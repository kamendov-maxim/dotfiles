local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
}

function M.config()
  require("nvim-treesitter.configs").setup {
    ensure_installed = { "lua", "bash", "python", "c", "c_sharp" },
    highlight = { enable = true },
    indent = { enable = true },
    additional_vim_regex_highlighting = { 'c_sharp' },
  }
end

return M
