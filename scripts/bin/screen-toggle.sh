#!/bin/bash

if xrandr | grep -P 'HDMI1\s.+x\s\d+mm'; then
  xrandr --output HDMI1 --off
else
  xrandr --output HDMI1 --auto --right-of eDP1 --set "Broadcast RGB" "Full"
fi
