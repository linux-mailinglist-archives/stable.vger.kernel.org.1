Return-Path: <stable+bounces-169723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FA7B281B7
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 16:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BAC55E240A
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 14:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F97422FE06;
	Fri, 15 Aug 2025 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E+aHUIJt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160C3224B09;
	Fri, 15 Aug 2025 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268107; cv=none; b=QpwIXfn3XLfeWYmWWWF0RLPiDQy3nrEXvkW3A/7xBcvsdNFg7brswBWoi/BMgf3wLXTk+ix9GERkM07QJc2VcV7aIZqwU4kuO99rF8uZVkcNoJ3pcdZEd3mZGVChyDp5/Ym9w5M4fVt2VbbSE1uqW2BTmmzMzjeXyS6ZVIztPvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268107; c=relaxed/simple;
	bh=87qW28BSJ7UktH5o2Zs0iNje5pFlnS38pdXnMJTwGgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gApRVsjipHOObNw2D8L4XCGi1Dv6nYH3FAxP2BWuhz3gkBkiCqYpuJOSh3S9e1FlZmnhwxrBiVUkagzzgSfa/USgdbLSFBBYKJO84JosA57T32bBctC+1dB/SB8OHEsw/bgWRB3wBg6YXqnlD/jToB+Cu/hO1bzt7YvL4ENma9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E+aHUIJt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AE8C4CEEB;
	Fri, 15 Aug 2025 14:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755268107;
	bh=87qW28BSJ7UktH5o2Zs0iNje5pFlnS38pdXnMJTwGgU=;
	h=From:To:Cc:Subject:Date:From;
	b=E+aHUIJt6vnuh/dpEfbkxu5SD+baXgLylToIiqu/GBDK6erPWUXbNTECS/CiJ9dYT
	 twFBrlwN4ZzWHpZzXhPUJw3bM830fLNtax0Ut7qdsq+f8Sr2AGozJemqcHNFTfG8qz
	 nKTmg4FyXnz1L1oXdA7lFj8tuQ1q1FZtay2NrsQE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.42
