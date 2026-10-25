# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
. "$HOME/.cargo/env"

# Inside Emacs term, keep things simple
if [[ -n "$INSIDE_EMACS" ]]; then
    unset PROMPT_COMMAND
    PS1='\u@\h:\w\$ '
    export TERM=eterm-color
else
    export TERM=xterm-256color
fi

# Inside Emacs term, disable systemd OSC 3008
if [[ -n "$INSIDE_EMACS" ]]; then
    __systemd_osc_context_precmdline() { :; }
    __systemd_osc_context_common() { :; }
    __systemd_osc_context_escape() { :; }
    PS0=""
fi
