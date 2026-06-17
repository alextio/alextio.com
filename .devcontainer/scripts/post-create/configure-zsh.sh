#!/usr/bin/env bash
set -euo pipefail

# Install powerlevel10k theme
P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ ! -d "$P10K_DIR" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
fi

ZSHRC="$HOME/.zshrc"

# Set powerlevel10k as the ZSH_THEME
if [ -f "$ZSHRC" ]; then
  sed -i 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' "$ZSHRC"
fi

# Append shared history settings if not already present
if ! grep -q 'SHARE_HISTORY' "$ZSHRC" 2>/dev/null; then
  cat >> "$ZSHRC" <<'EOF'

# Shared history across terminal sessions
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
EOF
fi
