local M = {}
local conf = require 'nvim-treesitter.configs'

function M.setup()
    conf.setup {
        ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        highlight = {
            enable = true,              -- false will disable the whole extension
        },
        indent = {
            -- enable = false
            enable = true,
            -- disable = { 'cpp', 'supercollider' },
        },
        matchup = {
            enable = true,              -- mandatory, false will disable the whole extension
            -- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
        },
        rainbow = {
            enable = true,
            extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
            max_file_lines = nil, -- Do not enable for files with more than n lines, int
            -- colors = {}, -- table of hex strings
            -- termcolors = {} -- table of colour name strings
        },
        refactor = {
            highlight_definitions = { enable = true },
            highlight_current_scope = { enable = false },
            smart_rename = {
                enable = true,
                keymaps = {
                    smart_rename = "<space>r",
                },
            },
            navigation = {
                enable = true,
                keymaps = {
                    goto_definition_lsp_fallback = "<c-]>",
                    list_definitions = "gD",
                    list_definitions_toc = "gO",
                    goto_next_usage = "]k",
                    goto_previous_usage = "[k",
                },
            },
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim.
                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm.
                    ['af'] = '@function.outer',
                    ['if'] = '@function.inner',
                    ['ac'] = '@class.outer',
                    ['ic'] = '@class.inner',
                },
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    [']m'] = '@function.outer',
                    [']]'] = '@class.outer',
                },
                goto_next_end = {
                    [']M'] = '@function.outer',
                    [']['] = '@class.outer',
                },
                goto_previous_start = {
                    ['[m'] = '@function.outer',
                    ['[['] = '@class.outer',
                },
                goto_previous_end = {
                    ['[M'] = '@function.outer',
                    ['[]'] = '@class.outer',
                },
            },
        },
    }
    require('treesitter-context').setup{}
end

return M

