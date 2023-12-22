# Prerequisites

- git
- zsh
	- [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
	- [powerlevel10k zsh theme](https://github.com/romkatv/powerlevel10k)
	- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
	- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

# Install
- `git clone https://github.com/APengue1/dotfiles.git ~/.dotfiles`
- `alias config='$(which git) --git-dir=$HOME/.dotfiles/.git/ --work-tree=$HOME'`
- `~/.dotfiles/install.sh`

# Usage

`config checkout`

# TODO

- Clone repos on install if not exists:
	- zsh themes
	- zsh plugins 

