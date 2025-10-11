{ pkgs, ... }:
pkgs.mkShell {
    buildInputs = with pkgs; [
        nodePackages.create-react-app
        nodejs
        yarn
    ];
}

