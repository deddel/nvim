return {
  -- =======================
  -- Color Schemes
  -- =======================
  { "folke/tokyonight.nvim", lazy = false, priority = 1000, config = function()
      vim.cmd.colorscheme("tokyonight-night")
    end
  },
  -- { "catppuccin/nvim", name = "catppuccin", lazy = true },

  -- =======================
  -- File Explorer
  -- =======================
  { "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup()
    end
  },

  -- =======================
  -- Treesitter
  -- =======================
  { "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "lua", "python", "c", "cpp", "javascript", "html", "json", "c_sharp", "vimdoc" },
        highlight = { enable = true },
        auto_install = false,
        sync_install = false,
        ignore_install = {},
      }
    end
  },

  -- =======================
  -- LSP: Lua & C# Language Servers
  -- =======================
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
  config = function()
    require("mason").setup()

    require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls", "csharp_ls" },
        automatic_installation = false,
    }

    -- Capabilities for nvim-cmp
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Lua LSP
    vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                    disable = { "missing-parameters", "missing-fields" },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                },
            },
        },
    })

    -- C# LSP
    vim.lsp.config("csharp_ls", {
        capabilities = capabilities,
    })

    -- Enable both language servers
    vim.lsp.enable("lua_ls")
    vim.lsp.enable("csharp_ls")
    end
  },

  -- =======================
  -- Autocomplete Menu (Dropdown)
  -- =======================
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          -- Tvinga fram menyn manuellt med Ctrl + Blanksteg (precis som i Emacs!)
          ['<C-Space>'] = cmp.mapping.complete(),
          -- Välj förslaget med Enter
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          -- Bläddra med Ctrl+n och Ctrl+p eller piltabbar
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
        })
      })
    end
  },
}

