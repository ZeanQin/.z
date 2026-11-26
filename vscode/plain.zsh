# Open VS Code with the minimal "Plain" profile. Defaults to current dir.
# Usage: code.plain [path ...]
code.plain() { code --profile Plain "${@:-.}"; }
