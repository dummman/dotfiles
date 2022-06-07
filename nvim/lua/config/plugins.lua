-------------------- PLUGINS -------------------------------
local cmd = vim.cmd
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local install_path = fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "--depth=1", "https://github.com/savq/paq-nvim.git", install_path })
end

require("paq")({
	"savq/paq-nvim", -- Let Paq manage itself

	"nvim-lua/plenary.nvim",
	"neovim/nvim-lspconfig", -- Mind the semi-colons
	"ray-x/lsp_signature.nvim",
    "p00f/clangd_extensions.nvim",
	"jose-elias-alvarez/null-ls.nvim",
	"ThePrimeagen/refactoring.nvim",
	-- {"junegunn/fzf", run = fn["fzf#install"]};
	-- "junegunn/fzf.vim";
	"nvim-treesitter/nvim-treesitter",
	"romgrk/nvim-treesitter-context",
	"nvim-treesitter/nvim-treesitter-refactor",
	"ojroques/nvim-bufdel",
	"lewis6991/gitsigns.nvim",
	-- "danymat/neogen";
	-- "lukas-reineke/indent-blankline.nvim";
	"terrortylor/nvim-comment",
	{ "kevinhwang91/nvim-bqf", ft = "qf" },
	-- "CRAG666/code_runner.nvim";
	"michaelb/sniprun",
	"nvim-telescope/telescope.nvim",
	{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
	-- "nvim-telescope/telescope-project.nvim";
	"cljoly/telescope-repo.nvim",
	-- "ahmedkhalf/project.nvim";
	"mfussenegger/nvim-dap",
	"mfussenegger/nvim-dap-python",
	"rcarriga/nvim-dap-ui",
	"nvim-telescope/telescope-dap.nvim",
	"honza/vim-snippets",
	"dcampos/nvim-snippy",
	"dcampos/cmp-snippy",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-calc",
	"hrsh7th/cmp-emoji",
	-- "hrsh7th/cmp-cmdline";
	"hrsh7th/nvim-cmp",
	-- "saadparwaiz1/cmp_luasnip";
	-- "L3MON4D3/LuaSnip";
	-- "rafamadriz/friendly-snippets";
	"windwp/nvim-autopairs",
	"max397574/better-escape.nvim",
	"folke/trouble.nvim",
	"simrat39/rust-tools.nvim",
	-- "bfredl/nvim-miniyank";
	"folke/todo-comments.nvim",
	-- "rmagatti/auto-session";
	-- "rmagatti/session-lens";
	"Shatur/neovim-session-manager",
	-- "svermeulen/vimpeccable";
	-- "famiu/nvim-reload";
	"mickael-menu/zk-nvim",

	-- vimscript
	"andymass/vim-matchup",
	"svermeulen/vim-yoink",
	"svermeulen/vim-subversive",
	"svermeulen/vim-cutlass",
	"tpope/vim-surround",
	"tpope/vim-repeat",
	"tpope/vim-fugitive",

	-- Visuals
	"folke/tokyonight.nvim",
	"NLKNguyen/papercolor-theme",
	"kyazdani42/nvim-web-devicons",
	"nvim-lualine/lualine.nvim",
	"kdheepak/tabline.nvim",
	"onsails/lspkind-nvim",
	"folke/lsp-colors.nvim",
	"p00f/nvim-ts-rainbow",
	"SmiteshP/nvim-gps",
    "ellisonleao/glow.nvim",
	-- "simrat39/symbols-outline.nvim";
	-- "karb94/neoscroll.nvim";
})

------------------------- SETUPS ---------------------------
-- require('lspfuzzy').setup {}

require("bufdel").setup({
	next = "cycle", -- or 'alternate'
	quit = true,
})

-- require('neogen').setup{
--     enabled = true,
--     languages = {
--         python = {
--             template = {
--                 annotation_convention = "numpydoc"
--             }
--         }
--     }
-- }
--
-- cmd [[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]]
-- cmd [[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]]
--
-- require('indent_blankline').setup{
--     space_char_blankline = " ",
--     show_current_context = true,
--     -- U+2502 may also be a good choice, it will be on the middle of cursor.
--     -- char = " ",
--     show_end_of_line = false,
--     disable_with_nolist = true,
--     buftype_exclude = {"terminal"},
--     filetype_exclude = { "help", "startify", "git", "markdown", "snippets" },
-- }
--
require("nvim_comment").setup()

require("better_escape").setup({
	mapping = { "jk", "kj" }, -- a table with mappings to use
	timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
	clear_empty_lines = false, -- clear line after escaping if there is only whitespace
	keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
	-- example
	-- keys = function()
	--   return vim.fn.col '.' - 2 >= 1 and '<esc>l' or '<esc>'
	-- end,
})

require("trouble").setup({})
-- require('project_nvim').setup{}
require("nvim-autopairs").setup({})
require("rust-tools").setup({})
require("todo-comments").setup({})
require("refactoring").setup({})
-- require('auto-session').setup {}
-- require('session-lens').setup {
--     path_display={'shorten'},
-- }
require("session_manager").setup({})
require("zk").setup({})

-- local vimp = require('vimp')
-- -- r = reload vimrc
-- vimp.nnoremap('<leader>r', function()
--     -- Remove all previously added vimpeccable maps
--     vimp.unmap_all()
--     -- Unload the lua namespace so that the next time require('config.X') is called
--     -- it will reload the file
--     require("config.util").unload_lua_namespace('config')
--     -- Make sure all open buffers are saved
--     vim.cmd('silent wa')
--     -- Execute our vimrc lua file again to add back our maps
--     dofile(vim.fn.stdpath('config') .. '/init.lua')
--
--     print("Reloaded vimrc!")
-- end)

require("config.dap")
require("config.git")
require("config.telescope")

--Visuals
require("config.visuals")
