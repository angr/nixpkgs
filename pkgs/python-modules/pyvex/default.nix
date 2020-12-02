{ archinfo
, bitstring
, cffi
, buildPythonPackage
, future
, fetchPypi
, pkgs
, setuptools
}:

buildPythonPackage rec {
  pname = "pyvex";
  version = "9.0.4446";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-aE3mo8717xotDsjP8n9XDq+/6BX0xX4R2X91kpnVZrA=";
  };

  propagatedBuildInputs = [ archinfo bitstring cffi future setuptools ];

  setupPyBuildFlags = [
    "--plat-name x86_64-linux"
  ];

  # Very long tests.
  doCheck = false;

  # Verify import still works.
  pythonImportsCheck = [ "pyvex" ];

  meta = with pkgs.lib; {
    description = "Python bindings for Valgrind's VEX IR";
    homepage = "https://github.com/angr/pyvex";
    license = licenses.bsd2;
    maintainers = [ maintainers.pamplemousse ];
  };
}
