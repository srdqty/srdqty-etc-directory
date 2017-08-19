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

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  fonts = {
    enableFontDir = true;
    enableCoreFonts = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      bakoma_ttf
      cm_unicode
      corefonts
      dejavu_fonts
      gentium
      google-fonts
      inconsolata
      liberation_ttf
      terminus_font
      ubuntu_font_family
    ];
  };

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
    lastpass-cli
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
    ripgrep
    sbt
    scrot
    slack
    smplayer # requires mpv
    spotify
    stack
    stalonetray
    steam
    tmux
    tree
    unzip
    rxvt_unicode-with-plugins
    usbutils
    vimHugeX
    weechat
    xclip
    xdotool
    xorg.xdpyinfo
    xscreensaver
    yabause
    yosys
    youtube-dl
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

      youtube-dl = pkgs.youtube-dl.overrideAttrs (oldAttrs: rec {
        name = "youtube-dl-${version}";
        version = "2017.08.13";
        src = pkgs.fetchurl {
          url = "https://yt-dl.org/downloads/${version}/${name}.tar.gz";
          sha256 = "212c4e6a622d4e20ea888d1b1539ab063e171bed2a05c9e00db71ed53ab059dd";
        };
      });

      lastpass-cli = pkgs.lastpass-cli.overrideAttrs (oldAttrs: rec {
        version = "1.2.1";
        src = pkgs.fetchFromGitHub {
          owner = "lastpass";
          repo = "lastpass-cli";
          rev = "eda59f8b9a064c38b8a6d3093695ee0d29afe837";
          sha256 = "0nrsrd5cqyv2zydzzl1vryrnj1p0x17cx1rmrp4kmzh83bzgcfvv";
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

    udev = {
      extraRules = ''
        ACTION=="add", ATTR{idVendor}=="0403", ATTR{idProduct}=="6010", MODE:="666"
      '';
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
