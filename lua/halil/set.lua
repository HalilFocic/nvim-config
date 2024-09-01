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

--vim.api.nvim_create_autocmd("FileType", {
--    pattern = { "html", "css", "javascript", "typescript", "typescriptreact", "javascriptreact" },
--    callback = function()
--        vim.bo.shiftwidth = 2
--        vim.bo.tabstop = 2
--        vim.bo.expandtab = true
--    end
--})
