vim.pack.add({
  { src = "https://github.com/bluz71/vim-moonfly-colors" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/j-hui/fidget.nvim" },
  { src = "https://github.com/chomosuke/typst-preview.nvim", version = vim.version.range("1.*") },
})

require("typst-preview").setup({
  dependencies_bin = {
    ["tinymist"] = "tinymist",
  },
})

vim.cmd([[colorscheme moonfly]])

require("fidget").setup({})

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    markdown = { "prettier" },
    json = { "prettier" },
    html = { "prettier" },
    jsonc = { "prettier" },
    python = { "ruff_format" },
    typst = { "typstyle" },
    -- astro = {},
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})

_G.Config.treesitter_supported_languages = {
  "python",
  "javascript",
  "typescript",
  "lua",
  "typst",
  "html",
  "css",
  "zsh",
  "bash",
  "jsdoc",
  "tsx",
  "jsx",
  "json",
  "sql",
  "dockerfile",
  "yaml",
  "csv",
  "markdown",
  "svelte",
  "astro",
}
require("nvim-treesitter").install(_G.Config.treesitter_supported_languages)

-- vim.keymap.set({ "x", "o" }, "af", function()
--   require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
-- end)
-- vim.keymap.set({ "x", "o" }, "if", function()
--   require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
-- end)

-- vim.keymap.set({ "x", "o" }, "ac", function()
--   require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
-- end)
-- vim.keymap.set({ "x", "o" }, "ic", function()
--   require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
-- end)

-- You can also use captures from other query groups like `locals.scm`
vim.keymap.set({ "x", "o", "n" }, "<CR>", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
end)
