-------------------- MAPPINGS -------------------------------
-- local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
-- local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
-- local g = vim.g      -- a table to access global variables
-- local opt = vim.opt  -- to set options
-- local function map(mode, lhs, rhs, opts)
--   local options = {noremap = true}
--   if opts then options = vim.tbl_extend('force', options, opts) end
--   vim.api.nvim_set_keymap(mode, lhs, rhs, options)
-- end
-- g.mapleader = ","

local M = {}
local api = vim.api

function M.mappings()
	M.movements()
	M.div()
	M.div_silent()
	M.div_nonoremap()
	M.plugins()
	M.lsp()
end

function M.bufmaps(mapdict, opts)
	for m = 1, #mapdict do
		local mode = mapdict[m][1]
		local lhs = mapdict[m][2]
		local rhs = mapdict[m][3]
		local buffer = 0

		api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts)
	end
end

function M.maps(mapdict, opts)
	for m = 1, #mapdict do
		local mode = mapdict[m][1]
		local lhs = mapdict[m][2]
		local rhs = mapdict[m][3]

		api.nvim_set_keymap(mode, lhs, rhs, opts)
	end
end

function M.movements()
	local opts = { nowait = true, noremap = true, silent = false }
	local maps = {
		-- {'v', 'H', '^'},
		-- {'v', 'L', '$'},
		-- {'n', 'H', '^'},
		-- {'n', 'L', '$'},
		-- {'o', 'H', '^'},
		-- {'o', 'L', '$'},
		{ "n", "j", "gj" },
		{ "n", "k", "gk" },
		-- {'n', '<space>', '<C-f>'},
		{ "n", "}", "}zz" },
		{ "n", "{", "{zz" },
		{ "n", "[[", "[[zz" },
		{ "n", "]]", "]]zz" },
		{ "n", "[]", "[]zz" },
		{ "n", "][", "][zz" },
		{ "n", "n", "nzzzv" },
		{ "n", "N", "Nzzzv" },
		{ "n", "#", "#zz" },
		{ "n", "*", "*zz" },
		{ "i", "<c-]>", "<c-o>$" },
		{ "i", "<c-[>", "<c-o>I" },
		{ "", "<c-u>", "<c-u>M" },
		{ "", "<c-d>", "<c-d>M" },
		{ "n", "<c-j>", ":move .+1<CR>==" },
		{ "n", "<c-k>", ":move .-2<CR>==" },
		{ "v", "<c-j>", ":move '>+1<CR>gv=gv" },
		{ "v", "<c-k>", ":move '<-2<CR>gv=gv" },
		-- window resizing
		{ "n", "<left>", "<c-w>>" },
		{ "n", "<right>", "<c-w><" },
		{ "n", "<up>", "<c-w>-" },
		{ "n", "<down>", "<c-w>+" },
	}
	M.maps(maps, opts)
end

function M.div()
	local opts = { nowait = true, noremap = true, silent = false }
	local maps = {
		{ "", "<leader>c", '"+y' },
		-- { "i", "<C-u>", "<Esc>viwUea" }, -- make uppercase
		-- { "i", "<C-t>", "<Esc>b~lea" }, -- make titlecase
		{ "i", "<C-w>", "<C-g>u<C-w>" },
		{ "n", "<leader><space>", ":noh<CR>" },
		{ "n", "<leader>o", "m`o<Esc>``" },
		{ "n", "<leader>O", "m`O<Esc>``" },
		-- {'n', 'jk', '<Esc>'},
		-- {'i', 'jk', '<Esc>'},
		-- {'i', 'kj', '<Esc>'},
		-- {'v', 'jk', '<Esc>'},
		-- {'n', ';', ':'},
		-- {'x', ';', ':'},
		{ "n", "<leader>p", "m`o<ESC>p``" }, -- Paste non-linewise text above or below current cursor
		{ "n", "<leader>P", "m`O<ESC>p``" },
		{ "n", "U", ":syntax sync fromstart<cr>:redraw!<cr>" }, -- Unfuck my screen
		-- { "n", "<leader>r", ":source %MYVIMRC<cr>:Reloaded!<cr>" }, -- Reload vimrc
		{ "n", "<C-s>", ":w<cr>:echo 'Saved!'<cr>" }, -- Save
		{ "i", "<C-s>", "<ESC>:w<cr>:echo 'Saved!'<cr>i" }, -- Save
		-- { "n", "<leader>d", ":read !date +'\%B \%-d, \%Y'<cr>" }, -- Save
		-- {'n', '<leader>l', ':set list!<CR>'},
		-- {'i', '<leader>l', '<C-o>:set list!<CR>'},
		-- {'c', '<leader>l', '<C-c>:set list!<CR>'},
		{ "n", "Y", "y$" },
		{ "x", "<", "<gv" },
		{ "x", ">", ">gv" },
		-- {'n', ':W<CR>', ':w<CR>'},
		-- {'n', ':Q<CR>', ':q<CR>'},
		{ "n", "<leader>cd", ":<C-U>lcd %:p:h<CR>:pwd<CR>" },
		{ "t", "<ESC>", "<C-\\><C-n>" },
		-- {'n', 'gb', ':bnext<CR>'},
		-- {'n', 'gB', ':bprevious<CR>'},
		{ "n", "<leader>a", ":argadd **/*" },
		{ "n", "<leader>A", ':argadd <c-r>=fnameescape(expand("%:p:h"))<cr>/*<C-d>' },
		{ "n", "<leader>B", ":b <C-d>" },
		-- {'n', '<leader>b', ':ls<CR>:b<space>'},
		{ "n", "<leader>e", ":e **/*" },
		{ "n", "<leader>E", ':e <c-r>=fnameescape(expand("%:p:h"))<cr>/*<C-d>' },
		{ "n", "<leader>g", ":grep<space>" },
		{ "n", "<leader>G", ":grep <c-r><c-w><cr>" },
		{ "n", "<leader>l", ":lgrep<space>" },
		{ "n", "<leader>L", ":lgrep <c-r><c-w><cr>" },
		{ "n", "<leader>i", ":ilist<space>" },
		{ "n", "<leader>j", ":tjump /" },
		{ "n", "<leader>m", ":make<CR>" },
		{ "n", "<leader>q", ":b#<CR>" },
		{ "n", "<leader>%", ":split<cr>" },
		{ "n", "<leader>|", ":vsplit<cr>" },
		{ "c", "%%", '<c-r>=fnameescape(expand("%"))<cr>' },
		{ "c", "::", '<c-r>=fnameescape(expand("%:p:h"))<cr>/' },
		-- {'i', '<c-space>', '<c-x><c-o>'},
		-- :let cmds = input('command: ', cmds) \| call system('tmux send-keys -t +1 "' . cmds . '" Enter')<cr>
		-- <Tab> to navigate the completion menu
		-- {'i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"'},
		-- {'i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"'},
	}
	M.maps(maps, opts)
