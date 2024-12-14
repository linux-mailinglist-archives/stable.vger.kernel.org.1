Return-Path: <stable+bounces-104212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2D39F20E0
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 22:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149161885989
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 21:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18251AB500;
	Sat, 14 Dec 2024 21:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W/11oRPJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773E119D07C;
	Sat, 14 Dec 2024 21:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734210118; cv=none; b=Wj6OcvmOzFP52AyId2c8tehgJyhHWOAa8xr6aWyWpBPITZmI1kaCKVBdVO6ZwJaI4yQ7sr/EE69j/dvoHkCcz9eVxUkz0FN9084viOUyLNRkgKha77416YSleKnx0f6U0BZe7HLg+vQR4AYq2jkO4yr4qJ6qhnKUK52lHvtO3d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734210118; c=relaxed/simple;
	bh=IqMPiBLwRaQJTxZ6CvvNOn+0azxoHQWLcxbyVqcCoQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tuwZEKSifJ3sjG16wxZhHtZ/AxxVMlYWMVTCJ1y48c4ZjRMZIPn3IdPu0GGqyDP0u6gkw6fpwsmJM8ISO9yCXc9ltBj/m73o4S8PvMDMiz0kB3ULAd9WmWGEecWO9P0cD0AWZ78THRmeYPmYwUFVXbCxrtA6kbyJKBQIWP/+9FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W/11oRPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4503BC4CED1;
	Sat, 14 Dec 2024 21:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734210118;
	bh=IqMPiBLwRaQJTxZ6CvvNOn+0azxoHQWLcxbyVqcCoQ4=;
	h=From:To:Cc:Subject:Date:From;
	b=W/11oRPJIBFq2uQofHBp6ncTyijUXjbLeS7S+/RVsMlsxAvju3ddU4QuJ/RMkrnzD
	 yKq7yES0/FkNWFzSUQC8q1hzneB7eWoJjymYui4MnpOrZ6yfNz3dYbS+Z4ZpLeLzrn
	 0JGKdAdEig6CYMvbwpmToFn9TQbftiwlSjJDU5AQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.5
