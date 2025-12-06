Return-Path: <stable+bounces-200269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3399DCAAE2A
	for <lists+stable@lfdr.de>; Sat, 06 Dec 2025 22:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18DC530D951A
	for <lists+stable@lfdr.de>; Sat,  6 Dec 2025 21:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950852D876B;
	Sat,  6 Dec 2025 21:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SZmkBuHi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F292882BE;
	Sat,  6 Dec 2025 21:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765057199; cv=none; b=k5cPS3aA2V8iiV2liiadjYvGUJwAnBXzV0ETYGtrOOSp1NGzbnZFl6F6yC5AdWFCptTc/Dh2JITtXtXUqlk42a9UKzXsWtcLCVL0YqUZvtgT6bW4nIgBxz9NRJXhA9B0kSPMZehntuqOsaW1ER7Ly98UTd4AavL43iHl/ucvGmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765057199; c=relaxed/simple;
	bh=qP0hfT4VV/FybHdwtipI6oG+IU63M0f5UgDoWUoLOyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hfHXfrIhaZE3oRskLnkiUdpIknUw2nJ5xQTXVyYHULf+4sM3TeHpNq9UErTFvvLCsiYVhLZZk3t3KLo3mdZ1MaDOrr/1OwrJihz/vvCkndFSks1pk8xOxg/Mg5xQpevJP9Ed8wjFBbUGJfqJx8Tb+NanpARhQEVeru7/fHnnGUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SZmkBuHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53C0C4CEF5;
	Sat,  6 Dec 2025 21:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765057197;
	bh=qP0hfT4VV/FybHdwtipI6oG+IU63M0f5UgDoWUoLOyc=;
	h=From:To:Cc:Subject:Date:From;
	b=SZmkBuHiOrC57xNe6dsb04Q6YpKZVmjLHtgB9/YkMrV3y8C30frEx9EelMu/KpVtf
	 jLZg2MCAOb6yFLH5c0BzlLRfr07Q0Uzsi+KJLhayi5WNi42DgD/Il0HJoF+i8qf4z0
	 exr+5fDihZfS5oSTgo9njG4u7XgoPZm7slsOOG38=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.159
