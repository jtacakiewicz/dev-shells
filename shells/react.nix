{ pkgs, ... }:
pkgs.mkShell {
    name = "react-env";
    buildInputs = with pkgs; [
        nodePackages.create-react-app
        nodejs
        yarn
    ];
}