Date: Fri, 15 Aug 2025 16:28:09 +0200
Message-ID: <2025081510-unicycle-theme-26a0@gregkh>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.42 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/filesystems/f2fs.rst                              |    6 
 Documentation/netlink/specs/ethtool.yaml                        |    6 
 Makefile                                                        |    2 
 arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-common.dtsi         |    1 
 arch/arm/boot/dts/nxp/vf/vfxxx.dtsi                             |    2 
 arch/arm/boot/dts/ti/omap/am335x-boneblack.dts                  |    2 
 arch/arm/crypto/aes-neonbs-glue.c                               |    2 
 arch/arm64/boot/dts/exynos/google/gs101.dtsi                    |    3 
 arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi            |    2 
 arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi            |    2 
 arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi               |    6 
 arch/arm64/boot/dts/qcom/msm8976.dtsi                           |    2 
 arch/arm64/boot/dts/qcom/sa8775p.dtsi                           |   10 
 arch/arm64/boot/dts/qcom/sc7180.dtsi                            |   10 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                            |   10 
 arch/arm64/boot/dts/st/stm32mp251.dtsi                          |    2 
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi          |    2 
 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts        |    2 
 arch/arm64/net/bpf_jit_comp.c                                   |    1 
 arch/m68k/Kconfig.debug                                         |    2 
 arch/m68k/kernel/early_printk.c                                 |   42 -
 arch/m68k/kernel/head.S                                         |    8 
 arch/mips/mm/tlb-r4k.c                                          |   56 +
 arch/powerpc/configs/ppc6xx_defconfig                           |    1 
 arch/powerpc/kernel/eeh.c                                       |    1 
 arch/powerpc/kernel/eeh_driver.c                                |   48 +
 arch/powerpc/kernel/eeh_pe.c                                    |   10 
 arch/powerpc/kernel/pci-hotplug.c                               |    3 
 arch/powerpc/platforms/pseries/dlpar.c                          |   52 +
 arch/s390/include/asm/ap.h                                      |    2 
 arch/s390/mm/pgalloc.c                                          |    5 
 arch/s390/mm/vmem.c                                             |    5 
 arch/sh/Makefile                                                |   10 
 arch/sh/boot/compressed/Makefile                                |    4 
 arch/sh/boot/romimage/Makefile                                  |    4 
 arch/um/drivers/rtc_user.c                                      |    2 
 arch/x86/boot/cpuflags.c                                        |   13 
 arch/x86/coco/sev/shared.c                                      |   46 +
 arch/x86/include/asm/cpufeatures.h                              |    1 
 arch/x86/include/asm/hw_irq.h                                   |   12 
 arch/x86/kernel/cpu/scattered.c                                 |    1 
 arch/x86/kernel/irq.c                                           |   63 +-
 arch/x86/mm/extable.c                                           |    5 
 block/blk-settings.c                                            |   13 
 drivers/accel/ivpu/ivpu_debugfs.c                               |   42 -
 drivers/block/ublk_drv.c                                        |    4 
 drivers/bluetooth/btusb.c                                       |    4 
 drivers/bus/mhi/host/pci_generic.c                              |    8 
 drivers/char/hw_random/mtk-rng.c                                |    4 
 drivers/clk/at91/sam9x7.c                                       |   20 
 drivers/clk/clk-axi-clkgen.c                                    |    2 
 drivers/clk/davinci/psc.c                                       |    5 
 drivers/clk/imx/clk-imx95-blk-ctl.c                             |   13 
 drivers/clk/renesas/rzv2h-cpg.c                                 |    1 
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c                            |    3 
 drivers/clk/thead/clk-th1520-ap.c                               |    9 
 drivers/clk/xilinx/xlnx_vcu.c                                   |    4 
 drivers/cpufreq/armada-8k-cpufreq.c                             |    3 
 drivers/cpufreq/cpufreq.c                                       |   21 
 drivers/cpufreq/intel_pstate.c                                  |    4 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c             |    4 
 drivers/crypto/ccp/ccp-debugfs.c                                |    3 
 drivers/crypto/ccp/sev-dev.c                                    |    8 
 drivers/crypto/img-hash.c                                       |    2 
 drivers/crypto/inside-secure/safexcel_hash.c                    |    8 
 drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c             |    8 
 drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c          |    9 
 drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c          |   29 
 drivers/crypto/intel/qat/qat_common/adf_sriov.c                 |    1 
 drivers/crypto/intel/qat/qat_common/adf_transport_debug.c       |    4 
 drivers/crypto/intel/qat/qat_common/qat_bl.c                    |    6 
 drivers/crypto/intel/qat/qat_common/qat_compression.c           |    8 
 drivers/crypto/marvell/cesa/cipher.c                            |    4 
 drivers/crypto/marvell/cesa/hash.c                              |    5 
 drivers/devfreq/devfreq.c                                       |   12 
 drivers/dma/mmp_tdma.c                                          |    2 
 drivers/dma/mv_xor.c                                            |   21 
 drivers/dma/nbpfaxi.c                                           |   13 
 drivers/firmware/arm_scmi/perf.c                                |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                          |    6 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                           |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c                         |    3 
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c                          |   20 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c             |    2 
 drivers/gpu/drm/i915/display/g4x_hdmi.c                         |   35 -
 drivers/gpu/drm/i915/display/g4x_hdmi.h                         |    5 
 drivers/gpu/drm/i915/display/intel_ddi.c                        |   37 -
 drivers/gpu/drm/i915/display/intel_display_types.h              |   13 
 drivers/gpu/drm/i915/display/intel_hdmi.c                       |   10 
 drivers/gpu/drm/i915/display/intel_hdmi.h                       |    2 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h         |    1 
 drivers/gpu/drm/panfrost/panfrost_devfreq.c                     |    4 
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c                      |    9 
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c                          |    2 
 drivers/gpu/drm/xe/xe_device.c                                  |    1 
 drivers/hid/hid-apple.c                                         |    3 
 drivers/i2c/muxes/i2c-mux-mule.c                                |    3 
 drivers/infiniband/hw/erdma/erdma_verbs.c                       |    3 
 drivers/infiniband/hw/hns/hns_roce_device.h                     |    1 
 drivers/infiniband/hw/hns/hns_roce_hem.c                        |   18 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                      |   87 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h                      |    8 
 drivers/infiniband/hw/hns/hns_roce_main.c                       |   22 
 drivers/infiniband/hw/mana/qp.c                                 |    2 
 drivers/infiniband/hw/mlx5/dm.c                                 |    2 
 drivers/infiniband/hw/mlx5/umr.c                                |    6 
 drivers/interconnect/qcom/sc8180x.c                             |    6 
 drivers/interconnect/qcom/sc8280xp.c                            |    1 
 drivers/iommu/amd/iommu.c                                       |   19 
 drivers/irqchip/Kconfig                                         |    1 
 drivers/md/bcache/alloc.c                                       |   64 --
 drivers/md/bcache/bcache.h                                      |    2 
 drivers/md/bcache/bset.c                                        |  124 +---
 drivers/md/bcache/bset.h                                        |   40 -
 drivers/md/bcache/btree.c                                       |   69 --
 drivers/md/bcache/extents.c                                     |   53 -
 drivers/md/bcache/movinggc.c                                    |   41 -
 drivers/md/bcache/super.c                                       |    3 
 drivers/md/bcache/sysfs.c                                       |    4 
 drivers/md/bcache/util.h                                        |   67 ++
 drivers/md/bcache/writeback.c                                   |   13 
 drivers/md/md.c                                                 |    9 
 drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c           |    1 
 drivers/media/v4l2-core/v4l2-ctrls-core.c                       |    8 
 drivers/misc/mei/platform-vsc.c                                 |    5 
 drivers/misc/mei/vsc-tp.c                                       |   20 
 drivers/mtd/ftl.c                                               |    2 
 drivers/mtd/nand/raw/atmel/nand-controller.c                    |    2 
 drivers/mtd/nand/raw/atmel/pmecc.c                              |    6 
 drivers/mtd/nand/raw/rockchip-nand-controller.c                 |   15 
 drivers/mtd/spi-nor/spansion.c                                  |   31 +
 drivers/net/can/kvaser_pciefd.c                                 |    1 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c                |    1 
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c                      |   17 
 drivers/net/dsa/microchip/ksz8.c                                |    3 
 drivers/net/dsa/microchip/ksz8_reg.h                            |    4 
 drivers/net/ethernet/emulex/benet/be_cmds.c                     |    2 
 drivers/net/ethernet/intel/fm10k/fm10k.h                        |    3 
 drivers/net/ethernet/intel/i40e/i40e.h                          |    2 
 drivers/net/ethernet/intel/ice/ice_ptp.c                        |    1 
 drivers/net/ethernet/intel/ixgbe/ixgbe.h                        |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c        |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c   |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c                 |    1 
 drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c                |    4 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                  |    3 
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c                    |    4 
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h                    |    6 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c               |    2 
 drivers/net/ipa/ipa_sysfs.c                                     |    6 
 drivers/net/mdio/mdio-bcm-unimac.c                              |    5 
 drivers/net/phy/mscc/mscc_ptp.c                                 |    1 
 drivers/net/phy/mscc/mscc_ptp.h                                 |    1 
 drivers/net/ppp/pptp.c                                          |   18 
 drivers/net/usb/usbnet.c                                        |   11 
 drivers/net/vrf.c                                               |    2 
 drivers/net/wireless/ath/ath11k/hal.c                           |    4 
 drivers/net/wireless/ath/ath11k/mac.c                           |   12 
 drivers/net/wireless/ath/ath12k/wmi.c                           |   12 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c     |    8 
 drivers/net/wireless/intel/iwlwifi/dvm/main.c                   |   11 
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c                    |    4 
 drivers/net/wireless/marvell/mwl8k.c                            |    4 
 drivers/net/wireless/purelifi/plfxlc/mac.c                      |   11 
 drivers/net/wireless/purelifi/plfxlc/mac.h                      |    2 
 drivers/net/wireless/purelifi/plfxlc/usb.c                      |   29 
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c              |    3 
 drivers/net/wireless/realtek/rtl8xxxu/core.c                    |    2 
 drivers/net/wireless/realtek/rtw88/main.c                       |    4 
 drivers/net/wireless/realtek/rtw89/core.c                       |    5 
 drivers/nvme/target/core.c                                      |   14 
 drivers/pci/controller/pcie-rockchip-host.c                     |    2 
 drivers/pci/endpoint/functions/pci-epf-vntb.c                   |    4 
 drivers/pci/hotplug/pnv_php.c                                   |  233 +++++++
 drivers/pci/pcie/aspm.c                                         |   30 -
 drivers/perf/arm-ni.c                                           |    2 
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c                  |   87 +-
 drivers/pinctrl/berlin/berlin.c                                 |    8 
 drivers/pinctrl/pinmux.c                                        |   20 
 drivers/pinctrl/sunxi/pinctrl-sunxi.c                           |   11 
 drivers/platform/x86/intel/pmt/class.c                          |    3 
 drivers/platform/x86/intel/pmt/class.h                          |    1 
 drivers/power/supply/cpcap-charger.c                            |    5 
 drivers/power/supply/max14577_charger.c                         |    4 
 drivers/powercap/dtpm_cpu.c                                     |    2 
 drivers/pps/pps.c                                               |   11 
 drivers/remoteproc/xlnx_r5_remoteproc.c                         |    2 
 drivers/rtc/rtc-ds1307.c                                        |    2 
 drivers/rtc/rtc-hym8563.c                                       |    2 
 drivers/rtc/rtc-nct3018y.c                                      |    2 
 drivers/rtc/rtc-pcf85063.c                                      |    2 
 drivers/rtc/rtc-pcf8563.c                                       |    2 
 drivers/rtc/rtc-rv3028.c                                        |    2 
 drivers/s390/crypto/ap_bus.h                                    |    2 
 drivers/scsi/elx/efct/efct_lio.c                                |    2 
 drivers/scsi/ibmvscsi_tgt/libsrp.c                              |    6 
 drivers/scsi/isci/request.c                                     |    2 
 drivers/scsi/mpt3sas/mpt3sas_scsih.c                            |    3 
 drivers/scsi/mvsas/mv_sas.c                                     |    4 
 drivers/scsi/scsi_transport_iscsi.c                             |    2 
 drivers/scsi/sd.c                                               |    4 
 drivers/soc/qcom/pmic_glink.c                                   |    9 
 drivers/soc/qcom/qmi_encdec.c                                   |   46 +
 drivers/soc/tegra/cbb/tegra234-cbb.c                            |    2 
 drivers/soundwire/stream.c                                      |    2 
 drivers/spi/spi-cs42l43.c                                       |    2 
 drivers/spi/spi-stm32.c                                         |    8 
 drivers/staging/fbtft/fbtft-core.c                              |    1 
 drivers/staging/greybus/gbphy.c                                 |    6 
 drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c       |    9 
 drivers/staging/nvec/nvec_power.c                               |    2 
 drivers/ufs/core/ufshcd.c                                       |   10 
 drivers/usb/early/xhci-dbc.c                                    |    4 
 drivers/usb/gadget/composite.c                                  |    5 
 drivers/usb/gadget/function/f_hid.c                             |    7 
 drivers/usb/host/xhci-plat.c                                    |    2 
 drivers/usb/misc/apple-mfi-fastcharge.c                         |   24 
 drivers/usb/serial/option.c                                     |    2 
 drivers/usb/typec/ucsi/ucsi_yoga_c630.c                         |   19 
 drivers/vdpa/mlx5/core/mr.c                                     |    3 
 drivers/vdpa/mlx5/net/mlx5_vnet.c                               |   12 
 drivers/vdpa/vdpa_user/vduse_dev.c                              |    1 
 drivers/vfio/group.c                                            |    7 
 drivers/vfio/iommufd.c                                          |    4 
 drivers/vfio/pci/pds/vfio_dev.c                                 |    1 
 drivers/vfio/pci/vfio_pci_core.c                                |    2 
 drivers/vfio/vfio_main.c                                        |    3 
 drivers/vhost/Kconfig                                           |   18 
 drivers/vhost/scsi.c                                            |    4 
 drivers/vhost/vhost.c                                           |  244 +++++++-
 drivers/vhost/vhost.h                                           |   22 
 drivers/video/fbdev/core/fbcon.c                                |    4 
 drivers/video/fbdev/imxfb.c                                     |    9 
 drivers/watchdog/ziirave_wdt.c                                  |    3 
 drivers/xen/gntdev-common.h                                     |    4 
 drivers/xen/gntdev-dmabuf.c                                     |   28 
 drivers/xen/gntdev.c                                            |   71 +-
 fs/ceph/crypto.c                                                |   31 -
 fs/exfat/file.c                                                 |    5 
 fs/ext4/inline.c                                                |    2 
 fs/ext4/inode.c                                                 |    3 
 fs/f2fs/data.c                                                  |    7 
 fs/f2fs/extent_cache.c                                          |    2 
 fs/f2fs/f2fs.h                                                  |    2 
 fs/f2fs/gc.c                                                    |    1 
 fs/f2fs/inode.c                                                 |   21 
 fs/f2fs/segment.h                                               |    5 
 fs/f2fs/super.c                                                 |    1 
 fs/f2fs/sysfs.c                                                 |   21 
 fs/gfs2/util.c                                                  |   31 -
 fs/hfs/inode.c                                                  |    1 
 fs/hfsplus/extents.c                                            |    3 
 fs/hfsplus/inode.c                                              |    1 
 fs/jfs/jfs_dmap.c                                               |    4 
 fs/nfs/dir.c                                                    |    4 
 fs/nfs/export.c                                                 |   11 
 fs/nfs/flexfilelayout/flexfilelayout.c                          |   26 
 fs/nfs/flexfilelayout/flexfilelayoutdev.c                       |    6 
 fs/nfs/internal.h                                               |    9 
 fs/nfs/nfs4proc.c                                               |   10 
 fs/notify/fanotify/fanotify.c                                   |    8 
 fs/ntfs3/file.c                                                 |    5 
 fs/ntfs3/frecord.c                                              |    7 
 fs/ntfs3/namei.c                                                |   10 
 fs/ntfs3/ntfs_fs.h                                              |    3 
 fs/orangefs/orangefs-debugfs.c                                  |    6 
 fs/proc/generic.c                                               |    2 
 fs/proc/inode.c                                                 |    2 
 fs/proc/internal.h                                              |    5 
 fs/smb/client/cifs_debug.c                                      |    6 
 fs/smb/client/smbdirect.c                                       |  116 +--
 fs/smb/client/smbdirect.h                                       |    4 
 fs/smb/server/connection.h                                      |    1 
 fs/smb/server/smb2pdu.c                                         |   22 
 fs/smb/server/smb_common.c                                      |    2 
 fs/smb/server/transport_rdma.c                                  |   97 +--
 fs/smb/server/transport_tcp.c                                   |   17 
 fs/smb/server/vfs.c                                             |    3 
 include/linux/audit.h                                           |    9 
 include/linux/fortify-string.h                                  |    2 
 include/linux/fs_context.h                                      |    2 
 include/linux/ioprio.h                                          |    3 
 include/linux/mlx5/device.h                                     |    1 
 include/linux/moduleparam.h                                     |    5 
 include/linux/pps_kernel.h                                      |    1 
 include/linux/proc_fs.h                                         |    1 
 include/linux/psi_types.h                                       |    6 
 include/linux/ring_buffer.h                                     |    4 
 include/linux/skbuff.h                                          |   23 
 include/linux/usb/usbnet.h                                      |    1 
 include/linux/wait_bit.h                                        |   60 ++
 include/net/bluetooth/hci.h                                     |    1 
 include/net/bluetooth/hci_core.h                                |    6 
 include/net/dst.h                                               |    4 
 include/net/lwtunnel.h                                          |    8 
 include/net/tc_act/tc_ctinfo.h                                  |    6 
 include/net/udp.h                                               |   24 
 include/sound/tas2781-tlv.h                                     |    2 
 include/uapi/drm/panthor_drm.h                                  |    3 
 include/uapi/linux/vhost.h                                      |   29 
 init/Kconfig                                                    |    2 
 kernel/audit.h                                                  |    2 
 kernel/auditsc.c                                                |    2 
 kernel/bpf/core.c                                               |    5 
 kernel/bpf/helpers.c                                            |   11 
 kernel/bpf/preload/Kconfig                                      |    1 
 kernel/events/core.c                                            |   20 
 kernel/kcsan/kcsan_test.c                                       |    2 
 kernel/module/main.c                                            |    6 
 kernel/rcu/refscale.c                                           |   10 
 kernel/rcu/tree_nocb.h                                          |    2 
 kernel/sched/psi.c                                              |  123 ++--
 kernel/trace/preemptirq_delay_test.c                            |   13 
 kernel/trace/ring_buffer.c                                      |   63 --
 kernel/trace/trace.c                                            |   14 
 kernel/trace/trace_kdb.c                                        |    8 
 kernel/ucount.c                                                 |    2 
 mm/hmm.c                                                        |    2 
 mm/swapfile.c                                                   |   63 +-
 net/bluetooth/hci_event.c                                       |    8 
 net/caif/cfctrl.c                                               |  294 ++++------
 net/core/dst.c                                                  |    4 
 net/core/filter.c                                               |    3 
 net/core/netpoll.c                                              |    7 
 net/core/skmsg.c                                                |    7 
 net/ipv4/route.c                                                |    4 
 net/ipv4/tcp_input.c                                            |    4 
 net/ipv6/ip6_fib.c                                              |   24 
 net/ipv6/ip6_offload.c                                          |    4 
 net/ipv6/ip6mr.c                                                |    3 
 net/ipv6/route.c                                                |   56 +
 net/mac80211/cfg.c                                              |    2 
 net/mac80211/tdls.c                                             |    2 
 net/mac80211/tx.c                                               |   14 
 net/netfilter/nf_bpf_link.c                                     |    5 
 net/netfilter/nf_tables_api.c                                   |   29 
 net/netfilter/xt_nfacct.c                                       |    4 
 net/packet/af_packet.c                                          |   12 
 net/sched/act_ctinfo.c                                          |   19 
 net/sched/sch_mqprio.c                                          |    2 
 net/sched/sch_netem.c                                           |   40 +
 net/sched/sch_taprio.c                                          |   21 
 net/sunrpc/svcsock.c                                            |   43 +
 net/sunrpc/xprtsock.c                                           |   40 +
 net/tls/tls_sw.c                                                |   13 
 net/vmw_vsock/af_vsock.c                                        |    3 
 net/wireless/nl80211.c                                          |    1 
 samples/mei/mei-amt-version.c                                   |    2 
 scripts/kconfig/qconf.cc                                        |    2 
 security/apparmor/include/match.h                               |    8 
 security/apparmor/match.c                                       |   23 
 security/apparmor/policy_unpack_test.c                          |    6 
 sound/pci/hda/cs35l56_hda.c                                     |  110 ++-
 sound/pci/hda/patch_ca0132.c                                    |    5 
 sound/pci/hda/patch_realtek.c                                   |    3 
 sound/soc/amd/yc/acp6x-mach.c                                   |   21 
 sound/soc/fsl/fsl_xcvr.c                                        |   20 
 sound/soc/intel/boards/Kconfig                                  |    2 
 sound/soc/mediatek/common/mtk-afe-platform-driver.c             |    4 
 sound/soc/mediatek/common/mtk-base-afe.h                        |    1 
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c                      |    7 
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c                      |    7 
 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c                      |    7 
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c                      |    7 
 sound/soc/soc-dai.c                                             |   16 
 sound/soc/soc-ops.c                                             |   26 
 sound/usb/mixer_scarlett2.c                                     |    7 
 sound/x86/intel_hdmi_audio.c                                    |    2 
 tools/bpf/bpftool/net.c                                         |   15 
 tools/cgroup/memcg_slabinfo.py                                  |    4 
 tools/lib/subcmd/help.c                                         |   12 
 tools/perf/.gitignore                                           |    2 
 tools/perf/builtin-sched.c                                      |   99 ++-
 tools/perf/tests/bp_account.c                                   |    1 
 tools/perf/util/build-id.c                                      |    2 
 tools/perf/util/evsel.c                                         |   11 
 tools/perf/util/evsel.h                                         |    2 
 tools/perf/util/symbol.c                                        |    1 
 tools/testing/selftests/alsa/utimer-test.c                      |    1 
 tools/testing/selftests/arm64/fp/sve-ptrace.c                   |    2 
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c         |    2 
 tools/testing/selftests/bpf/progs/verifier_arena_large.c        |  110 +++
 tools/testing/selftests/bpf/veristat.c                          |    1 
 tools/testing/selftests/breakpoints/step_after_suspend_test.c   |   41 +
 tools/testing/selftests/drivers/net/lib/py/env.py               |    2 
 tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc |   28 
 tools/testing/selftests/net/rtnetlink.sh                        |    6 
 tools/testing/selftests/perf_events/.gitignore                  |    1 
 tools/testing/selftests/perf_events/Makefile                    |    2 
 tools/testing/selftests/perf_events/mmap.c                      |  236 ++++++++
 tools/testing/selftests/syscall_user_dispatch/sud_test.c        |   50 -
 tools/testing/selftests/vDSO/vdso_test_chacha.c                 |    3 
 tools/verification/rv/src/in_kernel.c                           |    4 
 393 files changed, 3763 insertions(+), 1890 deletions(-)

