{ lib
, fetchFromGitHub
, buildPythonPackage
, pythonOlder
  # Mitmproxy requirements
, aioquic
, asgiref
, blinker
, brotli
, certifi
, cryptography
, flask
, h11
, h2
, hyperframe
, kaitaistruct
, ldap3
, mitmproxy-rs
, msgpack
, passlib
, protobuf
, publicsuffix2
, pyopenssl
, pyparsing
, pyperclip
, ruamel-yaml
, setuptools
, sortedcontainers
, tornado
, urwid
, wsproto
, zstandard
  # Additional check requirements
, hypothesis
, parver
, pytest-asyncio
, pytest-timeout
, pytest-xdist
, pytestCheckHook
, requests
}:

buildPythonPackage rec {
  pname = "mitmproxy";
  version = "10.1.1";
  disabled = pythonOlder "3.9";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "mitmproxy";
    repo = "mitmproxy";
    rev = "refs/tags/${version}";
    hash = "sha256-/ouMj7UVowvzwjOuusgVfXjvjNPKpuJUuoJf6Sl9P44=";
  };

  propagatedBuildInputs = [
    setuptools
    aioquic
    asgiref
    blinker
    brotli
    certifi
    cryptography
    flask
    h11
    h2
    hyperframe
    kaitaistruct
    ldap3
    mitmproxy-rs
    msgpack
    passlib
    protobuf
    pyopenssl
    publicsuffix2
    pyparsing
    pyperclip
    ruamel-yaml
    sortedcontainers
    tornado
    urwid
    wsproto
    zstandard
  ];

  nativeCheckInputs = [
    hypothesis
    parver
    pytest-asyncio
    pytest-timeout
    pytest-xdist
    pytestCheckHook
    requests
  ];

  __darwinAllowLocalNetworking = true;

  preCheck = ''
    export HOME=$(mktemp -d)
  '';

  disabledTests = [
    # Tests require a git repository
    "test_get_version"
    # https://github.com/mitmproxy/mitmproxy/commit/36ebf11916704b3cdaf4be840eaafa66a115ac03
    # Tests require terminal
    "test_integration"
    "test_contentview_flowview"
    "test_flowview"
    # ValueError: Exceeds the limit (4300) for integer string conversion
    "test_roundtrip_big_integer"

    "test_wireguard"
    "test_commands_exist"
    "test_statusbar"
  ];

  disabledTestPaths = [
    # teardown of half the tests broken
    "test/mitmproxy/addons/test_onboarding.py"
  ];

  dontUsePytestXdist = true;

  pythonImportsCheck = [ "mitmproxy" ];

  meta = with lib; {
    description = "Man-in-the-middle proxy";
    homepage = "https://mitmproxy.org/";
    license = licenses.mit;
    maintainers = with maintainers; [ kamilchm SuperSandro2000 ];
  };
}
