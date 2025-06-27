Return-Path: <stable+bounces-158768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF392AEB447
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 12:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 716E516BB72
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 10:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2552BCF70;
	Fri, 27 Jun 2025 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2bD6/2wT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF9A2980BF;
	Fri, 27 Jun 2025 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019504; cv=none; b=a76MG6uHOJqZIXBnK4UkiBIoXJJSavUsDFwgItr4qwOZ9iC4xo96FfQp1fSTg88J3zU27WiYS+/KwBgcZHHZEm8unqQ2Q7dBGriWVAQxCO9+PgVu2UYVa9SFd2pksGRPYgucV4mww6ZBSXsRvEK69zjavS+4Sz03ObqCRVvVGFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019504; c=relaxed/simple;
	bh=bWoPXS9Pf0s3Wo5+8IbaCu5BXM5rANBK2TBXcMv1JXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GfUwQV0wqhVvFy4GIf8BBLqZhhN+Z1CGdqyvN+FJQ/GH/fmBXokWPAY9nu1HMapd1BeMI1Q8RoiePwL1FbhmIlQCnh6Tt1FhI2pXLkOd1LnzDQQHVkZnBbn0V/uQPSaxSaQWJ6/im2+SnHUKjCBbtJhW/HbmD41VQ6nUJDRbuRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2bD6/2wT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A00BC4CEED;
	Fri, 27 Jun 2025 10:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751019504;
	bh=bWoPXS9Pf0s3Wo5+8IbaCu5BXM5rANBK2TBXcMv1JXo=;
	h=From:To:Cc:Subject:Date:From;
	b=2bD6/2wTUyxBaZn4SvmRkcE/JTfbq/UIl7wwjJAhKXUDXtN6hn+70cuwnmMHH/8h5
	 FaIYtE5umKIZPqZ65o0xr6ST5j68pXmBdkdo4p6uqXmU7/tp9V6N/deyQaRFK1YBWw
	 LPxunk3Jb+o7ZuhHXX528thEZBdAnlBZXjQjaF20=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.142
