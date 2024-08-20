local M = {
    "mfussenegger/nvim-dap",
    dependencies = {
        {
            'rcarriga/nvim-dap-ui',
            dependencies = { "nvim-neotest/nvim-nio" }
        },
        {
            'theHamsta/nvim-dap-virtual-text',
        },
    }
}

function M.config()
    local dap, dapui = require("dap"), require("dapui")

    dap.listeners.after.event_initialized["dapui_config"] = function(
    )
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function(
    )
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end
    dapui.setup()

    vim.keymap.set('n', '<leader>db', ':DapToggleBreakpoint<CR>')
    vim.keymap.set('n', '<leader>dc', ':DapContinue<CR>')
    vim.keymap.set('n', '<leader>dsi', ':DapStepInto<CR>')
    vim.keymap.set('n', '<leader>dso', ':DapStepOut<CR>')
    vim.keymap.set('n', '<leader>dn', ':DapStepOver<CR>')

    -- C, C++
    dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
            command = vim.fn.stdpath('data') .. '/mason/bin/codelldb',
            args = { "--port", "${port}" },
            detached = function() return true end
        }
    }
    dap.configurations.c = {
        {
            name = 'Launch',
            type = 'codelldb',
            request = 'launch',
            program = function() -- Ask the user what executable wants to debug
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/bin/program', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            args = {},
        },
    }
    dap.configurations.cpp = dap.configurations.c
    dap.configurations.rust = dap.configurations.c

    -- C#, F#
    dap.adapters.coreclr = {
        type = 'executable',
        command = vim.fn.stdpath('data') .. '/mason/bin/netcoredbg',
        args = { '--interpreter=vscode' }
    }
    dap.configurations.cs = {
        {
            type = "coreclr",
            name = "launch - netcoredbg",
            request = "launch",
            program = function()
                local cwd = vim.fn.getcwd()
                local d = vim.fn.fnamemodify(cwd, ":t")
                return vim.fn.input('Path to dll: ', cwd .. '/bin/Debug/net8.0/' .. d .. '.dll', 'file')
            end,
        },
        {
            type = "netcoredbg",
            name = "attach - netcoredbg",
            request = "attach",
            processId = function()
                local pgrep = vim.fn.system("pgrep -f 'dotnet run'")
                vim.fn.setenv('NETCOREDBG_ATTACH_PID', pid)
                return tonumber(pgrep)
            end,
        },
    }
    dap.configurations.fsharp = dap.configurations.cs
end

return M
