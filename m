Return-Path: <stable+bounces-50215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A3F904F76
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 11:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F249C1F2143B
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 09:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104CF16DEC9;
	Wed, 12 Jun 2024 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sGnc4Ylm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C7242052;
	Wed, 12 Jun 2024 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718185416; cv=none; b=kmFptMsnjcnDqd9NKu6sPNeYq//UNAd6hUTVOOXTQQqOvprCdBGCxJXslImsHQNWpiSgwKDsWqPtboxrYB67ushsqqmuTnnboWYg+UT0Kl6UuHJvJj9c1DNfPHoMIBknrJ1+coGKmggNs35vLBPzJhueaMHD4ywvLWmgIOnwxPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718185416; c=relaxed/simple;
	bh=WkjkSjS9V7LqKy7DNKPwPos2HzTYfvD9aHwn6chxYus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HFeQFCmolggSvICdhn6thavS7eIvAtjM+e/68CXSG6o7Nh6Ogf1OkkyUeRlDlddsRfUae1HFwH23jc6YXjrBFx8ocAEb1E/o1UseMQo+WG+m+4UvmvSMVKoQ5jAub8dccASe62ACJZsFkyZvsCjkRJHTBri10NDM3VDh14bE1mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sGnc4Ylm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE58C3277B;
	Wed, 12 Jun 2024 09:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718185415;
	bh=WkjkSjS9V7LqKy7DNKPwPos2HzTYfvD9aHwn6chxYus=;
	h=From:To:Cc:Subject:Date:From;
	b=sGnc4YlmrA9u3zcoGJjYGxFB8o8ur0z0JVwNsNCGTLiWfhVGzjXF+LxYs/I6pHYuK
	 a0Yjyiia8af3xH00wntGWv58TmEcHeokAa7i+eTSLMgTN6rMebkmvcJbyFf38IW24N
	 hHCBgkB6HW/Zpxptih+0bhbATv6VTpCF2dNcLR3s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.93