Date: Sat, 14 Dec 2024 22:01:47 +0100
Message-ID: <2024121448-crevice-karate-9c16@gregkh>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 1651
X-Developer-Signature: v=1; a=openpgp-sha256; l=84045; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=IqMPiBLwRaQJTxZ6CvvNOn+0azxoHQWLcxbyVqcCoQ4=; b=owGbwMvMwCRo6H6F97bub03G02pJDOmxn2zrJNoPl92Xf6SqL6C2LGGpXONSJ9tXH2ZNcAv6w LZ68se6jhgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZiIQAbDXLkp5jvY1cLizt38 /uyw7Wxb7qoJXAzTg+offipi9Aq8pLF3+0fZJ/FHKr4CAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.5 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-bus-pci                                    |   11 
 Documentation/ABI/testing/sysfs-fs-f2fs                                    |    6 
 Documentation/accel/qaic/aic080.rst                                        |   14 
 Documentation/accel/qaic/index.rst                                         |    1 
 Documentation/arch/arm64/silicon-errata.rst                                |    2 
 Documentation/i2c/busses/i2c-i801.rst                                      |    1 
 Documentation/netlink/specs/ethtool.yaml                                   |    7 
 Makefile                                                                   |    3 
 arch/arm64/Kconfig                                                         |   11 
 arch/arm64/kernel/ptrace.c                                                 |   10 
 arch/arm64/mm/context.c                                                    |    4 
 arch/arm64/mm/init.c                                                       |   17 
 arch/loongarch/include/asm/hugetlb.h                                       |   10 
 arch/loongarch/kvm/vcpu.c                                                  |    4 
 arch/loongarch/mm/tlb.c                                                    |    2 
 arch/mips/boot/dts/loongson/ls7a-pch.dtsi                                  |   73 
 arch/powerpc/kernel/prom_init.c                                            |   29 
 arch/riscv/configs/defconfig                                               |    1 
 arch/s390/include/asm/pci.h                                                |   14 
 arch/s390/include/asm/pci_clp.h                                            |    8 
 arch/s390/kernel/perf_cpum_sf.c                                            |    4 
 arch/s390/pci/pci.c                                                        |   88 
 arch/s390/pci/pci_bus.c                                                    |   48 
 arch/s390/pci/pci_clp.c                                                    |   17 
 arch/s390/pci/pci_event.c                                                  |   19 
 arch/x86/Kconfig                                                           |    1 
 arch/x86/events/amd/core.c                                                 |   10 
 arch/x86/include/asm/pgtable_types.h                                       |    8 
 arch/x86/kernel/cpu/amd.c                                                  |    2 
 arch/x86/kernel/cpu/cacheinfo.c                                            |   43 
 arch/x86/kernel/cpu/intel.c                                                |    4 
 arch/x86/kernel/cpu/topology.c                                             |    6 
 arch/x86/kernel/fpu/signal.c                                               |   20 
 arch/x86/kernel/fpu/xstate.h                                               |   27 
 arch/x86/kernel/relocate_kernel_64.S                                       |    8 
 arch/x86/kvm/mmu/mmu.c                                                     |   10 
 arch/x86/kvm/mmu/paging_tmpl.h                                             |    5 
 arch/x86/mm/ident_map.c                                                    |    6 
 arch/x86/mm/pti.c                                                          |    2 
 arch/x86/pci/acpi.c                                                        |  119 
 block/blk-zoned.c                                                          |   43 
 crypto/ecdsa.c                                                             |   19 
 drivers/accel/qaic/qaic_drv.c                                              |    4 
 drivers/acpi/video_detect.c                                                |   16 
 drivers/acpi/x86/utils.c                                                   |   79 
 drivers/base/arch_numa.c                                                   |    4 
 drivers/base/cacheinfo.c                                                   |   14 
 drivers/base/regmap/internal.h                                             |    1 
 drivers/base/regmap/regcache-maple.c                                       |    3 
 drivers/base/regmap/regmap.c                                               |   13 
 drivers/block/zram/zram_drv.c                                              |   27 
 drivers/bluetooth/btusb.c                                                  |   26 
 drivers/clk/clk-en7523.c                                                   |    4 
 drivers/clk/qcom/Kconfig                                                   |    4 
 drivers/clk/qcom/clk-alpha-pll.c                                           |   11 
 drivers/clk/qcom/clk-alpha-pll.h                                           |    1 
 drivers/clk/qcom/clk-rcg.h                                                 |    1 
 drivers/clk/qcom/clk-rcg2.c                                                |   48 
 drivers/clk/qcom/clk-rpmh.c                                                |   13 
 drivers/clk/qcom/dispcc-sm8550.c                                           |   18 
 drivers/clk/qcom/tcsrcc-sm8550.c                                           |   18 
 drivers/dma-buf/dma-fence-array.c                                          |   28 
 drivers/dma-buf/dma-fence-unwrap.c                                         |  126 
 drivers/firmware/qcom/qcom_scm.c                                           |    2 
 drivers/gpio/gpio-grgpio.c                                                 |   26 
 drivers/gpio/gpiolib.c                                                     |   41 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                                   |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                 |   48 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                                    |    5 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                                      |   12 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0_cleaner_shader.h                       |   44 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2_cleaner_shader.asm                   |  153 
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c                                      |   12 
 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c                                      |    7 
 drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c                                      |    6 
 drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c                                      |    6 
 drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c                                      |    6 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c                                    |   30 
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c                                     |   27 
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c                                      |    6 
 drivers/gpu/drm/amd/amdkfd/kfd_device.c                                    |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                          |   25 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c               |   17 
 drivers/gpu/drm/amd/display/dc/core/dc.c                                   |   18 
 drivers/gpu/drm/amd/display/dc/core/dc_debug.c                             |   40 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c                          |   57 
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c                            |    6 
 drivers/gpu/drm/amd/display/dc/dc.h                                        |    3 
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c                               |    6 
 drivers/gpu/drm/amd/display/dc/dio/dcn314/dcn314_dio_stream_encoder.c      |   10 
 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c                    |    1 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c       |   29 
 drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c                  |   20 
 drivers/gpu/drm/amd/display/dc/inc/core_status.h                           |    2 
 drivers/gpu/drm/amd/display/dc/inc/core_types.h                            |    1 
 drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c             |   23 
 drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c             |    2 
 drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c             |    1 
 drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c           |    1 
 drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c           |    1 
 drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c             |    7 
 drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h             |    3 
 drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c           |    1 
 drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c           |    1 
 drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c           |    1 
 drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c             |    1 
 drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c           |    1 
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c             |    2 
 drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c           |    2 
 drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c           |    1 
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h                            |    3 
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c                    |   13 
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                                         |    6 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                                  |  150 
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h                              |   15 
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c                          |  166 
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c                            |  167 
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c                    |  168 
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c                           |   41 
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c                            |   43 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c                       |  167 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c                       |  138 
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c                       |  168 
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                                     |   25 
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h                                     |    4 
 drivers/gpu/drm/bridge/ite-it6505.c                                        |    1 
 drivers/gpu/drm/display/drm_dp_dual_mode_helper.c                          |    4 
 drivers/gpu/drm/display/drm_dp_mst_topology.c                              |   55 
 drivers/gpu/drm/drm_panel_orientation_quirks.c                             |   18 
 drivers/gpu/drm/drm_panic.c                                                |   10 
 drivers/gpu/drm/mcde/mcde_drv.c                                            |    1 
 drivers/gpu/drm/panel/panel-simple.c                                       |   28 
 drivers/gpu/drm/radeon/r600_cs.c                                           |    2 
 drivers/gpu/drm/scheduler/sched_main.c                                     |    8 
 drivers/gpu/drm/sti/sti_mixer.c                                            |    2 
 drivers/gpu/drm/v3d/v3d_perfmon.c                                          |    2 
 drivers/gpu/drm/vc4/vc4_hdmi.c                                             |    2 
 drivers/gpu/drm/vc4/vc4_hvs.c                                              |   11 
 drivers/gpu/drm/xe/regs/xe_engine_regs.h                                   |    1 
 drivers/gpu/drm/xe/regs/xe_gt_regs.h                                       |    3 
 drivers/gpu/drm/xe/xe_devcoredump.c                                        |  146 
 drivers/gpu/drm/xe/xe_devcoredump.h                                        |    6 
 drivers/gpu/drm/xe/xe_devcoredump_types.h                                  |    3 
 drivers/gpu/drm/xe/xe_device.c                                             |    1 
 drivers/gpu/drm/xe/xe_force_wake.h                                         |   16 
 drivers/gpu/drm/xe/xe_gt_topology.c                                        |   14 
 drivers/gpu/drm/xe/xe_guc_ct.c                                             |   18 
 drivers/gpu/drm/xe/xe_guc_log.c                                            |   40 
 drivers/gpu/drm/xe/xe_guc_submit.c                                         |    2 
 drivers/gpu/drm/xe/xe_hw_engine.c                                          |    1 
 drivers/gpu/drm/xe/xe_pci.c                                                |    2 
 drivers/gpu/drm/xe/xe_query.c                                              |   42 
 drivers/gpu/drm/xe/xe_wa.c                                                 |   47 
 drivers/gpu/drm/xe/xe_wa_oob.rules                                         |    2 
 drivers/hid/hid-core.c                                                     |    5 
 drivers/hid/hid-generic.c                                                  |    3 
 drivers/hid/hid-ids.h                                                      |    1 
 drivers/hid/hid-magicmouse.c                                               |   56 
 drivers/hid/i2c-hid/i2c-hid-core.c                                         |   20 
 drivers/hid/wacom_sys.c                                                    |    3 
 drivers/hwmon/nct6775-platform.c                                           |    2 
 drivers/i2c/busses/Kconfig                                                 |    1 
 drivers/i2c/busses/i2c-i801.c                                              |    6 
 drivers/i3c/master.c                                                       |   85 
 drivers/i3c/master/mipi-i3c-hci/dma.c                                      |    2 
 drivers/iio/adc/ad7192.c                                                   |    3 
 drivers/iio/light/ltr501.c                                                 |    2 
 drivers/iio/magnetometer/af8133j.c                                         |    3 
 drivers/iio/magnetometer/yamaha-yas530.c                                   |   13 
 drivers/iommu/amd/io_pgtable.c                                             |   11 
 drivers/iommu/iommufd/fault.c                                              |    2 
 drivers/irqchip/Kconfig                                                    |    2 
 drivers/irqchip/irq-gic-v3-its.c                                           |   50 
 drivers/leds/led-class.c                                                   |   14 
 drivers/mailbox/pcc.c                                                      |   61 
 drivers/md/bcache/super.c                                                  |    2 
 drivers/media/pci/intel/ipu6/Kconfig                                       |    2 
 drivers/media/pci/intel/ipu6/ipu6-isys-queue.c                             |   66 
 drivers/media/pci/intel/ipu6/ipu6-isys-queue.h                             |    1 
 drivers/media/pci/intel/ipu6/ipu6-isys.c                                   |   19 
 drivers/media/usb/cx231xx/cx231xx-cards.c                                  |    2 
 drivers/media/usb/uvc/uvc_driver.c                                         |   31 
 drivers/misc/eeprom/eeprom_93cx6.c                                         |   10 
 drivers/mmc/core/block.c                                                   |   26 
 drivers/mmc/core/bus.c                                                     |    6 
 drivers/mmc/core/card.h                                                    |   10 
 drivers/mmc/core/core.c                                                    |    3 
 drivers/mmc/core/quirks.h                                                  |    9 
 drivers/mmc/core/sd.c                                                      |   30 
 drivers/mmc/core/sd.h                                                      |    2 
 drivers/mmc/core/sdio.c                                                    |    2 
 drivers/mmc/host/mtk-sd.c                                                  |   64 
 drivers/mmc/host/sdhci-esdhc-imx.c                                         |    6 
 drivers/mmc/host/sdhci-pci-core.c                                          |   72 
 drivers/mmc/host/sdhci-pci.h                                               |    1 
 drivers/net/can/c_can/c_can_main.c                                         |   26 
 drivers/net/can/dev/dev.c                                                  |    2 
 drivers/net/can/ifi_canfd/ifi_canfd.c                                      |   58 
 drivers/net/can/m_can/m_can.c                                              |   33 
 drivers/net/can/sja1000/sja1000.c                                          |   67 
 drivers/net/can/spi/hi311x.c                                               |   50 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c                              |   29 
 drivers/net/can/sun4i_can.c                                                |   22 
 drivers/net/can/usb/ems_usb.c                                              |   58 
 drivers/net/can/usb/f81604.c                                               |   10 
 drivers/net/can/usb/gs_usb.c                                               |   25 
 drivers/net/dsa/qca/qca8k-8xxx.c                                           |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c                          |    8 
 drivers/net/ethernet/freescale/enetc/enetc.c                               |    3 
 drivers/net/ethernet/freescale/fec_mpc52xx_phy.c                           |    2 
 drivers/net/ethernet/freescale/fman/fman.c                                 |    1 
 drivers/net/ethernet/freescale/fman/fman.h                                 |    3 
 drivers/net/ethernet/freescale/fman/mac.c                                  |    5 
 drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c                       |    2 
 drivers/net/ethernet/intel/ice/ice_common.c                                |   25 
 drivers/net/ethernet/intel/ice/ice_main.c                                  |    8 
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c                                |    3 
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h                                |    5 
 drivers/net/ethernet/intel/idpf/idpf_txrx.c                                |    1 
 drivers/net/ethernet/intel/igb/igb_main.c                                  |    4 
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.h                            |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h                               |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c                             |    2 
 drivers/net/ethernet/intel/ixgbevf/ipsec.c                                 |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c                  |   13 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                          |   32 
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c                          |    7 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc_complex.c |    2 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c        |    1 
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c                   |    6 
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h                   |    2 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c               |   72 
 drivers/net/ethernet/microsoft/mana/mana_en.c                              |    1 
 drivers/net/ethernet/qlogic/qed/qed_mcp.c                                  |    4 
 drivers/net/ethernet/realtek/r8169_main.c                                  |   14 
 drivers/net/ethernet/rocker/rocker_main.c                                  |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h                               |    5 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c                           |    5 
 drivers/net/geneve.c                                                       |    2 
 drivers/net/phy/microchip.c                                                |   21 
 drivers/net/phy/sfp.c                                                      |    3 
 drivers/net/virtio_net.c                                                   |   12 
 drivers/net/wireless/ath/ath10k/sdio.c                                     |    6 
 drivers/net/wireless/ath/ath12k/mac.c                                      |   18 
 drivers/net/wireless/ath/ath5k/pci.c                                       |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c                  |    2 
 drivers/net/wireless/intel/ipw2x00/libipw_rx.c                             |    8 
 drivers/net/wireless/realtek/rtw88/sdio.c                                  |    6 
 drivers/net/wireless/realtek/rtw88/usb.c                                   |    5 
 drivers/net/wireless/realtek/rtw89/fw.c                                    |    3 
 drivers/nvdimm/dax_devs.c                                                  |    4 
 drivers/nvdimm/nd.h                                                        |    7 
 drivers/nvme/host/core.c                                                   |   25 
 drivers/nvme/host/rdma.c                                                   |    8 
 drivers/nvme/host/tcp.c                                                    |    2 
 drivers/pci/controller/dwc/pcie-qcom.c                                     |    1 
 drivers/pci/controller/plda/pcie-starfive.c                                |   10 
 drivers/pci/controller/vmd.c                                               |   17 
 drivers/pci/pci-sysfs.c                                                    |   26 
 drivers/pci/pci.c                                                          |    2 
 drivers/pci/pci.h                                                          |    1 
 drivers/pci/probe.c                                                        |   30 
 drivers/pci/quirks.c                                                       |   15 
 drivers/pinctrl/core.c                                                     |    3 
 drivers/pinctrl/core.h                                                     |    1 
 drivers/pinctrl/freescale/Kconfig                                          |    2 
 drivers/pinctrl/pinmux.c                                                   |  173 
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c                                   |    2 
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c                                    |    1 
 drivers/platform/x86/asus-wmi.c                                            |   11 
 drivers/pmdomain/core.c                                                    |   37 
 drivers/pmdomain/imx/gpcv2.c                                               |    2 
 drivers/ptp/ptp_clock.c                                                    |    3 
 drivers/regulator/qcom-rpmh-regulator.c                                    |   83 
 drivers/remoteproc/qcom_q6v5_pas.c                                         |    1 
 drivers/rtc/rtc-cmos.c                                                     |   31 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                                     |  100 
 drivers/scsi/lpfc/lpfc_ct.c                                                |   21 
 drivers/scsi/lpfc/lpfc_hbadisc.c                                           |   36 
 drivers/scsi/lpfc/lpfc_init.c                                              |    2 
 drivers/scsi/lpfc/lpfc_sli.c                                               |   41 
 drivers/scsi/qla2xxx/qla_attr.c                                            |    1 
 drivers/scsi/qla2xxx/qla_bsg.c                                             |  124 
 drivers/scsi/qla2xxx/qla_mid.c                                             |    1 
 drivers/scsi/qla2xxx/qla_os.c                                              |   15 
 drivers/scsi/scsi_debug.c                                                  |    2 
 drivers/scsi/sg.c                                                          |    2 
 drivers/scsi/st.c                                                          |   31 
 drivers/soc/imx/soc-imx8m.c                                                |  107 
 drivers/soc/qcom/llcc-qcom.c                                               | 2644 +++
 drivers/soc/qcom/qcom_pd_mapper.c                                          |    1 
 drivers/spi/spi-fsl-lpspi.c                                                |    7 
 drivers/spi/spi-mpc52xx.c                                                  |    1 
 drivers/thermal/qcom/tsens-v1.c                                            |   21 
 drivers/thermal/qcom/tsens.c                                               |    3 
 drivers/thermal/qcom/tsens.h                                               |    2 
 drivers/tty/serial/8250/8250_dw.c                                          |    5 
 drivers/ufs/core/ufs-sysfs.c                                               |    6 
 drivers/ufs/core/ufs_bsg.c                                                 |    2 
 drivers/ufs/core/ufshcd-priv.h                                             |    1 
 drivers/ufs/core/ufshcd.c                                                  |   59 
 drivers/ufs/host/cdns-pltfrm.c                                             |    4 
 drivers/ufs/host/tc-dwc-g210-pltfrm.c                                      |    5 
 drivers/ufs/host/ufs-exynos.c                                              |    3 
 drivers/ufs/host/ufs-hisi.c                                                |    4 
 drivers/ufs/host/ufs-mediatek.c                                            |    5 
 drivers/ufs/host/ufs-qcom.c                                                |    7 
 drivers/ufs/host/ufs-renesas.c                                             |   13 
 drivers/ufs/host/ufs-sprd.c                                                |    5 
 drivers/ufs/host/ufshcd-pltfrm.c                                           |   16 
 drivers/ufs/host/ufshcd-pltfrm.h                                           |    1 
 drivers/usb/chipidea/ci.h                                                  |    2 
 drivers/usb/chipidea/ci_hdrc_imx.c                                         |    1 
 drivers/usb/chipidea/core.c                                                |    2 
 drivers/usb/chipidea/udc.c                                                 |  156 
 drivers/usb/chipidea/udc.h                                                 |    2 
 drivers/usb/typec/ucsi/ucsi_acpi.c                                         |   56 
 drivers/usb/typec/ucsi/ucsi_glink.c                                        |   10 
 drivers/vfio/pci/mlx5/cmd.c                                                |   47 
 drivers/virt/coco/pkvm-guest/arm-pkvm-guest.c                              |    6 
 drivers/watchdog/apple_wdt.c                                               |    2 
 drivers/watchdog/iTCO_wdt.c                                                |   21 
 drivers/watchdog/mtk_wdt.c                                                 |    6 
 drivers/watchdog/rti_wdt.c                                                 |    3 
 drivers/watchdog/xilinx_wwdt.c                                             |   75 
 fs/btrfs/dev-replace.c                                                     |    2 
 fs/btrfs/disk-io.c                                                         |    3 
 fs/btrfs/disk-io.h                                                         |    3 
 fs/btrfs/fs.h                                                              |    2 
 fs/btrfs/inode.c                                                           |    1 
 fs/btrfs/super.c                                                           |   73 
 fs/btrfs/volumes.c                                                         |  137 
 fs/dlm/lock.c                                                              |   10 
 fs/eventpoll.c                                                             |    6 
 fs/ext4/extents.c                                                          |    7 
 fs/ext4/inode.c                                                            |   51 
 fs/f2fs/data.c                                                             |   82 
 fs/f2fs/extent_cache.c                                                     |   74 
 fs/f2fs/f2fs.h                                                             |    4 
 fs/f2fs/inode.c                                                            |    4 
 fs/f2fs/node.c                                                             |    7 
 fs/f2fs/sysfs.c                                                            |   10 
 fs/gfs2/super.c                                                            |    2 
 fs/jffs2/compr_rtime.c                                                     |    3 
 fs/jfs/jfs_dmap.c                                                          |    6 
 fs/jfs/jfs_dtree.c                                                         |   15 
 fs/nilfs2/dir.c                                                            |    2 
 fs/notify/fanotify/fanotify_user.c                                         |   85 
 fs/ntfs3/attrib.c                                                          |    9 
 fs/ntfs3/frecord.c                                                         |  103 
 fs/ntfs3/ntfs_fs.h                                                         |    3 
 fs/ntfs3/run.c                                                             |   40 
 fs/ocfs2/dlmglue.c                                                         |    1 
 fs/ocfs2/localalloc.c                                                      |   19 
 fs/ocfs2/namei.c                                                           |    4 
 fs/smb/client/cifsproto.h                                                  |    1 
 fs/smb/client/cifssmb.c                                                    |    2 
 fs/smb/client/connect.c                                                    |    4 
 fs/smb/client/dfs.c                                                        |  188 
 fs/smb/client/inode.c                                                      |   94 
 fs/smb/client/readdir.c                                                    |   54 
 fs/smb/client/reparse.c                                                    |   84 
 fs/smb/client/smb2inode.c                                                  |    3 
 fs/smb/server/smb2pdu.c                                                    |    6 
 fs/unicode/mkutf8data.c                                                    |   70 
 fs/unicode/utf8data.c_shipped                                              | 6703 +++++-----
 include/acpi/pcc.h                                                         |    7 
 include/drm/display/drm_dp_mst_helper.h                                    |    7 
 include/drm/intel/xe_pciids.h                                              |   31 
 include/linux/blkdev.h                                                     |    2 
 include/linux/bpf.h                                                        |   17 
 include/linux/cleanup.h                                                    |   52 
 include/linux/clocksource.h                                                |    2 
 include/linux/eeprom_93cx6.h                                               |   11 
 include/linux/eventpoll.h                                                  |    2 
 include/linux/f2fs_fs.h                                                    |    1 
 include/linux/fanotify.h                                                   |    1 
 include/linux/hid.h                                                        |    2 
 include/linux/i3c/master.h                                                 |    9 
 include/linux/io_uring/cmd.h                                               |    4 
 include/linux/leds.h                                                       |    2 
 include/linux/mmc/card.h                                                   |    3 
 include/linux/mmc/sd.h                                                     |    1 
 include/linux/page-flags.h                                                 |    4 
 include/linux/pci.h                                                        |    6 
 include/linux/scatterlist.h                                                |    2 
 include/linux/stackdepot.h                                                 |    6 
 include/linux/timekeeper_internal.h                                        |   15 
 include/linux/usb/chipidea.h                                               |    1 
 include/net/bluetooth/hci.h                                                |   14 
 include/net/bluetooth/hci_core.h                                           |   10 
 include/net/netfilter/nf_tables_core.h                                     |    1 
 include/net/tcp_ao.h                                                       |    3 
 include/sound/soc_sdw_utils.h                                              |    2 
 include/trace/events/damon.h                                               |    2 
 include/trace/trace_events.h                                               |   36 
 include/uapi/drm/xe_drm.h                                                  |    4 
 include/uapi/linux/fanotify.h                                              |    1 
 include/ufs/ufshcd.h                                                       |   19 
 io_uring/tctx.c                                                            |   13 
 io_uring/uring_cmd.c                                                       |    2 
 kernel/bpf/arraymap.c                                                      |   26 
 kernel/bpf/core.c                                                          |    1 
 kernel/bpf/devmap.c                                                        |    6 
 kernel/bpf/hashtab.c                                                       |   56 
 kernel/bpf/lpm_trie.c                                                      |   55 
 kernel/bpf/syscall.c                                                       |   29 
 kernel/bpf/trampoline.c                                                    |   47 
 kernel/bpf/verifier.c                                                      |   15 
 kernel/dma/debug.c                                                         |    8 
 kernel/kcsan/debugfs.c                                                     |   74 
 kernel/sched/core.c                                                        |    4 
 kernel/sched/deadline.c                                                    |    1 
 kernel/sched/ext.c                                                         |    9 
 kernel/sched/fair.c                                                        |   14 
 kernel/sched/syscalls.c                                                    |    2 
 kernel/softirq.c                                                           |   15 
 kernel/time/Kconfig                                                        |    5 
 kernel/time/clocksource.c                                                  |   11 
 kernel/time/ntp.c                                                          |    2 
 kernel/time/timekeeping.c                                                  |  114 
 kernel/time/timekeeping_internal.h                                         |   15 
 kernel/trace/ring_buffer.c                                                 |   98 
 kernel/trace/trace.c                                                       |   33 
 kernel/trace/trace.h                                                       |    7 
 kernel/trace/trace_clock.c                                                 |    2 
 kernel/trace/trace_eprobe.c                                                |    5 
 kernel/trace/trace_output.c                                                |    4 
 kernel/trace/trace_syscalls.c                                              |   12 
 kernel/trace/tracing_map.c                                                 |    6 
 lib/Kconfig.debug                                                          |   13 
 lib/stackdepot.c                                                           |   10 
 lib/stackinit_kunit.c                                                      |    1 
 mm/debug.c                                                                 |    7 
 mm/gup.c                                                                   |   11 
 mm/kasan/report.c                                                          |    6 
 mm/memblock.c                                                              |    4 
 mm/memcontrol-v1.h                                                         |    2 
 mm/mempolicy.c                                                             |    4 
 mm/mmap.c                                                                  |    1 
 mm/readahead.c                                                             |    5 
 mm/vmalloc.c                                                               |    3 
 net/bluetooth/hci_conn.c                                                   |   19 
 net/bluetooth/hci_core.c                                                   |   13 
 net/bluetooth/hci_event.c                                                  |    7 
 net/bluetooth/hci_sync.c                                                   |    9 
 net/bluetooth/l2cap_sock.c                                                 |    1 
 net/bluetooth/rfcomm/sock.c                                                |   10 
 net/can/af_can.c                                                           |    1 
 net/can/j1939/transport.c                                                  |    2 
 net/core/link_watch.c                                                      |    7 
 net/core/neighbour.c                                                       |    1 
 net/core/netpoll.c                                                         |    2 
 net/dccp/feat.c                                                            |    6 
 net/ethtool/bitset.c                                                       |   48 
 net/hsr/hsr_device.c                                                       |   19 
 net/hsr/hsr_forward.c                                                      |    2 
 net/ieee802154/socket.c                                                    |   12 
 net/ipv4/af_inet.c                                                         |   22 
 net/ipv4/icmp.c                                                            |    3 
 net/ipv4/tcp_ao.c                                                          |   42 
 net/ipv4/tcp_bpf.c                                                         |   11 
 net/ipv4/tcp_ipv4.c                                                        |    3 
 net/ipv4/udp.c                                                             |   14 
 net/ipv6/addrconf.c                                                        |   13 
 net/ipv6/af_inet6.c                                                        |   22 
 net/ipv6/route.c                                                           |    6 
 net/ipv6/tcp_ipv6.c                                                        |    4 
 net/mptcp/diag.c                                                           |    2 
 net/mptcp/options.c                                                        |    4 
 net/mptcp/protocol.c                                                       |    6 
 net/mptcp/protocol.h                                                       |    6 
 net/mptcp/subflow.c                                                        |    4 
 net/netfilter/ipset/ip_set_core.c                                          |    5 
 net/netfilter/ipvs/ip_vs_proto.c                                           |    4 
 net/netfilter/nft_inner.c                                                  |   57 
 net/netfilter/nft_set_hash.c                                               |   16 
 net/netfilter/nft_socket.c                                                 |    2 
 net/netfilter/xt_LED.c                                                     |    4 
 net/packet/af_packet.c                                                     |   12 
 net/sched/cls_flower.c                                                     |    5 
 net/sched/sch_cbs.c                                                        |    2 
 net/sched/sch_tbf.c                                                        |   18 
 net/smc/af_smc.c                                                           |    6 
 net/tipc/udp_media.c                                                       |    2 
 net/vmw_vsock/af_vsock.c                                                   |   70 
 net/xdp/xsk_buff_pool.c                                                    |    5 
 net/xdp/xskmap.c                                                           |    2 
 rust/kernel/lib.rs                                                         |    2 
 rust/kernel/list/arc.rs                                                    |    3 
 rust/kernel/sync/arc.rs                                                    |    6 
 samples/bpf/test_cgrp2_sock.c                                              |    4 
 scripts/Makefile.build                                                     |    2 
 scripts/mod/modpost.c                                                      |    2 
 scripts/setlocalversion                                                    |   54 
 sound/core/seq/seq_ump_client.c                                            |    6 
 sound/pci/hda/hda_auto_parser.c                                            |   61 
 sound/pci/hda/hda_local.h                                                  |   28 
 sound/pci/hda/patch_analog.c                                               |    6 
 sound/pci/hda/patch_cirrus.c                                               |    8 
 sound/pci/hda/patch_conexant.c                                             |   36 
 sound/pci/hda/patch_cs8409-tables.c                                        |    2 
 sound/pci/hda/patch_cs8409.h                                               |    2 
 sound/pci/hda/patch_realtek.c                                              |  126 
 sound/pci/hda/patch_sigmatel.c                                             |   22 
 sound/pci/hda/patch_via.c                                                  |    2 
 sound/soc/amd/yc/acp6x-mach.c                                              |   14 
 sound/soc/codecs/hdmi-codec.c                                              |  140 
 sound/soc/intel/avs/pcm.c                                                  |    2 
 sound/soc/intel/boards/sof_rt5682.c                                        |    7 
 sound/soc/intel/boards/sof_sdw.c                                           |   41 
 sound/soc/intel/common/soc-acpi-intel-arl-match.c                          |   63 
 sound/soc/intel/common/soc-acpi-intel-mtl-match.c                          |    7 
 sound/soc/mediatek/mt8188/mt8188-mt6359.c                                  |    4 
 sound/soc/sdw_utils/soc_sdw_utils.c                                        |    7 
 sound/soc/sof/ipc3-topology.c                                              |   31 
 sound/usb/endpoint.c                                                       |   14 
 sound/usb/mixer.c                                                          |   58 
 sound/usb/mixer_maps.c                                                     |   10 
 sound/usb/mixer_quirks.c                                                   |    1 
 sound/usb/quirks-table.h                                                   |  341 
 sound/usb/quirks.c                                                         |   75 
 sound/usb/usbaudio.h                                                       |    4 
 tools/bpf/bpftool/prog.c                                                   |   17 
 tools/scripts/Makefile.arch                                                |    4 
 tools/testing/selftests/arm64/fp/fp-stress.c                               |   15 
 tools/testing/selftests/arm64/pauth/pac.c                                  |    3 
 tools/testing/selftests/bpf/progs/verifier_bits_iter.c                     |    4 
 tools/testing/selftests/damon/Makefile                                     |    2 
 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc       |    2 
 tools/testing/selftests/hid/run-hid-tools-tests.sh                         |   16 
 tools/testing/selftests/mm/hugetlb_dio.c                                   |   14 
 tools/testing/selftests/resctrl/resctrl_val.c                              |    4 
 tools/testing/selftests/resctrl/resctrlfs.c                                |    2 
 tools/testing/selftests/wireguard/qemu/debug.config                        |    1 
 tools/testing/vsock/vsock_perf.c                                           |   10 
 tools/testing/vsock/vsock_test.c                                           |   26 
 tools/tracing/rtla/sample/timerlat_load.py                                 |    9 
 tools/tracing/rtla/src/timerlat_hist.c                                     |   20 
 tools/tracing/rtla/src/timerlat_top.c                                      |    8 
 tools/tracing/rtla/src/utils.c                                             |    4 
 tools/tracing/rtla/src/utils.h                                             |    2 
 tools/verification/dot2/automata.py                                        |   18 
 543 files changed, 13068 insertions(+), 7133 deletions(-)

