return  {
  "catppuccin/nvim", 
  name = "catppuccin", 
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      integrations = {
        treesitter = true,
        neotree = true,
        nvimtree = true,
      }
    })
    vim.cmd.colorscheme "catppuccin-frappe"
  end

}
