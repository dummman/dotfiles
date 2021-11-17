local M = {}
local opt = vim.opt
local g = vim.g

function M.settings()
    M.globals()
    M.options()
    M.window_options()
    M.highlight()
    M.netrw()
    M.grep()
    M.plugins()
end


function M.globals()
    g.loaded_python_provider = 0  -- Disable Python2 support
    g.loaded_perl_provider = 0  -- Disable perl provider
    g.loaded_ruby_provider = 0  -- Disable ruby provider
    g.loaded_node_provider = 0  -- Disable node provider
    -- g.python3_host_prog=vim.fn.exepath('python3')
    -- g.python3_host_prog='/usr/bin/python3'
    g.python3_host_prog='/opt/homebrew/bin/python3'
    -- g.python3_host_prog='$HOME/.pyenv/versions/nvim/bin/python3'
end

function M.options()
    opt.autowriteall   = true
    opt.breakindentopt = 'shift:1'
    opt.clipboard      = 'unnamedplus'
    opt.cmdheight      = 1
    opt.compatible     = false
    -- opt.completeopt    = 'menu,menuone,noselect'
    opt.completeopt    = 'menuone,noinsert,noselect'
    opt.diffopt        = 'filler,internal,algorithm:histogram,indent-heuristic'
    opt.encoding       = 'utf-8'
    opt.expandtab      = true
    opt.fillchars      = 'eob: '
    -- opt.foldmethod = 'expr'
    -- opt.foldexpr = 'nvim_treesitter#foldexpr()'
    opt.formatprg      = 'fmt'
    opt.formatoptions  = 'jcroql'
    opt.gdefault       = true
    opt.hidden = true                   -- Enable background buffers
    opt.history        = 200
    opt.hlsearch       = true
    opt.ignorecase = true               -- Ignore case
    opt.inccommand     = "split"
    opt.incsearch      = true
    opt.infercase      = true
    opt.joinspaces     = false
    opt.laststatus     = 2
    opt.list           = true
    opt.listchars:append("space:⋅")
    opt.listchars:append("eol:↲")
    opt.listchars:append("tab:▸ ")
    opt.mouse = 'nic'
    opt.path:append {".,**"}
    opt.scrolloff = 4                   -- Lines of context
    -- opt.sessionoptions="blank,buffers,curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal"
    opt.shiftround = true               -- Round indent
    opt.shiftwidth     = 4
    opt.shortmess:append { c = true }
    opt.showbreak      = '↳'
    opt.sidescrolloff = 8               -- Columns of context
    opt.smartcase      = true
    opt.smartindent = true              -- Insert indeows below current
    opt.smarttab       = true
    opt.softtabstop    = 0
    opt.tabstop        = 4
    opt.splitbelow = true
    opt.splitright     = true
    opt.textwidth      = 0
    opt.title          = true
    opt.undofile       = true
    opt.wildmode       = "full"
    --opt.wildmode = {'list', 'longest'}  -- Command-line completion mode
    opt.updatetime = 100
end

function M.window_options()
    opt.breakindent = false
    opt.linebreak   = true
    opt.number      = true
    opt.relativenumber = true           -- Relative line numbers
    opt.wrap        = true
end

function M.grep()
    opt.grepprg="rg --vimgrep --no-heading"
    opt.grepformat="%f:%l:%c:%m"
end

function M.netrw()
    g.netrw_liststyle = 3
    g.netrw_banner    = 0
    g.netrw_winsize   = 25
end

function M.highlight()
vim.cmd([[
autocmd TextYankPost * lua vim.highlight.on_yank{higroup="IncSearch", timeout=500, on_visual=true}
    ]])
end

function M.term_settings()
    vim.api.nvim_command("startinsert")
end

function M.plugins()
    g.yoinkMaxItems= 100
    g.yoinkSyncNumberedRegisters = 1
    g.yoinkIncludeDeleteOperations = 1
    g.yoinkSavePersistently = 1
    g.yoinkAutoFormatPaste = 1
    g.yoinkSwapClampAtEnds = 1
    g.yoinkIncludeNamedRegisters = 1
    g.yoinkSyncSystemClipboardOnFocus = 1
end

return M
