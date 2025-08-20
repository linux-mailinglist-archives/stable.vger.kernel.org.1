Return-Path: <stable+bounces-171920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD016B2E416
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 19:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173435639DD
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 17:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1932566E2;
	Wed, 20 Aug 2025 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="al1Gte+j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A8A1DDA18;
	Wed, 20 Aug 2025 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755711492; cv=none; b=bjffytm0E3Xku1an8HC/tOZf4ZCrgTZXeRu+20VRSesR0cTOzdcLWwyWMXve4vGZ2W9E8LALXVaWhD3ygqyGfiKT/tGKRS4xZ1Bq9duTTn6P14LLFJx0dUDQ3myeUCPuy44TrTVdb4jFgVy5J+JtetKXYSyTlps5M0MtKkMdjmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755711492; c=relaxed/simple;
	bh=yRQ6SkjUtxheOA2wMi4Bl9mgUKmm6gLasmbS7rHat14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=To/+BMM+ZcC1rmdwh2vlg1NWatN74RZy7e2dnIEcjadfo9CgLOqsUGh+whaxWN2Agw1zpaaZ+8/xbo/kahGy1lmU5dXac3+QceMtMe9EiU6drVD2y2JfwdTRRTgfRIk6QK4JfVPK69NSNLSLqZ7+xdfIQxLaDQ1Rw7flGp4p8eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=al1Gte+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37B9C4CEE7;
	Wed, 20 Aug 2025 17:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755711491;
	bh=yRQ6SkjUtxheOA2wMi4Bl9mgUKmm6gLasmbS7rHat14=;
	h=From:To:Cc:Subject:Date:From;
	b=al1Gte+jSPfegnStm1+quRh0TYXzhd2kt7ZNiETzmt+4KVZvjqjMPeSyZ8srBFFDA
	 jG/kZf3f+Q8H2OWCrl0NgO5fDBwN+suSvmrCeLsDDxCcRGdPR2weUWzLsuhlVMuq+8
	 GDe7QXG7Q84IxK8WmO/iUkP8jNDgYkdsWLPjbkgg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.16.2
Date: Wed, 20 Aug 2025 19:37:56 +0200
Message-ID: <2025082057-sternum-passage-e10d@gregkh>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.16.2 kernel.

All users of the 6.16 kernel series must upgrade.

