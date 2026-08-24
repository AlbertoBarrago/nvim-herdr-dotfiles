local inside_herdr = vim.env.HERDR_SOCKET_PATH and vim.env.HERDR_SOCKET_PATH ~= ""

return {
	{
		"ctbaum/herdr-agents.nvim",
		cond = inside_herdr,
		lazy = false,
		dependencies = {
			{ "ishiooon/codex.nvim", dependencies = { "folke/snacks.nvim" } },
		},
		opts = {
			claude = { enabled = false },
			codex = {
				enabled = true,
				opts = { focus_after_send = false },
			},
		},
		keys = {
			{
				"<leader>ao",
				function()
					require("herdr-agents").open("codex")
				end,
				desc = "Agent: open Codex",
			},
			{
				"<leader>af",
				function()
					require("herdr-agents").focus("codex")
				end,
				desc = "Agent: focus Codex",
			},
			{
				"<leader>as",
				"<cmd>CodexSend<cr>",
				mode = "v",
				desc = "Agent: send selection",
			},
			{
				"<leader>ad",
				"<cmd>CodexHerdrSendDiagnostics<cr>",
				desc = "Agent: send diagnostics",
			},
		},
	},
}