Date: Wed, 12 Jun 2024 11:43:29 +0200
Message-ID: <2024061229-neuter-whooping-632b@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.93 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/media/i2c/ovti,ov2680.yaml           |   18 
 Documentation/devicetree/bindings/pci/rcar-pci-host.yaml               |   14 
 Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml |   92 +-
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml                |    1 
 Documentation/devicetree/bindings/sound/rt5645.txt                     |    6 
 Documentation/driver-api/fpga/fpga-region.rst                          |   13 
 Documentation/networking/device_drivers/ethernet/amazon/ena.rst        |   32 
 Makefile                                                               |    2 
 arch/arm/configs/sunxi_defconfig                                       |    1 
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi                              |   13 
 arch/arm64/include/asm/asm-bug.h                                       |    1 
 arch/loongarch/include/asm/perf_event.h                                |    3 
 arch/loongarch/kernel/perf_event.c                                     |    2 
 arch/m68k/kernel/entry.S                                               |    4 
 arch/m68k/mac/misc.c                                                   |   36 -
 arch/microblaze/kernel/Makefile                                        |    1 
 arch/microblaze/kernel/cpu/cpuinfo-static.c                            |    2 
 arch/parisc/kernel/parisc_ksyms.c                                      |    1 
 arch/powerpc/include/asm/hvcall.h                                      |    2 
 arch/powerpc/platforms/pseries/lpar.c                                  |    6 
 arch/powerpc/platforms/pseries/lparcfg.c                               |   10 
 arch/powerpc/sysdev/fsl_msi.c                                          |    2 
 arch/riscv/kernel/cpu_ops_sbi.c                                        |    2 
 arch/riscv/kernel/cpu_ops_spinwait.c                                   |    3 
 arch/riscv/kernel/entry.S                                              |    3 
 arch/riscv/kernel/stacktrace.c                                         |   29 
 arch/riscv/net/bpf_jit_comp64.c                                        |   20 
 arch/s390/boot/startup.c                                               |    1 
 arch/s390/kernel/ipl.c                                                 |   10 
 arch/s390/kernel/setup.c                                               |    2 
 arch/s390/kernel/vdso32/Makefile                                       |    5 
 arch/s390/kernel/vdso64/Makefile                                       |    6 
 arch/s390/net/bpf_jit_comp.c                                           |    8 
 arch/sh/kernel/kprobes.c                                               |    7 
 arch/sh/lib/checksum.S                                                 |   67 --
 arch/um/drivers/line.c                                                 |   14 
 arch/um/drivers/ubd_kern.c                                             |    4 
 arch/um/drivers/vector_kern.c                                          |    2 
 arch/um/include/asm/kasan.h                                            |    1 
 arch/um/include/asm/mmu.h                                              |    2 
 arch/um/include/asm/processor-generic.h                                |    1 
 arch/um/include/shared/kern_util.h                                     |    2 
 arch/um/include/shared/skas/mm_id.h                                    |    2 
 arch/um/os-Linux/mem.c                                                 |    1 
 arch/x86/Kconfig.debug                                                 |    5 
 arch/x86/boot/compressed/head_64.S                                     |    5 
 arch/x86/crypto/nh-avx2-x86_64.S                                       |    1 
 arch/x86/crypto/sha256-avx2-asm.S                                      |    1 
 arch/x86/crypto/sha512-avx2-asm.S                                      |    1 
 arch/x86/entry/vsyscall/vsyscall_64.c                                  |   28 
 arch/x86/include/asm/pgtable_types.h                                   |    2 
 arch/x86/include/asm/processor.h                                       |    1 
 arch/x86/include/asm/sparsemem.h                                       |    2 
 arch/x86/kernel/apic/vector.c                                          |    9 
 arch/x86/kernel/tsc_sync.c                                             |    6 
 arch/x86/kvm/cpuid.c                                                   |   21 
 arch/x86/lib/x86-opcode-map.txt                                        |   10 
 arch/x86/mm/fault.c                                                    |   33 -
 arch/x86/mm/numa.c                                                     |    4 
 arch/x86/mm/pat/set_memory.c                                           |   68 +-
 arch/x86/purgatory/Makefile                                            |    3 
 arch/x86/tools/relocs.c                                                |    9 
 arch/x86/um/shared/sysdep/archsetjmp.h                                 |    7 
 block/blk-core.c                                                       |    9 
 block/blk-merge.c                                                      |    2 
 block/blk-mq.c                                                         |   60 -
 block/blk.h                                                            |    1 
 block/genhd.c                                                          |    2 
 crypto/asymmetric_keys/Kconfig                                         |    2 
 drivers/accessibility/speakup/main.c                                   |    2 
 drivers/acpi/acpi_lpss.c                                               |    1 
 drivers/acpi/acpica/Makefile                                           |    1 
 drivers/acpi/numa/srat.c                                               |    5 
 drivers/block/null_blk/main.c                                          |    3 
 drivers/bluetooth/btqca.c                                              |    4 
 drivers/char/ppdev.c                                                   |   21 
 drivers/clk/clk-renesas-pcie.c                                         |   10 
 drivers/clk/mediatek/clk-mt8365-mm.c                                   |    2 
 drivers/clk/qcom/dispcc-sm6350.c                                       |   11 
 drivers/clk/qcom/dispcc-sm8450.c                                       |   20 
 drivers/clk/qcom/mmcc-msm8998.c                                        |    8 
 drivers/clk/renesas/r8a779a0-cpg-mssr.c                                |    2 
 drivers/clk/renesas/r9a07g043-cpg.c                                    |    9 
 drivers/clk/samsung/clk-exynosautov9.c                                 |    8 
 drivers/cpufreq/cppc_cpufreq.c                                         |   14 
 drivers/cpufreq/cpufreq.c                                              |   11 
 drivers/crypto/bcm/spu2.c                                              |    2 
 drivers/crypto/ccp/sp-platform.c                                       |   14 
 drivers/dma-buf/sync_debug.c                                           |    4 
 drivers/dma/idma64.c                                                   |    4 
 drivers/extcon/Kconfig                                                 |    3 
 drivers/firmware/dmi-id.c                                              |    7 
 drivers/firmware/efi/libstub/fdt.c                                     |    4 
 drivers/firmware/efi/libstub/x86-stub.c                                |   28 
 drivers/firmware/raspberrypi.c                                         |    7 
 drivers/fpga/dfl-pci.c                                                 |    3 
 drivers/fpga/fpga-region.c                                             |   24 
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c                                |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c                             |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                                 |    3 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                                 |    3 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                                  |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                               |    8 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                      |    1 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c         |    8 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c                 |    5 
 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c                   |    2 
 drivers/gpu/drm/arm/malidp_mw.c                                        |    5 
 drivers/gpu/drm/bridge/analogix/anx7625.c                              |    6 
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c                    |    3 
 drivers/gpu/drm/bridge/chipone-icn6211.c                               |    6 
 drivers/gpu/drm/bridge/lontium-lt8912b.c                               |    6 
 drivers/gpu/drm/bridge/lontium-lt9611.c                                |    6 
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c                             |    6 
 drivers/gpu/drm/bridge/tc358775.c                                      |   27 
 drivers/gpu/drm/bridge/ti-dlpc3433.c                                   |   17 
 drivers/gpu/drm/bridge/ti-sn65dsi83.c                                  |    1 
 drivers/gpu/drm/display/drm_dp_helper.c                                |   35 +
 drivers/gpu/drm/drm_bridge.c                                           |   10 
 drivers/gpu/drm/drm_mipi_dsi.c                                         |    6 
 drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h                          |    6 
 drivers/gpu/drm/mediatek/Kconfig                                       |    1 
 drivers/gpu/drm/mediatek/mtk_dp.c                                      |  137 +++-
 drivers/gpu/drm/mediatek/mtk_drm_gem.c                                 |    3 
 drivers/gpu/drm/meson/meson_vclk.c                                     |    6 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                                  |   17 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c                   |    3 
 drivers/gpu/drm/msm/dp/dp_aux.c                                        |   32 
 drivers/gpu/drm/msm/dp/dp_aux.h                                        |    3 
 drivers/gpu/drm/msm/dp/dp_ctrl.c                                       |   16 
 drivers/gpu/drm/msm/dp/dp_ctrl.h                                       |    2 
 drivers/gpu/drm/msm/dp/dp_display.c                                    |   12 
 drivers/gpu/drm/msm/dp/dp_link.c                                       |   22 
 drivers/gpu/drm/msm/dp/dp_link.h                                       |   14 
 drivers/gpu/drm/msm/dsi/dsi_host.c                                     |   10 
 drivers/gpu/drm/mxsfb/lcdif_drv.c                                      |    6 
 drivers/gpu/drm/panel/panel-edp.c                                      |    3 
 drivers/gpu/drm/panel/panel-novatek-nt35950.c                          |    6 
 drivers/gpu/drm/panel/panel-samsung-atna33xc20.c                       |   32 
 drivers/gpu/drm/panel/panel-simple.c                                   |    3 
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c                           |   22 
 drivers/gpu/drm/vc4/vc4_hdmi.c                                         |    2 
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c                          |   10 
 drivers/hid/intel-ish-hid/ipc/pci-ish.c                                |    5 
 drivers/hwmon/shtc1.c                                                  |    2 
 drivers/hwtracing/coresight/coresight-etm4x-core.c                     |   29 
 drivers/hwtracing/coresight/coresight-etm4x.h                          |   31 
 drivers/hwtracing/stm/core.c                                           |   11 
 drivers/iio/adc/stm32-adc.c                                            |    1 
 drivers/iio/industrialio-core.c                                        |    6 
 drivers/iio/pressure/dps310.c                                          |   11 
 drivers/infiniband/hw/hns/hns_roce_cq.c                                |   24 
 drivers/infiniband/hw/hns/hns_roce_hem.h                               |   12 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                             |    7 
 drivers/infiniband/hw/hns/hns_roce_main.c                              |    1 
 drivers/infiniband/hw/hns/hns_roce_mr.c                                |   15 
 drivers/infiniband/hw/hns/hns_roce_srq.c                               |    6 
 drivers/infiniband/hw/mlx5/mem.c                                       |    8 
 drivers/infiniband/hw/mlx5/mr.c                                        |    3 
 drivers/infiniband/sw/rxe/rxe_comp.c                                   |    6 
 drivers/infiniband/sw/rxe/rxe_net.c                                    |   46 -
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c                              |    8 
 drivers/input/misc/ims-pcu.c                                           |    4 
 drivers/input/misc/pm8xxx-vibrator.c                                   |    7 
 drivers/input/mouse/cyapa.c                                            |   12 
 drivers/input/serio/ioc3kbd.c                                          |   13 
 drivers/interconnect/qcom/qcm2290.c                                    |    2 
 drivers/irqchip/irq-alpine-msi.c                                       |    2 
 drivers/irqchip/irq-loongson-pch-msi.c                                 |    2 
 drivers/macintosh/via-macii.c                                          |   11 
 drivers/md/md-bitmap.c                                                 |    6 
 drivers/media/cec/core/cec-adap.c                                      |   24 
 drivers/media/cec/core/cec-api.c                                       |    5 
 drivers/media/pci/intel/ipu3/ipu3-cio2-main.c                          |   10 
 drivers/media/pci/ngene/ngene-core.c                                   |    4 
 drivers/media/platform/renesas/rcar-vin/rcar-vin.h                     |    2 
 drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig              |    1 
 drivers/media/radio/radio-shark2.c                                     |    2 
 drivers/media/usb/b2c2/flexcop-usb.c                                   |    2 
 drivers/media/usb/stk1160/stk1160-video.c                              |   20 
 drivers/misc/vmw_vmci/vmci_guest.c                                     |   10 
 drivers/mmc/host/sdhci_am654.c                                         |  205 ++++--
 drivers/mtd/mtdcore.c                                                  |    6 
 drivers/mtd/nand/raw/nand_hynix.c                                      |    2 
 drivers/net/Makefile                                                   |    4 
 drivers/net/dsa/microchip/ksz_common.c                                 |    2 
 drivers/net/dsa/mv88e6xxx/chip.c                                       |   50 +
 drivers/net/dsa/mv88e6xxx/chip.h                                       |    6 
 drivers/net/dsa/mv88e6xxx/global1.c                                    |   89 ++
 drivers/net/dsa/mv88e6xxx/global1.h                                    |    2 
 drivers/net/ethernet/amazon/ena/ena_admin_defs.h                       |    6 
 drivers/net/ethernet/amazon/ena/ena_com.c                              |  326 +++-------
 drivers/net/ethernet/amazon/ena/ena_eth_com.c                          |   49 -
 drivers/net/ethernet/amazon/ena/ena_eth_com.h                          |   15 
 drivers/net/ethernet/amazon/ena/ena_netdev.c                           |  163 +++--
 drivers/net/ethernet/amazon/ena/ena_netdev.h                           |    4 
 drivers/net/ethernet/cisco/enic/enic_main.c                            |   12 
 drivers/net/ethernet/cortina/gemini.c                                  |   12 
 drivers/net/ethernet/freescale/fec_main.c                              |   10 
 drivers/net/ethernet/freescale/fec_ptp.c                               |   14 
 drivers/net/ethernet/intel/ice/ice_ethtool.c                           |   19 
 drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c                      |   11 
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h                          |    3 
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c                          |   56 -
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c                          |   44 +
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c                    |    9 
 drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c                 |   23 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h            |    8 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h          |   17 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                      |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c                        |    6 
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c                      |   12 
 drivers/net/ethernet/qlogic/qed/qed_main.c                             |    9 
 drivers/net/ethernet/realtek/r8169_main.c                              |    9 
 drivers/net/ethernet/smsc/smc91x.h                                     |    4 
 drivers/net/ethernet/sun/sungem.c                                      |   14 
 drivers/net/ipvlan/ipvlan_core.c                                       |    4 
 drivers/net/phy/micrel.c                                               |    1 
 drivers/net/usb/aqc111.c                                               |    8 
 drivers/net/usb/qmi_wwan.c                                             |    3 
 drivers/net/usb/smsc95xx.c                                             |   26 
 drivers/net/usb/sr9700.c                                               |   10 
 drivers/net/wireless/ath/ar5523/ar5523.c                               |   14 
 drivers/net/wireless/ath/ath10k/core.c                                 |    3 
 drivers/net/wireless/ath/ath10k/debugfs_sta.c                          |    2 
 drivers/net/wireless/ath/ath10k/hw.h                                   |    1 
 drivers/net/wireless/ath/ath10k/targaddrs.h                            |    3 
 drivers/net/wireless/ath/ath10k/wmi.c                                  |   26 
 drivers/net/wireless/ath/ath11k/mac.c                                  |    9 
 drivers/net/wireless/ath/carl9170/tx.c                                 |    3 
 drivers/net/wireless/ath/carl9170/usb.c                                |   32 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c                |   15 
 drivers/net/wireless/marvell/mwl8k.c                                   |    2 
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c                        |    1 
 drivers/nvme/host/multipath.c                                          |    3 
 drivers/nvme/target/auth.c                                             |    8 
 drivers/nvme/target/configfs.c                                         |   20 
 drivers/nvme/target/core.c                                             |    5 
 drivers/nvme/target/nvmet.h                                            |    1 
 drivers/nvme/target/tcp.c                                              |   11 
 drivers/pci/controller/dwc/pcie-tegra194.c                             |    3 
 drivers/pci/pcie/edr.c                                                 |   28 
 drivers/perf/arm_dmc620_pmu.c                                          |    9 
 drivers/perf/hisilicon/hisi_pcie_pmu.c                                 |   14 
 drivers/perf/hisilicon/hns3_pmu.c                                      |   16 
 drivers/pwm/pwm-sti.c                                                  |   48 -
 drivers/regulator/bd71828-regulator.c                                  |   58 -
 drivers/regulator/irq_helpers.c                                        |    3 
 drivers/regulator/vqmmc-ipq4019-regulator.c                            |    1 
 drivers/s390/cio/trace.h                                               |    2 
 drivers/scsi/bfa/bfad_debugfs.c                                        |    4 
 drivers/scsi/hpsa.c                                                    |    2 
 drivers/scsi/libsas/sas_expander.c                                     |    3 
 drivers/scsi/qedf/qedf_debugfs.c                                       |    2 
 drivers/scsi/qla2xxx/qla_dfs.c                                         |    2 
 drivers/scsi/qla2xxx/qla_init.c                                        |    8 
 drivers/scsi/qla2xxx/qla_mr.c                                          |   20 
 drivers/soc/mediatek/mtk-cmdq-helper.c                                 |    5 
 drivers/soundwire/cadence_master.c                                     |    2 
 drivers/spi/spi-stm32.c                                                |    2 
 drivers/spi/spi.c                                                      |    4 
 drivers/staging/greybus/arche-apb-ctrl.c                               |    1 
 drivers/staging/greybus/arche-platform.c                               |    9 
 drivers/staging/greybus/light.c                                        |    8 
 drivers/staging/media/atomisp/pci/sh_css.c                             |    1 
 drivers/thermal/qcom/tsens.c                                           |    2 
 drivers/tty/n_gsm.c                                                    |  140 ++--
 drivers/tty/serial/8250/8250_bcm7271.c                                 |  101 +--
 drivers/tty/serial/8250/8250_mtk.c                                     |    8 
 drivers/tty/serial/max3100.c                                           |   22 
 drivers/tty/serial/sc16is7xx.c                                         |    2 
 drivers/tty/serial/sh-sci.c                                            |    5 
 drivers/ufs/core/ufshcd.c                                              |    4 
 drivers/ufs/host/cdns-pltfrm.c                                         |    2 
 drivers/ufs/host/ufs-qcom.c                                            |   13 
 drivers/ufs/host/ufs-qcom.h                                            |   21 
 drivers/usb/gadget/function/u_audio.c                                  |   21 
 drivers/video/fbdev/Kconfig                                            |    4 
 drivers/video/fbdev/sh_mobile_lcdcfb.c                                 |    2 
 drivers/video/fbdev/sis/init301.c                                      |    3 
 drivers/virt/acrn/mm.c                                                 |   61 +
 drivers/virtio/virtio_pci_common.c                                     |    4 
 drivers/watchdog/bd9576_wdt.c                                          |   12 
 drivers/watchdog/sa1100_wdt.c                                          |    5 
 drivers/xen/xenbus/xenbus_probe.c                                      |   36 -
 fs/ecryptfs/keystore.c                                                 |    4 
 fs/eventpoll.c                                                         |   38 +
 fs/ext4/mballoc.c                                                      |  134 ++--
 fs/ext4/namei.c                                                        |    2 
 fs/f2fs/checkpoint.c                                                   |    4 
 fs/f2fs/compress.c                                                     |    2 
 fs/f2fs/data.c                                                         |   10 
 fs/f2fs/extent_cache.c                                                 |    4 
 fs/f2fs/file.c                                                         |   96 +-
 fs/f2fs/gc.c                                                           |    9 
 fs/f2fs/namei.c                                                        |    2 
 fs/f2fs/node.c                                                         |    2 
 fs/f2fs/segment.c                                                      |    2 
 fs/gfs2/glock.c                                                        |    4 
 fs/gfs2/glops.c                                                        |    3 
 fs/gfs2/util.c                                                         |    1 
 fs/jffs2/xattr.c                                                       |    3 
 fs/nfs/filelayout/filelayout.c                                         |    4 
 fs/nfs/fs_context.c                                                    |    9 
 fs/nfs/nfs4state.c                                                     |   12 
 fs/nilfs2/ioctl.c                                                      |    2 
 fs/nilfs2/segment.c                                                    |   38 -
 fs/ntfs3/dir.c                                                         |    1 
 fs/ntfs3/fslog.c                                                       |    3 
 fs/ntfs3/index.c                                                       |    6 
 fs/ntfs3/inode.c                                                       |    7 
 fs/ntfs3/ntfs.h                                                        |    2 
 fs/ntfs3/record.c                                                      |   11 
 fs/ntfs3/super.c                                                       |    2 
 fs/openpromfs/inode.c                                                  |    8 
 fs/overlayfs/dir.c                                                     |    3 
 fs/smb/server/mgmt/share_config.c                                      |    6 
 fs/smb/server/oplock.c                                                 |   21 
 include/drm/display/drm_dp_helper.h                                    |    6 
 include/drm/drm_mipi_dsi.h                                             |    6 
 include/linux/acpi.h                                                   |    2 
 include/linux/bitops.h                                                 |    1 
 include/linux/counter.h                                                |    1 
 include/linux/dev_printk.h                                             |   25 
 include/linux/fpga/fpga-region.h                                       |   13 
 include/linux/mlx5/driver.h                                            |    1 
 include/linux/numa.h                                                   |   26 
 include/linux/printk.h                                                 |    2 
 include/linux/skbuff.h                                                 |   19 
 include/media/cec.h                                                    |    1 
 include/net/ax25.h                                                     |    3 
 include/net/bluetooth/bluetooth.h                                      |    2 
 include/net/bluetooth/l2cap.h                                          |   11 
 include/net/inet6_hashtables.h                                         |   16 
 include/net/inet_common.h                                              |    2 
 include/net/inet_hashtables.h                                          |   18 
 include/net/mac80211.h                                                 |    3 
 include/net/netfilter/nf_tables_core.h                                 |   10 
 include/trace/events/asoc.h                                            |    2 
 include/uapi/linux/bpf.h                                               |    2 
 io_uring/io_uring.h                                                    |    3 
 io_uring/nop.c                                                         |    2 
 kernel/Makefile                                                        |    1 
 kernel/bpf/verifier.c                                                  |   10 
 kernel/cgroup/cpuset.c                                                 |    2 
 kernel/dma/map_benchmark.c                                             |    6 
 kernel/irq/cpuhotplug.c                                                |   16 
 kernel/numa.c                                                          |   26 
 kernel/rcu/tasks.h                                                     |    2 
 kernel/rcu/tree_stall.h                                                |    3 
 kernel/sched/core.c                                                    |    2 
 kernel/sched/fair.c                                                    |   53 +
 kernel/sched/isolation.c                                               |    7 
 kernel/sched/topology.c                                                |    2 
 kernel/softirq.c                                                       |   12 
 kernel/trace/ftrace.c                                                  |   39 -
 kernel/trace/ring_buffer.c                                             |    9 
 kernel/trace/rv/rv.c                                                   |    2 
 lib/kunit/try-catch.c                                                  |    9 
 lib/slub_kunit.c                                                       |    2 
 lib/test_hmm.c                                                         |    8 
 net/ax25/ax25_dev.c                                                    |   48 -
 net/bluetooth/af_bluetooth.c                                           |   21 
 net/bluetooth/bnep/sock.c                                              |   10 
 net/bluetooth/hci_sock.c                                               |   10 
 net/bluetooth/iso.c                                                    |   10 
 net/bluetooth/l2cap_core.c                                             |   56 +
 net/bluetooth/l2cap_sock.c                                             |   99 ++-
 net/bluetooth/rfcomm/sock.c                                            |   13 
 net/bluetooth/sco.c                                                    |   10 
 net/bridge/br_device.c                                                 |    6 
 net/bridge/br_mst.c                                                    |   16 
 net/core/dev.c                                                         |    3 
 net/ipv4/af_inet.c                                                     |   34 -
 net/ipv4/inet_hashtables.c                                             |   29 
 net/ipv4/netfilter/nf_tproxy_ipv4.c                                    |    2 
 net/ipv4/tcp_dctcp.c                                                   |   13 
 net/ipv4/tcp_ipv4.c                                                    |   13 
 net/ipv4/udp.c                                                         |   55 -
 net/ipv6/inet6_hashtables.c                                            |   27 
 net/ipv6/reassembly.c                                                  |    2 
 net/ipv6/seg6.c                                                        |    5 
 net/ipv6/seg6_hmac.c                                                   |   42 -
 net/ipv6/seg6_iptunnel.c                                               |   11 
 net/ipv6/udp.c                                                         |   61 -
 net/mac80211/mlme.c                                                    |    3 
 net/mac80211/rate.c                                                    |    6 
 net/mac80211/scan.c                                                    |    1 
 net/mac80211/tx.c                                                      |   13 
 net/mptcp/sockopt.c                                                    |    2 
 net/netfilter/nfnetlink_queue.c                                        |    2 
 net/netfilter/nft_fib.c                                                |    8 
 net/netfilter/nft_payload.c                                            |  111 ++-
 net/netrom/nr_route.c                                                  |   19 
 net/nfc/nci/core.c                                                     |   17 
 net/openvswitch/actions.c                                              |    6 
 net/openvswitch/flow.c                                                 |    3 
 net/packet/af_packet.c                                                 |    3 
 net/qrtr/ns.c                                                          |   27 
 net/sunrpc/auth_gss/svcauth_gss.c                                      |   12 
 net/sunrpc/clnt.c                                                      |    1 
 net/sunrpc/svc.c                                                       |    2 
 net/sunrpc/xprtrdma/verbs.c                                            |    6 
 net/tls/tls_main.c                                                     |   10 
 net/unix/af_unix.c                                                     |   39 -
 net/wireless/trace.h                                                   |    4 
 scripts/kconfig/symbol.c                                               |    6 
 sound/core/init.c                                                      |   20 
 sound/core/jack.c                                                      |   46 -
 sound/core/timer.c                                                     |   10 
 sound/hda/intel-dsp-config.c                                           |   27 
 sound/pci/hda/hda_cs_dsp_ctl.c                                         |   47 -
 sound/pci/hda/patch_realtek.c                                          |   16 
 sound/soc/codecs/da7219-aad.c                                          |    6 
 sound/soc/codecs/rt5645.c                                              |   25 
 sound/soc/codecs/rt715-sdca.c                                          |    8 
 sound/soc/codecs/rt715-sdw.c                                           |    1 
 sound/soc/codecs/tas2552.c                                             |   15 
 sound/soc/intel/avs/boards/ssm4567.c                                   |    1 
 sound/soc/intel/avs/cldma.c                                            |    2 
 sound/soc/intel/avs/path.c                                             |    1 
 sound/soc/intel/boards/bxt_da7219_max98357a.c                          |    1 
 sound/soc/intel/boards/bxt_rt298.c                                     |    1 
 sound/soc/intel/boards/bytcr_rt5640.c                                  |   14 
 sound/soc/intel/boards/glk_rt5682_max98357a.c                          |    2 
 sound/soc/intel/boards/kbl_da7219_max98357a.c                          |    1 
 sound/soc/intel/boards/kbl_da7219_max98927.c                           |    4 
 sound/soc/intel/boards/kbl_rt5660.c                                    |    1 
 sound/soc/intel/boards/kbl_rt5663_max98927.c                           |    2 
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c                    |    1 
 sound/soc/intel/boards/skl_hda_dsp_generic.c                           |    2 
 sound/soc/intel/boards/skl_nau88l25_max98357a.c                        |    1 
 sound/soc/intel/boards/skl_rt286.c                                     |    1 
 sound/soc/kirkwood/kirkwood-dma.c                                      |    3 
 sound/soc/mediatek/mt8192/mt8192-dai-tdm.c                             |    4 
 tools/arch/x86/lib/x86-opcode-map.txt                                  |   10 
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c                              |    4 
 tools/bpf/resolve_btfids/main.c                                        |    2 
 tools/include/nolibc/stdlib.h                                          |    2 
 tools/include/uapi/linux/bpf.h                                         |    2 
 tools/lib/bpf/libbpf.c                                                 |    2 
 tools/lib/subcmd/parse-options.c                                       |    8 
 tools/perf/Documentation/perf-list.txt                                 |    1 
 tools/perf/bench/inject-buildid.c                                      |    2 
 tools/perf/builtin-annotate.c                                          |    2 
 tools/perf/builtin-daemon.c                                            |    4 
 tools/perf/builtin-record.c                                            |    4 
 tools/perf/builtin-report.c                                            |    2 
 tools/perf/tests/Build                                                 |    2 
 tools/perf/tests/builtin-test.c                                        |   29 
 tools/perf/tests/tests.h                                               |   27 
 tools/perf/tests/workloads/Build                                       |   13 
 tools/perf/tests/workloads/brstack.c                                   |   40 +
 tools/perf/tests/workloads/datasym.c                                   |   40 +
 tools/perf/tests/workloads/leafloop.c                                  |   34 +
 tools/perf/tests/workloads/noploop.c                                   |   32 
 tools/perf/tests/workloads/sqrtloop.c                                  |   45 +
 tools/perf/tests/workloads/thloop.c                                    |   53 +
 tools/perf/ui/browser.c                                                |    6 
 tools/perf/ui/browser.h                                                |    2 
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c                    |    2 
 tools/perf/util/intel-pt.c                                             |    2 
 tools/perf/util/probe-event.c                                          |    1 
 tools/perf/util/stat-display.c                                         |    3 
 tools/testing/selftests/bpf/network_helpers.c                          |    2 
 tools/testing/selftests/bpf/test_sockmap.c                             |    2 
 tools/testing/selftests/filesystems/binderfs/Makefile                  |    2 
 tools/testing/selftests/kcmp/kcmp_test.c                               |    2 
 tools/testing/selftests/kvm/aarch64/vgic_init.c                        |   50 +
 tools/testing/selftests/lib.mk                                         |   12 
 tools/testing/selftests/net/amt.sh                                     |   20 
 tools/testing/selftests/net/forwarding/bridge_igmp.sh                  |    6 
 tools/testing/selftests/net/forwarding/bridge_mld.sh                   |    6 
 tools/testing/selftests/resctrl/Makefile                               |    4 
 tools/testing/selftests/syscall_user_dispatch/sud_test.c               |   14 
 tools/tracing/latency/latency-collector.c                              |    8 
 476 files changed, 4154 insertions(+), 2396 deletions(-)

