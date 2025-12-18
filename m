Return-Path: <stable+bounces-202985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B9528CCC144
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 14:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D58EE305A4B2
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 13:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7819B339845;
	Thu, 18 Dec 2025 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mtu8Qt54"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F4533A714;
	Thu, 18 Dec 2025 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766065510; cv=none; b=Lsop8RfDLmNDpciwKzuOJa/FZZzGJFTkBRS7lJJgyix39uuC0UKkQkvK4n/H18KdVfN2hYXRRRUBxFObp0zwQYhOOaQBqJ+CPXsW/shl1qbt04mK5CeBQIhSTCpwsd5KiPap626cBJi+IDmIp6QxJnvpowgZ+t6tURRTWqkqaj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766065510; c=relaxed/simple;
	bh=iq2dzGLofBNKtBQpiKPvkEVWXTJbQ0zpZYwdyWb3DE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e2l4VS+S6pHDDxujeymYS2sBo6TChm9b6vEjvTHvuGKT3nxCV0KRX8rPQ06he2JQDjTF0Gr0oIaOPg+Tl6yQ/2tAMHIzRzWCNMXf23npxvXs7aVE/AC97PEHFCawJEQZb6CCu2/WZP5daD/OoLXXrrZ1M72hMCrpiRDxGnuU+VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mtu8Qt54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD58C116D0;
	Thu, 18 Dec 2025 13:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766065508;
	bh=iq2dzGLofBNKtBQpiKPvkEVWXTJbQ0zpZYwdyWb3DE8=;
	h=From:To:Cc:Subject:Date:From;
	b=mtu8Qt54isICoP1gB0BpEK0UieacJ6FiBkH/NKBvgzZRG6g2Eq7klty2/b76c614q
	 NRpG0bgyo+BPWYtKgUcuO9I+NdPJJMTGoRf5rP0mW6/7mSfuazfFWtzv48bW1jWsbm
	 pMh0yaDGcTKd6QRmI57TY0nwxnW5hBftSOFq3tUU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.63