Abdun Nihaal (1):
      staging: fbtft: fix potential memory leak in fbtft_framebuffer_alloc()

Abinash Singh (1):
      f2fs: fix KMSAN uninit-value in extent_info usage

Adam Ford (2):
      arm64: dts: imx8mm-beacon: Fix HS400 USDHC clock speed
      arm64: dts: imx8mn-beacon: Fix HS400 USDHC clock speed

Adam Queler (1):
      ASoC: amd: yc: Add DMI entries to support HP 15-fb1xxx

Adrián Larumbe (1):
      drm/panfrost: Fix panfrost device variable name in devfreq

Ahsan Atta (1):
      crypto: qat - allow enabling VFs in the absence of IOMMU

Al Viro (2):
      parse_longname(): strrchr() expects NUL-terminated string
      xen: fix UAF in dmabuf_exp_from_pages()

Albin Törnqvist (1):
      arm: dts: ti: omap: Fixup pinheader typo

Alex Deucher (3):
      drm/amdgpu/gfx9: fix kiq locking in KCQ reset
      drm/amdgpu/gfx9.4.3: fix kiq locking in KCQ reset
      drm/amdgpu/gfx10: fix kiq locking in KCQ reset

Alex Williamson (1):
      vfio/pci: Separate SR-IOV VF dev_set