end

function M.div_silent()
	local opts = { nowait = true, noremap = true, silent = true }
	local maps = {
		{ "n", "<leader>y", ":<C-U>%y<CR>" },

		{ "i", "<leader>f", "<C-x><C-f>" },
		{ "i", "<leader>i", "<C-x><C-i>" },
		{ "i", "<leader>l", "<C-x><C-l>" },
		{ "i", "<leader>n", "<C-x><C-n>" },
		-- {'i', '<leader>o', '<C-x><C-o>'},
		{ "i", "<leader>t", "<C-x><C-]>" },
		-- {'i', '<leader>u', '<C-x><C-u>'},

		{ "n", "[b", ":bp<CR>" },
		{ "n", "]b", ":bn<CR>" },
		{ "n", "[l", ":lprev<CR>" },
		{ "n", "]l", ":lnext<CR>" },
		{ "n", "[q", ":cprev<CR>" },
		{ "n", "]q", ":cnext<CR>" },
		{ "n", "[t", ":tabprevious<CR>" },
		{ "n", "]t", ":tabnext<CR>" },
	}
	M.maps(maps, opts)
end

function M.plugins()
	local opts = { nowait = true, noremap = true, silent = false }
	local maps = {
		-- FZF
		-- {'n', '<C-p>', [[:<C-u>FZF --reverse<CR>]]},
		-- {'n', '<C-g>', [[:Rg<CR>]]},
		-- {'n', '<C-b>', [[:Buffers<CR>]]},
		-- gitsigns
		{ "n", "gb", ":Gitsigns toggle_current_line_blame<CR>" },
		-- telescope
		{ "n", "<leader>b", ':lua require("telescope.builtin").buffers()<CR>' },
		-- {'n', '<leader>e', ':lua require("telescope.builtin").file_browser()<CR>'},
		{ "n", "<leader>ff", ':lua require("telescope.builtin").find_files()<CR>' },
		{ "n", "<leader>fg", ':lua require("telescope.builtin").live_grep()<CR>' },
		{ "n", "<leader>fh", ':lua require("telescope.builtin").help_tags()<CR>' },
		{ "n", "<leader>fk", ':lua require("telescope.builtin").keymaps()<CR>' },
		{ "n", "<leader>fl", ':lua require("config.telescope").project_files()<CR>' },
		{ "n", "<leader>fm", ':lua require("telescope.builtin").marks()<CR>' },
		{ "n", "<leader>fr", ':lua require("telescope.builtin").registers()<CR>' },
		-- {'n', '<leader>fp', ':lua require("telescope").extensions.projects.projects()<CR>'},
		{ "n", "<leader>fp", ':lua require("telescope").extensions.repo.list{}<CR>' },
		{ "n", "<leader>fq", ':lua require("telescope.builtin").man_pages()<CR>' },
		-- {'n', '<leader>fs', ':lua require("session-lens").search_session()<CR>'},
		-- {'n', '<leader>ft', ':TodoTelescope<CR>'},
		{ "n", "<leader>fv", ':lua require("telescope.builtin").vim_options()<CR>' },
		-- neogen
		-- {'n', '<leader>nf', ':lua require("neogen").generate()<CR>'},
		-- {'n', '<leader>nc', ':lua require("neogen").generate({type="class"})<CR>'},
		-- bufdel
		{ "n", "bd", ":BufDel<CR>" },
		-- trouble
		{ "n", "<leader>xx", ":TroubleToggle<CR>" },
		{ "n", "<leader>xw", ":TroubleToggle lsp_workspace_diagnostics<CR>" },
		{ "n", "<leader>xd", ":TroubleToggle lsp_document_diagnostics<CR>" },
		{ "n", "<leader>xq", ":TroubleToggle quickfix<CR>" },
		{ "n", "<leader>xl", ":TroubleToggle loclist<CR>" },
		{ "n", "<leader>xt", ":TodoTrouble<CR>" },
		{ "n", "gR", ":TroubleToggle lsp_references<CR>" },
		-- symbols-outline
		-- {'n', '<leader>V', ':SymbolsOutline<CR>'},
		-- cutlass.vim
		{ "n", "x", "d" },
		{ "x", "x", "d" },
		{ "n", "xx", "dd" },
		{ "n", "X", "D" },
		-- todo-comments.nvim

		-- glow
		{ "n", "<leader>sg", ":Glow<CR>" },

		-- zk
		{ "n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>" },
		{ "n", "<leader>zj", "<Cmd>ZkNew { dir = 'journal'}<CR>" },
		{ "n", "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>" },
		{ "n", "<leader>zt", "<Cmd>ZkTags<CR>" },
		{ "n", "<leader>zf", "<Cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<CR>" },
		{ "v", "<leader>zf", ":'<,'>ZkMatch<CR>" },
	}
	M.maps(maps, opts)