Abhishek Chauhan (1):
      net: stmmac: Programming sequence for VLAN packets with split header

Adam Young (1):
      mailbox: pcc: Check before sending MCTP PCC response ACK

Adrian Huang (1):
      sched/numa: fix memory leak due to the overwritten vma->numab_state

Ajay Kaher (1):
      ptp: Add error handling for adjfine callback in ptp_clock_adjtime

Akinobu Mita (1):
      mm/damon: fix order of arguments in damos_before_apply tracepoint

Aleksandr Mishin (1):
      fsl/fman: Validate cell-index value obtained from Device Tree

Aleksandrs Vinarskis (1):
      firmware: qcom: scm: Allow QSEECOM on Dell XPS 13 9345

Alex Deucher (9):
      drm/amd/pm: fix and simplify workload handling
      drm/amdgpu/hdp6.0: do a posting read when flushing HDP
      drm/amdgpu/hdp4.0: do a posting read when flushing HDP
      drm/amdgpu/hdp5.0: do a posting read when flushing HDP
      drm/amdgpu/hdp7.0: do a posting read when flushing HDP
      drm/amdgpu/hdp5.2: do a posting read when flushing HDP
      drm/amd/display: disable SG displays on cyan skillfish
      drm/amdgpu: rework resume handling for display (v2)
      Revert "drm/amd/display: parse umc_info or vram_info based on ASIC"

