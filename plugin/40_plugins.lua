-- vim.pack.add {
--   { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
--   { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
--   { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
--   { src = "https://github.com/neovim/nvim-lspconfig" },
--   { src = "https://github.com/mason-org/mason.nvim" },
--   { src = "https://github.com/stevearc/conform.nvim" },
--   { src = "https://github.com/chomosuke/typst-preview.nvim", version = vim.version.range "1.*" },
--   { src = "https://github.com/zbirenbaum/copilot.lua" },
--   { src = "https://github.com/mfussenegger/nvim-jdtls" },
-- }

local add = vim.pack.add
local now, now_if_args, later, on_event, on_filetype =
  Config.now, Config.now_if_args, Config.later, Config.on_event, Config.on_filetype

now(function()
  add { "https://github.com/bluz71/vim-moonfly-colors" }
  add { "https://github.com/craftzdog/solarized-osaka.nvim" }
  add { "https://github.com/vague-theme/vague.nvim" }
  add { "https://github.com/sainnhe/gruvbox-material" }
  add { "https://github.com/jpwol/thorn.nvim" }
  add { "https://github.com/sainnhe/everforest" }
  vim.cmd [[colorscheme solarized-osaka-vivid]]
end)

now_if_args(function()
  add {
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
  }

  local languages = {
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
    "java",
    "sql",
    "dockerfile",
    "yaml",
    "csv",
    "markdown",
    "php",
    "svelte",
    "astro",
    "go",
    "gomod",
    "gowork",
    "gosum",
  }
  local isnt_installed = function(lang)
    return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) == 0
  end
  local to_install = vim.tbl_filter(isnt_installed, languages)
  if #to_install > 0 then
    require("nvim-treesitter").install(to_install)
  end

  -- Enable tree-sitter after opening a file for a target language
  local filetypes = {}
  for _, lang in ipairs(languages) do
    for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
      table.insert(filetypes, ft)
    end
  end
  local ts_start = function(ev)
    vim.treesitter.start(ev.buf)
  end
  Config.new_autocmd("FileType", filetypes, ts_start, "Start tree-sitter")
end)

now_if_args(function()
  add { "https://github.com/neovim/nvim-lspconfig" }

  vim.lsp.enable {
    "lua_ls",
    "astro",
    "tsc",
    "basedpyright",
    "tinymist",
    "cssls",
    "tailwindcss",
    "gopls",
    "phpantom_lsp",
    "marksman",
    "jdtls",
  }
end)

now_if_args(function()
  add { "https://github.com/mason-org/mason.nvim" }
  require("mason").setup {
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  }
end)

later(function()
  add { "https://github.com/zbirenbaum/copilot.lua" }
  require("copilot").setup {
    suggestion = { auto_trigger = true },
  }
end)

later(function()
  add { "https://github.com/tpope/vim-fugitive" }
  add { "https://github.com/tpope/vim-dadbod" }
  add { "https://github.com/kristijanhusak/vim-dadbod-ui" }
end)

on_filetype("java", function()
  add { { src = "https://github.com/mfussenegger/nvim-jdtls" } }
end)

on_filetype("csv", function()
  add { { src = "https://github.com/hat0uma/csvview.nvim" } }
  require("csvview").setup {
    view = {
      display_mode = "border",
    },
  }
end)

on_filetype("typst", function()
  add { { src = "https://github.com/chomosuke/typst-preview.nvim", version = vim.version.range "1.*" } }
  require("typst-preview").setup {
    dependencies_bin = {
      ["tinymist"] = "tinymist",
    },
    extra_args = { "--verbose" },
  }
end)

on_filetype("markdown", function()
  add {
    { src = "https://github.com/selimacerbas/live-server.nvim" },
    { src = "https://github.com/selimacerbas/markdown-preview.nvim" },
  }
  require("markdown_preview").setup {
    -- all optional; sane defaults shown
    instance_mode = "takeover", -- "takeover" (one tab) or "multi" (tab per instance)
    port = 0, -- 0 = auto (8421 for takeover, OS-assigned for multi)
    open_browser = true,
    default_theme = "light", -- "dark" or "light"; initial preview theme
    debounce_ms = 300,
  }
end)

on_event("BufWritePre", function()
  add { "https://github.com/stevearc/conform.nvim" }
  require("conform").setup {
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
      astro = { "prettier" },
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  }
end)

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
-- vim.keymap.set({ "x", "o", "n" }, "<CR>", function()
--   require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
-- end)
