--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- typescript and javascript
require 'lspconfig'.tsserver.setup{
  capabilities = capabilities
}

-- HTML
require 'lspconfig'.html.setup {
  capabilities = capabilities
}

-- deno
require 'lspconfig'.denols.setup {
  init_options = { enable = false },
  capabilities = capabilities
}

-- rust
require 'lspconfig'.rls.setup{
  capabilities = capabilities
}

-- bash
require 'lspconfig'.bashls.setup{
  capabilities = capabilities
}

-- dockerfile
require 'lspconfig'.dockerls.setup{
  capabilities = capabilities
}

-- godot script
require 'lspconfig'.gdscript.setup{
  capabilities = capabilities
}

-- json
require 'lspconfig'.jsonls.setup{
  capabilities = capabilities
}

-- graphql
require 'lspconfig'.graphql.setup{
  capabilities = capabilities
}

-- vim
require 'lspconfig'.vimls.setup{
  capabilities = capabilities
}

-- lua
local sumneko_root_path = vim.fn.expand('$HOME/code/external/lua-language-server')
local sumneko_binary = sumneko_root_path.."/bin/Linux/lua-language-server"

require 'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
}

vim.fn.sign_define("LspDiagnosticsSignError", {text = ""})
vim.fn.sign_define("LspDiagnosticsSignWarning", {text = ""})
vim.fn.sign_define("LspDiagnosticsSignInformation", {text = ""})
vim.fn.sign_define("LspDiagnosticsSignHint", {text = ""})
