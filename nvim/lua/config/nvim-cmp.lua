-- Setup nvim-cmp.
local cmp = require("cmp")
local lspkind = require("lspkind")
-- local luasnip = require 'luasnip'
local snippy = require("snippy")
-- local neogen = require 'neogen'

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
-- local t = function(str)
--     return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end
--
-- local check_back_space = function()
--     local col = vim.fn.col '.' - 1
--     return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
-- end

cmp.setup({
	snippet = {
		expand = function(args)
			-- require('luasnip').lsp_expand(args.body)
			snippy.expand_snippet(args.body)
		end,
	},
	mapping = {
		["<Esc>"] = cmp.mapping.close(),
		-- ['<Tab>'] = cmp.mapping.confirm({ select = true }),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif snippy.can_expand_or_advance() then
				snippy.expand_or_advance()
			elseif has_words_before() then
				cmp.complete()
				-- elseif luasnip.expand_or_jumpable() then
				--     luasnip.expand_or_jump()
				-- elseif neogen.jumpable() then
				--     vim.fn.feedkeys(t("<cmd>lua require('neogen').jump_next()<CR>"), "")
				-- elseif check_back_space() then
				--     vim.fn.feedkeys(t("<tab>"), "n")
			else
				fallback()
			end
		end,
		["<C-y>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif snippy.can_jump(-1) then
				snippy.previous()
				-- elseif luasnip.jumpable(-1) then
				-- luasnip.jump(-1)
			else
				fallback()
			end
		end,
	},
	sources = {
		{ name = "nvim_lsp" }, -- For nvim-lsp
		-- { name = 'luasnip' },
		{ name = "snippy" },
		{ name = "nvim_lua" }, -- for nvim lua function
		{ name = "path" }, -- for path completion
		{ name = "calc" }, -- for path completion
		{ name = "buffer", keyword_length = 4 }, -- for buffer word completion
		{ name = "emoji", insert = true }, -- emoji completion
	},
	completion = {
		keyword_length = 1,
		completeopt = "menu,noselect",
	},
	experimental = {
		ghost_text = false,
	},
	formatting = {
		format = lspkind.cmp_format({
			with_text = false,
			menu = {
				nvim_lsp = "[LSP]",
				-- luasnip = "[Snip]",
				snippy = "[Snip]",
				nvim_lua = "[Lua]",
				path = "[Path]",
				calc = "[Calc]",
				buffer = "[Buffer]",
				emoji = "[Emoji]",
			},
		}),
	},
	sorting = {
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.recently_used,
			require("clangd_extensions.cmp_scores"),
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
})

-- require'cmp'.setup.cmdline(':', {
--   sources = {
--     { name = 'cmdline' }
--   }
-- })

vim.cmd("hi link CmpItemMenu Comment") -- Setup nvim-cmp.

-- require'luasnip'.config.set_config({history = true, updateevents = "TextChanged,TextChangedI"})
-- local types = require("luasnip.util.types")

-- require'luasnip'.config.setup({
--     ext_opts = {
--         [types.choiceNode] = {
--             active = {
--                 virt_text = {{"?", "GruvboxOrange"}}
--             }
--         },
--         [types.insertNode] = {
--             active = {
--                 virt_text = {{"?", "GruvboxBlue"}}
--             }
--         }
--     },
-- })

-- require("luasnip.loaders.from_vscode").load()

-- local cmp = require'cmp'
--   cmp.setup({
--     -- snippet = {
--     --   expand = function(args)
--     --     -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
--     --     require'snippy'.expand_snippet(args.body) -- For `snippy` users.
--     --   end,
--     -- },
--     mapping = {
--       ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
--       ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
--       ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
--       ['<C-e>'] = cmp.mapping({i = cmp.mapping.abort(), c = cmp.mapping.close(),}),
--       ['<C-y>'] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
--       ['<CR>'] = cmp.mapping.confirm({ select = true }),
--     },
--     sources = cmp.config.sources({
--       { name = 'nvim_lsp' },
--       -- { name = 'luasnip' }, -- For luasnip users.
--       -- { name = 'snippy' }, -- For snippy users.
--     }, {
--       { name = 'buffer' },
--     })
--   })
--
--   -- Use buffer source for `/`.
--   cmp.setup.cmdline('/', {
--     sources = {
--       { name = 'buffer' }
--     }
--   })
--
--   -- Use cmdline & path source for ':'.
--   -- cmp.setup.cmdline(':', {
--   --   sources = cmp.config.sources({
--   --     { name = 'path' }
--   --   }, {
--   --     { name = 'cmdline' }
--   --   })
--   -- })
--
--   -- Setup lspconfig.
--   local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
--   require('lspconfig')['pylsp'].setup {
--     capabilities = capabilities
--   }