Date: Thu, 18 Dec 2025 14:45:03 +0100
Message-ID: <2025121803-storewide-unripe-e237@gregkh>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.63 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-fs-f2fs                            |   52 
 Documentation/admin-guide/LSM/Smack.rst                            |   16 
 Documentation/devicetree/bindings/clock/qcom,x1e80100-gcc.yaml     |   62 
 Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml        |    6 
 Documentation/hwmon/g762.rst                                       |    2 
 Makefile                                                           |    2 
 arch/arm/boot/dts/renesas/r8a7793-gose.dts                         |    1 
 arch/arm/boot/dts/renesas/r9a06g032-rzn1d400-db.dts                |    2 
 arch/arm/boot/dts/samsung/exynos4210-i9100.dts                     |    1 
 arch/arm/boot/dts/samsung/exynos4210-trats.dts                     |    1 
 arch/arm/boot/dts/samsung/exynos4210-universal_c210.dts            |    1 
 arch/arm/boot/dts/samsung/exynos4412-midas.dtsi                    |    1 
 arch/arm/boot/dts/st/stm32mp157c-phycore-stm32mp15-som.dtsi        |    8 
 arch/arm/boot/dts/ti/omap/am335x-netcom-plus-2xx.dts               |    8 
 arch/arm/boot/dts/ti/omap/omap3-beagle-xm.dts                      |    2 
 arch/arm/boot/dts/ti/omap/omap3-n900.dts                           |    2 
 arch/arm/include/asm/word-at-a-time.h                              |   10 
 arch/arm64/boot/dts/exynos/google/gs101.dtsi                       |    4 
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi            |   11 
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi            |   51 
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw72xx.dtsi            |   11 
 arch/arm64/boot/dts/qcom/msm8996.dtsi                              |    3 
 arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts                   |    5 
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi                |    4 
 arch/arm64/boot/dts/qcom/sm8650.dtsi                               |    2 
 arch/arm64/boot/dts/qcom/x1e80100.dtsi                             |   12 
 arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts                    |    1 
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts                   |   15 
 arch/arm64/boot/dts/ti/k3-am62p.dtsi                               |    2 
 arch/loongarch/kernel/machine_kexec.c                              |   22 
 arch/powerpc/kernel/entry_32.S                                     |   10 
 arch/powerpc/kexec/ranges.c                                        |    2 
 arch/powerpc/mm/book3s64/hash_utils.c                              |   10 
 arch/powerpc/mm/ptdump/hashpagetable.c                             |    6 
 arch/riscv/kvm/vcpu_insn.c                                         |   22 
 arch/s390/kernel/smp.c                                             |    1 
 arch/um/Makefile                                                   |   12 
 arch/x86/boot/compressed/pgtable_64.c                              |   11 
 arch/x86/events/intel/core.c                                       |    4 
 arch/x86/events/intel/cstate.c                                     |    3 
 arch/x86/kernel/dumpstack.c                                        |   23 
 block/blk-lib.c                                                    |    6 
 block/blk-mq.c                                                     |   35 
 block/blk-throttle.c                                               |    9 
 block/mq-deadline.c                                                |  129 -
 crypto/asymmetric_keys/asymmetric_type.c                           |   14 
 crypto/authenc.c                                                   |   75 -
 drivers/accel/ivpu/ivpu_fw.h                                       |    2 
 drivers/accel/ivpu/ivpu_hw_btrs.c                                  |    2 
 drivers/accel/ivpu/ivpu_hw_btrs.h                                  |    2 
 drivers/accel/ivpu/ivpu_job.c                                      |   14 
 drivers/accel/ivpu/ivpu_pm.c                                       |    9 
 drivers/acpi/apei/ghes.c                                           |   27 
 drivers/acpi/processor_core.c                                      |    2 
 drivers/acpi/property.c                                            |    1 
 drivers/base/firmware_loader/Kconfig                               |    2 
 drivers/block/nbd.c                                                |    5 
 drivers/block/ps3disk.c                                            |    4 
 drivers/block/ublk_drv.c                                           |    4 
 drivers/clk/Makefile                                               |    3 
 drivers/clk/qcom/camcc-sm6350.c                                    |   13 
 drivers/clk/qcom/camcc-sm7150.c                                    |    6 
 drivers/clk/qcom/camcc-sm8550.c                                    |   10 
 drivers/clk/qcom/gcc-x1e80100.c                                    |  698 +++++++++-
 drivers/clk/renesas/r7s9210-cpg-mssr.c                             |    7 
 drivers/clk/renesas/r8a77970-cpg-mssr.c                            |    8 
 drivers/clk/renesas/r9a06g032-clocks.c                             |    6 
 drivers/clk/renesas/rcar-gen2-cpg.c                                |    5 
 drivers/clk/renesas/rcar-gen2-cpg.h                                |    3 
 drivers/clk/renesas/rcar-gen3-cpg.c                                |    6 
 drivers/clk/renesas/rcar-gen3-cpg.h                                |    3 
 drivers/clk/renesas/rcar-gen4-cpg.c                                |    6 
 drivers/clk/renesas/rcar-gen4-cpg.h                                |    3 
 drivers/clk/renesas/renesas-cpg-mssr.c                             |  150 +-
 drivers/clk/renesas/renesas-cpg-mssr.h                             |   20 
 drivers/clk/renesas/rzg2l-cpg.c                                    |    3 
 drivers/cpufreq/amd-pstate.c                                       |    2 
 drivers/crypto/ccree/cc_buffer_mgr.c                               |    6 
 drivers/crypto/hisilicon/qm.c                                      |   14 
 drivers/crypto/intel/iaa/iaa_crypto_main.c                         |    2 
 drivers/crypto/starfive/jh7110-hash.c                              |    6 
 drivers/firmware/efi/cper-arm.c                                    |   52 
 drivers/firmware/efi/cper.c                                        |   60 
 drivers/firmware/efi/libstub/x86-5lvl.c                            |    4 
 drivers/firmware/imx/imx-scu-irq.c                                 |    4 
 drivers/firmware/stratix10-svc.c                                   |    1 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                               |   46 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c                 |    8 
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c                    |   27 
 drivers/gpu/drm/drm_plane.c                                        |    8 
 drivers/gpu/drm/imagination/pvr_device.c                           |    2 
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c                          |   23 
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c                              |    2 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                              |   34 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                              |   10 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h                         |    6 
 drivers/gpu/drm/nouveau/nouveau_fence.c                            |    6 
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/base.c                      |    2 
 drivers/gpu/drm/panel/panel-visionox-rm69299.c                     |    2 
 drivers/gpu/drm/panthor/panthor_device.c                           |    4 
 drivers/gpu/drm/panthor/panthor_gem.c                              |   20 
 drivers/gpu/drm/panthor/panthor_mmu.c                              |   18 
 drivers/gpu/drm/panthor/panthor_sched.c                            |    6 
 drivers/gpu/drm/vgem/vgem_fence.c                                  |    2 
 drivers/gpu/host1x/syncpt.c                                        |    4 
 drivers/greybus/gb-beagleplay.c                                    |   12 
 drivers/hid/hid-logitech-hidpp.c                                   |    9 
 drivers/hwmon/sy7636a-hwmon.c                                      |    7 
 drivers/hwtracing/coresight/coresight-etm4x-core.c                 |  130 +
 drivers/i3c/master.c                                               |    8 
 drivers/i3c/master/svc-i3c-master.c                                |   22 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h                            |    2 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                           |    8 
 drivers/infiniband/hw/bnxt_re/qplib_sp.c                           |    8 
 drivers/infiniband/hw/bnxt_re/qplib_sp.h                           |    2 
 drivers/infiniband/hw/irdma/cm.c                                   |    2 
 drivers/infiniband/hw/irdma/ctrl.c                                 |    3 
 drivers/infiniband/hw/irdma/main.h                                 |    2 
 drivers/infiniband/hw/irdma/pble.c                                 |    6 
 drivers/infiniband/hw/irdma/verbs.c                                |   15 
 drivers/infiniband/hw/irdma/verbs.h                                |    3 
 drivers/infiniband/sw/rxe/rxe_srq.c                                |    7 
 drivers/infiniband/ulp/rtrs/rtrs-srv.c                             |    2 
 drivers/interconnect/debugfs-client.c                              |    7 
 drivers/interconnect/qcom/msm8996.c                                |    1 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                        |    2 
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c                         |   27 
 drivers/iommu/intel/iommu.h                                        |    2 
 drivers/irqchip/irq-bcm7038-l1.c                                   |    8 
 drivers/irqchip/irq-bcm7120-l2.c                                   |   17 
 drivers/irqchip/irq-brcmstb-l2.c                                   |   12 
 drivers/irqchip/irq-imx-mu-msi.c                                   |   14 
 drivers/irqchip/irq-mchp-eic.c                                     |    2 
 drivers/irqchip/irq-renesas-rzg2l.c                                |    6 
 drivers/irqchip/irq-starfive-jh8100-intc.c                         |    3 
 drivers/irqchip/qcom-irq-combiner.c                                |    2 
 drivers/leds/leds-netxbig.c                                        |   36 
 drivers/leds/rgb/leds-qcom-lpg.c                                   |    4 
 drivers/macintosh/mac_hid.c                                        |    3 
 drivers/md/dm-log-writes.c                                         |    1 
 drivers/md/dm-raid.c                                               |    2 
 drivers/md/md.c                                                    |   14 
 drivers/md/md.h                                                    |    8 
 drivers/md/raid5.c                                                 |    6 
 drivers/mfd/da9055-core.c                                          |    1 
 drivers/mfd/mt6358-irq.c                                           |    1 
 drivers/mfd/mt6397-irq.c                                           |    1 
 drivers/mtd/lpddr/lpddr_cmds.c                                     |    8 
 drivers/mtd/nand/raw/lpc32xx_slc.c                                 |    2 
 drivers/mtd/nand/raw/marvell_nand.c                                |   13 
 drivers/mtd/nand/raw/nand_base.c                                   |   13 
 drivers/mtd/nand/raw/renesas-nand-controller.c                     |    5 
 drivers/net/dsa/xrs700x/xrs700x.c                                  |   11 
 drivers/net/ethernet/microchip/lan743x_main.c                      |    3 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                  |    2 
 drivers/net/phy/adin1100.c                                         |    2 
 drivers/net/phy/aquantia/aquantia_firmware.c                       |    2 
 drivers/net/phy/mscc/mscc_main.c                                   |    6 
 drivers/net/wireless/ath/ath10k/bmi.c                              |    2 
 drivers/net/wireless/ath/ath10k/ce.c                               |    2 
 drivers/net/wireless/ath/ath10k/core.c                             |   22 
 drivers/net/wireless/ath/ath10k/core.h                             |    2 
 drivers/net/wireless/ath/ath10k/coredump.c                         |    2 
 drivers/net/wireless/ath/ath10k/debug.c                            |    2 
 drivers/net/wireless/ath/ath10k/htc.c                              |    3 
 drivers/net/wireless/ath/ath10k/htt_rx.c                           |    3 
 drivers/net/wireless/ath/ath10k/htt_tx.c                           |    2 
 drivers/net/wireless/ath/ath10k/mac.c                              |   36 
 drivers/net/wireless/ath/ath10k/trace.c                            |    2 
 drivers/net/wireless/ath/ath11k/mac.c                              |    8 
 drivers/net/wireless/ath/ath11k/pci.c                              |   20 
 drivers/net/wireless/ath/ath11k/wmi.c                              |   20 
 drivers/net/wireless/ath/ath11k/wmi.h                              |    2 
 drivers/net/wireless/ath/ath12k/wow.c                              |    1 
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c                    |    4 
 drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c                 |    9 
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c                 |   27 
 drivers/net/wireless/st/cw1200/bh.c                                |    6 
 drivers/nvme/host/auth.c                                           |    2 
 drivers/of/of_kunit_helpers.c                                      |    5 
 drivers/pci/controller/Kconfig                                     |    7 
 drivers/pci/controller/dwc/pci-keystone.c                          |    2 
 drivers/pci/controller/dwc/pcie-designware.h                       |    2 
 drivers/phy/freescale/phy-fsl-imx8qm-hsio.c                        |    5 
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                           |   20 
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c                  |   13 
 drivers/pinctrl/pinctrl-single.c                                   |    7 
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                            |    6 
 drivers/pinctrl/stm32/pinctrl-stm32.c                              |    2 
 drivers/platform/x86/asus-wmi.c                                    |    8 
 drivers/platform/x86/intel/pmc/core.h                              |    2 
 drivers/power/supply/apm_power.c                                   |    3 
 drivers/power/supply/cw2015_battery.c                              |    8 
 drivers/power/supply/max17040_battery.c                            |    6 
 drivers/power/supply/rt5033_charger.c                              |    2 
 drivers/power/supply/rt9467-charger.c                              |    6 
 drivers/power/supply/wm831x_power.c                                |   10 
 drivers/pwm/pwm-bcm2835.c                                          |   28 
 drivers/ras/ras.c                                                  |   40 
 drivers/regulator/core.c                                           |   37 
 drivers/regulator/fixed.c                                          |   11 
 drivers/remoteproc/qcom_q6v5_wcss.c                                |    8 
 drivers/rtc/rtc-gamecube.c                                         |    4 
 drivers/s390/crypto/ap_bus.c                                       |    8 
 drivers/scsi/imm.c                                                 |    1 
 drivers/scsi/qla2xxx/qla_nvme.c                                    |    2 
 drivers/scsi/sim710.c                                              |    2 
 drivers/scsi/smartpqi/smartpqi_init.c                              |   19 
 drivers/scsi/stex.c                                                |    1 
 drivers/soc/aspeed/aspeed-lpc-ctrl.c                               |    2 
 drivers/soc/aspeed/aspeed-lpc-snoop.c                              |    2 
 drivers/soc/aspeed/aspeed-p2a-ctrl.c                               |    2 
 drivers/soc/aspeed/aspeed-uart-routing.c                           |    2 
 drivers/soc/fsl/dpaa2-console.c                                    |    2 
 drivers/soc/fsl/qe/qmc.c                                           |    2 
 drivers/soc/fsl/qe/tsa.c                                           |    2 
 drivers/soc/fujitsu/a64fx-diag.c                                   |    2 
 drivers/soc/hisilicon/kunpeng_hccs.c                               |    2 
 drivers/soc/ixp4xx/ixp4xx-npe.c                                    |    2 
 drivers/soc/ixp4xx/ixp4xx-qmgr.c                                   |    2 
 drivers/soc/litex/litex_soc_ctrl.c                                 |    2 
 drivers/soc/loongson/loongson2_guts.c                              |    2 
 drivers/soc/mediatek/mtk-devapc.c                                  |    2 
 drivers/soc/mediatek/mtk-mmsys.c                                   |    2 
 drivers/soc/mediatek/mtk-socinfo.c                                 |    2 
 drivers/soc/microchip/mpfs-sys-controller.c                        |    2 
 drivers/soc/pxa/ssp.c                                              |    2 
 drivers/soc/qcom/icc-bwmon.c                                       |    2 
 drivers/soc/qcom/llcc-qcom.c                                       |    2 
 drivers/soc/qcom/ocmem.c                                           |    2 
 drivers/soc/qcom/pmic_glink.c                                      |    2 
 drivers/soc/qcom/qcom_aoss.c                                       |    2 
 drivers/soc/qcom/qcom_gsbi.c                                       |    8 
 drivers/soc/qcom/qcom_stats.c                                      |    2 
 drivers/soc/qcom/ramp_controller.c                                 |    4 
 drivers/soc/qcom/rmtfs_mem.c                                       |    2 
 drivers/soc/qcom/rpm-proc.c                                        |    2 
 drivers/soc/qcom/rpm_master_stats.c                                |    2 
 drivers/soc/qcom/smem.c                                            |    5 
 drivers/soc/qcom/smp2p.c                                           |    2 
 drivers/soc/qcom/smsm.c                                            |    6 
 drivers/soc/qcom/socinfo.c                                         |    2 
 drivers/soc/rockchip/io-domain.c                                   |    8 
 drivers/soc/samsung/exynos-chipid.c                                |    4 
 drivers/soc/tegra/cbb/tegra194-cbb.c                               |    2 
 drivers/soc/ti/k3-ringacc.c                                        |    2 
 drivers/soc/ti/knav_dma.c                                          |    4 
 drivers/soc/ti/knav_qmss_queue.c                                   |    2 
 drivers/soc/ti/pm33xx.c                                            |    2 
 drivers/soc/ti/pruss.c                                             |    4 
 drivers/soc/ti/smartreflex.c                                       |    2 
 drivers/soc/ti/wkup_m3_ipc.c                                       |    2 
 drivers/soc/xilinx/xlnx_event_manager.c                            |    2 
 drivers/soc/xilinx/zynqmp_power.c                                  |    2 
 drivers/spi/spi-airoha-snfi.c                                      |   25 
 drivers/spi/spi-ch341.c                                            |    2 
 drivers/spi/spi-tegra210-quad.c                                    |   22 
 drivers/staging/fbtft/fbtft-core.c                                 |    4 
 drivers/target/target_core_configfs.c                              |    1 
 drivers/ufs/core/ufshcd.c                                          |    2 
 drivers/uio/uio_fsl_elbc_gpcm.c                                    |    7 
 drivers/usb/core/message.c                                         |    2 
 drivers/usb/dwc2/platform.c                                        |   16 
 drivers/usb/dwc3/host.c                                            |    5 
 drivers/usb/gadget/legacy/raw_gadget.c                             |    3 
 drivers/usb/gadget/udc/tegra-xudc.c                                |    6 
 drivers/usb/misc/chaoskey.c                                        |   16 
 drivers/usb/phy/phy.c                                              |    4 
 drivers/vdpa/mlx5/net/mlx5_vnet.c                                  |    2 
 drivers/vdpa/pds/vdpa_dev.c                                        |    2 
 drivers/vfio/pci/vfio_pci_core.c                                   |   68 
 drivers/vfio/pci/vfio_pci_intrs.c                                  |   52 
 drivers/vfio/pci/vfio_pci_priv.h                                   |    4 
 drivers/vhost/vhost.c                                              |    4 
 drivers/video/backlight/led_bl.c                                   |   13 
 drivers/video/fbdev/ssd1307fb.c                                    |    4 
 drivers/virtio/virtio_vdpa.c                                       |    2 
 drivers/watchdog/starfive-wdt.c                                    |    4 
 drivers/watchdog/wdat_wdt.c                                        |   64 
 fs/9p/v9fs.c                                                       |    4 
 fs/9p/vfs_file.c                                                   |   11 
 fs/9p/vfs_inode.c                                                  |    3 
 fs/9p/vfs_inode_dotl.c                                             |    2 
 fs/btrfs/ctree.c                                                   |    2 
 fs/dcache.c                                                        |   46 
 fs/erofs/super.c                                                   |   16 
 fs/ext4/mballoc.c                                                  |   49 
 fs/ext4/move_extent.c                                              |    2 
 fs/f2fs/debug.c                                                    |    3 
 fs/f2fs/f2fs.h                                                     |   20 
 fs/f2fs/file.c                                                     |   77 -
 fs/f2fs/gc.c                                                       |   21 
 fs/f2fs/gc.h                                                       |    2 
 fs/f2fs/inode.c                                                    |   14 
 fs/f2fs/shrinker.c                                                 |   90 +
 fs/f2fs/super.c                                                    |    8 
 fs/f2fs/sysfs.c                                                    |  101 +
 fs/gfs2/glock.c                                                    |    5 
 fs/gfs2/inode.c                                                    |   15 
 fs/gfs2/inode.h                                                    |    1 
 fs/gfs2/ops_fstype.c                                               |    2 
 fs/iomap/direct-io.c                                               |   77 -
 fs/nfs/client.c                                                    |   21 
 fs/nfs/dir.c                                                       |   27 
 fs/nfs/inode.c                                                     |    2 
 fs/nfs/internal.h                                                  |    3 
 fs/nfs/namespace.c                                                 |   11 
 fs/nfs/nfs4client.c                                                |   18 
 fs/nfs/nfs4proc.c                                                  |   29 
 fs/nfs/pnfs.c                                                      |    1 
 fs/nfs/super.c                                                     |   33 
 fs/nfsd/blocklayout.c                                              |    4 
 fs/nls/nls_base.c                                                  |   27 
 fs/ntfs3/frecord.c                                                 |    8 
 fs/ntfs3/fsntfs.c                                                  |    9 
 fs/ntfs3/inode.c                                                   |    2 
 fs/ocfs2/alloc.c                                                   |    1 
 fs/ocfs2/move_extents.c                                            |    8 
 fs/smb/client/smb2pdu.c                                            |    2 
 fs/tracefs/event_inode.c                                           |    3 
 include/dt-bindings/clock/qcom,x1e80100-gcc.h                      |   63 
 include/linux/blk_types.h                                          |    5 
 include/linux/blkdev.h                                             |    2 
 include/linux/coresight.h                                          |   25 
 include/linux/cper.h                                               |   12 
 include/linux/dcache.h                                             |    1 
 include/linux/filter.h                                             |   12 
 include/linux/firmware/qcom/qcom_tzmem.h                           |   15 
 include/linux/ieee80211.h                                          |    4 
 include/linux/if_hsr.h                                             |   26 
 include/linux/nfs_fs_sb.h                                          |    7 
 include/linux/nfs_xdr.h                                            |   54 
 include/linux/perf_event.h                                         |    2 
 include/linux/platform_data/lp855x.h                               |    4 
 include/linux/ras.h                                                |   16 
 include/linux/rculist_nulls.h                                      |   59 
 include/linux/vfio_pci_core.h                                      |   10 
 include/linux/virtio_config.h                                      |    8 
 include/net/dst.h                                                  |   16 
 include/net/netfilter/nf_conntrack_count.h                         |   17 
 include/net/sock.h                                                 |   13 
 include/ras/ras_event.h                                            |   49 
 include/uapi/sound/asound.h                                        |    2 
 kernel/bpf/hashtab.c                                               |   10 
 kernel/bpf/stackmap.c                                              |   66 
 kernel/bpf/syscall.c                                               |    3 
 kernel/bpf/trampoline.c                                            |    4 
 kernel/cgroup/cpuset.c                                             |   35 
 kernel/dma/pool.c                                                  |    2 
 kernel/events/callchain.c                                          |   12 
 kernel/events/core.c                                               |    2 
 kernel/locking/locktorture.c                                       |    8 
 kernel/resource.c                                                  |   46 
 kernel/sched/fair.c                                                |   17 
 kernel/task_work.c                                                 |    8 
 lib/vsprintf.c                                                     |    6 
 net/core/dst.c                                                     |    2 
 net/core/filter.c                                                  |    9 
 net/hsr/hsr_device.c                                               |   33 
 net/hsr/hsr_main.h                                                 |   10 
 net/hsr/hsr_slave.c                                                |   12 
 net/ipv4/inet_hashtables.c                                         |    8 
 net/ipv4/inet_timewait_sock.c                                      |   35 
 net/ipv4/route.c                                                   |    4 
 net/ipv4/tcp_metrics.c                                             |    6 
 net/ipv6/ip6_fib.c                                                 |    4 
 net/mac80211/aes_cmac.c                                            |   63 
 net/mac80211/aes_cmac.h                                            |    8 
 net/mac80211/wpa.c                                                 |   20 
 net/netfilter/nf_conncount.c                                       |  187 +-
 net/netfilter/nft_connlimit.c                                      |   34 
 net/netfilter/nft_flow_offload.c                                   |    9 
 net/netfilter/xt_connlimit.c                                       |   14 
 net/openvswitch/conntrack.c                                        |   16 
 net/sched/sch_cake.c                                               |   58 
 net/sctp/socket.c                                                  |    5 
 security/integrity/ima/ima_policy.c                                |    2 
 security/smack/smack.h                                             |    3 
 security/smack/smack_access.c                                      |   93 +
 security/smack/smack_lsm.c                                         |  279 ++-
 sound/firewire/dice/dice-extension.c                               |    4 
 sound/firewire/motu/motu-hwdep.c                                   |    7 
 sound/isa/wavefront/wavefront_synth.c                              |    4 
 sound/soc/bcm/bcm63xx-pcm-whistler.c                               |    4 
 sound/soc/codecs/Kconfig                                           |    5 
 sound/soc/codecs/Makefile                                          |    2 
 sound/soc/codecs/ak4458.c                                          |   10 
 sound/soc/codecs/ak5558.c                                          |   10 
 sound/soc/codecs/nau8325.c                                         |    7 
 sound/soc/codecs/tas2781-i2c.c                                     |    2 
 sound/soc/fsl/fsl_xcvr.c                                           |    2 
 sound/soc/intel/catpt/pcm.c                                        |    4 
 tools/include/nolibc/stdio.h                                       |    4 
 tools/lib/bpf/btf.c                                                |    4 
 tools/objtool/check.c                                              |    3 
 tools/objtool/elf.c                                                |    8 
 tools/perf/builtin-record.c                                        |    2 
 tools/perf/util/annotate.c                                         |    2 
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c              |   37 
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h              |   26 
 tools/perf/util/bpf_lock_contention.c                              |    6 
 tools/perf/util/hist.c                                             |    6 
 tools/perf/util/symbol.c                                           |    5 
 tools/testing/selftests/bpf/prog_tests/perf_branches.c             |   22 
 tools/testing/selftests/bpf/prog_tests/send_signal.c               |    5 
 tools/testing/selftests/bpf/progs/test_perf_branches.c             |    3 
 tools/testing/selftests/drivers/net/bonding/Makefile               |    2 
 tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh        |   99 -
 tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh |   97 +
 tools/testing/selftests/drivers/net/bonding/config                 |    1 
 410 files changed, 4297 insertions(+), 1926 deletions(-)

