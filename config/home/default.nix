{ pkgs, config, ... }:

{
  imports = [
    # Enable &/ Configure Programs
    # ./alacritty.nix
    # ./bash.nix
    ./packages.nix
    ./gtk-qt.nix
    ./hyprland.nix
    ./kdenlive.nix
    ./kitty.nix
    ./neofetch.nix
    ./neovim.nix
    ./rofi.nix
    ./starship.nix
    ./waybar.nix
    ./swappy.nix
    ./swaylock.nix
    ./swaync.nix
    ./wezterm.nix
    ./zsh.nix
    ./vscode.nix
    ./zoxide.nix
    ./direnv.nix
    ./helix.nix
    # Place Home Files Like Pictures
    ./files.nix
  ];
}