Date: Sun,  7 Dec 2025 06:39:28 +0900
Message-ID: <2025120729-throwaway-rewash-7ebc@gregkh>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.159 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-bus-pci-drivers-xhci_hcd                |   62 
 Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml |   26 
 Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml              |   10 
 MAINTAINERS                                                             |    7 
 Makefile                                                                |    2 
 arch/alpha/kernel/asm-offsets.c                                         |    1 
 arch/arc/include/asm/bitops.h                                           |    2 
 arch/arc/kernel/asm-offsets.c                                           |    1 
 arch/arm/crypto/Kconfig                                                 |    2 
 arch/arm/kernel/asm-offsets.c                                           |    2 
 arch/arm/mach-at91/pm_suspend.S                                         |    8 
 arch/arm64/boot/dts/nvidia/tegra194.dtsi                                |   15 
 arch/arm64/boot/dts/nvidia/tegra210.dtsi                                |    1 
 arch/arm64/boot/dts/nvidia/tegra234.dtsi                                |   33 
 arch/arm64/kernel/asm-offsets.c                                         |    1 
 arch/arm64/kernel/cacheinfo.c                                           |   11 
 arch/csky/kernel/asm-offsets.c                                          |    1 
 arch/hexagon/kernel/asm-offsets.c                                       |    1 
 arch/loongarch/include/asm/pgtable.h                                    |   11 
 arch/loongarch/include/uapi/asm/bitsperlong.h                           |    9 
 arch/loongarch/kernel/asm-offsets.c                                     |    2 
 arch/loongarch/kernel/traps.c                                           |    4 
 arch/loongarch/pci/pci.c                                                |    8 
 arch/m68k/kernel/asm-offsets.c                                          |    1 
 arch/microblaze/kernel/asm-offsets.c                                    |    1 
 arch/mips/boot/dts/lantiq/danube.dtsi                                   |    6 
 arch/mips/boot/dts/lantiq/danube_easy50712.dts                          |    4 
 arch/mips/kernel/asm-offsets.c                                          |    2 
 arch/mips/lantiq/xway/sysctrl.c                                         |    2 
 arch/mips/mm/tlb-r4k.c                                                  |  116 
 arch/mips/mti-malta/malta-init.c                                        |   20 
 arch/nios2/kernel/asm-offsets.c                                         |    1 
 arch/openrisc/kernel/asm-offsets.c                                      |    1 
 arch/parisc/kernel/asm-offsets.c                                        |    1 
 arch/powerpc/kernel/asm-offsets.c                                       |    1 
 arch/powerpc/kernel/eeh_driver.c                                        |    2 
 arch/riscv/kernel/asm-offsets.c                                         |    1 
 arch/riscv/kernel/cacheinfo.c                                           |   42 
 arch/riscv/kernel/cpu-hotplug.c                                         |    1 
 arch/s390/include/asm/pci.h                                             |    1 
 arch/s390/kernel/asm-offsets.c                                          |    1 
 arch/s390/pci/pci_event.c                                               |    7 
 arch/s390/pci/pci_irq.c                                                 |    9 
 arch/sh/kernel/asm-offsets.c                                            |    1 
 arch/sparc/include/asm/elf_64.h                                         |    1 
 arch/sparc/include/asm/io_64.h                                          |    6 
 arch/sparc/kernel/asm-offsets.c                                         |    1 
 arch/sparc/kernel/module.c                                              |    1 
 arch/um/drivers/ssl.c                                                   |    5 
 arch/um/kernel/asm-offsets.c                                            |    2 
 arch/x86/entry/vsyscall/vsyscall_64.c                                   |   17 
 arch/x86/events/core.c                                                  |   10 
 arch/x86/kernel/cpu/bugs.c                                              |    5 
 arch/x86/kernel/fpu/core.c                                              |    3 
 arch/x86/kernel/kvm.c                                                   |   20 
 arch/x86/kvm/svm/svm.c                                                  |   10 
 arch/x86/net/bpf_jit_comp.c                                             |    2 
 arch/xtensa/kernel/asm-offsets.c                                        |    1 
 block/bdev.c                                                            |   17 
 block/blk-zoned.c                                                       |    5 
 block/fops.c                                                            |   61 
 block/ioctl.c                                                           |    6 
 drivers/acpi/acpi_video.c                                               |    4 
 drivers/acpi/acpica/dsmethod.c                                          |   10 
 drivers/acpi/cppc_acpi.c                                                |    6 
 drivers/acpi/numa/srat.c                                                |    2 
 drivers/acpi/pptt.c                                                     |   93 
 drivers/acpi/prmt.c                                                     |   19 
 drivers/acpi/property.c                                                 |   24 
 drivers/acpi/scan.c                                                     |    2 
 drivers/ata/libata-scsi.c                                               |   12 
 drivers/atm/fore200e.c                                                  |    2 
 drivers/base/arch_topology.c                                            |   12 
 drivers/base/cacheinfo.c                                                |  156 
 drivers/base/power/wakeup.c                                             |    5 
 drivers/base/regmap/regmap-slimbus.c                                    |    6 
 drivers/bcma/main.c                                                     |    6 
 drivers/bluetooth/btmtksdio.c                                           |   12 
 drivers/bluetooth/btusb.c                                               |   30 
 drivers/bluetooth/hci_bcsp.c                                            |    3 
 drivers/char/misc.c                                                     |    8 
 drivers/clk/at91/clk-master.c                                           |    3 
 drivers/clk/at91/clk-sam9x60-pll.c                                      |   75 
 drivers/clk/ti/clk-33xx.c                                               |    2 
 drivers/clocksource/timer-vf-pit.c                                      |   22 
 drivers/cpufreq/longhaul.c                                              |    3 
 drivers/cpufreq/tegra186-cpufreq.c                                      |   27 
 drivers/cpuidle/cpuidle.c                                               |    8 
 drivers/dma/dw-edma/dw-edma-core.c                                      |   22 
 drivers/dma/mv_xor.c                                                    |    4 
 drivers/dma/sh/shdma-base.c                                             |   25 
 drivers/dma/sh/shdmac.c                                                 |   17 
 drivers/edac/altera_edac.c                                              |   22 
 drivers/edac/edac_mc_sysfs.c                                            |   24 
 drivers/extcon/extcon-adc-jack.c                                        |    2 
 drivers/firmware/arm_scmi/scmi_pm_domain.c                              |   13 
 drivers/firmware/stratix10-svc.c                                        |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c                          |   66 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                                  |   23 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                              |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c                           |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                                 |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c                                |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                                 |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                                 |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c                                |    4 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                                  |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                                |   19 
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                                   |    9 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                       |   12 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c                       |    8 
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c                         |   11 
 drivers/gpu/drm/amd/display/include/dal_asic_id.h                       |    5 
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c                              |    5 
 drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c                   |    2 
 drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c                |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c                       |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c                      |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                                  |    2 
 drivers/gpu/drm/bridge/display-connector.c                              |    3 
 drivers/gpu/drm/drm_gem_atomic_helper.c                                 |    6 
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c                                |    2 
 drivers/gpu/drm/i915/gt/intel_gt_clock_utils.c                          |    4 
 drivers/gpu/drm/i915/i915_vma.c                                         |   16 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                                   |    5 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                                   |    3 
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c                               |   10 
 drivers/gpu/drm/nouveau/nvkm/core/enum.c                                |    2 
 drivers/gpu/drm/scheduler/sched_entity.c                                |    3 
 drivers/gpu/drm/sti/sti_vtg.c                                           |    7 
 drivers/gpu/drm/tegra/dc.c                                              |    1 
 drivers/gpu/drm/tegra/uapi.c                                            |    7 
 drivers/gpu/drm/tidss/tidss_crtc.c                                      |    7 
 drivers/gpu/drm/tidss/tidss_dispc.c                                     |   16 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                                 |    5 
 drivers/gpu/host1x/context.c                                            |    4 
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c                           |    2 
 drivers/hid/hid-core.c                                                  |    7 
 drivers/hid/hid-ids.h                                                   |    7 
 drivers/hid/hid-ntrig.c                                                 |    7 
 drivers/hid/hid-quirks.c                                                |   14 
 drivers/hwmon/asus-ec-sensors.c                                         |    2 
 drivers/hwmon/dell-smm-hwmon.c                                          |    7 
 drivers/hwmon/sbtsi_temp.c                                              |   46 
 drivers/hwmon/sy7636a-hwmon.c                                           |    1 
 drivers/i2c/busses/i2c-xgene-slimpro.c                                  |   16 
 drivers/iio/accel/adxl355_core.c                                        |   44 
 drivers/iio/accel/bmc150-accel-core.c                                   |    5 
 drivers/iio/accel/bmc150-accel.h                                        |    1 
 drivers/iio/adc/ad7280a.c                                               |    2 
 drivers/iio/adc/rtq6056.c                                               |    2 
 drivers/iio/adc/spear_adc.c                                             |    9 
 drivers/iio/common/ssp_sensors/ssp_dev.c                                |    4 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h                                 |   22 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                              |   11 
 drivers/infiniband/hw/hns/hns_roce_qp.c                                 |    2 
 drivers/infiniband/hw/irdma/pble.c                                      |    2 
 drivers/infiniband/hw/irdma/verbs.c                                     |    4 
 drivers/infiniband/hw/irdma/verbs.h                                     |    8 
 drivers/input/keyboard/cros_ec_keyb.c                                   |    6 
 drivers/input/keyboard/imx_sc_key.c                                     |    2 
 drivers/input/tablet/pegasus_notetaker.c                                |    9 
 drivers/iommu/amd/init.c                                                |   28 
 drivers/iommu/intel/debugfs.c                                           |   10 
 drivers/iommu/intel/perf.c                                              |   10 
 drivers/iommu/intel/perf.h                                              |    5 
 drivers/irqchip/irq-gic-v2m.c                                           |   13 
 drivers/irqchip/irq-loongson-pch-lpc.c                                  |    9 
 drivers/irqchip/irq-sifive-plic.c                                       |    6 
 drivers/isdn/hardware/mISDN/hfcsusb.c                                   |   18 
 drivers/mailbox/mailbox-test.c                                          |    2 
 drivers/mailbox/mailbox.c                                               |   96 
 drivers/mailbox/pcc.c                                                   |  246 -
 drivers/md/dm-verity-fec.c                                              |    6 
 drivers/media/i2c/Kconfig                                               |    2 
 drivers/media/i2c/adv7180.c                                             |   48 
 drivers/media/i2c/ir-kbd-i2c.c                                          |    6 
 drivers/media/i2c/og01a1b.c                                             |    6 
 drivers/media/pci/ivtv/ivtv-alsa-pcm.c                                  |    2 
 drivers/media/pci/ivtv/ivtv-driver.h                                    |    3 
 drivers/media/pci/ivtv/ivtv-fileops.c                                   |   18 
 drivers/media/pci/ivtv/ivtv-irq.c                                       |    4 
 drivers/media/platform/amphion/vpu_v4l2.c                               |    7 
 drivers/media/platform/verisilicon/hantro_drv.c                         |    2 
 drivers/media/platform/verisilicon/hantro_v4l2.c                        |    6 
 drivers/media/rc/imon.c                                                 |   61 
 drivers/media/rc/redrat3.c                                              |    2 
 drivers/media/tuners/xc4000.c                                           |    8 
 drivers/media/tuners/xc5000.c                                           |   12 
 drivers/memstick/core/memstick.c                                        |    8 
 drivers/mfd/da9063-i2c.c                                                |   27 
 drivers/mfd/madera-core.c                                               |    4 
 drivers/mfd/stmpe-i2c.c                                                 |    1 
 drivers/mfd/stmpe.c                                                     |    3 
 drivers/mmc/host/renesas_sdhi_core.c                                    |    6 
 drivers/mmc/host/sdhci-msm.c                                            |   15 
 drivers/mmc/host/sdhci-of-dwcmshc.c                                     |    2 
 drivers/most/most_usb.c                                                 |   14 
 drivers/mtd/mtdchar.c                                                   |    6 
 drivers/mtd/nand/onenand/onenand_samsung.c                              |    2 
 drivers/mtd/nand/raw/cadence-nand-controller.c                          |    3 
 drivers/net/can/sja1000/sja1000.c                                       |    4 
 drivers/net/can/sun4i_can.c                                             |    4 
 drivers/net/can/usb/gs_usb.c                                            |   64 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c                        |    4 
 drivers/net/dsa/b53/b53_common.c                                        |   15 
 drivers/net/dsa/b53/b53_regs.h                                          |    3 
 drivers/net/dsa/dsa_loop.c                                              |    9 
 drivers/net/dsa/hirschmann/hellcreek_ptp.c                              |   14 
 drivers/net/dsa/microchip/ksz9477.c                                     |   98 
 drivers/net/dsa/microchip/ksz9477_reg.h                                 |    3 
 drivers/net/dsa/microchip/ksz_common.c                                  |   12 
 drivers/net/dsa/microchip/ksz_common.h                                  |    2 
 drivers/net/dsa/microchip/lan937x_main.c                                |    1 
 drivers/net/dsa/sja1105/sja1105_main.c                                  |   66 
 drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.c                    |   22 
 drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.h                    |    1 
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c                        |    5 
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c               |   19 
 drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c                |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c                           |    4 
 drivers/net/ethernet/cadence/macb_main.c                                |    6 
 drivers/net/ethernet/emulex/benet/be_main.c                             |    7 
 drivers/net/ethernet/freescale/fec_main.c                               |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c                 |    3 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c                 |    9 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h                 |    2 
 drivers/net/ethernet/intel/fm10k/fm10k_common.c                         |    5 
 drivers/net/ethernet/intel/fm10k/fm10k_common.h                         |    2 
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c                             |    2 
 drivers/net/ethernet/intel/fm10k/fm10k_vf.c                             |    2 
 drivers/net/ethernet/intel/ice/ice_main.c                               |    2 
 drivers/net/ethernet/intel/ice/ice_trace.h                              |   10 
 drivers/net/ethernet/mellanox/mlx5/core/en.h                            |   10 
 drivers/net/ethernet/mellanox/mlx5/core/en/port.c                       |   72 
 drivers/net/ethernet/mellanox/mlx5/core/en/port.h                       |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c                |  282 +
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h                |    7 
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c                       |    8 
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c                      |   62 
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c                    |   18 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                       |    5 
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c                         |    5 
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c                      |   12 
 drivers/net/ethernet/mellanox/mlxsw/core_linecards.c                    |    2 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c                   |    6 
 drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c                    |    5 
 drivers/net/ethernet/microchip/sparx5/Kconfig                           |    2 
 drivers/net/ethernet/qlogic/qede/qede_fp.c                              |    5 
 drivers/net/ethernet/realtek/Kconfig                                    |    2 
 drivers/net/ethernet/realtek/r8169_main.c                               |    6 
 drivers/net/ethernet/renesas/sh_eth.c                                   |    4 
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c                         |    4 
 drivers/net/ethernet/smsc/smsc911x.c                                    |   14 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                       |    9 
 drivers/net/ethernet/ti/netcp_core.c                                    |   10 
 drivers/net/hamradio/6pack.c                                            |   57 
 drivers/net/mdio/of_mdio.c                                              |    1 
 drivers/net/phy/dp83867.c                                               |    6 
 drivers/net/phy/fixed_phy.c                                             |    1 
 drivers/net/phy/marvell.c                                               |   39 
 drivers/net/phy/mdio_bus.c                                              |    5 
 drivers/net/usb/asix_devices.c                                          |   12 
 drivers/net/usb/qmi_wwan.c                                              |    6 
 drivers/net/usb/usbnet.c                                                |    2 
 drivers/net/virtio_net.c                                                |   26 
 drivers/net/wireless/ath/ath10k/mac.c                                   |   12 
 drivers/net/wireless/ath/ath10k/wmi.c                                   |   40 
 drivers/net/wireless/ath/ath11k/hw.c                                    |    1 
 drivers/net/wireless/ath/ath11k/mac.c                                   |    5 
 drivers/net/wireless/ath/ath11k/wmi.c                                   |   30 
 drivers/net/wireless/ath/ath11k/wmi.h                                   |    3 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c             |    3 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c                  |   28 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h                  |    3 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c                        |    2 
 drivers/ntb/hw/epf/ntb_hw_epf.c                                         |  103 
 drivers/nvme/host/core.c                                                |    8 
 drivers/nvme/host/fc.c                                                  |   12 
 drivers/nvme/host/multipath.c                                           |    2 
 drivers/nvme/target/fc.c                                                |   16 
 drivers/pci/controller/cadence/pcie-cadence-host.c                      |    2 
 drivers/pci/controller/cadence/pcie-cadence.c                           |    4 
 drivers/pci/controller/cadence/pcie-cadence.h                           |    6 
 drivers/pci/p2pdma.c                                                    |    2 
 drivers/pci/pci-driver.c                                                |    2 
 drivers/pci/pci.c                                                       |    5 
 drivers/pci/quirks.c                                                    |    3 
 drivers/phy/cadence/cdns-dphy.c                                         |    4 
 drivers/phy/rockchip/phy-rockchip-inno-csidphy.c                        |    5 
 drivers/pinctrl/pinctrl-single.c                                        |    4 
 drivers/platform/x86/intel/punit_ipc.c                                  |    2 
 drivers/platform/x86/intel/speed_select_if/isst_if_mmio.c               |    4 
 drivers/power/supply/sbs-charger.c                                      |   16 
 drivers/ptp/ptp_clock.c                                                 |   13 
 drivers/regulator/fixed.c                                               |    1 
 drivers/remoteproc/qcom_q6v5.c                                          |    5 
 drivers/rtc/rtc-pcf2127.c                                               |    4 
 drivers/rtc/rtc-rx8025.c                                                |    2 
 drivers/s390/net/ctcm_mpc.c                                             |    1 
 drivers/scsi/hosts.c                                                    |    5 
 drivers/scsi/libfc/fc_encode.h                                          |    2 
 drivers/scsi/lpfc/lpfc_debugfs.h                                        |    3 
 drivers/scsi/lpfc/lpfc_els.c                                            |    6 
 drivers/scsi/lpfc/lpfc_init.c                                           |    7 
 drivers/scsi/lpfc/lpfc_scsi.c                                           |   14 
 drivers/scsi/mpi3mr/mpi3mr_fw.c                                         |   10 
 drivers/scsi/mpt3sas/mpt3sas_transport.c                                |    3 
 drivers/scsi/pm8001/pm8001_ctl.c                                        |   24 
 drivers/scsi/pm8001/pm8001_init.c                                       |    1 
 drivers/scsi/pm8001/pm8001_sas.c                                        |    4 
 drivers/scsi/pm8001/pm8001_sas.h                                        |    4 
 drivers/scsi/sg.c                                                       |   10 
 drivers/slimbus/qcom-ngd-ctrl.c                                         |    1 
 drivers/soc/aspeed/aspeed-socinfo.c                                     |    4 
 drivers/soc/imx/gpc.c                                                   |    2 
 drivers/soc/qcom/smem.c                                                 |    2 
 drivers/soc/samsung/pm_domains.c                                        |   11 
 drivers/soc/ti/knav_dma.c                                               |   14 
 drivers/soc/ti/pruss.c                                                  |    2 
 drivers/spi/spi-bcm63xx.c                                               |   14 
 drivers/spi/spi-loopback-test.c                                         |   12 
 drivers/spi/spi-rpc-if.c                                                |    2 
 drivers/spi/spi.c                                                       |   10 
 drivers/staging/Kconfig                                                 |    2 
 drivers/staging/Makefile                                                |    1 
 drivers/staging/rtl8712/Kconfig                                         |   21 
 drivers/staging/rtl8712/Makefile                                        |   35 
 drivers/staging/rtl8712/TODO                                            |   13 
 drivers/staging/rtl8712/basic_types.h                                   |   28 
 drivers/staging/rtl8712/drv_types.h                                     |  175 
 drivers/staging/rtl8712/ethernet.h                                      |   21 
 drivers/staging/rtl8712/hal_init.c                                      |  401 -
 drivers/staging/rtl8712/ieee80211.c                                     |  415 -
 drivers/staging/rtl8712/ieee80211.h                                     |  165 
 drivers/staging/rtl8712/mlme_linux.c                                    |  160 
 drivers/staging/rtl8712/mlme_osdep.h                                    |   31 
 drivers/staging/rtl8712/mp_custom_oid.h                                 |  287 -
 drivers/staging/rtl8712/os_intfs.c                                      |  465 -
 drivers/staging/rtl8712/osdep_intf.h                                    |   32 
 drivers/staging/rtl8712/osdep_service.h                                 |   60 
 drivers/staging/rtl8712/recv_linux.c                                    |  139 
 drivers/staging/rtl8712/recv_osdep.h                                    |   39 
 drivers/staging/rtl8712/rtl8712_bitdef.h                                |   26 
 drivers/staging/rtl8712/rtl8712_cmd.c                                   |  409 -
 drivers/staging/rtl8712/rtl8712_cmd.h                                   |  231 
 drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h                        |   95 
 drivers/staging/rtl8712/rtl8712_cmdctrl_regdef.h                        |   19 
 drivers/staging/rtl8712/rtl8712_debugctrl_bitdef.h                      |   41 
 drivers/staging/rtl8712/rtl8712_debugctrl_regdef.h                      |   32 
 drivers/staging/rtl8712/rtl8712_edcasetting_bitdef.h                    |   65 
 drivers/staging/rtl8712/rtl8712_edcasetting_regdef.h                    |   24 
 drivers/staging/rtl8712/rtl8712_efuse.c                                 |  564 --
 drivers/staging/rtl8712/rtl8712_efuse.h                                 |   43 
 drivers/staging/rtl8712/rtl8712_event.h                                 |   86 
 drivers/staging/rtl8712/rtl8712_fifoctrl_bitdef.h                       |  131 
 drivers/staging/rtl8712/rtl8712_fifoctrl_regdef.h                       |   61 
 drivers/staging/rtl8712/rtl8712_gp_bitdef.h                             |   68 
 drivers/staging/rtl8712/rtl8712_gp_regdef.h                             |   29 
 drivers/staging/rtl8712/rtl8712_hal.h                                   |  142 
 drivers/staging/rtl8712/rtl8712_interrupt_bitdef.h                      |   44 
 drivers/staging/rtl8712/rtl8712_io.c                                    |   99 
 drivers/staging/rtl8712/rtl8712_led.c                                   | 1830 -------
 drivers/staging/rtl8712/rtl8712_macsetting_bitdef.h                     |   31 
 drivers/staging/rtl8712/rtl8712_macsetting_regdef.h                     |   20 
 drivers/staging/rtl8712/rtl8712_powersave_bitdef.h                      |   39 
 drivers/staging/rtl8712/rtl8712_powersave_regdef.h                      |   26 
 drivers/staging/rtl8712/rtl8712_ratectrl_bitdef.h                       |   36 
 drivers/staging/rtl8712/rtl8712_ratectrl_regdef.h                       |   43 
 drivers/staging/rtl8712/rtl8712_recv.c                                  | 1079 ----
 drivers/staging/rtl8712/rtl8712_recv.h                                  |  145 
 drivers/staging/rtl8712/rtl8712_regdef.h                                |   32 
 drivers/staging/rtl8712/rtl8712_security_bitdef.h                       |   34 
 drivers/staging/rtl8712/rtl8712_spec.h                                  |  121 
 drivers/staging/rtl8712/rtl8712_syscfg_bitdef.h                         |  163 
 drivers/staging/rtl8712/rtl8712_syscfg_regdef.h                         |   42 
 drivers/staging/rtl8712/rtl8712_timectrl_bitdef.h                       |   49 
 drivers/staging/rtl8712/rtl8712_timectrl_regdef.h                       |   26 
 drivers/staging/rtl8712/rtl8712_wmac_bitdef.h                           |   49 
 drivers/staging/rtl8712/rtl8712_wmac_regdef.h                           |   36 
 drivers/staging/rtl8712/rtl8712_xmit.c                                  |  745 ---
 drivers/staging/rtl8712/rtl8712_xmit.h                                  |  108 
 drivers/staging/rtl8712/rtl871x_cmd.c                                   |  796 ---
 drivers/staging/rtl8712/rtl871x_cmd.h                                   |  761 ---
 drivers/staging/rtl8712/rtl871x_debug.h                                 |  130 
 drivers/staging/rtl8712/rtl871x_eeprom.c                                |  220 
 drivers/staging/rtl8712/rtl871x_eeprom.h                                |   88 
 drivers/staging/rtl8712/rtl871x_event.h                                 |  109 
 drivers/staging/rtl8712/rtl871x_ht.h                                    |   33 
 drivers/staging/rtl8712/rtl871x_io.c                                    |  147 
 drivers/staging/rtl8712/rtl871x_io.h                                    |  236 -
 drivers/staging/rtl8712/rtl871x_ioctl.h                                 |   94 
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c                           | 2330 ----------
 drivers/staging/rtl8712/rtl871x_ioctl_rtl.c                             |  519 --
 drivers/staging/rtl8712/rtl871x_ioctl_rtl.h                             |  109 
 drivers/staging/rtl8712/rtl871x_ioctl_set.c                             |  354 -
 drivers/staging/rtl8712/rtl871x_ioctl_set.h                             |   45 
 drivers/staging/rtl8712/rtl871x_led.h                                   |  118 
 drivers/staging/rtl8712/rtl871x_mlme.c                                  | 1709 -------
 drivers/staging/rtl8712/rtl871x_mlme.h                                  |  205 
 drivers/staging/rtl8712/rtl871x_mp.c                                    |  724 ---
 drivers/staging/rtl8712/rtl871x_mp.h                                    |  275 -
 drivers/staging/rtl8712/rtl871x_mp_ioctl.c                              |  883 ---
 drivers/staging/rtl8712/rtl871x_mp_ioctl.h                              |  328 -
 drivers/staging/rtl8712/rtl871x_mp_phy_regdef.h                         | 1034 ----
 drivers/staging/rtl8712/rtl871x_pwrctrl.c                               |  234 -
 drivers/staging/rtl8712/rtl871x_pwrctrl.h                               |  113 
 drivers/staging/rtl8712/rtl871x_recv.c                                  |  669 --
 drivers/staging/rtl8712/rtl871x_recv.h                                  |  208 
 drivers/staging/rtl8712/rtl871x_rf.h                                    |   55 
 drivers/staging/rtl8712/rtl871x_security.c                              | 1386 -----
 drivers/staging/rtl8712/rtl871x_security.h                              |  218 
 drivers/staging/rtl8712/rtl871x_sta_mgt.c                               |  263 -
 drivers/staging/rtl8712/rtl871x_wlan_sme.h                              |   35 
 drivers/staging/rtl8712/rtl871x_xmit.c                                  | 1059 ----
 drivers/staging/rtl8712/rtl871x_xmit.h                                  |  288 -
 drivers/staging/rtl8712/sta_info.h                                      |  132 
 drivers/staging/rtl8712/usb_halinit.c                                   |  307 -
 drivers/staging/rtl8712/usb_intf.c                                      |  638 --
 drivers/staging/rtl8712/usb_ops.c                                       |  195 
 drivers/staging/rtl8712/usb_ops.h                                       |   38 
 drivers/staging/rtl8712/usb_ops_linux.c                                 |  515 --
 drivers/staging/rtl8712/usb_osintf.h                                    |   35 
 drivers/staging/rtl8712/wifi.h                                          |  196 
 drivers/staging/rtl8712/wlan_bssdef.h                                   |  223 
 drivers/staging/rtl8712/xmit_linux.c                                    |  181 
 drivers/staging/rtl8712/xmit_osdep.h                                    |   52 
 drivers/target/loopback/tcm_loop.c                                      |    3 
 drivers/tee/tee_core.c                                                  |    2 
 drivers/thunderbolt/nhi.c                                               |    2 
 drivers/thunderbolt/nhi.h                                               |    1 
 drivers/thunderbolt/tb.c                                                |    2 
 drivers/tty/serial/amba-pl011.c                                         |    2 
 drivers/tty/serial/sc16is7xx.c                                          |  185 
 drivers/ufs/core/ufshcd.c                                               |    7 
 drivers/ufs/host/ufs-mediatek.c                                         |   46 
 drivers/ufs/host/ufshcd-pci.c                                           |   70 
 drivers/uio/uio_hv_generic.c                                            |   21 
 drivers/usb/cdns3/cdns3-pci-wrap.c                                      |    5 
 drivers/usb/cdns3/cdnsp-gadget.c                                        |    8 
 drivers/usb/dwc3/core.c                                                 |    3 
 drivers/usb/dwc3/ep0.c                                                  |    1 
 drivers/usb/dwc3/gadget.c                                               |    7 
 drivers/usb/gadget/function/f_eem.c                                     |    7 
 drivers/usb/gadget/function/f_fs.c                                      |    8 
 drivers/usb/gadget/function/f_hid.c                                     |    4 
 drivers/usb/gadget/function/f_ncm.c                                     |    3 
 drivers/usb/gadget/udc/core.c                                           |   18 
 drivers/usb/gadget/udc/trace.h                                          |    5 
 drivers/usb/host/xhci-dbgcap.c                                          |  261 +
 drivers/usb/host/xhci-dbgcap.h                                          |   12 
 drivers/usb/host/xhci-dbgtty.c                                          |   23 
 drivers/usb/host/xhci-plat.c                                            |    1 
 drivers/usb/mon/mon_bin.c                                               |   14 
 drivers/usb/renesas_usbhs/common.c                                      |   18 
 drivers/usb/serial/ftdi_sio.c                                           |    1 
 drivers/usb/serial/ftdi_sio_ids.h                                       |    1 
 drivers/usb/serial/option.c                                             |   10 
 drivers/usb/storage/sddr55.c                                            |    6 
 drivers/usb/storage/transport.c                                         |   16 
 drivers/usb/storage/uas.c                                               |    5 
 drivers/usb/storage/unusual_devs.h                                      |    2 
 drivers/usb/typec/ucsi/psy.c                                            |    5 
 drivers/vfio/iova_bitmap.c                                              |    5 
 drivers/vfio/vfio_main.c                                                |    2 
 drivers/video/backlight/lp855x_bl.c                                     |    2 
 drivers/video/fbdev/aty/atyfb_base.c                                    |    8 
 drivers/video/fbdev/core/bitblit.c                                      |   33 
 drivers/video/fbdev/core/fbcon.c                                        |   19 
 drivers/video/fbdev/core/fbmem.c                                        |    1 
 drivers/video/fbdev/pvr2fb.c                                            |    2 
 drivers/video/fbdev/valkyriefb.c                                        |    2 
 drivers/watchdog/s3c2410_wdt.c                                          |   10 
 fs/9p/v9fs.c                                                            |    9 
 fs/btrfs/disk-io.c                                                      |    2 
 fs/btrfs/extent-tree.c                                                  |    6 
 fs/btrfs/file.c                                                         |   10 
 fs/btrfs/scrub.c                                                        |    3 
 fs/btrfs/transaction.c                                                  |    2 
 fs/btrfs/tree-log.c                                                     |    3 
 fs/ceph/file.c                                                          |    2 
 fs/ceph/locks.c                                                         |    5 
 fs/direct-io.c                                                          |   10 
 fs/eventpoll.c                                                          |  139 
 fs/exfat/fatent.c                                                       |   11 
 fs/exfat/super.c                                                        |    5 
 fs/ext4/fast_commit.c                                                   |    2 
 fs/ext4/file.c                                                          |    9 
 fs/ext4/xattr.c                                                         |    2 
 fs/f2fs/file.c                                                          |    1 
 fs/hpfs/namei.c                                                         |   18 
 fs/iomap/direct-io.c                                                    |   12 
 fs/jfs/inode.c                                                          |    8 
 fs/jfs/jfs_txnmgr.c                                                     |    9 
 fs/libfs.c                                                              |   42 
 fs/nfs/file.c                                                           |    1 
 fs/nfs/nfs4client.c                                                     |    1 
 fs/nfs/nfs4proc.c                                                       |   15 
 fs/nfs/nfs4state.c                                                      |    3 
 fs/nfs/write.c                                                          |    3 
 fs/nfsd/nfs4proc.c                                                      |    7 
 fs/nfsd/nfs4state.c                                                     |    9 
 fs/nilfs2/the_nilfs.c                                                   |    3 
 fs/ntfs3/inode.c                                                        |    1 
 fs/open.c                                                               |   10 
 fs/orangefs/xattr.c                                                     |   12 
 fs/proc/generic.c                                                       |   12 
 fs/smb/client/cifsfs.c                                                  |    2 
 fs/smb/client/connect.c                                                 |    1 
 fs/smb/client/smb2inode.c                                               |    2 
 fs/smb/client/smb2pdu.c                                                 |    7 
 fs/smb/client/transport.c                                               |   10 
 fs/smb/server/smb2pdu.c                                                 |    6 
 fs/smb/server/transport_tcp.c                                           |   12 
 include/acpi/pcc.h                                                      |   20 
 include/linux/array_size.h                                              |   13 
 include/linux/ata.h                                                     |    1 
 include/linux/blk_types.h                                               |   11 
 include/linux/cacheinfo.h                                               |   11 
 include/linux/compiler_types.h                                          |    5 
 include/linux/fbcon.h                                                   |    2 
 include/linux/filter.h                                                  |   22 
 include/linux/fs.h                                                      |    7 
 include/linux/host1x.h                                                  |    2 
 include/linux/kernel.h                                                  |    7 
 include/linux/mailbox_client.h                                          |    1 
 include/linux/map_benchmark.h                                           |    1 
 include/linux/mlx5/driver.h                                             |    2 
 include/linux/mlx5/mlx5_ifc.h                                           |   61 
 include/linux/pagemap.h                                                 |    2 
 include/linux/pci.h                                                     |    2 
 include/linux/shdma-base.h                                              |    2 
 include/linux/string.h                                                  |    1 
 include/linux/suspend.h                                                 |    4 
 include/linux/usb/gadget.h                                              |    5 
 include/net/bluetooth/hci.h                                             |   12 
 include/net/bluetooth/hci_core.h                                        |    8 
 include/net/bluetooth/mgmt.h                                            |    2 
 include/net/cls_cgroup.h                                                |    2 
 include/net/nfc/nci_core.h                                              |    2 
 include/net/pkt_sched.h                                                 |   25 
 include/net/tc_act/tc_connmark.h                                        |   10 
 include/net/tls.h                                                       |    6 
 include/net/xdp.h                                                       |    5 
 include/net/xfrm.h                                                      |    3 
 include/trace/events/irq.h                                              |   47 
 include/uapi/asm-generic/bitsperlong.h                                  |   13 
 include/ufs/ufshcd.h                                                    |    7 
 include/ufs/ufshci.h                                                    |    4 
 kernel/bpf/ringbuf.c                                                    |    2 
 kernel/events/callchain.c                                               |   10 
 kernel/events/uprobes.c                                                 |    7 
 kernel/futex/syscalls.c                                                 |  106 
 kernel/gcov/gcc_4_7.c                                                   |    4 
 kernel/softirq.c                                                        |    9 
 kernel/time/timer.c                                                     |    7 
 kernel/trace/ftrace.c                                                   |    2 
 kernel/trace/trace_events_hist.c                                        |    6 
 lib/crypto/Makefile                                                     |    2 
 lib/maple_tree.c                                                        |   30 
 mm/filemap.c                                                            |  161 
 mm/mempool.c                                                            |   32 
 mm/page_alloc.c                                                         |    2 
 mm/percpu.c                                                             |    8 
 mm/secretmem.c                                                          |    2 
 mm/truncate.c                                                           |   27 
 net/8021q/vlan.c                                                        |    2 
 net/bluetooth/6lowpan.c                                                 |   97 
 net/bluetooth/hci_event.c                                               |   34 
 net/bluetooth/hci_sync.c                                                |   17 
 net/bluetooth/iso.c                                                     |   36 
 net/bluetooth/l2cap_core.c                                              |    1 
 net/bluetooth/mgmt.c                                                    |    7 
 net/bluetooth/sco.c                                                     |    7 
 net/bluetooth/smp.c                                                     |   31 
 net/bridge/br.c                                                         |    5 
 net/bridge/br_forward.c                                                 |    5 
 net/bridge/br_if.c                                                      |    1 
 net/bridge/br_input.c                                                   |    4 
 net/bridge/br_mst.c                                                     |   10 
 net/bridge/br_private.h                                                 |   13 
 net/ceph/auth_x.c                                                       |    2 
 net/ceph/ceph_common.c                                                  |   53 
 net/ceph/debugfs.c                                                      |   14 
 net/ceph/osdmap.c                                                       |   18 
 net/core/filter.c                                                       |    1 
 net/core/netpoll.c                                                      |    7 
 net/core/page_pool.c                                                    |   12 
 net/core/sock.c                                                         |   15 
 net/dsa/tag_brcm.c                                                      |   10 
 net/ethernet/eth.c                                                      |    5 
 net/hsr/hsr_device.c                                                    |    3 
 net/ipv4/esp4.c                                                         |    4 
 net/ipv4/esp4_offload.c                                                 |    6 
 net/ipv4/netfilter/nf_reject_ipv4.c                                     |   25 
 net/ipv4/nexthop.c                                                      |    6 
 net/ipv4/route.c                                                        |    5 
 net/ipv4/udp_tunnel_nic.c                                               |    2 
 net/ipv6/addrconf.c                                                     |    4 
 net/ipv6/ah6.c                                                          |   50 
 net/ipv6/esp6.c                                                         |    4 
 net/ipv6/esp6_offload.c                                                 |    6 
 net/ipv6/netfilter/nf_reject_ipv6.c                                     |   30 
 net/ipv6/raw.c                                                          |    2 
 net/ipv6/udp.c                                                          |    2 
 net/mac80211/iface.c                                                    |   14 
 net/mac80211/mlme.c                                                     |    2 
 net/mac80211/rx.c                                                       |   10 
 net/mptcp/options.c                                                     |   54 
 net/mptcp/pm_netlink.c                                                  |   26 
 net/mptcp/protocol.c                                                    |  125 
 net/mptcp/protocol.h                                                    |    5 
 net/mptcp/subflow.c                                                     |    8 
 net/netfilter/nf_tables_api.c                                           |   15 
 net/openvswitch/actions.c                                               |   68 
 net/openvswitch/flow_netlink.c                                          |   64 
 net/openvswitch/flow_netlink.h                                          |    2 
 net/rds/rds.h                                                           |    2 
 net/sched/act_bpf.c                                                     |    6 
 net/sched/act_connmark.c                                                |  134 
 net/sched/act_ife.c                                                     |   12 
 net/sched/cls_bpf.c                                                     |    6 
 net/sched/sch_api.c                                                     |   10 
 net/sched/sch_generic.c                                                 |   17 
 net/sched/sch_hfsc.c                                                    |   16 
 net/sched/sch_qfq.c                                                     |    2 
 net/sctp/diag.c                                                         |   21 
 net/sctp/transport.c                                                    |   13 
 net/smc/smc_clc.c                                                       |    1 
 net/strparser/strparser.c                                               |    2 
 net/tipc/net.c                                                          |    2 
 net/tls/tls_device.c                                                    |    4 
 net/unix/garbage.c                                                      |   14 
 net/vmw_vsock/af_vsock.c                                                |   40 
 net/xfrm/espintcp.c                                                     |    4 
 scripts/kconfig/mconf.c                                                 |    3 
 scripts/kconfig/nconf.c                                                 |    3 
 sound/drivers/serial-generic.c                                          |   12 
 sound/pci/hda/patch_realtek.c                                           |   17 
 sound/soc/codecs/cs4271.c                                               |   10 
 sound/soc/codecs/lpass-va-macro.c                                       |    2 
 sound/soc/codecs/max98090.c                                             |    6 
 sound/soc/fsl/fsl_sai.c                                                 |    3 
 sound/soc/intel/avs/pcm.c                                               |    2 
 sound/soc/meson/aiu-encoder-i2s.c                                       |    9 
 sound/soc/qcom/qdsp6/q6asm.c                                            |    2 
 sound/soc/qcom/sc8280xp.c                                               |    3 
 sound/usb/endpoint.c                                                    |    6 
 sound/usb/mixer.c                                                       |   11 
 sound/usb/mixer_s1810c.c                                                |   28 
 sound/usb/quirks.c                                                      |    3 
 sound/usb/validate.c                                                    |    9 
 tools/bpf/bpftool/btf_dumper.c                                          |    2 
 tools/bpf/bpftool/prog.c                                                |    2 
 tools/include/linux/bitmap.h                                            |    1 
 tools/include/uapi/asm-generic/bitsperlong.h                            |   14 
 tools/include/uapi/asm/bitsperlong.h                                    |    6 
 tools/lib/bpf/bpf_tracing.h                                             |    2 
 tools/lib/thermal/Makefile                                              |    9 
 tools/power/cpupower/lib/cpuidle.c                                      |    5 
 tools/power/cpupower/lib/cpupower.c                                     |    2 
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c         |   30 
 tools/testing/selftests/Makefile                                        |    2 
 tools/testing/selftests/bpf/test_lirc_mode2_user.c                      |    2 
 tools/testing/selftests/bpf/test_xsk.sh                                 |    2 
 tools/testing/selftests/drivers/net/netdevsim/Makefile                  |   21 
 tools/testing/selftests/drivers/net/netdevsim/settings                  |    1 
 tools/testing/selftests/net/bareudp.sh                                  |    2 
 tools/testing/selftests/net/fcnal-test.sh                               |  432 -
 tools/testing/selftests/net/forwarding/local_termination.sh             |    2 
 tools/testing/selftests/net/gro.c                                       |  101 
 tools/testing/selftests/net/mptcp/mptcp_connect.c                       |   18 
 tools/testing/selftests/net/mptcp/mptcp_connect.sh                      |    2 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                         |   65 
 tools/testing/selftests/net/psock_tpacket.c                             |    4 
 tools/testing/selftests/net/traceroute.sh                               |   13 
 tools/tracing/latency/latency-collector.c                               |    2 
 usr/include/headers_check.pl                                            |    2 
 678 files changed, 5740 insertions(+), 30290 deletions(-)

