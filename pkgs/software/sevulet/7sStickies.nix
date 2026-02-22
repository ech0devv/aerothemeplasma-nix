{
  stdenv,
  lib,
  fetchFromGitLab,
  qt6
}:
stdenv.mkDerivation {
  pname = "7sStickies";
  version = "f1ed6d0f";

  src = fetchFromGitLab {
    domain = "gitgud.io";
    owner = "snailatte";
    repo = "7s-stickies";
    rev = "f1ed6d0f5329f5bbaed7c22f20ae22532bd82402";
    sha256 = "sha256-iqGwZ13GtqEvzMi4xKUABpNmJb7aCU72YOgCXKIpbxU=";
  };

  buildInputs = [ qt6.qtbase ];
  nativeBuildInputs = [ qt6.wrapQtAppsHook qt6.qmake ];

  qmakeFlags = [
    "stickies.pro"
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/share/applications
    mkdir -p $out/share/icons

    cp -R ./installation/hicolor $out/share/icons
    cp -f ./installation/stickies.desktop $out/share/applications
    cp -f ./stickies $out/bin
    runHook postInstall
  '';
}