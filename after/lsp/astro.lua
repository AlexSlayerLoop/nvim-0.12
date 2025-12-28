---@type vim.lsp.Config
return {
  init_options = {
    typescript = {
      tsdk = vim.fn.expand("~/.local/share/nvim-0.12/mason/packages/astro-language-server/node_modules/typescript/lib"),
    },
  },
}
