Return-Path: <stable+bounces-202989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6069DCCC1DE
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 14:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03DD83149C52
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 13:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0213333A719;
	Thu, 18 Dec 2025 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SMPBtPkH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BAE338591;
	Thu, 18 Dec 2025 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766065585; cv=none; b=U+u17wJlGLSgKqgRyhoRDtzzqvr+x8+SgyS43gZUFsdsj36XpYGE6e7sZX/aVBiNCrs0i7wITuH5zdfyRgHsldNkMJN2rSnUFG+uAKobHLL3iUoN88oDHwbPifXC1MLOxYfb4O6Hpjm0CadnANaIH/75Ri1Jy4V1I3PzcdZwx1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766065585; c=relaxed/simple;
	bh=Ou3tCvfG8U7fAsffpQhqixcYXMHkVJwnMqpcRvMt34U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HT/Miz+ZomYNiTxhUQg4MIiIVh9apBzYQNwiaq4+XJAdCDtW8+hxDCcy0/iKOwzziEx1dKl0QfYDBJ61G89kJKI07LFbcsTmUAG1+74Y1qHltTS2wF8iI+Mp2fdM8Az6MVGlto6TPCMqBBzvP59or15bzLzC2AKGmKYlBueiApg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SMPBtPkH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1207EC4CEFB;
	Thu, 18 Dec 2025 13:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766065585;
	bh=Ou3tCvfG8U7fAsffpQhqixcYXMHkVJwnMqpcRvMt34U=;
	h=From:To:Cc:Subject:Date:From;
	b=SMPBtPkHXlwXt1H3lH2/u8QD41iV74pNjMdvld8sBwIz6tIlIqfswpnmEE4Xw7SoJ
	 alwtn1jKw4dOjGipXSiLifhiquYq3mFxCBEyflYBBx+8nbCifS6qhw/EXRXeCm4f/v
	 o9/vdUpPgFnSrvDh2w48x3lfvf/tNW5ZRMzuIRQo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.17.13
Date: Thu, 18 Dec 2025 14:46:19 +0100
Message-ID: <2025121823-avid-hatchback-83fb@gregkh>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Note, this is the LAST release of the 6.17.y kernel tree.  It is now
end-of-life, all users must move to the 6.18.y kernel branch at this
point in time.

I'm announcing the release of the 6.17.13 kernel.

All users of the 6.17 kernel series must upgrade.

