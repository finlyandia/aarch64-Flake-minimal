{ 
  lib,
  pkgs,
  config,
  ...
}: let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.hardware;

in {
  options.module.hardware.enable = mkEnableOption "";
  config = mkIf cfg.enable {
    boot = {
      kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
      initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];
      loader = {
        grub.enable = false;
        generic-extlinux-compatible.enable = true;
      };
    };
    fileSystems = {
      "/" = {
        device = "/dev/disk/by-label/NIXOS_SD";
        fsType = "ext4";
        options = [ "noatime" ];
      };
    };
    nix = {
      settings = {
        auto-optimise-store = true;
        experimental-features = [ 
          "nix-command" 
          "flakes" 
        ];
        substituters = [ 
          "https://nix-community.cachix.org"
          "https://cache.nixos.org"
        ];
        trusted-public-keys = [ 
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        ];
      };
    };
    hardware.enableRedistributableFirmware = true;
  };
}
