vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- window management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })     -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })   -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })      -- make split windows equal width & height
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

--vim.keymap.set("n","<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")


vim.keymap.set("n", "<leader>ce", "<cmd>Copilot enable<CR>", { desc = "Enable Copilot" })
vim.keymap.set("n", "<leader>cd", "<cmd>Copilot disable<CR>", { desc = "Disable Copilot" })

vim.keymap.set("n", "<F3>", vim.lsp.buf.format, { silent = true })
vim.keymap.set("v", "<F3>", vim.lsp.buf.format, { silent = true })

-- Remaps for changing current word with new one globally
vim.keymap.set('n', '<leader>r', ':%s/\\<<C-r><C-w>\\>//g<left><left>', { noremap = true })
vim.keymap.set('v', '<leader>r', 'y:%s/<C-r>"//g<left><left>', { noremap = true })

    -- Map Ctrl+{ to go to next quickfix entry
vim.keymap.set('n', '<C-{>', ':cnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-}>', ':cprev<CR>', { noremap = true, silent = true })


