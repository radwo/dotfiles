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
                },
            }
            require('telescope').load_extension('fzf')
            require("telescope").load_extension("grapple")
            require("telescope").load_extension("ui-select")
        end,
        keys = {
            { "<leader>tt", "<cmd>Telescope grapple tags<cr>", desc = "Telescope - grapple tags" },
            { "<leader>tf", "<cmd>Telescope find_files<cr>", desc = "Telescope - find files" },
            { "<leader>tb", "<cmd>Telescope buffers<cr>", desc = "Telescope - buffers" },
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
