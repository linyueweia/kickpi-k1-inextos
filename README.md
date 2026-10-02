# KICKPI K1A —— iNextOS 板级适配工程

基于 **jjm2473/armbian-easepi**(iNextOS 的构建仓库, fork of armbian/build, branch `easepi-v26.02`)
为 **KICKPI K1A (Rockchip RK3568)** 增加板级支持，用 GitHub Actions 编译出 iNextOS 镜像。

## 硬件事实（从设备实测提取）
- SoC: RK3568, 4x Cortex-A55, 4GB DDR4
- 存储: eMMC 58GB(sdhci@fe310000) + TF(dwmmc@fe2b0000) + NVMe(PCIe)
- 网络: 单千兆 gmac1 @0xfe2a0000 (rgmii, tx_delay=0x21, rx_delay=0x3c)
- 显示: HDMI (dw-hdmi @0xfe0a0000)
- LED: work-led (gpio heartbeat) + 5x gpio-led
- compatible: `rockchip,rk3568-kickpi-k1a`, `rockchip,rk3568`

## 与 EasePi R1 的关键差异（不可照搬）
| 项 | K1A | EasePi R1 |
|---|---|---|
| eMMC | mmc0 = sdhci@fe310000 | mmc1 = sdhci |
| TF | mmc1 = dwmmc@fe2b0000 | mmc0 = sdmmc0 |
| 网口 | ethernet0 = fe2a0000 | 4 口 |

## 构建
在 GitHub Actions 中调用 jjm2473/armbian-easepi：
```
./compile.sh build BOARD=kickpi-k1a BRANCH=vendor
```
- KERNEL_TARGET=vendor  (armbian/linux-rockchip @ rk-6.1-rkr5.1 == 6.1.115-vendor-rk35xx)
- BOOTCONFIG=radxa-e25-rk3568_defconfig (RK3568 通用 U-Boot)
- BOOT_FDT_FILE=rockchip/rk3568-kickpi-k1a.dtb
