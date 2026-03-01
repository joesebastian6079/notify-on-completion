#!/usr/bin/env osascript

on run argv
  tell application "System Events"
    set frontApp to name of first application process whose frontmost is true
    if frontApp is not "iTerm2" and frontApp is not "Terminal" then
      set cmdName to item 1 of argv
      set errorCode to item 2 of argv
      
      if errorCode is "0" then
        set notifTitle to "✅ Command Finished"
        set notifBody to cmdName
      else
        set notifTitle to "❌ Command Failed"
        set notifBody to cmdName & " (exit code " & errorCode & ")"
      end if
      
      do shell script "terminal-notifier -title '" & notifTitle & "' -message '" & notifBody & "' -sound Ping -activate com.googlecode.iterm2"
    end if
  end tell
end run
