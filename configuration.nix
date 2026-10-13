{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/software.nix
      ./modules/environment.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # trying to power off dGPU
  boot.extraModprobeConfig = ''
    blacklist nouveau
    options nouveau modeset=0
    '';
  services.udev.extraRules = ''
    # Remove NVIDIA USB xHCI Host Controller devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
    
    # Remove NVIDIA USB Type-C UCSI devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
    
    # Remove NVIDIA Audio devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
    
    # Remove NVIDIA VGA/3D controller devices
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
  '';

  services.undervolt = {
    enable = true;
    analogioOffset = -100;
    uncoreOffset = -100;
    coreOffset = -100;
    gpuOffset = -100;
    tempAc = 90;
    tempBat = 70;
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
  ];

  system.stateVersion = "26.05";
}
