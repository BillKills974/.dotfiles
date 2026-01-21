#!/bin/sh
if [ -d sysconf/i3 ]; then
    cd sysconf/i3 && cp -rvf ./* /
    cd -
fi
