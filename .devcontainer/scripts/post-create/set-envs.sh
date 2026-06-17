#!/usr/bin/env bash
set -euo pipefail

# https://code.visualstudio.com/remote/advancedcontainers/persist-bash-history
SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=\$HOME/.bash_history"
touch "$HOME/.bash_history"
grep -qxF "$SNIPPET" "$HOME/.bashrc" || echo "$SNIPPET" >> "$HOME/.bashrc"
