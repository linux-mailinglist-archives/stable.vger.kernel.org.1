Return-Path: <stable+bounces-83334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 544B0998406
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 12:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0782A2833D0
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 10:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69A91C1756;
	Thu, 10 Oct 2024 10:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PwYWZ/um"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BC41BF80F;
	Thu, 10 Oct 2024 10:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728556892; cv=none; b=gaGBsVoLAn3ToFKJ6/DhGeukR+mo137zrpcGUmrwJftljn4AP+lHZHfqoRnlVihttrKUeqkDXINHErSIdxxWwGf6po1IbXtLMNq/6uP/AD3wqoqoTeMRzbYyAKXbutWLFP6Np+OeJNtzJ0tw0Zrig1xeo32a7IiML4FF6Uj8mF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728556892; c=relaxed/simple;
	bh=ni5KvrVpp75FWEe5Hlj+zAYiyoK8YwZzgpAj2PagdsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WS0EFcDK9XRRLKkpClireM7/g2TMfAGFhT7wB4PJd548bba/bUSOtPUvnBAIHDxuq5AbKg/XTMimHMuzKF1m/qCssp6mVhc6llvDnx5PjMi5YQhMHA+3UrAq2vQxVvrLP2AScrthVkJ3Khul2G1AVPoQjcFwhbIJu1NTZoJwcsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PwYWZ/um; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE95C4CED0;
	Thu, 10 Oct 2024 10:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728556892;
	bh=ni5KvrVpp75FWEe5Hlj+zAYiyoK8YwZzgpAj2PagdsU=;
	h=From:To:Cc:Subject:Date:From;
	b=PwYWZ/um/g6NRokd0PKZcHFsOkanFQELpVTGy/xmQext9k1uYsHAyRvLpwzGrhfKQ
	 6zS3weZlNBHXeDGqhVCDQG//6oDC0VP5qCjdwfapZQrsdiRDpAFh5j2iNKTnUWTMVN
	 ElztMkHjX+h1guHx1rzjSf38NFXRQpGdRKp6YN44=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.11.3
Date: Thu, 10 Oct 2024 12:41:05 +0200
Message-ID: <2024101005-flyover-console-1337@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.11.3 kernel.

All users of the 6.11 kernel series must upgrade.

