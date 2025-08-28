Return-Path: <stable+bounces-176622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24158B3A264
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 16:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484141743D9
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 14:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3D13128AD;
	Thu, 28 Aug 2025 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wxhV9YRY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417C93128CE;
	Thu, 28 Aug 2025 14:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756391925; cv=none; b=rDgEqtAYBB1XwufWEDA0Plx1A6YYsODcZnW0z8XIANwtFcFAc816tGl0HKjgNWq15SrN/2svsekdoIdLhzpw/8/Zd+wcWcUUbNdZV8h9fDb7PqALwV59H08+wYKpsj+rs8hLRW9rcuqExrFaXLEF6zoL3J3VH5HOE/r7Ox4ebNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756391925; c=relaxed/simple;
	bh=njUdbzAmmsjeiqwNGWvYWTferZFx7tcUroXT7TXYEuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AJxB6V3l6A6PHVo+fJoVVzczyomOphb3qVOwlRwjB3aJK2x8TFiem5L+xxuMJ1YwVllYaMIBZdmPjHm0SGuUdtIcSM75yXEEUPuw7jab9eR4d9OnGyKhDLpW5UuQEKuOv4xTEDVQ7GwtJtqwcdhxc6iA1D/mhvppQw7saw73y28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wxhV9YRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABC8C4CEF5;
	Thu, 28 Aug 2025 14:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756391924;
	bh=njUdbzAmmsjeiqwNGWvYWTferZFx7tcUroXT7TXYEuI=;
	h=From:To:Cc:Subject:Date:From;
	b=wxhV9YRYMhYNUMQjtu+t3Tb3Pc7ZRs5g4m2KtGD2w8XoygTe8n54Qv3EyXkVEWog0
	 XadNjzvFGWewJxYTP+czbleemjJW+G2TrKlLftC7SfVFCXG1SmO0cUE4mY7JKFGrJp
	 IoZw2MIWzXbG2fmox2NaoEcIjxoCq/7V60xLdeow=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.190
