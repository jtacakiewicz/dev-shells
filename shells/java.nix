{ pkgs, ... }:
pkgs.mkShell {
    name = "java-env";
    buildInputs = with pkgs; [
        jdt-language-server
        hadoop
        maven
        jdk
    ];
    
    shellHook = ''
        export JAVA_HOME=${pkgs.jdk11}
        PATH="${pkgs.jdk}/bin:$PATH"
        if command -v zsh >/dev/null 2>&1
        then
            exec zsh
        fi
      '';
}