Date: Fri, 27 Jun 2025 11:18:09 +0100
Message-ID: <2025062710-engorge-party-22e1@gregkh>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.142 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-fs-xfs                        |    8 
 Documentation/admin-guide/kernel-parameters.txt               |    2 
 Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.yaml |   24 
 Documentation/devicetree/bindings/vendor-prefixes.yaml        |    2 
 Makefile                                                      |    6 
 arch/arm/boot/dts/am335x-bone-common.dtsi                     |    8 
 arch/arm/boot/dts/at91sam9263ek.dts                           |    2 
 arch/arm/boot/dts/qcom-apq8064.dtsi                           |   13 
 arch/arm/boot/dts/tny_a9263.dts                               |    2 
 arch/arm/boot/dts/usb_a9263.dts                               |    4 
 arch/arm/mach-aspeed/Kconfig                                  |    1 
 arch/arm/mach-omap2/clockdomain.h                             |    1 
 arch/arm/mach-omap2/clockdomains33xx_data.c                   |    2 
 arch/arm/mach-omap2/cm33xx.c                                  |   14 
 arch/arm/mach-omap2/pmic-cpcap.c                              |    6 
 arch/arm/mm/ioremap.c                                         |    4 
 arch/arm64/Kconfig                                            |    6 
 arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi          |    1 
 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi              |    1 
 arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi          |    1 
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi             |    8 
 arch/arm64/boot/dts/mediatek/mt6359.dtsi                      |    4 
 arch/arm64/boot/dts/mediatek/mt8195.dtsi                      |   50 +
 arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts           |    2 
 arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts           |    3 
 arch/arm64/boot/dts/qcom/sm8250.dtsi                          |    2 
 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts           |    8 
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi                      |   20 
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                        |   31 +
 arch/arm64/configs/defconfig                                  |    3 
 arch/arm64/kernel/fpsimd.c                                    |    4 
 arch/arm64/kernel/ptrace.c                                    |    2 
 arch/arm64/xen/hypercall.S                                    |   21 
 arch/loongarch/include/asm/irqflags.h                         |   16 
 arch/m68k/mac/config.c                                        |    2 
 arch/mips/Makefile                                            |    2 
 arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dts        |    1 
 arch/mips/vdso/Makefile                                       |    1 
 arch/parisc/boot/compressed/Makefile                          |    1 
 arch/parisc/kernel/unaligned.c                                |    2 
 arch/powerpc/kernel/eeh.c                                     |    2 
 arch/powerpc/kexec/crash.c                                    |    5 
 arch/powerpc/platforms/book3s/vas-api.c                       |    9 
 arch/powerpc/platforms/powernv/memtrace.c                     |    8 
 arch/powerpc/platforms/pseries/msi.c                          |    7 
 arch/riscv/kvm/vcpu_sbi_replace.c                             |    8 
 arch/s390/kvm/gaccess.c                                       |    8 
 arch/s390/net/bpf_jit_comp.c                                  |   12 
 arch/s390/pci/pci_mmio.c                                      |    2 
 arch/x86/kernel/cpu/bugs.c                                    |   10 
 arch/x86/kernel/cpu/common.c                                  |   17 
 arch/x86/kernel/cpu/mtrr/generic.c                            |    2 
 arch/x86/kernel/cpu/sgx/main.c                                |    2 
 arch/x86/kernel/ioport.c                                      |   13 
 arch/x86/kernel/process.c                                     |    6 
 arch/x86/kvm/svm/svm.c                                        |    2 
 crypto/lrw.c                                                  |    4 
 crypto/xts.c                                                  |    4 
 drivers/acpi/acpica/dsutils.c                                 |    9 
 drivers/acpi/acpica/psobject.c                                |   52 -
 drivers/acpi/acpica/utprint.c                                 |    7 
 drivers/acpi/apei/Kconfig                                     |    1 
 drivers/acpi/apei/ghes.c                                      |    2 
 drivers/acpi/battery.c                                        |   19 
 drivers/acpi/bus.c                                            |    6 
 drivers/acpi/cppc_acpi.c                                      |    2 
 drivers/acpi/osi.c                                            |    1 
 drivers/ata/pata_via.c                                        |    3 
 drivers/atm/atmtcp.c                                          |    4 
 drivers/base/power/domain.c                                   |    2 
 drivers/base/power/main.c                                     |    3 
 drivers/base/power/runtime.c                                  |    2 
 drivers/base/swnode.c                                         |    2 
 drivers/block/aoe/aoedev.c                                    |    8 
 drivers/bluetooth/hci_qca.c                                   |   14 
 drivers/bus/fsl-mc/fsl-mc-bus.c                               |    6 
 drivers/bus/fsl-mc/fsl-mc-uapi.c                              |    4 
 drivers/bus/fsl-mc/mc-io.c                                    |   19 
 drivers/bus/fsl-mc/mc-sys.c                                   |    2 
 drivers/bus/mhi/host/pm.c                                     |   18 
 drivers/bus/ti-sysc.c                                         |   49 -
 drivers/clk/bcm/clk-raspberrypi.c                             |    2 
 drivers/clk/meson/g12a.c                                      |    1 
 drivers/clk/qcom/dispcc-sm6350.c                              |    3 
 drivers/clk/qcom/gcc-msm8939.c                                |    4 
 drivers/clk/qcom/gcc-sm6350.c                                 |    6 
 drivers/clk/qcom/gpucc-sm6350.c                               |    6 
 drivers/clk/rockchip/clk-rk3036.c                             |    1 
 drivers/counter/interrupt-cnt.c                               |    9 
 drivers/cpufreq/acpi-cpufreq.c                                |    2 
 drivers/cpufreq/scmi-cpufreq.c                                |   36 +
 drivers/cpufreq/tegra186-cpufreq.c                            |    7 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c           |    7 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h                  |    2 
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c           |    2 
 drivers/crypto/marvell/cesa/cesa.c                            |    2 
 drivers/crypto/marvell/cesa/cesa.h                            |    9 
 drivers/crypto/marvell/cesa/cipher.c                          |    3 
 drivers/crypto/marvell/cesa/hash.c                            |    2 
 drivers/crypto/marvell/cesa/tdma.c                            |   53 +
 drivers/dma-buf/udmabuf.c                                     |    5 
 drivers/dma/ti/k3-udma.c                                      |    3 
 drivers/edac/altera_edac.c                                    |    6 
 drivers/edac/skx_common.c                                     |    1 
 drivers/firmware/Kconfig                                      |    1 
 drivers/firmware/arm_sdei.c                                   |   11 
 drivers/firmware/efi/libstub/efi-stub-helper.c                |    1 
 drivers/firmware/psci/psci.c                                  |    4 
 drivers/gpu/drm/amd/display/dc/dml/Makefile                   |    3 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c           |    8 
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c                    |    6 
 drivers/gpu/drm/meson/meson_drv.c                             |    2 
 drivers/gpu/drm/meson/meson_drv.h                             |    2 
 drivers/gpu/drm/meson/meson_encoder_hdmi.c                    |   29 -
 drivers/gpu/drm/meson/meson_vclk.c                            |  226 ++++----
 drivers/gpu/drm/meson/meson_vclk.h                            |   13 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c          |   14 
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c                    |    7 
 drivers/gpu/drm/nouveau/nouveau_backlight.c                   |    2 
 drivers/gpu/drm/rcar-du/rcar_du_kms.c                         |   10 
 drivers/gpu/drm/tegra/rgb.c                                   |   14 
 drivers/gpu/drm/vkms/vkms_crtc.c                              |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                       |   26 
 drivers/hid/hid-hyperv.c                                      |    4 
 drivers/hid/usbhid/hid-core.c                                 |   25 
 drivers/hwmon/asus-ec-sensors.c                               |    4 
 drivers/hwmon/occ/common.c                                    |  240 +++------
 drivers/hwtracing/coresight/coresight-config.h                |    2 
 drivers/hwtracing/coresight/coresight-syscfg.c                |   49 +
 drivers/i2c/busses/i2c-designware-slave.c                     |    2 
 drivers/i2c/busses/i2c-npcm7xx.c                              |   12 
 drivers/i2c/busses/i2c-tegra.c                                |    5 
 drivers/iio/accel/fxls8962af-core.c                           |   15 
 drivers/iio/adc/ad7124.c                                      |    4 
 drivers/iio/adc/ad7606_spi.c                                  |    2 
 drivers/iio/filter/admv8818.c                                 |  224 ++++++--
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c              |    8 
 drivers/infiniband/core/cm.c                                  |   16 
 drivers/infiniband/core/cma.c                                 |    3 
 drivers/infiniband/core/iwcm.c                                |   29 -
 drivers/infiniband/hw/hns/hns_roce_ah.c                       |    1 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                    |    1 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h                    |    1 
 drivers/infiniband/hw/hns/hns_roce_main.c                     |    1 
 drivers/infiniband/hw/hns/hns_roce_restrack.c                 |    1 
 drivers/infiniband/hw/mlx5/qpc.c                              |   30 +
 drivers/input/keyboard/gpio_keys.c                            |    2 
 drivers/input/misc/ims-pcu.c                                  |    6 
 drivers/input/misc/sparcspkr.c                                |   22 
 drivers/input/rmi4/rmi_f34.c                                  |  135 ++---
 drivers/iommu/Kconfig                                         |    1 
 drivers/iommu/amd/iommu.c                                     |    8 
 drivers/iommu/iommu.c                                         |    4 
 drivers/md/dm-raid1.c                                         |    5 
 drivers/md/dm.c                                               |   30 -
 drivers/media/common/videobuf2/videobuf2-dma-sg.c             |    4 
 drivers/media/i2c/ccs-pll.c                                   |   11 
 drivers/media/i2c/ov8856.c                                    |    9 
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c                |   12 
 drivers/media/platform/qcom/venus/core.c                      |   16 
 drivers/media/platform/ti/davinci/vpif.c                      |    4 
 drivers/media/platform/ti/omap3isp/ispccdc.c                  |    8 
 drivers/media/platform/ti/omap3isp/ispstat.c                  |    6 
 drivers/media/test-drivers/vidtv/vidtv_channel.c              |    2 
 drivers/media/test-drivers/vivid/vivid-vid-cap.c              |    2 
 drivers/media/usb/dvb-usb/cxusb.c                             |    3 
 drivers/media/usb/gspca/stv06xx/stv06xx_hdcs.c                |    7 
 drivers/media/usb/uvc/uvc_ctrl.c                              |   23 
 drivers/media/usb/uvc/uvc_driver.c                            |   27 -
 drivers/media/v4l2-core/v4l2-dev.c                            |   14 
 drivers/mfd/exynos-lpass.c                                    |    1 
 drivers/mfd/stmpe-spi.c                                       |    2 
 drivers/misc/vmw_vmci/vmci_host.c                             |   11 
 drivers/mmc/core/card.h                                       |    6 
 drivers/mmc/core/quirks.h                                     |   10 
 drivers/mmc/core/sd.c                                         |   32 -
 drivers/mtd/nand/ecc-mxic.c                                   |    2 
 drivers/mtd/nand/raw/sunxi_nand.c                             |    2 
 drivers/net/can/m_can/tcan4x5x-core.c                         |    9 
 drivers/net/ethernet/aquantia/atlantic/aq_main.c              |    1 
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c               |    2 
 drivers/net/ethernet/cadence/macb_main.c                      |    6 
 drivers/net/ethernet/cortina/gemini.c                         |   37 +
 drivers/net/ethernet/dlink/dl2k.c                             |   14 
 drivers/net/ethernet/dlink/dl2k.h                             |    2 
 drivers/net/ethernet/emulex/benet/be_cmds.c                   |    2 
 drivers/net/ethernet/faraday/Kconfig                          |    1 
 drivers/net/ethernet/google/gve/gve_main.c                    |    2 
 drivers/net/ethernet/google/gve/gve_tx_dqo.c                  |    3 
 drivers/net/ethernet/intel/i40e/i40e_common.c                 |    7 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c            |   11 
 drivers/net/ethernet/intel/ice/ice_arfs.c                     |   48 +
 drivers/net/ethernet/intel/ice/ice_sched.c                    |  181 +++++-
 drivers/net/ethernet/intel/ice/ice_switch.c                   |    4 
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c            |    9 
 drivers/net/ethernet/mediatek/mtk_star_emac.c                 |    4 
 drivers/net/ethernet/mellanox/mlx4/en_clock.c                 |    2 
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c               |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c               |   12 
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c             |    5 
 drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c           |    2 
 drivers/net/ethernet/mellanox/mlx5/core/vport.c               |   18 
 drivers/net/ethernet/microchip/lan743x_ethtool.c              |   18 
 drivers/net/ethernet/microchip/lan743x_main.c                 |    4 
 drivers/net/ethernet/microchip/lan743x_ptp.c                  |    2 
 drivers/net/ethernet/microchip/lan743x_ptp.h                  |    5 
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c         |    1 
 drivers/net/ethernet/microchip/lan966x/lan966x_main.h         |    1 
 drivers/net/ethernet/microchip/lan966x/lan966x_switchdev.c    |    1 
 drivers/net/ethernet/microchip/lan966x/lan966x_vlan.c         |   21 
 drivers/net/ethernet/pensando/ionic/ionic_main.c              |    3 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c             |    5 
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c         |   11 
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c              |    2 
 drivers/net/ethernet/vertexcom/mse102x.c                      |   15 
 drivers/net/macsec.c                                          |   40 +
 drivers/net/phy/mdio_bus.c                                    |   16 
 drivers/net/phy/mscc/mscc_ptp.c                               |   20 
 drivers/net/usb/aqc111.c                                      |   10 
 drivers/net/usb/ch9200.c                                      |    7 
 drivers/net/vmxnet3/vmxnet3_drv.c                             |   26 
 drivers/net/vxlan/vxlan_core.c                                |    8 
 drivers/net/wireguard/device.c                                |    1 
 drivers/net/wireless/ath/ath10k/snoc.c                        |    4 
 drivers/net/wireless/ath/ath11k/ce.c                          |   11 
 drivers/net/wireless/ath/ath11k/core.c                        |   37 -
 drivers/net/wireless/ath/ath11k/core.h                        |    4 
 drivers/net/wireless/ath/ath11k/debugfs.c                     |   61 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c                       |   25 
 drivers/net/wireless/ath/ath11k/hal.c                         |    4 
 drivers/net/wireless/ath/ath11k/mac.c                         |    4 
 drivers/net/wireless/ath/ath11k/qmi.c                         |    9 
 drivers/net/wireless/ath/ath11k/testmode.c                    |   64 --
 drivers/net/wireless/ath/ath11k/testmode.h                    |    8 
 drivers/net/wireless/ath/ath11k/wmi.c                         |    2 
 drivers/net/wireless/ath/ath9k/htc_drv_beacon.c               |    3 
 drivers/net/wireless/ath/carl9170/usb.c                       |   19 
 drivers/net/wireless/intersil/p54/fwio.c                      |    2 
 drivers/net/wireless/intersil/p54/p54.h                       |    1 
 drivers/net/wireless/intersil/p54/txrx.c                      |   13 
 drivers/net/wireless/mac80211_hwsim.c                         |    5 
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c               |    2 
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c          |   13 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c              |    5 
 drivers/net/wireless/purelifi/plfxlc/usb.c                    |    4 
 drivers/net/wireless/realtek/rtlwifi/pci.c                    |   10 
 drivers/net/wireless/realtek/rtw88/coex.c                     |    2 
 drivers/net/wireless/realtek/rtw88/rtw8822c.c                 |    3 
 drivers/nvme/target/fcloop.c                                  |   31 -
 drivers/pci/controller/cadence/pcie-cadence-ep.c              |    5 
 drivers/pci/controller/cadence/pcie-cadence-host.c            |   11 
 drivers/pci/controller/dwc/pcie-dw-rockchip.c                 |    2 
 drivers/pci/controller/pcie-apple.c                           |    4 
 drivers/pci/pci.c                                             |    3 
 drivers/pci/pcie/dpc.c                                        |    2 
 drivers/pci/quirks.c                                          |   23 
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c                       |    6 
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c                   |   35 -
 drivers/pinctrl/pinctrl-at91.c                                |    6 
 drivers/pinctrl/pinctrl-mcp23s08.c                            |    8 
 drivers/pinctrl/qcom/pinctrl-qcm2290.c                        |    9 
 drivers/platform/loongarch/loongson-laptop.c                  |   87 +--
 drivers/platform/x86/dell/dell_rbu.c                          |    6 
 drivers/platform/x86/ideapad-laptop.c                         |    3 
 drivers/power/reset/at91-reset.c                              |    5 
 drivers/power/supply/bq27xxx_battery.c                        |    2 
 drivers/power/supply/bq27xxx_battery_i2c.c                    |   13 
 drivers/ptp/ptp_clock.c                                       |    3 
 drivers/ptp/ptp_private.h                                     |   12 
 drivers/rapidio/rio_cm.c                                      |    3 
 drivers/regulator/max14577-regulator.c                        |    5 
 drivers/regulator/max20086-regulator.c                        |   10 
 drivers/remoteproc/qcom_wcnss_iris.c                          |    2 
 drivers/remoteproc/remoteproc_core.c                          |    6 
 drivers/remoteproc/ti_k3_r5_remoteproc.c                      |    8 
 drivers/rpmsg/qcom_smd.c                                      |    2 
 drivers/rtc/class.c                                           |    2 
 drivers/rtc/lib.c                                             |   24 
 drivers/rtc/rtc-sh.c                                          |   12 
 drivers/s390/scsi/zfcp_sysfs.c                                |    2 
 drivers/scsi/elx/efct/efct_hw.c                               |    5 
 drivers/scsi/hisi_sas/hisi_sas_main.c                         |   29 -
 drivers/scsi/lpfc/lpfc_hbadisc.c                              |    2 
 drivers/scsi/lpfc/lpfc_sli.c                                  |    4 
 drivers/scsi/qedf/qedf_main.c                                 |    2 
 drivers/scsi/scsi_transport_iscsi.c                           |   11 
 drivers/scsi/storvsc_drv.c                                    |   10 
 drivers/soc/aspeed/aspeed-lpc-snoop.c                         |   17 
 drivers/spi/spi-bcm63xx-hsspi.c                               |    2 
 drivers/spi/spi-bcm63xx.c                                     |    2 
 drivers/spi/spi-sh-msiof.c                                    |   13 
 drivers/spi/spi-tegra210-quad.c                               |   24 
 drivers/staging/iio/impedance-analyzer/ad5933.c               |    2 
 drivers/staging/media/rkvdec/rkvdec.c                         |   10 
 drivers/tee/tee_core.c                                        |   11 
 drivers/thunderbolt/ctl.c                                     |    5 
 drivers/tty/serial/milbeaut_usio.c                            |    5 
 drivers/tty/serial/sh-sci.c                                   |   97 ++-
 drivers/tty/vt/vt_ioctl.c                                     |    2 
 drivers/ufs/core/ufshcd.c                                     |    7 
 drivers/uio/uio_hv_generic.c                                  |    4 
 drivers/usb/cdns3/cdnsp-gadget.c                              |   21 
 drivers/usb/cdns3/cdnsp-gadget.h                              |    4 
 drivers/usb/class/usbtmc.c                                    |   21 
 drivers/usb/core/hub.c                                        |   16 
 drivers/usb/core/quirks.c                                     |    3 
 drivers/usb/gadget/function/f_hid.c                           |   12 
 drivers/usb/renesas_usbhs/common.c                            |   50 +
 drivers/usb/serial/pl2303.c                                   |    2 
 drivers/usb/storage/unusual_uas.h                             |    7 
 drivers/usb/typec/tcpm/tcpci_maxim.c                          |    3 
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c                |   57 +-
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h                |   14 
 drivers/vfio/vfio_iommu_type1.c                               |    2 
 drivers/video/backlight/qcom-wled.c                           |    6 
 drivers/video/console/vgacon.c                                |    2 
 drivers/video/fbdev/core/fbcon.c                              |    7 
 drivers/video/fbdev/core/fbcvt.c                              |    2 
 drivers/video/fbdev/core/fbmem.c                              |    4 
 drivers/watchdog/da9052_wdt.c                                 |    1 
 drivers/watchdog/exar_wdt.c                                   |    2 
 fs/ceph/super.c                                               |    1 
 fs/configfs/dir.c                                             |    2 
 fs/ext4/ext4.h                                                |    7 
 fs/ext4/extents.c                                             |   18 
 fs/ext4/file.c                                                |    7 
 fs/ext4/inline.c                                              |    2 
 fs/ext4/inode.c                                               |    3 
 fs/f2fs/data.c                                                |    4 
 fs/f2fs/f2fs.h                                                |   10 
 fs/f2fs/namei.c                                               |   19 
 fs/f2fs/super.c                                               |   12 
 fs/filesystems.c                                              |   14 
 fs/gfs2/inode.c                                               |    3 
 fs/gfs2/lock_dlm.c                                            |    3 
 fs/jbd2/transaction.c                                         |    5 
 fs/jffs2/erase.c                                              |    4 
 fs/jffs2/scan.c                                               |    4 
 fs/jffs2/summary.c                                            |    7 
 fs/kernfs/dir.c                                               |    5 
 fs/kernfs/file.c                                              |    3 
 fs/namespace.c                                                |    6 
 fs/nfs/super.c                                                |   19 
 fs/nfsd/nfs4proc.c                                            |    3 
 fs/nfsd/nfssvc.c                                              |    6 
 fs/nilfs2/btree.c                                             |    4 
 fs/nilfs2/direct.c                                            |    3 
 fs/ntfs3/index.c                                              |    8 
 fs/ocfs2/quota_local.c                                        |    2 
 fs/smb/client/cached_dir.h                                    |    8 
 fs/smb/client/connect.c                                       |    8 
 fs/smb/client/readdir.c                                       |   28 -
 fs/smb/server/smb2pdu.c                                       |   11 
 fs/squashfs/super.c                                           |    5 
 fs/userfaultfd.c                                              |    6 
 fs/xfs/Kconfig                                                |   12 
 fs/xfs/libxfs/xfs_alloc.c                                     |   10 
 fs/xfs/libxfs/xfs_dir2_data.c                                 |   31 -
 fs/xfs/libxfs/xfs_dir2_priv.h                                 |    7 
 fs/xfs/libxfs/xfs_quota_defs.h                                |    2 
 fs/xfs/libxfs/xfs_refcount.c                                  |   13 
 fs/xfs/libxfs/xfs_rmap.c                                      |   10 
 fs/xfs/libxfs/xfs_trans_resv.c                                |   28 -
 fs/xfs/scrub/bmap.c                                           |    8 
 fs/xfs/xfs.h                                                  |    4 
 fs/xfs/xfs_bmap_util.c                                        |   22 
 fs/xfs/xfs_buf_item.c                                         |   32 +
 fs/xfs/xfs_dquot_item.c                                       |   31 +
 fs/xfs/xfs_file.c                                             |   33 -
 fs/xfs/xfs_file.h                                             |   15 
 fs/xfs/xfs_fsmap.c                                            |  266 +++++-----
 fs/xfs/xfs_inode.c                                            |   29 -
 fs/xfs/xfs_inode.h                                            |    2 
 fs/xfs/xfs_inode_item.c                                       |   32 +
 fs/xfs/xfs_ioctl.c                                            |   12 
 fs/xfs/xfs_iops.c                                             |    1 
 fs/xfs/xfs_iops.h                                             |    3 
 fs/xfs/xfs_rtalloc.c                                          |   78 ++
 fs/xfs/xfs_symlink.c                                          |    8 
 fs/xfs/xfs_trace.h                                            |   25 
 include/acpi/actypes.h                                        |    2 
 include/linux/arm_sdei.h                                      |    4 
 include/linux/atmdev.h                                        |    6 
 include/linux/bio.h                                           |    2 
 include/linux/hid.h                                           |    3 
 include/linux/hugetlb.h                                       |    3 
 include/linux/mlx5/driver.h                                   |    1 
 include/linux/mm.h                                            |    3 
 include/linux/mm_types.h                                      |    3 
 include/linux/mmc/card.h                                      |    1 
 include/net/bluetooth/hci_core.h                              |    1 
 include/net/checksum.h                                        |    2 
 include/net/sock.h                                            |    7 
 include/trace/events/erofs.h                                  |   18 
 include/uapi/linux/bpf.h                                      |    2 
 io_uring/io_uring.c                                           |   10 
 ipc/shm.c                                                     |    5 
 kernel/bpf/core.c                                             |    2 
 kernel/bpf/helpers.c                                          |    3 
 kernel/cgroup/legacy_freezer.c                                |    3 
 kernel/events/core.c                                          |   57 +-
 kernel/exit.c                                                 |   17 
 kernel/power/wakelock.c                                       |    3 
 kernel/time/clocksource.c                                     |    2 
 kernel/time/posix-cpu-timers.c                                |    9 
 kernel/trace/bpf_trace.c                                      |    2 
 kernel/trace/ftrace.c                                         |   10 
 kernel/trace/trace.c                                          |    2 
 kernel/trace/trace.h                                          |    8 
 kernel/trace/trace_events_hist.c                              |    2 
 kernel/trace/trace_events_trigger.c                           |   20 
 lib/Kconfig                                                   |    1 
 mm/huge_memory.c                                              |   11 
 mm/hugetlb.c                                                  |   83 ++-
 mm/mmap.c                                                     |    8 
 mm/page-writeback.c                                           |    2 
 net/atm/common.c                                              |    1 
 net/atm/lec.c                                                 |   12 
 net/atm/raw.c                                                 |    2 
 net/bluetooth/eir.c                                           |   10 
 net/bluetooth/hci_core.c                                      |   15 
 net/bluetooth/hci_sync.c                                      |   20 
 net/bluetooth/l2cap_core.c                                    |    3 
 net/bluetooth/mgmt.c                                          |   39 -
 net/bluetooth/mgmt_util.c                                     |    2 
 net/bridge/br_mst.c                                           |    4 
 net/bridge/br_multicast.c                                     |  103 +++
 net/bridge/br_private.h                                       |   11 
 net/bridge/netfilter/nf_conntrack_bridge.c                    |   12 
 net/core/filter.c                                             |    5 
 net/core/skmsg.c                                              |   56 +-
 net/core/sock.c                                               |    4 
 net/core/utils.c                                              |    4 
 net/dsa/tag_brcm.c                                            |    2 
 net/ipv4/route.c                                              |    4 
 net/ipv4/tcp_fastopen.c                                       |    3 
 net/ipv4/tcp_input.c                                          |   63 +-
 net/ipv4/udp_offload.c                                        |    5 
 net/ipv6/calipso.c                                            |    8 
 net/ipv6/ila/ila_common.c                                     |    6 
 net/ipv6/netfilter.c                                          |   12 
 net/ipv6/netfilter/nft_fib_ipv6.c                             |   13 
 net/ipv6/seg6_local.c                                         |    6 
 net/mac80211/mesh_hwmp.c                                      |    6 
 net/mpls/af_mpls.c                                            |    4 
 net/ncsi/internal.h                                           |   21 
 net/ncsi/ncsi-pkt.h                                           |   23 
 net/ncsi/ncsi-rsp.c                                           |   21 
 net/netfilter/nft_quota.c                                     |   20 
 net/netfilter/nft_set_pipapo_avx2.c                           |   21 
 net/netfilter/nft_tunnel.c                                    |    8 
 net/netlabel/netlabel_kapi.c                                  |    5 
 net/nfc/nci/uart.c                                            |    8 
 net/openvswitch/flow.c                                        |    2 
 net/sched/sch_ets.c                                           |    2 
 net/sched/sch_prio.c                                          |    2 
 net/sched/sch_red.c                                           |    2 
 net/sched/sch_sfq.c                                           |   15 
 net/sched/sch_tbf.c                                           |    2 
 net/sctp/socket.c                                             |    3 
 net/tipc/crypto.c                                             |    8 
 net/tipc/udp_media.c                                          |    4 
 net/tls/tls_sw.c                                              |   15 
 net/wireless/core.c                                           |    6 
 scripts/Makefile.clang                                        |    3 
 scripts/Makefile.compiler                                     |    4 
 scripts/gcc-plugins/gcc-common.h                              |   32 +
 scripts/gcc-plugins/randomize_layout_plugin.c                 |   40 -
 security/selinux/xfrm.c                                       |    2 
 sound/pci/hda/hda_intel.c                                     |    2 
 sound/pci/hda/patch_realtek.c                                 |    1 
 sound/soc/amd/yc/acp6x-mach.c                                 |    9 
 sound/soc/apple/mca.c                                         |   23 
 sound/soc/codecs/hda.c                                        |    4 
 sound/soc/codecs/tas2764.c                                    |    2 
 sound/soc/codecs/tas2770.c                                    |   30 +
 sound/soc/intel/avs/ipc.c                                     |    4 
 sound/soc/meson/meson-card-utils.c                            |    2 
 sound/soc/qcom/sdm845.c                                       |    4 
 sound/soc/tegra/tegra210_ahub.c                               |    2 
 sound/usb/implicit.c                                          |    1 
 sound/usb/mixer_maps.c                                        |   12 
 tools/bpf/resolve_btfids/Makefile                             |    2 
 tools/include/uapi/linux/bpf.h                                |    2 
 tools/lib/bpf/bpf_core_read.h                                 |    6 
 tools/lib/bpf/btf.c                                           |   16 
 tools/lib/bpf/libbpf.c                                        |    2 
 tools/lib/bpf/linker.c                                        |    4 
 tools/lib/bpf/nlattr.c                                        |   15 
 tools/perf/Makefile.config                                    |    2 
 tools/perf/builtin-record.c                                   |    2 
 tools/perf/scripts/python/exported-sql-viewer.py              |    5 
 tools/perf/tests/switch-tracking.c                            |    2 
 tools/perf/ui/browsers/hists.c                                |    2 
 tools/perf/util/intel-pt.c                                    |  205 +++++++
 tools/testing/selftests/seccomp/seccomp_bpf.c                 |    7 
 tools/testing/selftests/x86/Makefile                          |    2 
 tools/testing/selftests/x86/sigtrap_loop.c                    |  101 +++
 usr/include/Makefile                                          |    2 
 499 files changed, 4440 insertions(+), 2092 deletions(-)