Date: Thu, 28 Aug 2025 16:38:28 +0200
Message-ID: <2025082829-lavender-grievous-e838@gregkh>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.190 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/filesystems/f2fs.rst                                |    6 
 Documentation/firmware-guide/acpi/i2c-muxes.rst                   |    8 
 Documentation/memory-barriers.txt                                 |   11 
 Documentation/networking/mptcp-sysctl.rst                         |    2 
 Makefile                                                          |    4 
 arch/alpha/include/asm/processor.h                                |    2 
 arch/alpha/kernel/process.c                                       |    5 
 arch/arc/include/asm/processor.h                                  |    2 
 arch/arc/kernel/stacktrace.c                                      |    4 
 arch/arm/Makefile                                                 |    2 
 arch/arm/boot/dts/am335x-boneblack.dts                            |    2 
 arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi                     |    1 
 arch/arm/boot/dts/vfxxx.dtsi                                      |    2 
 arch/arm/include/asm/processor.h                                  |    2 
 arch/arm/kernel/process.c                                         |    4 
 arch/arm/mach-rockchip/platsmp.c                                  |   15 
 arch/arm/mach-tegra/reset.c                                       |    2 
 arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi              |    2 
 arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi              |    2 
 arch/arm64/include/asm/acpi.h                                     |    2 
 arch/arm64/include/asm/processor.h                                |    2 
 arch/arm64/kernel/entry.S                                         |    6 
 arch/arm64/kernel/fpsimd.c                                        |    4 
 arch/arm64/kernel/process.c                                       |    4 
 arch/arm64/kernel/traps.c                                         |    1 
 arch/arm64/mm/fault.c                                             |    1 
 arch/arm64/mm/ptdump_debugfs.c                                    |    3 
 arch/csky/include/asm/processor.h                                 |    2 
 arch/csky/kernel/stacktrace.c                                     |    5 
 arch/h8300/include/asm/processor.h                                |    2 
 arch/h8300/kernel/process.c                                       |    5 
 arch/hexagon/include/asm/processor.h                              |    2 
 arch/hexagon/kernel/process.c                                     |    4 
 arch/ia64/include/asm/processor.h                                 |    2 
 arch/ia64/kernel/process.c                                        |    5 
 arch/m68k/Kconfig.debug                                           |    2 
 arch/m68k/include/asm/processor.h                                 |    2 
 arch/m68k/kernel/early_printk.c                                   |   42 -
 arch/m68k/kernel/head.S                                           |   39 -
 arch/m68k/kernel/process.c                                        |    4 
 arch/microblaze/include/asm/processor.h                           |    2 
 arch/microblaze/kernel/process.c                                  |    2 
 arch/mips/crypto/chacha-core.S                                    |   20 
 arch/mips/include/asm/processor.h                                 |    2 
 arch/mips/include/asm/vpe.h                                       |    8 
 arch/mips/kernel/process.c                                        |   24 
 arch/mips/mm/tlb-r4k.c                                            |   56 +
 arch/nds32/include/asm/processor.h                                |    2 
 arch/nds32/kernel/process.c                                       |    7 
 arch/nios2/include/asm/processor.h                                |    2 
 arch/nios2/kernel/process.c                                       |    5 
 arch/openrisc/include/asm/processor.h                             |    2 
 arch/openrisc/kernel/process.c                                    |    2 
 arch/parisc/Makefile                                              |    2 
 arch/parisc/include/asm/processor.h                               |    2 
 arch/parisc/kernel/process.c                                      |    5 
 arch/powerpc/configs/ppc6xx_defconfig                             |    1 
 arch/powerpc/include/asm/processor.h                              |    2 
 arch/powerpc/kernel/eeh.c                                         |    1 
 arch/powerpc/kernel/eeh_driver.c                                  |   48 +
 arch/powerpc/kernel/eeh_pe.c                                      |   11 
 arch/powerpc/kernel/pci-hotplug.c                                 |    3 
 arch/powerpc/kernel/process.c                                     |    9 
 arch/powerpc/platforms/512x/mpc512x_lpbfifo.c                     |    6 
 arch/riscv/include/asm/processor.h                                |    2 
 arch/riscv/kernel/stacktrace.c                                    |   12 
 arch/s390/hypfs/hypfs_dbfs.c                                      |   19 
 arch/s390/include/asm/processor.h                                 |    2 
 arch/s390/include/asm/timex.h                                     |   13 
 arch/s390/kernel/process.c                                        |    4 
 arch/s390/kernel/time.c                                           |    2 
 arch/s390/mm/dump_pagetables.c                                    |    2 
 arch/sh/Makefile                                                  |   10 
 arch/sh/boot/compressed/Makefile                                  |    4 
 arch/sh/boot/romimage/Makefile                                    |    4 
 arch/sh/include/asm/processor_32.h                                |    2 
 arch/sh/kernel/process_32.c                                       |    5 
 arch/sparc/include/asm/processor_32.h                             |    2 
 arch/sparc/include/asm/processor_64.h                             |    2 
 arch/sparc/kernel/process_32.c                                    |    5 
 arch/sparc/kernel/process_64.c                                    |    5 
 arch/um/drivers/rtc_user.c                                        |    2 
 arch/um/include/asm/processor-generic.h                           |    2 
 arch/um/kernel/process.c                                          |    5 
 arch/x86/include/asm/processor.h                                  |    2 
 arch/x86/include/asm/xen/hypercall.h                              |    6 
 arch/x86/kernel/cpu/amd.c                                         |    2 
 arch/x86/kernel/cpu/bugs.c                                        |    5 
 arch/x86/kernel/cpu/hygon.c                                       |    3 
 arch/x86/kernel/cpu/mce/amd.c                                     |   13 
 arch/x86/kernel/process.c                                         |   62 --
 arch/x86/kvm/vmx/vmx.c                                            |    5 
 arch/x86/mm/extable.c                                             |    5 
 arch/xtensa/include/asm/processor.h                               |    2 
 arch/xtensa/kernel/process.c                                      |    5 
 block/blk-settings.c                                              |    2 
 drivers/acpi/acpi_processor.c                                     |    2 
 drivers/acpi/apei/ghes.c                                          |    2 
 drivers/acpi/prmt.c                                               |   26 
 drivers/acpi/processor_idle.c                                     |    4 
 drivers/acpi/processor_perflib.c                                  |   11 
 drivers/ata/Kconfig                                               |   35 -
 drivers/ata/libata-sata.c                                         |    5 
 drivers/ata/libata-scsi.c                                         |   20 
 drivers/base/power/domain_governor.c                              |   18 
 drivers/base/power/runtime.c                                      |    5 
 drivers/base/regmap/regmap.c                                      |    2 
 drivers/block/drbd/drbd_receiver.c                                |    6 
 drivers/block/sunvdc.c                                            |    4 
 drivers/bus/fsl-mc/fsl-mc-bus.c                                   |   19 
 drivers/bus/mhi/host/boot.c                                       |    8 
 drivers/bus/mhi/host/internal.h                                   |    4 
 drivers/bus/mhi/host/main.c                                       |   15 
 drivers/char/hw_random/mtk-rng.c                                  |    4 
 drivers/char/ipmi/ipmi_msghandler.c                               |    8 
 drivers/char/ipmi/ipmi_watchdog.c                                 |   59 +-
 drivers/clk/clk-axi-clkgen.c                                      |    2 
 drivers/clk/davinci/psc.c                                         |    5 
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c                              |    3 
 drivers/clk/xilinx/xlnx_vcu.c                                     |    4 
 drivers/comedi/comedi_fops.c                                      |   66 +-
 drivers/comedi/comedi_internal.h                                  |    1 
 drivers/comedi/drivers.c                                          |   43 -
 drivers/comedi/drivers/aio_iiro_16.c                              |    3 
 drivers/comedi/drivers/comedi_test.c                              |    2 
 drivers/comedi/drivers/das16m1.c                                  |    3 
 drivers/comedi/drivers/das6402.c                                  |    3 
 drivers/comedi/drivers/pcl726.c                                   |    3 
 drivers/comedi/drivers/pcl812.c                                   |    3 
 drivers/cpufreq/armada-8k-cpufreq.c                               |    2 
 drivers/cpufreq/cppc_cpufreq.c                                    |    2 
 drivers/cpufreq/cpufreq.c                                         |   29 
 drivers/cpufreq/intel_pstate.c                                    |    4 
 drivers/cpuidle/governors/menu.c                                  |   21 
 drivers/crypto/ccp/ccp-debugfs.c                                  |    3 
 drivers/crypto/hisilicon/hpre/hpre_crypto.c                       |    8 
 drivers/crypto/img-hash.c                                         |    2 
 drivers/crypto/inside-secure/safexcel_hash.c                      |    8 
 drivers/crypto/keembay/keembay-ocs-hcu-core.c                     |    8 
 drivers/crypto/marvell/cesa/cipher.c                              |    4 
 drivers/crypto/marvell/cesa/hash.c                                |    5 
 drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c               |   16 
 drivers/crypto/qat/qat_common/adf_transport_debug.c               |    4 
 drivers/devfreq/devfreq.c                                         |   10 
 drivers/devfreq/governor_userspace.c                              |    6 
 drivers/dma/mv_xor.c                                              |   21 
 drivers/dma/nbpfaxi.c                                             |   24 
 drivers/edac/synopsys_edac.c                                      |   97 +--
 drivers/fpga/zynq-fpga.c                                          |   10 
 drivers/gpio/gpio-tps65912.c                                      |    7 
 drivers/gpio/gpio-virtio.c                                        |    9 
 drivers/gpio/gpio-wcd934x.c                                       |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c                           |    4 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                 |    3 
 drivers/gpu/drm/amd/display/dc/bios/command_table.c               |    2 
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c                  |    1 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c       |    2 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c    |   40 -
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c      |   31 -
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c                |   11 
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c               |    3 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c               |    2 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                         |    6 
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c                  |   37 -
 drivers/gpu/drm/drm_dp_helper.c                                   |    2 
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c                   |    4 
 drivers/gpu/drm/msm/msm_gem.c                                     |    3 
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c                        |    9 
 drivers/gpu/drm/scheduler/sched_entity.c                          |   27 
 drivers/gpu/drm/ttm/ttm_pool.c                                    |    8 
 drivers/gpu/drm/ttm/ttm_resource.c                                |    3 
 drivers/hid/hid-core.c                                            |   19 
 drivers/hid/hid-magicmouse.c                                      |   51 +
 drivers/hwmon/corsair-cpro.c                                      |    5 
 drivers/hwmon/gsc-hwmon.c                                         |    4 
 drivers/i2c/busses/i2c-qup.c                                      |    4 
 drivers/i2c/busses/i2c-stm32.c                                    |    8 
 drivers/i2c/busses/i2c-stm32f7.c                                  |    4 
 drivers/i2c/busses/i2c-virtio.c                                   |   15 
 drivers/i2c/i2c-core-acpi.c                                       |    1 
 drivers/i3c/internals.h                                           |    1 
 drivers/i3c/master.c                                              |    2 
 drivers/idle/intel_idle.c                                         |    2 
 drivers/iio/adc/ad7768-1.c                                        |   23 
 drivers/iio/adc/ad_sigma_delta.c                                  |    4 
 drivers/iio/adc/max1363.c                                         |   43 -
 drivers/iio/adc/stm32-adc-core.c                                  |    7 
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c                  |    6 
 drivers/iio/light/as73211.c                                       |    2 
 drivers/iio/light/hid-sensor-prox.c                               |    8 
 drivers/iio/pressure/bmp280-core.c                                |    9 
 drivers/iio/proximity/isl29501.c                                  |   16 
 drivers/infiniband/core/cache.c                                   |    4 
 drivers/infiniband/core/nldev.c                                   |   22 
 drivers/infiniband/hw/bnxt_re/qplib_res.c                         |    2 
 drivers/infiniband/hw/hfi1/affinity.c                             |   44 -
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                        |   15 
 drivers/infiniband/hw/mlx5/dm.c                                   |    2 
 drivers/input/joystick/xpad.c                                     |    2 
 drivers/input/keyboard/gpio_keys.c                                |    4 
 drivers/interconnect/qcom/sc7280.c                                |    1 
 drivers/iommu/amd/init.c                                          |    4 
 drivers/leds/leds-lp50xx.c                                        |   11 
 drivers/md/dm-ps-historical-service-time.c                        |    4 
 drivers/md/dm-ps-queue-length.c                                   |    4 
 drivers/md/dm-ps-round-robin.c                                    |    4 
 drivers/md/dm-ps-service-time.c                                   |    4 
 drivers/md/dm-zoned-target.c                                      |    2 
 drivers/media/cec/usb/rainshadow/rainshadow-cec.c                 |    3 
 drivers/media/dvb-frontends/dib7000p.c                            |   10 
 drivers/media/i2c/hi556.c                                         |   26 
 drivers/media/i2c/ov2659.c                                        |    3 
 drivers/media/i2c/tc358743.c                                      |   86 +-
 drivers/media/platform/qcom/camss/camss.c                         |   10 
 drivers/media/platform/qcom/venus/core.c                          |   21 
 drivers/media/platform/qcom/venus/core.h                          |    2 
 drivers/media/platform/qcom/venus/dbgfs.c                         |    9 
 drivers/media/platform/qcom/venus/dbgfs.h                         |   13 
 drivers/media/platform/qcom/venus/hfi_venus.c                     |    5 
 drivers/media/platform/qcom/venus/vdec.c                          |    5 
 drivers/media/platform/qcom/venus/venc.c                          |    5 
 drivers/media/usb/gspca/vicam.c                                   |   10 
 drivers/media/usb/hdpvr/hdpvr-i2c.c                               |    6 
 drivers/media/usb/usbtv/usbtv-video.c                             |    4 
 drivers/media/usb/uvc/uvc_driver.c                                |    3 
 drivers/media/usb/uvc/uvc_video.c                                 |   21 
 drivers/media/v4l2-core/v4l2-common.c                             |    8 
 drivers/media/v4l2-core/v4l2-ctrls-core.c                         |    9 
 drivers/memstick/core/memstick.c                                  |    3 
 drivers/memstick/host/rtsx_usb_ms.c                               |    1 
 drivers/misc/cardreader/rtsx_usb.c                                |   16 
 drivers/mmc/host/bcm2835.c                                        |    3 
 drivers/mmc/host/rtsx_usb_sdmmc.c                                 |    4 
 drivers/mmc/host/sdhci-msm.c                                      |   14 
 drivers/mmc/host/sdhci-pci-core.c                                 |    3 
 drivers/mmc/host/sdhci-pci-gli.c                                  |    4 
 drivers/mmc/host/sdhci_am654.c                                    |    9 
 drivers/most/core.c                                               |    2 
 drivers/mtd/ftl.c                                                 |    2 
 drivers/mtd/nand/raw/atmel/nand-controller.c                      |    2 
 drivers/mtd/nand/raw/atmel/pmecc.c                                |    6 
 drivers/mtd/nand/raw/fsmc_nand.c                                  |    2 
 drivers/mtd/nand/raw/rockchip-nand-controller.c                   |   15 
 drivers/mtd/nand/spi/core.c                                       |    5 
 drivers/net/bonding/bond_3ad.c                                    |   25 
 drivers/net/bonding/bond_options.c                                |    1 
 drivers/net/can/kvaser_pciefd.c                                   |    1 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c                  |    1 
 drivers/net/dsa/b53/b53_common.c                                  |   65 +-
 drivers/net/dsa/b53/b53_regs.h                                    |    2 
 drivers/net/ethernet/agere/et131x.c                               |   36 +
 drivers/net/ethernet/aquantia/atlantic/aq_hw.h                    |    2 
 drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c |   39 +
 drivers/net/ethernet/atheros/ag71xx.c                             |    9 
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c                 |    4 
 drivers/net/ethernet/emulex/benet/be_cmds.c                       |    2 
 drivers/net/ethernet/emulex/benet/be_main.c                       |    8 
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c                    |    2 
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c                |    4 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c                  |   15 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c               |   15 
 drivers/net/ethernet/freescale/enetc/enetc_pf.c                   |   14 
 drivers/net/ethernet/freescale/fec_main.c                         |   34 -
 drivers/net/ethernet/freescale/gianfar_ethtool.c                  |    4 
 drivers/net/ethernet/google/gve/gve_adminq.c                      |    1 
 drivers/net/ethernet/google/gve/gve_main.c                        |   67 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c           |   36 -
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c            |    9 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c         |    6 
 drivers/net/ethernet/intel/e1000e/defines.h                       |    3 
 drivers/net/ethernet/intel/e1000e/ich8lan.c                       |    2 
 drivers/net/ethernet/intel/e1000e/nvm.c                           |    6 
 drivers/net/ethernet/intel/fm10k/fm10k.h                          |    3 
 drivers/net/ethernet/intel/i40e/i40e.h                            |    2 
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c                    |    3 
 drivers/net/ethernet/intel/i40e/i40e_main.c                       |   18 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c                |    4 
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c                    |    2 
 drivers/net/ethernet/intel/igc/igc_main.c                         |   14 
 drivers/net/ethernet/intel/ixgbe/ixgbe.h                          |    3 
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c                      |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en.h                      |   24 
 drivers/net/ethernet/mellanox/mlx5/core/en/qos.c                  |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c                   |   13 
 drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c                  |    4 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                    |    3 
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c                    |    2 
 drivers/net/ethernet/mellanox/mlxsw/trap.h                        |    1 
 drivers/net/ethernet/xilinx/xilinx_emaclite.c                     |    2 
 drivers/net/hyperv/hyperv_net.h                                   |    3 
 drivers/net/hyperv/netvsc_drv.c                                   |   29 
 drivers/net/phy/dp83640.c                                         |    6 
 drivers/net/phy/mscc/mscc.h                                       |   12 
 drivers/net/phy/mscc/mscc_main.c                                  |   12 
 drivers/net/phy/mscc/mscc_ptp.c                                   |   50 +
 drivers/net/phy/mscc/mscc_ptp.h                                   |    1 
 drivers/net/phy/nxp-c45-tja11xx.c                                 |    2 
 drivers/net/phy/smsc.c                                            |    1 
 drivers/net/ppp/ppp_generic.c                                     |   17 
 drivers/net/ppp/pptp.c                                            |   18 
 drivers/net/thunderbolt.c                                         |    8 
 drivers/net/usb/asix_devices.c                                    |    1 
 drivers/net/usb/sierra_net.c                                      |    4 
 drivers/net/usb/usbnet.c                                          |   11 
 drivers/net/vrf.c                                                 |    2 
 drivers/net/wireless/ath/ath11k/hal.c                             |   25 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c       |    8 
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c    |    2 
 drivers/net/wireless/intel/iwlegacy/4965-mac.c                    |    5 
 drivers/net/wireless/intel/iwlwifi/dvm/main.c                     |   11 
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c                       |    2 
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c                       |    7 
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c                      |    4 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c                     |    2 
 drivers/net/wireless/marvell/mwl8k.c                              |    4 
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c                |    3 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c             |    2 
 drivers/net/wireless/realtek/rtlwifi/pci.c                        |   23 
 drivers/net/xen-netfront.c                                        |    5 
 drivers/nvme/host/core.c                                          |    4 
 drivers/pci/controller/pcie-rockchip-host.c                       |    2 
 drivers/pci/controller/vmd.c                                      |    3 
 drivers/pci/endpoint/functions/pci-epf-vntb.c                     |    4 
 drivers/pci/endpoint/pci-ep-cfs.c                                 |    1 
 drivers/pci/endpoint/pci-epf-core.c                               |    2 
 drivers/pci/hotplug/pnv_php.c                                     |  233 +++++++
 drivers/pci/pci-acpi.c                                            |    4 
 drivers/pci/pci.c                                                 |    8 
 drivers/pci/probe.c                                               |    2 
 drivers/phy/tegra/xusb-tegra186.c                                 |   59 +-
 drivers/pinctrl/mediatek/pinctrl-moore.c                          |   18 
 drivers/pinctrl/stm32/pinctrl-stm32.c                             |    1 
 drivers/pinctrl/sunxi/pinctrl-sunxi.c                             |   11 
 drivers/platform/chrome/cros_ec.c                                 |   23 
 drivers/platform/chrome/cros_ec.h                                 |    2 
 drivers/platform/chrome/cros_ec_i2c.c                             |    4 
 drivers/platform/chrome/cros_ec_lpc.c                             |    4 
 drivers/platform/chrome/cros_ec_spi.c                             |    4 
 drivers/platform/chrome/cros_ec_typec.c                           |    4 
 drivers/platform/x86/ideapad-laptop.c                             |    2 
 drivers/platform/x86/think-lmi.c                                  |   27 
 drivers/platform/x86/thinkpad_acpi.c                              |    4 
 drivers/power/supply/cpcap-charger.c                              |    5 
 drivers/power/supply/max14577_charger.c                           |    4 
 drivers/powercap/intel_rapl_common.c                              |   23 
 drivers/pps/clients/pps-gpio.c                                    |    5 
 drivers/pps/pps.c                                                 |   11 
 drivers/ptp/ptp_private.h                                         |    5 
 drivers/ptp/ptp_vclock.c                                          |    7 
 drivers/pwm/pwm-imx-tpm.c                                         |    9 
 drivers/pwm/pwm-mediatek.c                                        |   78 +-
 drivers/regulator/core.c                                          |    1 
 drivers/reset/Kconfig                                             |   10 
 drivers/rtc/rtc-ds1307.c                                          |   17 
 drivers/rtc/rtc-hym8563.c                                         |    2 
 drivers/rtc/rtc-pcf85063.c                                        |    2 
 drivers/rtc/rtc-pcf8563.c                                         |    2 
 drivers/rtc/rtc-rv3028.c                                          |    2 
 drivers/scsi/aacraid/comminit.c                                   |    3 
 drivers/scsi/bfa/bfad_im.c                                        |    1 
 drivers/scsi/ibmvscsi_tgt/libsrp.c                                |    6 
 drivers/scsi/isci/request.c                                       |    2 
 drivers/scsi/libiscsi.c                                           |    3 
 drivers/scsi/lpfc/lpfc_debugfs.c                                  |    1 
 drivers/scsi/lpfc/lpfc_scsi.c                                     |    4 
 drivers/scsi/mpi3mr/mpi3mr.h                                      |    6 
 drivers/scsi/mpi3mr/mpi3mr_fw.c                                   |   17 
 drivers/scsi/mpi3mr/mpi3mr_os.c                                   |    2 
 drivers/scsi/mpt3sas/mpt3sas_scsih.c                              |   22 
 drivers/scsi/mvsas/mv_sas.c                                       |    4 
 drivers/scsi/qla4xxx/ql4_os.c                                     |    2 
 drivers/scsi/scsi_scan.c                                          |    2 
 drivers/scsi/scsi_transport_sas.c                                 |   60 +-
 drivers/scsi/ufs/ufs-exynos.c                                     |    4 
 drivers/scsi/ufs/ufshcd-pci.c                                     |   42 +
 drivers/scsi/ufs/ufshcd.c                                         |   10 
 drivers/soc/aspeed/aspeed-lpc-snoop.c                             |   13 
 drivers/soc/qcom/mdt_loader.c                                     |   41 +
 drivers/soc/tegra/pmc.c                                           |   51 -
 drivers/soundwire/stream.c                                        |    2 
 drivers/staging/fbtft/fbtft-core.c                                |    1 
 drivers/staging/media/imx/imx-media-csc-scaler.c                  |    2 
 drivers/staging/nvec/nvec_power.c                                 |    2 
 drivers/target/target_core_fabric_lib.c                           |   63 +-
 drivers/target/target_core_internal.h                             |    4 
 drivers/target/target_core_pr.c                                   |   18 
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c                       |   43 +
 drivers/thermal/thermal_sysfs.c                                   |    9 
 drivers/thunderbolt/domain.c                                      |    2 
 drivers/thunderbolt/switch.c                                      |    2 
 drivers/tty/serial/8250/8250_port.c                               |    3 
 drivers/tty/serial/pch_uart.c                                     |    2 
 drivers/tty/vt/defkeymap.c_shipped                                |  112 +++
 drivers/tty/vt/keyboard.c                                         |    2 
 drivers/usb/atm/cxacru.c                                          |  106 +--
 drivers/usb/chipidea/ci.h                                         |   18 
 drivers/usb/chipidea/udc.c                                        |   10 
 drivers/usb/class/cdc-acm.c                                       |   11 
 drivers/usb/core/config.c                                         |   10 
 drivers/usb/core/hcd.c                                            |    8 
 drivers/usb/core/hub.c                                            |   60 +-
 drivers/usb/core/hub.h                                            |    1 
 drivers/usb/core/quirks.c                                         |    1 
 drivers/usb/core/urb.c                                            |    2 
 drivers/usb/dwc3/dwc3-imx8mp.c                                    |    6 
 drivers/usb/dwc3/dwc3-meson-g12a.c                                |    3 
 drivers/usb/dwc3/dwc3-qcom.c                                      |    7 
 drivers/usb/dwc3/ep0.c                                            |   20 
 drivers/usb/dwc3/gadget.c                                         |   19 
 drivers/usb/early/xhci-dbc.c                                      |    4 
 drivers/usb/gadget/composite.c                                    |    5 
 drivers/usb/gadget/configfs.c                                     |    2 
 drivers/usb/gadget/udc/renesas_usb3.c                             |    1 
 drivers/usb/host/xhci-hub.c                                       |    3 
 drivers/usb/host/xhci-mem.c                                       |   24 
 drivers/usb/host/xhci-pci-renesas.c                               |    7 
 drivers/usb/host/xhci-ring.c                                      |   19 
 drivers/usb/host/xhci.c                                           |   24 
 drivers/usb/host/xhci.h                                           |    3 
 drivers/usb/misc/apple-mfi-fastcharge.c                           |   24 
 drivers/usb/musb/musb_core.c                                      |   62 +-
 drivers/usb/musb/musb_core.h                                      |   11 
 drivers/usb/musb/musb_debugfs.c                                   |    6 
 drivers/usb/musb/musb_gadget.c                                    |   30 -
 drivers/usb/musb/musb_host.c                                      |    6 
 drivers/usb/musb/musb_virthub.c                                   |   18 
 drivers/usb/musb/omap2430.c                                       |   16 
 drivers/usb/phy/phy-mxs-usb.c                                     |    4 
 drivers/usb/serial/ftdi_sio.c                                     |    2 
 drivers/usb/serial/ftdi_sio_ids.h                                 |    3 
 drivers/usb/serial/option.c                                       |    7 
 drivers/usb/storage/realtek_cr.c                                  |    2 
 drivers/usb/storage/unusual_devs.h                                |   29 
 drivers/usb/typec/mux/intel_pmc_mux.c                             |    2 
 drivers/usb/typec/tcpm/fusb302.c                                  |    8 
 drivers/usb/typec/tcpm/tcpm.c                                     |   64 +-
 drivers/usb/typec/ucsi/psy.c                                      |    2 
 drivers/usb/typec/ucsi/ucsi.c                                     |    1 
 drivers/usb/typec/ucsi/ucsi.h                                     |    7 
 drivers/vhost/scsi.c                                              |    4 
 drivers/vhost/vhost.c                                             |    3 
 drivers/video/console/vgacon.c                                    |    2 
 drivers/video/fbdev/core/fbcon.c                                  |    9 
 drivers/video/fbdev/imxfb.c                                       |    9 
 drivers/watchdog/dw_wdt.c                                         |    2 
 drivers/watchdog/iTCO_wdt.c                                       |    6 
 drivers/watchdog/sbsa_gwdt.c                                      |   50 +
 drivers/watchdog/ziirave_wdt.c                                    |    3 
 drivers/xen/gntdev-common.h                                       |    4 
 drivers/xen/gntdev.c                                              |   71 +-
 fs/btrfs/relocation.c                                             |   19 
 fs/btrfs/tree-log.c                                               |   53 +
 fs/buffer.c                                                       |    2 
 fs/cifs/cifssmb.c                                                 |   10 
 fs/cifs/file.c                                                    |   10 
 fs/cifs/smb2ops.c                                                 |    7 
 fs/cifs/smbdirect.c                                               |   14 
 fs/eventpoll.c                                                    |   60 +-
 fs/ext2/inode.c                                                   |   12 
 fs/ext4/fsmap.c                                                   |   23 
 fs/ext4/indirect.c                                                |    4 
 fs/ext4/inline.c                                                  |   19 
 fs/ext4/inode.c                                                   |    2 
 fs/ext4/mballoc.c                                                 |   33 -
 fs/ext4/orphan.c                                                  |    5 
 fs/ext4/super.c                                                   |    2 
 fs/f2fs/extent_cache.c                                            |    2 
 fs/f2fs/f2fs.h                                                    |    2 
 fs/f2fs/inode.c                                                   |   28 
 fs/f2fs/node.c                                                    |   10 
 fs/file.c                                                         |   90 +--
 fs/hfs/bnode.c                                                    |   93 +++
 fs/hfsplus/bnode.c                                                |   92 +++
 fs/hfsplus/extents.c                                              |    3 
 fs/hfsplus/unicode.c                                              |    7 
 fs/hfsplus/xattr.c                                                |    6 
 fs/hugetlbfs/inode.c                                              |    2 
 fs/isofs/inode.c                                                  |    9 
 fs/jbd2/checkpoint.c                                              |    1 
 fs/jfs/file.c                                                     |    3 
 fs/jfs/inode.c                                                    |    2 
 fs/jfs/jfs_dmap.c                                                 |   10 
 fs/jfs/jfs_imap.c                                                 |   13 
 fs/ksmbd/smb2pdu.c                                                |   16 
 fs/ksmbd/smb_common.c                                             |    2 
 fs/ksmbd/transport_rdma.c                                         |   97 +--
 fs/libfs.c                                                        |    4 
 fs/namespace.c                                                    |   39 -
 fs/nfs/blocklayout/blocklayout.c                                  |    4 
 fs/nfs/blocklayout/dev.c                                          |    5 
 fs/nfs/blocklayout/extent_tree.c                                  |   20 
 fs/nfs/client.c                                                   |   44 +
 fs/nfs/export.c                                                   |   11 
 fs/nfs/flexfilelayout/flexfilelayout.c                            |   26 
 fs/nfs/flexfilelayout/flexfilelayoutdev.c                         |    6 
 fs/nfs/internal.h                                                 |   10 
 fs/nfs/nfs4client.c                                               |   15 
 fs/nfs/nfs4proc.c                                                 |   12 
 fs/nfs/pnfs.c                                                     |   11 
 fs/nfsd/nfs4state.c                                               |   34 -
 fs/nilfs2/inode.c                                                 |    9 
 fs/ntfs3/dir.c                                                    |    3 
 fs/ntfs3/file.c                                                   |    5 
 fs/ntfs3/inode.c                                                  |   31 -
 fs/orangefs/orangefs-debugfs.c                                    |    8 
 fs/squashfs/super.c                                               |   14 
 fs/udf/super.c                                                    |   13 
 include/asm-generic/barrier.h                                     |   33 +
 include/linux/bitmap.h                                            |    2 
 include/linux/blk_types.h                                         |    8 
 include/linux/compiler.h                                          |    8 
 include/linux/cpuset.h                                            |   17 
 include/linux/fs.h                                                |    4 
 include/linux/fs_context.h                                        |    2 
 include/linux/if_vlan.h                                           |    6 
 include/linux/memfd.h                                             |   14 
 include/linux/mlx5/device.h                                       |    1 
 include/linux/mm.h                                                |   80 +-
 include/linux/mmzone.h                                            |   22 
 include/linux/moduleparam.h                                       |    5 
 include/linux/pci.h                                               |   10 
 include/linux/platform_data/cros_ec_proto.h                       |    4 
 include/linux/pps_kernel.h                                        |    1 
 include/linux/sched.h                                             |    1 
 include/linux/skbuff.h                                            |   31 +
 include/linux/usb/usbnet.h                                        |    1 
 include/linux/xarray.h                                            |   15 
 include/net/bond_3ad.h                                            |    1 
 include/net/cfg80211.h                                            |    2 
 include/net/mac80211.h                                            |    2 
 include/net/tc_act/tc_ctinfo.h                                    |    6 
 include/net/udp.h                                                 |   24 
 include/sound/soc-dai.h                                           |   13 
 include/uapi/linux/in6.h                                          |    4 
 include/uapi/linux/io_uring.h                                     |    2 
 kernel/bpf/helpers.c                                              |   11 
 kernel/cgroup/cpuset.c                                            |   23 
 kernel/events/core.c                                              |   20 
 kernel/fork.c                                                     |    2 
 kernel/power/console.c                                            |    7 
 kernel/rcu/tree_plugin.h                                          |    3 
 kernel/sched/core.c                                               |   19 
 kernel/sched/deadline.c                                           |    4 
 kernel/sched/loadavg.c                                            |    2 
 kernel/sched/rt.c                                                 |    6 
 kernel/sched/sched.h                                              |    2 
 kernel/trace/ftrace.c                                             |   19 
 kernel/trace/preemptirq_delay_test.c                              |   13 
 kernel/trace/trace.c                                              |   33 -
 kernel/trace/trace.h                                              |    8 
 kernel/trace/trace_events.c                                       |    5 
 kernel/ucount.c                                                   |    2 
 lib/bitmap.c                                                      |   13 
 mm/debug_vm_pgtable.c                                             |    9 
 mm/filemap.c                                                      |    2 
 mm/hmm.c                                                          |    2 
 mm/kmemleak.c                                                     |   10 
 mm/madvise.c                                                      |    2 
 mm/memfd.c                                                        |    2 
 mm/memory-failure.c                                               |    8 
 mm/mmap.c                                                         |   10 
 mm/page_alloc.c                                                   |   13 
 mm/ptdump.c                                                       |    2 
 mm/shmem.c                                                        |    2 
 mm/vmalloc.c                                                      |   17 
 mm/zsmalloc.c                                                     |    3 
 net/8021q/vlan.c                                                  |   42 +
 net/8021q/vlan.h                                                  |    1 
 net/appletalk/aarp.c                                              |   24 
 net/bluetooth/l2cap_core.c                                        |   26 
 net/bluetooth/l2cap_sock.c                                        |    3 
 net/bluetooth/smp.c                                               |   21 
 net/bluetooth/smp.h                                               |    1 
 net/bridge/br_multicast.c                                         |   16 
 net/bridge/br_private.h                                           |    2 
 net/bridge/br_switchdev.c                                         |    3 
 net/caif/cfctrl.c                                                 |  294 ++++------
 net/core/filter.c                                                 |    3 
 net/core/netpoll.c                                                |    7 
 net/core/skmsg.c                                                  |   57 +
 net/hsr/hsr_slave.c                                               |    8 
 net/ipv4/netfilter/nf_reject_ipv4.c                               |    6 
 net/ipv4/route.c                                                  |    1 
 net/ipv4/tcp_input.c                                              |    3 
 net/ipv4/udp_offload.c                                            |    2 
 net/ipv6/addrconf.c                                               |    7 
 net/ipv6/ip6_offload.c                                            |    4 
 net/ipv6/mcast.c                                                  |   13 
 net/ipv6/netfilter/nf_reject_ipv6.c                               |    5 
 net/ipv6/rpl_iptunnel.c                                           |    8 
 net/ipv6/seg6_hmac.c                                              |    6 
 net/mac80211/cfg.c                                                |   13 
 net/mac80211/mlme.c                                               |    9 
 net/mac80211/tx.c                                                 |   10 
 net/mctp/af_mctp.c                                                |   26 
 net/mptcp/options.c                                               |    7 
 net/mptcp/pm_netlink.c                                            |   14 
 net/mptcp/protocol.c                                              |   17 
 net/mptcp/protocol.h                                              |   11 
 net/mptcp/subflow.c                                               |   20 
 net/ncsi/internal.h                                               |    2 
 net/ncsi/ncsi-rsp.c                                               |    1 
 net/netfilter/nf_conntrack_netlink.c                              |   24 
 net/netfilter/nf_tables_api.c                                     |    4 
 net/netfilter/xt_nfacct.c                                         |    4 
 net/netlink/af_netlink.c                                          |    2 
 net/packet/af_packet.c                                            |   39 -
 net/phonet/pep.c                                                  |    2 
 net/sched/act_ctinfo.c                                            |   19 
 net/sched/sch_cake.c                                              |   14 
 net/sched/sch_codel.c                                             |    5 
 net/sched/sch_drr.c                                               |    7 
 net/sched/sch_ets.c                                               |   46 -
 net/sched/sch_fq_codel.c                                          |    6 
 net/sched/sch_hfsc.c                                              |    8 
 net/sched/sch_htb.c                                               |   19 
 net/sched/sch_netem.c                                             |   40 +
 net/sched/sch_qfq.c                                               |   40 -
 net/sctp/input.c                                                  |    2 
 net/tls/tls_sw.c                                                  |   13 
 net/vmw_vsock/af_vsock.c                                          |    3 
 net/wireless/mlme.c                                               |    3 
 samples/mei/mei-amt-version.c                                     |    2 
 scripts/kconfig/gconf.c                                           |    8 
 scripts/kconfig/lxdialog/inputbox.c                               |    6 
 scripts/kconfig/lxdialog/menubox.c                                |    2 
 scripts/kconfig/nconf.c                                           |    2 
 scripts/kconfig/nconf.gui.c                                       |    1 
 scripts/kconfig/qconf.cc                                          |    2 
 security/apparmor/include/match.h                                 |    3 
 security/apparmor/match.c                                         |    1 
 security/inode.c                                                  |    2 
 sound/core/pcm_native.c                                           |   19 
 sound/pci/hda/patch_ca0132.c                                      |    7 
 sound/pci/hda/patch_hdmi.c                                        |   19 
 sound/pci/hda/patch_realtek.c                                     |    3 
 sound/pci/intel8x0.c                                              |    2 
 sound/soc/codecs/hdac_hdmi.c                                      |   10 
 sound/soc/codecs/rt5640.c                                         |    5 
 sound/soc/fsl/fsl_sai.c                                           |   30 -
 sound/soc/generic/audio-graph-card.c                              |    2 
 sound/soc/intel/boards/Kconfig                                    |    2 
 sound/soc/soc-core.c                                              |   28 
 sound/soc/soc-dai.c                                               |   59 +-
 sound/soc/soc-dapm.c                                              |    4 
 sound/soc/soc-ops.c                                               |   26 
 sound/usb/mixer_quirks.c                                          |   14 
 sound/usb/mixer_scarlett_gen2.c                                   |    8 
 sound/usb/stream.c                                                |   25 
 sound/usb/validate.c                                              |   14 
 sound/x86/intel_hdmi_audio.c                                      |    2 
 tools/bpf/bpftool/net.c                                           |   15 
 tools/include/linux/sched/mm.h                                    |    2 
 tools/include/nolibc/std.h                                        |    4 
 tools/perf/builtin-sched.c                                        |   12 
 tools/perf/tests/bp_account.c                                     |    1 
 tools/perf/util/evsel.c                                           |   11 
 tools/perf/util/evsel.h                                           |    2 
 tools/power/cpupower/utils/idle_monitor/mperf_monitor.c           |    4 
 tools/testing/ktest/ktest.pl                                      |    5 
 tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc   |   28 
 tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc  |    2 
 tools/testing/selftests/futex/include/futextest.h                 |   11 
 tools/testing/selftests/memfd/memfd_test.c                        |   43 +
 tools/testing/selftests/net/mptcp/Makefile                        |    3 
 tools/testing/selftests/net/mptcp/mptcp_connect.c                 |   28 
 tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh       |    5 
 tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh           |    5 
 tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh       |    5 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                   |    1 
 tools/testing/selftests/net/mptcp/pm_netlink.sh                   |    1 
 tools/testing/selftests/net/rtnetlink.sh                          |    6 
 tools/testing/selftests/net/udpgro.sh                             |   46 -
 tools/testing/selftests/perf_events/.gitignore                    |    1 
 tools/testing/selftests/perf_events/Makefile                      |    2 
 tools/testing/selftests/perf_events/mmap.c                        |  236 ++++++++
 tools/testing/selftests/syscall_user_dispatch/sud_test.c          |   50 -
 677 files changed, 6071 insertions(+), 2522 deletions(-)

