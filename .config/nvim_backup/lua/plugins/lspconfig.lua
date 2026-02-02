return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		{ "saghen/blink.cmp" },
	},
	config = function()
		-- Configurar capabilities de blink.cmp
		local capabilities = require('blink.cmp').get_lsp_capabilities()

		-- Keymaps que se aplican cuando LSP se adjunta a un buffer
		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('UserLspConfig', {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				-- Keymaps
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
				vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
				vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
				vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
				vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
				vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
				vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
				vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
				vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
			end,
		})

		-- Configuración base para todos los servers
		local default_config = {
			capabilities = capabilities,
		}

		-- TypeScript/JavaScript
		vim.lsp.config('ts_ls', vim.tbl_extend('force', default_config, {}))

		-- Python
		vim.lsp.config('pyright', vim.tbl_extend('force', default_config, {}))

		-- HTML
		vim.lsp.config('html', vim.tbl_extend('force', default_config, {}))

		-- CSS
		vim.lsp.config('cssls', vim.tbl_extend('force', default_config, {}))

		-- Lua con configuración especial
		vim.lsp.config('lua_ls', vim.tbl_extend('force', default_config, {
			settings = {
				Lua = {
					diagnostics = {
						globals = { 'vim' },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					telemetry = {
						enable = false,
					},
				},
			},
		}))

		-- TailwindCSS
		vim.lsp.config('tailwindcss', vim.tbl_extend('force', default_config, {}))

		-- Habilitar los servers (reemplaza vim.lsp.enable)
		vim.lsp.enable({ 'ts_ls', 'pyright', 'html', 'cssls', 'lua_ls', 'tailwindcss' })
	end,
}
