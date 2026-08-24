-- ==============================
-- Provider Settings
-- ==============================
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- ==============================
-- Load Lazy.nvim Plugin Manager
-- ==============================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- ==============================
-- Plugin Setup (Lazy.nvim)
-- ==============================
require("lazy").setup({
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			local palette = {
				bg = "#0d0f14",
				surface = "#141720",
				surface_alt = "#181d2a",
				border = "#1e2330",
				border_active = "#2a3050",
				accent = "#5aff8f",
				accent2 = "#7b8cff",
				accent3 = "#ff7b5a",
				yellow = "#ffcc5a",
				cyan = "#5af0ff",
				magenta = "#ff5aaa",
				purple = "#d05aff",
				muted = "#4a5270",
				comment = "#7b849f",
				text = "#c8d0e8",
				text_bright = "#e8eeff",
				text_dim = "#6b7594",
				tag_bg = "#1a2040",
				error = "#ff5a7a",
			}

			require("tokyonight").setup({
				style = "moon",
				transparent = false,
				terminal_colors = true,
				styles = {
					comments = { italic = true },
					keywords = { italic = false },
					functions = {},
					variables = {},
				},
				on_colors = function(colors)
					colors.bg = palette.bg
					colors.bg_dark = palette.bg
					colors.bg_float = palette.surface
					colors.bg_highlight = palette.surface_alt
					colors.bg_popup = palette.surface
					colors.bg_sidebar = palette.surface
					colors.fg = palette.text
					colors.fg_dark = palette.text_dim
					colors.fg_float = palette.text
					colors.comment = palette.comment
					colors.border = palette.border
					colors.green = palette.accent
					colors.blue = palette.accent2
					colors.cyan = palette.cyan
					colors.orange = palette.accent3
					colors.yellow = palette.yellow
					colors.magenta = palette.magenta
					colors.purple = palette.purple
					colors.red = palette.error
					colors.error = palette.error
					colors.warning = palette.yellow
					colors.info = palette.cyan
					colors.hint = palette.accent
					colors.git = colors.git or {}
					colors.git.add = palette.accent
					colors.git.change = palette.accent2
					colors.git.delete = palette.accent3
				end,
				on_highlights = function(hl, c)
					hl.Normal = { fg = palette.text, bg = palette.bg }
					hl.NormalNC = { fg = palette.text, bg = palette.bg }
					hl.NormalFloat = { fg = palette.text, bg = palette.surface }
					hl.FloatBorder = { fg = palette.border_active, bg = palette.surface }
					hl.FloatTitle = { fg = palette.accent, bg = palette.surface, bold = true }
					hl.WinSeparator = { fg = palette.border, bg = palette.bg }
					hl.SignColumn = { bg = palette.bg }
					hl.LineNr = { fg = palette.muted }
					hl.CursorLine = { bg = palette.surface_alt }
					hl.CursorLineNr = { fg = palette.accent, bg = palette.surface_alt, bold = true }
					hl.ColorColumn = { bg = palette.surface }
					hl.Visual = { bg = palette.tag_bg }
					hl.Search = { fg = palette.bg, bg = palette.accent }
					hl.IncSearch = { fg = palette.bg, bg = palette.accent3 }
					hl.CurSearch = { fg = palette.bg, bg = palette.yellow }
					hl.MatchParen = { fg = palette.accent, bg = palette.tag_bg, bold = true }
					hl.NonText = { fg = palette.muted }
					hl.SpecialKey = { fg = palette.muted }
					hl.EndOfBuffer = { fg = palette.bg }

					hl.Comment = { fg = palette.comment, italic = true }
					hl.String = { fg = palette.accent }
					hl.Character = { fg = palette.accent }
					hl.Function = { fg = palette.accent2 }
					hl.Method = { fg = palette.accent2 }
					hl.Identifier = { fg = palette.text }
					hl.Variable = { fg = palette.text }
					hl.Statement = { fg = palette.magenta }
					hl.Keyword = { fg = palette.magenta }
					hl.Conditional = { fg = palette.magenta }
					hl.Repeat = { fg = palette.magenta }
					hl.Type = { fg = palette.cyan }
					hl.Constant = { fg = palette.accent3 }
					hl.Number = { fg = palette.accent3 }
					hl.Boolean = { fg = palette.accent3 }
					hl.Operator = { fg = palette.text_dim }
					hl.Delimiter = { fg = palette.text_dim }
					hl.Special = { fg = palette.yellow }

					hl.Pmenu = { fg = palette.text, bg = palette.surface }
					hl.PmenuSel = { fg = palette.text_bright, bg = palette.tag_bg, bold = true }
					hl.PmenuSbar = { bg = palette.surface }
					hl.PmenuThumb = { bg = palette.border_active }

					hl.TelescopeNormal = { fg = palette.text, bg = palette.surface }
					hl.TelescopeBorder = { fg = palette.border_active, bg = palette.surface }
					hl.TelescopePromptNormal = { fg = palette.text_bright, bg = palette.surface }
					hl.TelescopePromptBorder = { fg = palette.accent2, bg = palette.surface }
					hl.TelescopePromptPrefix = { fg = palette.accent }
					hl.TelescopeSelection = { fg = palette.text_bright, bg = palette.surface_alt }
					hl.TelescopeMatching = { fg = palette.accent, bold = true }
					hl.TelescopeTitle = { fg = palette.accent, bg = palette.surface, bold = true }

					hl.NvimTreeNormal = { fg = palette.text, bg = palette.surface }
					hl.NvimTreeNormalNC = { fg = palette.text, bg = palette.surface }
					hl.NvimTreeWinSeparator = { fg = palette.border, bg = palette.surface }
					hl.NvimTreeRootFolder = { fg = palette.accent, bold = true }
					hl.NvimTreeFolderName = { fg = palette.accent2 }
					hl.NvimTreeOpenedFolderName = { fg = palette.accent2, bold = true }
					hl.NvimTreeGitDirty = { fg = palette.yellow }
					hl.NvimTreeGitNew = { fg = palette.accent }
					hl.NvimTreeGitDeleted = { fg = palette.accent3 }

					hl.DiagnosticError = { fg = palette.error }
					hl.DiagnosticWarn = { fg = palette.yellow }
					hl.DiagnosticInfo = { fg = palette.cyan }
					hl.DiagnosticHint = { fg = palette.accent }
					hl.DiagnosticVirtualTextError = { fg = palette.error, bg = palette.bg }
					hl.DiagnosticVirtualTextWarn = { fg = palette.yellow, bg = palette.bg }
					hl.DiagnosticVirtualTextInfo = { fg = palette.cyan, bg = palette.bg }
					hl.DiagnosticVirtualTextHint = { fg = palette.accent, bg = palette.bg }
					hl.DiagnosticUnderlineError = { sp = palette.error, undercurl = true }
					hl.DiagnosticUnderlineWarn = { sp = palette.yellow, undercurl = true }
					hl.DiagnosticUnderlineInfo = { sp = palette.cyan, undercurl = true }
					hl.DiagnosticUnderlineHint = { sp = palette.accent, undercurl = true }

					hl.GitSignsAdd = { fg = palette.accent }
					hl.GitSignsChange = { fg = palette.accent2 }
					hl.GitSignsDelete = { fg = palette.accent3 }
					hl.DiffAdd = { fg = palette.accent, bg = "#10251a" }
					hl.DiffChange = { fg = palette.accent2, bg = "#151a35" }
					hl.DiffDelete = { fg = palette.accent3, bg = "#281613" }
					hl.DiffText = { fg = palette.text_bright, bg = "#20284d" }

					hl.StatusLine = { fg = palette.text, bg = palette.surface }
					hl.StatusLineNC = { fg = palette.text_dim, bg = palette.surface }
					hl.TabLine = { fg = palette.text_dim, bg = palette.surface }
					hl.TabLineSel = { fg = palette.accent, bg = palette.bg, bold = true }
					hl.TabLineFill = { bg = palette.surface }

					hl["@comment"] = { fg = palette.comment, italic = true }
					hl["@string"] = { fg = palette.accent }
					hl["@function"] = { fg = palette.accent2 }
					hl["@function.call"] = { fg = palette.accent2 }
					hl["@keyword"] = { fg = palette.magenta }
					hl["@variable"] = { fg = palette.text }
					hl["@variable.parameter"] = { fg = palette.accent3 }
					hl["@type"] = { fg = palette.cyan }
					hl["@constant"] = { fg = palette.accent3 }
					hl["@number"] = { fg = palette.accent3 }
					hl["@operator"] = { fg = palette.text_dim }
					hl["@punctuation"] = { fg = palette.text_dim }
					hl["@tag"] = { fg = palette.accent2 }
					hl["@tag.attribute"] = { fg = palette.accent3 }
				end,
			})
			vim.cmd.colorscheme("tokyonight-moon")
		end,
	},
	"nvim-treesitter/nvim-treesitter",
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",

	{
		"ms-jpq/coq_nvim",
		branch = "coq",
		dependencies = {
			{ "ms-jpq/coq.artifacts", branch = "artifacts" },
			{ "ms-jpq/coq.thirdparty", branch = "3p" },
		},
	},

	"mfussenegger/nvim-dap",
	"nvim-tree/nvim-tree.lua",
	"nvim-tree/nvim-web-devicons",
	"nvim-lua/plenary.nvim",

	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					path_display = { "truncate" },
					file_ignore_patterns = { "node_modules", ".git" },
				},
			})
		end,
	},

	"stevearc/conform.nvim",
	"doctorfree/cheatsheet.nvim",
	"tpope/vim-fugitive",
	"lewis6991/gitsigns.nvim",
	"kdheepak/lazygit.nvim",
})

