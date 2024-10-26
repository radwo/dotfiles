return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            local function window()
                return vim.api.nvim_win_get_number(0)
            end

            local function diff_source()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                    return {
                        added = gitsigns.added,
                        modified = gitsigns.changed,
                        removed = gitsigns.removed
                    }
                end
            end

            require('lualine').setup {
                options = {
                    globalstatus = true,
                },
                sections = {
                    lualine_b = { window, 'b:gitsigns_head', {'diff', source = diff_source}, "diagnostics" },
                    lualine_c = {{'filename', path = 1}},
                    lualine_x = { "grapple", 'encoding', {
                        'fileformat',
                        icons_enabled = true,
                        symbols = {
                            unix = 'LF',
                            dos = 'CRLF',
                            mac = 'CR',
                        },
                    }, 'filetype'},
                },
                extensions = {'fugitive', 'quickfix'}
            }
        end,
    },
    {
        'b0o/incline.nvim',
        config = function()
            require('incline').setup {
                hide = {
                    focused_win = true,
                },
                render = function(props)
                    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
                    if filename == '' then
                        filename = '[No Name]'
                    end

                    local function get_git_diff()
                        local icons = { removed = '-', changed = '~', added = '+' }
                        local signs = vim.b[props.buf].gitsigns_status_dict
                        local labels = {}
                        if signs == nil then
                            return labels
                        end
                        for name, icon in pairs(icons) do
                            if tonumber(signs[name]) and signs[name] > 0 then
                                table.insert(labels, { icon .. signs[name] .. ' ', group = 'Diff' .. name })
                            end
                        end
                        if #labels > 0 then
                            table.insert(labels, { '┊ ' })
                        end
                        return labels
                    end

                    local function get_diagnostic_label()
                        local icons = { error = '', warn = '', info = '', hint = '' }
                        local label = {}

                        for severity, icon in pairs(icons) do
                            local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
                            if n > 0 then
                                table.insert(label, { icon .. n .. ' ', group = 'DiagnosticSign' .. severity })
                            end
                        end
                        if #label > 0 then
                            table.insert(label, { '┊ ' })
                        end
                        return label
                    end

                    return {
                        { get_diagnostic_label() },
                        { get_git_diff() },
                        { filename .. ' ', gui = vim.bo[props.buf].modified and 'bold,italic' or 'bold' },
                    }
                end,
            }
        end,
    },
}
