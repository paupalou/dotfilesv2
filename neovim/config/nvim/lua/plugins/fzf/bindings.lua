local MAPPER = require 'utils'

MAPPER.nnoremap('<leader>f', '<cmd> :Files<CR>')
MAPPER.nnoremap('<leader>b', '<cmd> :Buffers<CR>')
MAPPER.nnoremap('<leader>;', '<cmd> :BLines<CR>')
MAPPER.nnoremap('<leader>.', '<cmd> :Lines<CR>')
MAPPER.nnoremap('<leader>:', '<cmd> :Commands<CR>')
MAPPER.nnoremap('<leader>?', '<cmd> :History<CR>')
MAPPER.nnoremap('<leader>/', '<cmd> :History/<CR>')
MAPPER.nnoremap('<leader>u', '<cmd> :Snippets<CR>')

MAPPER.imap('<C-x><C-f>', '<plug>(fzf-complete-file-ag)')
MAPPER.imap('<C-x><C-l>', '<plug>(fzf-complete-line)')
