{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      forAllSystems = syss: f:
        nixpkgs.lib.genAttrs syss (system:
          let
            x = import nixpkgs {
              inherit system;
              config = { allowUnfree = true; };
              overlays = [];
            };
          in
          f x);

      script = pkgs:
        pkgs.writeShellApplication
          {
            name = "extract";
            text = builtins.readFile ./extract.sh;
            runtimeInputs = with pkgs; [ gnutar xz bzip2 unrar gzip unzip ncompress p7zip cabextract ];
          };
    in
    {
      apps = forAllSystems systems (pkgs: {
        default = {
          type = "app";
          program = "${(script pkgs).outPath}/bin/extract";
        };
      });

      nixosModules = forAllSystems [ "x86_64-linux" "aarch64-linux" ] (pkgs: {
        extract = {
          config = {
            environment.systemPackages = [ (script pkgs) ];
          };
        };
      });
    };
}
