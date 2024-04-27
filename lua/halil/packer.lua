-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.6',
		-- or                            , branch = '0.1.x',
	}
	use ('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})
	use 'ThePrimeagen/vim-be-good'
	use ('theprimeagen/harpoon')
	use 'mbbill/undotree'
  use 'navarasu/onedark.nvim'
	use 'tpope/vim-fugitive'
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		requires = {
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},
			{'neovim/nvim-lspconfig'},
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'L3MON4D3/LuaSnip'},
		}
	}
  use "nvim-lua/plenary.nvim"
  use 'm4xshen/autoclose.nvim'
end)

