require("roslyn").setup({
    dotnet_cmd = "dotnet", -- this is the default
    roslyn_version = "4.8.0-3.23475.7", -- this is the default
    on_attach = <on_attach you would pass to nvim-lspconfig>, -- required
    capabilities = <capabilities you would pass to nvim-lspconfig>, -- required
})