The updated 6.16.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.16.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/filesystems/fscrypt.rst                             |   37 
 Documentation/firmware-guide/acpi/i2c-muxes.rst                   |    8 
 Documentation/sphinx/kernel_abi.py                                |    6 
 Makefile                                                          |    2 
 arch/arm/mach-rockchip/platsmp.c                                  |   15 
 arch/arm/mach-tegra/reset.c                                       |    2 
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts                           |    2 
 arch/arm64/include/asm/acpi.h                                     |    2 
 arch/arm64/kernel/acpi.c                                          |   10 
 arch/arm64/kernel/stacktrace.c                                    |    2 
 arch/arm64/kernel/traps.c                                         |    1 
 arch/arm64/mm/fault.c                                             |    1 
 arch/arm64/mm/ptdump_debugfs.c                                    |    3 
 arch/loongarch/kernel/env.c                                       |   13 
 arch/loongarch/kernel/relocate_kernel.S                           |    2 
 arch/loongarch/kernel/unwind_orc.c                                |    2 
 arch/loongarch/net/bpf_jit.c                                      |   21 
 arch/loongarch/vdso/Makefile                                      |    2 
 arch/mips/include/asm/vpe.h                                       |    8 
 arch/mips/kernel/process.c                                        |   16 
 arch/mips/lantiq/falcon/sysctrl.c                                 |   23 
 arch/parisc/Makefile                                              |    2 
 arch/powerpc/include/asm/floppy.h                                 |    5 
 arch/powerpc/platforms/512x/mpc512x_lpbfifo.c                     |    6 
 arch/riscv/boot/dts/thead/th1520.dtsi                             |   10 
 arch/riscv/mm/ptdump.c                                            |    3 
 arch/s390/include/asm/timex.h                                     |   13 
 arch/s390/kernel/early.c                                          |    1 
 arch/s390/kernel/time.c                                           |    2 
 arch/s390/mm/dump_pagetables.c                                    |    2 
 arch/um/include/asm/thread_info.h                                 |    4 
 arch/um/kernel/process.c                                          |   20 
 arch/x86/boot/startup/sev-shared.c                                |    1 
 arch/x86/coco/sev/core.c                                          |    2 
 arch/x86/coco/sev/vc-handle.c                                     |   40 
 arch/x86/include/asm/kvm_host.h                                   |    7 
 arch/x86/kernel/cpu/bugs.c                                        |    5 
 arch/x86/kernel/fpu/xstate.c                                      |   19 
 arch/x86/kvm/vmx/main.c                                           |    2 
 arch/x86/kvm/vmx/nested.c                                         |   21 
 arch/x86/kvm/vmx/pmu_intel.c                                      |    8 
 arch/x86/kvm/vmx/vmx.c                                            |   41 
 arch/x86/kvm/vmx/vmx.h                                            |   26 
 arch/x86/kvm/x86.c                                                |   14 
 arch/x86/lib/crypto/poly1305_glue.c                               |   48 
 block/bfq-iosched.c                                               |   35 
 block/bfq-iosched.h                                               |    3 
 block/blk-mq.c                                                    |    6 
 block/blk-settings.c                                              |    2 
 block/blk-sysfs.c                                                 |   12 
 block/blk-zoned.c                                                 |   20 
 block/blk.h                                                       |    1 
 block/genhd.c                                                     |    2 
 block/kyber-iosched.c                                             |    9 
 block/mq-deadline.c                                               |   16 
 crypto/jitterentropy-kcapi.c                                      |    9 
 drivers/accel/habanalabs/common/memory.c                          |   23 
 drivers/acpi/acpi_processor.c                                     |    2 
 drivers/acpi/apei/ghes.c                                          |   13 
 drivers/acpi/ec.c                                                 |   10 
 drivers/acpi/prmt.c                                               |   26 
 drivers/acpi/processor_perflib.c                                  |   11 
 drivers/android/binder_alloc_selftest.c                           |    2 
 drivers/ata/ahci.c                                                |   12 
 drivers/ata/ata_piix.c                                            |    1 
 drivers/ata/libahci.c                                             |    1 
 drivers/ata/libata-sata.c                                         |   52 
 drivers/base/power/runtime.c                                      |    5 
 drivers/base/regmap/regmap-irq.c                                  |   19 
 drivers/block/drbd/drbd_receiver.c                                |    6 
 drivers/block/loop.c                                              |   38 
 drivers/block/sunvdc.c                                            |    4 
 drivers/block/ublk_drv.c                                          |   16 
 drivers/bluetooth/btusb.c                                         |    3 
 drivers/bus/mhi/host/pci_generic.c                                |   20 
 drivers/char/ipmi/ipmi_msghandler.c                               |    8 
 drivers/char/ipmi/ipmi_watchdog.c                                 |   59 
 drivers/char/misc.c                                               |    4 
 drivers/char/tpm/tpm-interface.c                                  |   17 
 drivers/char/tpm/tpm_crb_ffa.c                                    |   19 
 drivers/clk/qcom/dispcc-sm8750.c                                  |   10 
 drivers/clk/qcom/gcc-ipq5018.c                                    |    2 
 drivers/clk/qcom/gcc-ipq8074.c                                    |    6 
 drivers/clk/renesas/rzg2l-cpg.c                                   |    8 
 drivers/clk/samsung/clk-exynos850.c                               |    2 
 drivers/clk/samsung/clk-gs101.c                                   |    4 
 drivers/clk/tegra/clk-periph.c                                    |    4 
 drivers/clk/thead/clk-th1520-ap.c                                 |    5 
 drivers/comedi/comedi_fops.c                                      |   31 
 drivers/comedi/comedi_internal.h                                  |    1 
 drivers/comedi/drivers.c                                          |   13 
 drivers/cpufreq/cppc_cpufreq.c                                    |    2 
 drivers/cpufreq/cpufreq.c                                         |    8 
 drivers/cpufreq/intel_pstate.c                                    |    2 
 drivers/cpuidle/governors/menu.c                                  |   21 
 drivers/crypto/caam/ctrl.c                                        |    2 
 drivers/crypto/ccp/sp-pci.c                                       |    1 
 drivers/crypto/hisilicon/hpre/hpre_crypto.c                       |    8 
 drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c               |   16 
 drivers/devfreq/governor_userspace.c                              |    6 
 drivers/dma/stm32/stm32-dma.c                                     |    2 
 drivers/edac/ie31200_edac.c                                       |    4 
 drivers/edac/synopsys_edac.c                                      |   97 
 drivers/firmware/arm_ffa/driver.c                                 |    2 
 drivers/firmware/arm_scmi/scmi_power_control.c                    |   22 
 drivers/firmware/tegra/Kconfig                                    |    5 
 drivers/gpio/gpio-loongson-64bit.c                                |    6 
 drivers/gpio/gpio-mlxbf2.c                                        |    2 
 drivers/gpio/gpio-mlxbf3.c                                        |   54 
 drivers/gpio/gpio-pxa.c                                           |    8 
 drivers/gpio/gpio-tps65912.c                                      |    7 
 drivers/gpio/gpio-virtio.c                                        |    9 
 drivers/gpio/gpio-wcd934x.c                                       |    7 
 drivers/gpu/drm/amd/amdgpu/aldebaran.c                            |   33 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c                          |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c                           |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                           |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h                           |   11 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c                    |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c                      |    3 
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c                            |    4 
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c                            |   31 
 drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c                          |   25 
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c                            |   18 
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c                            |   25 
 drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c                          |   25 
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c                            |   25 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                 |   28 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c             |    6 
 drivers/gpu/drm/amd/display/dc/core/dc.c                          |   12 
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c           |   11 
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c                   |    3 
 drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c            |    2 
 drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c  |    1 
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c                 |   16 
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                                |    5 
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c                  |   37 
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h                            |   41 
 drivers/gpu/drm/clients/drm_client_setup.c                        |    5 
 drivers/gpu/drm/i915/display/intel_fbc.c                          |    8 
 drivers/gpu/drm/i915/display/intel_psr.c                          |   14 
 drivers/gpu/drm/imagination/pvr_power.c                           |   59 
 drivers/gpu/drm/msm/Makefile                                      |    5 
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c                         |    2 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h                             |    4 
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c                       |    2 
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h                       |    2 
 drivers/gpu/drm/msm/adreno/a6xx_preempt.c                         |    2 
 drivers/gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h             |    4 
 drivers/gpu/drm/msm/msm_drv.c                                     |    9 
 drivers/gpu/drm/msm/msm_gem.c                                     |    3 
 drivers/gpu/drm/msm/msm_gem.h                                     |    6 
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml                     | 3582 +---------
 drivers/gpu/drm/msm/registers/adreno/a6xx_descriptors.xml         |  198 
 drivers/gpu/drm/msm/registers/adreno/a6xx_enums.xml               |  383 +
 drivers/gpu/drm/msm/registers/adreno/a6xx_perfcntrs.xml           |  600 +
 drivers/gpu/drm/msm/registers/adreno/a7xx_enums.xml               |  223 
 drivers/gpu/drm/msm/registers/adreno/a7xx_perfcntrs.xml           | 1030 ++
 drivers/gpu/drm/msm/registers/adreno/adreno_pm4.xml               |  302 
 drivers/gpu/drm/panel/panel-raydium-rm67200.c                     |   22 
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c                    |    3 
 drivers/gpu/drm/scheduler/sched_main.c                            |   34 
 drivers/gpu/drm/scheduler/tests/tests_basic.c                     |   42 
 drivers/gpu/drm/ttm/ttm_pool.c                                    |    8 
 drivers/gpu/drm/ttm/ttm_resource.c                                |    3 
 drivers/gpu/drm/xe/xe_guc_exec_queue_types.h                      |    2 
 drivers/gpu/drm/xe/xe_guc_submit.c                                |    7 
 drivers/gpu/drm/xe/xe_hw_fence.c                                  |    3 
 drivers/gpu/drm/xe/xe_hwmon.c                                     |   29 
 drivers/gpu/drm/xe/xe_migrate.c                                   |   42 
 drivers/gpu/drm/xe/xe_query.c                                     |   27 
 drivers/hid/hid-core.c                                            |    4 
 drivers/hwmon/emc2305.c                                           |   10 
 drivers/i2c/i2c-core-acpi.c                                       |    1 
 drivers/i2c/i2c-core-base.c                                       |    8 
 drivers/i3c/internals.h                                           |    1 
 drivers/i3c/master.c                                              |    4 
 drivers/idle/intel_idle.c                                         |    2 
 drivers/iio/adc/ad7768-1.c                                        |   23 
 drivers/iio/adc/ad_sigma_delta.c                                  |    2 
 drivers/infiniband/core/nldev.c                                   |   22 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                          |    2 
 drivers/infiniband/hw/hfi1/affinity.c                             |   44 
 drivers/infiniband/sw/siw/siw_qp_tx.c                             |    5 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                       |    7 
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c                        |    1 
 drivers/iommu/intel/iommu.c                                       |   19 
 drivers/iommu/intel/iommu.h                                       |    3 
 drivers/iommu/iommufd/io_pagetable.c                              |   48 
 drivers/irqchip/irq-mips-gic.c                                    |    8 
 drivers/irqchip/irq-mvebu-gicp.c                                  |   10 
 drivers/irqchip/irq-renesas-rzv2h.c                               |    4 
 drivers/leds/flash/leds-qcom-flash.c                              |   15 
 drivers/leds/leds-lp50xx.c                                        |   11 
 drivers/leds/trigger/ledtrig-netdev.c                             |   16 
 drivers/md/dm-ps-historical-service-time.c                        |    4 
 drivers/md/dm-ps-queue-length.c                                   |    4 
 drivers/md/dm-ps-round-robin.c                                    |    4 
 drivers/md/dm-ps-service-time.c                                   |    4 
 drivers/md/dm-stripe.c                                            |    1 
 drivers/md/dm-table.c                                             |   10 
 drivers/md/dm-zoned-target.c                                      |    2 
 drivers/md/dm.c                                                   |   37 
 drivers/md/raid10.c                                               |    1 
 drivers/media/dvb-frontends/dib7000p.c                            |    8 
 drivers/media/i2c/hi556.c                                         |    7 
 drivers/media/i2c/lt6911uxe.c                                     |    2 
 drivers/media/i2c/tc358743.c                                      |   86 
 drivers/media/i2c/vd55g1.c                                        |   11 
 drivers/media/pci/intel/ipu-bridge.c                              |    2 
 drivers/media/platform/qcom/iris/iris_buffer.c                    |   11 
 drivers/media/platform/qcom/iris/iris_hfi_gen1_defines.h          |    2 
 drivers/media/platform/qcom/iris/iris_hfi_gen1_response.c         |    6 
 drivers/media/platform/qcom/venus/hfi_msgs.c                      |   83 
 drivers/media/platform/raspberrypi/rp1-cfe/cfe.c                  |    4 
 drivers/media/usb/hdpvr/hdpvr-i2c.c                               |    6 
 drivers/media/usb/uvc/uvc_ctrl.c                                  |   65 
 drivers/media/usb/uvc/uvc_driver.c                                |   12 
 drivers/media/usb/uvc/uvc_video.c                                 |   21 
 drivers/media/usb/uvc/uvcvideo.h                                  |    2 
 drivers/media/v4l2-core/v4l2-common.c                             |   14 
 drivers/mfd/axp20x.c                                              |    3 
 drivers/mfd/cros_ec_dev.c                                         |   10 
 drivers/misc/cardreader/rtsx_usb.c                                |   16 
 drivers/misc/mei/bus.c                                            |    6 
 drivers/mmc/host/rtsx_usb_sdmmc.c                                 |    4 
 drivers/mmc/host/sdhci-esdhc-imx.c                                |   16 
 drivers/mmc/host/sdhci-msm.c                                      |   14 
 drivers/net/can/ti_hecc.c                                         |    2 
 drivers/net/dsa/b53/b53_common.c                                  |   78 
 drivers/net/dsa/b53/b53_regs.h                                    |    7 
 drivers/net/ethernet/agere/et131x.c                               |   36 
 drivers/net/ethernet/aquantia/atlantic/aq_hw.h                    |    2 
 drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c |   39 
 drivers/net/ethernet/atheros/ag71xx.c                             |    9 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                         |   29 
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c                 |    4 
 drivers/net/ethernet/emulex/benet/be_main.c                       |    8 
 drivers/net/ethernet/faraday/ftgmac100.c                          |    7 
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c                    |    2 
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c                |    4 
 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c              |   15 
 drivers/net/ethernet/freescale/enetc/enetc_hw.h                   |    1 
 drivers/net/ethernet/freescale/enetc/enetc_pf.c                   |   14 
 drivers/net/ethernet/freescale/fec_main.c                         |   34 
 drivers/net/ethernet/freescale/gianfar_ethtool.c                  |    4 
 drivers/net/ethernet/google/gve/gve_adminq.c                      |    1 
 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c                  |   14 
 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c                   |   15 
 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.h                 |    7 
 drivers/net/ethernet/intel/idpf/idpf.h                            |   19 
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c                    |   36 
 drivers/net/ethernet/intel/idpf/idpf_lib.c                        |   18 
 drivers/net/ethernet/intel/idpf/idpf_main.c                       |    1 
 drivers/net/ethernet/intel/idpf/idpf_txrx.c                       |   13 
 drivers/net/ethernet/mediatek/mtk_wed.c                           |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en/qos.c                  |    2 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c                   |    7 
 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c                 |   14 
 drivers/net/ethernet/ti/icssg/icss_iep.c                          |   26 
 drivers/net/ethernet/ti/icssg/icssg_prueth.c                      |    6 
 drivers/net/hamradio/bpqether.c                                   |    2 
 drivers/net/hyperv/hyperv_net.h                                   |    3 
 drivers/net/hyperv/netvsc_drv.c                                   |   29 
 drivers/net/pcs/pcs-xpcs-plat.c                                   |    4 
 drivers/net/phy/air_en8811h.c                                     |   45 
 drivers/net/phy/broadcom.c                                        |   25 
 drivers/net/phy/mdio_bus.c                                        |    1 
 drivers/net/phy/mdio_bus_provider.c                               |    3 
 drivers/net/phy/micrel.c                                          |   12 
 drivers/net/phy/nxp-c45-tja11xx.c                                 |   23 
 drivers/net/phy/realtek/realtek_main.c                            |   10 
 drivers/net/phy/smsc.c                                            |    1 
 drivers/net/thunderbolt/main.c                                    |   21 
 drivers/net/usb/asix_devices.c                                    |    1 
 drivers/net/usb/cdc_ncm.c                                         |   20 
 drivers/net/usb/qmi_wwan.c                                        |    1 
 drivers/net/wan/lapbether.c                                       |    2 
 drivers/net/wireless/ath/ath10k/core.c                            |   48 
 drivers/net/wireless/ath/ath10k/core.h                            |   11 
 drivers/net/wireless/ath/ath10k/mac.c                             |    7 
 drivers/net/wireless/ath/ath10k/wmi.c                             |    6 
 drivers/net/wireless/ath/ath12k/dp.c                              |    3 
 drivers/net/wireless/ath/ath12k/hw.c                              |    2 
 drivers/net/wireless/ath/ath12k/mac.c                             |   57 
 drivers/net/wireless/ath/ath12k/wmi.c                             |    5 
 drivers/net/wireless/intel/iwlegacy/4965-mac.c                    |    5 
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c                       |    2 
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c                       |    7 
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c                      |    8 
 drivers/net/wireless/intel/iwlwifi/mld/agg.c                      |    5 
 drivers/net/wireless/intel/iwlwifi/mld/iface.h                    |    3 
 drivers/net/wireless/intel/iwlwifi/mld/link.c                     |    8 
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c                 |    1 
 drivers/net/wireless/intel/iwlwifi/mld/mld.c                      |    2 
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c                      |    8 
 drivers/net/wireless/intel/iwlwifi/mld/scan.c                     |    2 
 drivers/net/wireless/intel/iwlwifi/mld/scan.h                     |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c                       |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c                     |    5 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c                     |    2 
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h                |    1 
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c              |    5 
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c                   |    2 
 drivers/net/wireless/mediatek/mt76/channel.c                      |    4 
 drivers/net/wireless/mediatek/mt76/mt76.h                         |    5 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                   |   28 
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                   |    4 
 drivers/net/wireless/realtek/rtlwifi/pci.c                        |   23 
 drivers/net/wireless/realtek/rtw89/chan.c                         |    6 
 drivers/net/wireless/realtek/rtw89/coex.c                         |   12 
 drivers/net/wireless/realtek/rtw89/core.c                         |    3 
 drivers/net/wireless/realtek/rtw89/fw.c                           |   10 
 drivers/net/wireless/realtek/rtw89/fw.h                           |    2 
 drivers/net/wireless/realtek/rtw89/mac.c                          |   19 
 drivers/net/wireless/realtek/rtw89/reg.h                          |    1 
 drivers/net/wireless/realtek/rtw89/wow.c                          |    5 
 drivers/net/xen-netfront.c                                        |    5 
 drivers/nvme/host/pci.c                                           |   24 
 drivers/nvme/host/tcp.c                                           |   11 
 drivers/pci/controller/dwc/pcie-dw-rockchip.c                     |   15 
 drivers/pci/pci-acpi.c                                            |    4 
 drivers/pci/pci.c                                                 |    6 
 drivers/pci/probe.c                                               |    2 
 drivers/perf/arm-cmn.c                                            |    1 
 drivers/perf/arm-ni.c                                             |    1 
 drivers/perf/cxl_pmu.c                                            |    2 
 drivers/phy/rockchip/phy-rockchip-pcie.c                          |   15 
 drivers/pinctrl/stm32/pinctrl-stm32.c                             |    1 
 drivers/platform/chrome/cros_ec_sensorhub.c                       |   23 
 drivers/platform/chrome/cros_ec_typec.c                           |    4 
 drivers/platform/x86/amd/pmc/pmc-quirks.c                         |    9 
 drivers/platform/x86/thinkpad_acpi.c                              |    4 
 drivers/pmdomain/imx/imx8m-blk-ctrl.c                             |   10 
 drivers/pmdomain/ti/Kconfig                                       |    2 
 drivers/power/supply/qcom_battmgr.c                               |    2 
 drivers/pps/clients/pps-gpio.c                                    |    5 
 drivers/ptp/ptp_clock.c                                           |    2 
 drivers/ptp/ptp_private.h                                         |    5 
 drivers/ptp/ptp_vclock.c                                          |    7 
 drivers/remoteproc/imx_rproc.c                                    |    4 
 drivers/reset/Kconfig                                             |   10 
 drivers/rtc/rtc-ds1307.c                                          |   15 
 drivers/s390/char/sclp.c                                          |    4 
 drivers/scsi/aacraid/comminit.c                                   |    3 
 drivers/scsi/bfa/bfad_im.c                                        |    1 
 drivers/scsi/libiscsi.c                                           |    3 
 drivers/scsi/lpfc/lpfc_debugfs.c                                  |    1 
 drivers/scsi/lpfc/lpfc_hbadisc.c                                  |    3 
 drivers/scsi/lpfc/lpfc_scsi.c                                     |    4 
 drivers/scsi/mpi3mr/mpi3mr_os.c                                   |   20 
 drivers/scsi/mpt3sas/mpt3sas_scsih.c                              |   19 
 drivers/scsi/pm8001/pm80xx_hwi.c                                  |   12 
 drivers/scsi/scsi_scan.c                                          |    2 
 drivers/scsi/scsi_transport_sas.c                                 |   60 
 drivers/soc/qcom/mdt_loader.c                                     |   10 
 drivers/soc/qcom/rpmh-rsc.c                                       |    2 
 drivers/soundwire/amd_manager.c                                   |    7 
 drivers/soundwire/bus.c                                           |    6 
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c                         |   14 
 drivers/target/target_core_fabric_lib.c                           |   63 
 drivers/target/target_core_internal.h                             |    4 
 drivers/target/target_core_pr.c                                   |   18 
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c                       |   43 
 drivers/thermal/thermal_sysfs.c                                   |    9 
 drivers/thunderbolt/domain.c                                      |    2 
 drivers/tty/serial/serial_core.c                                  |   44 
 drivers/ufs/core/ufshcd.c                                         |    9 
 drivers/usb/class/cdc-acm.c                                       |   11 
 drivers/usb/core/config.c                                         |   10 
 drivers/usb/core/urb.c                                            |    2 
 drivers/usb/dwc3/dwc3-xilinx.c                                    |    1 
 drivers/usb/host/xhci-mem.c                                       |    2 
 drivers/usb/host/xhci-ring.c                                      |   10 
 drivers/usb/host/xhci.c                                           |    6 
 drivers/usb/typec/mux/intel_pmc_mux.c                             |    2 
 drivers/usb/typec/tcpm/fusb302.c                                  |    8 
 drivers/usb/typec/tcpm/tcpci_maxim_core.c                         |   46 
 drivers/usb/typec/ucsi/cros_ec_ucsi.c                             |    1 
 drivers/usb/typec/ucsi/psy.c                                      |    2 
 drivers/usb/typec/ucsi/ucsi.c                                     |    1 
 drivers/usb/typec/ucsi/ucsi.h                                     |    7 
 drivers/vfio/pci/mlx5/cmd.c                                       |    4 
 drivers/vfio/vfio_iommu_type1.c                                   |    7 
 drivers/vhost/vhost.c                                             |    3 
 drivers/video/fbdev/Kconfig                                       |    2 
 drivers/video/fbdev/core/fbcon.c                                  |    9 
 drivers/video/fbdev/core/fbmem.c                                  |    3 
 drivers/virt/coco/efi_secret/efi_secret.c                         |   10 
 drivers/watchdog/dw_wdt.c                                         |    2 
 drivers/watchdog/iTCO_wdt.c                                       |    6 
 drivers/watchdog/sbsa_gwdt.c                                      |   50 
 fs/btrfs/block-group.c                                            |   31 
 fs/btrfs/ctree.c                                                  |    1 
 fs/btrfs/disk-io.c                                                |    1 
 fs/btrfs/extent-tree.c                                            |   33 
 fs/btrfs/file.c                                                   |   59 
 fs/btrfs/inode.c                                                  |    2 
 fs/btrfs/ioctl.c                                                  |    3 
 fs/btrfs/qgroup.c                                                 |   44 
 fs/btrfs/relocation.c                                             |   19 
 fs/btrfs/send.c                                                   |   33 
 fs/btrfs/transaction.c                                            |    6 
 fs/btrfs/tree-log.c                                               |  107 
 fs/btrfs/zoned.c                                                  |   66 
 fs/btrfs/zoned.h                                                  |    3 
 fs/crypto/fscrypt_private.h                                       |   17 
 fs/crypto/hkdf.c                                                  |    2 
 fs/crypto/keysetup.c                                              |    3 
 fs/crypto/keysetup_v1.c                                           |    3 
 fs/erofs/super.c                                                  |    4 
 fs/exfat/dir.c                                                    |   12 
 fs/exfat/fatent.c                                                 |   10 
 fs/exfat/namei.c                                                  |    5 
 fs/exfat/super.c                                                  |   32 
 fs/ext2/inode.c                                                   |   12 
 fs/ext4/ext4.h                                                    |    2 
 fs/ext4/ialloc.c                                                  |    3 
 fs/ext4/inline.c                                                  |   19 
 fs/ext4/inode.c                                                   |   22 
 fs/ext4/mballoc-test.c                                            |    9 
 fs/ext4/mballoc.c                                                 |   67 
 fs/f2fs/file.c                                                    |   24 
 fs/f2fs/node.c                                                    |   29 
 fs/fhandle.c                                                      |    2 
 fs/file.c                                                         |   15 
 fs/gfs2/dir.c                                                     |    6 
 fs/gfs2/glops.c                                                   |    6 
 fs/gfs2/meta_io.c                                                 |    2 
 fs/hfs/bfind.c                                                    |    3 
 fs/hfs/bnode.c                                                    |   93 
 fs/hfs/btree.c                                                    |   57 
 fs/hfs/extent.c                                                   |    2 
 fs/hfs/hfs_fs.h                                                   |    1 
 fs/hfsplus/bnode.c                                                |   92 
 fs/hfsplus/unicode.c                                              |    7 
 fs/hfsplus/xattr.c                                                |    6 
 fs/jfs/file.c                                                     |    3 
 fs/jfs/inode.c                                                    |    2 
 fs/jfs/jfs_dmap.c                                                 |    6 
 fs/libfs.c                                                        |    4 
 fs/nfs/blocklayout/blocklayout.c                                  |    4 
 fs/nfs/blocklayout/dev.c                                          |    5 
 fs/nfs/blocklayout/extent_tree.c                                  |   20 
 fs/nfs/client.c                                                   |   44 
 fs/nfs/internal.h                                                 |    2 
 fs/nfs/nfs4client.c                                               |   20 
 fs/nfs/nfs4proc.c                                                 |    2 
 fs/nfs/pnfs.c                                                     |   11 
 fs/nfsd/nfs4state.c                                               |   34 
 fs/ntfs3/dir.c                                                    |    3 
 fs/ntfs3/inode.c                                                  |   31 
 fs/ocfs2/aops.c                                                   |    1 
 fs/orangefs/orangefs-debugfs.c                                    |    2 
 fs/pidfs.c                                                        |    2 
 fs/proc/task_mmu.c                                                |    6 
 fs/smb/client/cifsencrypt.c                                       |   79 
 fs/smb/client/cifssmb.c                                           |   10 
 fs/smb/client/compress.c                                          |   71 
 fs/smb/client/connect.c                                           |    1 
 fs/smb/client/sess.c                                              |    9 
 fs/smb/client/smb2ops.c                                           |   11 
 fs/smb/client/smbdirect.c                                         |   25 
 fs/smb/server/smb2pdu.c                                           |   16 
 fs/tracefs/inode.c                                                |   11 
 fs/udf/super.c                                                    |   13 
 fs/xfs/scrub/trace.h                                              |    2 
 include/drm/gpu_scheduler.h                                       |   18 
 include/linux/acpi.h                                              |    2 
 include/linux/blk_types.h                                         |    6 
 include/linux/blkdev.h                                            |   55 
 include/linux/hid.h                                               |    2 
 include/linux/hypervisor.h                                        |    3 
 include/linux/if_vlan.h                                           |   21 
 include/linux/libata.h                                            |    1 
 include/linux/memory-tiers.h                                      |    2 
 include/linux/packing.h                                           |    6 
 include/linux/pci.h                                               |    6 
 include/linux/sbitmap.h                                           |    6 
 include/linux/skbuff.h                                            |    8 
 include/linux/usb/cdc_ncm.h                                       |    1 
 include/linux/virtio_vsock.h                                      |    7 
 include/net/bluetooth/hci.h                                       |    6 
 include/net/bluetooth/hci_core.h                                  |    5 
 include/net/cfg80211.h                                            |    2 
 include/net/ip_vs.h                                               |   13 
 include/net/kcm.h                                                 |    1 
 include/net/mac80211.h                                            |    4 
 include/net/page_pool/types.h                                     |    2 
 include/sound/sdca_function.h                                     |    2 
 include/trace/events/thp.h                                        |    2 
 include/uapi/linux/in6.h                                          |    4 
 include/uapi/linux/io_uring.h                                     |    2 
 io_uring/memmap.c                                                 |    2 
 io_uring/net.c                                                    |   27 
 io_uring/rsrc.c                                                   |    4 
 io_uring/rsrc.h                                                   |    2 
 io_uring/rw.c                                                     |    2 
 io_uring/zcrx.c                                                   |   34 
 io_uring/zcrx.h                                                   |    1 
 kernel/.gitignore                                                 |    2 
 kernel/Makefile                                                   |   47 
 kernel/bpf/verifier.c                                             |    7 
 kernel/futex/futex.h                                              |    6 
 kernel/gen_kheaders.sh                                            |   94 
 kernel/kthread.c                                                  |    1 
 kernel/module/main.c                                              |   10 
 kernel/power/console.c                                            |    7 
 kernel/printk/nbcon.c                                             |   63 
 kernel/rcu/rcutorture.c                                           |    9 
 kernel/rcu/tree.c                                                 |    2 
 kernel/rcu/tree.h                                                 |   14 
 kernel/rcu/tree_nocb.h                                            |    5 
 kernel/rcu/tree_plugin.h                                          |   44 
 kernel/sched/deadline.c                                           |    4 
 kernel/sched/fair.c                                               |   19 
 kernel/sched/rt.c                                                 |    6 
 kernel/trace/fprobe.c                                             |    4 
 kernel/trace/rv/rv_trace.h                                        |    3 
 lib/sbitmap.c                                                     |   56 
 mm/damon/core.c                                                   |    1 
 mm/huge_memory.c                                                  |    7 
 mm/kmemleak.c                                                     |   10 
 mm/ptdump.c                                                       |    2 
 mm/shmem.c                                                        |   39 
 mm/slub.c                                                         |    7 
 mm/userfaultfd.c                                                  |   17 
 net/bluetooth/hci_conn.c                                          |    3 
 net/bluetooth/hci_event.c                                         |   39 
 net/bluetooth/hci_sock.c                                          |    2 
 net/core/ieee8021q_helpers.c                                      |   44 
 net/core/page_pool.c                                              |   29 
 net/ipv4/route.c                                                  |    1 
 net/ipv4/udp_offload.c                                            |    2 
 net/ipv6/addrconf.c                                               |    7 
 net/ipv6/mcast.c                                                  |   11 
 net/ipv6/xfrm6_tunnel.c                                           |    2 
 net/kcm/kcmsock.c                                                 |   10 
 net/mac80211/chan.c                                               |    1 
 net/mac80211/ht.c                                                 |   40 
 net/mac80211/ieee80211_i.h                                        |    6 
 net/mac80211/iface.c                                              |   29 
 net/mac80211/link.c                                               |    9 
 net/mac80211/mlme.c                                               |   45 
 net/mac80211/rx.c                                                 |   47 
 net/mctp/af_mctp.c                                                |   26 
 net/ncsi/internal.h                                               |    2 
 net/ncsi/ncsi-rsp.c                                               |    1 
 net/netfilter/ipvs/ip_vs_est.c                                    |    3 
 net/netfilter/nf_conntrack_netlink.c                              |   65 
 net/netfilter/nf_tables_api.c                                     |   30 
 net/netfilter/nft_set_pipapo.c                                    |    9 
 net/netlink/af_netlink.c                                          |    2 
 net/sched/sch_ets.c                                               |   11 
 net/sctp/input.c                                                  |    2 
 net/tls/tls.h                                                     |    2 
 net/tls/tls_strp.c                                                |   11 
 net/tls/tls_sw.c                                                  |    3 
 net/vmw_vsock/virtio_transport.c                                  |    2 
 net/wireless/mlme.c                                               |    3 
 net/xfrm/xfrm_device.c                                            |   12 
 net/xfrm/xfrm_state.c                                             |   74 
 rust/Makefile                                                     |   16 
 samples/damon/mtier.c                                             |   10 
 samples/damon/wsse.c                                              |   12 
 scripts/kconfig/gconf.c                                           |    8 
 scripts/kconfig/lxdialog/inputbox.c                               |    6 
 scripts/kconfig/lxdialog/menubox.c                                |    2 
 scripts/kconfig/nconf.c                                           |    2 
 scripts/kconfig/nconf.gui.c                                       |    1 
 security/apparmor/domain.c                                        |   52 
 security/apparmor/file.c                                          |    6 
 security/apparmor/include/lib.h                                   |    6 
 security/inode.c                                                  |    2 
 security/landlock/syscalls.c                                      |    1 
 sound/core/pcm_native.c                                           |   19 
 sound/pci/hda/cs35l41_hda.c                                       |    2 
 sound/pci/hda/cs35l56_hda.c                                       |    4 
 sound/pci/hda/hda_codec.c                                         |   42 
 sound/pci/hda/patch_ca0132.c                                      |    2 
 sound/pci/hda/patch_realtek.c                                     |    3 
 sound/pci/intel8x0.c                                              |    2 
 sound/soc/codecs/hdac_hdmi.c                                      |   10 
 sound/soc/codecs/rt5640.c                                         |    5 
 sound/soc/fsl/fsl_sai.c                                           |   20 
 sound/soc/intel/avs/core.c                                        |    3 
 sound/soc/intel/boards/sof_sdw.c                                  |    8 
 sound/soc/qcom/lpass-platform.c                                   |   27 
 sound/soc/sdca/sdca_functions.c                                   |    2 
 sound/soc/soc-core.c                                              |    3 
 sound/soc/soc-dapm.c                                              |    4 
 sound/soc/sof/topology.c                                          |   15 
 sound/usb/mixer_quirks.c                                          |   14 
 sound/usb/stream.c                                                |   25 
 sound/usb/validate.c                                              |   12 
 tools/bpf/bpftool/main.c                                          |    6 
 tools/include/nolibc/std.h                                        |    4 
 tools/include/nolibc/types.h                                      |    4 
 tools/lib/bpf/libbpf.c                                            |    7 
 tools/power/cpupower/utils/idle_monitor/mperf_monitor.c           |    4 
 tools/power/x86/turbostat/turbostat.c                             |   14 
 tools/scripts/Makefile.include                                    |    4 
 tools/testing/ktest/ktest.pl                                      |    5 
 tools/testing/selftests/arm64/fp/sve-ptrace.c                     |    3 
 tools/testing/selftests/bpf/prog_tests/ringbuf.c                  |    4 
 tools/testing/selftests/bpf/prog_tests/user_ringbuf.c             |   10 
 tools/testing/selftests/bpf/progs/test_ringbuf_write.c            |    4 
 tools/testing/selftests/bpf/progs/verifier_unpriv.c               |    2 
 tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc  |    2 
 tools/testing/selftests/futex/include/futextest.h                 |   11 
 tools/testing/selftests/kexec/Makefile                            |    2 
 tools/testing/selftests/net/netfilter/config                      |    2 
 tools/testing/selftests/vDSO/vdso_test_getrandom.c                |    6 
 tools/verification/dot2/dot2k.py                                  |    3 
 tools/verification/dot2/dot2k_templates/Kconfig_container         |    5 
 615 files changed, 8824 insertions(+), 5279 deletions(-)

