{
  lib,
  python3,
  fetchFromGitHub,
  setuptools,
  config,
}:
python3.pkgs.buildPythonApplication rec {
  pname = "handycon";
  version = "2.0.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "ShadowBlip";
    repo = "HandyGCCS";
    rev = "2f94eb9ae720abf00a8764dd8b217cdd8d30daa9";
    hash = "sha256-iwsVLjn1+L/T7OdAgA/rgGa3aAmKltAxvEfG6U7/9Gk=";
  };

  nativeBuildInputs = [
    setuptools
  ];

  installPhase = ''
    mkdir -p $out/lib/udev/
    cp -r usr/lib/udev/ $out/lib/udev/
    cp -r usr/share $out/share
  '';

  meta = with lib; {
    homepage = "https://github.com/ShadowBlip/HandyGCCS/";
    description = "HandyGCCS: expose all the buttons on your handheld console as a gamepad";
    platforms = platforms.linux;
    license = licenses.gpl3;
    maintainers = with maintainers; [appsforartists];
  };
}
