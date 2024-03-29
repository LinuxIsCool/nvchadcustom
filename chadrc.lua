-- Set Leader Key
vim.g.mapleader = ","

-- Set Vim Options

-- No wrap line
vim.opt.wrap = false

-- Highlight the cursor line
vim.opt.cursorline = true

-- Set Spell on by Default
vim.opt.spell = true

---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "everblush",
  theme_toggle = { "everblush", "one_light" },
  transparency = true,

  hl_override = highlights.override,
  hl_add = highlights.add,
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