Aapo Vienamo (1):
      mtd: core: Report error if first mtd_otp_size() call fails in mtd_otp_nvmem_add()

Aaron Conole (1):
      openvswitch: Set the skbuff pkt_type for proper pmtud support.

Abel Vesa (1):
      scsi: ufs: ufs-qcom: Clear qunipro_g4_sel for HW version major 5

Adham Faris (1):
      net/mlx5e: Fail with messages when params are not valid for XSK

Adrian Hunter (3):
      x86/insn: Fix PUSH instruction in x86 instruction decoder opcode map
      x86/insn: Add VEX versions of VPDPBUSD, VPDPBUSDS, VPDPWSSD and VPDPWSSDS
      perf intel-pt: Fix unassigned instruction op (discovered by MemorySanitizer)

Akiva Goldberger (2):
      net/mlx5: Add a timeout to acquire the command queue semaphore
      net/mlx5: Discard command completions in internal error

Al Viro (1):
      parisc: add missing export of __cmpxchg_u8()

Aleksandr Aprelkov (1):
      sunrpc: removed redundant procp check

Aleksandr Burakov (1):
      media: ngene: Add dvb_ca_en50221_init return value check

Aleksandr Mishin (6):
      crypto: bcm - Fix pointer arithmetic
      cppc_cpufreq: Fix possible null pointer dereference
      thermal/drivers/tsens: Fix null pointer dereference
      ASoC: kirkwood: Fix potential NULL dereference
      drm: bridge: cdns-mhdp8546: Fix possible null pointer dereference
      drm: vc4: Fix possible null pointer dereference

