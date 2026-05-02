#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="$HOME/.local/bin"
SYSTEMD_DIR="$HOME/.config/systemd/user"
SKIP_SYSTEMD=false

for arg in "$@"; do
  [[ "$arg" == "--skip-systemd" ]] && SKIP_SYSTEMD=true
done

step() { printf '\n\033[1;34m==> %s\033[0m\n' "$*"; }

step "Linking scripts to $BIN_DIR"
mkdir -p "$BIN_DIR"
linked=0
for script in "$REPO_DIR"/my-*; do
  [[ -f "$script" ]] || continue
  name="$(basename "$script")"
  target="$BIN_DIR/$name"
  chmod +x "$script"
  if [[ -L "$target" ]] && [[ "$(realpath "$target")" == "$script" ]]; then
    echo "  $name: already linked"
  else
    ln -sf "$script" "$target"
    echo "  $name: linked"
  fi
  (( linked++ )) || true
done
echo "  $linked script(s) processed"

$SKIP_SYSTEMD && exit 0

step "Installing systemd user units"
mkdir -p "$SYSTEMD_DIR"
for unit in "$REPO_DIR"/systemd/*; do
  [[ -f "$unit" ]] || continue
  name="$(basename "$unit")"
  cp "$unit" "$SYSTEMD_DIR/$name"
  echo "  $name: installed"
done

systemctl --user daemon-reload

step "Enabling timers"
for unit in "$REPO_DIR"/systemd/*.timer; do
  [[ -f "$unit" ]] || continue
  name="$(basename "$unit")"
  systemctl --user enable --now "$name"
  echo "  $name: enabled"
done

step "Done"
