{ stdenv, fetchFromGitHub, cmake, pkgconfig, ninja
, libX11, libXext, libXcursor, libXpm, libXxf86vm, libXxf86dga
}:

stdenv.mkDerivation rec {
  name = "aseprite-${version}";
  version = builtins.substring 0 7 src.rev;

  src = fetchFromGitHub {
    owner = "aseprite";
    repo = "aseprite";
    rev = "aa95ccde80350cab6b7cb6afe5bba3005de8f098";
    sha256 = "06jmgck90vf7k8l51zvmjwvrdxd07k95d8msg5ns69riahzvnkcy";
    fetchSubmodules = true;
  };

  buildInputs = [
    cmake pkgconfig ninja
    libX11 libXext libXcursor libXpm libXxf86vm libXxf86dga
  ];

  cmakeFlags = ''
    -DENABLE_UPDATER=OFF
    -GNinja
  '';

  NIX_LDFLAGS = "-lX11";

  meta = {
    description = "Animated sprite editor & pixel art tool";
    homepage = https://www.aseprite.org/;
    license = stdenv.lib.licenses.gpl2Plus;
    platforms = stdenv.lib.platforms.linux;
  };
}
