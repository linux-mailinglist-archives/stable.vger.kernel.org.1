Return-Path: <stable+bounces-69442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 543E395626C
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 06:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21DF31F2120B
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 04:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3988149C57;
	Mon, 19 Aug 2024 04:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jc9Kotmq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9272213D283;
	Mon, 19 Aug 2024 04:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724040788; cv=none; b=d7DrJKdspACT/a+RvKIUK5PyhPf06/aUqfczjTzUWmTBvgPvPl5iYZr2NiPw+UN5THEgIdNh3djRHN76bJO6PktcA9OnJrXSqiRWhpgSmyWtWO/BbmG0DJIOPR3GPyea3qkP5cIqMt9Zpnf4aR7U73WHELYGFF3zkX90PhJsDQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724040788; c=relaxed/simple;
	bh=64gTLrshxZBH56EjnJRNvgn2JXSg1wrAxd2fjHZ1RSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XvPXO6bZUWLJ79fdoq7X12GTx941WPOKNJF9Im3SDBczp8eDU66MSVF1BVGmYXcAPta/RXJRA/43BfYzRwpI/ZPRRmcrsrHKxD9H1oSNSAtzpnlZVlXU8xbx3Lf6Yhv8vZWQpW02uBeeiZTiS497Zpd3BHecXoAMHoCeuVLW9mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jc9Kotmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B335C4AF0F;
	Mon, 19 Aug 2024 04:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724040788;
	bh=64gTLrshxZBH56EjnJRNvgn2JXSg1wrAxd2fjHZ1RSI=;
	h=From:To:Cc:Subject:Date:From;
	b=Jc9KotmqTb8v5mhrxFrGVd4xTFOQijsPrc+2yQ+Q4POAjrAHoxO8vATLNDMcwNTbv
	 vYpoZyf1INekAkhDqI3Rn1u7lQFZaEKNB9QwRxGoAkpHKgYT0cb1scoI7oXgbmt/NH
	 D8fdV4i1TJuPN2jN5TUix/2jc+ZnE/mu41jY4wQA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.165
