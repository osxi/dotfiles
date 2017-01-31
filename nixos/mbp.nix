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
  };

  time.timeZone = "US/Central";

  nixpkgs.config.allowUnfree = true;

  powerManagement.enable = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget
    htop
    vim
    git
    gnumake
    aws
    openssl
    postgresql
    nodejs-6_x
    google-chrome
    ruby
    go_1_6
    redis
    elasticsearch
    emacs25
    mbpfan
    mu
  ];

  services = {
    openssh.enable = true;
    postgresql.enable = true;
    printing.enable = false;

    xserver = {
      autorun = false;
      enable = true;
      layout = "us";
      xkbOptions = "ctrl:nocaps";
      xkbVariant = "mac";
      videoDrivers = [ "nvidia" ];
      displayManager.sddm.enable = true;
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

  hardware.opengl.driSupport32Bit = true;

  # users.mutableUsers = false;
  users.extraUsers.zach = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" ];
    createHome = true;
    home = "/home/zach";
  };

  security.sudo.enable = true;

  system.stateVersion = "16.09";
}
