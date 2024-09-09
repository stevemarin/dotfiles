#!/bin/bash

sudo pacman -Sy --needed stow cmake neovide lazygit luarocks difftastic fd just ripgrep \
  hurl bottom starship eza gnome-terminal pass gnupg shellcheck openvpn github-cli

# install lazyvim
if [ ! -e ~/.config/nvim/lua/config/lazy.lua ]; then
  git clone https://github.com/LazyVim/starter ~/.config/nvim
fi

# install rust and binstall
if ! command -v cargo; then
  sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  cargo install cargo-binstall
fi

# install bash-preexec for atuin
if [ ! -e ~/.bash-preexec.sh ]; then
  curl https://raw.githubusercontent.com/rcaloras/bash-preexec/master/bash-preexec.sh -o ~/.bash-preexec.sh
fi

# install atuin
if ! command -v atuin; then
  bash <(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)
fi

# isntall jql
if ! command -v jql; then
    cargo binstall jql
fi

# install vscodium-insiders
if ! command -v codium-insiders; then
  yay -S vscodium-insiders-bin
fi

# install pixi
if ! command -v pixi; then
  curl -fsSL https://pixi.sh/install.sh | bash
fi

# install docker-desktop
if ! command -v docker; then
  yay -S docker-desktop
fi

# install openvpn3
if ! command -v openvpn3; then
  yay -S openvpn3
fi

# install nerd fonts
FONT_DIR="/usr/local/share/fonts"
sudo mkdir --parents ${FONT_DIR}
DIR="$(mktemp -d)"
pushd "${DIR}" || exit 1

if ! compgen "FiraCodeNerdFont*.ttf" >/dev/null; then
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip
fi

if ! compgen "HackNerdFont*.tft" >/dev/null; then
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hack.zip
fi

if ! compgen "InconsolataNerdFont*.ttf" >/dev/null; then
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Inconsolata.zip
fi

if ! compgen "JetBrainsMonoNerdFont*.ttf" >/dev/null; then
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
fi

if ! compgen "UbuntuNerdFont*.ttf" >/dev/null; then
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Ubuntu.zip
fi

if ! compgen "*.zip" >/dev/null; then
  find . -name "*.zip" -exec unzip -n {} \;
  find . -name "*.zip" -exec rm {} \;
  sudo mv ./*.ttf* ${FONT_DIR}
  sudo fc-cache -fv
fi

popd || exit 1
