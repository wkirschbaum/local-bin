# local-bin

Personal utility scripts for Ubuntu (whkbus). See `~/.claude/CLAUDE.md` for machine setup details.

## Conventions

- All scripts are prefixed with `my-` to make them easy to identify as personal scripts on any machine.
- Prefer bash scripts unless a task clearly benefits from Python or another language.
- Scripts should be self-contained and runnable from any directory.
- Use `#!/usr/bin/env bash` shebangs and `set -euo pipefail` at the top of bash scripts.
- Make scripts executable (`chmod +x`).
- Ubuntu native tooling is preferred: apt, systemd, snap, fwupdmgr, curl, etc.

## How it works

`install.sh` symlinks all `my-*` scripts from this repo into `~/.local/bin/` and installs the
`my-scripts-update` systemd user timer, which runs a daily `git pull` to keep scripts current.

Systemd unit files live in `systemd/` and are installed to `~/.config/systemd/user/`.