Date: Mon, 19 Aug 2024 06:12:50 +0200
Message-ID: <2024081951-swab-polio-dc69@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.165 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt                   |   10 
 Documentation/arm64/cpu-feature-registers.rst                     |   38 +-
 Documentation/arm64/silicon-errata.rst                            |   36 +
 Documentation/devicetree/bindings/thermal/thermal-zones.yaml      |    5 
 Makefile                                                          |    2 
 arch/arm/boot/dts/imx6q-kontron-samx6i.dtsi                       |   23 -
 arch/arm/boot/dts/imx6qdl-kontron-samx6i.dtsi                     |   26 +
 arch/arm/mach-pxa/include/mach/spitz.h                            |  185 ---------
 arch/arm/mach-pxa/spitz.c                                         |   39 +-
 arch/arm/mach-pxa/spitz.h                                         |  185 +++++++++
 arch/arm/mach-pxa/spitz_pm.c                                      |    2 
 arch/arm64/Kconfig                                                |   38 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi                       |    4 
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                        |    4 
 arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts          |    4 
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts                      |    4 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi            |   25 -
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi                    |    2 
 arch/arm64/boot/dts/qcom/ipq8074.dtsi                             |    6 
 arch/arm64/boot/dts/qcom/msm8996.dtsi                             |    8 
 arch/arm64/boot/dts/qcom/msm8998.dtsi                             |   36 -
 arch/arm64/boot/dts/qcom/sdm845.dtsi                              |    2 
 arch/arm64/boot/dts/qcom/sm8250.dtsi                              |   22 -
 arch/arm64/boot/dts/qcom/sm8350.dtsi                              |    3 
 arch/arm64/boot/dts/rockchip/rk3328.dtsi                          |    4 
 arch/arm64/include/asm/barrier.h                                  |    4 
 arch/arm64/include/asm/cputype.h                                  |   16 
 arch/arm64/kernel/cpu_errata.c                                    |   31 +
 arch/arm64/kernel/cpufeature.c                                    |   90 +++-
 arch/arm64/kernel/proton-pack.c                                   |   12 
 arch/arm64/tools/cpucaps                                          |    1 
 arch/m68k/amiga/config.c                                          |    9 
 arch/m68k/atari/ataints.c                                         |    6 
 arch/m68k/include/asm/cmpxchg.h                                   |    2 
 arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi                |   98 +++--
 arch/mips/include/asm/mach-loongson64/boot_param.h                |    2 
 arch/mips/include/asm/mips-cm.h                                   |    4 
 arch/mips/kernel/smp-cps.c                                        |    5 
 arch/mips/loongson64/env.c                                        |    8 
 arch/mips/loongson64/reset.c                                      |   38 --
 arch/mips/loongson64/smp.c                                        |   23 +
 arch/mips/sgi-ip30/ip30-console.c                                 |    1 
 arch/powerpc/configs/85xx-hw.config                               |    2 
 arch/powerpc/include/asm/interrupt.h                              |   14 
 arch/powerpc/include/asm/percpu.h                                 |   10 
 arch/powerpc/kernel/setup_64.c                                    |    2 
 arch/powerpc/kvm/powerpc.c                                        |    4 
 arch/powerpc/xmon/ppc-dis.c                                       |   33 -
 arch/riscv/mm/fault.c                                             |   17 
 arch/sparc/include/asm/oplib_64.h                                 |    1 
 arch/sparc/prom/init_64.c                                         |    3 
 arch/sparc/prom/p1275.c                                           |    2 
 arch/um/kernel/time.c                                             |    4 
 arch/um/os-Linux/signal.c                                         |  118 +++++-
 arch/x86/events/intel/pt.c                                        |    4 
 arch/x86/events/intel/pt.h                                        |    4 
 arch/x86/events/intel/uncore_snbep.c                              |    6 
 arch/x86/kernel/cpu/mtrr/mtrr.c                                   |    2 
 arch/x86/kernel/devicetree.c                                      |    2 
 arch/x86/kvm/vmx/vmx.c                                            |   11 
 arch/x86/kvm/vmx/vmx.h                                            |    1 
 arch/x86/mm/pti.c                                                 |    8 
 arch/x86/pci/intel_mid_pci.c                                      |    4 
 arch/x86/pci/xen.c                                                |    4 
 arch/x86/platform/intel/iosf_mbi.c                                |    4 
 arch/x86/xen/p2m.c                                                |    4 
 block/bio-integrity.c                                             |   21 -
 drivers/acpi/battery.c                                            |   16 
 drivers/acpi/sbs.c                                                |   23 -
 drivers/android/binder.c                                          |    4 
 drivers/ata/libata-scsi.c                                         |   10 
 drivers/base/core.c                                               |   13 
 drivers/base/devres.c                                             |   11 
 drivers/base/module.c                                             |    4 
 drivers/block/rbd.c                                               |   35 -
 drivers/bluetooth/btusb.c                                         |    4 
 drivers/char/hw_random/amd-rng.c                                  |    4 
 drivers/char/tpm/eventlog/common.c                                |    2 
 drivers/clk/davinci/da8xx-cfgchip.c                               |    4 
 drivers/clk/qcom/clk-branch.h                                     |   26 +
 drivers/clk/qcom/gcc-sc7280.c                                     |    3 
 drivers/clocksource/sh_cmt.c                                      |   13 
 drivers/dma/ti/k3-udma.c                                          |    4 
 drivers/edac/Makefile                                             |   10 
 drivers/edac/skx_common.c                                         |   21 +
 drivers/edac/skx_common.h                                         |    4 
 drivers/firmware/turris-mox-rwtm.c                                |   23 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                        |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c                           |    7 
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c                            |   12 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                 |    9 
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c                  |    3 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c               |   57 +--
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c               |   14 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c             |    7 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c                    |    4 
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c                 |    5 
 drivers/gpu/drm/drm_client_modeset.c                              |    5 
 drivers/gpu/drm/drm_dp_mst_topology.c                             |    4 
 drivers/gpu/drm/etnaviv/etnaviv_gem.c                             |    6 
 drivers/gpu/drm/gma500/cdv_intel_lvds.c                           |    3 
 drivers/gpu/drm/gma500/psb_intel_lvds.c                           |    3 
 drivers/gpu/drm/i915/display/intel_dp.c                           |    2 
 drivers/gpu/drm/i915/gem/i915_gem_mman.c                          |   53 ++
 drivers/gpu/drm/i915/gt/intel_execlists_submission.c              |    6 
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c                           |   17 
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h                       |    6 
 drivers/gpu/drm/mediatek/mtk_drm_plane.c                          |    4 
 drivers/gpu/drm/meson/meson_drv.c                                 |   37 -
 drivers/gpu/drm/mgag200/mgag200_i2c.c                             |    2 
 drivers/gpu/drm/nouveau/nouveau_prime.c                           |    3 
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c                    |    8 
 drivers/gpu/drm/panfrost/panfrost_drv.c                           |    1 
 drivers/gpu/drm/qxl/qxl_display.c                                 |    3 
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c                             |   17 
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c                           |    2 
 drivers/hid/wacom_wac.c                                           |    3 
 drivers/hwmon/adt7475.c                                           |    2 
 drivers/hwmon/max6697.c                                           |    5 
 drivers/hwtracing/coresight/coresight-platform.c                  |    4 
 drivers/i2c/i2c-smbus.c                                           |   64 +++
 drivers/infiniband/core/cache.c                                   |   14 
 drivers/infiniband/core/device.c                                  |    6 
 drivers/infiniband/core/iwcm.c                                    |   11 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                          |    8 
 drivers/infiniband/hw/bnxt_re/qplib_fp.h                          |    6 
 drivers/infiniband/hw/hns/hns_roce_device.h                       |    4 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                        |    6 
 drivers/infiniband/hw/hns/hns_roce_mr.c                           |    5 
 drivers/infiniband/hw/hns/hns_roce_srq.c                          |    2 
 drivers/infiniband/hw/mlx4/alias_GUID.c                           |    2 
 drivers/infiniband/hw/mlx4/mad.c                                  |    2 
 drivers/infiniband/hw/mlx5/mlx5_ib.h                              |   13 
 drivers/infiniband/hw/mlx5/odp.c                                  |    6 
 drivers/infiniband/sw/rxe/rxe_req.c                               |    7 
 drivers/input/keyboard/qt1050.c                                   |    7 
 drivers/input/mouse/elan_i2c_core.c                               |    2 
 drivers/iommu/sprd-iommu.c                                        |    2 
 drivers/irqchip/irq-imx-irqsteer.c                                |   40 +-
 drivers/irqchip/irq-mbigen.c                                      |   20 -
 drivers/irqchip/irq-meson-gpio.c                                  |   35 +
 drivers/irqchip/irq-xilinx-intc.c                                 |    2 
 drivers/isdn/hardware/mISDN/hfcmulti.c                            |    7 
 drivers/leds/led-class.c                                          |    1 
 drivers/leds/led-triggers.c                                       |   75 ++-
 drivers/leds/leds-ss4200.c                                        |    7 
 drivers/leds/trigger/ledtrig-timer.c                              |    5 
 drivers/macintosh/therm_windtunnel.c                              |    2 
 drivers/md/md.c                                                   |    1 
 drivers/md/raid5.c                                                |   20 -
 drivers/media/i2c/imx412.c                                        |    9 
 drivers/media/pci/saa7134/saa7134-dvb.c                           |    8 
 drivers/media/platform/qcom/venus/vdec.c                          |    3 
 drivers/media/platform/vsp1/vsp1_histo.c                          |   20 -
 drivers/media/platform/vsp1/vsp1_pipe.h                           |    2 
 drivers/media/platform/vsp1/vsp1_rpf.c                            |    8 
 drivers/media/rc/imon.c                                           |    5 
 drivers/media/rc/lirc_dev.c                                       |    4 
 drivers/media/usb/uvc/uvc_ctrl.c                                  |    9 
 drivers/media/usb/uvc/uvc_video.c                                 |   47 ++
 drivers/memory/Kconfig                                            |    2 
 drivers/mfd/Makefile                                              |    6 
 drivers/mfd/omap-usb-tll.c                                        |    3 
 drivers/mfd/rsmu_core.c                                           |    2 
 drivers/mtd/nand/raw/Kconfig                                      |    3 
 drivers/mtd/tests/Makefile                                        |   34 -
 drivers/mtd/tests/mtd_test.c                                      |    9 
 drivers/mtd/ubi/eba.c                                             |    3 
 drivers/net/bonding/bond_main.c                                   |    7 
 drivers/net/dsa/b53/b53_common.c                                  |    3 
 drivers/net/dsa/bcm_sf2.c                                         |    4 
 drivers/net/dsa/mv88e6xxx/chip.c                                  |    3 
 drivers/net/ethernet/brocade/bna/bna_types.h                      |    2 
 drivers/net/ethernet/brocade/bna/bnad.c                           |   11 
 drivers/net/ethernet/freescale/fec_main.c                         |   52 +-
 drivers/net/ethernet/freescale/fec_ptp.c                          |    3 
 drivers/net/ethernet/google/gve/gve_tx_dqo.c                      |   22 +
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c                   |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c              |    7 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_atcam.c          |   18 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c   |   38 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c            |   13 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.h           |    9 
 drivers/net/ethernet/realtek/r8169_main.c                         |    8 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c                 |    2 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c               |    2 
 drivers/net/ethernet/stmicro/stmmac/hwif.h                        |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                 |    6 
 drivers/net/netconsole.c                                          |    2 
 drivers/net/usb/qmi_wwan.c                                        |    1 
 drivers/net/usb/sr9700.c                                          |   11 
 drivers/net/wireless/ath/ath11k/dp_rx.c                           |    3 
 drivers/net/wireless/ath/ath11k/dp_rx.h                           |    3 
 drivers/net/wireless/ath/ath11k/mac.c                             |   15 
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c    |   18 
 drivers/net/wireless/marvell/mwifiex/cfg80211.c                   |    2 
 drivers/net/wireless/virt_wifi.c                                  |   20 -
 drivers/nvme/host/pci.c                                           |   91 ++--
 drivers/parport/procfs.c                                          |   24 -
 drivers/pci/controller/dwc/pcie-designware-host.c                 |    7 
 drivers/pci/controller/dwc/pcie-dw-rockchip.c                     |    2 
 drivers/pci/controller/pci-hyperv.c                               |    4 
 drivers/pci/controller/pcie-rockchip.c                            |    2 
 drivers/pci/endpoint/functions/pci-epf-vntb.c                     |   12 
 drivers/pci/pci.c                                                 |   19 -
 drivers/pci/setup-bus.c                                           |    6 
 drivers/phy/cadence/phy-cadence-torrent.c                         |    3 
 drivers/pinctrl/core.c                                            |   12 
 drivers/pinctrl/freescale/pinctrl-mxs.c                           |    4 
 drivers/pinctrl/pinctrl-rockchip.c                                |   17 
 drivers/pinctrl/pinctrl-single.c                                  |    7 
 drivers/pinctrl/ti/pinctrl-ti-iodelay.c                           |   14 
 drivers/platform/chrome/cros_ec_debugfs.c                         |    1 
 drivers/platform/chrome/cros_ec_proto.c                           |    2 
 drivers/platform/mips/cpu_hwmon.c                                 |    3 
 drivers/power/supply/axp288_charger.c                             |   22 -
 drivers/power/supply/bq24190_charger.c                            |    2 
 drivers/pwm/pwm-stm32.c                                           |    5 
 drivers/remoteproc/imx_rproc.c                                    |   10 
 drivers/remoteproc/stm32_rproc.c                                  |    2 
 drivers/rtc/interface.c                                           |    9 
 drivers/rtc/rtc-cmos.c                                            |   10 
 drivers/rtc/rtc-isl1208.c                                         |   11 
 drivers/s390/char/sclp_sd.c                                       |   10 
 drivers/scsi/mpi3mr/mpi3mr_os.c                                   |   11 
 drivers/scsi/mpt3sas/mpt3sas_base.c                               |   20 -
 drivers/scsi/qla2xxx/qla_bsg.c                                    |   98 +++--
 drivers/scsi/qla2xxx/qla_def.h                                    |    3 
 drivers/scsi/qla2xxx/qla_gs.c                                     |   35 +
 drivers/scsi/qla2xxx/qla_init.c                                   |   87 +++-
 drivers/scsi/qla2xxx/qla_inline.h                                 |    8 
 drivers/scsi/qla2xxx/qla_mid.c                                    |    2 
 drivers/scsi/qla2xxx/qla_nvme.c                                   |    5 
 drivers/scsi/qla2xxx/qla_os.c                                     |    7 
 drivers/scsi/qla2xxx/qla_sup.c                                    |  108 +++--
 drivers/scsi/ufs/ufshcd.c                                         |   11 
 drivers/soc/qcom/pdr_interface.c                                  |    8 
 drivers/soc/qcom/rpmh-rsc.c                                       |    7 
 drivers/soc/qcom/rpmh.c                                           |    1 
 drivers/soc/xilinx/zynqmp_pm_domains.c                            |   16 
 drivers/soc/xilinx/zynqmp_power.c                                 |    5 
 drivers/spi/spi-fsl-lpspi.c                                       |    6 
 drivers/spi/spidev.c                                              |   95 ++---
 drivers/tty/serial/serial_core.c                                  |    8 
 drivers/usb/gadget/function/u_audio.c                             |   42 +-
 drivers/usb/gadget/function/u_serial.c                            |    1 
 drivers/usb/gadget/udc/core.c                                     |   10 
 drivers/usb/serial/usb_debug.c                                    |    7 
 drivers/usb/usbip/vhci_hcd.c                                      |    9 
 drivers/vhost/vdpa.c                                              |    8 
 drivers/vhost/vsock.c                                             |    4 
 fs/binfmt_flat.c                                                  |    4 
 fs/btrfs/ctree.h                                                  |    1 
 fs/btrfs/file.c                                                   |   60 ++-
 fs/btrfs/free-space-cache.c                                       |    1 
 fs/ceph/super.c                                                   |    3 
 fs/exec.c                                                         |    8 
 fs/ext2/balloc.c                                                  |   11 
 fs/ext4/extents.c                                                 |    5 
 fs/ext4/extents_status.c                                          |   16 
 fs/ext4/extents_status.h                                          |    6 
 fs/ext4/fast_commit.c                                             |   65 ++-
 fs/ext4/inline.c                                                  |    6 
 fs/ext4/inode.c                                                   |  115 +++---
 fs/ext4/mballoc.c                                                 |    3 
 fs/ext4/namei.c                                                   |   88 +++-
 fs/ext4/xattr.c                                                   |    6 
 fs/f2fs/inline.c                                                  |    6 
 fs/f2fs/inode.c                                                   |    3 
 fs/file.c                                                         |    1 
 fs/fuse/inode.c                                                   |   24 +
 fs/hfs/inode.c                                                    |    3 
 fs/hfsplus/bfind.c                                                |   15 
 fs/hfsplus/extents.c                                              |    9 
 fs/hfsplus/hfsplus_fs.h                                           |   21 +
 fs/jbd2/commit.c                                                  |    2 
 fs/jbd2/journal.c                                                 |    6 
 fs/jfs/jfs_imap.c                                                 |    5 
 fs/nfs/nfs4client.c                                               |    6 
 fs/nfs/nfs4proc.c                                                 |    2 
 fs/nilfs2/btnode.c                                                |   25 +
 fs/nilfs2/btree.c                                                 |    4 
 fs/nilfs2/segment.c                                               |    2 
 fs/ntfs3/attrib.c                                                 |   14 
 fs/ntfs3/bitmap.c                                                 |    2 
 fs/ntfs3/dir.c                                                    |    3 
 fs/ntfs3/file.c                                                   |    5 
 fs/ntfs3/frecord.c                                                |    2 
 fs/ntfs3/fslog.c                                                  |    5 
 fs/ntfs3/fsntfs.c                                                 |    2 
 fs/ntfs3/index.c                                                  |    4 
 fs/ntfs3/inode.c                                                  |    2 
 fs/ntfs3/ntfs.h                                                   |   13 
 fs/ntfs3/ntfs_fs.h                                                |    2 
 fs/proc/proc_sysctl.c                                             |    6 
 fs/proc/task_mmu.c                                                |    2 
 fs/super.c                                                        |   11 
 fs/udf/balloc.c                                                   |   51 +-
 fs/udf/super.c                                                    |    3 
 fs/xfs/xfs_log_recover.c                                          |   20 -
 include/asm-generic/vmlinux.lds.h                                 |    2 
 include/linux/clocksource.h                                       |   14 
 include/linux/hugetlb.h                                           |    1 
 include/linux/irq.h                                               |    7 
 include/linux/irqdomain.h                                         |   10 
 include/linux/jbd2.h                                              |    5 
 include/linux/leds.h                                              |   32 -
 include/linux/objagg.h                                            |    1 
 include/linux/pci_ids.h                                           |    2 
 include/linux/perf_event.h                                        |    1 
 include/linux/profile.h                                           |    1 
 include/linux/sched/signal.h                                      |    6 
 include/linux/task_work.h                                         |    3 
 include/linux/trace_events.h                                      |    1 
 include/linux/virtio_net.h                                        |   11 
 include/net/netfilter/nf_tables.h                                 |   20 -
 include/net/sctp/sctp.h                                           |    4 
 include/net/sctp/structs.h                                        |    8 
 include/net/tcp.h                                                 |    1 
 include/trace/events/mptcp.h                                      |    2 
 include/trace/events/rpcgss.h                                     |    2 
 include/uapi/linux/netfilter/nf_tables.h                          |    2 
 include/uapi/linux/zorro_ids.h                                    |    3 
 io_uring/io-wq.c                                                  |   10 
 io_uring/io_uring.c                                               |    5 
 kernel/bpf/btf.c                                                  |   10 
 kernel/debug/kdb/kdb_io.c                                         |    6 
 kernel/dma/mapping.c                                              |    2 
 kernel/events/core.c                                              |   79 ++--
 kernel/events/internal.h                                          |    2 
 kernel/events/ring_buffer.c                                       |    4 
 kernel/irq/chip.c                                                 |   32 +
 kernel/irq/irqdesc.c                                              |    1 
 kernel/irq/irqdomain.c                                            |    7 
 kernel/irq/manage.c                                               |    2 
 kernel/kcov.c                                                     |   15 
 kernel/kprobes.c                                                  |    4 
 kernel/locking/rwsem.c                                            |    6 
 kernel/padata.c                                                   |    7 
 kernel/profile.c                                                  |   16 
 kernel/rcu/rcutorture.c                                           |    2 
 kernel/sched/core.c                                               |   50 +-
 kernel/sched/cputime.c                                            |    6 
 kernel/sched/fair.c                                               |   19 -
 kernel/sched/sched.h                                              |    2 
 kernel/signal.c                                                   |    8 
 kernel/task_work.c                                                |   34 +
 kernel/time/clocksource-wdtest.c                                  |   13 
 kernel/time/clocksource.c                                         |   10 
 kernel/time/ntp.c                                                 |    9 
 kernel/time/tick-broadcast.c                                      |   24 +
 kernel/time/timekeeping.c                                         |    2 
 kernel/trace/tracing_map.c                                        |    6 
 kernel/watchdog_hld.c                                             |   11 
 lib/decompress_bunzip2.c                                          |    3 
 lib/kobject_uevent.c                                              |   17 
 lib/objagg.c                                                      |   18 
 mm/hugetlb.c                                                      |    2 
 mm/mempolicy.c                                                    |   18 
 mm/mmap_lock.c                                                    |  175 +--------
 net/bluetooth/l2cap_core.c                                        |    1 
 net/bridge/br_multicast.c                                         |    4 
 net/core/filter.c                                                 |   15 
 net/core/link_watch.c                                             |    4 
 net/core/rtnetlink.c                                              |   69 +--
 net/core/xdp.c                                                    |    4 
 net/ipv4/esp4.c                                                   |    3 
 net/ipv4/netfilter/iptable_nat.c                                  |   18 
 net/ipv4/nexthop.c                                                |    7 
 net/ipv4/route.c                                                  |    2 
 net/ipv4/tcp.c                                                    |   13 
 net/ipv4/tcp_input.c                                              |   34 +
 net/ipv4/tcp_ipv4.c                                               |   19 -
 net/ipv4/tcp_output.c                                             |    2 
 net/ipv4/tcp_timer.c                                              |   10 
 net/ipv6/addrconf.c                                               |    3 
 net/ipv6/esp6.c                                                   |    3 
 net/ipv6/ndisc.c                                                  |   34 -
 net/ipv6/netfilter/ip6table_nat.c                                 |   14 
 net/ipv6/tcp_ipv6.c                                               |   19 -
 net/iucv/af_iucv.c                                                |    4 
 net/l2tp/l2tp_core.c                                              |   15 
 net/mac80211/cfg.c                                                |   21 -
 net/mptcp/mib.c                                                   |    2 
 net/mptcp/mib.h                                                   |    2 
 net/mptcp/options.c                                               |    5 
 net/mptcp/pm.c                                                    |    9 
 net/mptcp/pm_netlink.c                                            |   48 +-
 net/mptcp/protocol.c                                              |   18 
 net/mptcp/protocol.h                                              |    4 
 net/mptcp/subflow.c                                               |   24 +
 net/netfilter/ipset/ip_set_list_set.c                             |    3 
 net/netfilter/ipvs/ip_vs_proto_sctp.c                             |    4 
 net/netfilter/nf_conntrack_netlink.c                              |    3 
 net/netfilter/nf_tables_api.c                                     |  188 +---------
 net/netfilter/nft_connlimit.c                                     |    4 
 net/netfilter/nft_counter.c                                       |    4 
 net/netfilter/nft_dynset.c                                        |    2 
 net/netfilter/nft_last.c                                          |    4 
 net/netfilter/nft_limit.c                                         |   14 
 net/netfilter/nft_quota.c                                         |    4 
 net/netfilter/nft_set_hash.c                                      |    8 
 net/netfilter/nft_set_pipapo.c                                    |   40 +-
 net/netfilter/nft_set_pipapo.h                                    |   27 +
 net/netfilter/nft_set_pipapo_avx2.c                               |   81 ++--
 net/netfilter/nft_set_rbtree.c                                    |    6 
 net/packet/af_packet.c                                            |   86 ++++
 net/sched/act_ct.c                                                |    4 
 net/sctp/input.c                                                  |   46 +-
 net/sctp/proc.c                                                   |   10 
 net/sctp/socket.c                                                 |    6 
 net/smc/smc_core.c                                                |    5 
 net/sunrpc/auth_gss/gss_krb5_keys.c                               |    2 
 net/sunrpc/clnt.c                                                 |    3 
 net/sunrpc/sched.c                                                |    4 
 net/sunrpc/xprtrdma/frwr_ops.c                                    |    3 
 net/sunrpc/xprtrdma/verbs.c                                       |   16 
 net/tipc/udp_media.c                                              |    5 
 net/tls/tls_sw.c                                                  |   16 
 net/wireless/nl80211.c                                            |   16 
 net/wireless/util.c                                               |    8 
 scripts/gcc-x86_32-has-stack-protector.sh                         |    2 
 scripts/gcc-x86_64-has-stack-protector.sh                         |    2 
 security/apparmor/lsm.c                                           |    7 
 security/apparmor/policy.c                                        |    2 
 security/apparmor/policy_unpack.c                                 |    1 
 security/keys/keyctl.c                                            |    2 
 security/landlock/cred.c                                          |   11 
 sound/firewire/amdtp-stream.c                                     |   38 +-
 sound/firewire/amdtp-stream.h                                     |    1 
 sound/pci/hda/patch_conexant.c                                    |   54 --
 sound/pci/hda/patch_hdmi.c                                        |    2 
 sound/pci/hda/patch_realtek.c                                     |    1 
 sound/soc/codecs/max98088.c                                       |   10 
 sound/soc/codecs/wcd938x-sdw.c                                    |    4 
 sound/soc/codecs/wsa881x.c                                        |    2 
 sound/soc/intel/common/soc-intel-quirks.h                         |    2 
 sound/soc/meson/axg-fifo.c                                        |   26 -
 sound/soc/pxa/spitz.c                                             |   58 +--
 sound/usb/line6/driver.c                                          |    5 
 sound/usb/mixer.c                                                 |    7 
 sound/usb/quirks-table.h                                          |    4 
 sound/usb/quirks.c                                                |    4 
 sound/usb/stream.c                                                |    4 
 tools/lib/bpf/btf_dump.c                                          |    8 
 tools/lib/bpf/linker.c                                            |   11 
 tools/memory-model/lock.cat                                       |   20 -
 tools/perf/arch/x86/util/intel-pt.c                               |   15 
 tools/perf/util/sort.c                                            |    2 
 tools/testing/selftests/bpf/prog_tests/send_signal.c              |    3 
 tools/testing/selftests/bpf/prog_tests/sk_lookup.c                |    2 
 tools/testing/selftests/bpf/progs/btf_dump_test_case_multidim.c   |    4 
 tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c     |    4 
 tools/testing/selftests/bpf/test_sockmap.c                        |    9 
 tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh |   55 ++
 tools/testing/selftests/landlock/base_test.c                      |   74 +++
 tools/testing/selftests/landlock/config                           |    5 
 tools/testing/selftests/net/forwarding/devlink_lib.sh             |    2 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                   |   41 ++
 tools/testing/selftests/rcutorture/bin/torture.sh                 |    6 
 tools/testing/selftests/sigaltstack/current_stack_pointer.h       |    2 
 461 files changed, 4183 insertions(+), 2519 deletions(-)