Aaron Kling (1):
      ARM: tegra: Use I/O memcpy to write to IRAM

Aaron Plattner (1):
      watchdog: sbsa: Adjust keepalive timeout to avoid MediaTek WS0 race condition

Abdun Nihaal (2):
      regmap: fix potential memory leak of regmap_bus
      staging: fbtft: fix potential memory leak in fbtft_framebuffer_alloc()

Abinash Singh (1):
      f2fs: fix KMSAN uninit-value in extent_info usage

Ada Couprie Diaz (1):
      arm64/entry: Mask DAIF in cpu_switch_to(), call_on_irq_stack()

Adam Ford (2):
      arm64: dts: imx8mm-beacon: Fix HS400 USDHC clock speed
      arm64: dts: imx8mn-beacon: Fix HS400 USDHC clock speed

Aditya Garg (1):
      HID: magicmouse: avoid setting up battery timer when not needed

Adrian Hunter (1):
      scsi: ufs: ufs-pci: Fix default runtime and system PM levels

Al Viro (5):
      clone_private_mnt(): make sure that caller has CAP_SYS_ADMIN in the right userns
      better lockdep annotations for simple_recursive_removal()
      securityfs: don't pin dentries twice, once is enough...
      use uniform permission checks for all mount propagation changes
      alloc_fdtable(): change calling conventions.

