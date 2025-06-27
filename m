Return-Path: <stable+bounces-158773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD87AEB45B
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 12:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC13F7A52CC
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 10:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ED42D1309;
	Fri, 27 Jun 2025 10:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jABp50cj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8B22D12EB;
	Fri, 27 Jun 2025 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019524; cv=none; b=TSL8ViCK7nhsPrm2JVGmx1OlfRgHNTEi3kahsaLWa4If/OdLw5EPcyTM7iiqyzhrcp0877dwIn7y5fLUvbtwCEH6l0FBCH4JvZhmtp45Z9eMv/ncBNPu/gtQRfPdSFvHLWqNTkFN+0EIxFd142XzGYpK3UUjIqOHuTOAohxbBp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019524; c=relaxed/simple;
	bh=NyLGEjszLMU0uvkAVkOw6cR6x95Lf5uOGMeUSmgnufg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y9zaIdnXnwLV5Q0liJStI2o8qdJE8ySUIk3L7Lw6+RaD2f/wd2zQmCjSU4UNRiiTcSlKC3bFhP4iqieR5G2ZmODxzfYCdLeU+f2/ezRN/9hOmMHDbmUT+tbaVBKSCpwwaAVDkiwKjj/1z8J4TimpSzrXQ/QZWgZTfD/OJkX/ppI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jABp50cj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06295C4CEE3;
	Fri, 27 Jun 2025 10:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751019522;
	bh=NyLGEjszLMU0uvkAVkOw6cR6x95Lf5uOGMeUSmgnufg=;
	h=From:To:Cc:Subject:Date:From;
	b=jABp50cjk+xTcJKf2p7dpkiAHZzp45qqp3SWqFodLc3cyp5RZPY9nFHk7Emh0AugT
	 w2a2ZHSBmswKCKIa0zEAohGmd/W6p4/ioJdBmQ7VYA8CBswhUX6AGDsT8USTFq6dvD
	 YGq5mDpvZWQQI82w+1xICw5dmUbuRz8JXro9jKL0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.15.4
Date: Fri, 27 Jun 2025 11:18:32 +0100
Message-ID: <2025062732-negate-landless-3de0@gregkh>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.15.4 kernel.

All users of the 6.15 kernel series must upgrade.

