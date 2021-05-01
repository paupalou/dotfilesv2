-- Only required if you have packer in your `opt` pack
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
  if vim.fn.input("Download Packer? (y for yes)") ~= "y" then
    return
  end

  local directory = string.format(
    '%s/site/pack/packer/opt/',
    vim.fn.stdpath('data')
  )

  vim.fn.mkdir(directory, 'p')

  local out = vim.fn.system(string.format(
    'git clone %s %s',
    'https://github.com/wbthomason/packer.nvim',
    directory .. '/packer.nvim'
  ))

  print(out)
  print("Downloading packer.nvim...")

  return
end

return require('packer').startup {
  function(use)
    -- packer can manage itself as an optional plugin
    use { 'wbthomason/packer.nvim', opt = true }

    -- lua utils required for some plugins
    use 'nvim-lua/plenary.nvim'

    -- color scheme
    use 'mhartington/oceanic-next'

    -- fancy icons (font)
    use 'kyazdani42/nvim-web-devicons'

    -- statusline
    use { 'hoob3rt/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true} }

    -- tweak cursor hold performance
    use 'antoinemadec/FixCursorHold.nvim'

    -- commentarys
    use 'tpope/vim-commentary'
    use 'JoosepAlviste/nvim-ts-context-commentstring'

    -- must have tpope stuff
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'

    -- more objects targets
    use 'wellle/targets.vim'

    -- mru files and bookmarks on start
    use 'mhinz/vim-startify'

    -- visual signs for VCS
    use 'lewis6991/gitsigns.nvim'

    -- show marks on signcolumn
    use 'kshenoy/vim-signature'

    -- move between vim splits and tmux splits
    use 'christoomey/vim-tmux-navigator'

    -- remove delay on exit insert mode
    use 'jdhao/better-escape.vim'

    -- configs for language servers
    use 'neovim/nvim-lspconfig'

    -- snippets like vscode
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'

    -- autocompletion engine
    use 'hrsh7th/nvim-compe'

    -- improved matchit
    use 'andymass/vim-matchup'

    --  lsp stuff
    use 'onsails/lspkind-nvim'
    use 'glepnir/lspsaga.nvim'
    use 'folke/lsp-colors.nvim'
    use 'jose-elias-alvarez/nvim-lsp-ts-utils'
    use 'folke/lsp-trouble.nvim'

    -- indentation guides
    use { 'lukas-reineke/indent-blankline.nvim', branch="lua" }

    -- improve f/t/F/T
    use 'rhysd/clever-f.vim'

    -- buffer bar
    use 'romgrk/barbar.nvim'

    -- minimap sidebar like vscode
    use {'wfxr/minimap.vim', run = ':!cargo install --locked code-minimap' }

    -- async search
    use 'mhinz/vim-grepper'

    -- fuzzyfinder
    use { '~/.fzf', as = 'fzf' }
    use 'junegunn/fzf.vim'

    -- fish shell scripts syntax
    use 'dag/vim-fish'

    -- treesitter syntax
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- typescript stuff
    use 'windwp/nvim-ts-autotag'

    -- file explorer
    use 'kyazdani42/nvim-tree.lua'
  end
}
