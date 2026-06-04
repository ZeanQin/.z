#!/usr/bin/env sh
# Provision tmux on a new machine: symlink the config, install TPM and plugins.
# Idempotent — safe to re-run any time (also doubles as a "update plugins" command).
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"

# 1. Symlink the config into place (~/.tmux.conf -> repo/.tmux.conf)
ln -sf "$DIR/.tmux.conf" "$HOME/.tmux.conf"
echo "Linked ~/.tmux.conf -> $DIR/.tmux.conf"

# 2. Install TPM (the plugin manager) if it isn't already present
TPM="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM" ]; then
  echo "Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm "$TPM"
fi

# 3. Install / update the plugins headlessly.
#    TPM reads TMUX_PLUGIN_MANAGER_PATH from a running tmux server, which only
#    gets set once the config is sourced. So spin up a throwaway detached
#    session, install against it, then drop just that session (never the
#    server — you may already have tmux open).
echo "Installing plugins..."
tmux new-session -d -s __tpm_bootstrap 2>/dev/null || true
# Explicitly source the config so TMUX_PLUGIN_MANAGER_PATH is set even when a
# server was already running with an older config.
tmux source-file "$HOME/.tmux.conf" 2>/dev/null || true
"$TPM/bin/install_plugins"
tmux kill-session -t __tpm_bootstrap 2>/dev/null || true

# 4. Reload config if a server is already running (ignore failure if none)
tmux source-file "$HOME/.tmux.conf" 2>/dev/null || true

echo "Done. Start tmux, or reload an existing session with: prefix + r"