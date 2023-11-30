{ lib
, mkDerivation
, stdenv
, cmake
, extra-cmake-modules
, applet-window-buttons
, karchive
, kcoreaddons
, ki18n
, kio
, kirigami2
, mauikit
, mauikit-filebrowsing
, mauikit-texteditor
, qtmultimedia
, qtquickcontrols2
, qtwayland
}:

mkDerivation {
  pname = "nota";

  nativeBuildInputs = [
    cmake
    extra-cmake-modules
  ];

  buildInputs = [
    applet-window-buttons
    karchive
    kcoreaddons
    ki18n
    kio
    kirigami2
    mauikit
    mauikit-filebrowsing
    mauikit-texteditor
    qtmultimedia
    qtquickcontrols2
  ] ++ lib.optionals stdenv.isLinux [
    qtwayland
  ];

  meta = with lib; {
    description = "Multi-platform text editor";
    homepage = "https://invent.kde.org/maui/nota";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ onny ];
  };
}
