## Usage
```
nix run github:chessai/extract -- <archive>
```
and/or
```nix
# flake.nix
{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.extract.url = "github:chessai/extract";

  outputs = { nixpkgs, extract, ... }: {
    nixosConfigurations.my-epic-nixos = nixpkgs.lib.nixosSystem {
      system = "<x86_64-linux or aarch64-linux";
      modules = [
        extract.nixosModules.${system}.extract
      ];
    };
  };
}
```
