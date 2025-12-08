#!/usr/bin/env bash
layouts=("us" "gr" "ru" "ua")
current=$(xkb-switch -p 2>/dev/null || setxkbmap -query | awk '/layout/{print $2}')
for i in "${!layouts[@]}"; do
    if [[ "${layouts[i]}" == "${current%%,*}" ]]; then
        next=$(( (i + 1) % ${#layouts[@]} ))
        setxkbmap -layout "${layouts[next]}"
        xkb-switch -s "${layouts[next]}" 2>/dev/null || true
        break
    fi
done