The updated 6.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.yaml                |   24 
 Documentation/gpu/nouveau.rst                                                |    5 
 Makefile                                                                     |    2 
 arch/arm/mach-omap2/clockdomain.h                                            |    1 
 arch/arm/mach-omap2/clockdomains33xx_data.c                                  |    2 
 arch/arm/mach-omap2/cm33xx.c                                                 |   14 
 arch/arm/mach-omap2/pmic-cpcap.c                                             |    6 
 arch/arm/mm/ioremap.c                                                        |    4 
 arch/arm64/include/asm/tlbflush.h                                            |    9 
 arch/arm64/kernel/ptrace.c                                                   |    2 
 arch/arm64/kvm/hyp/include/hyp/debug-sr.h                                    |    3 
 arch/arm64/mm/mmu.c                                                          |    3 
 arch/loongarch/include/asm/irqflags.h                                        |   16 
 arch/loongarch/include/asm/vdso/getrandom.h                                  |    2 
 arch/loongarch/include/asm/vdso/gettimeofday.h                               |    6 
 arch/loongarch/mm/hugetlbpage.c                                              |    3 
 arch/mips/vdso/Makefile                                                      |    1 
 arch/nios2/include/asm/pgtable.h                                             |   16 
 arch/parisc/boot/compressed/Makefile                                         |    1 
 arch/parisc/kernel/unaligned.c                                               |    2 
 arch/powerpc/include/asm/ppc_asm.h                                           |    2 
 arch/powerpc/kernel/eeh.c                                                    |    2 
 arch/powerpc/kernel/trace/ftrace_entry.S                                     |    2 
 arch/powerpc/kernel/vdso/Makefile                                            |    2 
 arch/powerpc/net/bpf_jit.h                                                   |   20 
 arch/powerpc/net/bpf_jit_comp.c                                              |   33 
 arch/powerpc/net/bpf_jit_comp32.c                                            |    6 
 arch/powerpc/net/bpf_jit_comp64.c                                            |   15 
 arch/powerpc/platforms/pseries/msi.c                                         |    7 
 arch/riscv/kvm/vcpu_sbi_replace.c                                            |    8 
 arch/s390/kvm/gaccess.c                                                      |    8 
 arch/s390/pci/pci.c                                                          |   45 
 arch/s390/pci/pci_bus.h                                                      |    7 
 arch/s390/pci/pci_event.c                                                    |   22 
 arch/s390/pci/pci_mmio.c                                                     |    2 
 arch/x86/Kconfig                                                             |    2 
 arch/x86/events/intel/core.c                                                 |    2 
 arch/x86/include/asm/module.h                                                |    8 
 arch/x86/include/asm/tdx.h                                                   |    2 
 arch/x86/kernel/alternative.c                                                |   79 -
 arch/x86/kernel/cpu/amd.c                                                    |    2 
 arch/x86/kernel/cpu/sgx/main.c                                               |    2 
 arch/x86/kvm/svm/svm.c                                                       |    2 
 arch/x86/kvm/vmx/vmx.c                                                       |    5 
 arch/x86/mm/init_32.c                                                        |    3 
 arch/x86/mm/init_64.c                                                        |    3 
 arch/x86/mm/pat/set_memory.c                                                 |    3 
 arch/x86/mm/pti.c                                                            |    5 
 arch/x86/virt/vmx/tdx/tdx.c                                                  |    5 
 block/blk-merge.c                                                            |   26 
 block/blk-zoned.c                                                            |    1 
 drivers/accel/ivpu/ivpu_fw.c                                                 |   12 
 drivers/accel/ivpu/ivpu_gem.c                                                |   89 -
 drivers/accel/ivpu/ivpu_gem.h                                                |    2 
 drivers/accel/ivpu/ivpu_job.c                                                |    6 
 drivers/accel/ivpu/ivpu_jsm_msg.c                                            |    9 
 drivers/acpi/acpica/amlresrc.h                                               |    8 
 drivers/acpi/acpica/dsutils.c                                                |    9 
 drivers/acpi/acpica/psobject.c                                               |   52 
 drivers/acpi/acpica/rsaddr.c                                                 |   13 
 drivers/acpi/acpica/rscalc.c                                                 |   22 
 drivers/acpi/acpica/rslist.c                                                 |   12 
 drivers/acpi/acpica/utprint.c                                                |    7 
 drivers/acpi/acpica/utresrc.c                                                |   14 
 drivers/acpi/battery.c                                                       |   19 
 drivers/acpi/bus.c                                                           |    6 
 drivers/ata/ahci.c                                                           |   35 
 drivers/ata/pata_via.c                                                       |    3 
 drivers/atm/atmtcp.c                                                         |    4 
 drivers/base/platform-msi.c                                                  |    1 
 drivers/base/power/runtime.c                                                 |    2 
 drivers/base/swnode.c                                                        |    2 
 drivers/block/aoe/aoedev.c                                                   |    8 
 drivers/block/ublk_drv.c                                                     |    3 
 drivers/bluetooth/btmrvl_sdio.c                                              |    4 
 drivers/bluetooth/btmtksdio.c                                                |    2 
 drivers/bluetooth/btusb.c                                                    |    5 
 drivers/bus/fsl-mc/fsl-mc-uapi.c                                             |    4 
 drivers/bus/fsl-mc/mc-io.c                                                   |   19 
 drivers/bus/fsl-mc/mc-sys.c                                                  |    2 
 drivers/bus/mhi/ep/ring.c                                                    |   16 
 drivers/bus/mhi/host/pm.c                                                    |   18 
 drivers/bus/ti-sysc.c                                                        |   49 
 drivers/char/ipmi/ipmi_ssif.c                                                |    6 
 drivers/clk/meson/g12a.c                                                     |    1 
 drivers/clk/qcom/gcc-sm8650.c                                                |    2 
 drivers/clk/qcom/gcc-sm8750.c                                                |    3 
 drivers/clk/qcom/gcc-x1e80100.c                                              |    4 
 drivers/clk/rockchip/clk-rk3036.c                                            |    1 
 drivers/cpufreq/scmi-cpufreq.c                                               |   36 
 drivers/crypto/intel/qat/qat_420xx/adf_drv.c                                 |    8 
 drivers/crypto/intel/qat/qat_4xxx/adf_drv.c                                  |    8 
 drivers/crypto/intel/qat/qat_c3xxx/adf_drv.c                                 |    8 
 drivers/crypto/intel/qat/qat_c62x/adf_drv.c                                  |    8 
 drivers/crypto/intel/qat/qat_dh895xcc/adf_drv.c                              |    8 
 drivers/crypto/marvell/cesa/cesa.c                                           |    2 
 drivers/crypto/marvell/cesa/cesa.h                                           |    9 
 drivers/crypto/marvell/cesa/tdma.c                                           |   53 
 drivers/dma-buf/udmabuf.c                                                    |    5 
 drivers/edac/altera_edac.c                                                   |    6 
 drivers/edac/amd64_edac.c                                                    |    1 
 drivers/edac/igen6_edac.c                                                    |  100 +
 drivers/firmware/arm_scmi/driver.c                                           |   76 -
 drivers/firmware/arm_scmi/protocols.h                                        |    2 
 drivers/firmware/cirrus/test/cs_dsp_mock_bin.c                               |    3 
 drivers/firmware/cirrus/test/cs_dsp_mock_wmfw.c                              |    3 
 drivers/firmware/cirrus/test/cs_dsp_test_control_cache.c                     |    1 
 drivers/firmware/sysfb.c                                                     |   26 
 drivers/firmware/ti_sci.c                                                    |   14 
 drivers/gpio/gpio-loongson-64bit.c                                           |    2 
 drivers/gpio/gpio-mlxbf3.c                                                   |   54 
 drivers/gpio/gpio-pca953x.c                                                  |    2 
 drivers/gpio/gpiolib-of.c                                                    |    9 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                   |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c                                      |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c                                      |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c                                      |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h                                      |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h                                      |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c                               |   22 
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h                                     |   12 
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h                                  |    9 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                                       |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                                       |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c                                        |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c                                        |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c                                        |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                                        |    2 
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c                                        |   14 
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                                       |   17 
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c                                       |   17 
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c                                      |   63 
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c                                       |   20 
 drivers/gpu/drm/amd/amdkfd/kfd_device.c                                      |    5 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c                              |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c                                       |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                                         |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c                                    |    6 
 drivers/gpu/drm/amd/display/amdgpu_dm/Makefile                               |    1 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                            |  170 --
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h                            |    9 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c                  |   17 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c                     |  178 ++
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn351_clk_mgr.c                |    1 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c                 |    8 
 drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c                       |   38 
 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c               |    1 
 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c               |    1 
 drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c             |    1 
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c                |    2 
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c                           |    5 
 drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c                         |    2 
 drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c                    |   14 
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c                      |   21 
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h                     |    3 
 drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c                 |   61 
 drivers/gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401.c               |   60 
 drivers/gpu/drm/amd/display/dc/irq_types.h                                   |    9 
 drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c                         |  380 ++---
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c               |    2 
 drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c               |    2 
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c                                 |    4 
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h                                 |    1 
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c                           |   13 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c                               |   10 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c                         |    4 
 drivers/gpu/drm/bridge/Kconfig                                               |    1 
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c                           |    5 
 drivers/gpu/drm/bridge/analogix/anx7625.c                                    |   26 
 drivers/gpu/drm/display/drm_dp_helper.c                                      |   39 
 drivers/gpu/drm/drm_panel_orientation_quirks.c                               |    6 
 drivers/gpu/drm/i915/i915_pmu.c                                              |    4 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                                        |   14 
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c                                        |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c                         |   17 
 drivers/gpu/drm/msm/dp/dp_display.c                                          |    7 
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c                                   |    7 
 drivers/gpu/drm/msm/hdmi/hdmi_i2c.c                                          |   14 
 drivers/gpu/drm/msm/registers/adreno/adreno_pm4.xml                          |    3 
 drivers/gpu/drm/nouveau/Kbuild                                               |    1 
 drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h                            |   45 
 drivers/gpu/drm/nouveau/nouveau_backlight.c                                  |    2 
 drivers/gpu/drm/nouveau/nouveau_drm.c                                        |    8 
 drivers/gpu/drm/nouveau/nvkm/subdev/bar/r535.c                               |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/Kbuild                               |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c                               |  673 ---------
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/Kbuild                            |    5 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/Kbuild                       |    6 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rm.c                         |   10 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c                        |  699 ++++++++++
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h                              |   20 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rpc.h                             |   18 
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/r535.c                           |    2 
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c                              |   41 
 drivers/gpu/drm/panel/panel-simple.c                                         |   29 
 drivers/gpu/drm/panthor/panthor_mmu.c                                        |    1 
 drivers/gpu/drm/rockchip/inno_hdmi.c                                         |   36 
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h                                 |    1 
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c                                 |    5 
 drivers/gpu/drm/solomon/ssd130x.c                                            |    2 
 drivers/gpu/drm/tiny/Kconfig                                                 |    1 
 drivers/gpu/drm/ttm/tests/ttm_bo_test.c                                      |    2 
 drivers/gpu/drm/v3d/v3d_sched.c                                              |    8 
 drivers/gpu/drm/xe/xe_bo.c                                                   |    4 
 drivers/gpu/drm/xe/xe_eu_stall.c                                             |    4 
 drivers/gpu/drm/xe/xe_exec.c                                                 |    4 
 drivers/gpu/drm/xe/xe_exec_queue.c                                           |    9 
 drivers/gpu/drm/xe/xe_gt.c                                                   |    2 
 drivers/gpu/drm/xe/xe_gt_freq.c                                              |   82 -
 drivers/gpu/drm/xe/xe_gt_idle.c                                              |   28 
 drivers/gpu/drm/xe/xe_gt_throttle.c                                          |   90 -
 drivers/gpu/drm/xe/xe_guc.c                                                  |   44 
 drivers/gpu/drm/xe/xe_oa.c                                                   |    6 
 drivers/gpu/drm/xe/xe_svm.c                                                  |    2 
 drivers/gpu/drm/xe/xe_uc_fw.c                                                |    2 
 drivers/gpu/drm/xe/xe_vm.c                                                   |    6 
 drivers/hid/hid-asus.c                                                       |  107 +
 drivers/hv/connection.c                                                      |   23 
 drivers/hwmon/ftsteutates.c                                                  |    9 
 drivers/hwmon/ltc4282.c                                                      |    7 
 drivers/hwmon/occ/common.c                                                   |  240 +--
 drivers/i2c/busses/i2c-designware-slave.c                                    |    2 
 drivers/i2c/busses/i2c-k1.c                                                  |    2 
 drivers/i2c/busses/i2c-npcm7xx.c                                             |   12 
 drivers/i2c/busses/i2c-pasemi-core.c                                         |    2 
 drivers/i2c/busses/i2c-tegra.c                                               |    5 
 drivers/i3c/master/mipi-i3c-hci/core.c                                       |    6 
 drivers/iio/accel/fxls8962af-core.c                                          |   15 
 drivers/iio/adc/Kconfig                                                      |    6 
 drivers/iio/adc/ad7173.c                                                     |   15 
 drivers/iio/adc/ad7606.c                                                     |   21 
 drivers/iio/adc/ad7606_spi.c                                                 |    2 
 drivers/iio/adc/ad7944.c                                                     |    2 
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c                             |    8 
 drivers/infiniband/core/iwcm.c                                               |   29 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                                   |    2 
 drivers/input/keyboard/gpio_keys.c                                           |    6 
 drivers/input/misc/ims-pcu.c                                                 |    6 
 drivers/iommu/amd/iommu.c                                                    |   41 
 drivers/iommu/intel/iommu.c                                                  |   11 
 drivers/iommu/intel/iommu.h                                                  |    1 
 drivers/iommu/intel/nested.c                                                 |    4 
 drivers/iommu/iommu.c                                                        |   21 
 drivers/md/dm-raid1.c                                                        |    5 
 drivers/md/dm-table.c                                                        |   14 
 drivers/md/dm-verity-fec.c                                                   |    4 
 drivers/md/dm-verity-target.c                                                |    8 
 drivers/md/dm-verity-verify-sig.c                                            |   17 
 drivers/media/cec/usb/extron-da-hd-4k-plus/extron-da-hd-4k-plus.c            |    4 
 drivers/media/common/videobuf2/videobuf2-dma-sg.c                            |    4 
 drivers/media/i2c/ccs-pll.c                                                  |   23 
 drivers/media/i2c/ds90ub913.c                                                |    4 
 drivers/media/i2c/imx334.c                                                   |   18 
 drivers/media/i2c/imx335.c                                                   |    5 
 drivers/media/i2c/lt6911uxe.c                                                |    4 
 drivers/media/i2c/ov08x40.c                                                  |    2 
 drivers/media/i2c/ov2740.c                                                   |    4 
 drivers/media/i2c/ov5675.c                                                   |    5 
 drivers/media/i2c/ov8856.c                                                   |    9 
 drivers/media/i2c/tc358743.c                                                 |    4 
 drivers/media/pci/intel/ipu6/ipu6-dma.c                                      |    4 
 drivers/media/pci/intel/ipu6/ipu6.c                                          |    5 
 drivers/media/platform/imagination/e5010-jpeg-enc.c                          |    9 
 drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c |    2 
 drivers/media/platform/nuvoton/npcm-video.c                                  |   15 
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h                            |    1 
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c                               |   90 -
 drivers/media/platform/nxp/imx8-isi/imx8-isi-m2m.c                           |   14 
 drivers/media/platform/qcom/camss/camss-csid.c                               |    4 
 drivers/media/platform/qcom/camss/camss-vfe.c                                |    4 
 drivers/media/platform/qcom/iris/iris_firmware.c                             |    4 
 drivers/media/platform/qcom/venus/core.c                                     |   16 
 drivers/media/platform/qcom/venus/vdec.c                                     |    4 
 drivers/media/platform/renesas/rcar-vin/rcar-dma.c                           |   18 
 drivers/media/platform/renesas/rcar-vin/rcar-v4l2.c                          |    8 
 drivers/media/platform/renesas/vsp1/vsp1_rwpf.c                              |   13 
 drivers/media/platform/samsung/exynos4-is/fimc-is-regs.c                     |    1 
 drivers/media/platform/ti/cal/cal-video.c                                    |    4 
 drivers/media/platform/ti/davinci/vpif.c                                     |    4 
 drivers/media/platform/ti/omap3isp/ispccdc.c                                 |    8 
 drivers/media/platform/ti/omap3isp/ispstat.c                                 |    6 
 drivers/media/platform/verisilicon/rockchip_vpu_hw.c                         |   20 
 drivers/media/test-drivers/vidtv/vidtv_channel.c                             |    2 
 drivers/media/test-drivers/vivid/vivid-vid-cap.c                             |    2 
 drivers/media/usb/dvb-usb/cxusb.c                                            |    3 
 drivers/media/usb/gspca/stv06xx/stv06xx_hdcs.c                               |    7 
 drivers/media/usb/uvc/uvc_ctrl.c                                             |   23 
 drivers/media/usb/uvc/uvc_driver.c                                           |   27 
 drivers/media/v4l2-core/v4l2-dev.c                                           |   14 
 drivers/mmc/core/card.h                                                      |    6 
 drivers/mmc/core/quirks.h                                                    |   10 
 drivers/mmc/core/sd.c                                                        |   32 
 drivers/mtd/nand/qpic_common.c                                               |    8 
 drivers/mtd/nand/raw/qcom_nandc.c                                            |   18 
 drivers/mtd/nand/raw/sunxi_nand.c                                            |    2 
 drivers/mtd/nand/spi/alliancememory.c                                        |   12 
 drivers/mtd/nand/spi/ato.c                                                   |    6 
 drivers/mtd/nand/spi/esmt.c                                                  |    8 
 drivers/mtd/nand/spi/foresee.c                                               |    8 
 drivers/mtd/nand/spi/gigadevice.c                                            |   48 
 drivers/mtd/nand/spi/macronix.c                                              |    8 
 drivers/mtd/nand/spi/micron.c                                                |   20 
 drivers/mtd/nand/spi/paragon.c                                               |   12 
 drivers/mtd/nand/spi/skyhigh.c                                               |   12 
 drivers/mtd/nand/spi/toshiba.c                                               |    8 
 drivers/mtd/nand/spi/winbond.c                                               |   34 
 drivers/mtd/nand/spi/xtx.c                                                   |   12 
 drivers/net/can/kvaser_pciefd.c                                              |    3 
 drivers/net/can/m_can/tcan4x5x-core.c                                        |    9 
 drivers/net/ethernet/aquantia/atlantic/aq_main.c                             |    1 
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c                              |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                                    |   87 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c                                |   29 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h                                |    1 
 drivers/net/ethernet/cadence/macb_main.c                                     |    6 
 drivers/net/ethernet/cortina/gemini.c                                        |   37 
 drivers/net/ethernet/dlink/dl2k.c                                            |   14 
 drivers/net/ethernet/dlink/dl2k.h                                            |    2 
 drivers/net/ethernet/emulex/benet/be_cmds.c                                  |    2 
 drivers/net/ethernet/faraday/Kconfig                                         |    1 
 drivers/net/ethernet/intel/e1000e/netdev.c                                   |   14 
 drivers/net/ethernet/intel/e1000e/ptp.c                                      |    8 
 drivers/net/ethernet/intel/i40e/i40e_common.c                                |    7 
 drivers/net/ethernet/intel/ice/ice_arfs.c                                    |   48 
 drivers/net/ethernet/intel/ice/ice_eswitch.c                                 |    6 
 drivers/net/ethernet/intel/ice/ice_switch.c                                  |    4 
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c                                 |    4 
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c                           |    9 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c                     |    4 
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c                              |    1 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c                   |   10 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c               |   78 -
 drivers/net/ethernet/mellanox/mlx5/core/vport.c                              |   18 
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c                   |    6 
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c                                   |    5 
 drivers/net/ethernet/microchip/lan743x_ethtool.c                             |   18 
 drivers/net/ethernet/microchip/lan743x_ptp.h                                 |    4 
 drivers/net/ethernet/pensando/ionic/ionic_main.c                             |    3 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                            |    7 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                                     |   24 
 drivers/net/ethernet/ti/icssg/icssg_common.c                                 |   19 
 drivers/net/ethernet/vertexcom/mse102x.c                                     |   15 
 drivers/net/hyperv/netvsc_bpf.c                                              |    2 
 drivers/net/hyperv/netvsc_drv.c                                              |    4 
 drivers/net/netdevsim/netdev.c                                               |    2 
 drivers/net/phy/marvell-88q2xxx.c                                            |  103 -
 drivers/net/phy/mediatek/mtk-ge-soc.c                                        |   10 
 drivers/net/usb/asix.h                                                       |    1 
 drivers/net/usb/asix_common.c                                                |   22 
 drivers/net/usb/asix_devices.c                                               |   17 
 drivers/net/usb/ch9200.c                                                     |    7 
 drivers/net/vxlan/vxlan_core.c                                               |   22 
 drivers/net/wireless/ath/ath11k/ce.c                                         |   11 
 drivers/net/wireless/ath/ath11k/core.c                                       |   55 
 drivers/net/wireless/ath/ath11k/core.h                                       |    7 
 drivers/net/wireless/ath/ath11k/dp_rx.c                                      |   25 
 drivers/net/wireless/ath/ath11k/hal.c                                        |    4 
 drivers/net/wireless/ath/ath11k/qmi.c                                        |    9 
 drivers/net/wireless/ath/ath12k/ce.c                                         |   11 
 drivers/net/wireless/ath/ath12k/ce.h                                         |    6 
 drivers/net/wireless/ath/ath12k/dp.c                                         |   77 -
 drivers/net/wireless/ath/ath12k/dp.h                                         |    5 
 drivers/net/wireless/ath/ath12k/dp_mon.c                                     |    2 
 drivers/net/wireless/ath/ath12k/dp_rx.c                                      |   15 
 drivers/net/wireless/ath/ath12k/hal.c                                        |   12 
 drivers/net/wireless/ath/ath12k/hal.h                                        |    6 
 drivers/net/wireless/ath/ath12k/hal_desc.h                                   |    2 
 drivers/net/wireless/ath/ath12k/hw.c                                         |    2 
 drivers/net/wireless/ath/ath12k/hw.h                                         |    3 
 drivers/net/wireless/ath/ath12k/mac.c                                        |   55 
 drivers/net/wireless/ath/ath12k/pci.c                                        |    3 
 drivers/net/wireless/ath/ath12k/peer.c                                       |    5 
 drivers/net/wireless/ath/ath12k/peer.h                                       |    3 
 drivers/net/wireless/ath/ath12k/wmi.c                                        |   28 
 drivers/net/wireless/ath/ath12k/wmi.h                                        |    1 
 drivers/net/wireless/ath/carl9170/usb.c                                      |   19 
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c                               |    3 
 drivers/net/wireless/intel/iwlwifi/dvm/main.c                                |    6 
 drivers/net/wireless/intel/iwlwifi/mld/d3.c                                  |    2 
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c                            |    2 
 drivers/net/wireless/intel/iwlwifi/mld/mld.c                                 |    3 
 drivers/net/wireless/intel/iwlwifi/mld/thermal.c                             |    4 
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c                            |    4 
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c                              |    6 
 drivers/net/wireless/intersil/p54/fwio.c                                     |    2 
 drivers/net/wireless/intersil/p54/p54.h                                      |    1 
 drivers/net/wireless/intersil/p54/txrx.c                                     |   13 
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c                              |    2 
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c                         |   13 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c                             |    5 
 drivers/net/wireless/mediatek/mt76/mt7925/init.c                             |    6 
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c                              |   20 
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h                              |    1 
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c                              |    3 
 drivers/net/wireless/mediatek/mt76/mt7925/regs.h                             |    2 
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                              |    8 
 drivers/net/wireless/mediatek/mt76/mt7996/main.c                             |    4 
 drivers/net/wireless/purelifi/plfxlc/usb.c                                   |    4 
 drivers/net/wireless/realtek/rtlwifi/pci.c                                   |   10 
 drivers/net/wireless/realtek/rtw88/hci.h                                     |    8 
 drivers/net/wireless/realtek/rtw88/mac.c                                     |   11 
 drivers/net/wireless/realtek/rtw88/mac.h                                     |    2 
 drivers/net/wireless/realtek/rtw88/mac80211.c                                |    2 
 drivers/net/wireless/realtek/rtw88/main.c                                    |   32 
 drivers/net/wireless/realtek/rtw88/main.h                                    |    3 
 drivers/net/wireless/realtek/rtw88/pci.c                                     |    2 
 drivers/net/wireless/realtek/rtw88/rtw8703b.c                                |    1 
 drivers/net/wireless/realtek/rtw88/rtw8723d.c                                |    1 
 drivers/net/wireless/realtek/rtw88/rtw8812a.c                                |    1 
 drivers/net/wireless/realtek/rtw88/rtw8814a.c                                |   11 
 drivers/net/wireless/realtek/rtw88/rtw8821a.c                                |    1 
 drivers/net/wireless/realtek/rtw88/rtw8821c.c                                |    1 
 drivers/net/wireless/realtek/rtw88/rtw8822b.c                                |    1 
 drivers/net/wireless/realtek/rtw88/rtw8822bu.c                               |    2 
 drivers/net/wireless/realtek/rtw88/rtw8822c.c                                |    1 
 drivers/net/wireless/realtek/rtw88/sdio.c                                    |    2 
 drivers/net/wireless/realtek/rtw88/usb.c                                     |   57 
 drivers/net/wireless/realtek/rtw89/cam.c                                     |    3 
 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c                            |    5 
 drivers/net/wireless/virtual/mac80211_hwsim.c                                |    5 
 drivers/nvme/host/ioctl.c                                                    |   21 
 drivers/nvme/host/tcp.c                                                      |    2 
 drivers/pci/controller/cadence/pcie-cadence-ep.c                             |    5 
 drivers/pci/controller/dwc/pcie-designware-ep.c                              |    5 
 drivers/pci/controller/dwc/pcie-dw-rockchip.c                                |    6 
 drivers/pci/controller/pcie-apple.c                                          |    2 
 drivers/pci/hotplug/pciehp_hpc.c                                             |    2 
 drivers/pci/hotplug/s390_pci_hpc.c                                           |    2 
 drivers/pci/pci.c                                                            |    3 
 drivers/pci/quirks.c                                                         |   23 
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c                                   |   10 
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c                                  |   21 
 drivers/pinctrl/pinctrl-mcp23s08.c                                           |    8 
 drivers/platform/loongarch/loongson-laptop.c                                 |   87 -
 drivers/platform/x86/amd/pmc/pmc.c                                           |    2 
 drivers/platform/x86/amd/pmf/core.c                                          |    3 
 drivers/platform/x86/amd/pmf/tee-if.c                                        |   67 
 drivers/platform/x86/dell/alienware-wmi-wmax.c                               |    2 
 drivers/platform/x86/dell/dell_rbu.c                                         |    6 
 drivers/platform/x86/ideapad-laptop.c                                        |   19 
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c          |    9 
 drivers/pmdomain/core.c                                                      |    4 
 drivers/power/supply/bq27xxx_battery.c                                       |    2 
 drivers/power/supply/bq27xxx_battery_i2c.c                                   |   13 
 drivers/power/supply/collie_battery.c                                        |    1 
 drivers/power/supply/gpio-charger.c                                          |    4 
 drivers/power/supply/max17040_battery.c                                      |    5 
 drivers/ptp/ptp_clock.c                                                      |    3 
 drivers/ptp/ptp_private.h                                                    |   22 
 drivers/pwm/pwm-axi-pwmgen.c                                                 |   23 
 drivers/rapidio/rio_cm.c                                                     |    3 
 drivers/regulator/max14577-regulator.c                                       |    5 
 drivers/regulator/max20086-regulator.c                                       |    4 
 drivers/remoteproc/remoteproc_core.c                                         |    6 
 drivers/remoteproc/ti_k3_m4_remoteproc.c                                     |    2 
 drivers/s390/scsi/zfcp_sysfs.c                                               |    2 
 drivers/scsi/elx/efct/efct_hw.c                                              |    5 
 drivers/scsi/lpfc/lpfc_hbadisc.c                                             |    2 
 drivers/scsi/lpfc/lpfc_sli.c                                                 |    4 
 drivers/scsi/smartpqi/smartpqi_init.c                                        |   84 +
 drivers/scsi/storvsc_drv.c                                                   |   10 
 drivers/soc/qcom/pmic_glink_altmode.c                                        |   30 
 drivers/spi/spi-qpic-snand.c                                                 |    1 
 drivers/staging/iio/impedance-analyzer/ad5933.c                              |    2 
 drivers/staging/media/rkvdec/rkvdec.c                                        |   14 
 drivers/tee/tee_core.c                                                       |   11 
 drivers/uio/uio_hv_generic.c                                                 |    7 
 drivers/video/console/dummycon.c                                             |   18 
 drivers/video/console/vgacon.c                                               |    2 
 drivers/video/fbdev/core/fbcon.c                                             |    7 
 drivers/video/fbdev/core/fbmem.c                                             |   22 
 drivers/video/screen_info_pci.c                                              |   79 -
 drivers/virt/coco/tsm.c                                                      |   31 
 drivers/watchdog/da9052_wdt.c                                                |    1 
 drivers/watchdog/stm32_iwdg.c                                                |    2 
 fs/anon_inodes.c                                                             |   45 
 fs/ceph/addr.c                                                               |    9 
 fs/ceph/super.c                                                              |    1 
 fs/configfs/dir.c                                                            |    2 
 fs/dlm/lowcomms.c                                                            |    5 
 fs/erofs/zmap.c                                                              |   10 
 fs/exfat/nls.c                                                               |    1 
 fs/exfat/super.c                                                             |   30 
 fs/ext4/ext4.h                                                               |    7 
 fs/ext4/extents.c                                                            |   39 
 fs/ext4/file.c                                                               |    7 
 fs/ext4/inline.c                                                             |    2 
 fs/ext4/inode.c                                                              |   24 
 fs/ext4/ioctl.c                                                              |    8 
 fs/f2fs/compress.c                                                           |   23 
 fs/f2fs/f2fs.h                                                               |    5 
 fs/f2fs/inode.c                                                              |   10 
 fs/f2fs/namei.c                                                              |    9 
 fs/f2fs/node.c                                                               |    8 
 fs/f2fs/segment.c                                                            |   12 
 fs/f2fs/super.c                                                              |   12 
 fs/file.c                                                                    |    8 
 fs/gfs2/lock_dlm.c                                                           |    3 
 fs/internal.h                                                                |    5 
 fs/ioctl.c                                                                   |    7 
 fs/isofs/inode.c                                                             |    7 
 fs/isofs/isofs.h                                                             |    4 
 fs/isofs/rock.c                                                              |   40 
 fs/isofs/rock.h                                                              |    6 
 fs/isofs/util.c                                                              |   49 
 fs/jbd2/transaction.c                                                        |    5 
 fs/jffs2/erase.c                                                             |    4 
 fs/jffs2/scan.c                                                              |    4 
 fs/jffs2/summary.c                                                           |    7 
 fs/jfs/jfs_discard.c                                                         |    3 
 fs/jfs/jfs_dmap.c                                                            |    6 
 fs/jfs/jfs_dtree.c                                                           |   18 
 fs/libfs.c                                                                   |   10 
 fs/nfs/client.c                                                              |    2 
 fs/nfs/flexfilelayout/flexfilelayoutdev.c                                    |    2 
 fs/nfs/internal.h                                                            |    1 
 fs/nfs/localio.c                                                             |    6 
 fs/nfs/nfs4proc.c                                                            |    5 
 fs/nfs/read.c                                                                |    3 
 fs/nfsd/export.c                                                             |    3 
 fs/nfsd/nfs4proc.c                                                           |    3 
 fs/nfsd/nfs4xdr.c                                                            |   19 
 fs/nfsd/nfsctl.c                                                             |   26 
 fs/nfsd/nfssvc.c                                                             |    6 
 fs/overlayfs/file.c                                                          |    4 
 fs/overlayfs/overlayfs.h                                                     |    8 
 fs/pidfs.c                                                                   |    2 
 fs/smb/client/cached_dir.c                                                   |   14 
 fs/smb/client/cached_dir.h                                                   |    8 
 fs/smb/client/cifsglob.h                                                     |    1 
 fs/smb/client/connect.c                                                      |   17 
 fs/smb/client/namespace.c                                                    |    3 
 fs/smb/client/readdir.c                                                      |   28 
 fs/smb/client/reparse.c                                                      |    1 
 fs/smb/client/sess.c                                                         |    7 
 fs/smb/client/smb2pdu.c                                                      |   33 
 fs/smb/client/smbdirect.c                                                    |    5 
 fs/smb/client/transport.c                                                    |   14 
 fs/smb/server/connection.c                                                   |    2 
 fs/smb/server/connection.h                                                   |    1 
 fs/smb/server/smb2pdu.c                                                      |   11 
 fs/smb/server/transport_rdma.c                                               |   10 
 fs/smb/server/transport_tcp.c                                                |    3 
 fs/xattr.c                                                                   |    1 
 include/acpi/actypes.h                                                       |    2 
 include/drm/display/drm_dp_helper.h                                          |    5 
 include/linux/acpi.h                                                         |    9 
 include/linux/atmdev.h                                                       |    6 
 include/linux/bus/stm32_firewall_device.h                                    |   15 
 include/linux/codetag.h                                                      |    8 
 include/linux/execmem.h                                                      |    8 
 include/linux/f2fs_fs.h                                                      |    1 
 include/linux/fs.h                                                           |    2 
 include/linux/hugetlb.h                                                      |    3 
 include/linux/mmc/card.h                                                     |    1 
 include/linux/module.h                                                       |    5 
 include/linux/mtd/nand-qpic-common.h                                         |    4 
 include/linux/mtd/spinand.h                                                  |   72 -
 include/linux/tcp.h                                                          |    2 
 include/net/mac80211.h                                                       |   16 
 include/trace/events/erofs.h                                                 |   18 
 include/uapi/linux/videodev2.h                                               |   12 
 io_uring/io-wq.c                                                             |    4 
 io_uring/io_uring.c                                                          |    2 
 io_uring/kbuf.c                                                              |    7 
 io_uring/net.c                                                               |    6 
 io_uring/rsrc.c                                                              |    8 
 io_uring/sqpoll.c                                                            |    5 
 ipc/shm.c                                                                    |    5 
 kernel/bpf/bpf_struct_ops.c                                                  |    2 
 kernel/bpf/btf.c                                                             |    4 
 kernel/bpf/helpers.c                                                         |    3 
 kernel/cgroup/legacy_freezer.c                                               |    3 
 kernel/events/core.c                                                         |   80 -
 kernel/exit.c                                                                |   17 
 kernel/module/main.c                                                         |    5 
 kernel/sched/core.c                                                          |    4 
 kernel/sched/ext.c                                                           |    5 
 kernel/sched/ext.h                                                           |    2 
 kernel/sched/fair.c                                                          |    4 
 kernel/sched/rt.c                                                            |   54 
 kernel/time/clocksource.c                                                    |    2 
 kernel/trace/ftrace.c                                                        |   10 
 kernel/trace/trace.c                                                         |    5 
 kernel/trace/trace_events_filter.c                                           |  184 +-
 kernel/trace/trace_functions_graph.c                                         |    6 
 kernel/watchdog.c                                                            |   41 
 kernel/workqueue.c                                                           |    7 
 lib/Kconfig                                                                  |    1 
 lib/alloc_tag.c                                                              |   12 
 lib/codetag.c                                                                |   34 
 mm/execmem.c                                                                 |   40 
 mm/hugetlb.c                                                                 |   67 
 mm/madvise.c                                                                 |    7 
 mm/page-writeback.c                                                          |    2 
 mm/readahead.c                                                               |   20 
 mm/vma.c                                                                     |   49 
 mm/vma.h                                                                     |    7 
 net/atm/common.c                                                             |    1 
 net/atm/lec.c                                                                |   12 
 net/atm/raw.c                                                                |    2 
 net/bridge/br_mst.c                                                          |    4 
 net/bridge/br_multicast.c                                                    |  103 +
 net/bridge/br_private.h                                                      |   11 
 net/core/dev.c                                                               |    1 
 net/core/filter.c                                                            |   19 
 net/core/page_pool.c                                                         |    4 
 net/core/skbuff.c                                                            |    3 
 net/core/skmsg.c                                                             |    3 
 net/core/sock.c                                                              |    4 
 net/ipv4/route.c                                                             |    4 
 net/ipv4/tcp_fastopen.c                                                      |    3 
 net/ipv4/tcp_input.c                                                         |   79 -
 net/ipv6/calipso.c                                                           |    8 
 net/mac80211/cfg.c                                                           |    2 
 net/mac80211/debugfs_sta.c                                                   |    6 
 net/mac80211/mesh_hwmp.c                                                     |    6 
 net/mac80211/rate.c                                                          |    2 
 net/mac80211/sta_info.c                                                      |   28 
 net/mac80211/sta_info.h                                                      |   11 
 net/mac80211/tx.c                                                            |   15 
 net/mpls/af_mpls.c                                                           |    4 
 net/netfilter/nft_set_pipapo.c                                               |    6 
 net/nfc/nci/uart.c                                                           |    8 
 net/sched/sch_sfq.c                                                          |   10 
 net/sched/sch_taprio.c                                                       |    6 
 net/sctp/socket.c                                                            |    3 
 net/sunrpc/cache.c                                                           |   17 
 net/sunrpc/svc.c                                                             |   11 
 net/sunrpc/xprtrdma/svc_rdma_transport.c                                     |    1 
 net/sunrpc/xprtsock.c                                                        |    5 
 net/tipc/crypto.c                                                            |    2 
 net/tipc/udp_media.c                                                         |    4 
 net/xfrm/xfrm_user.c                                                         |   52 
 scripts/Makefile.compiler                                                    |    4 
 security/selinux/xfrm.c                                                      |    2 
 sound/pci/hda/cs35l41_hda_property.c                                         |    6 
 sound/pci/hda/hda_intel.c                                                    |    2 
 sound/pci/hda/patch_realtek.c                                                |   15 
 sound/soc/amd/acp/acp-sdw-legacy-mach.c                                      |    2 
 sound/soc/amd/acp/acp-sdw-sof-mach.c                                         |    2 
 sound/soc/amd/yc/acp6x-mach.c                                                |    9 
 sound/soc/codecs/tas2770.c                                                   |   30 
 sound/soc/codecs/wcd937x.c                                                   |    7 
 sound/soc/generic/simple-card-utils.c                                        |   23 
 sound/soc/meson/meson-card-utils.c                                           |    2 
 sound/soc/qcom/sdm845.c                                                      |    4 
 sound/soc/sdw_utils/soc_sdw_rt_amp.c                                         |    2 
 sound/soc/tegra/tegra210_ahub.c                                              |    2 
 sound/usb/mixer_maps.c                                                       |   12 
 tools/bpf/bpftool/cgroup.c                                                   |   12 
 tools/lib/bpf/btf.c                                                          |   18 
 tools/lib/bpf/libbpf.c                                                       |    6 
 tools/net/ynl/pyynl/lib/ynl.py                                               |   67 
 tools/perf/tests/tests-scripts.c                                             |    1 
 tools/perf/util/print-events.c                                               |    1 
 tools/testing/selftests/x86/Makefile                                         |    2 
 tools/testing/selftests/x86/sigtrap_loop.c                                   |  101 +
 tools/testing/vma/vma_internal.h                                             |    2 
 tools/tracing/rtla/src/utils.c                                               |    2 
 660 files changed, 6737 insertions(+), 3756 deletions(-)