The updated 6.17.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.17.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/LSM/Smack.rst                                           |   16 
 Documentation/devicetree/bindings/clock/qcom,x1e80100-gcc.yaml                    |   62 
 Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml                       |    6 
 Documentation/hwmon/g762.rst                                                      |    2 
 Makefile                                                                          |    2 
 arch/arm/boot/dts/renesas/r8a7793-gose.dts                                        |    1 
 arch/arm/boot/dts/renesas/r9a06g032-rzn1d400-db.dts                               |    2 
 arch/arm/boot/dts/samsung/exynos4210-i9100.dts                                    |    1 
 arch/arm/boot/dts/samsung/exynos4210-trats.dts                                    |    1 
 arch/arm/boot/dts/samsung/exynos4210-universal_c210.dts                           |    1 
 arch/arm/boot/dts/samsung/exynos4412-midas.dtsi                                   |    1 
 arch/arm/boot/dts/st/stm32mp157c-phycore-stm32mp15-som.dtsi                       |    8 
 arch/arm/boot/dts/ti/omap/am335x-netcom-plus-2xx.dts                              |    8 
 arch/arm/boot/dts/ti/omap/omap3-beagle-xm.dts                                     |    2 
 arch/arm/boot/dts/ti/omap/omap3-n900.dts                                          |    2 
 arch/arm/include/asm/word-at-a-time.h                                             |   10 
 arch/arm64/boot/dts/exynos/google/gs101.dtsi                                      |    4 
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi                           |   11 
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi                           |   51 
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw72xx.dtsi                           |   11 
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts                                 |    1 
 arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi                               |    4 
 arch/arm64/boot/dts/qcom/msm8996.dtsi                                             |    3 
 arch/arm64/boot/dts/qcom/qcm2290.dtsi                                             |   60 
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts                                |    2 
 arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts                                  |    5 
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts                                          |    2 
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi                               |    4 
 arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts                           |   17 
 arch/arm64/boot/dts/qcom/sm8650.dtsi                                              |    2 
 arch/arm64/boot/dts/qcom/x1e80100.dtsi                                            |   12 
 arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts                             |    6 
 arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts                                   |    1 
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts                                  |   15 
 arch/arm64/boot/dts/ti/k3-am62p.dtsi                                              |    2 
 arch/powerpc/kernel/entry_32.S                                                    |   10 
 arch/powerpc/kexec/ranges.c                                                       |    2 
 arch/powerpc/mm/book3s64/hash_utils.c                                             |   10 
 arch/powerpc/mm/ptdump/hashpagetable.c                                            |    6 
 arch/riscv/kvm/vcpu_insn.c                                                        |   22 
 arch/s390/include/asm/fpu-insn.h                                                  |    3 
 arch/s390/kernel/smp.c                                                            |    1 
 arch/um/Makefile                                                                  |   12 
 arch/x86/boot/compressed/pgtable_64.c                                             |   11 
 arch/x86/events/core.c                                                            |    5 
 arch/x86/events/intel/core.c                                                      |    7 
 arch/x86/events/intel/cstate.c                                                    |    3 
 arch/x86/kernel/dumpstack.c                                                       |   23 
 block/blk-lib.c                                                                   |    6 
 block/blk-mq.c                                                                    |   35 
 block/blk-throttle.c                                                              |    9 
 block/mq-deadline.c                                                               |  129 -
 crypto/aead.c                                                                     |    1 
 crypto/ahash.c                                                                    |   18 
 crypto/asymmetric_keys/asymmetric_type.c                                          |   14 
 crypto/authenc.c                                                                  |   75 -
 drivers/accel/amdxdna/aie2_ctx.c                                                  |   22 
 drivers/accel/amdxdna/amdxdna_ctx.c                                               |    1 
 drivers/accel/amdxdna/amdxdna_ctx.h                                               |    1 
 drivers/accel/amdxdna/amdxdna_mailbox.c                                           |    1 
 drivers/accel/ivpu/ivpu_fw.h                                                      |    2 
 drivers/accel/ivpu/ivpu_gem.c                                                     |   97 -
 drivers/accel/ivpu/ivpu_gem.h                                                     |    2 
 drivers/accel/ivpu/ivpu_hw_btrs.c                                                 |    2 
 drivers/accel/ivpu/ivpu_hw_btrs.h                                                 |    2 
 drivers/accel/ivpu/ivpu_job.c                                                     |    6 
 drivers/accel/ivpu/ivpu_pm.c                                                      |    9 
 drivers/acpi/apei/ghes.c                                                          |   27 
 drivers/acpi/processor_core.c                                                     |    2 
 drivers/acpi/property.c                                                           |    1 
 drivers/base/firmware_loader/Kconfig                                              |    2 
 drivers/block/nbd.c                                                               |    5 
 drivers/block/ps3disk.c                                                           |    4 
 drivers/block/ublk_drv.c                                                          |    4 
 drivers/char/random.c                                                             |   19 
 drivers/clk/Makefile                                                              |    3 
 drivers/clk/qcom/camcc-sm6350.c                                                   |   13 
 drivers/clk/qcom/camcc-sm7150.c                                                   |    6 
 drivers/clk/qcom/camcc-sm8550.c                                                   |   10 
 drivers/clk/qcom/gcc-ipq5424.c                                                    |    3 
 drivers/clk/qcom/gcc-qcs615.c                                                     |    6 
 drivers/clk/qcom/gcc-sm8750.c                                                     |    1 
 drivers/clk/qcom/gcc-x1e80100.c                                                   |  698 +++++++++-
 drivers/clk/renesas/r9a06g032-clocks.c                                            |    6 
 drivers/clk/renesas/r9a09g077-cpg.c                                               |    4 
 drivers/clk/renesas/renesas-cpg-mssr.c                                            |   57 
 drivers/clk/spacemit/ccu-k1.c                                                     |    4 
 drivers/clocksource/timer-nxp-stm.c                                               |   23 
 drivers/clocksource/timer-ralink.c                                                |   11 
 drivers/cpufreq/amd-pstate.c                                                      |    2 
 drivers/crypto/ccree/cc_buffer_mgr.c                                              |    6 
 drivers/crypto/hisilicon/qm.c                                                     |   14 
 drivers/crypto/intel/iaa/iaa_crypto_main.c                                        |    2 
 drivers/crypto/starfive/jh7110-hash.c                                             |    6 
 drivers/devfreq/hisi_uncore_freq.c                                                |    3 
 drivers/firmware/efi/cper-arm.c                                                   |   52 
 drivers/firmware/efi/cper.c                                                       |   60 
 drivers/firmware/efi/libstub/x86-5lvl.c                                           |    4 
 drivers/firmware/imx/imx-scu-irq.c                                                |    4 
 drivers/firmware/stratix10-svc.c                                                  |    1 
 drivers/firmware/ti_sci.c                                                         |   21 
 drivers/firmware/ti_sci.h                                                         |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h                                        |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c                                         |   44 
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h                                         |   12 
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c                                        |   31 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                                              |   46 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c                                |    8 
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c                                   |   27 
 drivers/gpu/drm/drm_plane.c                                                       |    8 
 drivers/gpu/drm/i915/display/intel_fbdev.c                                        |   43 
 drivers/gpu/drm/i915/display/intel_fbdev_fb.c                                     |   42 
 drivers/gpu/drm/i915/display/intel_fbdev_fb.h                                     |    8 
 drivers/gpu/drm/imagination/pvr_device.c                                          |    2 
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c                                         |   23 
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c                                             |    2 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                                             |   34 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                                             |   10 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h                                        |    6 
 drivers/gpu/drm/msm/msm_gpu.c                                                     |   21 
 drivers/gpu/drm/nouveau/dispnv04/nouveau_i2c_encoder.c                            |   20 
 drivers/gpu/drm/nouveau/include/dispnv04/i2c/encoder_i2c.h                        |   19 
 drivers/gpu/drm/nouveau/nouveau_fence.c                                           |    6 
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/base.c                                     |    2 
 drivers/gpu/drm/nova/Kconfig                                                      |    1 
 drivers/gpu/drm/panel/panel-visionox-rm69299.c                                    |    4 
 drivers/gpu/drm/panthor/panthor_device.c                                          |    4 
 drivers/gpu/drm/panthor/panthor_gem.c                                             |   20 
 drivers/gpu/drm/panthor/panthor_mmu.c                                             |   18 
 drivers/gpu/drm/panthor/panthor_sched.c                                           |   44 
 drivers/gpu/drm/tidss/tidss_dispc.c                                               |   93 -
 drivers/gpu/drm/tidss/tidss_dispc.h                                               |    3 
 drivers/gpu/drm/tidss/tidss_drv.h                                                 |    2 
 drivers/gpu/drm/tidss/tidss_oldi.c                                                |   22 
 drivers/gpu/drm/vgem/vgem_fence.c                                                 |    2 
 drivers/gpu/drm/xe/display/intel_fbdev_fb.c                                       |   32 
 drivers/gpu/host1x/syncpt.c                                                       |    4 
 drivers/greybus/gb-beagleplay.c                                                   |   12 
 drivers/hid/hid-logitech-hidpp.c                                                  |    9 
 drivers/hv/mshv_root_main.c                                                       |   89 -
 drivers/hwmon/sy7636a-hwmon.c                                                     |    7 
 drivers/hwtracing/coresight/coresight-etm-perf.c                                  |    1 
 drivers/hwtracing/coresight/coresight-etm3x-core.c                                |   59 
 drivers/hwtracing/coresight/coresight-etm4x-core.c                                |  103 -
 drivers/hwtracing/coresight/coresight-etm4x.h                                     |    3 
 drivers/hwtracing/coresight/coresight-tmc-etr.c                                   |   10 
 drivers/i2c/busses/i2c-k1.c                                                       |   19 
 drivers/i3c/master.c                                                              |    8 
 drivers/i3c/master/svc-i3c-master.c                                               |   22 
 drivers/iio/imu/bmi270/bmi270_spi.c                                               |    2 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h                                           |    2 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                                          |    8 
 drivers/infiniband/hw/bnxt_re/qplib_sp.c                                          |    8 
 drivers/infiniband/hw/bnxt_re/qplib_sp.h                                          |    2 
 drivers/infiniband/hw/irdma/cm.c                                                  |    2 
 drivers/infiniband/hw/irdma/ctrl.c                                                |    3 
 drivers/infiniband/hw/irdma/main.h                                                |    2 
 drivers/infiniband/hw/irdma/pble.c                                                |    6 
 drivers/infiniband/hw/irdma/verbs.c                                               |   15 
 drivers/infiniband/hw/irdma/verbs.h                                               |    3 
 drivers/infiniband/sw/rxe/rxe_srq.c                                               |    7 
 drivers/infiniband/ulp/rtrs/rtrs-srv.c                                            |    2 
 drivers/interconnect/debugfs-client.c                                             |    7 
 drivers/interconnect/qcom/msm8996.c                                               |    1 
 drivers/iommu/amd/debugfs.c                                                       |    2 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                                       |    2 
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c                                        |   27 
 drivers/iommu/intel/iommu.h                                                       |    2 
 drivers/irqchip/irq-bcm2712-mip.c                                                 |    3 
 drivers/irqchip/irq-bcm7038-l1.c                                                  |    8 
 drivers/irqchip/irq-bcm7120-l2.c                                                  |   17 
 drivers/irqchip/irq-brcmstb-l2.c                                                  |   12 
 drivers/irqchip/irq-imx-mu-msi.c                                                  |   14 
 drivers/irqchip/irq-mchp-eic.c                                                    |    2 
 drivers/irqchip/irq-renesas-rzg2l.c                                               |    6 
 drivers/irqchip/irq-starfive-jh8100-intc.c                                        |    3 
 drivers/irqchip/qcom-irq-combiner.c                                               |    2 
 drivers/leds/leds-netxbig.c                                                       |   36 
 drivers/leds/leds-upboard.c                                                       |    2 
 drivers/leds/rgb/leds-qcom-lpg.c                                                  |    4 
 drivers/macintosh/mac_hid.c                                                       |    3 
 drivers/md/dm-log-writes.c                                                        |    1 
 drivers/md/dm-raid.c                                                              |    2 
 drivers/md/md.c                                                                   |   23 
 drivers/md/md.h                                                                   |    9 
 drivers/md/raid5.c                                                                |    6 
 drivers/mfd/da9055-core.c                                                         |    1 
 drivers/mfd/mt6358-irq.c                                                          |    1 
 drivers/mfd/mt6397-irq.c                                                          |    1 
 drivers/misc/rp1/rp1_pci.c                                                        |    3 
 drivers/mtd/lpddr/lpddr_cmds.c                                                    |    8 
 drivers/mtd/nand/raw/lpc32xx_slc.c                                                |    2 
 drivers/mtd/nand/raw/marvell_nand.c                                               |   13 
 drivers/mtd/nand/raw/nand_base.c                                                  |   13 
 drivers/mtd/nand/raw/renesas-nand-controller.c                                    |    5 
 drivers/net/dsa/b53/b53_common.c                                                  |  315 +++-
 drivers/net/dsa/b53/b53_priv.h                                                    |  111 +
 drivers/net/dsa/b53/b53_regs.h                                                    |   41 
 drivers/net/dsa/xrs700x/xrs700x.c                                                 |   11 
 drivers/net/ethernet/intel/iavf/iavf_ptp.c                                        |    7 
 drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c                                |   20 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                                 |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c                                 |    3 
 drivers/net/phy/adin1100.c                                                        |    2 
 drivers/net/phy/aquantia/aquantia_firmware.c                                      |    2 
 drivers/net/phy/mscc/mscc_main.c                                                  |    6 
 drivers/net/phy/phy-core.c                                                        |   43 
 drivers/net/phy/realtek/realtek_main.c                                            |   65 
 drivers/net/wireless/ath/ath10k/core.c                                            |   20 
 drivers/net/wireless/ath/ath10k/core.h                                            |    2 
 drivers/net/wireless/ath/ath10k/mac.c                                             |    2 
 drivers/net/wireless/ath/ath11k/mac.c                                             |    8 
 drivers/net/wireless/ath/ath11k/pci.c                                             |   20 
 drivers/net/wireless/ath/ath11k/wmi.c                                             |   20 
 drivers/net/wireless/ath/ath11k/wmi.h                                             |    2 
 drivers/net/wireless/ath/ath12k/core.c                                            |   24 
 drivers/net/wireless/ath/ath12k/core.h                                            |    1 
 drivers/net/wireless/ath/ath12k/dp_rx.c                                           |   70 -
 drivers/net/wireless/ath/ath12k/hal_rx.c                                          |   10 
 drivers/net/wireless/ath/ath12k/mac.c                                             |   16 
 drivers/net/wireless/ath/ath12k/pci.c                                             |   20 
 drivers/net/wireless/ath/ath12k/qmi.c                                             |   11 
 drivers/net/wireless/ath/ath12k/qmi.h                                             |    5 
 drivers/net/wireless/ath/ath12k/wmi.c                                             |   23 
 drivers/net/wireless/ath/ath12k/wmi.h                                             |    2 
 drivers/net/wireless/ath/ath12k/wow.c                                             |    1 
 drivers/net/wireless/intel/iwlwifi/mld/d3.c                                       |    4 
 drivers/net/wireless/mediatek/mt76/mt76.h                                         |    9 
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c                                   |    4 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c                              |   25 
 drivers/net/wireless/mediatek/mt76/mt7925/main.c                                  |    1 
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c                                   |   23 
 drivers/net/wireless/mediatek/mt76/mt792x_core.c                                  |    7 
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                                   |    6 
 drivers/net/wireless/mediatek/mt76/mt7996/main.c                                  |   95 -
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                                   |   30 
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c                                  |    1 
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h                                |    9 
 drivers/net/wireless/mediatek/mt76/wed.c                                          |   10 
 drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c                                |    9 
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c                                |   27 
 drivers/net/wireless/realtek/rtw89/usb.c                                          |   13 
 drivers/net/wireless/st/cw1200/bh.c                                               |    6 
 drivers/nvme/host/auth.c                                                          |    2 
 drivers/of/fdt.c                                                                  |   57 
 drivers/of/of_kunit_helpers.c                                                     |    5 
 drivers/pci/controller/Kconfig                                                    |    7 
 drivers/pci/controller/dwc/pci-keystone.c                                         |    2 
 drivers/pci/controller/dwc/pcie-designware.h                                      |    2 
 drivers/pci/endpoint/functions/pci-epf-test.c                                     |    5 
 drivers/pci/setup-bus.c                                                           |    5 
 drivers/phy/freescale/phy-fsl-imx8qm-hsio.c                                       |    5 
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                                          |   20 
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c                                |  568 ++++----
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c                                 |   27 
 drivers/pinctrl/pinctrl-single.c                                                  |    7 
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                                           |    6 
 drivers/pinctrl/stm32/pinctrl-stm32.c                                             |    2 
 drivers/platform/x86/asus-wmi.c                                                   |    8 
 drivers/platform/x86/intel/pmc/core.h                                             |    2 
 drivers/power/supply/apm_power.c                                                  |    3 
 drivers/power/supply/cw2015_battery.c                                             |    8 
 drivers/power/supply/max17040_battery.c                                           |    6 
 drivers/power/supply/rt5033_charger.c                                             |    2 
 drivers/power/supply/rt9467-charger.c                                             |    6 
 drivers/power/supply/wm831x_power.c                                               |   10 
 drivers/pwm/pwm-bcm2835.c                                                         |   28 
 drivers/ras/ras.c                                                                 |   40 
 drivers/regulator/core.c                                                          |   37 
 drivers/regulator/fixed.c                                                         |   11 
 drivers/regulator/pca9450-regulator.c                                             |    7 
 drivers/remoteproc/imx_rproc.c                                                    |    9 
 drivers/remoteproc/qcom_q6v5_wcss.c                                               |    8 
 drivers/rtc/rtc-amlogic-a4.c                                                      |    4 
 drivers/rtc/rtc-gamecube.c                                                        |    4 
 drivers/rtc/rtc-max31335.c                                                        |    6 
 drivers/s390/crypto/ap_bus.c                                                      |    8 
 drivers/scsi/imm.c                                                                |    1 
 drivers/scsi/qla2xxx/qla_nvme.c                                                   |    2 
 drivers/scsi/sim710.c                                                             |    2 
 drivers/scsi/smartpqi/smartpqi_init.c                                             |   19 
 drivers/scsi/stex.c                                                               |    1 
 drivers/soc/qcom/qcom_gsbi.c                                                      |    8 
 drivers/soc/qcom/smem.c                                                           |    3 
 drivers/spi/spi-airoha-snfi.c                                                     |   25 
 drivers/spi/spi-ch341.c                                                           |    2 
 drivers/spi/spi-sg2044-nor.c                                                      |    4 
 drivers/spi/spi-tegra210-quad.c                                                   |   22 
 drivers/staging/fbtft/fbtft-core.c                                                |    4 
 drivers/staging/most/Kconfig                                                      |    2 
 drivers/staging/most/Makefile                                                     |    1 
 drivers/staging/most/i2c/Kconfig                                                  |   13 
 drivers/staging/most/i2c/Makefile                                                 |    4 
 drivers/staging/most/i2c/i2c.c                                                    |  374 -----
 drivers/target/target_core_configfs.c                                             |    1 
 drivers/target/target_core_stat.c                                                 |   24 
 drivers/tty/serial/imx.c                                                          |   14 
 drivers/ufs/core/ufshcd-priv.h                                                    |    2 
 drivers/ufs/core/ufshcd.c                                                         |    2 
 drivers/ufs/host/ufs-rockchip.c                                                   |   19 
 drivers/uio/uio_fsl_elbc_gpcm.c                                                   |    7 
 drivers/usb/core/message.c                                                        |    2 
 drivers/usb/dwc2/platform.c                                                       |   17 
 drivers/usb/dwc3/host.c                                                           |    5 
 drivers/usb/gadget/legacy/raw_gadget.c                                            |    3 
 drivers/usb/gadget/udc/tegra-xudc.c                                               |    6 
 drivers/usb/misc/chaoskey.c                                                       |   16 
 drivers/usb/phy/phy.c                                                             |    4 
 drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c                                       |    2 
 drivers/vdpa/mlx5/net/mlx5_vnet.c                                                 |    2 
 drivers/vdpa/pds/vdpa_dev.c                                                       |    2 
 drivers/vfio/pci/vfio_pci_core.c                                                  |   68 
 drivers/vfio/pci/vfio_pci_intrs.c                                                 |   52 
 drivers/vfio/pci/vfio_pci_priv.h                                                  |    4 
 drivers/vhost/net.c                                                               |   12 
 drivers/vhost/vhost.c                                                             |    4 
 drivers/video/backlight/led_bl.c                                                  |   13 
 drivers/video/fbdev/ssd1307fb.c                                                   |    4 
 drivers/virtio/virtio.c                                                           |   12 
 drivers/virtio/virtio_debug.c                                                     |   10 
 drivers/virtio/virtio_pci_modern_dev.c                                            |    6 
 drivers/virtio/virtio_vdpa.c                                                      |    2 
 drivers/watchdog/starfive-wdt.c                                                   |    4 
 drivers/watchdog/wdat_wdt.c                                                       |   64 
 fs/9p/v9fs.c                                                                      |    4 
 fs/9p/vfs_file.c                                                                  |   11 
 fs/9p/vfs_inode.c                                                                 |    3 
 fs/9p/vfs_inode_dotl.c                                                            |    2 
 fs/btrfs/block-group.c                                                            |    6 
 fs/btrfs/ctree.c                                                                  |    2 
 fs/btrfs/delayed-ref.c                                                            |   43 
 fs/btrfs/space-info.c                                                             |   22 
 fs/btrfs/space-info.h                                                             |    6 
 fs/erofs/super.c                                                                  |   38 
 fs/ext4/mballoc.c                                                                 |   49 
 fs/ext4/move_extent.c                                                             |    2 
 fs/f2fs/f2fs.h                                                                    |    2 
 fs/f2fs/gc.c                                                                      |  134 +
 fs/f2fs/recovery.c                                                                |    2 
 fs/f2fs/segment.c                                                                 |   38 
 fs/f2fs/segment.h                                                                 |    8 
 fs/f2fs/super.c                                                                   |   14 
 fs/f2fs/sysfs.c                                                                   |    7 
 fs/fuse/control.c                                                                 |   19 
 fs/gfs2/glock.c                                                                   |    5 
 fs/gfs2/inode.c                                                                   |   15 
 fs/gfs2/inode.h                                                                   |    1 
 fs/gfs2/ops_fstype.c                                                              |    2 
 fs/iomap/direct-io.c                                                              |   13 
 fs/nfs/client.c                                                                   |   21 
 fs/nfs/dir.c                                                                      |   27 
 fs/nfs/internal.h                                                                 |    3 
 fs/nfs/namespace.c                                                                |   11 
 fs/nfs/nfs4client.c                                                               |   18 
 fs/nfs/nfs4proc.c                                                                 |   27 
 fs/nfs/pnfs.c                                                                     |    1 
 fs/nfs/super.c                                                                    |   33 
 fs/nfsd/blocklayout.c                                                             |    4 
 fs/nls/nls_base.c                                                                 |   27 
 fs/ntfs3/frecord.c                                                                |    8 
 fs/ntfs3/fsntfs.c                                                                 |    9 
 fs/ntfs3/inode.c                                                                  |    2 
 fs/ocfs2/alloc.c                                                                  |    1 
 fs/ocfs2/inode.c                                                                  |   10 
 fs/ocfs2/move_extents.c                                                           |    8 
 fs/pidfs.c                                                                        |    2 
 fs/smb/client/cifssmb.c                                                           |    2 
 fs/smb/client/smb2pdu.c                                                           |    2 
 fs/tracefs/event_inode.c                                                          |    3 
 include/asm-generic/mshyperv.h                                                    |   17 
 include/asm-generic/rqspinlock.h                                                  |   60 
 include/dt-bindings/clock/qcom,x1e80100-gcc.h                                     |   61 
 include/linux/blk_types.h                                                         |    5 
 include/linux/cleanup.h                                                           |   15 
 include/linux/coresight.h                                                         |   35 
 include/linux/cper.h                                                              |   12 
 include/linux/f2fs_fs.h                                                           |    5 
 include/linux/filter.h                                                            |   12 
 include/linux/firmware/qcom/qcom_tzmem.h                                          |   15 
 include/linux/ieee80211.h                                                         |    4 
 include/linux/if_hsr.h                                                            |    9 
 include/linux/irq-entry-common.h                                                  |    2 
 include/linux/nfs_fs_sb.h                                                         |    5 
 include/linux/of_fdt.h                                                            |    9 
 include/linux/perf_event.h                                                        |    2 
 include/linux/phy.h                                                               |    3 
 include/linux/platform_data/lp855x.h                                              |    4 
 include/linux/ras.h                                                               |   16 
 include/linux/rculist_nulls.h                                                     |   59 
 include/linux/soc/mediatek/mtk_wed.h                                              |    1 
 include/linux/tty_port.h                                                          |   14 
 include/linux/vfio_pci_core.h                                                     |   10 
 include/linux/virtio.h                                                            |    2 
 include/linux/virtio_config.h                                                     |   10 
 include/linux/virtio_features.h                                                   |   29 
 include/linux/virtio_pci_modern.h                                                 |    8 
 include/net/netfilter/nf_conntrack_count.h                                        |   17 
 include/net/sock.h                                                                |   13 
 include/ras/ras_event.h                                                           |   49 
 include/sound/tas2781.h                                                           |    2 
 include/target/target_core_base.h                                                 |   12 
 include/uapi/linux/pidfd.h                                                        |    1 
 include/uapi/sound/asound.h                                                       |    2 
 include/ufs/ufshcd.h                                                              |    1 
 io_uring/io_uring.c                                                               |   10 
 kernel/bpf/hashtab.c                                                              |   10 
 kernel/bpf/helpers.c                                                              |    3 
 kernel/bpf/rqspinlock.c                                                           |   36 
 kernel/bpf/stackmap.c                                                             |   66 
 kernel/bpf/syscall.c                                                              |    3 
 kernel/bpf/trampoline.c                                                           |    4 
 kernel/cgroup/cpuset.c                                                            |   35 
 kernel/cpu.c                                                                      |   25 
 kernel/dma/pool.c                                                                 |    2 
 kernel/events/callchain.c                                                         |   12 
 kernel/events/core.c                                                              |   24 
 kernel/locking/locktorture.c                                                      |    8 
 kernel/resource.c                                                                 |   10 
 kernel/sched/fair.c                                                               |   17 
 kernel/sched/stats.h                                                              |    7 
 kernel/task_work.c                                                                |    8 
 kernel/time/timer_migration.c                                                     |  250 +--
 lib/vsprintf.c                                                                    |    6 
 net/core/filter.c                                                                 |    9 
 net/core/netpoll.c                                                                |    2 
 net/hsr/hsr_device.c                                                              |   20 
 net/hsr/hsr_slave.c                                                               |    7 
 net/ipv4/inet_hashtables.c                                                        |    8 
 net/ipv4/inet_timewait_sock.c                                                     |   35 
 net/ipv6/ip6_fib.c                                                                |    4 
 net/mac80211/aes_cmac.c                                                           |   63 
 net/mac80211/aes_cmac.h                                                           |    8 
 net/mac80211/wpa.c                                                                |   20 
 net/netfilter/nf_conncount.c                                                      |  187 +-
 net/netfilter/nft_connlimit.c                                                     |   34 
 net/netfilter/nft_flow_offload.c                                                  |    9 
 net/netfilter/xt_connlimit.c                                                      |   14 
 net/openvswitch/conntrack.c                                                       |   16 
 net/sched/sch_cake.c                                                              |   58 
 net/sctp/socket.c                                                                 |    5 
 scripts/package/install-extmod-build                                              |    2 
 security/integrity/ima/ima_main.c                                                 |   42 
 security/integrity/ima/ima_policy.c                                               |    2 
 security/smack/smack.h                                                            |    3 
 security/smack/smack_access.c                                                     |   93 +
 security/smack/smack_lsm.c                                                        |  279 ++-
 sound/firewire/dice/dice-extension.c                                              |    4 
 sound/firewire/motu/motu-hwdep.c                                                  |    7 
 sound/hda/codecs/realtek/alc269.c                                                 |    2 
 sound/hda/codecs/side-codecs/cs35l41_hda.c                                        |    2 
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c                                    |   44 
 sound/isa/wavefront/wavefront_synth.c                                             |    4 
 sound/soc/amd/acp/acp-i2s.c                                                       |    2 
 sound/soc/amd/acp/acp-legacy-common.c                                             |   30 
 sound/soc/bcm/bcm63xx-pcm-whistler.c                                              |    4 
 sound/soc/codecs/Kconfig                                                          |    5 
 sound/soc/codecs/Makefile                                                         |    2 
 sound/soc/codecs/ak4458.c                                                         |   10 
 sound/soc/codecs/ak5558.c                                                         |   10 
 sound/soc/codecs/nau8325.c                                                        |    7 
 sound/soc/codecs/tas2781-i2c.c                                                    |    2 
 sound/soc/fsl/fsl_xcvr.c                                                          |    2 
 sound/soc/intel/catpt/pcm.c                                                       |    4 
 sound/soc/sdca/sdca_functions.c                                                   |    2 
 tools/include/nolibc/dirent.h                                                     |    6 
 tools/include/nolibc/stdio.h                                                      |    4 
 tools/include/nolibc/sys/wait.h                                                   |   18 
 tools/lib/bpf/btf.c                                                               |    4 
 tools/objtool/check.c                                                             |    3 
 tools/objtool/elf.c                                                               |    8 
 tools/perf/builtin-record.c                                                       |    2 
 tools/perf/builtin-stat.c                                                         |   13 
 tools/perf/util/annotate.c                                                        |    2 
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c                             |   25 
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h                             |   15 
 tools/perf/util/bpf_counter.c                                                     |    7 
 tools/perf/util/bpf_lock_contention.c                                             |    6 
 tools/perf/util/evsel.c                                                           |    2 
 tools/perf/util/genelf.c                                                          |   32 
 tools/perf/util/hist.c                                                            |    6 
 tools/perf/util/hwmon_pmu.c                                                       |    3 
 tools/perf/util/parse-events.c                                                    |   28 
 tools/perf/util/parse-events.h                                                    |    3 
 tools/perf/util/parse-events.y                                                    |    2 
 tools/perf/util/symbol.c                                                          |    5 
 tools/power/x86/turbostat/turbostat.c                                             |   12 
 tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c                          |    3 
 tools/testing/selftests/bpf/prog_tests/perf_branches.c                            |   22 
 tools/testing/selftests/bpf/prog_tests/send_signal.c                              |    5 
 tools/testing/selftests/bpf/progs/test_perf_branches.c                            |    3 
 tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh                |    1 
 tools/testing/selftests/net/packetdrill/tcp_syscall_bad_arg_sendmsg-empty-iov.pkt |    4 
 tools/testing/selftests/net/packetdrill/tcp_zerocopy_basic.pkt                    |    2 
 tools/testing/selftests/net/packetdrill/tcp_zerocopy_batch.pkt                    |    2 
 tools/testing/selftests/net/packetdrill/tcp_zerocopy_client.pkt                   |    2 
 tools/testing/selftests/net/packetdrill/tcp_zerocopy_closed.pkt                   |    2 
 tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_edge.pkt               |    3 
 tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_exclusive.pkt          |    3 
 tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_oneshot.pkt            |    3 
 tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-client.pkt          |    2 
 tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-server.pkt          |    2 
 tools/testing/selftests/net/packetdrill/tcp_zerocopy_maxfrags.pkt                 |    2 
 tools/testing/selftests/net/packetdrill/tcp_zerocopy_small.pkt                    |    2 
 503 files changed, 6028 insertions(+), 3269 deletions(-)

