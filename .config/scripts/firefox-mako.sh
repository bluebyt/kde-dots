#!/bin/bash

# 1. Switch to Desktop 2
qdbus org.kde.kglobalaccel /component/kwin invokeShortcut "Switch to Desktop 2"

# 2. Invoke the default action (opens the Firefox link)
# We use -n $1 to target the specific notification you clicked
makoctl invoke -n "$1"

# 3. Finally, dismiss it
makoctl dismiss -n "$1"