Adam Ford (2):
      arm64: dts: imx8mm-beacon: Fix RTC capacitive load
      arm64: dts: imx8mn-beacon: Fix RTC capacitive load

Adrian Hunter (2):
      perf intel-pt: Fix PEBS-via-PT data_src
      perf scripts python: exported-sql-viewer.py: Fix pattern matching with Python 3

Ahmed S. Darwish (1):
      x86/cpu: Sanitize CPUID(0x80000000) output

Ahmed Salem (1):
      ACPICA: Avoid sequence overread in call to strncmp()

Akhil R (2):
      i2c: tegra: check msg length in SMBUS block read
      dt-bindings: i2c: nvidia,tegra20-i2c: Specify the required properties

Al Viro (2):
      fix propagation graph breakage by MOVE_MOUNT_SET_GROUP move_mount(2)
      do_change_type(): refuse to operate on unmounted/not ours mounts

Alan Maguire (1):
      libbpf: Add identical pointer detection to btf_dedup_is_equiv()

Alexander Aring (1):
      gfs2: move msleep to sleepable context

Alexander Shiyan (1):
      power: reset: at91-reset: Optimize at91_reset()

Alexander Sverdlin (2):
      counter: interrupt-cnt: Protect enable/disable OPs with mutex
      Revert "bus: ti-sysc: Probe for l4_wkup and l4_cfg interconnect devices first"

