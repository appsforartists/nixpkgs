{ lib, stdenv, fetchFromGitHub, gnome }:

stdenv.mkDerivation rec {
  pname = "gnome-shell-extension-force-phone-mode";
  version = "0-unstable-2024-11-16";

  src = fetchFromGitHub {
    owner = "vixalien";
    repo = "force-phone-mode";
    rev = "0963c1b5f6dbd83d9e209bb8a887e1b5ec851aac";
    sha256 = "sha256-0oN2mRQ1olhjCWEdZyMEexqba/VH20zcwiP1ae0nbWw=";
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
