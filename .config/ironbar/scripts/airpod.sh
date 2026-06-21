#!/bin/bash

device_address="60:93:16:0D:F9:59"

# Fast check: parser reads only the local controller state without polling the device
is_connected() {
    bluetoothctl info "$device_address" | grep -q "Connected: yes"
}

toggle_state () {
    if is_connected; then
        echo "Disconnecting..."
        bluetoothctl disconnect "$device_address"
    else
        echo "Connecting..."
        # Force an immediate connection profile punch-through
        bluetoothctl connect "$device_address"
    fi
}

status_str () {
    if is_connected; then
        echo " Pod"
    else
        echo " Pod"
    fi
}

case "$1" in
    --toggle)
        toggle_state
        ;;
    --status)
        status_str
        ;;
esac
