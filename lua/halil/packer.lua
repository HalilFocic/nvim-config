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
    use('folke/tokyonight.nvim')
    use({
        "L3MON4D3/LuaSnip",
        requires = {
            { "rafamadriz/friendly-snippets" },
        },
        -- follow latest release.
        tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!:).
        run = "make install_jsregexp"
    })
    use { 'folke/todo-comments.nvim', requires = 'nvim-lua/plenary.nvim' }
    -- Git control from my pope
    use("tpope/vim-fugitive")
    use("f-person/git-blame.nvim")
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
    use ('nvim-tree/nvim-web-devicons')
    use("nvim-lua/plenary.nvim")
    use("m4xshen/autoclose.nvim")
    use {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup {}
        end
    }
    -- Auto format config
    use("jose-elias-alvarez/null-ls.nvim")
    -- use nvim ts autotag
    use("windwp/nvim-ts-autotag")
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
