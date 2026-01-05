#!/usr/bin/env bash

USED=$(df -BM / | awk 'NR==2 {gsub("M","",$3); print $3}')
TOTAL=$(df -BM / | awk 'NR==2 {gsub("M","",$2); print $2}')

TEMP_FILE=$(find /sys/devices -path "*/nvme/nvme0/hwmon*" -name "temp1_input" 2>/dev/null | head -1)
if [ -n "$TEMP_FILE" ] && [ -r "$TEMP_FILE" ]; then
    TEMP=$(cat "$TEMP_FILE")
    TEMP=$((TEMP / 1000))
else
    TEMP="?"
fi

PCT=$(( 100 * USED / TOTAL ))

if (( PCT < 5 )); then
    BAR="%{F#cc3300}${PCT}%░░░░░░░░░░░░░░░░░░░░%{F-}"
else
    filled=$(( (PCT) / 5 ))
    BAR="%{F#ff6600}${PCT}%$(printf "█%.0s" $(seq 1 $filled))%{F#cc3300}$(printf "░%.0s" $(seq 1 $((20-filled))))%{F-}"
fi

echo "%{F#ff6600}${USED}/${TOTAL} MiB %{F-}$BAR %{F#ff6600}${TEMP}°C%{F-}  "