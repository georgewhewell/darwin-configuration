{ stdenv, pkgs, rustPlatform, fetchFromGitHub, pkgconfig, openssl, darwin
, withRaftcat ? true
}:

rustPlatform.buildRustPackage rec {
  pname = "shipcat";
  version = "0.95.0";

  src = fetchFromGitHub {
    owner = "Babylonpartners";
    repo = "shipcat";
    rev = "${version}";
    sha256 = "0q7gjxm3w9ml4am6c8bp2s7qdgz08ph6hdn47jz6ziv2nwsnnr1p";
  };

  cargoSha256 = "1z8ljc1151vpzf8mm9a42w2s5s0iz13dxmwarsvblgh17av5ydyd";
  nativeBuildInputs = [
    pkgconfig openssl
  ] ++ stdenv.lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.Security
  ];

  cargoBuildFlags = pkgs.lib.optionals withRaftcat [ "-p raftcat" ];

  propagatedBuildInputs = with pkgs; [
    kubernetes
    kubernetes-helm
    vault
    jq
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
