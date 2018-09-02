#
# ~/.bashrc
#
# If not running interactively, don't do anything

[[ $- != *i* ]] && return

[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases
[[ -d ~/bin ]] && export PATH="${HOME}/bin:${PATH}"

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export TERMINAL="rxvt-unicode"

[[ -f ~/.bash_exports ]] && . ~/.bash_exports

