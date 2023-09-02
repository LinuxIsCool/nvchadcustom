local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  -- Completion for things like jedi-language-server
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
    on_attach = function(bufnr)
      local api = require "nvim-tree.api"

      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- BEGIN_DEFAULT_ON_ATTACH
      vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts "CD")
      vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer, opts "Open: In Place")
      vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts "Info")
      vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts "Rename: Omit Filename")
      vim.keymap.set("n", "<C-t>", api.node.open.tab, opts "Open: New Tab")
      vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts "Open: Vertical Split")
      vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts "Open: Horizontal Split")
      vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts "Close Directory")
      vim.keymap.set("n", "<CR>", api.node.open.edit, opts "Open")
      vim.keymap.set("n", "<Tab>", api.node.open.preview, opts "Open Preview")
      vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts "Next Sibling")
      vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts "Previous Sibling")
      vim.keymap.set("n", ".", api.node.run.cmd, opts "Run Command")
      vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts "Up")
      vim.keymap.set("n", "a", api.fs.create, opts "Create")
      vim.keymap.set("n", "bd", api.marks.bulk.delete, opts "Delete Bookmarked")
      vim.keymap.set("n", "bmv", api.marks.bulk.move, opts "Move Bookmarked")
      vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter, opts "Toggle Filter: No Buffer")
      vim.keymap.set("n", "c", api.fs.copy.node, opts "Copy")
      vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter, opts "Toggle Filter: Git Clean")
      vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts "Prev Git")
      vim.keymap.set("n", "]c", api.node.navigate.git.next, opts "Next Git")
      vim.keymap.set("n", "d", api.fs.remove, opts "Delete")
      vim.keymap.set("n", "D", api.fs.trash, opts "Trash")
      vim.keymap.set("n", "E", api.tree.expand_all, opts "Expand All")
      vim.keymap.set("n", "e", api.fs.rename_basename, opts "Rename: Basename")
      vim.keymap.set("n", "]e", api.node.navigate.diagnostics.next, opts "Next Diagnostic")
      vim.keymap.set("n", "[e", api.node.navigate.diagnostics.prev, opts "Prev Diagnostic")
      vim.keymap.set("n", "F", api.live_filter.clear, opts "Clean Filter")
      vim.keymap.set("n", "f", api.live_filter.start, opts "Filter")
      vim.keymap.set("n", "g?", api.tree.toggle_help, opts "Help")
      vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts "Copy Absolute Path")
      vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts "Toggle Filter: Dotfiles")
      vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts "Toggle Filter: Git Ignore")
      vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts "Last Sibling")
      vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts "First Sibling")
      vim.keymap.set("n", "m", api.marks.toggle, opts "Toggle Bookmark")
      vim.keymap.set("n", "o", api.node.open.edit, opts "Open")
      vim.keymap.set("n", "O", api.node.open.no_window_picker, opts "Open: No Window Picker")
      vim.keymap.set("n", "p", api.fs.paste, opts "Paste")
      vim.keymap.set("n", "P", api.node.navigate.parent, opts "Parent Directory")
      vim.keymap.set("n", "q", api.tree.close, opts "Close")
      vim.keymap.set("n", "r", api.fs.rename, opts "Rename")
      vim.keymap.set("n", "R", api.tree.reload, opts "Refresh")
      vim.keymap.set("n", "s", api.node.run.system, opts "Run System")
      vim.keymap.set("n", "S", api.tree.search_node, opts "Search")
      vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts "Toggle Filter: Hidden")
      vim.keymap.set("n", "W", api.tree.collapse_all, opts "Collapse")
      vim.keymap.set("n", "x", api.fs.cut, opts "Cut")
      vim.keymap.set("n", "y", api.fs.copy.filename, opts "Copy Name")
      vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts "Copy Relative Path")
      vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts "Open")
      vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts "CD")
      -- END_DEFAULT_ON_ATTACH
    end,
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- FZF in Lua
  {
    "ibhagwan/fzf-lua",
    lazy = false,
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup {}
      vim.keymap.set("n", "fp", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
      vim.keymap.set("n", "fo", "<cmd>lua require('fzf-lua').oldfiles()<CR>", { silent = true })
      vim.keymap.set("n", "fg", "<cmd>lua require('fzf-lua').grep_project()<CR>", { silent = true })
      vim.keymap.set("n", "fb", "<cmd>lua require('fzf-lua').buffers()<CR>", { silent = true })
      vim.keymap.set("n", "fbl", "<cmd>lua require('fzf-lua').blines()<CR>", { silent = true })
      vim.keymap.set("n", "fl", "<cmd>lua require('fzf-lua').lines()<CR>", { silent = true })
      vim.keymap.set("n", "ff", "<cmd>lua require('fzf-lua').builtin()<CR>", { silent = true })
    end,
  },

  -- Vyper Syntax Highlighting
  { "vyperlang/vim-vyper", lazy = false },

  -- Snips
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },

  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("cmp").setup {
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        window = {
          completion = require("cmp").config.window.bordered(),
          documentation = require("cmp").config.window.bordered(),
        },
        mapping = require("cmp").mapping.preset.insert {
          ["<C-u>"] = require("cmp").mapping.scroll_docs(-4),
          ["<C-d>"] = require("cmp").mapping.scroll_docs(4),
          ["<C-Space>"] = require("cmp").mapping.complete(),
          ["<C-e>"] = require("cmp").mapping.abort(),
          ["<CR>"] = require("cmp").mapping.confirm { select = false }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        },

        sources = require("cmp").config.sources {
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- For luasnip users.
          { name = "buffer" },
        },
      }
    end,
  },
  { "hrsh7th/cmp-nvim-lsp" }, -- LSP source for nvim-cmp
  { "hrsh7th/cmp-buffer" }, -- Buffer source for nvim-cmp
  { "ray-x/lsp_signature.nvim" }, -- To show function signatures
  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    lazy = false,
    config = function()
      vim.g.codeium_no_map_tab = 1
      vim.keymap.set("i", "<C-f>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true })
      vim.keymap.set("i", "<C-o>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true })
      vim.keymap.set("i", "<C-i>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true })
      vim.keymap.set("i", "<C-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true })
    end,
  },

  -- AI in Vim with :AI
  { "aduros/ai.vim", lazy = false },

  -- Readline in vim!
  { "tpope/vim-rsi", lazy = false },

  -- Smooth scrolling in vim :)
  { "psliwka/vim-smoothie", lazy = false },

  {
    "folke/trouble.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      vim.keymap.set("n", "tx", function()
        require("trouble").open()
      end)
      vim.keymap.set("n", "<leader>xw", function()
        require("trouble").open "workspace_diagnostics"
      end)
      vim.keymap.set("n", "<leader>xd", function()
        require("trouble").open "document_diagnostics"
      end)
      vim.keymap.set("n", "<leader>xq", function()
        require("trouble").open "quickfix"
      end)
      vim.keymap.set("n", "<leader>xl", function()
        require("trouble").open "loclist"
      end)
      vim.keymap.set("n", "gR", function()
        require("trouble").open "lsp_references"
      end)
    end,
    opts = {
      {
        position = "bottom", -- position of the list can be: bottom, top, left, right
        height = 10, -- height of the trouble list when position is top or bottom
        width = 50, -- width of the list when position is left or right
        icons = true, -- use devicons for filenames
        mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
        severity = nil, -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
        fold_open = "", -- icon used for open folds
        fold_closed = "", -- icon used for closed folds
        group = true, -- group results by file
        padding = true, -- add an extra new line on top of the list
        cycle_results = true, -- cycle item list when reaching beginning or end of list
        action_keys = { -- key mappings for actions in the trouble list
          -- map to {} to remove a mapping, for example:
          -- close = {},
          close = "q", -- close the list
          cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
          refresh = "r", -- manually refresh
          jump = { "<cr>", "<tab>", "<2-leftmouse>" }, -- jump to the diagnostic or open / close folds
          open_split = { "<c-x>" }, -- open buffer in new split
          open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
          open_tab = { "<c-t>" }, -- open buffer in new tab
          jump_close = { "o" }, -- jump to the diagnostic and close the list
          toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
          switch_severity = "s", -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
          toggle_preview = "P", -- toggle auto_preview
          hover = "K", -- opens a small popup with the full multiline message
          preview = "p", -- preview the diagnostic location
          open_code_href = "c", -- if present, open a URI with more information about the diagnostic error
          close_folds = { "zM", "zm" }, -- close all folds
          open_folds = { "zR", "zr" }, -- open all folds
          toggle_fold = { "zA", "za" }, -- toggle fold of current file
          previous = "k", -- previous item
          next = "j", -- next item
          help = "?", -- help menu
        },
        multiline = true, -- render multi-line messages
        indent_lines = true, -- add an indent guide below the fold icons
        win_config = { border = "single" }, -- window configuration for floating windows. See |nvim_open_win()|.
        auto_open = false, -- automatically open the list when you have diagnostics
        auto_close = false, -- automatically close the list when you have no diagnostics
        auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
        auto_fold = false, -- automatically fold a file trouble list at creation
        auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
        include_declaration = { "lsp_references", "lsp_implementations", "lsp_definitions" }, -- for the given modes, include the declaration of the current symbol in the results
        signs = {
          -- icons / text used for a diagnostic
          error = "",
          warning = "",
          hint = "",
          information = "",
          other = "",
        },
        use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
      },
    },
  },
}

return plugins