The updated 6.11.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.11.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-fs-f2fs                                          |   22 
 Documentation/admin-guide/kernel-parameters.txt                                  |   10 
 Documentation/arch/arm64/silicon-errata.rst                                      |    6 
 Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml                     |    3 
 Documentation/networking/net_cachelines/net_device.rst                           |    2 
 Documentation/rust/general-information.rst                                       |    4 
 Makefile                                                                         |    2 
 arch/arm/crypto/aes-ce-glue.c                                                    |    2 
 arch/arm/crypto/aes-neonbs-glue.c                                                |    2 
 arch/arm64/Kconfig                                                               |    7 
 arch/arm64/include/asm/cputype.h                                                 |    2 
 arch/arm64/include/asm/kvm_host.h                                                |   25 
 arch/arm64/kernel/cpu_errata.c                                                   |    3 
 arch/arm64/mm/trans_pgd.c                                                        |    6 
 arch/loongarch/configs/loongson3_defconfig                                       |    1 
 arch/parisc/include/asm/mman.h                                                   |   14 
 arch/parisc/kernel/entry.S                                                       |    6 
 arch/parisc/kernel/syscall.S                                                     |   14 
 arch/powerpc/configs/ppc64_defconfig                                             |    1 
 arch/powerpc/include/asm/vdso_datapage.h                                         |   15 
 arch/powerpc/kernel/asm-offsets.c                                                |    2 
 arch/powerpc/kernel/vdso/cacheflush.S                                            |    2 
 arch/powerpc/kernel/vdso/datapage.S                                              |    4 
 arch/powerpc/platforms/pseries/dlpar.c                                           |   17 
 arch/powerpc/platforms/pseries/hotplug-cpu.c                                     |    2 
 arch/powerpc/platforms/pseries/hotplug-memory.c                                  |   16 
 arch/powerpc/platforms/pseries/pmem.c                                            |    2 
 arch/riscv/Kconfig                                                               |    8 
 arch/riscv/include/asm/thread_info.h                                             |    7 
 arch/x86/crypto/sha256-avx2-asm.S                                                |   16 
 arch/x86/events/core.c                                                           |   63 
 arch/x86/include/asm/apic.h                                                      |    8 
 arch/x86/include/asm/fpu/signal.h                                                |    2 
 arch/x86/include/asm/sev.h                                                       |    2 
 arch/x86/include/asm/syscall.h                                                   |    7 
 arch/x86/kernel/apic/apic_flat_64.c                                              |  119 
 arch/x86/kernel/apic/io_apic.c                                                   |   46 
 arch/x86/kernel/cpu/bugs.c                                                       |   14 
 arch/x86/kernel/cpu/common.c                                                     |    4 
 arch/x86/kernel/fpu/signal.c                                                     |    6 
 arch/x86/kernel/machine_kexec_64.c                                               |   27 
 arch/x86/kernel/signal.c                                                         |    3 
 arch/x86/kernel/signal_64.c                                                      |    6 
 arch/x86/mm/ident_map.c                                                          |   23 
 block/blk-iocost.c                                                               |    8 
 block/ioctl.c                                                                    |    9 
 crypto/simd.c                                                                    |   76 
 drivers/accel/ivpu/ivpu_fw.c                                                     |    4 
 drivers/acpi/acpi_pad.c                                                          |    6 
 drivers/acpi/acpica/dbconvert.c                                                  |    2 
 drivers/acpi/acpica/exprep.c                                                     |    3 
 drivers/acpi/acpica/psargs.c                                                     |   47 
 drivers/acpi/apei/einj-cxl.c                                                     |    2 
 drivers/acpi/battery.c                                                           |   28 
 drivers/acpi/cppc_acpi.c                                                         |   10 
 drivers/acpi/ec.c                                                                |   55 
 drivers/acpi/resource.c                                                          |   22 
 drivers/acpi/video_detect.c                                                      |   17 
 drivers/ata/pata_serverworks.c                                                   |   16 
 drivers/ata/sata_sil.c                                                           |   12 
 drivers/block/aoe/aoecmd.c                                                       |   13 
 drivers/bluetooth/btmrvl_sdio.c                                                  |    3 
 drivers/bluetooth/btrtl.c                                                        |    1 
 drivers/bluetooth/btusb.c                                                        |    2 
 drivers/clk/qcom/clk-alpha-pll.c                                                 |    2 
 drivers/clk/qcom/clk-rpmh.c                                                      |    2 
 drivers/clk/qcom/dispcc-sm8250.c                                                 |    3 
 drivers/clk/qcom/gcc-sc8180x.c                                                   |  438 -
 drivers/clk/qcom/gcc-sm8250.c                                                    |    6 
 drivers/clk/qcom/gcc-sm8450.c                                                    |    4 
 drivers/clk/rockchip/clk.c                                                       |    3 
 drivers/clk/samsung/clk-exynos7885.c                                             |    2 
 drivers/cpufreq/amd-pstate.c                                                     |   14 
 drivers/cpufreq/intel_pstate.c                                                   |   16 
 drivers/cpufreq/loongson3_cpufreq.c                                              |    2 
 drivers/crypto/hisilicon/sgl.c                                                   |   14 
 drivers/crypto/marvell/Kconfig                                                   |    2 
 drivers/crypto/marvell/octeontx/otx_cptvf_algs.c                                 |  261 -
 drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c                               |  254 -
 drivers/firmware/sysfb.c                                                         |    4 
 drivers/firmware/tegra/bpmp.c                                                    |    6 
 drivers/gpio/gpio-davinci.c                                                      |    8 
 drivers/gpio/gpiolib.c                                                           |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c                                          |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c                                       |   14 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h                                       |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c                                     |   35 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                                           |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c                                          |   18 
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                                          |   43 
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h                                          |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                                           |    8 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                                           |   12 
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c                                           |  132 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                                            |   54 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c                                          |   50 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                                         |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_device.c                                          |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c                            |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c                                  |   18 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c                                     |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                                         |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c                           |    5 
 drivers/gpu/drm/amd/amdkfd/soc15_int.h                                           |    1 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                                |   86 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c                        |    4 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c                      |   20 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c                          |    3 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c                   |    2 
 drivers/gpu/drm/amd/display/dc/core/dc.c                                         |    8 
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c                            |   96 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c                                |   34 
 drivers/gpu/drm/amd/display/dc/core/dc_state.c                                   |   10 
 drivers/gpu/drm/amd/display/dc/dc_types.h                                        |    1 
 drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c                           |    3 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c                           |    2 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c                           |    4 
 drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c                |    2 
 drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c              |    2 
 drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c                |    2 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c                             |    7 
 drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c                    |    2 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c             |    6 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c   |   93 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c       |    4 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h |    2 
 drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c                                |    1 
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c                    |   20 
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h                               |    1 
 drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c                     |   23 
 drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c                           |    3 
 drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c                           |    3 
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c                        |   26 
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c                          |    4 
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c                          |   48 
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c                          |    7 
 drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c                          |    4 
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c                          |   11 
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c                          |    8 
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c                        |  111 
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h                        |    2 
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c                         |    2 
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h                                 |    1 
 drivers/gpu/drm/amd/display/dc/inc/resource.h                                    |    5 
 drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c                    |    5 
 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c                         |    5 
 drivers/gpu/drm/amd/display/dc/link/link_factory.c                               |    2 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c               |    2 
 drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c                 |    5 
 drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c                   |    3 
 drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c                 |    4 
 drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c                   |    3 
 drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c                   |   10 
 drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c           |   14 
 drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c                 |    1 
 drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c                 |    3 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c                         |    2 
 drivers/gpu/drm/display/drm_hdmi_state_helper.c                                  |    4 
 drivers/gpu/drm/drm_atomic_uapi.c                                                |    2 
 drivers/gpu/drm/drm_debugfs.c                                                    |    4 
 drivers/gpu/drm/drm_print.c                                                      |   13 
 drivers/gpu/drm/i915/display/intel_ddi.c                                         |    2 
 drivers/gpu/drm/i915/display/intel_dp.c                                          |   22 
 drivers/gpu/drm/i915/display/intel_psr.c                                         |   32 
 drivers/gpu/drm/i915/display/intel_psr.h                                         |    2 
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c                                          |    2 
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c                                  |    4 
 drivers/gpu/drm/msm/adreno/adreno_gpu.c                                          |    1 
 drivers/gpu/drm/msm/msm_gpu.c                                                    |    1 
 drivers/gpu/drm/omapdrm/omap_drv.c                                               |    5 
 drivers/gpu/drm/panthor/panthor_mmu.c                                            |    8 
 drivers/gpu/drm/panthor/panthor_sched.c                                          |   36 
 drivers/gpu/drm/radeon/r100.c                                                    |   70 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c                                      |    4 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h                                      |    1 
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c                                      |    2 
 drivers/gpu/drm/scheduler/sched_entity.c                                         |   14 
 drivers/gpu/drm/scheduler/sched_main.c                                           |    7 
 drivers/gpu/drm/stm/drv.c                                                        |    3 
 drivers/gpu/drm/stm/ltdc.c                                                       |   76 
 drivers/gpu/drm/v3d/v3d_submit.c                                                 |    6 
 drivers/gpu/drm/xe/Makefile                                                      |   24 
 drivers/gpu/drm/xe/display/intel_fbdev_fb.c                                      |    6 
 drivers/gpu/drm/xe/display/xe_hdcp_gsc.c                                         |    8 
 drivers/gpu/drm/xe/display/xe_plane_initial.c                                    |    6 
 drivers/gpu/drm/xe/xe_bo.c                                                       |    4 
 drivers/gpu/drm/xe/xe_device.c                                                   |    8 
 drivers/gpu/drm/xe/xe_device_types.h                                             |   17 
 drivers/gpu/drm/xe/xe_drm_client.c                                               |    9 
 drivers/gpu/drm/xe/xe_exec_queue.c                                               |    2 
 drivers/gpu/drm/xe/xe_exec_queue_types.h                                         |    6 
 drivers/gpu/drm/xe/xe_execlist.c                                                 |    3 
 drivers/gpu/drm/xe/xe_gpu_scheduler.c                                            |    5 
 drivers/gpu/drm/xe/xe_gpu_scheduler.h                                            |    2 
 drivers/gpu/drm/xe/xe_gt_pagefault.c                                             |   55 
 drivers/gpu/drm/xe/xe_gt_types.h                                                 |    9 
 drivers/gpu/drm/xe/xe_guc_pc.c                                                   |    2 
 drivers/gpu/drm/xe/xe_guc_submit.c                                               |   76 
 drivers/gpu/drm/xe/xe_guc_types.h                                                |    2 
 drivers/gpu/drm/xe/xe_lrc.c                                                      |   35 
 drivers/gpu/drm/xe/xe_oa.c                                                       |    9 
 drivers/gpu/drm/xe/xe_pci.c                                                      |    2 
 drivers/gpu/drm/xe/xe_preempt_fence.c                                            |   12 
 drivers/gpu/drm/xe/xe_vm.c                                                       |   32 
 drivers/gpu/drm/xe/xe_vram.c                                                     |    1 
 drivers/gpu/drm/xe/xe_wa_oob.rules                                               |    3 
 drivers/hid/bpf/hid_bpf_struct_ops.c                                             |   14 
 drivers/hid/hid-ids.h                                                            |   17 
 drivers/hid/hid-input.c                                                          |   37 
 drivers/hid/hid-multitouch.c                                                     |    6 
 drivers/hid/i2c-hid/i2c-hid-core.c                                               |   42 
 drivers/hwmon/nct6775-platform.c                                                 |    1 
 drivers/i2c/busses/i2c-designware-common.c                                       |   14 
 drivers/i2c/busses/i2c-designware-core.h                                         |    1 
 drivers/i2c/busses/i2c-designware-master.c                                       |   38 
 drivers/i2c/busses/i2c-qcom-geni.c                                               |    4 
 drivers/i2c/busses/i2c-stm32f7.c                                                 |    6 
 drivers/i2c/busses/i2c-synquacer.c                                               |    5 
 drivers/i2c/busses/i2c-xiic.c                                                    |   21 
 drivers/i2c/i2c-core-base.c                                                      |   28 
 drivers/i3c/master/svc-i3c-master.c                                              |    1 
 drivers/idle/intel_idle.c                                                        |   14 
 drivers/iio/magnetometer/ak8975.c                                                |   32 
 drivers/iio/pressure/bmp280-core.c                                               |    9 
 drivers/iio/pressure/bmp280-regmap.c                                             |   45 
 drivers/iio/pressure/bmp280.h                                                    |    1 
 drivers/infiniband/hw/mana/main.c                                                |    8 
 drivers/input/keyboard/adp5589-keys.c                                            |   22 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                                      |   37 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h                                      |    1 
 drivers/iommu/intel/dmar.c                                                       |   16 
 drivers/iommu/intel/iommu.c                                                      |    6 
 drivers/iommu/intel/pasid.c                                                      |   12 
 drivers/leds/leds-pca9532.c                                                      |    5 
 drivers/mailbox/Kconfig                                                          |    1 
 drivers/mailbox/bcm2835-mailbox.c                                                |    3 
 drivers/mailbox/rockchip-mailbox.c                                               |    2 
 drivers/media/common/videobuf2/videobuf2-core.c                                  |    7 
 drivers/media/i2c/ar0521.c                                                       |    5 
 drivers/media/i2c/imx335.c                                                       |    9 
 drivers/media/i2c/ov5675.c                                                       |   12 
 drivers/media/platform/qcom/camss/camss-video.c                                  |    6 
 drivers/media/platform/qcom/camss/camss.c                                        |    5 
 drivers/media/platform/qcom/venus/core.c                                         |    1 
 drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c                               |    5 
 drivers/memory/tegra/tegra186-emc.c                                              |    5 
 drivers/net/can/dev/netlink.c                                                    |  102 
 drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c                              |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c                                |    2 
 drivers/net/ethernet/freescale/fec.h                                             |    9 
 drivers/net/ethernet/freescale/fec_main.c                                        |   11 
 drivers/net/ethernet/freescale/fec_ptp.c                                         |   50 
 drivers/net/ethernet/hisilicon/hip04_eth.c                                       |    1 
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c                                |    1 
 drivers/net/ethernet/hisilicon/hns_mdio.c                                        |    1 
 drivers/net/ethernet/intel/e1000e/netdev.c                                       |   19 
 drivers/net/ethernet/intel/ice/ice_sched.c                                       |    6 
 drivers/net/ethernet/lantiq_etop.c                                               |    4 
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h                                       |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en.h                                     |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/tir.c                                 |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c                         |    8 
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c                                  |    1 
 drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c                            |   10 
 drivers/net/ethernet/microchip/sparx5/sparx5_packet.c                            |    6 
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c                              |    5 
 drivers/net/ethernet/realtek/r8169_main.c                                        |   31 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c                                |   18 
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c                                  |    1 
 drivers/net/ieee802154/Kconfig                                                   |    1 
 drivers/net/ieee802154/mcr20a.c                                                  |    5 
 drivers/net/pcs/pcs-xpcs-wx.c                                                    |    2 
 drivers/net/phy/phy.c                                                            |   17 
 drivers/net/phy/realtek.c                                                        |    3 
 drivers/net/ppp/ppp_generic.c                                                    |    4 
 drivers/net/vrf.c                                                                |    2 
 drivers/net/wireless/ath/ath11k/dp_rx.c                                          |    2 
 drivers/net/wireless/ath/ath12k/dp_rx.c                                          |    2 
 drivers/net/wireless/ath/ath9k/debug.c                                           |    4 
 drivers/net/wireless/ath/ath9k/hif_usb.c                                         |    6 
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c                                     |    5 
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h                                 |   13 
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h                               |    2 
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c                                     |    2 
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h                                     |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c                                |   16 
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c                                 |   12 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c                                    |   42 
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c                                      |   12 
 drivers/net/wireless/marvell/mwifiex/fw.h                                        |    2 
 drivers/net/wireless/marvell/mwifiex/scan.c                                      |    3 
 drivers/net/wireless/mediatek/mt76/mt7915/init.c                                 |    1 
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c                                  |    4 
 drivers/net/wireless/mediatek/mt76/mt7915/main.c                                 |    7 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                                  |   10 
 drivers/net/wireless/microchip/wilc1000/sdio.c                                   |    7 
 drivers/net/wireless/realtek/rtw88/Kconfig                                       |    1 
 drivers/net/wireless/realtek/rtw89/core.h                                        |   18 
 drivers/net/wireless/realtek/rtw89/mac.c                                         |    2 
 drivers/net/wireless/realtek/rtw89/mac80211.c                                    |    4 
 drivers/net/wireless/realtek/rtw89/phy.c                                         |    4 
 drivers/net/wireless/realtek/rtw89/util.h                                        |   18 
 drivers/net/wwan/qcom_bam_dmux.c                                                 |   11 
 drivers/net/xen-netback/hash.c                                                   |    5 
 drivers/nvme/common/keyring.c                                                    |   58 
 drivers/nvme/host/Kconfig                                                        |    3 
 drivers/nvme/host/core.c                                                         |    1 
 drivers/nvme/host/fabrics.c                                                      |    2 
 drivers/nvme/host/ioctl.c                                                        |   22 
 drivers/nvme/host/nvme.h                                                         |    2 
 drivers/nvme/host/sysfs.c                                                        |    4 
 drivers/nvme/host/tcp.c                                                          |   55 
 drivers/of/address.c                                                             |    5 
 drivers/of/irq.c                                                                 |   38 
 drivers/perf/arm_spe_pmu.c                                                       |    9 
 drivers/perf/riscv_pmu_legacy.c                                                  |    4 
 drivers/perf/riscv_pmu_sbi.c                                                     |    4 
 drivers/platform/mellanox/mlxbf-pmc.c                                            |    5 
 drivers/platform/x86/amd/pmf/pmf-quirks.c                                        |    8 
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c                      |    4 
 drivers/platform/x86/lenovo-ymc.c                                                |    2 
 drivers/platform/x86/touchscreen_dmi.c                                           |   26 
 drivers/platform/x86/x86-android-tablets/core.c                                  |    6 
 drivers/platform/x86/x86-android-tablets/other.c                                 |   10 
 drivers/pmdomain/core.c                                                          |   40 
 drivers/power/reset/brcmstb-reboot.c                                             |    3 
 drivers/power/supply/power_supply_core.c                                         |    6 
 drivers/power/supply/power_supply_hwmon.c                                        |    3 
 drivers/remoteproc/ti_k3_r5_remoteproc.c                                         |   86 
 drivers/rtc/rtc-at91sam9.c                                                       |    1 
 drivers/scsi/NCR5380.c                                                           |    4 
 drivers/scsi/aacraid/aacraid.h                                                   |    2 
 drivers/scsi/lpfc/lpfc.h                                                         |   12 
 drivers/scsi/lpfc/lpfc_els.c                                                     |   73 
 drivers/scsi/lpfc/lpfc_hbadisc.c                                                 |   14 
 drivers/scsi/lpfc/lpfc_nportdisc.c                                               |   22 
 drivers/scsi/lpfc/lpfc_scsi.c                                                    |   13 
 drivers/scsi/lpfc/lpfc_sli.c                                                     |   11 
 drivers/scsi/pm8001/pm8001_init.c                                                |    6 
 drivers/scsi/smartpqi/smartpqi_init.c                                            |  130 
 drivers/scsi/st.c                                                                |    5 
 drivers/spi/spi-bcm63xx.c                                                        |    9 
 drivers/spi/spi-cadence.c                                                        |    8 
 drivers/spi/spi-imx.c                                                            |    2 
 drivers/spi/spi-rpc-if.c                                                         |    7 
 drivers/spi/spi-s3c64xx.c                                                        |    4 
 drivers/vhost/scsi.c                                                             |   27 
 drivers/video/fbdev/efifb.c                                                      |   11 
 drivers/video/fbdev/pxafb.c                                                      |    1 
 drivers/virt/coco/sev-guest/sev-guest.c                                          |    2 
 fs/afs/file.c                                                                    |    1 
 fs/afs/fs_operation.c                                                            |    2 
 fs/btrfs/backref.c                                                               |   12 
 fs/btrfs/disk-io.c                                                               |   11 
 fs/btrfs/relocation.c                                                            |   99 
 fs/btrfs/send.c                                                                  |   31 
 fs/cachefiles/namei.c                                                            |    7 
 fs/ceph/addr.c                                                                   |    6 
 fs/ceph/mds_client.c                                                             |   12 
 fs/dax.c                                                                         |    6 
 fs/exec.c                                                                        |   34 
 fs/exfat/balloc.c                                                                |   10 
 fs/ext4/dir.c                                                                    |   14 
 fs/ext4/ext4.h                                                                   |    1 
 fs/ext4/extents.c                                                                |   55 
 fs/ext4/fast_commit.c                                                            |   49 
 fs/ext4/file.c                                                                   |    8 
 fs/ext4/inode.c                                                                  |   11 
 fs/ext4/migrate.c                                                                |    2 
 fs/ext4/move_extent.c                                                            |    1 
 fs/ext4/namei.c                                                                  |   14 
 fs/ext4/resize.c                                                                 |   18 
 fs/ext4/super.c                                                                  |   25 
 fs/ext4/xattr.c                                                                  |    3 
 fs/f2fs/f2fs.h                                                                   |   31 
 fs/f2fs/gc.c                                                                     |   85 
 fs/f2fs/gc.h                                                                     |   23 
 fs/f2fs/segment.c                                                                |   31 
 fs/f2fs/super.c                                                                  |    8 
 fs/f2fs/sysfs.c                                                                  |   18 
 fs/file.c                                                                        |   95 
 fs/gfs2/glock.c                                                                  |    1 
 fs/gfs2/ops_fstype.c                                                             |    3 
 fs/inode.c                                                                       |   14 
 fs/iomap/buffered-io.c                                                           |   16 
 fs/jbd2/checkpoint.c                                                             |   21 
 fs/jbd2/journal.c                                                                |    4 
 fs/jfs/jfs_discard.c                                                             |   11 
 fs/jfs/jfs_dmap.c                                                                |    7 
 fs/jfs/xattr.c                                                                   |    2 
 fs/netfs/write_issue.c                                                           |   48 
 fs/nfsd/netns.h                                                                  |    1 
 fs/nfsd/nfs4proc.c                                                               |   34 
 fs/nfsd/nfs4state.c                                                              |    6 
 fs/nfsd/nfs4xdr.c                                                                |   10 
 fs/nfsd/nfsctl.c                                                                 |    2 
 fs/nfsd/nfssvc.c                                                                 |    2 
 fs/nfsd/vfs.c                                                                    |    1 
 fs/nfsd/xdr4.h                                                                   |    1 
 fs/ocfs2/aops.c                                                                  |    5 
 fs/ocfs2/buffer_head_io.c                                                        |    4 
 fs/ocfs2/journal.c                                                               |    7 
 fs/ocfs2/localalloc.c                                                            |   19 
 fs/ocfs2/quota_local.c                                                           |    8 
 fs/ocfs2/refcounttree.c                                                          |   26 
 fs/ocfs2/xattr.c                                                                 |   11 
 fs/overlayfs/copy_up.c                                                           |   43 
 fs/overlayfs/params.c                                                            |   38 
 fs/pidfs.c                                                                       |    5 
 fs/proc/base.c                                                                   |   61 
 fs/proc/proc_sysctl.c                                                            |   11 
 fs/smb/client/cifsfs.c                                                           |   13 
 fs/smb/client/cifsglob.h                                                         |    2 
 fs/smb/client/inode.c                                                            |   19 
 fs/smb/client/reparse.c                                                          |   16 
 fs/smb/client/smb1ops.c                                                          |    2 
 fs/smb/client/smb2inode.c                                                        |   24 
 fs/smb/client/smb2ops.c                                                          |   19 
 fs/smb/server/connection.c                                                       |    4 
 fs/smb/server/connection.h                                                       |    1 
 fs/smb/server/oplock.c                                                           |   55 
 fs/smb/server/smb2pdu.c                                                          |    5 
 fs/smb/server/vfs_cache.c                                                        |    3 
 fs/smb/server/vfs_cache.h                                                        |    4 
 include/crypto/internal/simd.h                                                   |   12 
 include/drm/drm_print.h                                                          |   54 
 include/drm/gpu_scheduler.h                                                      |    2 
 include/dt-bindings/clock/exynos7885.h                                           |    2 
 include/dt-bindings/clock/qcom,gcc-sc8180x.h                                     |    1 
 include/linux/cpufreq.h                                                          |    6 
 include/linux/fdtable.h                                                          |    8 
 include/linux/hdmi.h                                                             |    9 
 include/linux/hugetlb.h                                                          |   10 
 include/linux/i2c.h                                                              |    3 
 include/linux/netdevice.h                                                        |   22 
 include/linux/nvme-keyring.h                                                     |    6 
 include/linux/perf_event.h                                                       |    8 
 include/linux/sched.h                                                            |    2 
 include/linux/sunrpc/svc.h                                                       |    4 
 include/linux/uprobes.h                                                          |    2 
 include/linux/virtio_net.h                                                       |    4 
 include/trace/events/netfs.h                                                     |    1 
 include/uapi/linux/cec.h                                                         |    6 
 include/uapi/linux/netfilter/nf_tables.h                                         |    2 
 io_uring/io_uring.c                                                              |    5 
 io_uring/net.c                                                                   |    4 
 kernel/bpf/verifier.c                                                            |  119 
 kernel/events/core.c                                                             |   33 
 kernel/events/uprobes.c                                                          |    4 
 kernel/fork.c                                                                    |   32 
 kernel/jump_label.c                                                              |   34 
 kernel/rcu/rcuscale.c                                                            |    4 
 kernel/rcu/tasks.h                                                               |   82 
 kernel/resource.c                                                                |   58 
 kernel/sched/core.c                                                              |   23 
 kernel/sched/psi.c                                                               |   26 
 kernel/static_call_inline.c                                                      |   13 
 kernel/trace/trace_hwlat.c                                                       |    2 
 kernel/trace/trace_osnoise.c                                                     |   22 
 lib/buildid.c                                                                    |   76 
 mm/Kconfig                                                                       |   25 
 mm/filemap.c                                                                     |    4 
 mm/gup.c                                                                         |    1 
 mm/hugetlb.c                                                                     |   17 
 mm/memfd.c                                                                       |   18 
 mm/slab_common.c                                                                 |    7 
 mm/slub.c                                                                        |  100 
 net/bluetooth/hci_core.c                                                         |    2 
 net/bluetooth/hci_event.c                                                        |   15 
 net/bluetooth/l2cap_core.c                                                       |    8 
 net/bluetooth/mgmt.c                                                             |   23 
 net/bridge/br_mdb.c                                                              |    2 
 net/core/dev.c                                                                   |   14 
 net/core/gro.c                                                                   |    9 
 net/core/net-sysfs.c                                                             |    6 
 net/core/netdev-genl.c                                                           |    8 
 net/core/netpoll.c                                                               |   15 
 net/core/skbuff.c                                                                |   15 
 net/dsa/dsa.c                                                                    |    7 
 net/ipv4/devinet.c                                                               |    6 
 net/ipv4/fib_frontend.c                                                          |    2 
 net/ipv4/ip_gre.c                                                                |    6 
 net/ipv4/netfilter/nf_dup_ipv4.c                                                 |    7 
 net/ipv4/tcp_ipv4.c                                                              |    3 
 net/ipv4/tcp_offload.c                                                           |   10 
 net/ipv4/udp_offload.c                                                           |   22 
 net/ipv6/netfilter/nf_dup_ipv6.c                                                 |    7 
 net/ipv6/tcpv6_offload.c                                                         |   10 
 net/l2tp/l2tp_core.c                                                             |   40 
 net/l2tp/l2tp_core.h                                                             |    4 
 net/l2tp/l2tp_netlink.c                                                          |    4 
 net/l2tp/l2tp_ppp.c                                                              |    3 
 net/mac80211/chan.c                                                              |    4 
 net/mac80211/mlme.c                                                              |    2 
 net/mac80211/scan.c                                                              |    2 
 net/mac80211/util.c                                                              |    4 
 net/mac802154/scan.c                                                             |    4 
 net/ncsi/ncsi-manage.c                                                           |    2 
 net/netfilter/nf_tables_api.c                                                    |    5 
 net/rxrpc/ar-internal.h                                                          |    2 
 net/rxrpc/io_thread.c                                                            |   10 
 net/rxrpc/local_object.c                                                         |    2 
 net/sched/sch_taprio.c                                                           |    4 
 net/sctp/socket.c                                                                |    4 
 net/sunrpc/svc.c                                                                 |   31 
 net/tipc/bearer.c                                                                |    8 
 net/wireless/nl80211.c                                                           |   15 
 rust/Makefile                                                                    |   22 
 rust/exports.c                                                                   |    1 
 rust/helpers.c                                                                   |  239 
 rust/helpers/blk.c                                                               |   14 
 rust/helpers/bug.c                                                               |    8 
 rust/helpers/build_assert.c                                                      |   25 
 rust/helpers/build_bug.c                                                         |    9 
 rust/helpers/err.c                                                               |   19 
 rust/helpers/helpers.c                                                           |   25 
 rust/helpers/kunit.c                                                             |    9 
 rust/helpers/mutex.c                                                             |   15 
 rust/helpers/page.c                                                              |   19 
 rust/helpers/refcount.c                                                          |   19 
 rust/helpers/signal.c                                                            |    9 
 rust/helpers/slab.c                                                              |    9 
 rust/helpers/spinlock.c                                                          |   24 
 rust/helpers/task.c                                                              |   19 
 rust/helpers/uaccess.c                                                           |   15 
 rust/helpers/wait.c                                                              |    9 
 rust/helpers/workqueue.c                                                         |   15 
 rust/kernel/sync/locked_by.rs                                                    |   18 
 scripts/gdb/linux/proc.py                                                        |    4 
 scripts/gdb/linux/rbtree.py                                                      |   12 
 scripts/gdb/linux/timerlist.py                                                   |   31 
 scripts/kconfig/parser.y                                                         |   10 
 scripts/kconfig/qconf.cc                                                         |    6 
 security/Kconfig                                                                 |   32 
 security/tomoyo/domain.c                                                         |    9 
 sound/core/control.c                                                             |   55 
 sound/core/control_compat.c                                                      |   45 
 sound/core/init.c                                                                |   14 
 sound/core/oss/mixer_oss.c                                                       |    4 
 sound/isa/gus/gus_pcm.c                                                          |    4 
 sound/pci/asihpi/hpimsgx.c                                                       |    2 
 sound/pci/hda/hda_controller.h                                                   |    2 
 sound/pci/hda/hda_generic.c                                                      |    4 
 sound/pci/hda/hda_intel.c                                                        |   10 
 sound/pci/hda/patch_conexant.c                                                   |   24 
 sound/pci/hda/patch_realtek.c                                                    |  156 
 sound/pci/hda/samsung_helper.c                                                   |  310 -
 sound/pci/rme9652/hdsp.c                                                         |    6 
 sound/pci/rme9652/hdspm.c                                                        |    6 
 sound/soc/atmel/mchp-pdmc.c                                                      |    3 
 sound/soc/codecs/wsa883x.c                                                       |   16 
 sound/soc/fsl/imx-card.c                                                         |    1 
 sound/soc/intel/boards/bytcht_cx2072x.c                                          |    4 
 sound/soc/intel/boards/bytcht_da7213.c                                           |    4 
 sound/soc/intel/boards/bytcht_es8316.c                                           |    2 
 sound/soc/intel/boards/bytcr_rt5640.c                                            |    2 
 sound/soc/intel/boards/bytcr_rt5651.c                                            |    2 
 sound/soc/intel/boards/cht_bsw_rt5645.c                                          |    4 
 sound/soc/intel/boards/cht_bsw_rt5672.c                                          |    4 
 sound/soc/intel/boards/sof_es8336.c                                              |    2 
 sound/soc/intel/boards/sof_wm8804.c                                              |    4 
 sound/soc/intel/common/soc-acpi-intel-rpl-match.c                                |    1 
 sound/soc/soc-topology.c                                                         |    4 
 sound/usb/card.c                                                                 |    6 
 sound/usb/line6/podhd.c                                                          |    2 
 sound/usb/mixer.c                                                                |   35 
 sound/usb/mixer.h                                                                |    1 
 sound/usb/mixer_quirks.c                                                         |  413 +
 sound/usb/quirks-table.h                                                         | 2457 +++-------
 sound/usb/quirks.c                                                               |   62 
 tools/arch/x86/kcpuid/kcpuid.c                                                   |   12 
 tools/bpf/bpftool/net.c                                                          |   11 
 tools/hv/hv_fcopy_uio_daemon.c                                                   |    7 
 tools/include/nolibc/arch-powerpc.h                                              |    2 
 tools/perf/util/hist.c                                                           |    7 
 tools/perf/util/machine.c                                                        |   17 
 tools/perf/util/setup.py                                                         |    4 
 tools/perf/util/thread.c                                                         |    4 
 tools/perf/util/thread.h                                                         |    1 
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c                            |    1 
 tools/testing/selftests/breakpoints/step_after_suspend_test.c                    |    5 
 tools/testing/selftests/devices/probe/test_discoverable_devices.py               |    4 
 tools/testing/selftests/hid/Makefile                                             |    2 
 tools/testing/selftests/mm/charge_reserved_hugetlb.sh                            |    2 
 tools/testing/selftests/mm/pagemap_ioctl.c                                       |    2 
 tools/testing/selftests/mm/write_to_hugetlbfs.c                                  |   21 
 tools/testing/selftests/net/netfilter/conntrack_dump_flush.c                     |    1 
 tools/testing/selftests/net/netfilter/nft_audit.sh                               |   57 
 tools/testing/selftests/nolibc/nolibc-test.c                                     |    4 
 tools/testing/selftests/vDSO/parse_vdso.c                                        |   17 
 tools/testing/selftests/vDSO/vdso_config.h                                       |   10 
 tools/testing/selftests/vDSO/vdso_test_correctness.c                             |    6 
 tools/tracing/rtla/Makefile.rtla                                                 |    2 
 tools/tracing/rtla/src/osnoise_top.c                                             |    2 
 tools/tracing/rtla/src/timerlat_top.c                                            |    4 
 595 files changed, 7353 insertions(+), 5268 deletions(-)

