{ config, pkgs, ... }:

let
  plugins = pkgs.vimPlugins;
  theme = config.colorScheme.palette;
  extraLuaConfig = builtins.readFile ./configs/neovim.lua;
in {
  programs.nixvim = {
    enable = true;

    globals.mapleader = " "; # Sets the leader key to space
    
    highlight = {
      VertSplit.fg = "#1e1e2e";
      VertSplit.blend = 0;
    };

    options = {
      clipboard="unnamedplus";
      number = true;         # Show line numbers
      relativenumber = true; # Show relative line numbers
      shiftwidth = 2;        # Tab width should be 2
      expandtab = true;
      tabstop = 2;
      softtabstop = 2;
      smartindent = true;
      wrap = false;
      swapfile = false;
      backup = false;
      hlsearch = false;
      incsearch = true;
      termguicolors = true;
      scrolloff = 8;
      updatetime = 50;
    };

    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
    };
    # colorschemes.base16.enable = true;
    # colorschemes.base16.customColorScheme = {
    #   base00 = "#${theme.base00}";
    #   base01 = "#${theme.base01}";
    #   base02 = "#${theme.base02}";
    #   base03 = "#${theme.base03}";
    #   base04 = "#${theme.base04}";
    #   base05 = "#${theme.base05}";
    #   base06 = "#${theme.base06}";
    #   base07 = "#${theme.base07}";
    #   base08 = "#${theme.base08}";
    #   base09 = "#${theme.base09}";
    #   base0A = "#${theme.base0A}";
    #   base0B = "#${theme.base0B}";
    #   base0C = "#${theme.base0C}";
    #   base0D = "#${theme.base0D}";
    #   base0E = "#${theme.base0E}";
    #   base0F = "#${theme.base0F}";
    # };
    
    plugins = {
      auto-session = {
        enable = true;
      };
      barbecue.enable = true;
      
      better-escape = {
        enable = true;
        mapping = ["jj"];
      };

      gitsigns.enable = true;

      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>gg" = "live_grep";
          "<leader>fz" = "current_buffer_fuzzy_find"; 
        };
        extensions = {
          fzf-native = {
            enable = true;
          };
        };
      };

      neo-tree = {
        enable = true;
        autoCleanAfterSessionRestore = true;
      };

      indent-blankline.enable = true;

      nvim-colorizer.enable = true;

      nvim-autopairs.enable = true;

      nix.enable = true;

      comment-nvim = {
        enable = true;
      };

      startup = { 
        enable = true;
        theme = "dashboard";
      };

      lint = {
        enable = true;
        lintersByFt = {
          text = ["vale"];
          json = ["jsonlint"];
          markdown = ["vale"];
          rst = ["vale"];
          ruby = ["ruby"];
          janet = ["janet"];
          inko = ["inko"];
          clojure = ["clj-kondo"];
          dockerfile = ["hadolint"];
          terraform = ["tflint"];
          typscriptreact = ["prettier_eslint"];
        };
      };

      lsp = {
        enable = true;
        servers = {
          tsserver.enable = true;
          lua-ls.enable = true;
          bashls.enable = true;
          rust-analyzer = {
            enable = true;
            installRustc = true;
            installCargo = true;
          };
          nixd.enable = true;
          html.enable = true;
          ccls.enable = true;
          cmake.enable = true;
          csharp-ls.enable = true;
          cssls.enable = true;
          gopls.enable = true;
          jsonls.enable = true;
          pyright.enable = true;
          tailwindcss.enable = true;
        };
      };

      lsp-lines.enable = true;
      treesitter = {
        enable = true;
        nixGrammars = true;
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        extraOptions.sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
        
        settings = {
          mapping = {
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          };
          window = {
            completion = {
              winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None";
              col_offset = -3;
              side_padding = 0;
            };
          };
          formatting = {
            fields = ["kind" "abbr" "menu"];
            format = ''
              function(entry, vim_item)
                local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
                local strings = vim.split(kind.kind, "%s", { trimempty = true })
                kind.kind = " " .. (strings[1] or "") .. " "
                kind.menu = "    (" .. (strings[2] or "") .. ")"

                return kind
              end
            '';
          };
        };
      };

      lsp-format.enable = true;

      none-ls = {
        enable = true;
        enableLspFormat = true;
      };

      leap.enable = true;

      toggleterm = {
        enable = true;
        highlights = {
          Normal = {
            guibg = "#${theme.base0F}";
          };
        };
        floatOpts = {
          border = "curved";
        };
      };

      illuminate = {
        enable = true;
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      lspkind-nvim
      lualine-nvim
    ];

    # FOR NEOVIDE
    extraConfigLua = extraLuaConfig;

    extraConfigVim = ''
      set noshowmode
    '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>Neotree reveal right<CR>";
        options.silent = false;
      }
      # cycles through current buffers
      {
        key = "<Tab>";
        action = ":bnext<CR>";
        options.silent = false;
      }
      # cycles through current buffers
      {
        key = "<S-Tab>";
        action = ":bprev<CR>";
        options.silent = false;
      }
      # formats buffer on save
      {
        mode = "i";
        key = "<C-s>";
        action = "<ESC>:lua SaveAndFormat()<CR>";
      }
      # formats buffer on save
      {
        mode = "n";
        key = "<C-s>";
        action = ":lua SaveAndFormat()<CR>";
      }
      # fast quit
      {
        mode = "n";
        key = "<leader>qq";
        action = ":qa!<CR>";
        options.silent = true;
      }
      # terminal toggle
      {
        mode = "n";
        key = "<M-i>";
        action = "<cmd>:ToggleTerm direction=float<CR>";
      }
      {
        mode = "t";
        key = "<M-i>";
        action = "<cmd>:ToggleTerm direction=float<CR>";
      }
      # wasd movements for buffer
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w><C-h>";
      }
      # wasd movements for buffer
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w><C-j>";
      }
      # wasd movements for buffer
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w><C-k>";
      }
      # wasd movements for buffer
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w><C-l>";
      }
      # toggles the navigation tree
      {
        mode = "n";
        key = "<C-n>";
        action = "<cmd>Neotree toggle<CR>";
      }
      # wasd movements for buffer
      {
        mode = "v";
        key = "J";
        action = ":m '>+1<CR>gv=gv";
      }
      {
        mode = "v";
        key = "K";
        action = ":m '<-2<CR>gv=gv";
      }
      # triggers lsp hover
      {
        mode = "n";
        key = "K";
        action = ":lua vim.lsp.buf.hover()<CR>";
        options.silent = true;
      }
      # jump to definition under keyword
      {
        mode = "n";
        key = "<leader>gd";
        action = ":lua vim.lsp.buf.definition()<CR>";
        options.silent = true;
      }
      # commenting stuff
      {
        mode = "n";
        key = "<C-/>";
        action = ":lua require('Comment.api').toggle.linewise.current()<CR>";
        options.silent = true;
      }
      {
        mode = "x";
        key = "<C-/>";
        action = ":lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "/e";
        action = ":lua require('Comment.api').insert.linewise.eol()<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "/o";
        action = ":lua InsertCommentWithIndentationAndEnterInsertMode()<CR>";
        options.silent = true;
      }
   ];
  };
} 