Aakash Kumar S (1):
      xfrm: Duplicate SPI Handling

Aaron Kling (1):
      ARM: tegra: Use I/O memcpy to write to IRAM

Aaron Plattner (1):
      watchdog: sbsa: Adjust keepalive timeout to avoid MediaTek WS0 race condition

Abel Vesa (1):
      power: supply: qcom_battmgr: Add lithium-polymer entry

Ahmed Zaki (1):
      idpf: preserve coalescing settings across resets

Al Viro (5):
      habanalabs: fix UAF in export_dmabuf()
      better lockdep annotations for simple_recursive_removal()
      landlock: opened file never has a negative dentry
      fix locking in efi_secret_unlink()
      securityfs: don't pin dentries twice, once is enough...

Alessio Belle (1):
      drm/imagination: Clear runtime PM errors while resetting the GPU

Alex Guo (2):
      media: dvb-frontends: dib7090p: fix null-ptr-deref in dib7090p_rw_on_apb()
      media: dvb-frontends: w7090p: fix null-ptr-deref in w7090p_tuner_write_serpar and w7090p_tuner_read_serpar

Alex Hung (1):
      drm/amd/display: Initialize mode_select to 0

Alexander Kochetkov (1):
      ARM: rockchip: fix kernel hang during smp initialization