Alexandre Mergnat (2):
      rtc: Make rtc_time64_to_tm() support dates before 1970
      rtc: Fix offset calculation for .start_secs < 0

Alexei Safin (1):
      hwmon: (asus-ec-sensors) check sensor index in read_string()

Alexey Gladkov (1):
      mfd: stmpe-spi: Correct the name used in MODULE_DEVICE_TABLE

Alexey Kodanev (2):
      wifi: rtw88: fix the 'para' buffer size to avoid reading out of bounds
      net: lan743x: fix potential out-of-bounds write in lan743x_ptp_io_event_clock_get()

Alexey Minnekhanov (3):
      arm64: dts: qcom: sdm660-xiaomi-lavender: Add missing SD card detect GPIO
      arm64: dts: qcom: sdm660-lavender: Add missing USB phy supply
      arm64: dts: qcom: sda660-ifc6560: Fix dt-validate warning

Alexis Lothoré (1):
      net: stmmac: make sure that ptp_rate is not 0 before configuring timestamping

Alok Tiwari (4):
      gve: Fix RX_BUFFERS_POSTED stat to report per-queue fill_cnt
      gve: add missing NULL check for gve_alloc_pending_packet() in TX DQO
      scsi: iscsi: Fix incorrect error path labels for flashnode operations
      emulex/benet: correct command version selection in be_cmd_get_stats()

Amit Sunil Dhamne (1):
      usb: typec: tcpm/tcpci_maxim: Fix bounds check in process_rx()

Andre Przywara (1):
      dt-bindings: vendor-prefixes: Add Liontron name

Andreas Gruenbacher (1):
      gfs2: gfs2_create_inode error handling fix

Andreas Kemnade (1):
      ARM: omap: pmic-cpcap: do not mess around without CPCAP or OMAP4

Andrew Lunn (1):
      net: mdio: C22 is now optional, EOPNOTSUPP if not provided

Andrew Morton (1):
      drivers/rapidio/rio_cm.c: prevent possible heap overwrite

Andrew Zaborowski (1):
      x86/sgx: Prevent attempts to reclaim poisoned pages

Andrey Vatoropin (1):
      fs/ntfs3: handle hdr_first_de() return value

Andy Shevchenko (1):
      pinctrl: at91: Fix possible out-of-boundary access

AngeloGioacchino Del Regno (1):
      arm64: dts: mediatek: mt8195: Reparent vdec1/2 and venc1 power domains

Anton Protopopov (3):
      libbpf: Use proper errno value in linker
      bpf: Fix uninitialized values in BPF_{CORE,PROBE}_READ
      libbpf: Use proper errno value in nlattr

Anup Patel (2):
      RISC-V: KVM: Fix the size parameter check in SBI SFENCE calls
      RISC-V: KVM: Don't treat SBI HFENCE calls as NOPs

Armin Wolf (2):
      ACPI: OSI: Stop advertising support for "3.0 _SCP Extensions"
      ACPI: bus: Bail out if acpi_kobj registration fails

Arnaldo Carvalho de Melo (2):
      perf build: Warn when libdebuginfod devel files are not available
      perf ui browser hists: Set actions->thread before calling do_zoom_thread()

Arnd Bergmann (4):
      kbuild: hdrcheck: fix cross build with clang
      parisc: fix building with gcc-15
      hwmon: (occ) Rework attribute registration for stack usage
      hwmon: (occ) fix unaligned accesses

Artem Sadovnikov (1):
      jffs2: check that raw node were preallocated before writing summary

Baochen Qiang (3):
      wifi: ath11k: avoid burning CPU in ath11k_debugfs_fw_stats_request()
      wifi: ath11k: don't use static variables in ath11k_debugfs_fw_stats_process()
      wifi: ath11k: don't wait when there is no vdev started

Bartosz Golaszewski (1):
      Bluetooth: hci_qca: move the SoC type check to the right place

Benjamin Berg (1):
      wifi: mac80211: do not offer a mesh path if forwarding is disabled

Benjamin Marzinski (2):
      dm: don't change md if dm_table_set_restrictions() fails
      dm: free table mempools if not used in __bind

Bharath SM (1):
      smb: improve directory cache reuse for readdir operations

Biju Das (2):
      drm: rcar-du: Fix memory leak in rcar_du_vsps_init()
      drm/tegra: rgb: Fix the unbound reference count

Bjorn Helgaas (1):
      PCI/DPC: Initialize aer_err_info before using it

Breno Leitao (1):
      Revert "x86/bugs: Make spectre user default depend on MITIGATION_SPECTRE_V2" on v6.6 and older

Brett Creeley (1):
      ionic: Prevent driver/fw getting out of sync on devcmd(s)

Brett Werling (1):
      can: tcan4x5x: fix power regulator retrieval during probe

Brian Pellegrino (1):
      iio: filter: admv8818: Support frequencies >= 2^32

Caleb Connolly (1):
      ath10k: snoc: fix unbalanced IRQ enable in crash recovery

