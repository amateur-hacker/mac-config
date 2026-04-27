#!/usr/bin/env sh

WS="$1"
[ -z "$WS" ] && exit 1

aerospace move-node-to-workspace "$WS"
sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE="$WS"