Alexey Klimov (1):
      iommu/arm-smmu-qcom: Add SM6115 MDSS compatible

Alok Tiwari (6):
      net: ti: icss-iep: Fix incorrect type for return value in extts_enable()
      ALSA: intel8x0: Fix incorrect codec index usage in mixer for ICH4
      be2net: Use correct byte order and format string for TCP seq and ack_seq
      net: thunderx: Fix format-truncation warning in bgx_acpi_match_id()
      perf/cxlpmu: Remove unintended newline from IRQ name format string
      gve: Return error for unknown admin queue command

Amelie Delaunay (1):
      dmaengine: stm32-dma: configure next sg only if there are more than 2 sgs

Amir Mohammad Jahangirzad (1):
      fs/orangefs: use snprintf() instead of sprintf()

Andrew Price (2):
      gfs2: Validate i_depth for exhash directories
      gfs2: Set .migrate_folio in gfs2_{rgrp,meta}_aops

Andrey Albershteyn (1):
      xfs: fix scrub trace with null pointer in quotacheck

André Draszik (4):
      clk: samsung: exynos850: fix a comment
      clk: samsung: gs101: fix CLK_DOUT_CMU_G3D_BUSD
      clk: samsung: gs101: fix alternate mout_hsi0_usb20_ref parent clock
      usb: typec: tcpm/tcpci_maxim: fix irq wake usage

Andy Shevchenko (1):
      Documentation: ACPI: Fix parent device references

Andy Yan (1):
      drm/panel: raydium-rm67200: Move initialization from enable() to prepare stage

Anshuman Khandual (1):
      mm/ptdump: take the memory hotplug lock inside ptdump_walk_pgd()

Anthoine Bourgeois (1):
      xen/netfront: Fix TX response spurious interrupts

Armin Wolf (1):
      ACPI: EC: Relax sanity check of the ECDT ID string

Arnaud Lecomte (1):
      jfs: upper bound check of tree index in dbAllocAG

Arnd Bergmann (2):
      RDMA/core: reduce stack using in nldev_stat_get_doit()
      firmware: arm_scmi: Convert to SYSTEM_SLEEP_PM_OPS

Artem Sadovnikov (1):
      vfio/mlx5: fix possible overflow in tracking max message size

Avraham Stern (4):
      wifi: iwlwifi: mld: avoid outdated reorder buffer head_sn
      wifi: iwlwifi: mvm: avoid outdated reorder buffer head_sn
      wifi: iwlwifi: mld: fix scan request validation
      wifi: iwlwifi: mvm: fix scan request validation

Baokun Li (2):
      ext4: fix zombie groups in average fragment size lists
      ext4: fix largest free orders lists corruption on mb_optimize_scan switch

Bartosz Golaszewski (3):
      Revert "gpio: pxa: Make irq_chip immutable"
      gpio: wcd934x: check the return value of regmap_update_bits()
      gpio: tps65912: check the return value of regmap_update_bits()

Benjamin Berg (1):
      wifi: iwlwifi: mld: use the correct struct size for tracing

Benjamin Marzinski (1):
      dm-table: fix checking for rq stackable devices

Benjamin Mugnier (3):
      media: i2c: vd55g1: Setup sensor external clock before patching
      media: i2c: vd55g1: Fix RATE macros not being expressed in bps
      media: i2c: vd55g1: Fix return code in vd55g1_enable_streams error path

Benson Leung (1):
      usb: typec: ucsi: psy: Set current max to 100mA for BC 1.2 and Default

Bharat Bhushan (1):
      crypto: octeontx2 - add timeout for load_fvc completion poll

Bijan Tabatabai (1):
      mm/damon/core: commit damos->target_nid

Biju Das (2):
      irqchip/renesas-rzv2h: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND
      net: phy: micrel: Add ksz9131_resume()

Binbin Zhou (1):
      gpio: loongson-64bit: Extend GPIO irq support

