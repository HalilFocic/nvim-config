return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 
          'nvim-lua/plenary.nvim',
      },
      keys = {
              { "<leader>pf", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
              { "<C-p>", 
              function() require("telescope.builtin").git_files() end },
              { "<leader>ps",
              function() require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") }) end,
              desc = "Search"
          }
      }
}
