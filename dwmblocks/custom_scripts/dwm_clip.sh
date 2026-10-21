#!/usr/bin/env bash

HISTFILE="$HOME/.dwm_clip"

current=$(xclip -out -selection clipboard 2>/dev/null) #get the current selection

if [ -n "$current" ]; then

    grep -Fvx "$current" "$HISTFILE" > "$HISTFILE.tmp" 2>/dev/null
    echo "$current" | cat - "$HISTFILE.tmp" > "$HISTFILE"
    rm -f "$HISTFILE.tmp"
fi

# Limit history to 50 lines
head -n 50 "$HISTFILE" > "$HISTFILE.tmp" && mv "$HISTFILE.tmp" "$HISTFILE"

# Interactive selection using fzf inside a square terminal layout
selected=$(cat "$HISTFILE" | fzf --prompt="clip > " \
                                --height=100% \
                                --layout=reverse \
                                --border=rounded)

# If an item was selected, copy it back to clipboard and primary selections
if [ -n "$selected" ]; then
    echo -n "$selected" | xclip -selection clipboard
    echo -n "$selected" | xclip -selection primary
fi
