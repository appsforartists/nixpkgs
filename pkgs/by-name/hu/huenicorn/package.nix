{
  lib,
  stdenv,
  fetchFromGitLab,
  cmake,
  crow,
  curl,
  curlpp,
  glib,
  glm,
  libX11,
  libselinux,
  libsepol,
  libsysprof-capture,
  mbedtls,
  nlohmann_json,
  opencv,
  pcre2,
  pipewire,
  pkg-config,
  util-linux,
  wayland,
  xorg,
}:
stdenv.mkDerivation rec {
  pname = "huenicorn";
  version = "1.0.10";

  src = fetchFromGitLab {
    owner = "openjowelsofts";
    repo = "huenicorn";
    rev = "v${version}";
    hash = "sha256-d1M0JJLadHzOVK31Tz6fUTcGR2/0xVp2czoLynghcUM=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    crow
    curl
    curlpp
    glib
    glm
    libX11
    libselinux
    libsepol
    libsysprof-capture
    mbedtls
    nlohmann_json
    opencv
    pcre2
    pipewire
    util-linux
    wayland
    xorg.libXext
    xorg.libXrandr
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp huenicorn $out/bin/
    cp -r webroot $out/bin/
  '';

  #TODO:
  # - figure out where to put webroot (has to be in the cwd of huenicorn when it runs)
  # - make a desktop file that runs huenicorn from that webroot's parent, and is compatible with steam/gamescope
  # - maybe make a systemd rule that will start/stop this when a particular screen is available

  meta = with lib; {
    description = "Sync your screen to Philips Hue lights";
    homepage = "https://gitlab.com/openjowelsofts/huenicorn";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [appsforartists];
    platforms = platforms.linux;
  };
}
