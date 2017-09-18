# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "sd_mod" "sr_mod" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/c81d767b-0ddc-4678-b547-695f0f23d8c7";
      fsType = "ext4";
    };

  fileSystems."/var/lib/docker/devicemapper" =
    { device = "/var/lib/docker/devicemapper";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/var/lib/docker/plugins" =
    { device = "/var/lib/docker/plugins";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/117E-DB85";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/6da94cfb-f80f-4d84-a569-c6aaf8ccdbeb"; }
    ];

  nix.maxJobs = lib.mkDefault 8;
  powerManagement.cpuFreqGovernor = "powersave";
}