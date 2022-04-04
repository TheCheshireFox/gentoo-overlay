# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop xdg-utils

DESCRIPTION="Cisco AnyConnect Secure Mobility Client"
HOMEPAGE=""
SRC_URI="anyconnect-linux64-${PV}-core-vpn-webdeploy-k9.sh"

LICENSE="IDEA"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="( net-libs/webkit-gtk )"

pkg_nofetch() {
	einfo "Please download installer script ${SRC_URI} for linux anyconnect and place it in DISTDIR"
}

src_unpack() {
	mkdir "${S}"
	cp "${DISTDIR}/${SRC_URI}" "${S}/"
}

src_prepare() {
	# fix path
#	sed -i 's|INSTPREFIX=/opt/cisco/anyconnect|INSTPREFIX="${D}/opt/cisco/anyconnect"|g' "${S}/${SRC_URI}"
#	sed -i 's|ROOTCERTSTORE=/opt/.cisco/certificates/ca|ROOTCERTSTORE="${D}/opt/.cisco/certificates/ca"|g' "${S}/${SRC_URI}"
#	sed -i 's|SYSTEMD_CONF_DIR="/etc/systemd/system"|SYSTEMD_CONF_DIR="${D}/etc/systemd/system"|g' "${S}/${SRC_URI}"
#	sed -i 's|/usr/share/icons|${D}/usr/share/icons|g' "${S}/${SRC_URI}"
#	sed -i 's|/etc/xdg/menus|${D}/etc/xdg/menus|g' "${S}/${SRC_URI}"
#	sed -i 's|/usr/share/desktop-directories|${D}/usr/share/desktop-directories|g' "${S}/${SRC_URI}"
#	sed -i 's|/usr/share/applications|${D}/usr/share/applications|g' "${S}/${SRC_URI}"
#	sed -i 's|/etc/init.d|${D}/etc/init.d|g' "${S}/${SRC_URI}"
#	sed -i 's|/etc/systemd/system/|${D}/etc/systemd/system/|g'

	# do not start/stop services
#	sed -i 's/if \[ -z "\${TESTINIT##\*"systemd"\*}" \]/if [ 0 ]/g' "${S}/${SRC_URI}"
#	sed -i 's/elif \[ "x\\\${INITD}" != "x" ]/elif [ 0 ]/g' "${S}/${SRC_URI}"
	eapply "${FILESDIR}/fix-hardcoded-path.patch"
	eapply_user
}

src_compile () {
	chmod +x "${S}/${SRC_URI}"
}

src_install() {
	mkdir -p "${D}/etc/init.d"
	mkdir -p "${D}/etc/systemd/system"
	mkdir -p "${D}/usr/share/icons/hicolor/48x48/apps"
	mkdir -p "${D}/usr/share/icons/hicolor/64x64/apps"
	mkdir -p "${D}/usr/share/icons/hicolor/96x96/apps"
	mkdir -p "${D}/usr/share/icons/hicolor/128x128/apps"
	mkdir -p "${D}/usr/share/icons/hicolor/256x256/apps"
	mkdir -p "${D}/usr/share/desktop-directories/"
	mkdir -p "${D}/usr/share/applications"

	INSTPREFIX="${D}/opt/cisco/anyconnect"
	ROOTCERTSTORE="${D}/opt/.cisco/certificates/ca"
	SYSTEMD_CONF_DIR="${D}/etc/systemd/system"
	ICONS_DIR="${D}/usr/share/icons"
	XDG_MENUS_DIR="${D}/etc/xdg/menus"
	DESKTOP_DIRECTORIES_DIR="${D}/usr/share/desktop-directories"
	APPLICATIONS_DIR="${D}/usr/share/applications"
	INITD="${D}/etc/init.d"
	"${S}/${SRC_URI}"
}


pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update

	einfo "You need to start vpnagentd in order to use cisco anyconnect"
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
