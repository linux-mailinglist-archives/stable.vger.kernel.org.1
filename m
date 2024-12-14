Return-Path: <stable+bounces-104206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AAC9F20C4
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 21:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E780B1885BB2
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 20:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB631B4123;
	Sat, 14 Dec 2024 20:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g+PwAk7v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2381B4143;
	Sat, 14 Dec 2024 20:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734209578; cv=none; b=naz987/1LNqfNjaXGSRmavcbbkqjOJlw7fdnJIUo84nCswcV89K5yGDFzUy4IaGVBE0DcDifElP8OsY6lBTqwL6xKMCmPTs6bccB3g0vM5xTXTs1APvB7td8cN6NPUBVInO9rmNAnf3cdGOrH0q0k1VR1iCENNrp2CgoHfX2CHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734209578; c=relaxed/simple;
	bh=nfpkjVIRL38yKZe/WKIJMcslgrgP9qdrT+DdVLHa704=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jfz38001NeyC30q1i0ApJn44PPVw9Dc7mj7OIGW0kufuhezCC7KJgw2jMvtoPZAXCMNukmbR3LulwTSDXVXPa+CgRYgcGr/s1qflACnFd6M1B/gR/glQfYwTlsmNW0YVtnIZ29H/x8FFzswJLOoHKzaP5kwC9NyeyIiO/Oa7iCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g+PwAk7v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FBFC4CED1;
	Sat, 14 Dec 2024 20:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734209577;
	bh=nfpkjVIRL38yKZe/WKIJMcslgrgP9qdrT+DdVLHa704=;
	h=From:To:Cc:Subject:Date:From;
	b=g+PwAk7vRMKI6XPKmg1XP/AjbeK+8N9MReqyB7Z7ZjrzECKOJk2/lFQGnFtGFqJ4b
	 pt1tb7RqyuAAdUzHcWQyT1PtW9Oszzt73OKG5qiwSfZ027LVf1lzYdiTBBNebwUA4b
	 0PeUxF/B5vG3uxO5heN3Wng+aW8DyqBn8pn/+ARw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.231