Alexander Egorenkov (2):
      s390/ipl: Fix incorrect initialization of len fields in nvme reipl block
      s390/ipl: Fix incorrect initialization of nvme dump block

Alexander Lobakin (1):
      bitops: add missing prototype check

Alexandre Mergnat (1):
      clk: mediatek: mt8365-mm: fix DPI0 parent

Andrea Mayer (1):
      ipv6: sr: fix missing sk_buff release in seg6_input_core

Andreas Gruenbacher (2):
      gfs2: Don't forget to complete delayed withdraw
      gfs2: Fix "ignore unlock failures after withdraw"

Andrew Halaney (7):
      scsi: ufs: qcom: Perform read back after writing reset bit
      scsi: ufs: qcom: Perform read back after writing REG_UFS_SYS1CLK_1US
      scsi: ufs: qcom: Perform read back after writing unipro mode
      scsi: ufs: qcom: Perform read back after writing CGC enable
      scsi: ufs: cdns-pltfrm: Perform read back after writing HCLKDIV
      scsi: ufs: core: Perform read back after disabling interrupts
      scsi: ufs: core: Perform read back after disabling UIC_COMMAND_COMPL

Andy Chi (1):
      ALSA: hda/realtek: fix mute/micmute LEDs don't work for ProBook 440/460 G11.

Andy Shevchenko (6):
      ACPI: LPSS: Advertise number of chip selects via property
      iio: core: Leave private pointer NULL when no private data supplied
      serial: max3100: Lock port->lock when calling uart_handle_cts_change()
      serial: max3100: Update uart_driver_registered on driver removal
      serial: max3100: Fix bitwise types
      spi: Don't mark message DMA mapped when no transfer in it is

AngeloGioacchino Del Regno (2):
      drm/mediatek: dp: Move PHY registration to new function
      drm/mediatek: dp: Add support for embedded DisplayPort aux-bus

Anshuman Khandual (1):
      coresight: etm4x: Fix unbalanced pm_runtime_enable()

Anton Protopopov (1):
      bpf: Pack struct bpf_fib_lookup

