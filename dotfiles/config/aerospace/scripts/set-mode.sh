#!/usr/bin/env bash

MODE="$1"

echo "$MODE" >/tmp/aerospace_mode
sketchybar --trigger aerospace_mode_change

aerospace mode "$MODE"
