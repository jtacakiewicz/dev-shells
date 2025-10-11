{ pkgs, ... }:

let 
    python = pkgs.python312;
    pythonPackages = python.pkgs;
    lib-path = with pkgs; lib.makeLibraryPath [
        libffi
        openssl
        stdenv.cc.cc
    ];
    pyPkgs = with pythonPackages; [
        venvShellHook
        uv
    ];
in pkgs.mkShell {
    packages = [
        pkgs.python3
        pyPkgs
    ];
    buildInputs = with pkgs; [
        openssl
        git
        openssh
        rsync
    ];
    shellHook = ''
        SOURCE_DATE_EPOCH=$(date +%s)
        export "LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${lib-path}"
        VENV=.venv

        if test ! -d $VENV; then
          uv venv
        fi
        source ./$VENV/bin/activate
        export PYTHONPATH=`pwd`/$VENV/${python.sitePackages}/:$PYTHONPATH
        if [ -f requirements.txt ]; then
            uv pip install -r requirements.txt
        fi
    '';

    postShellHook = ''
        ln -sf ${python.sitePackages}/* ./.venv/lib/python/site-packages
    '';
}
