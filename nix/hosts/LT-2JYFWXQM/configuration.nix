{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  stateVersions = {
    darwin = 6;
  };
in {
  # Darwin state version 6 - defines system configuration schema/compatibility
  # See flake.nix for actual package channel selection (stable vs unstable)
  # Reference: https://github.com/LnL7/nix-darwin/blob/master/modules/system/default.nix
  system.stateVersion = stateVersions.darwin;

  networking.hostName = "LT-2JYFWXQM";

  nixpkgs.hostPlatform = "aarch64-darwin";

  time.timeZone = "Europe/Stockholm";

  host.users = {
    osx = {
      isAdmin = true;
      isPrimary = true;
      shell = "zsh";
      homeConfig = ./users/osx.nix;
    };
  };

  host.extraPackages = with pkgs; [
  ];

  host.extraBrews = [
  ];

  host.extraCasks = [
    "google-chrome"
    "orbstack"
    "raycast"
  ];

  host.extraMasApps = {
  };
}
