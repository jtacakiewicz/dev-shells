{ pkgs
, pythonVersion ? "313", ...
}:


let 
    python = pkgs."python${pythonVersion}";
    pythonPackages = python.pkgs;
    lib-path = with pkgs; lib.makeLibraryPath [
        libffi
        zlib
        openssl
        stdenv.cc.cc
        freetype
        libGL
    ];
    pyPkgs = with pythonPackages; [
        venvShellHook
        uv
        python-lsp-server
    ];
in pkgs.mkShell {
    name = "python-env";
    packages = [
        pkgs.python310
        pkgs.python311
        pkgs.python312
        pkgs.python313
        pyPkgs
    ];
    buildInputs = with pkgs; [
        pandoc
        openssl
        git
        zlib
        freetype
        libGL
    ];
    shellHook = ''
        export "LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${lib-path}"
        VENV=.venv

        if test ! -d $VENV; then
            UV_PYTHON=${pythonVersion} uv venv -q
            echo "if you want to use other python version use 'export UV_PYTHON=3.x' and remove current .venv"
        fi
        source ./$VENV/bin/activate
        if [ -f requirements.txt ]; then
            uv pip install -r requirements.txt
        fi
    '';

    postShellHook = ''
        ln -sf ${python.sitePackages}/* ./.venv/lib/python/site-packages
    '';
}
