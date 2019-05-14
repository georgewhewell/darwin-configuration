{ config, pkgs, ... }:

let
  myPkgs = import ./pkgs { inherit pkgs; };
in {
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

  environment.systemPackages = with pkgs; with myPkgs; [
    httpie
    htop
    siege
    wrk
    jq
    yq
    mosh
    kubectl
    tmux
    exa
    vault
    pwgen
    shipcat
    raftcat
    watch
    ripgrep
    circleci-cli
    (runCommand "circleci" {} ''
      mkdir -p $out/bin
      ln -s ${circleci-cli}/bin/circleci-cli $out/bin/circleci
    '')
  ];

  environment.shellAliases = rec {
    ll = "exa --long --header --git --git-ignore --sort=created";
    gsp = "git stash && git pull";
    gspp = "${gsp} && git stash pop";
    slugify = "iconv -t ascii//TRANSLIT | sed -E 's/[~\^]+//g' | sed -E 's/[^a-zA-Z0-9]+/-/g' | sed -E 's/^-+\|-+$//g' | tr A-Z a-z";
  };

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.maxJobs = 2;
  nix.buildCores = 0;
}
