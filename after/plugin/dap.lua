-- DAP configuration for debugging
local dap = require 'dap'
local dapui = require 'dapui'
local dap_go = require 'dap-go'

-- Set up UI
dapui.setup {
  icons = { expanded = '▾', collapsed = '▸' },
  mappings = {
    -- Use a table with strings
    expand = { '<CR>', '<2-LeftMouse>' },
    open = 'o',
    remove = 'd',
    edit = 'e',
    repl = 'r',
    toggle = 't',
  },
  element_mappings = {},
  expand_lines = true,
  layouts = {
    {
      elements = {
        { id = 'scopes', size = 0.25 },
        'breakpoints',
        'stacks',
        'watches',
      },
      size = 40,
      position = 'left',
    },
    {
      elements = {
        'repl',
        'console',
      },
      size = 0.25,
      position = 'bottom',
    },
  },
}

-- Set up Go debugging
dap_go.setup()

-- Virtual text setup with arguments
require('nvim-dap-virtual-text').setup {
  enabled = true,
  enabled_commands = true,
  highlight_changed_variables = true,
  highlight_new_as_changed = false,
  show_stop_reason = true,
  commented = false,
}

-- Debugging keymaps
vim.keymap.set('n', '<F5>', function()
  dap.continue()
end, { desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<F1>', function()
  dap.step_into()
end, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F2>', function()
  dap.step_over()
end, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F3>', function()
  dap.step_out()
end, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<leader>b', function()
  dap.toggle_breakpoint()
end, { desc = 'Debug: Toggle Breakpoint' })
vim.keymap.set('n', '<leader>B', function()
  dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = 'Debug: Set Breakpoint' })

-- Toggle UI automatically
dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end
