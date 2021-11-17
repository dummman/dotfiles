
local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

local previewers = require('telescope.previewers')
local Job = require('plenary.job')
local new_maker = function(filepath, bufnr, opts)
    filepath = vim.fn.expand(filepath)
    Job:new({
        command = 'file',
        args = { '--mime-type', '-b', filepath },
        on_exit = function(j)
            local mime_type = vim.split(j:result()[1], '/')[1]
            if mime_type == "text" then
                previewers.buffer_previewer_maker(filepath, bufnr, opts)
            else
                -- maybe we want to write something to the buffer here
                vim.schedule(function()
                    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { 'BINARY' })
                end)
            end
        end
    }):sync()
end

require('telescope').setup {
    defaults = {
        mappings = {
            i = { ["<c-t>"] = trouble.open_with_trouble },
            n = { ["<c-t>"] = trouble.open_with_trouble },
        },
        buffer_previewer_maker = new_maker,
    },
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
        -- project = {
        -- base_dirs = {
        --   '~/dev/src',
        --   {'~/dev/src2'},
        --   {'~/dev/src3', max_depth = 4},
        --   {path = '~/dev/src4'},
        --   {path = '~/dev/src5', max_depth = 2},
        -- },
        -- hidden_files = true -- default: false
    }
}
require('telescope').load_extension('fzf')
-- require('telescope').load_extension('projects')
-- require('telescope').load_extension('project')
require('telescope').load_extension('repo')
require('telescope').load_extension('dap')
require('telescope').load_extension('sessions')
-- require('telescope').load_extension('session-lens')

local M = {}

M.project_files = function()
    local opts = {} -- define here if you want to define something
    local ok = pcall(require'telescope.builtin'.git_files, opts)
    if not ok then require'telescope.builtin'.find_files(opts) end
end

return M
