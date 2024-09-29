Manages dotfiles with git by setting the worktree to $HOME.

Inspiration taken from:

- https://www.ackama.com/what-we-think/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained/
- https://www.atlassian.com/git/tutorials/dotfiles

# Prerequisites

- git
- zsh

The following are automatically installed
- [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
- [powerlevel10k zsh theme](https://github.com/romkatv/powerlevel10k)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

# Install
- `git clone git@github.com:APengue1/dotfiles.git ~/.dotfiles`
- `cd && .dotfiles/install.sh`

# Usage

`config` is now an alias referencing your $HOME directory as the git working tree. 

You can:
- `config add`
- `config commit`
- `config push`

To update your $HOME directory with updated dotfiles upstream, run the install script again:
- `config pull`
- `cd && .dotfiles/install.sh`

