NOTIFY_DIR="${0:A:h}"

_notify_on_completion() {
  local last_exit=$?
  local last_cmd=$(fc -ln -1 | sed 's/^[[:space:]]*//')
  (osascript "$NOTIFY_DIR/notifyme.applescript" "$last_cmd" "$last_exit" &>/dev/null &)
}

if [[ ! " ${precmd_functions[*]} " =~ " _notify_on_completion " ]]; then
  precmd_functions+=(_notify_on_completion)
fi
