# notify-on-completion

macOS notifications for terminal commands and Claude Code. Get pinged when long-running commands finish or when Claude Code needs your input. Clicking the notification opens iTerm2 directly.

## What's included

| File | Purpose |
|------|---------|
| `notifyme.applescript` | Shows notification when terminal command finishes (only if terminal not in focus) |
| `notify-on-completion.zsh` | Hooks into zsh to trigger notifications after every command |
| `claude-task-finished.sh` | Claude Code hook - notifies when task completes |
| `claude-input-needed.sh` | Claude Code hook - notifies when input is needed |

## Requirements

- macOS
- [terminal-notifier](https://github.com/julienXX/terminal-notifier) (for clickable notifications)

```bash
brew install terminal-notifier
```

## Installation

### Terminal notifications

```bash
# Clone the repo
git clone https://github.com/joesebastian6079/notify-on-completion.git ~/notify-on-completion

# Add to your .zshrc
echo 'source ~/notify-on-completion/notify-on-completion.zsh' >> ~/.zshrc

# Reload shell
exec zsh
```

Test: Run `sleep 3` and switch to another app. You'll get a notification with sound when it finishes.

### Claude Code notifications

In Claude Code, run `/hooks` and configure:
- **Stop hook**: `~/notify-on-completion/claude-task-finished.sh`
- **Notification hook**: `~/notify-on-completion/claude-input-needed.sh`

Or just ask Claude Code to set them up for you.

## How it works

- ✅ **Success**: Shows "Command Finished" with Ping sound
- ❌ **Failure**: Shows "Command Failed" with exit code
- 🔔 **Claude Code**: Different sounds - Ping for task complete, Funk for input needed

Notifications only appear when the terminal is **not** in focus - no spam while you're watching.

Clicking any notification opens iTerm2 directly.

## Note

If you use Terminal.app instead of iTerm2, update the `-activate` parameter in the scripts:
- iTerm2: `com.googlecode.iterm2`
- Terminal: `com.apple.Terminal`

## License

MIT - do whatever you want with it.

## Acknowledgments

- Original solution by [Alex Kotliarskyi](https://frantic.im/notify-on-completion/)
- Built with help from Claude (Anthropic)
