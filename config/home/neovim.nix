{ config, pkgs, ... }:

let
  plugins = pkgs.vimPlugins;
  theme = config.colorScheme.palette;
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

    colorschemes.base16.enable = true;
    colorschemes.base16.customColorScheme = {
      base00 = "#${theme.base00}";
      base01 = "#${theme.base01}";
      base02 = "#${theme.base02}";
      base03 = "#${theme.base03}";
      base04 = "#${theme.base04}";
      base05 = "#${theme.base05}";
      base06 = "#${theme.base06}";
      base07 = "#${theme.base07}";
      base08 = "#${theme.base08}";
      base09 = "#${theme.base09}";
      base0A = "#${theme.base0A}";
      base0B = "#${theme.base0B}";
      base0C = "#${theme.base0C}";
      base0D = "#${theme.base0D}";
      base0E = "#${theme.base0E}";
      base0F = "#${theme.base0F}";
    };
    
    plugins = {
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

      neo-tree.enable = true;

      indent-blankline.enable = true;

      nvim-colorizer.enable = true;

      nvim-autopairs.enable = true;

      nix.enable = true;

      comment-nvim = {
        enable = true;
      };

      lualine = {
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

      nvim-cmp = {
        enable = true;
        autoEnableSources = true;
        sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
        mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = {
            action = ''cmp.mapping.select_next_item()'';
            modes = [ "i" "s" ];
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

    # FOR NEOVIDE
    extraConfigLua = '' 
      vim.opt.guifont = "JetBrainsMono\\ NFM,Noto_Color_Emoji:h14"
      vim.g.neovide_cursor_animation_length = 0.05

      local colors = {
        blue   = '#${theme.base0D}',
        cyan   = '#${theme.base0C}',
        black  = '#${theme.base00}',
        white  = '#${theme.base05}',
        red    = '#${theme.base08}',
        violet = '#${theme.base0E}',
        grey   = '#${theme.base02}',
      }

      local bubbles_theme = {
        normal = {
          a = { fg = colors.black, bg = colors.violet },
          b = { fg = colors.white, bg = colors.grey },
          c = { fg = colors.black, bg = colors.black },
        },

        insert = { a = { fg = colors.black, bg = colors.blue } },
        visual = { a = { fg = colors.black, bg = colors.cyan } },
        replace = { a = { fg = colors.black, bg = colors.red } },

        inactive = {
          a = { fg = colors.white, bg = colors.black },
          b = { fg = colors.white, bg = colors.black },
          c = { fg = colors.black, bg = colors.black },
        },
      }

      require('lualine').setup {
        options = {
          theme = bubbles_theme,
          component_separators = '|',
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = {
            { 'mode', separator = { left = '' }, right_padding = 2 },
          },
          lualine_b = { 'filename', 'branch' },
          lualine_c = { 'fileformat' },
          lualine_x = {},
          lualine_y = { 'filetype', 'progress' },
          lualine_z = {
            { 'location', separator = { right = '' }, left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = { 'filename' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'location' },
        },
        tabline = {},
        extensions = {},
      }

      function InsertCommentWithIndentationAndEnterInsertMode()
        local current_line_num = vim.api.nvim_win_get_cursor(0)[1] - 1
        local current_line = vim.api.nvim_buf_get_lines(0, current_line_num, current_line_num + 1, false)[1]
        local indentation = current_line:match("^%s*")
        
        local ft = require('Comment.ft')
        local U = require('Comment.utils')
        local commentstring = ft.get(vim.bo.filetype, U.ctype.linewise)
        
        -- If commentstring is an array, use the first element (line comment)
        if type(commentstring) == "table" then
            commentstring = commentstring[1]
        end
        
        -- Handle the case where the comment string includes a '%s' for substitution
        local comment_prefix = commentstring:match("^(.*)%%s")
        if comment_prefix then
            commentstring = comment_prefix
        else
            commentstring = commentstring .. " "
        end

        -- Construct the full comment string with indentation and an additional space for typing
        local full_comment_string = indentation .. commentstring .. " "

        -- Insert the comment string above the current line
        vim.api.nvim_buf_set_lines(0, current_line_num, current_line_num, false, {full_comment_string})
        
        -- Move the cursor to the comment line and enter insert mode
        vim.api.nvim_win_set_cursor(0, {current_line_num + 1, #indentation + #commentstring})
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('A', true, false, true), 'n', false)
      end
      '';

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
        action = "<Esc>:w<CR>:lua vim.lsp.buf.format()<CR>";
      }
      # formats buffer on save
      {
        mode = "n";
        key = "<C-s>";
        action = ":w<CR>:lua vim.lsp.buf.format()<CR>";
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
