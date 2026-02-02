return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        workspaces = {
            {
                name = "notes",
                path = "~/Documentos/Obsidian_Vault", -- CAMBIA ESTO a tu carpeta de Obsidian
            },
        },
        completion = {
            nvim_cmp = false,
            min_chars = 2,
        },
        -- Usar fzf-lua como picker
        ui = {
            enable = false, -- desactiva el UI de obsidian para usar el tuyo
        },
    },
    keys = {
        { "<leader>oc", "<cmd>lua require('obsidian').util.toggle_checkbox()<CR>", desc = "Toggle checkbox" },
        { "<leader>on", "<cmd>ObsidianNew<CR>", desc = "New note" },
        { "<leader>os", "<cmd>ObsidianSearch<CR>", desc = "Search notes" },
        { "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", desc = "Quick switch" },
        { "<leader>ob", "<cmd>ObsidianBacklinks<CR>", desc = "Show backlinks" },
        { "<leader>ot", "<cmd>ObsidianTemplate<CR>", desc = "Insert template" },
        { "<leader>oo", "<cmd>ObsidianOpen<CR>", desc = "Open in Obsidian app" },
        { "gf", function() return require("obsidian").util.gf_passthrough() end, desc = "Follow link", ft = "markdown" },
    },
}