Alex Far (1):
      ASoC: amd: yc: fix internal mic on Redmi G 2022

Alexander Aring (1):
      dlm: fix possible lkb_resource null dereference

Alexander Kozhinov (1):
      can: gs_usb: add usb endpoint address detection at driver probe step

Alexander Sverdlin (1):
      watchdog: rti: of: honor timeout-sec property

Amadeusz Sławiński (1):
      ASoC: Intel: avs: Fix return status of avs_pcm_hw_constraints_init()

Amir Goldstein (1):
      fanotify: allow reporting errors on failure to open fd

Amir Mohammadi (1):
      bpftool: fix potential NULL pointer dereferencing in prog_dump()

Andrew Lunn (1):
      dsa: qca8k: Use nested lock to avoid splat

Andrii Nakryiko (2):
      mm: fix vrealloc()'s KASAN poisoning logic
      bpf: put bpf_link's program when link is safe to be deallocated

Andy Shevchenko (1):
      iio: light: ltr501: Add LTER0303 to the supported devices

Andy-ld Lu (2):
      mmc: mtk-sd: Fix error handle of probe function
      mmc: mtk-sd: Fix MMC_CAP2_CRYPTO flag setting

Anil Gurumurthy (1):
      scsi: qla2xxx: Supported speed displayed incorrectly for VPorts

Arkadiusz Kubalewski (1):
      ice: fix PHY Clock Recovery availability check

Armin Wolf (1):
      platform/x86: asus-wmi: Ignore return value when writing thermal policy

Aruna Ramakrishna (2):
      x86/pkeys: Change caller of update_pkru_in_sigframe()
      x86/pkeys: Ensure updated PKRU value is XRSTOR'd

Asahi Lina (1):
      ALSA: usb-audio: Add extra PID for RME Digiface USB

Aurabindo Pillai (1):
      drm/amd/display: parse umc_info or vram_info based on ASIC

Ausef Yousof (1):
      drm/amd/display: Remove hw w/a toggle if on DP2/HPO

Avri Altman (3):
      mmc: sd: SDUC Support Recognition
      mmc: core: Adjust ACMD22 to SDUC
      mmc: core: Use GFP_NOIO in ACMD22

Badal Nilawar (1):
      drm/xe/guc/ct: Flush g2h worker in case of g2h response timeout

Balamurugan C (1):
      ASoC: Intel: sof_rt5682: Add HDMI-In capture with rt5682 support for MTL.

