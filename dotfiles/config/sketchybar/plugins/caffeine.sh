#!/bin/sh

STATE_FILE="/tmp/caffeine_state"

if [ "$BUTTON" = "1" ]; then
  if pgrep -x caffeinate >/dev/null; then
    pkill -x caffeinate
    echo "off" >"$STATE_FILE"
  else
    caffeinate -dimsu &
    echo "on" >"$STATE_FILE"
  fi
fi

if [ -f "$STATE_FILE" ] && [ "$(cat "$STATE_FILE")" = "on" ]; then
  sketchybar --set "$NAME" icon="󰅶"
else
  sketchybar --set "$NAME" icon="󰛊"
fi