Bitterblue Smith (3):
      wifi: rtw89: Lower the timeout in rtw89_fw_read_c2h_reg() for USB
      wifi: rtw89: Fix rtw89_mac_power_switch() for USB
      wifi: rtw89: Disable deep power saving for USB/SDIO

Bjorn Andersson (1):
      soc: qcom: mdt_loader: Actually use the e_phoff

Boris Burkov (2):
      btrfs: fix ssd_spread overallocation
      btrfs: fix iteration bug in __qgroup_excl_accounting()

Breno Leitao (5):
      ACPI: APEI: GHES: add TAINT_MACHINE_CHECK on GHES panic path
      arm64: Mark kernel as tainted on SAE and SError panic
      ptp: Use ratelimite for freerun error message
      ipmi: Use dev_warn_ratelimited() for incorrect message warnings
      mm/kmemleak: avoid deadlock by moving pr_warn() outside kmemleak_lock

Buday Csaba (2):
      net: mdiobus: release reset_gpio in mdiobus_unregister_device()
      net: phy: smsc: add proper reset flags for LAN8710A

Caleb Sander Mateos (2):
      ublk: check for unprivileged daemon on each I/O fetch
      btrfs: don't skip accounting in early ENOTTY return in btrfs_uring_encoded_read()

Calvin Owens (2):
      tools/power turbostat: Fix build with musl
      tools/power turbostat: Handle cap_get_proc() ENOSYS

Cezary Rojewski (1):
      ASoC: Intel: avs: Fix uninitialized pointer error in probe()

Chao Yu (1):
      f2fs: handle nat.blkaddr corruption in f2fs_get_node_info()

Charlene Liu (1):
      drm/amd/display: limit clear_update_flags to dcn32 and above

Charles Keepax (2):
      ASoC: SDCA: Add flag for unused IRQs
      soundwire: Move handle_nested_irq outside of sdw_dev_lock

Cheick Traore (1):
      pinctrl: stm32: Manage irq affinity settings

Chen-Yu Tsai (1):
      mfd: axp20x: Set explicit ID for AXP313 regulator

Chih-Kang Chang (1):
      wifi: rtw89: scan abort when assign/unassign_vif

Chin-Yen Lee (1):
      wifi: rtw89: wow: Add Basic Rate IE to probe request in scheduled scan mode

Ching-Te Ku (1):
      wifi: rtw89: coex: Not to set slot duration to zero to avoid firmware issue

Chris Mason (1):
      sched/fair: Bump sd->max_newidle_lb_cost when newidle balance fails

Christian Brauner (2):
      fhandle: raise FILEID_IS_DIR in handle_type
      pidfs: raise SB_I_NODEV and SB_I_NOEXEC

Christian Marangi (1):
      clk: qcom: gcc-ipq8074: fix broken freq table for nss_port6_tx_clk_src

Christophe Leroy (1):
      ALSA: pcm: Rewrite recalculate_boundary() to avoid costly loop

Christopher Eby (1):
      ALSA: hda/realtek: Add Framework Laptop 13 (AMD Ryzen AI 300) to quirks

Clark Wang (1):
      net: phy: nxp-c45-tja11xx: fix the PHY ID mismatch issue when using C45

Claudiu Beznea (1):
      clk: renesas: rzg2l: Postpone updating priv->clks[]

Corey Minyard (1):
      ipmi: Fix strcpy source and destination the same

Cristian Ciocaltea (1):
      ALSA: usb-audio: Avoid precedence issues in mixer_quirks macros

Cynthia Huang (1):
      selftests/futex: Define SYS_futex on 32-bit architectures with 64-bit time_t

Dai Ngo (1):
      NFSD: detect mismatch of file handle and delegation stateid in OPEN op

Damien Le Moal (9):
      block: Make REQ_OP_ZONE_FINISH a write operation
      ata: ahci: Disallow LPM policy control if not supported
      ata: ahci: Disable DIPM if host lacks support
      ata: libata-sata: Disallow changing LPM state if not supported
      scsi: mpt3sas: Correctly handle ATA device errors
      scsi: mpi3mr: Correctly handle ATA device errors
      block: Introduce bio_needs_zone_write_plugging()
      dm: Always split write BIOs to zoned device limits
      ata: libata-sata: Add link_power_management_supported sysfs attribute

Daniel Braunwarth (1):
      net: phy: realtek: add error handling to rtl8211f_get_wol

Daniel Golle (1):
      Revert "leds: trigger: netdev: Configure LED blink interval for HW offload"

Daniel Scally (1):
      media: ipu-bridge: Add _HID for OV5670

Daniele Palmas (1):
      bus: mhi: host: pci_generic: Add Telit FN990B40 modem support

Dave Penkler (1):
      staging: gpib: Add init response codes for new ni-usb-hs+

Dave Stevenson (3):
      media: tc358743: Check I2C succeeded during probe
      media: tc358743: Return an appropriate colorspace from tc358743_set_fmt
      media: tc358743: Increase FIFO trigger level to 374

David Bauer (2):
      wifi: mt76: mt7915: mcu: re-init MCU before loading FW patch
      wifi: mt76: mt7915: mcu: increase eeprom command timeout

David Collins (1):
      thermal/drivers/qcom-spmi-temp-alarm: Enable stage 2 shutdown when required

David Hildenbrand (1):
      mm/huge_memory: don't ignore queried cachemode in vmf_insert_pfn_pud()

David Howells (1):
      cifs: Fix collect_sample() to handle any iterator type

David Lechner (1):
      iio: adc: ad_sigma_delta: don't overallocate scan buffer

David Thompson (3):
      gpio: mlxbf2: use platform_get_irq_optional()
      Revert "gpio: mlxbf3: only get IRQ for device instance 0"
      gpio: mlxbf3: use platform_get_irq_optional()

David Wei (1):
      bnxt: fill data page pool with frags if PAGE_SIZE > BNXT_RX_PAGE_SIZE

Davide Caratti (1):
      net/sched: ets: use old 'nbands' while purging unused classes

Dikshita Agarwal (1):
      media: iris: Add handling for corrupt and drop frames

Dongcheng Yan (1):
      media: i2c: set lt6911uxe's reset_gpio to GPIOD_OUT_LOW

Eduard Zingerman (1):
      libbpf: Verify that arena map exists when adding arena relocations

Edward Adam Davis (1):
      jfs: Regular file corruption check

Elad Nachman (1):
      irqchip/mvebu-gicp: Clear pending interrupts on init

Eliav Farber (1):
      pps: clients: gpio: fix interrupt handling order in remove path

Emily Deng (1):
      drm/ttm: Should to return the evict error

En-Wei Wu (1):
      Bluetooth: btusb: Add new VID/PID 0489/e14e for MT7925

Eric Biggers (4):
      fscrypt: Don't use problematic non-inline crypto engines
      lib/crypto: x86/poly1305: Fix register corruption in no-SIMD contexts
      lib/crypto: x86/poly1305: Fix performance regression on short messages
      thunderbolt: Fix copy+paste error in match_service_id()

Eric Work (1):
      net: atlantic: add set_power to fw_ops for atl2 to fix wol

Fabio Porcedda (1):
      net: usb: qmi_wwan: add Telit Cinterion FN990A w/audio composition

Fedor Pchelkin (1):
      netlink: avoid infinite retry looping in netlink_unicast()

Felix Fietkau (1):
      wifi: mt76: fix vif link allocation

Filipe Manana (11):
      btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents
      btrfs: abort transaction during log replay if walk_log_tree() failed
      btrfs: qgroup: set quota enabled bit if quota disable fails flushing reservations
      btrfs: don't ignore inode missing when replaying log tree
      btrfs: qgroup: fix race between quota disable and quota rescan ioctl
      btrfs: qgroup: fix qgroup create ioctl returning success after quotas disabled
      btrfs: don't skip remaining extrefs if dir not found during log replay
      btrfs: clear dirty status from extent buffer on error at insert_new_root()
      btrfs: send: use fallocate for hole punching with send stream v2
      btrfs: fix log tree replay failure due to file with 0 links and extents
      btrfs: error on missing block group when unaccounting log tree extent buffers

Florian Larysch (1):
      net: phy: micrel: fix KSZ8081/KSZ8091 cable test

Florian Westphal (3):
      netfilter: ctnetlink: fix refcount leak on table dump
      netfilter: ctnetlink: remove refcounting in expectation dumpers
      netfilter: nft_set_pipapo: prefer kvmalloc for scratch maps

Florin Leotescu (1):
      hwmon: (emc2305) Set initial PWM minimum value during probe based on thermal state

Francisco Gutierrez (1):
      scsi: pm80xx: Free allocated tags after failure

Frederic Weisbecker (2):
      ipvs: Fix estimator kthreads preferred affinity
      rcu: Fix racy re-initialization of irq_work causing hangs

Fushuai Wang (1):
      x86/fpu: Fix NULL dereference in avx512_status()

Gabriel Totev (1):
      apparmor: shift ouid when mediating hard links in userns

Gal Pressman (2):
      net: vlan: Make is_vlan_dev() a stub when VLAN is not configured
      net: vlan: Replace BUG() with WARN_ON_ONCE() in vlan_dev_* stubs

GalaxySnail (1):
      ALSA: hda: add MODULE_FIRMWARE for cs35l41/cs35l56

Gao Xiang (1):
      erofs: fix block count report when 48-bit layout is on

Gautham R. Shenoy (1):
      pm: cpupower: Fix the snapshot-order of tsc,mperf, clock in mperf_stop()

George Gaidarov (1):
      EDAC/ie31200: Enable support for Core i5-14600 and i7-14700

George Moussalem (1):
      clk: qcom: ipq5018: keep XO clock always on

Geraldo Nascimento (1):
      phy: rockchip-pcie: Properly disable TEST_WRITE strobe signal

Gerd Hoffmann (1):
      x86/sev/vc: Fix EFI runtime instruction emulation

Greg Kroah-Hartman (1):
      Linux 6.16.2

Guillaume La Roque (1):
      pmdomain: ti: Select PM_GENERIC_DOMAINS

Gwendal Grignou (1):
      platform/chrome: cros_ec_sensorhub: Retries when a sensor is not ready

Haibo Chen (1):
      mmc: sdhci-esdhc-imx: Don't change pinctrl in suspend if wakeup source

Haiyang Zhang (1):
      hv_netvsc: Fix panic during namespace deletion with VF

Hans de Goede (3):
      mei: bus: Check for still connected devices in mei_cl_bus_dev_release()
      media: hi556: Fix reset GPIO timings
      i2c: core: Fix double-free of fwnode in i2c_unregister_device()

Haoran Jiang (1):
      LoongArch: BPF: Fix jump offset calculation in tailcall

Harald Mommer (1):
      gpio: virtio: Fix config space reading.

Hari Chandrakanthan (2):
      wifi: mac80211: fix rx link assignment for non-MLO stations
      wifi: ath12k: Fix station association with MBSSID Non-TX BSS

Hari Kalavakunta (1):
      net: ncsi: Fix buffer overflow in fetching version id