Bard Liao (1):
      ASoC: SOF: ipc3-topology: Convert the topology pin index to ALH dai index

Barnabás Czémán (3):
      pinctrl: qcom-pmic-gpio: add support for PM8937
      pinctrl: qcom: spmi-mpp: Add PM8937 compatible
      thermal/drivers/qcom/tsens-v1: Add support for MSM8937 tsens

Bart Van Assche (2):
      scsi: ufs: core: Always initialize the UIC done completion
      scsi: ufs: core: Make DMA mask configuration more flexible

Bartosz Golaszewski (2):
      gpio: grgpio: use a helper variable to store the address of ofdev->dev
      gpio: free irqs that are still requested when the chip is being removed

Benjamin Tissoires (1):
      HID: add per device quirk to force bind to hid-generic

Bernd Schubert (1):
      io_uring: Change res2 parameter type in io_uring_cmd_done

Bibo Mao (1):
      LoongArch: Add architecture specific huge_pte_clear()

Bingbu Cao (1):
      media: ipu6: use the IPU6 DMA mapping APIs to do mapping

Bjorn Andersson (1):
      soc: qcom: pd-mapper: Add QCM6490 PD maps

Björn Töpel (1):
      tools: Override makefile ARCH variable if defined, but empty

Boris Burkov (1):
      btrfs: do not clear read-only when adding sprout device

Brahmajit Das (1):
      drm/display: Fix building with GCC 15

Breno Leitao (2):
      perf/x86/amd: Warn only on new bits set
      netpoll: Use rcu_access_pointer() in __netpoll_setup

Brian Foster (1):
      ext4: partial zero eof block on unaligned inode size extension

Callahan Kovacs (1):
      HID: magicmouse: Apple Magic Trackpad 2 USB-C driver support

Catalin Marinas (1):
      arm64: Ensure bits ASID[15:8] are masked out when the kernel uses 8-bit ASIDs

Changwoo Min (1):
      sched_ext: add a missing rcu_read_lock/unlock pair at scx_select_cpu_dfl()

Chao Yu (5):
      f2fs: clean up w/ F2FS_{BLK_TO_BYTES,BTYES_TO_BLK}
      f2fs: fix to requery extent which cross boundary of inquiry
      f2fs: print message if fscorrupted was found in f2fs_new_node_page()
      f2fs: fix to shrink read extent node in batches
      f2fs: add a sysfs node to limit max read extent count per-inode

Charles Han (1):
      gpio: grgpio: Add NULL check in grgpio_probe

Charles Keepax (4):
      ASoC: sdw_utils: Add support for exclusion DAI quirks
      ASoC: sdw_utils: Add a quirk to allow the cs42l43 mic DAI to be ignored
      ASoC: Intel: sof_sdw: Add quirk for cs42l43 system using host DMICs
      ASoC: Intel: sof_sdw: Add quirks for some new Lenovo laptops

Chris Chiu (1):
      ALSA: hda/realtek: fix micmute LEDs don't work on HP Laptops

Chris Park (1):
      drm/amd/display: Ignore scalar validation failure if pipe is phantom

Christian Brauner (1):
      epoll: annotate racy check

Christian König (1):
      dma-buf: fix dma_fence_array_signaled v4

Christoph Hellwig (1):
      nvme: don't apply NVME_QUIRK_DEALLOCATE_ZEROES when DSM is not supported

Christophe JAILLET (1):
      mlxsw: spectrum_acl_flex_keys: Constify struct mlxsw_afk_element_inst

Chunguang.xu (2):
      nvme-tcp: fix the memleak while create new ctrl failed
      nvme-rdma: unquiesce admin_q before destroy it

Colin Ian King (1):
      ALSA: hda/realtek: Fix spelling mistake "Firelfy" -> "Firefly"

Cosmin Ratiu (2):
      net/mlx5: HWS: Fix memory leak in mlx5hws_definer_calc_layout
      net/mlx5: HWS: Properly set bwc queue locks lock classes

Cosmin Tanislav (1):
      regmap: detach regmap from dev on regmap_exit

Cristian Ciocaltea (1):
      regmap: maple: Provide lockdep (sub)class for maple tree's internal lock

Damien Le Moal (2):
      block: RCU protect disk->conv_zones_bitmap
      x86: Fix build regression with CONFIG_KEXEC_JUMP enabled

Dan Carpenter (2):
      ASoC: SOF: ipc3-topology: fix resource leaks in sof_ipc3_widget_setup_comp_dai()
      ALSA: usb-audio: Fix a DMA to stack memory bug

Daniel Xu (1):
      bnxt_en: ethtool: Supply ntuple rss context action

Danil Pylaev (3):
      Bluetooth: Add new quirks for ATS2851
      Bluetooth: Support new quirks for ATS2851
      Bluetooth: Set quirks for ATS2851

Dario Binacchi (10):
      can: c_can: c_can_handle_bus_err(): update statistics if skb allocation fails
      can: sun4i_can: sun4i_can_err(): call can_change_state() even if cf is NULL
      can: hi311x: hi3110_can_ist(): fix potential use-after-free
      can: m_can: m_can_handle_lec_err(): fix {rx,tx}_errors statistics
      can: ifi_canfd: ifi_canfd_handle_lec_err(): fix {rx,tx}_errors statistics
      can: hi311x: hi3110_can_ist(): fix {rx,tx}_errors statistics
      can: sja1000: sja1000_err(): fix {rx,tx}_errors statistics
      can: sun4i_can: sun4i_can_err(): fix {rx,tx}_errors statistics
      can: ems_usb: ems_usb_rx_err(): fix {rx,tx}_errors statistics
      can: f81604: f81604_handle_can_bus_errors(): fix {rx,tx}_errors statistics

Dave Stevenson (1):
      drm/vc4: hvs: Set AXI panic modes for the HVS

David Given (1):
      media: uvcvideo: Add a quirk for the Kaiweets KTI-W02 infrared camera

David Hildenbrand (1):
      mm/mempolicy: fix migrate_to_node() assuming there is at least one VMA in a MM

David Sterba (2):
      btrfs: drop unused parameter options from open_ctree()
      btrfs: drop unused parameter data from btrfs_fill_super()

David Woodhouse (2):
      x86/kexec: Restore GDT on return from ::preserve_context kexec
      x86/mm: Add _PAGE_NOPTISHADOW bit to avoid updating userspace page tables

David Yat Sin (1):
      drm/amdkfd: hard-code cacheline for gc943,gc944

Defa Li (1):
      i3c: Use i3cdev->desc->info instead of calling i3c_device_get_info() to avoid deadlock

Devi Priya (1):
      clk: qcom: clk-alpha-pll: Add NSS HUAYRA ALPHA PLL support for ipq9574

Dillon Varone (1):
      drm/amd/display: Limit VTotal range to max hw cap minus fp

Dmitry Antipov (3):
      netfilter: x_tables: fix LED ID check in led_tg_check()
      can: j1939: j1939_session_new(): fix skb reference counting
      rocker: fix link status detection in rocker_carrier_init()

Dmitry Baryshkov (6):
      clk: qcom: rcg2: add clk_rcg2_shared_floor_ops
      clk: qcom: rpmh: add support for SAR2130P
      clk: qcom: tcsrcc-sm8550: add SAR2130P support
      clk: qcom: dispcc-sm8550: enable support for SAR2130P
      remoteproc: qcom: pas: enable SAR2130P audio DSP support
      usb: typec: ucsi: glink: be more precise on orientation-aware ports

Dmitry Kandybka (1):
      mptcp: fix possible integer overflow in mptcp_reset_tout_timer

Dmitry Perchanov (1):
      media: uvcvideo: RealSense D421 Depth module metadata

Dmitry Safonov (1):
      net/tcp: Add missing lockdep annotations for TCP-AO hlist traversals

Dmitry Torokhov (1):
      rtc: cmos: avoid taking rtc_lock for extended period of time

Dnyaneshwar Bhadane (1):
      drm/xe/pciid: Add new PCI id for ARL

Dom Cobley (1):
      drm/vc4: hdmi: Avoid log spam for audio start failure

Donald Hunter (1):
      netlink: specs: Add missing bitset attrs to ethtool spec

Dong Chenchen (1):
      net: Fix icmp host relookup triggering ip_rt_bug

Elena Salomatkina (1):
      net/sched: cbs: Fix integer overflow in cbs_set_port_rate()

Eric Dumazet (5):
      net: hsr: avoid potential out-of-bound access in fill_frame_info()
      ipv6: avoid possible NULL deref in modify_prefix_route()
      net: hsr: must allocate more bytes for RedBox support
      geneve: do not assume mac header is set in geneve_xmit_skb()
      net: avoid potential UAF in default_operstate()

Esben Haabendal (1):
      pinctrl: freescale: fix COMPILE_TEST error with PINCTRL_IMX_SCU

Esther Shimanovich (1):
      PCI: Detect and trust built-in Thunderbolt chips

Fangzhi Zuo (1):
      drm/amd/display: Prune Invalid Modes For HDMI Output

Fernando Fernandez Mancera (2):
      Revert "udp: avoid calling sock_def_readable() if possible"
      x86/cpu/topology: Remove limit of CPUs due to disabled IO/APIC

Filipe Manana (1):
      btrfs: fix missing snapshot drew unlock when root is dead during swap activation

Frank Li (3):
      i3c: master: Replace hard code 2 with macro I3C_ADDR_SLOT_STATUS_BITS
      i3c: master: Extend address status bit to 4 and add I3C_ADDR_SLOT_EXT_DESIRED
      i3c: master: Fix dynamic address leak when 'assigned-address' is present

Fudongwang (1):
      drm/amd/display: skip disable CRTC in seemless bootup case

