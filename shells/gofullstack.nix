{ pkgs, ... }:
pkgs.mkShell {
    name = "react-env";
    buildInputs = with pkgs; [
        pnpm
        nodejs_22
        yarn
        go
        postgresql
    ];
    shellHook = ''
        if command -v zsh >/dev/null 2>&1
        then
            exec zsh
        fi
    '';
}

