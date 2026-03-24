# notify-on-completion

## The Problem

Developers running long terminal commands (builds, deploys, test suites) constantly tab back to check if they're done. Claude Code users miss input prompts while multitasking. There's no native macOS solution that's both focus-aware and supports AI coding tools.

## The Solution

A lightweight macOS utility that delivers smart notifications when terminal commands complete or when Claude Code needs user input. Only alerts when the terminal isn't in focus — no unnecessary interruptions.

---
macOS notifications for terminal commands and Claude Code. Get pinged when long-running commands finish or when Claude Code needs your input. Clicking the notification opens iTerm2 directly.

## Why I Built This

I run long builds, deploys, and AI coding sessions daily. I kept missing Claude Code prompts while working in another app. Existing solutions either spammed notifications regardless of focus, required complex setup, or didn't support AI coding tools.

So I built a focus-aware, CLI-friendly, Claude-ready notification tool. It's not perfect. But it works and it's MIT licensed — use it, fork it, improve it.

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

\```bash
brew install terminal-notifier
\```

## Installation

### Terminal notifications

\```bash
# Clone the repo
git clone https://github.com/joesebastian6079/notify-on-completion.git ~/notify-on-completion

# Add to your .zshrc
echo 'source ~/notify-on-completion/notify-on-completion.zsh' >> ~/.zshrc
# Reload shell
exec zsh
\```

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

## Tradeoffs & Decisions

– Chose AppleScript over Swift for rapid prototyping and accessibility to non-developers

– Used terminal-notifier for clickable notifications instead of native osascript alerts (which can't focus apps on click)

– iTerm2-specific by design — focused on the terminal most developers actually use rather than trying to support every terminal emulator

## What I Learned

– macOS notification system has surprising limitations — native osascript notifications can't carry click actions, which forced the terminal-notifier dependency

– Focus detection via System Events is more reliable than checking window process IDs

– Zsh precmd/preexec hooks are the cleanest integration point for shell completion tracking

## License

MIT - do whatever you want with it.

## Acknowledgments

- Original solution by [Alex Kotliarskyi](https://frantic.im/notify-on-completion/)
- Built with help from Claude (Anthropic)
