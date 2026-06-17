#!/usr/bin/env bash
set -euo pipefail

ARCH="$(uname -m)"
case "$ARCH" in
  x86_64) TARGETARCH="amd64" ;;
  aarch64|arm64) TARGETARCH="arm64" ;;
  *) echo "Unsupported arch: $ARCH" && exit 1 ;;
esac

mkdir -p "$HOME/.local/bin"
grep -qxF 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc" \
  || echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"


# install Claude Code
if ! command -v claude &>/dev/null; then
  curl -fsSL https://claude.ai/install.sh | bash
fi