Carlos Fernandez (1):
      macsec: MACsec SCI assignment for ES = 0

Cezary Rojewski (2):
      ASoC: codecs: hda: Fix RPM usage count underflow
      ASoC: Intel: avs: Fix deadlock when the failing IPC is SET_D0IX

Chao Yu (4):
      f2fs: fix to do sanity check on sbi->total_valid_block_count
      f2fs: clean up w/ fscrypt_is_bounce_page()
      f2fs: fix to detect gcing page in f2fs_is_cp_guaranteed()
      f2fs: fix to do sanity check on sit_bitmap_size

Charalampos Mitrodimas (1):
      net: tipc: fix refcount warning in tipc_aead_encrypt

Charan Teja Kalla (1):
      PM: runtime: fix denying of auto suspend in pm_suspend_timer_fn()

Charles Han (1):
      drm/amd/pp: Fix potential NULL pointer dereference in atomctrl_initialize_mc_reg_table

Charles Yeh (1):
      USB: serial: pl2303: add new chip PL2303GC-Q20 and PL2303GT-2AB

Chen Ridong (1):
      cgroup,freezer: fix incomplete freezing when attaching tasks

Chenyuan Yang (1):
      phy: qcom-qmp-usb: Fix an NULL vs IS_ERR() bug

Christian Lamparter (1):
      wifi: p54: prevent buffer-overflow in p54_rx_eeprom_readback()

Christoph Hellwig (1):
      xfs: fix the contact address for the sysfs ABI documentation

Christophe JAILLET (2):
      drm/bridge: lt9611uxc: Fix an error handling path in lt9611uxc_probe()
      mfd: exynos-lpass: Avoid calling exynos_lpass_disable() twice in exynos_lpass_remove()

Claudiu Beznea (4):
      serial: sh-sci: Check if TX data was written to device in .tx_empty()
      serial: sh-sci: Move runtime PM enable to sci_probe_single()
      serial: sh-sci: Clean sci_ports[0] after at earlycon exit
      serial: sh-sci: Increment the runtime usage counter for the earlycon device

Colin Foster (1):
      ARM: dts: am335x-bone-common: Increase MDIO reset deassert time

Corentin Labbe (1):
      crypto: sun8i-ss - do not use sg_dma_len before calling DMA functions

Da Xue (1):
      clk: meson-g12a: add missing fclk_div2 to spicc

Dan Carpenter (6):
      remoteproc: qcom_wcnss_iris: Add missing put_device() on error in probe
      rpmsg: qcom_smd: Fix uninitialized return variable in __qcom_smd_send()
      net/mlx4_en: Prevent potential integer overflow calculating Hz
      pmdomain: core: Fix error checking in genpd_dev_pm_attach_by_id()
      regulator: max20086: Fix refcount leak in max20086_parse_regulators_dt()
      Input: ims-pcu - check record size in ims_pcu_flash_firmware()

Daniel Wagner (2):
      nvmet-fcloop: access fcpreq only when holding reqlock
      scsi: lpfc: Use memcpy() for BIOS version

Dapeng Mi (1):
      perf record: Fix incorrect --user-regs comments

Darrick J. Wong (17):
      xfs: fix interval filtering in multi-step fsmap queries
      xfs: fix integer overflows in the fsmap rtbitmap and logdev backends
      xfs: fix getfsmap reporting past the last rt extent
      xfs: clean up the rtbitmap fsmap backend
      xfs: fix logdev fsmap query result filtering
      xfs: validate fsmap offsets specified in the query keys
      xfs: fix xfs_btree_query_range callers to initialize btree rec fully
      xfs: fix an agbno overflow in __xfs_getfsmap_datadev
      xfs: verify buffer, inode, and dquot items every tx commit
      xfs: use consistent uid/gid when grabbing dquots for inodes
      xfs: declare xfs_file.c symbols in xfs_file.h
      xfs: create a new helper to return a file's allocation unit
      xfs: attr forks require attr, not attr2
      xfs: conditionally allow FS_XFLAG_REALTIME changes if S_DAX is set
      xfs: use XFS_BUF_DADDR_NULL for daddrs in getfsmap code
      xfs: take m_growlock when running growfsrt
      xfs: reset rootdir extent size hint after growfsrt

Dave Penkler (2):
      usb: usbtmc: Fix timeout value in get_stb
      usb: usbtmc: Fix read_stb function and get_stb ioctl

David Heimann (1):
      ALSA: usb-audio: Add implicit feedback quirk for RODE AI-1

David Lechner (1):
      iio: adc: ad7606_spi: fix reg write value mask

David Wei (1):
      tcp: fix passive TFO socket having invalid NAPI ID

Denis Arefev (1):
      media: vivid: Change the siize of the composing

Dennis Marttinen (1):
      ceph: set superblock s_magic for IMA fsmagic matching

Dexuan Cui (1):
      scsi: storvsc: Increase the timeouts to storvsc_timeout

Diederik de Haas (1):
      PCI: dw-rockchip: Fix PHY function call sequence in rockchip_pcie_phy_deinit()

Dmitry Antipov (3):
      wifi: rtw88: do not ignore hardware read error during DPK
      Bluetooth: MGMT: iterate over mesh commands in mgmt_mesh_foreach()
      wifi: carl9170: do not ping device which has failed to load firmware

Dmitry Baryshkov (1):
      ARM: dts: qcom: apq8064 merge hw splinlock into corresponding syscon device

Dmitry Nikiforov (1):
      media: davinci: vpif: Fix memory leak in probe error path

Dmitry Torokhov (1):
      Input: synaptics-rmi - fix crash with unsupported versions of F34

Easwar Hariharan (1):
      wifi: ath11k: convert timeouts to secs_to_jiffies()

Eddie James (1):
      powerpc/crash: Fix non-smp kexec preparation

Edward Adam Davis (4):
      media: cxusb: no longer judge rbuf when the write fails
      media: vidtv: Terminating the subsequent process of initialization failure
      wifi: mac80211_hwsim: Prevent tsf from setting if beacon is disabled
      wifi: cfg80211: init wiphy_work before allocating rfkill fails

Eric Dumazet (11):
      net_sched: sch_sfq: fix a potential crash on gso_skb handling
      net_sched: prio: fix a race in prio_tune()
      net_sched: red: fix a race in __red_change()
      net_sched: tbf: fix a race in tbf_change()
      net_sched: ets: fix a race in ets_qdisc_change()
      calipso: unlock rcu before returning -EAFNOSUPPORT
      tcp: always seek for minimal rtt in tcp_rcv_rtt_update()
      tcp: fix initial tp->rcvq_space.space value for passive TS enabled flows
      net_sched: sch_sfq: reject invalid perturb period
      net: atm: add lec_mutex
      net: atm: fix /proc/net/atm/lec handling

Erick Shepherd (1):
      mmc: Add quirk to disable DDR50 tuning

Faicker Mo (1):
      net: openvswitch: Fix the dead loop of MPLS parse

Fedor Pchelkin (1):
      jffs2: check jffs2_prealloc_raw_node_refs() result in few other places

Fernando Fernandez Mancera (1):
      netfilter: nft_tunnel: fix geneve_opt dump

Finn Thain (1):
      m68k: mac: Fix macintosh_config for Mac II

Florian Westphal (2):
      netfilter: nf_tables: nft_fib_ipv6: fix VRF ipv4/ipv6 result discrepancy
      netfilter: nf_set_pipapo_avx2: fix initial map fill

GONG Ruiqi (1):
      vgacon: Add check for vc_origin address range in vgacon_scroll()

Gabor Juhos (7):
      pinctrl: armada-37xx: use correct OUTPUT_VAL register for GPIOs > 31
      pinctrl: armada-37xx: set GPIO output value before setting direction
      arm64: dts: marvell: uDPU: define pinctrl state for alarm LEDs
      pinctrl: armada-37xx: propagate error from armada_37xx_pmx_set_by_name()
      pinctrl: armada-37xx: propagate error from armada_37xx_gpio_get_direction()
      pinctrl: armada-37xx: propagate error from armada_37xx_pmx_gpio_set_direction()
      pinctrl: armada-37xx: propagate error from armada_37xx_gpio_get()

Gabriel Shahrouzi (1):
      staging: iio: ad5933: Correct settling cycles encoding per datasheet

Gao Xiang (1):
      erofs: remove unused trace event erofs_destroy_inode

Gatien Chevallier (1):
      Input: gpio-keys - fix possible concurrent access in gpio_keys_irq_timer()

Gautam Menghani (1):
      powerpc/pseries/msi: Avoid reading PCI device registers in reduced power states

Gautham R. Shenoy (1):
      acpi-cpufreq: Fix nominal_freq units to KHz in get_max_boost_ratio()

Gavin Guo (1):
      mm/huge_memory: fix dereferencing invalid pmd migration entry

Geert Uytterhoeven (2):
      spi: sh-msiof: Fix maximum DMA transfer size
      ARM: dts: am335x-bone-common: Increase MDIO reset deassert delay to 50ms

Govindaraj Saminathan (1):
      wifi: ath11k: remove unused function ath11k_tm_event_wmi()

Greg Kroah-Hartman (2):
      Revert "io_uring: ensure deferred completions are posted for multishot"
      Linux 6.1.142

Guilherme G. Piccoli (1):
      clocksource: Fix the CPUs' choice in the watchdog per CPU verification

Haixia Qu (1):
      tipc: fix null-ptr-deref when acquiring remote ip of ethernet bearer

Hans Zhang (2):
      efi/libstub: Describe missing 'out' parameter in efi_load_initrd
      PCI: cadence: Fix runtime atomic count underflow

Haren Myneni (1):
      powerpc/vas: Return -EINVAL if the offset is non-zero in mmap()

