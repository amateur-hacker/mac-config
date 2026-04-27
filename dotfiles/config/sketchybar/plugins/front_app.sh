#!/bin/sh

if [ "$SENDER" = "front_app_switched" ]; then
  FOCUSED=$(aerospace list-workspaces --focused)
  
  if aerospace list-windows --workspace "$FOCUSED" 2>/dev/null | grep -q .; then
    sketchybar --set "$NAME" label="$INFO"
  else
    sketchybar --set "$NAME" label="No Windows"
  fi
elif [ "$SENDER" = "aerospace_workspace_change" ]; then
  FOCUSED=$(aerospace list-workspaces --focused)
  
  if aerospace list-windows --workspace "$FOCUSED" 2>/dev/null | grep -q .; then
    FRONT_APP=$(aerospace list-windows --workspace "$FOCUSED" --json 2>/dev/null | grep app-name | head -1 | sed 's/.*"app-name" *: *"\(.*\)".*/\1/')
    if [ -z "$FRONT_APP" ]; then
      FRONT_APP="Unknown"
    fi
    sketchybar --set "$NAME" label="$FRONT_APP"
  else
    sketchybar --set "$NAME" label="No Windows"
  fi
fi
