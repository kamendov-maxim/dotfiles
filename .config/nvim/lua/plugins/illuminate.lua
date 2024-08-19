local M = {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
}

function M.config()
    require("illuminate").configure {
        filetypes_denylist = {
            "mason",
            "harpoon",
            "DressingInput",
            "NeogitCommitMessage",
            "qf",
            "dirvish",
            "oil",
            "minifiles",
            "fugitive",
            "alpha",
            "NvimTree",
            "lazy",
            "NeogitStatus",
            "Trouble",
            "netrw",
            "lir",
            "DiffviewFiles",
            "Outline",
            "Jaq",
            "spectre_panel",
            "toggleterm",
            "DressingSelect",
            "TelescopePrompt",
        },
    }
    vim.keymap.set("n", "<leader>n", function()
        require("illuminate").goto_next_reference()
    end)
    vim.keymap.set("n", "<leader>p", function()
        require("illuminate").goto_prev_reference()
    end)
end

return M