Ard Biesheuvel (3):
      x86/efistub: Omit physical KASLR when memory reservations exist
      x86/boot/64: Clear most of CR4 in startup_64(), except PAE, MCE and LA57
      x86/purgatory: Switch to the position-independent small code model

Armin Wolf (1):
      ACPI: Fix Generic Initiator Affinity _OSC bit

Arnaldo Carvalho de Melo (1):
      perf probe: Add missing libgen.h header needed for using basename()

Arnd Bergmann (14):
      nilfs2: fix out-of-range warning
      crypto: ccp - drop platform ifdef checks
      qed: avoid truncating work queue length
      mlx5: stop warning for 64KB pages
      wifi: carl9170: re-fix fortified-memset warning
      ACPI: disable -Wstringop-truncation
      fbdev: shmobile: fix snprintf truncation
      powerpc/fsl-soc: hide unused const variable
      fbdev: sisfb: hide unused variables
      media: rcar-vin: work around -Wenum-compare-conditional warning
      firmware: dmi-id: add a release callback function
      greybus: arche-ctrl: move device table to its right location
      Input: ims-pcu - fix printf string overflow
      drm/i915/guc: avoid FIELD_PREP warning

Azeem Shaikh (1):
      scsi: qla2xxx: Replace all non-returning strlcpy() with strscpy()

Baochen Qiang (2):
      wifi: ath10k: poll service ready message before failing
      wifi: ath11k: don't force enable power save on non-running vdevs

Basavaraj Natikar (1):
      HID: amd_sfh: Handle "no sensors" in PM operations

Benjamin Coddington (1):
      NFSv4: Fixup smatch warning for ambiguous return

Bibo Mao (1):
      LoongArch: Lately init pmu after smp is online

Bob Pearson (3):
      RDMA/rxe: Fix seg fault in rxe_comp_queue_pkt
      RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_net.c
      RDMA/rxe: Fix incorrect rxe_put in error path

Brennan Xavier McManus (1):
      tools/nolibc/stdlib: fix memory error in realloc()

Breno Leitao (1):
      af_unix: Fix data races in unix_release_sock/unix_stream_sendmsg

Brian Kubisiak (1):
      ecryptfs: Fix buffer size for tag 66 packet

Bui Quang Minh (2):
      scsi: bfa: Ensure the copied buf is NUL terminated
      scsi: qedf: Ensure the copied buf is NUL terminated

Carolina Jubran (1):
      net/mlx5e: Use rx_missed_errors instead of rx_dropped for reporting buffer exhaustion

Catalin Popescu (1):
      clk: rs9: fix wrong default value for clock amplitude

Cezary Rojewski (4):
      ASoC: Intel: Disable route checks for Skylake boards
      ASoC: Intel: avs: ssm4567: Do not ignore route checks
      ASoC: Intel: avs: Fix ASRC module initialization
      ASoC: Intel: avs: Fix potential integer overflow

Chaitanya Kulkarni (2):
      block: open code __blk_account_io_start()
      block: open code __blk_account_io_done()

Chao Yu (11):
      f2fs: multidev: fix to recognize valid zero block address
      f2fs: fix to wait on page writeback in __clone_blkaddrs()
      f2fs: compress: fix to relocate check condition in f2fs_{release,reserve}_compress_blocks()
      f2fs: compress: fix to relocate check condition in f2fs_ioc_{,de}compress_file()
      f2fs: fix to relocate check condition in f2fs_fallocate()
      f2fs: fix to check pinfile flag in f2fs_move_file_range()
      f2fs: compress: fix to update i_compr_blocks correctly
      f2fs: compress: fix to cover {reserve,release}_compress_blocks() w/ cp_rwsem lock
      f2fs: fix to release node block count in error path of f2fs_new_node_page()
      f2fs: compress: don't allow unaligned truncation on released compress inode
      f2fs: fix to add missing iput() in gc_data_segment()

Chen Ni (3):
      HID: intel-ish-hid: ipc: Add check for pci_alloc_irq_vectors
      dmaengine: idma64: Add check for dma_set_max_seg_size
      watchdog: sa1100: Fix PTR_ERR_OR_ZERO() vs NULL check in sa1100dog_probe()

Cheng Yu (1):
      sched/core: Fix incorrect initialization of the 'burst' parameter in cpu_max_write()

Chengchang Tang (5):
      RDMA/hns: Fix deadlock on SRQ async events.
      RDMA/hns: Fix UAF for cq async event
      RDMA/hns: Fix GMV table pagesize
      RDMA/hns: Use complete parentheses in macros
      RDMA/hns: Modify the print level of CQE error

Chris Lew (1):
      net: qrtr: ns: Fix module refcnt

Chris Wulff (2):
      usb: gadget: u_audio: Fix race condition use of controls after free during gadget unbind.
      usb: gadget: u_audio: Clear uac pointer when freed.

Christian Hewitt (1):
      drm/meson: vclk: fix calculation of 59.94 fractional rates

Christoph Hellwig (1):
      virt: acrn: stop using follow_pfn

Christophe JAILLET (2):
      VMCI: Fix an error handling path in vmci_guest_probe_device()
      ppdev: Remove usage of the deprecated ida_simple_xx() API

Chuck Lever (2):
      SUNRPC: Fix loop termination condition in gss_free_in_token_pages()
      SUNRPC: Fix gss_free_in_token_pages()

Chun-Kuang Hu (1):
      soc: mediatek: cmdq: Fix typo of CMDQ_JUMP_RELATIVE

Clément Léger (1):
      selftests: sud_test: return correct emulated syscall value on RISC-V

Dae R. Jeong (1):
      tls: fix missing memory barrier in tls_init

Dan Aloni (2):
      sunrpc: fix NFSACL RPC retry on soft mount
      rpcrdma: fix handling for RDMA_CM_EVENT_DEVICE_REMOVAL

Dan Carpenter (7):
      speakup: Fix sizeof() vs ARRAY_SIZE() bug
      nvmet: prevent sprintf() overflow in nvmet_subsys_nsid_exists()
      wifi: mwl8k: initialize cmd->addr[] properly
      Bluetooth: qca: Fix error code in qca_read_fw_build_info()
      ext4: fix potential unnitialized variable
      stm class: Fix a double free in stm_register_device()
      media: stk1160: fix bounds checking in stk1160_copy_video()

Daniel J Blueman (1):
      x86/tsc: Trust initial offset in architectural TSC-adjust MSRs

Daniel Starke (2):
      tty: n_gsm: fix possible out-of-bounds in gsm0_receive()
      tty: n_gsm: fix missing receive state reset after mode switch

Daniele Palmas (1):
      net: usb: qmi_wwan: add Telit FN920C04 compositions

David Arinzon (3):
      net: ena: Add dynamic recycling mechanism for rx buffers
      net: ena: Reduce lines with longer column width boundary
      net: ena: Fix DMA syncing in XDP path when SWIOTLB is on

David Hildenbrand (1):
      drivers/virt/acrn: fix PFNMAP PTE checks in acrn_vm_ram_map()

Derek Fang (2):
      ASoC: rt5645: Fix the electric noise due to the CBJ contacts floating
      ASoC: dt-bindings: rt5645: add cbj sleeve gpio property

Detlev Casanova (1):
      drm/rockchip: vop2: Do not divide height twice for YUV

Dmitry Baryshkov (5):
      wifi: ath10k: populate board data for WCN3990
      drm/msm/dp: allow voltage swing / pre emphasis of 3
      drm/mipi-dsi: use correct return type for the DSC functions
      clk: qcom: dispcc-sm8450: fix DisplayPort clocks
      clk: qcom: dispcc-sm6350: fix DisplayPort clocks

Dongli Zhang (1):
      genirq/cpuhotplug, x86/vector: Prevent vector leak during CPU offline

Dongliang Mu (1):
      media: flexcop-usb: fix sanity check of bNumEndpoints

Doug Berger (1):
      serial: 8250_bcm7271: use default_mux_rate if possible

Douglas Anderson (4):
      drm/dp: Don't attempt AUX transfers when eDP panels are not powered
      drm/panel: atna33xc20: Fix unbalanced regulator in the case HPD doesn't assert
      drm/msm/dp: Return IRQ_NONE for unhandled interrupts
      drm/msm/dp: Avoid a long timeout for AUX transfer if nothing connected

Drew Davenport (1):
      drm/panel-samsung-atna33xc20: Use ktime_get_boottime for delays

Duoming Zhou (6):
      wifi: brcmfmac: pcie: handle randbuf allocation failure
      ax25: Use kernel universal linked list to implement ax25_dev_list
      ax25: Fix reference count leak issues of ax25_dev
      ax25: Fix reference count leak issue of net_device
      lib/test_hmm.c: handle src_pfns and dst_pfns allocation failure
      um: Fix return value in ubd_init()

Edward Liaw (1):
      selftests/kcmp: remove unused open mode

