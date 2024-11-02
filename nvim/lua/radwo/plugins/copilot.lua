local prompts = {
  -- Code related prompts
  Explain = "Please explain how the following code works.",
  Review = "Please review the following code and provide suggestions for improvement.",
  Tests = "Please explain how the selected code works, then generate unit tests for it.",
  Refactor = "Please refactor the following code to improve its clarity and readability.",
  FixCode = "Please fix the following code to make it work as intended.",
  FixError = "Please explain the error in the following text and provide a solution.",
  BetterNamings = "Please provide better names for the following variables and functions.",
  Documentation = "Please provide documentation for the following code.",
  SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
  SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
  -- Text related prompts
  Summarize = "Please summarize the following text.",
  Spelling = "Please correct any grammar and spelling errors in the following text.",
  Wording = "Please improve the grammar and wording of the following text.",
  Concise = "Please rewrite the following text to make it more concise.",


  Commit = "Write commit message for the change with commitizen convention",
  CommitStaged = "Write commit message for the change with commitizen convention",
}

return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        enabled = false,
        dev = false,
        branch = "canary",
        dependencies = {
            { "nvim-telescope/telescope.nvim" }, -- Use telescope for help actions
            { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
            { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
        },
        build = "make tiktoken",
        keys = {
            -- Show help actions with telescope
            {
                "<leader>ah",
                function()
                    local actions = require("CopilotChat.actions")
                    require("CopilotChat.integrations.telescope").pick(actions.help_actions())
                end,
                desc = "CopilotChat - Help actions",
            },
            -- Show prompts actions with telescope
            {
                "<leader>ap",
                function()
                    local actions = require("CopilotChat.actions")
                    local select = require("CopilotChat.select")
                    require("CopilotChat.integrations.telescope").pick(actions.prompt_actions({
                        selection = select.visual,
                    }))
                end,
                desc = "CopilotChat - Prompt actions",
            },
            {
                "<leader>ap",
                ":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
                mode = "x",
                desc = "CopilotChat - Prompt actions",
            },
            -- Chat with Copilot in visual mode
            {
                "<leader>av",
                ":CopilotChat<cr>",
                mode = "x",
                desc = "CopilotChat - Open in vertical split",
            },
            {
                "<leader>ai",
                function()
                    local input = vim.fn.input("Quick Chat: ")
                    local mode = vim.fn.mode()

                    if input ~= "" then
                        if mode == "n" then
                            require("CopilotChat").ask(input)
                        else
                            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").selection })
                        end
                    end
                end,
                desc = "CopilotChat - Quick chat",
                mode = {"n", "v"}
            },
            {
                "<leader>ax",
                ":CopilotChatInline<cr>",
                mode = "x",
                desc = "CopilotChat - Inline chat",
            },
            -- Generate commit message based on the git diff
            {
                "<leader>am",
                "<cmd>CopilotChatCommit<cr>",
                desc = "CopilotChat - Generate commit message for all changes",
            },
            {
                "<leader>aM",
                "<cmd>CopilotChatCommitStaged<cr>",
                desc = "CopilotChat - Generate commit message for staged changes",
            },
            -- Debug
            { "<leader>ad", "<cmd>CopilotChatDebugInfo<cr>", desc = "CopilotChat - Debug Info" },
            -- Fix the issue with diagnostic
            { "<leader>af", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix Diagnostic" },
            -- Clear buffer and chat history
            { "<leader>al", "<cmd>CopilotChatReset<cr>", desc = "CopilotChat - Clear buffer and chat history" },
            -- Toggle Copilot Chat Vsplit
            { "<leader>av", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
            -- Copilot Chat Models
            { "<leader>a?", "<cmd>CopilotChatModels<cr>", desc = "CopilotChat - Select Models" },
        },
        opts = {
            debug = false, -- Enable debugging
            model = 'claude-3.5-sonnet',
            prompts = prompts,
            auto_insert_mode = true,
            show_help = false,
            mappings = {
                -- Use tab for completion
                complete = {
                    detail = "Use @<Tab> or /<Tab> for options.",
                    insert = "<Tab>",
                },
                -- Close the chat
                close = {
                    normal = "q",
                    insert = "<C-c>",
                },
                -- Reset the chat buffer
                reset = {
                    normal = "<C-x>",
                    insert = "<C-x>",
                },
                -- Submit the prompt to Copilot
                submit_prompt = {
                    normal = "<CR>",
                    insert = "<C-CR>",
                },
                -- Accept the diff
                accept_diff = {
                    normal = "<C-y>",
                    insert = "<C-y>",
                },
                -- Yank the diff in the response to register
                yank_diff = {
                    normal = "gmy",
                },
                -- Show the diff
                show_diff = {
                    normal = "gmd",
                },
                -- Show the prompt
                show_system_prompt = {
                    normal = "gmp",
                },
                -- Show the user selection
                show_user_selection = {
                    normal = "gms",
                },
                -- Show help
                show_help = {
                    normal = "gmh",
                },
            }
        },
        config = function(_, opts)
            local chat = require("CopilotChat")
            local select = require("CopilotChat.select")

            -- Override the git prompts message
            opts.prompts.Commit = {
                prompt = "Write commit message for the change with commitizen convention",
                selection = select.gitdiff,
            }
            opts.prompts.CommitStaged = {
                prompt = "Write commit message for the change with commitizen convention",
                selection = function(source)
                    return select.gitdiff(source, true)
                end,
            }

            chat.setup(opts)

            vim.api.nvim_create_user_command("CopilotChatInline", function(args)
                chat.ask(args.args, {
                    selection = select.visual,
                    window = {
                        layout = "float",
                        relative = "cursor",
                        width = 1,
                        height = 0.4,
                        row = 1,
                    },
                })
            end, { nargs = "*", range = true })

            -- Custom buffer for CopilotChat
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = "copilot-*",
                callback = function()
                    vim.opt_local.relativenumber = true
                    vim.opt_local.number = true
                end,
            })
        end,
    }
}
