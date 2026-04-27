#!/bin/sh

MODE_FILE="/tmp/aerospace_mode"

get_mode() {
  if [ -f "$MODE_FILE" ]; then
    cat "$MODE_FILE"
  else
    echo ""
  fi
}

case "$(get_mode)" in
apps)
  sketchybar --set "aerospace_mode_separator" icon.drawing=on
  sketchybar --set "$NAME" icon="A" label="apps" label.drawing=on
  ;;
screenshot)
  sketchybar --set "aerospace_mode_separator" icon.drawing=on
  sketchybar --set "$NAME" icon="S" label="screenshot" label.drawing=on
  ;;
session)
  sketchybar --set "aerospace_mode_separator" icon.drawing=on
  sketchybar --set "$NAME" icon="Q" label="session" label.drawing=on
  ;;
media)
  sketchybar --set "aerospace_mode_separator" icon.drawing=on
  sketchybar --set "$NAME" icon="M" label="media" label.drawing=on
  ;;
*)
  sketchybar --set "$NAME" icon="" label="" label.drawing=off
  sketchybar --set "aerospace_mode_separator" icon.drawing=off
  ;;
esac