Aakash Menon (1):
      net: sparx5: Fix invalid timestamps

Abhishek Tamboli (1):
      ALSA: hda/realtek: Add a quirk for HP Pavilion 15z-ec200

Adrian Ratiu (1):
      proc: add config & param to block forcing mem writes

Ahmed S. Darwish (1):
      tools/x86/kcpuid: Protect against faulty "max subleaf" values

Ahmed, Muhammad (1):
      drm/amd/display: guard write a 0 post_divider value to HW

Ai Chao (1):
      ALSA: hda/realtek: Add quirk for Huawei MateBook 13 KLV-WX9

Ajit Pandey (1):
      clk: qcom: clk-alpha-pll: Fix CAL_L_VAL override for LUCID EVO PLL

Al Viro (1):
      close_range(): fix the logics in descriptor table trimming

Aleksander Jan Bajkowski (1):
      net: ethernet: lantiq_etop: fix memory disclosure

Aleksandr Mishin (1):
      ice: Adjust over allocation of memory in ice_sched_add_root_node() and ice_sched_add_node()

Aleksandrs Vinarskis (1):
      ACPICA: iasl: handle empty connection_node

Alessandro Zanni (1):
      kselftest/devices/probe: Fix SyntaxWarning in regex strings for Python3

Alex Deucher (7):
      drm/amdgpu/gfx12: properly handle error ints on all pipes
      drm/amdgpu/gfx9: properly handle error ints on all pipes
      drm/amdgpu/gfx9: use rlc safe mode for soft recovery
      drm/amdgpu/gfx11: enter safe mode before touching CP_INT_CNTL
      drm/amdgpu/gfx12: use rlc safe mode for soft recovery
      drm/amdgpu/gfx11: use rlc safe mode for soft recovery
      drm/amdgpu/gfx10: use rlc safe mode for soft recovery

