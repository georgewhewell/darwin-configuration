{ config, lib, pkgs, ... }:

{
  programs.vim = {
    enable = true;
    enableSensible = true;
    extraKnownPlugins = {
      fzf-vim = pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = "fzf";
        version = "0.1";
        src = pkgs.fetchgit {
          url = "git://github.com/junegunn/fzf.vim";
          rev = "c6275ee1080de4d94bb3f3cfd6e7cc0ccecd9e64";
          sha256 = "1xy7yk4d9p7mbk8s9nj5kqihdgb4a4b004ivbnxwappj52znzw1g";
        };
        dependencies = [];
      };
      lightline = pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = "lightline";
        version = "0.1";
        src = pkgs.fetchgit {
          url = "git://github.com/itchyny/lightline.vim";
          rev = "47765c787ddc981c2eab6105ade84067d164893c";
          sha256 = "1r5xpss99jfkvc5dngg877dhmirwnrwppql7ysbab50wfx4hv5c6";
        };
        dependencies = [];
      };
      editorconfig = pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = "editorconfig";
        version = "0.1";
        src = pkgs.fetchgit {
          url = "git://github.com/editorconfig/editorconfig-vim";
          rev = "2c3e5323609d97ad7bda6fc22ae1f7746caab3d4";
          sha256 = "0a1nszrhxh9ixp5n47w89ijkvjk3rf29ypiz5blf4pnja39r336x";
        };
        dependencies = [];
      };
    };
    plugins = [
      { names = [ "lightline" "editorconfig" "gitgutter" "ale" ]; }
    ];
    vimConfig = ''
      " lightline
      set laststatus=2
      set noshowmode

      " ale python
      let g:ale_python_auto_pipenv = 0
      let g:ale_python_flake8_executable = '${pkgs.python3.pkgs.flake8}/bin/flake8'
      let g:ale_python_mypy_executable = '${pkgs.python3.pkgs.mypy}/bin/mypy'
      let g:ale_python_pylint_executable = '${pkgs.python3.pkgs.pylint}/bin/pylint'
    '';
  };

}
