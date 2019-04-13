{ pkgs
}:
with pkgs;
stdenv.mkDerivation {
  name = "swi-prolog";

  src = fetchgit {
    url = "https://github.com/SWI-Prolog/swipl-devel";
    rev = "V8.1.4";
    sha256 = "0qxa6f5dypwczxajlf0l736adbjb17cbak3qsh5g04hpv2bxm6dh";
  };

  buildInputs = [ cmake jdk gmp readline openssl libjpeg unixODBC
    libarchive libyaml db pcre libedit libossp_uuid
    zlib freetype pkgconfig fontconfig ]
  ++ stdenv.lib.optional stdenv.isDarwin makeWrapper;

  hardeningDisable = [ "format" ];

  configureFlags = [
    "--with-world"
    "--enable-gmp"
    "--enable-shared"
  ];

  installPhase = ''
    mkdir -p $out
    mkdir build
    cd build
    ${cmake}/bin/cmake -DCMAKE_INSTALL_PREFIX=$out ..
    cd ../
    make
    make install
  '';

  # For macOS: still not fixed in upstream: "abort trap 6" when called
  # through symlink, so wrap binary.
  # We reinvent wrapProgram here but omit argv0 pass in order to not
  # break PAKCS package build. This is also safe for SWI-Prolog, since
  # there is no wrapping environment and hence no need to spoof $0
  postInstall = stdenv.lib.optionalString stdenv.isDarwin ''
    local prog="$out/bin/swipl"
    local hidden="$(dirname "$prog")/.$(basename "$prog")"-wrapped
    mv $prog $hidden
    makeWrapper $hidden $prog
  '';

  meta = {
    homepage = http://www.swi-prolog.org/;
    description = "A Prolog compiler and interpreter";
    license = "LGPL";

    platforms = stdenv.lib.platforms.unix;
    maintainers = [ stdenv.lib.maintainers.meditans ];
  };
}
