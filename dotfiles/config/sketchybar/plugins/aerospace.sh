#!/usr/bin/env bash
FOCUSED=$(aerospace list-workspaces --focused)
for sid in $(aerospace list-workspaces --all); do
  if [ "$sid" = "$FOCUSED" ]; then
    sketchybar --set "space.$sid" \
      background.color=0xff89b4fa \
      label.color=0xff1e1e2e \
      icon.drawing=on \
      label.drawing=on \
      background.drawing=on \
      padding_left=2.5 \
      padding_right=2.5
  elif aerospace list-windows --workspace "$sid" 2>/dev/null | grep -q .; then
    sketchybar --set "space.$sid" \
      label.color=0xffcdd6f4 \
      icon.drawing=on \
      label.drawing=on \
      background.drawing=off \
      padding_left=2.5 \
      padding_right=2.5
  else
    sketchybar --set "space.$sid" \
      label.color=0xffcdd6f4 \
      icon.drawing=off \
      label.drawing=off \
      background.drawing=off \
      padding_left=0 \
      padding_right=0
  fi
done
