local inside_herdr = vim.env.HERDR_SOCKET_PATH ~= nil and vim.env.HERDR_SOCKET_PATH ~= ""

return {
	{
		"ctbaum/herdr-agents.nvim",
		cond = inside_herdr,
		lazy = false,
		dependencies = {
			{ "coder/claudecode.nvim", dependencies = { "folke/snacks.nvim" } },
		},
		opts = {
			claude = { enabled = true },
		},
		keys = {
			{
				"<leader>aco",
				function()
					require("herdr-agents").open("claude")
				end,
				desc = "Agent: open Claude",
			},
			{
				"<leader>acf",
				function()
					require("herdr-agents").focus("claude")
				end,
				desc = "Agent: focus Claude",
			},
			{
				"<leader>acs",
				"<cmd>ClaudeHerdrSendSelection<cr>",
				mode = "v",
				desc = "Agent: send selection to Claude",
			},
			{
				"<leader>acd",
				"<cmd>ClaudeHerdrSendDiagnostics<cr>",
				desc = "Agent: send diagnostics to Claude",
			},
		},
	},
	-- Outside herdr (e.g. Rex), load claudecode.nvim on its own so `/ide` in
	-- Claude Code can discover this Neovim instance via ~/.claude/ide/*.lock.
	-- Inside herdr, herdr-agents.nvim already sets it up as a dependency.
	{
		"coder/claudecode.nvim",
		cond = not inside_herdr,
		lazy = false,
		dependencies = { "folke/snacks.nvim" },
		opts = {},
		keys = {
			{ "<leader>acs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Agent: send selection to Claude" },
			{ "<leader>aca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Agent: accept Claude diff" },
			{ "<leader>acr", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Agent: reject Claude diff" },
		},
	},
}
