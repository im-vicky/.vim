vim.g.mapleader = " "

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
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
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

-- Replace the existing cmp setup with:
local cmp = require("cmp")
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<TAB>'] = cmp.mapping({
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
    sources = {
        { name = 'nvim_lsp' },
    },
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

-- NvimTree setup
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
vim.keymap.set("n", "<leader>w", ":w!<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "G", "gg", { noremap = true, silent = true })
vim.keymap.set("n", "gg", "G", { noremap = true, silent = true })
vim.keymap.set("n", ";f", vim.lsp.buf.format, { desc = "Format file" })
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

vim.api.nvim_create_autocmd("QuitPre", {
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
        if modified then
            vim.ui.input({
                prompt = "You have unsaved changes. Save before quitting? (y/n) ",
            }, function(input)
                if input == "y" then
                    vim.cmd("write")
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