Aashish Sharma (1):
      iommu/vt-d: Fix unused invalidation hint in qi_desc_iotlb

Abdun Nihaal (4):
      wifi: ath12k: fix potential memory leak in ath12k_wow_arp_ns_offload()
      wifi: cw1200: Fix potential memory leak in cw1200_bh_rx_helper()
      wifi: rtl818x: Fix potential memory leaks in rtl8180_init_rx_ring()
      fbdev: ssd1307fb: fix potential page leak in ssd1307fb_probe()

Abel Vesa (1):
      kbuild: install-extmod-build: Properly fix CC expansion when ccache is used

Ahelenia Ziemiańska (1):
      power: supply: apm_power: only unset own apm_get_power_status

Akash Goel (3):
      drm/panthor: Fix potential memleak of vma structure
      drm/panthor: Avoid adding of kernel BOs to extobj list
      drm/panthor: Prevent potential UAF in group creation

Akhil P Oommen (3):
      drm/msm/a6xx: Flush LRZ cache before PT switch
      drm/msm/a6xx: Fix the gemnoc workaround
      drm/msm/a6xx: Improve MX rail fallback in RPMH vote init

Al Viro (2):
      fuse_ctl_add_conn(): fix nlink breakage in case of early failure
      tracefs: fix a leak in eventfs_create_events_dir()

