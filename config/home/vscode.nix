{ pkgs, config, lib, ... }: 
{
  programs.vscode = {
    enable = true;
    enableUpdateCheck = true;
    enableExtensionUpdateCheck = true;
    extensions = with pkgs; [
      vscode-extensions.catppuccin.catppuccin-vsc
      vscode-extensions.github.copilot
      vscode-extensions.mhutchie.git-graph
      vscode-extensions.catppuccin.catppuccin-vsc-icons
      vscode-extensions.jnoortheen.nix-ide
      vscode-extensions.asvetliakov.vscode-neovim
      vscode-extensions.tamasfe.even-better-toml
    ];
    userSettings = {
      "telemetry.telemetryLevel" = "off";
      "workbench.colorTheme" = "Catppuccin Mocha";
      "[nix]"."editor.tabSize" = 2;

      # customize the bar at the top
      "window.titleBarStyle" = "custom";
      "workbench.colorCustomizations" = {
	      # this is equivalent to Catppucin Mocha "Crust" color
        "titleBar.activeBackground" = "#11111b";      
        "titleBar.activeForeground" = "#fff";
      };
      "window.menuBarVisibility" = "compact";

      # fonts
      "editor.fontFamily" = "JetBrainsMono Nerd Font";
      "editor.fontSize" = 14;


      # neovim settings
      "extensions.experimental.affinity" = {
        "asvetliakov.vscode-neovim" = 1;
      };

      # avoid vs code opening file in the same window
      "workbench.editor.enablePreview" = false;

      "workbench.statusBar.visible" = true;
      "git-graph.showStatusBarItem" = true;
      "vscode-neovim.ctrlKeysForInsertMode" = [
        "a"
        "d"
        "h"
        "j"
        "o"
        "r"
        "t"
        "u"
        "w"
      ];
    };

    keybindings = [
      {
        command = "vscode-neovim.compositeEscape1";
        key = "j";
        when = "neovim.mode == insert && editorTextFocus";
        args = "j";
      }

      {
        command = "vscode-neovim.send";
        key = "ctrl+s";
        when = "neovim.mode == insert && editorTextFocus";
        args = "<Esc>:w<CR>";
      }
    ];
  };
}