Date: Sat, 14 Dec 2024 21:52:52 +0100
Message-ID: <2024121451-daybed-daisy-58f6@gregkh>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.231 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-bus-pci                                                           |   11 
 Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml                                       |   67 
 Documentation/devicetree/bindings/clock/axi-clkgen.txt                                            |   25 
 Documentation/devicetree/bindings/serial/rs485.yaml                                               |   19 
 Documentation/devicetree/bindings/sound/mt6359.yaml                                               |   10 
 Documentation/devicetree/bindings/vendor-prefixes.yaml                                            |    2 
 Documentation/filesystems/mount_api.rst                                                           |    3 
 Documentation/networking/j1939.rst                                                                |    2 
 Makefile                                                                                          |    2 
 arch/arm/Kconfig                                                                                  |    2 
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts                                                       |    4 
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi                                           |    3 
 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi                                                 |    8 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi                                              |    4 
 arch/arm64/include/asm/mman.h                                                                     |   10 
 arch/arm64/kernel/process.c                                                                       |    2 
 arch/arm64/kernel/ptrace.c                                                                        |    6 
 arch/arm64/kernel/vmlinux.lds.S                                                                   |    6 
 arch/arm64/kvm/pmu-emul.c                                                                         |    1 
 arch/arm64/kvm/vgic/vgic-its.c                                                                    |   32 
 arch/arm64/kvm/vgic/vgic.h                                                                        |   24 
 arch/m68k/coldfire/device.c                                                                       |    8 
 arch/m68k/include/asm/mcfgpio.h                                                                   |    2 
 arch/m68k/include/asm/mvme147hw.h                                                                 |    4 
 arch/m68k/kernel/early_printk.c                                                                   |    9 
 arch/m68k/mvme147/config.c                                                                        |   30 
 arch/m68k/mvme147/mvme147.h                                                                       |    6 
 arch/m68k/mvme16x/config.c                                                                        |    2 
 arch/m68k/mvme16x/mvme16x.h                                                                       |    6 
 arch/mips/Kconfig                                                                                 |    3 
 arch/mips/boot/dts/loongson/ls7a-pch.dtsi                                                         |   73 
 arch/mips/include/asm/switch_to.h                                                                 |    2 
 arch/mips/pic32/Kconfig                                                                           |    1 
 arch/powerpc/include/asm/dtl.h                                                                    |    4 
 arch/powerpc/include/asm/sstep.h                                                                  |    5 
 arch/powerpc/include/asm/vdso.h                                                                   |    1 
 arch/powerpc/kernel/prom_init.c                                                                   |   29 
 arch/powerpc/kexec/file_load_64.c                                                                 |    9 
 arch/powerpc/lib/sstep.c                                                                          |   12 
 arch/powerpc/platforms/pseries/dtl.c                                                              |    8 
 arch/powerpc/platforms/pseries/lpar.c                                                             |    8 
 arch/s390/kernel/perf_cpum_sf.c                                                                   |    4 
 arch/s390/kernel/syscalls/Makefile                                                                |    2 
 arch/sh/Kconfig                                                                                   |    1 
 arch/sh/kernel/cpu/proc.c                                                                         |    2 
 arch/um/drivers/net_kern.c                                                                        |    2 
 arch/um/drivers/ubd_kern.c                                                                        |    2 
 arch/um/drivers/vector_kern.c                                                                     |    3 
 arch/um/kernel/physmem.c                                                                          |    6 
 arch/um/kernel/process.c                                                                          |    2 
 arch/um/kernel/sysrq.c                                                                            |    2 
 arch/x86/crypto/aegis128-aesni-asm.S                                                              |   29 
 arch/x86/events/intel/pt.c                                                                        |   11 
 arch/x86/events/intel/pt.h                                                                        |    2 
 arch/x86/include/asm/amd_nb.h                                                                     |    5 
 arch/x86/include/asm/barrier.h                                                                    |   18 
 arch/x86/include/asm/cpufeatures.h                                                                |    1 
 arch/x86/include/asm/processor.h                                                                  |   18 
 arch/x86/kernel/cpu/amd.c                                                                         |    3 
 arch/x86/kernel/cpu/common.c                                                                      |    7 
 arch/x86/kernel/cpu/hygon.c                                                                       |    3 
 arch/x86/kvm/vmx/vmx.c                                                                            |    4 
 arch/x86/mm/ioremap.c                                                                             |    6 
 arch/x86/platform/pvh/head.S                                                                      |    2 
 block/blk-mq.c                                                                                    |    6 
 block/blk-mq.h                                                                                    |   13 
 crypto/pcrypt.c                                                                                   |   12 
 drivers/acpi/arm64/gtdt.c                                                                         |    2 
 drivers/base/bus.c                                                                                |    2 
 drivers/base/core.c                                                                               |   20 
 drivers/base/regmap/regmap-irq.c                                                                  |    4 
 drivers/base/regmap/regmap.c                                                                      |   12 
 drivers/bluetooth/btusb.c                                                                         |    2 
 drivers/clk/Kconfig                                                                               |    6 
 drivers/clk/Makefile                                                                              |    3 
 drivers/clk/clk-axi-clkgen.c                                                                      |   26 
 drivers/clk/qcom/gcc-qcs404.c                                                                     |    1 
 drivers/clocksource/Kconfig                                                                       |    9 
 drivers/cpufreq/loongson2_cpufreq.c                                                               |    4 
 drivers/crypto/bcm/cipher.c                                                                       |    5 
 drivers/crypto/caam/caampkc.c                                                                     |   11 
 drivers/crypto/caam/qi.c                                                                          |    2 
 drivers/crypto/cavium/cpt/cptpf_main.c                                                            |    6 
 drivers/dma-buf/dma-fence-array.c                                                                 |   28 
 drivers/edac/bluefield_edac.c                                                                     |    2 
 drivers/edac/fsl_ddr_edac.c                                                                       |   22 
 drivers/firmware/arm_scpi.c                                                                       |    3 
 drivers/firmware/efi/tpm.c                                                                        |   17 
 drivers/firmware/google/gsmi.c                                                                    |    6 
 drivers/gpio/gpio-grgpio.c                                                                        |   26 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                                                       |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                                        |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                                                           |    5 
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                                                          |    5 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c                                                 |   14 
 drivers/gpu/drm/bridge/tc358767.c                                                                 |    7 
 drivers/gpu/drm/bridge/tc358768.c                                                                 |   21 
 drivers/gpu/drm/drm_mm.c                                                                          |    2 
 drivers/gpu/drm/drm_panel_orientation_quirks.c                                                    |    6 
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c                                                          |    3 
 drivers/gpu/drm/etnaviv/etnaviv_drv.c                                                             |   10 
 drivers/gpu/drm/etnaviv/etnaviv_dump.c                                                            |   13 
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c                                                             |   98 
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h                                                             |   21 
 drivers/gpu/drm/fsl-dcu/Kconfig                                                                   |    1 
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c                                                         |   93 
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h                                                         |    3 
 drivers/gpu/drm/imx/dcss/dcss-crtc.c                                                              |    6 
 drivers/gpu/drm/imx/ipuv3-crtc.c                                                                  |    6 
 drivers/gpu/drm/mcde/mcde_drv.c                                                                   |    1 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                                                             |    4 
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c                                                     |    2 
 drivers/gpu/drm/omapdrm/omap_gem.c                                                                |   10 
 drivers/gpu/drm/panfrost/panfrost_gpu.c                                                           |    1 
 drivers/gpu/drm/radeon/r600_cs.c                                                                  |    2 
 drivers/gpu/drm/sti/sti_mixer.c                                                                   |    2 
 drivers/gpu/drm/v3d/v3d_mmu.c                                                                     |   29 
 drivers/gpu/drm/vc4/vc4_hvs.c                                                                     |   11 
 drivers/hid/wacom_sys.c                                                                           |    3 
 drivers/hid/wacom_wac.c                                                                           |    4 
 drivers/i3c/master.c                                                                              |   88 
 drivers/iio/adc/ad7780.c                                                                          |    2 
 drivers/iio/light/al3010.c                                                                        |   11 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                                                          |    7 
 drivers/infiniband/hw/bnxt_re/qplib_fp.h                                                          |    2 
 drivers/infiniband/hw/hns/hns_roce_mr.c                                                           |    7 
 drivers/iommu/arm/arm-smmu/arm-smmu.c                                                             |   11 
 drivers/leds/led-class.c                                                                          |   14 
 drivers/leds/leds-lp55xx-common.c                                                                 |    3 
 drivers/md/bcache/super.c                                                                         |    2 
 drivers/md/dm-thin.c                                                                              |    1 
 drivers/media/dvb-core/dvbdev.c                                                                   |   15 
 drivers/media/dvb-frontends/ts2020.c                                                              |    8 
 drivers/media/i2c/adv7604.c                                                                       |    5 
 drivers/media/i2c/adv7842.c                                                                       |   13 
 drivers/media/i2c/tc358743.c                                                                      |    4 
 drivers/media/platform/qcom/venus/core.c                                                          |    2 
 drivers/media/radio/wl128x/fmdrv_common.c                                                         |    3 
 drivers/media/test-drivers/vivid/vivid-vid-cap.c                                                  |   15 
 drivers/media/usb/cx231xx/cx231xx-cards.c                                                         |    2 
 drivers/media/usb/gspca/ov534.c                                                                   |    2 
 drivers/media/usb/uvc/uvc_driver.c                                                                |  106 
 drivers/media/v4l2-core/v4l2-dv-timings.c                                                         |  132 
 drivers/message/fusion/mptsas.c                                                                   |    4 
 drivers/mfd/da9052-spi.c                                                                          |    2 
 drivers/mfd/intel_soc_pmic_bxtwc.c                                                                |  196 
 drivers/mfd/rt5033.c                                                                              |    4 
 drivers/mfd/tps65010.c                                                                            |    8 
 drivers/misc/apds990x.c                                                                           |   12 
 drivers/misc/eeprom/eeprom_93cx6.c                                                                |   10 
 drivers/mmc/core/bus.c                                                                            |    2 
 drivers/mmc/core/core.c                                                                           |    3 
 drivers/mmc/core/host.c                                                                           |    6 
 drivers/mmc/host/Kconfig                                                                          |    4 
 drivers/mmc/host/dw_mmc.c                                                                         |    4 
 drivers/mmc/host/mmc_spi.c                                                                        |    9 
 drivers/mmc/host/sdhci-pci-core.c                                                                 |   72 
 drivers/mmc/host/sdhci-pci.h                                                                      |    1 
 drivers/mtd/nand/raw/atmel/pmecc.c                                                                |    8 
 drivers/mtd/nand/raw/atmel/pmecc.h                                                                |    2 
 drivers/mtd/ubi/attach.c                                                                          |   12 
 drivers/mtd/ubi/wl.c                                                                              |    9 
 drivers/net/can/sun4i_can.c                                                                       |   22 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                                                         |    8 
 drivers/net/ethernet/broadcom/tg3.c                                                               |    3 
 drivers/net/ethernet/freescale/fec_mpc52xx_phy.c                                                  |    2 
 drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c                                              |    2 
 drivers/net/ethernet/intel/igb/igb_main.c                                                         |    4 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c                                                   |   88 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.h                                                   |    8 
 drivers/net/ethernet/marvell/octeontx2/af/cgx_fw_if.h                                             |   22 
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h                                                  |   86 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c                                                   |   85 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h                                                   |    4 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c                                               |   65 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c                                               |    4 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.c                                               |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h                                            |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c                                          |   28 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h                                          |    8 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c                                         |  170 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c                                              |    3 
 drivers/net/ethernet/marvell/pxa168_eth.c                                                         |   14 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c                                        |    8 
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c                                                 |   15 
 drivers/net/ethernet/qlogic/qed/qed_mcp.c                                                         |    4 
 drivers/net/ethernet/realtek/r8169_main.c                                                         |   14 
 drivers/net/ethernet/rocker/rocker_main.c                                                         |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c                                               |    2 
 drivers/net/geneve.c                                                                              |    2 
 drivers/net/netdevsim/ipsec.c                                                                     |   11 
 drivers/net/usb/lan78xx.c                                                                         |   11 
 drivers/net/usb/qmi_wwan.c                                                                        |    1 
 drivers/net/wireless/ath/ath10k/mac.c                                                             |    4 
 drivers/net/wireless/ath/ath5k/pci.c                                                              |    2 
 drivers/net/wireless/ath/ath9k/htc_hst.c                                                          |    3 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c                                         |    2 
 drivers/net/wireless/intel/ipw2x00/libipw_rx.c                                                    |    8 
 drivers/net/wireless/intersil/p54/p54spi.c                                                        |    4 
 drivers/net/wireless/marvell/mwifiex/fw.h                                                         |    2 
 drivers/net/wireless/marvell/mwifiex/main.c                                                       |    4 
 drivers/nvdimm/dax_devs.c                                                                         |    4 
 drivers/nvdimm/nd.h                                                                               |    7 
 drivers/nvme/host/core.c                                                                          |    7 
 drivers/nvme/host/pci.c                                                                           |   16 
 drivers/pci/controller/dwc/pci-keystone.c                                                         |   11 
 drivers/pci/controller/pcie-rockchip-ep.c                                                         |   18 
 drivers/pci/controller/pcie-rockchip.h                                                            |    4 
 drivers/pci/hotplug/cpqphp_pci.c                                                                  |   19 
 drivers/pci/pci-sysfs.c                                                                           |   26 
 drivers/pci/pci.c                                                                                 |    2 
 drivers/pci/pci.h                                                                                 |    1 
 drivers/pci/quirks.c                                                                              |   15 
 drivers/pci/slot.c                                                                                |    4 
 drivers/pinctrl/freescale/Kconfig                                                                 |    2 
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c                                                          |    2 
 drivers/platform/chrome/cros_ec_typec.c                                                           |    1 
 drivers/platform/x86/intel_bxtwc_tmu.c                                                            |   22 
 drivers/power/supply/bq27xxx_battery.c                                                            |   72 
 drivers/power/supply/power_supply_core.c                                                          |    2 
 drivers/ptp/ptp_clock.c                                                                           |    3 
 drivers/pwm/pwm-imx27.c                                                                           |   98 
 drivers/regulator/rk808-regulator.c                                                               |    2 
 drivers/remoteproc/qcom_q6v5_mss.c                                                                |    3 
 drivers/rpmsg/qcom_glink_native.c                                                                 |  175 
 drivers/rtc/interface.c                                                                           |    7 
 drivers/rtc/rtc-ab-eoz9.c                                                                         |    7 
 drivers/rtc/rtc-abx80x.c                                                                          |    2 
 drivers/rtc/rtc-st-lpc.c                                                                          |    5 
 drivers/scsi/bfa/bfad.c                                                                           |    3 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                                                            |    1 
 drivers/scsi/qedf/qedf_main.c                                                                     |    1 
 drivers/scsi/qedi/qedi_main.c                                                                     |    1 
 drivers/scsi/qla2xxx/qla_attr.c                                                                   |    1 
 drivers/scsi/qla2xxx/qla_bsg.c                                                                    |   10 
 drivers/scsi/qla2xxx/qla_mid.c                                                                    |    1 
 drivers/scsi/qla2xxx/qla_os.c                                                                     |   15 
 drivers/scsi/scsi_lib.c                                                                           |   21 
 drivers/scsi/sd.c                                                                                 |    7 
 drivers/scsi/st.c                                                                                 |   31 
 drivers/scsi/ufs/ufs-exynos.c                                                                     |   16 
 drivers/sh/intc/core.c                                                                            |    2 
 drivers/soc/qcom/qcom-geni-se.c                                                                   |    3 
 drivers/soc/qcom/socinfo.c                                                                        |    8 
 drivers/soc/ti/smartreflex.c                                                                      |    4 
 drivers/soc/ti/ti_sci_pm_domains.c                                                                |    4 
 drivers/spi/atmel-quadspi.c                                                                       |    2 
 drivers/spi/spi-fsl-lpspi.c                                                                       |   14 
 drivers/spi/spi-mpc52xx.c                                                                         |    1 
 drivers/spi/spi.c                                                                                 |   13 
 drivers/staging/board/Kconfig                                                                     |    2 
 drivers/staging/comedi/comedi_fops.c                                                              |   12 
 drivers/staging/greybus/uart.c                                                                    |    3 
 drivers/staging/media/allegro-dvt/allegro-core.c                                                  |    4 
 drivers/staging/media/atomisp/pci/isp/kernels/bh/bh_2/ia_css_bh.host.c                            |    2 
 drivers/staging/media/atomisp/pci/isp/kernels/raw_aa_binning/raw_aa_binning_1.0/ia_css_raa.host.c |    2 
 drivers/staging/media/atomisp/pci/isp/kernels/s3a/s3a_1.0/ia_css_s3a.host.c                       |    5 
 drivers/staging/media/atomisp/pci/runtime/binary/src/binary.c                                     |    4 
 drivers/staging/media/atomisp/pci/sh_css_params.c                                                 |   12 
 drivers/staging/wfx/main.c                                                                        |   17 
 drivers/tty/serial/8250/8250_omap.c                                                               |    4 
 drivers/tty/tty_ldisc.c                                                                           |    2 
 drivers/usb/chipidea/udc.c                                                                        |    2 
 drivers/usb/dwc3/gadget.c                                                                         |   15 
 drivers/usb/gadget/composite.c                                                                    |   18 
 drivers/usb/host/ehci-spear.c                                                                     |    7 
 drivers/usb/host/xhci-dbgcap.c                                                                    |  135 
 drivers/usb/host/xhci-dbgcap.h                                                                    |    2 
 drivers/usb/misc/chaoskey.c                                                                       |   35 
 drivers/usb/misc/iowarrior.c                                                                      |   50 
 drivers/usb/misc/yurex.c                                                                          |    5 
 drivers/usb/typec/tcpm/wcove.c                                                                    |    4 
 drivers/vdpa/mlx5/core/mr.c                                                                       |   12 
 drivers/vfio/pci/vfio_pci_config.c                                                                |   16 
 drivers/video/fbdev/sh7760fb.c                                                                    |   11 
 drivers/watchdog/iTCO_wdt.c                                                                       |   21 
 drivers/watchdog/mtk_wdt.c                                                                        |    6 
 drivers/watchdog/rti_wdt.c                                                                        |    3 
 drivers/xen/xenbus/xenbus_probe.c                                                                 |    8 
 fs/btrfs/extent-tree.c                                                                            |    1 
 fs/btrfs/inode.c                                                                                  |    1 
 fs/btrfs/ref-verify.c                                                                             |    1 
 fs/btrfs/volumes.c                                                                                |   38 
 fs/cifs/smb2ops.c                                                                                 |    6 
 fs/exfat/namei.c                                                                                  |    1 
 fs/ext4/fsmap.c                                                                                   |   54 
 fs/ext4/mballoc.c                                                                                 |   18 
 fs/ext4/mballoc.h                                                                                 |    1 
 fs/ext4/super.c                                                                                   |    8 
 fs/f2fs/f2fs.h                                                                                    |    2 
 fs/f2fs/file.c                                                                                    |    2 
 fs/f2fs/inode.c                                                                                   |    4 
 fs/f2fs/segment.c                                                                                 |   92 
 fs/f2fs/segment.h                                                                                 |    6 
 fs/hfsplus/hfsplus_fs.h                                                                           |    3 
 fs/hfsplus/wrapper.c                                                                              |    2 
 fs/jffs2/compr_rtime.c                                                                            |    3 
 fs/jffs2/erase.c                                                                                  |    7 
 fs/jfs/jfs_dmap.c                                                                                 |    6 
 fs/jfs/jfs_dtree.c                                                                                |   15 
 fs/jfs/xattr.c                                                                                    |    2 
 fs/nfs/internal.h                                                                                 |    2 
 fs/nfs/nfs4proc.c                                                                                 |    8 
 fs/nfsd/export.c                                                                                  |    5 
 fs/nfsd/netns.h                                                                                   |    1 
 fs/nfsd/nfs4callback.c                                                                            |   16 
 fs/nfsd/nfs4proc.c                                                                                |   41 
 fs/nfsd/nfs4recover.c                                                                             |    3 
 fs/nfsd/nfs4state.c                                                                               |   20 
 fs/nfsd/xdr4.h                                                                                    |    1 
 fs/nilfs2/btnode.c                                                                                |    2 
 fs/nilfs2/dir.c                                                                                   |    2 
 fs/nilfs2/gcinode.c                                                                               |    4 
 fs/nilfs2/mdt.c                                                                                   |    1 
 fs/nilfs2/page.c                                                                                  |    2 
 fs/notify/fsnotify.c                                                                              |   23 
 fs/ocfs2/aops.h                                                                                   |    2 
 fs/ocfs2/dlmglue.c                                                                                |    1 
 fs/ocfs2/file.c                                                                                   |    4 
 fs/ocfs2/localalloc.c                                                                             |   19 
 fs/ocfs2/namei.c                                                                                  |    4 
 fs/ocfs2/resize.c                                                                                 |    2 
 fs/ocfs2/super.c                                                                                  |   13 
 fs/overlayfs/util.c                                                                               |    3 
 fs/proc/softirqs.c                                                                                |    2 
 fs/quota/dquot.c                                                                                  |    2 
 fs/ubifs/super.c                                                                                  |    6 
 fs/ubifs/tnc_commit.c                                                                             |    2 
 fs/unicode/mkutf8data.c                                                                           |   70 
 fs/unicode/utf8data.h_shipped                                                                     | 6703 +++++-----
 include/linux/blkdev.h                                                                            |    2 
 include/linux/device.h                                                                            |    2 
 include/linux/eeprom_93cx6.h                                                                      |   11 
 include/linux/i3c/master.h                                                                        |    9 
 include/linux/jiffies.h                                                                           |    2 
 include/linux/leds.h                                                                              |    2 
 include/linux/lockdep.h                                                                           |    2 
 include/linux/mman.h                                                                              |    7 
 include/linux/netdev_features.h                                                                   |    4 
 include/linux/netpoll.h                                                                           |    2 
 include/linux/seqlock.h                                                                           |   12 
 include/linux/sunrpc/clnt.h                                                                       |    3 
 include/linux/sunrpc/xprtsock.h                                                                   |    1 
 include/linux/util_macros.h                                                                       |   56 
 include/media/v4l2-dv-timings.h                                                                   |   18 
 include/net/xfrm.h                                                                                |   16 
 include/uapi/linux/rtnetlink.h                                                                    |    2 
 init/initramfs.c                                                                                  |   15 
 kernel/bpf/devmap.c                                                                               |    6 
 kernel/bpf/lpm_trie.c                                                                             |   27 
 kernel/cgroup/cgroup.c                                                                            |   21 
 kernel/dma/debug.c                                                                                |    8 
 kernel/kcsan/debugfs.c                                                                            |   74 
 kernel/rcu/tasks.h                                                                                |    2 
 kernel/sched/core.c                                                                               |    6 
 kernel/sched/fair.c                                                                               |  113 
 kernel/sched/idle.c                                                                               |    6 
 kernel/sched/sched.h                                                                              |   15 
 kernel/time/time.c                                                                                |    2 
 kernel/trace/ftrace.c                                                                             |    3 
 kernel/trace/trace_clock.c                                                                        |    2 
 kernel/trace/trace_event_perf.c                                                                   |    6 
 kernel/trace/tracing_map.c                                                                        |    6 
 lib/string_helpers.c                                                                              |    2 
 mm/internal.h                                                                                     |   19 
 mm/mmap.c                                                                                         |   82 
 mm/nommu.c                                                                                        |    9 
 mm/shmem.c                                                                                        |    5 
 mm/util.c                                                                                         |   33 
 net/9p/trans_xen.c                                                                                |    9 
 net/bluetooth/hci_sysfs.c                                                                         |   15 
 net/bluetooth/l2cap_sock.c                                                                        |    1 
 net/bluetooth/rfcomm/sock.c                                                                       |   10 
 net/can/af_can.c                                                                                  |    1 
 net/can/j1939/transport.c                                                                         |    2 
 net/core/filter.c                                                                                 |   88 
 net/core/neighbour.c                                                                              |    1 
 net/core/netpoll.c                                                                                |    2 
 net/dccp/feat.c                                                                                   |    6 
 net/ethtool/bitset.c                                                                              |   48 
 net/ethtool/common.c                                                                              |    1 
 net/hsr/hsr_device.c                                                                              |    4 
 net/hsr/hsr_forward.c                                                                             |    2 
 net/ieee802154/socket.c                                                                           |   12 
 net/ipv4/af_inet.c                                                                                |   22 
 net/ipv4/ipmr.c                                                                                   |   48 
 net/ipv4/ipmr_base.c                                                                              |    3 
 net/ipv4/tcp_bpf.c                                                                                |   11 
 net/ipv6/af_inet6.c                                                                               |   22 
 net/ipv6/ip6mr.c                                                                                  |    8 
 net/ipv6/route.c                                                                                  |    6 
 net/mac80211/main.c                                                                               |    2 
 net/netfilter/ipset/ip_set_bitmap_ip.c                                                            |    7 
 net/netfilter/ipset/ip_set_core.c                                                                 |    5 
 net/netfilter/ipvs/ip_vs_proto.c                                                                  |    4 
 net/netfilter/nft_set_hash.c                                                                      |   16 
 net/netfilter/xt_LED.c                                                                            |    4 
 net/netlink/af_netlink.c                                                                          |   31 
 net/netlink/af_netlink.h                                                                          |    2 
 net/packet/af_packet.c                                                                            |   12 
 net/rfkill/rfkill-gpio.c                                                                          |    8 
 net/sched/cls_flower.c                                                                            |    5 
 net/sched/sch_cbs.c                                                                               |    2 
 net/sched/sch_tbf.c                                                                               |   18 
 net/sunrpc/auth_gss/gss_rpc_upcall.c                                                              |    2 
 net/sunrpc/cache.c                                                                                |    4 
 net/sunrpc/clnt.c                                                                                 |   53 
 net/sunrpc/debugfs.c                                                                              |    2 
 net/sunrpc/rpc_pipe.c                                                                             |    2 
 net/sunrpc/xprtsock.c                                                                             |   29 
 net/tipc/udp_media.c                                                                              |    2 
 net/xfrm/xfrm_device.c                                                                            |   10 
 net/xfrm/xfrm_state.c                                                                             |    4 
 net/xfrm/xfrm_user.c                                                                              |    5 
 samples/bpf/test_cgrp2_sock.c                                                                     |    4 
 samples/bpf/xdp_adjust_tail_kern.c                                                                |    1 
 scripts/mod/file2alias.c                                                                          |    5 
 scripts/mod/modpost.c                                                                             |    2 
 security/apparmor/capability.c                                                                    |    2 
 security/apparmor/policy_unpack_test.c                                                            |    6 
 sound/pci/hda/patch_realtek.c                                                                     |  166 
 sound/soc/codecs/da7219.c                                                                         |    9 
 sound/soc/codecs/hdmi-codec.c                                                                     |  140 
 sound/soc/dwc/Kconfig                                                                             |    2 
 sound/soc/fsl/fsl_micfil.c                                                                        |   74 
 sound/soc/fsl/fsl_micfil.h                                                                        |  272 
 sound/soc/intel/boards/bytcr_rt5640.c                                                             |   15 
 sound/soc/rockchip/Kconfig                                                                        |   14 
 sound/soc/stm/stm32_sai_sub.c                                                                     |    6 
 sound/usb/6fire/chip.c                                                                            |   10 
 sound/usb/caiaq/audio.c                                                                           |   10 
 sound/usb/caiaq/audio.h                                                                           |    1 
 sound/usb/caiaq/device.c                                                                          |   19 
 sound/usb/caiaq/input.c                                                                           |   12 
 sound/usb/caiaq/input.h                                                                           |    1 
 sound/usb/clock.c                                                                                 |   32 
 sound/usb/mixer_maps.c                                                                            |   10 
 sound/usb/quirks-table.h                                                                          |   14 
 sound/usb/quirks.c                                                                                |   19 
 sound/usb/usx2y/us122l.c                                                                          |   66 
 sound/usb/usx2y/us122l.h                                                                          |    2 
 sound/usb/usx2y/usX2Yhwdep.c                                                                      |   84 
 sound/usb/usx2y/usX2Yhwdep.h                                                                      |    2 
 sound/usb/usx2y/usb_stream.c                                                                      |   75 
 sound/usb/usx2y/usb_stream.h                                                                      |   23 
 sound/usb/usx2y/usbus428ctldefs.h                                                                 |   18 
 sound/usb/usx2y/usbusx2y.c                                                                        |  223 
 sound/usb/usx2y/usbusx2y.h                                                                        |    8 
 sound/usb/usx2y/usbusx2yaudio.c                                                                   |  326 
 sound/usb/usx2y/usx2yhwdeppcm.c                                                                   |  303 
 tools/perf/builtin-trace.c                                                                        |   16 
 tools/perf/util/cs-etm.c                                                                          |   25 
 tools/perf/util/probe-finder.c                                                                    |   21 
 tools/perf/util/probe-finder.h                                                                    |    4 
 tools/testing/selftests/arm64/mte/check_tags_inclusion.c                                          |    4 
 tools/testing/selftests/arm64/pauth/pac.c                                                         |    3 
 tools/testing/selftests/bpf/test_sockmap.c                                                        |  194 
 tools/testing/selftests/net/pmtu.sh                                                               |    2 
 tools/testing/selftests/resctrl/resctrl_val.c                                                     |    3 
 tools/testing/selftests/vDSO/parse_vdso.c                                                         |    3 
 tools/testing/selftests/watchdog/watchdog-test.c                                                  |    6 
 tools/testing/selftests/wireguard/netns.sh                                                        |    1 
 462 files changed, 8501 insertions(+), 6063 deletions(-)