Alan Maguire (1):
      libbpf: Fix parsing of multi-split BTF

Aleksei Nikiforov (1):
      s390/fpu: Fix false-positive kmsan report in fpu_vstl()

Alex Deucher (1):
      drm/amdgpu/userq: fix SDMA and compute validation

Alex Williamson (1):
      vfio/pci: Use RCU for error/request triggers to avoid circular locking

Alexander Dahl (1):
      net: phy: adin1100: Fix software power-down ready condition

Alexander Martinz (1):
      arm64: dts: qcom: qcm6490-shift-otter: Add missing reserved-memory

Alexander Stein (1):
      arm64: dts: imx95-tqma9596sa: reduce maximum FlexSPI frequency to 66MHz

Alexandre Courbot (1):
      firmware_loader: make RUST_FW_LOADER_ABSTRACTIONS select FW_LOADER

Alexandru Gagniuc (1):
      remoteproc: qcom_q6v5_wcss: fix parsing of qcom,halt-regs

Alexei Starovoitov (1):
      selftests/bpf: Fix failure paths in send_signal test

Alexey Kodanev (1):
      net: stmmac: fix rx limit check in stmmac_rx_zc()

Alexey Simakov (1):
      dm-raid: fix possible NULL dereference with undefined raid type

Alok Tiwari (3):
      virtio_vdpa: fix misleading return in void function
      vdpa/mlx5: Fix incorrect error code reporting in query_virtqueues
      vdpa/pds: use %pe for ERR_PTR() in event handler registration

Andreas Gruenbacher (1):
      gfs2: Prevent recursive memory reclaim

Andres J Rosa (1):
      ALSA: uapi: Fix typo in asound.h comment

Andy Shevchenko (1):
      lib/vsprintf: Check pointer before dereferencing in time_and_date()

Antheas Kapenekakis (2):
      ALSA: hda/realtek: Add match for ASUS Xbox Ally projects
      ALSA: hda/tas2781: fix speaker id retrieval for multiple probes

Anton Khirnov (1):
      platform/x86: asus-wmi: use brightness_set_blocking() for kbd led

Armin Wolf (2):
      fs/nls: Fix utf16 to utf8 conversion
      fs/nls: Fix inconsistency between utf8_to_utf32() and utf32_to_utf8()

Arnaud Lecomte (2):
      bpf: Refactor stack map trace depth calculation into helper function
      bpf: Fix stackmap overflow check in __bpf_get_stackid()

Arnd Bergmann (1):
      random: use offstack cpumask when necessary

Aryan Srivastava (2):
      Revert "mtd: rawnand: marvell: fix layouts"
      mtd: nand: relax ECC parameter validation check

Baochen Qiang (7):
      wifi: ath11k: restore register window after global reset
      wifi: ath12k: fix VHT MCS assignment
      wifi: ath11k: fix VHT MCS assignment
      wifi: ath11k: fix peer HE MCS assignment
      wifi: ath12k: restore register window after global reset
      wifi: ath12k: fix reusing m3 memory
      wifi: ath12k: fix error handling in creating hardware group

Bart Van Assche (4):
      block/mq-deadline: Introduce dd_start_request()
      block/mq-deadline: Switch back to a single dispatch list
      scsi: ufs: core: Move the ufshcd_enable_intr() declaration
      scsi: target: Do not write NUL characters into ASCII configfs output

Bean Huo (1):
      scsi: ufs: core: fix incorrect buffer duplication in ufshcd_read_string_desc()

