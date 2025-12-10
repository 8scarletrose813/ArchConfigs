#!/usr/bin/env bash
BAT="BAT0"

state=$(cat /sys/class/power_supply/$BAT/status)
capacity=$(cat /sys/class/power_supply/$BAT/capacity)

icon_discharging() {
    case $capacity in
        0|1|2|3|4|5|6|7|8|9) echo "󰂃" ;;
        1[0-9]) echo "󰁺" ;;
        2[0-9]) echo "󰁻" ;;
        3[0-9]) echo "󰁼" ;;
        4[0-9]) echo "󰁽" ;;
        5[0-9]) echo "󰁾" ;;
        6[0-9]) echo "󰁿" ;;
        7[0-9]) echo "󰂀" ;;
        8[0-9]) echo "󰂁" ;;
        9[0-9]) echo "󰂂" ;;
        *) echo "󰂂" ;;
    esac
}

icon_charging() {
    case $capacity in
        0|1|2|3|4|5|6|7|8|9) echo "󰢟" ;;
        1[0-9]) echo "󰢜" ;;
        2[0-9]) echo "󰂆" ;;
        3[0-9]) echo "󰂇" ;;
        4[0-9]) echo "󰂈" ;;
        5[0-9]) echo "󰢝" ;;
        6[0-9]) echo "󰂉" ;;
        7[0-9]) echo "󰢞" ;;
        8[0-9]) echo "󰂊" ;;
        9[0-9]) echo "󰂋" ;;
        *) echo "󰂅" ;;
    esac
}

if [ "$state" = "Charging" ]; then
    icon=$(icon_charging)
elif [ "$state" = "Full" ]; then
    icon="󰁹"
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