#!/usr/bin/env osascript

on run argv
  tell application "System Events"
    set frontApp to name of first application process whose frontmost is true
    if frontApp is not "iTerm2" and frontApp is not "Terminal" then
      set cmdName to item 1 of argv
      set errorCode to item 2 of argv
      set elapsedSecs to (item 3 of argv) as integer
      set sessionId to ""
      set focusScript to ""
      if (count of argv) >= 4 then set sessionId to item 4 of argv
      if (count of argv) >= 5 then set focusScript to item 5 of argv

      -- Format elapsed time
      if elapsedSecs >= 60 then
        set elapsedStr to ((elapsedSecs div 60) as string) & "m " & ((elapsedSecs mod 60) as string) & "s"
      else
        set elapsedStr to (elapsedSecs as string) & "s"
      end if

      if errorCode is "0" then
        set notifTitle to "✅ Done (" & elapsedStr & ")"
        set notifBody to cmdName
        set soundName to "Ping"
      else
        set notifTitle to "❌ Failed (" & elapsedStr & ")"
        set notifBody to cmdName & " (exit " & errorCode & ")"
        set soundName to "Basso"
      end if

      set notifierBin to do shell script "if [ -x /opt/homebrew/bin/terminal-notifier ]; then echo /opt/homebrew/bin/terminal-notifier; else echo /usr/local/bin/terminal-notifier; fi"
      do shell script notifierBin & " -title " & quoted form of notifTitle & " -message " & quoted form of notifBody & " -activate com.googlecode.iterm2; afplay /System/Library/Sounds/" & soundName & ".aiff"
    end if
  end tell
end run