Benjamin Berg (2):
      tools/nolibc/stdio: let perror work when NOLIBC_IGNORE_ERRNO is set
      tools/nolibc/dirent: avoid errno in readdir_r

Bhanu Seshu Kumar Valluri (1):
      PCI: endpoint: pci-epf-test: Fix sleeping function being called from atomic context

Biju Das (1):
      pinctrl: renesas: rzg2l: Fix PMC restore

Boris Brezillon (3):
      drm/panthor: Handle errors returned by drm_sched_entity_init()
      drm/panthor: Fix group_free_queue() for partially initialized queues
      drm/panthor: Fix UAF on kernel BO VA nodes

Boris Burkov (1):
      btrfs: fix racy bitfield write in btrfs_clear_space_info_full()

Breno Leitao (1):
      net: netpoll: initialize work queue before error checks

Carl Worth (1):
      coresight: tmc: add the handle of the event to the path

Cezary Rojewski (1):
      ASoC: Intel: catpt: Fix error path in hw_params()

Charles Keepax (1):
      ASoC: SDCA: Fix missing dash in HIDE DisCo property

Charles Mirabile (1):
      clk: spacemit: Set clk_hw_onecell_data::num before using flex array

Chen Ridong (1):
      cpuset: Treat cpusets in attaching as populated

Chia-I Wu (1):
      panthor: save task pid and comm in panthor_group

Chien Wong (1):
      wifi: mac80211: fix CMAC functions not handling errors

Christian Brauner (3):
      pidfs: add missing PIDFD_INFO_SIZE_VER1
      pidfs: add missing BUILD_BUG_ON() assert on struct pidfd_info
      cleanup: fix scoped_class()

Christoph Hellwig (1):
      iomap: always run error completions in user context

Christophe JAILLET (2):
      phy: renesas: rcar-gen3-usb2: Fix an error handling path in rcar_gen3_phy_usb2_probe()
      misc: rp1: Fix an error handling path in rp1_probe()

Christophe Leroy (1):
      powerpc/32: Fix unpaired stwcx. on interrupt exit

Cong Zhang (1):
      blk-mq: Abort suspend when wakeup events are pending

Cristian Ciocaltea (3):
      phy: rockchip: samsung-hdptx: Fix reported clock rate in high bpc mode
      phy: rockchip: samsung-hdptx: Reduce ROPLL loop bandwidth
      phy: rockchip: samsung-hdptx: Prevent Inter-Pair Skew from exceeding the limits

Cyrille Pitchen (1):
      drm: atmel-hlcdc: fix atmel_xlcdc_plane_setup_scaler()

Daeho Jeong (2):
      f2fs: maintain one time GC mode is enabled during whole zoned GC cycle
      f2fs: revert summary entry count from 2048 to 512 in 16kb block support

Dan Carpenter (4):
      regulator: pca9450: Fix error code in probe()
      drm/amd/display: Fix logical vs bitwise bug in get_embedded_panel_info_v2_1()
      drm/plane: Fix IS_ERR() vs NULL check in drm_plane_create_hotspot_properties()
      irqchip/mchp-eic: Fix error code in mchp_eic_domain_alloc()

Danilo Krummrich (1):
      drm: nova: select NOVA_CORE

Dapeng Mi (2):
      perf/x86: Fix NULL event access and potential PEBS record loss
      perf/x86/intel: Correct large PEBS flag check

Dave Kleikamp (1):
      dma/pool: eliminate alloc_pages warning in atomic_pool_expand

David Gow (1):
      um: Don't rename vmap to kernel_vmap

David Howells (2):
      cifs: Fix handling of a beyond-EOF DIO/unbuffered read over SMB1
      cifs: Fix handling of a beyond-EOF DIO/unbuffered read over SMB2

Denis Arefev (1):
      ALSA: hda: cs35l41: Fix NULL pointer dereference in cs35l41_hda_read_acpi()

Dibin Moolakadan Subrahmanian (1):
      drm/i915/fbdev: Hold runtime PM ref during fbdev BO creation

Dinh Nguyen (1):
      firmware: stratix10-svc: fix make htmldocs warning for stratix10_svc

Diogo Ivo (1):
      usb: phy: Initialize struct usb_phy list_head

Dmitry Antipov (2):
      ocfs2: relax BUG() to ocfs2_error() in __ocfs2_move_extent()
      ocfs2: fix memory leak in ocfs2_merge_rec_left()

Dmitry Baryshkov (4):
      interconnect: qcom: msm8996: add missing link to SLAVE_USB_HS
      arm64: dts: qcom: msm8996: add interconnect paths to USB2 controller
      drm/msm/dpu: drop dpu_hw_dsc_destroy() prototype
      drm/msm/a2xx: stop over-complaining about the legacy firmware

Duoming Zhou (3):
      scsi: imm: Fix use-after-free bug caused by unfinished delayed work
      usb: typec: ucsi: fix probe failure in gaokun_ucsi_probe()
      usb: typec: ucsi: fix use-after-free caused by uec->work

Dylan Hatch (1):
      objtool: Fix standalone --hacks=jump_label

Dzmitry Sankouski (2):
      arm64: dts: qcom: sdm845-starqltechn: remove (address|size)-cells
      arm64: dts: qcom: sdm845-starqltechn: fix max77705 interrupts

Edward Adam Davis (3):
      ntfs3: init run lock for extend inode
      fs/ntfs3: out1 also needs to put mi
      fs/ntfs3: Prevent memory leaks in add sub record

Eric Gonçalves (1):
      arm64: dts: qcom: starqltechn: remove extra empty line

Eric Sandeen (1):
      9p: fix cache/debug options printing in v9fs_show_options

Evan Li (1):
      perf/x86/intel: Fix NULL event dereference crash in handle_pmi_common()

FUKAUMI Naoki (3):
      arm64: dts: rockchip: Move the EEPROM to correct I2C bus on Radxa ROCK 5A
      arm64: dts: rockchip: Add eeprom vcc-supply for Radxa ROCK 5A
      arm64: dts: rockchip: Add eeprom vcc-supply for Radxa ROCK 3C

Fangyu Yu (1):
      RISC-V: KVM: Fix guest page fault within HLV* instructions

Fedor Pchelkin (3):
      wifi: rtw89: usb: use common error path for skbs in rtw89_usb_rx_handler()
      wifi: rtw89: usb: fix leak in rtw89_usb_write_port()
      Revert "wifi: mt76: mt792x: improve monitor interface handling"

Felix Fietkau (1):
      wifi: mt76: mt7996: fix null pointer deref in mt7996_conf_tx()

Fenglin Wu (1):
      leds: rgb: leds-qcom-lpg: Don't enable TRILED when configuring PWM

Fernand Sieber (1):
      sched/fair: Forfeit vruntime on yield

Fernando Fernandez Mancera (3):
      ipv6: clear RA flags when adding a static route
      netfilter: nf_conncount: rework API to use sk_buff directly
      netfilter: nft_connlimit: update the count if add was skipped

Filipe Manana (1):
      btrfs: fix leaf leak in an error path in btrfs_del_items()

Francesco Lavra (1):
      iio: imu: st_lsm6dsx: Fix measurement unit for odr struct member

Frank Li (1):
      i3c: fix refcount inconsistency in i3c_master_register

Frederic Weisbecker (3):
      timers/migration: Convert "while" loops to use "for"
      timers/migration: Remove locking on group connection
      timers/migration: Fix imbalanced NUMA trees

Gabor Juhos (1):
      regulator: core: disable supply if enabling main regulator fails

Gao Xiang (2):
      erofs: correct FSDAX detection
      erofs: limit the level of fs stacking for file-backed mounts

Gautham R. Shenoy (1):
      cpufreq/amd-pstate: Call cppc_set_auto_sel() only for online CPUs

Geert Uytterhoeven (2):
      PCI: rcar-gen2: Drop ARM dependency from PCI_RCAR_GEN2
      drm/imagination: Fix reference to devm_platform_get_and_ioremap_resource()

Gergo Koteles (1):
      arm64: dts: qcom: sdm845-oneplus: Correct gpio used for slider

Gopi Krishna Menon (1):
      usb: raw-gadget: cap raw_io transfer length to KMALLOC_MAX_SIZE

Greg Kroah-Hartman (1):
      Linux 6.17.13

Guenter Roeck (2):
      block/blk-throttle: Fix throttle slice time for SSDs
      of: Skip devicetree kunit tests when RISCV+ACPI doesn't populate root node

Guido Günther (2):
      drm/panel: visionox-rm69299: Fix clock frequency for SHIFT6mq
      drm/panel: visionox-rm69299: Don't clear all mode flags

Hangbin Liu (1):
      selftests: bonding: add delay before each xvlan_over_bond connectivity check

Haotian Zhang (26):
      soc: qcom: gsbi: fix double disable caused by devm
      mtd: rawnand: lpc32xx_slc: fix GPIO descriptor leak on probe error and remove
      soc: qcom: smem: fix hwspinlock resource leak in probe error paths
      pinctrl: stm32: fix hwspinlock resource leak in probe function
      power: supply: rt5033_charger: Fix device node reference leaks
      mfd: da9055: Fix missing regmap_del_irq_chip() in error path
      scsi: stex: Fix reboot_notifier leak in probe error path
      clk: renesas: r9a06g032: Fix memory leak in error path
      ACPI: property: Fix fwnode refcount leak in acpi_fwnode_graph_parse_endpoint()
      scsi: sim710: Fix resource leak by adding missing ioport_unmap() calls
      leds: netxbig: Fix GPIO descriptor leak in error paths
      watchdog: wdat_wdt: Fix ACPI table leak in probe function
      watchdog: starfive: Fix resource leak in probe error path
      mfd: mt6397-irq: Fix missing irq_domain_remove() in error path
      mfd: mt6358-irq: Fix missing irq_domain_remove() in error path
      crypto: starfive - Correctly handle return of sg_nents_for_len
      crypto: ccree - Correctly handle return of sg_nents_for_len
      clocksource/drivers/ralink: Fix resource leaks in init error path
      greybus: gb-beagleplay: Fix timeout handling in bootloader functions
      hwmon: sy7636a: Fix regulator_enable resource leak on error path
      mtd: rawnand: renesas: Handle devm_pm_runtime_enable() errors
      pinctrl: single: Fix incorrect type for error return variable
      rtc: amlogic-a4: fix double free caused by devm
      ASoC: bcm: bcm63xx-pcm-whistler: Check return value of of_dma_configure()
      rtc: gamecube: Check the return value of ioremap()
      dm log-writes: Add missing set_freezable() for freezable kthread

