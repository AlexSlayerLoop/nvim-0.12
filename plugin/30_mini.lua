-- Mini ecosistem
local now, now_if_args, later = Config.now, Config.now_if_args, Config.later

-- Editor --
-- mini.ai
later(function()
  local ai = require "mini.ai"
  ai.setup {
    custom_textobjects = {
      F = ai.gen_spec.treesitter { a = "@function.outer", i = "@function.inner" },
    },
  }

  local f = function(args)
    vim.b[args.buf].miniai_disable = true
  end
  vim.api.nvim_create_autocmd("FileType", { pattern = "fugitive", callback = f })
end)

-- mini.completion
now_if_args(function()
  local process_items_opts = { kind_priority = { Text = -1, Snippet = 99 } }
  local process_items = function(items, base)
    return MiniCompletion.default_process_items(items, base, process_items_opts)
  end

  require("mini.completion").setup {
    lsp_completion = {
      -- Without this config autocompletion is set up through `:h 'completefunc'`.
      -- Although not needed, setting up through `:h 'omnifunc'` is cleaner
      -- (sets up only when needed) and makes it possible to use `<C-u>`.
      source_func = "omnifunc",
      auto_setup = false,
      process_items = process_items,
    },
  }

  -- Set 'omnifunc' for LSP completion only when needed.
  local on_attach = function(ev)
    vim.bo[ev.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
  end
  Config.new_autocmd("LspAttach", nil, on_attach, "Set 'omnifunc'")

  -- Advertise to servers that Neovim now supports certain set of completion and
  -- signature features through 'mini.completion'.
  vim.lsp.config("*", { capabilities = MiniCompletion.get_lsp_capabilities() })
end)
-- mini.surround
later(function()
  require("mini.surround").setup()

  local f = function(args)
    vim.b[args.buf].minisurround_disable = true
  end
  vim.api.nvim_create_autocmd("FileType", { pattern = "fugitive", callback = f })
end)

-- mini.pairs
later(function()
  require("mini.pairs").setup { modes = { command = true } }
end)

-- Appearence --
-- mini.icons
now(function()
  require("mini.icons").setup()

  -- Mock 'nvim-tree/nvim-web-devicons' for plugins without 'mini.icons' support.
  -- Not needed for 'mini.nvim' or MiniMax, but might be useful for others.
  later(MiniIcons.mock_nvim_web_devicons)

  -- Add LSP kind icons. Useful for 'mini.completion'.
  later(MiniIcons.tweak_lsp_kind)
end)
-- mini.indentscope
later(function()
  require("mini.indentscope").setup { symbol = "│" }
end)

-- Workflow --
-- mini.pick
later(function()
  require("mini.pick").setup()
end)
-- mini.extra
later(function()
  require("mini.extra").setup()
end)
-- mini.files
now_if_args(function()
  require("mini.files").setup { options = { permanent_delete = false } }

  local add_marks = function()
    MiniFiles.set_bookmark("c", vim.fn.stdpath "config", { desc = "Config" })
    local vimpack_plugins = vim.fn.stdpath "data" .. "/site/pack/core/opt"
    MiniFiles.set_bookmark("p", vimpack_plugins, { desc = "Plugins" })
    MiniFiles.set_bookmark("w", vim.fn.getcwd, { desc = "Working directory" })
  end

  local set_cwd = function()
    local path = (MiniFiles.get_fs_entry() or {}).path
    if path == nil then
      return vim.notify "Cursor is not on valid entry"
    end
    vim.fn.chdir(vim.fs.dirname(path))
  end

  local set_cwd_mapping = function(args)
    local b = args.data.buf_id
    vim.keymap.set("n", "g~", set_cwd, { buffer = b, desc = "Set cwd" })
  end

  Config.new_autocmd("User", "MiniFilesExplorerOpen", add_marks, "Add bookmarks")
  Config.new_autocmd("User", "MiniFilesBufferCreate", set_cwd_mapping, "Set cwd in files")
end)
-- mini.diff
later(function()
  require("mini.diff").setup { view = { style = "sign" } }
end)
-- mini.clue
later(function()
  local miniclue = require "mini.clue"
  miniclue.setup {
    triggers = {
      { mode = { "n", "x" }, keys = "<Leader>" }, -- Leader triggers
      { mode = "n", keys = "[" }, -- `[` and `]` keys
      { mode = "n", keys = "]" },
      { mode = "i", keys = "<C-x>" }, -- Built-in completion
      { mode = { "n", "x" }, keys = "g" }, -- `g` key
      { mode = { "n", "x" }, keys = "'" }, -- Marks
      { mode = { "n", "x" }, keys = "`" },
      { mode = { "n", "x" }, keys = '"' }, -- Registers
      { mode = { "i", "c" }, keys = "<C-r>" },
      { mode = "n", keys = "<C-w>" }, -- Window commands
      { mode = { "n", "x" }, keys = "z" }, -- `z` key
      { mode = { "n", "x" }, keys = "s" }, -- `s` key (mini.surround, etc.)
    },
    clues = {
      _G.Config.leader_group_clues,
      miniclue.gen_clues.square_brackets(),
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.windows {
        submode_move = true,
        submode_navigate = true,
        submode_resize = true,
      },
      miniclue.gen_clues.z(),
    },
  }
end)

-- require("mini.align")
-- require("mini.comment")
-- require("mini.keymap")
-- require("mini.move")
-- require("mini.operators")
-- require("mini.snippets")
-- require("mini.splitjoin")

-- require("mini.starter")
-- require("mini.animate")
-- require("mini.base16")
-- require("mini.colors")
-- require("mini.cursorword")
-- require("mini.hipatterns")
-- require("mini.hues")
-- require("mini.map")
-- require("mini.notify")
-- require("mini.tabline")
-- require "mini.trailspace"

-- require("mini.basics")
-- require("mini.bracketed")
-- require("mini.bufremove")
-- require("mini.cmdline")
-- require("mini.deps")
-- require("mini.git")
-- require("mini.jump")
-- require("mini.jump2d")
-- require("mini.misc")
-- require("mini.sessions")
-- require("mini.visits")

-- require("mini.doc")
-- require("mini.fuzzy")
-- require("mini.test")
