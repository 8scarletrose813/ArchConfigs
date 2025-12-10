#!/usr/bin/env bash
status=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

vol=$(echo "$status" | awk '{gsub(/[^0-9.]/,"",$2); printf "%.0f", $2*100}')
if echo "$status" | grep -q "MUTED"; then
	echo "%{F#ff4000}$vol% %{F-}" > ~/.config/polybar/scripts/vol-popup
else
    echo "%{F#adb5cf}$vol% %{F-}" > ~/.config/polybar/scripts/vol-popup
fi

sleep 5

echo "" > ~/.config/polybar/scripts/vol-popup