# local-bin

Personal utility scripts for Ubuntu. All scripts are prefixed with `my-` for easy identification.

## Install

Clone the repo and run:

```bash
git clone git@github.com:wkirschbaum/local-bin.git ~/src/wkirschbaum/local-bin
~/src/wkirschbaum/local-bin/install.sh
```

This symlinks all `my-*` scripts into `~/.local/bin/` and installs a systemd user timer that runs
`my-scripts-update` every morning at 07:00 SAST to keep the scripts up to date via `git pull`.

## Uninstall

```bash
~/src/wkirschbaum/scripts/uninstall.sh
```

Removes all symlinks, stops and removes the systemd timer and service.

## Scripts

| Script | Description |
|---|---|
| `my-system-update` | Full system update: apt, fwupdmgr, snap |
| `my-scripts-update` | Pull latest changes from git and re-link any new scripts |
| `my-update-expert` | Download the latest Expert (Elixir LSP) nightly into `~/.local/bin/expert` |
