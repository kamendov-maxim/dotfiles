local M = {
    "f-person/auto-dark-mode.nvim",
    opts = {
        update_interval = 1000,
        set_dark_mode = function()
            vim.cmd("colorscheme github_dark_dimmed")
        end,
        set_light_mode = function()
            vim.cmd("colorscheme github_light")
        end,
    },
}

return M
