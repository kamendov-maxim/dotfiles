local M = {
    "lervag/vimtex",
    lazy = false,
}

function M.config()
    vim.g.tex_flavor = 'latex'
    vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_quickfix_mode = 0
    vim.g.vimtex_compiler_latexmk = { build_dir = 'build' }
    vim.g.tex_conceal = 'abdmg'
    vim.opt.conceallevel = 2
end

return M