Adrian Hunter (1):
      perf/x86/intel/pt: Fix buffer full but size is 0 case

Ahmed Ehab (1):
      locking/lockdep: Avoid creating new name string literals in lockdep_set_subclass()

Ajay Kaher (1):
      ptp: Add error handling for adjfine callback in ptp_clock_adjtime

Aleksandr Mishin (1):
      acpi/arm64: Adjust error handling procedure in gtdt_parse_timer_block()

Alex Hung (1):
      drm/amd/display: Check BIOS images before it is used

Alex Zenla (2):
      9p/xen: fix init sequence
      9p/xen: fix release of IRQ

Alexander Hölzl (1):
      can: j1939: fix error in J1939 documentation.

Alexander Lobakin (1):
      net: introduce a netdev feature for UDP GRO forwarding

Alexander Shiyan (1):
      media: i2c: tc358743: Fix crash in the probe error path when using polling

Alexander Stein (1):
      spi: spi-fsl-lpspi: downgrade log level for pio mode

Alexander Sverdlin (1):
      watchdog: rti: of: honor timeout-sec property

Alexandru Ardelean (3):
      dt-bindings: clock: adi,axi-clkgen: convert old binding to yaml format
      clk: axi-clkgen: use devm_platform_ioremap_resource() short-hand
      util_macros.h: fix/rework find_closest() macros