Aaron Kling (1):
      cpufreq: tegra186: Initialize all cores to max frequencies

Abdun Nihaal (1):
      isdn: mISDN: hfcsusb: fix memory leak in hfcsusb_probe()

Abinaya Kalaiselvan (1):
      wifi: ath11k: Add tx ack signal support for management packets

Adam Young (1):
      mailbox: pcc: Check before sending MCTP PCC response ACK

Adrian Hunter (3):
      scsi: ufs: ufs-pci: Fix S0ix/S3 for Intel controllers
      scsi: ufs: core: Add a quirk to suppress link_startup_again
      scsi: ufs: ufs-pci: Set UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE for Intel ADL

Akhil P Oommen (1):
      drm/msm/a6xx: Fix GMU firmware parser

Al Viro (4):
      direct_write_fallback(): on error revert the ->ki_pos update from buffered write
      allow finish_no_open(file, ERR_PTR(-E...))
      sparc64: fix prototypes of reads[bwl]()
      nfs4_setup_readdir(): insufficient locking for ->d_parent->d_inode dereferencing

Alan Borzeszkowski (1):
      thunderbolt: Add support for Intel Wildcat Lake

Alan Stern (2):
      USB: storage: Remove subclass and protocol overrides from Novatek quirk
      HID: core: Harden s32ton() against conversion to 0 bits

