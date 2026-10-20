# Word-at-a-time movement.
#
# iTerm2's "Option Key Sends" is set to Normal (0), so Option+Left/Right arrive
# as CSI 1;3D / 1;3C rather than as ESC b / ESC f. zsh has no default binding
# for those, and an unbound sequence gets its tail inserted literally — which is
# why Option+Left printed a stray "D". Binding them here rather than changing
# the iTerm profile keeps it working in any terminal.
#
# Sourced last, after oh-my-zsh, so these win over anything it sets up.

bindkey '^[[1;3D' backward-word      # Option+Left  (iTerm, Option=Normal)
bindkey '^[[1;3C' forward-word       # Option+Right
bindkey '^[[1;5D' backward-word      # Ctrl+Left, and Option=Normal in some terminals
bindkey '^[[1;5C' forward-word       # Ctrl+Right
bindkey '^[b'     backward-word      # ESC b — what Option=Esc+ sends
bindkey '^[f'     forward-word       # ESC f
bindkey '^[^?'    backward-kill-word # Option+Backspace, same family
