require("halil.set")
require("halil.remap")
require('tokyonight').load()
require('autoclose').setup()
require('todo-comments').setup()
-- Todo-comments shortcut commands 
vim.api.nvim_create_user_command('Todo', function()
  vim.cmd("TodoTelescope keywords=TODO") end,{})

vim.api.nvim_create_user_command('Fix', function()
  vim.cmd("TodoTelescope keywords=FIXME,FIX") end,{})

vim.api.nvim_create_user_command('Notes', function()
  vim.cmd("TodoTelescope keywords=NOTE") end,{})
vim.api.nvim_create_user_command('Warnings', function()
  vim.cmd("TodoTelescope keywords=WARN") end,{})


-- Execute ':Copilot disable' command when starting 

