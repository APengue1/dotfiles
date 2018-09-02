#
# ~/.bashrc
#
# If not running interactively, don't do anything

[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases
[[ -f ~/.bash_exports ]] && . ~/.bash_exports
[[ -d ~/bin ]] && export PATH="${HOME}/bin:${PATH}"

