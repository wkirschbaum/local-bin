# local-bin

Personal utility scripts for Ubuntu (whkbus). See `~/.claude/CLAUDE.md` for machine setup details.

## Conventions

- Prefer bash scripts (`.sh`) unless a task clearly benefits from Python or another language.
- Scripts should be self-contained and runnable from any directory.
- Use `#!/usr/bin/env bash` shebangs and `set -euo pipefail` at the top of bash scripts.
- Make scripts executable (`chmod +x`).
