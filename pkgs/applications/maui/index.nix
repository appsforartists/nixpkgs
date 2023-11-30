{ lib
, mkDerivation
, stdenv
, cmake
, extra-cmake-modules
, karchive
, kcoreaddons
, ki18n
, kio
, kirigami2
, mauikit
, mauikit-filebrowsing
, qtmultimedia
, qtquickcontrols2
, qtwayland
}:

mkDerivation {
  pname = "index-fm";

  postPatch = ''
    substituteInPlace CMakeLists.txt \
      --replace "-Werror" ""
  '';

  nativeBuildInputs = [
    cmake
    extra-cmake-modules
  ];

  buildInputs = [
    karchive
    kcoreaddons
    ki18n
    kio
    kirigami2
    mauikit
    mauikit-filebrowsing
    qtmultimedia
    qtquickcontrols2
  ] ++ lib.optionals stdenv.isLinux [
    qtwayland
  ];

  meta = with lib; {
    description = "Multi-platform file manager";
    homepage = "https://invent.kde.org/maui/index-fm";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ dotlambda ];
  };
}
