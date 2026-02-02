return {
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        build = ":MasonUpdate",
        opts = {
            ensure_installed = {
                -- JavaScript/TypeScript
                "typescript-language-server",
                "eslint-lsp",
                "prettier",
                
                -- Python
                "pyright",
                "ruff",
                
                -- Web
                "html-lsp",
                "css-lsp",
                "tailwindcss-language-server",
                
                -- Lua
                "lua-language-server",
                "stylua",
                
                -- Markdown
                "markdownlint",
                "markdown-toc",
                
                -- Formatters
                "prettierd",
                "black",
            },
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = {
            automatic_installation = true,
        },
    },
}
