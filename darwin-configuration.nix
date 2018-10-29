{ config, pkgs, ... }:

{
  imports = [
    ./system.nix
    ./programs/vim.nix
    ./programs/zsh.nix
  ];

  services.redis.enable = true;
  services.postgresql.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 3;

  users.users."george.whewell" = {
    shell = pkgs.zsh;
  };

  nix.nixPath =
    [ "darwin-config=$HOME/.nixpkgs/darwin-configuration.nix"
      "darwin=$HOME/.nix-defexpr/channels/darwin"
      "$HOME/.nix-defexpr/channels"
    ];

  environment.systemPackages = with pkgs; [
    httpie
    htop
    siege
    jq
    mosh
    kubectl
  ];

  environment.shellAliases = rec {
    ll = "${pkgs.coreutils}/bin/ls -lahGFT0 --group-directories-first";
    gsp = "${pkgs.git}/bin/git stash && ${pkgs.git}/bin/git pull";
    gspp = "${gsp} && ${pkgs.git}/bin/git stash pop";
  };

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.maxJobs = 4;
  nix.buildCores = 0;
}
