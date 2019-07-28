#!/bin/bash

function join() {
        local IFS="$1"
        shift
        echo "$*"
}

number_of_sticky_windows=$(
        yabai -m query --windows |
                jq -r ".[] | select(.sticky == 1) | .id" |
                sort -n |
                uniq |
                wc -l |
                awk '{print $1}'
)

active_space=$(
        yabai -m query --spaces --space |
                jq -r ".index"
)

all_spaces=$(
        yabai -m query --spaces |
                jq -r ".[]
                        | select(.windows | length > ${number_of_sticky_windows})
                        | select(.\"native-fullscreen\" != 1)
                        | .index" |
                xargs echo "$active_space" |
                xargs -n1 |
                sort -n -u |
                xargs |
                tr " " ","
)

hs -c "spaces.update({$all_spaces}, $active_space)"
