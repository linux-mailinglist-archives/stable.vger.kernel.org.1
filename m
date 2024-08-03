Return-Path: <stable+bounces-65314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F43E94686F
	for <lists+stable@lfdr.de>; Sat,  3 Aug 2024 09:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B894F1F21BE8
	for <lists+stable@lfdr.de>; Sat,  3 Aug 2024 07:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C005314D717;
	Sat,  3 Aug 2024 07:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CRitNX+m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECF3D2EE;
	Sat,  3 Aug 2024 07:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722668757; cv=none; b=FWzNxUjIdEKlI3hfmk8ZToYhgFWeFF6araOzoGURkqT3VCt1nnB4KvZA1T3R4ZhZpF7kYiXNuKXeOnyBoHZH8n5ivMuoCXg0WFhzQE3kPrGm0L0/uo7rETrP3gIhejBqSVW7n4ed36sSE2Uhm0pGtZ4fmYb8tdtwIbGPvV1+kVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722668757; c=relaxed/simple;
	bh=9ADKqRtzG8RAwsxpNh+T9lM7S4QC7IUo5Wzwb4lG4L4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sftJunNFGSYtSgXfwiKshr68/GxGv8G20u5OaHXfkW+943/CY/eY66QUTS4Ephzi0WonszzXU4BEW38jf81lVuRhSajMRHWdHu2Ki23V8IbU+GgB50YQaXUobMWeKvEU81fGMBTJ1UtYXM4vepEOBCPjJltTWzXfqcs93XIB740=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CRitNX+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59ECC116B1;
	Sat,  3 Aug 2024 07:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722668756;
	bh=9ADKqRtzG8RAwsxpNh+T9lM7S4QC7IUo5Wzwb4lG4L4=;
	h=From:To:Cc:Subject:Date:From;
	b=CRitNX+m0uShxWnBICqfW+pm1wuYTavlGml94VAlT6U0Ev6hlgCmKxGbam7rSY2Xa
	 ErEv9Cp9XKatjKTTqoRIeIzfGSgnbzJxwIEY2NeOAx7ZB0M5nM5vzpu2t052erhVQv
	 gJOFisz2rXa9fKe9CBU/Tus/MGOTahRKmIHohEDU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.103
