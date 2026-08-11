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
-- vim.o.guicursor =
--   "n-v-c-sm:block,i-ci-ve:block-blinkon300-blinkoff150,r-cr-o:hor20,t:block-blinkon500-blinkoff500-TermCursor"
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
vim.o.formatoptions = "jcroqlnt" -- TODO: defined this
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
vim.o.undofile = true

-- Folds
-- opt.foldmethod = "expr" -- set a default fold method like indent of manual
vim.o.foldlevel = 99 -- start with all folds open
vim.o.foldtext = "" -- TODO: finish the styling of folds
-- vim.o.foldcolumn = "1"

-- netrw
-- vim.g.netrw_banner = 0
-- vim.g.netrw_liststyle = 3
-- vim.g.netrw_browse_split = 4
-- vim.g.netrw_winsize = 35
-- vim.g.netrw_sort_by = "time"
