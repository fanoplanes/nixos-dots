{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/software.nix
      ./modules/environment.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.undervolt = {
    enable = true;
    analogioOffset = -100;
    uncoreOffset = -100;
    coreOffset = -100;
    gpuOffset = -100;
    tempAc = 90;
    tempBat = 60;
  };

  nixpkgs.config.allowUnfree = true;


  users.users."fanoplanes" = {
    isNormalUser = true;
    description = "FanoPlanes";
    extraGroups = [ "networkmanager" "wheel" "plugdev" ];
    packages = with pkgs; [
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    linuxKernel.packages.linux_7_2.acpi_call
  ];

  system.stateVersion = "26.05";
}
