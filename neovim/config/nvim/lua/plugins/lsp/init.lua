-- typescript and javascript
require 'lspconfig'.tsserver.setup{}
-- deno
require 'lspconfig'.denols.setup{}
-- rust
require 'lspconfig'.rls.setup{}

-- icons
vim.fn.sign_define("LspDiagnosticsSignError",
    {text = ""})
vim.fn.sign_define("LspDiagnosticsSignWarning",
    {text = ""})
vim.fn.sign_define("LspDiagnosticsSignInformation",
    {text = ""})
vim.fn.sign_define("LspDiagnosticsSignHint",
    {text = ""})