Alexander Stein (1):
      arm64: dts: freescale: imx93-tqma9352: Limit BUCK2 to 600mV

Alexander Wetzel (2):
      wifi: mac80211: Do not schedule stopped TXQs
      wifi: mac80211: Don't call fq_flow_idx() for management frames

Alexander Wilhelm (1):
      soc: qcom: QMI encoding/decoding for big endian

Alexandru Andries (1):
      ASoC: amd: yc: add DMI quirk for ASUS M6501RM

Alexei Lazar (1):
      net/mlx5e: Clear Read-Only port buffer size in PBMC before update

Alexei Starovoitov (2):
      selftests/bpf: Add a test for arena range tree algorithm
      selftests/bpf: Fix build error with llvm 19

Alexey Kardashevskiy (1):
      crypto: ccp - Fix locking on alloc failure handling

Alok Tiwari (1):
      staging: nvec: Fix incorrect null termination of battery manufacturer

Amir Goldstein (1):
      fanotify: sanitize handle_type values when reporting fid

Ammar Faizi (1):
      net: usbnet: Fix the wrong netif_carrier_on() call

Anders Roxell (1):
      vdpa: Fix IDR memory leak in VDUSE module exit

Andreas Gruenbacher (1):
      gfs2: No more self recovery

Andrzej Kacprowski (1):
      accel/ivpu: Fix reset_engine debugfs file logic

André Apitzsch (1):
      arm64: dts: qcom: msm8976: Make blsp_dma controlled-remotely

Andy Shevchenko (1):
      mm/hmm: move pmd_to_hmm_pfn_flags() to the respective #ifdeffery

Andy Yan (1):
      drm/rockchip: cleanup fb when drm_gem_fb_afbc_init failed

Annette Kobou (1):
      ARM: dts: imx6ul-kontron-bl-common: Fix RTS polarity for RS485 interface

Anton Nadezhdin (1):
      ice/ptp: fix crosstimestamp reporting

