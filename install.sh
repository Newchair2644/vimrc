#!/bin/bash

# Very simple way to install all vim plugins
# generate all helptags in vim with `:helptags ALL`

if [[ $1 == vim ]]; then
	INSTALL_DIR=~/.vim/
elif [[ $1 == nvim ]]; then
	INSTALL_DIR=~/.config/nvim/
else
	echo "Specify either vim or nvim"
	exit
fi

mkdir -p $INSTALL_DIR/pack/bundle/opt/
echo "Created dir pack/bundle/opt/ in $INSTALL_DIR"

mkdir -p $INSTALL_DIR/pack/bundle/start/
echo "Created dir pack/bundle/start/ in $INSTALL_DIR"

# Plugins installed to pack/*/start
startup_plugins=(
	SirVer/ultisnips
	honza/vim-snippets
	Raimondi/delimitMate
	dense-analysis/ale
	itchyny/lightline.vim
	maximbaz/lightline-ale
)

# Plugins installed to pack/*/opt
opt_plugins=(
	arcticicestudio/nord-vim
	folke/which-key.nvim
)

cd $INSTALL_DIR/pack/bundle/start
for repo in "${startup_plugins[@]}"; do
	git clone https://github.com/$repo
done

cd $INSTALL_DIR/pack/bundle/opt
for repo in "${opt_plugins[@]}"; do
	git clone https://github.com/$repo
done