Adrian Hunter (7):
      perf/x86/intel/pt: Fix pt_topa_entry_for_page() address calculation
      perf: Fix perf_aux_size() for greater-than 32-bit size
      perf: Prevent passing zero nr_pages to rb_alloc_aux()
      perf: Fix default aux_watermark calculation
      perf intel-pt: Fix aux_watermark calculation for 64-bit size
      perf intel-pt: Fix exclude_guest setting
      perf/x86/intel/pt: Fix a topa_entry base address calculation

Al Viro (3):
      powerpc: fix a file leak in kvm_vcpu_ioctl_enable_cap()
      lirc: rc_dev_get_from_fd(): fix file leak
      protect the fetch of ->fd[fd] in do_dup2() from mispredictions

Alan Maguire (2):
      bpf: annotate BTF show functions with __printf
      bpf: Eliminate remaining "make W=1" warnings in kernel/bpf/btf.o

Alan Stern (1):
      tools/memory-model: Fix bug in lock.cat

Aleksandr Burakov (1):
      saa7134: Unchecked i2c_transfer function result fixed

Aleksandr Mishin (2):
      remoteproc: imx_rproc: Skip over memory region when node value is NULL
      remoteproc: imx_rproc: Fix refcount mistake in imx_rproc_addr_init

Alex Deucher (1):
      drm/amdgpu/sdma5.2: Update wptr registers as well as doorbell

