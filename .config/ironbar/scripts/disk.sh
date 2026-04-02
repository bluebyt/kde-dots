#!/bin/bash
# Extracts available space on / and removes the 'G' suffix
space=$(df -BG / | awk 'NR==2 {print $4}' | sed 's/G//')

echo "${space}GB"
