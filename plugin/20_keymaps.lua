-- This is used to provide 'mini.clue' with extra clues.

-- Add an entry if you create a new group.
_G.Config.leader_group_clues = {
  { mode = "n", keys = "<Leader>b", desc = "+Buffer" },
  { mode = "n", keys = "<Leader>e", desc = "+Explore/Edit" },
  { mode = "n", keys = "<Leader>f", desc = "+Find" },
  { mode = "n", keys = "<Leader>g", desc = "+Git" },
  -- { mode = 'n', keys = '<Leader>l', desc = '+Language' },
  -- { mode = "n", keys = "<Leader>o", desc = "+Other" },
  { mode = "n", keys = "<Leader>u", desc = "+Toggle" },
  { mode = "n", keys = "<Leader>p", desc = "+Pack" },

  -- { mode = "x", keys = "<Leader>g", desc = "+Git" },
  -- { mode = "x", keys = "<Leader>l", desc = "+Language" },
}

-- Highlight
vim.keymap.set("n", "<C-[>", "<cmd>nohlsearch<cr><esc>", { desc = "nohlsearch + ESC" })
vim.keymap.set(
  "n",
  "<leader>e",
  "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>",
  { desc = "Explore Files" }
)

-- MiniPick
vim.keymap.set("n", "<leader>,", "<cmd>Pick buffers<cr>", { desc = "pick buffers" })
vim.keymap.set("n", "<leader>fe", "<cmd>Pick explorer<cr>", { desc = "pick explorer" })
vim.keymap.set("n", "<leader>ff", "<cmd>Pick files<cr>", { desc = "pick files" })
vim.keymap.set("n", "<leader>fh", "<cmd>Pick help<cr>", { desc = "pick help tags" })
vim.keymap.set("n", "<leader>fg", "<cmd>Pick grep_live<cr>", { desc = "pick grep_live" })
vim.keymap.set("n", "<leader>/", "<cmd>Pick buf_lines scope='current'<cr>", { desc = "pick buf lines" })
vim.keymap.set("n", "<leader>fo", "<cmd>Pick oldfiles<cr>", { desc = "pick oldfiles" })
vim.keymap.set("n", "<leader>fn", function()
  require("mini.pick").builtin.files { path = vim.fn.stdpath "config" }
end, { desc = "pick config" })
-- vim.keymap.set("n", "<leader>fd", function()
--   require("mini.pick").builtin.files { path = vim.fn.stdpath "data" .. "site/pack/core/opt" }
-- end, { desc = "pick data" })

-- Git status
vim.keymap.set("n", "<leader>gt", "<cmd>Pick git_files<cr>", { desc = "git tracked" })
vim.keymap.set("n", "<leader>gu", "<cmd>Pick git_files scope='untracked'<cr>", { desc = "git untracked" })
vim.keymap.set("n", "<leader>gd", "<cmd>Pick git_files scope='deleted'<cr>", { desc = "git deleted" })
vim.keymap.set("n", "<leader>gm", "<cmd>Pick git_files scope='modified'<cr>", { desc = "git modified" })

-- Buffers
vim.keymap.set("n", "<leader>bd", "<cmd>bd<CR>", { desc = "buffer delete" })
vim.keymap.set("n", "<leader>l", "<cmd>e #<cr>", { desc = "[L]ast buffer" })
vim.keymap.set("n", "<leader>bo", function()
  vim.cmd [[
  1,.-bdelete
  .+,$bdelete
  ]]
end, { desc = "Close other buffers", silent = true })

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

-- Diagnostics
vim.keymap.set("n", "<leader>ud", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "[T]oggle [D]iagnostics" })

-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- Increment/Decrement
vim.keymap.set("n", "+", "<C-a>")
vim.keymap.set("n", "-", "<C-x>")

-- Indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Toggleling
vim.keymap.set("n", "<leader>up", function()
  vim.g.minipairs_disable = not vim.g.minipairs_disable
end, { desc = "toggle minipairs" })
vim.keymap.set("n", "<leader>ud", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "[T]oggle [D]iagnostics" })

-- Pack Helpers
vim.keymap.set("n", "<Leader>pc", "<cmd>PackClean<cr>", { desc = "Pack clean" })
vim.keymap.set("n", "<Leader>pm", "<cmd>MasonInstallMissing<cr>", { desc = "Pack Mason" })
vim.keymap.set("n", "<Leader>pu", "<cmd>lua vim.pack.update()<cr>", { desc = "Pack Upadte" })

-- Markdown
vim.keymap.set("n", "<leader>mps", "<cmd>MarkdownPreview<cr>", { desc = "Markdown: Start preview" })
vim.keymap.set("n", "<leader>mpS", "<cmd>MarkdownPreviewStop<cr>", { desc = "Markdown: Stop preview" })
vim.keymap.set("n", "<leader>mpr", "<cmd>MarkdownPreviewRefresh<cr>", { desc = "Markdown: Refresh preview" })
