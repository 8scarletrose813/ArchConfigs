#!/usr/bin/env bash

IF="wlan0"
ESSID=$(iwgetid -r)
IP=$(ip -4 addr show $IF 2>/dev/null | grep inet | awk '{print $2}' | cut -d/ -f1)

if [ -z "$ESSID" ]; then
    echo "%{F#ff4000}󰤭 offline%{F-}"
    exit
fi

QUAL=$(grep $IF /proc/net/wireless | awk '{print int($3*100/70)}')

RX1=$(cat /sys/class/net/$IF/statistics/rx_bytes)
TX1=$(cat /sys/class/net/$IF/statistics/tx_bytes)
sleep 1
RX2=$(cat /sys/class/net/$IF/statistics/rx_bytes)
TX2=$(cat /sys/class/net/$IF/statistics/tx_bytes)
DOWN=$(( (RX2 - RX1) / 1024 ))
UP=$(( (TX2 - TX1) / 1024 ))

if ping -c1 -W1 1.1.1.1 &>/dev/null; then
    case $QUAL in 100|9*) ICON="󰤨" ;; 8*) ICON="󰤥" ;; 6*|7*) ICON="󰤢" ;; 4*|5*) ICON="󰤟" ;; *)  ICON="󰤯" ;; esac
    COLOR="#00ff00"
else
    ICON="󰤭"
    COLOR="#ff8800"
fi

SEC=$(date +%s)
if (( SEC % 8 < 4 )); then
    TEXT="$ESSID ${DOWN}/${UP} KiB"
else
    TEXT="$IP ${DOWN}/${UP} KiB"
fi

echo "%{F$COLOR}$ICON $TEXT%{F-}"