return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown" },
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		opts = {},
		keys = {
			{ "<leader>mr", "<cmd>RenderMarkdown toggle<CR>", ft = "markdown", desc = "Markdown: toggle render" },
		},
	},
}
