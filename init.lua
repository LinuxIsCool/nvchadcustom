local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

-- Auto open NvimTree on startup (deferred for faster startup)
autocmd("VimEnter", {
  callback = function()
    vim.defer_fn(function()
      require("nvim-tree.api").tree.toggle({ focus = false })
    end, 0)
  end,
})

-- PYTHON PROVIDER CONFIGURATION
-- Set the command to start Python 3
vim.g.python3_host_prog = "/usr/bin/python"
vim.g.vim_markdown_preview_github = 1
-- vim.api.nvim_set_keymap("n", "<Esc>[105;6u", "<C-i>", { noremap = true, silent = true })
