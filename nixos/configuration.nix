{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "puppybox";

  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Berlin";

  users.users.nils = {
    isNormalUser = true;
    extraGroups = [ "wheel"];
    packages = with pkgs; [
      tree
      emacs
      librewolf
      git
      prismlauncher
      keepassxc
      kdePackages.dolphin
      gimp
      obs-studio
    ];
  };

  # Screen capture support
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  security.rtkit.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];

    wlr.settings.screencast = {
      chooser_type = "simple";
      chooser_cmd = "${pkgs.slurp}/bin/slurp -f 'Monitor: %o' -or";
    };
  };

  services.udisks2.enable = true;

  services.gvfs.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  services.gnome.gnome-keyring.enable = true;

  services.displayManager.sddm = { 
	enable = true;
	wayland.enable = true;
  };

  services.goxlr-utility.enable = true;

   environment.systemPackages = with pkgs; [
     wget
     git
     grim
     slurp
     wl-clipboard
     mako
     i3status
     nordzy-cursor-theme
     pavucontrol
   ];

  fonts.packages = with pkgs; [
	iosevka
];

# The following will only work if set up properly. Commented out to prevent readers from confusion.

#  home-manager.users.nils = { pkgs, config, ... }: {
#    home.stateVersion = "26.05";
#    xdg.configFile."sway".source =
#      config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dots/sway";
#    xdg.configFile."doom".source =
#      config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dots/doom";
#    xdg.configFile."emacs".source =
#      config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dots/emacs";
#    xdg.configFile."goxlr-utility".source =
#      config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dots/goxlr-utility";
#  };

  #networking.firewall.allowedTCPPorts = [ ... ];
  #networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = false;

  system.copySystemConfiguration = true;

  system.stateVersion = "26.05"; # Dont change unless you know what youre doing!

}

