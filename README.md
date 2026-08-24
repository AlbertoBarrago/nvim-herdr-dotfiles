# Neovim + Herdr dotfiles

Shared development environment with Neovim, Codex, Claude Code, and a persistent
Herdr workspace. The `ide` command creates an editor and agent area across the
top 85% of the workspace, with a compact shell across the bottom 15%. Codex is
the default agent.

## Requirements

- Git
- Neovim 0.10 or newer
- Herdr 0.7.5 or newer
- Codex CLI
- Claude Code CLI
- `jq`

The installer checks these executables but does not install system packages.

## Install

Clone the repository, then run:

```sh
./install.sh
```

The installer links:

- `~/.config/nvim` to `nvim/.config/nvim`
- `~/.local/bin/ide` to `bin/.local/bin/ide`

Existing targets are moved to timestamped sibling backups before linking. Running
the installer again is safe. Use `./install.sh --skip-integration` when the Herdr
Codex integration is managed separately.

Ensure `~/.local/bin` is on `PATH`. For Zsh:

```sh
export PATH="$HOME/.local/bin:$PATH"
```

Open Herdr and create a workspace for a project:

```sh
herdr
ide ~/Projects/example
ide --agent claude ~/Projects/example
```

Pass `--agent codex` or `--agent claude` to select the initial agent. Omitting
the option launches Codex.

## Neovim mappings

These mappings are available only when Neovim runs inside Herdr:

| Mapping | Action |
| --- | --- |
| `<leader>ao` | Open or focus Codex |
| `<leader>af` | Focus the connected Codex pane |
| `<leader>as` | Send the visual selection to Codex |
| `<leader>ad` | Send current buffer diagnostics to Codex |
| `<leader>aco` | Open or focus Claude |
| `<leader>acf` | Focus the connected Claude pane |
| `<leader>acs` | Send the visual selection to Claude |
| `<leader>acd` | Send current buffer diagnostics to Claude |

## Machine-specific configuration

Create `nvim/.config/nvim/lua/local.lua` for settings that must not be shared,
such as corporate paths, proxy configuration, or personal keymaps. The file is
loaded last and ignored by Git.

Example:

```lua
vim.opt.guifont = "JetBrainsMono Nerd Font:h14"
```

Do not commit credentials, Codex sessions, Herdr runtime state, or company
secrets. Those remain outside this repository.

## Updating

```sh
git pull --ff-only
./install.sh
nvim --headless "+Lazy! restore" +qa
```

Shared changes should go through short-lived branches and focused pull requests.
