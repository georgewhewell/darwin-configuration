{ stdenv, pkgs, rustPlatform, fetchFromGitHub, pkgconfig, openssl, darwin
, pkgname ? "shipcat"
}:

rustPlatform.buildRustPackage rec {
  pname = pkgname;
  version = "0.103.2";

  src = fetchFromGitHub {
    owner = "Babylonpartners";
    repo = "shipcat";
    rev = "${version}";
    sha256 = "0nz6drflx6hkmhqqmwvrhb1h76bhy52gd5xxygwczcp6a3a54lff";
  };

  cargoSha256 = "1n1gk6cp59dwn4dmmd6xfi1hjkgf0agwg9z02j2428gk0bjj6agq";
  nativeBuildInputs = [
    pkgconfig openssl
  ] ++ stdenv.lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.Security
  ];

  cargoBuildFlags = [ "-p ${pkgname}" ];

  propagatedBuildInputs = with pkgs; [
    kubernetes
    kubernetes-helm
    vault
    jq
    yq
  ];

  # thread 'config_test' panicked at 'assertion failed: fullcfg.is_ok()', shipcat_cli/tests/common.rs:42:5
  doCheck = false;

  meta = with stdenv.lib; {
    inherit (src) homepage;
    description = "A standardisation tool and security layer on top of kubernetes to config manage microservices.";
    license = licenses.unlicense;
    maintainers = [ maintainers.georgewhewell ];
    platforms = platforms.all;
  };
}
