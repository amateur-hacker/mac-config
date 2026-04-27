#!/usr/bin/env bash

STATE="/tmp/aerospace_last_ws"
TIMEFILE="/tmp/aerospace_last_time"

CURRENT="$AEROSPACE_FOCUSED_WORKSPACE"
NOW=$(date +%s%3N) # milliseconds

LAST_WS=$(cat "$STATE" 2>/dev/null)
LAST_TIME=$(cat "$TIMEFILE" 2>/dev/null)

# 🚫 Skip if same workspace
[ "$CURRENT" = "$LAST_WS" ] && exit 0

# 🚫 Skip if too soon (e.g. < 80ms)
if [ -n "$LAST_TIME" ] && [ $((NOW - LAST_TIME)) -lt 80 ]; then
  exit 0
fi

echo "$CURRENT" >"$STATE"
echo "$NOW" >"$TIMEFILE"

sketchybar --trigger aerospace_workspace_change \
  FOCUSED_WORKSPACE="$CURRENT"
borders active_color=0xffcdd6f4 inactive_color=0xff313244 width=5',
