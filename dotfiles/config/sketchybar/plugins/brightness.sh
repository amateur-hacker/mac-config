#!/bin/sh

BRIGHTNESS=$(/usr/libexec/corebrightnessdiag status-info 2>/dev/null | grep 'DisplayServicesBrightness =' | head -1 | sed 's/.*DisplayServicesBrightness = //' | tr -d '";')

if [ -z "$BRIGHTNESS" ]; then
  BRIGHTNESS_INT=0
else
  BRIGHTNESS_INT=$(echo "$BRIGHTNESS" | awk '{printf "%.0f", $1 * 100}')
fi

BRIGHTNESS_IDX=$((BRIGHTNESS_INT / 11))
if [ "$BRIGHTNESS_IDX" -gt 8 ]; then
  BRIGHTNESS_IDX=8
fi

case "$BRIGHTNESS_IDX" in
0) ICON=""
  ;;
1) ICON=""
  ;;
2) ICON=""
  ;;
3) ICON=""
  ;;
4) ICON=""
  ;;
5) ICON=""
  ;;
6) ICON=""
  ;;
7) ICON=""
  ;;
8) ICON=""
  ;;
*) ICON="" ;;
esac

sketchybar --set "$NAME" icon="$ICON" label="${BRIGHTNESS_INT}%"
