#!/usr/bin/env bash
UTIL=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
TEMP=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)
echo "${UTIL}% ${TEMP}°C "