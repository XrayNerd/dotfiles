#!/bin/sh
#
# ~/.xinitrc
xsetroot -name FabWM
xsetroot -cursor-name left_ptr
hsetroot -fill ~/.desktop.png
sxhkd -m 1 &
~/bin/beepop &
wew | yawee &
~/bin/timebar &
while :; do ~/bin/battery_check; sleep 120; done &
exec xwait

xset +fp /home/null/.fonts
xset fp rehash
