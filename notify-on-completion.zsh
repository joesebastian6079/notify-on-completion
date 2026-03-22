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

  (osascript "$NOTIFY_DIR/notifyme.applescript" "$last_cmd" "$last_exit" "$elapsed" &>/dev/null &)
}

if [[ ! " ${preexec_functions[*]} " =~ " _notify_preexec " ]]; then
  preexec_functions+=(_notify_preexec)
fi

if [[ ! " ${precmd_functions[*]} " =~ " _notify_on_completion " ]]; then
  precmd_functions+=(_notify_on_completion)
fi
