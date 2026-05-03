#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
INSTALL_DIR="/usr/local/bin"

chmod +x "$SCRIPT_DIR/git-spin"

if [[ -L "$INSTALL_DIR/git-spin" || -f "$INSTALL_DIR/git-spin" ]]; then
    echo "Removing existing git-spin from $INSTALL_DIR..."
    rm -f "$INSTALL_DIR/git-spin"
fi

ln -s "$SCRIPT_DIR/git-spin" "$INSTALL_DIR/git-spin"
echo "Installed git-spin → $INSTALL_DIR/git-spin"
echo "Run 'git-spin --help' to get started."