Aashish Sharma (1):
      iommu/vt-d: Fix unused invalidation hint in qi_desc_iotlb

Abdun Nihaal (4):
      wifi: ath12k: fix potential memory leak in ath12k_wow_arp_ns_offload()
      wifi: cw1200: Fix potential memory leak in cw1200_bh_rx_helper()
      wifi: rtl818x: Fix potential memory leaks in rtl8180_init_rx_ring()
      fbdev: ssd1307fb: fix potential page leak in ssd1307fb_probe()

Ahelenia Ziemiańska (1):
      power: supply: apm_power: only unset own apm_get_power_status

Akash Goel (2):
      drm/panthor: Fix potential memleak of vma structure
      drm/panthor: Avoid adding of kernel BOs to extobj list

Akhil P Oommen (3):
      drm/msm/a6xx: Flush LRZ cache before PT switch
      drm/msm/a6xx: Fix the gemnoc workaround
      drm/msm/a6xx: Improve MX rail fallback in RPMH vote init

Al Viro (1):
      tracefs: fix a leak in eventfs_create_events_dir()

Alan Maguire (1):
      libbpf: Fix parsing of multi-split BTF

Alex Williamson (1):
      vfio/pci: Use RCU for error/request triggers to avoid circular locking

Alexander Dahl (1):
      net: phy: adin1100: Fix software power-down ready condition