Heiko Carstens (1):
      s390/early: Copy last breaking event address to pt_regs

Heiner Kallweit (2):
      net: ftgmac100: fix potential NULL pointer access in ftgmac100_phy_disconnect
      dpaa_eth: don't use fixed_phy_change_carrier

Hiago De Franco (1):
      remoteproc: imx_rproc: skip clock enable when M-core is managed by the SCU

Hsin-Te Yuan (1):
      thermal: sysfs: Return ENODATA instead of EAGAIN for reads

Huacai Chen (2):
      PCI: Extend isolated function probing to LoongArch
      LoongArch: Make relocate_new_kernel_size be a .quad value

Ian Abbott (1):
      comedi: fix race between polling and detaching

Ihor Solodrai (1):
      bpf: Make reg_not_null() true for CONST_PTR_TO_MAP

Ilan Peer (1):
      wifi: cfg80211: Fix interface type validation

Ilya Bakoulin (1):
      drm/amd/display: Separate set_gsl from set_gsl_source_select

Ivan Lipski (1):
      drm/amd/display: Allow DCN301 to clear update flags

Jack Ping CHNG (1):
      net: pcs: xpcs: mask readl() return value to 16 bits

Jack Xiao (1):
      drm/amdgpu: fix incorrect vm flags to map bo

Jaegeuk Kim (1):
      f2fs: check the generic conditions first

Jakub Kicinski (4):
      net: page_pool: allow enabling recycling late, fix false positive warning
      tls: handle data disappearing from under the TLS ULP
      eth: bnxt: take page size into account for page pool recycling rings
      uapi: in6: restore visibility of most IPv6 socket options

Jameson Thies (1):
      usb: typec: ucsi: Add poll_cci operation to cros_ec_ucsi

Jan Kara (2):
      loop: Avoid updating block size under exclusive owner
      udf: Verify partition map count

Jarkko Sakkinen (1):
      tpm: Check for completion after timeout

Jason Gunthorpe (1):
      iommufd: Prevent ALIGN() overflow

Jason Wang (1):
      vhost: fail early when __vhost_add_used() fails

Jay Chen (1):
      usb: xhci: Set avg_trb_len = 8 for EP0 during Address Device Command

Jeff Layton (1):
      nfsd: handle get_client_locked() failure in nfsd4_setclientid_confirm()

Jens Axboe (3):
      io_uring/memmap: cast nr_pages to size_t before shifting
      io_uring/net: commit partial buffers on retry
      io_uring/rw: cast rw->flags assignment to rwf_t

Jeongjun Park (1):
      ptp: prevent possible ABBA deadlock in ptp_clock_freerun()

Jiasheng Jiang (1):
      scsi: lpfc: Remove redundant assignment to avoid memory leak

Jiayi Li (1):
      ACPI: processor: perflib: Fix initial _PPC limit application

Jijie Shao (3):
      net: hibmcge: fix rtnl deadlock issue
      net: hibmcge: fix the division by zero issue
      net: hibmcge: fix the np_link_fail error reporting issue

Jinjiang Tu (1):
      mm/smaps: fix race between smaps_hugetlb_range and migration

Joel Fernandes (1):
      rcu: Fix rcu_read_unlock() deadloop due to IRQ work

Johan Adolfsson (1):
      leds: leds-lp50xx: Handle reg to get correct multi_index

Johan Hovold (5):
      net: gianfar: fix device leak when querying time stamp info
      net: enetc: fix device and OF node leak at probe
      net: mtk_eth_soc: fix device leak at probe
      net: ti: icss-iep: fix device and OF node leaks at probe
      net: dpaa: fix device leak when querying time stamp info

Johannes Berg (6):
      wifi: cfg80211: reject HTC bit for management frames
      wifi: mac80211: don't use TPE data from assoc response
      wifi: mac80211: don't unreserve never reserved chanctx
      wifi: mac80211: don't complete management TX on SAE commit
      wifi: iwlwifi: mld: fix last_mlo_scan_time type
      wifi: iwlwifi: pcie: reinit device properly during TOP reset

Johannes Thumshirn (2):
      btrfs: zoned: use filesystem size not disk size for reclaim decision
      btrfs: zoned: reserve data_reloc block group on mount

John Ernberg (1):
      crypto: caam - Support iMX8QXP and variants thereof

John Garry (4):
      dm-stripe: limit chunk_sectors to the stripe size
      md/raid10: set chunk_sectors limit
      scsi: aacraid: Stop using PCI_IRQ_AFFINITY
      block: avoid possible overflow for chunk_sectors check in blk_stack_limits()

John Johansen (1):
      apparmor: fix x_table_lookup when stacking is not the first entry

John Ogness (1):
      printk: nbcon: Allow reacquire during panic

Jonas Rebmann (1):
      net: fec: allow disable coalescing

Jonathan Santos (1):
      iio: adc: ad7768-1: Ensure SYNC_IN pulse minimum timing requirement

Jorge Marques (1):
      i3c: master: Initialize ret in i3c_i2c_notifier_call()

Joseph Tilahun (1):
      tty: serial: fix print format specifiers

Jouni Högander (1):
      drm/i915/psr: Do not trigger Frame Change events from frontbuffer flush

Juri Lelli (1):
      sched/deadline: Fix accounting after global limits change

Justin Tee (2):
      scsi: lpfc: Ensure HBA_SETUP flag is used only for SLI4 in dev_loss_tmo_callbk
      scsi: lpfc: Check for hdwq null ptr when cleaning up lpfc_vport structure

Kairui Song (1):
      mm/shmem, swap: improve cached mTHP handling and fix potential hang

Kalesh AP (1):
      RDMA/bnxt_re: Fix size of uverbs_copy_to() in BNXT_RE_METHOD_GET_TOGGLE_MEM

Kamil Horák - 2N (1):
      net: phy: bcm54811: PHY initialization

Kang Yang (1):
      wifi: ath10k: shutdown driver when hardware is unreliable

Karthik Poosa (1):
      drm/xe/hwmon: Add SW clamp for power limits writes

Karthikeyan Kathirvel (1):
      wifi: ath12k: Decrement TID on RX peer frag setup error handling

Kees Cook (2):
      arm64: Handle KCOV __init vs inline mismatches
      platform/x86: thinkpad_acpi: Handle KCOV __init vs inline mismatches

Keith Busch (2):
      nvme-pci: try function level reset on init failure
      vfio/type1: conditional rescheduling while pinning

Krzysztof Hałasa (1):
      imx8m-blk-ctrl: set ISI panic write hurry level

Krzysztof Kozlowski (2):
      leds: flash: leds-qcom-flash: Fix registry access after re-bind
      clk: qcom: dispcc-sm8750: Fix setting rate byte and pixel clocks

Kuan-Chung Chen (1):
      wifi: rtw89: 8852c: increase beacon loss to 6 seconds

Kuninori Morimoto (1):
      ASoC: soc-dapm: set bias_level if snd_soc_dapm_set_bias_level() was successed

Kuniyuki Iwashima (1):
      ipv6: mcast: Check inet6_dev->dead under idev->mc_lock in __ipv6_dev_mc_inc().

Lad Prabhakar (1):
      drm: renesas: rz-du: mipi_dsi: Add min check for VCLK range

Len Brown (2):
      intel_idle: Allow loading ACPI tables for any family
      tools/power turbostat: Handle non-root legacy-uncore sysfs permissions

Leon Romanovsky (1):
      net/mlx5e: Properly access RCU protected qdisc_sleeping variable

Li Chen (3):
      ACPI: Suppress misleading SPCR console message when SPCR table is absent
      HID: rate-limit hid_warn to prevent log flooding
      ACPI: Return -ENODEV from acpi_parse_spcr() when SPCR support is disabled

Li RongQing (1):
      cpufreq: intel_pstate: Add Granite Rapids support in no-HWP mode

Li Zhijian (1):
      mm/memory-tier: fix abstract distance calculation overflow

Lifeng Zheng (2):
      cpufreq: Exit governor when failed to start old governor
      PM / devfreq: governor: Replace sscanf() with kstrtoul() in set_freq_store()

Lijo Lazar (3):
      drm/amdgpu: Add more checks to PSP mailbox
      drm/amd/pm: Use pointer type for typecheck()
      drm/amdgpu: Suspend IH during mode-2 reset

Lizhi Xu (3):
      fs/ntfs3: Add sanity check for file name
      jfs: truncate good inode pages when hard link is 0
      ocfs2: reset folio to NULL when get folio fails

Lorenzo Bianconi (1):
      wifi: mt76: mt7996: Fix mlink lookup in mt7996_tx_prepare_skb

Lu Baolu (1):
      iommu/vt-d: Optimize iotlb_sync_map for non-caching/non-RWBF modes

Lucien.Jheng (1):
      net: phy: air_en8811h: Introduce resume/suspend and clk_restore_context to ensure correct CKO settings after network interface reinitialization.

Lucy Thrun (1):
      ALSA: hda/ca0132: Fix buffer overflow in add_tuning_control

Lukas Wunner (1):
      PCI/ACPI: Fix runtime PM ref imbalance on Hot-Plug Capable ports

MD Danish Anwar (1):
      net: ti: icssg-prueth: Fix emac link speed handling

Ma Ke (1):
      sunvdc: Balance device refcount in vdc_port_mpgroup_check

Marek Szyprowski (1):
      media: v4l2: Add support for NV12M tiled variants to v4l2_format_info()

Mario Limonciello (8):
      platform/x86/amd: pmc: Add Lenovo Yoga 6 13ALC6 to pmc quirk list
      usb: xhci: Avoid showing warnings for dying controller
      usb: xhci: Avoid showing errors during surprise removal
      drm/amd: Allow printing VanGogh OD SCLK levels without setting dpm to manual
      drm/amd/display: Stop storing failures into adev->dm.cached_state
      drm/amd/display: Only finalize atomic_obj if it was initialized
      drm/amd/display: Avoid configuring PSR granularity if PSR-SU not supported
      crypto: ccp - Add missing bootloader info reg for pspv6

Mark Brown (3):
      ASoC: hdac_hdmi: Rate limit logging on connection and disconnection
      kselftest/arm64: Specify SVE data when testing VL set in sve-ptrace
      regmap: irq: Free the regmap-irq mutex

Mark Rutland (1):
      arm64: stacktrace: Check kretprobe_find_ret_addr() return value

Markus Stockhausen (1):
      irqchip/mips-gic: Allow forced affinity

Markus Theil (1):
      crypto: jitter - fix intermediary handling

Masahiro Yamada (3):
      kconfig: gconf: avoid hardcoding model2 in on_treeview2_cursor_changed()
      kconfig: gconf: fix potential memory leak in renderer_edited()
      kheaders: rebuild kheaders_data.tar.xz when a file is modified within a minute

Masami Hiramatsu (Google) (2):
      selftests: tracing: Use mutex_unlock for testing glob filter
      tracing: fprobe: Fix infinite recursion using preempt_*_notrace()

Mateusz Guzik (1):
      apparmor: use the condition in AA_BUG_FMT even with debug disabled

