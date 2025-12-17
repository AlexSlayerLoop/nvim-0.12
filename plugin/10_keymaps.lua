vim.keymap.set("n", "<C-[>", "<cmd>nohlsearch<cr><esc>", { desc = "nohlsearch + ESC" })
vim.keymap.set("n", "<leader>e", "<cmd>lua MiniFiles.open()<cr>", { desc = "Explore Files" })

-- mini.pick
vim.keymap.set("n", "<leader>,", "<cmd>Pick buffers<cr>", { desc = "pick buffers" })
vim.keymap.set("n", "<leader>ff", "<cmd>Pick files<cr>", { desc = "pick files" })
vim.keymap.set("n", "<leader>fh", "<cmd>Pick help<cr>", { desc = "pick help tags" })
vim.keymap.set("n", "<leader>fr", "<cmd>Pick grep_live<cr>", { desc = "pick grep_live" })

-- buffers
vim.keymap.set("n", "<leader>bd", "<cmd>bd<CR>", { desc = "buffer delete" })
vim.keymap.set("n", "<leader>bq", "<cmd>CloseOtherBuffers<CR>", { desc = "Close other buffers except the current one" })
vim.keymap.set("n", "<leader>l", "<cmd>e #<cr>", { desc = "[L]ast buffer" })

-- Pane Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h") -- Navigation Left
vim.keymap.set("n", "<C-j>", "<C-w>j") -- Navigation Down
vim.keymap.set("n", "<C-k>", "<C-w>k") -- Navigation Up
vim.keymap.set("n", "<C-l>", "<C-w>l") -- Navigation Right

-- Resize window using
vim.keymap.set("n", "<Left>", "<cmd>vertical resize -5<CR>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<Right>", "<cmd>vertical resize +5<CR>", { desc = "Increase Window Width" })
vim.keymap.set("n", "<Up>", "<cmd>resize +5<CR>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<Down>", "<cmd>resize -5<CR>", { desc = "Decrease Window Height" })
