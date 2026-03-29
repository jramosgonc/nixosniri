{ self, inputs, ... }: {

	flake.nixosModules.ramosConfiguration = { pkgs, lib, ... }: {
	  imports = [
            self.nixosModules.ramosHardware
	    self.nixosModules.niri
	];

          nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "ramos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  #  networking.networkmanager.enable = true;

  networking.networkmanager = {
     enable = true;
     plugins = with pkgs; [ networkmanager-openvpn ];
  };

  # Set your time zone.
  time.timeZone = "America/Fortaleza";

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_BR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.gvfs.enable = true;
 
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  programs.niri.enable = true;

  #  services.xserver.displayManager.niri.enable = true;

  programs.dconf.enable = true;
  nixpkgs.config.allowUnfree = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  security.lsm = lib.mkForce [ ];

  virtualisation.podman = {
      enable = true;
      # Enable the Podman daemon on NixOS
      dockerCompat = true;
      defaultNetwork.settings.dnsname_enabled = true;
  };

  # Example for configuration.nix
  fonts.packages = with pkgs; [
    nerd-fonts.symbols-only
    font-awesome
  ];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ramos = {
    isNormalUser = true;
    description = "José Ramos Gonçalves";
    extraGroups = [ "networkmanager" "wheel" "podman" ];
    packages = with pkgs; [
    #  thunderbird
    ];
    # The following lines are important for rootless Podman to work correctly.
    subGidRanges = [ { count = 65536; startGid = 100000; } ];
    subUidRanges = [ { count = 65536; startUid = 100000; } ];
  };

  # Install firefox.
  programs.firefox.enable = true;

# Making neovim the standard editor
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

# List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     git
  (pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-full;
  })
  texstudio
  lyx
  # Define the full TeXLive environment
  (texlive.combine {
    inherit (texlive) scheme-full;
  })
  gnumeric
  mc
  emacs
  auctex
  go
  gcc15
  gfortran15
  neovim
  ghostty
  julia
  tree
  fastfetch
  typesetter
  libreoffice-fresh
  openvpn
  networkmanager-openvpn
  btop
  alacritty
  bat
  helix
  zip
  unzip
  lf
  xournalpp
  gparted
  spotify
  distrobox
  evince
  home-manager
  niri
  xwayland
  xwayland-satellite
  waybar
  yazi
  tmux
  fuzzel
  wezterm
 ];

# Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

#  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  };

}

        
