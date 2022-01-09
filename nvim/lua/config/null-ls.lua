local null_ls = require("null-ls")

-- register any number of sources simultaneously
local sources = {
	null_ls.builtins.formatting.prettier,
	null_ls.builtins.formatting.black,
	null_ls.builtins.formatting.isort,
	null_ls.builtins.formatting.stylua,
	null_ls.builtins.formatting.rustfmt,
	null_ls.builtins.formatting.uncrustify,
	null_ls.builtins.formatting.trim_whitespace,
	null_ls.builtins.diagnostics.cppcheck,
	null_ls.builtins.diagnostics.gitlint,
	null_ls.builtins.diagnostics.luacheck,
	null_ls.builtins.diagnostics.pylint.with({
		extra_args = {
			"--disable=design, format, bare-except, unneeded-not, undefined-variable, unused-import, unused-variable, missing-module-docstring, missing-class-docstring, missing-function-docstring, no-self-argument, invalid-name, bad-classmethod-argument, bad-mcs-classmethod-argument",
		},
	}),
	null_ls.builtins.diagnostics.write_good,
	null_ls.builtins.code_actions.gitsigns,
	null_ls.builtins.code_actions.refactoring,
}

null_ls.setup({ sources = sources })