Hari Kalavakunta (1):
      net: ncsi: Fix GCPS 64-bit member variables

Hector Martin (3):
      ASoC: tas2764: Enable main IRQs
      PCI: apple: Use gpiod_set_value_cansleep in probe flow
      ASoC: tas2770: Power cycle amp on ISENSE/VSENSE change

Heiko Carstens (1):
      s390/pci: Fix __pcilg_mio_inuser() inline assembly

Heiko Stuebner (1):
      clk: rockchip: rk3036: mark ddrphy as critical

Heiner Kallweit (1):
      net: ftgmac100: select FIXED_PHY

Helge Deller (1):
      parisc/unaligned: Fix hex output to show 8 hex chars

Henk Vergonet (1):
      wifi: mt76: mt76x2: Add support for LiteOn WN4516R,WN4519R

Henry Martin (5):
      clk: bcm: rpi: Add NULL check in raspberrypi_clk_register()
      soc: aspeed: Add NULL check in aspeed_lpc_enable_snoop()
      backlight: pm8941: Add NULL check in wled_configure()
      dmaengine: ti: Add NULL check in udma_probe()
      serial: Fix potential null-ptr-deref in mlb_usio_probe()

Herbert Xu (5):
      crypto: marvell/cesa - Handle zero-length skcipher requests
      crypto: marvell/cesa - Avoid empty transfer descriptor
      crypto: lrw - Only add ecb if it is not already there
      crypto: xts - Only add ecb if it is not already there
      crypto: marvell/cesa - Do not chain submitted requests

Hongyu Xie (1):
      usb: storage: Ignore UAS driver for SanDisk 3.2 Gen2 storage device

Horatiu Vultur (3):
      net: phy: mscc: Fix memory leak when using one step timestamping
      net: phy: mscc: Stop clearing the the UDPv4 checksum for L2 frames
      net: lan966x: Make sure to insert the vlan tags also in host mode

Hou Tao (1):
      bpf: Check rcu_read_lock_trace_held() in bpf_map_lookup_percpu_elem()

Huacai Chen (2):
      PCI: Add ACS quirk for Loongson PCIe
      LoongArch: Avoid using $r0/$r1 as "mask" for csrxchg

Huajian Yang (1):
      netfilter: bridge: Move specific fragmented packet to slow_path instead of dropping it

Huang Yiwei (1):
      firmware: SDEI: Allow sdei initialization without ACPI_APEI_GHES

I Hsin Cheng (1):
      drm/meson: Use 1000ULL when operating with mode->clock

Ian Forbes (1):
      drm/vmwgfx: Add seqno waiter for sync_files

Ido Schimmel (2):
      seg6: Fix validation of nexthop addresses
      vxlan: Do not treat dst cache initialization errors as fatal

Ilpo Järvinen (1):
      PCI: Fix lock symmetry in pci_slot_unlock()

Ilya Leoshkevich (1):
      s390/bpf: Store backchain even for leaf progs

Ioana Ciornei (2):
      bus: fsl-mc: fix double-free on mc_dev
      bus: fsl-mc: do not add a device-link for the UAPI used DPMCP device

Jack Morgenstein (1):
      RDMA/cma: Fix hang when cma_netevent_callback fails to queue_work

Jacob Keller (1):
      drm/nouveau/bl: increase buffer size to avoid truncate warning

Jacob Moroni (1):
      IB/cm: use rwlock for MAD agent lock

Jaegeuk Kim (1):
      f2fs: prevent kernel warning due to negative i_nlink from corrupted image

Jakub Raczynski (1):
      net/mdiobus: Fix potential out-of-bounds read/write access

James A. MacInnes (1):
      drm/msm/disp: Correct porch timing for SDM845

Jan Kara (1):
      ext4: fix calculation of credits for extent tree modification

Jann Horn (3):
      tee: Prevent size calculation wraparound on 32-bit kernels
      mm/hugetlb: unshare page tables during VMA split, not before
      mm/hugetlb: fix huge_pmd_unshare() vs GUP-fast race

Jason Gunthorpe (1):
      iommu: Protect against overflow in iommu_pgsize()

Jason Xing (2):
      net: atlantic: generate software timestamp just before the doorbell
      net: mlx4: add SOF_TIMESTAMPING_TX_SOFTWARE flag when getting ts info

Jeff Hugo (1):
      bus: mhi: host: Fix conflict between power_up and SYSERR

Jeff Johnson (1):
      wifi: ath11k: fix soc_dp_stats debugfs file permission

Jeongjun Park (3):
      ptp: remove ptp->n_vclocks check logic in ptp_vclock_in_use()
      jbd2: fix data-race and null-ptr-deref in jbd2_journal_dirty_metadata()
      ipc: fix to protect IPCS lookups using RCU

Jerry Lv (1):
      power: supply: bq27xxx: Retrieve again when busy

Jianbo Liu (1):
      net/mlx5e: Fix leak of Geneve TLV option object

Jiaqing Zhao (1):
      x86/mtrr: Check if fixed-range MTRRs exist in mtrr_save_fixed_ranges()

Jiayi Li (1):
      usb: quirks: Add NO_LPM quirk for SanDisk Extreme 55AE

Jiayuan Chen (6):
      bpf: fix ktls panic with sockmap
      bpf, sockmap: fix duplicated data transmission
      bpf, sockmap: Fix panic when calling skb_linearize
      ktls, sockmap: Fix missing uncharge operation
      bpf, sockmap: Avoid using sk_socket after free when sending
      bpf, sockmap: Fix data lost during EAGAIN retries

Jinliang Zheng (1):
      mm: fix ratelimit_pages update error in dirty_ratio_handler()

Joel Stanley (1):
      ARM: aspeed: Don't select SRAM

Johan Hovold (3):
      wifi: ath11k: fix rx completion meta data corruption
      wifi: ath11k: fix ring-buffer corruption
      media: ov8856: suppress probe deferral errors

John Garry (2):
      xfs: Fix xfs_flush_unmap_range() range for RT
      xfs: Fix xfs_prepare_shift() range for RT

Jon Hunter (1):
      Revert "cpufreq: tegra186: Share policy per cluster"

Jonas Karlman (1):
      media: rkvdec: Fix frame size enumeration

Jonathan Lane (1):
      ALSA: hda/realtek: enable headset mic on Latitude 5420 Rugged

João Paulo Gonçalves (2):
      regulator: max20086: Fix MAX200086 chip id
      regulator: max20086: Change enable gpio to optional

Judith Mendez (2):
      arm64: dts: ti: k3-am65-main: Fix sdhci node properties
      arm64: dts: ti: k3-am65-main: Add missing taps to sdhci0

Julian Sun (1):
      xfs: remove unused parameter in macro XFS_DQUOT_LOGRES

Julien Massot (2):
      arm64: dts: mt6359: Add missing 'compatible' property to regulators node
      arm64: dts: mt6359: Rename RTC node to match binding expectations

Junxian Huang (1):
      RDMA/hns: Include hnae3.h in hns_roce_hw_v2.h

Justin Sanders (1):
      aoe: clean device rq_list in aoedev_downdev()

Justin Tee (1):
      scsi: lpfc: Fix lpfc_check_sli_ndlp() handling for GEN_REQUEST64 commands

KaFai Wan (1):
      bpf: Avoid __bpf_prog_ret0_warn when jit fails

Kees Cook (6):
      watchdog: exar: Shorten identity name to fit correctly
      drm/vkms: Adjust vkms_state->active_planes allocation type
      scsi: qedf: Use designated initializer for struct qed_fcoe_cb_ops
      randstruct: gcc-plugin: Remove bogus void member
      randstruct: gcc-plugin: Fix attribute addition
      fbcon: Make sure modelist not set on unregistered console

Khem Raj (1):
      mips: Add -std= flag specified in KBUILD_CFLAGS to vdso CFLAGS

Kornel Dulęba (1):
      arm64: Support ARM64_VA_BITS=52 when setting ARCH_MMAP_RND_BITS_MAX

Krishna Kumar (1):
      net: ice: Perform accurate aRFS flow match

Krzysztof Kozlowski (2):
      NFC: nci: uart: Set tty->disc_data only in success path
      drm/msm/dsi/dsi_phy_10nm: Fix missing initial VCO rate

Kuniyuki Iwashima (5):
      calipso: Don't call calipso functions for AF_INET sk.
      atm: Revert atm_account_tx() if copy_from_iter_full() fails.
      mpls: Use rcu_dereference_rtnl() in mpls_route_input_rcu().
      atm: atmtcp: Free invalid length skb in atmtcp_c_send().
      calipso: Fix null-ptr-deref in calipso_req_{set,del}attr().

Kyungwook Boo (1):
      i40e: fix MMIO write access to an invalid page in i40e_clear_hw

Lad Prabhakar (1):
      usb: renesas_usbhs: Reorder clock handling and power management in probe

Laurentiu Tudor (1):
      bus: fsl-mc: increase MC_CMD_COMPLETION_TIMEOUT_MS value

Leo Yan (1):
      perf tests switch-tracking: Fix timestamp comparison

Li Lingfeng (3):
      nfs: clear SB_RDONLY before getting superblock
      nfs: ignore SB_RDONLY when remounting nfs
      nfsd: Initialize ssc before laundromat_work to prevent NULL dereference

Li RongQing (1):
      vfio/type1: Fix error unwind in migration dirty bitmap allocation

Linus Walleij (1):
      net: ethernet: cortina: Use TOE/TSO on all TCP

Liu Shixin (1):
      mm: hugetlb: independent PMD page table shared count

Loic Poulain (1):
      media: venus: Fix probe error handling

Long Li (1):
      uio_hv_generic: Use correct size for interrupt and monitor pages

Longfang Liu (2):
      hisi_acc_vfio_pci: fix XQE dma address error
      hisi_acc_vfio_pci: add eq and aeq interruption restore

