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

        require("which-key").add({
            {
                mode = { "n" },
                { "<leader>t",  group = "[T]erminal..." },
                { "<leader>tf", function() vim.cmd("ToggleTerm direction=float") end,         desc = "[f]loating terminal" },
                { "<leader>tv", function() vim.cmd("2ToggleTerm direction=vertical") end,     desc = "[v]ertical split terminal" },
                { "<leader>th", function() vim.cmd("3ToggleTerm direction=horizontal") end,   desc = "[h]orizontal split terminal" },
                { "<leader>tc", function() claude_term:toggle() end,                          desc = "[c]laude" },
            },
        })
    end,
}
