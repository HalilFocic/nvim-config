local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(_, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

-- to learn how to use mason.nvim
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'bashls',
    'cssls',
    'html',
    'jsonls',
    'tsserver',
    'vimls',
    'yamlls',
    'rust_analyzer',
    'eslint',
    'lua_ls',
    'jinja_lsp',
    'tailwindcss',
    'jinja_lsp'
  },
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  },
})

require('lspconfig').lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = {'vim'},
      },
    },
  },
})

vim.cmd("Copilot disable")
