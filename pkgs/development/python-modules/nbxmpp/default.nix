{ lib
, buildPythonPackage
, pythonOlder
, fetchFromGitLab
, gobject-introspection
, idna
, libsoup
, precis-i18n
, pygobject3
, pyopenssl
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "nbxmpp";
  version = "2.0.6";

  disabled = pythonOlder "3.7";

  src = fetchFromGitLab {
    domain = "dev.gajim.org";
    owner = "gajim";
    repo = "python-nbxmpp";
    rev = "nbxmpp-${version}";
    sha256 = "sha256:03iydz0r9m8559srawwnhaqzqm9liwrnc8v6abj4w3m1lil32bid";
  };

  buildInputs = [
    precis-i18n
  ];

  propagatedBuildInputs = [
    gobject-introspection
    idna
    libsoup
    pygobject3
    pyopenssl
  ];

  checkInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [ "nbxmpp" ];

  meta = with lib; {
    homepage = "https://dev.gajim.org/gajim/python-nbxmpp";
    description = "Non-blocking Jabber/XMPP module";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ abbradar ];
  };
}
