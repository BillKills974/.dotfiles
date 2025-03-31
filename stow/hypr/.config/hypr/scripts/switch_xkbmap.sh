#!/bin/bash
CURRENT_MAP=$(hyprctl devices | grep -B 5 "main: yes$" | grep "active keymap" | tail -n1 | cut -d " " -f 3)
if [ $CURRENT_MAP = "French"  ]; then
	setxkbmap fr
else
	setxkbmap us
fi