Date: Sat,  3 Aug 2024 09:05:51 +0200
Message-ID: <2024080351-earflap-punk-7a45@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.103 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/thermal/thermal-zones.yaml      |    5 
 Makefile                                                          |    2 
 arch/arm/boot/dts/imx6q-kontron-samx6i.dtsi                       |   23 
 arch/arm/boot/dts/imx6qdl-kontron-samx6i.dtsi                     |   14 
 arch/arm/mach-pxa/spitz.c                                         |   30 
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi                       |    4 
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                        |    4 
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi                        |    4 
 arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts          |    4 
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts                      |    4 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi            |   25 
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi                    |    2 
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi               |    1 
 arch/arm64/boot/dts/qcom/msm8996.dtsi                             |    2 
 arch/arm64/boot/dts/qcom/msm8998.dtsi                             |    1 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                              |    2 
 arch/arm64/boot/dts/qcom/sm6350.dtsi                              |    4 
 arch/arm64/boot/dts/qcom/sm8250.dtsi                              |   22 
 arch/arm64/boot/dts/qcom/sm8450.dtsi                              |    2 
 arch/arm64/boot/dts/renesas/r8a779a0.dtsi                         |   14 
 arch/arm64/boot/dts/renesas/r8a779f0.dtsi                         |   14 
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi                         |   82 +
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi                       |   11 
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi                        |   11 
 arch/arm64/boot/dts/renesas/r9a07g044c1.dtsi                      |    7 
 arch/arm64/boot/dts/renesas/r9a07g044l1.dtsi                      |    7 
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi                        |   11 
 arch/arm64/boot/dts/renesas/r9a07g054l1.dtsi                      |    7 
 arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts                 |   71 
 arch/arm64/boot/dts/rockchip/rk3328.dtsi                          |    4 
 arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts                  |    2 
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts                   |    4 
 arch/arm64/boot/dts/rockchip/rk356x.dtsi                          |    1 
 arch/m68k/amiga/config.c                                          |    9 
 arch/m68k/atari/ataints.c                                         |    6 
 arch/m68k/include/asm/cmpxchg.h                                   |    2 
 arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi                |   21 
 arch/mips/include/asm/mach-loongson64/boot_param.h                |    2 
 arch/mips/include/asm/mips-cm.h                                   |    4 
 arch/mips/kernel/smp-cps.c                                        |    5 
 arch/mips/loongson64/env.c                                        |    8 
 arch/mips/loongson64/reset.c                                      |   38 
 arch/mips/loongson64/smp.c                                        |   23 
 arch/mips/sgi-ip30/ip30-console.c                                 |    1 
 arch/parisc/Kconfig                                               |    1 
 arch/powerpc/configs/85xx-hw.config                               |    2 
 arch/powerpc/include/asm/kexec.h                                  |    4 
 arch/powerpc/include/asm/plpks.h                                  |  163 ++
 arch/powerpc/kernel/prom.c                                        |   12 
 arch/powerpc/kexec/core_64.c                                      |  112 +
 arch/powerpc/kexec/file_load_64.c                                 |   87 -
 arch/powerpc/kvm/powerpc.c                                        |    4 
 arch/powerpc/platforms/pseries/plpks.c                            |  171 ++
 arch/powerpc/platforms/pseries/plpks.h                            |   96 -
 arch/powerpc/xmon/ppc-dis.c                                       |   33 
 arch/s390/kernel/uv.c                                             |   58 
 arch/s390/pci/pci_irq.c                                           |  110 -
 arch/sparc/include/asm/oplib_64.h                                 |    1 
 arch/sparc/prom/init_64.c                                         |    3 
 arch/sparc/prom/p1275.c                                           |    2 
 arch/um/drivers/ubd_kern.c                                        |   50 
 arch/um/kernel/time.c                                             |    4 
 arch/um/os-Linux/signal.c                                         |  118 +
 arch/x86/events/core.c                                            |    3 
 arch/x86/events/intel/cstate.c                                    |    7 
 arch/x86/events/intel/pt.c                                        |    4 
 arch/x86/events/intel/pt.h                                        |    4 
 arch/x86/events/intel/uncore_snbep.c                              |    6 
 arch/x86/include/asm/kvm_host.h                                   |    2 
 arch/x86/kernel/devicetree.c                                      |    2 
 arch/x86/kvm/vmx/nested.c                                         |    2 
 arch/x86/kvm/vmx/vmx.c                                            |   11 
 arch/x86/kvm/vmx/vmx.h                                            |    1 
 arch/x86/kvm/x86.c                                                |    4 
 arch/x86/pci/intel_mid_pci.c                                      |    4 
 arch/x86/pci/xen.c                                                |    4 
 arch/x86/platform/intel/iosf_mbi.c                                |    4 
 arch/x86/xen/p2m.c                                                |    4 
 block/bio-integrity.c                                             |   21 
 drivers/android/binder.c                                          |    4 
 drivers/ata/libata-scsi.c                                         |    7 
 drivers/auxdisplay/ht16k33.c                                      |    1 
 drivers/base/devres.c                                             |   11 
 drivers/block/rbd.c                                               |   35 
 drivers/bluetooth/btusb.c                                         |    4 
 drivers/char/hw_random/amd-rng.c                                  |    4 
 drivers/char/tpm/eventlog/common.c                                |    2 
 drivers/clk/clk-en7523.c                                          |    9 
 drivers/clk/davinci/da8xx-cfgchip.c                               |    4 
 drivers/clk/qcom/camcc-sc7280.c                                   |    5 
 drivers/clk/qcom/clk-branch.h                                     |   26 
 drivers/clk/qcom/clk-rcg2.c                                       |   32 
 drivers/clk/qcom/gcc-sc7280.c                                     |    3 
 drivers/clk/qcom/gpucc-sm8350.c                                   |    5 
 drivers/cpufreq/ti-cpufreq.c                                      |    2 
 drivers/crypto/qat/qat_common/adf_cfg.c                           |    6 
 drivers/dma/ti/k3-udma.c                                          |    4 
 drivers/edac/Makefile                                             |   10 
 drivers/edac/skx_common.c                                         |   21 
 drivers/edac/skx_common.h                                         |    4 
 drivers/firmware/efi/libstub/x86-stub.c                           |   25 
 drivers/firmware/turris-mox-rwtm.c                                |   23 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                        |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c                           |    1 
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c                            |   12 
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c                  |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c                    |    4 
 drivers/gpu/drm/display/drm_dp_mst_topology.c                     |    4 
 drivers/gpu/drm/etnaviv/etnaviv_gem.c                             |    6 
 drivers/gpu/drm/etnaviv/etnaviv_sched.c                           |    9 
 drivers/gpu/drm/gma500/cdv_intel_lvds.c                           |    3 
 drivers/gpu/drm/gma500/psb_intel_lvds.c                           |    3 
 drivers/gpu/drm/i915/display/intel_dp.c                           |    2 
 drivers/gpu/drm/i915/gt/intel_execlists_submission.c              |    6 
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                            |    2 
 drivers/gpu/drm/mediatek/mtk_drm_plane.c                          |    2 
 drivers/gpu/drm/meson/meson_drv.c                                 |   37 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                       |    3 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c               |    3 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h                        |    3 
 drivers/gpu/drm/msm/dsi/dsi_host.c                                |    3 
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c                    |    8 
 drivers/gpu/drm/panfrost/panfrost_drv.c                           |    1 
 drivers/gpu/drm/qxl/qxl_display.c                                 |    3 
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c                      |    2 
 drivers/hwmon/adt7475.c                                           |    2 
 drivers/hwmon/max6697.c                                           |    5 
 drivers/hwtracing/coresight/coresight-platform.c                  |    4 
 drivers/iio/frequency/adrf6780.c                                  |    1 
 drivers/infiniband/core/cache.c                                   |   14 
 drivers/infiniband/core/device.c                                  |    6 
 drivers/infiniband/core/iwcm.c                                    |   11 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                          |    8 
 drivers/infiniband/hw/bnxt_re/qplib_fp.h                          |    6 
 drivers/infiniband/hw/hns/hns_roce_device.h                       |    6 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                        |   40 
 drivers/infiniband/hw/hns/hns_roce_mr.c                           |    5 
 drivers/infiniband/hw/hns/hns_roce_qp.c                           |    4 
 drivers/infiniband/hw/hns/hns_roce_srq.c                          |    2 
 drivers/infiniband/hw/mlx4/alias_GUID.c                           |    2 
 drivers/infiniband/hw/mlx4/mad.c                                  |    2 
 drivers/infiniband/hw/mlx5/mlx5_ib.h                              |   13 
 drivers/infiniband/hw/mlx5/odp.c                                  |    6 
 drivers/infiniband/sw/rxe/rxe_req.c                               |    7 
 drivers/input/keyboard/qt1050.c                                   |    7 
 drivers/input/mouse/elan_i2c_core.c                               |    2 
 drivers/interconnect/qcom/qcm2290.c                               |    2 
 drivers/iommu/intel/iommu.c                                       |   22 
 drivers/iommu/sprd-iommu.c                                        |    2 
 drivers/irqchip/irq-imx-irqsteer.c                                |   24 
 drivers/isdn/hardware/mISDN/hfcmulti.c                            |    7 
 drivers/leds/flash/leds-mt6360.c                                  |    5 
 drivers/leds/led-class.c                                          |    1 
 drivers/leds/led-triggers.c                                       |    2 
 drivers/leds/leds-ss4200.c                                        |    7 
 drivers/macintosh/therm_windtunnel.c                              |    2 
 drivers/md/dm-verity-target.c                                     |   16 
 drivers/md/md.c                                                   |   26 
 drivers/media/i2c/imx412.c                                        |    9 
 drivers/media/pci/ivtv/ivtv-udma.c                                |    8 
 drivers/media/pci/ivtv/ivtv-yuv.c                                 |    6 
 drivers/media/pci/ivtv/ivtvfb.c                                   |    6 
 drivers/media/pci/saa7134/saa7134-dvb.c                           |    8 
 drivers/media/platform/qcom/venus/vdec.c                          |    3 
 drivers/media/platform/renesas/rcar-vin/rcar-csi2.c               |    5 
 drivers/media/platform/renesas/rcar-vin/rcar-dma.c                |   16 
 drivers/media/platform/renesas/vsp1/vsp1_histo.c                  |   20 
 drivers/media/platform/renesas/vsp1/vsp1_pipe.h                   |    2 
 drivers/media/platform/renesas/vsp1/vsp1_rpf.c                    |    8 
 drivers/media/rc/imon.c                                           |    5 
 drivers/media/rc/lirc_dev.c                                       |    4 
 drivers/media/usb/dvb-usb/dvb-usb-init.c                          |   35 
 drivers/media/usb/uvc/uvc_ctrl.c                                  |    9 
 drivers/media/usb/uvc/uvc_video.c                                 |   10 
 drivers/media/v4l2-core/v4l2-async.c                              |    3 
 drivers/memory/Kconfig                                            |    2 
 drivers/mfd/Makefile                                              |    6 
 drivers/mfd/omap-usb-tll.c                                        |    3 
 drivers/mfd/rsmu_core.c                                           |    2 
 drivers/mtd/nand/raw/Kconfig                                      |    3 
 drivers/mtd/tests/Makefile                                        |   34 
 drivers/mtd/tests/mtd_test.c                                      |    9 
 drivers/mtd/ubi/eba.c                                             |    3 
 drivers/net/bonding/bond_main.c                                   |    7 
 drivers/net/dsa/b53/b53_common.c                                  |    3 
 drivers/net/dsa/mv88e6xxx/chip.c                                  |    3 
 drivers/net/ethernet/brocade/bna/bna_types.h                      |    2 
 drivers/net/ethernet/brocade/bna/bnad.c                           |   11 
 drivers/net/ethernet/freescale/fec_main.c                         |   52 
 drivers/net/ethernet/google/gve/gve_tx_dqo.c                      |   22 
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c                 |    2 
 drivers/net/ethernet/intel/ice/ice_fdir.h                         |    3 
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c                |   16 
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.h                |    1 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_atcam.c          |   18 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c   |    2 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c            |   13 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.h           |    9 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c                 |    2 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c               |    2 
 drivers/net/ethernet/stmicro/stmmac/hwif.h                        |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                 |    4 
 drivers/net/netconsole.c                                          |    2 
 drivers/net/wireless/ath/ath11k/dp_rx.c                           |    3 
 drivers/net/wireless/ath/ath11k/dp_rx.h                           |    3 
 drivers/net/wireless/ath/ath11k/mac.c                             |   15 
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c    |   18 
 drivers/net/wireless/marvell/mwifiex/cfg80211.c                   |    2 
 drivers/net/wireless/realtek/rtw89/debug.c                        |    2 
 drivers/net/wireless/virt_wifi.c                                  |   20 
 drivers/nvme/host/pci.c                                           |    5 
 drivers/nvme/target/auth.c                                        |   14 
 drivers/opp/ti-opp-supply.c                                       |    6 
 drivers/parport/procfs.c                                          |   24 
 drivers/pci/controller/dwc/pci-keystone.c                         |  156 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c                   |   13 
 drivers/pci/controller/dwc/pcie-dw-rockchip.c                     |    2 
 drivers/pci/controller/dwc/pcie-qcom-ep.c                         |    6 
 drivers/pci/controller/pci-hyperv.c                               |    4 
 drivers/pci/controller/pci-loongson.c                             |   13 
 drivers/pci/controller/pcie-rcar-host.c                           |    6 
 drivers/pci/controller/pcie-rockchip.c                            |    2 
 drivers/pci/endpoint/functions/pci-epf-vntb.c                     |   19 
 drivers/pci/pci.c                                                 |    6 
 drivers/pci/setup-bus.c                                           |    6 
 drivers/phy/cadence/phy-cadence-torrent.c                         |    3 
 drivers/pinctrl/core.c                                            |   12 
 drivers/pinctrl/freescale/pinctrl-mxs.c                           |    4 
 drivers/pinctrl/pinctrl-rockchip.c                                |   17 
 drivers/pinctrl/pinctrl-single.c                                  |    7 
 drivers/pinctrl/renesas/pfc-r8a779g0.c                            |  712 ++++------
 drivers/pinctrl/ti/pinctrl-ti-iodelay.c                           |   14 
 drivers/platform/chrome/cros_ec_debugfs.c                         |    1 
 drivers/platform/mips/cpu_hwmon.c                                 |    3 
 drivers/pwm/pwm-atmel-tcb.c                                       |   66 
 drivers/pwm/pwm-stm32.c                                           |    5 
 drivers/remoteproc/imx_rproc.c                                    |   10 
 drivers/remoteproc/stm32_rproc.c                                  |    2 
 drivers/rtc/interface.c                                           |    9 
 drivers/rtc/rtc-cmos.c                                            |   10 
 drivers/rtc/rtc-isl1208.c                                         |   11 
 drivers/s390/block/dasd_devmap.c                                  |   10 
 drivers/scsi/qla2xxx/qla_bsg.c                                    |   98 -
 drivers/scsi/qla2xxx/qla_def.h                                    |    3 
 drivers/scsi/qla2xxx/qla_gs.c                                     |   35 
 drivers/scsi/qla2xxx/qla_init.c                                   |   87 -
 drivers/scsi/qla2xxx/qla_inline.h                                 |    8 
 drivers/scsi/qla2xxx/qla_mid.c                                    |    2 
 drivers/scsi/qla2xxx/qla_nvme.c                                   |    5 
 drivers/scsi/qla2xxx/qla_os.c                                     |    7 
 drivers/scsi/qla2xxx/qla_sup.c                                    |  108 +
 drivers/soc/qcom/pdr_interface.c                                  |    8 
 drivers/soc/qcom/rpmh-rsc.c                                       |    7 
 drivers/soc/qcom/rpmh.c                                           |    1 
 drivers/soc/xilinx/xlnx_event_manager.c                           |   15 
 drivers/soc/xilinx/zynqmp_power.c                                 |    4 
 drivers/spi/atmel-quadspi.c                                       |   11 
 drivers/spi/spi-microchip-core.c                                  |  188 +-
 drivers/spi/spidev.c                                              |   11 
 drivers/vhost/vsock.c                                             |    4 
 drivers/watchdog/rzg2l_wdt.c                                      |   22 
 fs/ceph/super.c                                                   |    3 
 fs/ext2/balloc.c                                                  |   11 
 fs/ext4/extents_status.c                                          |    2 
 fs/ext4/fast_commit.c                                             |    6 
 fs/ext4/namei.c                                                   |   73 -
 fs/ext4/xattr.c                                                   |    6 
 fs/f2fs/checkpoint.c                                              |   10 
 fs/f2fs/file.c                                                    |    2 
 fs/f2fs/inline.c                                                  |    6 
 fs/f2fs/inode.c                                                   |    3 
 fs/f2fs/segment.h                                                 |    3 
 fs/fuse/inode.c                                                   |   24 
 fs/hfs/inode.c                                                    |    3 
 fs/hfsplus/bfind.c                                                |   15 
 fs/hfsplus/extents.c                                              |    9 
 fs/hfsplus/hfsplus_fs.h                                           |   21 
 fs/jbd2/commit.c                                                  |    2 
 fs/jbd2/journal.c                                                 |    5 
 fs/jfs/jfs_imap.c                                                 |    5 
 fs/kernfs/dir.c                                                   |  112 -
 fs/kernfs/file.c                                                  |   18 
 fs/kernfs/inode.c                                                 |    8 
 fs/kernfs/kernfs-internal.h                                       |    2 
 fs/kernfs/mount.c                                                 |   10 
 fs/kernfs/symlink.c                                               |    2 
 fs/nfs/nfs4client.c                                               |    6 
 fs/nfs/nfs4proc.c                                                 |    2 
 fs/nilfs2/btnode.c                                                |   25 
 fs/nilfs2/btree.c                                                 |    4 
 fs/nilfs2/segment.c                                               |    2 
 fs/ntfs3/attrib.c                                                 |   17 
 fs/ntfs3/bitmap.c                                                 |    2 
 fs/ntfs3/dir.c                                                    |    3 
 fs/ntfs3/file.c                                                   |    5 
 fs/ntfs3/frecord.c                                                |    2 
 fs/ntfs3/fslog.c                                                  |    5 
 fs/ntfs3/fsntfs.c                                                 |    2 
 fs/ntfs3/index.c                                                  |    4 
 fs/ntfs3/inode.c                                                  |    3 
 fs/ntfs3/ntfs.h                                                   |   13 
 fs/ntfs3/ntfs_fs.h                                                |    2 
 fs/proc/task_mmu.c                                                |    2 
 fs/smb/client/cifsfs.c                                            |    8 
 fs/smb/client/connect.c                                           |   24 
 fs/super.c                                                        |   11 
 fs/udf/balloc.c                                                   |   15 
 fs/udf/super.c                                                    |    3 
 include/asm-generic/vmlinux.lds.h                                 |    2 
 include/drm/drm_mipi_dsi.h                                        |   21 
 include/linux/bpf_verifier.h                                      |    2 
 include/linux/hugetlb.h                                           |    1 
 include/linux/jbd2.h                                              |    5 
 include/linux/jump_label.h                                        |   21 
 include/linux/mlx5/qp.h                                           |    9 
 include/linux/objagg.h                                            |    1 
 include/linux/pci.h                                               |    2 
 include/linux/perf_event.h                                        |    1 
 include/linux/sbitmap.h                                           |    5 
 include/linux/task_work.h                                         |    3 
 include/linux/virtio_net.h                                        |   11 
 include/net/ip_fib.h                                              |    1 
 include/net/tcp.h                                                 |    1 
 include/trace/events/rpcgss.h                                     |    2 
 include/uapi/linux/netfilter/nf_tables.h                          |    2 
 include/uapi/linux/zorro_ids.h                                    |    3 
 io_uring/io-wq.c                                                  |   10 
 io_uring/io_uring.c                                               |    5 
 io_uring/timeout.c                                                |    2 
 kernel/bpf/btf.c                                                  |   10 
 kernel/bpf/dispatcher.c                                           |    5 
 kernel/cgroup/cgroup-v1.c                                         |    2 
 kernel/cgroup/cgroup.c                                            |    4 
 kernel/cgroup/cpuset.c                                            |   15 
 kernel/debug/kdb/kdb_io.c                                         |    6 
 kernel/dma/mapping.c                                              |    2 
 kernel/events/core.c                                              |   79 -
 kernel/events/internal.h                                          |    2 
 kernel/events/ring_buffer.c                                       |    4 
 kernel/irq/manage.c                                               |    2 
 kernel/jump_label.c                                               |  101 -
 kernel/locking/rwsem.c                                            |    6 
 kernel/rcu/tasks.h                                                |   10 
 kernel/sched/core.c                                               |   37 
 kernel/sched/fair.c                                               |    9 
 kernel/sched/sched.h                                              |    2 
 kernel/signal.c                                                   |    8 
 kernel/task_work.c                                                |   34 
 kernel/time/tick-broadcast.c                                      |   23 
 kernel/trace/pid_list.c                                           |    4 
 kernel/watchdog_hld.c                                             |   11 
 lib/decompress_bunzip2.c                                          |    3 
 lib/kobject_uevent.c                                              |   17 
 lib/objagg.c                                                      |   18 
 lib/sbitmap.c                                                     |   83 -
 mm/hugetlb.c                                                      |    2 
 mm/mempolicy.c                                                    |   18 
 mm/mmap_lock.c                                                    |  175 --
 mm/vmscan.c                                                       |    1 
 net/bridge/br_forward.c                                           |    4 
 net/core/filter.c                                                 |   15 
 net/core/flow_dissector.c                                         |    2 
 net/core/xdp.c                                                    |    4 
 net/ipv4/esp4.c                                                   |    3 
 net/ipv4/fib_semantics.c                                          |   13 
 net/ipv4/fib_trie.c                                               |    1 
 net/ipv4/nexthop.c                                                |    7 
 net/ipv4/route.c                                                  |   18 
 net/ipv4/tcp.c                                                    |   13 
 net/ipv4/tcp_input.c                                              |   34 
 net/ipv4/tcp_ipv4.c                                               |   19 
 net/ipv4/tcp_output.c                                             |    2 
 net/ipv4/tcp_timer.c                                              |   10 
 net/ipv6/addrconf.c                                               |    3 
 net/ipv6/esp6.c                                                   |    3 
 net/ipv6/tcp_ipv6.c                                               |   19 
 net/mac80211/cfg.c                                                |   23 
 net/mac80211/ieee80211_i.h                                        |    2 
 net/mac80211/rate.c                                               |    2 
 net/mac80211/sta_info.h                                           |    6 
 net/mac80211/vht.c                                                |   37 
 net/netfilter/ipvs/ip_vs_proto_sctp.c                             |    4 
 net/netfilter/nf_conntrack_netlink.c                              |    3 
 net/netfilter/nft_set_pipapo.c                                    |   22 
 net/netfilter/nft_set_pipapo.h                                    |   27 
 net/netfilter/nft_set_pipapo_avx2.c                               |   81 -
 net/packet/af_packet.c                                            |   86 +
 net/smc/smc_core.c                                                |    5 
 net/sunrpc/auth_gss/gss_krb5_keys.c                               |    2 
 net/sunrpc/clnt.c                                                 |    3 
 net/sunrpc/xprtrdma/frwr_ops.c                                    |    3 
 net/sunrpc/xprtrdma/verbs.c                                       |   16 
 net/tipc/udp_media.c                                              |    5 
 net/unix/af_unix.c                                                |   41 
 net/unix/unix_bpf.c                                               |    3 
 net/wireless/util.c                                               |    8 
 scripts/Makefile.lib                                              |    6 
 scripts/gcc-x86_32-has-stack-protector.sh                         |    2 
 scripts/gcc-x86_64-has-stack-protector.sh                         |    2 
 security/apparmor/lsm.c                                           |    7 
 security/apparmor/policy.c                                        |    2 
 security/apparmor/policy_unpack.c                                 |    1 
 security/keys/keyctl.c                                            |    2 
 security/landlock/cred.c                                          |   11 
 sound/soc/amd/acp-es8336.c                                        |    4 
 sound/soc/amd/yc/acp6x-mach.c                                     |    7 
 sound/soc/codecs/max98088.c                                       |   10 
 sound/soc/intel/common/soc-intel-quirks.h                         |    2 
 sound/soc/qcom/lpass-cpu.c                                        |    4 
 sound/soc/sof/imx/imx8m.c                                         |    2 
 sound/usb/mixer.c                                                 |    7 
 sound/usb/quirks.c                                                |    4 
 tools/bpf/bpftool/common.c                                        |    2 
 tools/bpf/bpftool/prog.c                                          |    4 
 tools/bpf/resolve_btfids/main.c                                   |    2 
 tools/lib/bpf/btf_dump.c                                          |    8 
 tools/lib/bpf/linker.c                                            |   11 
 tools/memory-model/lock.cat                                       |   20 
 tools/perf/arch/x86/util/intel-pt.c                               |   15 
 tools/perf/tests/shell/test_arm_callgraph_fp.sh                   |   64 
 tools/perf/tests/workloads/leafloop.c                             |   20 
 tools/perf/util/sort.c                                            |    2 
 tools/testing/selftests/bpf/prog_tests/sk_lookup.c                |    2 
 tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c          |    2 
 tools/testing/selftests/bpf/progs/btf_dump_test_case_multidim.c   |    4 
 tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c     |    4 
 tools/testing/selftests/bpf/test_sockmap.c                        |    9 
 tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh |   55 
 tools/testing/selftests/landlock/base_test.c                      |   74 +
 tools/testing/selftests/landlock/config                           |    5 
 tools/testing/selftests/net/fib_tests.sh                          |   24 
 tools/testing/selftests/net/forwarding/devlink_lib.sh             |    2 
 tools/testing/selftests/sigaltstack/current_stack_pointer.h       |    2 
 433 files changed, 4242 insertions(+), 2567 deletions(-)