Arnd Bergmann (8):
      ethernet: intel: fix building with large NR_CPUS
      ASoC: Intel: fix SND_SOC_SOF dependencies
      ASoC: ops: dynamically allocate struct snd_ctl_elem_value
      cpufreq: armada-8k: make both cpu masks static
      caif: reduce stack size, again
      crypto: arm/aes-neonbs - work around gcc-15 warning
      kernel: trace: preemptirq_delay_test: use offstack cpu mask
      irqchip: Build IMX_MU_MSI only on ARM

Arseniy Krasnov (1):
      Bluetooth: hci_sync: fix double free in 'hci_discovery_filter_clear()'

Artem Sadovnikov (1):
      refscale: Check that nreaders and loops multiplication doesn't overflow

Bairavi Alagappan (1):
      crypto: qat - disable ZUC-256 capability for QAT GEN5

Balamanikandan Gunasundar (1):
      mtd: rawnand: atmel: set pmecc data setup time

Baochen Qiang (1):
      wifi: ath11k: fix sleeping-in-atomic in ath11k_mac_op_set_bitrate_mask()

Baojun Xu (1):
      ASoC: tas2781: Fix the wrong step for TLV on tas2781

Bard Liao (1):
      soundwire: stream: restore params when prepare ports fail

Ben Hutchings (1):
      sh: Do not use hyphen in exported variable name

Benjamin Coddington (1):
      NFS: Fixup allocation flags for nfsiod's __GFP_NORETRY

Bitterblue Smith (1):
      wifi: rtw88: Fix macid assigned to TDLS station

Boris Brezillon (1):
      drm/panthor: Add missing explicit padding in drm_panthor_gpu_info

Brahmajit Das (1):
      samples: mei: Fix building on musl libc

Brett Creeley (1):
      vfio/pds: Fix missing detach_ioas op

Brian Masney (6):
      rtc: ds1307: fix incorrect maximum clock rate handling
      rtc: hym8563: fix incorrect maximum clock rate handling
      rtc: nct3018y: fix incorrect maximum clock rate handling
      rtc: pcf85063: fix incorrect maximum clock rate handling
      rtc: pcf8563: fix incorrect maximum clock rate handling
      rtc: rv3028: fix incorrect maximum clock rate handling

Budimir Markovic (1):
      vsock: Do not allow binding to VMADDR_PORT_ANY

Caleb Sander Mateos (1):
      ublk: use vmalloc for ublk_device's __queues

Chanwoo Choi (1):
      PM / devfreq: Fix a index typo in trans_stat

Chao Yu (9):
      f2fs: fix to check upper boundary for gc_valid_thresh_ratio
      f2fs: fix to check upper boundary for gc_no_zoned_gc_percent
      f2fs: doc: fix wrong quota mount option description
      f2fs: fix to avoid UAF in f2fs_sync_inode_meta()
      f2fs: fix to avoid panic in f2fs_evict_inode
      f2fs: fix to avoid out-of-boundary access in devs.path
      f2fs: fix to update upper_p in __get_secs_required() correctly
      f2fs: fix to calculate dirty data during has_not_enough_free_secs()
      f2fs: fix to trigger foreground gc during f2fs_map_blocks() in lfs mode

Charalampos Mitrodimas (1):
      usb: misc: apple-mfi-fastcharge: Make power supply names unique

Charles Han (2):
      power: supply: cpcap-charger: Fix null check for power_supply_get_by_name
      power: supply: max14577: Handle NULL pdata when CONFIG_OF is not set

Chen Pei (1):
      perf tools: Remove libtraceevent in .gitignore

Chen-Yu Tsai (1):
      ASoC: mediatek: use reserved memory or enable buffer pre-allocation

Chenyuan Yang (1):
      fbdev: imxfb: Check fb_add_videomode to prevent null-ptr-deref

Chris Down (1):
      Bluetooth: hci_event: Mask data status from LE ext adv reports

Christoph Hellwig (1):
      block: ensure discard_granularity is zero when discard is not supported

Christoph Paasch (1):
      net/mlx5: Correctly set gso_segs when LRO is used

Christophe JAILLET (1):
      i2c: muxes: mule: Fix an error handling path in mule_i2c_mux_probe()

Cindy Lu (1):
      vhost: Reintroduce kthread API and add mode selection

Clément Le Goffic (1):
      spi: stm32: Check for cfg availability in stm32_spi_probe

Daeho Jeong (1):
      f2fs: turn off one_time when forcibly set to foreground GC

Dan Carpenter (2):
      watchdog: ziirave_wdt: check record length in ziirave_firm_verify()
      fs/orangefs: Allow 2 more characters in do_c_string()

Daniil Dulov (1):
      wifi: rtl818x: Kill URBs before clearing tx status queue

Dave Hansen (1):
      x86/fpu: Delay instruction pointer fixup until after warning

Denis OSTERLAND-HEIM (1):
      pps: fix poll support

Dmitry Baryshkov (3):
      usb: typec: ucsi: yoga-c630: fix error and remove paths
      interconnect: qcom: sc8280xp: specify num_links for qnm_a1noc_cfg
      interconnect: qcom: sc8180x: specify num_nodes

Dmitry Vyukov (1):
      selftests: Fix errno checking in syscall_user_dispatch test

Dragos Tatulea (2):
      vdpa/mlx5: Fix needs_teardown flag calculation
      vdpa/mlx5: Fix release of uninitialized resources on error path

Easwar Hariharan (1):
      iommu/amd: Enable PASID and ATS capabilities in the correct order

Edip Hazuri (3):
      ALSA: hda/realtek - Fix mute LED for HP Victus 16-r1xxx
      ALSA: hda/realtek - Fix mute LED for HP Victus 16-s0xxx
      ALSA: hda/realtek - Fix mute LED for HP Victus 16-d1xxx (MB 8A26)

Edward Adam Davis (1):
      fs/ntfs3: cancle set bad inode after removing name fails

Edward Srouji (1):
      RDMA/mlx5: Fix UMR modifying of mkey page size

Eric Dumazet (10):
      net: dst: annotate data-races around dst->input
      net: dst: annotate data-races around dst->output
      net_sched: act_ctinfo: use atomic64_t for three counters
      tcp: call tcp_measure_rcv_mss() for ooo packets
      ipv6: prevent infinite loop in rt6_nlmsg_size()
      ipv6: fix possible infinite loop in fib6_info_uses_dev()
      ipv6: annotate data-races around rt->fib6_nsiblings
      pptp: ensure minimal skb length in pptp_xmit()
      ipv6: reject malicious packets in ipv6_gso_segment()
      pptp: fix pptp_xmit() error path

Fedor Pchelkin (2):
      drm/amd/pm/powerplay/hwmgr/smu_helper: fix order of mask and value
      netfilter: nf_tables: adjust lockdep assertions handling

Finn Thain (1):
      m68k: Don't unregister boot console needlessly

Florian Fainelli (1):
      net: mdio: mdio-bcm-unimac: Correct rate fallback logic

Florian Westphal (1):
      netfilter: xt_nfacct: don't assume acct name is null-terminated

Fushuai Wang (1):
      selftests/bpf: fix signedness bug in redir_partial()

Gabriele Monaco (1):
      tools/rv: Do not skip idle in trace

Gal Pressman (1):
      selftests: drv-net: Fix remote command checking in require_cmd()

Geoffrey D. Bennett (1):
      ALSA: scarlett2: Add retry on -EPROTO from scarlett2_usb_tx()

