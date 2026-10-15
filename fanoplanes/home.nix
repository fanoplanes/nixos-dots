{ config, pkgs, ... }:

{
  imports = [
    ./modules/sdr.nix
  ];

  home.username = "fanoplanes";
  home.homeDirectory = "/home/fanoplanes";

  home.stateVersion = "26.05";

  home.sessionVariables = {
    EDITOR = "emacs";
  };

  home.packages = with pkgs; [
    gimp-with-plugins 
    libreoffice
    nixos-artwork.wallpapers.binary-black
    redhat-official-fonts
    spicetify-cli
    spotify
    protonmail-bridge
    protonmail-bridge-gui
    ncdu
    pciutils
    nps
    racket
    gnumake
    gcc
  ];

  programs = {
    steam.enable = true;
    ripgrep.enable = true;
    fd.enable = true;
    emacs.enable = true;
    btop = {
      enable = true;
      settings = {
        color_theme = "TTY";
      };
    };
    git = {
      enable = true;
      settings.user = {
        name = "fanoplanes";
        email = "pontryagin@protonmail.com";
      };
    };
    ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings = {
        "github.com" = {
          HostName = "github.com";
          User = "git";
          IdentityFile = "~/.ssh/FanoPlanesGitHub";
        };
      };
    };
    vesktop.enable = true;
    bash = {
      enable = true;
      shellAliases = {
        edit = "emacs -nw";
        e = "edit";
        se = "sudoedit";
      };
    };
    vim = {
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
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
