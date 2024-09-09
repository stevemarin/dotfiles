sudo pacman -Sy stow cmake neovide lazygit luarocks difftastic fd just ripgrep \
                hurl bottom starship eza jql gnome-terminal pass gnupg

# install lazyvim
if [ ! -e ~/.config/nvim/lua/config/lazy.lua ]; then
  git clone https://github.com/LazyVim/starter ~/.config/nvim
fi

# install rust
if ! command -v cargo; then
  sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

# install bash-preexec for atuin
if [ ! -e ~/.bash-preexec.sh ]; then
  curl https://raw.githubusercontent.com/rcaloras/bash-preexec/master/bash-preexec.sh -o ~/.bash-preexec.sh
figit push --set-upstream origin main

# install atuin
if ! command atuin; then
  bash <(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)
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

# install nerd fonts
FONT_DIR="/usr/local/share/fonts"
sudo mkdir --parents ${FONT_DIR}
DIR="$(mktemp -d)"
pushd "${DIR}"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hack.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Inconsolata.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Ubuntu.zip
find . -name "*.zip" -exec unzip -n {} \;
find . -name "*.zip" -exec rm {} \;
sudo mv *.ttf ${FONT_DIR}
sudo fc-cache -fv
popd
