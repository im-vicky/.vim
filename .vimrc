vim.g.mapleader = " "
vim.opt.timeoutlen = 300 -- Time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.ttimeoutlen = 0

-- Basic options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true


-- Lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
    "nvim-tree/nvim-tree.lua",
    "nvim-tree/nvim-web-devicons",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "neovim/nvim-lspconfig",
    "github/copilot.vim",
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",            -- use the canary branch for latest features
        dependencies = {
            { "github/copilot.vim" }, -- you already have this
            { "nvim-lua/plenary.nvim" },
        },
        opts = {
            -- optional: auto-mount keymaps
            show_help = true,
        },
        keys = {
            -- Toggle chat split view
            {
                "<leader>cc",
                function() require("CopilotChat").toggle() end,
                desc = "Copilot Chat: Toggle Split",
            },
            {
                "<leader>ce",
                mode = { "n", "v" },
                function()
                    require("CopilotChat").explain()
                end,
                desc = "Explain Code",
            },
            {
                "<leader>cr",
                mode = { "n", "v" },
                function()
                    require("CopilotChat").ask("Review this code and suggest improvements.")
                end,
                desc = "Review Code",
            },
            {
                "<leader>ct",
                mode = { "n", "v" },
                function()
                    require("CopilotChat").ask("Write tests for this code.")
                end,
                desc = "Generate Tests",
            },
        },
    },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    }, {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require("bufferline").setup({
            options = {
                mode = "tabs",
                separator_style = "slant",
                always_show_bufferline = true,
                show_buffer_close_icons = true,
                show_close_icon = true,
                color_icons = true,
                show_tab_indicators = true,
                enforce_regular_tabs = true,
                tab_size = 20,
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(count, level)
                    local icon = level:match("error") and " " or " "
                    return " " .. icon .. count
                end,
            }
        })
    end,
},
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "mfussenegger/nvim-jdtls",
            "nvim-neotest/nvim-nio", -- Add this line
        },
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "nvim-neotest/nvim-nio" -- Add this line
        },
        config = function()
            require("dapui").setup()
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'gruvbox', -- matches your current theme
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = { 'filename' },
                    lualine_x = { 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {}
                },
            })
        end
    },
    {
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            local dashboard = require("alpha.themes.dashboard")
            local utils = require("alpha.themes.dashboard")

            -- Set header
            dashboard.section.header.val = {
                "                                                     ",
                "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
                "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
                "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
                "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
                "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
                "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
                "                                                     ",
            }

            -- Set menu
            dashboard.section.buttons.val = {
                dashboard.button("ff", "  Find files", ":Telescope find_files<CR>"),
                dashboard.button("fg", "  Live grep", ":Telescope live_grep<CR>"),
                dashboard.button("fb", "  Find buffers", ":Telescope buffers<CR>"),
                dashboard.button("e", "  Recently used files", ":Telescope oldfiles<CR>"),
                dashboard.button("s", "  Search current buffer", ":Telescope current_buffer_fuzzy_find<CR>"),
                dashboard.button("S", "  Search all files", ":Telescope live_grep<CR>"),
                dashboard.button("n", "  File Explorer", ":NvimTreeToggle<CR>"),
                dashboard.button(";r", "  Run Code", ":RunCode<CR>"),
                dashboard.button("c", "  Configuration", ":e $MYVIMRC<CR>"),
                dashboard.button("q", "  Quit", ":confirm q<CR>"),
            }

            -- Set footer
            dashboard.section.footer.val = "Happy Coding!"

            -- Set header padding
            dashboard.section.header.opts.hl = "Type"
            dashboard.section.header.opts.position = "center"

            -- Set buttons padding
            dashboard.section.buttons.opts.hl = "Keyword"
            dashboard.section.buttons.opts.position = "center"

            -- Set footer padding
            dashboard.section.footer.opts.hl = "Type"
            dashboard.section.footer.opts.position = "center"

            -- Setup
            dashboard.config.layout = {
                { type = "padding", val = 2 },
                dashboard.section.header,
                { type = "padding", val = 2 },
                dashboard.section.buttons,
                { type = "padding", val = 1 },
                dashboard.section.footer,
            }
            dashboard.config.opts.noautocmd = true

            require("alpha").setup(dashboard.config)
        end
    },
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end,
    },
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            require("gruvbox").setup({
                contrast = "hard",
                transparent_mode = false,
            })
            vim.cmd("colorscheme gruvbox")
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = true,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = true,
    },
    { "mfussenegger/nvim-jdtls" },
    {
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    java = { "google_java_format" },
                },
                format_on_save = {
                    -- Enable auto-formatting on save
                    timeout_ms = 500,
                    lsp_fallback = true,
                    async = false,
                },
            })
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        config = function()
            require("which-key").setup({})
        end,
    },
    { 'rlane/pounce.nvim' },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },
    {
        "CRAG666/code_runner.nvim",
        config = function()
            require('code_runner').setup({
                mode = "float",
                float = {
                    border = "rounded",
                    width = 0.8,
                    height = 0.8,
                    x = 0.5,
                    y = 0.5,
                },
                filetype = {
                    java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
                    python = "python -u",
                    typescript = "deno run",
                    rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt"
                },
            })
        end
    },
})

