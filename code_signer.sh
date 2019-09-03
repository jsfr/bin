#!/usr/bin/env bash

# yabai
OLD_SUM=$(cat ~/.yabai_md5)
NEW_SUM=$(md5 -q /usr/local/bin/yabai)

echo "Checking whether yabai was updated"

if [ "$OLD_SUM" != "$NEW_SUM" ]; then
  echo "yabai was updated, code signing and restarting"
  codesign -fs "yabai-cert" /usr/local/opt/yabai/bin/yabai
  brew services restart yabai
  md5 -q /usr/local/bin/yabai > ~/.yabai_md5
fi

# skhd
OLD_SUM=$(cat ~/.skhd_md5)
NEW_SUM=$(md5 -q /usr/local/bin/skhd)

echo "Checking whether chunwkm was updated"

if [ "$OLD_SUM" != "$NEW_SUM" ]; then
  echo "skhd was updated, code signing and restarting"
  codesign -fs "skhd-cert" /usr/local/opt/skhd/bin/skhd
  brew services restart skhd
  md5 -q /usr/local/bin/skhd > ~/.skhd_md5
fi
