{
    description = "A very basic flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    };

    outputs = { self, nixpkgs, ... }: 
        let
            system = "x86_64-linux";
            pkgs = import nixpkgs { inherit system; };
        in
            {
            devShells.${system} = {
                python = pkgs.callPackage ./shells/python.nix { };
                vulkan = pkgs.callPackage ./shells/vulkan.nix { };
                react = pkgs.callPackage ./shells/react.nix { };
                bigdata = pkgs.callPackage ./shells/bigdata.nix { };
                android = pkgs.callPackage ./shells/android.nix { };
                gostack = pkgs.callPackage ./shells/gofullstack.nix { };
            };
        };
}
