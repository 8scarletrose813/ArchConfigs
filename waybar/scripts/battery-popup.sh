#!/usr/bin/env bash
BAT="BAT1"
POP=~/.config/waybar/scripts/battery-popup

state=$(cat /sys/class/power_supply/$BAT/status)
capacity=$(cat /sys/class/power_supply/$BAT/capacity)

if [ "$capacity" -gt 20 ]; then
	echo "%{F#ebedf3}$capacity% %{F-}" > "$POP"
	sleep 5
	echo "" > "$POP"
	exit 0
fi