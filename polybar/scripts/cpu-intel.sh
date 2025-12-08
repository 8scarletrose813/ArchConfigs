#!/usr/bin/env bash
usage=$(top -bn1 | grep '%Cpu(s):' | awk '{printf "%d", 100 - $8}')
temp=$(sensors coretemp-isa-0000 | grep "Package id 0" | awk '{print $4}' | tr -d '+°C' | cut -d. -f1)
echo "${usage}% ${temp}°C "