Aditya Dutt (1):
      jfs: fix array-index-out-of-bounds read in add_missing_indices

Aditya Garg (1):
      drm/appletbdrm: Make appletbdrm depend on X86

Aditya Kumar Singh (2):
      wifi: mac80211: validate SCAN_FLAG_AP in scan request during MLO
      wifi: ath12k: fix failed to set mhi state error during reboot with hardware grouping

Ahmed Salem (1):
      ACPICA: Avoid sequence overread in call to strncmp()

Akhil P Oommen (1):
      drm/msm/a6xx: Increase HFI response timeout

Akhil R (2):
      i2c: tegra: check msg length in SMBUS block read
      dt-bindings: i2c: nvidia,tegra20-i2c: Specify the required properties

Alan Maguire (2):
      libbpf/btf: Fix string handling to support multi-split BTF
      libbpf: Add identical pointer detection to btf_dedup_is_equiv()

Alex Deucher (6):
      drm/amdgpu/gfx6: fix CSIB handling
      drm/amdgpu/gfx11: fix CSIB handling
      drm/amdgpu/gfx10: fix CSIB handling
      drm/amdgpu/gfx7: fix CSIB handling
      drm/amdgpu/gfx8: fix CSIB handling
      drm/amdgpu/gfx9: fix CSIB handling

