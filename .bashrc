#
# ~/.bashrc
#
# If not running interactively, don't do anything

[[ $- != *i* ]] && return

[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases
[[ -d ~/bin ]] && export PATH="${HOME}/bin:${PATH}"

PS1='[\u@\h \W]\$ '

[[ -f ~/.bash_exports ]] && . ~/.bash_exports