Gabriele Monaco (2):
      rtla: Fix consistency in getopt_long for timerlat_hist
      verification/dot2: Improve dot parser robustness

Gang Yan (1):
      mptcp: annotate data-races around subflow->fully_established

Gary Guo (1):
      rust: enable arbitrary_self_types and remove `Receiver`

Geert Uytterhoeven (1):
      irqchip/stm32mp-exti: CONFIG_STM32MP_EXTI should not default to y when compile-testing

Ghanshyam Agrawal (3):
      jfs: array-index-out-of-bounds fix in dtReadFirst
      jfs: fix shift-out-of-bounds in dbSplit
      jfs: fix array-index-out-of-bounds in jfs_readdir

Greg Kroah-Hartman (1):
      Linux 6.12.5

Gustavo Sousa (1):
      drm/xe/xe3: Add initial set of workarounds

Gwendal Grignou (1):
      scsi: ufs: core: sysfs: Prevent div by zero

Hans de Goede (5):
      mmc: sdhci-pci: Add DMI quirk for missing CD GPIO on Vexia Edu Atla 10 tablet
      ACPI: x86: Make UART skip quirks work on PCI UARTs without an UID
      ACPI: x86: Add adev NULL check to acpi_quirk_skip_serdev_enumeration()
      ACPI: x86: Add skip i2c clients quirk for Acer Iconia One 8 A1-840
      ACPI: x86: Clean up Asus entries in acpi_quirk_skip_dmi_ids[]

Hao Qin (1):
      Bluetooth: btusb: Add new VID/PID 0489/e111 for MT7925

Haoyu Li (1):
      clk: en7523: Initialize num before accessing hws in en7523_register_clocks()

Hari Bathini (1):
      selftests/ftrace: adjust offset for kprobe syntax error test

Harini T (1):
      watchdog: xilinx_wwdt: Calculate max_hw_heartbeat_ms using clock frequency

Heiner Kallweit (1):
      r8169: don't apply UDP padding quirk on RTL8126A

Heming Zhao (1):
      ocfs2: Revert "ocfs2: fix the la space leak when unmounting an ocfs2 volume"

Hilda Wu (1):
      Bluetooth: btusb: Add RTL8852BE device 0489:e123 to device tables

Himal Prasad Ghimiray (2):
      drm/xe/forcewake: Add a helper xe_force_wake_ref_has_domain()
      drm/xe/devcoredump: Update handling of xe_force_wake_get return

Hou Tao (5):
      bpf: Handle BPF_EXIST and BPF_NOEXIST for LPM trie
      bpf: Remove unnecessary kfree(im_node) in lpm_trie_update_elem
      bpf: Handle in-place update for full LPM trie correctly
      bpf: Fix exact match conditions in trie_get_next_key()
      bpf: Call free_htab_elem() after htab_unlock_bucket()

Huacai Chen (2):
      LoongArch: KVM: Protect kvm_check_requests() with SRCU
      LoongArch: Fix sleeping in atomic context for PREEMPT_RT

Ido Schimmel (1):
      mlxsw: spectrum_acl_flex_keys: Use correct key block on Spectrum-4

Ignat Korchagin (7):
      af_packet: avoid erroring out after sock_init_data() in packet_create()
      Bluetooth: L2CAP: do not leave dangling sk pointer on error in l2cap_sock_create()
      Bluetooth: RFCOMM: avoid leaving dangling sk pointer in rfcomm_sock_alloc()
      net: af_can: do not leave a dangling sk pointer in can_create()
      net: ieee802154: do not leave a dangling sk pointer in ieee802154_create()
      net: inet: do not leave a dangling sk pointer in inet_create()
      net: inet6: do not leave a dangling sk pointer in inet6_create()

Igor Artemiev (1):
      drm/radeon/r600_cs: Fix possible int overflow in r600_packet3_check()

Imre Deak (3):
      drm/dp_mst: Fix MST sideband message body length check
      drm/dp_mst: Verify request type in the corresponding down message reply
      drm/dp_mst: Fix resetting msg rx state after topology removal

Inochi Amaoto (1):
      serial: 8250_dw: Add Sophgo SG2044 quirk

Ivan Solodovnikov (1):
      dccp: Fix memory leak in dccp_feat_change_recv

Jacob Keller (2):
      ixgbevf: stop attempting IPSEC offload on Mailbox API 1.5
      ixgbe: downgrade logging of unsupported VF API version to debug

Jakob Hauser (1):
      iio: magnetometer: yas530: use signed integer type for clamp limits

Jakub Kicinski (1):
      net/neighbor: clear error in case strict check is not set

Jan Kara (1):
      Revert "readahead: properly shorten readahead when falling back to do_page_cache_ra()"

Jan Stancek (1):
      tools/rtla: fix collision with glibc sched_attr/sched_set_attr

Jani Nikula (2):
      drm/xe/pciids: separate RPL-U and RPL-P PCI IDs
      drm/xe/pciids: separate ARL and MTL PCI IDs

Jared Kangas (1):
      kasan: make report_lock a raw spinlock

Jarkko Nikula (2):
      i2c: i801: Add support for Intel Panther Lake
      i3c: mipi-i3c-hci: Mask ring interrupts before ring stop request

Jason Gunthorpe (1):
      iommu/amd: Fix corruption when mapping large pages from 0

Jeffrey Hugo (1):
      accel/qaic: Add AIC080 support

Jens Axboe (1):
      io_uring/tctx: work around xa_store() allocation error issue

Jian-Hong Pan (1):
      PCI: vmd: Set devices to D0 before enabling PM L1 Substates

Jianbo Liu (1):
      net/mlx5e: Remove workaround to avoid syndrome for internal port

Jiande Lu (2):
      Bluetooth: btusb: Add USB HW IDs for MT7920/MT7925
      Bluetooth: btusb: Add 3 HWIDs for MT7925

Jiapeng Chong (1):
      wifi: ipw2x00: libipw_rx_any(): fix bad alignment

Jinghao Jia (1):
      ipvs: fix UB due to uninitialized stack access in ip_vs_protocol_init()

Jiri Wiesner (1):
      net/ipv6: release expired exception dst cached in socket

Joaquín Ignacio Aramendía (3):
      drm: panel-orientation-quirks: Add quirk for AYA NEO 2 model
      drm: panel-orientation-quirks: Add quirk for AYA NEO Founder edition
      drm: panel-orientation-quirks: Add quirk for AYA NEO GEEK

Jocelyn Falempe (1):
      drm/panic: Add ABGR2101010 support

Johannes Thumshirn (1):
      btrfs: don't take dev_replace rwsem on task already holding it

John Garry (1):
      scsi: scsi_debug: Fix hrtimer support for ndelay

John Harrison (4):
      drm/xe/devcoredump: Use drm_puts and already cached local variables
      drm/xe/devcoredump: Improve section headings and add tile info
      drm/xe/devcoredump: Add ASCII85 dump helper function
      drm/xe/guc: Copy GuC log prior to dumping

John Hubbard (1):
      mm/gup: handle NULL pages in unpin_user_pages()

John Sperbeck (1):
      mm: memcg: declare do_memsw_account inline

Jonas Karlman (1):
      ASoC: hdmi-codec: reorder channel allocation list

Jonathan Denose (1):
      ACPI: video: force native for Apple MacbookPro11,2 and Air7,2

Jonathan McCrohan (1):
      Bluetooth: btusb: Add new VID/PID 0489/e124 for MT7925

Jordy Zomer (2):
      ksmbd: fix Out-of-Bounds Read in ksmbd_vfs_stream_read
      ksmbd: fix Out-of-Bounds Write in ksmbd_vfs_stream_write

Josh Don (1):
      sched: fix warning in sched_setaffinity

Joshua Hay (1):
      idpf: set completion tag for "empty" bufs associated with a packet

Justin Tee (3):
      scsi: lpfc: Call lpfc_sli4_queue_unset() in restart and rmmod paths
      scsi: lpfc: Check SLI_ACTIVE flag in FDMI cmpl before submitting follow up FDMI
      scsi: lpfc: Prevent NDLP reference count underflow in dev_loss_tmo callback

K Prateek Nayak (4):
      sched/core: Remove the unnecessary need_resched() check in nohz_csd_func()
      sched/fair: Check idle_cpu() before need_resched() to detect ilb CPU turning busy
      sched/core: Prevent wakeup of ksoftirqd during idle load balance
      softirq: Allow raising SCHED_SOFTIRQ from SMP-call-function on RT kernel

Kai Mäkisara (2):
      scsi: st: Don't modify unknown block number in MTIOCGET
      scsi: st: Add MTIOCGET and MTLOAD to ioctls allowed after device reset

Kalesh Singh (1):
      mm: respect mmap hint address when aligning for THP

Kalle Valo (1):
      wifi: ath12k: fix atomic calls in ath12k_mac_op_set_bitrate_mask()

Kang Yang (1):
      wifi: ath10k: avoid NULL pointer error during sdio remove

Kees Cook (2):
      lib: stackinit: hide never-taken branch from compiler
      smb: client: memcpy() with surrounding object base address

Keita Aihara (1):
      mmc: core: Add SD card quirk for broken poweroff notification

Keith Busch (1):
      PCI: Add 'reset_subordinate' to reset hierarchy below bridge

Kenny Levinsen (1):
      HID: i2c-hid: Revert to using power commands to wake on resume

Kinsey Moore (1):
      jffs2: Prevent rtime decompress memory corruption

Konrad Dybcio (1):
      soc: qcom: llcc: Use designated initializers for LLC settings

Konstantin Komarov (2):
      fs/ntfs3: Fix warning in ni_fiemap
      fs/ntfs3: Fix case when unmarked clusters intersect with zone