Alper Nebi Yasak (1):
      wifi: mwifiex: Fix memcpy() field-spanning write warning in mwifiex_config_scan()

Amir Goldstein (1):
      fsnotify: fix sending inotify event with unexpected filename

Andre Przywara (2):
      kselftest/arm64: mte: fix printf type warnings about longs
      ARM: dts: cubieboard4: Fix DCDC5 regulator constraints

Andrej Shadura (1):
      Bluetooth: Fix type of len in rfcomm_sock_getsockopt{,_old}()

Andrew Morton (1):
      mm: revert "mm: shmem: fix data-race in shmem_getattr()"

Andy Shevchenko (7):
      regmap: irq: Set lockdep class for hierarchical IRQ domains
      drm/mm: Mark drm_mm_interval_tree*() functions with __maybe_unused
      driver core: Introduce device_find_any_child() helper
      mfd: intel_soc_pmic_bxtwc: Use dev_err_probe()
      mfd: intel_soc_pmic_bxtwc: Use IRQ domain for USB Type-C device
      mfd: intel_soc_pmic_bxtwc: Use IRQ domain for TMU device
      mfd: intel_soc_pmic_bxtwc: Use IRQ domain for PMIC devices

Anil Gurumurthy (1):
      scsi: qla2xxx: Supported speed displayed incorrectly for VPorts

Antonio Quartulli (1):
      m68k: coldfire/device.c: only build FEC when HW macros are defined

Arnd Bergmann (2):
      x86/amd_nb: Fix compile-testing without CONFIG_AMD_NB
      clkdev: remove CONFIG_CLKDEV_LOOKUP

Artem Sadovnikov (1):
      jfs: xattr: check invalid xattr size more strictly

Arun Kumar Neelakantam (2):
      rpmsg: glink: Add TX_DATA_CONT command while sending
      rpmsg: glink: Send READ_NOTIFY command in FIFO full case

Aurelien Jarno (1):
      Revert "mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K"

Avihai Horon (1):
      vfio/pci: Properly hide first-in-list PCIe extended capability

Baochen Qiang (2):
      wifi: ath10k: fix invalid VHT parameters in supported_vht_mcs_rate_nss1
      wifi: ath10k: fix invalid VHT parameters in supported_vht_mcs_rate_nss2

Baoquan He (1):
      x86/mm: Fix a kdump kernel failure on SME system when CONFIG_IMA_KEXEC=y

Barnabás Czémán (2):
      power: supply: bq27xxx: Fix registers of bq27426
      pinctrl: qcom-pmic-gpio: add support for PM8937

Bart Van Assche (1):
      power: supply: core: Remove might_sleep() from power_supply_put()

Bartosz Golaszewski (3):
      mmc: mmc_spi: drop buggy snprintf()
      lib: string_helpers: silence snprintf() output truncation warning
      gpio: grgpio: use a helper variable to store the address of ofdev->dev

Ben Greear (1):
      mac80211: fix user-power when emulating chanctx

