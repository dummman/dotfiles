local colorscheme = "default"
if vim.fn.has("termguicolors") == 1 then
	-- print("we have termguicolors")
	vim.opt.termguicolors = true
	-- Apply theme
	-- local theme = pcall(require, 'little-wonder')
	-- if theme then vim.cmd('colorscheme darkling') end
	colorscheme = "lw-rubber"
	-- local colorscheme = "PaperColor"
	-- colorscheme = "tokyonight"
	-- vim.g.tokyonight_style = "storm"
	-- vim.g.tokyonight_style = "night"
	-- vim.g.tokyonight_italic_functions = true
	-- vim.g.tokyonight_italic_variables = true
	-- vim.g.tokyonight_hide_inactive_statusline = true
	-- Change the "hint" color to the "orange" color, and make the "error" color bright red
	-- vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
	-- vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
	-- tokyonight_lualine_bold = true
else
	print("we do not have termguicolors")
	vim.opt.termguicolors = false
	-- vim.opt.notermguicolors = true
end
vim.g.colors_name = colorscheme
vim.o.background = "dark"
-- vim.o.background = "light"
vim.opt.colorcolumn = "88"

require("nvim-gps").setup({})
local gps = require("nvim-gps")
require("tabline").setup({ enable = false })
-- require('tabline').setup {enable = true}
require("lualine").setup({
	options = {
		theme = colorscheme,
	},
	extensions = {
		"quickfix",
		"fugitive",
	},
	sections = {
		lualine_c = {
			{ gps.get_location, condition = gps.is_available },
			-- { require('auto-session-library').current_session_name}
		},
	},
	tabline = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { require("tabline").tabline_buffers },
		lualine_x = { require("tabline").tabline_tabs },
		lualine_y = {},
		lualine_z = {},
	},
})
-- require("neoscroll").setup({
--     easing_function = "quadratic"
-- })
-- require("dapui").setup()
