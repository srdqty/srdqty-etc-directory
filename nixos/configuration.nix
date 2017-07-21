# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    awscli
    binutils
    blender
    cabal2nix
    curl
    deadbeef
    docker_compose
    dolphinEmu
    dos2unix
    ffmpeg
    gambatte
    gettext
    gimp
    git
    gnumake
    gnupg
    google-chrome
    haskellPackages.hlint
    haskellPackages.xmobar
    jq
    mlton
    mpv
    networkmanagerapplet
    nix-repl
    parcellite
    pciutils
    playerctl
    playonlinux
    PPSSPP
    qbittorrent
    racket
    readline
    sbt
    scrot
    silver-searcher
    slack
    smplayer # requires mpv
    stack
    stalonetray
    steam
    terminator
    tmux
    tree
    unzip
    usbutils
    vim
    weechat
    xclip
    xdotool
    xorg.xdpyinfo
    xscreensaver
    yabause
  ];

  nixpkgs.config.allowUnfree = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.xkbOptions = "eurosign:e";

  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      windowManager.xmonad.enable = true;
      windowManager.xmonad.enableContribAndExtras = true;
      desktopManager.default = "none";
      desktopManager.xterm.enable = false;
      windowManager.default = "xmonad";
    };
  };

  hardware.opengl.driSupport32Bit = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.srdqty = {
    isNormalUser = true;
    uid = 1000;
    group = "users";
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
      "messagebus"
      "systemd-journal"
      "disk"
      "audio"
      "video"
    ];
    createHome = true;
    home = "/home/srdqty";
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";

  virtualisation.docker.enable = true;

  programs.bash.enableCompletion = true;
}
