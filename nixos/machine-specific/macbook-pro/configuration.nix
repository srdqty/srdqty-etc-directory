# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/sda4";
      preLVM = true;
    }
  ];

#  hardware.bluetooth.enable = true;

  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.cleanTmpDir = true;

  boot.extraModprobeConfig = ''
    options libata.force=noncq
    options resume=/dev/sda5
    options snd_hda_intel index=0 model=intel-mac-auto id=PCH
    options snd_hda_intel index=1 model=intel-mac-auto id=HDMI
    options snd_hda_intel model=mbp101
    options hid_apple fnmode=2
  '';

  networking.hostName = "nixos-mbp-srdqty"; # Define your hostname.
  networking.networkmanager.enable = true;

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "America/New_York";

  fonts.enableFontDir = true;
  fonts.enableCoreFonts = true;
  fonts.enableGhostscriptFonts = true;
  fonts.fonts = with pkgs; [
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

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    let
      common = (import ./system-packages/common);
    in
      (common { inherit pkgs; });

  nixpkgs.config = {
    allowUnfree = true;

    packageOverrides = (import ./package-overrides/common);
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;
  #
  services = {
    xserver = {
      enable = true;

      libinput = {
        enable = true;
        accelProfile = "flat";
      };

#      xrandrHeads = [ "eDP1" "DP1" ];

      desktopManager.default = "none";
      windowManager.xmonad.enable = true;
      windowManager.xmonad.enableContribAndExtras = true;
      windowManager.default = "xmonad";

      # Configure the macbook's touchpad
      # synaptics = {
      #   enable = true;
      #   tapButtons = true;
      #   fingersMap = [ 0 0 0 ];
      #   buttonsMap = [ 1 3 2 ];
      #   twoFingerScroll = true;
      #   maxSpeed = "0.8";
      # };
    };
  };

  hardware.opengl.extraPackages = [ pkgs.vaapiIntel ];
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

  virtualisation.docker.enable = true;

  programs.bash.enableCompletion = true;

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";

}
