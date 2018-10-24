{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableBashCompletion = true;
    promptInit = ''
      autoload -U promptinit && promptinit
      setopt PROMPTSUBST
      _prompt_nix() {
        [ -z "$IN_NIX_SHELL" ] || echo "%F{yellow}%B[''${name:+$name}]%b%f "
      }
      PS1='%F{red}%B%(?..%? )%b%f%# '
      RPS1='$(_prompt_nix)%F{green}%~%f'
  '';

  };
}