Alex Hung (15):
      drm/amd/display: Pass non-null to dcn20_validate_apply_pipe_split_flags
      drm/amd/display: Check null pointers before using them
      drm/amd/display: Check null pointers before used
      drm/amd/display: Check null pointers before multiple uses
      drm/amd/display: Check null pointers before using dc->clk_mgr
      drm/amd/display: Initialize denominators' default to 1
      drm/amd/display: Check null-initialized variables
      drm/amd/display: Check phantom_stream before it is used
      drm/amd/display: Check stream before comparing them
      drm/amd/display: Increase array size of dummy_boolean
      drm/amd/display: Fix possible overflow in integer multiplication
      drm/amd/display: Check stream_status before it is used
      drm/amd/display: Avoid overflow assignment in link_dp_cts
      drm/amd/display: Initialize get_bytes_per_element's default to 1
      drm/amd/display: Add HDR workaround for specific eDP

Alexander F. Lent (1):
      accel/ivpu: Add missing MODULE_FIRMWARE metadata

Alexander Shiyan (1):
      media: i2c: ar0521: Use cansleep version of gpiod_set_value()

Alexandre Ghiti (1):
      riscv: Fix kernel stack size when KASAN is enabled

Alexey Dobriyan (1):
      block: fix integer overflow in BLKSECDISCARD

Alice Ryhl (1):
      rust: sync: require `T: Sync` for `LockedBy::access`

Amir Goldstein (1):
      ovl: fsync after metadata copy-up

Anastasia Belova (1):
      cpufreq: amd-pstate: add check for cpufreq_cpu_get's return value

Andreas Hindborg (1):
      rust: kbuild: split up helpers.c

Andrei Simion (1):
      ASoC: atmel: mchp-pdmc: Skip ALSA restoration if substream runtime is uninitialized

Andrew Davis (1):
      power: reset: brcmstb: Do not go into infinite loop if reset fails

Andrew Jones (1):
      of/irq: Support #msi-cells=<0> in of_msi_get_domain

Andrii Nakryiko (2):
      perf,x86: avoid missing caller address in stack traces captured in uprobe
      lib/buildid: harden build ID parsing logic

Anjaneyulu (1):
      wifi: iwlwifi: allow only CN mcc from WRDD

Anton Danilov (1):
      ipv4: ip_gre: Fix drops of small packets in ipgre_xmit

Ard Biesheuvel (1):
      i2c: synquacer: Deal with optional PCLK correctly

Armin Wolf (4):
      ACPICA: Fix memory leak if acpi_ps_get_next_namepath() fails
      ACPICA: Fix memory leak if acpi_ps_get_next_field() fails
      ACPI: battery: Simplify battery hook locking
      ACPI: battery: Fix possible crash when unregistering a battery hook

Arnaldo Carvalho de Melo (2):
      perf python: Disable -Wno-cast-function-type-mismatch if present on clang
      perf python: Allow checking for the existence of warning options in clang

Arnd Bergmann (1):
      nvme-tcp: fix link failure for TCP auth

Artem Sadovnikov (1):
      ext4: fix i_data_sem unlock order in ext4_ind_migrate()

Arun R Murthy (1):
      drm/i915/display: BMG supports UHBR13.5

Aruna Ramakrishna (2):
      x86/pkeys: Add PKRU as a parameter in signal handling functions
      x86/pkeys: Restore altstack access in sigreturn()

Asad Kamal (1):
      drm/amdgpu: Fix get each xcp macro

Asahi Lina (1):
      ALSA: usb-audio: Add mixer quirk for RME Digiface USB

Aurabindo Pillai (1):
      drm/amd/display: fix a UBSAN warning in DML2.1

