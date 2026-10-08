---@type vim.lsp.Config
return {
  cmd = { "astro-ls", "--stdio" },
  filetypes = { "astro" },
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
  init_options = {
    typescript = {
      -- tsdk = vim.fn.expand "~/.local/share/nvim/mason/packages/astro-language-server/node_modules/typescript/lib",
      tsdk = vim.fn.expand "~/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib",
    },
  },
}
