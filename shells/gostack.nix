{ pkgs, ... }:
pkgs.mkShell {
    name = "gostack-env";
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
        vtsls
        biome
        pre-commit
        golangci-lint
    ];
    shellHook = ''
        export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
        dockerd-rootless&
        DOCKER_PID=$!
        echo "docker id: $DOCKER_PID"
        trap "kill $DOCKER_PID 2>/dev/null" EXIT
    '';
}

