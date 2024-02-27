# PLEASE READ THE WIKI FOR DETERMINING
# WHAT TO PUT HERE AS OPTIONS. 
# https://gitlab.com/Zaney/zaneyos/-/wikis/Setting-Options

let
  # THINGS YOU NEED TO CHANGE
  username = "davide";
  hostname = "hydrogen";
  userHome = "/home/${username}";
  flakeDir = "${userHome}/hydrogen";
  waybarStyle = "slickbar-num"; # simplebar, slickbar, slickbar-num, or default
in {
  # User Variables
  username = "${username}";
  hostname = "${hostname}";
  gitUsername = "Davide Valiante";
  gitEmail = "dav.valiante@gmail.com";
  theme = "catppuccin-mocha";
  slickbar = if waybarStyle == "slickbar" then true else false;
  slickbar-num = if waybarStyle == "slickbar-num" then true else false;
  simplebar = if waybarStyle == "simplebar" then true else false;
  borderAnim = true;
  browser = "firefox";
  wallpaperGit = "https://github.com/davidevaliante/wallpapers.git"; # This will give you my wallpapers
  # ^ (use as is or replace with your own repo - removing will break the wallsetter script) 
  wallpaperDir = "${userHome}/Pictures/Wallpapers";
  screenshotDir = "${userHome}/Pictures/Screenshots";
  flakeDir = "${flakeDir}";
  flakePrev = "${userHome}/.hydrogen-previous";
  flakeBackup = "${userHome}/.hydrogen-backup";
  terminal = "kitty"; # This sets the terminal that is used by the hyprland terminal keybinding

  # System Settings
  clock24h = false;
  theLocale = "en_US.UTF-8";
  theKBDLayout = "us";
  theSecondKBDLayout = "it";
  theKBDVariant = "";
  theLCVariables = "en_US.UTF-8";
  theTimezone = "Europe/Rome";
  theShell = "zsh"; # Possible options: bash, zsh
  theKernel = "default"; # Possible options: default, latest, lqx, xanmod, zen
  sdl-videodriver = "x11"; # Either x11 or wayland ONLY. Games might require x11 set here
  # For Hybrid Systems intel-nvidia
  # Should Be Used As gpuType
  cpuType = "intel";
  gpuType = "intel-nvidia";

  # Nvidia Hybrid Devices
  # ONLY NEEDED FOR HYBRID
  # SYSTEMS! 
  intel-bus-id = "PCI:0:2:0";
  nvidia-bus-id = "PCI:1:00:0";

  # Enable / Setup NFS
  nfs = false;
  nfsMountPoint = "/mnt/nas";
  nfsDevice = "nas:/volume1/nas";

  # NTP & HWClock Settings
  ntp = true;
  localHWClock = false;

  # Enable Printer & Scanner Support
  printer = false;

  # Enable Flatpak & Larger Programs
  distrobox = false;
  flatpak = false;
  kdenlive = true;
  blender = true;

  # Enable Support For
  # Logitech Devices
  logitech = true;

  # Enable Terminals
  # If You Disable All You Get Kitty
  wezterm = false;
  alacritty = false;
  kitty = true;

  # Enable Python & PyCharm
  python = false;

}
