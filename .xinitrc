export _JAVA_AWT_WM_NONREPARENTING=1

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

setxkbmap -layout us,gr,ru,ua -option grp:alt_shift_toggle &

copyq --start-server &
blueman-applet &
flameshot &

exec bspwm