Eric Biggers (4):
      KEYS: asymmetric: Add missing dependencies of FIPS_SIGNATURE_SELFTEST
      crypto: x86/nh-avx2 - add missing vzeroupper
      crypto: x86/sha256-avx2 - add missing vzeroupper
      crypto: x86/sha512-avx2 - add missing vzeroupper

Eric Dumazet (9):
      tcp: avoid premature drops in tcp_add_backlog()
      net: give more chances to rcu in netdev_wait_allrefs_any()
      usb: aqc111: stop lying about skb->truesize
      net: usb: sr9700: stop lying about skb->truesize
      net: usb: smsc95xx: stop lying about skb->truesize
      net: add pskb_may_pull_reason() helper
      netrom: fix possible dead-lock in nr_rt_ioctl()
      af_packet: do not call packet_read_pending() from tpacket_destruct_skb()
      netfilter: nfnetlink_queue: acquire rcu_read_lock() in instance_destroy_rcu()

Eric Garver (1):
      netfilter: nft_fib: allow from forward/input without iif selector

Eric Sandeen (1):
      openpromfs: finish conversion to the new mount API

Fabio Estevam (1):
      media: dt-bindings: ovti,ov2680: Fix the power supply names

Fedor Pchelkin (2):
      dma-mapping: benchmark: fix node id validation
      dma-mapping: benchmark: handle NUMA_NO_NODE correctly

Felix Fietkau (1):
      wifi: mt76: mt7603: add wpdma tx eof flag for PSE client reset

Felix Kuehling (1):
      drm/amdgpu: Update BO eviction priorities

Fenglin Wu (1):
      Input: pm8xxx-vibrator - correct VIB_MAX_LEVELS calculation

Finn Thain (2):
      macintosh/via-macii: Fix "BUG: sleeping function called from invalid context"
      m68k: mac: Fix reboot hang on Mac IIci

Florian Fainelli (1):
      net: Always descend into dsa/ folder with CONFIG_NET_DSA enabled

Florian Westphal (2):
      netfilter: nft_payload: rebuild vlan header on h_proto access
      netfilter: tproxy: bail out if IP has been disabled on the device

Friedrich Vock (1):
      bpf: Fix potential integer overflow in resolve_btfids

Gabriel Krisman Bertazi (1):
      udp: Avoid call to compute_score on multiple sites

Gal Pressman (1):
      net/mlx5e: Fix UDP GSO for encapsulated packets

Geert Uytterhoeven (5):
      sh: kprobes: Merge arch_copy_kprobe() into arch_prepare_kprobe()
      printk: Let no_printk() use _printk()
      dev_printk: Add and use dev_no_printk()
      clk: renesas: r8a779a0: Fix CANFD parent clock
      dt-bindings: PCI: rcar-pci-host: Add missing IOMMU properties

Geliang Tang (2):
      selftests/bpf: Fix umount cgroup2 error in test_sockmap
      selftests/bpf: Fix a fd leak in error paths in open_netns

Gerd Hoffmann (1):
      KVM: x86: Don't advertise guest.MAXPHYADDR as host.MAXPHYADDR in CPUID

Greg Kroah-Hartman (1):
      Linux 6.1.93

Guenter Roeck (3):
      mm/slub, kunit: Use inverted data to corrupt kmem cache
      Revert "sh: Handle calling csum_partial with misaligned data"
      hwmon: (shtc1) Fix property misspelling

Guixiong Wei (1):
      x86/boot: Ignore relocations in .notes sections in walk_relocs() too

Guo Ren (1):
      riscv: stacktrace: Make walk_stackframe cross pt_regs frame

Hagar Hemdan (1):
      efi: libstub: only free priv.runtime_map when allocated

Hangbin Liu (4):
      ipv6: sr: add missing seg6_local_exit
      ipv6: sr: fix incorrect unregister order
      ipv6: sr: fix invalid unregister error path
      ipv6: sr: fix memleak in seg6_hmac_init_algo

Hans Verkuil (4):
      media: cec: cec-adap: always cancel work in cec_transmit_msg_fh
      media: cec: cec-api: add locking in cec_release()
      media: cec: core: avoid recursive cec_claim_log_addrs
      media: cec: core: avoid confusing "transmit timed out" message

Hans de Goede (1):
      ASoC: Intel: bytcr_rt5640: Apply Asus T100TA quirk to Asus T100TAM too

Hao Chen (1):
      drivers/perf: hisi: hns3: Actually use devm_add_action_or_reset()

He Zhe (1):
      perf bench internals inject-build-id: Fix trap divide when collecting just one DSO

Heiko Carstens (1):
      s390/vdso: Use standard stack frame layout

Heiner Kallweit (1):
      Revert "r8169: don't try to disable interrupts if NAPI is, scheduled already"

Henry Wang (1):
      drivers/xen: Improve the late XenStore init protocol

Himanshu Madhani (1):
      scsi: qla2xxx: Fix debugfs output for fw_resource_count

Hsin-Te Yuan (1):
      ASoC: mediatek: mt8192: fix register configuration for tdm

Huacai Chen (1):
      LoongArch: Fix callchain parse error with kernel tracepoint events again

Huai-Yuan Liu (2):
      drm/arm/malidp: fix a possible null pointer dereference
      ppdev: Add an error check in register_device

Hugo Villeneuve (1):
      serial: sc16is7xx: add proper sched.h include for sched_set_fifo()

Ian Rogers (7):
      perf record: Delete session after stopping sideband thread
      perf docs: Document bpf event modifier
      perf ui browser: Don't save pointer to stack memory
      perf ui browser: Avoid SEGV on title
      perf report: Avoid SEGV in report__setup_sample_type()
      libsubcmd: Fix parse-options memory leak
      perf stat: Don't display metric header for non-leader uncore events

Igor Artemiev (1):
      wifi: cfg80211: fix the order of arguments for trace events of the tx_rx_evt class

Ilya Denisyev (1):
      jffs2: prevent xattr node from overflowing the eraseblock

Ilya Leoshkevich (1):
      s390/bpf: Emit a barrier for BPF_FETCH instructions

Ilya Maximets (1):
      net: openvswitch: fix overwriting ct original tuple for ICMPv6

Jack Xiao (1):
      drm/amdgpu/mes: fix use-after-free issue

Jack Yu (2):
      ASoC: rt715: add vendor clear control register
      ASoC: rt715-sdca: volume step modification

Jacob Keller (2):
      Revert "ixgbe: Manual AN-37 for troublesome link partners for X550 SFI"
      ice: fix accounting if a VLAN already exists

Jaewon Kim (1):
      clk: samsung: exynosautov9: fix wrong pll clock id value

Jagan Teki (1):
      drm/bridge: Fix improper bridge init order with pre_enable_prev_first

Jakub Kicinski (2):
      eth: sungem: remove .ndo_poll_controller to avoid deadlocks
      selftests: net: move amt to socat for better compatibility

Jakub Sitnicki (1):
      bpf: Allow delete from sockmap/sockhash only if update is allowed

James Clark (1):
      perf tests: Make "test data symbol" more robust on Neoverse N1

Jan Kara (1):
      ext4: avoid excessive credit estimate in ext4_tmpfile()

Jason Gunthorpe (1):
      IB/mlx5: Use __iowrite64_copy() for write combining stores

Jens Axboe (2):
      io_uring: don't use TIF_NOTIFY_SIGNAL to test for availability of task_work
      io_uring: use the right type for work_llist empty check

Jens Remus (1):
      s390/vdso: Generate unwind information for C modules

Jiangfeng Xiao (1):
      arm64: asm-bug: Add .align 2 to the end of __BUG_ENTRY

Jinyoung CHOI (1):
      f2fs: fix typos in comments

Jiri Olsa (1):
      libbpf: Fix error message in attach_kprobe_multi

Jiri Pirko (1):
      virtio: delete vq in vp_find_vqs_msix() when request_irq() fails

Johannes Berg (2):
      wifi: mac80211: don't use rate mask for scanning
      um: vector: fix bpfflash parameter evaluation

John Hubbard (2):
      selftests/binderfs: use the Makefile's rules, not Make's implicit rules
      selftests/resctrl: fix clang build failure: use LOCAL_HDRS

Jonathan Cameron (1):
      iio: adc: stm32: Fixing err code to not indicate success

Joshua Ashton (1):
      drm/amd/display: Set color_mgmt_changed to true on unsuspend

Judith Mendez (5):
      mmc: sdhci_am654: Add tuning algorithm for delay chain
      mmc: sdhci_am654: Write ITAPDLY for DDR52 timing
      mmc: sdhci_am654: Add OTAP/ITAP delay enable
      mmc: sdhci_am654: Add ITAPDLYSEL in sdhci_j721e_4bit_set_clock
      mmc: sdhci_am654: Fix ITAPDLY for HS400 timing

Juergen Gross (3):
      x86/pat: Introduce lookup_address_in_pgd_attr()
      x86/pat: Restructure _lookup_address_cpa()
      x86/pat: Fix W^X violation false-positives when running as Xen PV guest