Austin Zheng (1):
      drm/amd/display: Unlock Pipes Based On DET Allocation

Baojun Xu (1):
      ALSA: hda/tas2781: Add new quirk for Lenovo Y990 Laptop

Baokun Li (10):
      ext4: avoid use-after-free in ext4_ext_show_leaf()
      ext4: fix slab-use-after-free in ext4_split_extent_at()
      ext4: propagate errors from ext4_find_extent() in ext4_insert_range()
      ext4: drop ppath from ext4_ext_replay_update_ex() to avoid double-free
      ext4: aovid use-after-free in ext4_ext_insert_extent()
      ext4: fix double brelse() the buffer of the extents path
      ext4: update orig_path in ext4_find_extent()
      ext4: fix off by one issue in alloc_flex_gd()
      jbd2: stop waiting for space when jbd2_cleanup_journal_tail() returns error
      cachefiles: fix dentry leak in cachefiles_open_file()

Bard Liao (1):
      ASoC: Intel: soc-acpi-intel-rpl-match: add missing empty item

Barnabás Czémán (1):
      iio: magnetometer: ak8975: Fix reading for ak099xx sensors

Bastien Curutchet (1):
      leds: pca9532: Remove irrelevant blink configuration error message

Beleswar Padhi (1):
      remoteproc: k3-r5: Acquire mailbox handle during probe routine

Ben Cheatham (1):
      EINJ, CXL: Fix CXL device SBDF calculation

Ben Dooks (1):
      spi: s3c64xx: fix timeout counters in flush_fifo

Ben Hutchings (1):
      tools/rtla: Fix installation from out-of-tree build

Benjamin Lin (1):
      wifi: mt76: mt7915: add dummy HW offload of IEEE 802.11 fragmentation

Benjamin Tissoires (1):
      HID: bpf: fix cfi stubs for hid_bpf_ops

Biju Das (1):
      spi: rpc-if: Add missing MODULE_DEVICE_TABLE

Boris Brezillon (4):
      drm/panthor: Lock the VM resv before calling drm_gpuvm_bo_obtain_prealloc()
      drm/panthor: Don't add write fences to the shared BOs
      drm/panthor: Fix access to uninitialized variable in tick_ctx_cleanup()
      drm/panthor: Don't declare a queue blocked if deferred operations are pending

Breno Leitao (1):
      netpoll: Ensure clean state on setup failures

Bryan O'Donoghue (3):
      media: ov5675: Fix power on/off delay timings
      media: qcom: camss: Remove use_count guard in stop_streaming
      media: qcom: camss: Fix ordering of pm_runtime_enable

Chao Yu (1):
      f2fs: fix to don't panic system for no free segment fault injection

Charlene Liu (1):
      drm/amd/display: avoid set dispclk to 0

Chih-Kang Chang (1):
      wifi: rtw89: avoid to add interface to list twice when SER

Chris Park (1):
      drm/amd/display: Deallocate DML memory if allocation fails

Christian Brauner (1):
      pidfs: check for valid pid namespace

Christian König (1):
      drm/sched: revert "Always increment correct scheduler score"

Christoph Hellwig (1):
      iomap: handle a post-direct I/O invalidate race in iomap_write_delalloc_release

Christophe JAILLET (2):
      ALSA: mixer_oss: Remove some incorrect kfree_const() usages
      ALSA: gus: Fix some error handling paths related to get_bpos() usage

Christophe Leroy (4):
      selftests: vDSO: fix vDSO name for powerpc
      selftests: vDSO: fix vdso_config for powerpc
      selftests: vDSO: fix vDSO symbols lookup for powerpc64
      powerpc/vdso: Fix VDSO data access when running in a non-root time namespace

Chuck Lever (3):
      NFSD: Fix NFSv4's PUTPUBFH operation
      NFSD: Async COPY result needs to return a write verifier
      NFSD: Limit the number of concurrent async COPY operations

Chun-Yi Lee (1):
      aoe: fix the potential use-after-free problem in more places

Ckath (1):
      platform/x86: touchscreen_dmi: add nanote-next quirk

Colin Ian King (1):
      r8169: Fix spelling mistake: "tx_underun" -> "tx_underrun"

Csókás, Bence (2):
      net: fec: Restart PPS after link state change
      net: fec: Reload PTP registers after link-state change

Cyan Nyan (1):
      ALSA: usb-audio: Add quirk for RME Digiface USB

Daeho Jeong (5):
      f2fs: make BG GC more aggressive for zoned devices
      f2fs: introduce migration_window_granularity
      f2fs: increase BG GC migration window granularity when boosted for zoned devices
      f2fs: do FG_GC when GC boosting is required for zoned devices
      f2fs: forcibly migrate to secure space for zoned device file pinning

Damien Le Moal (2):
      ata: pata_serverworks: Do not use the term blacklist
      ata: sata_sil: Rename sil_blacklist to sil_quirks

Daniel Borkmann (2):
      net: Add netif_get_gro_max_size helper for GRO
      net: Fix gso_features_check to check for both dev->gso_{ipv4_,}max_size

Daniel Bristot de Oliveira (1):
      sched/deadline: Comment sched_dl_entity::dl_server variable

Daniel Sa (1):
      drm/amd/display: Underflow Seen on DCN401 eGPU

Daniel Sneddon (1):
      x86/bugs: Add missing NO_SSB flag

Daniel Wagner (1):
      scsi: pm8001: Do not overwrite PCI queue mapping

Danilo Krummrich (1):
      mm: krealloc: consider spare memory for __GFP_ZERO

Darrick J. Wong (1):
      iomap: constrain the file range passed to iomap_file_unshare

David Hildenbrand (1):
      selftests/mm: fix charge_reserved_hugetlb.sh test

David Howells (5):
      afs: Fix missing wire-up of afs_retry_request()
      afs: Fix the setting of the server responding flag
      netfs: Fix missing wakeup after issuing writes
      netfs: Cancel dirty folios that have no storage destination
      rxrpc: Fix a race between socket set up and I/O thread creation

David Kaplan (1):
      x86/bugs: Fix handling when SRSO mitigation is disabled

David Strahan (2):
      scsi: smartpqi: Add new controller PCI IDs
      scsi: smartpqi: add new controller PCI IDs

David Virag (2):
      dt-bindings: clock: exynos7885: Fix duplicated binding
      clk: samsung: exynos7885: Update CLKS_NR_FSYS after bindings fix

Denis Pauk (1):
      hwmon: (nct6775) add G15CF to ASUS WMI monitoring list

Derek Foreman (1):
      drm/connector: hdmi: Fix writing Dynamic Range Mastering infoframes

Dillon Varone (1):
      drm/amd/display: Force enable 3DLUT DMA check for dcn401 in DML

Dirk Behme (1):
      rust: mutex: fix __mutex_init() usage in case of PREEMPT_RT

Dmitry Antipov (1):
      net: sched: consistently use rcu_replace_pointer() in taprio_change()

Dmitry Baryshkov (1):
      clk: qcom: dispcc-sm8250: use CLK_SET_RATE_PARENT for branch clocks

Dmitry Kandybka (1):
      wifi: ath9k: fix possible integer overflow in ath9k_get_et_stats()

Dmitry Torokhov (1):
      HID: i2c-hid: ensure various commands do not interfere with each other

Dragos Tatulea (1):
      net/mlx5e: SHAMPO, Fix overflow of hd_per_wq

Easwar Hariharan (1):
      arm64: Subscribe Microsoft Azure Cobalt 100 to erratum 3194386

Eddie James (1):
      net/ncsi: Disable the ncsi work before freeing the associated structure

Eder Zulian (1):
      rtla: Fix the help text in osnoise and timerlat top tools

Edward Adam Davis (3):
      jfs: Fix uaf in dbFreeBits
      jfs: check if leafidx greater than num leaves per dmap tree
      ext4: no need to continue when the number of entries is 1

Elena Salomatkina (1):
      net/mlx5e: Fix NULL deref in mlx5e_tir_builder_alloc()

Emanuele Ghidoli (1):
      gpio: davinci: fix lazy disable

Eric Dumazet (5):
      netfilter: nf_tables: prevent nf_skb_duplicated corruption
      net: avoid potential underflow in qdisc_pkt_len_init() with UFO
      net: add more sanity checks to qdisc_pkt_len_init()
      net: test for not too small csum_start in virtio_net_hdr_to_skb()
      ppp: do not assume bh is held in ppp_channel_bridge_input()

Fangrui Song (1):
      crypto: x86/sha256 - Add parentheses around macros' single arguments

Fangzhi Zuo (1):
      drm/amd/display: Restore Optimized pbn Value if Failed to Disable DSC

Fares Mehanna (1):
      arm64: trans_pgd: mark PTEs entries as valid to avoid dead kexec()

Felix Fietkau (3):
      wifi: mt76: mt7915: disable tx worker during tx BA session enable/disable
      wifi: mt76: mt7915: hold dev->mt76.mutex while disabling tx worker
      net: gso: fix tcp fraglist segmentation after pull from frag_list

Filipe Manana (3):
      btrfs: send: fix buffer overflow detection when copying path to cache entry
      btrfs: send: fix invalid clone operation for file that got its size decreased
      btrfs: wait for fixup workers before stopping cleaner kthread during umount

Finn Thain (1):
      scsi: NCR5380: Initialize buffer for MSG IN and STATUS transfers

Gabe Teeger (1):
      drm/amd/display: Revert Avoid overflow assignment

Gabriel Krisman Bertazi (1):
      ext4: fix error message when rejecting the default hash

Gary Guo (1):
      rust: kbuild: auto generate helper exports

Gautham Ananthakrishna (1):
      ocfs2: reserve space for inline xattr before attaching reflink tree

Geert Uytterhoeven (4):
      mailbox: ARM_MHU_V3 should depend on ARM64
      drm/radeon/r100: Handle unknown family in r100_cp_init_microcode()
      of/irq: Refer to actual buffer size in of_irq_parse_one()
      pmdomain: core: Reduce debug summary table width

Gerd Bayer (1):
      net/mlx5: Fix error path in multi-packet WQE transmit

Gergo Koteles (1):
      platform/x86: lenovo-ymc: Ignore the 0x0 state

Greg Kroah-Hartman (1):
      Linux 6.11.3

Guixin Liu (1):
      io_uring: fix memory leak when cache init fail

Gustavo A. R. Silva (1):
      wifi: mwifiex: Fix memcpy() field-spanning write warning in mwifiex_cmd_802_11_scan_ext()

Hannes Reinecke (3):
      nvme-keyring: restrict match length for version '1' identifiers
      nvme-tcp: sanitize TLS key handling
      nvme-tcp: check for invalidated or revoked key

