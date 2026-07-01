# homebrew-usrcp

Homebrew tap for [USRCP](https://github.com/frank-bot07/usrcp) — encrypted local AI memory protocol. Your context, your machine, your keys.

## Install

```sh
brew tap frank-bot07/usrcp
brew install usrcp
```

Or in one step:

```sh
brew install frank-bot07/usrcp/usrcp
```

## What you get

The brew install ships the core `usrcp` CLI (encrypted local SQLite ledger, MCP server, 12 tools accessible to Claude Code, Cursor, Cline, Hermes, OpenClaw).

After install:

```sh
usrcp init           # interactive setup — prompts for passphrase
usrcp setup          # interactive adapter picker
usrcp serve          # start the MCP server
```

Adapters available out of the box (no extra install): `terminal` (Claude Code, Cursor, Cline, Antigravity, OpenCode), `mcp-agent`, `openclaw`.

Capture adapters (Discord, Slack, Telegram, iMessage, Obsidian, Linear, GitHub, Gmail, Google Calendar, Claude Code, Chrome extension) are published on **npm** — install the ones you want alongside the brew CLI, e.g. `npm install usrcp-discord`. See the [main repo](https://github.com/frank-bot07/usrcp) for per-adapter setup.

## Update

```sh
brew update
brew upgrade usrcp
```

## Uninstall

```sh
brew uninstall usrcp
brew untap frank-bot07/usrcp
```