Junhao He (2):
      drivers/perf: hisi_pcie: Fix out-of-bound access when valid event group
      drivers/perf: hisi: hns3: Fix out-of-bound access when valid event group

Justin Green (1):
      drm/mediatek: Add 0 size check to mtk_drm_gem_obj

Karel Balej (1):
      Input: ioc3kbd - add device table

Kemeng Shi (4):
      ext4: simplify calculation of blkoff in ext4_mb_new_blocks_simple
      ext4: fix unit mismatch in ext4_mb_new_blocks_simple
      ext4: try all groups in ext4_mb_new_blocks_simple
      ext4: remove unused parameter from ext4_mb_new_blocks_simple()

Ken Milmore (1):
      r8169: Fix possible ring buffer corruption on fragmented Tx packets.

Kent Overstreet (1):
      kernel/numa.c: Move logging out of numa.h

Konrad Dybcio (2):
      interconnect: qcom: qcm2290: Fix mas_snoc_bimc QoS port assignment
      drm/msm/a6xx: Avoid a nullptr dereference when speedbin setting fails

Konstantin Komarov (6):
      fs/ntfs3: Remove max link count info display during driver init
      fs/ntfs3: Taking DOS names into account during link counting
      fs/ntfs3: Fix case when index is reused during tree transformation
      fs/ntfs3: Break dir enumeration if directory contents error
      fs/ntfs3: Use 64 bit variable to avoid 32 bit overflow
      fs/ntfs3: Use variable length array instead of fixed size

Krzysztof Kozlowski (1):
      regulator: vqmmc-ipq4019: fix module autoloading

Kuniyuki Iwashima (3):
      af_unix: Update unix_sk(sk)->oob_skb under sk_receive_queue lock.
      tcp: Fix shift-out-of-bounds in dctcp_update_alpha().
      af_unix: Read sk->sk_hash under bindlock during bind().

Kuppuswamy Sathyanarayanan (2):
      PCI/EDR: Align EDR_PORT_DPC_ENABLE_DSM with PCI Firmware r3.3
      PCI/EDR: Align EDR_PORT_LOCATE_DSM with PCI Firmware r3.3

Lad Prabhakar (1):
      clk: renesas: r9a07g043: Add clock and reset entry for PLIC

Lancelot SIX (1):
      drm/amdkfd: Flush the process wq before creating a kfd_process

Larysa Zaremba (1):
      ice: Interpret .set_channels() input differently

Laurent Pinchart (1):
      firmware: raspberrypi: Use correct device for DMA mappings

Leon Romanovsky (1):
      RDMA/IPoIB: Fix format truncation compilation errors

Linus Torvalds (2):
      x86/mm: Remove broken vsyscall emulation code from the page fault code
      epoll: be better about file lifetimes

Linus Walleij (1):
      net: ethernet: cortina: Locking fixes

Lorenz Bauer (2):
      net: export inet_lookup_reuseport and inet6_lookup_reuseport
      net: remove duplicate reuseport_lookup functions

Luca Ceresoli (1):
      Revert "drm/bridge: ti-sn65dsi83: Fix enable error path"

Luiz Augusto von Dentz (1):
      Bluetooth: Consolidate code around sk_alloc into a helper function

Luke D. Jones (3):
      ALSA: hda/realtek: Add quirk for ASUS ROG G634Z
      ALSA: hda/realtek: Amend G634 quirk to enable rear speakers
      ALSA: hda/realtek: Adjust G814JZR to use SPI init for amp

Maher Sanalla (1):
      net/mlx5: Lag, do bond only if slaves agree on roce state

Manivannan Sadhasivam (1):
      scsi: ufs: ufs-qcom: Fix the Qcom register name for offset 0xD0

Marc Gonzalez (1):
      clk: qcom: mmcc-msm8998: fix venus clock issue

Marco Pagani (1):
      fpga: region: add owner module and take its refcount

Marek Szyprowski (1):
      Input: cyapa - add missing input core locking to suspend/resume functions

Marek Vasut (2):
      drm/lcdif: Do not disable clocks on already suspended hardware
      drm/panel: simple: Add missing Innolux G121X1-L03 format, flags, connector

Marijn Suijten (2):
      drm/msm/dsi: Print dual-DSI-adjusted pclk instead of original mode pclk
      drm/msm/dpu: Always flush the slave INTF on the CTL

Martin Kaiser (1):
      nfs: keep server info for remounts

Masahiro Yamada (2):
      x86/kconfig: Select ARCH_WANT_FRAME_POINTERS again when UNWINDER_FRAME_POINTER=y
      kconfig: fix comparison to constant symbols, 'm', 'n'

Mathieu Othacehe (1):
      net: phy: micrel: set soft_reset callback to genphy_soft_reset for KSZ8061

Matthew Bystrin (1):
      riscv: stacktrace: fixed walk_stackframe()

Matthias Schiffer (2):
      net: dsa: mv88e6xxx: Add support for model-specific pre- and post-reset handlers
      net: dsa: mv88e6xxx: Avoid EEPROM timeout without EEPROM on 88E6250-family switches

Matthieu Baerts (NGI0) (1):
      mptcp: SO_KEEPALIVE: fix getsockopt support

Matti Vaittinen (3):
      regulator: irq_helpers: duplicate IRQ name
      watchdog: bd9576: Drop "always-running" property
      regulator: bd71828: Don't overwrite runtime voltages

Maurizio Lombardi (2):
      nvmet-auth: return the error code to the nvmet_auth_host_hash() callers
      nvmet-auth: replace pr_debug() with pr_err() to report an error.

Maxim Korotkov (1):
      mtd: rawnand: hynix: fixed typo

Maxime Ripard (1):
      ARM: configs: sunxi: Enable DRM_DW_HDMI

Michael Schmitz (1):
      m68k: Fix spinlock race in kernel thread creation

Michael Walle (1):
      drm/bridge: tc358775: fix support for jeida-18 and jeida-24

Michal Simek (2):
      microblaze: Remove gcc flag for non existing early_printk.c file
      microblaze: Remove early printk call from cpuinfo-static.c

Mickaël Salaün (1):
      kunit: Fix kthread reference

Miklos Szeredi (1):
      ovl: remove upper umask handling from ovl_create_upper()

Ming Lei (1):
      io_uring: fail NOP if non-zero op flags is passed in

Namhyung Kim (8):
      perf annotate: Get rid of duplicate --group option item
      perf test: Add -w/--workload option
      perf test: Add 'thloop' test workload
      perf test: Add 'leafloop' test workload
      perf test: Add 'sqrtloop' test workload
      perf test: Add 'brstack' test workload
      perf test: Add 'datasym' test workload
      perf/arm-dmc620: Fix lockdep assert in ->event_init()

Namjae Jeon (1):
      ksmbd: avoid to send duplicate oplock break notifications

Nandor Kracser (1):
      ksmbd: ignore trailing slashes in share paths

Nathan Lynch (1):
      powerpc/pseries/lparcfg: drop error message from guest name lookup

Neil Armstrong (1):
      scsi: ufs: ufs-qcom: Clear qunipro_g4_sel for HW major version > 5

Nikita Kiryushin (2):
      rcu-tasks: Fix show_rcu_tasks_trace_gp_kthread buffer overflow
      rcu: Fix buffer overflow in print_cpu_stall_info()

Nikita Zhandarovich (2):
      wifi: carl9170: add a proper sanity check for endpoints
      wifi: ar5523: enable proper endpoint verification

Nikolay Aleksandrov (3):
      net: bridge: xmit: make sure we have at least eth header len bytes
      selftests: net: bridge: increase IGMP/MLD exclude timeout membership interval
      net: bridge: mst: fix vlan use-after-free

Nilay Shroff (1):
      nvme: find numa distance only if controller has valid numa id

Nícolas F. R. A. Prado (8):
      drm/bridge: anx7625: Don't log an error when DSI host can't be found
      drm/bridge: icn6211: Don't log an error when DSI host can't be found
      drm/bridge: lt8912b: Don't log an error when DSI host can't be found
      drm/bridge: lt9611: Don't log an error when DSI host can't be found
      drm/bridge: lt9611uxc: Don't log an error when DSI host can't be found
      drm/bridge: tc358775: Don't log an error when DSI host can't be found
      drm/bridge: dpc3433: Don't log an error when DSI host can't be found
      drm/panel: novatek-nt35950: Don't log an error when DSI host can't be found

Oleg Nesterov (1):
      sched/isolation: Fix boot crash when maxcpus < first housekeeping CPU

Olga Kornievskaia (1):
      pNFS/filelayout: fixup pNfs allocation modes

Oliver Upton (1):
      KVM: selftests: Add test for uaccesses to non-existent vgic-v2 CPUIF

Or Har-Toov (1):
      RDMA/mlx5: Adding remote atomic access flag to updatable flags

Pablo Neira Ayuso (4):
      netfilter: nft_payload: restore vlan q-in-q match support
      netfilter: nft_payload: move struct nft_payload_set definition where it belongs
      netfilter: nft_payload: rebuild vlan header when needed
      netfilter: nft_payload: skbuff vlan metadata mangle support

