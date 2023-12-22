#!/bin/sh

# There could be weird behaviour if .cfg tries to track itself.
# Avoid recursive issues by adding .cfg to your global Git ignore.
echo "$HOME/.dotfiles" >> $HOME/.gitignore

# Add config alias for this script.
# Sets the git working tree to $HOME
alias config='$(which git) --git-dir=$HOME/.dotfiles/.git/ --work-tree=$HOME'

# Do not show untracked files in $HOME directory.
config config --local status.showUntrackedFiles no

# Checkout (copy) the contents of this repository into your $HOME directory.
# config checkout TODO: Why does this not work?

cd
config checkout
config restore *