Albin Törnqvist (1):
      arm: dts: ti: omap: Fixup pinheader typo

Alessandro Carminati (1):
      regulator: core: fix NULL dereference on unbind due to stale coupling data

Alex Guo (2):
      media: dvb-frontends: dib7090p: fix null-ptr-deref in dib7090p_rw_on_apb()
      media: dvb-frontends: w7090p: fix null-ptr-deref in w7090p_tuner_write_serpar and w7090p_tuner_read_serpar

Alexander Gordeev (1):
      mm/vmalloc: leave lazy MMU mode on PTE mapping error

Alexander Kochetkov (1):
      ARM: rockchip: fix kernel hang during smp initialization

Alexander Wetzel (1):
      wifi: mac80211: Don't call fq_flow_idx() for management frames

Alexander Wilhelm (1):
      bus: mhi: host: Fix endianness of BHI vector table

Alok Tiwari (7):
      thunderbolt: Fix bit masking in tb_dp_port_set_hops()
      net: emaclite: Fix missing pointer increment in aligned_read()
      staging: nvec: Fix incorrect null termination of battery manufacturer
      ALSA: intel8x0: Fix incorrect codec index usage in mixer for ICH4
      be2net: Use correct byte order and format string for TCP seq and ack_seq
      net: thunderx: Fix format-truncation warning in bgx_acpi_match_id()
      gve: Return error for unknown admin queue command

Amir Mohammad Jahangirzad (1):
      fs/orangefs: use snprintf() instead of sprintf()

Ammar Faizi (1):
      net: usbnet: Fix the wrong netif_carrier_on() call

Anantha Prabhu (1):
      RDMA/bnxt_re: Fix to initialize the PBL array

Andreas Dilger (1):
      ext4: check fast symlink for ea_inode correctly

Andrew Jeffery (2):
      soc: aspeed: lpc-snoop: Cleanup resources in stack-order
      soc: aspeed: lpc-snoop: Don't disable channels that aren't enabled

André Draszik (1):
      scsi: ufs: exynos: Fix programming of HCI_UTRL_NEXUS_TYPE

Andy Shevchenko (2):
      mm/hmm: move pmd_to_hmm_pfn_flags() to the respective #ifdeffery
      Documentation: ACPI: Fix parent device references

Andy Yan (1):
      drm/rockchip: cleanup fb when drm_gem_fb_afbc_init failed

Anna Schumaker (1):
      NFS: Create an nfs4_server_set_init_caps() function

Annette Kobou (1):
      ARM: dts: imx6ul-kontron-bl-common: Fix RTS polarity for RS485 interface

Anshuman Khandual (1):
      mm/ptdump: take the memory hotplug lock inside ptdump_walk_pgd()

Anthoine Bourgeois (1):
      xen/netfront: Fix TX response spurious interrupts

Archana Patni (1):
      scsi: ufs: ufs-pci: Fix hibernate state transition for Intel MTL-like host controllers

Arnaud Lecomte (1):
      jfs: upper bound check of tree index in dbAllocAG

Arnd Bergmann (6):
      ethernet: intel: fix building with large NR_CPUS
      ASoC: Intel: fix SND_SOC_SOF dependencies
      ASoC: ops: dynamically allocate struct snd_ctl_elem_value
      caif: reduce stack size, again
      kernel: trace: preemptirq_delay_test: use offstack cpu mask
      RDMA/core: reduce stack using in nldev_stat_get_doit()

Arun Raghavan (1):
      ASoC: fsl_sai: Force a software reset when starting in consumer mode

Aruna Ramakrishna (1):
      sched: Change nr_uninterruptible type to unsigned long

Avraham Stern (1):
      wifi: iwlwifi: mvm: fix scan request validation

Baihan Li (1):
      drm/hisilicon/hibmc: fix the hibmc loaded failed bug

Balamanikandan Gunasundar (1):
      mtd: rawnand: atmel: set pmecc data setup time

Baokun Li (2):
      ext4: fix largest free orders lists corruption on mb_optimize_scan switch
      jbd2: prevent softlockup in jbd2_log_do_checkpoint()

Bard Liao (1):
      soundwire: stream: restore params when prepare ports fail

Bartosz Golaszewski (2):
      gpio: wcd934x: check the return value of regmap_update_bits()
      gpio: tps65912: check the return value of regmap_update_bits()

Ben Ben-Ishay (1):
      net/mlx5e: Add support to klm_umr_wqe

Ben Hutchings (1):
      sh: Do not use hyphen in exported variable name

Benjamin Coddington (1):
      NFS: Fixup allocation flags for nfsiod's __GFP_NORETRY

Benjamin Tissoires (3):
      HID: core: ensure the allocated report buffer can contain the reserved report ID
      HID: core: ensure __hid_request reserves the report ID as the first byte
      HID: core: do not bypass hid_hw_raw_request

Benson Leung (1):
      usb: typec: ucsi: psy: Set current max to 100mA for BC 1.2 and Default

Bharat Bhushan (1):
      crypto: octeontx2 - add timeout for load_fvc completion poll

Bingbu Cao (1):
      media: hi556: correct the test pattern configuration

Bjorn Andersson (1):
      soc: qcom: mdt_loader: Ensure we don't read past the ELF header

