local MAPPER = require 'utils'

MAPPER.nnoremap('<leader>ca', '<cmd> :Lspsaga code_action<CR>')
MAPPER.vnoremap('<leader>ca', '<cmd> :<C-U>Lspsaga range_code_action<CR>')
MAPPER.nnoremap('<leader>cd', '<cmd> :Lspsaga show_line_diagnostics<CR>')
MAPPER.nnoremap('[e', '<cmd> :Lspsaga diagnostic_jump_prev<CR>')
MAPPER.nnoremap(']e', '<cmd> :Lspsaga diagnostic_jump_next<CR>')

MAPPER.nnoremap('K', '<cmd> :Lspsaga hover_doc<CR>')

MAPPER.nnoremap('<C-f>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>")
MAPPER.nnoremap('<C-b>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>")

MAPPER.nnoremap('gh', '<cmd> :Lspsaga lsp_finder<CR>')
MAPPER.nnoremap('gs', '<cmd> :Lspsaga signature_help<CR>')
MAPPER.nnoremap('gr', '<cmd> :Lspsaga rename<CR>')
MAPPER.nnoremap('gd', '<cmd> :Lspsaga preview_definition<CR>')
