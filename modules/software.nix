{ pkgs, ... }:

{
  programs.firefox.enable = true;

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["fanoplanes"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };
}
