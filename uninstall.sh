#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="$HOME/.local/bin"
SYSTEMD_DIR="$HOME/.config/systemd/user"

step() { printf '\n\033[1;34m==> %s\033[0m\n' "$*"; }

step "Stopping and disabling my-scripts-update.timer"
systemctl --user disable --now my-scripts-update.timer 2>/dev/null || true

step "Removing systemd user units"
for unit in "$REPO_DIR"/systemd/*; do
  [[ -f "$unit" ]] || continue
  name="$(basename "$unit")"
  target="$SYSTEMD_DIR/$name"
  if [[ -f "$target" ]]; then
    rm "$target"
    echo "  $name: removed"
  fi
done
systemctl --user daemon-reload

step "Removing symlinks from $BIN_DIR"
for script in "$REPO_DIR"/my-*; do
  [[ -f "$script" ]] || continue
  name="$(basename "$script")"
  target="$BIN_DIR/$name"
  if [[ -L "$target" ]] && [[ "$(realpath "$target")" == "$script" ]]; then
    rm "$target"
    echo "  $name: removed"
  fi
done

step "Done"