Alex Elder (1):
      i2c: k1: check for transfer error

Alexander Aring (2):
      gfs2: move msleep to sleepable context
      dlm: use SHUT_RDWR for SCTP shutdown

Alexander Sverdlin (1):
      Revert "bus: ti-sysc: Probe for l4_wkup and l4_cfg interconnect devices first"

Alexey Kodanev (1):
      net: lan743x: fix potential out-of-bounds write in lan743x_ptp_io_event_clock_get()

Alok Tiwari (1):
      emulex/benet: correct command version selection in be_cmd_get_stats()

Amber Lin (1):
      drm/amdkfd: Set SDMA_RLCx_IB_CNTL/SWITCH_INSIDE_IB

Amir Goldstein (1):
      ovl: fix debug print in case of mkdir error

Andreas Kemnade (1):
      ARM: omap: pmic-cpcap: do not mess around without CPCAP or OMAP4

Andrew Morton (1):
      drivers/rapidio/rio_cm.c: prevent possible heap overwrite

Andrew Zaborowski (1):
      x86/sgx: Prevent attempts to reclaim poisoned pages

André Almeida (1):
      ovl: Fix nested backing file paths

Andy Yan (2):
      drm/rockchip: inno-hdmi: Fix video timing HSYNC/VSYNC polarity setting for rk3036
      drm/rockchip: vop2: Make overlay layer select register configuration take effect by vsync

Antonin Godard (1):
      drm/panel: simple: Add POWERTIP PH128800T004-ZZA01 panel entry

Anup Patel (2):
      RISC-V: KVM: Fix the size parameter check in SBI SFENCE calls
      RISC-V: KVM: Don't treat SBI HFENCE calls as NOPs

Anusha Srivatsa (1):
      drm/panel/sharp-ls043t1le01: Use _multi variants

Apurv Mishra (1):
      drm/amdkfd: Drop workaround for GC v9.4.3 revID 0

Armin Wolf (1):
      ACPI: bus: Bail out if acpi_kobj registration fails

Arnd Bergmann (3):
      parisc: fix building with gcc-15
      hwmon: (occ) Rework attribute registration for stack usage
      hwmon: (occ) fix unaligned accesses

Artem Sadovnikov (1):
      jffs2: check that raw node were preallocated before writing summary

Arthur-Prince (1):
      iio: adc: ti-ads1298: Kconfig: add kfifo dependency to fix module build

Arvind Yadav (1):
      drm/amdgpu: fix MES GFX mask

Avadhut Naik (1):
      EDAC/amd64: Correct number of UMCs for family 19h models 70h-7fh

Ayushi Makhija (2):
      drm/bridge: anx7625: enable HPD interrupts
      drm/bridge: anx7625: change the gpiod_set_value API

Bagas Sanjaya (1):
      Documentation: nouveau: Update GSP message queue kernel-doc reference

Balamurugan S (1):
      wifi: ath12k: fix incorrect CE addresses

Baochen Qiang (3):
      wifi: ath12k: fix a possible dead lock caused by ab->base_lock
      wifi: ath12k: make assoc link associate first
      wifi: ath11k: determine PM policy based on machine model

Beleswar Padhi (1):
      remoteproc: k3-m4: Don't assert reset in detach routine

Ben Skeggs (2):
      drm/nouveau/gsp: fix rm shutdown wait condition
      drm/nouveau/gsp: split rpc handling out on its own

