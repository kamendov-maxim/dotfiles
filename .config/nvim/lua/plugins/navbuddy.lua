local M = {
  "SmiteshP/nvim-navbuddy",
  dependencies = {
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",
  },
}

function M.config()
  local wk = require "which-key"
  wk.register {
    ["<leader>o"] = { "<cmd>Navbuddy<cr>", "Nav" },
  }

  local navbuddy = require "nvim-navbuddy"
  -- local actions = require("nvim-navbuddy.actions")
  navbuddy.setup {
    window = {
      border = "rounded",
    },
    icons = require("icons").kind,
    lsp = { auto_attach = true },
  }

end

return M