Albin Babu Varghese (1):
      fbdev: Add bounds checking in bit_putcs to fix vmalloc-out-of-bounds

Alejandro Colomar (1):
      kernel.h: Move ARRAY_SIZE() to a separate header

Aleksander Jan Bajkowski (5):
      mips: lantiq: danube: add missing properties to cpu node
      mips: lantiq: danube: add model to EASY50712 dts
      mips: lantiq: danube: add missing device_type in pci node
      mips: lantiq: xway: sysctrl: rename stp clock
      mips: lantiq: danube: rename stp node on EASY50712 reference board

Aleksei Nikiforov (1):
      s390/ctcm: Fix double-kfree

Alex Deucher (6):
      Reapply "Revert drm/amd/display: Enable Freesync Video Mode by default"
      drm/amd/display: add more cyan skillfish devices
      drm/amd: add more cyan skillfish PCI ids
      drm/amdgpu: don't enable SMU on cyan skillfish
      drm/amdgpu: add support for cyan skillfish gpu_info
      drm/amdgpu: fix cyan_skillfish2 gpu info fw handling

Alex Hung (1):
      drm/amd/display: Check NULL before accessing

Alex Mastro (1):
      vfio: return -ENOTTY for unsupported device feature

Alexander Stein (2):
      mfd: stmpe: Remove IRQ domain upon removal
      mfd: stmpe-i2c: Add missing MODULE_LICENSE