Gerald Schaefer (1):
      s390/mm: Remove possible false-positive warning in pte_free_defer()

Giovanni Cabiddu (2):
      crypto: qat - fix DMA direction for compression on GEN2 devices
      crypto: qat - fix seq_file position update in adf_ring_next()

Gokul Sivakumar (1):
      wifi: brcmfmac: fix P2P discovery failure in P2P peer due to missing P2P IE

Greg Kroah-Hartman (3):
      Revert "vmci: Prevent the dispatching of uninitialized payloads"
      staging: greybus: gbphy: fix up const issue with the match callback
      Linux 6.12.42

Guenter Roeck (1):
      block: Fix default IO priority if there is no IO context

Hans Zhang (1):
      PCI: rockchip-host: Fix "Unexpected Completion" log message

Hans de Goede (3):
      mei: vsc: Destroy mutex after freeing the IRQ
      mei: vsc: Event notifier fixes
      mei: vsc: Unset the event callback on remove and probe errors

Harald Freudenberger (1):
      s390/ap: Unmask SLCF bit in card and queue ap functions sysfs

Haren Myneni (1):
      powerpc/pseries/dlpar: Search DRC index from ibm,drc-indexes for IO add

Helge Deller (1):
      apparmor: Fix unaligned memory accesses in KUnit test

Heming Zhao (1):
      md/md-cluster: handle REMOVE message earlier

Henry Martin (1):
      clk: davinci: Add NULL check in davinci_lpsc_clk_register()

Herbert Xu (1):
      crypto: marvell/cesa - Fix engine load inaccuracy

Horatiu Vultur (1):
      phy: mscc: Fix parsing of unicast frames

Ian Forbes (1):
      drm/vmwgfx: Fix Host-Backed userspace on Guest-Backed kernel

Ian Rogers (1):
      perf dso: Add missed dso__put to dso__load_kcore

Ilpo Järvinen (1):
      PCI/ASPM: Fix L1SS saving

Ivan Stepchenko (1):
      mtd: fix possible integer overflow in erase_xfer()

Jacob Pan (2):
      vfio: Fix unbalanced vfio_df_close call in no-iommu mode
      vfio: Prevent open_count decrement to negative

Jakub Kicinski (3):
      netpoll: prevent hanging NAPI when netcons gets enabled
      netlink: specs: ethtool: fix module EEPROM input/output arguments
      eth: fbnic: remove the debugging trick of super high page bias

James Cowgill (1):
      media: v4l2-ctrls: Fix H264 SEPARATE_COLOUR_PLANE check

Jan Kara (1):
      ext4: Make sure BH_New bit is cleared in ->write_end handler

Jan Prusakowski (1):
      f2fs: vm_unmap_ram() may be called from an invalid context

Jani Nikula (6):
      drm/i915/ddi: change intel_ddi_init_{dp, hdmi}_connector() return type
      drm/i915/hdmi: propagate errors from intel_hdmi_init_connector()
      drm/i915/hdmi: add error handling in g4x_hdmi_init()
      drm/i915/ddi: gracefully handle errors from intel_ddi_init_hdmi_connector()
      drm/i915/display: add intel_encoder_is_hdmi()
      drm/i915/ddi: only call shutdown hooks for valid encoders

Jason Gunthorpe (1):
      iommu/amd: Fix geometry.aperture_end for V2 tables

Jason Xing (1):
      stmmac: xsk: fix negative overflow of budget in zerocopy mode

Jerome Brunet (1):
      PCI: endpoint: pci-epf-vntb: Return -ENOENT if pci_epc_get_next_free_bar() fails

Jian-Hong Pan (1):
      PCI/ASPM: Save parent L1SS config in pci_save_aspm_l1ss_state()

Jianbo Liu (1):
      net/mlx5e: Remove skb secpath if xfrm state is not found

Jiasheng Jiang (1):
      iwlwifi: Add missing check for alloc_ordered_workqueue

Jiaxun Yang (1):
      MIPS: mm: tlb-r4k: Uniquify TLB entries on init

Jiayuan Chen (2):
      bpf, sockmap: Fix psock incorrectly pointing to sk
      bpf, ktls: Fix data corruption when using bpf_msg_pop_data() in ktls

Jimmy Assarsson (2):
      can: kvaser_pciefd: Store device channel index
      can: kvaser_usb: Assign netdev.dev_port based on device channel index

Johan Hovold (1):
      soc: qcom: pmic_glink: fix OF node leak

Johan Korsnes (1):
      arch: powerpc: defconfig: Drop obsolete CONFIG_NET_CLS_TCINDEX

John Ernberg (1):
      net: usbnet: Avoid potential RCU stall on LINK_CHANGE event

Juergen Gross (1):
      xen/gntdev: remove struct gntdev_copy_batch from stack

Julien Massot (1):
      media: ti: j721e-csi2rx: fix list_del corruption

Junxian Huang (4):
      RDMA/hns: Get message length of ack_req from FW
      RDMA/hns: Fix accessing uninitialized resources
      RDMA/hns: Drop GFP_NOWARN
      RDMA/hns: Fix -Wframe-larger-than issue

Kees Cook (4):
      wifi: mac80211: Write cnt before copying in ieee80211_copy_rnr_beacon()
      wifi: nl80211: Set num_sub_specs before looping through sub_specs
      staging: media: atomisp: Fix stack buffer overflow in gmin_get_var_int()
      fortify: Fix incorrect reporting of read buffer size

Kemeng Shi (2):
      mm: swap: correctly use maxpages in swapon syscall to avoid potential deadloop
      mm: swap: fix potential buffer overflow in setup_clusters()

Konrad Dybcio (3):
      arm64: dts: qcom: sdm845: Expand IMEM region
      arm64: dts: qcom: sc7180: Expand IMEM region
      drm/msm/dpu: Fill in min_prefill_lines for SC8180X

Konstantin Komarov (1):
      Revert "fs/ntfs3: Replace inode_trylock with inode_lock"

Krzysztof Kozlowski (2):
      ARM: dts: vfxxx: Correctly use two tuples for timer address
      dmaengine: mmp: Fix again Wvoid-pointer-to-enum-cast warning

Kuan-Wei Chiu (1):
      Revert "bcache: remove heap-related macros and switch to generic min_heap"

Kumar Kartikeya Dwivedi (1):
      bpf: Ensure RCU lock is held around bpf_prog_ksym_find

Kuninori Morimoto (1):
      ASoC: soc-dai: tidyup return value of snd_soc_xlate_tdm_slot_mask()

Kuniyuki Iwashima (1):
      bpf: Disable migration in nf_hook_run_bpf().

Lad Prabhakar (1):
      clk: renesas: rzv2h: Fix missing CLK_SET_RATE_PARENT flag for ddiv clocks

Lane Odenbach (1):
      ASoC: amd: yc: Add DMI quirk for HP Laptop 17 cp-2033dx

Laurentiu Palcu (1):
      clk: imx95-blk-ctl: Fix synchronous abort

Leo Yan (1):
      perf tests bp_account: Fix leaked file descriptor

Li Lingfeng (1):
      scsi: Revert "scsi: iscsi: Fix HW conn removal use after free"

Lifeng Zheng (3):
      PM / devfreq: Check governor before using governor->name
      cpufreq: Initialize cpufreq-based frequency-invariance later
      cpufreq: Init policy->rwsem before it may be possibly used

