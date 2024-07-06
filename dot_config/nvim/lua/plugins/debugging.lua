return {
  "mfussenegger/nvim-dap",
  dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio" },

  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("dapui").setup()

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    local windows = vim.fn.has('win32') == 1 -- true if on windows
    -- C
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
        args = { "--port", "${port}" },
        detached = function()
          if windows then
            return false
          else
            return true
          end
        end,
      },
    }
    dap.configurations.c = {
      {
        name = "Launch",
        type = "codelldb",
        request = "launch",
        program = function() -- Ask the user what executable wants to debug
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/bin/program", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
      },
    }
    -- C++
      dap.configurations.cpp = dap.configurations.c

    --csharp dap
    dap.adapters.coreclr = {
      type = "executable",
      command = "/path/to/dotnet/netcoredbg/netcoredbg",
      args = { "--interpreter=vscode" },
    }

    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
          return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
        end,
      },
    }

    vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
    vim.keymap.set("n", "<Leader>dc", dap.continue, {})
  end,
}
