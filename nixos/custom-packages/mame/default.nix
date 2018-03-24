{ stdenv
, fetchFromGitHub
, alsaLib
, fontconfig
, freettype
, SDL2
, SDL2_ttf
, xorg
, qt5
, python27
, pkgconfig
, mesa
}:

stdenv.mkDerivation rec {
  name = "mame-${version}";
  version = builtins.substring 0 7 src.rev;

  src = fetchFromGitHub {
    owner = "mamedev";
    repo = "mame";
    rev = "e44e85b8efa23947b8084dba8e02d1aa45a405d2";
    sha256 = "18yip6cgmfdv6fqvskb4j93camnjcv0if2zdvpasw0bac3fh22xm";
  };

  buildInputs = [
    mesa
    python27
    pkgconfig
    alsaLib
    fontconfig
    freettype
    SDL2
    SDL2_ttf
    xorg.libX11
    xorg.libXinerama
    qt5.qtbase.dev
  ];

  makeFlags = [
    "QT_HOME=${qt5.qtbase.dev}"
    "-j5"
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp mame* $out/bin/
  '';
}