Alexander Martinz (1):
      arm64: dts: qcom: qcm6490-shift-otter: Add missing reserved-memory

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

Andrzej Kacprowski (1):
      accel/ivpu: Prevent runtime suspend during context abort work

Andy Shevchenko (3):
      lib/vsprintf: Check pointer before dereferencing in time_and_date()
      resource: replace open coded resource_intersection()
      resource: introduce is_type_match() helper and use it

Anton Khirnov (1):
      platform/x86: asus-wmi: use brightness_set_blocking() for kbd led

Armin Wolf (2):
      fs/nls: Fix utf16 to utf8 conversion
      fs/nls: Fix inconsistency between utf8_to_utf32() and utf32_to_utf8()

Arnaud Lecomte (2):
      bpf: Refactor stack map trace depth calculation into helper function
      bpf: Fix stackmap overflow check in __bpf_get_stackid()

Aryan Srivastava (2):
      Revert "mtd: rawnand: marvell: fix layouts"
      mtd: nand: relax ECC parameter validation check

Baochen Qiang (3):
      wifi: ath11k: restore register window after global reset
      wifi: ath11k: fix VHT MCS assignment
      wifi: ath11k: fix peer HE MCS assignment

Bart Van Assche (3):
      block/mq-deadline: Introduce dd_start_request()
      block/mq-deadline: Switch back to a single dispatch list
      scsi: target: Do not write NUL characters into ASCII configfs output

