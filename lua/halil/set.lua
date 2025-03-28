vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 5
vim.opt.signcolumn = "yes"

vim.opt.termguicolors = true

vim.opt.updatetime = 50
vim.g.mapleader = " "


-- JavaScript-specific settings via autocmd
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"javascript", "javascriptreact", "typescript", "typescriptreact", "json"},
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})
