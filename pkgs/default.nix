{ pkgs ? (import <nixpkgs> { }), ...}:

{
  shipcat = pkgs.callPackage ./shipcat { };
  raftcat = pkgs.callPackage ./shipcat { pkgname = "raftcat"; };
}
