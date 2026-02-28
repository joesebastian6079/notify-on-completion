# notify-on-completion

macOS notifications for terminal commands and Claude Code. Get pinged when long-running commands finish or when Claude Code needs your input.

## What's included

| File | Purpose |
|------|---------|
| `notifyme.applescript` | Shows notification when terminal command finishes (only if terminal not in focus) |
| `notify-on-completion.zsh` | Hooks into zsh to trigger notifications after every command |
| `claude-task-finished.sh` | Claude Code hook - notifies when task completes |
| `claude-input-needed.sh` | Claude Code hook - notifies when input is needed |

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

Test: Run `sleep 3` and switch to another app. You'll get a notification when it finishes.

### Claude Code notifications

In Claude Code, run `/hooks` and configure:
- **Stop hook**: `~/notify-on-completion/claude-task-finished.sh`
- **Notification hook**: `~/notify-on-completion/claude-input-needed.sh`

Or ask Claude Code to set them up for you.

## How it works

- ✅ Success: Shows "Command Finished" with a ping sound
- ❌ Failure: Shows "Command Failed" with exit code
- 🔔 Claude Code: Different sounds for task complete (Ping) vs input needed (Funk)

Notifications only appear when the terminal is **not** in focus - no spam while you're watching.

## Credits

Based on [this article](https://frantic.im/notify-on-completion/) by Alex Kotliarskyi.

## License

MIT - do whatever you want with it.

## Acknowledgments

- Original solution by [Alex Kotliarskyi](https://frantic.im/notify-on-completion/)
- Built with help from Claude (Anthropic)