Benjamin Berg (2):
      wifi: iwlwifi: mld: call thermal exit without wiphy lock held
      wifi: mac80211: do not offer a mesh path if forwarding is disabled

Benjamin Lin (1):
      wifi: mt76: mt7996: drop fragments with multicast or broadcast RA

Benjamin Marzinski (1):
      dm-table: check BLK_FEAT_ATOMIC_WRITES inside limits_lock

Bharath SM (2):
      smb: improve directory cache reuse for readdir operations
      smb: fix secondary channel creation issue with kerberos by populating hostname when adding channels

Binbin Zhou (1):
      gpio: loongson-64bit: Correct Loongson-7A2000 ACPI GPIO access mode

Bitterblue Smith (3):
      wifi: rtw88: usb: Upload the firmware in bigger chunks
      wifi: rtw88: usb: Reduce control message timeout to 500 ms
      wifi: rtw88: Set AMPDU factor to hardware for RTL8814A

Boris Brezillon (1):
      drm/panthor: Don't update MMU_INT_MASK in panthor_mmu_irq_handler()

Brett Creeley (1):
      ionic: Prevent driver/fw getting out of sync on devcmd(s)

Brett Werling (1):
      can: tcan4x5x: fix power regulator retrieval during probe

Brian Foster (1):
      ext4: only dirty folios when data journaling regular files

Chao Gao (1):
      KVM: VMX: Flush shadow VMCS on emergency reboot

Chao Yu (6):
      f2fs: fix to do sanity check on ino and xnid
      f2fs: fix to do sanity check on sit_bitmap_size
      f2fs: fix to return correct error number in f2fs_sync_node_pages()
      f2fs: use vmalloc instead of kvmalloc in .init_{,de}compress_ctx
      f2fs: fix to bail out in get_new_segment()
      f2fs: fix to set atomic write status more clear

Charan Teja Kalla (1):
      PM: runtime: fix denying of auto suspend in pm_suspend_timer_fn()

Charlene Liu (2):
      drm/amd/display: disable DPP RCG before DPP CLK enable
      drm/amd/display: fix zero value for APU watermark_c

Chen Linxuan (1):
      RDMA/hns: initialize db in update_srq_db()

Chen Ridong (1):
      cgroup,freezer: fix incomplete freezing when attaching tasks

Chris Chiu (1):
      ALSA: hda/realtek: Fix built-in mic on ASUS VivoBook X513EA

Christian Brauner (4):
      anon_inode: use a proper mode internally
      anon_inode: explicitly block ->setattr()
      anon_inode: raise SB_I_NODEV and SB_I_NOEXEC
      fs: add S_ANON_INODE

Christian Lamparter (1):
      wifi: p54: prevent buffer-overflow in p54_rx_eeprom_readback()

Christoph Rudorff (1):
      drm/nouveau: fix hibernate on disabled GPU

Christophe Leroy (1):
      powerpc/vdso: Fix build of VDSO32 with pcrel

Chuck Lever (3):
      NFSD: Implement FATTR4_CLONE_BLKSIZE attribute
      SUNRPC: Prevent hang on NFS mount with xprtsec=[m]tls
      svcrdma: Unregister the device if svc_rdma_accept() fails

Chuyi Zhou (1):
      workqueue: Initialize wq_isolated_cpumask in workqueue_init_early()

Connor Abbott (2):
      drm/msm: Fix CP_RESET_CONTEXT_STATE bitfield names
      drm/msm/a7xx: Call CP_RESET_CONTEXT_STATE

Corey Minyard (1):
      ipmi:ssif: Fix a shutdown race

Da Xue (1):
      clk: meson-g12a: add missing fclk_div2 to spicc

Damien Le Moal (1):
      block: Clear BIO_EMULATES_ZONE_APPEND flag on BIO completion

Damon Ding (1):
      drm/bridge: analogix_dp: Add irq flag IRQF_NO_AUTOEN instead of calling disable_irq()

Dan Carpenter (2):
      media: iris: fix error code in iris_load_fw_to_memory()
      Input: ims-pcu - check record size in ims_pcu_flash_firmware()

Dan Williams (1):
      configfs-tsm-report: Fix NULL dereference of tsm_ops

Daniel Wagner (1):
      scsi: lpfc: Use memcpy() for BIOS version

Daniele Ceraolo Spurio (1):
      drm/xe/vf: Fix guc_info debugfs for VFs

Dave Airlie (1):
      drm/dp: add option to disable zero sized address only transactions.

Dave Hansen (1):
      x86/mm: Disable INVLPGB when PTI is enabled

David Lechner (5):
      pwm: axi-pwmgen: fix missing separate external clock
      iio: adc: ad7944: mask high bits on direct read
      iio: adc: ad7606_spi: fix reg write value mask
      iio: adc: ad7173: fix compiling without gpiolib
      iio: adc: ad7606: fix raw read for 18-bit chips

David Strahan (1):
      scsi: smartpqi: Add new PCI IDs

David Thompson (2):
      mlxbf_gige: return EPROBE_DEFER if PHY IRQ is not available
      gpio: mlxbf3: only get IRQ for device instance 0

David Wei (1):
      tcp: fix passive TFO socket having invalid NAPI ID

Denis Arefev (1):
      media: vivid: Change the siize of the composing

Dennis Marttinen (1):
      ceph: set superblock s_magic for IMA fsmagic matching

Dev Jain (1):
      arm64: Restrict pagetable teardown to avoid false warning

Dexuan Cui (1):
      scsi: storvsc: Increase the timeouts to storvsc_timeout

Dian-Syuan Yang (1):
      wifi: rtw89: leave idle mode when setting WEP encryption for AP mode

Diederik de Haas (1):
      PCI: dw-rockchip: Fix PHY function call sequence in rockchip_pcie_phy_deinit()

Dillon Varone (3):
      drm/amd/display: Fix Vertical Interrupt definitions for dcn32, dcn401
      drm/amd/display: Fix VUpdate offset calculations for dcn401
      Revert "drm/amd/display: Fix VUpdate offset calculations for dcn401"

Dimitri Fedrau (1):
      net: phy: marvell-88q2xxx: Enable temperature measurement in probe again

Dmitry Antipov (1):
      wifi: carl9170: do not ping device which has failed to load firmware

Dmitry Baryshkov (3):
      drm/bridge: select DRM_KMS_HELPER for AUX_BRIDGE
      drm/msm/hdmi: add runtime PM calls to DDC transfer function
      drm/msm/dpu: don't select single flush for active CTL blocks

Dmitry Nikiforov (1):
      media: davinci: vpif: Fix memory leak in probe error path

Donald Hunter (1):
      tools: ynl: parse extack for sub-messages

Dongcheng Yan (1):
      media: i2c: change lt6911uxe irq_gpio name to "hpd"

Dylan Wolff (1):
      jfs: Fix null-ptr-deref in jfs_ioc_trim

Edip Hazuri (1):
      ALSA: hda/realtek - Add mute LED support for HP Victus 16-s1xxx and HP Victus 15-fa1xxx

Edward Adam Davis (3):
      media: cxusb: no longer judge rbuf when the write fails
      media: vidtv: Terminating the subsequent process of initialization failure
      wifi: mac80211_hwsim: Prevent tsf from setting if beacon is disabled

Eric Dumazet (7):
      tcp: always seek for minimal rtt in tcp_rcv_rtt_update()
      tcp: remove zero TCP TS samples for autotuning
      tcp: fix initial tp->rcvq_space.space value for passive TS enabled flows
      tcp: add receive queue awareness in tcp_rcv_space_adjust()
      net_sched: sch_sfq: reject invalid perturb period
      net: atm: add lec_mutex
      net: atm: fix /proc/net/atm/lec handling

Erick Shepherd (1):
      mmc: Add quirk to disable DDR50 tuning

Fabrice Gasnier (1):
      Input: gpio-keys - fix a sleep while atomic with PREEMPT_RT

Fangzhi Zuo (1):
      drm/amd/display: Do Not Consider DSC if Valid Config Not Found

Fedor Pchelkin (2):
      can: kvaser_pciefd: refine error prone echo_skb_max handling logic
      jffs2: check jffs2_prealloc_raw_node_refs() result in few other places

Fei Shao (1):
      media: mediatek: vcodec: Correct vsi_core framebuffer size

Frank Li (1):
      platform-msi: Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()

Frank Wunderlich (1):
      net: phy: mediatek: do not require syscon compatible for pio property

GONG Ruiqi (1):
      vgacon: Add check for vc_origin address range in vgacon_scroll()

Gabor Juhos (4):
      pinctrl: armada-37xx: propagate error from armada_37xx_pmx_set_by_name()
      pinctrl: armada-37xx: propagate error from armada_37xx_gpio_get_direction()
      pinctrl: armada-37xx: propagate error from armada_37xx_pmx_gpio_set_direction()
      pinctrl: armada-37xx: propagate error from armada_37xx_gpio_get()

Gabriel Shahrouzi (1):
      staging: iio: ad5933: Correct settling cycles encoding per datasheet

Gao Xiang (3):
      erofs: remove unused trace event erofs_destroy_inode
      erofs: refuse crafted out-of-file-range encoded extents
      erofs: remove a superfluous check for encoded extents

Gatien Chevallier (1):
      Input: gpio-keys - fix possible concurrent access in gpio_keys_irq_timer()

Gautam Menghani (1):
      powerpc/pseries/msi: Avoid reading PCI device registers in reduced power states

Giovanni Cabiddu (5):
      crypto: qat - add shutdown handler to qat_c3xxx
      crypto: qat - add shutdown handler to qat_420xx
      crypto: qat - add shutdown handler to qat_4xxx
      crypto: qat - add shutdown handler to qat_c62x
      crypto: qat - add shutdown handler to qat_dh895xcc

Greg Kroah-Hartman (1):
      Linux 6.15.4

Grzegorz Nitka (1):
      ice: fix eswitch code memory leak in reset scenario

Gui-Dong Han (1):
      hwmon: (ftsteutates) Fix TOCTOU race in fts_read()

Guilherme G. Piccoli (1):
      clocksource: Fix the CPUs' choice in the watchdog per CPU verification

Haixia Qu (1):
      tipc: fix null-ptr-deref when acquiring remote ip of ethernet bearer

Hans Verkuil (2):
      media: cec: extron-da-hd-4k-plus: Fix Wformat-truncation
      media: tc358743: ignore video while HPD is low

Hans de Goede (2):
      media: ov2740: Move pm-runtime cleanup on probe-errors to proper place
      media: ov08x40: Extend sleep after reset to 5 ms

Hao Yao (1):
      media: ipu6: Remove workaround for Meteor Lake ES2

Haoxiang Li (1):
      media: imagination: fix a potential memory leak in e5010_probe()

Hari Bathini (2):
      powerpc64/ftrace: fix clobbered r15 during livepatching
      powerpc/bpf: fix JIT code size calculation of bpf trampoline

Hari Chandrakanthan (1):
      wifi: ath12k: fix link valid field initialization in the monitor Rx

Hariprasad Kelam (1):
      Octeontx2-pf: Fix Backpresure configuration

Harish Chegondi (1):
      drm/xe: Use copy_from_user() instead of __copy_from_user()

Harshit Agarwal (1):
      sched/rt: Fix race in push_rt_task

Hector Martin (2):
      ASoC: tas2770: Power cycle amp on ISENSE/VSENSE change
      i2c: pasemi: Enable the unjam machine

Heiko Carstens (1):
      s390/pci: Fix __pcilg_mio_inuser() inline assembly

Heiko Stuebner (1):
      clk: rockchip: rk3036: mark ddrphy as critical

Heiner Kallweit (1):
      net: ftgmac100: select FIXED_PHY