Alex Hung (1):
      drm/amd/display: Add null checker before passing variables

Alexander Maltsev (1):
      netfilter: ipset: Add list flush to cancel_gc

Alexandra Winter (1):
      net/iucv: fix use after free in iucv_sock_close()

Alexey Kodanev (1):
      bna: adjust 'name' buf size of bna_tcb and bna_ccb structures

Amit Cohen (2):
      mlxsw: spectrum_acl_bloom_filter: Make mlxsw_sp_acl_bf_key_encode() more flexible
      selftests: forwarding: devlink_lib: Wait for udev events after reloading

Amit Daniel Kachhap (1):
      arm64: cpufeature: Fix the visibility of compat hwcaps

Andi Kleen (1):
      x86/mtrr: Check if fixed MTRRs exist before saving them

Andi Shyti (1):
      drm/i915/gem: Fix Virtual Memory mapping boundaries calculation

Andreas Larsson (1):
      sparc64: Fix incorrect function signature and add prototype for prom_cif_init

Andrei Lalaev (1):
      Input: qt1050 - handle CHIP_ID reading error

Andrey Konovalov (1):
      kcov: properly check for softirq context

Andrii Nakryiko (1):
      libbpf: Fix no-args func prototype BTF dumping syntax

Andy Shevchenko (2):
      spi: spidev: Replace ACPI specific code by device_get_match_data()
      spi: spidev: Replace OF specific code by device property API

Arnd Bergmann (5):
      EDAC, i10nm: make skx_common.o a separate module
      ARM: pxa: spitz: use gpio descriptors for audio
      mfd: rsmu: Split core code into separate module
      mtd: make mtd_test.c a separate module
      kdb: address -Wformat-security warnings

Arseniy Krasnov (1):
      irqchip/meson-gpio: Convert meson_gpio_irq_controller::lock to 'raw_spinlock_t'

Artem Chernyshev (1):
      iommu: sprd: Avoid NULL deref in sprd_iommu_hw_en

Bailey Forrest (1):
      gve: Fix an edge case for TSO skb validity check

Baochen Qiang (3):
      wifi: ath11k: fix wrong handling of CCMP256 and GCMP ciphers
      wifi: cfg80211: fix typo in cfg80211_calculate_bitrate_he()
      wifi: cfg80211: handle 2x996 RU allocation in cfg80211_calculate_bitrate_he()

Baokun Li (3):
      ext4: check dot and dotdot of dx_root before making dir indexed
      ext4: make sure the first directory block is not a hole
      ext4: make ext4_es_insert_extent() return void

Bart Van Assche (1):
      RDMA/iwcm: Fix a use-after-free related to destroying CM IDs

Bastien Curutchet (1):
      clk: davinci: da8xx-cfgchip: Initialize clk_init_data before use

Benjamin Coddington (2):
      SUNRPC: Fixup gss_status tracepoint error output
      SUNRPC: Fix a race to wake a sync task

Besar Wicaksono (1):
      arm64: Add Neoverse-V2 part

Binbin Zhou (1):
      MIPS: Loongson64: DTS: Add RTC support to Loongson-2K1000

Breno Leitao (1):
      net: netconsole: Disable target before netpoll cleanup

Bryan O'Donoghue (1):
      media: i2c: Fix imx412 exposure control

Carlos Llamas (1):
      binder: fix hang of unregistered readers

Chao Yu (4):
      f2fs: fix return value of f2fs_convert_inline_inode()
      f2fs: fix to don't dirty inode for readonly filesystem
      hfsplus: fix to avoid false alarm of circular locking
      hfs: fix to initialize fields of hfs_inode_info after hfs_alloc_inode()

