return {
    "Aietes/esp32.nvim",
    opts = function(_, opts)
        -- Espressif ships clangd (the `esp-clangd` tool) as a bare binary, with
        -- no `lib/clang/<ver>/include` beside it. clangd derives its resource
        -- directory from its own location, so without help it cannot find the
        -- compiler builtin headers (stddef.h, stdint.h, ...) and every source
        -- file reports "'stddef.h' file not found". Those headers live in the
        -- separate `esp-clang` toolchain, so point clangd at that one.
        --
        -- IDF_TOOLS_PATH already ends in `tools` on an EIM install but not on a
        -- classic one, so try both layouts rather than assuming either.
        local bases = {}
        if vim.env.IDF_TOOLS_PATH then
            table.insert(bases, vim.env.IDF_TOOLS_PATH)
            table.insert(bases, vim.fs.joinpath(vim.env.IDF_TOOLS_PATH, "tools"))
        end
        table.insert(bases, vim.fs.joinpath(vim.env.HOME, ".espressif", "tools"))

        for _, base in ipairs(bases) do
            local found = vim.fn.glob(vim.fs.joinpath(base, "esp-clang", "*", "esp-clang", "lib", "clang", "*"), true, true)
            if #found > 0 then
                table.sort(found)

                opts.clangd_args = opts.clangd_args or {}
                table.insert(opts.clangd_args, "--resource-dir=" .. found[#found])
                break
            end
        end

        return opts
    end,
}
