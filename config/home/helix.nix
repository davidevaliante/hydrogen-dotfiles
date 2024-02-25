{ pkgs, config, ... }:
{
  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_mocha";
    };
  };
}

# this is a comment this 2 comment words on it