Bean Huo (1):
      scsi: ufs: core: fix incorrect buffer duplication in ufshcd_read_string_desc()

Benjamin Berg (1):
      tools/nolibc/stdio: let perror work when NOLIBC_IGNORE_ERRNO is set

Biju Das (1):
      pinctrl: renesas: rzg2l: Fix PMC restore

Boris Brezillon (3):
      drm/panthor: Handle errors returned by drm_sched_entity_init()
      drm/panthor: Fix group_free_queue() for partially initialized queues
      drm/panthor: Fix UAF on kernel BO VA nodes

Cezary Rojewski (1):
      ASoC: Intel: catpt: Fix error path in hw_params()

Chao Yu (3):
      f2fs: fix to avoid running out of free segments
      f2fs: sysfs: add encoding_flags entry
      f2fs: introduce reserved_pin_section sysfs entry

Chen Ridong (1):
      cpuset: Treat cpusets in attaching as populated

Chien Wong (1):
      wifi: mac80211: fix CMAC functions not handling errors

Christoph Hellwig (3):
      iomap: factor out a iomap_dio_done helper
      iomap: always run error completions in user context
      block: return unsigned int from queue_dma_alignment

Christophe JAILLET (1):
      phy: renesas: rcar-gen3-usb2: Fix an error handling path in rcar_gen3_phy_usb2_probe()

