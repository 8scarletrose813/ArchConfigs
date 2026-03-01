#!/usr/bin/env bash
BAT="BAT1"

state=$(cat /sys/class/power_supply/$BAT/status)
capacity=$(cat /sys/class/power_supply/$BAT/capacity)

icon_discharging() {
    if [[ $capacity -ge 90 ]]; then
        echo "🌕"
    elif [[ $capacity -ge 75 ]]; then
        echo "🌖"
    elif [[ $capacity -ge 50 ]]; then
        echo "🌗"
    elif [[ $capacity -ge 25 ]]; then
        echo "🌘"
    else
        echo "🌑"
    fi
}

icon_charging() {
    echo "🔮" 
}

if [ "$state" = "Charging" ]; then
    icon=$(icon_charging)
elif [ "$state" = "Full" ]; then
    icon="🔮"
else
    icon=$(icon_discharging)
fi

if [ "$capacity" -le 20 ]; then
    if [ "$state" = "Discharging" ]; then
        echo "%{F#ff4000}${icon} $capacity%%{F-}"
    else
        echo "%{F#cccc00}${icon} $capacity%%{F-}"
    fi
else
    echo "%{F#ebedf3}${icon} %{F-}"
fi