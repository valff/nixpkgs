{ lib
, stdenv
, fetchFromGitHub
, gdk-pixbuf
, gnome-themes-extra
, gtk-engine-murrine
, librsvg
, sassc
, which
, gitUpdater
}:

stdenv.mkDerivation rec {
  pname = "qogir-theme";
  version = "2022-04-29";

  src = fetchFromGitHub {
    owner = "vinceliuice";
    repo = pname;
    rev = version;
    sha256 = "oFGJ29He7ZmryW/Eg+JLM9C3FzNjmKjzNtyXDHGuhwo=";
  };

  nativeBuildInputs = [
    sassc
    which
  ];

  buildInputs = [
    gdk-pixbuf # pixbuf engine for Gtk2
    gnome-themes-extra # adwaita engine for Gtk2
    librsvg # pixbuf loader for svg
  ];

  propagatedUserEnvPkgs = [
    gtk-engine-murrine # murrine engine for Gtk2
  ];

  installPhase = ''
    patchShebangs .
    mkdir -p $out/share/themes
    name= HOME="$TMPDIR" ./install.sh -t all -d $out/share/themes
    mkdir -p $out/share/doc/${pname}
    cp -a src/firefox $out/share/doc/${pname}
    rm $out/share/themes/*/{AUTHORS,COPYING}
  '';

  passthru.updateScript = gitUpdater { inherit pname version; };

  meta = with lib; {
    description = "Flat Design theme for GTK based desktop environments";
    homepage = "https://vinceliuice.github.io/Qogir-theme";
    license = licenses.gpl3Only;
    platforms = platforms.unix;
    maintainers = [ maintainers.romildo ];
  };
}