Abhinav Kumar (1):
      drm/msm/dpu: drop validity checks for clear_pending_flush() ctl op

Adrian Hunter (7):
      perf/x86/intel/pt: Fix pt_topa_entry_for_page() address calculation
      perf: Fix perf_aux_size() for greater-than 32-bit size
      perf: Prevent passing zero nr_pages to rb_alloc_aux()
      perf: Fix default aux_watermark calculation
      perf intel-pt: Fix aux_watermark calculation for 64-bit size
      perf intel-pt: Fix exclude_guest setting
      perf/x86/intel/pt: Fix a topa_entry base address calculation

Ahmed Zaki (1):
      ice: Add a per-VF limit on number of FDIR filters

Al Viro (2):
      powerpc: fix a file leak in kvm_vcpu_ioctl_enable_cap()
      lirc: rc_dev_get_from_fd(): fix file leak

Alan Maguire (2):
      bpf: annotate BTF show functions with __printf
      bpf: Eliminate remaining "make W=1" warnings in kernel/bpf/btf.o

Alan Stern (1):
      tools/memory-model: Fix bug in lock.cat

Aleksandr Burakov (1):
      saa7134: Unchecked i2c_transfer function result fixed

Aleksandr Mishin (6):
      wifi: rtw89: Fix array index mistake in rtw89_sta_info_get_iter()
      PCI: keystone: Fix NULL pointer dereference in case of DT error in ks_pcie_setup_rc_app_regs()
      ASoC: qcom: Adjust issues in case of DT error in asoc_qcom_lpass_cpu_platform_probe()
      ASoC: amd: Adjust error handling in case of absent codec device
      remoteproc: imx_rproc: Skip over memory region when node value is NULL
      remoteproc: imx_rproc: Fix refcount mistake in imx_rproc_addr_init

