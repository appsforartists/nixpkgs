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
, mauikit-accounts
, mauikit-texteditor
, qtmultimedia
, qtquickcontrols2
, qtwayland
}:

mkDerivation {
  pname = "buho";

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
    mauikit-accounts
    mauikit-texteditor
    qtmultimedia
    qtquickcontrols2
  ] ++ lib.optionals stdenv.isLinux [
    qtwayland
  ];

  meta = with lib; {
    description = "Task and Note Keeper";
    homepage = "https://invent.kde.org/maui/buho";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ onny ];
  };
}
