{ pkgs }:
let 
    lib-path = with pkgs; lib.makeLibraryPath [ ];
in pkgs.mkShell {
    name = "python-env";
    packages = with pkgs; [
        gcc
        clang
        clang-tools
        clangd

        # build tools
        cmake
        ninja
        make
        meson
        bear            # generates compile_commands.json
        pkg-config
        ccache

        # debugging / linking
        gdb
        lldb
        lld

        cppcheck
    ];
    shellHook = ''
        export "LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${lib-path}"
    '';
}