Paolo Abeni (2):
      inet: factor out locked section of inet_accept() in a new helper
      net: relax socket state check at accept time.

Parthiban Veerasooran (1):
      net: usb: smsc95xx: fix changing LED_SEL bit value updated from EEPROM

Peter Colberg (1):
      fpga: dfl-pci: add PCI subdevice ID for Intel D5005 card

Peter Oberparleiter (1):
      s390/cio: fix tracepoint subchannel type field

Petr Pavlu (1):
      ring-buffer: Fix a race between readers and resize checks

Pierre-Louis Bossart (3):
      ASoC: da7219-aad: fix usage of device_get_named_child_node()
      ALSA: hda: intel-dsp-config: harden I2C/I2S codec detection
      soundwire: cadence: fix invalid PDI offset

Pin-yen Lin (1):
      serial: 8520_mtk: Set RTS on shutdown for Rx in-band wakeup

Prike Liang (1):
      drm/amdgpu: Fix the ring buffer size for queue VM flush

Puranjay Mohan (1):
      riscv, bpf: make some atomic operations fully ordered

Rafał Miłecki (1):
      dt-bindings: pinctrl: mediatek: mt7622: fix array properties

Rahul Rameshbabu (1):
      net/mlx5e: Fix IPsec tunnel mode offload feature check

Randy Dunlap (4):
      fbdev: sh7760fb: allow modular build
      counter: linux/counter.h: fix Excess kernel-doc description warning
      extcon: max8997: select IRQ_DOMAIN instead of depending on it
      media: sunxi: a83-mips-csi2: also select GENERIC_PHY

Ricardo Ribalda (1):
      media: radio-shark2: Avoid led_names truncations

Richard Fitzgerald (1):
      ALSA: hda/cs_dsp_ctl: Use private_free for control cleanup

Richard Kinder (1):
      wifi: mac80211: ensure beacon is non-S1G prior to extracting the beacon timestamp field

Rob Clark (1):
      drm/msm: Enable clamp_to_idle for 7c3

Rob Herring (1):
      dt-bindings: rockchip: grf: Add missing type to 'pcie-phy' node

Robert Richter (1):
      x86/numa: Fix SRAT lookup of CFMWS ranges with numa_fill_memblks()

Roberto Sassu (1):
      um: Add winch to winch_handlers before registering winch IRQ

Roded Zats (1):
      enic: Validate length of nl attributes in enic_set_vf_port

Rodrigo Siqueira (1):
      drm/amd/display: Add VCO speed parameter for DCN31 FPU

Rui Miguel Silva (1):
      greybus: lights: check return of get_channel_from_mode

Ryosuke Yasuoka (2):
      nfc: nci: Fix uninit-value in nci_rx_work
      nfc: nci: Fix handling of zero-length payload packets in nci_rx_work()

Ryusuke Konishi (2):
      nilfs2: fix unexpected freezing of nilfs_segctor_sync()
      nilfs2: fix potential hang in nilfs_detach_log_writer()

Sagi Grimberg (3):
      nvmet-tcp: fix possible memory leak when tearing down a controller
      nvmet: fix nvme status code when namespace is disabled
      nvmet: fix ns enable/disable possible hang

Sakari Ailus (1):
      media: ipu3-cio2: Request IRQ earlier

Samasth Norway Ananda (1):
      perf daemon: Fix file leak in daemon_session__control

Sebastian Urban (1):
      Bluetooth: compute LE flow credits based on recvbuf space

Sergey Matyukevich (1):
      riscv: prevent pt_regs corruption for secondary idle threads

Shay Agroskin (1):
      net: ena: Fix redundant device NUMA node override

Shenghao Ding (1):
      ASoC: tas2552: Add TX path for capturing AUDIO-OUT data

Shrikanth Hegde (2):
      sched/fair: Add EAS checks before updating root_domain::overutilized
      powerpc/pseries: Add failure related checks for h_get_mpp and h_get_ppp

Shuah Khan (1):
      tools/latency-collector: Fix -Wformat-security compile warns

Srinivasan Shanmugam (1):
      drm/amd/display: Fix potential index out of bounds in color transformation function

Steven Rostedt (1):
      ASoC: tracing: Export SND_SOC_DAPM_DIR_OUT to its value

Su Hui (1):
      wifi: ath10k: Fix an error code problem in ath10k_dbg_sta_write_peer_debug_trigger()

Sumanth Korikkar (2):
      s390/vdso: filter out mno-pic-data-is-text-relative cflag
      s390/vdso64: filter out munaligned-symbols flag for vdso

Suzuki K Poulose (4):
      coresight: etm4x: Do not hardcode IOMEM access for register restore
      coresight: etm4x: Do not save/restore Data trace control registers
      coresight: etm4x: Safe access for TRCQCLTR
      coresight: etm4x: Fix access to resource selector registers

Sven Schnelle (1):
      s390/boot: Remove alt_stfle_fac_list from decompressor

Swapnil Patel (1):
      drm/amd/display: Add dtbclk access to dcn315

Taehee Yoo (1):
      selftests: net: kill smcrouted in the cleanup logic in amt.sh

Takashi Iwai (5):
      ALSA: core: Fix NULL module pointer assignment at card init
      ALSA: Fix deadlocks with kctl removals at disconnection
      ALSA: jack: Use guard() for locking
      ALSA: core: Remove debugfs at disconnection
      ALSA: timer: Set lower bound of start tick time

Tetsuo Handa (2):
      nfc: nci: Fix kcov check in nci_rx_work()
      dma-buf/sw-sync: don't enable IRQ from sync_print_obj()

Thomas Haemmerle (1):
      iio: pressure: dps310: support negative temperature values

Thorsten Blum (1):
      net: smc91x: Fix m68k kernel compilation for ColdFire CPU

Tiwei Bie (3):
      um: Fix the -Wmissing-prototypes warning for __switch_mm
      um: Fix the -Wmissing-prototypes warning for get_thread_reg
      um: Fix the declaration of kasan_map_memory

Tristram Ha (1):
      net: dsa: microchip: fix RGMII error in KSZ DSA driver

Uwe Kleine-König (5):
      pwm: sti: Convert to platform remove callback returning void
      pwm: sti: Prepare removing pwm_chip from driver data
      pwm: sti: Simplify probe function using devm functions
      Input: ioc3kbd - convert to platform remove callback returning void
      spi: stm32: Don't warn about spurious interrupts

Valentin Obst (1):
      selftests: default to host arch for LLVM builds

Vidya Sagar (1):
      PCI: tegra194: Fix probe path for Endpoint mode

Vignesh Raghavendra (1):
      mmc: sdhci_am654: Drop lookup for deprecated ti,otap-del-sel

Viresh Kumar (1):
      cpufreq: exit() callback is optional

Vitalii Bursov (1):
      sched/fair: Allow disabling sched_balance_newidle with sched_relax_domain_level

Wei Fang (1):
      net: fec: avoid lock evasion when reading pps_enable

Wojciech Macek (1):
      drm/mediatek: dp: Fix mtk_dp_aux_transfer return value

Wolfram Sang (2):
      dt-bindings: PCI: rcar-pci-host: Add optional regulators
      serial: sh-sci: protect invalidating RXDMA on shutdown

Xianwei Zhao (1):
      arm64: dts: meson: fix S4 power-controller node

Xiaolei Wang (1):
      net:fec: Add fec_enet_deinit()

Xingui Yang (1):
      scsi: libsas: Fix the failure of adding phy with zero-address to port

Yang Li (1):
      rv: Update rv_en(dis)able_monitor doc to match kernel-doc

Yonghong Song (1):
      bpftool: Fix missing pids during link show

Yu Kuai (2):
      md: fix resync softlockup when bitmap size is less than array size
      block: support to account io_ticks precisely

Yue Haibing (1):
      ipvlan: Dont Use skb->sk in ipvlan_process_v{4,6}_outbound

Yuri Karpov (1):
      scsi: hpsa: Fix allocation size for Scsi_Host private data

Zenghui Yu (2):
      irqchip/alpine-msi: Fix off-by-one in allocation error path
      irqchip/loongson-pch-msi: Fix off-by-one on allocation error path

Zheng Yejian (1):
      ftrace: Fix possible use-after-free issue in ftrace_location()

Zhengchao Shao (1):
      RDMA/hns: Fix return value in hns_roce_map_mr_sg

Zhipeng Lu (1):
      media: atomisp: ssh_css: Fix a null-pointer dereference in load_video_binaries

Zhu Yanjun (2):
      null_blk: Fix missing mutex_destroy() at module removal
      null_blk: Fix the WARNING: modpost: missing MODULE_DESCRIPTION()

Zqiang (1):
      softirq: Fix suspicious RCU usage in __do_softirq()

gaoxingwang (1):
      net: ipv6: fix wrong start position when receive hop-by-hop fragment


