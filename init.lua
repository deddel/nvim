-- =========================
--  Leader
-- =========================
vim.g.mapleader = " "

-- =========================
--  Bootstrap lazy.nvim
-- =========================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  rocks = {
    enabled = false,
  },
})

-- =========================
--  UI
-- =========================
vim.opt.statusline = " %f %m %=%y %=%l,%c %p%%   "
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.background = "dark"

-- =========================
--  Editing
-- =========================
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Delete without overwriting clipboard
vim.keymap.set({"n", "v"}, "d", '"_d')
vim.keymap.set({"n", "v"}, "x", '"_x')
vim.keymap.set({"n", "v"}, "c", '"_c')

-- If you ever DO want to cut text to move it somewhere else, use 'Leader + d'
vim.keymap.set({"n", "v"}, "<leader>d", "d")


-- =========================
--  Search
-- =========================
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- =========================
--  Behavior
-- =========================
vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.belloff = "all"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 5

vim.opt.clipboard = "unnamedplus"

-- Briefly highlight text when yanking (copying)
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})


-- =========================
--  Keymaps
-- =========================
vim.keymap.set("n", "å", "$")

vim.keymap.set("n", "<F2>", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<C-n>", ":NvimTreeFocus<CR>")

-- Clear search highlight
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { silent = true })

-- Format via LSP
vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format()
end)


-- =========================
--  Filetype detection
-- =========================

vim.filetype.add({
    extension = {
        razor = "razor",
    },
})

-- =========================
--  Filetype specific
-- =========================
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

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local opts = { buffer = args.buf }

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'grr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    end,
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

