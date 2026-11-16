{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/d78a0595-5a7b-40f7-8096-762fbba3844f";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/2EA8-74EE";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  fileSystems."/mnt/2tb" = {
    device = "/dev/disk/by-uuid/144353bc-75d5-491a-b0b9-d21b170e1ddd";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  fileSystems."/mnt/1tb" = {
    device = "/dev/disk/by-uuid/231d01d4-a7aa-4d2a-9cb3-658e47ccfbde";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/75339f8c-8943-4fdb-b56b-c584b587e2c1"; }
    ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