Lorenzo Stoakes (1):
      KVM: s390: rename PROT_NONE to PROT_TYPE_DUMMY

Luca Weiss (3):
      clk: qcom: dispcc-sm6350: Add *_wait_val values for GDSCs
      clk: qcom: gcc-sm6350: Add *_wait_val values for GDSCs
      clk: qcom: gpucc-sm6350: Add *_wait_val values for GDSCs

Luiz Augusto von Dentz (5):
      Bluetooth: L2CAP: Fix not responding with L2CAP_CR_LE_ENCRYPTION
      Bluetooth: MGMT: Fix UAF on mgmt_remove_adv_monitor_complete
      Bluetooth: Fix NULL pointer deference on eir_get_service_data
      Bluetooth: hci_sync: Fix broadcast/PA when using an existing instance
      Bluetooth: MGMT: Fix sparse errors

Ma Ke (1):
      media: v4l2-dev: fix error handling in __video_register_device()

Marcus Folkesson (1):
      watchdog: da9052_wdt: respect TWDMIN

Marek Szyprowski (3):
      media: omap3isp: use sgtable-based scatterlist wrappers
      media: videobuf2: use sgtable-based scatterlist wrappers
      udmabuf: use sgtable-based scatterlist wrappers

Marek Vasut (1):
      arm64: dts: imx8mm: Drop sd-vsel-gpios from i.MX8M Mini Verdin SoM

Mark Brown (1):
      arm64/fpsimd: Discard stale CPU state when handling SME traps

Mark Rutland (1):
      arm64/fpsimd: Fix merging of FPSIMD state during signal return

Martin Blumenstingl (5):
      drm/meson: use unsigned long long / Hz for frequency types
      drm/meson: fix debug log statement when setting the HDMI clocks
      drm/meson: use vclk_freq instead of pixel_freq in debug print
      drm/meson: fix more rounding issues with 59.94Hz modes
      ASoC: meson: meson-card-utils: use of_property_present() for DT parsing

Martin Povišer (1):
      ASoC: apple: mca: Constrain channels according to TDM mask

Masahiro Yamada (1):
      kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS

Mateusz Pacuszka (1):
      ice: fix check for existing switch rule

Mathias Nyman (1):
      usb: Flush altsetting 0 endpoints before reinitializating them after reset.

Matthew Wilcox (Oracle) (1):
      bio: Fix bio_first_folio() for SPARSEMEM without VMEMMAP

Miaoqian Lin (2):
      firmware: psci: Fix refcount leak in psci_dt_init
      tracing: Fix error handling in event_trigger_parse()

Michal Koutný (1):
      kernfs: Relax constraint in draining guard

Michal Kubiak (2):
      ice: create new Tx scheduler nodes for new queues only
      ice: fix rebuilding the Tx scheduler tree for large queue counts

Michal Luczaj (1):
      net: Fix TOCTOU issue in sk_is_readable()

Mike Looijmans (1):
      pinctrl: mcp23s08: Reset all pins to input at probe

Mike Tipton (1):
      cpufreq: scmi: Skip SCMI devices that aren't used by the CPUs

Mikhail Arkhipov (1):
      mtd: nand: ecc-mxic: Fix use of uninitialized variable ret

Mikulas Patocka (1):
      dm-mirror: fix a tiny race condition

Ming Qian (1):
      media: imx-jpeg: Drop the first error frames

Mingcong Bai (1):
      wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 11ad:1723

Mirco Barone (1):
      wireguard: device: enable threaded NAPI

Moon Yeounsu (1):
      net: dlink: add synchronization for stats update

Moshe Shemesh (1):
      net/mlx5: Ensure fw pages are always allocated on same NUMA

Muhammad Usama Anjum (1):
      wifi: ath11k: Fix QMI memory reuse logic

Murad Masimov (2):
      ocfs2: fix possible memory leak in ocfs2_finish_quota_recovery
      fbdev: Fix fb_set_var to prevent null-ptr-deref in fb_videomode_to_var

Namjae Jeon (1):
      ksmbd: fix null pointer dereference in destroy_previous_session

Narayana Murty N (1):
      powerpc/eeh: Fix missing PE bridge reconfiguration during VFIO EEH recovery

Nathan Chancellor (4):
      drm/amd/display: Do not add '-mhard-float' to dml_ccflags for clang
      mips: Include KBUILD_CPPFLAGS in CHECKFLAGS invocation
      kbuild: Add CLANG_FLAGS to as-instr
      kbuild: Add KBUILD_CPPFLAGS to as-option invocation

Neal Cardwell (1):
      tcp: fix tcp_packet_delayed() for tcp_is_non_sack_preventing_reopen() behavior

NeilBrown (1):
      nfsd: nfsd4_spo_must_allow() must check this is a v4 compound request

Neill Kapron (1):
      selftests/seccomp: fix syscall_restart test for arm compat

Nicolas Pitre (1):
      vt: remove VT_RESIZE and VT_RESIZEX from vt_compat_ioctl()

Nikita Zhandarovich (1):
      net: usb: aqc111: fix error handling of usbnet read calls

Niklas Cassel (1):
      PCI: cadence-ep: Correct PBA offset in .set_msix() callback

Niravkumar L Rabara (1):
      EDAC/altera: Use correct write width with the INTTEST register

Nishanth Menon (1):
      arm64: dts: ti: k3-am65-main: Drop deprecated ti,otap-del-sel property

Oleg Nesterov (1):
      posix-cpu-timers: fix race between handle_posix_cpu_timers() and posix_cpu_timer_del()

Oliver Neukum (1):
      net: usb: aqc111: debug info before sanitation

Ovidiu Panait (2):
      crypto: sun8i-ce-cipher - fix error handling in sun8i_ce_cipher_prepare()
      crypto: sun8i-ce - move fallback ahash_request to the end of the struct

Pan Taixi (1):
      tracing: Fix compilation warning on arm32

Patrisious Haddad (2):
      RDMA/mlx5: Fix error flow upon firmware failure for RQ destruction
      net/mlx5: Fix return value when searching for existing flow group

Paul Chaignon (2):
      net: Fix checksum update for ILA adj-transport
      bpf: Fix L4 csum update on IPv6 in CHECKSUM_COMPLETE

Pauli Virtanen (1):
      Bluetooth: hci_core: fix list_for_each_entry_rcu usage

Pavel Begunkov (1):
      io_uring: account drain memory to cgroup

Pawel Laszczak (2):
      usb: cdnsp: Fix issue with detecting command completion event
      usb: cdnsp: Fix issue with detecting USB 3.2 speed

Peter Marheine (1):
      ACPI: battery: negate current when discharging

Peter Oberparleiter (1):
      scsi: s390: zfcp: Ensure synchronous unit_add

Peter Xu (1):
      mm/uffd: fix vma operation where start addr cuts part of vma

Peter Zijlstra (2):
      perf: Ensure bpf_perf_link path is properly serialized
      perf: Fix sample vs do_exit()

Petr Malat (1):
      sctp: Do not wake readers in __sctp_write_space()

Phillip Lougher (1):
      Squashfs: check return result of sb_min_blocksize

Qasim Ijaz (1):
      net: ch9200: fix uninitialised access during mii_nway_restart

Qing Wang (1):
      perf/core: Fix broken throttling when max_samples_per_tick=1

Qiuxu Zhuo (1):
      EDAC/skx_common: Fix general protection fault

Quentin Schulz (2):
      arm64: dts: rockchip: disable unrouted USB controllers and PHY on RK3399 Puma with Haikou
      net: stmmac: platform: guarantee uniqueness of bus_id

Rafael J. Wysocki (1):
      PM: sleep: Fix power.is_suspended cleanup for direct-complete devices

Renato Caldas (1):
      platform/x86: ideapad-laptop: add missing Ideapad Pro 5 fn keys

Rengarajan S (2):
      net: lan743x: Modify the EEPROM and OTP size for PCI1xxxx devices
      net: microchip: lan743x: Reduce PTP timeout on HW failure

Ricardo Ribalda (3):
      media: uvcvideo: Return the number of processed controls
      media: uvcvideo: Send control events for partial succeeds
      media: uvcvideo: Fix deferred probing error

Ritesh Harjani (IBM) (1):
      powerpc/powernv/memtrace: Fix out of bounds issue in memtrace mmap

Robert Malz (2):
      i40e: return false from i40e_reset_vf if reset is in progress
      i40e: retry VFLR handling if there is ongoing VF reset

Rodrigo Gobbi (1):
      wifi: ath11k: validate ath11k_crypto_mode on top of ath11k_core_qmi_firmware_ready

Rolf Eike Beer (1):
      iommu: remove duplicate selection of DMAR_TABLE

Ronak Doshi (1):
      vmxnet3: correctly report gso type for UDP tunnels

Ross Stutterheim (1):
      ARM: 9447/1: arm/memremap: fix arch_memremap_can_ram_remap()

Ryusuke Konishi (1):
      nilfs2: do not propagate ENOENT error from nilfs_btree_propagate()

Sakari Ailus (4):
      media: ccs-pll: Start VT pre-PLL multiplier search from correct value
      media: ccs-pll: Start OP pre-PLL multiplier search from correct value
      media: ccs-pll: Correct the upper limit of maximum op_pre_pll_clk_div
      media: ccs-pll: Check for too high VT PLL multiplier in dual PLL case

Salah Triki (1):
      wireless: purelifi: plfxlc: fix memory leak in plfxlc_usb_wreq_asyn()

Sam Winchenbach (3):
      iio: filter: admv8818: fix band 4, state 15
      iio: filter: admv8818: fix integer overflow
      iio: filter: admv8818: fix range calculation

