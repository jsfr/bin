#!/usr/bin/env sh

active_space=$(yabai -m query --spaces --space | jq -r '.index')
next_space=$(yabai -m query --spaces | jq -r 'limit(1;.[] | select(."native-fullscreen" == 1)) | .index')

yabai -m space --focus "$next_space"
