#!/usr/bin/env bash
if command -v intel_gpu_top >/dev/null 2>&1; then
    UTIL=$(intel_gpu_top -L -s 200 2>/dev/null | grep -m1 "Render/3D" | awk '{print $2}' | tr -d '%' | cut -d. -f1)
    [ -z "$UTIL" ] || [ "$UTIL" = "-" ] && UTIL="0"
else
    CUR=$(cat /sys/class/drm/card0/gt_act_freq_mhz 2>/dev/null || echo 0)
    MIN=$(cat /sys/class/drm/card0/gt_min_freq_mhz 2>/dev/null || echo 300)
    MAX=$(cat /sys/class/drm/card0/gt_max_freq_mhz 2>/dev/null || echo 1300)
    if (( CUR > MIN )); then
        UTIL=$(( (CUR - MIN) * 100 / (MAX - MIN) ))
    else
        UTIL=0
    fi
fi
echo "${UTIL}% "