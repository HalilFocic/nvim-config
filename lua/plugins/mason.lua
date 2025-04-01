return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
    },
    opts = function()
        local mason = require('mason')
        local mason_lspconfig = require('mason-lspconfig')

        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })
        mason_lspconfig.setup({
            ensure_installed = {
                'bashls',
                'lua_ls',
                'cssls',
                'html',
                'jsonls',
                'ts_ls',
                'vimls',
                'yamlls',
                'eslint',
                'tailwindcss',
                'gopls',
                "yamlls",
                "templ",
                "zls",
                "clangd"
            },
            automatic_installation = true,
        })
    end
}

