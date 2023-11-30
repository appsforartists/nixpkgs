{ lib
, mkDerivation
, stdenv
, cmake
, extra-cmake-modules
, kcoreaddons
, ki18n
, kirigami2
, mauikit
, mauikit-filebrowsing
, prison
, qtgraphicaleffects
, qtmultimedia
, qtquickcontrols2
, qtwayland
, gst_all_1
}:

mkDerivation {
  pname = "booth";

  nativeBuildInputs = [
    cmake
    extra-cmake-modules
  ];

  buildInputs = [
    kcoreaddons
    ki18n
    kirigami2
    mauikit
    mauikit-filebrowsing
    prison
    qtgraphicaleffects
    qtmultimedia
    qtquickcontrols2
  ] ++ lib.optionals stdenv.isLinux [
    qtwayland
  ] ++ (with gst_all_1; [
    gst-plugins-bad
    gst-plugins-base
    gst-plugins-good
    gstreamer
  ]);

  preFixup = ''
    qtWrapperArgs+=(
      --prefix GST_PLUGIN_SYSTEM_PATH_1_0 : "$GST_PLUGIN_SYSTEM_PATH_1_0"
    )
  '';

  meta = with lib; {
    description = "Camera application";
    homepage = "https://invent.kde.org/maui/booth";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ milahu ];
  };
}
