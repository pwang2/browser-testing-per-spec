#!/bin/bash
/etc/init.d/dbus start > /dev/null 2>&1
/etc/init.d/xvfb start > /dev/null 2>&1

export DISPLAY=:1

sleep 1s

su chromeuser -c "tape-run -b chrome -"
