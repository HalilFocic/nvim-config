--true- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		-- or                            , branch = '0.1.x',
	})
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	use("ThePrimeagen/vim-be-good")
	use("theprimeagen/harpoon")
	use("mbbill/undotree")
  -- Themes
	use("navarasu/onedark.nvim")
  use('folke/tokyonight.nvim')
  use({'rose-pine/neovim' , as = 'rose-pine'})

  -- todo-comments for searching through todo and fixme 
  use {'folke/todo-comments.nvim', requires = 'nvim-lua/plenary.nvim'}
  -- Git control from my pope
	use("tpope/vim-fugitive")
  -- lsp config
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		requires = {
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "neovim/nvim-lspconfig" },
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "L3MON4D3/LuaSnip" },
		},
	})
	use("nvim-lua/plenary.nvim")
	use("m4xshen/autoclose.nvim")
  -- Auto format config
	use("jose-elias-alvarez/null-ls.nvim")
  -- use nvim ts autotag
  use("windwp/nvim-ts-autotag" )
  -- Tmux config
	use({
		"christoomey/vim-tmux-navigator",
		config = function()
			vim.api.nvim_set_keymap("n", "<c-h>", ":TmuxNavigateLeft<CR>", { silent = true })
			vim.api.nvim_set_keymap("n", "<c-j>", ":TmuxNavigateDown<CR>", { silent = true })
			vim.api.nvim_set_keymap("n", "<c-k>", ":TmuxNavigateUp<CR>", { silent = true })
			vim.api.nvim_set_keymap("n", "<c-l>", ":TmuxNavigateRight<CR>", { silent = true })
			vim.api.nvim_set_keymap("n", "<c-\\>", ":TmuxNavigatePrevious<CR>", { silent = true })
		end,
	})
end)