Haotien Hsu (1):
      usb: gadget: tegra-xudc: Always reinitialize data toggle when clear halt

Heiko Carstens (2):
      s390/smp: Fix fallback CPU detection
      s390/ap: Don't leak debug feature files if AP instructions are not available

Hemalatha Pinnamreddy (2):
      ASoC: amd: acp: Audio is not resuming after s0ix
      ASoC: amd: acp: update tdm channels for specific DAI

Herbert Xu (3):
      crypto: authenc - Correctly pass EINPROGRESS back up to the caller
      crypto: ahash - Fix crypto_ahash_import with partial block data
      crypto: ahash - Zero positive err value in ahash_update_finish

Horatiu Vultur (1):
      phy: mscc: Fix PTP for VSC8574 and VSC8572

Howard Hsu (1):
      wifi: mt76: mt7996: fix implicit beamforming support for mt7992

Huiwen He (2):
      drm/msm: Fix NULL pointer dereference in crashstate_get_vm_logs()
      drm/msm: fix missing NULL check after kcalloc in crashstate_get_bos()

Ian Rogers (3):
      perf bpf_counter: Fix opening of "any"(-1) CPU events
      perf parse-events: Fix legacy cache events if event is duplicated in a PMU
      perf hist: In init, ensure mem_info is put on error paths

Ilias Stamatis (1):
      Reinstate "resource: avoid unnecessary lookups in find_next_iomem_res()"

Ilpo Järvinen (1):
      PCI: Prevent resource tree corruption when BAR resize fails

Inochi Amaoto (2):
      net: phy: Add helper for fixing RGMII PHY mode based on internal mac delay
      net: stmmac: dwmac-sophgo: Add phy interface filter

Israel Rukshin (1):
      nvme-auth: use kvfree() for memory allocated with kvcalloc()

Ivan Abramov (4):
      power: supply: cw2015: Check devm_delayed_work_autocancel() return code
      power: supply: max17040: Check iio_read_channel_processed() return code
      power: supply: rt9467: Return error on failure in rt9467_set_value_from_ranges()
      power: supply: wm831x: Check wm831x_set_bits() return value

Ivan Stepchenko (1):
      mtd: lpddr_cmds: fix signed shifts in lpddr_cmds

Jacek Lawrynowicz (3):
      accel/ivpu: Rework bind/unbind of imported buffers
      accel/ivpu: Fix page fault in ivpu_bo_unbind_all_bos_from_context()
      accel/ivpu: Make function parameter names consistent

Jacob Moroni (1):
      RDMA/irdma: Do not directly rely on IB_PD_UNSAFE_GLOBAL_RKEY

James Le Cuirot (1):
      kbuild: install-extmod-build: Fix when given dir outside the build dir

Jani Nikula (4):
      drm/xe/fbdev: use the same 64-byte stride alignment as i915
      drm/i915/fbdev: make intel_framebuffer_create() error return handling explicit
      drm/{i915, xe}/fbdev: pass struct drm_device to intel_fbdev_fb_alloc()
      drm/{i915, xe}/fbdev: deduplicate struct drm_mode_fb_cmd2 init

Janusz Krzysztofik (1):
      drm/vgem-fence: Fix potential deadlock on release

Jaroslav Kysela (2):
      ASoC: nau8325: use simple i2c probe function
      ASoC: nau8325: add missing build config

Jason Tian (1):
      RAS: Report all ARM processor CPER information to userspace

Jay Liu (1):
      drm/mediatek: Fix CCORR mtk_ctm_s31_32_to_s1_n function issue

Jayesh Choudhary (2):
      drm/tidss: Remove max_pclk_khz and min_pclk_khz from tidss display features
      drm/tidss: Move OLDI mode validation to OLDI bridge mode_valid hook

Jianglei Nie (1):
      staging: fbtft: core: fix potential memory leak in fbtft_probe_common()

Jihed Chaibi (3):
      ARM: dts: omap3: beagle-xm: Correct obsolete TWL4030 power compatible
      ARM: dts: omap3: n900: Correct obsolete TWL4030 power compatible
      ARM: dts: stm32: stm32mp157c-phycore: Fix STMPE811 touchscreen node properties

Jiri Slaby (SUSE) (1):
      tty: introduce tty_port_tty guard()

Jisheng Zhang (2):
      usb: dwc2: fix hang during shutdown if set as peripheral
      usb: dwc2: fix hang during suspend if set as peripheral

Johan Hovold (14):
      irqchip/bcm2712-mip: Fix OF node reference imbalance
      irqchip/bcm2712-mip: Fix section mismatch
      irqchip/irq-bcm7038-l1: Fix section mismatch
      irqchip/irq-bcm7120-l2: Fix section mismatch
      irqchip/irq-brcmstb-l2: Fix section mismatch
      irqchip/imx-mu-msi: Fix section mismatch
      irqchip/renesas-rzg2l: Fix section mismatch
      irqchip/starfive-jh8100: Fix section mismatch
      irqchip/qcom-irq-combiner: Fix section mismatch
      staging: most: remove broken i2c driver
      clocksource/drivers/stm: Fix double deregistration on probe failure
      clocksource/drivers/nxp-stm: Fix section mismatches
      clocksource/drivers/nxp-stm: Prevent driver unbind
      clk: keystone: fix compile testing

John Stultz (1):
      sched/core: Fix psi_dequeue() for Proxy Execution

Jonas Gorski (14):
      net: dsa: b53: fix VLAN_ID_IDX write size for BCM5325/65
      net: dsa: b53: fix extracting VID from entry for BCM5325/65
      net: dsa: b53: b53_arl_read{,25}(): use the entry for comparision
      net: dsa: b53: move reading ARL entries into their own function
      net: dsa: b53: move writing ARL entries into their own functions
      net: dsa: b53: provide accessors for accessing ARL_SRCH_CTL
      net: dsa: b53: split reading search entry into their own functions
      net: dsa: b53: move ARL entry functions into ops struct
      net: dsa: b53: add support for 5389/5397/5398 ARL entry format
      net: dsa: b53: use same ARL search result offset for BCM5325/65
      net: dsa: b53: fix CPU port unicast ARL entries for BCM5325/65
      net: dsa: b53: add support for bcm63xx ARL entry format
      net: dsa: b53: fix BCM5325/65 ARL entry multicast port masks
      net: dsa: b53: fix BCM5325/65 ARL entry VIDs

Jonathan Curley (1):
      NFSv4/pNFS: Clear NFS_INO_LAYOUTCOMMIT in pnfs_mark_layout_stateid_invalid

Joseph Qi (1):
      ocfs2: use correct endian in ocfs2_dinode_has_extents

Josh Poimboeuf (2):
      objtool: Fix weak symbol detection
      perf: Remove get_perf_callchain() init_nr argument

Joy Zou (1):
      arm64: dts: imx95-15x15-evk: add fan-supply property for pwm-fan

Junrui Luo (4):
      ALSA: firewire-motu: fix buffer overflow in hwdep read for DSP events
      ALSA: firewire-motu: add bounds check in put_user loop for DSP events
      ALSA: dice: fix buffer overflow in detect_stream_formats()
      ALSA: wavefront: Fix integer overflow in sample size validation

Kang Yang (1):
      wifi: ath10k: move recovery check logic into a new work

Karol Wachowski (2):
      accel/ivpu: Ensure rpm_runtime_put in case of engine reset/resume fail
      accel/ivpu: Fix DCT active percent format

Kathara Sasikumar (1):
      docs: hwmon: fix link to g762 devicetree binding

Ketil Johnsen (2):
      drm/panthor: Fix UAF race between device unplug and FW event processing
      drm/panthor: Fix race with suspend during unplug

Kevin Brodsky (1):
      ublk: prevent invalid access with DEBUG

Konrad Dybcio (3):
      dt-bindings: clock: qcom,x1e80100-gcc: Add missing USB4 clocks/resets
      clk: qcom: gcc-x1e80100: Add missing USB4 clocks/resets
      arm64: dts: qcom: sdm845-starqltechn: Fix i2c-gpio node name

Konstantin Andreev (7):
      smack: deduplicate "does access rule request transmutation"
      smack: fix bug: SMACK64TRANSMUTE set on non-directory
      smack: deduplicate xattr setting in smack_inode_init_security()
      smack: always "instantiate" inode in smack_inode_init_security()
      smack: fix bug: invalid label of unix socket file
      smack: fix bug: unprivileged task can create labels
      smack: fix bug: setting task label silently ignores input garbage

Krishna Kurapati (2):
      arm64: dts: qcom: x1e80100: Fix compile warnings for USB HS controller
      arm64: dts: qcom: x1e80100: Add missing quirk for HS only USB controller

Krzysztof Czurylo (2):
      RDMA/irdma: Fix data race in irdma_sc_ccq_arm
      RDMA/irdma: Fix data race in irdma_free_pble

Krzysztof Kozlowski (1):
      ASoC: codecs: nau8325: Silence uninitialized variables warnings

Kuan-Wei Chiu (1):
      interconnect: debugfs: Fix incorrect error handling for NULL path

