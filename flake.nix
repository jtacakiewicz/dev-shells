{
    description = "A very basic flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
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
                java = pkgs.callPackage ./shells/java.nix { };
                android = pkgs.callPackage ./shells/android.nix { };
                gostack = pkgs.callPackage ./shells/gofullstack.nix { };
            };
        };
}
