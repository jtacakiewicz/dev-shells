{ pkgs, ... }:
pkgs.mkShell {
    buildInputs = with pkgs; [
        nodePackages.create-react-app
        nodejs
        yarn
    ];
    shellHook = ''
        if command -v zsh >/dev/null 2>&1
        then
            exec zsh
        fi
    '';
}

