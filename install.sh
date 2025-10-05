#!/bin/bash
sudo dnf update
dnf copr enable scottames/ghostty
sudo dnf install -y curl zsh fzf zoxide ghostty
curl -s https://ohmyposh.dev/install.sh | bash -s
stow ghostty
stow posh
stow zsh
chsh -s /usr/bin/zsh
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