Alexander Sverdlin (1):
      selftests: net: local_termination: Wait for interfaces to come up

Alexey Klimov (2):
      regmap: slimbus: fix bus_context pointer in regmap init calls
      ASoC: qcom: sc8280xp: explicitly set S16LE format in sc8280xp_be_hw_params_fixup()

Alexey Kodanev (1):
      net: sxgbe: fix potential NULL dereference in sxgbe_rx()

Alice Chao (2):
      scsi: ufs: host: mediatek: Assign power mode userdata before FASTAUTO mode change
      scsi: ufs: host: mediatek: Fix invalid access in vccqx handling

Alistair Francis (1):
      nvme: Use non zero KATO for persistent discovery connections

Alok Tiwari (2):
      udp_tunnel: use netdev_warn() instead of netdev_WARN()
      scsi: libfc: Fix potential buffer overflow in fc_ct_ms_fill()

Amber Lin (1):
      drm/amdkfd: Tie UNMAP_LATENCY to queue_preemption

Amery Hung (1):
      bpf: Clear pfmemalloc flag when freeing all fragments

Amirreza Zarrabi (1):
      tee: allow a driver to allocate a tee_device without a pool

Andreas Kemnade (1):
      hwmon: sy7636a: add alias

Andrey Vatoropin (1):
      be2net: pass wrb_params in case of OS2BMC

Andrii Nakryiko (1):
      libbpf: Fix powerpc's stack register definition in bpf_tracing.h

André Draszik (1):
      pmdomain: samsung: plug potential memleak during probe

Anthony Iliopoulos (1):
      NFSv4.1: fix mount hang after CREATE_SESSION failure

Antonino Maniscalco (1):
      drm/msm: make sure to not queue up recovery more than once

Anubhav Singh (2):
      selftests/net: fix out-of-order delivery of FIN in gro:tcp test
      selftests/net: use destination options instead of hop-by-hop

Arkadiusz Bokowy (1):
      Bluetooth: btusb: Check for unexpected bytes when defragmenting HCI frames

Armen Ratner (1):
      net/mlx5e: Preserve shared buffer capacity during headroom updates

Armin Wolf (1):
      hwmon: (dell-smm) Add support for Dell OptiPlex 7040

Arnd Bergmann (2):
      mfd: madera: Work around false-positive -Wininitialized warning
      asm-generic: partially revert "Unify uapi bitsperlong.h for arm64, riscv and loongarch"

Arseniy Krasnov (1):
      Bluetooth: hci_sync: fix double free in 'hci_discovery_filter_clear()'

Ashish Kalra (1):
      iommu/amd: Skip enabling command/event buffers for kdump

Avadhut Naik (1):
      EDAC/mc_sysfs: Increase legacy channel support to 16

Baochen Qiang (1):
      Revert "wifi: ath10k: avoid unnecessary wait for service ready message"

Bart Van Assche (2):
      scsi: sg: Do not sleep in atomic context
      scsi: core: Fix a regression triggered by scsi_host_busy()

Bastien Curutchet (Schneider Electric) (1):
      net: dsa: microchip: common: Fix checks on irq_find_mapping()

Ben Copeland (1):
      hwmon: (asus-ec-sensors) increase timeout for locking ACPI mutex

Benjamin Berg (1):
      wifi: mac80211: skip rate verification for not captured PSDUs

Biju Das (2):
      mmc: host: renesas_sdhi: Fix the actual clock
      spi: rpc-if: Add resume support for RZ/G3E

Brahmajit Das (1):
      net: intel: fm10k: Fix parameter idx set but not used

Breno Leitao (1):
      net: netpoll: fix incorrect refcount handling causing incorrect cleanup

Buday Csaba (1):
      net: mdio: fix resource leak in mdiobus_register_device()

Bui Quang Minh (1):
      virtio-net: fix received length check in big packets

Carolina Jubran (1):
      net/mlx5e: Don't query FEC statistics when FEC is disabled

Celeste Liu (1):
      can: gs_usb: increase max interface to U8_MAX

Cen Zhang (1):
      Bluetooth: hci_sync: fix race in hci_cmd_sync_dequeue_once

Cezary Rojewski (1):
      ASoC: Intel: avs: Unprepare a stream when XRUN occurs

Chandrakanth Patil (1):
      scsi: mpi3mr: Fix controller init failure on fault during queue creation

Chang S. Bae (1):
      x86/fpu: Ensure XFD state on signal delivery

Charalampos Mitrodimas (1):
      net: ipv6: fix field-spanning memcpy warning in AH output

Chelsy Ratnawat (1):
      media: fix uninitialized symbol warnings

Chen Wang (1):
      PCI: cadence: Check for the existence of cdns_pcie::ops before using it

Chen Yufeng (1):
      usb: cdns3: gadget: Use-after-free during failed initialization and exit of cdnsp gadget

Chi Zhang (1):
      pinctrl: single: fix bias pull up/down handling in pin_config_set

Chi Zhiling (1):
      exfat: limit log print for IO error

ChiYuan Huang (1):
      iio: adc: rtq6056: Correct the sign bit index

Chris Lu (1):
      Bluetooth: btmtksdio: Add pmctrl handling for BT closed state during reset

Christian Bruel (1):
      irqchip/gic-v2m: Handle Multiple MSI base IRQ Alignment

Christian König (1):
      drm/amdgpu: reject gang submissions under SRIOV

Christoph Hellwig (5):
      filemap: add a kiocb_invalidate_pages helper
      filemap: add a kiocb_invalidate_post_direct_write helper
      filemap: update ki_pos in generic_perform_write
      fs: factor out a direct_write_fallback helper
      block: open code __generic_file_write_iter for blkdev writes

Christoph Paasch (1):
      net: When removing nexthops, don't call synchronize_net if it is not necessary

Christophe JAILLET (1):
      iio:common:ssp_sensors: Fix an error handling path ssp_probe()

Chuande Chen (1):
      hwmon: (sbtsi_temp) AMD CPU extended temperature range support

Chuang Wang (1):
      ipv4: route: Prevent rt_bind_exception() from rebinding stale fnhe

Chuck Lever (1):
      NFSD: Fix crash in nfsd4_read_release()

ChunHao Lin (1):
      r8169: set EEE speed down ratio to 1

Claudia Draghicescu (1):
      Bluetooth: ISO: Add support for periodic adv reports processing

Claudiu Beznea (1):
      usb: renesas_usbhs: Fix synchronous external abort on unbind

Colin Foster (1):
      smsc911x: add second read of EEPROM mac when possible corruption seen

Cryolitia PukNgae (1):
      ALSA: usb-audio: apply quirk for MOONDROP Quark2

D. Wythe (1):
      net/smc: fix mismatch between CLC header and proposal

Damien Le Moal (2):
      block: fix op_is_zone_mgmt() to handle REQ_OP_ZONE_RESET_ALL
      block: make REQ_OP_ZONE_OPEN a write operation

Dan Carpenter (4):
      mtd: onenand: Pass correct pointer to IRQ handler
      mtdchar: fix integer overflow in read/write ioctls
      Input: imx_sc_key - fix memory corruption on unload
      platform/x86: intel: punit_ipc: fix memory corruption

Daniel Lezcano (1):
      clocksource/drivers/vf-pit: Replace raw_readl/writel to readl/writel

Daniel Palmer (2):
      fbdev: atyfb: Check if pll_ops->init_pll failed
      eth: 8139too: Make 8139TOO_PIO depend on !NO_IOPORT_MAP

Daniel Wagner (2):
      nvmet-fc: avoid scheduling association deletion twice
      nvme-fc: use lock accessing port_state and rport state

Danielle Costantino (1):
      net/mlx5e: Fix validation logic in rate limiting

Danil Skrebenkov (1):
      RISC-V: clear hot-unplugged cores from all task mm_cpumasks to avoid rfence errors

Darrick J. Wong (1):
      block: fix race between set_blocksize and read paths

David Ahern (2):
      selftests: Disable dad for ipv6 in fcnal-test.sh
      selftests: Replace sleep with slowwait

David Francis (1):
      drm/amdgpu: Allow kfd CRIU with no buffer objects

David Kaplan (1):
      x86/bugs: Fix reporting of LFENCE retpoline

David Lechner (1):
      iio: adc: ad7280a: fix ad7280_store_balance_timer()

David Wei (1):
      netdevsim: add Makefile for selftests

Dennis Beier (1):
      cpufreq/longhaul: handle NULL policy in longhaul_exit

Desnes Nunes (1):
      usb: storage: Fix memory leak in USB bulk transport

Devendra K Verma (1):
      dmaengine: dw-edma: Set status for callback_result

Dmitry Baryshkov (1):
      drm/bridge: display-connector: don't set OP_DETECT for DisplayPorts

Dragos Tatulea (2):
      page_pool: Clamp pool size to max 16K pages
      net/mlx5e: SHAMPO, Fix skb size check for 64K pages

Elliot Berman (2):
      mailbox: Allow direct registration to a channel
      mailbox: pcc: Use mbox_bind_client

Emanuele Ghidoli (1):
      net: phy: dp83867: Disable EEE support as not implemented

Emil Dahl Juhl (1):
      tools: lib: thermal: don't preserve owner in install

Eric Biggers (1):
      lib/crypto: arm/curve25519: Disable on CPU_BIG_ENDIAN

Eric Dumazet (8):
      net: call cond_resched() less often in __release_sock()
      ipv6: np->rxpmtu race annotation
      sctp: prevent possible shift-out-of-bounds in sctp_transport_update_rto
      net_sched: act_connmark: use RCU in tcf_connmark_dump()
      net_sched: limit try_bulk_dequeue_skb() batches
      bpf: Add bpf_prog_run_data_pointers()
      mptcp: fix race condition in mptcp_schedule_work()
      mptcp: fix a race in mptcp_pm_del_add_timer()

Eric Huang (1):
      drm/amdkfd: fix vram allocation failure for a special case

Ewan D. Milne (1):
      nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()

Fabien Proriol (1):
      power: supply: sbs-charger: Support multiple devices

Fabio M. De Francesco (1):
      mm/mempool: replace kmap_atomic() with kmap_local_page()

Farhan Ali (1):
      s390/pci: Restore IRQ unconditionally for the zPCI device

Felix Maurer (1):
      hsr: Fix supervision frame sending on HSRv0

Filipe Manana (3):
      btrfs: always drop log root tree reference in btrfs_replay_log()
      btrfs: use smp_mb__after_atomic() when forcing COW in create_pending_snapshot()
      btrfs: do not update last_log_commit when logging inode due to a new name

Fiona Ebner (1):
      smb: client: transport: avoid reconnects triggered by pending task work

Florian Fuchs (1):
      fbdev: pvr2fb: Fix leftover reference to ONCHIP_NR_DMA_CHANNELS

Florian Westphal (1):
      netfilter: nf_reject: don't reply to icmp error messages

Forest Crossman (1):
      usb: mon: Increase BUFF_MAX to 64 MiB to support multi-MB URBs

Francesco Lavra (1):
      iio: imu: st_lsm6dsx: fix array size for st_lsm6dsx_settings fields

Francisco Gutierrez (1):
      scsi: pm80xx: Fix race condition caused by static variables

Gal Pressman (4):
      net/mlx5e: Fix maxrate wraparound in threshold between units
      net/mlx5e: Fix wraparound in rate limiting for values above 255 Gbps
      net/mlx5e: Remove mlx5e_dbg() and msglvl support
      net/mlx5e: Fix potentially misleading debug message

Gautham R. Shenoy (3):
      ACPI: CPPC: Check _CPC validity for only the online CPUs
      ACPI: CPPC: Perform fast check switch only for online CPUs
      ACPI: CPPC: Limit perf ctrs in PCC check only to online CPUs

Geert Uytterhoeven (1):
      kbuild: uapi: Strip comments before size type check

