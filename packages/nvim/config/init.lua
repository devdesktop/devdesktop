vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0

vim.g.mapleader = " "

vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.background = "dark"
vim.opt.backup = false
vim.opt.breakindent = true
vim.opt.colorcolumn = "100"
vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"
vim.opt.expandtab = true
vim.opt.fileencoding = "utf-8"
vim.opt.foldmethod = "marker"
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.incsearch = true
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = { nbsp = "󱁐", tab = "⭾ ", trail = "󰈅" }
vim.opt.mouse = ""
vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.relativenumber = true
vim.opt.scrolloff = 999
vim.opt.shiftwidth = 2
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.title = true
vim.opt.titlestring = "󱃖 %{expand('%:h:t')}/%{expand('%:t')}"
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.virtualedit = "block"

vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

vim.keymap.set("n", "<leader>l", vim.diagnostic.setloclist, { desc = "Open quickfix list" })

vim.keymap.set("n", "<C-k>", "<cmd>bprevious<cr>")
vim.keymap.set("n", "<C-j>", "<cmd>bnext<cr>")
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>")
vim.keymap.set("n", "<M-k>", "<cmd>cprevious<cr>")
vim.keymap.set("n", "<M-j>", "<cmd>cnext<cr>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>")
vim.keymap.set("n", "m", "q")
vim.keymap.set("n", "q", "<cmd>bdelete<cr>")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  checker = { enabled = true },

  spec = {
    {
      "AckslD/nvim-neoclip.lua",
      lazy = false,
      keys = {
        { "<leader>ey", "<cmd>Telescope neoclip<cr>", desc = "Yank history" },
      },
      dependencies = {
        { "nvim-telescope/telescope.nvim" },
      },
      opts = {},
    },

    { "Bilal2453/luvit-meta", lazy = true },
    { "HiPhish/rainbow-delimiters.nvim", main = "rainbow-delimiters.setup", opts = {} },
    { "Kasama/nvim-custom-diagnostic-highlight", opts = {} },

    {
      "RRethy/nvim-treesitter-endwise",
      main = "nvim-treesitter.configs",
      opts = {
        endwise = {
          enable = true,
        },
      },
    },

    {
      "Wansmer/treesj",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      keys = {
        {
          "gs",
          function()
            require("treesj").toggle()
          end,
          desc = "Toggle single line/multiline",
        },
      },
      opts = {
        use_default_keymaps = false,
      },
    },

    {
      "akinsho/git-conflict.nvim",
      version = "*",
      dependencies = "nvim-tree/nvim-web-devicons",
      opts = {},
    },

    {
      "andymass/vim-matchup",
      main = "nvim-treesitter.configs",
      opts = {
        matchup = { enable = true },
      },
    },

    { "brenoprata10/nvim-highlight-colors", opts = {} },
    { "direnv/direnv.vim" },

    {
      "echasnovski/mini.ai",
      opts = {},
      dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    },

    { "echasnovski/mini.align", opts = {} },
    { "echasnovski/mini.bracketed", opts = {} },
    { "echasnovski/mini.diff", opts = {} },
    { "echasnovski/mini.move", opts = {} },

    {
      "ellisonleao/gruvbox.nvim",
      priority = 1000,
      config = function()
        require("gruvbox").setup({
          contrast = "hard",
          inverse = true,
          invert_selection = true,
          invert_signs = true,
          overrides = {
            NeotreeNormal = { bg = "#282828" },
            NeotreeNormalNC = { bg = "#282828" },
            NeotreeWinSeparator = { fg = "#282828", bg = "#282828" },
            NotifyBackground = { bg = "#282828" },
            WhichKeyNormal = { bg = "#282828" },
          },
        })
      end,
    },

    { "fladson/vim-kitty", ft = "kitty" },

    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "luvit-meta/library", words = { "vim%.uv" } },
        },
      },
    },

    {
      "folke/snacks.nvim",
      opts = {
        indent = {},
        notifier = {},
        statuscolumn = {},
      },
    },

    {
      "folke/todo-comments.nvim",
      event = "VimEnter",
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = { signs = false },
    },

    {
      "folke/which-key.nvim",
      event = "VimEnter",
      opts = {
        icons = {
          mappings = true,
        },
        preset = "helix",
        spec = {
          { "<leader>/", group = "Search" },
          { "<leader>c", group = "Code" },
          { "<leader>d", group = "Document" },
          { "<leader>e", group = "Edit" },
          { "<leader>h", group = "Help" },
          { "<leader>r", group = "Refactor" },
          { "<leader>v", group = "Version Control" },
          { "<leader>w", group = "Workspace" },
        },
        win = {
          border = "none",
        },
      },
    },

    {
      "ggandor/flit.nvim",
      opts = {
        labeled_modes = "nv",
        multiline = false,
      },
    },

    {
      "ggandor/leap.nvim",
      dependencies = { "tpope/vim-repeat" },
      keys = {
        { "s", "<Plug>(leap-forward)", desc = "Leap forward", mode = { "n" } },
        { "S", "<Plug>(leap-backward)", desc = "Leap backward", mode = { "n" } },
      },
    },

    {
      "saghen/blink.cmp",
      version = "*",
      opts = {
        completion = {
          menu = {
            draw = {
              components = {
                kind_icon = {
                  highlight = function(ctx)
                    local highlight = "BlinkCmpKind" .. ctx.kind

                    if ctx.item.source_name == "LSP" then
                      local color_item =
                        require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                      if color_item and color_item.abbr_hl_group then
                        highlight = color_item.abbr_hl_group
                      end
                    end

                    return highlight
                  end,
                  text = function(ctx)
                    local icon = ctx.kind_icon

                    if ctx.item.source_name == "LSP" then
                      local color_item =
                        require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                      if color_item and color_item.abbr then
                        icon = color_item.abbr
                      end
                    end

                    return icon .. ctx.icon_gap
                  end,
                },
              },
            },
          },
        },

        keymap = {
          ["<Up>"] = { "select_prev" },
          ["<Down>"] = { "select_next" },
          ["<Right>"] = { "select_and_accept" },
        },
        signature = { enabled = true },
      },
      opts_extend = { "sources.default" },
    },

    { "kevinhwang91/nvim-bqf", ft = "qf", opts = {} },
    { "kylechui/nvim-surround", version = "*", event = "VeryLazy", opts = {} },
    { "lukas-reineke/virt-column.nvim", opts = {} },

    {
      "mfussenegger/nvim-lint",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        local lint = require("lint")
        local group = vim.api.nvim_create_augroup("timbuktu-lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
          group = group,
          callback = function()
            lint.try_lint()
          end,
        })
      end,
    },

    {
      "neovim/nvim-lspconfig",
      config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
          group = vim.api.nvim_create_augroup("timbuktu-lsp-attach", { clear = true }),
          callback = function(event)
            local map = function(keys, func, desc)
              vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
            end

            local builtin = require("telescope.builtin")

            map("gd", builtin.lsp_definitions, "Go to definition")
            map("gr", builtin.lsp_references, "Go to references")
            map("<leader>ca", vim.lsp.buf.code_action, "Code action")
            map("<leader>dd", "<cmd>FzfLua diagnostics_document<cr>", "Diagnostics")
            map("<leader>ds", "<cmd>FzfLua lsp_document_symbols<cr>", "Symbols")
            map("<leader>wd", "<cmd>FzfLua diagnostics_workspace<cr>", "Diagnostics")
            map("<leader>ws", "<cmd>FzfLua lsp_workspaced_symbols<cr>", "Symbols")
            map("<leader>rn", vim.lsp.buf.rename, "Rename")

            local client = vim.lsp.get_client_by_id(event.data.client_id)
            if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
              local highlight_augroup = vim.api.nvim_create_augroup("timbuktu-lsp-highlight", { clear = false })

              vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
              })

              vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
              })

              vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("timbuktu-lsp-detach", { clear = true }),
                callback = function(event2)
                  vim.lsp.buf.clear_references()
                  vim.api.nvim_clear_autocmds({
                    group = "timbuktu-lsp-highlight",
                    buffer = event2.buf,
                  })
                end,
              })
            end
          end,
        })

        local servers = {
          bashls = {},
          eslint = {},
          html = {},
          jsonls = {},
          lua_ls = {
            settings = {
              Lua = {
                completion = {
                  callSnippet = "Replace",
                },
                diagnostics = { disable = { "missing-fields" } },
              },
            },
          },
          ruby_lsp = {},
          tailwindcss = {},
          ts_ls = {},
          yamlls = {},
        }

        require("mason").setup()

        local ensure_installed = vim.tbl_keys(servers)
        vim.list_extend(ensure_installed, {
          "stylua",
        })

        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        require("mason-lspconfig").setup({
          handlers = {
            function(server_name)
              local server = servers[server_name] or {}
              require("lspconfig")[server_name].setup(server)
            end,
          },
        })
      end,
      dependencies = {
        { "williamboman/mason.nvim", config = true },
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
      },
    },

    {
      "nvim-lualine/lualine.nvim",
      dependencies = "nvim-tree/nvim-web-devicons",
      opts = {
        options = {
          theme = "gruvbox",
        },
      },
    },

    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
      },
    },

    {
      "nvim-telescope/telescope.nvim",
      lazy = false,
      dependencies = {
        { "debugloop/telescope-undo" },
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        { "nvim-telescope/telescope-ui-select.nvim" },
      },
      keys = {
        { "<leader>eu", "<cmd>Telescope undo<cr>", desc = "Undo history" },
        { "<leader>//", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
        { "<leader>F", "<cmd>Telescope buffers<cr>", desc = "Open buffer" },
        { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Open file" },
        { "<leader>hc", "<cmd>Telescope highlights<cr>", desc = "Colors" },
        { "<leader>hh", "<cmd>Telescope helptags<cr>", desc = "Tags" },
        { "<leader>hk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
      },
      config = function()
        require("telescope").setup({
          defaults = {
            layout_config = {
              vertical = { mirror = true, preview_height = 0.5, prompt_position = "top" },
            },
            prompt_prefix = "  ",
            sorting_strategy = "ascending",
          },
          extensions = {
            ["ui-select"] = {
              require("telescope.themes").get_dropdown(),
            },
          },
        })

        require("telescope").load_extension("fzf")
        require("telescope").load_extension("ui-select")
        require("telescope").load_extension("undo")
      end,
    },

    { "nvim-tree/nvim-web-devicons" },

    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      main = "nvim-treesitter.configs",
      opts = {
        ensure_installed = {
          "bash",
          "eex",
          "elixir",
          "embedded_template",
          "heex",
          "html",
          "lua",
          "luadoc",
          "markdown",
          "markdown_inline",
          "regex",
          "ruby",
          "terraform",
          "vim",
          "vimdoc",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "ruby" },
        },
        indent = {
          enable = true,
          disable = { "ruby" },
        },
      },
    },

    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      main = "nvim-treesitter.configs",
      opts = {
        textobjects = {
          lsp_interop = {
            enable = true,
          },
          move = {
            enable = true,
            goto_next_start = {
              ["<M-a>"] = "@parameter.inner",
              ["<M-f>"] = "@function.outer",
              ["<M-b>"] = "@block.outer",
            },
            goto_prev_start = {
              ["<M-S-a>"] = "@parameter.inner",
              ["<M-S-f>"] = "@function.outer",
              ["<M-S-b>"] = "@block.outer",
            },
          },
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["gwa"] = "@parameter.inner",
            },
            swap_previous = {
              ["gwA"] = "@parameter.inner",
            },
          },
        },
      },
    },

    { "okuuva/auto-save.nvim", lazy = false, opts = {} },
    { "rachartier/tiny-glimmer.nvim", event = "TextYankPost", opts = {} },

    {
      "stevearc/conform.nvim",
      event = "BufWritePre",
      cmd = { "ConformInfo" },
      keys = {
        {
          "<leader>df",
          function()
            require("conform").format({
              async = true,
              lsp_fallback = true,
            })
          end,
          mode = "",
          desc = "Format buffer",
        },
      },
      opts = {
        format_on_save = function()
          local cwd = vim.fn.getcwd()

          if not string.find(cwd, "Projects/ar/") then
            return { timeout_ms = 500, lsp_format = "fallback" }
          end
        end,
        formatters_by_ft = {
          elixir = { "mix" },
          eelixir = { "mix" },
          heex = { "mix" },
          lua = { "stylua" },
          ruby = { "rubocop" },
          ["*"] = { "trim_whitespace" },
        },
        notify_on_error = false,
      },
    },

    {
      "stevearc/quicker.nvim",
      ft = "qf",
      opts = {
        keys = {
          {
            ">",
            function()
              require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
            end,
            desc = "Expand quickfix context",
          },
          {
            "<",
            function()
              require("quicker").collapse()
            end,
            desc = "Collapse quickfix context",
          },
        },
      },
    },

    { "windwp/nvim-autopairs", event = { "InsertEnter" }, opts = {} },
    { "windwp/nvim-ts-autotag", event = { "InsertEnter" }, opts = {} },
  },
})

vim.cmd.colorscheme("gruvbox")