Hans P. Moller (1):
      ALSA: line6: add hw monitor volume control to POD HD500X

Hans Verkuil (1):
      media: uapi/linux/cec.h: cec_msg_set_reply_to: zero flags

Hans de Goede (11):
      ACPI: video: Add force_vendor quirk for Panasonic Toughbook CF-18
      HID: Ignore battery for all ELAN I2C-HID devices
      platform/x86: x86-android-tablets: Adjust Xiaomi Pad 2 bottom bezel touch buttons LED
      platform/x86: x86-android-tablets: Fix use after free on platform_device_register() errors
      power: supply: hwmon: Fix missing temp1_max_alarm attribute
      power: supply: Drop use_cnt check from power_supply_property_is_writeable()
      ACPI: video: Add backlight=native quirk for Dell OptiPlex 5480 AIO
      ACPI: resource: Remove duplicate Asus E1504GAB IRQ override
      ACPI: resource: Loosen the Asus E1404GAB DMI match to also cover the E1404GA
      ACPI: resource: Add Asus Vivobook X1704VAP to irq1_level_low_skip_override[]
      ACPI: resource: Add Asus ExpertBook B2502CVA to irq1_level_low_skip_override[]

Haoran Zhang (1):
      vhost/scsi: null-ptr-dereference in vhost_scsi_get_req()

Haren Myneni (1):
      powerpc/pseries: Use correct data types from pseries_hp_errorlog struct

Hawking Zhang (1):
      drm/amdkfd: Check int source id for utcl2 poison event

Heiko Carstens (1):
      selftests: vDSO: fix vdso_config for s390

Heiner Kallweit (2):
      i2c: core: Lock address during client device instantiation
      r8169: add tally counter fields added with RTL8125

Helge Deller (4):
      parisc: Fix itlb miss handler for 64-bit programs
      parisc: Fix 64-bit userspace syscall path
      parisc: Allow mmap(MAP_STACK) memory to automatically expand upwards
      parisc: Fix stack start for ADDR_NO_RANDOMIZE personality

Heming Zhao (1):
      ocfs2: fix the la space leak when unmounting an ocfs2 volume

Herbert Xu (4):
      crypto: octeontx - Fix authenc setkey
      crypto: octeontx2 - Fix authenc setkey
      crypto: simd - Do not call crypto_alloc_tfm during registration
      crypto: octeontx* - Select CRYPTO_AUTHENC

Hilda Wu (2):
      Bluetooth: btusb: Add Realtek RTL8852C support ID 0x0489:0xe122
      Bluetooth: btrtl: Set msft ext address filter quirk for RTL8852B

Huacai Chen (1):
      cpufreq: loongson3: Use raw_smp_processor_id() in do_service_request()

Huang Ying (1):
      resource: fix region_intersects() vs add_memory_driver_managed()

Hui Wang (2):
      net: phy: realtek: Check the index value in led_hw_control_get
      ASoC: imx-card: Set card.owner to avoid a warning calltrace if SND=m

Ian Rogers (1):
      perf callchain: Fix stitch LBR memory leaks

Ido Schimmel (2):
      bridge: mcast: Fail MDB get request on empty entry
      ipv4: Mask upper DSCP bits and ECN bits in NETLINK_FIB_LOOKUP family

Ilan Peer (1):
      wifi: iwlwifi: mvm: Fix a race in scan abort flow

Imre Deak (1):
      drm/i915/dp: Fix AUX IO power enabling for eDP PSR

Issam Hamdi (1):
      wifi: cfg80211: Set correct chandef when starting CAC

Jakub Kicinski (1):
      net: skbuff: sprinkle more __GFP_NOWARN on ingress allocs

James Chapman (3):
      l2tp: prevent possible tunnel refcount underflow
      l2tp: free sessions using rcu
      l2tp: use rcu list add/del when updating lists

James Clark (1):
      drivers/perf: arm_spe: Use perf_allow_kernel() for permissions

Jan Kiszka (1):
      remoteproc: k3-r5: Fix error handling when power-up failed

Jan Lalinsky (1):
      ALSA: usb-audio: Add native DSD support for Luxman D-08u

Jani Nikula (1):
      drm/i915/gem: fix bitwise and logical AND mixup

Jaroslav Kysela (1):
      ALSA: core: add isascii() check to card ID generator

Jason Gunthorpe (1):
      iommu/arm-smmu-v3: Do not use devm for the cd table allocations

Jason Xing (1):
      tcp: avoid reusing FIN_WAIT2 when trying to find port in connect() process

Javier Carrasco (1):
      drm/mediatek: ovl_adaptor: Add missing of_node_put()

Jens Axboe (1):
      io_uring/net: harden multishot termination case for recv

Jens Remus (1):
      selftests: vDSO: fix ELF hash table entry size for s390x

Jeongjun Park (1):
      net/xen-netback: prevent UAF in xenvif_flush_hash()

Jesse Zhang (1):
      drm/amdkfd: Fix resource leak in criu restore queue

Jianbo Liu (1):
      net/mlx5e: Fix crash caused by calling __xfrm_state_delete() twice

Jiawei Ye (1):
      mac802154: Fix potential RCU dereference issue in mac802154_scan_worker

Jiawen Wu (1):
      net: pcs: xpcs: fix the wrong register that was written back

Jinjie Ruan (12):
      ieee802154: Fix build error
      net: ieee802154: mcr20a: Use IRQF_NO_AUTOEN flag in request_irq()
      net: wwan: qcom_bam_dmux: Fix missing pm_runtime_disable()
      Bluetooth: btmrvl: Use IRQF_NO_AUTOEN flag in request_irq()
      nfp: Use IRQF_NO_AUTOEN flag in request_irq()
      spi: spi-imx: Fix pm_runtime_set_suspended() with runtime pm enabled
      spi: spi-cadence: Fix pm_runtime_set_suspended() with runtime pm enabled
      spi: spi-cadence: Fix missing spi_controller_is_target() check
      i2c: qcom-geni: Use IRQF_NO_AUTOEN flag in request_irq()
      i2c: xiic: Fix pm_runtime_set_suspended() with runtime pm enabled
      spi: bcm63xx: Fix module autoloading
      spi: bcm63xx: Fix missing pm_runtime_disable()

Jiri Olsa (1):
      selftests/bpf: fix uprobe.path leak in bpf_testmod

Jisheng Zhang (1):
      riscv: define ILLEGAL_POINTER_VALUE for 64bit

Joe Damato (2):
      netdev-genl: Set extack and fix error on napi-get
      net: napi: Prevent overflow of napi_defer_hard_irqs

Joel Fernandes (Google) (1):
      sched/core: Add clearing of ->dl_server in put_prev_task_balance()

Johannes Berg (3):
      wifi: iwlwifi: mvm: drop wrong STA selection in TX
      wifi: iwlwifi: mvm: use correct key iteration
      wifi: mac80211: fix RCU list iterations

Johannes Thumshirn (1):
      btrfs: don't readahead the relocation inode on RST

Johannes Weiner (1):
      sched: psi: fix bogus pressure spikes from aggregation race

Jonathan Gray (1):
      Revert "drm/amd/display: Skip Recompute DSC Params if no Stream on Link"

Josef Bacik (1):
      btrfs: drop the backref cache during relocation if we commit

Joseph Qi (2):
      ocfs2: fix uninit-value in ocfs2_get_block()
      ocfs2: cancel dqi_sync_work before freeing oinfo

Joshua Grisham (1):
      ALSA: hda/realtek: Refactor and simplify Samsung Galaxy Book init

Joshua Pius (1):
      ALSA: usb-audio: Add logitech Audio profile quirk

José Roberto de Souza (1):
      drm/xe/oa: Don't reset OAC_CONTEXT_ENABLE on OA stream close

Jouni Högander (1):
      drm/i915/psr: Do not wait for PSR being idle on on Panel Replay

Julian Sun (2):
      ocfs2: fix null-ptr-deref when journal load failed.
      gfs2: fix double destroy_workqueue error

Juntong Deng (1):
      bpf: Make the pointer returned by iter next method valid

Justin Tee (3):
      scsi: lpfc: Validate hdwq pointers before dereferencing in reset/errata paths
      scsi: lpfc: Fix unsolicited FLOGI kref imbalance when in direct attached topology
      scsi: lpfc: Update PRLO handling in direct attached topology

Kai-Heng Feng (1):
      intel_idle: Disable promotion to C1E on Jasper Lake and Elkhart Lake

Kaixin Wang (2):
      fbdev: pxafb: Fix possible use after free in pxafb_task()
      i3c: master: svc: Fix use after free vulnerability in svc_i3c_master Driver Due to Race Condition

Karthikeyan Periyasamy (2):
      wifi: ath12k: fix array out-of-bound access in SoC stats
      wifi: ath11k: fix array out-of-bound access in SoC stats

Katya Orlova (1):
      drm/stm: Avoid use-after-free issues with crtc and plane

Kees Cook (2):
      x86/syscall: Avoid memcpy() for ia32 syscall_get_arguments()
      scsi: aacraid: Rearrange order of struct aac_srb_unit

Kemeng Shi (1):
      jbd2: correctly compare tids with tid_geq function in jbd2_fc_begin_commit

KhaiWenTan (1):
      net: stmmac: Fix zero-division error when disabling tc cbs

Kimriver Liu (1):
      i2c: designware: fix controller is holding SCL low while ENABLE bit is disabled

Konrad Dybcio (1):
      drm/msm/adreno: Assign msm_gpu->pdev earlier to avoid nullptrs

Konstantin Ovsepian (1):
      blk_iocost: fix more out of bound shifts

Krzysztof Kozlowski (7):
      net: hisilicon: hip04: fix OF node leak in probe()
      net: hisilicon: hns_dsaf_mac: fix OF node leak in hns_mac_get_info()
      net: hisilicon: hns_mdio: fix OF node leak in probe()
      ASoC: codecs: wsa883x: Handle reading version failure
      firmware: tegra: bpmp: Drop unused mbox_client_to_bpmp()
      memory: tegra186-emc: drop unused to_tegra186_emc()
      rtc: at91sam9: fix OF node leak in probe() error path

Kuan-Wei Chiu (2):
      bpftool: Fix undefined behavior caused by shifting into the sign bit
      bpftool: Fix undefined behavior in qsort(NULL, 0, ...)

Kuan-Ying Lee (3):
      scripts/gdb: fix timerlist parsing issue
      scripts/gdb: add iteration function for rbtree
      scripts/gdb: fix lx-mounts command error

