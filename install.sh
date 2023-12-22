#!/bin/sh

# There could be weird behaviour if .cfg tries to track itself.
# Avoid recursive issues by adding .cfg to your global Git ignore.
echo "$HOME/.dotfiles" >> $HOME/.gitignore

# Clone the dotfiles to $HOME/.dotfiles.
git clone https://github.com/APengue1/dotfiles.git  $HOME/.dotfiles

# Set alias 'config'.
# Set the working tree to $HOME.
alias config='$(which git) --git-dir=$HOME/.dotfiles/.git/ --work-tree=$HOME'

# Do not show untracked files in $HOME directory.
config config --local status.showUntrackedFiles no

# Checkout (copy) the contents of this repository into your $HOME directory.
config checkout

