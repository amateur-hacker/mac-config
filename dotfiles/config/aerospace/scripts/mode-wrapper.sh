#!/usr/bin/env bash

MODE="$1"
shift
COMMAND="$@"

echo "$MODE" > /tmp/aerospace_mode
sketchybar --trigger aerospace_mode_change

eval "$COMMAND"