Konstantin Shkolnyy (2):
      vsock/test: fix failures due to wrong SO_RCVLOWAT parameter
      vsock/test: fix parameter types in SO_VM_SOCKETS_* calls

Kory Maincent (1):
      ethtool: Fix wrong mod state in case of verbose and no_mask bitset

Kuan-Wei Chiu (1):
      tracing: Fix cmp_entries_dup() to respect sort() comparison rules

Kumar Kartikeya Dwivedi (1):
      bpf: Don't mark STACK_INVALID as STACK_MISC in mark_stack_slot_misc

Kuniyuki Iwashima (1):
      tipc: Fix use-after-free of kernel socket in cleanup_bearer().

Lang Yu (1):
      drm/amdgpu: refine error handling in amdgpu_ttm_tt_pin_userptr

Larysa Zaremba (1):
      xsk: always clear DMA mapping information when unmapping the pool

Len Brown (1):
      x86/cpu: Add Lunar Lake to list of CPUs with a broken MONITOR implementation

Leo Chen (2):
      drm/amd/display: Full exit out of IPS2 when all allow signals have been cleared
      drm/amd/display: Adding array index check to prevent memory corruption

Leo Ma (1):
      drm/amd/display: Fix underflow when playing 8K video in full screen mode

Leon Hwang (1):
      bpf: Prevent tailcall infinite loop caused by freplace

Levi Yun (1):
      dma-debug: fix a possible deadlock on radix_lock

Liao Chen (2):
      drm/bridge: it6505: Enable module autoloading
      drm/mcde: Enable module autoloading

Liequan Che (1):
      bcache: revert replacing IS_ERR_OR_NULL with IS_ERR again

Linus Torvalds (1):
      Revert "unicode: Don't special case ignorable code points"

Lo-an Chen (1):
      drm/amd/display: Correct prefetch calculation

Louis Leseur (1):
      net/qed: allow old cards not supporting "num_images" to work

Luiz Augusto von Dentz (2):
      Bluetooth: hci_conn: Use disable_delayed_work_sync
      Bluetooth: hci_core: Fix not checking skb length on hci_acldata_packet

Lukas Wunner (1):
      crypto: ecdsa - Avoid signed integer overflow on signature decoding

Mac Chiang (2):
      ASoC: sdw_utils: Add quirk to exclude amplifier function
      ASoC: Intel: soc-acpi-intel-arl-match: Add rt722 and rt1320 support

Maciej Fijalkowski (2):
      bpf: fix OOB devmap writes when deleting elements
      xsk: fix OOB map writes when deleting elements

Manikandan Muralidharan (1):
      drm/panel: simple: Add Microchip AC69T88A LVDS Display panel

Manivannan Sadhasivam (5):
      scsi: ufs: core: Cancel RTC work during ufshcd_remove()
      scsi: ufs: qcom: Only free platform MSIs when ESI is enabled
      scsi: ufs: pltfrm: Disable runtime PM during removal of glue drivers
      scsi: ufs: pltfrm: Drop PM runtime reference count after ufshcd_remove()
      scsi: ufs: pltfrm: Dellocate HBA during ufshcd_pltfrm_remove()

Marc Kleine-Budde (2):
      can: dev: can_set_termination(): allow sleeping GPIOs
      can: mcp251xfd: mcp251xfd_get_tef_len(): work around erratum DS80000789E 6.

Marc Zyngier (1):
      arch_numa: Restore nid checks before registering a memblock with a node

Marcelo Dalmas (1):
      ntp: Remove invalid cast in time offset math

Marcin Szycik (1):
      ice: Fix VLAN pruning in switchdev mode

Marco Elver (2):
      stackdepot: fix stack_depot_save_flags() in NMI context
      kcsan: Turn report_filterlist_lock into a raw_spinlock

Marek Vasut (1):
      soc: imx8m: Probe the SoC driver as platform driver

Marie Ramlow (1):
      ALSA: usb-audio: add mixer mapping for Corsair HS80

Mark Brown (3):
      selftest: hugetlb_dio: fix test naming
      kselftest/arm64: Log fp-stress child startup errors to stdout
      kselftest/arm64: Don't leak pipe fds in pac.exec_sign_all()

Mark Rutland (3):
      arm64: ptrace: fix partial SETREGSET for NT_ARM_TAGGED_ADDR_CTRL
      arm64: ptrace: fix partial SETREGSET for NT_ARM_FPMR
      arm64: ptrace: fix partial SETREGSET for NT_ARM_POE

Markus Elfring (1):
      Bluetooth: hci_conn: Reduce hci_conn_drop() calls in two functions

Martin Ottens (1):
      net/sched: tbf: correct backlog statistic for GSO packets

Masami Hiramatsu (Google) (1):
      tracing/eprobe: Fix to release eprobe when failed to add dyn_event

Mathieu Desnoyers (1):
      tracing/ftrace: disable preemption in syscall probe

Matthew Wilcox (Oracle) (2):
      mm: open-code PageTail in folio_flags() and const_folio_flags()
      mm: open-code page_folio() in dump_page()

Maurizio Lombardi (1):
      nvme-fabrics: handle zero MAXCMD without closing the connection

Maximilian Heyne (2):
      selftests: hid: fix typo and exit code
      selftests/damon: add _damon_sysfs.py to TEST_FILES

Maya Matuszczyk (1):
      firmware: qcom: scm: Allow QSEECOM on Lenovo Yoga Slim 7x

Mayank Rana (1):
      PCI: starfive: Enable controller runtime PM before probing host bridge

Maíra Canal (1):
      drm/v3d: Enable Performance Counters before clearing them

Melody Olvera (1):
      regulator: qcom-rpmh: Update ranges for FTSMPS525

Mengyuan Lou (1):
      PCI: Add ACS quirk for Wangxun FF5xxx NICs

Michael Ellerman (1):
      powerpc/prom_init: Fixup missing powermac #size-cells

Michal Luczaj (2):
      bpf, vsock: Fix poll() missing a queue
      bpf, vsock: Invoke proto::close on close()

Miguel Ojeda (1):
      rust: allow `clippy::needless_lifetimes`

Mike Rapoport (Microsoft) (1):
      memblock: allow zero threshold in validate_numa_converage()

Mukesh Ojha (2):
      pinmux: Use sequential access to access desc->pinmux data
      leds: class: Protect brightness_show() with led_cdev->led_access mutex

Nazar Bilinskyi (1):
      ALSA: hda/realtek: Enable mute and micmute LED on HP ProBook 430 G8

Nick Chan (1):
      watchdog: apple: Actually flush writes after requesting watchdog restart

Nicolin Chen (1):
      iommufd: Fix out_fput in iommufd_fault_alloc()

Nihar Chaithanya (1):
      jfs: add a check to prevent array-index-out-of-bounds in dbAdjTree

Niklas Schnelle (4):
      s390/pci: Sort PCI functions prior to creating virtual busses
      s390/pci: Use topology ID for multi-function devices
      s390/pci: Ignore RID for isolated VFs
      s390/pci: Fix leak of struct zpci_dev when zpci_add_device() fails

Nikolay Kuratov (1):
      KVM: x86/mmu: Ensure that kvm_release_pfn_clean() takes exact pfn from kvm_faultin_pfn()

Nilay Shroff (1):
      Revert "nvme: make keep-alive synchronous operation"

Nirmal Patel (1):
      PCI: vmd: Add DID 8086:B06F and 8086:B60B for Intel client SKUs

Norbert van Bolhuis (1):
      wifi: brcmfmac: Fix oops due to NULL pointer dereference in brcmf_sdiod_sglist_rw()

Nuno Sa (1):
      iio: adc: ad7192: properly check spi_get_device_match_data()

Nícolas F. R. A. Prado (1):
      ASoC: mediatek: mt8188-mt6359: Remove hardcoded dmic codec

Oleksandr Ocheretnyi (1):
      iTCO_wdt: mask NMI_NOW bit for update_no_reboot_bit() call

Oleksij Rempel (1):
      net: phy: microchip: Reset LAN88xx PHY to ensure clean link state on LAN7800/7850

Pablo Neira Ayuso (3):
      netfilter: nft_socket: remove WARN_ON_ONCE on maximum cgroup level
      netfilter: nft_inner: incorrect percpu area handling under softirq
      netfilter: nft_set_hash: skip duplicated elements pending gc run

Parker Newman (1):
      misc: eeprom: eeprom_93cx6: Add quirk for extra read clock cycle

Paulo Alcantara (2):
      smb: client: fix potential race in cifs_put_tcon()
      smb: client: don't try following DFS links in cifs_tree_connect()

Pei Xiao (2):
      drm/sti: Add __iomem for mixer_dbg_mxn's parameter
      spi: mpc52xx: Add cancel_work_sync before module remove

Peng Fan (1):
      mmc: sdhci-esdhc-imx: enable quirks SDHCI_QUIRK_NO_LED

Peter Wang (1):
      scsi: ufs: core: Add missing post notify for power mode change

Peterson Guo (1):
      drm/amd/display: Add a left edge pixel if in YCbCr422 or YCbCr420 and odm

Petr Pavlu (1):
      ring-buffer: Limit time with disabled interrupts in rb_check_pages()

Phil Sutter (1):
      netfilter: ipset: Hold module reference while requesting a module

Philipp Stanner (1):
      drm/sched: memset() 'job' in drm_sched_job_init()

Ping-Ke Shih (2):
      wifi: rtw88: use ieee80211_purge_tx_queue() to purge TX skb
      wifi: rtw89: check return value of ieee80211_probereq_get() for RNR

Prike Liang (2):
      drm/amdgpu: Dereference the ATCS ACPI buffer
      drm/amdgpu: set the right AMDGPU sg segment limitation

Przemek Kitszel (1):
      cleanup: Adjust scoped_guard() macros to avoid potential warning

