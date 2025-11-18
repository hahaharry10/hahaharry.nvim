return {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter", -- lazy load on insert
    config = function()
        require("copilot").setup({
            suggestion = {
                enabled = true,
                auto_trigger = true, -- automatically show suggestions
                debounce = 75,
                keymap = {
                    accept = "<Tab>", -- change to your preferred key
                    accept_word = false,
                    accept_line = false,
                    next = "<M-n>",
                    prev = "<M-N>",
                    dismiss = "<M-m>",
                },
            },

            panel = {
                enabled = true,
                auto_refresh = true,
                keymap = {
                    jump_prev = "<M-[>",
                    jump_next = "<M-]>",
                    accept = "<CR>",
                    refresh = "gr",
                    open = "<M-CR>"
                },
            },
            -- panel = {
            --     enabled = false, -- disable side panel unless you want it
            -- },
            filetypes = {
                ["*"] = true, -- enable for all filetypes
                [""] = true,
            },
        })
    end,
}

