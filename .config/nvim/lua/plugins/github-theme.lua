Theme = {
    'projekt0n/github-nvim-theme',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000,
    current_colorscheme = "github_light"
}


function Theme.theme_switch()
    if Theme.current_colorscheme == "github_light" then
        Theme.current_colorscheme = "github_dark_dimmed"
    else
        Theme.current_colorscheme = "github_light"
    end
    vim.cmd(string.format('colorscheme %s', Theme.current_colorscheme))
end

function Theme.config()
    require('github-theme').setup()
    -- vim.cmd('colorscheme github_light')
    vim.keymap.set('n', '<leader>ts', ':lua Theme.theme_switch()<cr>')
end

return Theme
