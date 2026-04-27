#!/bin/sh

condition=$(curl -s "wttr.in?format=%C")
temp=$(curl -s "wttr.in?format=%t" | tr -d '+')

hour=$(date +%H)

is_invalid() {
  echo "$1" | grep -Eqi "unknown|error|not available"
}

if [ "$hour" -ge 6 ] && [ "$hour" -lt 18 ]; then
  is_day=1
else
  is_day=0
fi

case "$condition" in
*Sunny* | *Clear*)
  if [ "$is_day" -eq 1 ]; then
    icon="󰖙"
  else
    icon="󰖔"
  fi
  ;;

*Cloud*)
  if [ "$is_day" -eq 1 ]; then
    icon="󰖐"
  else
    icon="󰼱"
  fi
  ;;

*Rain*)
  icon="󰖗"
  ;;

*Thunder*)
  icon="󰖓"
  ;;

*Snow*)
  icon="󰖘"
  ;;

*)
  icon="󰖐"
  ;;
esac

if [ -z "$condition" ] || [ -z "$temp" ] || is_invalid "$condition" || is_invalid "$temp"; then
  sketchybar --set "$NAME" icon="󰖐" label="N/A"
  exit 0
fi

sketchybar --set "$NAME" icon="$icon" label="$temp"
