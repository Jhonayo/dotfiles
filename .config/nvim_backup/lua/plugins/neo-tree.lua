return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	cmd = "Neotree",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},

	keys = {
		{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
		{ "<leader>o", "<cmd>Neotree focus<cr>", desc = "Focus Neo-tree" },
	},

	opts = {
		------------------------------------------------------------------
		-- Sources (igual que LazyVim)
		------------------------------------------------------------------
		sources = { "filesystem", "buffers", "git_status" },

		------------------------------------------------------------------
		-- Barra superior con selector + ?
		------------------------------------------------------------------
		source_selector = {
			winbar = true,
			statusline = false,
			content_layout = "center",
			tabs_layout = "equal",
			show_separator_on_edge = true,
			sources = {
				{ source = "filesystem", display_name = "  Files " },
				{ source = "buffers", display_name = "  Buffers " },
				{ source = "git_status", display_name = "  Git " },
			},
		},

		------------------------------------------------------------------
		-- Configuración del filesystem (LazyVim behavior)
		------------------------------------------------------------------
		filesystem = {
			follow_current_file = {
				enabled = true,
			},
			hijack_netrw_behavior = "open_current",

			filtered_items = {
				visible = false, -- ocultos por defecto
				hide_dotfiles = true,
				hide_gitignored = true,
			},
		},

		------------------------------------------------------------------
		-- Iconos (LazyVim-like)
		------------------------------------------------------------------
		default_component_configs = {
			icon = {
				folder_closed = "",
				folder_open = "",
				folder_empty = "",
				default = "",
			},
			git_status = {
				symbols = {
					added = "✚",
					modified = "",
					deleted = "✖",
					renamed = "󰁕",
					untracked = "",
					ignored = "",
					unstaged = "󰄱",
					staged = "",
					conflict = "",
				},
			},
		},

		------------------------------------------------------------------
		-- Ventana y keymaps (igual que LazyVim)
		------------------------------------------------------------------
		window = {
			width = 30,
			mappings = {
				["<space>"] = "none",
				["l"] = "open",
				["h"] = "close_node",
				["H"] = "toggle_hidden",
				["I"] = "toggle_gitignore",
				["?"] = "show_help",
				["1"] = "filesystem",
				["2"] = "buffers",
				["3"] = "git_status",
			},
		},
	},
}
