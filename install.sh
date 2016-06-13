#!/usr/bin/env bash
# based on https://github.com/webpro/dotfiles/blob/master/install.sh

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -siv "$DOTFILES_DIR/runcom/.bashrc" ~
ln -siv "$DOTFILES_DIR/runcom/.bash_profile" ~
ln -siv "$DOTFILES_DIR/runcom/.inputrc" ~
ln -siv "$DOTFILES_DIR/runcom/.profile" ~
ln -siv "$DOTFILES_DIR/runcom/.vimrc" ~
