{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/software.nix
    ./modules/environment.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot = {
    loader.grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "quiet"
      "loglevel=2"
    ];
  };

  networking.modemmanager.enable = false;

  nixpkgs.config.allowUnfree = true;

  users.users."fanoplanes" = {
    isNormalUser = true;
    description = "FanoPlanes";
    extraGroups = [
      "networkmanager"
      "wheel"
      "plugdev"
    ];
    packages = with pkgs; [
    ];
  };

  environment.systemPackages = with pkgs; [
    gcc
    gnumake
    cmake
    libtool
  ];

  system.stateVersion = "26.05";
}
