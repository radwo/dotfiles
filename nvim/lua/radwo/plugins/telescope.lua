return {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
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
                    -- Global defaults for telescope go here (if needed)
                },
                pickers = {
                    buffers = {
                        attach_mappings = function(_, map)
                            map('i', '<C-X>', actions.delete_buffer)
                            map('n', '<C-X>', actions.delete_buffer)
                            return true
                        end,
                    },
                },
            }
            require('telescope').load_extension('fzf')
            require("telescope").load_extension("grapple")
        end,
        keys = {
            { "<leader>tt", "<cmd>Telescope grapple tags<cr>", desc = "Telescope - grapple tags" },
            { "<leader>tf", "<cmd>Telescope find_files<cr>", desc = "Telescope - find files" },
            { "<leader>tb", "<cmd>Telescope buffers<cr>", desc = "Telescope - buffers" },
            {
                "<leader>ts",
                function()
                    local builtin = require('telescope.builtin')
                    builtin.grep_string({search = vim.fn.input("Grep >")})
                end,
                desc = "Telescope - grep files",
            },
        }
    }
}
