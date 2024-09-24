return {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        signs = false,
        -- Set the keywords so the format must be: "<space><keyword>:". This is done to force a convention and for nicer highlighting.
        keywords = {
            FIXME_ = {
                color = "error",
                alt = { "FIXME:", "BUG:", "ISSUE:", "ERROR:" },
            },
            TODO_ = { color = "info", alt = { "TODO:" } },
            HACK_ = { color = "warning", alt = { "HACK:" } },
            WARNING_ = { color = "warning", alt = { "WARNING:" } },
            NOTE_ = { color = "hint", alt = { "NOTE:" } },
            TEST_ = { color = "test", alt = { "TEST:" } },
            PASSED_ = { color = "#32CD32", alt = { "PASSED:" } },
            FAILED_ = { color = "#D22B2B", alt = { "FAILED:" } },
        },
        gui_style = {
            fg = "NONE", -- The gui style to use for the fg highlight group.
            bg = "BOLD", -- The gui style to use for the bg highlight group.
        },
        merge_keywords = false,
        highlight = {
            multiline = true, -- enable multine todo comments
            multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
            multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
            before = "", -- "fg" or "bg" or empty
            keyword = "bg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
            after = "fg", -- "fg" or "bg" or empty
            pattern = [[.* <(KEYWORDS)\s*]], -- pattern or table of patterns, used for highlighting (vim regex)
            comments_only = true, -- uses treesitter to match keywords in comments only
            max_line_len = 400, -- ignore lines longer than this
            exclude = {}, -- list of file types to exclude highlighting
        },

    },
}

