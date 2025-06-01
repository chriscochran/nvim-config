return {
    {
        'folke/zen-mode.nvim',
        opts = {},
        config = function()
            local zenmode = require 'zen-mode'
            vim.keymap.set('n', '<leader>zm', function()
                zenmode.toggle()
            end, { desc = 'Toggle [Z]en [M]ode' })
        end,
    },
}