Kuniyuki Iwashima (1):
      ipv4: Check !in_dev earlier for ioctl(SIOCSIFADDR).

Lad Prabhakar (1):
      gpiolib: Fix potential NULL pointer dereference in gpiod_get_label()

Laurent Pinchart (2):
      media: videobuf2: Drop minimum allocation requirement of 2 buffers
      media: sun4i_csi: Implement link validate for sun4i_csi subdev

Leo Li (1):
      drm/amd/display: Enable idle workqueue for more IPS modes

Li Lingfeng (1):
      nfsd: map the EBADMSG to nfserr_io to avoid warning

Li Zhijian (1):
      fs/inode: Prevent dump_mapping() accessing invalid dentry.d_name.name

Lianqin Hu (1):
      ALSA: usb-audio: Add delay quirk for VIVO USB-C HEADSET

Liao Chen (1):
      mailbox: rockchip: fix a typo in module autoloading

Liao Yuanhong (1):
      f2fs: add write priority option based on zone UFS

Lizhi Xu (3):
      ext4: filesystems without casefold feature cannot be mounted with siphash
      ocfs2: remove unreasonable unlock in ocfs2_read_blocks
      ocfs2: fix possible null-ptr-deref in ocfs2_set_buffer_uptodate

Long Li (2):
      RDMA/mana_ib: use the correct page table index based on hardware page size
      RDMA/mana_ib: use the correct page size for mapping user-mode doorbell page

Lu Baolu (2):
      iommu/vt-d: Always reserve a domain ID for identity setup
      iommu/vt-d: Unconditionally flush device TLB for pasid table updates

Lucas De Marchi (1):
      drm/xe: Generate oob before compiling anything

Luis Henriques (SUSE) (9):
      ceph: fix a memory leak on cap_auths in MDS client
      ext4: fix incorrect tid assumption in ext4_fc_mark_ineligible()
      ext4: fix incorrect tid assumption in __jbd2_log_wait_for_space()
      ext4: fix access to uninitialised lock in fc replay path
      ext4: fix incorrect tid assumption in ext4_wait_for_tail_page_commit()
      ext4: fix incorrect tid assumption in jbd2_journal_shrink_checkpoint_list()
      ext4: fix fast commit inode enqueueing during a full journal commit
      ext4: use handle to mark fc as ineligible in __track_dentry_update()
      ext4: mark fc as ineligible using an handle in ext4_xattr_set()

Luiz Augusto von Dentz (3):
      Bluetooth: MGMT: Fix possible crash on mgmt_index_removed
      Bluetooth: L2CAP: Fix uaf in l2cap_connect
      Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE

Luiz Capitulino (1):
      platform/mellanox: mlxbf-pmc: fix lockdep warning

Luo Gengkun (1):
      perf/core: Fix small negative period being ignored

Ma Ke (1):
      drm: omapdrm: Add missing check for alloc_ordered_workqueue

Mahesh Rajashekhara (1):
      scsi: smartpqi: correct stream detection

Manivannan Sadhasivam (2):
      clk: qcom: gcc-sm8450: Do not turn off PCIe GDSCs during gdsc_disable()
      clk: qcom: gcc-sm8250: Do not turn off PCIe GDSCs during gdsc_disable()

Marc Zyngier (1):
      KVM: arm64: Fix kvm_has_feat*() handling of negative features

Marek Vasut (2):
      wifi: wilc1000: Do not operate uninitialized hardware during suspend/resume
      i2c: stm32f7: Do not prepare/unprepare clock during runtime suspend/resume

Mario Limonciello (2):
      ACPI: CPPC: Add support for setting EPP register in FFH
      drm/amd/display: Allow backlight to go below `AMDGPU_DM_DEFAULT_MIN_BACKLIGHT`

Mark Rutland (3):
      arm64: fix selection of HAVE_DYNAMIC_FTRACE_WITH_ARGS
      arm64: cputype: Add Neoverse-N3 definitions
      arm64: errata: Expand speculative SSBS workaround once more

Masahiro Yamada (3):
      kconfig: fix infinite loop in sym_calc_choice()
      kconfig: qconf: move conf_read() before drawing tree pain
      kconfig: qconf: fix buffer overflow in debug links

Mateusz Guzik (2):
      exec: don't WARN for racy path_noexec check
      vfs: use RCU in ilookup

Matt Fleming (1):
      perf hist: Update hist symbol when updating maps

Matt Roper (1):
      drm/xe: Name and document Wa_14019789679

Matthew Auld (5):
      drm/xe/guc_submit: add missing locking in wedged_fini
      drm/xe: fixup xe_alloc_pf_queue
      drm/xe: fix UAF around queue destruction
      drm/xe/vm: move xa_alloc to prevent UAF
      drm/xe/vram: fix ccs offset calculation

Matthew Brost (5):
      drm/xe: Resume TDR after GT reset
      drm/xe: Add timeout to preempt fences
      drm/printer: Allow NULL data in devcoredump printer
      drm/xe: Drop warn on xe_guc_pc_gucrc_disable in guc pc fini
      drm/xe: Clean up VM / exec queue file lock usage.

Mike Baynton (1):
      ovl: fail if trusted xattrs are needed but caller lacks permission

Mike Tipton (1):
      clk: qcom: clk-rpmh: Fix overflow in BCM vote

Miquel Sabaté Solà (1):
      cpufreq: Avoid a bad reference count on CPU node

Miri Korenblit (1):
      wifi: iwlwifi: mvm: avoid NULL pointer dereference

Mohamed Khalfella (1):
      net/mlx5: Added cond_resched() to crdump collection

Mostafa Saleh (1):
      iommu/arm-smmu-v3: Match Stall behaviour for S2

Muhammad Usama Anjum (1):
      kselftests: mm: fix wrong __NR_userfaultfd value

Namhyung Kim (2):
      perf: Really fix event_function_call() locking
      perf report: Fix segfault when 'sym' sort key is not used

Namjae Jeon (2):
      ksmbd: fix warning: comparison of distinct pointer types lacks a cast
      ksmbd: add refcnt to ksmbd_conn struct

NeilBrown (2):
      nfsd: fix delegation_blocked() to block correctly for at least 30 seconds
      sunrpc: change sp_nrthreads from atomic_t to unsigned int.

Nicholas Kazlauskas (1):
      drm/amd/display: Use gpuvm_min_page_size_kbytes for DML2 surfaces

Niklas Söderlund (1):
      net: phy: Check for read errors in SIOCGMIIREG

Nikolai Afanasenkov (1):
      ALSA: hda/realtek: fix mute/micmute LED for HP mt645 G8

Nikunj A Dadhania (1):
      virt: sev-guest: Ensure the SNP guest messages do not exceed a page

Nirmoy Das (1):
      drm/xe: Fix memory leak on xe_alloc_pf_queue failure

Nuno Sa (2):
      Input: adp5589-keys - fix NULL pointer dereference
      Input: adp5589-keys - fix adp5589_gpio_get_value()

Oder Chiou (1):
      ALSA: hda/realtek: Fix the push button function for the ALC257

Oleg Nesterov (1):
      uprobes: fix kernel info leak via "[uprobes]" vma

Pablo Neira Ayuso (1):
      netfilter: nf_tables: do not remove elements if set backend implements .abort

Pali Rohár (3):
      cifs: Remove intermediate object of failed create reparse call
      cifs: Fix buffer overflow when parsing NFS reparse points
      cifs: Do not convert delimiter when parsing NFS-style symlinks

Patrick Donnelly (1):
      ceph: fix cap ref leak via netfs init_request

Paul E. McKenney (1):
      rcuscale: Provide clear error when async specified without primitives

Pei Xiao (1):
      ACPICA: check null return of ACPI_ALLOCATE_ZEROED() in acpi_db_convert_to_package()

Peng Fan (1):
      mm, slub: avoid zeroing kmalloc redzone

Peng Liu (2):
      drm/amdgpu: add raven1 gfxoff quirk
      drm/amdgpu: enable gfxoff quirk on HP 705G4

Peter Zijlstra (2):
      jump_label: Fix static_key_slow_dec() yet again
      perf: Fix event_function_call() locking

Phil Sutter (2):
      netfilter: uapi: NFTA_FLOWTABLE_HOOK is NLA_NESTED
      selftests: netfilter: Fix nft_audit.sh for newer nft binaries

Philip Yang (1):
      drm/amdkfd: amdkfd_free_gtt_mem clear the correct pointer

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: disallow multiple BO_HANDLES chunks in one submit

Pierre-Louis Bossart (1):
      ASoC: Intel: boards: always check the result of acpi_dev_get_first_match_dev()

Ping-Ke Shih (2):
      wifi: rtw89: 885xb: reset IDMEM mode to prevent download firmware failure
      wifi: rtw89: correct base HT rate mask for firmware

Pu Lehui (1):
      drivers/perf: riscv: Align errno for unsupported perf event

Puranjay Mohan (1):
      nvme: fix metadata handling in nvme-passthrough

Qu Wenruo (1):
      btrfs: fix a NULL pointer dereference when failed to start a new trasacntion

Rafael J. Wysocki (1):
      ACPI: EC: Do not release locks during operation region accesses

Rafael Rocha (1):
      scsi: st: Fix input/output error on empty drive reset

Ravikanth Tuniki (1):
      dt-bindings: net: xlnx,axi-ethernet: Add missing reg minItems

Remington Brasga (1):
      jfs: UBSAN: shift-out-of-bounds in dbFindBits

Rob Clark (1):
      drm/sched: Fix dynamic job-flow control race

Robert Hancock (1):
      i2c: xiic: Wait for TX empty to avoid missed TX NAKs

Rodrigo Siqueira (1):
      drm/amd/display: Check null pointer before try to access it

Rodrigo Vivi (1):
      drm/xe: Restore pci state upon resume

Sanjay K Kumar (1):
      iommu/vt-d: Fix potential lockup if qi_submit_sync called with 0 count

Satya Priya Kakitapalli (5):
      dt-bindings: clock: qcom: Add GPLL9 support on gcc-sc8180x
      clk: qcom: gcc-sc8180x: Register QUPv3 RCGs for DFS on sc8180x
      clk: qcom: gcc-sm8150: De-register gcc_cpuss_ahb_clk_src
      clk: qcom: gcc-sc8180x: Add GPLL9 support
      clk: qcom: gcc-sc8180x: Fix the sdcc2 and sdcc4 clocks freq table

Sebastian Reichel (1):
      clk: rockchip: fix error for unknown clocks

Seiji Nishikawa (1):
      ACPI: PAD: fix crash in exit_round_robin()

Shenwei Wang (1):
      net: stmmac: dwmac4: extend timeout for VLAN Tag register busy bit check

