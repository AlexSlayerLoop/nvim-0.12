--wildcharm vim.cmd [[colorscheme catppuccin]]

_G.Config = {}

vim.diagnostic.config {
  severity_sort = true,
  virtual_text = true,
}

-- deactivate plugins
vim.g.loaded_man = 1

-- activate plugins
vim.cmd.packadd "nvim.undotree"
-- vim.cmd.packadd "nvim.difftool"
-- vim.cmd.packadd "cfilter"

-- experimental command-line features
require("vim._core.ui2").enable {}

vim.pack.add { "https://github.com/nvim-mini/mini.nvim" }


local misc = require "mini.misc"
Config.now = function(f) misc.safely("now", f) end
Config.later = function(f) misc.safely("later", f) end
Config.now_if_args = vim.fn.argc(-1) > 0 and Config.now or Config.later
Config.on_event = function(ev, f) misc.safely("event:" .. ev, f) end
Config.on_filetype = function(ft, f) misc.safely("filetype:" .. ft, f) end

local gr = vim.api.nvim_create_augroup("custom-config", {})
Config.new_autocmd = function(event, pattern, callback, desc)
  local opts = { group = gr, pattern = pattern, callback = callback, desc = desc }
  vim.api.nvim_create_autocmd(event, opts)
end