Benjamin Peterson (3):
      perf trace: avoid garbage when not printing a trace event's arguments
      perf trace: Do not lose last events in a race
      perf trace: Avoid garbage when not printing a syscall's arguments

Benoît Monin (1):
      net: usb: qmi_wwan: add Quectel RG650V

Benoît Sevens (1):
      ALSA: usb-audio: Fix potential out-of-bound accesses for Extigy and Mbox devices

Bin Liu (1):
      serial: 8250: omap: Move pm_runtime_get_sync

Bjorn Andersson (2):
      rpmsg: glink: Fix GLINK command prefix
      rpmsg: glink: Propagate TX failures in intentless mode as well

Borislav Petkov (AMD) (1):
      x86/barrier: Do not serialize MSR accesses on AMD

Breno Leitao (3):
      ipmr: Fix access to mfc_cache_list without lock held
      netpoll: Use rcu_access_pointer() in netpoll_poll_lock
      netpoll: Use rcu_access_pointer() in __netpoll_setup

Calum Mackay (1):
      SUNRPC: correct error code comment in xs_tcp_setup_socket()

Chao Yu (1):
      f2fs: avoid using native allocate_segment_by_default()

Charles Han (2):
      soc: qcom: Add check devm_kasprintf() returned value
      gpio: grgpio: Add NULL check in grgpio_probe

Chen Ridong (4):
      crypto: caam - add error check to caam_rsa_set_priv_key_form
      crypto: bcm - add error check in the ahash_hmac_init function
      Revert "cgroup: Fix memory leak caused by missing cgroup_bpf_offline"
      cgroup/bpf: only cgroup v2 can be attached by bpf programs

Chen-Yu Tsai (1):
      arm64: dts: mediatek: mt8173-elm-hana: Add vdd-supply to second source trackpad

Christian König (1):
      dma-buf: fix dma_fence_array_signaled v4

Christina Jacob (2):
      octeontx2-af: forward error correction configuration
      octeontx2-pf: ethtool fec mode support

Christoph Hellwig (5):
      nvme-pci: fix freeing of the HMB descriptor table
      f2fs: remove struct segment_allocation default_salloc_ops
      f2fs: open code allocate_segment_by_default
      f2fs: remove the unused flush argument to change_curseg
      block: return unsigned int from bdev_io_min

Christophe JAILLET (3):
      crypto: caam - Fix the pointer passed to caam_qi_shutdown()
      crypto: cavium - Fix an error handling path in cpt_ucode_load_fw()
      iio: light: al3010: Fix an error handling path in al3010_probe()

Christophe Leroy (1):
      powerpc/vdso: Flag VDSO64 entry points as functions

Chuck Lever (8):
      NFSD: Async COPY result needs to return a write verifier
      NFSD: Limit the number of concurrent async COPY operations
      NFSD: Initialize struct nfsd4_copy earlier
      NFSD: Never decrement pending_async_copies on error
      NFSD: Prevent NULL dereference in nfsd4_process_cb_update()
      NFSD: Cap the number of bytes copied by nfs4_reset_recoverydir()
      NFSD: Fix nfsd4_shutdown_copy()
      NFSD: Prevent a potential integer overflow

Clark Wang (1):
      pwm: imx27: Workaround of the pwm output bug when decrease the duty cycle

Claudiu Beznea (1):
      serial: sh-sci: Clean sci_ports[0] after at earlycon exit

Cosmin Tanislav (1):
      regmap: detach regmap from dev on regmap_exit

Csókás, Bence (1):
      spi: atmel-quadspi: Fix register name in verbose logging function

Dai Ngo (1):
      NFSD: initialize copy->cp_clp early in nfsd4_copy for use by trace point

Damien Le Moal (3):
      PCI: rockchip-ep: Fix address translation unit programming
      scsi: sd: Fix sd_do_mode_sense() buffer length handling
      scsi: core: Fix scsi_mode_select() buffer length handling

Dan Carpenter (3):
      soc: qcom: geni-se: fix array underflow in geni_se_clk_tbl_get()
      sh: intc: Fix use-after-free bug in register_intc_controller()
      octeontx2-pf: Fix otx2_get_fecparam()

Daniel Palmer (2):
      m68k: mvme147: Fix SCSI controller IRQ numbers
      m68k: mvme147: Reinstate early console

Dario Binacchi (2):
      can: sun4i_can: sun4i_can_err(): call can_change_state() even if cf is NULL
      can: sun4i_can: sun4i_can_err(): fix {rx,tx}_errors statistics

Dave Stevenson (1):
      drm/vc4: hvs: Set AXI panic modes for the HVS

David Disseldorp (1):
      initramfs: avoid filename buffer overrun

David Given (1):
      media: uvcvideo: Add a quirk for the Kaiweets KTI-W02 infrared camera

David S. Miller (1):
      octeontx2: Fix condition.

David Thompson (1):
      EDAC/bluefield: Fix potential integer overflow

David Wang (1):
      proc/softirqs: replace seq_printf with seq_put_decimal_ull_width

Defa Li (1):
      i3c: Use i3cdev->desc->info instead of calling i3c_device_get_info() to avoid deadlock

Dinesh Kumar (1):
      ALSA: hda/realtek: Fix Internal Speaker and Mic boost of Infinix Y4 Max

Dipendra Khadka (1):
      octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_ethtool.c

Dmitry Antipov (7):
      ocfs2: uncache inode which has failed entering the group
      ocfs2: fix UBSAN warning in ocfs2_verify_volume()
      Bluetooth: fix use-after-free in device_for_each_child()
      ocfs2: fix uninitialized value in ocfs2_file_read_iter()
      netfilter: x_tables: fix LED ID check in led_tg_check()
      can: j1939: j1939_session_new(): fix skb reference counting
      rocker: fix link status detection in rocker_carrier_init()

Doug Brown (1):
      drm/etnaviv: fix power register offset on GC300

Dragan Simic (1):
      arm64: dts: allwinner: pinephone: Add mount matrix to accelerometer

Dragos Tatulea (1):
      net/mlx5e: kTLS, Fix incorrect page refcounting

Edward Adam Davis (1):
      USB: chaoskey: Fix possible deadlock chaoskey_list_lock

Elena Salomatkina (1):
      net/sched: cbs: Fix integer overflow in cbs_set_port_rate()

Eric Biggers (1):
      crypto: x86/aegis128 - access 32-bit arguments as 32-bit

Eric Dumazet (4):
      net: hsr: fix hsr_init_sk() vs network/transport headers.
      ipmr: convert /proc handlers to rcu_read_lock()
      net: hsr: avoid potential out-of-bound access in fill_frame_info()
      geneve: do not assume mac header is set in geneve_xmit_skb()

Eryk Zagorski (1):
      ALSA: usb-audio: Fix Yamaha P-125 Quirk Entry

Esben Haabendal (1):
      pinctrl: freescale: fix COMPILE_TEST error with PINCTRL_IMX_SCU

Everest K.C (1):
      crypto: cavium - Fix the if condition to exit loop after timeout

Felix Manlunas (1):
      octeontx2-af: Add new CGX_CMD to get PHY FEC statistics

Filipe Manana (2):
      btrfs: ref-verify: fix use-after-free after invalid ref action
      btrfs: fix missing snapshot drew unlock when root is dead during swap activation

Francesco Dolcini (1):
      drm/bridge: tc358768: Fix DSI command tx

Frank Li (4):
      i3c: master: Fix miss free init_dyn_addr at i3c_master_put_i3c_addrs()
      i3c: master: Replace hard code 2 with macro I3C_ADDR_SLOT_STATUS_BITS
      i3c: master: Extend address status bit to 4 and add I3C_ADDR_SLOT_EXT_DESIRED
      i3c: master: Fix dynamic address leak when 'assigned-address' is present

Gabor Juhos (1):
      clk: qcom: gcc-qcs404: fix initial rate of GPLL3

Gaosheng Cui (1):
      media: platform: allegro-dvt: Fix possible memory leak in allocate_buffers_internal()

Geert Uytterhoeven (1):
      m68k: mvme16x: Add and use "mvme16x.h"

Ghanshyam Agrawal (3):
      jfs: array-index-out-of-bounds fix in dtReadFirst
      jfs: fix shift-out-of-bounds in dbSplit
      jfs: fix array-index-out-of-bounds in jfs_readdir

Greg Kroah-Hartman (2):
      Revert "serial: sh-sci: Clean sci_ports[0] after at earlycon exit"
      Linux 5.10.231

Gregory Price (1):
      tpm: fix signed/unsigned bug when checking event logs

Gustavo A. R. Silva (1):
      octeontx2-pf: Fix out-of-bounds read in otx2_get_fecparam()

Hangbin Liu (2):
      netdevsim: copy addresses for both in and out paths
      wireguard: selftests: load nf_conntrack if not present

Hans Verkuil (1):
      media: v4l2-core: v4l2-dv-timings: check cvt/gtf result

Hans de Goede (2):
      ASoC: Intel: bytcr_rt5640: Add DMI quirk for Vexia Edu Atla 10 tablet
      mmc: sdhci-pci: Add DMI quirk for missing CD GPIO on Vexia Edu Atla 10 tablet

