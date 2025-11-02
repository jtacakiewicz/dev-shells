{ pkgs, ... }:
pkgs.mkShell {
    name = "react-env";
    buildInputs = with pkgs; [
        pnpm
        nodejs_22
        yarn
        go
        gopls
        postgresql
        sqlc
        docker
        rootlesskit
        docker-compose
        eslint
        biome
        pre-commit
    ];
    shellHook = ''
        export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
        dockerd-rootless&
        DOCKER_PID=$!
        echo "docker id: $DOCKER_PID"
        trap "kill $DOCKER_PID 2>/dev/null" EXIT
        if command -v zsh >/dev/null 2>&1
        then
            zsh
        fi
    '';
}

