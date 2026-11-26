# VS Code — "Plain" profile

Minimal VS Code profile: plain-text viewing, git diffs, Claude Code extension. Default profile untouched.

- `plain-settings.json` — profile settings (symlinked into VS Code)
- `plain-extensions.txt` — extensions, one per line
- `plain.zsh` — defines `code.plain` launcher (sourced from `~/.zshrc`)
- `install.sh` — creates profile if missing, links settings, installs extensions, adds `code.plain` to `~/.zshrc`. Idempotent.

Use: `code.plain` (current dir) or `code.plain <path ...>` — same as `code --profile Plain <path>`

## How it works

### Symlink
`settings.json` in the profile folder is a symlink — a tiny file holding a path. macOS follows it transparently, so VS Code reads/writes the real file in this repo:

```
~/Library/Application Support/Code/User/profiles/<id>/settings.json  ──►  ~/.z/vscode/plain-settings.json
```

- Edits from either side (incl. VS Code's Settings UI) change the same file.
- Deleting the link leaves the real file; moving/deleting the real file breaks the link.
- Check with `ls -la` (shows `->` target).

### How VS Code loads the profile
1. `User/globalStorage/storage.json` lists profiles, mapping name → random folder id (e.g. `Plain` → `aa1662b`).
2. `code --profile Plain` selects `User/profiles/<id>/`.
3. Loads that folder's `settings.json` (the symlink). Plain doesn't inherit the default profile's settings; unset keys use VS Code's built-in defaults.
4. Extensions are stored once in `~/.vscode/extensions/`; each profile's `extensions.json` lists which are enabled.
5. Settings file is watched — saved changes apply instantly.

### Why install.sh is needed per machine
The folder id is random and only exists once VS Code creates the profile, so Git can't hold a fixed link. The script creates the profile if missing, looks up its id in `storage.json`, symlinks the settings, and installs `plain-extensions.txt`.

### Day to day
- Change settings anywhere → commit from `~/.z`.
- Other machines: `git pull` is enough (link already points here).
- Edit `plain.zsh` to change `code.plain`; picked up by new shells.
- Re-run `install.sh` only on a new machine or after adding an extension.
