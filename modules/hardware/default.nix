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
      loader.generic-extlinux-compatible.enable = true;
    };
    fileSystems = {
      "/" = {
        device = "/dev/disk/by-label/NIXOS_SD";
        fsType = "ext4";
        options = [ "noatime" ];
      };
    };
    hardware.enableRedistributableFirmware = true;
  };
}
