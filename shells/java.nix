{ pkgs, ... }:
pkgs.mkShell {
    name = "java-env";
    buildInputs = with pkgs; [
        jdk11 
        jdt-language-server
        maven
    ];
    
    shellHook = ''
      export JAVA_HOME=${pkgs.jdk11}
      PATH="${pkgs.jdk11}/bin:$PATH"
    '';
}