Christophe Leroy (1):
      powerpc/32: Fix unpaired stwcx. on interrupt exit

Cong Zhang (1):
      blk-mq: Abort suspend when wakeup events are pending

Cristian Ciocaltea (2):
      phy: rockchip: samsung-hdptx: Reduce ROPLL loop bandwidth
      phy: rockchip: samsung-hdptx: Prevent Inter-Pair Skew from exceeding the limits

Cyrille Pitchen (1):
      drm: atmel-hlcdc: fix atmel_xlcdc_plane_setup_scaler()

Daeho Jeong (4):
      f2fs: add carve_out sysfs node
      f2fs: add gc_boost_gc_multiple sysfs node
      f2fs: add gc_boost_gc_greedy sysfs node
      f2fs: maintain one time GC mode is enabled during whole zoned GC cycle

Dan Carpenter (3):
      drm/amd/display: Fix logical vs bitwise bug in get_embedded_panel_info_v2_1()
      drm/plane: Fix IS_ERR() vs NULL check in drm_plane_create_hotspot_properties()
      irqchip/mchp-eic: Fix error code in mchp_eic_domain_alloc()

Dapeng Mi (1):
      perf/x86/intel: Correct large PEBS flag check

Dave Kleikamp (1):
      dma/pool: eliminate alloc_pages warning in atomic_pool_expand

David Gow (1):
      um: Don't rename vmap to kernel_vmap

David Howells (1):
      cifs: Fix handling of a beyond-EOF DIO/unbuffered read over SMB2

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

Duoming Zhou (1):
      scsi: imm: Fix use-after-free bug caused by unfinished delayed work

Dylan Hatch (1):
      objtool: Fix standalone --hacks=jump_label

Edward Adam Davis (3):
      ntfs3: init run lock for extend inode
      fs/ntfs3: out1 also needs to put mi
      fs/ntfs3: Prevent memory leaks in add sub record

Eric Dumazet (4):
      net: hsr: remove one synchronize_rcu() from hsr_del_port()
      net: hsr: remove synchronize_rcu() from hsr_add_port()
      net: dst: introduce dst->dev_rcu
      tcp_metrics: use dst_dev_net_rcu()

Eric Sandeen (1):
      9p: fix cache/debug options printing in v9fs_show_options

Etienne Champetier (1):
      selftests: bonding: add ipvlan over bond testing

FUKAUMI Naoki (3):
      arm64: dts: rockchip: Move the EEPROM to correct I2C bus on Radxa ROCK 5A
      arm64: dts: rockchip: Add eeprom vcc-supply for Radxa ROCK 5A
      arm64: dts: rockchip: Add eeprom vcc-supply for Radxa ROCK 3C

Fangyu Yu (1):
      RISC-V: KVM: Fix guest page fault within HLV* instructions

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

Gabor Juhos (1):
      regulator: core: disable supply if enabling main regulator fails

Gao Xiang (1):
      erofs: limit the level of fs stacking for file-backed mounts

Gautham R. Shenoy (1):
      cpufreq/amd-pstate: Call cppc_set_auto_sel() only for online CPUs

Geert Uytterhoeven (3):
      clk: renesas: Use str_on_off() helper
      PCI: rcar-gen2: Drop ARM dependency from PCI_RCAR_GEN2
      drm/imagination: Fix reference to devm_platform_get_and_ioremap_resource()

Gergo Koteles (1):
      arm64: dts: qcom: sdm845-oneplus: Correct gpio used for slider

Gopi Krishna Menon (1):
      usb: raw-gadget: cap raw_io transfer length to KMALLOC_MAX_SIZE

Greg Kroah-Hartman (1):
      Linux 6.12.63

Guenter Roeck (2):
      block/blk-throttle: Fix throttle slice time for SSDs
      of: Skip devicetree kunit tests when RISCV+ACPI doesn't populate root node

Guido Günther (1):
      drm/panel: visionox-rm69299: Don't clear all mode flags

Hangbin Liu (1):
      selftests: bonding: add delay before each xvlan_over_bond connectivity check

Haotian Zhang (24):
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
      greybus: gb-beagleplay: Fix timeout handling in bootloader functions
      hwmon: sy7636a: Fix regulator_enable resource leak on error path
      mtd: rawnand: renesas: Handle devm_pm_runtime_enable() errors
      pinctrl: single: Fix incorrect type for error return variable
      ASoC: bcm: bcm63xx-pcm-whistler: Check return value of of_dma_configure()
      rtc: gamecube: Check the return value of ioremap()
      dm log-writes: Add missing set_freezable() for freezable kthread

Haotien Hsu (1):
      usb: gadget: tegra-xudc: Always reinitialize data toggle when clear halt

Heiko Carstens (2):
      s390/smp: Fix fallback CPU detection
      s390/ap: Don't leak debug feature files if AP instructions are not available

Herbert Xu (1):
      crypto: authenc - Correctly pass EINPROGRESS back up to the caller

Horatiu Vultur (1):
      phy: mscc: Fix PTP for VSC8574 and VSC8572

Huacai Chen (1):
      LoongArch: Add machine_kexec_mask_interrupts() implementation

Ian Rogers (1):
      perf hist: In init, ensure mem_info is put on error paths

Ilias Stamatis (1):
      Reinstate "resource: avoid unnecessary lookups in find_next_iomem_res()"

Israel Rukshin (1):
      nvme-auth: use kvfree() for memory allocated with kvcalloc()

Ivan Abramov (4):
      power: supply: cw2015: Check devm_delayed_work_autocancel() return code
      power: supply: max17040: Check iio_read_channel_processed() return code
      power: supply: rt9467: Return error on failure in rt9467_set_value_from_ranges()
      power: supply: wm831x: Check wm831x_set_bits() return value