-- Replace your existing cmp setup with:
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() then
                    cmp.confirm({ select = true })
                else
                    fallback()
                end
            end
        }),
        ['<CR>'] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() then
                    cmp.confirm({ select = true })
                else
                    fallback()
                end
            end
        }),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }),
})

-- Mason auto-install LSPs
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "jdtls", "pyright" },
})

-- Shared LSP capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- LSP configurations
local lspconfig = require("lspconfig")

-- Python LSP
lspconfig.pyright.setup({
    capabilities = capabilities,
})

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.java",
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})

require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
    actions = {
        open_file = {
            quit_on_open = false,
            window_picker = {
                enable = false,
            },
        },
    },
    on_attach = function(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- Safe file opening function
        local function safe_open(filepath, cmd)
            -- Handle swap files and other attention-requiring situations
            local status, err = pcall(vim.cmd, string.format("%s %s", cmd, vim.fn.fnameescape(filepath)))
            if not status then
                -- If there's an error, try to recover
                vim.cmd('silent! e ' .. vim.fn.fnameescape(filepath))
            end
        end

        -- Override the default open behavior
        vim.keymap.set('n', '<CR>', function()
            local node = api.tree.get_node_under_cursor()
            if node.type == 'file' then
                -- Close the tree view
                api.tree.close()
                -- Safely open file in new tab
                safe_open(node.absolute_path, "tab drop")
            else
                api.node.open.edit() -- Keep default behavior for directories
            end
        end, opts('Open in new tab'))

        -- Add a mapping for opening in split
        vim.keymap.set('n', 'v', function()
            local node = api.tree.get_node_under_cursor()
            if node.type == 'file' then
                safe_open(node.absolute_path, "vsplit")
            end
        end, opts('Open in vertical split'))
    end,
})

-- Disable netrw (recommended by nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Telescope mappings
require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = require("telescope.actions").move_selection_next,
                ["<C-k>"] = require("telescope.actions").move_selection_previous,
            },
            n = {
                ["j"] = require("telescope.actions").move_selection_next,
                ["k"] = require("telescope.actions").move_selection_previous,
            },
        },
    },
}

