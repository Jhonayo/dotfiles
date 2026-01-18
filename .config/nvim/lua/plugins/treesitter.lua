return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    dependencies = {
        'windwp/nvim-ts-autotag',
    },
    opts = {
        highlight = { enable = true },
        indent = { enable = true },
        autotag = { enable = true },
        ensure_installed = {
            "lua",
            "tsx",
            "typescript",
            "javascript",
            "html",
            "css",
        },
        auto_install = true,
        sync_install = false,
    },
}