-- ==============================
-- General Neovim Settings
-- ==============================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.g.have_nerd_font = true
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8
vim.opt.confirm = true
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.fillchars = { eob = " ", fold = " ", foldopen = "", foldsep = " ", foldclose = "" }

-- Treesitter-based folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevelstart = 99

vim.diagnostic.config({
	virtual_text = {
		spacing = 4,
		source = "if_many",
		prefix = "●",
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "if_many",
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local opts = { buffer = event.buf }
		local map = function(keys, action, desc)
			vim.keymap.set("n", keys, action, vim.tbl_extend("force", opts, { desc = desc }))
		end

		map("gd", vim.lsp.buf.definition, "Go to definition")
		map("gr", vim.lsp.buf.references, "Go to references")
		map("gI", vim.lsp.buf.implementation, "Go to implementation")
		map("<leader>D", vim.lsp.buf.type_definition, "Type definition")
		map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
		map("<leader>ca", vim.lsp.buf.code_action, "Code action")
		map("K", vim.lsp.buf.hover, "Hover documentation")
		map("<leader>ds", require("telescope.builtin").diagnostics, "Workspace diagnostics")
		map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
		map("]d", vim.diagnostic.goto_next, "Next diagnostic")
		map("<leader>df", vim.diagnostic.open_float, "Line diagnostic")
	end,
})

-- ==============================
-- COQ Settings (must be before LSP)
-- ==============================
vim.g.coq_settings = { auto_start = true, keymap = { recommended = true } }

-- ==============================
-- Mason & LSP Setup
-- ==============================
vim.defer_fn(function()
	require("mason").setup()

	local coq = require("coq")
	local servers = { "elixirls", "lua_ls", "pyright", "jdtls", "ts_ls" }
	local capabilities = coq.lsp_ensure_capabilities({})

	for _, server_name in ipairs(servers) do
		vim.lsp.config(server_name, capabilities)
	end

	vim.lsp.config(
		"elixirls",
		vim.tbl_deep_extend("force", capabilities, {
			settings = {
				flags = {
					debounce_text_changes = 150,
				},
				elixirLS = {
					dialyzerEnabled = false,
					fetchDeps = false,
				},
			},
		})
	)

	require("mason-lspconfig").setup({
		ensure_installed = servers,
		automatic_enable = true,
	})

	if vim.fn.executable("sourcekit-lsp") == 1 then
		vim.lsp.config("sourcekit", coq.lsp_ensure_capabilities({}))
		vim.lsp.enable("sourcekit")
	end

	-- Auto-start COQ
	vim.g.coq_settings = { auto_start = "shut-up" }
end, 100)

-- ==============================
-- Treesitter Setup
-- ==============================
require("nvim-treesitter.configs").setup({
	ensure_installed = { "elixir", "heex", "eex", "lua", "python", "java", "javascript", "typescript" },
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
})

-- ==============================
-- Keybindings
-- ==============================
local builtin = require("telescope.builtin")

-- Function to detect Git root
local function project_root()
	local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
	if vim.v.shell_error == 0 and git_root ~= "" then
		return git_root
	end
	return vim.fn.getcwd()
end

-- Telescope keymaps with git root
vim.keymap.set("n", "<leader>f", function()
	builtin.find_files({ cwd = project_root() })
end, { desc = "Find files" })

vim.keymap.set("n", "<leader>g", function()
	builtin.live_grep({ cwd = project_root() })
end, { desc = "Live grep" })

vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "List buffers" })
vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "Help tags" })
vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "Recent files" })
vim.keymap.set("n", "<leader>sf", builtin.current_buffer_fuzzy_find, { desc = "Search current buffer" })

