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

vim.diagnostic.config({
  severity_sort = true,
  virtual_text = true,
})

vim.lsp.enable({ "lua_ls", "astro", "tsgo", "basedpyright", "tinymist" })

_G.Config = {}

local gr = vim.api.nvim_create_augroup("custom-config", {})
_G.Config.new_autocmd = function(event, pattern, callback, desc)
  local opts = { group = gr, pattern = pattern, callback = callback, desc = desc }
  vim.api.nvim_create_autocmd(event, opts)
end

local group = vim.api.nvim_create_augroup("LazyPlugins", { clear = true })
---@param plugins (string|vim.pack.Spec)[]
_G.Config.lazy_load = function(plugins)
  vim.pack.add(plugins, {
    load = function(plugin)
      local data = plugin.spec.data or {}

      -- Event trigger
      if data.event then
        vim.api.nvim_create_autocmd(data.event, {
          group = group,
          once = true,
          pattern = data.pattern or "*",
          callback = function()
            vim.cmd.packadd(plugin.spec.name)
            if data.config then
              data.config(plugin)
            end
          end,
        })
      end

      -- Command trigger
      if data.cmd then
        vim.api.nvim_create_user_command(data.cmd, function(cmd_args)
          pcall(vim.api.nvim_del_user_command, data.cmd)
          vim.cmd.packadd(plugin.spec.name)
          if data.config then
            data.config(plugin)
          end
          vim.api.nvim_cmd({
            cmd = data.cmd,
            args = cmd_args.fargs,
            bang = cmd_args.bang,
            nargs = cmd_args.nargs,
            range = cmd_args.range ~= 0 and { cmd_args.line1, cmd_args.line2 } or nil,
            count = cmd_args.count ~= -1 and cmd_args.count or nil,
          }, {})
        end, {
          nargs = data.nargs,
          range = data.range,
          bang = data.bang,
          complete = data.complete,
          count = data.count,
        })
      end

      -- Keymap trigger
      if data.keys then
        local mode, lhs = data.keys[1], data.keys[2]
        vim.keymap.set(mode, lhs, function()
          vim.keymap.del(mode, lhs)
          vim.cmd.packadd(plugin.spec.name)
          if data.config then
            data.config(plugin)
          end
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(lhs, true, false, true), "m", false)
        end, { desc = data.desc })
      end
    end,
  })
end
