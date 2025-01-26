{
  stdenvNoCC,
  fetchFromGitHub,
  lib,
  unstableGitUpdater,
}:
let
  pname = "plymouth-steamos-theme";
  version = "0.17";

  src = fetchTarball {
    url = "https://repo.steampowered.com/steamos/pool/main/p/plymouth-themes-steamos/plymouth-themes-steamos_${version}.tar.xz";
    sha256 = "12naw6wh67vr911s6dcbzwjm0wd18lpkrcfigxrb8aszhx4w2xbw";
  };
in stdenvNoCC.mkDerivation {
  inherit pname version src;

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/plymouth/themes/steamos
    cp -r $src/usr/share/plymouth/themes/steamos $out/share/plymouth/themes
    substituteInPlace $out/share/plymouth/themes/steamos/steamos.plymouth \
      --replace-fail "/usr/" "$out/"
    runHook postInstall
  '';

  meta = {
    description = "SteamOS startup theme";
    longDescription = ''
      Graphical boot animation and logger - SteamOS theme
      Plymouth is an application that runs very early in the boot process
      (even before the root filesystem is mounted!) that provides a graphical
      boot animation while the boot process happens in the background.
      .
      This package contains the SteamOS theme.
    '';
    license = [ lib.licenses.bsd2 lib.licenses.gpl2 ];
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ appsforartists ];
  };
}
