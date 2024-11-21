return {
    {
        'stevearc/dressing.nvim',
        opts = {
            input = {
                relative = "editor",
            }
        },
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'cbochs/grapple.nvim' }
        },
        config = function(_, _)
            local actions = require('telescope.actions')

            require('telescope').setup {
                defaults = {
                },
                pickers = {
                    find_files = {
                        hidden = true,
                    },
                    buffers = {
                        attach_mappings = function(_, map)
                            map('i', '<C-X>', actions.delete_buffer)
                            map('n', '<C-X>', actions.delete_buffer)
                            return true
                        end,
                    },
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                    aerial = {
                        -- Set the width of the first two columns (the second
                        -- is relevant only when show_columns is set to 'both')
                        col1_width = 4,
                        col2_width = 30,
                        -- How to format the symbols
                        format_symbol = function(symbol_path, filetype)
                            if filetype == "json" or filetype == "yaml" then
                                return table.concat(symbol_path, ".")
                            else
                                return symbol_path[#symbol_path]
                            end
                        end,
                        -- Available modes: symbols, lines, both
                        show_columns = "both",
                    },
                },
            }

            require('telescope').load_extension('fzf')
            require("telescope").load_extension("aerial")
            require("telescope").load_extension("grapple")
            require("telescope").load_extension("ui-select")
        end,
        keys = {
            { "<leader>tt", "<cmd>Telescope grapple tags<cr>", desc = "Telescope - grapple tags" },
            { "<leader>tf", "<cmd>Telescope find_files<cr>", desc = "Telescope - find files" },
            { "<leader>tb", "<cmd>Telescope buffers<cr>", desc = "Telescope - buffers" },
            { "<leader>ta", "<cmd>Telescope aerial<cr>", desc = "Telescope - document symbols" },
            { "<leader><leader>", "<cmd>Telescope oldfiles<cr>", desc = "Telescope - buffers" },
            {
                "<leader>ts",
                function()
                    local builtin = require('telescope.builtin')
                    vim.ui.input({ prompt = "Grep >" }, function(input)
                        if input then
                            builtin.grep_string({ search = input })
                        end
                    end)
                end,
                desc = "Telescope - grep files",
            },
        }
    }
}
