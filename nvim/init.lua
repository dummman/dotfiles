-------------------- HELPERS -------------------------------
-- vim.g.mapleader = ','
require("config.plugins")
require("config.nvim-cmp")
require("config.lsp").setup()
require("config.mappings").mappings()
require("config.settings").settings()
require("config.treesitter").setup()
