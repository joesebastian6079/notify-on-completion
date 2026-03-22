#!/usr/bin/env osascript

on run argv
  set targetId to item 1 of argv
  tell application "iTerm2"
    activate
    repeat with w in windows
      repeat with t in tabs of w
        repeat with s in sessions of t
          if unique ID of s is targetId then
            tell w to select t
            return
          end if
        end repeat
      end repeat
    end repeat
  end tell
end run
