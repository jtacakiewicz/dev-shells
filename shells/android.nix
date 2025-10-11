# shell.nix for Android Studio development

{ pkgs ? import <nixpkgs> {
    config.allowUnfree = true;
    config.android_sdk.accept_license = true;
} }:

pkgs.mkShell rec {
    buildInputs = [
        pkgs.openjdk11   # OpenJDK 11, required for Android Studio
        pkgs.android-studio-full # Android Studio package
        pkgs.git # Git for version control
        pkgs.unzip # Unzip for extracting zip files
        pkgs.curl # Curl for downloading dependencies
        pkgs.gradle # Gradle (if needed for builds)
    ];

    # Environment variables for Android development
    shellHook = ''
    export ANDROID_HOME=${pkgs.androidsdk}
    export JAVA_HOME=${pkgs.openjdk11}
    export PATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$JAVA_HOME/bin:$PATH
    '';
}
