# Dotfiles

Personal development environment configuration for Neovim and Herdr.

## Layout

- `nvim/.config/nvim`: Neovim configuration managed by `lazy.nvim`.
- `bin/.local/bin/ide`: Herdr workspace launcher.

## Herdr IDE workspace

Run `ide [project-directory]` from an existing Herdr pane. It creates a dedicated
workspace with Neovim, a Codex pane connected to Neovim, and a shell pane.

Neovim mappings are available only when it runs inside Herdr:

| Mapping | Action |
| --- | --- |
| `<leader>ao` | Open or focus Codex |
| `<leader>af` | Focus the connected Codex pane |
| `<leader>as` | Send the visual selection to Codex |
| `<leader>ad` | Send current buffer diagnostics to Codex |

## Installation

The active paths are symlinked to this repository:

- `~/.config/nvim` → `nvim/.config/nvim`
- `~/.local/bin/ide` → `bin/.local/bin/ide`

Required executables: `nvim`, `herdr`, `codex`, and `jq`.