Geliang Tang (2):
      selftests: mptcp: disable add_addr retrans in endpoint_tests
      mptcp: change 'first' as a parameter

Geoffrey McRae (1):
      drm/amdkfd: return -ENOTTY for unsupported IOCTLs

Gerd Bayer (1):
      s390/pci: Avoid deadlock between PCI error recovery and mlx5 crdump

Gokul Sivakumar (1):
      wifi: brcmfmac: fix crash while sending Action Frames in standalone AP Mode

Greg Kroah-Hartman (1):
      Linux 6.1.159

Gui-Dong Han (1):
      atm/fore200e: Fix possible data race in fore200e_open()

Haein Lee (1):
      ALSA: usb-audio: Fix NULL pointer dereference in snd_usb_mixer_controls_badd

Hamza Mahfooz (1):
      scsi: target: tcm_loop: Fix segfault in tcm_loop_tpg_address_show()

Hang Zhou (1):
      spi: bcm63xx: fix premature CS deassertion on RX-only transactions

Hangbin Liu (1):
      net: vlan: sync VLAN features with lower device

Hans de Goede (3):
      ACPI: scan: Add Intel CVS ACPI HIDs to acpi_ignore_dep_ids[]
      ACPICA: dispatcher: Use acpi_ds_clear_operands() in acpi_ds_call_control_method()
      spi: Try to get ACPI GPIO IRQ earlier

Haotian Zhang (5):
      regulator: fixed: fix GPIO descriptor leak on register failure
      ASoC: cs4271: Fix regulator leak on probe failure
      ASoC: codecs: va-macro: fix resource leak in probe error path
      platform/x86/intel/speed_select_if: Convert PCIBIOS_* return codes to errnos
      mailbox: mailbox-test: Fix debugfs_create_dir error checking

Harikrishna Shenoy (1):
      phy: cadence: cdns-dphy: Enable lower resolutions in dphy

Heiner Kallweit (1):
      net: phy: fixed_phy: let fixed_phy_unregister free the phy_device

Horatiu Vultur (1):
      net: lan966x: Fix the initialization of taprio

Hoyoung Seo (1):
      scsi: ufs: core: Include UTP error in INT_FATAL_ERRORS

Huacai Chen (2):
      LoongArch: Use physical addresses for CSR_MERRENTRY/CSR_TLBRENTRY
      LoongArch: Don't panic if no valid cache info for PCI

Hugo Villeneuve (4):
      serial: sc16is7xx: remove unused to_sc16is7xx_port macro
      serial: sc16is7xx: reorder code to remove prototype declarations
      serial: sc16is7xx: refactor EFR lock
      serial: sc16is7xx: remove useless enable of enhanced features

Huisong Li (2):
      mailbox: pcc: Add support for platform notification handling
      mailbox: pcc: Support shared interrupt for multiple subspaces

Ian Forbes (1):
      drm/vmwgfx: Validate command header size against SVGA_CMD_MAX_DATASIZE

Ian Rogers (1):
      tools bitmap: Add missing asm-generic/bitsperlong.h include

Ido Schimmel (2):
      bridge: Redirect to backup port when port is administratively down
      selftests: traceroute: Use require_command()

Igor Pylypiv (1):
      scsi: pm80xx: Set phy->enable_completion only when we

Ilan Peer (1):
      wifi: mac80211: Fix HE capabilities element check

Ilia Gavrilov (1):
      Bluetooth: MGMT: Fix OOB access in parse_adv_monitor_pattern()

Ilya Dryomov (1):
      libceph: fix potential use-after-free in have_mon_and_osd_map()

Ilya Maximets (1):
      net: openvswitch: remove never-working support for setting nsh fields

Inochi Amaoto (1):
      irqchip/sifive-plic: Respect mask state when setting affinity

Isaac J. Manjarres (1):
      mm/mm_init: fix hash table order logging in alloc_large_system_hash()

Ivan Pravdin (1):
      Bluetooth: bcsp: receive data only if registered

Ivan Zhaldak (1):
      ALSA: usb-audio: Add DSD quirk for LEAK Stereo 230

Jacob Moroni (3):
      RDMA/irdma: Fix SD index calculation
      RDMA/irdma: Remove unused struct irdma_cq fields
      RDMA/irdma: Set irdma_cq cq_num field during CQ create

Jakub Horký (2):
      kconfig/mconf: Initialize the default locale at startup
      kconfig/nconf: Initialize the default locale at startup

Jakub Kicinski (3):
      selftests: net: replace sleeps in fcnal-test with waits
      page_pool: always add GFP_NOWARN for ATOMIC allocations
      selftests: netdevsim: set test timeout to 10 minutes

Jameson Thies (1):
      usb: typec: ucsi: psy: Set max current to zero when disconnected

Jamie Iles (2):
      mailbox: pcc: don't zero error register
      drivers/usb/dwc3: fix PCI parent check

Janusz Krzysztofik (1):
      drm/i915: Avoid lock inversion when pinning to GGTT on CHV/BXT+VTD

Jason Gunthorpe (1):
      iommufd: Don't overflow during division for dirty tracking

Jayesh Choudhary (1):
      drm/tidss: Set crtc modesetting parameters with adjusted mode

Jens Kehne (1):
      mfd: da9063: Split chip variant reading in two bus transactions

Jens Reidel (1):
      soc: qcom: smem: Fix endian-unaware access of num_entries

Jerome Brunet (1):
      NTB: epf: Allow arbitrary BAR mapping

Jesse.Zhang (1):
      drm/amdgpu: Fix NULL pointer dereference in VRAM logic for APU devices

Jianbo Liu (1):
      xfrm: Determine inner GSO type from packet inner protocol

Jiayi Li (1):
      memstick: Add timeout to prevent indefinite waiting

Jiayuan Chen (2):
      mptcp: Disallow MPTCP subflows from sockmap
      mptcp: Fix proto fallback detection with BPF

Jiefeng Zhang (1):
      net: atlantic: fix fragment overflow handling in RX path

Jijie Shao (1):
      net: hns3: return error code when function fails

Jimmy Hu (1):
      usb: gadget: udc: fix use-after-free in usb_gadget_state_work

Jiri Olsa (2):
      uprobe: Do not emulate/sstep original instruction when ip is changed
      Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"

Johan Hovold (2):
      most: usb: fix double free on late probe failure
      drm: sti: fix device leaks at component probe

Johannes Berg (1):
      wifi: mac80211: reject address change while connecting

John Keeping (1):
      ALSA: serial-generic: remove shared static buffer

John Smith (2):
      drm/amd/pm/powerplay/smumgr: Fix PCIeBootLinkLevel value on Fiji
      drm/amd/pm/powerplay/smumgr: Fix PCIeBootLinkLevel value on Iceland

Jonas Gorski (4):
      net: dsa: tag_brcm: legacy: fix untagged rx on unbridged ports for bcm63xx
      net: dsa: b53: fix resetting speed and pause on forced link
      net: dsa: b53: fix enabling ip multicast
      net: dsa: b53: stop reading ARL entries if search is done

Josh Poimboeuf (1):
      perf: Have get_perf_callchain() return NULL if crosstask and user are set

Joshua Rogers (2):
      smb: client: validate change notify buffer before copy
      ksmbd: close accepted socket when per-IP limit rejects connection

Joshua Watt (1):
      NFS4: Fix state renewals missing after boot

Josua Mayer (1):
      rtc: pcf2127: clear minute/second interrupt

Julian Sun (1):
      ext4: increase IO priority of fastcommit

Junjie Cao (1):
      fbdev: bitblit: bound-check glyph index in bit_putcs*

Junxian Huang (1):
      RDMA/hns: Fix wrong WQE data when QP wraps around

Juraj Šarinay (1):
      net: nfc: nci: Increase NCI_DATA_TIMEOUT to 3000 ms

Justin Tee (3):
      scsi: lpfc: Check return status of lpfc_reset_flush_io_context during TGT_RESET
      scsi: lpfc: Remove ndlp kref decrement clause for F_Port_Ctrl in lpfc_cleanup
      scsi: lpfc: Define size of debugfs entry for xri rebalancing

K Prateek Nayak (1):
      drivers: base: cacheinfo: Update cpu_map_populated during CPU Hotplug

Kai-Heng Feng (2):
      PM: suspend: Fix pm_suspend_target_state handling for !CONFIG_PM
      net: aquantia: Add missing descriptor cache invalidation on ATL2

Kailang Yang (1):
      ALSA: hda/realtek: Audio disappears on HP 15-fc000 after warm boot again

Kalesh AP (1):
      bnxt_en: Fix a possible memory leak in bnxt_ptp_init

Kaushlendra Kumar (3):
      tools/cpupower: fix error return value in cpupower_write_sysfs()
      tools/cpupower: Fix incorrect size in cpuidle_state_disable()
      tools/power x86_energy_perf_policy: Fix incorrect fopen mode usage

Kees Cook (1):
      arc: Fix __fls() const-foldability via __builtin_clzl()

Khairul Anuar Romli (1):
      firmware: stratix10-svc: fix bug in saving controller data

Kirill A. Shutemov (1):
      x86/vsyscall: Do not require X86_PF_INSTR to emulate vsyscall

Kiryl Shutsemau (1):
      mm/truncate: unmap large folio on split failure

Koakuma (1):
      sparc/module: Add R_SPARC_UA64 relocation handling

Krishna Kurapati (1):
      usb: xhci: plat: Facilitate using autosuspend for xhci plat devices

Krzysztof Kozlowski (5):
      extcon: adc-jack: Fix wakeup source leaks on device unbind
      drm/msm/dsi/phy: Toggle back buffer resync after preparing PLL
      drm/msm/dsi/phy_7nm: Fix missing initial VCO rate
      extcon: adc-jack: Cleanup wakeup source only if it was enabled
      dt-bindings: pinctrl: toshiba,visconti: Fix number of items in groups

Kuen-Han Tsai (2):
      usb: gadget: f_eem: Fix memory leak in eem_unwrap
      usb: udc: Add trace event for usb_gadget_set_state

Kuniyuki Iwashima (3):
      net: Call trace_sock_exceed_buf_limit() for memcg failure with SK_MEM_RECV.
      tipc: Fix use-after-free in tipc_mon_reinit_self().
      af_unix: Initialise scc_index in unix_add_edge().

Lance Yang (1):
      mm/secretmem: fix use-after-free race in fault handler

Laurent Pinchart (2):
      media: pci: ivtv: Don't create fake v4l2_fh
      media: amphion: Delete v4l2_fh synchronously in .release()

Len Brown (2):
      tools/power x86_energy_perf_policy: Enhance HWP enable
      tools/power x86_energy_perf_policy: Prefer driver HWP limits

Li RongQing (1):
      x86/kvm: Prefer native qspinlock for dedicated vCPUs irrespective of PV_UNHALT

Lijo Lazar (2):
      drm/amd/pm: Use cached metrics data on aldebaran
      drm/amd/pm: Use cached metrics data on arcturus

Linus Walleij (1):
      iio: accel: bmc150: Fix irq assumption regression

Lizhi Xu (1):
      usbnet: Prevents free active kevent

Loic Poulain (2):
      wifi: ath10k: Fix memory leak on unsupported WMI command
      wifi: ath10k: Fix connection after GTK rekeying

Long Li (1):
      uio_hv_generic: Set event for all channels on the device

Luiz Augusto von Dentz (4):
      Bluetooth: HCI: Fix tracking of advertisement set/instance 0x00
      Bluetooth: ISO: Fix another instance of dst_type handling
      Bluetooth: SCO: Fix UAF on sco_conn_free
      Bluetooth: SMP: Fix not generating mackey and ltk when repairing

Lukas Wunner (1):
      thunderbolt: Use is_pciehp instead of is_hotplug_bridge

Ma Ke (1):
      drm/tegra: dc: Fix reference leak in tegra_dc_couple()

Maciej W. Rozycki (2):
      MIPS: Malta: Fix !EVA SOC-it PCI MMIO
      MIPS: mm: Prevent a TLB shutdown on initial uniquification

