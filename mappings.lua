---@type MappingsTable
local M = {}

M.disabled = {
  n = {
    ["<leader>f"] = "",
    ["<leader>ff"] = "",
    ["<leader>fg"] = "",
    ["<leader>fb"] = "",
    ["<leader>fh"] = "",
    ["<leader>fa"] = "",
    ["<leader>fm"] = "",
    ["<leader>fo"] = "",
    ["<leader>fw"] = "",
    ["<leader>fz"] = "",
    ["<leader>j"] = "",
    ["<leader>r"] = "",
  }
}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>f"] = { "0", "go to start of line", opts = { nowait = true } },
    ["<leader>j"] = { "$", "go to end of line", opts = { nowait = true } },
    ["tt"] = { ":lua require('base46').toggle_transparency()<cr>", "toggle transparency", opts = { nowait = true } },
  },
  v = {
    ["<leader>f"] = { "0", "go to start of line", opts = { nowait = true } },
    ["<leader>j"] = { "$", "go to end of line", opts = { nowait = true } },
  }
}

-- more keybinds!

return M