Brahmajit Das (1):
      samples: mei: Fix building on musl libc

Breno Leitao (4):
      ACPI: APEI: GHES: add TAINT_MACHINE_CHECK on GHES panic path
      arm64: Mark kernel as tainted on SAE and SError panic
      ipmi: Use dev_warn_ratelimited() for incorrect message warnings
      mm/kmemleak: avoid deadlock by moving pr_warn() outside kmemleak_lock

Brian Masney (5):
      rtc: ds1307: fix incorrect maximum clock rate handling
      rtc: hym8563: fix incorrect maximum clock rate handling
      rtc: pcf85063: fix incorrect maximum clock rate handling
      rtc: pcf8563: fix incorrect maximum clock rate handling
      rtc: rv3028: fix incorrect maximum clock rate handling

Buday Csaba (1):
      net: phy: smsc: add proper reset flags for LAN8710A

Budimir Markovic (1):
      vsock: Do not allow binding to VMADDR_PORT_ANY

Chao Gao (1):
      KVM: VMX: Flush shadow VMCS on emergency reboot

Chao Yu (6):
      f2fs: doc: fix wrong quota mount option description
      f2fs: fix to avoid UAF in f2fs_sync_inode_meta()
      f2fs: fix to avoid panic in f2fs_evict_inode
      f2fs: fix to avoid out-of-boundary access in devs.path
      f2fs: fix to do sanity check on ino and xnid
      f2fs: fix to avoid out-of-boundary access in dnode page

Charalampos Mitrodimas (1):
      usb: misc: apple-mfi-fastcharge: Make power supply names unique

Charles Han (2):
      power: supply: cpcap-charger: Fix null check for power_supply_get_by_name
      power: supply: max14577: Handle NULL pdata when CONFIG_OF is not set

Cheick Traore (1):
      pinctrl: stm32: Manage irq affinity settings

Chen Ni (1):
      iio: adc: stm32-adc: Fix race in installing chained IRQ handler

Chen-Yu Tsai (1):
      platform/chrome: cros_ec: Use per-device lockdep key

Chenyuan Yang (2):
      fbdev: imxfb: Check fb_add_videomode to prevent null-ptr-deref
      drm/amd/display: Add null pointer check in mod_hdcp_hdcp1_create_session()

Christoph Paasch (3):
      net/mlx5: Correctly set gso_size when LRO is used
      net/mlx5: Correctly set gso_segs when LRO is used
      mptcp: drop skb if MPTCP skb extension allocation fails

Christophe Leroy (1):
      ALSA: pcm: Rewrite recalculate_boundary() to avoid costly loop

Clément Le Goffic (1):
      i2c: stm32: fix the device used for the DMA map

Cong Wang (6):
      sch_htb: make htb_qlen_notify() idempotent
      sch_hfsc: make hfsc_qlen_notify() idempotent
      sch_qfq: make qfq_qlen_notify() idempotent
      sch_drr: make drr_qlen_notify() idempotent
      codel: remove sch->q.qlen check before qdisc_tree_reduce_backlog()
      sch_htb: make htb_deactivate() idempotent

Corey Minyard (1):
      ipmi: Fix strcpy source and destination the same

Cristian Ciocaltea (1):
      ALSA: usb-audio: Avoid precedence issues in mixer_quirks macros

Cynthia Huang (1):
      selftests/futex: Define SYS_futex on 32-bit architectures with 64-bit time_t

Dai Ngo (1):
      NFSD: detect mismatch of file handle and delegation stateid in OPEN op

Damien Le Moal (7):
      ata: libata-sata: Disallow changing LPM state if not supported
      scsi: mpt3sas: Correctly handle ATA device errors
      ata: libata-scsi: Fix ata_to_sense_error() status handling
      PCI: endpoint: Fix configfs group list head handling
      PCI: endpoint: Fix configfs group removal on driver teardown
      block: Make REQ_OP_ZONE_FINISH a write operation
      ata: Fix SATA_MOBILE_LPM_POLICY description in Kconfig

Dan Carpenter (7):
      dmaengine: nbpfaxi: Fix memory corruption in probe()
      watchdog: ziirave_wdt: check record length in ziirave_firm_verify()
      fs/orangefs: Allow 2 more characters in do_c_string()
      cpufreq: armada-8k: Fix off by one in armada_8k_cpufreq_free_table()
      media: gspca: Add bounds checking to firmware parser
      scsi: qla4xxx: Prevent a potential error pointer dereference
      ALSA: usb-audio: Fix size validation in convert_chmap_v3()

Daniel Dadap (1):
      ALSA: hda: Add missing NVIDIA HDA codec IDs

Daniil Dulov (1):
      wifi: rtl818x: Kill URBs before clearing tx status queue

Dave Hansen (1):
      x86/fpu: Delay instruction pointer fixup until after warning

Dave Stevenson (3):
      media: tc358743: Check I2C succeeded during probe
      media: tc358743: Return an appropriate colorspace from tc358743_set_fmt
      media: tc358743: Increase FIFO trigger level to 374

David Collins (1):
      thermal/drivers/qcom-spmi-temp-alarm: Enable stage 2 shutdown when required

David Lechner (2):
      iio: proximity: isl29501: fix buffered read on big-endian systems
      iio: adc: ad_sigma_delta: change to buffer predisable

Davide Caratti (2):
      net/sched: sch_ets: properly init all active DRR list handles
      net/sched: ets: use old 'nbands' while purging unused classes

Dawid Rezler (1):
      ALSA: hda/realtek - Add mute LED support for HP Pavilion 15-eg0xxx

Denis OSTERLAND-HEIM (1):
      pps: fix poll support

Dennis Chen (1):
      i40e: report VF tx_dropped with tx_errors instead of tx_discards

Dikshita Agarwal (1):
      media: venus: Add support for SSR trigger using fault injection

Dmitry Antipov (1):
      jfs: reject on-disk inodes of an unsupported type

Dmitry Vyukov (1):
      selftests: Fix errno checking in syscall_user_dispatch test

Dong Chenchen (1):
      net: vlan: fix VLAN 0 refcount imbalance of toggling filtering during runtime

Drew Hamilton (1):
      usb: musb: fix gadget state on disconnect

Edson Juliano Drosdeck (1):
      mmc: sdhci-pci: Quirk for broken command queuing on Intel GLK-based Positivo models

Edward Adam Davis (2):
      jfs: Regular file corruption check
      comedi: pcl726: Prevent invalid irq number

Eliav Farber (1):
      pps: clients: gpio: fix interrupt handling order in remove path

Emily Deng (1):
      drm/ttm: Should to return the evict error

Eric Biggers (3):
      thunderbolt: Fix copy+paste error in match_service_id()
      lib/crypto: mips/chacha: Fix clang build and remove unneeded byteswap
      ipv6: sr: Fix MAC comparison to be constant-time

Eric Dumazet (5):
      net_sched: act_ctinfo: use atomic64_t for three counters
      pptp: ensure minimal skb length in pptp_xmit()
      ipv6: reject malicious packets in ipv6_gso_segment()
      pptp: fix pptp_xmit() error path
      net_sched: sch_ets: implement lockless ets_dump()

Eric Work (1):
      net: atlantic: add set_power to fw_ops for atl2 to fix wol

Evgeniy Harchenko (1):
      ALSA: hda/realtek: Add support for HP EliteBook x360 830 G6 and EliteBook 830 G6

Fabio Estevam (2):
      iio: adc: max1363: Fix MAX1363_4X_CHANS/MAX1363_8X_CHANS[]
      iio: adc: max1363: Reorder mode_list[] entries

Fabio Porcedda (1):
      USB: serial: option: add Telit Cinterion FE910C04 (ECM) composition

Fabrice Gasnier (1):
      Input: gpio-keys - fix a sleep while atomic with PREEMPT_RT

Fedor Pchelkin (3):
      drm/amd/pm/powerplay/hwmgr/smu_helper: fix order of mask and value
      netfilter: nf_tables: adjust lockdep assertions handling
      netlink: avoid infinite retry looping in netlink_unicast()

Feng Tang (1):
      mm/page_alloc: detect allocation forbidden by cpuset and bail out early

Filipe Manana (1):
      btrfs: fix log tree replay failure due to file with 0 links and extents

Finn Thain (2):
      m68k: Don't unregister boot console needlessly
      m68k: Fix lost column on framebuffer debug console

Florian Westphal (4):
      netfilter: xt_nfacct: don't assume acct name is null-terminated
      netfilter: ctnetlink: fix refcount leak on table dump
      selftests: mptcp: make sendfile selftest work
      netfilter: nf_reject: don't leak dst refcount for loopback packets

Gabor Juhos (1):
      mtd: spinand: propagate spinand_wait() errors from spinand_write_page()

Gal Pressman (1):
      net: vlan: Replace BUG() with WARN_ON_ONCE() in vlan_dev_* stubs

Gautham R. Shenoy (1):
      pm: cpupower: Fix the snapshot-order of tsc,mperf, clock in mperf_stop()

Geliang Tang (2):
      mptcp: drop unused sk in mptcp_push_release
      mptcp: disable add_addr retransmission when timeout is 0

Geoffrey D. Bennett (1):
      ALSA: scarlett2: Add retry on -EPROTO from scarlett2_usb_tx()

Giovanni Cabiddu (1):
      crypto: qat - fix seq_file position update in adf_ring_next()

Gokul Sivakumar (1):
      wifi: brcmfmac: fix P2P discovery failure in P2P peer due to missing P2P IE

Greg Kroah-Hartman (2):
      Revert "vmci: Prevent the dispatching of uninitialized payloads"
      Linux 5.15.190

Gui-Dong Han (1):
      media: rainshadow-cec: fix TOCTOU race condition in rain_interrupt()

Haiyang Zhang (1):
      hv_netvsc: Fix panic during namespace deletion with VF

Hangbin Liu (2):
      selftests: udpgro: report error when receive failed
      bonding: update LACP activity flag after setting lacp_active

Hans Zhang (1):
      PCI: rockchip-host: Fix "Unexpected Completion" log message

Haoxiang Li (2):
      media: imx: fix a potential memory leak in imx_media_csc_scaler_device_init()
      ice: Fix a null pointer dereference in ice_copy_and_init_pkg()

Harald Mommer (1):
      gpio: virtio: Fix config space reading.

Hari Kalavakunta (1):
      net: ncsi: Fix buffer overflow in fetching version id

Harry Yoo (1):
      mm/zsmalloc: do not pass __GFP_MOVABLE if CONFIG_COMPACTION=n

Heiner Kallweit (1):
      dpaa_eth: don't use fixed_phy_change_carrier

Helge Deller (1):
      Revert "vgacon: Add check for vc_origin address range in vgacon_scroll()"

Henry Martin (1):
      clk: davinci: Add NULL check in davinci_lpsc_clk_register()

Herbert Xu (1):
      crypto: marvell/cesa - Fix engine load inaccuracy

Herton R. Krzesinski (1):
      mm/debug_vm_pgtable: clear page table entries at destroy_args()

Horatiu Vultur (2):
      phy: mscc: Fix parsing of unicast frames
      phy: mscc: Fix timestamping for vsc8584

Hsin-Te Yuan (1):
      thermal: sysfs: Return ENODATA instead of EAGAIN for reads

Ian Abbott (12):
      comedi: pcl812: Fix bit shift out of bounds
      comedi: aio_iiro_16: Fix bit shift out of bounds
      comedi: das16m1: Fix bit shift out of bounds
      comedi: das6402: Fix bit shift out of bounds
      comedi: Fail COMEDI_INSNLIST ioctl if n_insns is too large
      comedi: Fix some signed shift left operations
      comedi: Fix use of uninitialized data in insn_rw_emulate_bits()
      comedi: Fix initialization of data for instructions that write to subdevice
      comedi: comedi_test: Fix possible deletion of uninitialized timers
      comedi: fix race between polling and detaching
      comedi: Make insn_rw_emulate_bits() do insn->n samples
      comedi: Fix use of uninitialized memory in do_insn_ioctl() and do_insnlist_ioctl()

Ido Schimmel (1):
      mlxsw: spectrum: Forward packets with an IPv4 link-local source IP

Ilan Peer (1):
      wifi: cfg80211: Fix interface type validation

Ilya Bakoulin (1):
      drm/amd/display: Separate set_gsl from set_gsl_source_select