Alex Deucher (1):
      drm/amdgpu/sdma5.2: Update wptr registers as well as doorbell

Alexey Kodanev (1):
      bna: adjust 'name' buf size of bna_tcb and bna_ccb structures

Amit Cohen (1):
      selftests: forwarding: devlink_lib: Wait for udev events after reloading

Andreas Larsson (1):
      sparc64: Fix incorrect function signature and add prototype for prom_cif_init

Andrei Lalaev (1):
      Input: qt1050 - handle CHIP_ID reading error

Andrew Donnellan (1):
      powerpc/pseries: Fix alignment of PLPKS structures and buffers

Andrii Nakryiko (1):
      libbpf: Fix no-args func prototype BTF dumping syntax

Andy Yan (1):
      drm/rockchip: vop2: Fix the port mux of VP2

Antoniu Miclaus (1):
      iio: frequency: adrf6780: rm clk provider include

Ard Biesheuvel (2):
      x86/efistub: Avoid returning EFI_SUCCESS on error
      x86/efistub: Revert to heap allocated boot_params for PE entrypoint

Arnd Bergmann (4):
      EDAC, i10nm: make skx_common.o a separate module
      mfd: rsmu: Split core code into separate module
      mtd: make mtd_test.c a separate module
      kdb: address -Wformat-security warnings

Artem Chernyshev (1):
      iommu: sprd: Avoid NULL deref in sprd_iommu_hw_en

Bailey Forrest (1):
      gve: Fix an edge case for TSO skb validity check

Baochen Qiang (3):
      wifi: ath11k: fix wrong handling of CCMP256 and GCMP ciphers
      wifi: cfg80211: fix typo in cfg80211_calculate_bitrate_he()
      wifi: cfg80211: handle 2x996 RU allocation in cfg80211_calculate_bitrate_he()

Baokun Li (2):
      ext4: check dot and dotdot of dx_root before making dir indexed
      ext4: make sure the first directory block is not a hole

Bart Van Assche (2):
      RDMA/iwcm: Fix a use-after-free related to destroying CM IDs
      nvme-pci: Fix the instructions for disabling power management

