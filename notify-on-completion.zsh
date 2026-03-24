NOTIFY_DIR="${0:A:h}"

# Minimum seconds a command must run before notifying (default: 5)
NOTIFY_MIN_SECONDS=${NOTIFY_MIN_SECONDS:-5}

# Commands to never notify about
typeset -a NOTIFY_BLACKLIST
NOTIFY_BLACKLIST=(ls ll la l cd clear pwd echo cat man which exit history z j bg fg jobs)

_notify_cmd_start=0
_notify_last_cmd=""

_notify_preexec() {
  _notify_cmd_start=$SECONDS
  _notify_last_cmd="$1"
}

_notify_on_completion() {
  local last_exit=$?

  # Skip if no command was run (bare Enter)
  [[ -z "$_notify_last_cmd" ]] && return

  local elapsed=$(( SECONDS - _notify_cmd_start ))
  local last_cmd="$_notify_last_cmd"
  _notify_last_cmd=""

  # Skip if below time threshold
  (( elapsed < NOTIFY_MIN_SECONDS )) && return

  # Extract base command for blacklist check
  local base_cmd="${last_cmd%% *}"
  base_cmd="${base_cmd##*/}"

  # Skip if blacklisted
  [[ ${NOTIFY_BLACKLIST[(r)$base_cmd]} == $base_cmd ]] && return

  # Strip "w0t0p0:" prefix from ITERM_SESSION_ID to get just the UUID
  local session_id="${ITERM_SESSION_ID##*:}"
  (osascript "$NOTIFY_DIR/notifyme.applescript" "$last_cmd" "$last_exit" "$elapsed" "$session_id" "$NOTIFY_DIR/focus-iterm-session.applescript" &>/dev/null &)

  # Remote notification via ntfy.sh (fires in zsh where NTFY_TOPIC is available)
  if [[ -n "$NTFY_TOPIC" ]]; then
    local idle_seconds
    idle_seconds=$(ioreg -c IOHIDSystem | awk '/HIDIdleTime/ {print int($NF/1000000000); exit}')
    if (( idle_seconds >= 600 )); then
      local icon="✅"
      (( last_exit != 0 )) && icon="❌"
      (curl -s -H "Priority: high" -d "${icon} ${last_cmd} (${elapsed}s)" "ntfy.sh/$NTFY_TOPIC" &>/dev/null &)
    fi
  fi
}

if [[ ! " ${preexec_functions[*]} " =~ " _notify_preexec " ]]; then
  preexec_functions+=(_notify_preexec)
fi

if [[ ! " ${precmd_functions[*]} " =~ " _notify_on_completion " ]]; then
  precmd_functions+=(_notify_on_completion)
fi