Heiner Kallweit (1):
      r8169: don't apply UDP padding quirk on RTL8126A

Heming Zhao (1):
      ocfs2: Revert "ocfs2: fix the la space leak when unmounting an ocfs2 volume"

Hermes Zhang (1):
      power: supply: bq27xxx: Support CHARGE_NOW for bq27z561/bq28z610/bq34z100

Hilda Wu (1):
      Bluetooth: btusb: Add RTL8852BE device 0489:e123 to device tables

Hou Tao (2):
      bpf: Handle BPF_EXIST and BPF_NOEXIST for LPM trie
      bpf: Fix exact match conditions in trie_get_next_key()

Hsin-Te Yuan (1):
      arm64: dts: mt8183: krane: Fix the address of eeprom at i2c4

Huacai Chen (1):
      sh: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTACK

Ian Rogers (1):
      perf probe: Fix libdw memory leak

Ignat Korchagin (6):
      af_packet: avoid erroring out after sock_init_data() in packet_create()
      Bluetooth: L2CAP: do not leave dangling sk pointer on error in l2cap_sock_create()
      net: af_can: do not leave a dangling sk pointer in can_create()
      net: ieee802154: do not leave a dangling sk pointer in ieee802154_create()
      net: inet: do not leave a dangling sk pointer in inet_create()
      net: inet6: do not leave a dangling sk pointer in inet6_create()

Igor Artemiev (1):
      drm/radeon/r600_cs: Fix possible int overflow in r600_packet3_check()

Igor Prusov (1):
      dt-bindings: vendor-prefixes: Add NeoFidelity, Inc

Ilpo Järvinen (1):
      PCI: cpqphp: Fix PCIBIOS_* return value confusion

Ivan Solodovnikov (1):
      dccp: Fix memory leak in dccp_feat_change_recv

Jakub Kicinski (2):
      netlink: terminate outstanding dump on socket close
      net/neighbor: clear error in case strict check is not set

James Clark (1):
      perf cs-etm: Don't flush when packet_queue fills up

Jamie Iles (1):
      i3c: fix incorrect address slot lookup on 64-bit

Jann Horn (1):
      comedi: Flush partial mappings in error case

Jason Gerecke (1):
      HID: wacom: Interpret tilt data from Intuos Pro BT as signed values

Javier Carrasco (1):
      platform/chrome: cros_ec_typec: fix missing fwnode reference decrement

Jean-Michel Hautbois (1):
      m68k: mcfgpio: Fix incorrect register offset for CONFIG_M5441x

Jeongjun Park (4):
      wifi: ath9k: add range check for conn_rsp_epid in htc_connect_service()
      usb: using mutex lock and supporting O_NONBLOCK flag in iowarrior_read()
      ext4: supress data-race warnings in ext4_free_inodes_{count,set}()
      netfilter: ipset: add missing range check in bitmap_ip_uadt

Jiapeng Chong (1):
      wifi: ipw2x00: libipw_rx_any(): fix bad alignment

Jing Zhang (1):
      KVM: arm64: vgic-its: Add a data length check in vgic_its_save_*

Jinghao Jia (1):
      ipvs: fix UB due to uninitialized stack access in ip_vs_protocol_init()

Jinjie Ruan (13):
      media: venus: Fix pm_runtime_set_suspended() with runtime pm enabled
      media: gspca: ov534-ov772x: Fix off-by-one error in set_frame_rate()
      spi: spi-fsl-lpspi: Use IRQF_NO_AUTOEN flag in request_irq()
      soc: ti: smartreflex: Use IRQF_NO_AUTOEN flag in request_irq()
      wifi: p54: Use IRQF_NO_AUTOEN flag in request_irq()
      wifi: mwifiex: Use IRQF_NO_AUTOEN flag in request_irq()
      drm/imx/dcss: Use IRQF_NO_AUTOEN flag in request_irq()
      drm/imx/ipuv3: Use IRQF_NO_AUTOEN flag in request_irq()
      drm/msm/adreno: Use IRQF_NO_AUTOEN flag in request_irq()
      mfd: tps65010: Use IRQF_NO_AUTOEN flag in request_irq() to fix race
      misc: apds990x: Fix missing pm_runtime_disable()
      apparmor: test: Fix memory leak for aa_unpack_strdup()
      rtc: st-lpc: Use IRQF_NO_AUTOEN flag in request_irq()

Jiri Wiesner (1):
      net/ipv6: release expired exception dst cached in socket

Joaquín Ignacio Aramendía (1):
      drm: panel-orientation-quirks: Add quirk for AYA NEO 2 model

Johan Hovold (1):
      staging: greybus: uart: clean up TIOCGSERIAL

Jonas Gorski (1):
      mips: asm: fix warning when disabling MIPS_FP_SUPPORT

Jonas Karlman (1):
      ASoC: hdmi-codec: reorder channel allocation list

Jonathan Marek (1):
      rpmsg: glink: use only lower 16-bits of param2 for CMD_OPEN name length

Josef Bacik (1):
      btrfs: don't BUG_ON on ENOMEM from btrfs_lookup_extent_info() in walk_down_proc()

Josh Poimboeuf (1):
      x86/xen/pvh: Annotate indirect branch as safe

Junxian Huang (1):
      RDMA/hns: Fix NULL pointer derefernce in hns_roce_map_mr_sg()

K Prateek Nayak (3):
      sched/core: Remove the unnecessary need_resched() check in nohz_csd_func()
      sched/fair: Check idle_cpu() before need_resched() to detect ilb CPU turning busy
      sched/core: Prevent wakeup of ksoftirqd during idle load balance

Kai Mäkisara (2):
      scsi: st: Don't modify unknown block number in MTIOCGET
      scsi: st: Add MTIOCGET and MTLOAD to ioctls allowed after device reset

Kailang Yang (4):
      ALSA: hda/realtek - Add type for ALC287
      ALSA: hda/realtek: Update ALC256 depop procedure
      ALSA: hda/realtek: Update ALC225 depop procedure
      ALSA: hda/realtek: Set PCBeep to default value for ALC274

Kashyap Desai (1):
      RDMA/bnxt_re: Check cqe flags to know imm_data vs inv_irkey

Keith Busch (1):
      PCI: Add 'reset_subordinate' to reset hierarchy below bridge

Kinsey Moore (1):
      jffs2: Prevent rtime decompress memory corruption

Kishon Vijay Abraham I (1):
      PCI: keystone: Add link up check to ks_pcie_other_map_bus()

Kory Maincent (1):
      ethtool: Fix wrong mod state in case of verbose and no_mask bitset

Kuan-Wei Chiu (1):
      tracing: Fix cmp_entries_dup() to respect sort() comparison rules

Kuniyuki Iwashima (1):
      tipc: Fix use-after-free of kernel socket in cleanup_bearer().

Kunkun Jiang (2):
      KVM: arm64: vgic-its: Clear DTE when MAPD unmaps a device
      KVM: arm64: vgic-its: Clear ITE when DISCARD frees an ITE

Lang Yu (1):
      drm/amdgpu: refine error handling in amdgpu_ttm_tt_pin_userptr

Leo Yan (1):
      perf probe: Correct demangled symbols in C++ program

Leon Romanovsky (3):
      xfrm: rename xfrm_state_offload struct to allow reuse
      xfrm: store and rely on direction to construct offload flags
      netdevsim: rely on XFRM state direction instead of flags

Levi Yun (2):
      trace/trace_event_perf: remove duplicate samples on the first tracepoint event
      dma-debug: fix a possible deadlock on radix_lock

Li Huafei (1):
      media: atomisp: Add check for rgby_data memory allocation failure

Li Lingfeng (1):
      nfs: ignore SB_RDONLY when mounting nfs

Li Zetao (1):
      media: ts2020: fix null-ptr-deref in ts2020_probe()

Li Zhijian (1):
      selftests/watchdog-test: Fix system accidentally reset after watchdog-test

Liao Chen (1):
      drm/mcde: Enable module autoloading

Liequan Che (1):
      bcache: revert replacing IS_ERR_OR_NULL with IS_ERR again

Lino Sanfilippo (1):
      dt_bindings: rs485: Correct delay values

Linus Torvalds (1):
      Revert "unicode: Don't special case ignorable code points"

Liu Jian (2):
      selftests, bpf: Add one test for sockmap with strparser
      sunrpc: clear XPRT_SOCK_UPD_TIMEOUT when reset transport

LongPing Wei (1):
      f2fs: fix the wrong f2fs_bug_on condition in f2fs_do_replace_block

Lorenzo Stoakes (4):
      mm: avoid unsafe VMA hook invocation when error arises on mmap hook
      mm: unconditionally close VMAs on error
      mm: refactor arch_calc_vm_flag_bits() and arm64 MTE handling
      mm: resolve faulty mmap_region() error path behaviour

Louis Leseur (1):
      net/qed: allow old cards not supporting "num_images" to work

Lucas Stach (3):
      drm/etnaviv: rework linear window offset calculation
      drm/etnaviv: hold GPU lock across perfmon sampling
      drm/etnaviv: flush shader L1 cache after user commandstream

