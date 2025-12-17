vim.g.loaded_man = 1 -- deactivate plugin
vim.g.mapleader = " " -- Use `<Space>` as <Leader> key
vim.g.maplocalleader = " "

-- Tab / Indentation
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.smartindent = true

-- Search
vim.o.showmatch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- Appearance
vim.o.number = true
vim.o.relativenumber = true
vim.o.laststatus = 3
vim.o.termguicolors = true
vim.o.colorcolumn = "80"
vim.o.signcolumn = "yes"
vim.o.list = true
vim.o.inccommand = "split"
vim.o.cursorline = true
vim.o.winborder = "solid"
vim.o.breakindent = true
vim.o.listchars = "extends:…,nbsp:␣,precedes:…,tab:> "
vim.o.fillchars = "eob: ,fold:╌"
-- vim.opt.fillchars = {
--   foldopen = "",
--   foldclose = "",
--   fold = " ",
--   foldsep = " ",
--   diff = "╱",
--   eob = " ",
-- }

-- Behaviour
vim.o.formatoptions = "jcroqlnt"
-- vim.o.formatoptions = "tcqj" --default
-- vim.o.formatoptions = "rqnl1j"
vim.o.wrap = false
vim.o.confirm = true
vim.o.mouse = "a"
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.completeopt = "menu,menuone,noselect"
vim.o.pumheight = 12
vim.o.spelloptions = "camel"
vim.o.virtualedit = "block"
vim.o.shiftround = true

-- Folds
-- opt.foldmethod = "expr"
vim.o.foldlevel = 99 -- start with all folds open
vim.o.foldtext = ""

-- netrw
-- vim.g.netrw_banner = 0
-- vim.g.netrw_liststyle = 3
-- vim.g.netrw_browse_split = 4
-- vim.g.netrw_winsize = 35
-- vim.g.netrw_sort_by = "time"

vim.diagnostic.config({
  severity_sort = true,
  virtual_text = true,
})

vim.lsp.enable({ "lua_ls", "astro", "basedpyright", "tynimist" })

_G.Config = {}

local gr = vim.api.nvim_create_augroup("custom-config", {})
_G.Config.new_autocmd = function(event, pattern, callback, desc)
  local opts = { group = gr, pattern = pattern, callback = callback, desc = desc }
  vim.api.nvim_create_autocmd(event, opts)
end

-- highlight on yank
_G.Config.new_autocmd("TextYankPost", nil, function()
  vim.hl.on_yank()
end, "Highlight selection on yank")

-- Treesitter update parsers automatically
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(event)
    local name, kind = event.data.spec.name, event.data.kind

    if (kind == "update" or kind == "install") and name == "nvim-treesitter" then
      local ok = pcall(vim.cmd, "TSUpdate")
      if not ok then
        vim.notify("TSUpdate failed!", vim.log.levels.WARN)
      else
        vim.notify("TSUpdate correctly executed!", vim.log.levels.INFO)
      end
    end
  end,
})
