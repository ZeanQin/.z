# claude

User-level (global) instructions for [Claude Code](https://claude.com/claude-code),
loaded automatically for every project on this machine.

## Install

```sh
./install.sh
```

This symlinks `CLAUDE.md` into place:

```
~/.claude/CLAUDE.md -> claude/CLAUDE.md
```

Only the single file is symlinked — `~/.claude/` also holds Claude Code's own
state (sessions, settings, etc.), which is not tracked here.

## Notes

- This is **user memory**: cross-project preferences for your machine.
- Project-specific guidance belongs in a `CLAUDE.md` at that project's root.
- Claude merges memory from enterprise → user (this file) → project → subdirectory.