Chen Ni (3):
      x86/xen: Convert comma to semicolon
      drm/qxl: Add check for drm_cvt_mode
      ASoC: max98088: Check for clk_prepare_enable() error

Chen-Yu Tsai (2):
      arm64: dts: mediatek: mt8183-kukui: Drop bogus output-enable property
      arm64: dts: mediatek: mt8183-kukui-jacuzzi: Add ports node for anx7625

Chengchang Tang (3):
      RDMA/hns: Fix missing pagesize and alignment check in FRMR
      RDMA/hns: Fix undifined behavior caused by invalid max_sge
      RDMA/hns: Fix insufficient extend DB for VFs.

Chengen Du (1):
      af_packet: Handle outgoing VLAN packets without hardware offloading

Chiara Meiohas (1):
      RDMA/mlx5: Set mkeys for dmabuf at PAGE_SIZE

Chris Wulff (2):
      usb: gadget: core: Check for unset descriptor
      usb: gadget: u_audio: Check return codes from usb_ep_enable and config_ep_by_speed.

Christoph Hellwig (2):
      block: initialize integrity buffer to zero before writing it to media
      xfs: fix log recovery buffer allocation for the legacy h_size fixup

Christophe Leroy (1):
      vmlinux.lds.h: catch .bss..L* sections into BSS")

Chuck Lever (1):
      xprtrdma: Fix rpcrdma_reqs_reset()

Conor Dooley (1):
      spi: spidev: add correct compatible for Rohm BH2228FV

Csókás Bence (1):
      net: fec: Refactor: #define magic constants

Csókás, Bence (3):
      net: fec: Fix FEC_ECR_EN1588 being cleared on link-down
      rtc: interface: Add RTC offset to alarm after fix-up
      net: fec: Stop PPS on driver remove

Damien Le Moal (2):
      scsi: mpt3sas: Avoid IOMMU page faults on REPORT ZONES
      scsi: mpi3mr: Avoid IOMMU page faults on REPORT ZONES

Dan Carpenter (3):
      PCI: endpoint: Clean up error handling in vpci_scan_bus()
      mISDN: Fix a use after free in hfcmulti_tx()
      net: mvpp2: Don't re-use loop iterator

Dan Williams (1):
      driver core: Fix uevent_show() vs driver detach race

Daniel Schaefer (1):
      media: uvcvideo: Override default flags

Daniele Palmas (1):
      net: usb: qmi_wwan: fix memory leak for not ip packets

Danilo Krummrich (1):
      drm/nouveau: prime: fix refcount underflow

David Hildenbrand (1):
      fs/proc/task_mmu: indicate PM_FILE for PMD-mapped file THP

Denis Arefev (1):
      net: missing check virtio

Dikshita Agarwal (2):
      media: venus: flush all buffers in output plane streamoff
      media: venus: fix use after free in vdec_close

Dmitry Antipov (1):
      Bluetooth: l2cap: always unlock channel in l2cap_conless_channel()

Dmitry Baryshkov (8):
      arm64: dts: qcom: sdm845: add power-domain to UFS PHY
      arm64: dts: qcom: sm8250: switch UFS QMP PHY to new style of bindings
      arm64: dts: qcom: sm8250: add power-domain to UFS PHY
      arm64: dts: qcom: msm8996: specify UFS core_clk frequencies
      soc: qcom: pdr: protect locator_addr with the main mutex
      soc: qcom: pdr: fix parsing of domains lists
      arm64: dts: qcom: msm8998: switch USB QMP PHY to new style of bindings
      arm64: dts: qcom: msm8996: correct #clock-cells for QMP PHY nodes

Dmitry Torokhov (2):
      ARM: spitz: fix GPIO assignment for backlight
      Input: elan_i2c - do not leave interrupt disabled on suspend failure

Dmitry Yashin (1):
      pinctrl: rockchip: update rk3308 iomux routes

Dominique Martinet (1):
      MIPS: Octeron: remove source file executable bit

Donglin Peng (1):
      libbpf: Checking the btf_type kind when fixing variable offsets

Douglas Anderson (3):
      drm/panel: boe-tv101wum-nl6: If prepare fails, disable GPIO before regulators
      drm/panel: boe-tv101wum-nl6: Check for errors on the NOP in prepare()
      kdb: Use the passed prompt in kdb_position_cursor()

Dragan Simic (1):
      drm/panfrost: Mark simple_ondemand governor as softdep

Edmund Raile (2):
      Revert "ALSA: firewire-lib: obsolete workqueue for period update"
      Revert "ALSA: firewire-lib: operate for period elapse event in process context"

Eero Tamminen (1):
      m68k: atari: Fix TT bootup freeze / unexpected (SCU) interrupt messages

En-Wei Wu (1):
      wifi: virt_wifi: avoid reporting connection success with wrong SSID

Eric Dumazet (8):
      tcp: annotate lockless accesses to sk->sk_err_soft
      tcp: annotate lockless access to sk->sk_err
      tcp: add tcp_done_with_error() helper
      tcp: fix race in tcp_write_err()
      tcp: fix races in tcp_v[46]_err()
      sched: act_ct: take care of padding in struct zones_ht_key
      net: linkwatch: use system_unbound_wq
      wifi: cfg80211: restrict NL80211_ATTR_TXQ_QUANTUM values

Eric Sandeen (1):
      fuse: verify {g,u}id mount options correctly

Esben Haabendal (2):
      memory: fsl_ifc: Make FSL_IFC config visible and selectable
      powerpc/configs: Update defconfig with now user-visible CONFIG_FSL_IFC

FUJITA Tomonori (1):
      PCI: Add Edimax Vendor ID to pci_ids.h

Fedor Pchelkin (2):
      apparmor: use kvfree_sensitive to free data->data
      ubi: eba: properly rollback inside self_check_eba

Feng Tang (1):
      clocksource: Scale the watchdog read retries automatically

Filipe Manana (3):
      btrfs: fix bitmap leak when loading free space cache on duplicate entry
      btrfs: fix corruption after buffer fault in during direct IO append write
      btrfs: fix double inode unlock for direct IO sync writes

Florent Fourcot (1):
      rtnetlink: enable alt_ifname for setlink/newlink

Florian Westphal (5):
      netfilter: nft_set_pipapo: constify lookup fn args where possible
      netfilter: nf_set_pipapo: fix initial map fill
      netfilter: nft_set_pipapo_avx2: disable softinterrupts
      netfilter: nf_tables: allow clone callbacks to sleep
      netfilter: nf_tables: prefer nft_chain_validate

Fred Li (1):
      bpf: Fix a segment issue when downgrading gso_size

Frederic Weisbecker (4):
      task_work: s/task_work_cancel()/task_work_cancel_func()/
      task_work: Introduce task_work_cancel() again
      perf: Fix event leak upon exit
      perf: Fix event leak upon exec and file release

Friedrich Vock (1):
      drm/amdgpu: Check if NBIO funcs are NULL in amdgpu_device_baco_exit

Gaosheng Cui (1):
      gss_krb5: Fix the error handling path for crypto_sync_skcipher_setkey

Geert Uytterhoeven (1):
      spi: spidev: Add missing spi_device_id for bh2228fv

Geliang Tang (4):
      selftests/bpf: Fix prog numbers in test_sockmap
      selftests/bpf: Check length of recv in test_sockmap
      selftests/bpf: Close fd in error path in drop_on_reuseport
      mptcp: export local_address

George Kennedy (1):
      serial: core: check uartclk for zero to avoid divide by zero

Greg Kroah-Hartman (1):
      Linux 5.15.165

Gregory CLEMENT (1):
      MIPS: SMP-CPS: Fix address for GCR_ACCESS register for CM3 and later

Guangguan Wang (1):
      net/smc: set rmb's SG_MAX_SINGLE_ALLOC limitation only when CONFIG_ARCH_NO_SG_CHAIN is defined

Guenter Roeck (4):
      hwmon: (max6697) Fix underflow when writing limit attributes
      hwmon: (max6697) Fix swapped temp{1,8} critical alarms
      i2c: smbus: Improve handling of stuck alerts
      i2c: smbus: Send alert notifications to all devices if source not found

Gwenael Treuveur (1):
      remoteproc: stm32_rproc: Fix mailbox interrupts queuing

Hagar Hemdan (1):
      net: esp: cleanup esp_output_tail_tcp() in case of unsupported ESPINTCP

Hans de Goede (4):
      leds: trigger: Unregister sysfs attributes before calling deactivate()
      leds: trigger: Call synchronize_rcu() before calling trig->activate()
      power: supply: axp288_charger: Fix constant_charge_voltage writes
      power: supply: axp288_charger: Round constant_charge_voltage writes down

