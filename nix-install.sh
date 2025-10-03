#!/bin/sh

channel="nixpkgs"

# Remove default channel (usually unstable) and replace it with our stable version.
nix-channel --remove $channel
nix-channel --add https://nixos.org/channels/nixos-24.11 $channel
nix-channel --update

# Install our desired packages.
packages=(
        nix
        entr
        ripgrep
        fzf
        tmux
        git
        gitmux
        neovim
)

for package in ${packages[@]}
do
    nix-env -iA "$channel.$package"
done
