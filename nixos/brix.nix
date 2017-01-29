# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };

  networking = {
    hostName = "brix";
    wireless.enable = true;
  };

  time.timeZone = "US/Central";

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
    git
    vim
    htop
    i3status
    i3lock
    dmenu
    google-chrome
  ];

  programs.zsh.enable = true;

  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "ctrl:nocaps";
    windowManager.i3.enable = true;
  };
  # services.openssh.enable = true;
  # services.printing.enable = true;

  users.mutableUsers = true;
  users.defaultUserShell = "/run/current-system/sw/bin/zsh";
  users.extraUsers.zach = {
    home = "/home/zach";
    description = "Zach";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    uid = 1000;
  };

  security.sudo.extraConfig = "zach ALL = (ALL) NOPASSWD: ALL";

  system.stateVersion = "16.09";
}
