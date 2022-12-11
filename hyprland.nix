{ config, pkgs, ... }:
let
  flake-compat = builtins.fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz";
  hyprland = (import flake-compat {
    src = builtins.fetchTarball "https://github.com/hyprwm/Hyprland/archive/master.tar.gz";
  }).defaultNix;
in
{
  imports = [
    hyprland.nixosModules.default
  ];
  
  environment.systemPackages = with hyprland.packages.${pkgs.system}; [
    hyprland
    waybar-hyprland
  ];

  programs.hyprland.enable = true;

  xdg.portal = {
    # not needed, impacts screensharing
    # enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    # NOT needed since it fucks with screensharing
    # extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

}