Lukas Wunner (1):
      PCI: Fix use-after-free of slot->bus on hot remove

Luo Qiu (1):
      firmware: arm_scpi: Check the DVFS OPP count returned by the firmware

Luo Yifan (2):
      ASoC: stm: Prevent potential division by zero in stm32_sai_mclk_round_rate()
      ASoC: stm: Prevent potential division by zero in stm32_sai_get_clk_div()

Maciej Fijalkowski (1):
      bpf: fix OOB devmap writes when deleting elements

Macpaul Lin (1):
      ASoC: dt-bindings: mt6359: Update generic node name and dmic-mode

Manikanta Mylavarapu (1):
      soc: qcom: socinfo: fix revision check in qcom_socinfo_probe()

Marc Kleine-Budde (1):
      drm/etnaviv: dump: fix sparse warnings

Marco Elver (2):
      kcsan, seqlock: Fix incorrect assumption in read_seqbegin()
      kcsan: Turn report_filterlist_lock into a raw_spinlock

Marcus Folkesson (1):
      mfd: da9052-spi: Change read-mask to write-mask

Marie Ramlow (1):
      ALSA: usb-audio: add mixer mapping for Corsair HS80

Mark Bloch (1):
      net/mlx5: fs, lock FTE when checking if active

Mark Brown (2):
      clocksource/drivers:sp804: Make user selectable
      kselftest/arm64: Don't leak pipe fds in pac.exec_sign_all()

Mark Rutland (1):
      arm64: ptrace: fix partial SETREGSET for NT_ARM_TAGGED_ADDR_CTRL

Martin Ottens (1):
      net/sched: tbf: correct backlog statistic for GSO packets

Masahiro Yamada (3):
      arm64: fix .data.rel.ro size assertion when CONFIG_LTO_CLANG
      s390/syscalls: Avoid creation of arch/arch/ directory
      modpost: remove incorrect code in do_eisa_entry()

Mathias Nyman (1):
      xhci: dbc: Fix STALL transfer event handling

Matthias Schiffer (1):
      drm: fsl-dcu: enable PIXCLK on LS1021A

Maurice Lambert (1):
      netlink: typographical error in nlmsg_type constants definition

Mauro Carvalho Chehab (2):
      media: dvbdev: fix the logic when DVB_DYNAMIC_MINORS is not set
      media: atomisp: remove #ifdef HAS_NO_HMEM

Maxime Chevallier (2):
      net: stmmac: dwmac-socfpga: Set RX watchdog interrupt as broken
      rtc: ab-eoz9: don't fail temperature reads on undervoltage notification

Maíra Canal (1):
      drm/v3d: Address race-condition in MMU flush

Mengyuan Lou (1):
      PCI: Add ACS quirk for Wangxun FF5xxx NICs

Michael Ellerman (2):
      powerpc/pseries: Fix dtl_access_lock to be a rw_semaphore
      powerpc/prom_init: Fixup missing powermac #size-cells

Michal Simek (1):
      dt-bindings: serial: rs485: Fix rs485-rts-delay property

Michal Suchanek (1):
      powerpc/sstep: make emulate_vsx_load and emulate_vsx_store static

Michal Vokáč (1):
      leds: lp55xx: Remove redundant test for invalid channel number

Michal Vrastil (1):
      Revert "usb: gadget: composite: fix OS descriptors w_value logic"

Miguel Ojeda (1):
      time: Fix references to _msecs_to_jiffies() handling of values

Mikhail Rudenko (1):
      regulator: rk808: Add apply_bit for BUCK3 on RK809

Mingwei Zheng (1):
      net: rfkill: gpio: Add check for clk_enable()

Miquel Raynal (1):
      mtd: rawnand: atmel: Fix possible memory leak

Muchun Song (1):
      block: fix ordering between checking BLK_MQ_S_STOPPED request adding

Mukesh Ojha (1):
      leds: class: Protect brightness_show() with led_cdev->led_access mutex

Namjae Jeon (1):
      exfat: fix uninit-value in __exfat_get_dentry_set

Nazar Bilinskyi (1):
      ALSA: hda/realtek: Enable mute and micmute LED on HP ProBook 430 G8

Nicolas Bouchinet (1):
      tty: ldsic: fix tty_ldisc_autoload sysctl's proc_handler

Nihar Chaithanya (1):
      jfs: add a check to prevent array-index-out-of-bounds in dbAdjTree

Nobuhiro Iwamatsu (1):
      rtc: abx80x: Fix WDT bit position of the status register

Norbert van Bolhuis (1):
      wifi: brcmfmac: Fix oops due to NULL pointer dereference in brcmf_sdiod_sglist_rw()

Nuno Sa (2):
      dt-bindings: clock: axi-clkgen: include AXI clk
      clk: clk-axi-clkgen: make sure to enable the AXI bus clock

Ojaswin Mujoo (1):
      quota: flush quota_release_work upon quota writeback

Oleksandr Ocheretnyi (1):
      iTCO_wdt: mask NMI_NOW bit for update_no_reboot_bit() call

Oleksij Rempel (2):
      net: usb: lan78xx: Fix memory leak on device unplug by freeing PHY device
      net: usb: lan78xx: Fix refcounting and autosuspend on invalid WoL configuration

Oliver Neukum (2):
      usb: yurex: make waiting on yurex_write interruptible
      USB: chaoskey: fail open after removal

Pablo Neira Ayuso (1):
      netfilter: nft_set_hash: skip duplicated elements pending gc run

Pali Rohár (1):
      cifs: Fix buffer overflow when parsing NFS reparse points

Paolo Abeni (2):
      selftests: net: really check for bg process completion
      ipmr: fix tables suspicious RCU usage

Parker Newman (1):
      misc: eeprom: eeprom_93cx6: Add quirk for extra read clock cycle

Paul E. McKenney (1):
      rcu-tasks: Idle tasks on offline CPUs are in quiescent states

Pavan Chebbi (1):
      tg3: Set coherent DMA mask bits to 31 for BCM57766 chipsets

Pei Xiao (2):
      drm/sti: Add __iomem for mixer_dbg_mxn's parameter
      spi: mpc52xx: Add cancel_work_sync before module remove

Peter Griffin (1):
      scsi: ufs: exynos: Fix hibern8 notify callbacks

Phil Sutter (1):
      netfilter: ipset: Hold module reference while requesting a module

Piyush Raj Chouhan (1):
      ALSA: hda/realtek: Add subwoofer quirk for Infinix ZERO BOOK 13

Pratyush Brahma (1):
      iommu/arm-smmu: Defer probe of clients after smmu device bound

Prike Liang (1):
      drm/amdgpu: set the right AMDGPU sg segment limitation

Priyanka Singh (1):
      EDAC/fsl_ddr: Fix bad bit shift operations

Puranjay Mohan (1):
      nvme: fix metadata handling in nvme-passthrough

Qi Han (1):
      f2fs: fix f2fs_bug_on when uninstalling filesystem call f2fs_evict_inode.

Qingfang Deng (1):
      jffs2: fix use of uninitialized variable

Qiu-ji Chen (3):
      xen: Fix the issue of resource not being properly released in xenbus_dev_probe()
      ASoC: codecs: Fix atomicity violation in snd_soc_component_get_drvdata()
      media: wl128x: Fix atomicity violation in fmc_send_cmd()

Qu Wenruo (1):
      btrfs: avoid unnecessary device path update for the same device

Quinn Tran (2):
      scsi: qla2xxx: Fix NVMe and NPIV connect issue
      scsi: qla2xxx: Fix use after free on unload

Raghavendra Rao Ananta (1):
      KVM: arm64: Ignore PMCNTENSET_EL0 while checking for overflow status

Randy Dunlap (1):
      fs_parser: update mount_api doc to match function signature

Reinette Chatre (1):
      selftests/resctrl: Protect against array overrun during iMC config parsing

Ricardo Ribalda (1):
      media: uvcvideo: Stop stream during unregister

Richard Weinberger (1):
      jffs2: Fix rtime decompressor

Rohan Barar (1):
      media: cx231xx: Add support for Dexatek USB Video Grabber 1d19:6108

Rosen Penev (2):
      wifi: ath5k: add PCI ID for SX76X
      wifi: ath5k: add PCI ID for Arcadyan devices

Ryusuke Konishi (3):
      nilfs2: fix null-ptr-deref in block_touch_buffer tracepoint
      nilfs2: fix null-ptr-deref in block_dirty_buffer tracepoint
      nilfs2: fix potential out-of-bounds memory access in nilfs_find_entry()

Sahas Leelodharry (1):
      ALSA: hda/realtek: Add support for Samsung Galaxy Book3 360 (NP730QFG)

Saravanan Vajravel (1):
      bnxt_en: Reserve rings after PCIe AER recovery if NIC interface is down

Sascha Hauer (3):
      ASoC: fsl_micfil: Drop unnecessary register read
      ASoC: fsl_micfil: do not define SHIFT/MASK for single bits
      ASoC: fsl_micfil: use GENMASK to define register bit fields

Saurav Kashyap (1):
      scsi: qla2xxx: Remove check req_sg_cnt should be equal to rsp_sg_cnt

