-- delete the packages that aren't used
local function pack_clean()
  local active_plugins = {}
  local unused_plugins = {}
  for _, plugin in ipairs(vim.pack.get()) do
    active_plugins[plugin.spec.name] = plugin.active
  end
  for _, plugin in ipairs(vim.pack.get()) do
    if not active_plugins[plugin.spec.name] then
      table.insert(unused_plugins, plugin.spec.name)
    end
  end
  if #unused_plugins == 0 then
    vim.notify("No unused plugins.", vim.log.levels.INFO)
    return
  end
  local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
  if choice == 1 then
    vim.pack.del(unused_plugins)
    vim.notify("plugins deleted successfully", vim.log.levels.INFO)
  end
end
vim.api.nvim_create_user_command("PackClean", pack_clean, {})

local ensure_installed = {
  -- LSPs
  "astro-language-server",
  "html-lsp",
  "lua-language-server",
  "tailwindcss-language-server",
  "tinymist",
  "tsgo",
  "basedpyright",
  "css-lsp",

  -- Formatters
  "stylua",
  "typstyle",
  "prettier",
  "ruff",
}
local function install_missing_lsp()
  local success, mason_registry = pcall(require, "mason-registry")
  if not success then
    vim.notify("mason-registry not found", vim.log.levels.ERROR)
    return
  end
  local function enable_lsp(p)
    if p.spec.neovim and p.spec.neovim.lspconfig then
      vim.lsp.enable(p.spec.neovim.lspconfig)
      return
    end
    if vim.tbl_contains(p.spec.categories, "LSP") then
      vim.notify("LSP " .. p.name .. " does not have neovim config skipping", vim.log.levels.INFO)
    end
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
vim.api.nvim_create_user_command("MasonInstallMissing", install_missing_lsp, {})
