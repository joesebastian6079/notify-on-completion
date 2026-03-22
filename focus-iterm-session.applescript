#!/usr/bin/env osascript
-- Focuses the iTerm2 tab/session that ran the completed command.
-- Requires alerter (brew install alerter) instead of terminal-notifier,
-- since terminal-notifier's -execute flag is broken on macOS 12+.
--
-- Usage: osascript focus-iterm-session.applescript <session-uuid>

on run argv
  set targetId to item 1 of argv
  tell application "iTerm2"
    set windowList to every window
    repeat with w in windowList
      set tabList to every tab of w
      repeat with t in tabList
        set sessionList to every session of t
        repeat with s in sessionList
          if unique ID of s is targetId then
            select w
            select t
            activate
            return
          end if
        end repeat
      end repeat
    end repeat
    activate
  end tell
end run
