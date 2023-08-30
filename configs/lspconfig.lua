local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd" , "jedi_language_server"}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.jedi_language_server.setup({
    on_attach = function(client, bufnr)
        -- LSP function signature setup
        require "lsp_signature".on_attach()
    end,
    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    settings = {
        jedi = {
            completion = {
                fuzzy = true,  -- Fuzzy matching
            },
            diagnostics = {
                enable = true,  -- Enable diagnostics
            },
            environment = {
                -- If you have a virtualenv you want to use, specify the path
                -- virtualenv = "/path/to/your/virtualenv"
            },
        }
    }
})
