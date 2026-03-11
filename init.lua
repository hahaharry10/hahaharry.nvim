-- Search down into subdirectories (for autocompletion)
vim.opt.path = vim.opt.path + "**"

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

-- Auto-reload files changed outside of Neovim:
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
    desc = 'Check if file changed on disk and reload',
    group = vim.api.nvim_create_augroup('auto-reload', { clear = true }),
    callback = function()
        if vim.fn.mode() ~= 'c' then
            vim.cmd('checktime')
        end
    end,
})

-- Highlight When Yanking:
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.lsp.enable('clangd')

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

vim.keymap.set('n', 'z', '<C-d>', { desc = 'Down half a page', noremap = true })
vim.keymap.set('n', 'Z', '<C-u>', { desc = 'Up half a page', noremap = true })
vim.keymap.set('x', 'z', '<C-d>', { desc = 'Down half a page', noremap = true })
vim.keymap.set('x', 'Z', '<C-u>', { desc = 'Up half a page', noremap = true })
vim.o.timeoutlen = 0

vim.g.copilot_no_tab_map = true

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
local kw_q = { "QUESTION:" }

-- TODO: Add ccls lsp instead of clangd.
-- Below is taken from https://github.com/Aumnescio/dotfiles/blob/c647e3a73150af8eb0eb0713cda2667f11c07571/nvim/init.lua#L1228
--
-- require("ccls").setup({
--     lsp = {
--         -- Check `:help vim.lsp.start` for config options.
--         server = {
--             name = "ccls",  -- String name.
--
--             cmd = { "ccls-extra.sh" },  -- Point to your binary, has to be a table.
--             args = {},
--
--             -- autostart = false,  -- Does not seem to work here.
--
--             offset_encoding = "utf-32",  -- Default value set by plugin.
--
--             root_dir = vim.fs.dirname(vim.fs.find({ "compile_commands.json", ".git" }, { upward = true })[1]),
--
--             init_options = {
--                 index = {
--                     threads = 0;
--                 };
--
--                 clang = {
--                     excludeArgs = { "-frounding-math" };
--                 };
--             },
--
--             -- -- |> Fix diagnostics.
--             -- flags = lsp_flags,
--             -- -- |> Attach LSP keybindings & other crap.
--             -- on_attach = aum_general_on_attach,
--             -- -- |> Add nvim-cmp or snippet completion capabilities.
--             -- capabilities = completion_capabilities,
--             -- -- |> Activate custom handlers.
--             -- handlers = aum_handler_config,
--         },
--     },
--
--     win_config = {
--         -- Sidebar configuration.
--         sidebar = {
--             size = 50,
--             position = "topleft",
--             split = "vnew",
--             width = 50,
--             height = 20,
--         },
--
--         -- Floating window configuration. check :help nvim_open_win for options.
--         float = {
--             style = "minimal",
--             relative = "cursor",
--             width = 50,
--             height = 20,
--             row = 0,
--             col = 0,
--             border = "rounded",
--         },
--     },
--
--     filetypes = {"c", "cpp"},
-- })

-- Functions for keybindings `gv` and `gs`:
function SplitGotoDeclaration(split_direction)
    if( split_direction == "vertical" ) then
        vim.cmd("vsplit")
    elseif( split_direction == "horizontal" ) then
        vim.cmd("split")
    end

    require('telescope.builtin').lsp_definitions()
end

-- Functions for Telescope split window keybindings:
local tele = require("telescope.builtin")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local function open_with_split(prompt_bufnr, split_type)
    local entry = action_state.get_selected_entry()
    actions.close(prompt_bufnr)
    if split_type == "vertical" then
        vim.cmd("vsplit " .. entry.path)
    elseif split_type == "horizontal" then
        vim.cmd("split " .. entry.path)
    end
end

local function custom_find_files()
    require("telescope.builtin").find_files({
        attach_mappings = function(_, map)
            map("n", "<C-v>", function(prompt_bufnr) open_with_split(prompt_bufnr, "vertical") end)
            map("n", "<C-s>", function(prompt_bufnr) open_with_split(prompt_bufnr, "horizontal") end)
            return true
        end,
    })
end

local function custom_grep_string()
    require("telescope.builtin").grep_string({
        search = vim.fn.input("Grep > "),
        attach_mappings = function(_, map)
            map("n", "<C-v>", function(prompt_bufnr) open_with_split(prompt_bufnr, "vertical") end)
            map("n", "<C-s>", function(prompt_bufnr) open_with_split(prompt_bufnr, "horizontal") end)
            return true
        end,
    })
end


local wk = require("which-key")
wk.add({
    -- telescope:
    {
        mode = {"n"},
        { "<leader>f", group = "Find..." },
        { "<leader>ff", custom_find_files, desc = "Fuzzy find [f]iles" },
        { "<leader>fg", custom_grep_string, desc = "Fuzzy live [g]rep" },
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
        { "<leader>nq", function() require("todo-comments").jump_next({ keywords = kw_q }) end, desc = "QUESTION comment" },
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
        { "<leader>pq", function() require("todo-comments").jump_prev({ keywords = kw_q }) end, desc = "QUESTION comment" },
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
        mode = {"n"},
        { "g", group = "LSP Actions..." },
        { "gR", vim.lsp.buf.rename, desc = "[R]e[n]ame" },
        { "ga", vim.lsp.buf.code_action, desc = "[G]oto Code [A]ction" },
        { "gr", require('telescope.builtin').lsp_references, desc = "[G]oto [R]eferences" },
        { "gi", require('telescope.builtin').lsp_implementations, desc = "[G]oto [I]mplementation" },
        { "gd", require('telescope.builtin').lsp_definitions, desc = "[G]oto [D]efinition" },
        { "gD", vim.lsp.buf.declaration, desc = "[G]oto [D]eclaration" },
        { "gv", function() SplitGotoDeclaration("vertical") end, desc = "[G]oto Declaration with [V]ertical Split"},
        { "gs", function() SplitGotoDeclaration("horizontal") end, desc = "[G]oto Declaration with Horizontal [S]plit"},
        { "gO", require('telescope.builtin').lsp_document_symbols, desc = "Open Document Symbols" },
        { "gW", require('telescope.builtin').lsp_dynamic_workspace_symbols, desc = "Open Workspace Symbols" },
        { "gt", require('telescope.builtin').lsp_type_definitions, desc = "[G]oto [T]ype Definition" },
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
        {":", "q:a", desc = "Enter e[x]ecute mode" },
    },

    -- Allow focus on selected text:
    {
        mode = {"v"},
        {"<leader>l", function() require("focus"):focus_visual_selection() end, desc = "Focus Selection"},
    },
    {
        mode = {"n"},
        {"<leader>l", function() require("focus"):unfocus() end, desc = "Unfocus text" },
    },

    -- Copilot keys:
    {
        mode = {"n"},
        {
            "<C-C>",
            function()
                if vim.g.copilot_enabled == true then
                    vim.g.copilot_enabled = false
                    vim.notify("GitHub Copilot Disabled")
                else
                    vim.g.copilot_enabled = true
                    vim.notify("GitHub Copilot Enabled")
                end
            end,
            desc = "Toggle GitHub Copilot"
        },
    },

}, { prefix = "<leader>" })

vim.cmd.UndotreePersistUndo = true -- HACK: Unsure if this is right, but it seems to work.

-- Output to the terminal hello
