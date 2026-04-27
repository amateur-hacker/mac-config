#!/bin/sh

EN=$(networksetup -listallhardwareports | awk '/Wi-Fi|AirPort/{getline; print $NF}')

if [ "$BUTTON" = "1" ]; then
  WIFI_STATUS=$(networksetup -getairportpower "$EN" | awk '{print $NF}')
  if [ "$WIFI_STATUS" = "On" ]; then
    networksetup -setairportpower "$EN" off
  else
    networksetup -setairportpower "$EN" on
  fi
  sketchybar --trigger wifi_change
fi

EN=$(networksetup -listallhardwareports | awk '/Wi-Fi|AirPort/{getline; print $NF}')
SSID=$(ipconfig getsummary "$EN" | grep -Fxq "  Active : FALSE" && echo "" || networksetup -listpreferredwirelessnetworks "$EN" | sed -n '2s/^\t//p')

if [ -z "$SSID" ]; then
  sketchybar --set "$NAME" icon="󰤭" label="" label.drawing=off icon.padding_left=0 icon.padding_right=0
else
  sketchybar --set "$NAME" icon="󰤨" label="$SSID" label.drawing=on icon.padding_left=4 icon.padding_right=4
fi
