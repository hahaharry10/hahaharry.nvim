return {
    'inkarkat/vim-mark',
    dependencies = { 'inkarkat/vim-ingo-library' },
    init = function()
        vim.g.mwDefaultHighlightingPalette = 'maximum'
        vim.g.mw_no_mappings = 1
    end,
}
