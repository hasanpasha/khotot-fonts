{
  description =
    "A flake giving access to fonts that I use, outside of nixpkgs.";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let 
        pkgs = nixpkgs.legacyPackages.${system};
        installInstructions = ''
          mkdir -p $out/share/fonts/freetype
          cp $src/*/*.ttf $out/share/fonts/freetype
        '';
      in {
        packages.default = pkgs.stdenvNoCC.mkDerivation {
          name = "khotot-fonts-0.0.1";
          src = ./khotot;
          installPhase = installInstructions;
          meta = { description = "A Khotot Fonts Family derivation."; };
        };
      });
}
