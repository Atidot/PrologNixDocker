{ nixpkgs ? import <nixpkgs> {} }:
with nixpkgs;
let
  swiProlog = import ./swipl.nix { pkgs = nixpkgs; };
  script    = copyPathToStore ./test.pl;
in
dockerTools.buildImage {
  name = "prolog-nix-docker";
  tag = "latest";
  fromImage = dockerTools.buildImage {
    name = "ubuntu";
    tag  = "latest";
  };
  contents = [
    coreutils
    bashInteractive
    swiProlog
  ];
  runAsRoot = ''
    #!${pkgs.stdenv.shell}
    ${nixpkgs.dockerTools.shadowSetup}
  '';
  config = {
    Entrypoint = [
        "swipl"
        "-s"
        script
      ];
  };
}