Heiner Kallweit (3):
      leds: trigger: Remove unused function led_trigger_rename_static()
      leds: trigger: Store brightness set by led_trigger_event()
      r8169: don't increment tx_dropped in case of NETDEV_TX_BUSY

Herve Codina (1):
      irqdomain: Fixed unbalanced fwnode get and put

Hilda Wu (1):
      Bluetooth: btusb: Add RTL8852BE device 0489:e125 to device tables

Honggang LI (1):
      RDMA/rxe: Don't set BTH_ACK_MASK for UC or UD QPs

Hou Tao (1):
      bpf, events: Use prog to emit ksymbol event for main program

Hsiao Chien Sung (2):
      drm/mediatek: Add missing plane settings when async update
      drm/mediatek: Add DRM_MODE_ROTATE_0 to rotation property

Huacai Chen (1):
      fs/ntfs3: Update log->page_{mask,bits} if log->page_size changed

Ian Forbes (1):
      drm/vmwgfx: Fix overlay when using Screen Targets

Ido Schimmel (4):
      lib: objagg: Fix general protection fault
      mlxsw: spectrum_acl_erp: Fix object nesting warning
      mlxsw: spectrum_acl: Fix ACL scale regression and firmware errors
      ipv4: Fix incorrect source address in Record Route option

Igor Pylypiv (1):
      ata: libata-scsi: Honor the D_SENSE bit for CK_COND=1 and no error

Ilpo Järvinen (7):
      x86/of: Return consistent error type from x86_of_pci_irq_enable()
      x86/pci/intel_mid_pci: Fix PCIBIOS_* return code handling
      x86/pci/xen: Fix PCIBIOS_* return code handling
      x86/platform/iosf_mbi: Convert PCIBIOS_* return codes to errnos
      PCI: Fix resource double counting on remove & rescan
      leds: ss4200: Convert PCIBIOS_* return codes to errnos
      hwrng: amd - Convert PCIBIOS_* return codes to errnos

Ilya Dryomov (3):
      rbd: don't assume rbd_is_lock_owner() for exclusive mappings
      rbd: rename RBD_LOCK_STATE_RELEASING and releasing_wait
      rbd: don't assume RBD_LOCK_STATE_LOCKED for exclusive mappings

Imre Deak (1):
      drm/i915/dp: Reset intel_dp->link_trained before retraining the link

Ismael Luceno (1):
      ipvs: Avoid unnecessary calls to skb_is_gso_sctp

Jack Wang (1):
      bnxt_re: Fix imm_data endianness

Jakub Kicinski (1):
      tls: fix race between tx work scheduling and socket close

James Chapman (1):
      l2tp: fix lockdep splat

James Clark (1):
      coresight: Fix ref leak when of_coresight_parse_endpoint() fails

James Morse (1):
      arm64: cpufeature: Force HWCAP to be based on the sysreg visible to user-space

Jan Kara (4):
      ext4: avoid writing unitialized memory to disk in EA inodes
      ext2: Verify bitmap and itable block numbers before using them
      udf: Avoid using corrupted block bitmap buffer
      jbd2: make jbd2_journal_get_max_txn_bufs() internal

Jann Horn (1):
      landlock: Don't lose track of restrictions on cred_transfer

Jason Wang (1):
      vhost-vdpa: switch to use vmf_insert_pfn() in the fault handler

Javier Carrasco (1):
      mfd: omap-usb-tll: Use struct_size to allocate tll

Javier Martinez Canillas (1):
      spi: spidev: Make probe to fail early if a spidev compatible is used

Jay Buddhabhatti (1):
      drivers: soc: xilinx: check return status of get_api_version()

Jens Axboe (2):
      nvme: split command copy into a helper
      nvme: separate command prep and issue

Jeongjun Park (1):
      jfs: Fix array-index-out-of-bounds in diFree

Jerome Brunet (2):
      arm64: dts: amlogic: gx: correct hdmi clocks
      ASoC: meson: axg-fifo: fix irq scheduling issue with PREEMPT_RT

Jiaxun Yang (10):
      platform: mips: cpu_hwmon: Disable driver on unsupported hardware
      MIPS: ip30: ip30-console: Add missing include
      MIPS: dts: loongson: Fix GMAC phy node
      MIPS: Loongson64: env: Hook up Loongsson-2K
      MIPS: Loongson64: Remove memory node for builtin-dtb
      MIPS: Loongson64: reset: Prioritise firmware service
      MIPS: Loongson64: Test register availability before use
      MIPS: Loongson64: DTS: Fix PCIe port nodes for ls7a
      MIPS: dts: loongson: Fix liointc IRQ polarity
      MIPS: dts: loongson: Fix ls2k1000-rtc interrupt

Jinyoung Choi (1):
      block: cleanup bio_integrity_prep

Jisheng Zhang (1):
      PCI: dwc: Restore MSI Receiver mask during resume

Joe Hattori (2):
      char: tpm: Fix possible memory leak in tpm_bios_measurements_open()
      net: dsa: bcm_sf2: Fix a possible memory leak in bcm_sf2_mdio_register()

Johan Hovold (1):
      arm64: dts: qcom: msm8998: drop USB PHY clock index

Johannes Berg (7):
      wifi: virt_wifi: don't use strlen() in const context
      um: time-travel: fix time-travel-start option
      um: time-travel: fix signal blocking race/hang
      net: bonding: correctly annotate RCU in bond_should_notify_peers()
      leds: trigger: use RCU to protect the led_cdevs list
      wifi: nl80211: don't give key data to userspace
      wifi: mac80211: check basic rates validity

John Stultz (1):
      locking/rwsem: Add __always_inline annotation to __down_write_common() and inlined callers

Jonas Karlman (1):
      arm64: dts: rockchip: Increase VOP clk rate on RK3328

Joy Chakraborty (2):
      rtc: cmos: Fix return value of nvmem callbacks
      rtc: isl1208: Fix return value of nvmem callbacks

Justin Stitt (3):
      power: supply: bq24190_charger: replace deprecated strncpy with strscpy
      ntp: Clamp maxerror and esterror to operating range
      ntp: Safeguard against time_constant overflow

Kan Liang (1):
      perf/x86/intel/uncore: Fix the bits of the CHA extended umask for SPR

Kees Cook (2):
      exec: Fix ToCToU between perm check and set-uid/gid usage
      binfmt_flat: Fix corruption when not offsetting data start

Kemeng Shi (2):
      jbd2: avoid memleak in jbd2_journal_write_metadata_buffer
      ext4: fix wrong unit use in ext4_mb_find_by_goal

Konrad Dybcio (1):
      clk: qcom: branch: Add helper functions for setting retain bits

Konstantin Komarov (8):
      fs/ntfs3: Use ALIGN kernel macro
      fs/ntfs3: Merge synonym COMPRESSION_UNIT and NTFS_LZNT_CUNIT
      fs/ntfs3: Fix transform resident to nonresident for compressed files
      fs/ntfs3: Missed NI_FLAG_UPDATE_PARENT setting
      fs/ntfs3: Fix getting file type
      fs/ntfs3: Replace inode_trylock with inode_lock
      fs/ntfs3: Fix field-spanning write in INDEX_HDR
      fs/ntfs3: Missed error return

Krishna Kurapati (2):
      arm64: dts: qcom: msm8998: Disable SS instance in Parkmode for USB
      arm64: dts: qcom: ipq8074: Disable SS instance in Parkmode for USB

Krzysztof Kozlowski (4):
      dt-bindings: thermal: correct thermal zone node name limit
      spi: spidev: order compatibles alphabetically
      ASoC: codecs: wcd938x-sdw: Correct Soundwire ports mask
      ASoC: codecs: wsa881x: Correct Soundwire ports mask

Kuniyuki Iwashima (4):
      rtnetlink: Don't ignore IFLA_TARGET_NETNSID when ifname is specified in rtnl_dellink().
      netfilter: iptables: Fix null-ptr-deref in iptable_nat_table_init().
      netfilter: iptables: Fix potential null-ptr-deref in ip6table_nat_table_init().
      sctp: Fix null-ptr-deref in reuseport_add_sock().

Lance Richardson (1):
      dma: fix call order in dmam_free_coherent

Laurent Pinchart (2):
      media: renesas: vsp1: Fix _irqsave and _irq mix
      media: renesas: vsp1: Store RPF partition configuration per RPF instance

Leon Romanovsky (5):
      RDMA/cache: Release GID table even if leak is detected
      RDMA/mlx4: Fix truncated output warning in mad.c
      RDMA/mlx4: Fix truncated output warning in alias_GUID.c
      RDMA/device: Return error earlier if port in not valid
      nvme-pci: add missing condition check for existence of mapped data

