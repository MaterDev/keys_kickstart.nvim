-- Go development configuration
local lspconfig = require 'lspconfig'

-- Configure gopls (Go language server)
lspconfig.gopls.setup {
  -- Server-specific settings
  settings = {
    gopls = {
      -- Enable additional analysis tools
      analyses = {
        unusedparams = true,
        shadow = true,
        fieldalignment = true,
        nilness = true,
        unusedwrite = true,
      },
      -- Enable static checking
      staticcheck = true,
      -- Use gofumpt for stricter formatting
      gofumpt = true,
    },
  },

  -- Attach custom keybindings and settings when gopls connects
  on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Buffer local mappings
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- Go specific mappings
    -- Type definition
    vim.keymap.set('n', '<space>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    -- Run go mod tidy
    vim.keymap.set('n', '<space>gi', '<cmd>!go mod tidy<CR>', opts)
    -- Run current project
    vim.keymap.set('n', '<space>gr', '<cmd>!go run .<CR>', opts)
    -- Run tests for current package
    vim.keymap.set('n', '<space>gtf', '<cmd>!go test -v .<CR>', opts)
    -- Run tests with coverage
    vim.keymap.set('n', '<space>gtc', '<cmd>!go test -v -cover .<CR>', opts)

    -- Debug mappings
    vim.keymap.set('n', '<space>dt', function()
      require('dap-go').debug_test()
    end, { desc = 'Debug Go Test', buffer = bufnr })

    vim.keymap.set('n', '<space>dl', function()
      require('dap-go').debug_last()
    end, { desc = 'Debug Last Go Test', buffer = bufnr })
  end,
}

-- Auto-format on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- Add imports on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { 'source.organizeImports' } }
    local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, 3000)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, 'UTF-8')
        end
      end
    end
  end,
})
