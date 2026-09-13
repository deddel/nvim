return {
  -- =======================
  -- Color Schemes
  -- =======================
  { "folke/tokyonight.nvim", lazy = false, priority = 1000, config = function()
      vim.cmd.colorscheme("tokyonight-night")
    end
  },
  { "catppuccin/nvim", name = "catppuccin", lazy = true },

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
    version = "0.1.7",  -- Compatible with Neovim 0.10
    dependencies = {
      { "williamboman/mason.nvim", version = "1.8.0" },          
      { "williamboman/mason-lspconfig.nvim", version = "1.24.0" } 
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup {
        -- LÄGG TILL "csharp_ls" HÄR SÅ MASON INSTALLERAR DEN AUTOMATISKT
        ensure_installed = { "lua_ls", "csharp_ls" },
        automatic_installation = false,
      }

      local lspconfig = require("lspconfig")

      -- Berätta för Neovim att autocomplete-menyn är redo att ta emot data
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Setup Lua LSP
      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
              disable = {"missing-parameters", "missing-fields"}
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            }
          }
        }
      }

      -- ✅ AKTIVERA C# LSP HÄR
      lspconfig.csharp_ls.setup({
        capabilities = capabilities,
      })
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