Matt Johnston (1):
      net: mctp: Prevent duplicate binds

Matt Roper (1):
      drm/xe/xe_query: Use separate iterator while filling GT list

Matteo Croce (1):
      libbpf: Fix warning in calloc() usage

Matthew Auld (3):
      drm/xe/migrate: prevent infinite recursion
      drm/xe/migrate: don't overflow max copy size
      drm/xe/migrate: prevent potential UAF

Maulik Shah (1):
      soc: qcom: rpmh-rsc: Add RSC version 4 support

Maurizio Lombardi (2):
      nvme-tcp: log TLS handshake failures at error level
      scsi: target: core: Generate correct identifiers for PR OUT transport IDs

Mauro Carvalho Chehab (1):
      sphinx: kernel_abi: fix performance regression with O=<dir>

Maxim Levitsky (3):
      KVM: nVMX: Check vmcs12->guest_ia32_debugctl on nested VM-Enter
      KVM: VMX: Wrap all accesses to IA32_DEBUGCTL with getter/setter APIs
      KVM: VMX: Preserve host's DEBUGCTLMSR_FREEZE_IN_SMM while running the guest

Meagan Lloyd (2):
      rtc: ds1307: handle oscillator stop flag (OSF) for ds1341
      rtc: ds1307: remove clear of oscillator stop flag (OSF) in probe

Michal Wilczynski (1):
      clk: thead: Mark essential bus clocks as CLK_IGNORE_UNUSED

Miguel Ojeda (2):
      rust: kbuild: clean output before running `rustdoc`
      rust: workaround `rustdoc` target modifiers bug

Mikulas Patocka (1):
      dm-mpath: don't print the "loaded" message if registering fails

Mina Almasry (1):
      netmem: fix skb_frag_address_safe with unreadable skbs

Miri Korenblit (6):
      wifi: iwlwifi: mld: use spec link id and not FW link id
      wifi: mac80211: handle WLAN_HT_ACTION_NOTIFY_CHANWIDTH async
      wifi: iwlwifi: mvm: set gtk id also in older FWs
      wifi: iwlwifi: handle non-overlapping API ranges
      wifi: mac80211: avoid weird state in error path
      wifi: iwlwifi: mld: don't exit EMLSR when we shouldn't

Moon Hee Lee (1):
      selftests/kexec: fix test_kexec_jump build

Myrrh Periwinkle (1):
      usb: typec: ucsi: Update power_supply on power role change

Nam Cao (2):
      verification/dot2k: Make a separate dot2k_templates/Kconfig_container
      rv: Add #undef TRACE_INCLUDE_FILE

Naohiro Aota (3):
      btrfs: zoned: requeue to unused block group list if zone finish failed
      btrfs: zoned: do not remove unwritten non-data block group
      btrfs: zoned: do not select metadata BG as finish target

Nathan Lynch (1):
      lib: packing: Include necessary headers

NeilBrown (1):
      smb/server: avoid deadlock when linking with ReplaceIfExists

Nicholas Kazlauskas (1):
      drm/amd/display: Update DMCUB loading sequence for DCN3.5

Nicolin Chen (2):
      iommu/arm-smmu-v3: Revert vmaster in the error path
      iommufd: Report unmapped bytes in the error path of iopt_unmap_iova_range

Niklas Söderlund (1):
      media: v4l2-common: Reduce warnings about missing V4L2_CID_LINK_FREQ control

Nikunj A Dadhania (1):
      x86/sev: Improve handling of writes to intercepted TSC MSRs

Nitin Rawat (1):
      scsi: ufs: core: Fix interrupt handling for MCQ Mode

Oliver Neukum (3):
      usb: core: usb_submit_urb: downgrade type check
      net: usb: cdc-ncm: check for filtering capability
      cdc-acm: fix race between initial clearing halt and open

Oscar Maes (1):
      net: ipv4: fix incorrect MTU in broadcast routes

Pablo Neira Ayuso (1):
      netfilter: nf_tables: reject duplicate device on updates

Pagadala Yesu Anjaneyulu (1):
      wifi: iwlwifi: fw: Fix possible memory leak in iwl_fw_dbg_collect

Pali Rohár (1):
      cifs: Fix calling CIFSFindFirst() for root path without msearch

Paul Chaignon (1):
      bpf: Forget ranges when refining tnum after JSET

Paul E. McKenney (1):
      rcu: Protect ->defer_qs_iw_pending from data race

Paulo Alcantara (1):
      smb: client: fix session setup against servers that require SPN

Pavel Begunkov (5):
      io_uring: don't use int for ABI
      io_uring: export io_[un]account_mem
      io_uring/zcrx: account area memory
      io_uring/zcrx: fix null ifq on area destruction
      io_uring/zcrx: don't leak pages on account failure

Pawan Gupta (1):
      x86/bugs: Avoid warning when overriding return thunk

Pedro Falcato (1):
      RDMA/siw: Fix the sendmsg byte count in siw_tcp_sendpages

Pei Xiao (1):
      clk: tegra: periph: Fix error handling and resolve unsigned compare warning

Peichen Huang (1):
      drm/amd/display: add null check

Peng Fan (1):
      firmware: arm_scmi: power_control: Ensure SCMI_SYSPOWER_IDLE is set early during resume

Peter Jakubek (1):
      ASoC: Intel: sof_sdw: Add quirk for Alienware Area 51 (2025) 0CCC SKU

Peter Robinson (1):
      reset: brcmstb: Enable reset drivers for ARCH_BCM2835

Peter Ujfalusi (2):
      ASoC: SOF: topology: Parse the dapm_widget_tokens in case of DSPless mode
      ASoC: core: Check for rtd == NULL in snd_soc_remove_pcm_runtime()

Petr Pavlu (1):
      module: Prevent silent truncation of module name in delete_module(2)

Philipp Stanner (2):
      drm/sched/tests: Add unit test for cancel_job()
      drm/sched: Avoid memory leaks with cancel_job() callback

Prashant Malani (1):
      cpufreq: CPPC: Mark driver with NEED_UPDATE_LIMITS flag

Purva Yeshi (1):
      md: dm-zoned-target: Initialize return variable r to avoid uninitialized use

Qu Wenruo (3):
      btrfs: populate otime when logging an inode item
      btrfs: fix wrong length parameter for btrfs_cleanup_ordered_extents()
      btrfs: do not allow relocation of partially dropped subvolumes

Radhey Shyam Pandey (1):
      usb: dwc3: xilinx: add shutdown callback

Rafael J. Wysocki (3):
      ACPI: processor: perflib: Move problematic pr->performance check
      cpuidle: governors: menu: Avoid using invalid recent intervals data
      PM: runtime: Clear power.needs_force_resume in pm_runtime_reinit()

Raj Kumar Bhagat (1):
      wifi: ath12k: Enable REO queue lookup table feature on QCN9274 hw2.0

Rameshkumar Sundaram (1):
      wifi: ath12k: Fix beacon reception for sta associated to Non-TX AP

Ramya Gnanasekar (1):
      wifi: mac80211: update radar_required in channel context after channel switch

Rand Deeb (1):
      wifi: iwlwifi: dvm: fix potential overflow in rs_fill_link_cmd()

Randy Dunlap (2):
      fbdev: nvidiafb: add depends on HAS_IOPORT
      parisc: Makefile: fix a typo in palo.conf

Ranjan Kumar (1):
      scsi: Fix sas_user_scan() to handle wildcard and multi-channel scans

Ricardo Ribalda (4):
      media: uvcvideo: Add quirk for HP Webcam HD 2300
      media: uvcvideo: Set V4L2_CTRL_FLAG_DISABLED during queryctrl errors
      media: uvcvideo: Do not mark valid metadata as invalid
      media: uvcvideo: Turn on the camera if V4L2_EVENT_SUB_FL_SEND_INITIAL

Ricky Wu (1):
      misc: rtsx: usb: Ensure mmc child device is active when card is present

Rob Clark (2):
      drm/msm: Update register xml
      drm/msm: use trylock for debugfs

Robin Murphy (1):
      perf/arm: Add missing .suppress_bind_attrs

Roman Li (1):
      drm/amd/display: Disable dsc_power_gate for dcn314 by default

Rong Zhang (1):
      fs/ntfs3: correctly create symlink for relative path

RubenKelevra (1):
      net: ieee8021q: fix insufficient table-size assertion

Sabrina Dubroca (4):
      xfrm: flush all states in xfrm_state_fini
      xfrm: restore GSO for SW crypto
      xfrm: bring back device check in validate_xmit_xfrm
      udp: also consider secpath when evaluating ipsec use for checksumming

Sarah Newman (1):
      drbd: add missing kref_get in handle_write_conflicts

Sarika Sharma (2):
      wifi: ath12k: Correct tid cleanup when tid setup fails
      wifi: ath12k: Add memset and update default rate value in wmi tx completion

Sarthak Garg (1):
      mmc: sdhci-msm: Ensure SD card power isn't ON when card removed

Sasha Levin (1):
      fs: Prevent file descriptor table allocations exceeding INT_MAX

Sean Christopherson (1):
      KVM: VMX: Extract checking of guest's DEBUGCTL into helper

Sebastian Andrzej Siewior (1):
      selftests: netfilter: Enable CONFIG_INET_SCTP_DIAG

Sebastian Ott (1):
      ACPI: processor: fix acpi_object initialization

Sebastian Reichel (2):
      watchdog: dw_wdt: Fix default timeout
      usb: typec: fusb302: cache PD RX state

SeongJae Park (2):
      samples/damon/wsse: fix boot time enable handling
      samples/damon/mtier: support boot time enable setup

Sergey Bashirov (4):
      pNFS: Fix stripe mapping in block/scsi layout
      pNFS: Fix disk addr range check in block/scsi layout
      pNFS: Handle RPC size limit for layoutcommits
      pNFS: Fix uninited ptr deref in block/scsi layout

Shankari Anand (1):
      kconfig: nconf: Ensure null termination where strncpy is used

Shannon Nelson (1):
      ionic: clean dbpage in de-init

Shengjiu Wang (1):
      ASoC: fsl_sai: replace regmap_write with regmap_update_bits

Shiji Yang (2):
      MIPS: vpe-mt: add missing prototypes for vpe_{alloc,start,stop,free}
      MIPS: lantiq: falcon: sysctrl: fix request memory check logic

Shin'ichiro Kawasaki (1):
      dm: split write BIOs on zone boundaries when zone append is not emulated

Showrya M N (1):
      scsi: libiscsi: Initialize iscsi_conn->dd_data only if memory is allocated

Shuai Xue (1):
      ACPI: APEI: send SIGBUS to current task if synchronous memory error not recovered

Shubhrajyoti Datta (1):
      EDAC/synopsys: Clear the ECC counters on init

Shyam Prasad N (1):
      cifs: reset iface weights when we cannot find a candidate

Siddharth Vadapalli (1):
      arm64: dts: ti: k3-j722s-evm: Fix USB gpio-hog level for Type-C