Helge Deller (1):
      parisc/unaligned: Fix hex output to show 8 hex chars

Henk Vergonet (1):
      wifi: mt76: mt76x2: Add support for LiteOn WN4516R,WN4519R

Herbert Xu (1):
      crypto: marvell/cesa - Do not chain submitted requests

Hou Tao (1):
      bpf: Check rcu_read_lock_trace_held() in bpf_map_lookup_percpu_elem()

Huacai Chen (2):
      PCI: Add ACS quirk for Loongson PCIe
      LoongArch: Avoid using $r0/$r1 as "mask" for csrxchg

Hyunwoo Kim (1):
      net/sched: fix use-after-free in taprio_dev_notifier

I Hsin Cheng (1):
      ASoC: intel/sdw_utils: Assign initial value in asoc_sdw_rt_amp_spk_rtd_init()

Ian Rogers (2):
      perf evsel: Missed close() when probing hybrid core PMUs
      perf test: Directory file descriptor leak

Ido Schimmel (2):
      vxlan: Do not treat dst cache initialization errors as fatal
      vxlan: Add RCU read-side critical sections in the Tx path

Ilpo Järvinen (1):
      PCI: Fix lock symmetry in pci_slot_unlock()

Ilya Leoshkevich (1):
      bpf: Pass the same orig_call value to trampoline functions

Ioana Ciornei (1):
      bus: fsl-mc: do not add a device-link for the UAPI used DPMCP device

Jacek Lawrynowicz (4):
      accel/ivpu: Improve buffer object logging
      accel/ivpu: Use firmware names from upstream repo
      accel/ivpu: Use dma_resv_lock() instead of a custom mutex
      accel/ivpu: Fix warning in ivpu_gem_bo_free()

Jacob Keller (1):
      drm/nouveau/bl: increase buffer size to avoid truncate warning

Jaegeuk Kim (1):
      f2fs: prevent kernel warning due to negative i_nlink from corrupted image

Jakub Kicinski (3):
      net: clear the dst when changing skb protocol
      eth: fbnic: avoid double free when failing to DMA-map FW msg
      tools: ynl: fix mixing ops and notifications on one socket

James A. MacInnes (2):
      drm/msm/dp: Disable wide bus support for SDM845
      drm/msm/disp: Correct porch timing for SDM845

Jan Kara (1):
      ext4: fix calculation of credits for extent tree modification

Jann Horn (3):
      mm/hugetlb: unshare page tables during VMA split, not before
      mm/hugetlb: fix huge_pmd_unshare() vs GUP-fast race
      tee: Prevent size calculation wraparound on 32-bit kernels

Janne Grunau (1):
      PCI: apple: Set only available ports up

Jarkko Nikula (1):
      i3c: mipi-i3c-hci: Fix handling status of i3c_hci_irq_handler()

Jaroslav Kysela (3):
      firmware: cs_dsp: Fix OOB memory read access in KUnit test
      firmware: cs_dsp: Fix OOB memory read access in KUnit test (ctl cache)
      firmware: cs_dsp: Fix OOB memory read access in KUnit test (wmfw info)

Jason Xing (3):
      net: atlantic: generate software timestamp just before the doorbell
      net: stmmac: generate software timestamp just before the doorbell
      net: mlx4: add SOF_TIMESTAMPING_TX_SOFTWARE flag when getting ts info

Jeevaka Prabu Badrappan (1):
      drm/xe: Fix CFI violation when accessing sysfs files

Jeff Hugo (1):
      bus: mhi: host: Fix conflict between power_up and SYSERR

Jeff Layton (2):
      nfsd: use threads array as-is in netlink interface
      sunrpc: handle SVC_GARBAGE during svc auth processing as auth error

Jens Axboe (7):
      block: use plug request list tail for one-shot backmerge attempt
      io_uring/net: only consider msg_inq if larger than 1
      io_uring/kbuf: don't truncate end buffer for multiple buffer peeks
      io_uring/rsrc: validate buffer count with offset for cloning
      nvme: always punt polled uring_cmd end_io work to task_work
      io_uring/net: always use current transfer count for buffer put
      io_uring/sqpoll: don't put task_struct on tctx setup failure

Jeongjun Park (2):
      jbd2: fix data-race and null-ptr-deref in jbd2_journal_dirty_metadata()
      ipc: fix to protect IPCS lookups using RCU

Jerry Lv (1):
      power: supply: bq27xxx: Retrieve again when busy

Jesse.Zhang (2):
      drm/amdgpu: Fix API status offset for MES queue reset
      drm/amdkfd: move SDMA queue reset capability check to node_show

Jiande Lu (1):
      Bluetooth: btusb: Add new VID/PID 13d3/3630 for MT7925

Jiayuan Chen (2):
      workqueue: Fix race condition in wq->stats incrementation
      bpf, sockmap: Fix data lost during EAGAIN retries

Jinliang Zheng (1):
      mm: fix ratelimit_pages update error in dirty_ratio_handler()

Joe Damato (1):
      netdevsim: Mark NAPI ID on skb in nsim_rcv

Johan Hovold (8):
      wifi: ath11k: fix rx completion meta data corruption
      wifi: ath11k: fix ring-buffer corruption
      wifi: ath12k: fix ring-buffer corruption
      media: ov8856: suppress probe deferral errors
      media: ov5675: suppress probe deferral errors
      media: qcom: camss: csid: suppress CSID log spam
      media: qcom: camss: vfe: suppress VFE version log spam
      soc: qcom: pmic_glink_altmode: fix spurious DP hotplug events

Johannes Berg (2):
      wifi: iwlwifi: mvm: fix beacon CCK flag
      wifi: iwlwifi: dvm: pair transport op-mode enter/leave

John Garry (1):
      dm-table: Set BLK_FEAT_ATOMIC_WRITES for target queue limits

John Keeping (1):
      drm/ssd130x: fix ssd132x_clear_screen() columns

Jonas 'Sortie' Termansen (1):
      isofs: fix Y2038 and Y2156 issues in Rock Ridge TF entry

Jonathan Lane (1):
      ALSA: hda/realtek: enable headset mic on Latitude 5420 Rugged

João Paulo Gonçalves (2):
      regulator: max20086: Fix MAX200086 chip id
      regulator: max20086: Change enable gpio to optional

Juergen Gross (1):
      x86/mm/pat: don't collapse pages without PSE set

Justin Sanders (1):
      aoe: clean device rq_list in aoedev_downdev()

Justin Tee (1):
      scsi: lpfc: Fix lpfc_check_sli_ndlp() handling for GEN_REQUEST64 commands

Kai Huang (1):
      x86/virt/tdx: Avoid indirect calls to TDX assembly functions

Kalesh AP (2):
      bnxt_en: Remove unused field "ref_count" in struct bnxt_ulp
      bnxt_en: Fix double invocation of bnxt_ulp_stop()/bnxt_ulp_start()

Kan Liang (1):
      perf/x86/intel: Fix crash in icl_update_topdown_event()

Kang Yang (1):
      wifi: ath12k: fix macro definition HAL_RX_MSDU_PKT_LENGTH_GET

Karol Wachowski (1):
      accel/ivpu: Trigger device recovery on engine reset/resume failure

Kees Cook (2):
      fbcon: Make sure modelist not set on unregistered console
      wifi: iwlwifi: mld: Work around Clang loop unrolling bug

Kendall Willis (1):
      firmware: ti_sci: Convert CPU latency constraint from us to ms

Kevin Gao (1):
      drm/amd/display: Correct SSC enable detection for DCN351

Khem Raj (1):
      mips: Add -std= flag specified in KBUILD_CFLAGS to vdso CFLAGS

Kieran Bingham (1):
      media: i2c: imx335: Fix frame size enumeration

Krishna Kumar (1):
      net: ice: Perform accurate aRFS flow match

Krzysztof Hałasa (1):
      usbnet: asix AX88772: leave the carrier control to phylink

Krzysztof Kozlowski (10):
      ASoC: codecs: wcd9375: Fix double free of regulator supplies
      ASoC: codecs: wcd937x: Drop unused buck_supply
      bus: firewall: Fix missing static inline annotations for stubs
      NFC: nci: uart: Set tty->disc_data only in success path
      power: supply: gpio-charger: Fix wakeup source leaks on device unbind
      power: supply: collie: Fix wakeup source leaks on device unbind
      Bluetooth: btmrvl_sdio: Fix wakeup source leaks on device unbind
      Bluetooth: btmtksdio: Fix wakeup source leaks on device unbind
      watchdog: stm32: Fix wakeup source leaks on device unbind
      drm/msm/dsi/dsi_phy_10nm: Fix missing initial VCO rate

Kuan-Chung Chen (1):
      wifi: rtw89: 8922a: fix TX fail with wrong VCO setting

Kuninori Morimoto (1):
      ASoC: simple-card-utils: fixup dlc->xxx handling for error case

Kuniyuki Iwashima (4):
      atm: Revert atm_account_tx() if copy_from_iter_full() fails.
      mpls: Use rcu_dereference_rtnl() in mpls_route_input_rcu().
      atm: atmtcp: Free invalid length skb in atmtcp_c_send().
      calipso: Fix null-ptr-deref in calipso_req_{set,del}attr().

Kurt Borja (1):
      Revert "platform/x86: alienware-wmi-wmax: Add G-Mode support to Alienware m16 R1"

Kyungwook Boo (1):
      i40e: fix MMIO write access to an invalid page in i40e_clear_hw

Laurent Pinchart (1):
      media: renesas: vsp1: Fix media bus code setup on RWPF source pad

Laurentiu Palcu (1):
      media: nxp: imx8-isi: better handle the m2m usage_count

Laurentiu Tudor (1):
      bus: fsl-mc: increase MC_CMD_COMPLETION_TIMEOUT_MS value

Leon Romanovsky (1):
      xfrm: validate assignment of maximal possible SEQ number

Leon Yen (1):
      wifi: mt76: mt7925: introduce thermal protection

Li Lingfeng (1):
      nfsd: Initialize ssc before laundromat_work to prevent NULL dereference

Lijo Lazar (3):
      drm/amdgpu: Add basic validation for RAS header
      drm/amdgpu: Disallow partition query during reset
      drm/amd/pm: Reset SMU v13.0.x custom settings

Linus Torvalds (1):
      Make 'cc-option' work correctly for the -Wno-xyzzy pattern

Linus Walleij (1):
      net: ethernet: cortina: Use TOE/TSO on all TCP

Liwei Sun (1):
      Bluetooth: btusb: Add new VID/PID 13d3/3584 for MT7922

Loic Poulain (1):
      media: venus: Fix probe error handling

Long Li (5):
      Drivers: hv: Allocate interrupt and monitor pages aligned to system page boundary
      uio_hv_generic: Use correct size for interrupt and monitor pages
      uio_hv_generic: Align ring size to system page
      sunrpc: update nextcheck time when adding new cache entries
      sunrpc: fix race in cache cleanup causing stale nextcheck time

Lorenzo Stoakes (2):
      KVM: s390: rename PROT_NONE to PROT_TYPE_DUMMY
      mm/vma: reset VMA iterator on commit_merge() OOM failure

Lu Baolu (2):
      iommu/vt-d: Restore context entry setup order for aliased devices
      iommu: Allow attaching static domains in iommu_attach_device_pasid()

Lucas De Marchi (1):
      drm/xe/uc: Remove static from loop variable

Luis Henriques (1):
      fs: drop assert in file_seek_cur_needs_f_lock

Lukas Bulwahn (1):
      x86/its: Fix an ifdef typo in its_alloc()

Lukas Wunner (1):
      PCI: pciehp: Ignore belated Presence Detect Changed caused by DPC

Luke D. Jones (1):
      hid-asus: check ROG Ally MCU version and warn

