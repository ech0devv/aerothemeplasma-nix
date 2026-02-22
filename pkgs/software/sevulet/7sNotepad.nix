{
  stdenv,
  lib,
  fetchFromGitLab,
  qt6
}:
stdenv.mkDerivation {
  pname = "7sNotepad";
  version = "7733e2f9";

  src = fetchFromGitLab {
    domain = "gitgud.io";
    owner = "snailatte";
    repo = "7s-notepad";
    rev = "7733e2f9fa50d84120136ddfe4bbf2902fe0e938";
    sha256 = "sha256-dl2GdeYfDklzU3qUd/xfAuGABabLJMSFPnLEstbH6gc=";
  };

  buildInputs = [ qt6.qtbase ];
  nativeBuildInputs = [ qt6.wrapQtAppsHook qt6.qmake ];

  qmakeFlags = [
    "notepad.pro"
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/share/applications
    mkdir -p $out/share/icons

    cp -R ./installation/hicolor $out/share/icons
    cp -f ./installation/notepad.desktop $out/share/applications
    cp -f ./notepad $out/bin
    runHook postInstall
  '';
}