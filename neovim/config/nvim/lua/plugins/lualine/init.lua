local lualine = require('lualine')
lualine.options.theme = 'oceanicnext'
lualine.sections.lualine_x = { 'filetype' }
lualine.extensions = { 'fzf' }
lualine.status()
