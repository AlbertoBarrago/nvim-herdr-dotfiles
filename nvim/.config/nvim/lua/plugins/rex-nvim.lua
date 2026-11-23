-- rex-nvim (github.com/AlbertoBarrago/rex-nvim): registers this nvim when it
-- runs in a Rex pane, so file hyperlinks clicked in Rex open here.
-- Loaded from the local clone; skipped on machines without it.
local dir = vim.fn.expand("~/Projects/rex-nvim/nvim")

return {
	{
		dir = dir,
		name = "rex-nvim",
		lazy = false,
		cond = vim.uv.fs_stat(dir) ~= nil,
	},
}
