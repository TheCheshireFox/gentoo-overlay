EAPI=8

DESCRIPTION="Add drop-in directories for hook scripts, uses basrc to proxy calls"
HOMEPAGE="https://github.com/TheCheshireFox/portage-hooks"
SRC_URI="https://github.com/TheCheshireFox/portage-hooks/archive/refs/tags/v${PV}.zip"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-shells/bash"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
  insinto /etc
  doins -r etc/*
}