end

function M.div_nonoremap()
	local opts = { nowait = true, noremap = false, silent = false }
	local maps = {
		--  Yoink
		{ "n", "y", "<Plug>(YoinkYankPreserveCursorPosition)" },
		{ "x", "y", "<Plug>(YoinkYankPreserveCursorPosition)" },
		{ "n", "p", "<Plug>(YoinkPaste_p)" },
		{ "n", "P", "<Plug>(YoinkPaste_P)" },
		{ "n", "gp", "<Plug>(YoinkPaste_gp)" },
		{ "n", "gP", "<Plug>(YoinkPaste_gP)" },
		{ "n", "<c-p>", "<Plug>(YoinkPostPasteSwapForward)" },
		{ "n", "<c-n>", "<Plug>(YoinkPostPasteSwapBack)" },
		{ "n", "[y", "<Plug>(YoinkRotateBack)" },
		{ "n", "]y", "<Plug>(YoinkRotateForward)" },
		{ "n", "<c-=>", "<Plug>(YoinkPostPasteToggleFormat)" },
		-- Subversive.vim
		{ "n", "s", "<Plug>(SubversiveSubstitute)" },
		{ "n", "ss", "<Plug>(SubversiveSubstituteLine)" },
		{ "n", "S", "<Plug>(SubversiveSubstituteToEndOfLine)" },
		-- {'n', 's', 'v@=""<CR>p'},
		-- {'n', 'ss', 'V@=""<CR>p'},
		-- {'n', 'S', 'v$hp'},
	}
	M.maps(maps, opts)
end

function M.lsp()
	local opts = { nowait = true, noremap = true, silent = true }
	local maps = {
		{ "n", "<c-]>", ":lua vim.lsp.buf.definition()<CR>" },
		{ "n", "<space>a", ":lua vim.lsp.buf.code_action()<CR>" },
		{ "x", "<space>a", ":lua vim.lsp.buf.range_code_action()<CR>" },
		{ "n", "K", ":lua vim.lsp.buf.hover()<CR>" },
		-- {'n', '<space>i', ':lua vim.lsp.buf.implementation()<CR>'},
		{ "n", "[d", ":lua vim.lsp.diagnostic.goto_prev()<CR>" },
		{ "n", "]d", ":lua vim.lsp.diagnostic.goto_next()<CR>" },
		-- {'n', '<space>r', ':lua vim.lsp.buf.rename()<CR>'},
		{ "n", "<space>f", ":lua vim.lsp.buf.formatting()<CR>" },
		{ "x", "<space>f", ":lua vim.lsp.buf.range_formatting()<CR>" },
		{ "n", "<space>wa", ":lua vim.lsp.buf.add_workspace_folder()<CR>" },
		{ "n", "<space>wr", ":lua vim.lsp.buf.remove_workspace_folder()<CR>" },
		{ "n", "<space>wl", ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>" },
		{ "n", "<space>ai", ":!/Users/daniel/Library/Python/3.8/bin/autoimport %<CR>" },
		-- {'n', 'gr', ':lua vim.lsp.buf.references()<CR>'},
	}
	M.maps(maps, opts)
end

return M
