-- Numbering:
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabstops:
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Wrap:
vim.opt.wrap = true
vim.opt.breakindent = true

-- Searches (using '/'):
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false

-- Scrolloff:
vim.opt.scrolloff = 999

vim.g.have_nerd_font = false

-- Enable mouse:
vim.opt.mouse = "a"

-- Save file history:
vim.opt.undofile = true

-- Configure how windows are split:
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Show the line that the cursor is on:
vim.opt.cursorline = true

require("config.lazy")

-- Highlight When Yanking:
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- opy to system clipboard:
vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
end)

-- Window navigation remaps:
vim.keymap.set('n', 'j', 'gj', { noremap = true  })
vim.keymap.set('n', 'k', 'gk', { noremap = true  })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Terminal Remaps:
vim.keymap.set('t', '<Esc>', [[<C-\><C-N>]], { noremap = true })
vim.keymap.set('t', '<C-h>', [[<C-\><C-N><C-w>h]], { noremap = true })
vim.keymap.set('t', '<C-j>', [[<C-\><C-N><C-w>j]], { noremap = true })
vim.keymap.set('t', '<C-k>', [[<C-\><C-N><C-w>k]], { noremap = true })
vim.keymap.set('t', '<C-l>', [[<C-\><C-N><C-w>l]], { noremap = true })

-- Remap :Ex to "<leader>e"
vim.keymap.set('n', '<leader>e', ':Ex<enter>', { desc = 'Enter directory', noremap = true })


local wk = require("which-key")
local tele = require("telescope.builtin")
local todo = require("todo-comments")

-- Todo-comment keyword combos: 
local kw_td = { "TODO:" }
local kw_e = { "FIXME:", "BUG:", "ISSUE:", "ERROR:" }
local kw_w = { "WARNING:" }
local kw_fx_w = { "FIXME:", "BUG:", "ISSUE:", "ERROR:", "WARNING:" }
local kw_hk = { "HACK:" }
local kw_t = { "TEST:" }
local kw_p = { "PASSED:" }
local kw_f = { "FAILED:" }
local kw_p_f = { "PASSED:", "FAILED:" }