vim.keymap.set('n', '<leader>ff', "<cmd>Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set('n', '<leader>fg', "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
vim.keymap.set('n', '<leader>fb', "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
vim.keymap.set('n', '<leader>fh', "<cmd>Telescope help_tags<CR>", { desc = "Find help" })

-- Basic keymaps
vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "J", "10j", { noremap = true, silent = true })
vim.keymap.set("n", "K", "10k", { noremap = true, silent = true })
vim.keymap.set("v", "J", "10gj", { noremap = true, silent = true })
vim.keymap.set("v", "K", "10gk", { noremap = true, silent = true })
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("i", "kk", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("n", "H", "^", { noremap = true, silent = true })
vim.keymap.set("n", "L", "$", { noremap = true, silent = true })
vim.keymap.set("v", "H", "^", { noremap = true, silent = true })
vim.keymap.set("v", "L", "$", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>e", "<Cmd>Telescope oldfiles<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>f", "/", { noremap = true, silent = true })
vim.keymap.set("n", "e", "<Cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "E", "<Cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "R", "<Cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>n", "<Cmd>NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.keymap.set('n', 's', "<cmd>Telescope current_buffer_fuzzy_find<CR>",
    { noremap = true, silent = true, desc = "Search current buffer" })
vim.keymap.set('n', 'S', "<cmd>Telescope live_grep<CR>", { noremap = true, silent = true, desc = "Search all files" })
vim.keymap.set("n", "(", "<Cmd>bprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", ")", "<Cmd>bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "U", "<C-r>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>q", ":confirm q<CR>", { noremap = true, silent = true, desc = "Quit with confirmation" })
vim.keymap.set("n", "<leader>wq", ":wq<CR>", { noremap = true, silent = true, desc = "Save and quit" })
vim.keymap.set("n", "<C-s>", ":w!<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "G", "gg", { noremap = true, silent = true })
vim.keymap.set("n", "gg", "G", { noremap = true, silent = true })
vim.keymap.set("n", ";f", function()
    require("conform").format({
        async = false,
        lsp_fallback = true,
    })
end, { desc = "Format file" })
vim.api.nvim_create_autocmd("CmdlineLeave", {
    pattern = "[/?]",
    callback = function()
        vim.schedule(function()
            vim.cmd("nohlsearch")
        end)
    end,
})

vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })

vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "f", function() require 'pounce'.pounce {} end)
vim.keymap.set("n", "F", function() require 'pounce'.pounce {} end)

-- Add these keymaps with your other Telescope mappings
vim.keymap.set('n', '<leader>fs', "<cmd>Telescope grep_string<CR>", { desc = "Find string under cursor" })
vim.keymap.set('n', '<leader>fc', "<cmd>Telescope commands<CR>", { desc = "List commands" })
vim.keymap.set('n', '<leader>fk', "<cmd>Telescope keymaps<CR>", { desc = "List keymaps" })
vim.keymap.set('n', '<leader>fr', "<cmd>Telescope lsp_references<CR>", { desc = "Find references" })
vim.keymap.set('n', '<leader>fd', "<cmd>Telescope diagnostics<CR>", { desc = "List diagnostics" })
vim.keymap.set('n', '<leader>fm', "<cmd>Telescope marks<CR>", { desc = "List marks" })
vim.keymap.set('n', '<leader>ft', "<cmd>Telescope treesitter<CR>", { desc = "List symbols" })
vim.keymap.set('n', '<leader>fg', "<cmd>Telescope git_files<CR>", { desc = "Find git files" })
vim.keymap.set('n', '<leader>fb', "<cmd>Telescope git_branches<CR>", { desc = "List git branches" })

-- Add with your other keymaps code runner
vim.keymap.set('n', ';r', ':RunCode<CR>', { noremap = true, silent = false })
vim.keymap.set('n', ';rf', ':RunFile<CR>', { noremap = true, silent = false })

-- Add these with your other keymaps
vim.keymap.set("n", "vae", "ggVG", { noremap = true, silent = true, desc = "Select entire file" })
vim.keymap.set("v", "ae", "gg0oG$", { noremap = true, silent = true, desc = "Select entire file" })

-- Other UI settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff = 5
vim.opt.showmode = true
vim.opt.incsearch = true
vim.opt.visualbell = true
vim.opt.errorbells = false
vim.opt.clipboard:append("unnamed")
vim.o.hlsearch = false
vim.o.incsearch = true
-- Add with your other vim.opt settings
vim.opt.showtabline = 2  -- Always show tabs
vim.opt.tabstop = 4      -- Number of spaces that a <Tab> counts for
vim.opt.shiftwidth = 4   -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true -- Convert tabs to spaces

-- Add with your other keymaps
-- Tab management
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { noremap = true, desc = "New tab" })
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { noremap = true, desc = "Close tab" })
vim.keymap.set('n', ')', ':tabnext<CR>', { noremap = true, desc = "Next tab" })
vim.keymap.set('n', '(', ':tabprevious<CR>', { noremap = true, desc = "Previous tab" })
vim.keymap.set('n', '<leader>to', ':tabo<CR>', { noremap = true, desc = "Close other tabs" })


