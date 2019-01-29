#!/usr/bin/env bash

fswatch -0 ~/.tmux-session | while read -r -d "" path; do
    tmux -S "$path" has-session || tmux -S "$path" new-session -s alacritty -d
done