Sravan Kumar Gundu (1):
      fbdev: Fix vmalloc out-of-bounds write in fast_imageblit

Srinivas Kandagatla (1):
      ASoC: qcom: use drvdata instead of component to keep id

Stanislav Fomichev (2):
      net: lapbether: ignore ops-locked netdevs
      hamradio: ignore ops-locked netdevs

Stanislaw Gruszka (1):
      wifi: iwlegacy: Check rate_idx range after addition

Stefan Metzmacher (3):
      smb: client: let send_done() cleanup before calling smbd_disconnect_rdma_connection()
      smb: client: don't wait for info->send_pending == 0 on error
      smb: client: don't call init_waitqueue_head(&info->conn_wait) twice in _smbd_get_connection

Steve French (1):
      smb3: fix for slab out of bounds on mount to ksmbd

Steven Rostedt (3):
      tracefs: Add d_delete to remove negative dentries
      powerpc/thp: tracing: Hide hugepage events under CONFIG_PPC_BOOK3S_64
      ktest.pl: Prevent recursion of default variable options

Su Hui (1):
      usb: xhci: print xhci->xhc_state when queue_command failed

Suchit Karunakaran (1):
      kconfig: lxdialog: replace strcpy() with strncpy() in inputbox.c

Suren Baghdasaryan (1):
      userfaultfd: fix a crash in UFFDIO_MOVE when PMD is a migration entry

Sven Schnelle (3):
      s390/sclp: Use monotonic clock in sclp_sync_wait()
      s390/time: Use monotonic clock in get_cycles()
      s390/stp: Remove udelay from stp_sync_clock()

Sven Stegemann (1):
      net: kcm: Fix race condition in kcm_unattach()

Takashi Iwai (4):
      ALSA: usb-audio: Validate UAC3 power domain descriptors, too
      ALSA: usb-audio: Validate UAC3 cluster segment descriptors
      ALSA: hda: Handle the jack polling always via a work
      ALSA: hda: Disable jack polling at shutdown

Tetsuo Handa (1):
      hfsplus: don't use BUG_ON() in hfsplus_create_attributes_file()

Theodore Ts'o (1):
      ext4: do not BUG when INLINE_DATA_FL lacks system.data xattr

Thierry Reding (2):
      firmware: tegra: Fix IVC dependency problems
      drm/fbdev-client: Skip DRM clients if modesetting is absent

Thomas Croft (1):
      ALSA: hda/realtek: add LG gram 16Z90R-A to alc269 fixup table

Thomas Fourier (6):
      et131x: Add missing check after DMA map
      net: ag71xx: Add missing check after DMA map
      (powerpc/512) Fix possible `dma_unmap_single()` on uninitialized pointer
      wifi: rtlwifi: fix possible skb memory leak in `_rtl_pci_rx_interrupt()`.
      powerpc: floppy: Add missing checks after DMA map
      wifi: rtlwifi: fix possible skb memory leak in _rtl_pci_init_one_rxdesc()

Thomas Gleixner (1):
      irqchip/mvebu-gicp: Use resource_size() for ioremap()

Thomas Weißschuh (7):
      LoongArch: Don't use %pK through printk() in unwinder
      mfd: cros_ec: Separate charge-control probing from USB-PD
      tools/nolibc: define time_t in terms of __kernel_old_time_t
      tools/build: Fix s390(x) cross-compilation with clang
      selftests: vDSO: vdso_test_getrandom: Always print TAP header
      um: Re-evaluate thread flags repeatedly
      MIPS: Don't crash in stack_top() for tasks without ABI or vDSO

Tiffany Yang (1):
      binder: Fix selftest page indexing

Tom Lendacky (1):
      x86/sev: Ensure SVSM reserved fields in a page validation entry are initialized to zero

Tomasz Michalec (2):
      usb: typec: intel_pmc_mux: Defer probe if SCU IPC isn't present
      platform/chrome: cros_ec_typec: Defer probe on missing EC parent

Tomi Valkeinen (1):
      media: raspberrypi: cfe: Fix min_reqbufs_allocation

Trond Myklebust (1):
      NFS: Fix the setting of capabilities when automounting a new filesystem

Tvrtko Ursulin (2):
      drm/xe: Make dma-fences compliant with the safe access rules
      drm/ttm: Respect the shrinker core free target

Ulf Hansson (1):
      mmc: rtsx_usb_sdmmc: Fix error-path in sd_set_power_mode()

Umio Yasuno (1):
      drm/amd/pm: fix null pointer access

Uwe Kleine-König (1):
      Bluetooth: btusb: Add support for variant of RTL8851BE (USB ID 13d3:3601)

Valmantas Paliksa (1):
      phy: rockchip-pcie: Enable all four lanes if required

Vasiliy Kovalev (1):
      ALSA: hda/realtek: Fix headset mic on HONOR BRB-X

Vedang Nagar (1):
      media: venus: Fix OOB read due to missing payload bound check

Viacheslav Dubeyko (5):
      hfs: fix general protection fault in hfs_find_init()
      hfs: fix slab-out-of-bounds in hfs_bnode_read()
      hfsplus: fix slab-out-of-bounds in hfsplus_bnode_read()
      hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()
      hfs: fix not erasing deleted b-tree node issue

Vijendar Mukunda (2):
      soundwire: amd: serialize amd manager resume sequence during pm_prepare
      soundwire: amd: cancel pending slave status handling workqueue during remove sequence

Vincent Mailhol (1):
      can: ti_hecc: fix -Woverflow compiler warning

Vinod Govindapillai (1):
      drm/i915/fbc: fix the implementation of wa_18038517565

Vivek Pernamitta (1):
      bus: mhi: host: pci_generic: Disable runtime PM for QDU100

Vlastimil Babka (1):
      mm, slab: restore NUMA policy support for large kmalloc

Waiman Long (2):
      futex: Use user_write_access_begin/_end() in futex_put_value()
      mm/kmemleak: avoid soft lockup in __kmemleak_do_cleanup()

Wang Zhaolong (1):
      smb: client: remove redundant lstrp update in negotiate protocol

Wayne Lin (1):
      drm/amd/display: Avoid trying AUX transactions on disconnected ports

Wei Fang (1):
      net: enetc: separate 64-bit counters from enetc_port_counters

Wei Gao (1):
      ext2: Handle fiemap on empty files to prevent EINVAL

Wen Chen (1):
      drm/amd/display: Fix 'failed to blank crtc!'

Wentao Guan (1):
      LoongArch: vDSO: Remove -nostdlib complier flag

Wilfred Mallawa (1):
      PCI: dw-rockchip: Delay link training after hot reset in EP mode

Will Deacon (1):
      vsock/virtio: Resize receive buffers so that each SKB fits in a 4K page

Willy Tarreau (1):
      tools/nolibc: fix spelling of FD_SETBITMASK in FD_* macros

Wolfram Sang (3):
      media: usb: hdpvr: disable zero-length read messages
      i3c: add missing include to internal header
      i3c: don't fail if GETHDRCAP is unsupported

Xiang Liu (1):
      drm/amdgpu: Use correct severity for BP threshold exceed event

Xin Long (1):
      sctp: linearize cloned gso packets in sctp_rcv

Xinxin Wan (1):
      ASoC: codecs: rt5640: Retry DEVICE_ID verification

Xinyu Liu (1):
      usb: core: config: Prevent OOB read in SS endpoint companion parsing

Xu Yang (1):
      net: usb: asix_devices: add phy_mask for ax88772 mdio bus

Yang Li (1):
      Bluetooth: hci_event: Add support for handling LE BIG Sync Lost event

Yann E. MORIN (1):
      kconfig: lxdialog: fix 'space' to (de)select options

Yao Zi (3):
      LoongArch: Avoid in-place string operation on FDT content
      net: stmmac: thead: Get and enable APB clock on initialization
      riscv: dts: thead: Add APB clocks for TH1520 GMACs

Yeoreum Yun (2):
      tpm: tpm_crb_ffa: try to probe tpm_crb_ffa when it's built-in
      firmware: arm_ffa: Change initcall level of ffa_init() to rootfs_initcall

YiPeng Chai (1):
      drm/amdgpu: fix vram reservation issue

Yonghong Song (2):
      selftests/bpf: Fix ringbuf/ringbuf_write test failure with arm64 64KB page size
      selftests/bpf: Fix a user_ringbuf failure with arm64 64KB page size

Yongzhen Zhang (1):
      fbdev: fix potential buffer overflow in do_register_framebuffer()

Youngjun Lee (1):
      media: uvcvideo: Fix 1-byte out-of-bounds read in uvc_parse_format()

Yu Kuai (1):
      lib/sbitmap: convert shallow_depth from one word to the whole sbitmap

Yuan Chen (2):
      drm/msm: Add error handling for krealloc in metadata setup
      bpftool: Fix JSON writer resource leak in version command

Yuezhang Mo (1):
      exfat: add cluster chain loop check for dir

Yury Norov [NVIDIA] (1):
      RDMA: hfi1: fix possible divide-by-zero in find_hw_thread_mask()

Zhang Yi (2):
      ext4: limit the maximum folio order
      ext4: initialize superblock fields in the kballoc-test.c kunit tests

Zheng Qixing (1):
      block: fix kobject double initialization in add_disk

Zhiqi Song (1):
      crypto: hisilicon/hpre - fix dma unmap sequence

Zhu Qiyu (1):
      ACPI: PRM: Reduce unnecessary printing to avoid user confusion

Zijun Hu (2):
      char: misc: Fix improper and inaccurate error code returned by misc_init()
      Bluetooth: hci_sock: Reset cookie to zero in hci_sock_free_cookie()

Ziyan Fu (1):
      watchdog: iTCO_wdt: Report error if timeout configuration fails

Zqiang (2):
      rcu/nocb: Fix possible invalid rdp's->nocb_cb_kthread pointer access
      rcutorture: Fix rcutorture_one_extend_check() splat in RT kernels

chenchangcheng (1):
      media: uvcvideo: Fix bandwidth issue for Alcor camera

fangzhong.zhou (1):
      i2c: Force DLL0945 touchpad i2c freq to 100khz

ganglxie (1):
      drm/amdgpu: clear pa and mca record counter when resetting eeprom

jackysliu (1):
      scsi: bfa: Double-free fix

tuhaowen (1):
      PM: sleep: console: Fix the black screen issue

zhangjianrong (2):
      net: thunderbolt: Enable end-to-end flow control also in transmit
      net: thunderbolt: Fix the parameter passing of tb_xdomain_enable_paths()/tb_xdomain_disable_paths()

Álvaro Fernández Rojas (6):
      net: dsa: b53: ensure BCM5325 PHYs are enabled
      net: dsa: b53: fix b53_imp_vlan_setup for BCM5325
      net: dsa: b53: prevent GMII_PORT_OVERRIDE_CTRL access on BCM5325
      net: dsa: b53: prevent DIS_LEARNING access on BCM5325
      net: dsa: b53: prevent SWITCH_CTRL access on BCM5325
      net: dsa: b53: fix IP_MULTICAST_CTRL on BCM5325