Sean Christopherson (1):
      KVM: VMX: Bury Intel PT virtualization (guest/host mode) behind CONFIG_BROKEN

Shengjiu Wang (2):
      ASoC: fsl_micfil: fix regmap_write_bits usage
      ASoC: fsl_micfil: fix the naming style for mask definition

Si-Wei Liu (2):
      vdpa/mlx5: Fix PA offset with unaligned starting iotlb map
      vdpa/mlx5: Fix suboptimal range on iotlb iteration

Sibi Sankar (1):
      remoteproc: qcom_q6v5_mss: Re-order writes to the IMEM region

Simon Horman (2):
      net: fec_mpc52xx_phy: Use %pa to format resource_size_t
      net: ethernet: fs_enet: Use %pa to format resource_size_t

Stanislaw Gruszka (1):
      spi: Fix acpi deferred irq probe

Steven Price (1):
      drm/panfrost: Remove unused id_mask from struct panfrost_model

Subbaraya Sundeep (2):
      octeontx2-af: Mbox changes for 98xx
      octeontx2-pf: Calculate LBK link instead of hardcoding

Takashi Iwai (9):
      ALSA: usx2y: Fix spaces
      ALSA: usx2y: Coding style fixes
      ALSA: usx2y: Cleanup probe and disconnect callbacks
      ALSA: usx2y: Use snd_card_free_when_closed() at disconnection
      ALSA: us122l: Use snd_card_free_when_closed() at disconnection
      ALSA: caiaq: Use snd_card_free_when_closed() at disconnection
      ALSA: 6fire: Release resources at card release
      ALSA: hda/realtek: Apply quirk for Medion E15433
      ALSA: usb-audio: Fix out of bounds reads when finding clock sources

Tetsuo Handa (1):
      ocfs2: free inode when ocfs2_get_init_inode() fails

Thadeu Lima de Souza Cascardo (2):
      hfsplus: don't query the device logical block size multiple times
      media: uvcvideo: Require entities to have a non-zero unique ID

Theodore Ts'o (1):
      ext4: fix FS_IOC_GETFSMAP handling

Thiago Rafael Becker (1):
      sunrpc: remove unnecessary test in rpc_task_set_client()

Thinh Nguyen (2):
      usb: dwc3: gadget: Fix checking for number of TRBs left
      usb: dwc3: gadget: Fix looping of queued SG entries

Thomas Gleixner (1):
      modpost: Add .irqentry.text to OTHER_SECTIONS

Thomas Richter (1):
      s390/cpum_sf: Handle CPU hotplug remove during sampling

Thomas Zimmermann (2):
      drm/fsl-dcu: Convert to Linux IRQ interfaces
      fbdev/sh7760fb: Alloc DMA memory from hardware device

Tiwei Bie (6):
      um: ubd: Do not use drvdata in release
      um: net: Do not use drvdata in release
      um: vector: Do not use drvdata in release
      um: Fix potential integer overflow during physmem setup
      um: Fix the return value of elf_core_copy_task_fpregs
      um: Always dump trace for specified task in show_stack

Tomi Valkeinen (2):
      drm/omap: Fix locking in omap_gem_new_dmabuf()
      drm/bridge: tc358767: Fix link properties discovery

Trond Myklebust (3):
      NFSv4.0: Fix a use-after-free problem in the asynchronous open()
      SUNRPC: Convert rpc_client refcount to use refcount_t
      SUNRPC: Replace internal use of SOCKWQ_ASYNC_NOSPACE

Ulf Hansson (1):
      mmc: core: Further prevent card detect during shutdown

Uros Bizjak (1):
      tracing: Use atomic64_inc_return() in trace_clock_counter()

Valentin Schneider (1):
      sched/fair: Add NOHZ balancer flag for nohz.next_balance updates

Vasiliy Kovalev (1):
      ovl: Filter invalid inodes with missing lookup function

Victor Zhao (1):
      drm/amdgpu: skip amdgpu_device_cache_pci_state under sriov

Vincent Guittot (4):
      sched/fair: Remove update of blocked load from newidle_balance
      sched/fair: Remove unused parameter of update_nohz_stats
      sched/fair: Merge for each idle cpu loop of ILB
      sched/fair: Trigger the update of blocked load on newly idle cpu

Vitalii Mordan (2):
      marvell: pxa168_eth: fix call balance of pep->clk handling routines
      usb: ehci-spear: fix call balance of sehci clk handling routines

WangYuli (1):
      HID: wacom: fix when get product name maybe null pointer

Waqar Hameed (1):
      ubifs: authentication: Fix use-after-free in ubifs_tnc_end_commit

Wengang Wang (1):
      ocfs2: update seq_file index in ocfs2_dlm_seq_next

Will Deacon (1):
      arm64: tls: Fix context-switching of tpidrro_el0 when kpti is enabled

Xi Ruoyao (1):
      MIPS: Loongson64: DTS: Really fix PCIe port nodes for ls7a

Xiaolei Wang (1):
      drm/etnaviv: Request pages from DMA32 zone on addressing_limited

Xin Long (1):
      net: sched: fix erspan_opt settings in cls_flower

Xu Yang (1):
      usb: chipidea: udc: handle USB Error Interrupt if IOC not set

Yang Erkun (3):
      SUNRPC: make sure cache entry active before cache_show
      nfsd: make sure exp active before svc_export_show
      nfsd: fix nfs4_openowner leak when concurrent nfsd4_open occur

Yang Yingliang (1):
      mmc: core: fix return value check in devm_mmc_alloc_host()

Yassine Oudjana (1):
      watchdog: mediatek: Make sure system reset gets asserted in mtk_wdt_restart()

Ye Bin (1):
      scsi: bfa: Fix use-after-free in bfad_im_module_exit()

Yi Yang (2):
      crypto: pcrypt - Call crypto layer directly when padata_do_parallel() return -EBUSY
      nvdimm: rectify the illogical code within nd_dax_probe()

Yihang Li (1):
      scsi: hisi_sas: Add cond_resched() for no forced preemption model

Yongliang Gao (1):
      rtc: check if __rtc_read_time was successful in rtc_timer_do_work()

Yongpeng Yang (1):
      f2fs: check curseg->inited before write_sum_page in change_curseg

Yuan Can (6):
      firmware: google: Unregister driver_info on failure
      wifi: wfx: Fix error handling in wfx_core_init()
      drm/amdkfd: Fix wrong usage of INIT_WORK()
      cpufreq: loongson2: Unregister platform_driver on failure
      dm thin: Add missing destroy_work_on_stack()
      igb: Fix potential invalid memory access in igb_init_module()

Yuan Chen (1):
      bpf: Fix the xdp_adjust_tail sample prog issue

Zeng Heng (1):
      scsi: fusion: Remove unused variable 'rc'

Zhang Changzhong (1):
      mfd: rt5033: Fix missing regmap_del_irq_chip()

Zhang Zekun (3):
      pmdomain: ti-sci: Add missing of_node_put() for args.np
      powerpc/kexec: Fix return of uninitialized variable
      Revert "drm/amdgpu: add missing size check in amdgpu_debugfs_gprwave_read()"

Zhen Lei (3):
      scsi: qedf: Fix a possible memory leak in qedf_alloc_and_init_sb()
      scsi: qedi: Fix a possible memory leak in qedi_alloc_and_init_sb()
      fbdev: sh7760fb: Fix a possible memory leak in sh7760fb_alloc_mem()

Zhihao Cheng (3):
      ubi: wl: Put source PEB into correct list if trying locking LEB failed
      ubifs: Correct the total block count by deducting journal reservation
      ubi: fastmap: Fix duplicate slab cache names while attaching

Zhu Jun (1):
      samples/bpf: Fix a resource leak

Zichen Xie (1):
      drm/msm/dpu: cast crtc_clk calculation to u64 in _dpu_core_perf_calc_clk()

Zicheng Qu (1):
      ad7780: fix division by zero in ad7780_write_raw()

Zijian Zhang (10):
      selftests/bpf: Fix msg_verify_data in test_sockmap
      selftests/bpf: Fix txmsg_redir of test_txmsg_pull in test_sockmap
      selftests/bpf: Add txmsg_pass to pull/push/pop in test_sockmap
      selftests/bpf: Fix SENDPAGE data logic in test_sockmap
      selftests/bpf: Fix total_bytes in msg_loop_rx in test_sockmap
      selftests/bpf: Add push/pop checking for msg_verify_data in test_sockmap
      bpf, sockmap: Several fixes to bpf_msg_push_data
      bpf, sockmap: Several fixes to bpf_msg_pop_data
      bpf, sockmap: Fix sk_msg_reset_curr
      tcp_bpf: Fix the sk_mem_uncharge logic in tcp_bpf_sendmsg

Zijun Hu (1):
      driver core: bus: Fix double free in driver API bus_register()

chao liu (1):
      apparmor: fix 'Do simple duplicate message elimination'

guoweikang (1):
      ftrace: Fix regression with module command in stack_trace_filter

weiyufeng (1):
      PCI: cpqphp: Use PCI_POSSIBLE_ERROR() to check config reads


