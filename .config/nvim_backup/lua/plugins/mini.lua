return {
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		opts = {},
	},
	{
		"echasnovski/mini.surround",
		keys = function(_, keys)
			local mappings = {
				{ "gsa", desc = "Add surrounding", mode = { "n", "v" } },
				{ "gsd", desc = "Delete surrounding" },
				{ "gsf", desc = "Find right surrounding" },
				{ "gsF", desc = "Find left surrounding" },
				{ "gsh", desc = "Highlight surrounding" },
				{ "gsr", desc = "Replace surrounding" },
				{ "gsn", desc = "Update `MiniSurround.config.n_lines`" },
			}
			return vim.list_extend(mappings, keys)
		end,
		opts = {
			mappings = {
				add = "gsa",
				delete = "gsd",
				find = "gsf",
				find_left = "gsF",
				highlight = "gsh",
				replace = "gsr",
				update_n_lines = "gsn",
			},
		},
	},
}