Imre Deak (1):
      drm/dp: Change AUX DPCD probe address from DPCD_REV to LANE0_1_STATUS

Ivan Stepchenko (1):
      mtd: fix possible integer overflow in erase_xfer()

Jacek Kowalski (2):
      e1000e: disregard NVM checksum on tgp when valid checksum bit is not set
      e1000e: ignore uninitialized checksum word on tgp

Jack Xiao (1):
      drm/amdgpu: fix incorrect vm flags to map bo

Jakub Acs (1):
      net, hsr: reject HSR frame if skb can't hold tag

Jakub Kicinski (2):
      netpoll: prevent hanging NAPI when netcons gets enabled
      uapi: in6: restore visibility of most IPv6 socket options

James Cowgill (1):
      media: v4l2-ctrls: Fix H264 SEPARATE_COLOUR_PLANE check

Jan Beulich (1):
      compiler: remove __ADDRESSABLE_ASM{_STR,}() again

Jan Kara (2):
      isofs: Verify inode mode when loading from disk
      udf: Verify partition map count

Jann Horn (1):
      eventpoll: Fix semi-unbounded recursion

Jason Wang (1):
      vhost: fail early when __vhost_add_used() fails

Jason Xing (1):
      ixgbe: xsk: resolve the negative overflow of budget in ixgbe_xmit_zc

Jay Chen (1):
      usb: xhci: Set avg_trb_len = 8 for EP0 during Address Device Command

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_icm42600: change invalid data error to -EBUSY

Jeff Layton (1):
      nfsd: handle get_client_locked() failure in nfsd4_setclientid_confirm()

Jeongjun Park (1):
      ptp: prevent possible ABBA deadlock in ptp_clock_freerun()

Jerome Brunet (1):
      PCI: endpoint: pci-epf-vntb: Return -ENOENT if pci_epc_get_next_free_bar() fails

Jian Shen (2):
      net: hns3: fix concurrent setting vlan filter issue
      net: hns3: fixed vf get max channels bug

Jiasheng Jiang (2):
      iwlwifi: Add missing check for alloc_ordered_workqueue
      scsi: lpfc: Remove redundant assignment to avoid memory leak

Jiaxun Yang (1):
      MIPS: mm: tlb-r4k: Uniquify TLB entries on init

Jiayi Li (2):
      ACPI: processor: perflib: Fix initial _PPC limit application
      memstick: Fix deadlock by moving removing flag earlier

Jiayuan Chen (3):
      bpf, sockmap: Fix panic when calling skb_linearize
      bpf, sockmap: Fix psock incorrectly pointing to sk
      bpf, ktls: Fix data corruption when using bpf_msg_pop_data() in ktls

Jimmy Assarsson (2):
      can: kvaser_pciefd: Store device channel index
      can: kvaser_usb: Assign netdev.dev_port based on device channel index

Jinjiang Tu (1):
      mm/memory-failure: fix infinite UCE for VM_PFNMAP pfn

Johan Adolfsson (1):
      leds: leds-lp50xx: Handle reg to get correct multi_index

Johan Hovold (9):
      net: gianfar: fix device leak when querying time stamp info
      net: dpaa: fix device leak when querying time stamp info
      usb: gadget: udc: renesas_usb3: fix device leak at unbind
      usb: dwc3: meson-g12a: fix device leaks at unbind
      wifi: ath11k: fix source ring-buffer corruption
      net: enetc: fix device and OF node leak at probe
      usb: musb: omap2430: fix device leak at unbind
      usb: dwc3: imx8mp: fix device leak at unbind
      wifi: ath11k: fix dest ring-buffer corruption when ring is full

Johan Korsnes (1):
      arch: powerpc: defconfig: Drop obsolete CONFIG_NET_CLS_TCINDEX

Johannes Berg (2):
      wifi: cfg80211: reject HTC bit for management frames
      wifi: mac80211: don't complete management TX on SAE commit

John Ernberg (1):
      net: usbnet: Avoid potential RCU stall on LINK_CHANGE event

John Garry (2):
      scsi: aacraid: Stop using PCI_IRQ_AFFINITY
      block: avoid possible overflow for chunk_sectors check in blk_stack_limits()

Jon Hunter (1):
      soc/tegra: pmc: Ensure power-domains are in a known state

Jonas Rebmann (1):
      net: fec: allow disable coalescing

Jonathan Cameron (1):
      iio: light: as73211: Ensure buffer holes are zeroed

Jonathan Santos (1):
      iio: adc: ad7768-1: Ensure SYNC_IN pulse minimum timing requirement

Jorge Ramirez-Ortiz (2):
      media: venus: hfi: explicitly release IRQ during teardown
      media: venus: protect against spurious interrupts during probe

Joseph Huang (1):
      net: bridge: Do not offload IGMP/MLD messages

Judith Mendez (1):
      mmc: sdhci_am654: Workaround for Errata i2312

Juergen Gross (1):
      xen/gntdev: remove struct gntdev_copy_batch from stack

Junxian Huang (1):
      RDMA/hns: Fix -Wframe-larger-than issue

Juri Lelli (1):
      sched/deadline: Fix accounting after global limits change

Justin Tee (1):
      scsi: lpfc: Check for hdwq null ptr when cleaning up lpfc_vport structure

Kees Cook (4):
      sched: Add wrapper for get_wchan() to keep task blocked
      arm64: Handle KCOV __init vs inline mismatches
      platform/x86: thinkpad_acpi: Handle KCOV __init vs inline mismatches
      iommu/amd: Avoid stack buffer overflow from kernel cmdline

Kefeng Wang (1):
      asm-generic: Add memory barrier dma_mb()

Kito Xu (veritas501) (1):
      net: appletalk: Fix use-after-free in AARP proxy probe

Konstantin Komarov (1):
      Revert "fs/ntfs3: Replace inode_trylock with inode_lock"

Krishna Kurapati (1):
      usb: dwc3: qcom: Don't leave BCR asserted

Krzysztof Kozlowski (1):
      ARM: dts: vfxxx: Correctly use two tuples for timer address

Kuen-Han Tsai (1):
      usb: dwc3: Ignore late xferNotReady event to prevent halt timeout

Kuninori Morimoto (4):
      ASoC: soc-dai: tidyup return value of snd_soc_xlate_tdm_slot_mask()
      ASoC: soc-dapm: set bias_level if snd_soc_dapm_set_bias_level() was successed
      ASoC: soc-dai.c: add missing flag check at snd_soc_pcm_dai_probe()
      ASoC: soc-dai.h: merge DAI call back functions into ops

Kuniyuki Iwashima (3):
      rpl: Fix use-after-free in rpl_do_srh_inline().
      Bluetooth: Fix null-ptr-deref in l2cap_sock_resume_cb()
      ipv6: mcast: Check inet6_dev->dead under idev->mc_lock in __ipv6_dev_mc_inc().

Kurt Borja (1):
      platform/x86: think-lmi: Fix kobject cleanup

Laurentiu Mihalcea (1):
      pwm: imx-tpm: Reset counter if CMOD is 0

Len Brown (1):
      intel_idle: Allow loading ACPI tables for any family

Leo Yan (1):
      perf tests bp_account: Fix leaked file descriptor

Leon Romanovsky (1):
      net/mlx5e: Properly access RCU protected qdisc_sleeping variable

Li Zhong (1):
      ACPI: processor: idle: Check acpi_fetch_acpi_dev() return value

Liao Yuanhong (1):
      ext4: use kmalloc_array() for array space allocation

Lifeng Zheng (5):
      PM / devfreq: Check governor before using governor->name
      cpufreq: Initialize cpufreq-based frequency-invariance later
      cpufreq: Init policy->rwsem before it may be possibly used
      cpufreq: Exit governor when failed to start old governor
      PM / devfreq: governor: Replace sscanf() with kstrtoul() in set_freq_store()

Lin.Cao (1):
      drm/sched: Remove optimization that causes hang when killing dependent jobs

Lizhi Xu (3):
      vmci: Prevent the dispatching of uninitialized payloads
      fs/ntfs3: Add sanity check for file name
      jfs: truncate good inode pages when hard link is 0

Lorenzo Stoakes (5):
      selftests/perf_events: Add a mmap() correctness test
      mm: drop the assumption that VM_SHARED always implies writable
      mm: update memfd seal write check to include F_SEAL_WRITE
      mm: reinstate ability to map write-sealed memfd mappings read-only
      selftests/memfd: add test for mapping write-sealed memfd read-only

Lucas De Marchi (1):
      usb: early: xhci-dbc: Fix early_ioremap leak

Lucy Thrun (1):
      ALSA: hda/ca0132: Fix buffer overflow in add_tuning_control

Ludwig Disterhof (1):
      media: usbtv: Lock resolution while streaming

Luiz Augusto von Dentz (3):
      Bluetooth: SMP: If an unallowed command is received consider it a failure
      Bluetooth: SMP: Fix using HCI_ERROR_REMOTE_USER_TERM on timeout
      Bluetooth: L2CAP: Fix attempting to adjust outgoing MTU

Lukas Wunner (1):
      PCI/ACPI: Fix runtime PM ref imbalance on Hot-Plug Capable ports

Ma Ke (4):
      bus: fsl-mc: Fix potential double device reference in fsl_mc_get_endpoint()
      dpaa2-eth: Fix device reference count leak in MAC endpoint handling
      dpaa2-switch: Fix device reference count leak in MAC endpoint handling
      sunvdc: Balance device refcount in vdc_port_mpgroup_check

Maciej W. Rozycki (1):
      powerpc/eeh: Rely on dev->link_active_reporting

Mael GUERIN (1):
      USB: storage: Add unusual-devs entry for Novatek NTK96550-based camera

Manivannan Sadhasivam (1):
      PCI: endpoint: pci-epf-vntb: Fix the incorrect usage of __iomem attribute

Maor Gottlieb (1):
      RDMA/core: Rate limit GID cache warning messages

Marco Elver (1):
      locking/barriers, kcsan: Support generic instrumentation

Marek Szyprowski (1):
      zynq_fpga: use sgtable-based scatterlist wrappers

Marek Vasut (1):
      usb: renesas-xhci: Fix External ROM access timeouts

Mario Limonciello (5):
      usb: xhci: Avoid showing warnings for dying controller
      usb: xhci: Avoid showing errors during surprise removal
      drm/amd: Allow printing VanGogh OD SCLK levels without setting dpm to manual
      drm/amd: Restore cached power limit during resume
      drm/amd/display: Avoid a NULL pointer dereference

Marius Zachmann (1):
      hwmon: (corsair-cpro) Validate the size of the received input buffer

Mark Brown (1):
      ASoC: hdac_hdmi: Rate limit logging on connection and disconnection

Martin Kaistra (1):
      wifi: rtl8xxxu: Fix RX skb size for aggregation disabled

Masahiro Yamada (3):
      kconfig: qconf: fix ConfigList::updateListAllforAll()
      kconfig: gconf: avoid hardcoding model2 in on_treeview2_cursor_changed()
      kconfig: gconf: fix potential memory leak in renderer_edited()

Masami Hiramatsu (Google) (1):
      selftests: tracing: Use mutex_unlock for testing glob filter

Mat Martineau (1):
      selftests: mptcp: Initialize variables to quiet gcc 12 warnings

Mathias Nyman (5):
      usb: hub: fix detection of high tier USB3 devices behind suspended hubs
      usb: hub: Fix flushing and scheduling of delayed work that tunes runtime pm
      usb: hub: Fix flushing of delayed work used for post resume purposes
      usb: hub: avoid warm port reset during USB3 disconnect
      usb: hub: Don't try to recover devices lost during warm reset.

Matt Johnston (1):
      net: mctp: Prevent duplicate binds

Matthew Wilcox (Oracle) (1):
      XArray: Add calls to might_alloc()

Matthieu Baerts (1):
      selftests: mptcp: add missing join check

Matthieu Baerts (NGI0) (4):
      mptcp: pm: kernel: flush: do not reset ADD_ADDR limit
      selftests: mptcp: connect: also cover alt modes
      selftests: mptcp: connect: also cover checksum
      selftests: mptcp: pm: check flush doesn't reset limits

Maulik Shah (1):
      pmdomain: governor: Consider CPU latency tolerance from pm_domain_cpu_gov

