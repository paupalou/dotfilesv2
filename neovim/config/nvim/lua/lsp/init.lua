--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=#1f2335]]
-- vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

local border = {
  {"╭", "FloatBorder"}, {"─", "FloatBorder"},
  {"╮", "FloatBorder"}, {"│", "FloatBorder"},
  {"╯", "FloatBorder"}, {"─", "FloatBorder"},
  {"╰", "FloatBorder"}, {"│", "FloatBorder"}
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    underline = true,
    signs = true,
    update_in_insert = false
  }
)
vim.lsp.handlers["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border})
vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]

require 'null-ls'.config {}
require 'lspconfig'["null-ls"].setup {}

-- typescript and javascript
require 'lspconfig'.tsserver.setup {
  capabilities = capabilities,
  on_attach = function (client, _)
    -- disable tsserver formatting if you plan on formatting via null-ls
    client.resolved_capabilities.document_formatting = false
    local ts_utils = require('nvim-lsp-ts-utils')
    ts_utils.setup {
      enable_formatting = true,
      formatter = "prettier"
    }
    -- required to enable ESLint code actions and formatting
    ts_utils.setup_client(client)
  end
}

-- HTML
require 'lspconfig'.html.setup {
  capabilities = capabilities
}

-- deno
-- require 'lspconfig'.denols.setup {
--   init_options = { enable = false },
--   capabilities = capabilities
-- }

-- rust
require 'lspconfig'.rust_analyzer.setup {
  capabilities = capabilities
}

-- bash
require 'lspconfig'.bashls.setup {
  capabilities = capabilities
}

-- dockerfile
require 'lspconfig'.dockerls.setup {
  capabilities = capabilities
}

-- godot script
require 'lspconfig'.gdscript.setup {
  capabilities = capabilities
}

-- json
require 'lspconfig'.jsonls.setup {
  capabilities = capabilities
}

-- graphql
require 'lspconfig'.graphql.setup {
  capabilities = capabilities
}

-- vim
require 'lspconfig'.vimls.setup {
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

require 'lspkind'.init({})
require 'lsp-colors'.setup {}
require 'trouble'.setup {}
require 'lspsaga'.init_lsp_saga {
  use_saga_diagnostic_sign = false,
  finder_definition_icon = ' ',
  finder_reference_icon = ' ',
  rename_prompt_prefix = '',
}
require 'lsp.bindings'
