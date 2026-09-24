#!/usr/bin/env bash
set -e

if [ -f /etc/os-release ]; then
  . /etc/os-release
else
  echo "Error: /etc/os-release not found." >&2
  exit 1
fi

IS_CONTAINER=false
if [ -n "$CODESPACES" ] || [ -f /.dockerenv ] || [ -n "$REMOTE_CONTAINERS" ]; then
  IS_CONTAINER=true
fi

case "$ID" in
  fedora)
    sudo dnf update -y
    sudo dnf install -y curl unzip zsh fzf zoxide stow
    ;;
  ubuntu|debian)
    sudo apt update
    sudo apt install -y curl unzip zsh fzf zoxide stow
    ;;
  *)
    echo "Unsupported distribution: $ID" >&2
    exit 1
    ;;
esac

if ! command -v oh-my-posh &> /dev/null; then
  curl -s https://ohmyposh.dev/install.sh | bash -s
fi

[ -d "posh" ] && stow -t "$HOME" posh
[ -d "zsh" ] && stow -t "$HOME" zsh

if command -v zsh &> /dev/null && [ "$SHELL" != "$(which zsh)" ]; then
  sudo chsh -s "$(which zsh)" "$USER" || true
fi

if [ "$IS_CONTAINER" = false ] && [ "$ID" = "fedora" ]; then
  echo "Installing desktop GUI apps for Fedora..."
  sudo dnf copr enable -y scottames/ghostty

  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null

  sudo dnf install -y ghostty code syncthing
  flatpak install -y flathub md.obsidian.Obsidian

  [ -d "ghostty" ] && stow -t "$HOME" ghostty
  gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
fi
