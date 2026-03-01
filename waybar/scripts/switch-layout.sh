#!/usr/bin/env bash
KB=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main==true) | .name')

hyprctl switchxkblayout "$KB" next