return {
    'echasnovski/mini.nvim',
    config = function()
        require('mini.ai').setup { n_lines = 500 } -- This is my favourite one. Big up!!
        require('mini.surround').setup({
            -- Set keybindings:
            mappings = {
                add = '<leader>sa', -- Add surrounding in Normal and Visual modes
                delete = '<leader>sd', -- Delete surrounding
                find = '<leader>sf', -- Find surrounding (to the right)
                find_left = '<leader>sF', -- Find surrounding (to the left)
                highlight = '<leader>sh', -- Highlight surrounding
                replace = '<leader>sr', -- Replace surrounding
                update_n_lines = '<leader>sn', -- Update `n_lines`

                suffix_last = 'l', -- Suffix to search with "prev" method
                suffix_next = 'n', -- Suffix to search with "next" method
            },
        })
        require('mini.splitjoin').setup()
        local statusline = require 'mini.statusline'
        -- Taken from kickstart.nvim (n
        statusline.setup { use_icons = vim.g.have_nerd_font }
        statusline.section_location = function()
            return '%2l:%-2v'
        end
    end,
}
