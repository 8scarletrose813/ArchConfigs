#!/usr/bin/env bash

ram_total=$(free -m | awk '/Mem:/ {print $2}')
ram_used=$(free -m | awk '/Mem:/ {print $3}')
ram_pct=$(( 100 * ram_used / ram_total ))

if (( ram_pct < 10 )); then
    ram_bar="%{F#b38300}${ram_pct}%░░░░░░░░░░%{F-}"
else
    filled=$(( ram_pct / 10 ))
    ram_bar="%{F#ffbb00}${ram_pct}%$(printf "█%.0s" $(seq 1 $filled))%{F#b38300}$(printf "░%.0s" $(seq 1 $((4 - filled))))%{F-}"
fi

swap_total=$(free -m | awk '/Swap:/ {print $2}')
if (( swap_total == 0 )); then
    swap_pct=0
    swap_bar="%{F#00aa00}░░░░░░░░░░0%%{F-}"
else
    swap_used=$(free -m | awk '/Swap:/ {print $3}')
    swap_pct=$(( 100 * swap_used / swap_total ))
    if (( swap_pct < 10 )); then
        swap_bar="%{F#00aa00}░░░░░░░░░░${swap_pct}%%{F-}"
    else
        filled=$(( swap_pct / 10 ))
        swap_bar="%{F#00ff00}$(printf "█%.0s" $(seq 1 $filled))%{F#00aa00}$(printf "░%.0s" $(seq 1 $((10 - filled))))${swap_pct}%%{F-}"
    fi
fi
printf "%s" "${ram_bar}${swap_bar} "