Luo Gengkun (2):
      watchdog: fix watchdog may detect false positive of softlockup
      perf/core: Fix WARN in perf_cgroup_switch()

Ma Ke (1):
      media: v4l2-dev: fix error handling in __video_register_device()

Maarten Lankhorst (1):
      drm/xe/svm: Fix regression disallowing 64K SVM migration

Maninder Singh (2):
      NFSD: unregister filesystem in case genl_register_family() fails
      NFSD: fix race between nfsd registration and exports_proc

Marcus Folkesson (1):
      watchdog: da9052_wdt: respect TWDMIN

Marek Szyprowski (3):
      media: omap3isp: use sgtable-based scatterlist wrappers
      media: videobuf2: use sgtable-based scatterlist wrappers
      udmabuf: use sgtable-based scatterlist wrappers

Mario Limonciello (7):
      ACPI: Add missing prototype for non CONFIG_SUSPEND/CONFIG_X86 case
      drm/amd/display: Avoid divide by zero by initializing dummy pitch to 1
      drm/amd/display: Restructure DMI quirks
      iommu/amd: Allow matching ACPI HID devices without matching UIDs
      platform/x86/amd: pmc: Clear metrics table at start of cycle
      platform/x86/amd: pmf: Use device managed allocations
      platform/x86/amd: pmf: Prevent amd_pmf_tee_deinit() from running twice

Mark Rutland (1):
      KVM: arm64: VHE: Synchronize restore of host debug registers

Martin Blumenstingl (1):
      ASoC: meson: meson-card-utils: use of_property_present() for DT parsing

Martin KaFai Lau (1):
      bpftool: Fix cgroup command to only show cgroup bpf programs

Mateusz Pacuszka (1):
      ice: fix check for existing switch rule

Max Kellermann (1):
      fs/nfs/read: fix double-unlock bug in nfs_return_empty_folio()

Maíra Canal (1):
      drm/v3d: Avoid NULL pointer dereference in `v3d_job_update_stats()`

Md Sadre Alam (3):
      mtd: rawnand: qcom: Pass 18 bit offset from NANDc base to BAM base
      mtd: rawnand: qcom: Fix last codeword read in qcom_param_page_type_exec()
      mtd: rawnand: qcom: Fix read len for onfi param page

Meghana Malladi (1):
      net: ti: icssg-prueth: Fix packet handling for XDP_TX

Michael Chang (1):
      media: nuvoton: npcm-video: Fix stuck due to no video signal error

Michael Lo (1):
      wifi: mt76: mt7925: fix host interrupt register initialization

Michael Walle (1):
      net: ethernet: ti: am65-cpsw: handle -EPROBE_DEFER

Mike Looijmans (1):
      pinctrl: mcp23s08: Reset all pins to input at probe

Mike Rapoport (Microsoft) (3):
      x86/Kconfig: only enable ROX cache in execmem when STRICT_MODULE_RWX is set
      x86/its: move its_pages array to struct mod_arch_specific
      Revert "mm/execmem: Unify early execmem_cache behaviour"

Mike Snitzer (1):
      NFS: always probe for LOCALIO support asynchronously

Mike Tipton (1):
      cpufreq: scmi: Skip SCMI devices that aren't used by the CPUs

Mikko Korhonen (1):
      ata: ahci: Disallow LPM for Asus B550-F motherboard

Mikulas Patocka (3):
      dm-mirror: fix a tiny race condition
      dm-verity: fix a memory leak if some arguments are specified multiple times
      dm: lock limits when reading them

Mina Almasry (1):
      net: netmem: fix skb_ensure_writable with unreadable skbs

Ming Qian (5):
      media: imx-jpeg: Drop the first error frames
      media: imx-jpeg: Move mxc_jpeg_free_slot_data() ahead
      media: imx-jpeg: Reset slot data pointers when freed
      media: imx-jpeg: Cleanup after an allocation error
      media: imx-jpeg: Check decoding is ongoing for motion-jpeg

Mingcong Bai (1):
      wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 11ad:1723

Miquel Raynal (6):
      mtd: spinand: Use more specific naming for the (single) read from cache ops
      mtd: spinand: Use more specific naming for the (dual output) read from cache ops
      mtd: spinand: Use more specific naming for the (dual IO) read from cache ops
      mtd: spinand: Use more specific naming for the (quad output) read from cache ops
      mtd: spinand: Use more specific naming for the (quad IO) read from cache ops
      mtd: spinand: winbond: Prevent unsupported frequencies on dual/quad I/O variants

Miri Korenblit (2):
      wifi: iwlwifi: mld: check for NULL before referencing a pointer
      wifi: iwlwifi: pcie: make sure to lock rxq->read

Moon Yeounsu (1):
      net: dlink: add synchronization for stats update

Muhammad Usama Anjum (1):
      wifi: ath11k: Fix QMI memory reuse logic

Muna Sinada (1):
      wifi: mac80211: VLAN traffic in multicast path

Murad Masimov (2):
      fbdev: Fix do_register_framebuffer to prevent null-ptr-deref in fb_videomode_to_var
      fbdev: Fix fb_set_var to prevent null-ptr-deref in fb_videomode_to_var

Mykyta Yatsenko (1):
      libbpf: Check bpf_map_skeleton link for NULL

Namjae Jeon (3):
      exfat: fix double free in delayed_free
      ksmbd: fix null pointer dereference in destroy_previous_session
      ksmbd: add free_transport ops in ksmbd connection

Narayana Murty N (1):
      powerpc/eeh: Fix missing PE bridge reconfiguration during VFIO EEH recovery

Nas Chung (3):
      media: uapi: v4l: Fix V4L2_TYPE_IS_OUTPUT condition
      media: uapi: v4l: Change V4L2_TYPE_IS_CAPTURE condition
      media: qcom: venus: Fix uninitialized variable warning

Neal Cardwell (1):
      tcp: fix tcp_packet_delayed() for tcp_is_non_sack_preventing_reopen() behavior

NeilBrown (1):
      nfsd: nfsd4_spo_must_allow() must check this is a v4 compound request

Nicolas Dufresne (2):
      media: verisilicon: Enable wide 4K in AV1 decoder
      media: rkvdec: Initialize the m2m context before the controls

Niklas Cassel (3):
      ata: ahci: Disallow LPM for ASUSPRO-D840SA motherboard
      PCI: cadence-ep: Correct PBA offset in .set_msix() callback
      PCI: dwc: ep: Correct PBA offset in .set_msix() callback

Niklas Schnelle (4):
      s390/pci: Remove redundant bus removal and disable from zpci_release_device()
      s390/pci: Prevent self deletion in disable_slot()
      s390/pci: Allow re-add of a reserved but not yet removed device
      s390/pci: Serialize device addition and removal

Niklas Söderlund (1):
      media: rcar-vin: Fix stride setting for RAW8 formats

Niravkumar L Rabara (1):
      EDAC/altera: Use correct write width with the INTTEST register

Nuno Sá (1):
      hwmon: (ltc4282) avoid repeated register write

Olga Kornievskaia (1):
      nfsd: fix access checking for NLM under XPRTSEC policies

Ovidiu Bunea (1):
      drm/amd/display: Update IPS sequential_ono requirement checks

Pablo Neira Ayuso (1):
      netfilter: nft_set_pipapo: clamp maximum map bucket size to INT_MAX

Pali Rohár (1):
      cifs: Remove duplicate fattr->cf_dtype assignment from wsl_to_fattr() function

Paul Aurich (1):
      smb: Log an error when close_all_cached_dirs fails

Paul Hsieh (1):
      drm/amd/display: Skip to enable dsc if it has been off

Pavan Chebbi (2):
      bnxt_en: Add a helper function to configure MRU and RSS
      bnxt_en: Update MRU and RSS table of RSS contexts on queue reset

Pavel Begunkov (2):
      io_uring: account drain memory to cgroup
      io_uring/kbuf: account ring io_buffer_list memory

Peng Fan (1):
      gpiolib: of: Add polarity quirk for s5m8767

Penglei Jiang (2):
      io_uring: fix task leak issue in io_wq_create()
      io_uring: fix potential page leak in io_sqe_buffer_register()

Peter Marheine (1):
      ACPI: battery: negate current when discharging

Peter Oberparleiter (1):
      scsi: s390: zfcp: Ensure synchronous unit_add

Peter Zijlstra (3):
      sched/fair: Adhere to place_entity() constraints
      perf: Fix sample vs do_exit()
      perf: Fix cgroup state vs ERROR

Peter Zijlstra (Intel) (1):
      x86/its: explicitly manage permissions for ITS pages

Petr Malat (1):
      sctp: Do not wake readers in __sctp_write_space()

Pradeep Kumar Chitrapu (1):
      wifi: ath12k: Fix incorrect rates sent to firmware

Pu Lehui (1):
      mm: fix uprobe pte be overwritten when expanding vma

Qasim Ijaz (2):
      net: ch9200: fix uninitialised access during mii_nway_restart
      drm/ttm/tests: fix incorrect assert in ttm_bo_unreserve_bulk()

Qiuxu Zhuo (2):
      EDAC/igen6: Skip absent memory controllers
      EDAC/igen6: Fix NULL pointer dereference

Rand Deeb (1):
      ixgbe: Fix unreachable retry logic in combined and byte I2C write functions

Rengarajan S (1):
      net: lan743x: Modify the EEPROM and OTP size for PCI1xxxx devices

Ricardo Ribalda (3):
      media: uvcvideo: Return the number of processed controls
      media: uvcvideo: Send control events for partial succeeds
      media: uvcvideo: Fix deferred probing error

Richard Fitzgerald (1):
      ALSA: hda/realtek: Add quirk for Asus GU605C

Rik van Riel (1):
      x86/mm: Fix early boot use of INVPLGB

Rong Zhang (1):
      platform/x86: ideapad-laptop: use usleep_range() for EC polling

Ronnie Sahlberg (1):
      ublk: santizize the arguments from userspace when adding a device

Ross Stutterheim (1):
      ARM: 9447/1: arm/memremap: fix arch_memremap_can_ram_remap()

Ruben Devos (1):
      smb: client: add NULL check in automount_fullpath

Ryan Roberts (2):
      arm64/mm: Close theoretical race where stale TLB entry remains valid
      mm: close theoretical race where stale TLB entries could linger

Sakari Ailus (5):
      media: ccs-pll: Start VT pre-PLL multiplier search from correct value
      media: ccs-pll: Start OP pre-PLL multiplier search from correct value
      media: ccs-pll: Correct the upper limit of maximum op_pre_pll_clk_div
      media: ccs-pll: Check for too high VT PLL multiplier in dual PLL case
      media: ccs-pll: Better validate VT PLL branch

Salah Triki (1):
      wireless: purelifi: plfxlc: fix memory leak in plfxlc_usb_wreq_asyn()

Samson Tam (1):
      drm/amd/display: disable EASF narrow filter sharpening

Samuel Williams (1):
      wifi: mt76: mt7921: add 160 MHz AP for mt7922 device

Sarika Sharma (2):
      wifi: ath12k: correctly handle mcast packets for clients
      wifi: ath12k: using msdu end descriptor to check for rx multicast packets

Sascha Hauer (1):
      gpio: pca953x: fix wrong error probe return value

Saurabh Sengar (1):
      hv_netvsc: fix potential deadlock in netvsc_vf_setxdp()

Scott Mayhew (1):
      NFSv4: Don't check for OPEN feature support in v4.1

Sean Christopherson (1):
      iommu/amd: Ensure GA log notifier callbacks finish running before module unload

Sean Nyekjaer (3):
      iio: accel: fxls8962af: Fix temperature scan element sign
      iio: accel: fxls8962af: Fix temperature calculation
      iio: imu: inv_icm42600: Fix temperature calculation

