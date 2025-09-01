# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # not enabling autoupdates for now.
  # system.autoUpgrade.enable = true;
  # system.autoUpgrade.allowReboot = false;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # luks
  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/32b67f64-d5ed-4a50-aef9-24a367ef09eb";
    };	
  };

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  services.tailscale.enable = true;
  
  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  #Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
#  console = {
 #   font = "Lat2-Terminus16";
  #  keyMap = "us";
   # useXkbConfig = true; # use xkb.options in tty.
  #};

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Enable xWayland
  programs.xwayland.enable = true;

  # Enable fingerprint reader support
  services.fprintd.enable = true;

  # Enable firmware updates
  services.fwupd.enable = true;  

  # Enable Thermal Protection on Intel CPUs
  services.thermald.enable = true;
  
  # Enable TLP for better power management
  services.tlp.enable = true;

  # Set behaviour for how laptop lid closing behaves
  # services.logind.lidSwitch = "lock";
  # services.logind.lidSwitchExternalPower = "lock";
  # services.logind.lidSwitchDocked = "lock";
  
  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";
  nixpkgs.config.allowUnfree = true; 
  
  environment.systemPackages = with pkgs; [
    sway
    wayland
    xwayland
    networkmanager
    alacritty
    git
    jujutsu #jj-vcs
    networkmanagerapplet
    grim # screenshot functionality
    slurp # screenshot functionality
    wl-clipboard #wl-copy and wl-paste for copypaste from stdin / stdout
    mako # developped by the sway maintainers
    vim # god i need vim
    tofi # minimal dmenu / rofi replacement
    fuzzel # recommended for niri instead of tofi
    waybar # recommended for niri over swaybar ofc
    swww # trying out swww for niri
    wget 
    yazi
    fastfetch
    vesktop
    spotify
    _1password-gui
    rclone
    rsync
    mpv
    nil # yet another nix lsp
    rust-analyzer # rust lsp
    lldb # llvm debugger
    go 
    gopls # go lsp
    delve # go debugger
    omnisharp-roslyn #dotnet lsp
    netcoredbg # dotnet debugger
    llvmPackages_20.clang-tools # llvm / c related tools
    jdt-language-server # java lsp
    helix
    btop
    tmux 
    typescript-language-server
    zls # zig language server
    jetbrains.rider
    dotnetCorePackages.sdk_8_0_3xx
    typst
    tinymist # typst lsp
    zathura # document viewer
  ];

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  programs.steam = {
    enable = true;
  };
  
  #environment.sessionVariables = rec {
   # PATH="$PATH:/home/kitty/Code/scripts/";
  #};
  
  services.gnome.gnome-keyring.enable = true; # secret service
  security.pam.services.swaylock = {};


  programs.niri.enable = true;
  # enable sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # To setup sway using home manager must enable Polkit
  security.polkit.enable = true;

#  wayland.windowManager.sway = {
 #   enable = true;
  #  config = rec {
  #    modifier = "Mod4";
   #   # Use kitty as default terminal
    #  terminal = "kitty";
    #};
  #};

  programs.light.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kitty = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
   #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   #  wget
 #  ];

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

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

