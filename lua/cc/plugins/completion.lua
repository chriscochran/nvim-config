return {

    { -- Autocompletion
        'saghen/blink.cmp',
        event = 'VimEnter',
        version = '1.*',
        dependencies = {
            -- Snippet Engine
            {
                'L3MON4D3/LuaSnip',
                version = '2.*',
                build = (function()
                    if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                        return
                    end
                    return 'make install_jsregexp'
                end)(),
                dependencies = {
                    -- `friendly-snippets` contains a variety of premade snippets.
                    --    https://github.com/rafamadriz/friendly-snippets
                    {
                        'rafamadriz/friendly-snippets',
                        config = function()
                            require('luasnip.loaders.from_vscode').lazy_load()
                        end,
                    },
                },
                opts = {},
            },
            'folke/lazydev.nvim',
        },
        --- @module 'blink.cmp'
        --- @type blink.cmp.Config
        opts = {
            keymap = {
                -- All presets have the following mappings:
                -- ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                -- ['<C-e>'] = { 'hide' },
                -- ['<C-y>'] = { 'select_and_accept' },
                --
                -- ['<Up>'] = { 'select_prev', 'fallback' },
                -- ['<Down>'] = { 'select_next', 'fallback' },
                -- ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
                -- ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
                --
                -- ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
                -- ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
                --
                -- ['<Tab>'] = { 'snippet_forward', 'fallback' },
                -- ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
                --
                -- ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
                --
                -- No, but seriously. Please read `:help ins-completion`, it is really good!
                --
                -- See :h blink-cmp-config-keymap for defining your own keymap
                preset = 'default',

                -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
            },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                nerd_font_variant = 'mono',
            },

            completion = {
                documentation = { auto_show = false, auto_show_delay_ms = 500 },
            },

            sources = {
                default = { 'lsp', 'path', 'snippets', 'lazydev' },
                providers = {
                    lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
                },
            },

            snippets = { preset = 'luasnip' },

            -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
            -- which automatically downloads a prebuilt binary when enabled.
            --
            -- By default, we use the Lua implementation instead, but you may enable
            -- the rust implementation via `'prefer_rust_with_warning'`
            --
            -- See :h blink-cmp-config-fuzzy for more information
            fuzzy = { implementation = 'rust' },

            -- Shows a signature help window while you type arguments for a function
            signature = { enabled = true },
        },
    },
}
