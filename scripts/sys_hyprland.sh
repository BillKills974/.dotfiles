#!/bin/sh
if [ -d sysconf/hyprland ]; then
    cd sysconf/hyprland && cp -rvf ./* /
    cd -
fi
systemctl --user -M $SUDO_USER@ enable hyprpaper.service hypridle.service hyprpolkitagent.service waybar.service
