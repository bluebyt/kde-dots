#!/bin/bash
grep -oP '(?<="code": ")[^"]+' /tmp/layout.json
