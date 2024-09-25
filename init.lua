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

local builtin = require('telescope.builtin')
-- Telescope remaps:
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Fuzzy find [f]iles' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Fuzzy live [g]rep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope [b]uffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope [h]elp tags' })

-- Window navigation remaps:
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Remap :Ex to "<leader>e"
vim.keymap.set('n', '<leader>e', ':Ex<enter>', { desc = 'Enter directory', noremap = true })

-- Todo-comment ramaps: 
kw_td = { "TODO:" }
kw_fx = { "FIXME:", "BUG:", "ISSUE:", "ERROR:" }
kw_w  = { "WARNING:" }
kw_fx_w = { "FIXME:", "BUG:", "ISSUE:", "ERROR:", "WARNING:" }
kw_hk = { "HACK:" }
kw_t = { "TEST:" }
kw_p = { "PASSED:" }
kw_f = { "FAILED:" }
kw_p_f = { "PASSED:", "FAILED:" }

local wk = require("which-key")
wk.add({
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
}, { prefix = "<leader>" })

-- undotree:
wk.add({
    mode = {"n"},
    { "<leader>u", group = "Undo-Tree" },
    { "<leader>ut", vim.cmd.UndotreeToggle, desc = "Toggle" },
    { "<leader>uf", vim.cmd.UndotreeFocus, desc = "Focus" },
}, { prefix = "<leader>" })
vim.cmd.UndotreePersistUndo = true -- HACK: Unsure if this is right, but it seems to work.

-- gitsigns:
wk.add({
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
}, { prefix = "<leader>" })

