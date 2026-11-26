#!/usr/bin/env sh
# Provision the minimal "Plain" VS Code profile (diff viewer + Claude Code).
# Symlinks plain-settings.json into the profile's folder. Idempotent — safe to re-run.
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
PROFILE="Plain"
USER_DIR="$HOME/Library/Application Support/Code/User"
STORAGE="$USER_DIR/globalStorage/storage.json"

command -v code >/dev/null || { echo "'code' CLI not found. Install it from VS Code: Shell Command: Install 'code' command in PATH"; exit 1; }

profile_id() {
  python3 -c "import json,sys
try: d=json.load(open(sys.argv[1]))
except Exception: sys.exit(1)
p=[x for x in d.get('userDataProfiles',[]) if x['name']==sys.argv[2]]
print(p[0]['location']) if p else sys.exit(1)" "$STORAGE" "$PROFILE"
}

# The CLI can't create a profile; opening a window with it does. ID differs per machine.
ID="$(profile_id 2>/dev/null || true)"
if [ -z "$ID" ]; then
  echo "Creating '$PROFILE' profile (opens a VS Code window)..."
  code --profile "$PROFILE" --new-window
  i=0; while [ -z "$ID" ] && [ $i -lt 40 ]; do sleep 0.5; ID="$(profile_id 2>/dev/null || true)"; i=$((i+1)); done
  [ -n "$ID" ] || { echo "Profile not found after launch"; exit 1; }
fi

PDIR="$USER_DIR/profiles/$ID"
mkdir -p "$PDIR"
ln -sf "$DIR/plain-settings.json" "$PDIR/settings.json"
echo "Linked $PDIR/settings.json -> $DIR/plain-settings.json"

while read -r ext; do
  [ -n "$ext" ] && code --profile "$PROFILE" --install-extension "$ext" >/dev/null && echo "Installed $ext"
done < "$DIR/plain-extensions.txt"

# Add `code.plain` launcher: source plain.zsh from ~/.zshrc (once).
LINE="[ -f \"$DIR/plain.zsh\" ] && source \"$DIR/plain.zsh\""
touch "$HOME/.zshrc"
if ! grep -qF "$DIR/plain.zsh" "$HOME/.zshrc"; then
  printf '\n# VS Code Plain profile launcher (from ~/.z/vscode)\n%s\n' "$LINE" >> "$HOME/.zshrc"
  echo "Added code.plain to ~/.zshrc (open a new shell or: source ~/.zshrc)"
fi