wk.add({
    -- telescope:
    {
        mode = {"n"},
        { "<leader>f", group = "Find..." },
        { "<leader>ff", tele.find_files, desc = "Fuzzy find [f]iles" },
        { "<leader>fg", function() tele.grep_string({ search = vim.fn.input("Grep > ") }) end, desc = "Fuzzy live [g]rep" },
        { "<leader>fb",  tele.buffers, desc = "Telescope [b]uffers" },
        { "<leader>fh",  tele.help_tags, desc = "Telescope [h]elp tags" },
    },

    -- todo-comments:
    {
        mode = {"n"},
        { "<leader>n", group = "Next..." },
        { "<leader>nt", function() require("todo-comments").jump_next({ keywords = kw_td }) end, desc = "TODO comment" },
        { "<leader>ne", function() require("todo-comments").jump_next({ keywords = kw_e }) end,  desc = "FIXME comment" },
        { "<leader>nw", function() require("todo-comments").jump_next({ keywords = kw_w }) end,  desc = "WARNING comment" },
        { "<leader>nm", function() require("todo-comments").jump_next({ keywords = kw_fx_w }) end, desc = "FIXME or WARNING comment" },
        { "<leader>nh", function() require("todo-comments").jump_next({ keywords = kw_hk }) end, desc = "HACK comment" },
        { "<leader>nu", function() require("todo-comments").jump_next({ keywords = kw_t }) end, desc = "TEST comment" },
        { "<leader>np", function() require("todo-comments").jump_next({ keywords = kw_p }) end, desc = "PASSED comment" },
        { "<leader>nf", function() require("todo-comments").jump_next({ keywords = kw_f }) end, desc = "FAILED comment" },
        { "<leader>no", function() require("todo-comments").jump_next({ keywords = kw_p_f }) end, desc = "PASSED or FAILED comment" },
        { "<leader>na", function() require("todo-comments").jump_next() end, desc = "highlighted comment" },
    },
    {
        mode = {"n"},
        { "<leader>p", group = "Previous..." },
        { "<leader>pt", function() require("todo-comments").jump_prev({ keywords = kw_td }) end, desc = "TODO comment" },
        { "<leader>pe", function() require("todo-comments").jump_prev({ keywords = kw_e }) end,  desc = "FIXME comment" },
        { "<leader>pw", function() require("todo-comments").jump_prev({ keywords = kw_w }) end,  desc = "WARNING comment" },
        { "<leader>pm", function() require("todo-comments").jump_prev({ keywords = kw_fx_w }) end, desc = "FIXME or WARNING comment" },
        { "<leader>ph", function() require("todo-comments").jump_prev({ keywords = kw_hk }) end, desc = "HACK comment" },
        { "<leader>pu", function() require("todo-comments").jump_prev({ keywords = kw_t }) end, desc = "TEST comment" },
        { "<leader>pp", function() require("todo-comments").jump_prev({ keywords = kw_p }) end, desc = "PASSED comment" },
        { "<leader>pf", function() require("todo-comments").jump_prev({ keywords = kw_f }) end, desc = "FAILED comment" },
        { "<leader>po", function() require("todo-comments").jump_prev({ keywords = kw_p_f }) end, desc = "PASSED or FAILED comment" },
        { "<leader>pa", function() require("todo-comments").jump_prev() end, desc = "highlighted comment" },
    },

    -- undotree:
    {
        mode = {"n"},
        { "<leader>u", group = "Undo-Tree" },
        { "<leader>ut", vim.cmd.UndotreeToggle, desc = "Toggle" },
        { "<leader>uf", vim.cmd.UndotreeFocus, desc = "Focus" },
    },

    -- gitsigns:
    {
        mode = {"n"},
        { "<leader>h", group = "Git..." },
        { "<leader>hs", ":Gitsigns stage_hunk<CR>", desc = "[s]tage hunk" },
        { "<leader>hu", ":Gitsigns undo_stage_hunk<CR>", desc = "[u]nstage hunk" },
        { "<leader>hr", ":Gitsigns reset_hunk<CR>", desc = "[r]eset hunk" },
        { "<leader>hS", ":Gitsigns stage_buffer<CR>", desc = "[S]tage buffer" },
        { "<leader>hR", ":Gitsigns reset_buffer<CR>", desc = "[R]eset buffer" },
        { "<leader>hp", ":Gitsigns preview_hunk<CR>", desc = "[p]review hunk" },
        { "<leader>hb", ":Gitsigns blame_line<CR>", desc = "[b]lame line" },
        { "<leader>hd", ":Gitsigns diffthis<CR>", desc = "[d]iff to most recent stage" },
        { "<leader>hD", function() require("gitsigns").diffthis('~') end, desc = "[D]iff to most recent commit" },
        { "<leader>ht", ":Gitsigns toggle_deleted<CR>", desc = "[t]oggle deleted" },
    },
    {
        mode = {"v"},
        { "<leader>h", group = "Git..." },
        { "<leader>hs", function() require("gitsigns").stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, desc = "[s]tage selection" },
        { "<leader>hr", function() require("gitsigns").reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, desc = "[r]eset selection" },
    },

    -- mini.surround:
    {
        mode = {"n", "v"},
        { "<leader>s", group = "Surround..." },
        -- NOTE: All keymappings are in ./lua/plugins/mini.lua
    },

    -- mini.splitjoin:
    {
        mode = {"n", "v"},
        {"<leader><CR>", function() require("mini.splitjoin").toggle() end, desc = "Toggle splitjoin" },
    },

    -- Full Screen Execute mode:
    {
        mode = {"n"},
        {"<leader>x", ":<C-f>", desc = "Enter e[x]ecute mode" },
    },

    -- Terminal Emulator Options:
    {
        mode = {"n"},
        {"<leader>t", group = "[T]erminal emulator..." },
        {"<leader>tv", ":vs | terminal<CR>", desc = "[v]ertical split" },
        {"<leader>th", ":split | terminal<CR>", desc = "[h]orizontal split" },
    },
}, { prefix = "<leader>" })

vim.cmd.UndotreePersistUndo = true -- HACK: Unsure if this is right, but it seems to work.