-- Open new files in tabs
vim.api.nvim_create_autocmd("BufAdd", {
    callback = function()
        -- Get all windows
        local wins = vim.api.nvim_list_wins()
        -- Get current buffer
        local current_buf = vim.api.nvim_get_current_buf()
        -- Check if buffer is already displayed
        local buf_displayed = false
        for _, win in ipairs(wins) do
            if vim.api.nvim_win_get_buf(win) == current_buf then
                buf_displayed = true
                break
            end
        end
        -- If buffer is not displayed, open it in a new tab
        if not buf_displayed then
            vim.cmd("tabnew")
        end
    end
})

-- Replace the existing QuitPre autocmd with this improved version
vim.api.nvim_create_autocmd("QuitPre", {
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
        local readonly = vim.api.nvim_buf_get_option(bufnr, "readonly")

        if modified then
            vim.ui.input({
                prompt = "You have unsaved changes. Save before quitting? (y/n) ",
            }, function(input)
                if input == "y" then
                    if readonly then
                        -- Handle readonly files
                        vim.ui.input({
                            prompt = "File is readonly. Force save? (y/n) ",
                        }, function(force)
                            if force == "y" then
                                vim.cmd("write!")
                            end
                        end)
                    else
                        -- Normal save for writable files
                        vim.cmd("write")
                    end
                end
            end)
        end
    end,
})

-- Auto-save configuration
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
    pattern = { "*" },
    command = "silent! update",
    desc = "Auto-save when leaving insert mode or text is changed"
})

-- Optional: Add a visual indicator when saving
vim.api.nvim_create_autocmd("BufWritePost", {
    callback = function()
        vim.notify("File saved", vim.log.levels.INFO, { title = "Auto-save" })
    end,
})

-- Disable auto-save for alpha
vim.api.nvim_create_autocmd("FileType", {
    pattern = "alpha",
    callback = function()
        vim.opt_local.buflisted = false
        vim.opt_local.bufhidden = "wipe"
        vim.opt_local.modifiable = false
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
    end,
})

-- Replace your existing jdtls config with this:
local config = {
    cmd = { 'C:/Users/anura/AppData/Local/nvim-data/mason/bin/jdtls' },
    root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
}
require('jdtls').start_or_attach(config)

-- Create required directories
vim.fn.mkdir(vim.fn.expand('~/.cache/jdtls/config'), 'p')
vim.fn.mkdir(vim.fn.expand('~/.cache/jdtls/workspace'), 'p')

-- Start jdtls only for Java files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function()
        require('jdtls').start_or_attach(config)
    end,
})

-- Add after your LSP configurations
local dap = require('dap')
local dapui = require('dapui')

-- Automatically open dap-ui when debugging starts
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end

-- Configure Java debugger
dap.configurations.java = {
    {
        type = 'java',
        request = 'launch',
        name = "Debug (Attach) - Remote",
        hostName = "127.0.0.1",
        port = 5005,
    },
}

-- Add with your other keymaps
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set('n', '<leader>dc', dap.continue, { desc = "Continue" })
vim.keymap.set('n', '<leader>di', dap.step_into, { desc = "Step Into" })
vim.keymap.set('n', 'n', dap.step_over, { desc = "Step Over" }) -- Changed from <leader>do to n
vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = "Step Out" })
vim.keymap.set('n', '<leader>dr', dap.repl.open, { desc = "Open REPL" })
vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = "Run Last" })
vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = "Toggle UI" })
vim.keymap.set('n', '<leader>dt', dap.terminate, { desc = "Terminate" })
