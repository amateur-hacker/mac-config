{ config, lib, inputs, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/Documents/mac-config/dotfiles";

  createSymlink = path:
    config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    aerospace = "aerospace";
    atac = "atac";
    bat = "bat";
    bottom = "bottom";
    cava = "cava";
    fish = "fish";
    git = "git";
    kitty = "kitty";
    lsd = "lsd";
    neovide = "neovide";
    nvim = "nvim";
    nix = "nix";
    sketchybar = "sketchybar";
    yazi = "yazi";
    zathura = "zathura";
    "chrome-flags.conf" = "chrome-flags.conf";
    "starship.toml" = "starship.toml";
  };

  homeDotfiles = {
    ".hammerspoon" = { path = "${dotfiles}/home/.hammerspoon"; recursive = true; };
    ".hushlogin".path = "${dotfiles}/home/.hushlogin";
    "Pictures/wallpapers" = { path = "${dotfiles}/pictures/wallpapers"; recursive = true; };
  };

in
{
  home.username = "amateur_hacker";
  home.homeDirectory = lib.mkForce "/Users/amateur_hacker";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    # CLI Tools
    age
    atac
    bat
    bottom
    cbonsai
    cowsay
    curl
    coreutils
    duf
    dysk
    fastfetch
    fd
    ffmpeg
    figlet
    fzf
    geoip
    gowall
    httpie
    imagemagick
    inxi
    jq
    less
    lolcat
    lsd
    perl5Packages.FileMimeInfo
    pipes-rs
    p7zip
    qrencode
    ripgrep
    rsync
    sops
    starship
    stow
    tealdeer
    television
    tesseract
    toilet
    trash-cli
    unp
    unrar
    unzip
    util-linux
    wget
    xdg-ninja
    yazi
    yq
    yt-dlp-light
    zip
    zoxide

    # Dev Tools
    bun
    # llvmPackages.clang
    python314Packages.cmake
    docker
    docker-compose
    gcc
    gh
    go
    ghq
    jdk
    lazydocker
    lazygit
    meson
    neovim
    ninja
    nodejs
    opencode
    php
    pm2
    python315
    ruby
    rustc
    sqlite
  ];

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = createSymlink "${dotfiles}/config/${subpath}";
    recursive = true;
    # force = true;
  }) configs;

  home.file =
    (builtins.mapAttrs (name: cfg: {
      source = createSymlink cfg.path;
      recursive = cfg.recursive or false;
    }) homeDotfiles);
}
