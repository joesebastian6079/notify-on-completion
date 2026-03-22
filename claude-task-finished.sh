#!/bin/bash
/opt/homebrew/bin/terminal-notifier -title "Claude Code ✅" -message "Task completed" -activate com.googlecode.iterm2
afplay /System/Library/Sounds/Ping.aiff

if [[ -n "$NTFY_TOPIC" ]]; then
  curl -s -d "Claude Code: Task completed" "ntfy.sh/$NTFY_TOPIC" > /dev/null
fi