Bastien Curutchet (1):
      clk: davinci: da8xx-cfgchip: Initialize clk_init_data before use

Benjamin Coddington (1):
      SUNRPC: Fixup gss_status tracepoint error output

Breno Leitao (1):
      net: netconsole: Disable target before netpoll cleanup

Bryan O'Donoghue (1):
      media: i2c: Fix imx412 exposure control

Carlos Llamas (1):
      binder: fix hang of unregistered readers

Carlos López (1):
      s390/dasd: fix error checks in dasd_copy_pair_store()

Chao Yu (6):
      hfsplus: fix to avoid false alarm of circular locking
      hfs: fix to initialize fields of hfs_inode_info after hfs_alloc_inode()
      f2fs: fix to force buffered IO on inline_data inode
      f2fs: fix to don't dirty inode for readonly filesystem
      f2fs: fix return value of f2fs_convert_inline_inode()
      f2fs: fix to update user block counts in block_operations()

Chen Ni (4):
      spi: atmel-quadspi: Add missing check for clk_prepare
      x86/xen: Convert comma to semicolon
      drm/qxl: Add check for drm_cvt_mode
      ASoC: max98088: Check for clk_prepare_enable() error

Chen Ridong (1):
      cgroup/cpuset: Prevent UAF in proc_cpuset_show()

Chen-Yu Tsai (2):
      arm64: dts: mediatek: mt8183-kukui: Drop bogus output-enable property
      arm64: dts: mediatek: mt8183-kukui-jacuzzi: Add ports node for anx7625

Chengchang Tang (4):
      RDMA/hns: Fix missing pagesize and alignment check in FRMR
      RDMA/hns: Fix shift-out-bounds when max_inline_data is 0
      RDMA/hns: Fix undifined behavior caused by invalid max_sge
      RDMA/hns: Fix insufficient extend DB for VFs.

Chengen Du (1):
      af_packet: Handle outgoing VLAN packets without hardware offloading

ChiYuan Huang (1):
      media: v4l: async: Fix NULL pointer dereference in adding ancillary links

Chiara Meiohas (1):
      RDMA/mlx5: Set mkeys for dmabuf at PAGE_SIZE

Christoph Hellwig (3):
      ubd: refactor the interrupt handler
      ubd: untagle discard vs write zeroes not support handling
      block: initialize integrity buffer to zero before writing it to media

Christophe Leroy (1):
      vmlinux.lds.h: catch .bss..L* sections into BSS")

Chuck Lever (1):
      xprtrdma: Fix rpcrdma_reqs_reset()

Claudiu Beznea (2):
      watchdog: rzg2l_wdt: Use pm_runtime_resume_and_get()
      watchdog: rzg2l_wdt: Check return status of pm_runtime_put()

Conor Dooley (1):
      spi: spidev: add correct compatible for Rohm BH2228FV

Cristian Ciocaltea (3):
      arm64: dts: rockchip: Drop invalid mic-in-differential on rk3568-rock-3a
      arm64: dts: rockchip: Fix mic-in-differential usage on rk3568-evb1-v10
      arm64: dts: rockchip: Add missing power-domains for rk356x vop_mmu

Csókás Bence (1):
      net: fec: Refactor: #define magic constants

Csókás, Bence (2):
      net: fec: Fix FEC_ECR_EN1588 being cleared on link-down
      rtc: interface: Add RTC offset to alarm after fix-up

Dan Carpenter (3):
      PCI: endpoint: Clean up error handling in vpci_scan_bus()
      PCI: endpoint: Fix error handling in epf_ntb_epc_cleanup()
      mISDN: Fix a use after free in hfcmulti_tx()

Daniel Baluta (1):
      ASoC: SOF: imx8m: Fix DSP control regmap retrieval

Daniel Schaefer (1):
      media: uvcvideo: Override default flags

David Hildenbrand (2):
      s390/uv: Don't call folio_wait_writeback() without a folio reference
      fs/proc/task_mmu: indicate PM_FILE for PMD-mapped file THP

Denis Arefev (1):
      net: missing check virtio

Dikshita Agarwal (2):
      media: venus: flush all buffers in output plane streamoff
      media: venus: fix use after free in vdec_close

Dmitry Baryshkov (9):
      arm64: dts: qcom: sdm845: add power-domain to UFS PHY
      arm64: dts: qcom: sm6350: add power-domain to UFS PHY
      arm64: dts: qcom: sm8250: switch UFS QMP PHY to new style of bindings
      arm64: dts: qcom: sm8250: add power-domain to UFS PHY
      arm64: dts: qcom: sm8450: add power-domain to UFS PHY
      arm64: dts: qcom: msm8996-xiaomi-common: drop excton from the USB PHY
      arm64: dts: qcom: msm8996: specify UFS core_clk frequencies
      soc: qcom: pdr: protect locator_addr with the main mutex
      soc: qcom: pdr: fix parsing of domains lists

Dmitry Safonov (1):
      jump_label: Prevent key->enabled int overflow

Dmitry Torokhov (2):
      ARM: spitz: fix GPIO assignment for backlight
      Input: elan_i2c - do not leave interrupt disabled on suspend failure

Dmitry Yashin (1):
      pinctrl: rockchip: update rk3308 iomux routes

Dominique Martinet (1):
      MIPS: Octeron: remove source file executable bit

Donglin Peng (1):
      libbpf: Checking the btf_type kind when fixing variable offsets

Douglas Anderson (4):
      drm/mipi-dsi: Fix theoretical int overflow in mipi_dsi_dcs_write_seq()
      drm/panel: boe-tv101wum-nl6: If prepare fails, disable GPIO before regulators
      drm/panel: boe-tv101wum-nl6: Check for errors on the NOP in prepare()
      kdb: Use the passed prompt in kdb_position_cursor()

Dragan Simic (1):
      drm/panfrost: Mark simple_ondemand governor as softdep

Eero Tamminen (1):
      m68k: atari: Fix TT bootup freeze / unexpected (SCU) interrupt messages

Elliot Ayrey (1):
      net: bridge: mst: Check vlan state for egress decision

En-Wei Wu (1):
      wifi: virt_wifi: avoid reporting connection success with wrong SSID

Eric Biggers (1):
      dm-verity: fix dm_is_verity_target() when dm-verity is builtin

Eric Dumazet (5):
      tcp: annotate lockless accesses to sk->sk_err_soft
      tcp: annotate lockless access to sk->sk_err
      tcp: add tcp_done_with_error() helper
      tcp: fix race in tcp_write_err()
      tcp: fix races in tcp_v[46]_err()

Eric Sandeen (1):
      fuse: verify {g,u}id mount options correctly

Esben Haabendal (2):
      powerpc/configs: Update defconfig with now user-visible CONFIG_FSL_IFC
      memory: fsl_ifc: Make FSL_IFC config visible and selectable

Fedor Pchelkin (2):
      apparmor: use kvfree_sensitive to free data->data
      ubi: eba: properly rollback inside self_check_eba

Florian Westphal (3):
      netfilter: nft_set_pipapo: constify lookup fn args where possible
      netfilter: nf_set_pipapo: fix initial map fill
      netfilter: nft_set_pipapo_avx2: disable softinterrupts

Frank Li (1):
      PCI: dwc: Fix index 0 incorrectly being interpreted as a free ATU slot

Fred Li (1):
      bpf: Fix a segment issue when downgrading gso_size

Frederic Weisbecker (5):
      rcu/tasks: Fix stale task snaphot for Tasks Trace
      task_work: s/task_work_cancel()/task_work_cancel_func()/
      task_work: Introduce task_work_cancel() again
      perf: Fix event leak upon exit
      perf: Fix event leak upon exec and file release

Friedrich Vock (1):
      drm/amdgpu: Check if NBIO funcs are NULL in amdgpu_device_baco_exit

Gaosheng Cui (2):
      nvmet-auth: fix nvmet_auth hash error handling
      gss_krb5: Fix the error handling path for crypto_sync_skcipher_setkey