Ivan Stepchenko (1):
      mtd: lpddr_cmds: fix signed shifts in lpddr_cmds

Jacek Lawrynowicz (1):
      accel/ivpu: Make function parameter names consistent

Jacob Moroni (1):
      RDMA/irdma: Do not directly rely on IB_PD_UNSAFE_GLOBAL_RKEY

Jaegeuk Kim (2):
      f2fs: keep POSIX_FADV_NOREUSE ranges
      f2fs: add a sysfs entry to reclaim POSIX_FADV_NOREUSE pages

Janusz Krzysztofik (1):
      drm/vgem-fence: Fix potential deadlock on release

Jaroslav Kysela (2):
      ASoC: nau8325: use simple i2c probe function
      ASoC: nau8325: add missing build config

Jason Tian (1):
      RAS: Report all ARM processor CPER information to userspace

Jay Liu (1):
      drm/mediatek: Fix CCORR mtk_ctm_s31_32_to_s1_n function issue

Jeff Johnson (1):
      wifi: ath10k: Add missing include of export.h

Jianglei Nie (1):
      staging: fbtft: core: fix potential memory leak in fbtft_probe_common()

Jihed Chaibi (3):
      ARM: dts: omap3: beagle-xm: Correct obsolete TWL4030 power compatible
      ARM: dts: omap3: n900: Correct obsolete TWL4030 power compatible
      ARM: dts: stm32: stm32mp157c-phycore: Fix STMPE811 touchscreen node properties

Jisheng Zhang (3):
      usb: dwc2: disable platform lowlevel hw resources during shutdown
      usb: dwc2: fix hang during shutdown if set as peripheral
      usb: dwc2: fix hang during suspend if set as peripheral

Johan Hovold (8):
      irqchip/irq-bcm7038-l1: Fix section mismatch
      irqchip/irq-bcm7120-l2: Fix section mismatch
      irqchip/irq-brcmstb-l2: Fix section mismatch
      irqchip/imx-mu-msi: Fix section mismatch
      irqchip/renesas-rzg2l: Fix section mismatch
      irqchip/starfive-jh8100: Fix section mismatch
      irqchip/qcom-irq-combiner: Fix section mismatch
      clk: keystone: fix compile testing

Jonathan Curley (1):
      NFSv4/pNFS: Clear NFS_INO_LAYOUTCOMMIT in pnfs_mark_layout_stateid_invalid

Josh Poimboeuf (2):
      objtool: Fix weak symbol detection
      perf: Remove get_perf_callchain() init_nr argument

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

Konrad Dybcio (2):
      dt-bindings: clock: qcom,x1e80100-gcc: Add missing USB4 clocks/resets
      clk: qcom: gcc-x1e80100: Add missing USB4 clocks/resets

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

Kuniyuki Iwashima (1):
      sctp: Defer SCTP_DBG_OBJCNT_DEC() to sctp_destroy_sock().

Leo Yan (6):
      coresight: Change device mode to atomic type
      coresight: etm4x: Correct polling IDLE bit
      coresight: etm4x: Extract the trace unit controlling
      coresight: etm4x: Add context synchronization before enabling trace
      perf arm-spe: Extend branch operations
      perf arm_spe: Fix memset subclass in operation

Leon Hwang (1):
      bpf: Free special fields when update [lru_,]percpu_hash maps

Li Qiang (1):
      uio: uio_fsl_elbc_gpcm:: Add null pointer check to uio_fsl_elbc_gpcm_probe

Liyuan Pang (1):
      ARM: 9464/1: fix input-only operand modification in load_unaligned_zeropad()

Loic Poulain (1):
      wifi: ath10k: Avoid vdev delete timeout when firmware is already down

Long Li (1):
      macintosh/mac_hid: fix race condition in mac_hid_toggle_emumouse

Luca Ceresoli (1):
      backlight: led-bl: Add devlink to supplier LEDs

Luca Weiss (2):
      clk: qcom: camcc-sm6350: Fix PLL config of PLL2
      clk: qcom: camcc-sm7150: Fix PLL config of PLL2

MD Danish Anwar (1):
      net: hsr: Create and export hsr_get_port_ndev()

Ma Ke (1):
      RDMA/rtrs: server: Fix error handling in get_or_create_srv

Madhur Kumar (1):
      drm/nouveau: refactor deprecated strcpy

Mainak Sen (1):
      gpu: host1x: Fix race in syncpt alloc/free

Manivannan Sadhasivam (1):
      dt-bindings: PCI: amlogic: Fix the register name of the DBI region

Marek Szyprowski (4):
      ARM: dts: samsung: universal_c210: turn off SDIO WLAN chip during system suspend
      ARM: dts: samsung: exynos4210-i9100: turn off SDIO WLAN chip during system suspend
      ARM: dts: samsung: exynos4210-trats: turn off SDIO WLAN chip during system suspend
      ARM: dts: samsung: exynos4412-midas: turn off SDIO WLAN chip during system suspend

Marek Vasut (2):
      clk: renesas: cpg-mssr: Add missing 1ms delay into reset toggle callback
      clk: renesas: cpg-mssr: Read back reset registers to assure values latched

Mark Brown (1):
      regulator: fixed: Rely on the core freeing the enable GPIO

Martin KaFai Lau (1):
      bpf: Check skb->transport_header is set in bpf_skb_check_mtu

Matt Bobrowski (2):
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

Michael S. Tsirkin (4):
      virtio: fix typo in virtio_device_ready() comment
      virtio: fix whitespace in virtio_config_ops
      virtio: fix grammar in virtio_queue_info docs
      virtio: fix virtqueue_set_affinity() docs

Mike Christie (1):
      vhost: Fix kthread worker cgroup failure handling

Mike McGowen (1):
      scsi: smartpqi: Fix device resources accessed after device removal

Mikhail Kshevetskiy (1):
      spi: airoha-snfi: en7523: workaround flash damaging if UART_TXD was short to GND

Mohamed Khalfella (1):
      block: Use RCU in blk_mq_[un]quiesce_tagset() instead of set->tag_list_lock

Murad Masimov (1):
      power: supply: rt9467: Prevent using uninitialized local variable in rt9467_set_value_from_ranges()

Namhyung Kim (3):
      perf lock contention: Load kernel map before lookup
      perf tools: Mark split kallsyms DSOs as loaded
      perf tools: Fix split kallsyms DSO counting