Lijo Lazar (1):
      drm/amdgpu: Remove nbiov7.9 replay count reporting

Lijuan Gao (1):
      arm64: dts: qcom: sa8775p: Correct the interrupt for remoteproc

Lizhi Xu (1):
      vmci: Prevent the dispatching of uninitialized payloads

Lorenzo Stoakes (1):
      selftests/perf_events: Add a mmap() correctness test

Luca Weiss (2):
      phy: qualcomm: phy-qcom-eusb2-repeater: Don't zero-out registers
      net: ipa: add IPA v5.1 and v5.5 to ipa_version_string()

Lucas De Marchi (1):
      usb: early: xhci-dbc: Fix early_ioremap leak

Lukasz Laguna (1):
      drm/xe/vf: Disable CSC support on VF

Maher Azzouzi (1):
      net/sched: mqprio: fix stack out-of-bounds write in tc entry parsing

Manivannan Sadhasivam (1):
      PCI: endpoint: pci-epf-vntb: Fix the incorrect usage of __iomem attribute

Marco Elver (1):
      kcsan: test: Initialize dummy variable

Mark Brown (1):
      kselftest/arm64: Fix check for setting new VLs in sve-ptrace

Martin Kaistra (1):
      wifi: rtl8xxxu: Fix RX skb size for aggregation disabled

Masahiro Yamada (1):
      kconfig: qconf: fix ConfigList::updateListAllforAll()

Matthew Wilcox (Oracle) (1):
      memcg_slabinfo: Fix use of PG_slab

Mengbiao Xiong (1):
      crypto: ccp - Fix crash when rebind ccp device for ccp.ko

Michael J. Ruhl (1):
      platform/x86/intel/pmt: fix a crashlog NULL pointer access

Michael Walle (1):
      arm64: dts: ti: k3-am62p-j722s: fix pinctrl-single size

Michal Schmidt (1):
      benet: fix BUG when creating VFs

Mike Christie (1):
      vhost-scsi: Fix log flooding with target does not exist errors

Mohamed Khalfella (2):
      nvmet: initialize discovery subsys after debugfs is initialized
      nvmet: exit debugfs after discovery subsystem exits

Moon Hee Lee (2):
      selftests: breakpoints: use suspend_stats to reliably check suspend success
      wifi: mac80211: reject TDLS operations when station is not associated

Mukesh Ojha (1):
      pinmux: fix race causing mux_owner NULL with active mux_usecount

Murad Masimov (1):
      wifi: plfxlc: Fix error handling in usb driver probe

Mykyta Yatsenko (1):
      selftests/bpf: Fix unintentional switch case fall through

Namhyung Kim (8):
      perf tools: Fix use-after-free in help_unknown_cmd()
      perf sched: Make sure it frees the usage string
      perf sched: Free thread->priv using priv_destructor
      perf sched: Fix memory leaks in 'perf sched map'
      perf sched: Fix memory leaks for evsel->priv in timehist
      perf sched: Use RC_CHK_EQUAL() to compare pointers
      perf sched: Fix memory leaks in 'perf sched latency'
      perf record: Cache build-ID of hit DSOs only

Namjae Jeon (4):
      ksmbd: fix null pointer dereference error in generate_encryptionkey
      ksmbd: fix Preauh_HashValue race condition
      ksmbd: fix corrupted mtime and ctime in smb2_open
      ksmbd: limit repeated connections from clients with the same IP

NeilBrown (1):
      sched: Add test_and_clear_wake_up_bit() and atomic_dec_and_wake_up()

Nuno Sá (1):
      clk: clk-axi-clkgen: fix fpfd_max frequency for zynq

Olga Kornievskaia (3):
      NFSv4.2: another fix for listxattr
      sunrpc: fix client side handling of tls alerts
      sunrpc: fix handling of server side tls alerts

Ovidiu Panait (2):
      crypto: sun8i-ce - fix nents passed to dma_unmap_sg()
      hwrng: mtk - handle devm_pm_runtime_enable errors

Patrick Delaunay (1):
      arm64: dts: st: fix timer used for ticks

Paul Chaignon (2):
      bpf: Check flow_dissector ctx accesses are aligned
      bpf: Check netfilter ctx accesses are aligned

Paul Kocialkowski (1):
      clk: sunxi-ng: v3s: Fix de clock definition

Peter Zijlstra (2):
      sched/psi: Optimize psi_group_change() cpu_clock() usage
      sched/psi: Fix psi_seq initialization

Petr Machata (1):
      net: ipv6: ip6mr: Fix in/out netdev to pass to the FORWARD chain

Petr Pavlu (1):
      module: Restore the moduleparam prefix length check

Phil Sutter (1):
      netfilter: nf_tables: Drop dead code from fill_*_info routines

Puranjay Mohan (1):
      bpf, arm64: Fix fp initialization for exception boundary

Qasim Ijaz (1):
      HID: apple: validate feature-report field count to prevent NULL pointer dereference

Quang Le (1):
      net/packet: fix a race in packet_set_ring() and packet_notifier()

Rafael J. Wysocki (1):
      cpufreq: intel_pstate: Always use HWP_DESIRED_PERF in passive mode

Randy Dunlap (1):
      io_uring: fix breakage in EXPERT menu

Remi Pommarel (2):
      wifi: mac80211: Check 802.11 encaps offloading in ieee80211_tx_h_select_key()
      Reapply "wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()"

Richard Fitzgerald (1):
      ALSA: hda/cs35l56: Workaround bad dev-index on Lenovo Yoga Book 9i GenX

Richard Guy Briggs (1):
      audit,module: restore audit logging in load failure case

Robin Murphy (1):
      perf/arm-ni: Set initial IRQ affinity

Rohit Visavalia (1):
      clk: xilinx: vcu: unregister pll_post only if registered correctly

RubenKelevra (1):
      fs_context: fix parameter name in infofc() macro

Ryan Lee (2):
      apparmor: ensure WB_HISTORY_SIZE value is a power of 2
      apparmor: fix loop detection used in conflicting attachment resolution

Salomon Dushimirimana (1):
      scsi: sd: Make sd shutdown issue START STOP UNIT appropriately

Sergey Senozhatsky (1):
      wifi: ath11k: clear initialized flag for deinit-ed srng lists

Seunghui Lee (1):
      scsi: ufs: core: Use link recovery when h8 exit fails during runtime resume

Seungjin Bae (1):
      usb: host: xhci-plat: fix incorrect type for of_match variable in xhci_plat_probe()

Sheng Yong (1):
      f2fs: fix bio memleak when committing super block

Shengjiu Wang (1):
      ASoC: fsl_xcvr: get channel status data when PHY is not exists

Shiraz Saleem (1):
      RDMA/mana_ib: Fix DSCP value in modify QP

Shixiong Ou (1):
      fbcon: Fix outdated registered_fb reference in comment

Sibi Sankar (1):
      firmware: arm_scmi: Fix up turbo frequencies selection

Simon Trimmer (1):
      spi: cs42l43: Property entry should be a null-terminated array

Sivan Zohar-Kotzer (1):
      powercap: dtpm_cpu: Fix NULL pointer dereference in get_pd_power_uw()

Slark Xiao (2):
      bus: mhi: host: pci_generic: Fix the modem name of Foxconn T99W640
      USB: serial: option: add Foxconn T99W709

