#!/bin/sh
if [ -d sysconf/common ]; then
    cd sysconf/common && cp -rvf ./* /
    cd -
fi