Simon Horman (4):
      tipc: guard against string buffer overrun
      net: mvpp2: Increase size of queue_name buffer
      bnxt_en: Extend maximum length of version string by 1 byte
      net: atlantic: Avoid warning about potential string truncation

Srinivasan Shanmugam (17):
      drm/amd/display: Add null check for head_pipe in dcn201_acquire_free_pipe_for_layer
      drm/amd/display: Add null check for head_pipe in dcn32_acquire_idle_pipe_for_head_pipe_in_layer
      drm/amd/display: Add NULL check for clk_mgr and clk_mgr->funcs in dcn30_init_hw
      drm/amd/display: Add NULL check for clk_mgr and clk_mgr->funcs in dcn401_init_hw
      drm/amd/display: Add NULL check for clk_mgr in dcn32_init_hw
      drm/amd/display: Add null check for pipe_ctx->plane_state in dcn20_program_pipe
      drm/amd/display: Add null check for top_pipe_to_program in commit_planes_for_stream
      drm/amd/display: Handle null 'stream_status' in 'planes_changed_for_existing_stream'
      drm/amd/display: Add NULL check for function pointer in dcn20_set_output_transfer_func
      drm/amd/display: Add NULL check for function pointer in dcn401_set_output_transfer_func
      drm/amd/display: Add NULL check for function pointer in dcn32_set_output_transfer_func
      drm/amd/display: Add null check for 'afb' in amdgpu_dm_update_cursor (v2)
      drm/amd/display: Add null check for 'afb' in amdgpu_dm_plane_handle_cursor_update (v2)
      drm/amd/display: Fix index out of bounds in DCN30 degamma hardware format translation
      drm/amd/display: Fix index out of bounds in degamma hardware format translation
      drm/amd/display: Implement bounds check for stream encoder creation in DCN401
      drm/amd/display: Fix index out of bounds in DCN30 color transformation

Stefan Mätje (1):
      can: netlink: avoid call to do_set_data_bittiming callback with stale can_priv::ctrlmode

Stefan Wahren (1):
      mailbox: bcm2835: Fix timeout during suspend mode

Steve French (1):
      smb3: fix incorrect mode displayed for read-only files

Steve Sistare (6):
      mm/filemap: fix filemap_get_folios_contig THP panic
      mm/hugetlb: fix memfd_pin_folios free_huge_pages leak
      mm/hugetlb: fix memfd_pin_folios resv_huge_pages leak
      mm/gup: fix memfd_pin_folios hugetlb page allocation
      mm/gup: fix memfd_pin_folios alloc race panic
      mm/hugetlb: simplify refs in memfd_alloc_folio

Steve Wahl (1):
      x86/mm/ident_map: Use gbpages only where full GB page should be mapped.

Steven Price (1):
      drm/panthor: Fix race when converting group handle to group object

Stuart Summers (1):
      drm/xe: Use topology to determine page fault queue size

Sunil Khatri (3):
      drm/amdgpu: fix ptr check warning in gfx9 ip_dump
      drm/amdgpu: fix ptr check warning in gfx10 ip_dump
      drm/amdgpu: fix ptr check warning in gfx11 ip_dump

Suraj Kandpal (1):
      drm/xe/hdcp: Check GSC structure validity

Takashi Iwai (11):
      ALSA: hda/generic: Unconditionally prefer preferred_dacs pairs
      ALSA: hda/conexant: Fix conflicting quirk for System76 Pangolin
      ALSA: usb-audio: Add input value sanity checks for standard types
      ALSA: usb-audio: Define macros for quirk table entries
      ALSA: usb-audio: Replace complex quirk lines with macros
      ALSA: control: Take power_ref lock primarily
      ALSA: asihpi: Fix potential OOB array access
      ALSA: hdsp: Break infinite MIDI input flush loop
      ALSA: control: Fix power_ref lock order for compat code, too
      Revert "ALSA: hda: Conditionally use snooping for AMD HDMI"
      ALSA: control: Fix leftover snd_power_unref()

Tamim Khan (1):
      ACPI: resource: Skip IRQ override on Asus Vivobook Go E1404GAB

Tang Bin (1):
      ASoC: topology: Fix incorrect addressing assignments

Tao Liu (1):
      x86/kexec: Add EFI config table identity mapping for kexec kernel

Tetsuo Handa (1):
      tomoyo: fallback to realpath if symlink's pathname does not exist

Thadeu Lima de Souza Cascardo (1):
      ext4: ext4_search_dir should return a proper error

Thomas Gleixner (4):
      static_call: Handle module init failure correctly in static_call_del_module()
      static_call: Replace pointless WARN_ON() in static_call_module_notify()
      x86/ioapic: Handle allocation failures gracefully
      x86/apic: Remove logical destination mode for 64-bit

Thomas Weißschuh (5):
      tools/nolibc: powerpc: limit stack-protector workaround to GCC
      selftests/nolibc: avoid passing NULL to printf("%s")
      fbdev: efifb: Register sysfs groups through driver core
      of: address: Report error on resource bounds overflow
      sysctl: avoid spurious permanent empty tables

Thomas Zimmermann (2):
      drm: Consistently use struct drm_mode_rect for FB_DAMAGE_CLIPS
      firmware/sysfb: Disable sysfb for firmware buffers with unknown parent

Tim Huang (4):
      drm/amd/display: fix double free issue during amdgpu module unload
      drm/amdgpu: fix unchecked return value warning for amdgpu_gfx
      drm/amdgpu: fix unchecked return value warning for amdgpu_atombios
      drm/amd/pm: ensure the fw_info is not null before using it

Tobias Jakobi (1):
      drm/amd/display: handle nulled pipe context in DCE110's set_drr()

Toke Høiland-Jørgensen (1):
      wifi: ath9k_htc: Use __skb_set_length() for resetting urb before resubmit

Tom Chung (4):
      drm/amd/display: Disable replay if VRR capability is false
      drm/amd/display: Fix VRR cannot enable
      drm/amd/display: Re-enable panel replay feature
      drm/amd/display: Fix system hang while resume with TBT monitor

Tvrtko Ursulin (4):
      drm/v3d: Prevent out of bounds access in performance query extensions
      drm/sched: Add locking to drm_sched_entity_modify_sched
      drm/sched: Always wake up correct scheduler in drm_sched_entity_push_job
      drm/sched: Always increment correct scheduler score

Udit Kumar (1):
      remoteproc: k3-r5: Delay notification of wakeup event

Ulf Hansson (2):
      pmdomain: core: Don't hold the genpd-lock when calling dev_pm_domain_set()
      pmdomain: core: Use dev_name() instead of kobject_get_path() in debugfs

Uma Shankar (1):
      drm/xe/fbdev: Limit the usage of stolen for LNL+

Umang Jain (1):
      media: imx335: Fix reset-gpio handling

Uwe Kleine-König (1):
      cpufreq: intel_pstate: Make hwp_notify_lock a raw spinlock

Val Packett (2):
      drm/rockchip: vop: clear DMA stop bit on RK3066
      drm/rockchip: vop: enable VOP_FEATURE_INTERNAL_RGB on RK3066

Vasileios Amoiridis (2):
      iio: pressure: bmp280: Fix regmap for BMP280 device
      iio: pressure: bmp280: Fix waiting time for BMP3xx configuration

Victor Skvortsov (1):
      drm/amdgpu: Block MMR_READ IOCTL in reset

Ville Syrjälä (1):
      drm/i915/dp: Fix colorimetry detection

Vishnu Sankar (1):
      HID: multitouch: Add support for Thinkpad X12 Gen 2 Kbd Portfolio

Vitaly Lifshits (1):
      e1000e: avoid failing the system during pm_suspend

Vladimir Oltean (1):
      net: dsa: improve shutdown sequence

Wei Li (4):
      tracing/hwlat: Fix a race during cpuhp processing
      tracing/timerlat: Drop interface_lock in stop_kthread()
      tracing/timerlat: Fix a race during cpuhp processing
      tracing/timerlat: Fix duplicated kthread creation due to CPU online/offline

Willem de Bruijn (2):
      vrf: revert "vrf: Remove unnecessary RCU-bh critical section"
      gso: fix udp gso fraglist segmentation after pull from frag_list

Xiaxi Shen (1):
      ext4: fix timer use-after-free on failed mount

Xin Long (1):
      sctp: set sk_state back to CLOSED if autobind fails in sctp_listen_start

Xiubo Li (1):
      ceph: remove the incorrect Fw reference check when dirtying pages

Yang Shen (1):
      crypto: hisilicon - fix missed error branch

Yang Wang (1):
      drm/amdgpu: add list empty check to avoid null pointer issue

Yannick Fertre (1):
      drm/stm: ltdc: reset plane transparency after plane disable

Yifei Liu (1):
      selftests: breakpoints: use remaining time to check if suspend succeed

Yihan Zhu (1):
      drm/amd/display: update DML2 policy EnhancedPrefetchScheduleAccelerationFinal DCN35

Yonghong Song (1):
      bpf: Fix a sdiv overflow issue

Yosry Ahmed (1):
      mm: z3fold: deprecate CONFIG_Z3FOLD

Youssef Esmat (1):
      sched/core: Clear prev->dl_server in CFS pick fast path

Yuezhang Mo (1):
      exfat: fix memory leak in exfat_load_bitmap()

Yun Lu (1):
      selftest: hid: add missing run-hid-tools-tests.sh

Zach Wade (1):
      platform/x86: ISST: Fix the KASAN report slab-out-of-bounds bug

Zhanjun Dong (1):
      drm/xe: Prevent null pointer access in xe_migrate_copy

Zhao Mengmeng (1):
      jfs: Fix uninit-value access of new_ea in ea_buffer

Zheng Wang (1):
      media: venus: fix use after free bug in venus_remove due to race condition

Zhihao Cheng (1):
      ext4: dax: fix overflowing extents beyond inode size when partially writing

Zhu Jun (1):
      tools/hv: Add memory allocation check in hv_fcopy_start

Zong-Zhe Yang (2):
      wifi: rtw88: select WANT_DEV_COREDUMP
      wifi: rtw89: avoid reading out of bounds when loading TX power FW elements

Zqiang (1):
      rcu-tasks: Fix access non-existent percpu rtpcp variable in rcu_tasks_need_gpcb()

aln8 (1):
      platform/x86/amd: pmf: Add quirk for TUF Gaming A14

wangrong (1):
      smb: client: use actual path when queryfs

yao.ly (1):
      ext4: correct encrypted dentry name hash when not casefolded

zhang jiao (1):
      selftests: netfilter: Add missing return value


