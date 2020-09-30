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

  # Version 9.0.4446 of `archinfo` is broken: see angr/archinfo#94 ;
  # Allow the use of the unstable version present in the repo;
  # Could probably be removed on the next release of `angr` (and its dependencies).
  patchPhase = ''
    sed -i "s/archinfo==${version}/archinfo/" setup.py
  '';

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
