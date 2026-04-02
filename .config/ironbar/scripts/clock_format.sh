#!/bin/bash

state="/tmp/ironbar_clock_state"

[ ! -f "$state" ] && echo full > "$state"

if [ "$1" = "--toggle" ]; then
  [ "$(cat "$state")" = "full" ] && echo short > "$state" || echo full > "$state"
fi

if [ "$(cat "$state")" = "full" ]; then
  date +" %B %d  %H:%M:%S"
else
  date +" %H:%M:%S"
fi

