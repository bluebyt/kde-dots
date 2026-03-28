#!/bin/bash
qdbus org.kde.kglobalaccel /component/kwin invokeShortcut "Switch to Desktop 8"

makoctl invoke -n "$1"

# 3. Finally, dismiss it
makoctl dismiss -n "$1"
