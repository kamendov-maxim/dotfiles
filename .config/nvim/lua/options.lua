local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap('i', 'jk', '<Esc>', opts)

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.expandtab = true
vim.opt.tabstop=4
vim.opt.softtabstop=4
vim.opt.shiftwidth=4
vim.opt.number = true
vim.opt.relativenumber = true 
vim.opt.signcolumn = "yes"

vim.g.mapleader = " "
vim.opt.cursorline = true
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>')

keymap("n", "=", [[<cmd>vertical resize +5<cr>]], opts) -- make the window biger vertically
keymap("n", "-", [[<cmd>vertical resize -5<cr>]], opts) -- make the window smaller vertically
keymap("n", "+", [[<cmd>horizontal resize +2<cr>]], opts) -- make the window bigger horizontally by pressing shift and =
keymap("n", "_", [[<cmd>horizontal resize -2<cr>]], opts) -- make the window smaller horizontally by pressing shift and -

keymap("n", "<C-n>", ":tabnew<cr>", opts)
keymap("n", "L", ":tabn<cr>", opts)
keymap("n", "H", ":tabp<cr>", opts)
keymap("n", "<leader>x", ":tabc<cr>", opts)
keymap("n", "<C-e>", ":Lex<cr>", opts)

-- vim.opt.termguicolors = true

keymap("n", "<leader>5", ":vsplit<cr>")
keymap("n", "<leader>'", ":split<cr>")
keymap("n", "<leader>q", ":q<cr>")
keymap("n", "<leader>w", ":w<cr>")

vim.opt.splitright = true
vim.opt.splitbelow = true

keymap("x", "p", [["_dP]])

vim.api.nvim_set_keymap("t", "jk", "<C-\\><C-n>", opts)

vim.g.netrw_banner = 0
