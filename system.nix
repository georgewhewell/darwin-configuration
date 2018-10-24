{ config, lib, pkgs, ... }:

{
  system.defaults.NSGlobalDomain = {
    AppleShowAllExtensions = true;
    NSNavPanelExpandedStateForSaveMode = true; 
    "com.apple.trackpad.enableSecondaryClick" = true;
    "com.apple.trackpad.trackpadCornerClickBehavior" = 1;
  };

  system.defaults.dock = {
    autohide = true;
    orientation = "right";
    showhidden = true;
    mru-spaces = false;
  };

  system.defaults.finder = {
    AppleShowAllExtensions = true;
    QuitMenuItem = true;
    FXEnableExtensionChangeWarning = false;
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  system.defaults.LaunchServices.LSQuarantine = false;
}
