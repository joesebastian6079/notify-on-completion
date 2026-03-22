#!/bin/bash
/opt/homebrew/bin/terminal-notifier -title "Claude Code 🔔" -message "Waiting for your input" -activate com.googlecode.iterm2
afplay /System/Library/Sounds/Funk.aiff

if [[ -n "$NTFY_TOPIC" ]]; then
  curl -s -d "Claude Code: Waiting for your input" "ntfy.sh/$NTFY_TOPIC" > /dev/null
fi
