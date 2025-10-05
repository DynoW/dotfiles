#!/bin/bash
sudo dnf update

sudo dnf copr enable scottames/ghostty

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null

sudo dnf install -y curl zsh fzf zoxide ghostty code syncthing
flatpak install -y flathub md.obsidian.Obsidian
curl -s https://ohmyposh.dev/install.sh | bash -s

stow ghostty
stow posh
stow zsh

chsh -s /usr/bin/zsh
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'

#/home/dyno/.local/state/syncthing

#systemctl --user enable syncthing
#systemctl --user start syncthing
