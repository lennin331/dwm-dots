#!/usr/bin/env bash
WALLPAPER_DIR="$HOME/wallpaper"
SELECTED=$(ls "$WALLPAPER_DIR" | dmenu -l 15 -p "Select wallpaper: ")
[ -z "$SELECTED" ] && exit 0
IMAGE_PATH="$WALLPAPER_DIR/$SELECTED"
xwallpaper --stretch "$IMAGE_PATH"
echo "$IMAGE_PATH" > ~/wallpaper/.wallpaper

#the wallpapers must be inside the "wallpaper" dir in Home
#touch .wallpaper - stores the recent used wallpaper that called @ .xinitrc
#[ -f ~/wallpaper/.wallpaper ] && xwallpaper --zoom "$(cat ~/wallpaper/.wallpaper)" &

#Github: lennin331
