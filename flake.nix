{
    description = "Development shells";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    };

    outputs = { self, nixpkgs, ... }:
        let
            # Define all systems you want to support
            systems = [
                "x86_64-linux"
                "aarch64-linux"
                "x86_64-darwin"
                "aarch64-darwin"
            ];

            forAllSystems = f: nixpkgs.lib.genAttrs systems (system:
                let
                    pkgs = import nixpkgs { inherit system; };
                in
                    f pkgs
            );
        in
            {
            devShells = forAllSystems (pkgs: {
                python   = pkgs.callPackage ./shells/python.nix { };
                python310   = pkgs.callPackage ./shells/python.nix { pythonVersion="310"; };
                python311   = pkgs.callPackage ./shells/python.nix { pythonVersion="311"; };
                python312   = pkgs.callPackage ./shells/python.nix { pythonVersion="312"; };
                vulkan   = pkgs.callPackage ./shells/vulkan.nix { };
                react    = pkgs.callPackage ./shells/react.nix { };
                bigdata  = pkgs.callPackage ./shells/bigdata.nix { };
                android  = pkgs.callPackage ./shells/android.nix { };
                gostack  = pkgs.callPackage ./shells/gofullstack.nix { };
            });
        };
}

