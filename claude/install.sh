#!/usr/bin/env sh
# Provision user-level Claude Code config on a new machine.
# Symlinks CLAUDE.md into ~/.claude/. Idempotent — safe to re-run any time.
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"

# ~/.claude/ holds Claude Code's own state, so only symlink the single file,
# never the whole directory. Create the dir first in case it doesn't exist yet.
mkdir -p "$HOME/.claude"
ln -sf "$DIR/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
echo "Linked ~/.claude/CLAUDE.md -> $DIR/CLAUDE.md"
