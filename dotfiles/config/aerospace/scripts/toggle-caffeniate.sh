#!/usr/bin/env bash

STATE_FILE="/tmp/caffeine_state"

if pgrep -x caffeinate >/dev/null; then
  pkill -x caffeinate
  echo "off" >"$STATE_FILE"
else
  caffeinate -dimsu &
  echo "on" >"$STATE_FILE"
fi

sketchybar --trigger caffeine_update