Maurizio Lombardi (1):
      scsi: target: core: Generate correct identifiers for PR OUT transport IDs

Meagan Lloyd (2):
      rtc: ds1307: handle oscillator stop flag (OSF) for ds1341
      rtc: ds1307: remove clear of oscillator stop flag (OSF) in probe

Mengbiao Xiong (1):
      crypto: ccp - Fix crash when rebind ccp device for ccp.ko

Miao Li (1):
      usb: quirks: Add DELAY_INIT quick for another SanDisk 3.2Gen1 Flash Drive

Miaoqian Lin (1):
      most: core: Drop device reference after usage in get_channel()

Michael Grzeschik (2):
      usb: typec: tcpm: allow to use sink in accessory mode
      usb: typec: tcpm: allow switching to mode accessory to mux properly

Michael Zhivich (1):
      x86/bugs: Fix use of possibly uninit value in amd_check_tsa_microcode()

Michal Schmidt (1):
      benet: fix BUG when creating VFs

Mike Christie (1):
      vhost-scsi: Fix log flooding with target does not exist errors

Mikhail Lobanov (1):
      wifi: mac80211: check basic rates validity in sta_link_apply_parameters

Mikulas Patocka (1):
      dm-mpath: don't print the "loaded" message if registering fails

Mina Almasry (1):
      netmem: fix skb_frag_address_safe with unreadable skbs

Minhong He (1):
      ipv6: sr: validate HMAC algorithm ID in seg6_hmac_info_add

Myrrh Periwinkle (3):
      usb: typec: ucsi: Update power_supply on power role change
      vt: keyboard: Don't process Unicode characters in K_OFF mode
      vt: defkeymap: Map keycodes above 127 to K_HOLE

Namhyung Kim (1):
      perf sched: Fix memory leaks for evsel->priv in timehist

Nathan Chancellor (5):
      phonet/pep: Move call to pn_skb_get_dst_sockaddr() earlier in pep_sock_accept()
      memstick: core: Zero initialize id_reg in h_memstick_read_dev_id()
      usb: atm: cxacru: Merge cxacru_upload_firmware() into cxacru_heavy_init()
      wifi: brcmsmac: Remove const from tbl_ptr parameter in wlc_lcnphy_common_read_table()
      ARM: 9448/1: Use an absolute path to unified.h in KBUILD_AFLAGS

NeilBrown (1):
      smb/server: avoid deadlock when linking with ReplaceIfExists

Niklas Söderlund (1):
      media: v4l2-common: Reduce warnings about missing V4L2_CID_LINK_FREQ control

Nilton Perim Neto (1):
      Input: xpad - set correct controller type for Acer NGR200

Nirmal Patel (1):
      PCI: vmd: Assign VMD IRQ domain before enumeration

Nuno Sá (1):
      clk: clk-axi-clkgen: fix fpfd_max frequency for zynq

Ojaswin Mujoo (2):
      ext4: fix fsmap end of range reporting with bigalloc
      ext4: fix reserved gdt blocks handling in fsmap

Olga Kornievskaia (1):
      NFSv4.2: another fix for listxattr

Oliver Neukum (3):
      usb: net: sierra: check for no status endpoint
      usb: core: usb_submit_urb: downgrade type check
      cdc-acm: fix race between initial clearing halt and open

Oscar Maes (1):
      net: ipv4: fix incorrect MTU in broadcast routes

Ovidiu Panait (1):
      hwrng: mtk - handle devm_pm_runtime_enable errors

Pagadala Yesu Anjaneyulu (1):
      wifi: iwlwifi: fw: Fix possible memory leak in iwl_fw_dbg_collect

Pali Rohár (1):
      cifs: Fix calling CIFSFindFirst() for root path without msearch

Paolo Abeni (4):
      selftests: net: increase inter-packet timeout in udpgro.sh
      mptcp: fix error mibs accounting
      mptcp: introduce MAPPING_BAD_CSUM
      mptcp: do not queue data on closed subflows

Paul Cercueil (1):
      usb: musb: Add and use inline functions musb_{get,set}_state

Paul Chaignon (2):
      bpf: Reject %p% format string in bprintf-like helpers
      bpf: Check flow_dissector ctx accesses are aligned

Paul E. McKenney (1):
      rcu: Protect ->defer_qs_iw_pending from data race

Paul Kocialkowski (1):
      clk: sunxi-ng: v3s: Fix de clock definition

Pavel Begunkov (1):
      io_uring: don't use int for ABI

Pawan Gupta (1):
      x86/bugs: Avoid warning when overriding return thunk

Peter Oberparleiter (2):
      s390/hypfs: Avoid unnecessary ioctl registration in debugfs
      s390/hypfs: Enable limited access during lockdown

Peter Robinson (1):
      reset: brcmstb: Enable reset drivers for ARCH_BCM2835

Peter Ujfalusi (1):
      ASoC: core: Check for rtd == NULL in snd_soc_remove_pcm_runtime()

Peter Zijlstra (2):
      x86: Fix __get_wchan() for !STACKTRACE
      x86: Pin task-stack in __get_wchan()

Petr Pavlu (1):
      module: Restore the moduleparam prefix length check

Phillip Lougher (1):
      squashfs: fix memory leak in squashfs_fill_super

Prashant Malani (1):
      cpufreq: CPPC: Mark driver with NEED_UPDATE_LIMITS flag

Praveen Kaligineedi (1):
      gve: Fix stuck TX queue for DQ queue format

Pu Lehui (1):
      tracing: Limit access to parser->buffer when trace_get_user failed

Purva Yeshi (1):
      md: dm-zoned-target: Initialize return variable r to avoid uninitialized use

Qi Zheng (1):
      x86: Fix get_wchan() to support the ORC unwinder

Qingfang Deng (1):
      ppp: fix race conditions in ppp_fill_forward_path

Qu Wenruo (2):
      btrfs: do not allow relocation of partially dropped subvolumes
      btrfs: populate otime when logging an inode item

Quang Le (1):
      net/packet: fix a race in packet_set_ring() and packet_notifier()

RD Babiera (1):
      usb: typec: tcpm: apply vbus before data bringup in tcpm_src_attach

Rafael J. Wysocki (4):
      cpufreq: intel_pstate: Always use HWP_DESIRED_PERF in passive mode
      ACPI: processor: perflib: Move problematic pr->performance check
      cpuidle: governors: menu: Avoid using invalid recent intervals data
      PM: runtime: Clear power.needs_force_resume in pm_runtime_reinit()

Rand Deeb (1):
      wifi: iwlwifi: dvm: fix potential overflow in rs_fill_link_cmd()

Randy Dunlap (1):
      parisc: Makefile: fix a typo in palo.conf

Ranjan Kumar (4):
      scsi: Fix sas_user_scan() to handle wildcard and multi-channel scans
      scsi: mpi3mr: Fix race between config read submit and interrupt completion
      scsi: mpi3mr: Drop unnecessary volatile from __iomem pointers
      scsi: mpi3mr: Serialize admin queue BAR writes on 32-bit systems

Remi Pommarel (2):
      wifi: mac80211: Check 802.11 encaps offloading in ieee80211_tx_h_select_key()
      Reapply "wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()"

Ricardo Ribalda (3):
      media: uvcvideo: Do not mark valid metadata as invalid
      media: venus: vdec: Clamp param smaller than 1fps and bigger than 240.
      media: venus: venc: Clamp param smaller than 1fps and bigger than 240

Ricky Wu (1):
      misc: rtsx: usb: Ensure mmc child device is active when card is present

Rob Clark (1):
      drm/msm: use trylock for debugfs

Rohit Visavalia (1):
      clk: xilinx: vcu: unregister pll_post only if registered correctly

Rong Zhang (2):
      platform/x86: ideapad-laptop: Fix kbd backlight not remembered among boots
      fs/ntfs3: correctly create symlink for relative path

RubenKelevra (1):
      fs_context: fix parameter name in infofc() macro

Ryan Lee (1):
      apparmor: ensure WB_HISTORY_SIZE value is a power of 2

Ryan Mann (NDI) (1):
      USB: serial: ftdi_sio: add support for NDI EMGUIDE GEMINI

Ryusuke Konishi (1):
      nilfs2: reject invalid file types when reading inodes

Sabrina Dubroca (1):
      udp: also consider secpath when evaluating ipsec use for checksumming

Sakari Ailus (1):
      media: v4l2-ctrls: Don't reset handler's error in v4l2_ctrl_handler_free()

Salah Triki (1):
      iio: pressure: bmp280: Use IS_ERR() in bmp280_common_probe()

Sam Shih (1):
      pinctrl: mediatek: moore: check if pin_desc is valid before use

Sarah Newman (1):
      drbd: add missing kref_get in handle_write_conflicts

Sarthak Garg (1):
      mmc: sdhci-msm: Ensure SD card power isn't ON when card removed

Sasha Levin (2):
      fs: Prevent file descriptor table allocations exceeding INT_MAX
      media: qcom: camss: cleanup media device allocated resource on error path

Sebastian Andrzej Siewior (1):
      net: phy: Use netif_rx().

Sebastian Ott (1):
      ACPI: processor: fix acpi_object initialization

Sebastian Reichel (2):
      watchdog: dw_wdt: Fix default timeout
      usb: typec: fusb302: cache PD RX state

Selvarasu Ganesan (1):
      usb: dwc3: Remove WARN_ON for device endpoint command timeouts

Sergey Bashirov (4):
      pNFS: Fix stripe mapping in block/scsi layout
      pNFS: Fix disk addr range check in block/scsi layout
      pNFS: Handle RPC size limit for layoutcommits
      pNFS: Fix uninited ptr deref in block/scsi layout

Sergey Senozhatsky (1):
      wifi: ath11k: clear initialized flag for deinit-ed srng lists

Seunghui Lee (1):
      scsi: ufs: core: Use link recovery when h8 exit fails during runtime resume

Shankari Anand (1):
      kconfig: nconf: Ensure null termination where strncpy is used

Shengjiu Wang (1):
      ASoC: fsl_sai: replace regmap_write with regmap_update_bits

Shiji Yang (1):
      MIPS: vpe-mt: add missing prototypes for vpe_{alloc,start,stop,free}

Showrya M N (1):
      scsi: libiscsi: Initialize iscsi_conn->dd_data only if memory is allocated

Shubhrajyoti Datta (1):
      EDAC/synopsys: Clear the ECC counters on init

Slark Xiao (2):
      USB: serial: option: add Foxconn T99W640
      USB: serial: option: add Foxconn T99W709

Sravan Kumar Gundu (1):
      fbdev: Fix vmalloc out-of-bounds write in fast_imageblit

Stanislav Fomichev (1):
      vrf: Drop existing dst reference in vrf_ip6_input_dst

Stanislaw Gruszka (1):
      wifi: iwlegacy: Check rate_idx range after addition

Stav Aviram (1):
      net/mlx5: Check device memory pointer before usage

Stefan Metzmacher (5):
      smb: server: remove separate empty_recvmsg_queue
      smb: server: make sure we call ib_dma_unmap_single() only if we called ib_dma_map_single already
      smb: server: let recv_done() consistently call put_recvmsg/smb_direct_disconnect_rdma_connection
      smb: server: let recv_done() avoid touching data_transfer after cleanup/move
      smb: client: let recv_done() cleanup before notifying the callers.

Steven Rostedt (5):
      tracing: Add down_write(trace_event_sem) when adding trace event
      selftests/tracing: Fix false failure of subsystem event test
      ktest.pl: Prevent recursion of default variable options
      ftrace: Also allocate and copy hash for reading of filter files
      tracing: Remove unneeded goto out logic

Su Hui (1):
      usb: xhci: print xhci->xhc_state when queue_command failed

Suchit Karunakaran (1):
      kconfig: lxdialog: replace strcpy() with strncpy() in inputbox.c

Sven Schnelle (2):
      s390/time: Use monotonic clock in get_cycles()
      s390/stp: Remove udelay from stp_sync_clock()

Takashi Iwai (4):
      ALSA: hda/ca0132: Fix missing error handling in ca0132_alt_select_out()
      ALSA: usb-audio: Validate UAC3 power domain descriptors, too
      ALSA: usb-audio: Validate UAC3 cluster segment descriptors
      ALSA: usb-audio: Use correct sub-type for UAC3 feature unit validation

