return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({

            direction = "float",
            float_opts = {
                border = "rounded",
                width = function() return math.floor(vim.o.columns * 0.85) end,
                height = function() return math.floor(vim.o.lines * 0.85) end,
            },
            persist_mode = true,
            close_on_exit = false,
        })

        local Terminal = require("toggleterm.terminal").Terminal

        local claude_term = Terminal:new({
            cmd = "claude --continue",
            direction = "float",
            hidden = true,
            float_opts = {
                border = "rounded",
                width = function() return math.floor(vim.o.columns * 0.95) end,
                height = function() return math.floor(vim.o.lines * 0.95) end,
            },
        })

        local vert_term = Terminal:new({ direction = "vertical",   hidden = true })
        local horiz_term = Terminal:new({ direction = "horizontal", hidden = true })

        require("which-key").add({
            {
                mode = { "n" },
                { "<leader>t",  group = "[T]erminal..." },
                { "<leader>tf", function() vim.cmd("ToggleTerm direction=float") end, desc = "[f]loating terminal" },
                { "<leader>tv", function()
                    if horiz_term:is_open() then horiz_term:close() end
                    vert_term:toggle(math.floor(vim.o.columns * 0.5))
                end, desc = "[v]ertical split terminal" },
                { "<leader>ts", function()
                    if vert_term:is_open() then vert_term:close() end
                    horiz_term:toggle()
                end, desc = "[s]plit horizontal terminal" },
                { "<leader>tc", function() claude_term:toggle() end, desc = "[c]laude" },
            },
        })
    end,
}
