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
    arachne-pnr
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
    icestorm
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
    yosys
  ];

  nixpkgs.config = {
    allowUnfree = true;

    packageOverrides = pkgs: {
      icestorm = pkgs.icestorm.overrideAttrs (oldAttrs: rec {
        name = "icestorm-${version}";
        version = "2017.08.01";
        src = pkgs.fetchFromGitHub {
          owner = "cliffordwolf";
          repo = "icestorm";
          rev = "873eb9effaef6f97df24ca8d7b6eae3721303454";
          sha256 = "1ywyalqavlj3134xsa6p95xqmdgjw4ixndkxfp77yk3bfs04sxl7";
        };
      });

      arachne-pnr = pkgs.arachne-pnr.overrideAttrs (oldAttrs: rec {
        name = "arachne-pnr-${version}";
        version = "2017.06.29";
        src = pkgs.fetchFromGitHub {
          owner = "cseed";
          repo = "arachne-pnr";
          rev = "7e135edb31feacde85ec5b7e5c03fc9157080977";
          sha256 = "1wszcx6hgw4q4r778zswrlwdwvwxq834bkajck8w9yfqwxs9lmq8";
        };
      });

      yosys = pkgs.yosys.overrideAttrs (oldAttrs: rec {
        name = "yosys-${version}";
        version = "2017.08.14";
        src = pkgs.fetchFromGitHub {
          owner = "cliffordwolf";
          repo = "yosys";
          rev = "2cf0b5c1575b2ea4f8d949854eab7ab2bfdcd10e";
          sha256 = "00sfkq9z7g0ga5x3xphagyrvxrqafkd4429bx39lxwkm8l302w6h";
        };
      });
    };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.xkbOptions = "eurosign:e";

  services = {
    mediatomb = {
      enable = true;
    };

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
      "mediatomb"
    ];
    createHome = true;
    home = "/home/srdqty";
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";

  virtualisation.docker.enable = true;

  programs.bash.enableCompletion = true;
}
