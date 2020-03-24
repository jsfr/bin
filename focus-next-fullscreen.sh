#!/usr/bin/env sh

active_space=$(yabai -m query --spaces --space | jq -r '.index')
last_fullscreen_space=$(
  yabai -m query --spaces |
    jq -r '[.[] | select(."native-fullscreen" == 1)] | last | .index'
)

if [ "$active_space" -ge "$last_fullscreen_space" ]; then
  first_fullscreen_space=$(
    yabai -m query --spaces |
      jq -r '[.[] | select(."native-fullscreen" == 1)] | first | .index'
  )
  yabai -m space --focus "$first_fullscreen_space"
else
  next_fullscreen_space=$(
    yabai -m query --spaces |
      jq -r "[.[] | select(.\"native-fullscreen\" == 1 and .index > $active_space)] | first | .index"
  )
  yabai -m space --focus "$next_fullscreen_space"
fi
