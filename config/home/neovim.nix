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

    colorschemes.oxocarbon.enable = true;
   
    plugins = {
      auto-session.enable = true;

      barbecue.enable = true;

      barbar = {
        enable = true;
        autoHide = true;
        insertAtEnd = true;
        animation = false;
        excludeFileNames = ["neo-tree" "Trouble" "toggleterm"];
        icons = {
          separator.left = "@";
          diagnostics = {
            error = {
              enable = true;
              icon = "";
            };
          };
        };
      };
      
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

      indent-blankline = {
        enable = true;
        scope = {
          showStart = false;
          showEnd = false;
        };
      };

      nvim-colorizer.enable = true;

      nvim-autopairs.enable = true;

      nix.enable = true;

      comment-nvim = {
        enable = true;
      };

      # startup = { 
      #   enable = true;
      #   theme = "dashboard";
      # };

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
      
      lspsaga = {
        enable = true;
        lightbulb.enable = false;
      };

      trouble = {
        enable = true;
      };
      
      treesitter = {
        enable = true;
        nixGrammars = true;
      };

      cmp_luasnip.enable = true;

      luasnip.enable = true;
      
      cmp = {
        enable = true;
        autoEnableSources = true;
        extraOptions.sources = [
          # { name = "copilot"; }
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
        
        settings = {
          mapping = {
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = ''cmp.mapping(function(fallback) HandleCmpTab(fallback) end, {'i', 's'})'';
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          };
          window = {
            completion = {
                col_offset = -3;
                side_padding = 0;
                expandable_indicator = true;
              };
            documentation = {
              winhighlight = "Normal:CmpDocNormal";
            };
          };
          formatting = {
            fields = ["kind" "abbr" "menu"];
            format = ''
              function(entry, vim_item)
                local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
                local strings = vim.split(kind.kind, "%s", { trimempty = true })
                kind.kind = " " .. (strings[1] or "") .. " "
                kind.menu = "    [" .. (strings[2] or "") .. "]"

                return kind
              end
            '';
          };
          snippet.expand = ''
            function(args)
              require('luasnip').lsp_expand(args.body)
            end
          '';
        };
      };

      copilot-cmp = {
        enable = false;
      };
        
      copilot-lua = {
        enable = true;        
        suggestion = {
          enabled = true;
          autoTrigger = true;
          keymap = {
            accept = false;
            acceptLine = "<S-Tab>";
          };
        };
        panel.enabled = false;
      };

      lsp-format.enable = true;

      none-ls = {
        enable = true;
        enableLspFormat = true;
        onAttach = ''
          function(client, bufnr)
            if client.supports_method("textDocument/formatting") then
              vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
              vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                  -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                  -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                  -- vim.lsp.buf.formatting_sync()
                  vim.lsp.buf.format({ async = false })
                end,
              })
            end
          end'';
        sources = {
          formatting = {
            prettierd = {
              enable = true;
            };
          };
        };
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
      ChatGPT-nvim
      (pkgs.vimUtils.buildVimPlugin {
          name = "copilot-chat";
          src = pkgs.fetchFromGitHub {
              owner = "CopilotC-Nvim";
              repo = "CopilotChat.nvim";
              rev = "8206d4eeed8f815e62a933862bebfa6919eb2b6f";
              hash = "sha256-9nr5eruyOk3nWFyfyXLf+TotOEUr1/x9izuKDd66mGk=";
          };
      })
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
        options.silent = true;
      }
      # cycles through current buffers
      {
        key = "<S-Tab>";
        action = ":bprev<CR>";
        options.silent = true;
      }
      # formats buffer on save
      {
        mode = "i";
        key = "<C-s>";
        action = "<ESC>:w<CR>";
      }
      # formats buffer on save
      {
        mode = "n";
        key = "<C-s>";
        action = ":w<CR>";
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
      # barbar
      {
        mode = "n";
        key = "<M-c>";
        action = ":BufferClose<CR>";
        options.silent = true;
      }
      # trouble
      {
        mode = "n";
        key = "<C-t>";
        action = ":Trouble<CR>";
        options.silent = true;
      }
      # lsp-saga
      {
        mode = "n";
        key = "<leader>ca";
        action = ":Lspsaga code_action<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<S-k>";
        action = ":Lspsaga hover_doc<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<C-o><C-t>";
        action = ":Lspsaga outline<CR>";
        options.silent = true;
      }
    ];
  };
} 
