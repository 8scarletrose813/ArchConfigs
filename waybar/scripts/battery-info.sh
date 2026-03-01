#!/usr/bin/env bash

BAT="BAT1"
POP=~/.config/waybar/scripts/battery-popup

capacity=$(cat /sys/class/power_supply/$BAT/capacity)

energy_now=$(cat /sys/class/power_supply/$BAT/energy_now 2>/dev/null)
energy_full=$(cat /sys/class/power_supply/$BAT/energy_full 2>/dev/null)
design_full=$(cat /sys/class/power_supply/$BAT/energy_full_design 2>/dev/null)

if [ -z "$energy_now" ]; then
    energy_now=$(cat /sys/class/power_supply/$BAT/charge_now)
    energy_full=$(cat /sys/class/power_supply/$BAT/charge_full)
    design_full=$(cat /sys/class/power_supply/$BAT/charge_full_design)
fi

health=$(awk "BEGIN { printf \"%.1f\", ($energy_now / $design_full) * 100 }")

percent_now=$(awk "BEGIN { printf \"%.1f\", ($energy_now / $energy_full) * 100 }")

echo "%{F#ebedf3}${percent_now}% ~${health}%%{F-}" > "$POP"
sleep 5
echo "" > "$POP"