Geert Uytterhoeven (16):
      arm64: dts: renesas: r8a779g0: Add L3 cache controller
      arm64: dts: renesas: r8a779g0: Add secondary CA76 CPU cores
      arm64: dts: renesas: r8a779a0: Add missing hypervisor virtual timer IRQ
      arm64: dts: renesas: r8a779f0: Add missing hypervisor virtual timer IRQ
      arm64: dts: renesas: r8a779g0: Add missing hypervisor virtual timer IRQ
      arm64: dts: renesas: r9a07g043u: Add missing hypervisor virtual timer IRQ
      arm64: dts: renesas: r9a07g044: Add missing hypervisor virtual timer IRQ
      arm64: dts: renesas: r9a07g054: Add missing hypervisor virtual timer IRQ
      pinctrl: renesas: r8a779g0: Fix CANFD5 suffix
      pinctrl: renesas: r8a779g0: Fix FXR_TXEN[AB] suffixes
      pinctrl: renesas: r8a779g0: Fix (H)SCIF1 suffixes
      pinctrl: renesas: r8a779g0: Fix (H)SCIF3 suffixes
      pinctrl: renesas: r8a779g0: Fix IRQ suffixes
      pinctrl: renesas: r8a779g0: FIX PWM suffixes
      pinctrl: renesas: r8a779g0: Fix TCLK suffixes
      pinctrl: renesas: r8a779g0: Fix TPU suffixes

Geliang Tang (4):
      selftests/bpf: Fix prog numbers in test_sockmap
      selftests/bpf: Check length of recv in test_sockmap
      selftests/bpf: Close fd in error path in drop_on_reuseport
      selftests/bpf: Close obj in error path in xdp_adjust_tail

Gerd Bayer (2):
      s390/pci: Refactor arch_setup_msi_irqs()
      s390/pci: Allow allocation of more than 1 MSI interrupt

Greg Kroah-Hartman (1):
      Linux 6.1.103

Gregory CLEMENT (1):
      MIPS: SMP-CPS: Fix address for GCR_ACCESS register for CM3 and later

Guangguan Wang (1):
      net/smc: set rmb's SG_MAX_SINGLE_ALLOC limitation only when CONFIG_ARCH_NO_SG_CHAIN is defined

Guenter Roeck (2):
      hwmon: (max6697) Fix underflow when writing limit attributes
      hwmon: (max6697) Fix swapped temp{1,8} critical alarms

Gwenael Treuveur (1):
      remoteproc: stm32_rproc: Fix mailbox interrupts queuing

Hagar Hemdan (1):
      net: esp: cleanup esp_output_tail_tcp() in case of unsupported ESPINTCP

Hans de Goede (1):
      leds: trigger: Unregister sysfs attributes before calling deactivate()

Hilda Wu (1):
      Bluetooth: btusb: Add RTL8852BE device 0489:e125 to device tables

Honggang LI (1):
      RDMA/rxe: Don't set BTH_ACK_MASK for UC or UD QPs

Hou Tao (1):
      bpf, events: Use prog to emit ksymbol event for main program

Hsiao Chien Sung (2):
      drm/mediatek: Add missing plane settings when async update
      drm/mediatek: Add OVL compatible name for MT8195

Huacai Chen (2):
      PCI: loongson: Enable MSI in LS7A Root Complex
      fs/ntfs3: Update log->page_{mask,bits} if log->page_size changed

Ido Schimmel (6):
      lib: objagg: Fix general protection fault
      mlxsw: spectrum_acl_erp: Fix object nesting warning
      mlxsw: spectrum_acl: Fix ACL scale regression and firmware errors
      ipv4: Fix incorrect TOS in route get reply
      ipv4: Fix incorrect TOS in fibmatch route get reply
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

Ira Weiny (1):
      PCI: Introduce cleanup helpers for device reference counts and locks

Ismael Luceno (1):
      ipvs: Avoid unnecessary calls to skb_is_gso_sctp

Ivan Babrou (1):
      bpftool: Un-const bpf_func_info to fix it for llvm 17 and newer

Jack Wang (1):
      bnxt_re: Fix imm_data endianness

Jacopo Mondi (3):
      media: rcar-vin: Fix YUYV8_1X16 handling for CSI-2
      media: rcar-csi2: Disable runtime_pm in probe error
      media: rcar-csi2: Cleanup subdevice in remove()

James Clark (3):
      perf tests: Fix test_arm_callgraph_fp variable expansion
      perf test: Make test_arm_callgraph_fp.sh more robust
      coresight: Fix ref leak when of_coresight_parse_endpoint() fails

Jan Kara (4):
      ext4: avoid writing unitialized memory to disk in EA inodes
      ext2: Verify bitmap and itable block numbers before using them
      udf: Avoid using corrupted block bitmap buffer
      jbd2: make jbd2_journal_get_max_txn_bufs() internal

Jann Horn (1):
      landlock: Don't lose track of restrictions on cred_transfer

Javier Carrasco (2):
      mfd: omap-usb-tll: Use struct_size to allocate tll
      leds: mt6360: Fix memory leak in mt6360_init_isnk_properties()

Javier Martinez Canillas (1):
      drm/mipi-dsi: Fix mipi_dsi_dcs_write_seq() macro definition format

Jay Buddhabhatti (2):
      soc: xilinx: rename cpu_number1 to dummy_cpu_number
      drivers: soc: xilinx: check return status of get_api_version()

Jeongjun Park (1):
      jfs: Fix array-index-out-of-bounds in diFree

Jerome Brunet (2):
      arm64: dts: amlogic: sm1: fix spdif compatibles
      arm64: dts: amlogic: gx: correct hdmi clocks

Jiaxun Yang (8):
      platform: mips: cpu_hwmon: Disable driver on unsupported hardware
      MIPS: dts: loongson: Add ISA node
      MIPS: ip30: ip30-console: Add missing include
      MIPS: dts: loongson: Fix GMAC phy node
      MIPS: Loongson64: env: Hook up Loongsson-2K
      MIPS: Loongson64: Remove memory node for builtin-dtb
      MIPS: Loongson64: reset: Prioritise firmware service
      MIPS: Loongson64: Test register availability before use

Jinyoung Choi (1):
      block: cleanup bio_integrity_prep

Jiri Olsa (1):
      bpf: Synchronize dispatcher update with bpf_dispatcher_xdp_func

Joe Hattori (1):
      char: tpm: Fix possible memory leak in tpm_bios_measurements_open()

Johannes Berg (6):
      wifi: virt_wifi: don't use strlen() in const context
      wifi: mac80211: track capability/opmode NSS separately
      wifi: mac80211: check basic rates validity
      um: time-travel: fix time-travel-start option
      um: time-travel: fix signal blocking race/hang
      net: bonding: correctly annotate RCU in bond_should_notify_peers()

John David Anglin (1):
      parisc: Fix warning at drivers/pci/msi/msi.h:121

John Stultz (1):
      locking/rwsem: Add __always_inline annotation to __down_write_common() and inlined callers

Jon Pan-Doh (1):
      iommu/vt-d: Fix identity map bounds in si_domain_init()

Jonas Karlman (5):
      arm64: dts: rockchip: Add sdmmc related properties on rk3308-rock-pi-s
      arm64: dts: rockchip: Add pinctrl for UART0 to rk3308-rock-pi-s
      arm64: dts: rockchip: Add mdio and ethernet-phy nodes to rk3308-rock-pi-s
      arm64: dts: rockchip: Update WIFi/BT related nodes on rk3308-rock-pi-s
      arm64: dts: rockchip: Increase VOP clk rate on RK3328

Jonathan Marek (1):
      drm/msm/dsi: set VIDEO_COMPRESSION_MODE_CTRL_WC

Joy Chakraborty (2):
      rtc: cmos: Fix return value of nvmem callbacks
      rtc: isl1208: Fix return value of nvmem callbacks

Junxian Huang (2):
      RDMA/hns: Check atomic wr length
      RDMA/hns: Fix unmatch exception handling when init eq table fails

Kan Liang (1):
      perf/x86/intel/uncore: Fix the bits of the CHA extended umask for SPR

Kees Cook (1):
      kernfs: Convert kernfs_path_from_node_locked() from strlcpy() to strscpy()

