local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

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
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

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
    "ibhagwan/fzf-lua", lazy=false,
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({})
    end
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- Vyper Syntax Highlighting
  {'vyperlang/vim-vyper', lazy=false},

  -- Snips
  {'L3MON4D3/LuaSnip'},
  {'saadparwaiz1/cmp_luasnip'},

  -- Completion for things like jedi-language-server
  {'neovim/nvim-lspconfig'},
  {'hrsh7th/nvim-cmp',
    config = function()

      require('cmp').setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        window = {
          completion = require('cmp').config.window.bordered(),
          documentation = require('cmp').config.window.bordered(),
        },
        mapping = require('cmp').mapping.preset.insert({
          ['<C-u>'] = require('cmp').mapping.scroll_docs(-4),
          ['<C-d>'] = require('cmp').mapping.scroll_docs(4),
          ['<C-Space>'] = require('cmp').mapping.complete(),
          ['<C-e>'] = require('cmp').mapping.abort(),
          ['<CR>'] = require('cmp').mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),

        sources = require('cmp').config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' }, -- For luasnip users.
          { name = 'buffer' },
        })
      })
    end,
  },
  {'hrsh7th/cmp-nvim-lsp'}, -- LSP source for nvim-cmp
  {'hrsh7th/cmp-buffer'},  -- Buffer source for nvim-cmp
  {'ray-x/lsp_signature.nvim'}, -- To show function signatures
  {
    'Exafunction/codeium.vim',
    event = 'BufEnter',
    lazy=false,
    config = function ()
      vim.g.codeium_no_map_tab = 1
      vim.keymap.set('i', '<C-f>', function () return vim.fn['codeium#Accept']() end, { expr = true })
      vim.keymap.set('i', '<C-o>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
      vim.keymap.set('i', '<C-i>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
      vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
    end
    },

  {'aduros/ai.vim', lazy=false}

}

return plugins