Tao Xue (1):
      usb: gadget : fix use-after-free in composite_dev_cleanup()

Tariq Toukan (1):
      lib: bitmap: Introduce node-aware alloc API

Tetsuo Handa (1):
      hfsplus: don't use BUG_ON() in hfsplus_create_attributes_file()

Theodore Ts'o (2):
      ext4: do not BUG when INLINE_DATA_FL lacks system.data xattr
      ext4: don't try to clear the orphan_present feature block device is r/o

Thomas Fourier (19):
      pch_uart: Fix dma_sync_sg_for_device() nents value
      mmc: bcm2835: Fix dma_unmap_sg() nents value
      mwl8k: Add missing check after DMA map
      crypto: inside-secure - Fix `dma_unmap_sg()` nents value
      scsi: ibmvscsi_tgt: Fix dma_unmap_sg() nents value
      scsi: mvsas: Fix dma_unmap_sg() nents value
      scsi: isci: Fix dma_unmap_sg() nents value
      crypto: keembay - Fix dma_unmap_sg() nents value
      crypto: img-hash - Fix dma_unmap_sg() nents value
      dmaengine: mv_xor: Fix missing check after DMA map and missing unmap
      dmaengine: nbpfaxi: Add missing check after DMA map
      mtd: rawnand: atmel: Fix dma_mapping_error() address
      mtd: rawnand: rockchip: Add missing check after DMA map
      et131x: Add missing check after DMA map
      net: ag71xx: Add missing check after DMA map
      (powerpc/512) Fix possible `dma_unmap_single()` on uninitialized pointer
      wifi: rtlwifi: fix possible skb memory leak in `_rtl_pci_rx_interrupt()`.
      wifi: rtlwifi: fix possible skb memory leak in _rtl_pci_init_one_rxdesc()
      mtd: rawnand: fsmc: Add missing check after DMA map

Thomas Gleixner (3):
      perf/core: Don't leak AUX buffer refcount on allocation failure
      perf/core: Exit early on perf_mmap() fail
      perf/core: Prevent VMA split of buffer mappings

Thomas Weißschuh (3):
      tools/nolibc: define time_t in terms of __kernel_old_time_t
      MIPS: Don't crash in stack_top() for tasks without ABI or vDSO
      kbuild: userprogs: use correct linker when mixing clang and GNU ld

Thorsten Blum (3):
      ALSA: intel_hdmi: Fix off-by-one error in __hdmi_lpe_audio_probe()
      smb: server: Fix extension string in ksmbd_extract_shortname()
      usb: storage: realtek_cr: Use correct byte order for bcs->Residue

Tianxiang Peng (1):
      x86/cpu/hygon: Add missing resctrl_cpu_detect() in bsp_init helper

Tigran Mkrtchyan (1):
      pNFS/flexfiles: don't attempt pnfs on fatal DS errors

Tim Harvey (1):
      hwmon: (gsc-hwmon) fix fan pwm setpoint show functions

Timothy Pearson (5):
      PCI: pnv_php: Clean up allocated IRQs on unplug
      PCI: pnv_php: Work around switches with broken presence detection
      powerpc/eeh: Export eeh_unfreeze_pe()
      powerpc/eeh: Make EEH driver device hotplug safe
      PCI: pnv_php: Fix surprise plug detection and recovery

Timur Kristóf (6):
      drm/amd/display: Don't overwrite dce60_clk_mgr
      drm/amd/display: Fix fractional fb divider in set_pixel_clock_v3
      drm/amd/display: Fix DP audio DTO1 clock source on DCE 6.
      drm/amd/display: Find first CRTC and its line time in dce110_fill_display_configs
      drm/amd/display: Fill display clock and vblank time in dce110_fill_display_configs
      drm/amd/display: Don't overclock DCE 6 by 15%

Tiwei Bie (1):
      um: rtc: Avoid shadowing err in uml_rtc_start()

Tomas Henzl (1):
      scsi: mpt3sas: Fix a fw_event memory leak

Tomasz Michalec (2):
      usb: typec: intel_pmc_mux: Defer probe if SCU IPC isn't present
      platform/chrome: cros_ec_typec: Defer probe on missing EC parent

Trond Myklebust (2):
      NFS: Fix filehandle bounds checking in nfs_fh_to_dentry()
      NFS: Fix the setting of capabilities when automounting a new filesystem

Tvrtko Ursulin (1):
      drm/ttm: Respect the shrinker core free target

Tzung-Bi Shih (2):
      platform/chrome: cros_ec: remove unneeded label and if-condition
      platform/chrome: cros_ec: Unregister notifier in cros_ec_unregister()

Ulf Hansson (1):
      mmc: rtsx_usb_sdmmc: Fix error-path in sd_set_power_mode()

Uros Bizjak (1):
      ucount: fix atomic_long_inc_below() argument type

Uwe Kleine-König (6):
      usb: musb: omap2430: Convert to platform remove callback returning void
      platform/chrome: cros_ec: Make cros_ec_unregister() return void
      media: camss: Convert to platform remove callback returning void
      pwm: mediatek: Implement .apply() callback
      pwm: mediatek: Handle hardware enable and clock enable separately
      pwm: mediatek: Fix duty and period setting

ValdikSS (1):
      igc: fix disabling L1.2 PCI-E link substate on I226 on init

Vedang Nagar (1):
      media: venus: Add a check for packet size after reading from shared memory

Viacheslav Dubeyko (4):
      hfs: fix slab-out-of-bounds in hfs_bnode_read()
      hfsplus: fix slab-out-of-bounds in hfsplus_bnode_read()
      hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()
      hfs: fix not erasing deleted b-tree node issue

Victor Shih (1):
      mmc: sdhci-pci-gli: GL9763e: Rename the gli_set_gl9763e() for consistency

Viresh Kumar (1):
      i2c: virtio: Avoid hang by using interruptible completion wait

Waiman Long (2):
      mm/kmemleak: avoid soft lockup in __kmemleak_do_cleanup()
      cgroup/cpuset: Use static_branch_enable_cpuslocked() on cpusets_insane_config_key

Wang Liang (2):
      net: drop UFO packets in udp_rcv_segment()
      net: bridge: fix soft lockup in br_multicast_query_expired()

Wang Zhaolong (2):
      smb: client: fix use-after-free in cifs_oplock_break
      smb: client: fix use-after-free in crypt_message when using async crypto

Wayne Chang (1):
      phy: tegra: xusb: Fix unbalanced regulator disable in UTMI PHY mode

Wei Gao (1):
      ext2: Handle fiemap on empty files to prevent EINVAL

Weitao Wang (1):
      usb: xhci: Fix slot_id resource race conflict

Wen Chen (1):
      drm/amd/display: Fix 'failed to blank crtc!'

Will Deacon (1):
      KVM: arm64: Fix kernel BUG() due to bad backport of FPSIMD/SVE/SME fix

William Liu (4):
      net/sched: Return NULL when htb_lookup_leaf encounters an empty rbtree
      net/sched: Restrict conditions for adding duplicating netems to qdisc tree
      net/sched: Make cake_enqueue return NET_XMIT_CN when past buffer_limit
      net/sched: Remove unnecessary WARNING condition for empty child qdisc in htb_activate

Wolfram Sang (3):
      media: usb: hdpvr: disable zero-length read messages
      i3c: add missing include to internal header
      i3c: don't fail if GETHDRCAP is unsupported

Xiang Mei (2):
      net/sched: sch_qfq: Fix race condition on qfq_aggregate
      net/sched: sch_qfq: Avoid triggering might_sleep in atomic context in qfq_delete_class

Xilin Wu (1):
      interconnect: qcom: sc7280: Add missing num_links to xm_pcie3_1 node

Xin Long (1):
      sctp: linearize cloned gso packets in sctp_rcv

Xinxin Wan (1):
      ASoC: codecs: rt5640: Retry DEVICE_ID verification

Xinyu Liu (2):
      usb: gadget: configfs: Fix OOB read on empty string write
      usb: core: config: Prevent OOB read in SS endpoint companion parsing

Xiu Jianfeng (1):
      wifi: iwlwifi: Fix memory leak in iwl_mvm_init()

Xiumei Mu (1):
      selftests: rtnetlink.sh: remove esp4_offload after test

Xu Yang (4):
      usb: chipidea: add USB PHY event
      usb: phy: mxs: disconnect line when USB charger is attached
      net: usb: asix_devices: add phy_mask for ax88772 mdio bus
      usb: core: hcd: fix accessing unmapped memory in SINGLE_STEP_SET_FEATURE test

Xu Yilun (1):
      fpga: zynq_fpga: Fix the wrong usage of dma_map_sgtable()

Yajun Deng (1):
      i40e: Add rx_missed_errors for buffer exhaustion

Yang Xiwen (1):
      i2c: qup: jump out of the loop in case of timeout

Yangtao Li (1):
      hfsplus: remove mutex_lock check in hfsplus_free_extents

Yann E. MORIN (1):
      kconfig: lxdialog: fix 'space' to (de)select options

Yazen Ghannam (1):
      x86/mce/amd: Add default names for MCA banks and blocks

Ye Bin (1):
      fs/buffer: fix use-after-free when call bh_read() helper

Yonglong Liu (1):
      net: hns3: disable interrupt when ptp init failed

Youngjun Lee (1):
      media: uvcvideo: Fix 1-byte out-of-bounds read in uvc_parse_format()

Youssef Samir (1):
      bus: mhi: host: Detect events pointing to unexpected TREs

Yu Kuai (1):
      nvme: fix misaccounting of nvme-mpath inflight I/O

Yuan Chen (2):
      bpftool: Fix memory leak in dump_xx_nlmsg on realloc failure
      pinctrl: sunxi: Fix memory leak on krealloc failure

Yue Haibing (1):
      ipv6: mcast: Delay put pmc->idev in mld_del_delrec()

Yuichiro Tsuji (1):
      net: usb: asix_devices: Fix PHY address mask in MDIO bus initialization

Yun Lu (2):
      af_packet: fix the SO_SNDTIMEO constraint not effective on tpacked_snd()
      af_packet: fix soft lockup issue caused by tpacket_snd()

Yunhui Cui (1):
      serial: 8250: fix panic due to PSLVERR

Yury Norov [NVIDIA] (1):
      RDMA: hfi1: fix possible divide-by-zero in find_hw_thread_mask()

Zenm Chen (1):
      USB: storage: Ignore driver CD mode for Realtek multi-mode Wi-Fi dongles

Zhang Lixu (2):
      iio: hid-sensor-prox: Restore lost scale assignments
      iio: hid-sensor-prox: Fix incorrect OFFSET calculation

Zhang Rui (1):
      powercap: intel_rapl: Do not change CLAMPING bit if ENABLE bit cannot be changed

Zhang Shurong (1):
      media: ov2659: Fix memory leaks in ov2659_probe()

Zhang Yi (1):
      ext4: fix hole length calculation overflow in non-extent inodes

Zheng Yu (1):
      jfs: fix metapage reference count leak in dbAllocCtl

Zhiqi Song (1):
      crypto: hisilicon/hpre - fix dma unmap sequence

Zhu Qiyu (1):
      ACPI: PRM: Reduce unnecessary printing to avoid user confusion

Ziyan Fu (1):
      watchdog: iTCO_wdt: Report error if timeout configuration fails

chenchangcheng (1):
      media: uvcvideo: Fix bandwidth issue for Alcor camera

fangzhong.zhou (1):
      i2c: Force DLL0945 touchpad i2c freq to 100khz

jackysliu (1):
      scsi: bfa: Double-free fix

tuhaowen (1):
      PM: sleep: console: Fix the black screen issue

xin.guo (1):
      tcp: fix tcp_ofo_queue() to avoid including too much DUP SACK range

zhangjianrong (1):
      net: thunderbolt: Fix the parameter passing of tb_xdomain_enable_paths()/tb_xdomain_disable_paths()

Álvaro Fernández Rojas (5):
      net: dsa: b53: fix b53_imp_vlan_setup for BCM5325
      net: dsa: b53: prevent GMII_PORT_OVERRIDE_CTRL access on BCM5325
      net: dsa: b53: prevent DIS_LEARNING access on BCM5325
      net: dsa: b53: prevent SWITCH_CTRL access on BCM5325
      net: dsa: b53: fix IP_MULTICAST_CTRL on BCM5325


