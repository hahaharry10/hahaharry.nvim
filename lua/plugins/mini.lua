return {
    'echasnovski/mini.nvim',
    config = function()
        require('mini.ai').setup { n_lines = 500 } -- This is my favourite one. Big up!!
        require('mini.surround').setup()
        require('mini.splitjoin').setup()
        local statusline = require 'mini.statusline'
        -- Taken from kickstart.nvim (n
        statusline.setup { use_icons = vim.g.have_nerd_font }
        statusline.section_location = function()
            return '%2l:%-2v'
        end
    end,
}
