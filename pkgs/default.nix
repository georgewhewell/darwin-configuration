{ pkgs ? (import <nixpkgs> { }), ...}:

{
  shipcat = pkgs.callPackage ./shipcat { };
}
