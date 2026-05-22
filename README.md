# mac-config

A reproducible macOS workspace engineered for speed, focus, and minimal friction.

## Quick Start

```bash
darwin-rebuild switch --flake .#machine
```

## Architecture

### Workspace-Centric Window Management

The desktop is carved into 9 semantic workspaces. Aerospace auto-routes applications to their home, so you never waste thought on placement.

```
 1 → Dev / Coding             2 → Web browsing         3 → File manager
 4 → Content production       5 → Image/Video editing  6 → Messaging
 7 → Music                    8 → System/Settings      9 → Additional
```

### Modal Keyboard System

Aerospace modes collapse app launching, screenshots, media control, and session commands into single keystrokes — no dock clicks, no searching.

### Visual Cohesion

Every interface element shares a single palette — Catppuccin Mocha. Terminal, editor, status bar, file manager, prompt — the entire environment reads as one surface.

### Declarative Dotfiles

~30 tools symlinked to their XDG paths via home-manager, not ad-hoc scripts. Config files under `dotfiles/config/` get wired in at build time.

### Secrets Management

API keys and SSH secrets encrypted with `sops` + `age`.

## Structure

```
flake.nix              — system config (packages, homebrew, defaults, shell)
home.nix               — user packages, dotfiles, config symlinks
dotfiles/config/       — per-tool XDG configuration
dotfiles/pictures/     — wallpapers
secrets/               — encrypted credentials
```

## Built With

- [nix-darwin](https://github.com/nix-darwin/nix-darwin)
- [home-manager](https://github.com/nix-community/home-manager)
- [nix-homebrew](https://github.com/zhaofengli/nix-homebrew)
- [sops-nix](https://github.com/Mic92/sops-nix) + [age](https://age-encryption.org/)
