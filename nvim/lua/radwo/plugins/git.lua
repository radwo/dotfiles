return {
    {
        "https://tpope.io/vim/fugitive.git",
        event = 'BufWinEnter',
        keys = {
            {
                "<leader>gd",
                function()
                    vim.cmd.Gvdiff()
                end,
                desc = "Fugitive - Git diff"
            },
        }
    },
    {
        -- GitHub support for Fugitive
        "tpope/vim-rhubarb",
    },
    {
        "lewis6991/gitsigns.nvim",
        lazy = false,
        config = function(_, _)
            require('gitsigns').setup{
                on_attach = function(bufnr)
                    local gitsigns = require('gitsigns')

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']c', function()
                        if vim.wo.diff then
                            vim.cmd.normal({']c', bang = true})
                        else
                            gitsigns.nav_hunk('next')
                        end
                    end)

                    map('n', '[c', function()
                        if vim.wo.diff then
                            vim.cmd.normal({'[c', bang = true})
                        else
                            gitsigns.nav_hunk('prev')
                        end
                    end)
                end
            }
        end,
        keys = {
            {
                "<leader>ghp",
                function()
                    local gitsigns = require('gitsigns')
                    gitsigns.preview_hunk()
                end,
                desc = "GitSigns - Preview Hunk"
            },
            {
                "<leader>gbb",
                function()
                    local gitsigns = require('gitsigns')
                    gitsigns.blame_line{full=true}
                end,
                desc = "GitSigns - Blame Line"
            },
            {
                '<leader>gbt',
                function()
                    local gitsigns = require('gitsigns')
                    gitsigns.toggle_current_line_blame()
                end,
                desc = "GitSigns - Toggle Current Line Blame"
            }
        }
    }
}
