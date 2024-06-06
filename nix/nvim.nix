{ pkgs, ... }: {
  programs.nixvim = {
    enable = true;

    defaultEditor = true;

    clipboard = {
      register = "unnamedplus";

      providers.wl-copy.enable = true;
    };

    colorschemes.gruvbox = {
      enable = true;

      settings = {
        overrides = {
          NormalFloat = {
            bg = "#101010";
          };
        };

        transparent_mode = true;
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      neodev-nvim
      vim-repeat
    ];

    globals = {
      loaded_ruby_provider = 0;
      loaded_perl_provider = 0;
      loaded_python_provider = 0;
      mapleader = " ";
    };

    keymaps = let
      withDefaults = kms:
        map (km: {
          inherit (km) action key;

          options = {
            noremap = true;
            silent = true;
          };
        }) kms;
    in withDefaults [
      { key = "<leader><leader>"; action = "<cmd>nohlsearch<cr>"; }
      { key = "<c-k>";            action = "<cmd>m-2<cr>=="; }
      { key = "<c-j>";            action = "<cmd>m+1<cr>=="; }

      { key = "m";                action = "q"; }
      { key = "q";                action = "<cmd>q<cr>"; }
    ];

    plugins = {
      auto-save.enable = true;

      cmp = {
        enable = true;

        autoEnableSources = true;

        settings = {
          sources = [
            { name = "buffer"; }
            { name = "cmdline"; }
            { name = "cmdline-history"; }
            { name = "git"; }
            { name = "path"; }
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            {
              name = "buffer";
              option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
            }
          ];
        };
      };

      cmp-buffer.enable = true;
      cmp-cmdline.enable = true;
      cmp-cmdline-history.enable = true;
      cmp-git.enable = true;
      cmp-path.enable = true;

      comment.enable = true;

      direnv.enable = true;
      fidget.enable = true;
      gitsigns.enable = true;
      leap.enable = true;
      lint.enable = true;
      luasnip.enable = true;

      lsp = {
        enable = true;

        servers = {
          cssls.enable = true;
          eslint.enable = true;

          html = {
            enable = true;
            filetypes = [ "eruby" "html" ];
          };

          jsonls.enable = true;
          lua-ls.enable = true;
          nil-ls.enable = true;
          nushell.enable = true;

          solargraph = {
            enable = true;
            package = null;
          };

          tailwindcss.enable = true;
          tsserver.enable = true;
        };
      };

      lspkind = {
        enable = true;

        mode = "symbol";

        cmp.enable = true;
      };

      mini = {
        enable = true;

        modules = {
          align = {};
        };
      };

      neo-tree.enable = true;
      nvim-autopairs.enable = true;
      nvim-colorizer.enable = true;
      surround.enable = true;

      telescope = {
        enable = true;

        extensions = {
          fzf-native.enable = true;
          undo.enable = true;
        };
      };

      treesitter = {
        enable = true;

        grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;

        incrementalSelection.enable = true;
        indent = true;

        nixvimInjections = true;
      };

      treesitter-textobjects = {
        enable = true;

        lspInterop.enable = true;
        move.enable = true;
        select.enable = true;
        swap.enable = true;
      };

      trouble.enable = true;
      which-key.enable = true;

      yanky = {
        enable = true;
        ring.storage = "sqlite";
      };
    };

    opts = {
      autoindent = true;
      autoread = true;
      autowrite = true;
      background = "dark";
      backup = false;
      colorcolumn = [ 120 ];
      completeopt = [ "menu" "menuone" "noinsert" "preview" ];
      cursorline = true;
      cursorlineopt = "both";
      expandtab = true;
      fileencoding = "utf-8";
      foldmethod = "marker";
      guifont = "Iosevka Timbuktu:h12";
      hidden = true;
      hlsearch = true;
      ignorecase = true;
      inccommand = "split";
      incsearch = true;
      list = true;
      listchars = {
        tab = "⭾ ";
        trail = "󰈅";
        nbsp = "󱁐";
      };
      mouse = "";
      number = true;
      numberwidth = 4;
      relativenumber = true;
      scrolloff = 999;
      shiftwidth = 2;
      signcolumn = "yes";
      smartcase = true;
      splitbelow = true;
      splitright = false;
      swapfile = false;
      termguicolors = true;
      timeout = true;
      timeoutlen = 300;
      title = true;
      titlestring = "%F";
      undofile = true;
      updatetime = 100;
      virtualedit = "block";
    };
  };
}