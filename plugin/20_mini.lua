-- Mini ecosistem
vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

-- Editing
local ai = require("mini.ai")
ai.setup({
  custom_textobjects = {
    F = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
  },
})
require("mini.completion").setup() -- Read docs next
require("mini.surround").setup()
require("mini.pairs").setup()
-- require("mini.align")
-- require("mini.comment")
-- require("mini.keymap")
-- require("mini.move")
-- require("mini.operators")
-- require("mini.snippets")
-- require("mini.splitjoin")

-- Appearence
require("mini.icons").setup()
require("mini.starter").setup()
require("mini.indentscope").setup({ symbol = "│" })
-- require("mini.animate")
-- require("mini.base16")
-- require("mini.colors")
-- require("mini.cursorword")
-- require("mini.hipatterns")
-- require("mini.hues")
-- require("mini.map")
-- require("mini.notify")
-- require("mini.tabline")
-- require("mini.trailspace")

-- Workflow
require("mini.pick").setup()
require("mini.extra").setup()
require("mini.files").setup()
require("mini.diff").setup({ view = { style = "sign" } })
local miniclue = require("mini.clue")
miniclue.setup({
  triggers = {
    { mode = "n", keys = "<Leader>" },
    { mode = "x", keys = "<Leader>" },

    -- `[` and `]` keys
    { mode = "n", keys = "[" },
    { mode = "n", keys = "]" },

    -- Built-in completion
    { mode = "i", keys = "<C-x>" },

    -- `g` key
    { mode = "n", keys = "g" },
    { mode = "x", keys = "g" },

    -- Marks
    { mode = "n", keys = "'" },
    { mode = "n", keys = "`" },
    { mode = "x", keys = "'" },
    { mode = "x", keys = "`" },

    -- Registers
    { mode = "n", keys = '"' },
    { mode = "x", keys = '"' },
    { mode = "i", keys = "<C-r>" },
    { mode = "c", keys = "<C-r>" },

    -- Window commands
    { mode = "n", keys = "<C-w>" },

    -- `z` key
    { mode = "n", keys = "z" },
    { mode = "x", keys = "z" },
  },

  clues = {
    _G.Config.leader_group_clues,
    miniclue.gen_clues.square_brackets(),
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows({
      submode_move = true,
      submode_navigate = true,
      submode_resize = true,
    }),
    miniclue.gen_clues.z(),
  },
})
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

-- Other
-- require("mini.doc")
-- require("mini.fuzzy")
-- require("mini.test")