Li Nan (1):
      md: do not delete safemode_timer in mddev_suspend

Lijo Lazar (1):
      drm/amd/pm: Fix aldebaran pcie speed reporting

Luca Ceresoli (1):
      Revert "leds: led-core: Fix refcount leak in of_led_get()"

Lucas Stach (4):
      drm/etnaviv: fix DMA direction handling for cached RW buffers
      irqchip/imx-irqsteer: Constify irq_chip struct
      irqchip/imx-irqsteer: Add runtime PM support
      drm/bridge: analogix_dp: properly handle zero sized AUX transactions

Luis Henriques (SUSE) (2):
      ext4: fix infinite loop when replaying fast_commit
      ext4: don't track ranges in fast_commit if inode has inlined data

Lukas Wunner (1):
      PCI/DPC: Fix use-after-free on concurrent DPC and hot-removal

Ma Jun (3):
      drm/amdgpu/pm: Fix the null pointer dereference for smu7
      drm/amdgpu: Fix the null pointer dereference to ras_manager
      drm/amdgpu/pm: Fix the null pointer dereference in apply_state_adjust_rules

Ma Ke (5):
      drm/gma500: fix null pointer dereference in cdv_intel_lvds_get_modes
      drm/gma500: fix null pointer dereference in psb_intel_lvds_get_modes
      phy: cadence-torrent: Check return value on register read
      net: usb: sr9700: fix uninitialized variable use in sr_mdio_read
      drm/client: fix null pointer dereference in drm_client_modeset_probe

Maciej Żenczykowski (1):
      ipv6: fix ndisc_is_useropt() handling for PIO

Mahesh Salgaonkar (1):
      powerpc: Avoid nmi_enter/nmi_exit in real mode interrupt.

Manish Rangankar (1):
      scsi: qla2xxx: During vport delete send async logout explicitly

Manivannan Sadhasivam (1):
      PCI: rockchip: Use GPIOD_OUT_LOW flag while requesting ep_gpio

Marc Zyngier (2):
      genirq: Allow the PM device to originate from irq domain
      genirq: Allow irq_chip registration functions to take a const irq_chip

Marco Cavenati (1):
      perf/x86/intel/pt: Fix topa_entry base length

Marco Felsch (1):
      ARM: dts: imx6qdl-kontron-samx6i: move phy reset into phy-node

Marek Behún (3):
      firmware: turris-mox-rwtm: Do not complete if there are no waiters
      firmware: turris-mox-rwtm: Fix checking return value of wait_for_completion_timeout()
      firmware: turris-mox-rwtm: Initialize completion before mailbox

Marek Marczykowski-Górecki (1):
      USB: serial: debug: do not echo input by default

Mark Rutland (12):
      arm64: barrier: Restore spec_bar() macro
      arm64: cputype: Add Cortex-X4 definitions
      arm64: cputype: Add Neoverse-V3 definitions
      arm64: errata: Add workaround for Arm errata 3194386 and 3312417
      arm64: cputype: Add Cortex-X3 definitions
      arm64: cputype: Add Cortex-A720 definitions
      arm64: cputype: Add Cortex-X925 definitions
      arm64: errata: Unify speculative SSBS errata logic
      arm64: errata: Expand speculative SSBS workaround
      arm64: cputype: Add Cortex-X1C definitions
      arm64: cputype: Add Cortex-A725 definitions
      arm64: errata: Expand speculative SSBS workaround (again)

Martin Willi (2):
      net: dsa: mv88e6xxx: Limit chip-wide frame size config to CPU ports
      net: dsa: b53: Limit chip-wide jumbo frame config to CPU ports

Masami Hiramatsu (Google) (1):
      kprobes: Fix to check symbol prefixes correctly

Matthieu Baerts (NGI0) (8):
      mptcp: sched: check both directions for backup
      mptcp: distinguish rcv vs sent backup flag in requests
      mptcp: mib: count MPJ with backup flag
      mptcp: pm: only set request_bkup flag when sending MP_PRIO
      mptcp: pm: fix backup support in signal endpoints
      selftests: mptcp: join: validate backup in MPJ
      selftests: mptcp: join: check backup support in signal endp
      mptcp: fully established after ADD_ADDR echo on MPJ

Mavroudis Chatzilazaridis (1):
      ALSA: hda/realtek: Add quirk for Acer Aspire E5-574G

Menglong Dong (1):
      bpf: kprobe: remove unused declaring of bpf_kprobe_override

Miaohe Lin (1):
      mm/hugetlb: fix possible recursive locking detected warning

Michael Ellerman (2):
      powerpc/xmon: Fix disassembly CPU feature checks
      selftests/sigaltstack: Fix ppc64 GCC build

Michael S. Tsirkin (1):
      vhost/vsock: always initialize seqpacket_allow

Michael Tretter (1):
      soc: xilinx: move PM_INIT_FINALIZE to zynqmp_pm_domains driver

Michael Walle (5):
      ARM: dts: imx6qdl-kontron-samx6i: fix PHY reset
      ARM: dts: imx6qdl-kontron-samx6i: fix board reset
      ARM: dts: imx6qdl-kontron-samx6i: fix SPI0 chip selects
      ARM: dts: imx6qdl-kontron-samx6i: fix PCIe reset polarity
      ARM: dts: imx6qdl-kontron-samx6i: fix phy-mode

Michal Pecio (1):
      media: uvcvideo: Fix the bandwdith quirk on USB 3.x

Mickaël Salaün (1):
      selftests/landlock: Add cred_transfer test

Namhyung Kim (1):
      perf report: Fix condition in sort__sym_cmp()

Nathan Chancellor (1):
      kbuild: Fix '-S -c' in x86 stack protector scripts

NeilBrown (1):
      SUNRPC: avoid soft lockup when transmitting UDP to reachable server.

Nick Bowler (1):
      macintosh/therm_windtunnel: fix module unload.

Nicolas Dichtel (1):
      ipv6: take care of scope when choosing the src addr

Niklas Cassel (2):
      PCI: dw-rockchip: Fix initial PERST# GPIO value
      Revert "ata: libata-scsi: Honor the D_SENSE bit for CK_COND=1 and no error"

Niklas Söderlund (1):
      clocksource/drivers/sh_cmt: Address race condition for clock events

Nikolay Aleksandrov (1):
      net: bridge: mcast: wait for previous gc cycles when removing port

Nilesh Javali (1):
      scsi: qla2xxx: validate nvme_local_port correctly

Nitesh Shetty (1):
      block: refactor to use helper

Nitin Gote (1):
      drm/i915/gt: Do not consider preemption during execlists_dequeue for gen8

Olga Kornievskaia (1):
      NFSv4.1 another fix for EXCHGID4_FLAG_USE_PNFS_DS for DS server

Oliver Neukum (1):
      usb: vhci-hcd: Do not drop references before new references are gained

Pablo Neira Ayuso (5):
      netfilter: nf_tables: rise cap on SELinux secmark context
      netfilter: ctnetlink: use helper function to calculate expect ID
      netfilter: nf_tables: set element extended ACK reporting support
      netfilter: nf_tables: use timestamp to check for set element timeout
      netfilter: nf_tables: bail out if stateful expression provides no .clone

Paolo Abeni (3):
      mptcp: fix duplicate data handling
      mptcp: fix NL PM announced address accounting
      mptcp: fix bad RCVPRUNED mib accounting

Paolo Pisati (1):
      m68k: amiga: Turn off Warp1260 interrupts during boot

Patryk Duda (1):
      platform/chrome: cros_ec_proto: Lock device when updating MKBP version

Paul E. McKenney (3):
      rcutorture: Fix rcu_torture_fwd_cb_cr() data race
      torture: Enable clocksource watchdog with "tsc=watchdog"
      clocksource: Fix brown-bag boolean thinko in cs_watchdog_read()

Pavel Begunkov (3):
      io_uring: tighten task exit cancellations
      io_uring/io-wq: limit retrying worker initialisation
      kernel: rerun task_work while freezing in get_signal()

Peng Fan (1):
      pinctrl: freescale: mxs: Fix refcount of child

Peter Oberparleiter (1):
      s390/sclp: Prevent release of buffer in I/O

Peter Zijlstra (2):
      x86/mm: Fix pti_clone_pgtable() alignment assumption
      x86/mm: Fix pti_clone_entry_text() for i386

Petr Machata (1):
      net: nexthop: Initialize all fields in dumped nexthops

Pierre Gondois (1):
      sched/fair: Use all little CPUs for CPU-bound workloads

Pierre-Louis Bossart (1):
      ASoC: Intel: use soc_intel_is_byt_cr() only when IOSF_MBI is reachable

Prashanth K (1):
      usb: gadget: u_serial: Set start_delayed during suspend

Qianggui Song (1):
      irqchip/meson-gpio: support more than 8 channels gpio irq

