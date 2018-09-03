#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export TERMINAL="rxvt-unicode"
export BROWSER="firefox"

# Start graphical server if i3 not already running.
if [[ "$(tty)" = "/dev/tty1" ]]; then
  pgrep -x i3 || exec startx
fi
