local MAPPER = require 'utils'

MAPPER.nnoremap(']b', '<cmd>:BufferNext<CR>')
MAPPER.nnoremap('[b', '<cmd>:BufferPrevious<CR>')
MAPPER.nnoremap('<leader>c', '<cmd>:BufferClose<CR>')

MAPPER.nnoremap('<leader>1', '<cmd>:BufferGoto 1<CR>')
MAPPER.nnoremap('<leader>2', '<cmd>:BufferGoto 2<CR>')
MAPPER.nnoremap('<leader>3', '<cmd>:BufferGoto 3<CR>')
MAPPER.nnoremap('<leader>4', '<cmd>:BufferGoto 4<CR>')
MAPPER.nnoremap('<leader>5', '<cmd>:BufferGoto 5<CR>')
MAPPER.nnoremap('<leader>6', '<cmd>:BufferGoto 6<CR>')
MAPPER.nnoremap('<leader>7', '<cmd>:BufferGoto 7<CR>')
MAPPER.nnoremap('<leader>8', '<cmd>:BufferGoto 8<CR>')
MAPPER.nnoremap('<leader>9', '<cmd>:BufferGoto 9<CR>')
