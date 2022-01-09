require("dap-python").setup("~/.virtualenvs/debugpy/bin/python", {
	PythonPath = function()
		local cwd = vim.fn.getcwd()
		if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
			return cwd .. "/venv/bin/python"
		elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
			return cwd .. "/.venv/bin/python"
		else
			return "/usr/bin/python3"
		end
	end,
})
-- local dap = require('dap')
-- dap.adapters.python = {
--   type = 'executable';
--   command = '~/.virtualenvs/debugpy/bin/python';
--   args = { '-m', 'debugpy.adapter' };
-- }
-- dap.configurations.python = {
--   {
--     type = 'python';
--     request = 'launch';
--     name = 'Launch file';
--     program = "${file}";
--     pythonPath = function()
--       local cwd = vim.fn.getcwd()
--       if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
--         return cwd .. '/venv/bin/python'
--       elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
--         return cwd .. '/.venv/bin/python'
--       else
--         return '/usr/bin/python3'
--       end
--     end;
--   },
-- }
--
