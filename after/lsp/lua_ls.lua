return {
  settings = {
    Lua = {
      -- Define runtime properties. Use 'LuaJIT', as it is built into Neovim.
      -- runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
      runtime = { version = "LuaJIT" },
      workspace = {
        -- Don't analyze code from submodules
        ignoreSubmodules = true,
        -- Add Neovim's methods for easier code writing
        library = { vim.env.VIMRUNTIME, "${3rd}/luv/library" },
      },
    },
  },
}
