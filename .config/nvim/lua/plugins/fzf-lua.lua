return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("fzf-lua").setup({
			winopts = {
				height = 0.85,
				width = 0.80,
				row = 0.35,
				col = 0.50,
				border = 'rounded',
				preview = {
					default = 'bat',
					border = 'border',
					wrap = 'nowrap',
					hidden = 'nohidden',
					vertical = 'down:45%',
					horizontal = 'right:60%',
					layout = 'flex',
					flip_columns = 120,
				},
			},
			previewers = {
				bat = {
					cmd = "bat",
					args = "--color=always --style=numbers,changes",
					theme = 'tokyonight',
				},
			},
			files = {
				previewer = "bat",
			},
			grep = {
				previewer = "bat",
			},
		})

		-- Keymaps (los mismos que tenías con Telescope)
		local fzf = require('fzf-lua')
		vim.keymap.set('n', '<leader>ff', fzf.files, { desc = 'Find files' })
		vim.keymap.set('n', '<leader>fg', fzf.live_grep, { desc = 'Live grep' })
		vim.keymap.set('n', '<leader>fb', fzf.buffers, { desc = 'Buffers' })
		vim.keymap.set('n', '<leader>fh', fzf.helptags, { desc = 'Help tags' })
	end
}
