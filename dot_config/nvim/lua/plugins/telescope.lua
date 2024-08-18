return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim', "BurntSushi/ripgrep", "sharkdp/fd" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set('n', '<C-p>', builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", function()
        builtin.live_grep({ additional_args = function()
          return { "--hidden" }
        end,
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--hidden'
          }
        })
      end, {})
      vim.keymap.set('n', '<leader>ff', function()
        builtin.find_files({hidden=true})
      end, { desc = "Find all files under this dir" })
    end
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            }
          }
        },
        pickers = {
          find_files = {
            hidden = true
          }
        },
        defaults = {
          vimgrep_arguments = {
            'rg',
            'hidden',
          }
        }
      }
      require("telescope").load_extension("ui-select")
    end
  }
}
