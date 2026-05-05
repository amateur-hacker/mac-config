{
  description = "Zenful nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager }:
  let
    configuration = { pkgs, ... }: {
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      # environment.systemPackages = with pkgs;
      #   [
      #   ];

      # Fonts
      fonts.packages = with pkgs; [
        jetbrains-mono
        font-awesome
        nerd-fonts.caskaydia-mono
        nerd-fonts.jetbrains-mono
      ];

      nixpkgs.overlays = [
        (final: prev: {
          unity-test = prev.unity-test.overrideAttrs (old: {
            doCheck = false;
          });
        })
      ];

      homebrew = {
        enable = true;
        taps = [
          "nikitabobko/tap"
          "FelixKratz/formulae"
          "mediosz/tap"
        ];
        brews = [
          # CLI Tools (only work when install via brew)
          "bitwarden-cli"
          "cava"
          # GUI Apps
          "bookokrat"
          "borders"
          "clipboard"
          "displayplacer"
          "iina"
          "mole"
          "mpv"
          "nowplaying-cli"
          "portaudio"
          "sketchybar"
          "vercel-cli"
        ];
        casks = [
          # GUI Apps
          # "aldente"
          "aerospace"
          # "affinity"
          "alt-tab"
          "battery"
          "bitwarden"
          # "caffeine"
          # "camtasia"
          "docker-desktop"
          "ferdium"
          "gimp"
          "google-chrome"
          "hammerspoon"
          "karabiner-elements"
          "kitty"
          "localsend"
          # "monitorcontrol"
          "neovide-app"
          "obs"
          "raycast"
          # "shortcat"
          "shotcut"
          "spotify"
          "telegram-desktop"
          # "swipeaerospace"
          # "ubersicht"

          # Fonts
          "sf-symbols"
        ];
      #   masApps = {
      #     "Keystroke Pro" = 1572206224;
      #     "Davinci Resolve" = 571213070;
      #   };
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };

      system.primaryUser = "amateur_hacker";
      system.defaults = {
          finder.AppleShowAllExtensions = true;
          finder.AppleShowAllFiles = true;
          finder.FXPreferredViewStyle = "clmv";
          loginwindow.GuestEnabled = false;
          dock.autohide = true;
          dock.tilesize = 45;
          dock.magnification = true;
          dock.persistent-apps = [];
          NSGlobalDomain."com.apple.mouse.tapBehavior" = 1; # default null
          # NSGlobalDomain._HIHideMenuBar = false;
      };

      security.pam.services.sudo_local.touchIdAuth = true;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # enable alternative shell support in nix-darwin.
      programs.fish.enable = true;

      # Add fish to /etc/shells
      environment.shells = [ pkgs.fish ];

      # Set fish as the default user shell
      users.users.amateur_hacker.shell = pkgs.fish;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#machine
    darwinConfigurations."machine" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "amateur_hacker";
            autoMigrate = true;
          };
        }
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "bak";
            extraSpecialArgs = {
              inherit inputs;
            };
            users.amateur_hacker = import ./home.nix;
          };
        }
      ];
    };
  };
}
