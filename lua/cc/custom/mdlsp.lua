vim.lsp.set_log_level 'debug'
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    callback = function()
        local client = vim.lsp.start {
            name = 'python-lsp-chris',
            cmd = { 'markdownlsp-cli' },
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