Kemeng Shi (2):
      sbitmap: remove unnecessary calculation of alloc_hint in __sbitmap_get_shallow
      sbitmap: rewrite sbitmap_find_bit_in_index to reduce repeat code

Konrad Dybcio (2):
      clk: qcom: branch: Add helper functions for setting retain bits
      interconnect: qcom: qcm2290: Fix mas_snoc_bimc RPM master ID

Konstantin Komarov (10):
      fs/ntfs3: Use ALIGN kernel macro
      fs/ntfs3: Merge synonym COMPRESSION_UNIT and NTFS_LZNT_CUNIT
      fs/ntfs3: Fix transform resident to nonresident for compressed files
      fs/ntfs3: Missed NI_FLAG_UPDATE_PARENT setting
      fs/ntfs3: Fix getting file type
      fs/ntfs3: Add missing .dirty_folio in address_space_operations
      fs/ntfs3: Replace inode_trylock with inode_lock
      fs/ntfs3: Fix field-spanning write in INDEX_HDR
      fs/ntfs3: Missed error return
      fs/ntfs3: Keep runs for $MFT::$ATTR_DATA and $MFT::$ATTR_BITMAP

Krzysztof Kozlowski (2):
      dt-bindings: thermal: correct thermal zone node name limit
      spi: spidev: order compatibles alphabetically

Lad Prabhakar (1):
      arm64: dts: renesas: Drop specifying the GIC_CPU_MASK_SIMPLE() for GICv3 systems

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
      md: fix deadlock between mddev_suspend and flush bio

Lijo Lazar (1):
      drm/amd/pm: Fix aldebaran pcie speed reporting

Liwei Song (1):
      tools/resolve_btfids: Fix comparison of distinct pointer types warning in resolve_btfids

Lorenzo Bianconi (1):
      clk: en7523: fix rate divider for slic and spi clocks

Luca Ceresoli (1):
      Revert "leds: led-core: Fix refcount leak in of_led_get()"

Luca Weiss (1):
      arm64: dts: qcom: sm6350: Add missing qcom,non-secure-domain property

Lucas Stach (2):
      drm/etnaviv: fix DMA direction handling for cached RW buffers
      drm/etnaviv: don't block scheduler when GPU is still active

Luis Henriques (SUSE) (2):
      ext4: fix infinite loop when replaying fast_commit
      ext4: don't track ranges in fast_commit if inode has inlined data

Lukas Wunner (1):
      PCI/DPC: Fix use-after-free on concurrent DPC and hot-removal

Ma Ke (3):
      drm/gma500: fix null pointer dereference in cdv_intel_lvds_get_modes
      drm/gma500: fix null pointer dereference in psb_intel_lvds_get_modes
      phy: cadence-torrent: Check return value on register read

Manish Rangankar (1):
      scsi: qla2xxx: During vport delete send async logout explicitly

Manivannan Sadhasivam (2):
      PCI: qcom-ep: Disable resources unconditionally during PERST# assert
      PCI: rockchip: Use GPIOD_OUT_LOW flag while requesting ep_gpio

Marc Gonzalez (1):
      arm64: dts: qcom: msm8998: enable adreno_smmu by default

Marco Cavenati (1):
      perf/x86/intel/pt: Fix topa_entry base length

Marek Behún (3):
      firmware: turris-mox-rwtm: Do not complete if there are no waiters
      firmware: turris-mox-rwtm: Fix checking return value of wait_for_completion_timeout()
      firmware: turris-mox-rwtm: Initialize completion before mailbox

Marek Vasut (1):
      PCI: rcar: Demote WARN() to dev_warn_ratelimited() in rcar_pcie_wakeup()

Markus Elfring (1):
      auxdisplay: ht16k33: Drop reference after LED registration

Martin Willi (2):
      net: dsa: mv88e6xxx: Limit chip-wide frame size config to CPU ports
      net: dsa: b53: Limit chip-wide jumbo frame config to CPU ports

Masahiro Yamada (1):
      kbuild: avoid build error when single DTB is turned into composite DTB

Matthew Wilcox (Oracle) (2):
      s390/mm: Convert make_page_secure to use a folio
      s390/mm: Convert gmap_make_secure to use a folio

Miaohe Lin (1):
      mm/hugetlb: fix possible recursive locking detected warning

Michael Ellerman (2):
      powerpc/xmon: Fix disassembly CPU feature checks
      selftests/sigaltstack: Fix ppc64 GCC build

Michael S. Tsirkin (1):
      vhost/vsock: always initialize seqpacket_allow

Michael Walle (5):
      ARM: dts: imx6qdl-kontron-samx6i: fix phy-mode
      ARM: dts: imx6qdl-kontron-samx6i: fix PHY reset
      ARM: dts: imx6qdl-kontron-samx6i: fix board reset
      ARM: dts: imx6qdl-kontron-samx6i: fix SPI0 chip selects
      ARM: dts: imx6qdl-kontron-samx6i: fix PCIe reset polarity

Michal Luczaj (1):
      af_unix: Disable MSG_OOB handling for sockets in sockmap/sockhash

Mickaël Salaün (1):
      selftests/landlock: Add cred_transfer test

Mikhail Kobuk (1):
      media: pci: ivtv: Add check for DMA map result

Naga Sureshkumar Relli (1):
      spi: microchip-core: fix the issues in the isr

Namhyung Kim (2):
      perf test: Replace arm callgraph fp test workload with leafloop
      perf report: Fix condition in sort__sym_cmp()

Nathan Chancellor (1):
      kbuild: Fix '-S -c' in x86 stack protector scripts

Nathan Lynch (1):
      powerpc/prom: Add CPU info to hardware description string later

Nayna Jain (1):
      powerpc/pseries: Expose PLPKS config values, support additional fields

NeilBrown (1):
      SUNRPC: avoid soft lockup when transmitting UDP to reachable server.

Nick Bowler (1):
      macintosh/therm_windtunnel: fix module unload.

Nicolas Dichtel (2):
      ipv4: fix source address selection with route leak
      ipv6: take care of scope when choosing the src addr

Niklas Cassel (1):
      PCI: dw-rockchip: Fix initial PERST# GPIO value

Nilesh Javali (1):
      scsi: qla2xxx: validate nvme_local_port correctly

Nitesh Shetty (1):
      block: refactor to use helper

Nitin Gote (1):
      drm/i915/gt: Do not consider preemption during execlists_dequeue for gen8

Nivas Varadharajan Mugunthakumar (1):
      crypto: qat - extend scope of lock in adf_cfg_add_key_value_param()

Olga Kornievskaia (1):
      NFSv4.1 another fix for EXCHGID4_FLAG_USE_PNFS_DS for DS server

Or Har-Toov (1):
      RDMA/mlx5: Use sq timestamp as QP timestamp when RoCE is disabled

Pablo Neira Ayuso (3):
      netfilter: nf_tables: rise cap on SELinux secmark context
      netfilter: ctnetlink: use helper function to calculate expect ID
      net: flow_dissector: use DEBUG_NET_WARN_ON_ONCE

Paolo Pisati (1):
      m68k: amiga: Turn off Warp1260 interrupts during boot

Pavel Begunkov (4):
      kernel: rerun task_work while freezing in get_signal()
      io_uring: tighten task exit cancellations
      io_uring/io-wq: limit retrying worker initialisation
      io_uring: fix io_match_task must_hold

Peng Fan (1):
      pinctrl: freescale: mxs: Fix refcount of child

Petr Machata (1):
      net: nexthop: Initialize all fields in dumped nexthops

Pierre Gondois (1):
      sched/fair: Use all little CPUs for CPU-bound workloads

Pierre-Louis Bossart (1):
      ASoC: Intel: use soc_intel_is_byt_cr() only when IOSF_MBI is reachable

Prajna Rajendra Kumar (1):
      spi: spi-microchip-core: Fix the number of chip selects supported

Primoz Fiser (2):
      cpufreq: ti-cpufreq: Handle deferred probe with dev_err_probe()
      OPP: ti: Fix ti_opp_supply_probe wrong return values

