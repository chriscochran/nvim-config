require 'config.options'
require 'config.autocmds'
require 'config.keymaps'

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- auto imports for python and other langs
require('lazy').setup({
    -- Theme first, always
    { 'f4z3r/gruvbox-material.nvim', name = 'gruvbox-material', lazy = false, priority = 1000, opts = {} },

    require 'cc.plugins.alpha',
    require 'cc.plugins.autopairs',
    require 'cc.plugins.completion', -- switch to rust fzf
    require 'cc.plugins.fileexplorer',
    require 'cc.plugins.format',
    require 'cc.plugins.gitsigns', -- (removed hunk)
    require 'cc.plugins.harpoon', -- delete num?
    require 'cc.plugins.lazygit',
    -- require 'cc.plugins.lint',
    require 'cc.plugins.lsp', -- kepmays
    require 'cc.plugins.lualine',
    -- require 'cc.plugins.mini', -- go thru keymaps and features
    -- require 'cc.plugins.neo-tree', -- bad
    require 'cc.plugins.noice',
    require 'cc.plugins.telescope',
    require 'cc.plugins.todo',
    require 'cc.plugins.treesitter',
    require 'cc.plugins.trouble',
    require 'cc.plugins.whichkey',
    require 'cc.plugins.zenmode',
}, {

    ui = {
        -- If you are using a Nerd Font: set icons to an empty table which will use the
        -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
        icons = vim.g.have_nerd_font and {} or {
            cmd = '⌘',
            config = '🛠',
            event = '📅',
            ft = '📂',
            init = '⚙',
            keys = '🗝',
            plugin = '🔌',
            runtime = '💻',
            require = '🌙',
            source = '📄',
            start = '🚀',
            task = '📌',
            lazy = '💤 ',
        },
    },
})

vim.lsp.set_log_level 'debug'
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    callback = function()
        local client = vim.lsp.start {
            name = 'python-lsp-chris',
            cmd = { '/home/chris/Development/nvim/python-lsp/dist/main' },
            root_dir = '/home/chris/Development/nvim/python-lsp/',
            on_error = function(code, _)
                vim.notify(vim.lsp.client_errors[code], vim.log.levels.WARN)
            end,
            trace = 'verbose',
        }

        if not client then
            vim.notify "Hey, you didn't do the client thing good"
            return
        end

        local output = vim.lsp.buf_attach_client(0, client)
        vim.notify('client attach success: ' .. tostring(output), vim.log.levels.INFO)
    end,
})

-- vim: ts=2 sts=2 sw=2 et