Stanislav Fomichev (1):
      vrf: Drop existing dst reference in vrf_ip6_input_dst

Stav Aviram (1):
      net/mlx5: Check device memory pointer before usage

Stefan Metzmacher (9):
      smb: server: remove separate empty_recvmsg_queue
      smb: server: make sure we call ib_dma_unmap_single() only if we called ib_dma_map_single already
      smb: server: let recv_done() consistently call put_recvmsg/smb_direct_disconnect_rdma_connection
      smb: server: let recv_done() avoid touching data_transfer after cleanup/move
      smb: client: remove separate empty_packet_queue
      smb: client: make sure we call ib_dma_unmap_single() only if we called ib_dma_map_single already
      smb: client: let recv_done() cleanup before notifying the callers.
      smb: client: let recv_done() avoid touching data_transfer after cleanup/move
      smb: client: return an error if rdma_connect does not return within 5 seconds

Stephane Grosjean (1):
      can: peak_usb: fix USB FD devices potential malfunction

Steven Rostedt (2):
      selftests/tracing: Fix false failure of subsystem event test
      ring-buffer: Remove ring_buffer_read_prepare_sync()

Suman Kumar Chakraborty (1):
      crypto: qat - use unmanaged allocation for dc_data

Sumanth Korikkar (1):
      s390/mm: Allocate page table with PAGE_SIZE granularity

Sumit Gupta (1):
      soc/tegra: cbb: Clear ERR_FORCE register with ERR_STATUS

Svyatoslav Pankratov (1):
      crypto: qat - fix state restore for banks with exceptions

Takahiro Kuwano (1):
      mtd: spi-nor: spansion: Fixup params->set_4byte_addr_mode for SEMPER

Takamitsu Iwai (1):
      net/sched: taprio: enforce minimum value for picos_per_byte

Takashi Iwai (1):
      ALSA: hda/ca0132: Fix missing error handling in ca0132_alt_select_out()

Tamizh Chelvam Raja (1):
      wifi: ath12k: fix endianness handling while accessing wmi service bit

Tanmay Shah (1):
      remoteproc: xlnx: Disable unsupported features

Tao Xue (1):
      usb: gadget : fix use-after-free in composite_dev_cleanup()

Thomas Fourier (13):
      mwl8k: Add missing check after DMA map
      Fix dma_unmap_sg() nents value
      crypto: inside-secure - Fix `dma_unmap_sg()` nents value
      scsi: ibmvscsi_tgt: Fix dma_unmap_sg() nents value
      scsi: elx: efct: Fix dma_unmap_sg() nents value
      scsi: mvsas: Fix dma_unmap_sg() nents value
      scsi: isci: Fix dma_unmap_sg() nents value
      crypto: keembay - Fix dma_unmap_sg() nents value
      crypto: img-hash - Fix dma_unmap_sg() nents value
      dmaengine: mv_xor: Fix missing check after DMA map and missing unmap
      dmaengine: nbpfaxi: Add missing check after DMA map
      mtd: rawnand: atmel: Fix dma_mapping_error() address
      mtd: rawnand: rockchip: Add missing check after DMA map

Thomas Gleixner (4):
      x86/irq: Plug vector setup race
      perf/core: Don't leak AUX buffer refcount on allocation failure
      perf/core: Exit early on perf_mmap() fail
      perf/core: Prevent VMA split of buffer mappings

Thomas Weißschuh (2):
      selftests: vDSO: chacha: Correctly skip test if necessary
      bpf/preload: Don't select USERMODE_DRIVER

Thorsten Blum (2):
      smb: server: Fix extension string in ksmbd_extract_shortname()
      ALSA: intel_hdmi: Fix off-by-one error in __hdmi_lpe_audio_probe()

Tigran Mkrtchyan (1):
      pNFS/flexfiles: don't attempt pnfs on fatal DS errors

Timothy Pearson (5):
      PCI: pnv_php: Clean up allocated IRQs on unplug
      PCI: pnv_php: Work around switches with broken presence detection
      powerpc/eeh: Export eeh_unfreeze_pe()
      powerpc/eeh: Make EEH driver device hotplug safe
      PCI: pnv_php: Fix surprise plug detection and recovery

Tiwei Bie (1):
      um: rtc: Avoid shadowing err in uml_rtc_start()

Tom Lendacky (1):
      x86/sev: Evict cache lines during SNP memory validation

Tomas Henzl (1):
      scsi: mpt3sas: Fix a fw_event memory leak

Tristram Ha (1):
      net: dsa: microchip: Fix wrong rx drop MIB counter for KSZ8863

Trond Myklebust (2):
      NFS: Fix wakeup of __nfs_lookup_revalidate() in unblock_revalidate()
      NFS: Fix filehandle bounds checking in nfs_fh_to_dentry()

Tze-nan Wu (1):
      rcu: Fix delayed execution of hurry callbacks

Uros Bizjak (1):
      ucount: fix atomic_long_inc_below() argument type

Varshini Rajendran (1):
      clk: at91: sam9x7: update pll clk ranges

Wadim Egorov (1):
      arm64: dts: ti: k3-am642-phyboard-electra: Fix PRU-ICSSG Ethernet ports

Wang Liang (1):
      net: drop UFO packets in udp_rcv_segment()

WangYuli (1):
      selftests: ALSA: fix memory leak in utimer test

Will Deacon (1):
      arm64: dts: exynos: gs101: Add 'local-timer-stop' to cpuidle nodes

William Liu (1):
      net/sched: Restrict conditions for adding duplicating netems to qdisc tree

Xiu Jianfeng (1):
      wifi: iwlwifi: Fix memory leak in iwl_mvm_init()

Xiumei Mu (1):
      selftests: rtnetlink.sh: remove esp4_offload after test

Yangtao Li (3):
      hfsplus: make splice write available again
      hfs: make splice write available again
      hfsplus: remove mutex_lock check in hfsplus_free_extents

Yao Zi (1):
      clk: thead: th1520-ap: Correctly refer the parent of osc_12m

Yuan Chen (3):
      bpftool: Fix memory leak in dump_xx_nlmsg on realloc failure
      pinctrl: sunxi: Fix memory leak on krealloc failure
      pinctrl: berlin: fix memory leak in berlin_pinctrl_build_state()

Yuhao Jiang (1):
      USB: gadget: f_hid: Fix memory leak in hidg_bind error path

Zenm Chen (1):
      Bluetooth: btusb: Add USB ID 3625:010b for TP-LINK Archer TX10UB Nano

Zheng Yu (1):
      jfs: fix metapage reference count leak in dbAllocCtl

Zhengxu Zhang (1):
      exfat: fdatasync flag should be same like generic_write_sync()

Zong-Zhe Yang (1):
      wifi: rtw89: avoid NULL dereference when RX problematic packet on unsupported 6 GHz band

wangzijie (1):
      proc: use the same treatment to check proc_lseek as ones for proc_read_iter et.al

wenglianfa (2):
      RDMA/hns: Fix double destruction of rsv_qp
      RDMA/hns: Fix HW configurations not cleared in error flow

xin.guo (1):
      tcp: fix tcp_ofo_queue() to avoid including too much DUP SACK range

yohan.joung (1):
      f2fs: fix to check upper boundary for value of gc_boost_zoned_gc_percent