Quinn Tran (3):
      scsi: qla2xxx: Unable to act on RSCN for port online
      scsi: qla2xxx: Use QP lock to search for bsg
      scsi: qla2xxx: Fix flash read failure

Rafael Beims (1):
      wifi: mwifiex: Fix interface type change

Rafał Miłecki (1):
      arm64: dts: mediatek: mt7622: fix "emmc" pinctrl mux

Rameshkumar Sundaram (1):
      wifi: mac80211: Allow NSS change only up to capability

Randy Dunlap (1):
      kernfs: fix all kernel-doc warnings and multiple typos

Ricardo Ribalda (2):
      media: imon: Fix race getting ictx->lock
      media: uvcvideo: Fix integer overflow calculating timestamp

Ross Lagerwall (1):
      decompress_bunzip2: fix rare decompression failure

Russell Currey (3):
      powerpc/pseries: Move plpks.h to include directory
      powerpc/pseries: Add helper to get PLPKS password length
      powerpc/pseries: Avoid hcall in plpks_is_available() on non-pseries

Ryusuke Konishi (2):
      nilfs2: avoid undefined behavior in nilfs_cnt32_ge macro
      nilfs2: handle inconsistent state in nilfs_btnode_create_block()

Samasth Norway Ananda (1):
      wifi: brcmsmac: LCN PHY code is used for BCM4313 2G-only device

Saurav Kashyap (1):
      scsi: qla2xxx: Return ENOBUFS if sg_cnt is more than one for ELS cmds

Sean Christopherson (2):
      KVM: VMX: Split out the non-virtualization part of vmx_interrupt_blocked()
      KVM: nVMX: Request immediate exit iff pending nested event needs injection

Seth Forshee (DigitalOcean) (1):
      fs: don't allow non-init s_user_ns for filesystems without FS_USERNS_MOUNT

Sheng Yong (1):
      f2fs: fix start segno of large section

Shenwei Wang (1):
      irqchip/imx-irqsteer: Handle runtime power management correctly

Shigeru Yoshida (1):
      tipc: Return non-zero value from tipc_udp_addr2str() on error

Shreyas Deodhar (3):
      scsi: qla2xxx: Fix optrom version displayed in FDMI
      scsi: qla2xxx: Fix for possible memory corruption
      scsi: qla2xxx: Complete command early within lock

Siddharth Vadapalli (2):
      PCI: keystone: Relocate ks_pcie_set/clear_dbi_mode()
      PCI: keystone: Don't enable BAR 0 for AM654x

Simon Horman (1):
      net: stmmac: Correct byte order of perfect_match

Sourabh Jain (2):
      powerpc/kexec: make the update_cpus_node() function public
      powerpc/kexec_file: fix cpus node update to FDT

Spoorthy S (1):
      perf tests arm_callgraph_fp: Address shellcheck warnings about signal names and adding double quotes for expression

Stephen Boyd (2):
      soc: qcom: rpmh-rsc: Ensure irqs aren't disabled by rpmh_rsc_send_data() callers
      clk: qcom: Park shared RCGs upon registration

Steve French (3):
      cifs: fix potential null pointer use in destroy_workqueue in init_cifs error path
      cifs: fix reconnect with SMB1 UNIX Extensions
      cifs: mount with "unix" mount option for SMB1 incorrectly handled

Steve Wilkins (2):
      spi: microchip-core: only disable SPI controller when register value change requires it
      spi: microchip-core: fix init function not setting the master and motorola modes

Sung Joon Kim (1):
      drm/amd/display: Check for NULL pointer

Taehee Yoo (1):
      xdp: fix invalid wait context of page_pool_destroy()

Takashi Iwai (2):
      ALSA: usb-audio: Move HD Webcam quirk to the right place
      ASoC: amd: yc: Support mic on Lenovo Thinkpad E16 Gen 2

Taniya Das (3):
      clk: qcom: gcc-sc7280: Update force mem core bit for UFS ICE clock
      clk: qcom: camcc-sc7280: Add parent dependency to all camera GDSCs
      clk: qcom: gpucc-sm8350: Park RCG's clk source at XO during disable

Tao Chen (1):
      bpftool: Mount bpffs when pinmaps path not under the bpffs

Tejun Heo (1):
      sched/fair: set_load_weight() must also call reweight_task() for SCHED_IDLE tasks

Tengda Wu (1):
      bpf: Fix null pointer dereference in resolve_prog_type() for BPF_PROG_TYPE_EXT

Tetsuo Handa (1):
      mm: mmap_lock: replace get_memcg_path_buf() with on-stack buffer

Thomas Gleixner (3):
      perf/x86: Serialize set_attr_rdpmc()
      jump_label: Fix concurrency issues in static_key_slow_dec()
      watchdog/perf: properly initialize the turbo mode timestamp and rearm counter

Thorsten Blum (1):
      m68k: cmpxchg: Fix return value for default case in __arch_xchg()

Tim Van Patten (1):
      drm/amdgpu: Remove GC HW IP 9.3.0 from noretry=1

Tvrtko Ursulin (1):
      mm/numa_balancing: teach mpol_to_str about the balancing mode

Tzung-Bi Shih (1):
      platform/chrome: cros_ec_debugfs: fix wrong EC message version

Uros Bizjak (1):
      jump_label: Use atomic_try_cmpxchg() in static_key_slow_inc_cpuslocked()

Uwe Kleine-König (6):
      pwm: stm32: Always do lazy disabling
      pwm: atmel-tcb: Put per-channel data into driver data
      pwm: atmel-tcb: Unroll atmel_tcb_pwm_set_polarity() into only caller
      pwm: atmel-tcb: Don't track polarity in driver data
      pwm: atmel-tcb: Fix race condition and convert to guards
      pinctrl: ti: ti-iodelay: Drop if block with always false condition

Vignesh Raghavendra (1):
      dmaengine: ti: k3-udma: Fix BCHAN count with UHC and HC channels

Vincent Tremblay (1):
      spidev: Add Silicon Labs EM3581 device compatible

WangYuli (1):
      Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x13d3:0x3591

Wayne Lin (1):
      drm/dp_mst: Fix all mstb marked as not probed after suspend/resume

Wayne Tung (1):
      hwmon: (adt7475) Fix default duty on fan is disabled

Wei Liu (1):
      PCI: hv: Return zero, not garbage, when reading PCI_INTERRUPT_PIN

Xiao Liang (1):
      apparmor: Fix null pointer deref when receiving skb during sock creation

Yanfei Xu (1):
      iommu/vt-d: Fix to convert mm pfn to dma pfn

Yang Yang (1):
      sbitmap: fix io hung due to race on sbitmap_word::cleared

Yang Yingliang (4):
      pinctrl: core: fix possible memory leak when pinctrl_enable() fails
      pinctrl: single: fix possible memory leak when pinctrl_enable() fails
      pinctrl: ti: ti-iodelay: fix possible memory leak when pinctrl_enable() fails
      spi: microchip-core: switch to use modern name

Yao Zi (1):
      drm/meson: fix canvas release in bind function

Yu Liao (1):
      tick/broadcast: Make takeover of broadcast hrtimer reliable

Yu Zhao (1):
      mm/mglru: fix div-by-zero in vmpressure_calc_level()

Zhang Rui (1):
      perf/x86/intel/cstate: Fix Alderlake/Raptorlake/Meteorlake

Zheng Yejian (1):
      media: dvb-usb: Fix unexpected infinite loop in dvb_usb_read_remote_control()

Zijun Hu (3):
      kobject_uevent: Fix OOB access within zap_modalias_env()
      devres: Fix devm_krealloc() wasting memory
      devres: Fix memory leakage caused by driver API devm_free_percpu()

ethanwu (1):
      ceph: fix incorrect kmalloc size of pagevec mempool

levi.yun (1):
      trace/pid_list: Change gfp flags in pid_list_fill_irq()

linke li (1):
      sbitmap: use READ_ONCE to access map->word

tuhaowen (1):
      dev/parport: fix the array out-of-bounds risk

wangdicheng (2):
      ALSA: usb-audio: Fix microphone sound on HD webcam.
      ALSA: usb-audio: Add a quirk for Sonix HD USB Camera