Quinn Tran (3):
      scsi: qla2xxx: Unable to act on RSCN for port online
      scsi: qla2xxx: Use QP lock to search for bsg
      scsi: qla2xxx: Fix flash read failure

Radhey Shyam Pandey (1):
      irqchip/xilinx: Fix shift out of bounds

Rafael Beims (1):
      wifi: mwifiex: Fix interface type change

Rafał Miłecki (1):
      arm64: dts: mediatek: mt7622: fix "emmc" pinctrl mux

Ricardo Ribalda (3):
      media: imon: Fix race getting ictx->lock
      media: uvcvideo: Fix integer overflow calculating timestamp
      media: uvcvideo: Ignore empty TS packets

Ritesh Harjani (1):
      ext4: return early for non-eligible fast_commit track events

Roman Smirnov (1):
      udf: prevent integer overflow in udf_bitmap_free_blocks()

Ross Lagerwall (1):
      decompress_bunzip2: fix rare decompression failure

Ryusuke Konishi (2):
      nilfs2: avoid undefined behavior in nilfs_cnt32_ge macro
      nilfs2: handle inconsistent state in nilfs_btnode_create_block()

Samasth Norway Ananda (1):
      wifi: brcmsmac: LCN PHY code is used for BCM4313 2G-only device

Saurav Kashyap (1):
      scsi: qla2xxx: Return ENOBUFS if sg_cnt is more than one for ELS cmds

Sean Christopherson (1):
      KVM: VMX: Split out the non-virtualization part of vmx_interrupt_blocked()

Sean Young (1):
      media: Revert "media: dvb-usb: Fix unexpected infinite loop in dvb_usb_read_remote_control()"

Seth Forshee (DigitalOcean) (1):
      fs: don't allow non-init s_user_ns for filesystems without FS_USERNS_MOUNT

Shahar Shitrit (1):
      net/mlx5e: Add a check for the return value from mlx5_port_set_eth_ptys

Shawn Guo (1):
      arm64: dts: qcom: msm8996: Move '#clock-cells' to QMP PHY child node

Shay Drory (1):
      genirq/irqdesc: Honor caller provided affinity in alloc_desc()

Shenwei Wang (2):
      irqchip/imx-irqsteer: Handle runtime power management correctly
      net: stmmac: Enable mac_managed_pm phylink config

Shigeru Yoshida (1):
      tipc: Return non-zero value from tipc_udp_addr2str() on error

Shreyas Deodhar (3):
      scsi: qla2xxx: Fix optrom version displayed in FDMI
      scsi: qla2xxx: Fix for possible memory corruption
      scsi: qla2xxx: Complete command early within lock

Simon Horman (1):
      net: stmmac: Correct byte order of perfect_match

Stefan Wahren (1):
      spi: spi-fsl-lpspi: Fix scldiv calculation

Stephen Boyd (1):
      soc: qcom: rpmh-rsc: Ensure irqs aren't disabled by rpmh_rsc_send_data() callers

Steven 'Steve' Kendall (1):
      ALSA: hda: Add HP MP9 G4 Retail System AMS to force connect list

Sung Joon Kim (1):
      drm/amd/display: Check for NULL pointer

Taehee Yoo (1):
      xdp: fix invalid wait context of page_pool_destroy()

Takashi Iwai (5):
      ALSA: usb-audio: Move HD Webcam quirk to the right place
      ALSA: usb-audio: Correct surround channels in UAC1 channel map
      ALSA: usb-audio: Re-add ScratchAmp quirk entries
      ALSA: line6: Fix racy access to midibuf
      ALSA: hda/hdmi: Yet more pin fix for HP EliteDesk 800 G4

Taniya Das (1):
      clk: qcom: gcc-sc7280: Update force mem core bit for UFS ICE clock

Tatsunosuke Tobita (1):
      HID: wacom: Modify pen IDs

Tejun Heo (1):
      sched/fair: set_load_weight() must also call reweight_task() for SCHED_IDLE tasks

Tetsuo Handa (2):
      mm: mmap_lock: replace get_memcg_path_buf() with on-stack buffer
      profiling: remove profile=sleep support

Thomas Gleixner (3):
      watchdog/perf: properly initialize the turbo mode timestamp and rearm counter
      tick/broadcast: Move per CPU pointer access into the atomic section
      timekeeping: Fix bogus clock_was_set() invocation in do_adjtimex()

Thomas Weißschuh (4):
      sysctl: always initialize i_uid/i_gid
      leds: triggers: Flush pending brightness before activating trigger
      ACPI: battery: create alarm sysfs attribute atomically
      ACPI: SBS: manage alarm sysfs attribute through psy core

Thomas Zimmermann (1):
      drm/mgag200: Set DDC timeout in milliseconds

Thorsten Blum (1):
      m68k: cmpxchg: Fix return value for default case in __arch_xchg()

Tvrtko Ursulin (1):
      mm/numa_balancing: teach mpol_to_str about the balancing mode

Tze-nan Wu (1):
      tracing: Fix overflow in get_free_elt()

Tzung-Bi Shih (1):
      platform/chrome: cros_ec_debugfs: fix wrong EC message version

Uwe Kleine-König (2):
      pwm: stm32: Always do lazy disabling
      pinctrl: ti: ti-iodelay: Drop if block with always false condition

Vamshi Gajjela (1):
      scsi: ufs: core: Fix hba->last_dme_cmd_tstamp timestamp updating logic

Vignesh Raghavendra (1):
      dmaengine: ti: k3-udma: Fix BCHAN count with UHC and HC channels

Vincent Tremblay (1):
      spidev: Add Silicon Labs EM3581 device compatible

Waiman Long (2):
      clocksource: Reduce the default clocksource_watchdog() retries to 2
      padata: Fix possible divide-by-0 panic in padata_mt_helper()

WangYuli (2):
      Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x13d3:0x3591
      nvme/pci: Add APST quirk for Lenovo N60z laptop

Wayne Lin (1):
      drm/dp_mst: Fix all mstb marked as not probed after suspend/resume

Wayne Tung (1):
      hwmon: (adt7475) Fix default duty on fan is disabled

Wei Liu (1):
      PCI: hv: Return zero, not garbage, when reading PCI_INTERRUPT_PIN

Xiao Liang (1):
      apparmor: Fix null pointer deref when receiving skb during sock creation

Xiaxi Shen (1):
      ext4: fix uninitialized variable in ext4_inlinedir_to_tree

Xin Long (1):
      sctp: move hlist_node and hashent out of sctp_ep_common

Yang Yingliang (5):
      pinctrl: core: fix possible memory leak when pinctrl_enable() fails
      pinctrl: single: fix possible memory leak when pinctrl_enable() fails
      pinctrl: ti: ti-iodelay: fix possible memory leak when pinctrl_enable() fails
      sched/smt: Introduce sched_smt_present_inc/dec() helper
      sched/smt: Fix unbalance sched_smt_present dec/inc

Yao Zi (1):
      drm/meson: fix canvas release in bind function

Yipeng Zou (1):
      irqchip/mbigen: Fix mbigen node address layout

Yonghong Song (1):
      selftests/bpf: Fix send_signal test with nested CONFIG_PARAVIRT

Yu Kuai (1):
      md/raid5: avoid BUG_ON() while continue reshape after reassembling

Yu Liao (1):
      tick/broadcast: Make takeover of broadcast hrtimer reliable

Zack Rusin (1):
      drm/vmwgfx: Fix a deadlock in dma buf fence polling

Zhang Yi (4):
      ext4: refactor ext4_da_map_blocks()
      ext4: convert to exclusive lock while inserting delalloc extents
      ext4: factor out a common helper to query extent map
      ext4: check the extent status again before inserting delalloc block

Zhe Qiao (1):
      riscv/mm: Add handling for VM_FAULT_SIGSEGV in mm_fault_error()

Zheng Yejian (1):
      media: dvb-usb: Fix unexpected infinite loop in dvb_usb_read_remote_control()

Zheng Zucheng (1):
      sched/cputime: Fix mul_u64_u64_div_u64() precision for cputime

Zijun Hu (3):
      kobject_uevent: Fix OOB access within zap_modalias_env()
      devres: Fix devm_krealloc() wasting memory
      devres: Fix memory leakage caused by driver API devm_free_percpu()

ethanwu (1):
      ceph: fix incorrect kmalloc size of pagevec mempool

songxiebing (1):
      ALSA: hda: conexant: Fix headset auto detect fail in the polling mode

tuhaowen (1):
      dev/parport: fix the array out-of-bounds risk

wangdicheng (2):
      ALSA: usb-audio: Fix microphone sound on HD webcam.
      ALSA: usb-audio: Add a quirk for Sonix HD USB Camera