Maher Sanalla (6):
      net/mlx5: Expose shared buffer registers bits and structs
      net/mlx5e: Add API to query/modify SBPR and SBCM registers
      net/mlx5e: Update shared buffer along with device buffer changes
      net/mlx5e: Consider internal buffers size in port buffer calculations
      net/mlx5: Fix memory leak in error flow of port set buffer
      net/mlx5e: Do not update SBCM when prio2buffer command is invalid

Manish Nagar (1):
      usb: dwc3: Fix race condition between concurrent dwc3_remove_requests() call paths

Marc Kleine-Budde (3):
      can: gs_usb: gs_usb_xmit_callback(): fix handling of failed transmitted URBs
      can: gs_usb: gs_usb_receive_bulk_callback(): check actual_length before accessing header
      can: sun4i_can: sun4i_can_interrupt(): fix max irq loop handling

Marcos Del Sol Vives (1):
      PCI: Disable MSI on RDC PCI to PCIe bridges

Mario Limonciello (2):
      PCI/PM: Skip resuming to D0 if device is disconnected
      drm/amd: Fix suspend failure with secure display TA

Mario Limonciello (AMD) (2):
      drm/amd: Avoid evicting resources at S5
      HID: amd_sfh: Stop sensor before starting

Martin Kaiser (1):
      maple_tree: fix tracepoint string pointers

Masami Ichikawa (1):
      HID: hid-ntrig: Prevent memory leak in ntrig_report_version()

Mathias Nyman (6):
      xhci: dbc: Provide sysfs option to configure dbc descriptors
      xhci: dbc: poll at different rate depending on data transfer activity
      xhci: dbc: Improve performance by removing delay in transfer event polling.
      xhci: dbc: Avoid event polling busyloop if pending rx transfers are inactive.
      xhci: dbc: fix bogus 1024 byte prefix if ttyDBC read races with stall event
      xhci: dbgtty: Fix data corruption when transmitting data form DbC to host

Matthias Schiffer (1):
      clk: ti: am33xx: keep WKUP_DEBUGSS_CLKCTRL enabled

Matthieu Baerts (NGI0) (6):
      mptcp: pm: in-kernel: C-flag: handle late ADD_ADDR
      selftests: mptcp: join: mark 'delete re-add signal' as skipped if not supported
      selftests: mptcp: connect: trunc: read all recv data
      selftests: mptcp: join: rm: set backup flag
      selftests: mptcp: connect: fix fallback note due to OoO
      selftests: mptcp: join: endpoints: longer transfer

Mehdi Djait (1):
      media: i2c: Kconfig: Ensure a dependency on HAVE_CLK for VIDEO_CAMERA_SENSOR

Menglong Dong (1):
      arch: Add the macro COMPILE_OFFSETS to all the asm-offsets.c

Miaoqian Lin (6):
      net: usb: asix_devices: Check return value of usbnet_get_endpoints
      fbdev: valkyriefb: Fix reference count leak in valkyriefb_init
      pmdomain: imx: Fix reference count leak in imx_gpc_remove
      slimbus: ngd: Fix reference count leak in qcom_slim_ngd_notify_slaves
      serial: amba-pl011: prefer dma_mapping_error() over explicit address checking
      usb: cdns3: Fix double resource release in cdns3_pci_probe

Michael Riesch (1):
      phy: rockchip: phy-rockchip-inno-csidphy: allow writes to grf register 0

Michal Hocko (1):
      mm, percpu: do not consider sleepable allocations atomic

Michal Luczaj (1):
      vsock: Ignore signal/timeout on connect() if already established

Mike Marshall (1):
      orangefs: fix xattr related buffer overflow...

Mikko Perttunen (1):
      gpu: host1x: Select context device based on attached IOMMU

Mikulas Patocka (1):
      dm-verity: fix unreliable memory allocation

Ming Wang (1):
      irqchip/loongson-pch-lpc: Use legacy domain for PCH-LPC IRQ controller

Miroslav Lichvar (1):
      ptp: Limit time setting of PTP clocks

Nai-Chen Cheng (1):
      selftests/Makefile: include $(INSTALL_DEP_TARGETS) in clean target to clean net/lib dependency

Nam Cao (1):
      eventpoll: Replace rwlock with spinlock

Namjae Jeon (1):
      ksmbd: use sock_create_kern interface to create kernel socket

Naohiro Aota (1):
      btrfs: zoned: refine extent allocator hint selection

Nate Karstens (1):
      strparser: Fix signed/unsigned mismatch bug

Nathan Chancellor (1):
      lib/crypto: curve25519-hacl64: Fix older clang KASAN workaround for GCC

NeilBrown (1):
      nfsd: Replace clamp_t in nfsd4_get_drc_mem()

Nicolas Escande (1):
      wifi: ath11k: zero init info->status in wmi_process_mgmt_tx_comp()

Nicolas Ferre (2):
      ARM: at91: pm: save and restore ACR during PLL disable/enable
      clk: at91: clk-sam9x60-pll: force write to PLL_UPDT register

Niklas Cassel (1):
      ata: libata-scsi: Fix system suspend for a security locked drive

Niklas Schnelle (2):
      powerpc/eeh: Use result of error_detected() in uevent
      s390/pci: Use pci_uevent_ers() in PCI recovery

Niklas Söderlund (4):
      media: adv7180: Add missing lock in suspend callback
      media: adv7180: Do not write format to device in set_fmt
      media: adv7180: Only validate format in querystd
      net: sh_eth: Disable WoL if system can not suspend

Nikolay Aleksandrov (2):
      net: bridge: fix use-after-free due to MST port state bypass
      net: bridge: fix MST static key usage

Niravkumar L Rabara (3):
      EDAC/altera: Handle OCRAM ECC enable after warm reset
      EDAC/altera: Use INTTEST register for Ethernet and USB SBE injection
      mtd: rawnand: cadence: fix DMA device NULL pointer dereference

Nishanth Menon (1):
      net: ethernet: ti: netcp: Standardize knav_dma_open_channel to return NULL on error

Noorain Eqbal (1):
      bpf: Sync pending IRQ work before freeing ring buffer

Oleksandr Suvorov (1):
      USB: serial: ftdi_sio: add support for u-blox EVK-M101

Oleksij Rempel (1):
      net: dsa: microchip: lan937x: Fix RGMII delay tuning

Olga Kornievskaia (2):
      NFSv4: handle ERR_GRACE on delegation recalls
      NFSD: free copynotify stateid in nfs4_free_ol_stateid()

Ondrej Mosnacek (1):
      bpf: Do not audit capability check in do_jit()

Owen Gu (2):
      usb: gadget: f_fs: Fix epfile null pointer access after ep enable.
      usb: uas: fix urb unmapping issue when the uas device is remove during ongoing data transfer

Pablo Neira Ayuso (1):
      netfilter: nf_tables: reject duplicate device on updates

Pankaj Raghav (1):
      filemap: cap PTE range to be created to allowed zero fill in folio_map_range()

Paolo Abeni (8):
      mptcp: restore window probe
      mptcp: drop bogus optimization in __mptcp_check_push()
      mptcp: fix ack generation for fallback msk
      mptcp: fix premature close in case of fallback
      mptcp: avoid unneeded subflow-level drops
      mptcp: do not fallback when OoO is present
      mptcp: decouple mptcp fastclose from tcp close
      mptcp: fix duplicate reset on fastclose

Paul Kocialkowski (1):
      media: verisilicon: Explicitly disable selection api ioctls for decoders

Pauli Virtanen (5):
      Bluetooth: MGMT: cancel mesh send timer when hdev removed
      Bluetooth: 6lowpan: reset link-local header on ipv6 recv path
      Bluetooth: 6lowpan: fix BDADDR_LE vs ADDR_LE_DEV address type confusion
      Bluetooth: 6lowpan: Don't hold spin lock over sleeping functions
      Bluetooth: L2CAP: export l2cap_chan_hold for modules

Paulo Alcantara (1):
      smb: client: fix memory leak in cifs_construct_tcon()

Pavel Zhigulin (3):
      net: dsa: hellcreek: fix missing error handling in LED registration
      net: mlxsw: linecards: fix missing error check in mlxsw_linecard_devlink_info_get()
      net: qlogic/qede: fix potential out-of-bounds read in qede_tpa_cont() and qede_tpa_end()

Pedro Tammela (2):
      net/sched: act_connmark: transition to percpu stats and rcu
      net/sched: act_connmark: handle errno on tcf_idr_check_alloc

Peter Oberparleiter (1):
      gcov: add support for GCC 15

Peter Wang (2):
      scsi: ufs: host: mediatek: Change reset sequence for improved stability
      scsi: ufs: host: mediatek: Enhance recovery on resume failure

Peter Zijlstra (1):
      compiler_types: Move unused static inline functions warning to W=2

Petr Machata (1):
      net: bridge: Install FDB for bridge MAC on VLAN 0

Philipp Hortmann (1):
      staging: rtl8712: Remove driver using deprecated API wext

Philipp Stanner (1):
      drm/sched: Fix race in drm_sched_entity_select_rq()

Pierre Gondois (8):
      cacheinfo: Use RISC-V's init_cache_level() as generic OF implementation
      cacheinfo: Return error code in init_of_cache_level()
      cacheinfo: Check 'cache-unified' property to count cache leaves
      ACPI: PPTT: Remove acpi_find_cache_levels()
      ACPI: PPTT: Update acpi_find_last_cache_level() to acpi_get_cache_info()
      arch_topology: Build cacheinfo from primary CPU
      cacheinfo: Initialize variables in fetch_cache_info()
      arm64: tegra: Update cache properties

Po-Hsu Lin (1):
      selftests: net: use BASH for bareudp testing

Pranav Tyagi (1):
      futex: Don't leak robust_list pointer on exec race

Prateek Agarwal (1):
      drm/tegra: Add call to put_pid()

Qendrim Maxhuni (1):
      net: usb: qmi_wwan: initialize MAC header offset in qmimux_rx_fixup

Qianfeng Rong (2):
      scsi: pm8001: Use int instead of u32 to store error codes
      media: redrat3: use int type to store negative error codes

Qingfang Deng (1):
      6pack: drop redundant locking and refcounting

Qinxin Xia (1):
      dma-mapping: benchmark: Restore padding to ensure uABI remained consistent

Quan Zhou (1):
      wifi: mt76: mt7921: Add 160MHz beamformee capability for mt7922 device

Quanmin Yan (1):
      fbcon: Set fb_display[i]->mode to NULL when the mode is released

Rafael J. Wysocki (1):
      cpuidle: Fail cpuidle device registration if there is one already

Rafał Miłecki (1):
      bcma: don't register devices disabled in OF

Randall P. Embry (2):
      9p: fix /sys/fs/9p/caches overwriting itself
      9p: sysfs_init: don't hardcode error to ENOMEM

Ranganath V N (2):
      net: sched: act_connmark: initialize struct tc_ife to fix kernel leak
      net: sched: act_ife: initialize struct tc_ife to fix KMSAN kernel-infoleak

Ranjan Kumar (1):
      scsi: mpt3sas: Add support for 22.5 Gbps SAS link rate

Raphael Pinsonneault-Thibeault (2):
      Bluetooth: hci_event: validate skb length for unknown CC opcode
      Bluetooth: btusb: reorder cleanup in btusb_disconnect to avoid UAF

René Rebe (1):
      ALSA: usb-audio: fix uac2 clock source at terminal parser

Ricardo B. Marlière (2):
      selftests/bpf: Fix bpf_prog_detach2 usage in test_lirc_mode2
      selftests/bpf: Upon failures, exit with code 1 in test_xsk.sh

Richard Gobert (1):
      selftests/net: fix GRO coalesce test and add ext header coalesce tests

Robert Marko (1):
      net: ethernet: microchip: sparx5: make it selectable for ARCH_LAN969X

