#!/bin/sh
BAT_PATH="/sys/class/power_supply/BAT0"

LOCK_LOW="/tmp/dwm_bat_low"
LOCK_CRIT="/tmp/dwm_bat_crit"
LOCK_CHR="/tmp/dwm_bat_chr"
LOCK_FULL="/tmp/dwm_bat_full"

if [ ! -d "$BAT_PATH" ]; then
    exit 0
fi

while true; do
    CAPACITY=$(cat "$BAT_PATH/capacity")
    STATUS=$(cat "$BAT_PATH/status")

    if [ "$STATUS" = "Discharging" ]; then
        rm -f "$LOCK_CHR" "$LOCK_FULL"

        # warning under 10%
        if [ "$CAPACITY" -le 10 ]; then
            if [ ! -f "$LOCK_CRIT" ]; then
                notify-send -u critical -i battery-caution "CRITICAL BATTERY" "Battery level is low <b>${CAPACITY}%</b>!"
                touch "$LOCK_CRIT"
            fi
        #warning under 20%
        elif [ "$CAPACITY" -le 20 ]; then
            if [ ! -f "$LOCK_LOW" ]; then
                notify-send -u normal -i battery-low "Low Battery" "Battery level is <b>${CAPACITY}%</b>!"
                touch "$LOCK_LOW"
            fi
        fi

    elif [ "$STATUS" = "Charging" ]; then

        rm -f "$LOCK_LOW" "$LOCK_CRIT" "$LOCK_FULL"

        if [ ! -f "$LOCK_CHR" ]; then
            notify-send -t 1500 -u low -i battery-charging "Charging" "Battery is charging <b>${CAPACITY}%</b>."
            touch "$LOCK_CHR"
        fi

    elif [ "$STATUS" = "Full" ] || [ "$CAPACITY" -ge 100 ]; then
        rm -f "$LOCK_LOW" "$LOCK_CRIT" "$LOCK_CHR"

        if [ ! -f "$LOCK_FULL" ]; then
            notify-send -t 1500 -u low -i battery-charging "Charging Completed" "Battery is fully charged <b>100%</b>."
            touch "$LOCK_FULL"
        fi
    fi

    sleep 5
done
