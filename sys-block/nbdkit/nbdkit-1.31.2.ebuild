EAPI=8

inherit autotools

DESCRIPTION="NBD server with stable plugin ABI and permissive license."
HOMEPAGE="https://gitlab.com/nbdkit/nbdkit"
SRC_URI="https://gitlab.com/nbdkit/nbdkit/-/archive/v${PV}/nbdkit-v${PV}.zip -> ${P}.zip"

#NBDKIT_PLUGINS=( ruby perl python ocaml rust ruby tcl lua  )

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	>=net-libs/gnutls-3.3.0
	dev-lang/perl
	dev-perl/Pod-Parser
	virtual/perl-Pod-Simple
	net-misc/curl
	>=net-libs/libssh-0.8.0
	>=sys-block/nbd-0.9.8"
BDEPEND=""

src_unpack() {
	unpack "${P}.zip"
	mv "nbdkit-v${PV}" "${P}"
}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf --disable-perl --disable-python --disable-ocaml --disable-rust --disable-ruby --disable-tcl --disable-lua --disable-golang --disable-libguestfs-tests --disable-torrent --disable-vddk --without-iconv --without-iso --without-libvirt --without-zlib --without-liblzma --without-libzstd --without-libguestfs --without-ext2
}
