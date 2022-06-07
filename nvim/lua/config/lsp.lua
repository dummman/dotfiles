local lsp = require("lspconfig")
local M = {}

function M.setup()
	local on_attach = function(client, bufnr)
		local function buf_set_option(...)
			vim.api.nvim_buf_set_option(bufnr, ...)
		end
		-- Enable completion triggered by <c-x><c-o>
		buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
		require("lsp_signature").on_attach()
	end

	-- lsp.sumneko_lua.setup{}
	-- lsp.sumneko_lua.setup{require("config.lua-lsp")}
	-- lsp.ccls.setup{}
	local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
	-- local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	-- lsp.pylsp.setup{
	--   on_attach = on_attach,
	--   settings = {
	--       pylsp = {
	--           plugins = {
	--               -- jedi = {environment = '.venv'},
	--               pylint = { enabled = true , executable = "pylint" },
	--               pyflakes = { enabled = false },
	--               pycodestyle = { enabled = true },
	--               -- jedi_completion = { fuzzy = true },
	--               pyls_isort = { enabled = true },
	--               pylsp_mypy = { enabled = false },
	--               pydocstyle = { enabled = true },
	--           },
	--       },
	--   },
	--   flags = {
	--       debounce_text_changes = 150,
	--   },
	--   capabilities = capabilities,
	-- }
	-- lsp.pyright.setup({
	-- 	on_attach = on_attach,
	-- 	flags = {
	-- 		debounce_text_changes = 150,
	-- 	},
	-- 	capabilities = capabilities,
	-- })

	lsp.rust_analyzer.setup({
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 150,
		},
		settings = {
			["rust-analyzer"] = {
				assist = {
					importGranularity = "module",
					importPrefix = "by_self",
				},
				cargo = {
					loadOutDirsFromCheck = true,
				},
				procMacro = {
					enable = true,
				},
			},
		},
		capabilities = capabilities,
	})
	-- lsp.bashls.setup{
	--     on_attach = on_attach,
	--     flags = {
	--         debounce_text_changes = 150,
	--     },
	--     capabilities = capabilities,
	-- }
	-- lsp.ccls.setup({
	-- 	init_options = {
	-- 		compilationDatabaseDirectory = "build",
	-- 		index = {
	-- 			threads = 0,
	-- 		},
	-- 		clang = {
	-- 			excludeArgs = { "-frounding-math" },
	-- 		},
	-- 		cache = {
	-- 			directory = ".ccls-cache",
	-- 		},
	-- 	},
	-- })
end

require("config.clangd-lsp")
require("config.null-ls")

-- Make runtime files discoverable to the server.
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
return M
