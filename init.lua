-- =========================
--  Bootstrap lazy.nvim
-- =========================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
  })
  end
  vim.opt.rtp:prepend(lazypath)

  require("lazy").setup("plugins") -- Load plugins from lua/plugins.lua

  -- =========================
  --  General Settings
  -- =========================
  vim.opt.ruler = true
  vim.opt.cursorline = true
  vim.opt.termguicolors = true
  vim.opt.background = "dark"
  vim.opt.errorbells = false
  vim.opt.visualbell = false
  vim.opt.belloff = "all"
  vim.opt.number = true

  -- =========================
  --  Keymaps
  -- =========================
  vim.keymap.set("n", "å", "$")  -- Example: å goes to end of line ($)
  vim.keymap.set("n", "<F2>", ":NvimTreeToggle<CR>")
  vim.keymap.set("n", "<C-n>", ":NvimTreeFocus<CR>")

  -- Use spaces instead of tabs
  vim.opt.expandtab = true

  -- Set number of spaces per tab
  vim.opt.tabstop = 4       -- Display width of tab character
  vim.opt.shiftwidth = 4    -- Indent size when using > or <

  -- Optional: set different rules for specific languages
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lua", "json", "yaml", "html", "css" },
    callback = function()
      vim.opt_local.shiftwidth = 2
      vim.opt_local.tabstop = 2
    end
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "cs" },
    callback = function()
      vim.opt_local.shiftwidth = 4
      vim.opt_local.tabstop = 4
    end
  })

  -- Kör 'dotnet build && dotnet run' i en inbyggd terminal med F5
  vim.keymap.set("n", "<F5>", function()
  -- Spara filen automatiskt innan körning (valfritt men smidigt)
  vim.cmd("silent! write") 
  -- Öppna en delad terminal i botten och kör programmet
  vim.cmd("split | terminal dotnet build && dotnet run")
  -- Starta i "Insert mode" om ditt program kräver tangentbordsinmatning
  vim.cmd("startinsert")
  end, { desc = "Build and run .NET project" })

