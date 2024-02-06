#!/bin/sh


mkdir -p build && cd build || exit 1
git clone https://aur.archlinux.org/yay.git && cd yay || exit 1
makepkg -si || exit 1
cd ../.. || exit 1
rm -Rf build && exit 0

