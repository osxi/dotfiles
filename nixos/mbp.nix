# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, nixos, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot = {
    cleanTmpDir = true;
    blacklistedKernelModules = [ "b43" ];

    # initrd.kernelModules = ["vboxdrv"];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    extraModprobeConfig = ''
      options libata.force=noncq
      options resume=/dev/sda2
      options snd_hda_intel index=0 model=intel-mac-auto id=PCH
      options snd_hda_intel index=1 model=intel-mac-auto id=HDMI
      options snd-hda-intel model=mbp101
      options hid_apple fnmode=2
    '';
  };

  networking = {
    hostName = "zachs-mbp";
    wireless.enable = true;
    firewall.enable = false;
  };

  hardware = {
    bluetooth.enable = true;
    facetimehd.enable = true;
    pulseaudio.enable = true;
    opengl.driSupport32Bit = true;

    # bumblebee = {
    #   enable = true;
    #   driver = "nvidia";
    #   connectDisplay = true;
    # };
  };

  time.timeZone = "US/Central";

  powerManagement.enable = true;

  programs.zsh.enable = true;
  # programs.virtualbox.enable = true;

  # nixpkgs.config = {
  #   allowUnfree = true;
  #   packageOverrides = pkgs: rec {
  #     emacs = pkgs.emacs.override {
  #       emacs = emacs25;
  #     };
  #   };
  # };
 
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget
    htop
    vim
    git
    aws
    openssl
    google-chrome
    emacs25
    mbpfan
    mu
    arandr
    tmux
    gnupg
    unzip
    telnet
    alpine
    file
    mplayer
    scrot
    patchelf
    pass
    conky
    kde5.kcolorchooser
    lm_sensors
    i3lock
    rabbitmq_server
    hplip
    python
    sloccount
    libreoffice
    filezilla

    bzflag
    gcc
    zlib
    go_1_6
    glide
    cassandra
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  virtualisation = {
    docker.enable = true;
    virtualbox.host.enable = true;
  };

  services = {
    # virtualboxHost.enable = true;
    openssh.enable = true;
    printing.enable = true;
    printing.drivers = [ pkgs.hplip ];
    redis.enable = true;
    rabbitmq.enable = false;
    avahi.enable = true;

    # cassandra.enable = true;

    logind.extraConfig = "HandleLidSwitch=ignore";

    # vsftpd = {
    #   enable = true;
    #   localUsers = true;
    # };

    acpid.powerEventCommands = "";

    elasticsearch = {
      enable = true;
      package = pkgs.elasticsearch;
    };

    emacs = {
      enable = true;
      package = pkgs.emacs25;
    };

    postgresql = {
      enable = true;
      extraPlugins = [ (pkgs.postgis.override { postgresql = pkgs.postgresql95; }).v_2_2_1 ];
    };

    mbpfan = {
      enable = true;
      highTemp = 60;
      lowTemp = 55;
      maxFanSpeed = 6001;
      maxTemp = 95;
      minFanSpeed = 3300;
      pollingInterval = 5;
    };

    xserver = {
      autorun = false;
      enable = true;
      layout = "us";
      xkbOptions = "ctrl:nocaps";
      xkbVariant = "mac";
      videoDrivers = [ "nvidiaLegacy340" ];
      desktopManager.kde5.enable = true;
      windowManager = {
        i3.enable = true;
        # afterstep.enable = true;
        # fluxbox.enable = true; 
        # xmonad.enable = true;
	default = "i3";

        # exwm = {
        #   enable = true;
        #   enableDefaultConfig = false;
        # };
      };

      multitouch = {
        enable = true;
        invertScroll = true;
        ignorePalm = true;
      };

      synaptics = {
        enable = true;
        fingersMap = [ 0 0 0 ];
        buttonsMap = [ 1 3 2 ];
        twoFingerScroll = true;
        accelFactor = "0.001";
        dev = "/dev/input/event*";
        palmDetect = true;
      };
    };
  };

  users = {
    defaultUserShell = "/run/current-system/sw/bin/zsh";
    mutableUsers = true;
  };

  users.extraUsers.zach = {
    isNormalUser = true;
    shell = "/run/current-system/sw/bin/zsh";
    uid = 1000;
    extraGroups = [ "wheel" "docker" "vboxusers" ];
    createHome = true;
    home = "/home/zach";
  };

  security.sudo.enable = true;

  system.stateVersion = "16.09";
}
