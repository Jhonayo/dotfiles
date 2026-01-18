local function enable_transparency()
  vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
end

return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 100,
    config = function()
      require("tokyonight").setup({
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "dark",  -- Cambia a "dark" para que tenga fondo
        },
     })
      vim.cmd.colorscheme("tokyonight")
      enable_transparency()
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      theme = 'tokyonight',
    }
  },
}