-- File explorer
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })

-- Git keymaps
vim.keymap.set("n", "<leader>gs", ":G<CR>", { desc = "Git status" })
vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Git files" })
vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Git commits" })
vim.keymap.set("n", "<leader>gC", builtin.git_bcommits, { desc = "Buffer commits" })
vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame" })
vim.keymap.set("n", "<leader>gd", ":Gdiffsplit<CR>", { desc = "Git diff" })
vim.keymap.set("n", "<leader>gl", ":LazyGit<CR>", { desc = "LazyGit" })
vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { desc = "Git push" })
vim.keymap.set("n", "<leader>gP", ":Git pull<CR>", { desc = "Git pull" })
vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
vim.keymap.set("n", "<leader>gR", ":Gitsigns reset_buffer<CR>", { desc = "Reset buffer" })
vim.keymap.set("n", "<leader>ga", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>gu", ":Gitsigns undo_stage_hunk<CR>", { desc = "Undo stage hunk" })
vim.keymap.set("n", "]h", ":Gitsigns next_hunk<CR>", { desc = "Next hunk" })
vim.keymap.set("n", "[h", ":Gitsigns prev_hunk<CR>", { desc = "Previous hunk" })

-- Format keybind
vim.keymap.set("n", "<leader>fm", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })

