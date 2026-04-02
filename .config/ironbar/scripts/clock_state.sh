#!/bin/sh
# store the state in /tmp/ironbar_clock_state
state_file="/tmp/ironbar_clock_state"

# initialize if missing
if [ ! -f "$state_file" ]; then
  echo "full" > "$state_file"
fi

# if first arg is "toggle", switch
if [ "$1" = "toggle" ]; then
  current=$(cat "$state_file")
  if [ "$current" = "full" ]; then
    echo "short" > "$state_file"
  else
    echo "full" > "$state_file"
  fi
  exit 0
fi

# print the state so config can use it
cat "$state_file"

