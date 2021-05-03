vim.cmd('syntax on')
vim.cmd('colorscheme OceanicNext')

vim.o.termguicolors = true
vim.o.background = 'dark'

local M = {
  base00 = "#1b2b34",
  base01 = "#343d46",
  base02 = "#4f5b66",
  base03 = "#65737e",
  base04 = "#a7adba",
  base05 = "#c0c5ce",
  base06 = "#cdd3de",
  base07 = "#d8dee9",
  red = "#ec5f67",
  orange = "#f99157",
  yellow = "#fac863",
  green = "#99c794",
  cyan = "#62b3b2",
  blue = "#6699cc",
  purple = "#c594c5",
  brown = "#ab7967",
  white = "#ffffff"
}

-- comments in italic
vim.cmd("hi Comment gui=italic")
-- sign colors
vim.cmd("hi SignatureMarkText guifg=#0083ba")
-- lsp colors
vim.cmd("hi LspDiagnosticsDefaultError guifg=#F45D4C")
vim.cmd("hi LspDiagnosticsUnderlineError guifg=#F45D4C gui=undercurl")

vim.cmd("hi LspDiagnosticsDefaultWarning guifg=#F7A541")
vim.cmd("hi LspDiagnosticsUnderlineWarning guifg=#F7A541 gui=undercurl")

vim.cmd("hi LspDiagnosticsDefaultInformation guifg=#A1DBB2")
vim.cmd("hi LspDiagnosticsUnderfInformation guifg=#A1DBB2 gui=undercurl")

vim.cmd("hi LspDiagnosticsDefaultHint guifg=#FEE5AD")
vim.cmd("hi LspDiagnosticsUnderlineHint guifg=#FEE5AD gui=undercurl")

return M