Samuel Williams (1):
      wifi: mt76: mt7921: add 160 MHz AP for mt7922 device

Sanjeev Yadav (1):
      scsi: core: ufs: Fix a hang in the error handler

Sean Christopherson (1):
      iommu/amd: Ensure GA log notifier callbacks finish running before module unload

Sean Nyekjaer (3):
      iio: accel: fxls8962af: Fix temperature scan element sign
      iio: imu: inv_icm42600: Fix temperature calculation
      iio: accel: fxls8962af: Fix temperature calculation

Sebastian Andrzej Siewior (1):
      ipv4/route: Use this_cpu_inc() for stats on PREEMPT_RT

Sergey Senozhatsky (1):
      thunderbolt: Do not double dequeue a configuration request

Sergey Shtylyov (1):
      fbdev: core: fbcvt: avoid division by 0 in fb_cvt_hperiod()

Sergio Perez Gonzalez (1):
      net: macb: Check return value of dma_set_mask_and_coherent()

Seunghun Han (2):
      ACPICA: fix acpi operand cache leak in dswstate.c
      ACPICA: fix acpi parse and parseext cache leaks

Shengyu Qu (1):
      ARM: dts: am335x-bone-common: Add GPIO PHY reset on revision C3 board

Shiming Cheng (1):
      net: fix udp gso skb_segment after pull from frag_list

Shin'ichiro Kawasaki (1):
      RDMA/iwcm: Fix use-after-free of work objects after cm_id destruction

Shyam Prasad N (1):
      cifs: reset connections for all channels when reconnect requested

Siddharth Vadapalli (1):
      remoteproc: k3-r5: Drop check performed in k3_r5_rproc_{mbox_callback/kick}

Simon Horman (1):
      pldmfw: Select CRC32 when PLDMFW is selected

Stefan Wahren (1):
      net: vertexcom: mse102x: Return code for mse102x_rx_pkt_spi

Stefano Stabellini (1):
      xen/arm: call uaccess_ttbr0_enable for dm_op hypercall

Stephen Smalley (1):
      selinux: fix selinux_xfrm_alloc_user() to set correct ctx_len

Steven Rostedt (1):
      tracing: Rename event_trigger_alloc() to trigger_data_alloc()

Stone Zhang (1):
      wifi: ath11k: fix node corruption in ar->arvifs list

Stuart Hayes (2):
      platform/x86: dell_rbu: Fix list usage
      platform/x86: dell_rbu: Stop overwriting data buffer

Su Hui (1):
      soc: aspeed: lpc: Fix impossible judgment condition

Sukrut Bellary (1):
      ARM: OMAP2+: Fix l4ls clk domain handling in STANDBY

Suleiman Souhlal (1):
      tools/resolve_btfids: Fix build when cross compiling kernel with clang.

Takashi Iwai (1):
      ALSA: hda/intel: Add Thinkpad E15 to PM deny list

Talhah Peerbhai (1):
      ASoC: amd: yc: Add quirk for Lenovo Yoga Pro 7 14ASP9

Tali Perry (1):
      i2c: npcm: Add clock toggle recovery

Tan En De (1):
      i2c: designware: Invoke runtime suspend on quick slave re-registration

Tao Chen (1):
      bpf: Fix WARN() in get_bpf_raw_tp_regs

Tasos Sahanidis (1):
      ata: pata_via: Force PIO for ATAPI devices on VT6415/VT6330

Tengda Wu (1):
      arm64/ptrace: Fix stack-out-of-bounds read in regs_get_kernel_stack_nth()

Terry Junge (1):
      HID: usbhid: Eliminate recurrent out-of-bounds bug in usbhid_parse()

Thadeu Lima de Souza Cascardo (1):
      ext4: inline: fix len overflow in ext4_prepare_inline_data

Thangaraj Samynathan (1):
      net: lan743x: rename lan743x_reset_phy to lan743x_hw_reset_phy

Thomas Gleixner (1):
      x86/iopl: Cure TIF_IO_BITMAP inconsistencies

Thomas Weißschuh (1):
      kbuild: userprogs: fix bitsize and target detection on clang

Toke Høiland-Jørgensen (1):
      wifi: ath9k_htc: Abort software beacon handling if disabled

Uwe Kleine-König (1):
      iio: adc: ad7124: Fix 3dB filter frequency reading

Vignesh Raman (1):
      arm64: defconfig: mediatek: enable PHY drivers

Viktor Malik (1):
      libbpf: Fix buffer overflow in bpf_object__init_prog

Vincent Knecht (1):
      clk: qcom: gcc-msm8939: Fix mclk0 & mclk1 for 24 MHz

Vishwaroop A (3):
      spi: tegra210-quad: Fix X1_X2_X4 encoding and support x4 transfers
      spi: tegra210-quad: remove redundant error handling code
      spi: tegra210-quad: modify chip select (CS) deactivation

Vitaliy Shevtsov (1):
      scsi: elx: efct: Fix memory leak in efct_hw_parse_filter()

Vladimir Oltean (2):
      ptp: fix breakage after ptp_vclock_in_use() rework
      ptp: allow reading of currently dialed frequency to succeed on free-running clocks

Wan Junjie (1):
      bus: fsl-mc: fix GET/SET_TAILDROP command ids

WangYuli (2):
      MIPS: Loongson64: Add missing '#interrupt-cells' for loongson64c_ls7a
      Input: sparcspkr - avoid unannotated fall-through

Wentao Liang (9):
      nilfs2: add pointer check for nilfs_direct_propagate()
      ASoC: qcom: sdm845: Add error handling in sdm845_slim_snd_hw_params()
      net/mlx5_core: Add error handling inmlx5_query_nic_vport_qkey_viol_cntr()
      net/mlx5: Add error handling in mlx5_query_nic_vport_node_guid()
      media: gspca: Add error handling for stv06xx_read_sensor()
      mtd: rawnand: sunxi: Add randomizer configuration in sunxi_nfc_hw_ecc_write_chunk
      mtd: nand: sunxi: Add randomizer configuration before randomizer enable
      regulator: max14577: Add error check for max14577_read_reg()
      octeontx2-pf: Add error log forcn10k_map_unmap_rq_policer()

Wojciech Slenska (1):
      pinctrl: qcom: pinctrl-qcm2290: Add missing pins

Wolfram Sang (3):
      ARM: dts: at91: usb_a9263: fix GPIO for Dataflash chip select
      ARM: dts: at91: at91sam9263: fix NAND chip selects
      rtc: sh: assign correct interrupts with DT

Wupeng Ma (1):
      VMCI: fix race between vmci_host_setup_notify and vmci_ctx_unset_notify

Xiaolei Wang (2):
      remoteproc: core: Cleanup acquired resources when rproc_handle_resources() fails in rproc_attach()
      remoteproc: core: Release rproc->clean_table after rproc_attach() fails

Xilin Wu (1):
      arm64: dts: qcom: sm8250: Fix CPU7 opp table

Xin Li (Intel) (1):
      selftests/x86: Add a test to detect infinite SIGTRAP handler loop

Yanqing Wang (1):
      driver: net: ethernet: mtk_star_emac: fix suspend/resume issue

Yao Zi (3):
      platform/loongarch: laptop: Get brightness setting from EC on probe
      platform/loongarch: laptop: Unregister generic_sub_drivers on exit
      platform/loongarch: laptop: Add backlight power control support

Ye Bin (1):
      ftrace: Fix UAF when lookup kallsym after ftrace disabled

Yemike Abhilash Chandra (1):
      arm64: dts: ti: k3-j721e-sk: Add DT nodes for power regulators

Yeoreum Yun (1):
      coresight: prevent deactivate active config while enabling the config

Yihang Li (1):
      scsi: hisi_sas: Call I_T_nexus after soft reset for SATA disk

Yong Wang (2):
      net: bridge: mcast: update multicast contex when vlan state is changed
      net: bridge: mcast: re-implement br_multicast_{enable, disable}_port functions

Yosry Ahmed (1):
      KVM: SVM: Clear current_vmcb during vCPU free for all *possible* CPUs

Yuanjun Gong (1):
      ASoC: tegra210_ahub: Add check to of_device_get_match_data()

Yunhui Cui (1):
      ACPI: CPPC: Fix NULL pointer dereference when nosmp is used

Zhang Yi (2):
      ext4: factor out ext4_get_maxbytes()
      ext4: ensure i_size is smaller than maxbytes

Zhiguo Niu (2):
      f2fs: use d_inode(dentry) cleanup dentry->d_inode
      f2fs: fix to correct check conditions in f2fs_cross_rename

Zhongqiu Duan (1):
      netfilter: nft_quota: match correctly when the quota just depleted

Zijun Hu (5):
      PM: wakeup: Delete space in the end of string shown by pm_show_wakelocks()
      fs/filesystems: Fix potential unsigned integer underflow in fs_name()
      configfs: Do not override creating attribute file failure in populate_attrs()
      software node: Correct a OOB check in software_node_get_reference_args()
      sock: Correct error checking condition for (assign|release)_proto_idx()

Zilin Guan (1):
      tipc: use kfree_sensitive() for aead cleanup

Zizhi Wo (1):
      xfs: Fix the owner setting issue for rmap query in xfs fsmap

gldrk (1):
      ACPICA: utilities: Fix overflow check in vsnprintf()

lei lu (1):
      xfs: don't walk off the end of a directory data block

wangdicheng (1):
      ALSA: usb-audio: Rename ALSA kcontrol PCM and PCM1 for the KTMicro sound card

zhangjian (1):
      smb: client: fix first command failure during re-negotiation

Álvaro Fernández Rojas (3):
      spi: bcm63xx-spi: fix shared reset
      spi: bcm63xx-hsspi: fix shared reset
      net: dsa: tag_brcm: legacy: fix pskb_may_pull length