Kumar Kartikeya Dwivedi (2):
      rqspinlock: Enclose lock/unlock within lock entry acquisitions
      rqspinlock: Use trylock fallback when per-CPU rqnode is busy

Kuniyuki Iwashima (1):
      sctp: Defer SCTP_DBG_OBJCNT_DEC() to sctp_destroy_sock().

Lad Prabhakar (1):
      clk: renesas: r9a09g077: Propagate rate changes to parent clocks

Len Brown (1):
      tools/power turbostat: Regression fix Uncore MHz printed in hex

Leo Yan (7):
      coresight: Change device mode to atomic type
      coresight: etm4x: Always set tracer's device mode on target CPU
      coresight: etm3x: Always set tracer's device mode on target CPU
      coresight: etm4x: Correct polling IDLE bit
      coresight: etm4x: Add context synchronization before enabling trace
      coresight: etm4x: Properly control filter in CPU idle with FEAT_TRF
      perf arm_spe: Fix memset subclass in operation

Leon Hwang (1):
      bpf: Free special fields when update [lru_,]percpu_hash maps

Li Nan (1):
      md: delete md_redundancy_group when array is becoming inactive

Li Qiang (2):
      uio: uio_fsl_elbc_gpcm:: Add null pointer check to uio_fsl_elbc_gpcm_probe
      wifi: iwlwifi: mld: add null check for kzalloc() in iwl_mld_send_proto_offload()

Liyuan Pang (1):
      ARM: 9464/1: fix input-only operand modification in load_unaligned_zeropad()

Lizhi Hou (4):
      accel/amdxdna: Fix incorrect command state for timed out job
      accel/amdxdna: Fix dma_fence leak when job is canceled
      accel/amdxdna: Clear mailbox interrupt register during channel creation
      accel/amdxdna: Fix deadlock between context destroy and job timeout

Loic Poulain (2):
      arm64: dts: qcom: qcm2290: Add CCI node
      arm64: dts: qcom: qcm2290: Fix camss register prop ordering

Long Li (1):
      macintosh/mac_hid: fix race condition in mac_hid_toggle_emumouse

Longbin Li (1):
      spi: sophgo: Fix incorrect use of bus width value macros

Lorenzo Bianconi (4):
      wifi: mt76: wed: use proper wed reference in mt76 wed driver callabacks
      wifi: mt76: mt7996: grab mt76 mutex in mt7996_mac_sta_event()
      wifi: mt76: mt7996: skip deflink accounting for offchannel links
      wifi: mt76: mt7996: Add missing locking in mt7996_mac_sta_rc_work()

Luca Ceresoli (1):
      backlight: led-bl: Add devlink to supplier LEDs

Luca Weiss (3):
      clk: qcom: camcc-sm6350: Fix PLL config of PLL2
      clk: qcom: camcc-sm7150: Fix PLL config of PLL2
      arm64: dts: qcom: qcm6490-fairphone-fp5: Add supplies to simple-fb node

Luo Jie (1):
      clk: qcom: gcc-ipq5424: Correct the icc_first_node_id

Ma Ke (1):
      RDMA/rtrs: server: Fix error handling in get_or_create_srv

Maciej Falkowski (1):
      accel/ivpu: Remove skip of dma unmap for imported buffers

Madhur Kumar (1):
      drm/nouveau: refactor deprecated strcpy

Mainak Sen (1):
      gpu: host1x: Fix race in syncpt alloc/free

Manish Dharanenthiran (1):
      wifi: ath12k: Fix timeout error during beacon stats retrieval

Manivannan Sadhasivam (1):
      dt-bindings: PCI: amlogic: Fix the register name of the DBI region

Marek Szyprowski (4):
      ARM: dts: samsung: universal_c210: turn off SDIO WLAN chip during system suspend
      ARM: dts: samsung: exynos4210-i9100: turn off SDIO WLAN chip during system suspend
      ARM: dts: samsung: exynos4210-trats: turn off SDIO WLAN chip during system suspend
      ARM: dts: samsung: exynos4412-midas: turn off SDIO WLAN chip during system suspend

Marek Vasut (3):
      clk: renesas: cpg-mssr: Add missing 1ms delay into reset toggle callback
      clk: renesas: cpg-mssr: Read back reset registers to assure values latched
      arm64: dts: renesas: sparrow-hawk: Fix full-size DP connector node name and labels

Mark Brown (1):
      regulator: fixed: Rely on the core freeing the enable GPIO

Markus Niebel (1):
      arm64: dts: imx95-tqma9596sa: fix TPM5 pinctrl node name

Martin KaFai Lau (1):
      bpf: Check skb->transport_header is set in bpf_skb_check_mtu

Matt Bobrowski (3):
      selftests/bpf: Use ASSERT_STRNEQ to factor in long slab cache names
      selftests/bpf: skip test_perf_branches_hw() on unsupported platforms
      selftests/bpf: Improve reliability of test_perf_branches_no_hw()

Mauro Carvalho Chehab (3):
      efi/cper: Add a new helper function to print bitmasks
      efi/cper: Adjust infopfx size to accept an extra space
      efi/cper: align ARM CPER type with UEFI 2.9A/2.10 specs

Mavroudis Chatzilazaridis (1):
      HID: logitech-hidpp: Do not assume FAP in hidpp_send_message_sync()

Menglong Dong (1):
      bpf: Handle return value of ftrace_set_filter_ip in register_fentry

Michael S. Tsirkin (5):
      virtio: fix typo in virtio_device_ready() comment
      virtio: fix whitespace in virtio_config_ops
      virtio: fix grammar in virtio_queue_info docs
      virtio: fix virtqueue_set_affinity() docs
      virtio: clean up features qword/dword terms

Michal Schmidt (1):
      iavf: Implement settime64 with -EOPNOTSUPP

Michal Suchanek (1):
      perf hwmon_pmu: Fix uninitialized variable warning

Mike Christie (2):
      scsi: target: Fix LUN/device R/W and total command stats
      vhost: Fix kthread worker cgroup failure handling

Mike McGowen (1):
      scsi: smartpqi: Fix device resources accessed after device removal

Mikhail Kshevetskiy (1):
      spi: airoha-snfi: en7523: workaround flash damaging if UART_TXD was short to GND

Ming Yen Hsieh (2):
      wifi: mt76: mt7925: add MBSSID support
      wifi: mt76: mt7921: add MBSSID support

Miquel Sabaté Solà (1):
      btrfs: fix double free of qgroup record after failure to add delayed ref head

Mohamed Khalfella (1):
      block: Use RCU in blk_mq_[un]quiesce_tagset() instead of set->tag_list_lock

Murad Masimov (1):
      power: supply: rt9467: Prevent using uninitialized local variable in rt9467_set_value_from_ranges()

Namhyung Kim (5):
      perf lock contention: Load kernel map before lookup
      perf tools: Fix missing feature check for inherit + SAMPLE_READ
      perf jitdump: Add sym/str-tables to build-ID generation
      perf tools: Mark split kallsyms DSOs as loaded
      perf tools: Fix split kallsyms DSO counting

Neil Armstrong (1):
      arm64: dts: qcom: sm8650: set ufs as dma coherent

Nuno Das Neves (2):
      mshv: Fix deposit memory in MSHV_ROOT_HVCALL
      mshv: Fix create memory region overlap check

Nuno Sá (1):
      rtc: max31335: Fix ignored return value in set_alarm

Oliver Neukum (1):
      usb: chaoskey: fix locking for O_NONBLOCK

Ovidiu Panait (1):
      net: stmmac: Fix VLAN 0 deletion in vlan_del_hw_rx_fltr()

Pablo Neira Ayuso (1):
      netfilter: flowtable: check for maximum number of encapsulations in bridge vlan

Pavel Begunkov (1):
      io_uring: use WRITE_ONCE for user shared memory

Peng Fan (2):
      remoteproc: imx_rproc: Fix runtime PM cleanup and improve remove path
      firmware: imx: scu-irq: fix OF node leak in

Pengjie Zhang (1):
      PM / devfreq: hisi: Fix potential UAF in OPP handling

Peter Griffin (1):
      arm64: dts: exynos: gs101: fix sysreg_apm reg property

Peter Zijlstra (2):
      task_work: Fix NMI race condition
      entry,unwind/deferred: Fix unwind_reset_info() placement

Pradeep Kumar Chitrapu (1):
      wifi: ath12k: fix TX and RX MCS rate configurations in HE mode

Praveen Talari (1):
      arm64: dts: qcom: qrb2210-rb1: Fix UART3 wakeup IRQ storm

Prike Liang (1):
      drm/amdgpu: add userq object va track helpers

Pu Lehui (1):
      bpf: Fix invalid prog->stats access when update_effective_progs fails

Rameshkumar Sundaram (1):
      wifi: ath12k: unassign arvif on scan vdev create failure

Randolph Sapp (1):
      arm64: dts: ti: k3-am62p: Fix memory ranges for GPU

Randy Dunlap (2):
      firmware: qcom: tzmem: fix qcom_tzmem_policy kernel-doc
      backlight: lp855x: Fix lp855x.h kernel-doc warnings

Raphael Pinsonneault-Thibeault (1):
      ntfs3: fix uninit memory after failed mi_read in mi_format_new

Rene Rebe (1):
      ps3disk: use memcpy_{from,to}_bvec index

René Rebe (2):
      ACPI: processor_core: fix map_x2apic_id for amd-pstate on am4
      drm/nouveau: fix circular dep oops from vendored i2c encoder

Ria Thomas (1):
      wifi: ieee80211: correct FILS status codes

Ritesh Harjani (IBM) (2):
      powerpc/64s/hash: Restrict stress_hpt_struct memblock region to within RMA limit
      powerpc/64s/ptdump: Fix kernel_hash_pagetable dump for ISA v3.00 HPTE format

Robert Marko (1):
      net: phy: aquantia: check for NVMEM deferral

