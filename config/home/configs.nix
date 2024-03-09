{ pkgs, config, ... }:

{
  home.file.".neovim-config".source = ./configs/neovim.lua;
}
