#!/bin/bash

# 1. Get the layout index using dbus-send (it's more stable than qdbus6)
# This pulls the number and strips everything but the digit
INDEX=$(dbus-send --print-reply --dest=org.kde.keyboard /Layouts org.kde.KeyboardLayouts.getLayout | grep "uint32" | awk '{print $2}')

# 2. Check the number and echo the layout
if [ "$INDEX" = "0" ]; then
    echo "us"
elif [ "$INDEX" = "1" ]; then
    echo "ca"
else
    # If the script runs but can't find the index, it will output this:
    echo "kb"
fi
