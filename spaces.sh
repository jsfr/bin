#!/bin/bash

function join() {
        local IFS="$1"
        shift
        echo "$*"
}

space_list=$(yabai -m query --spaces | jq -r "map(select(.windows > 0)) | .[].index")
active_space=$(yabai -m query --spaces --space | jq -r ".index")

all_spaces=$(echo "$space_list $active_space" | tr " " "\n" | sort -n | uniq)
all_spaces=$(join , ${all_spaces[@]})

hs -c "spaces.update({$all_spaces}, $active_space)"
