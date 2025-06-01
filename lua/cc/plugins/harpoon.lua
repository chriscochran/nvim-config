return {
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { 'nvim-lua/plenary.nvim' },

        config = function()
            local harpoon = require 'harpoon'
            harpoon:setup()

            -- Add and Menu
            vim.keymap.set('n', '<leader>ha', function()
                harpoon:list():add()
            end, { desc = '[H]arpoon toggle [a]dd file' })

            vim.keymap.set('n', '<leader>hm', function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end, { desc = '[H]arpoon toggle quick menu' })

            -- Selecting
            vim.keymap.set('n', '<leader>hh', function()
                harpoon:list():select(1)
            end, { desc = '[H]arpoon select 1' })

            vim.keymap.set('n', '<leader>hj', function()
                harpoon:list():select(2)
            end, { desc = '[H]arpoon select 2' })

            vim.keymap.set('n', '<leader>hk', function()
                harpoon:list():select(3)
            end, { desc = '[H]arpoon select 3' })

            vim.keymap.set('n', '<leader>hl', function()
                harpoon:list():select(4)
            end, { desc = '[H]arpoon select 4' })

            -- Toggle previous & next buffers stored within Harpoon list
            vim.keymap.set('n', '<C-S-P>', function()
                harpoon:list():prev()
            end, { desc = 'Toggle previous buffer' })

            vim.keymap.set('n', '<C-S-N>', function()
                harpoon:list():next()
            end, { desc = 'Toggle next buffer' })
        end,
    },
}
