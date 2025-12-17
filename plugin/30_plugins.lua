vim.pack.add({
  { src = "https://github.com/bluz71/vim-moonfly-colors" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/j-hui/fidget.nvim" },
})

vim.cmd([[colorscheme moonfly]])

require("fidget").setup({})

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

local ensure_installed = {
  -- LSPs
  "lua-language-server",
  "astro-language-server",
  "tinymist",

  -- formatters
  "stylua",
  "typstyle",
}

local function install_missing_lsp()
  local success, mason_registry = pcall(require, "mason-registry")
  if not success then
    vim.notify("mason-registry not found", vim.log.levels.ERROR)
    return
  end

  local function enable_lsp(p)
    -- print(p.spec)
    -- vim.print(p)
  end

  local installed = mason_registry.get_installed_package_names()
  for _, package_name in ipairs(ensure_installed) do
    local p = mason_registry.get_package(package_name)
    if not vim.tbl_contains(installed, package_name) and vim.fn.executable(package_name) ~= 1 then
      p:install():once("install:success", function()
        enable_lsp(p)
      end)
      vim.notify("Installing missing lsp: " .. package_name, vim.log.levels.INFO)
    else
      enable_lsp(p)
    end
  end
end

install_missing_lsp()

local languages = { "python", "javascript", "lua" }
require("nvim-treesitter").install(languages)

vim.api.nvim_create_autocmd("FileType", {
  pattern = languages,
  callback = function()
    -- syntax highlighting, provided by Neovim
    vim.treesitter.start()
    -- folds, provided by Neovim
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldmethod = "expr"
    -- indentation, provided by nvim-treesitter
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

-- LSP autocmds
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("my.lsp", {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    -- use foldexpr
    if client:supports_method("textDocument/foldingRange") then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
    end
  end,
})
