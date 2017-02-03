# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot = {
    cleanTmpDir = true;
    blacklistedKernelModules = [ "b43" ];

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
    firewall.enable = true;
  };

  hardware = {
    bluetooth.enable = true;
    facetimehd.enable = true;
    pulseaudio.enable = true;
    opengl.driSupport32Bit = true;
  };

  time.timeZone = "US/Central";

  nixpkgs.config.allowUnfree = true;

  powerManagement.enable = true;

  programs.zsh.enable = true;

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

    go_1_6
    glide
  ];

  virtualisation.docker.enable = true;

  services = {
    openssh.enable = true;
    printing.enable = false;
    redis.enable = true;
    elasticsearch.enable = true;
    emacs.enable = true;

    postgresql = {
      enable = true;
      extraPlugins = [ (pkgs.postgis.override { postgresql = pkgs.postgresql95; }).v_2_2_1 ];
    };

    mbpfan = {
      enable = true;
      highTemp = 70;
      lowTemp = 55;
      maxFanSpeed = 5500;
      maxTemp = 90;
      minFanSpeed = 2500;
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
      windowManager.i3.enable = true;

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
    extraGroups = [ "wheel" "docker" ];
    createHome = true;
    home = "/home/zach";
  };

  security.sudo.enable = true;

  system.stateVersion = "16.09";
}
