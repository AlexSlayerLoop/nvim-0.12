-- Highlight on yank
_G.Config.new_autocmd("TextYankPost", nil, function()
  vim.hl.on_yank()
end, "Highlight selection on yank")

-- Resize splits
_G.Config.new_autocmd("VimResized", nil, function()
  local current_tab = vim.fn.tabpagenr()
  vim.cmd("tabdo wincmd =")
  vim.cmd("tabnext " .. current_tab)
end, "Resize splits if window get resized")

-- Update Treesitter Parsers
_G.Config.new_autocmd("PackChanged", nil, function(event)
  local name, kind = event.data.spec.name, event.data.kind
  if (kind ~= "delete") and name == "nvim-treesitter" then
    local ok = pcall(vim.cmd, "TSUpdate")
    if not ok then
      vim.notify("TSUpdate failed!", vim.log.levels.WARN)
    else
      vim.notify("TSUpdate correctly executed!", vim.log.levels.INFO)
    end
  end
end, "Treesitter update parsers automatically")

-- Init Treesitter
_G.Config.new_autocmd("FileType", _G.Config.treesitter_supported_languages, function()
  -- syntax highlighting, provided by Neovim
  vim.treesitter.start()
  -- folds, provided by Neovim
  vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.wo.foldmethod = "expr"
  -- indentation, provided by nvim-treesitter
  vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end, "Enable Treesitter parsers for folding and indenting")

-- LSP Attach
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("my.lsp", {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    -- unset defaults
    -- vim.keymap.del("n", "grr", { buffer = args.buf })

    -- use foldexpr
    if client:supports_method("textDocument/foldingRange") then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldmethod = "expr"
      vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
    end

    if client:supports_method("textDocument/documentSymbol") then
      vim.keymap.set("n", "<leader>fS", "<cmd>Pick lsp scope='document_symbol'<cr>", { desc = "Symbols document" })
      vim.keymap.set("n", "<leader>fs", "<cmd>Pick lsp scope='workspace_symbol'<cr>", { desc = "Symbols workspace" })
    end

    if client:supports_method("textDocument/references") then
      vim.keymap.set("n", "<leader>fr", "<cmd>Pick lsp scope='references'<cr>", { desc = "Find references" })
    end

    -- inlay hints
    if client:supports_method("textDocument/inlayHint") then
      vim.keymap.set("n", "<leader>uh", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }))
      end, { desc = "[T]oggle Inlay [H]ints" })
    end
  end,
})