Sebastian Andrzej Siewior (2):
      ipv4/route: Use this_cpu_inc() for stats on PREEMPT_RT
      net: page_pool: Don't recycle into cache on PREEMPT_RT

SeongJae Park (1):
      mm/madvise: handle madvise_lock() failure during race unwinding

Sergio Perez Gonzalez (1):
      net: macb: Check return value of dma_set_mask_and_coherent()

Seunghun Han (2):
      ACPICA: fix acpi operand cache leak in dswstate.c
      ACPICA: fix acpi parse and parseext cache leaks

Shawn Lin (1):
      PCI: dw-rockchip: Remove PCIE_L0S_ENTRY check from rockchip_pcie_link_up()

Shin'ichiro Kawasaki (2):
      RDMA/iwcm: Fix use-after-free of work objects after cm_id destruction
      nvme-tcp: remove tag set when second admin queue config fails

Shravan Chippa (1):
      media: i2c: imx334: update mode_3840x2160_regs array

Shung-Hsi Yu (1):
      bpf: Use proper type to calculate bpf_raw_tp_null_args.mask index

Shyam Prasad N (6):
      cifs: reset connections for all channels when reconnect requested
      cifs: update dstaddr whenever channel iface is updated
      cifs: dns resolution is needed only for primary channel
      cifs: deal with the channel loading lag while picking channels
      cifs: serialize other channels when query server interfaces is pending
      cifs: do not disable interface polling on failure

Sibi Sankar (1):
      firmware: arm_scmi: Ensure that the message-id supports fastchannel

Sidhanta Sahu (1):
      wifi: ath12k: Fix memory leak due to multiple rx_stats allocation

Simon Horman (1):
      pldmfw: Select CRC32 when PLDMFW is selected

Simon Schuster (1):
      nios2: force update_mmu_cache on spurious tlb-permission--related pagefaults

Srinivas Pandruvada (1):
      platform/x86/intel-uncore-freq: Fail module load when plat_info is NULL

Srinivasan Shanmugam (1):
      drm/amd/display: Add NULL pointer checks in dm_force_atomic_commit()

Sriram R (1):
      wifi: ath12k: Fix the enabling of REO queue lookup table feature

Stanislaw Gruszka (1):
      media: intel/ipu6: Fix dma mask for non-secure mode

Stefan Binding (2):
      ALSA: hda/realtek: Add support for Acer Helios Laptops using CS35L41 HDA
      ALSA: hda: cs35l41: Fix swapped l/r audio channels for Acer Helios laptops

Stefan Metzmacher (1):
      smb: client: fix max_sge overflow in smb_extract_folioq_to_rdma()

Stefan Wahren (1):
      net: vertexcom: mse102x: Return code for mse102x_rx_pkt_spi

Stephen Smalley (2):
      fs/xattr.c: fix simple_xattr_list()
      selinux: fix selinux_xfrm_alloc_user() to set correct ctx_len

Steven Rostedt (4):
      tracing: Only return an adjusted address if it matches the kernel address
      tracing: Fix regression of filter waiting a long time on RCU synchronization
      fgraph: Do not enable function_graph tracer when setting funcgraph-args
      tracing: Do not free "head" on error path of filter_free_subsystem_filters()

Stuart Hayes (2):
      platform/x86: dell_rbu: Fix list usage
      platform/x86: dell_rbu: Stop overwriting data buffer

Sukrut Bellary (1):
      ARM: OMAP2+: Fix l4ls clk domain handling in STANDBY

Sumit Kumar (1):
      bus: mhi: ep: Update read pointer only after buffer is written

Suraj P Kizhakkethil (1):
      wifi: ath12k: Pass correct values of center freq1 and center freq2 for 160 MHz

Suren Baghdasaryan (1):
      alloc_tag: handle module codetag load errors as module load failures

Svyatoslav Ryhel (1):
      power: supply: max17040: adjust thermal channel scaling

Takashi Iwai (1):
      ALSA: hda/intel: Add Thinkpad E15 to PM deny list

Talhah Peerbhai (1):
      ASoC: amd: yc: Add quirk for Lenovo Yoga Pro 7 14ASP9

Tali Perry (1):
      i2c: npcm: Add clock toggle recovery

Tamir Duberstein (1):
      ACPICA: Apply pack(1) to union aml_resource

Tan En De (1):
      i2c: designware: Invoke runtime suspend on quick slave re-registration

Taniya Das (2):
      clk: qcom: gcc-x1e80100: Set FORCE MEM CORE for UFS clocks
      clk: qcom: gcc: Set FORCE_MEM_CORE_ON for gcc_ufs_axi_clk for 8650/8750

Tarang Raval (2):
      media: i2c: imx334: Enable runtime PM before sub-device registration
      media: i2c: imx334: Fix runtime PM handling in remove function

Tasos Sahanidis (1):
      ata: pata_via: Force PIO for ATAPI devices on VT6415/VT6330

Tejun Heo (1):
      sched_ext, sched/core: Don't call scx_group_set_weight() prematurely from sched_create_group()

Tengda Wu (1):
      arm64/ptrace: Fix stack-out-of-bounds read in regs_get_kernel_stack_nth()

Thadeu Lima de Souza Cascardo (1):
      ext4: inline: fix len overflow in ext4_prepare_inline_data

Thomas Weißschuh (1):
      LoongArch: vDSO: Correctly use asm parameters in syscall wrappers

Thomas Zimmermann (3):
      sysfb: Fix screen_info type check for VGA
      video: screen_info: Relocate framebuffers behind PCI bridges
      dummycon: Trigger redraw when switching consoles with deferred takeover

Tianyang Zhang (1):
      LoongArch: Fix panic caused by NULL-PMD in huge_pte_offset()

Tiezhu Yang (1):
      rtla: Define __NR_sched_setattr for LoongArch

Toke Høiland-Jørgensen (1):
      Revert "mac80211: Dynamically set CoDel parameters per station"

Tomi Valkeinen (3):
      media: i2c: ds90ub913: Fix returned fmt from .set_fmt()
      media: rcar-vin: Fix RAW10
      media: ti: cal: Fix wrong goto on error path

TungYu Lu (1):
      drm/amd/display: Correct prefetch calculation

Tzung-Bi Shih (1):
      drm/i915/pmu: Fix build error with GCOV and AutoFDO enabled

Ulf Hansson (1):
      pmdomain: core: Reset genpd->states to avoid freeing invalid data

Umang Jain (1):
      media: imx335: Use correct register width for HNUM

Vasiliy Kovalev (1):
      jfs: validate AG parameters in dbMount() to prevent crashes

Viacheslav Dubeyko (1):
      ceph: avoid kernel BUG for encrypted inode with unaligned file size

Vicki Pfau (1):
      drm: panel-orientation-quirks: Add ZOTAC Gaming Zone

Victor Skvortsov (1):
      drm/amdgpu: Add indirect L1_TLB_CNTL reg programming for VFs

Vijendar Mukunda (2):
      ASoC: amd: amd_sdw: Fix unlikely uninitialized variable use in create_sdw_dailinks()
      ASoC: amd: sof_amd_sdw: Fix unlikely uninitialized variable use in create_sdw_dailinks()

Vinay Belgaumkar (1):
      drm/xe/bmg: Update Wa_16023588340

Vitaliy Shevtsov (1):
      scsi: elx: efct: Fix memory leak in efct_hw_parse_filter()

Vitaly Lifshits (1):
      e1000e: set fixed clock frequency indication for Nahum 11 and Nahum 13

Vlad Dogaru (2):
      net/mlx5: HWS, Fix IP version decision
      net/mlx5: HWS, Harden IP version definer checks

Vladimir Oltean (2):
      ptp: fix breakage after ptp_vclock_in_use() rework
      ptp: allow reading of currently dialed frequency to succeed on free-running clocks

Víctor Gonzalo (1):
      wifi: iwlwifi: Add missing MODULE_FIRMWARE for Qu-c0-jf-b0

Wan Junjie (1):
      bus: fsl-mc: fix GET/SET_TAILDROP command ids

WangYuli (1):
      Bluetooth: btusb: Add RTL8851BE device 0x0bda:0xb850

Wentao Liang (9):
      ASoC: qcom: sdm845: Add error handling in sdm845_slim_snd_hw_params()
      net/mlx5_core: Add error handling inmlx5_query_nic_vport_qkey_viol_cntr()
      net/mlx5: Add error handling in mlx5_query_nic_vport_node_guid()
      media: gspca: Add error handling for stv06xx_read_sensor()
      mtd: rawnand: sunxi: Add randomizer configuration in sunxi_nfc_hw_ecc_write_chunk
      mtd: nand: sunxi: Add randomizer configuration before randomizer enable
      regulator: max14577: Add error check for max14577_read_reg()
      media: platform: exynos4-is: Add hardware sync wait to fimc_is_hw_change_mode()
      octeontx2-pf: Add error log forcn10k_map_unmap_rq_policer()

Xiaolei Wang (2):
      remoteproc: core: Cleanup acquired resources when rproc_handle_resources() fails in rproc_attach()
      remoteproc: core: Release rproc->clean_table after rproc_attach() fails

Xin Li (Intel) (1):
      selftests/x86: Add a test to detect infinite SIGTRAP handler loop

Xu Yang (1):
      phy: fsl-imx8mq-usb: fix phy_tx_vboost_level_from_property()

Yao Zi (3):
      platform/loongarch: laptop: Get brightness setting from EC on probe
      platform/loongarch: laptop: Unregister generic_sub_drivers on exit
      platform/loongarch: laptop: Add backlight power control support

Ye Bin (1):
      ftrace: Fix UAF when lookup kallsym after ftrace disabled

Yevgeny Kliteynik (1):
      net/mlx5: HWS, fix counting of rules in the matcher

Yihan Zhu (1):
      drm/amd/display: DCN32 null data check

Yong Wang (2):
      net: bridge: mcast: update multicast contex when vlan state is changed
      net: bridge: mcast: re-implement br_multicast_{enable, disable}_port functions

Yosry Ahmed (1):
      KVM: SVM: Clear current_vmcb during vCPU free for all *possible* CPUs

Yuanjun Gong (1):
      ASoC: tegra210_ahub: Add check to of_device_get_match_data()

Yuezhang Mo (1):
      exfat: do not clear volume dirty flag during sync

Yuuki NAGAO (1):
      wifi: rtw88: rtw8822bu VID/PID for BUFFALO WI-U2-866DM

Zhang Yi (6):
      ext4: fix out of bounds punch offset
      ext4: fix incorrect punch max_end
      ext4: factor out ext4_get_maxbytes()
      ext4: ensure i_size is smaller than maxbytes
      ext4: ext4: unify EXT4_EX_NOCACHE|NOFAIL flags in ext4_ext_remove_space()
      ext4: prevent stale extent cache entries caused by concurrent get es_cache

Zhi Wang (3):
      drm/nouveau/nvkm: factor out current GSP RPC command policies
      drm/nouveau/nvkm: introduce new GSP reply policy NVKM_GSP_RPC_REPLY_POLL
      drm/nouveau: fix a use-after-free in r535_gsp_rpc_push()

Zijun Hu (3):
      configfs: Do not override creating attribute file failure in populate_attrs()
      software node: Correct a OOB check in software_node_get_reference_args()
      sock: Correct error checking condition for (assign|release)_proto_idx()

Zilin Guan (1):
      tipc: use kfree_sensitive() for aead cleanup

gldrk (1):
      ACPICA: utilities: Fix overflow check in vsnprintf()

sunliming (1):
      wifi: mt76: mt7996: fix uninitialized symbol warning

wangdicheng (1):
      ALSA: usb-audio: Rename ALSA kcontrol PCM and PCM1 for the KTMicro sound card

zhangjian (1):
      smb: client: fix first command failure during re-negotiation