Neil Armstrong (1):
      arm64: dts: qcom: sm8650: set ufs as dma coherent

NeilBrown (1):
      nfs/vfs: discard d_exact_alias()

Oliver Neukum (1):
      usb: chaoskey: fix locking for O_NONBLOCK

Pablo Neira Ayuso (1):
      netfilter: flowtable: check for maximum number of encapsulations in bridge vlan

Peng Fan (1):
      firmware: imx: scu-irq: fix OF node leak in

Peter Griffin (1):
      arm64: dts: exynos: gs101: fix sysreg_apm reg property

Peter Zijlstra (1):
      task_work: Fix NMI race condition

Pu Lehui (1):
      bpf: Fix invalid prog->stats access when update_effective_progs fails

Randolph Sapp (1):
      arm64: dts: ti: k3-am62p: Fix memory ranges for GPU

Randy Dunlap (2):
      firmware: qcom: tzmem: fix qcom_tzmem_policy kernel-doc
      backlight: lp855x: Fix lp855x.h kernel-doc warnings

Raphael Pinsonneault-Thibeault (1):
      ntfs3: fix uninit memory after failed mi_read in mi_format_new

Rene Rebe (1):
      ps3disk: use memcpy_{from,to}_bvec index

René Rebe (1):
      ACPI: processor_core: fix map_x2apic_id for amd-pstate on am4

Ria Thomas (1):
      wifi: ieee80211: correct FILS status codes

Ritesh Harjani (IBM) (2):
      powerpc/64s/hash: Restrict stress_hpt_struct memblock region to within RMA limit
      powerpc/64s/ptdump: Fix kernel_hash_pagetable dump for ISA v3.00 HPTE format

Robert Marko (1):
      net: phy: aquantia: check for NVMEM deferral

Ryan Huang (1):
      iommu/arm-smmu-v3: Fix error check in arm_smmu_alloc_cd_tables

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

Shawn Lin (1):
      PCI: dwc: Fix wrong PORT_LOGIC_LTSSM_STATE_MASK definition

Shenghao Ding (1):
      ASoC: tas2781: correct the wrong period

Shengjiu Wang (3):
      ASoC: fsl_xcvr: clear the channel status control memory
      ASoC: ak4458: Disable regulator when error happens
      ASoC: ak5558: Disable regulator when error happens

Shuai Xue (1):
      perf record: skip synthesize event when open evsel failed

Siddharth Vadapalli (1):
      PCI: keystone: Exit ks_pcie_probe() for invalid mode

Sidharth Seela (1):
      ntfs3: Fix uninit buffer allocated by __getname()

Sourabh Jain (1):
      powerpc/kdump: Fix size calculation for hot-removed memory ranges

Stanley Chu (1):
      i3c: master: svc: Prevent incomplete IBI transaction

Stephan Gerhold (2):
      dt-bindings: clock: qcom,x1e80100-gcc: Add missing video resets
      iommu/arm-smmu-qcom: Enable use of all SMR groups when running bare-metal

Sven Peter (1):
      usb: dwc3: dwc3_power_off_all_roothub_ports: Use ioremap_np when required

Tengda Wu (1):
      x86/dumpstack: Prevent KASAN false positive warnings in __show_regs()

Thangaraj Samynathan (1):
      net: lan743x: Allocate rings outside ZONE_DMA

Thierry Bultel (1):
      clk: renesas: Pass sub struct of cpg_mssr_priv to cpg_clk_register

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

Trond Myklebust (10):
      NFS: Avoid changing nlink when file removes and attribute updates race
      NFS: Initialise verifiers for visible dentries in readdir and lookup
      NFS: Initialise verifiers for visible dentries in nfs_atomic_open()
      NFS: Initialise verifiers for visible dentries in _nfs4_open_and_get_state
      Revert "nfs: ignore SB_RDONLY when remounting nfs"
      Revert "nfs: clear SB_RDONLY before getting superblock"
      Revert "nfs: ignore SB_RDONLY when mounting nfs"
      NFS: Automounted filesystems should inherit ro,noexec,nodev,sync flags
      Expand the type of nfs_fattr->valid
      NFS: Fix inheritance of the block sizes when automounting

Usama Arif (2):
      x86/boot: Fix page table access in 5-level to 4-level paging transition
      efi/libstub: Fix page table access in 5-level to 4-level paging transition

Uwe Kleine-König (2):
      soc: Switch back to struct platform_driver::remove()
      pwm: bcm2835: Make sure the channel is enabled after pwm_request()

Vishwaroop A (1):
      spi: tegra210-quad: Fix timeout handling

Vladimir Oltean (1):
      net: dsa: xrs700x: reject unsupported HSR configurations

Vladimir Zapolskiy (2):
      clk: qcom: camcc-sm8550: Specify Titan GDSC power domain as a parent to other
      clk: qcom: camcc-sm6350: Specify Titan GDSC power domain as a parent to other

Wang Liang (1):
      locktorture: Fix memory leak in param_set_cpumask()

Wolfram Sang (2):
      ARM: dts: renesas: gose: Remove superfluous port property
      ARM: dts: renesas: r9a06g032-rzn1d400-db: Drop invalid #cells properties

Xi Pardee (1):
      platform/x86:intel/pmc: Update Arrow Lake telemetry GUID

Xiang Mei (1):
      net/sched: sch_cake: Fix incorrect qlen reduction in cake_drop

Xiaogang Chen (1):
      drm/amdkfd: Use huge page size to check split svm range alignment

Xiaolei Wang (1):
      phy: freescale: Initialize priv->lock

Xiaoliang Yang (1):
      net: hsr: create an API to get hsr port type

Xuanqiang Luo (3):
      rculist: Add hlist_nulls_replace_rcu() and hlist_nulls_replace_init_rcu()
      inet: Avoid ehash lookup race in inet_ehash_insert()
      inet: Avoid ehash lookup race in inet_twsk_hashdance_schedule()

Yegor Yefremov (1):
      ARM: dts: am335x-netcom-plus-2xx: add missing GPIO labels

Yongjian Sun (1):
      ext4: improve integrity checking in __mb_check_buddy by enhancing order-0 validation

Yu Kuai (1):
      md/raid5: fix IO hang when array is broken with IO inflight

Yun Zhou (1):
      md: fix rcu protection in md_wakeup_thread

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


