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
                    lualine_c = {{'filename', path = 1}, {"aerial", dense = true}},
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
}
