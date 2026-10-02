# Rockchip RK3568 quad core 2-4GB RAM 64GB eMMC 1x GbE NVMe HDMI USB3
# KICKPI K1A (compatible: rockchip,rk3568-kickpi-k1a)
BOARD_NAME="KICKPI K1A"
BOARD_VENDOR="kickpi"
BOARDFAMILY="rk35xx"
BOARD_MAINTAINER="linyueweia"
BOOTCONFIG="radxa-e25-rk3568_defconfig"
KERNEL_TARGET="vendor"
FULL_DESKTOP="yes"
BOOT_LOGO="desktop"
BOOT_FDT_FILE="rockchip/rk3568-kickpi-k1a.dtb"
BOOT_SCENARIO="spl-blobs"
IMAGE_PARTITION_TABLE="gpt"
BOOTFS_TYPE="fat"

function post_family_tweaks__kickpi_k1a_default_network() {
	display_alert "$BOARD" "Set KICKPI K1A default network interface to eth0" "info"
	mkdir -p "${SDCARD}/etc/udev/rules.d/"
	cat <<- EOF > "${SDCARD}/etc/udev/rules.d/70-persistent-net.rules"
		SUBSYSTEM=="net", ACTION=="add", KERNELS=="fe2a0000.ethernet", NAME:="eth0"
	EOF
	echo "DEFAULT_INTERFACE=eth0" > "${SDCARD}/root/.default-network"
	echo "fe2a0000.ethernet" > "${SDCARD}/etc/eth_order"
	return 0
}