Rodrigo Gobbi (1):
      iio: adc: spear_adc: mask SPEAR_ADC_STATUS channel and avg sample before setting register

Rohan G Thomas (1):
      net: phy: marvell: Fix 88e1510 downshift counter errata

Rosen Penev (1):
      dmaengine: mv_xor: match alloc_wc and free_wc

Roy Vegard Ovesen (2):
      ALSA: usb-audio: fix control pipe direction
      ALSA: usb-audio: add mono main switch to Presonus S1824c

Russell King (Oracle) (1):
      net: dsa: sja1105: simplify static configuration reload

Ryan Chen (1):
      soc: aspeed: socinfo: Add AST27xx silicon IDs

Ryan Wanner (1):
      clk: at91: clk-master: Add check for divide by 3

Ryusuke Konishi (1):
      nilfs2: fix deadlock warnings caused by lock dependency in init_nilfs()

Sabrina Dubroca (1):
      espintcp: fix skb leaks

Sakari Ailus (1):
      ACPI: property: Return present device nodes only on fwnode interface

Saket Dumbre (1):
      ACPICA: Update dsmethod.c to get rid of unused variable warning

Sangwook Shin (1):
      watchdog: s3c2410_wdt: Fix max_timeout being calculated larger

Sarthak Garg (1):
      mmc: sdhci-msm: Enable tuning for SDR50 mode for SD card

Sascha Hauer (1):
      tools: lib: thermal: use pkg-config to locate libnl3

Sathishkumar S (1):
      drm/amdgpu/jpeg: Hold pg_lock before jpeg poweroff

Scott Mayhew (1):
      NFS: check if suid/sgid was cleared after a write as needed

Sean Heelan (1):
      ksmbd: fix use-after-free in session logoff

Seungjin Bae (2):
      Input: pegasus-notetaker - fix potential out-of-bounds access
      can: kvaser_usb: leaf: Fix potential infinite loop in command parsers

Seyediman Seyedarab (2):
      drm/nouveau: replace snprintf() with scnprintf() in nvkm_snprintbf()
      iommu/vt-d: Replace snprintf with scnprintf in dmar_latency_snapshot()

Shahar Shitrit (1):
      net: tls: Cancel RX async resync request on rcd_delta overflow

Shang song (Lenovo) (1):
      ACPI: PRM: Skip handlers with NULL handler_address or NULL VA

Sharique Mohammad (1):
      ASoC: max98090/91: fixed max98091 ALSA widget powering up/down

Shaurya Rane (1):
      jfs: fix uninitialized waitqueue in transaction manager

Shawn Lin (1):
      mmc: sdhci-of-dwcmshc: Change DLL_STRBIN_TAPNUM_DEFAULT to 0x4

Shengjiu Wang (1):
      ASoC: fsl_sai: fix bit order for DSD format

Shin'ichiro Kawasaki (1):
      nvme-multipath: fix lockdep WARN due to partition scan work

Shuai Xue (1):
      acpi,srat: Fix incorrect device handle check for Generic Initiator

Shuhao Fu (1):
      smb: client: fix refcount leak in smb2_set_path_attr

Srinivas Kandagatla (1):
      ASoC: qdsp6: q6asm: do not sleep while atomic

Srinivasan Shanmugam (1):
      drm/amdgpu: Fix function header names in amdgpu_connectors.c

Stefan Wahren (1):
      ethernet: Extend device_get_mac_address() to use NVMEM

Stefan Wiehler (3):
      sctp: Hold RCU read lock while iterating over address list
      sctp: Prevent TOCTOU out-of-bounds write
      sctp: Hold sock lock while iterating over address list

Stephan Gerhold (1):
      remoteproc: qcom: q6v5: Avoid handling handover twice

Steve French (1):
      cifs: fix typo in enable_gcm_256 module parameter

Sudeep Holla (4):
      pmdomain: arm: scmi: Fix genpd leak on provider registration failure
      ACPI: PCC: Add PCC shared memory region command and status bitfields
      mailbox: pcc: Refactor error handling in irq handler into separate function
      i2c: xgene-slimpro: Migrate to use generic PCC shmem related macros

Sumanth Gavini (1):
      softirq: Add trace points for tasklet entry/exit

Sungho Kim (1):
      PCI/P2PDMA: Fix incorrect pointer usage in devm_kfree() call

Svyatoslav Ryhel (1):
      video: backlight: lp855x_bl: Set correct EPROM start for LP8556

Takashi Iwai (3):
      ALSA: usb-audio: Add validation of UAC2/UAC3 effect units
      ALSA: usb-audio: Fix potential overflow of PCM transfer buffer
      ALSA: usb-audio: Fix missing unlock at error path of maxpacksize check

Tetsuo Handa (3):
      media: imon: make send_packet() more robust
      ntfs3: pretend $Extend records as regular files
      jfs: Verify inode mode when loading from disk

Thomas Andreatta (1):
      dmaengine: sh: setup_xref error handling

Thomas Bogendoerfer (1):
      MIPS: mm: kmalloc tlb_vpn array to avoid stack overflow

Thomas Mühlbacher (1):
      can: sja1000: fix max irq loop handling

Thomas Weißschuh (4):
      spi: loopback-test: Don't use %pK through printk
      soc: ti: pruss: don't use %pK through printk
      bpf: Don't use %pK through printk
      ice: Don't use %pK through printk or tracepoints

Thomas Zimmermann (1):
      drm/sysfb: Do not dereference NULL pointer in plane reset

Thorsten Blum (1):
      btrfs: scrub: replace max_t()/min_t() with clamp() in scrub_throttle_dev_io()

Théo Lebrun (1):
      net: macb: avoid dealing with endianness in macb_set_hwaddr()

Tianchu Chen (1):
      usb: storage: sddr55: Reject out-of-bound new_pba

Tianyang Zhang (1):
      LoongArch: Let {pte,pmd}_modify() record the status of _PAGE_DIRTY

Tiezhu Yang (2):
      net: stmmac: Check stmmac_hw_setup() in stmmac_resume()
      asm-generic: Unify uapi bitsperlong.h for arm64, riscv and loongarch

Timur Kristóf (2):
      drm/amdgpu: Respect max pixel clock for HDMI and DVI-D (v2)
      drm/amd/pm: Disable MCLK switching on SI at high pixel clocks

Tiwei Bie (1):
      um: Fix help message for ssl-non-raw

Tom Stellard (1):
      bpftool: Fix -Wuninitialized-const-pointer warnings with clang >= 21

Tomeu Vizoso (1):
      drm/etnaviv: fix flush sequence logic

Tomi Valkeinen (1):
      drm/tidss: Use the crtc_* timings when programming the HW

Tristan Lobb (1):
      HID: quirks: avoid Cooler Master MM712 dongle wakeup bug

Tristram Ha (1):
      net: dsa: microchip: Fix reserved multicast address table programming

Trond Myklebust (1):
      NFSv4: Fix an incorrect parameter when calling nfs4_call_sync()

Tvrtko Ursulin (1):
      drm/amdgpu: Use memdup_array_user in amdgpu_cs_wait_fences_ioctl

Tzung-Bi Shih (1):
      Input: cros_ec_keyb - fix an invalid memory access

Uday M Bhat (1):
      xhci: dbc: Allow users to modify DbC poll interval via sysfs

Ujwal Kundur (1):
      rds: Fix endianness annotation for RDS_MPATH_HASH

Umesh Nerlige Ramappa (1):
      drm/i915: Fix conversion between clock ticks and nanoseconds

Uwe Kleine-König (1):
      usb: renesas_usbhs: Convert to platform remove callback returning void

Valek Andrej (1):
      iio: accel: fix ADXL355 startup race condition

Valerio Setti (1):
      ASoC: meson: aiu-encoder-i2s: fix bit clock polarity

Vanillan Wang (1):
      USB: serial: option: add support for Rolling RW101R-GL

Viacheslav Dubeyko (1):
      ceph: add checking of wait_for_completion_killable() return value

Vladimir Oltean (1):
      net: dsa: sja1105: fix SGMII linking at 10M or 100M but not passing traffic

Vladimir Riabchun (1):
      ftrace: Fix softlockup in ftrace_module_enable

Vladimir Zapolskiy (1):
      media: i2c: og01a1b: Specify monochrome media bus format instead of Bayer

Vlastimil Babka (1):
      mm/mempool: fix poisoning order>0 pages with HIGHMEM

Wake Liu (2):
      selftests/net: Replace non-standard __WORDSIZE with sizeof(long) * 8
      selftests/net: Ensure assert() triggers in psock_tpacket.c

Wang Liang (1):
      selftests: netdevsim: Fix ethtool-coalesce.sh fail by installing ethtool-common.sh

Wei Fang (1):
      net: fec: correct rx_bytes statistic for the case SHIFT16 is set

Wei Yang (1):
      fs/proc: fix uaf in proc_readdir_de()

William Wu (1):
      usb: gadget: f_hid: Fix zero length packet transfer

Wonkon Kim (1):
      scsi: ufs: core: Initialize value of an attribute returned by uic cmd

Xiang Mei (1):
      net/sched: sch_qfq: Fix null-deref in agg_dequeue

Xu Yang (1):
      dt-bindings: usb: dwc3-imx8mp: dma-range is required only for imx8mp

Yafang Shao (1):
      net/cls_cgroup: Fix task_get_classid() during qdisc run

Yang Wang (1):
      drm/amd/pm: fix smu table id bound check issue in smu_cmn_update_table()

Yicong Yang (1):
      cacheinfo: Fix LLC is not exported through sysfs

Yifan Zha (1):
      drm/amdgpu: Skip emit de meta data on gfx11 with rs64 enabled

Yihang Li (1):
      ata: libata-scsi: Add missing scsi_device_put() in ata_scsi_dev_rescan()

Yikang Yue (1):
      fs/hpfs: Fix error code for new_inode() failure in mkdir/create/mknod/symlink

Yipeng Zou (1):
      timers: Fix NULL function pointer race in timer_shutdown_sync()

Yongpeng Yang (1):
      exfat: check return value of sb_min_blocksize in exfat_read_boot_sector

Yosry Ahmed (1):
      KVM: SVM: Mark VMCB_LBR dirty when MSR_IA32_DEBUGCTLMSR is updated

Yue Haibing (1):
      ipv6: Add sanity checks on ipv6_devconf.rpl_seg_enabled

Yuhao Jiang (1):
      ACPI: video: Fix use-after-free in acpi_video_switch_brightness()

Yuta Hayama (1):
      rtc: rx8025: fix incorrect register reference

Zhang Chujun (1):
      tracing/tools: Fix incorrcet short option in usage text for --threads

Zhang Heng (1):
      HID: quirks: work around VID/PID conflict for 0x4c4a/0x4155

ZhangGuoDong (2):
      smb/server: fix possible memory leak in smb2_read()
      smb/server: fix possible refcount leak in smb2_sess_setup()

Zijun Hu (1):
      char: misc: Does not request module for miscdevice with dynamic minor

Zilin Guan (2):
      tracing: Fix memory leaks in create_field_var()
      mlxsw: spectrum: Fix memory leak in mlxsw_sp_flower_stats()

austinchang (1):
      btrfs: mark dirty extent range for out of bound prealloc extents

chuguangqing (1):
      fs: ext4: change GFP_KERNEL to GFP_NOFS to avoid deadlock

luoguangfei (1):
      net: macb: fix unregister_netdev call order in macb_remove()

raub camaioni (1):
      usb: gadget: f_ncm: Fix MAC assignment NCM ethernet

wenglianfa (1):
      RDMA/hns: Fix the modification of max_send_sge

ziming zhang (2):
      libceph: prevent potential out-of-bounds writes in handle_auth_session_key()
      libceph: replace BUG_ON with bounds check for map->max_osd

Łukasz Bartosik (1):
      xhci: dbgtty: fix device unregister