-- ==============================
-- NvimTree Setup
-- ==============================
require("nvim-tree").setup({
	view = {
		width = 30,
		side = "left",
	},
	renderer = {
		icons = {
			show = {
				git = true,
				file = true,
				folder = true,
			},
		},
	},
	filters = {
		dotfiles = false,
		git_ignored = false,
	},
})

-- ==============================
-- Gitsigns Setup
-- ==============================
require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
	current_line_blame = true,
	sign_priority = 6,
	update_debounce = 200,
})

-- ==============================
-- Conform Setup (Formatting)
-- ==============================
require("conform").setup({
	formatters_by_ft = {
		elixir = { "mix" },
		heex = { "mix" },
		eex = { "mix" },
		python = { "black" },
		lua = { "stylua" },
	},
	formatters = {
		mix = {
			command = "mix",
			args = { "format", "-" },
			stdin = true,
		},
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

-- ==============================
-- Lazygit Integration
-- ==============================
vim.g.lazygit_floating_window_winblend = 0
vim.g.lazygit_floating_window_scaling_factor = 1.0
vim.g.lazygit_floating_window_border_chars = { "╭", "╮", "╰", "╯", "─", "│", "├", "┤" }
vim.g.lazygit_use_neovim_remote = 1

-- ==============================
-- Colorscheme
-- ==============================
vim.cmd.colorscheme("tokyonight")
