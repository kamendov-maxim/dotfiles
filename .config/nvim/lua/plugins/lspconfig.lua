local M = {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        {
            "folke/neodev.nvim",
            "jmederosalvarado/roslyn.nvim", -- c#
        },
    },
}

local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    local keymap = vim.api.nvim_buf_set_keymap
    keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
end

M.toggle_inlay_hints = function()
    local bufnr = vim.api.nvim_get_current_buf()
    -- vim.lsp.inlay_hint.enable(bufnr, not vim.lsp.inlay_hint.is_enabled(bufnr))
end

function M.common_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    return capabilities
end

M.on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)
    if client.supports_method "textDocument/inlayHint" then
        vim.lsp.inlay_hint.enable(bufnr, true)
    end
end

function M.config()
    local wk = require "which-key"
    wk.register {
        ["<leader>la"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        ["<leader>lf"] = {
            "<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
            "Format",
        },
        ["<leader>li"] = { "<cmd>LspInfo<cr>", "Info" },
        ["<leader>lj"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
        ["<leader>lh"] = { "<cmd>lua require('plugins.lspconfig').toggle_inlay_hints()<cr>", "Hints" },
        ["<leader>lk"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
        ["<leader>ll"] = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
        ["<leader>lq"] = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
        ["<leader>lr"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    }

    wk.register {
        ["<leader>la"] = {
            name = "LSP",
            a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action", mode = "v" },
        },
    }

    local servers = {
        "lua_ls",
        "pyright",
        "bashls",
    }

    local lspconfig = require "lspconfig"
    local icons = require "icons"


    local default_diagnostic_config = {
        signs = {
            active = true,
            values = {
                { name = "DiagnosticSignError", text = icons.diagnostics.Error },
                { name = "DiagnosticSignWarn",  text = icons.diagnostics.Warning },
                { name = "DiagnosticSignHint",  text = icons.diagnostics.Hint },
                { name = "DiagnosticSignInfo",  text = icons.diagnostics.Information },
            },
        },
        virtual_text = false,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    for _, server in pairs(servers) do
        local opts = {
            on_attach = M.on_attach,
            capabilities = M.common_capabilities(),
        }

        local require_ok, settings = pcall(require, "plugins.lspsettings." .. server)
        if require_ok then
            opts = vim.tbl_deep_extend("force", settings, opts)
        end

        if server == "lua_ls" then
            require("neodev").setup {}
        end

        lspconfig[server].setup(opts)
    end

    require("roslyn").setup({
        dotnet_cmd = "dotnet",              -- this is the default
        roslyn_version = "4.8.0-3.23475.7", -- this is the default
        on_attach = M.on_attach,
        capabilies = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(),
            require('cmp_nvim_lsp').default_capabilities())
    })

    require 'lspconfig'.clangd.setup(
        {
            -- root_dir = { require'lspconfig'.root_pattern(
            --     '.clangd',
            --     '.clang-tidy',
            --     '.clang-format',
            --     'compile_commands.json',
            --     'compile_flags.txt',
            --     'configure.ac',
            --     '.git'
            -- )},
            -- root_dir = function(fname)
            --     return require("lspconfig").root_pattern(
            --         "Makefile",
            --         "configure.ac",
            --         "configure.in",
            --         "config.h.in",
            --         "meson.build",
            --         "meson_options.txt",
            --         "build.ninja"
            --     )(fname) or require("lspconfig").root_pattern("compile_commands.json", "compile_flags.txt")(
            --         fname
            --     ) or require("lspconfig").find_git_ancestor(fname)
            -- end,
            capabilities = {
                offsetEncoding = { "utf-16" },
            },
            cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=iwyu",
                "--completion-style=detailed",
                "--function-arg-placeholders",
                "--fallback-style=llvm",
            },
            init_options = {
                usePlaceholders = true,
                completeUnimported = true,
                clangdFileStatus = true,
            },
            single_file_support = true
        }
    )
end

return M
