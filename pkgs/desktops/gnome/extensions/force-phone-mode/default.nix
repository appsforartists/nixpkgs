{ lib, stdenv, fetchFromGitHub, gnome }:

stdenv.mkDerivation rec {
  pname = "gnome-shell-extension-force-phone-mode";
  version = "0-unstable-2023-10-28";

  src = fetchFromGitHub {
    owner = "vixalien";
    repo = "force-phone-mode";
    rev = "a6dd652bf4471f191307ca2a41f0c3a6f58d3eed";
    sha256 = "sha256-KihW0SD0VTm3Kg21eBj9jzFq7UmQcsHoA0BYuwp5svg=";
  };

  passthru = {
    extensionUuid = "force-phone-mode@vixalien.com";
    extensionPortalSlug = "force-phone-mode";
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/gnome-shell/extensions/force-phone-mode@vixalien.com
    cp -r ./ $out/share/gnome-shell/extensions/force-phone-mode@vixalien.com
    runHook postInstall
  '';

  meta = with lib; {
    description = "Force the phone mode on GNOME Shell Mobile. Useful for testing GNOME Shell Mobile on non-mobile devices.";
    license = licenses.gpl2;
    maintainers = with maintainers; [ appsforartists ];
    platforms = gnome.gnome-shell.meta.platforms;
    homepage = "https://github.com/vixalien/force-phone-mode";
  };
}
