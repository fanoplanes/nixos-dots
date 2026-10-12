{ config, pkgs, ... }:

{
  imports = [
    ./modules/sdr.nix
  ];

  home.username = "fanoplanes";
  home.homeDirectory = "/home/fanoplanes";

  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    gimp-with-plugins 
    libreoffice
    nixos-artwork.wallpapers.binary-black
    redhat-official-fonts
    spicetify-cli
    spotify
    protonmail-bridge
    protonmail-bridge-gui
    emacs
    ripgrep
    fd
    ncdu
    pciutils
    btop
    nps
    racket
  ];

  programs.git = {
    enable = true;
    userName = "fanoplanes";
    userEmail = "pontryagin@protonmail.com";
  };

  programs.ssh = {
    enable = true;
    settings = {
      "github.com" = {
        HostName = "github.com";
        User = "git";
        IdentityFile = "~/.ssh/FanoPlanesGitHub";
      };
    };
  };
  
  programs.vesktop.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      edit = "emacs -nw";
      e = "edit";
      se = "sudoedit";
    };
  };
  
  home.sessionVariables = {
    EDITOR = "emacs -nw";
  };

  programs.vim = {
    enable = true;
    settings = {
      mouse = "a";
      number = true;
    };
    extraConfig = ''
      colorscheme desert
    
      set clipboard+=unnamedplus
      set termguicolors
      syntax on
      set cursorline
      set ruler
      set noerrorbells
    
      set ttyfast
      set lazyredraw
      set splitbelow
    
      set wildmenu
      set wildmode=longest,list
    
      cnoremap W!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
    
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Allow unfree packages in home manager
  #nixpkgs.config = {
  #  allowUnfree = true;
  #};
}