Przemyslaw Korba (1):
      ice: fix PHY timestamp extraction for ETH56G

Qi Han (1):
      f2fs: fix f2fs_bug_on when uninstalling filesystem call f2fs_evict_inode.

Qianqiang Liu (1):
      KMSAN: uninit-value in inode_go_dump (5)

Qu Wenruo (3):
      btrfs: avoid unnecessary device path update for the same device
      btrfs: canonicalize the device path before adding it
      btrfs: fix mount failure due to remount races

Quinn Tran (3):
      scsi: qla2xxx: Fix abort in bsg timeout
      scsi: qla2xxx: Fix NVMe and NPIV connect issue
      scsi: qla2xxx: Fix use after free on unload

Ralph Boehme (3):
      fs/smb/client: avoid querying SMB2_OP_QUERY_WSL_EA for SMB3 POSIX
      fs/smb/client: Implement new SMB3 POSIX type
      fs/smb/client: cifs_prime_dcache() for SMB3 POSIX reparse points

Randy Dunlap (1):
      scatterlist: fix incorrect func name in kernel-doc

Rasmus Villemoes (1):
      setlocalversion: work around "git describe" performance

Reinette Chatre (1):
      selftests/resctrl: Protect against array overflow when reading strings

Ricardo Neri (2):
      cacheinfo: Allocate memory during CPU hotplug if not done from the primary CPU
      x86/cacheinfo: Delete global num_cache_leaves

Ricardo Ribalda (1):
      media: uvcvideo: Force UVC version to 1.0a for 0408:4033

Richard Weinberger (1):
      jffs2: Fix rtime decompressor

Rodrigo Vivi (1):
      drm/xe/pciids: Add PVC's PCI device ID macros

Rohan Barar (1):
      media: cx231xx: Add support for Dexatek USB Video Grabber 1d19:6108

Rosen Penev (4):
      mmc: mtk-sd: use devm_mmc_alloc_host
      mmc: mtk-sd: fix devm_clk_get_optional usage
      wifi: ath5k: add PCI ID for SX76X
      wifi: ath5k: add PCI ID for Arcadyan devices

Ryusuke Konishi (1):
      nilfs2: fix potential out-of-bounds memory access in nilfs_find_entry()

Sahas Leelodharry (1):
      ALSA: hda/realtek: Add support for Samsung Galaxy Book3 360 (NP730QFG)

Sarah Maedel (1):
      hwmon: (nct6775) Add 665-ACE/600M-CL to ASUS WMI monitoring list

Saranya Gopal (1):
      usb: typec: ucsi: Do not call ACPI _DSM method for UCSI read operations

Saurav Kashyap (1):
      scsi: qla2xxx: Remove check req_sg_cnt should be equal to rsp_sg_cnt

Sean Christopherson (1):
      x86/CPU/AMD: WARN when setting EFER.AUTOIBRS if and only if the WRMSR fails

Sebastian Ott (1):
      net/mlx5: unique names for per device caches

Sergey Senozhatsky (2):
      zram: do not mark idle slots that cannot be idle
      zram: clear IDLE flag in mark_idle()

Shekhar Chauhan (1):
      drm/xe/ptl: L3bank mask is not available on the media GT

Shengjiu Wang (1):
      pmdomain: imx: gpcv2: Adjust delay after power up handshake

Shengyu Qu (1):
      net: sfp: change quirks for Alcatel Lucent G-010S-P

Shradha Gupta (1):
      net :mana :Request a V2 response version for MANA_QUERY_GF_STAT

Simon Horman (2):
      net: fec_mpc52xx_phy: Use %pa to format resource_size_t
      net: ethernet: fs_enet: Use %pa to format resource_size_t

Sreekant Somasekharan (1):
      drm/amdkfd: add MEC version that supports no PCIe atomics for GFX12

Srinivasan Shanmugam (2):
      drm/amd/display: Fix out-of-bounds access in 'dcn21_link_encoder_create'
      drm/amdgpu/gfx9: Add cleaner shader for GFX9.4.2

Stefan Wahren (1):
      spi: spi-fsl-lpspi: Adjust type of scldiv

Stephen Rothwell (1):
      iio: magnetometer: fix if () scoped_guard() formatting

Steve French (1):
      smb3.1.1: fix posix mounts to older servers

Sung Lee (1):
      drm/amd/display: Add option to retrieve detile buffer size

Suraj Sonawane (1):
      scsi: sg: Fix slab-use-after-free read in sg_release()

Takashi Iwai (7):
      ALSA: seq: ump: Fix seq port updates per FB info notify
      ALSA: usb-audio: Notify xrun for low-latency mode
      ALSA: hda: Use own quirk lookup helper
      ALSA: hda/conexant: Use the new codec SSID matching
      ALSA: hda/realtek: Use codec SSID matching for Lenovo devices
      ALSA: usb-audio: Make mic volume workarounds globally applicable
      ALSA: hda: Fix build error without CONFIG_SND_DEBUG

Tao Lyu (2):
      bpf: Ensure reg is PTR_TO_STACK in process_iter_arg
      bpf: Fix narrow scalar spill onto 64-bit spilled scalar slots

Tariq Toukan (1):
      net/mlx5e: SD, Use correct mdev to build channel param

Tatsuya S (1):
      tracing: Fix function name for trampoline

Tetsuo Handa (1):
      ocfs2: free inode when ocfs2_get_init_inode() fails

Thomas Gleixner (4):
      modpost: Add .irqentry.text to OTHER_SECTIONS
      timekeeping: Always check for negative motion
      timekeeping: Remove CONFIG_DEBUG_TIMEKEEPING
      clocksource: Make negative motion detection more robust

Thomas Richter (1):
      s390/cpum_sf: Handle CPU hotplug remove during sampling

Tomas Glozar (2):
      rtla/timerlat: Make timerlat_top_cpu->*_count unsigned long long
      rtla/timerlat: Make timerlat_hist_cpu->*_count unsigned long long

Tore Amundsen (1):
      ixgbe: Correct BASE-BX10 compliance code

Tvrtko Ursulin (2):
      dma-fence: Fix reference leak on fence merge failure path
      dma-fence: Use kernel's sort for merging fences

Ulf Hansson (3):
      pmdomain: core: Add missing put_device()
      pmdomain: core: Fix error path in pm_genpd_init() when ida alloc fails
      mmc: core: Further prevent card detect during shutdown

Uros Bizjak (1):
      tracing: Use atomic64_inc_return() in trace_clock_counter()

Uwe Kleine-König (1):
      ASoC: amd: yc: Add quirk for microphone on Lenovo Thinkpad T14s Gen 6 21M1CTO1WW

Victor Lu (1):
      drm/amdgpu: clear RB_OVERFLOW bit when enabling interrupts for vega20_ih

Victor Zhao (1):
      drm/amdgpu: skip amdgpu_device_cache_pci_state under sriov

Wander Lairson Costa (1):
      sched/deadline: Fix warning in migrate_enable for boosted tasks

WangYuli (1):
      HID: wacom: fix when get product name maybe null pointer

Wei Fang (1):
      net: enetc: Do not configure preemptible TCs if SIs do not support

Wen Gu (2):
      net/smc: initialize close_work early to avoid warning
      net/smc: fix LGR and link use-after-free issue

Wengang Wang (1):
      ocfs2: update seq_file index in ocfs2_dlm_seq_next

Will Deacon (1):
      drivers/virt: pkvm: Don't fail ioremap() call if MMIO_GUARD fails

Xi Ruoyao (1):
      MIPS: Loongson64: DTS: Really fix PCIe port nodes for ls7a

Xiang Liu (1):
      drm/amdgpu/vcn: reset fw_shared when VCPU buffers corrupted on vcn v4.0.3

Xin Long (1):
      net: sched: fix erspan_opt settings in cls_flower

Xu Yang (4):
      usb: chipidea: add CI_HDRC_HAS_SHORT_PKT_LIMIT flag
      usb: chipidea: udc: limit usb request length to max 16KB
      usb: chipidea: udc: create bounce buffer for problem sglist entries if possible
      usb: chipidea: udc: handle USB Error Interrupt if IOC not set

Xuan Zhuo (1):
      virtio-net: fix overflow inside virtnet_rq_alloc

Yang Shi (1):
      arm64: mm: Fix zone_dma_limit calculation

Yassine Oudjana (1):
      watchdog: mediatek: Make sure system reset gets asserted in mtk_wdt_restart()

Yi Yang (1):
      nvdimm: rectify the illogical code within nd_dax_probe()

Yihan Zhu (1):
      drm/amd/display: calculate final viewport before TAP optimization

Yihang Li (2):
      scsi: hisi_sas: Add cond_resched() for no forced preemption model
      scsi: hisi_sas: Create all dump files during debugfs initialization

Yishai Hadas (1):
      vfio/mlx5: Align the page tracking max message size with the device capability

Yuan Can (1):
      igb: Fix potential invalid memory access in igb_init_module()

Zhiguo Niu (1):
      f2fs: fix to adjust appropriate length for fiemap

Zhongwei (1):
      drm/amd/display: Fix garbage or black screen when resetting otg

Zhou Wang (1):
      irqchip/gicv3-its: Add workaround for hip09 ITS erratum 162100801

Zhu Jun (1):
      samples/bpf: Fix a resource leak

Zijian Zhang (1):
      tcp_bpf: Fix the sk_mem_uncharge logic in tcp_bpf_sendmsg

Ziqi Chen (1):
      scsi: ufs: core: Add ufshcd_send_bsg_uic_cmd() for UFS BSG

devi priya (1):
      PCI: qcom: Add support for IPQ9574

furkanonder (1):
      tools/rtla: Enhance argument parsing in timerlat_load.py


