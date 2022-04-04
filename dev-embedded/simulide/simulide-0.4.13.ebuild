EAPI=7

inherit qmake-utils

COMMIT="4bf26bc839147551a00938aa2949012681a3e046"

DESCRIPTION="SimulIDE simulates your circuit designs, it includes Arduino emulation."
HOMEPAGE="https://github.com/SimulIDE/SimulIDE"
SRC_URI="https://github.com/SimulIDE/SimulIDE/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"

RDEPEND="dev-qt/qtcore
	dev-qt/qtgui
	dev-qt/qtxml
	dev-qt/qtwidgets
	dev-qt/qtconcurrent
	dev-qt/qtsvg
	dev-qt/qtmultimedia
	dev-qt/qtserialport
	dev-qt/qtscript"

DEPEND="${RDEPEND}
  dev-libs/libelf
  dev-embedded/avr-libc"

S="${WORKDIR}/SimulIDE-${COMMIT}"

src_configure() {
	eqmake5 PREFIX="${D}"/usr
}

src_install() {
	DIR="${S}/release/SimulIDE_${PVR}-SR5-CE/"
	dobin "${DIR}/bin/simulide"

	insinto "/usr/share"
	doins -r "${DIR}/share/icons"
	doins -r "${DIR}/share/simulide"

	insinto "/usr/share/pixmaps"
	doins "${DIR}/share/icons/hicolor/256x256/simulide.png"

	insinto "/usr/share/applications"
	doins "${FILESDIR}/simulide.desktop"
}
