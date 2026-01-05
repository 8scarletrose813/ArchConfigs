#!/bin/bash

BUSY=$(intel_gpu_top -J -s 500 2>/dev/null | \
awk '
  /"Render\/3D"/ { found=1 }
  found && /"busy"/ {
    gsub(/[^0-9.]/, "", $0)
    print $0
    exit
  }
')

[ -z "$BUSY" ] && BUSY=0

BUSY_INT=$(printf "%.0f" "$BUSY")

echo "${BUSY_INT}% "