Roberto Sassu (1):
      ima: Attach CREDS_CHECK IMA hook to bprm_creds_from_file LSM hook

Rodrigo Gobbi (1):
      iio: imu: bmi270: fix dev_err_probe error msg

Ryan Huang (1):
      iommu/arm-smmu-v3: Fix error check in arm_smmu_alloc_cd_tables

Sahil Chandna (1):
      bpf: Prevent nesting overflow in bpf_try_get_buffers

Sarika Sharma (1):
      wifi: ath12k: Fix MSDU buffer types handling in RX error path

Sebastian Andrzej Siewior (1):
      cpu: Make atomic hotplug callbacks run with interrupts disabled on UP

Selvin Xavier (2):
      RDMA/bnxt_re: Fix the inline size for GenP7 devices
      RDMA/bnxt_re: Pass correct flag for dma mr creation

Sergey Bashirov (1):
      NFSD/blocklayout: Fix minlength check in proc_layoutget

Seungjin Bae (2):
      USB: Fix descriptor count when handling invalid MBIM extended descriptor
      wifi: rtl818x: rtl8187: Fix potential buffer underflow in rtl8187_rx_cb()

Shaurya Rane (1):
      block: fix memory leak in __blkdev_issue_zero_pages

Shawn Lin (3):
      scsi: ufs: rockchip: Reset controller on PRE_CHANGE of hce enable notify
      phy: rockchip: naneng-combphy: Fix PCIe L1ss support RK3562
      PCI: dwc: Fix wrong PORT_LOGIC_LTSSM_STATE_MASK definition

Shayne Chen (5):
      wifi: mt76: mt7996: fix several fields in mt7996_mcu_bss_basic_tlv()
      wifi: mt76: mt7996: fix teardown command for an MLD peer
      wifi: mt76: mt7996: set link_valid field when initializing wcid
      wifi: mt76: mt7996: fix MLD group index assignment
      wifi: mt76: mt7996: fix using wrong phy to start in mt7996_mac_restart()

Shenghao Ding (1):
      ASoC: tas2781: correct the wrong period

Shengjiu Wang (3):
      ASoC: fsl_xcvr: clear the channel status control memory
      ASoC: ak4458: Disable regulator when error happens
      ASoC: ak5558: Disable regulator when error happens

Sherry Sun (1):
      tty: serial: imx: Only configure the wake register when device is set as wakeup source

Shuai Xue (1):
      perf record: skip synthesize event when open evsel failed

Siddharth Chintamaneni (1):
      bpf: Cleanup unused func args in rqspinlock implementation

Siddharth Vadapalli (1):
      PCI: keystone: Exit ks_pcie_probe() for invalid mode

Sidharth Seela (1):
      ntfs3: Fix uninit buffer allocated by __getname()

Songtang Liu (1):
      iommu/amd: Fix potential out-of-bounds read in iommu_mmio_show

Sourabh Jain (1):
      powerpc/kdump: Fix size calculation for hot-removed memory ranges

Stanley Chu (1):
      i3c: master: svc: Prevent incomplete IBI transaction

StanleyYP Wang (1):
      wifi: mt76: mt7996: fix max nss value when getting rx chainmask

Stephan Gerhold (1):
      iommu/arm-smmu-qcom: Enable use of all SMR groups when running bare-metal

Sven Peter (1):
      usb: dwc3: dwc3_power_off_all_roothub_ports: Use ioremap_np when required

T Pratham (1):
      crypto: aead - Fix reqsize handling

Taniya Das (2):
      clk: qcom: gcc-sm8750: Add a new frequency for sdcc2 clock
      clk: qcom: gcc-qcs615: Update the SDCC clock to use shared_floor_ops

Tengda Wu (1):
      x86/dumpstack: Prevent KASAN false positive warnings in __show_regs()

Thaumy Cheng (1):
      perf/core: Fix missing read event generation on task exit

Thomas Richard (1):
      leds: upboard: Fix module alias

Thomas Richard (TI.com) (1):
      firmware: ti_sci: Set IO Isolation only if the firmware is capable

Thomas Weißschuh (1):
      tools/nolibc: handle NULL wstatus argument to waitpid()

Thorsten Blum (1):
      crypto: asymmetric_keys - prevent overflow in asymmetric_key_generate_id

Tianchu Chen (1):
      spi: ch341: fix out-of-bounds memory access in ch341_transfer_one

Tianyou Li (1):
      perf annotate: Check return value of evsel__get_arch() properly

Tim Harvey (4):
      arm64: dts: freescale: imx8mp-venice-gw7905-2x: remove duplicate usdhc1 props
      arm64: dts: imx8mm-venice-gw72xx: remove unused sdhc1 pinctrl
      arm64: dts: imx8mp-venice-gw702x: remove off-board uart
      arm64: dts: imx8mp-venice-gw702x: remove off-board sdhc1

Timur Tabi (1):
      drm/nouveau: restrict the flush page to a 32-bit address

Tingmao Wang (1):
      fs/9p: Don't open remote file with APPEND mode when writeback cache is used

Tomasz Rusinowicz (1):
      accel/ivpu: Fix race condition when unbinding BOs

Trond Myklebust (9):
      NFS: Avoid changing nlink when file removes and attribute updates race
      NFS: Initialise verifiers for visible dentries in readdir and lookup
      NFS: Initialise verifiers for visible dentries in nfs_atomic_open()
      NFS: Initialise verifiers for visible dentries in _nfs4_open_and_get_state
      Revert "nfs: ignore SB_RDONLY when remounting nfs"
      Revert "nfs: clear SB_RDONLY before getting superblock"
      Revert "nfs: ignore SB_RDONLY when mounting nfs"
      NFS: Automounted filesystems should inherit ro,noexec,nodev,sync flags
      NFS: Fix inheritance of the block sizes when automounting

Troy Mitchell (1):
      i2c: spacemit: fix detect issue

Usama Arif (2):
      x86/boot: Fix page table access in 5-level to 4-level paging transition
      efi/libstub: Fix page table access in 5-level to 4-level paging transition

Uwe Kleine-König (1):
      pwm: bcm2835: Make sure the channel is enabled after pwm_request()

Vishwaroop A (1):
      spi: tegra210-quad: Fix timeout handling

Vladimir Oltean (2):
      net: phy: realtek: create rtl8211f_config_rgmii_delay()
      net: dsa: xrs700x: reject unsupported HSR configurations

Vladimir Zapolskiy (2):
      clk: qcom: camcc-sm8550: Specify Titan GDSC power domain as a parent to other
      clk: qcom: camcc-sm6350: Specify Titan GDSC power domain as a parent to other

Wang Liang (1):
      locktorture: Fix memory leak in param_set_cpumask()

Willem de Bruijn (1):
      selftests/net: packetdrill: pass send_omit_free to MSG_ZEROCOPY tests

Wludzik, Jozef (1):
      accel/ivpu: Fix race condition when mapping dmabuf

Wolfram Sang (2):
      ARM: dts: renesas: gose: Remove superfluous port property
      ARM: dts: renesas: r9a06g032-rzn1d400-db: Drop invalid #cells properties

Xi Pardee (1):
      platform/x86:intel/pmc: Update Arrow Lake telemetry GUID

Xiang Mei (1):
      net/sched: sch_cake: Fix incorrect qlen reduction in cake_drop

Xiao Ni (2):
      md: delete mddev kobj before deleting gendisk kobj
      md: avoid repeated calls to del_gendisk

Xiaogang Chen (1):
      drm/amdkfd: Use huge page size to check split svm range alignment

Xiaolei Wang (1):
      phy: freescale: Initialize priv->lock

Xiaoliang Yang (1):
      net: hsr: create an API to get hsr port type

Xiaoqi Zhuang (1):
      coresight: ETR: Fix ETR buffer use-after-free issue

Xuanqiang Luo (3):
      rculist: Add hlist_nulls_replace_rcu() and hlist_nulls_replace_init_rcu()
      inet: Avoid ehash lookup race in inet_ehash_insert()
      inet: Avoid ehash lookup race in inet_twsk_hashdance_schedule()

Yao Zi (1):
      phy: rockchip: naneng-combphy: Add SoC prefix to register definitions

Yegor Yefremov (1):
      ARM: dts: am335x-netcom-plus-2xx: add missing GPIO labels

Yongjian Sun (1):
      ext4: improve integrity checking in __mb_check_buddy by enhancing order-0 validation

Yu Kuai (1):
      md/raid5: fix IO hang when array is broken with IO inflight

Yun Zhou (1):
      md: fix rcu protection in md_wakeup_thread

Yuntao Wang (2):
      of/fdt: Consolidate duplicate code into helper functions
      of/fdt: Fix incorrect use of dt_root_addr_cells in early_init_dt_check_kho()

Zhang Rui (1):
      perf/x86/intel/cstate: Remove PC3 support from LunarLake

Zhang Yi (1):
      ext4: correct the checking of quota files before moving extents

Zhao Yipeng (1):
      ima: Handle error code returned by ima_filter_rule_match()

Zheng Qixing (2):
      nbd: defer config put in recv_work
      nbd: defer config unlock in nbd_genl_connect

Zhu Yanjun (1):
      RDMA/rxe: Fix null deref on srq->rq.queue after resize failure

Zilin Guan (3):
      crypto: iaa - Fix incorrect return value in save_iaa_wq()
      scsi: qla2xxx: Fix improper freeing of purex item
      mt76: mt7615: Fix memory leak in mt7615_mcu_wtbl_sta_add()

nieweiqiang (1):
      crypto: hisilicon/qm - restore original qos values

shechenglong (1):
      block: fix comment for op_is_zone_mgmt() to include RESET_ALL

sparkhuang (1):
      regulator: core: Protect regulator_supply_alias_list with regulator_list_mutex

xupengbo (1):
      sched/fair: Fix unfairness caused by stalled tg_load_avg_contrib when the last task migrates out


