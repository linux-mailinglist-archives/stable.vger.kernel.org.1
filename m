Return-Path: <stable+bounces-50217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5004F904F7A
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 11:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8DAC289D79
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 09:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A1816DEDE;
	Wed, 12 Jun 2024 09:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ggQq4z+t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8054016DED0;
	Wed, 12 Jun 2024 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718185429; cv=none; b=UH6133u5thOW+zsAu0Qp/VhwfcCJYg3FJFFQweYVelT24b6SC0KMyzrSi/XGoPUs/DEOE8jWrqRd7K+0FWZGHc9rACh0q39SHPdGfo4zP5bbRC74uTLHcUJYP1yd9YiV1QOvwwyAe2oNUI2MTYPYulzl1Ye361ZMK7M6bB9h+D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718185429; c=relaxed/simple;
	bh=I6eZSxr1WKDa2V8jNYxsh03EJtN2KjtZwBwAyI+pMrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CLsyKJnc2ebFCCTTZ/QZ5LeF01tUbjzKmxGwSce9CD5ZkAyklYzUJdyWmn2a72i8ovb5hnL3Y4fD1IAyXGFlxXBf/8GxfxbBqI4PmffVpa8dLc7FFrEpMUGcyAuFTZ3SkIrIgT25D/MYYvdLP9AaPF/+mP9vLMjHPqh5ku7Qsz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ggQq4z+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB21C3277B;
	Wed, 12 Jun 2024 09:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718185429;
	bh=I6eZSxr1WKDa2V8jNYxsh03EJtN2KjtZwBwAyI+pMrM=;
	h=From:To:Cc:Subject:Date:From;
	b=ggQq4z+txxAZ9du6YdV3PvBNPmFNG35cx146hq2MD3oJITdUbyoRPbxOIHwKH3vX/
	 UyjAmN5yI/nto1HhAIkN8BJB7nuXmiey8uK5otBrBun8nkV4PnbAW+uIiklhpaPGQ/
	 tUTJUVgvEmAmWeiZ7LEWCSPmV8lHgr823zMrWA+I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.33
Date: Wed, 12 Jun 2024 11:43:43 +0200
Message-ID: <2024061242-unlovable-conjuror-89e5@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.33 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt                            |    3 
 Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml                 |   13 
 Documentation/devicetree/bindings/media/i2c/ovti,ov2680.yaml               |   18 
 Documentation/devicetree/bindings/pci/rcar-pci-host.yaml                   |   14 
 Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml            |    1 
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml       |   16 
 Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml          |    4 
 Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml     |   92 +-
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml                    |    1 
 Documentation/devicetree/bindings/sound/rt5645.txt                         |    6 
 Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml |    4 
 Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml       |   34 
 Documentation/driver-api/fpga/fpga-bridge.rst                              |    7 
 Documentation/driver-api/fpga/fpga-mgr.rst                                 |   34 
 Documentation/driver-api/fpga/fpga-region.rst                              |   13 
 Documentation/driver-api/pwm.rst                                           |    8 
 Documentation/filesystems/f2fs.rst                                         |    6 
 MAINTAINERS                                                                |   10 
 Makefile                                                                   |   11 
 arch/arm/Makefile                                                          |    7 
 arch/arm/configs/sunxi_defconfig                                           |    1 
 arch/arm/vdso/Makefile                                                     |   25 
 arch/arm64/Makefile                                                        |    9 
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi                                  |   13 
 arch/arm64/include/asm/asm-bug.h                                           |    1 
 arch/arm64/kernel/vdso/Makefile                                            |   10 
 arch/arm64/kernel/vdso32/Makefile                                          |   10 
 arch/loongarch/Makefile                                                    |    4 
 arch/loongarch/include/asm/perf_event.h                                    |    3 
 arch/loongarch/kernel/perf_event.c                                         |    2 
 arch/loongarch/vdso/Makefile                                               |   10 
 arch/m68k/kernel/entry.S                                                   |    4 
 arch/m68k/mac/misc.c                                                       |   36 
 arch/microblaze/kernel/Makefile                                            |    1 
 arch/microblaze/kernel/cpu/cpuinfo-static.c                                |    2 
 arch/openrisc/kernel/traps.c                                               |   48 -
 arch/parisc/Makefile                                                       |    8 
 arch/parisc/kernel/parisc_ksyms.c                                          |    1 
 arch/powerpc/include/asm/hvcall.h                                          |    2 
 arch/powerpc/platforms/pseries/lpar.c                                      |    6 
 arch/powerpc/platforms/pseries/lparcfg.c                                   |   10 
 arch/powerpc/sysdev/fsl_msi.c                                              |    2 
 arch/riscv/Makefile                                                        |    9 
 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi             |   40 
 arch/riscv/kernel/compat_vdso/Makefile                                     |   10 
 arch/riscv/kernel/cpu_ops_sbi.c                                            |    2 
 arch/riscv/kernel/cpu_ops_spinwait.c                                       |    3 
 arch/riscv/kernel/stacktrace.c                                             |   20 
 arch/riscv/kernel/vdso/Makefile                                            |   10 
 arch/riscv/net/bpf_jit_comp64.c                                            |   20 
 arch/s390/Makefile                                                         |    6 
 arch/s390/boot/startup.c                                                   |    1 
 arch/s390/include/asm/gmap.h                                               |    2 
 arch/s390/include/asm/mmu.h                                                |    5 
 arch/s390/include/asm/mmu_context.h                                        |    1 
 arch/s390/include/asm/pgtable.h                                            |   16 
 arch/s390/kernel/ipl.c                                                     |   10 
 arch/s390/kernel/setup.c                                                   |    2 
 arch/s390/kernel/vdso32/Makefile                                           |   14 
 arch/s390/kernel/vdso64/Makefile                                           |   15 
 arch/s390/kvm/kvm-s390.c                                                   |    4 
 arch/s390/mm/gmap.c                                                        |  165 ++-
 arch/s390/net/bpf_jit_comp.c                                               |    8 
 arch/sh/kernel/kprobes.c                                                   |    7 
 arch/sh/lib/checksum.S                                                     |   67 -
 arch/sparc/Makefile                                                        |    5 
 arch/sparc/vdso/Makefile                                                   |   27 
 arch/um/drivers/line.c                                                     |   14 
 arch/um/drivers/ubd_kern.c                                                 |    4 
 arch/um/drivers/vector_kern.c                                              |    2 
 arch/um/include/asm/kasan.h                                                |    1 
 arch/um/include/asm/mmu.h                                                  |    2 
 arch/um/include/asm/processor-generic.h                                    |    1 
 arch/um/include/shared/kern_util.h                                         |    2 
 arch/um/include/shared/skas/mm_id.h                                        |    2 
 arch/um/os-Linux/mem.c                                                     |    1 
 arch/x86/Kconfig                                                           |    8 
 arch/x86/Kconfig.debug                                                     |    5 
 arch/x86/Makefile                                                          |    7 
 arch/x86/boot/compressed/head_64.S                                         |    5 
 arch/x86/crypto/nh-avx2-x86_64.S                                           |    1 
 arch/x86/crypto/sha256-avx2-asm.S                                          |    1 
 arch/x86/crypto/sha512-avx2-asm.S                                          |    1 
 arch/x86/entry/vdso/Makefile                                               |   27 
 arch/x86/entry/vsyscall/vsyscall_64.c                                      |   28 
 arch/x86/include/asm/cmpxchg_64.h                                          |    2 
 arch/x86/include/asm/pgtable_types.h                                       |    2 
 arch/x86/include/asm/processor.h                                           |    1 
 arch/x86/include/asm/sparsemem.h                                           |    2 
 arch/x86/kernel/apic/vector.c                                              |    9 
 arch/x86/kernel/tsc_sync.c                                                 |    6 
 arch/x86/kvm/cpuid.c                                                       |   21 
 arch/x86/lib/x86-opcode-map.txt                                            |   10 
 arch/x86/mm/fault.c                                                        |   33 
 arch/x86/mm/numa.c                                                         |    4 
 arch/x86/mm/pat/set_memory.c                                               |   68 +
 arch/x86/net/bpf_jit_comp.c                                                |   57 -
 arch/x86/pci/mmconfig-shared.c                                             |   40 
 arch/x86/purgatory/Makefile                                                |    3 
 arch/x86/tools/relocs.c                                                    |    9 
 arch/x86/um/shared/sysdep/archsetjmp.h                                     |    7 
 arch/x86/xen/enlighten.c                                                   |   33 
 block/blk-cgroup.c                                                         |   87 +-
 block/blk-core.c                                                           |    9 
 block/blk-merge.c                                                          |    2 
 block/blk-mq.c                                                             |    4 
 block/blk.h                                                                |    1 
 block/fops.c                                                               |    2 
 block/genhd.c                                                              |    2 
 block/partitions/cmdline.c                                                 |   49 -
 crypto/asymmetric_keys/Kconfig                                             |    3 
 drivers/accel/ivpu/ivpu_job.c                                              |    3 
 drivers/accessibility/speakup/main.c                                       |    2 
 drivers/acpi/acpi_lpss.c                                                   |    1 
 drivers/acpi/acpica/Makefile                                               |    1 
 drivers/acpi/numa/srat.c                                                   |    5 
 drivers/base/base.h                                                        |    9 
 drivers/base/bus.c                                                         |    9 
 drivers/base/module.c                                                      |   42 -
 drivers/block/null_blk/main.c                                              |    3 
 drivers/bluetooth/btmrvl_main.c                                            |    9 
 drivers/bluetooth/btqca.c                                                  |    4 
 drivers/bluetooth/btrsi.c                                                  |    1 
 drivers/bluetooth/btsdio.c                                                 |    8 
 drivers/bluetooth/btusb.c                                                  |    5 
 drivers/bluetooth/hci_bcm4377.c                                            |    1 
 drivers/bluetooth/hci_ldisc.c                                              |    6 
 drivers/bluetooth/hci_serdev.c                                             |    5 
 drivers/bluetooth/hci_uart.h                                               |    1 
 drivers/bluetooth/hci_vhci.c                                               |   10 
 drivers/bluetooth/virtio_bt.c                                              |    2 
 drivers/char/ppdev.c                                                       |   21 
 drivers/char/tpm/tpm_tis_spi_main.c                                        |    3 
 drivers/clk/clk-renesas-pcie.c                                             |   10 
 drivers/clk/mediatek/clk-mt8365-mm.c                                       |    2 
 drivers/clk/mediatek/clk-pllfh.c                                           |    2 
 drivers/clk/qcom/clk-alpha-pll.c                                           |    1 
 drivers/clk/qcom/dispcc-sm6350.c                                           |   11 
 drivers/clk/qcom/dispcc-sm8450.c                                           |   20 
 drivers/clk/qcom/dispcc-sm8550.c                                           |   20 
 drivers/clk/qcom/mmcc-msm8998.c                                            |    8 
 drivers/clk/renesas/r8a779a0-cpg-mssr.c                                    |    2 
 drivers/clk/renesas/r9a07g043-cpg.c                                        |    9 
 drivers/clk/samsung/clk-exynosautov9.c                                     |    8 
 drivers/cpufreq/brcmstb-avs-cpufreq.c                                      |    5 
 drivers/cpufreq/cppc_cpufreq.c                                             |   14 
 drivers/cpufreq/cpufreq.c                                                  |   11 
 drivers/crypto/bcm/spu2.c                                                  |    2 
 drivers/crypto/ccp/sp-platform.c                                           |   14 
 drivers/crypto/intel/qat/qat_4xxx/adf_drv.c                                |    2 
 drivers/cxl/core/region.c                                                  |    1 
 drivers/cxl/core/trace.h                                                   |    4 
 drivers/dma-buf/st-dma-fence-chain.c                                       |   12 
 drivers/dma-buf/st-dma-fence.c                                             |    4 
 drivers/dma-buf/sync_debug.c                                               |    4 
 drivers/dma/idma64.c                                                       |    4 
 drivers/dma/idxd/cdev.c                                                    |    1 
 drivers/extcon/Kconfig                                                     |    3 
 drivers/firmware/dmi-id.c                                                  |    7 
 drivers/firmware/efi/libstub/fdt.c                                         |    4 
 drivers/firmware/efi/libstub/x86-stub.c                                    |   28 
 drivers/firmware/qcom_scm.c                                                |   10 
 drivers/firmware/raspberrypi.c                                             |    7 
 drivers/fpga/dfl-pci.c                                                     |    3 
 drivers/fpga/fpga-bridge.c                                                 |   57 -
 drivers/fpga/fpga-mgr.c                                                    |   82 +
 drivers/fpga/fpga-region.c                                                 |   24 
 drivers/gpio/gpiolib-acpi.c                                                |   19 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                           |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c                                    |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c                                 |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                                     |    3 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                                     |    3 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                                      |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c                                    |    8 
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c                                   |   16 
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                                   |    8 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                                       |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                          |    1 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c                |    3 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c             |    8 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c               |   15 
 drivers/gpu/drm/amd/display/dc/core/dc.c                                   |    3 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c                     |    5 
 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c                       |    2 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c            |   10 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c                       |   25 
 drivers/gpu/drm/arm/malidp_mw.c                                            |    5 
 drivers/gpu/drm/bridge/analogix/anx7625.c                                  |   15 
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c                        |    3 
 drivers/gpu/drm/bridge/chipone-icn6211.c                                   |    6 
 drivers/gpu/drm/bridge/lontium-lt8912b.c                                   |    6 
 drivers/gpu/drm/bridge/lontium-lt9611.c                                    |    6 
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c                                 |    6 
 drivers/gpu/drm/bridge/tc358775.c                                          |   27 
 drivers/gpu/drm/bridge/ti-dlpc3433.c                                       |   17 
 drivers/gpu/drm/bridge/ti-sn65dsi83.c                                      |    1 
 drivers/gpu/drm/ci/build.yml                                               |    1 
 drivers/gpu/drm/ci/gitlab-ci.yml                                           |   22 
 drivers/gpu/drm/ci/image-tags.yml                                          |    2 
 drivers/gpu/drm/ci/lava-submit.sh                                          |    2 
 drivers/gpu/drm/ci/test.yml                                                |   27 
 drivers/gpu/drm/display/drm_dp_helper.c                                    |   35 
 drivers/gpu/drm/drm_bridge.c                                               |   10 
 drivers/gpu/drm/drm_edid.c                                                 |    2 
 drivers/gpu/drm/drm_mipi_dsi.c                                             |    6 
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c                                      |    4 
 drivers/gpu/drm/i915/display/intel_backlight.c                             |    6 
 drivers/gpu/drm/i915/gt/intel_engine_cs.c                                  |    6 
 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c                                |    2 
 drivers/gpu/drm/i915/gt/intel_gt_types.h                                   |    8 
 drivers/gpu/drm/i915/gt/selftest_migrate.c                                 |    4 
 drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h                              |    6 
 drivers/gpu/drm/i915/gvt/interrupt.c                                       |   13 
 drivers/gpu/drm/mediatek/mtk_dp.c                                          |    2 
 drivers/gpu/drm/mediatek/mtk_drm_gem.c                                     |    3 
 drivers/gpu/drm/meson/meson_dw_mipi_dsi.c                                  |    7 
 drivers/gpu/drm/meson/meson_vclk.c                                         |    6 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                                      |    3 
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.h                               |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                                |   30 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h                           |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c                       |   11 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c                       |    4 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c                        |   16 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c                          |  131 +--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h                          |   18 
 drivers/gpu/drm/msm/dp/dp_aux.c                                            |   20 
 drivers/gpu/drm/msm/dp/dp_aux.h                                            |    1 
 drivers/gpu/drm/msm/dp/dp_ctrl.c                                           |    6 
 drivers/gpu/drm/msm/dp/dp_display.c                                        |    4 
 drivers/gpu/drm/msm/dp/dp_link.c                                           |   22 
 drivers/gpu/drm/msm/dp/dp_link.h                                           |   14 
 drivers/gpu/drm/msm/dsi/dsi_host.c                                         |   10 
 drivers/gpu/drm/mxsfb/lcdif_drv.c                                          |    6 
 drivers/gpu/drm/nouveau/nouveau_abi16.c                                    |   12 
 drivers/gpu/drm/nouveau/nouveau_bo.c                                       |   44 -
 drivers/gpu/drm/omapdrm/Kconfig                                            |    2 
 drivers/gpu/drm/omapdrm/omap_fbdev.c                                       |   40 
 drivers/gpu/drm/panel/panel-edp.c                                          |    3 
 drivers/gpu/drm/panel/panel-novatek-nt35950.c                              |    6 
 drivers/gpu/drm/panel/panel-samsung-atna33xc20.c                           |   24 
 drivers/gpu/drm/panel/panel-simple.c                                       |    3 
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c                             |   16 
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c                               |   22 
 drivers/gpu/drm/solomon/ssd130x.c                                          |    2 
 drivers/gpu/drm/vc4/vc4_hdmi.c                                             |    2 
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c                                        |    7 
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c                              |   10 
 drivers/hid/hid-mcp2221.c                                                  |    2 
 drivers/hid/intel-ish-hid/ipc/pci-ish.c                                    |    5 
 drivers/hwmon/intel-m10-bmc-hwmon.c                                        |    2 
 drivers/hwmon/pwm-fan.c                                                    |    8 
 drivers/hwmon/shtc1.c                                                      |    2 
 drivers/hwtracing/coresight/coresight-etm4x-core.c                         |   29 
 drivers/hwtracing/coresight/coresight-etm4x.h                              |   31 
 drivers/hwtracing/stm/core.c                                               |   11 
 drivers/i2c/busses/i2c-cadence.c                                           |    1 
 drivers/i2c/busses/i2c-synquacer.c                                         |   20 
 drivers/i3c/master/svc-i3c-master.c                                        |   36 
 drivers/iio/Kconfig                                                        |    9 
 drivers/iio/Makefile                                                       |    1 
 drivers/iio/accel/mxc4005.c                                                |   76 +
 drivers/iio/adc/Kconfig                                                    |    6 
 drivers/iio/adc/ad9467.c                                                   |  310 ++++---
 drivers/iio/adc/adi-axi-adc.c                                              |  408 ++-------
 drivers/iio/adc/stm32-adc.c                                                |    1 
 drivers/iio/buffer/industrialio-buffer-dmaengine.c                         |    8 
 drivers/iio/industrialio-backend.c                                         |  418 ++++++++++
 drivers/iio/industrialio-core.c                                            |    6 
 drivers/iio/pressure/dps310.c                                              |   11 
 drivers/infiniband/core/cma.c                                              |    4 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                                   |   57 -
 drivers/infiniband/hw/bnxt_re/ib_verbs.h                                   |    7 
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                                   |  208 +++-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h                                   |   34 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c                                 |   19 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h                                 |    4 
 drivers/infiniband/hw/bnxt_re/qplib_res.c                                  |    2 
 drivers/infiniband/hw/bnxt_re/qplib_res.h                                  |   46 -
 drivers/infiniband/hw/bnxt_re/roce_hsi.h                                   |   67 +
 drivers/infiniband/hw/hns/hns_roce_cq.c                                    |   24 
 drivers/infiniband/hw/hns/hns_roce_hem.h                                   |   12 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                                 |    7 
 drivers/infiniband/hw/hns/hns_roce_main.c                                  |    1 
 drivers/infiniband/hw/hns/hns_roce_mr.c                                    |   15 
 drivers/infiniband/hw/hns/hns_roce_srq.c                                   |    6 
 drivers/infiniband/hw/mlx5/mem.c                                           |    8 
 drivers/infiniband/hw/mlx5/mlx5_ib.h                                       |    2 
 drivers/infiniband/hw/mlx5/mr.c                                            |    3 
 drivers/infiniband/sw/rxe/rxe_comp.c                                       |    6 
 drivers/infiniband/sw/rxe/rxe_net.c                                        |   12 
 drivers/infiniband/sw/rxe/rxe_verbs.c                                      |    6 
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c                                  |    8 
 drivers/input/input.c                                                      |  104 ++
 drivers/input/joystick/xpad.c                                              |    2 
 drivers/input/misc/da7280.c                                                |    4 
 drivers/input/misc/ims-pcu.c                                               |    4 
 drivers/input/misc/pm8xxx-vibrator.c                                       |    7 
 drivers/input/misc/pwm-beeper.c                                            |    4 
 drivers/input/misc/pwm-vibra.c                                             |    8 
 drivers/input/mouse/cyapa.c                                                |   12 
 drivers/interconnect/qcom/qcm2290.c                                        |    2 
 drivers/iommu/iommu.c                                                      |   21 
 drivers/irqchip/irq-alpine-msi.c                                           |    2 
 drivers/irqchip/irq-loongson-pch-msi.c                                     |    2 
 drivers/leds/leds-pwm.c                                                    |   10 
 drivers/leds/rgb/leds-pwm-multicolor.c                                     |    4 
 drivers/macintosh/via-macii.c                                              |   11 
 drivers/md/md-bitmap.c                                                     |    6 
 drivers/media/cec/core/cec-adap.c                                          |   24 
 drivers/media/cec/core/cec-api.c                                           |    5 
 drivers/media/i2c/et8ek8/et8ek8_driver.c                                   |    4 
 drivers/media/i2c/ov2680.c                                                 |   13 
 drivers/media/pci/intel/ipu3/ipu3-cio2.c                                   |   10 
 drivers/media/pci/ngene/ngene-core.c                                       |    4 
 drivers/media/platform/cadence/cdns-csi2rx.c                               |   26 
 drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.c            |   21 
 drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.c         |   20 
 drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.h         |    3 
 drivers/media/platform/mediatek/vcodec/encoder/venc_drv_if.c               |   11 
 drivers/media/platform/renesas/rcar-vin/rcar-vin.h                         |    2 
 drivers/media/platform/renesas/vsp1/vsp1_pipe.c                            |    2 
 drivers/media/platform/renesas/vsp1/vsp1_rpf.c                             |   10 
 drivers/media/platform/renesas/vsp1/vsp1_rwpf.c                            |    8 
 drivers/media/platform/renesas/vsp1/vsp1_rwpf.h                            |    4 
 drivers/media/platform/renesas/vsp1/vsp1_wpf.c                             |   29 
 drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig                  |    1 
 drivers/media/radio/radio-shark2.c                                         |    2 
 drivers/media/rc/ir-rx51.c                                                 |    4 
 drivers/media/rc/pwm-ir-tx.c                                               |    4 
 drivers/media/usb/b2c2/flexcop-usb.c                                       |    2 
 drivers/media/usb/stk1160/stk1160-video.c                                  |   20 
 drivers/media/usb/uvc/uvc_driver.c                                         |   31 
 drivers/media/usb/uvc/uvcvideo.h                                           |    1 
 drivers/media/v4l2-core/v4l2-subdev.c                                      |   39 
 drivers/misc/lkdtm/Makefile                                                |    2 
 drivers/misc/lkdtm/perms.c                                                 |    2 
 drivers/misc/pvpanic/pvpanic-mmio.c                                        |   58 -
 drivers/misc/pvpanic/pvpanic-pci.c                                         |   60 -
 drivers/misc/pvpanic/pvpanic.c                                             |   76 +
 drivers/misc/pvpanic/pvpanic.h                                             |   10 
 drivers/misc/vmw_vmci/vmci_guest.c                                         |   10 
 drivers/mmc/host/sdhci_am654.c                                             |  205 +++-
 drivers/mtd/mtdcore.c                                                      |    6 
 drivers/mtd/nand/raw/nand_hynix.c                                          |    2 
 drivers/net/Makefile                                                       |    4 
 drivers/net/dsa/microchip/ksz_common.c                                     |    2 
 drivers/net/dsa/mv88e6xxx/chip.c                                           |   50 +
 drivers/net/dsa/mv88e6xxx/chip.h                                           |    6 
 drivers/net/dsa/mv88e6xxx/global1.c                                        |   89 ++
 drivers/net/dsa/mv88e6xxx/global1.h                                        |    2 
 drivers/net/ethernet/amazon/ena/ena_com.c                                  |  326 ++-----
 drivers/net/ethernet/amazon/ena/ena_eth_com.c                              |   49 -
 drivers/net/ethernet/amazon/ena/ena_eth_com.h                              |   15 
 drivers/net/ethernet/amazon/ena/ena_netdev.c                               |   32 
 drivers/net/ethernet/cisco/enic/enic_main.c                                |   12 
 drivers/net/ethernet/cortina/gemini.c                                      |   12 
 drivers/net/ethernet/freescale/enetc/enetc.c                               |    2 
 drivers/net/ethernet/freescale/fec_main.c                                  |   36 
 drivers/net/ethernet/freescale/fec_ptp.c                                   |   14 
 drivers/net/ethernet/intel/ice/ice_ethtool.c                               |   19 
 drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c                          |   11 
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h                              |    3 
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c                              |   56 -
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c                           |    4 
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c                              |   44 -
 drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c                     |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h                |    8 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c                |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h              |   17 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                          |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c                            |    6 
 drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c                       |    2 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h                          |    4 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c                 |   28 
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c                          |   18 
 drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c                        |   18 
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c                      |   12 
 drivers/net/ethernet/microsoft/mana/hw_channel.c                           |    2 
 drivers/net/ethernet/qlogic/qed/qed_main.c                                 |    9 
 drivers/net/ethernet/realtek/r8169_main.c                                  |    9 
 drivers/net/ethernet/smsc/smc91x.h                                         |    4 
 drivers/net/ethernet/sun/sungem.c                                          |   14 
 drivers/net/ethernet/ti/icssg/icssg_classifier.c                           |    2 
 drivers/net/ethernet/ti/icssg/icssg_prueth.c                               |   14 
 drivers/net/ethernet/wangxun/libwx/wx_lib.c                                |    4 
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c                             |    8 
 drivers/net/ipvlan/ipvlan_core.c                                           |    4 
 drivers/net/phy/micrel.c                                                   |   14 
 drivers/net/usb/aqc111.c                                                   |    8 
 drivers/net/usb/qmi_wwan.c                                                 |    3 
 drivers/net/usb/smsc95xx.c                                                 |   26 
 drivers/net/usb/sr9700.c                                                   |   10 
 drivers/net/wireless/ath/ar5523/ar5523.c                                   |   14 
 drivers/net/wireless/ath/ath10k/core.c                                     |    3 
 drivers/net/wireless/ath/ath10k/debugfs_sta.c                              |    2 
 drivers/net/wireless/ath/ath10k/hw.h                                       |    1 
 drivers/net/wireless/ath/ath10k/targaddrs.h                                |    3 
 drivers/net/wireless/ath/ath10k/wmi.c                                      |   26 
 drivers/net/wireless/ath/ath11k/mac.c                                      |    9 
 drivers/net/wireless/ath/ath12k/qmi.c                                      |    3 
 drivers/net/wireless/ath/ath12k/wmi.c                                      |    2 
 drivers/net/wireless/ath/carl9170/tx.c                                     |    3 
 drivers/net/wireless/ath/carl9170/usb.c                                    |   32 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c                    |   15 
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c                          |   19 
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c                      |    9 
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c                           |   19 
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h                               |    2 
 drivers/net/wireless/marvell/mwl8k.c                                       |    2 
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c                            |   46 -
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c                            |    1 
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c                        |    6 
 drivers/net/xen-netback/interface.c                                        |    3 
 drivers/nvme/host/core.c                                                   |   23 
 drivers/nvme/host/multipath.c                                              |    6 
 drivers/nvme/host/nvme.h                                                   |   22 
 drivers/nvme/host/pci.c                                                    |    8 
 drivers/nvme/target/auth.c                                                 |    8 
 drivers/nvme/target/configfs.c                                             |   20 
 drivers/nvme/target/core.c                                                 |    5 
 drivers/nvme/target/nvmet.h                                                |    1 
 drivers/nvme/target/tcp.c                                                  |   11 
 drivers/of/module.c                                                        |    7 
 drivers/pci/controller/dwc/pcie-tegra194.c                                 |    3 
 drivers/pci/of_property.c                                                  |    2 
 drivers/pci/pci.c                                                          |    2 
 drivers/pci/pcie/edr.c                                                     |   28 
 drivers/perf/arm_dmc620_pmu.c                                              |    9 
 drivers/perf/hisilicon/hisi_pcie_pmu.c                                     |   14 
 drivers/perf/hisilicon/hns3_pmu.c                                          |   16 
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c                                  |    2 
 drivers/pinctrl/qcom/pinctrl-sm7150.c                                      |   20 
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c                |    1 
 drivers/platform/x86/intel/tpmi.c                                          |    7 
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c        |    7 
 drivers/platform/x86/lenovo-yogabook.c                                     |    2 
 drivers/platform/x86/thinkpad_acpi.c                                       |    5 
 drivers/pwm/core.c                                                         |   18 
 drivers/pwm/pwm-sti.c                                                      |   46 -
 drivers/pwm/pwm-twl-led.c                                                  |    2 
 drivers/pwm/pwm-vt8500.c                                                   |    2 
 drivers/pwm/sysfs.c                                                        |   10 
 drivers/regulator/bd71828-regulator.c                                      |   58 -
 drivers/regulator/helpers.c                                                |   43 -
 drivers/regulator/irq_helpers.c                                            |    3 
 drivers/regulator/pwm-regulator.c                                          |    4 
 drivers/regulator/qcom-refgen-regulator.c                                  |    1 
 drivers/regulator/tps6287x-regulator.c                                     |    1 
 drivers/regulator/tps6594-regulator.c                                      |   16 
 drivers/regulator/vqmmc-ipq4019-regulator.c                                |    1 
 drivers/s390/cio/trace.h                                                   |    2 
 drivers/scsi/bfa/bfad_debugfs.c                                            |    4 
 drivers/scsi/hpsa.c                                                        |    2 
 drivers/scsi/libsas/sas_expander.c                                         |    3 
 drivers/scsi/qedf/qedf_debugfs.c                                           |    2 
 drivers/scsi/qla2xxx/qla_dfs.c                                             |    2 
 drivers/soc/mediatek/mtk-cmdq-helper.c                                     |    5 
 drivers/soc/qcom/pmic_glink.c                                              |   26 
 drivers/soundwire/cadence_master.c                                         |    2 
 drivers/spi/spi-stm32.c                                                    |    2 
 drivers/spi/spi.c                                                          |    4 
 drivers/staging/greybus/arche-apb-ctrl.c                                   |    1 
 drivers/staging/greybus/arche-platform.c                                   |    9 
 drivers/staging/greybus/light.c                                            |    8 
 drivers/staging/media/atomisp/pci/sh_css.c                                 |    1 
 drivers/thermal/qcom/tsens.c                                               |    2 
 drivers/tty/n_gsm.c                                                        |  140 ++-
 drivers/tty/serial/8250/8250_bcm7271.c                                     |  101 +-
 drivers/tty/serial/8250/8250_mtk.c                                         |    8 
 drivers/tty/serial/max3100.c                                               |   22 
 drivers/tty/serial/sc16is7xx.c                                             |   27 
 drivers/tty/serial/sh-sci.c                                                |    5 
 drivers/ufs/core/ufs-mcq.c                                                 |    3 
 drivers/ufs/core/ufshcd.c                                                  |    6 
 drivers/ufs/host/cdns-pltfrm.c                                             |    2 
 drivers/ufs/host/ufs-qcom.c                                                |    7 
 drivers/ufs/host/ufs-qcom.h                                                |   12 
 drivers/usb/fotg210/fotg210-core.c                                         |    1 
 drivers/usb/gadget/function/u_audio.c                                      |   21 
 drivers/usb/typec/ucsi/ucsi.c                                              |   18 
 drivers/usb/usbip/usbip_common.h                                           |    6 
 drivers/vfio/pci/vfio_pci_intrs.c                                          |    4 
 drivers/video/backlight/lm3630a_bl.c                                       |    2 
 drivers/video/backlight/lp855x_bl.c                                        |    2 
 drivers/video/backlight/pwm_bl.c                                           |   12 
 drivers/video/fbdev/Kconfig                                                |    4 
 drivers/video/fbdev/core/Kconfig                                           |   12 
 drivers/video/fbdev/core/Makefile                                          |    3 
 drivers/video/fbdev/core/fb_io_fops.c                                      |    3 
 drivers/video/fbdev/sh_mobile_lcdcfb.c                                     |    2 
 drivers/video/fbdev/sis/init301.c                                          |    3 
 drivers/video/fbdev/ssd1307fb.c                                            |    2 
 drivers/virt/acrn/mm.c                                                     |   61 +
 drivers/virtio/virtio_pci_common.c                                         |    4 
 drivers/watchdog/bd9576_wdt.c                                              |   12 
 drivers/watchdog/cpu5wdt.c                                                 |    2 
 drivers/watchdog/sa1100_wdt.c                                              |    5 
 drivers/xen/xenbus/xenbus_probe.c                                          |   36 
 fs/dlm/ast.c                                                               |   14 
 fs/dlm/dlm_internal.h                                                      |    1 
 fs/dlm/user.c                                                              |   15 
 fs/ecryptfs/keystore.c                                                     |    4 
 fs/eventpoll.c                                                             |   38 
 fs/ext4/inode.c                                                            |    3 
 fs/ext4/mballoc.c                                                          |    1 
 fs/ext4/namei.c                                                            |    2 
 fs/f2fs/checkpoint.c                                                       |   10 
 fs/f2fs/compress.c                                                         |   64 -
 fs/f2fs/data.c                                                             |  148 +--
 fs/f2fs/debug.c                                                            |    6 
 fs/f2fs/dir.c                                                              |    5 
 fs/f2fs/f2fs.h                                                             |  165 ++-
 fs/f2fs/file.c                                                             |  134 +--
 fs/f2fs/gc.c                                                               |  117 +-
 fs/f2fs/node.c                                                             |    6 
 fs/f2fs/node.h                                                             |    4 
 fs/f2fs/recovery.c                                                         |    2 
 fs/f2fs/segment.c                                                          |  244 ++---
 fs/f2fs/segment.h                                                          |   66 -
 fs/f2fs/super.c                                                            |  116 --
 fs/f2fs/sysfs.c                                                            |    6 
 fs/gfs2/acl.h                                                              |    8 
 fs/gfs2/aops.c                                                             |   36 
 fs/gfs2/aops.h                                                             |    6 
 fs/gfs2/bmap.c                                                             |    4 
 fs/gfs2/bmap.h                                                             |   38 
 fs/gfs2/dir.c                                                              |    2 
 fs/gfs2/dir.h                                                              |   38 
 fs/gfs2/file.c                                                             |    2 
 fs/gfs2/glock.c                                                            |   97 +-
 fs/gfs2/glock.h                                                            |  107 +-
 fs/gfs2/glops.c                                                            |    5 
 fs/gfs2/glops.h                                                            |    4 
 fs/gfs2/incore.h                                                           |    3 
 fs/gfs2/inode.c                                                            |   15 
 fs/gfs2/inode.h                                                            |   52 -
 fs/gfs2/lock_dlm.c                                                         |   40 
 fs/gfs2/log.c                                                              |   21 
 fs/gfs2/log.h                                                              |   46 -
 fs/gfs2/lops.h                                                             |   22 
 fs/gfs2/meta_io.c                                                          |    9 
 fs/gfs2/meta_io.h                                                          |   20 
 fs/gfs2/ops_fstype.c                                                       |   28 
 fs/gfs2/quota.c                                                            |    8 
 fs/gfs2/quota.h                                                            |   35 
 fs/gfs2/recovery.c                                                         |    2 
 fs/gfs2/recovery.h                                                         |   18 
 fs/gfs2/rgrp.c                                                             |   12 
 fs/gfs2/rgrp.h                                                             |   85 +-
 fs/gfs2/super.c                                                            |   19 
 fs/gfs2/super.h                                                            |   50 -
 fs/gfs2/sys.c                                                              |    2 
 fs/gfs2/trans.c                                                            |    2 
 fs/gfs2/trans.h                                                            |   24 
 fs/gfs2/util.c                                                             |    5 
 fs/gfs2/util.h                                                             |   23 
 fs/gfs2/xattr.c                                                            |    6 
 fs/gfs2/xattr.h                                                            |   12 
 fs/jffs2/xattr.c                                                           |    3 
 fs/nfs/filelayout/filelayout.c                                             |    4 
 fs/nfs/fs_context.c                                                        |    9 
 fs/nfs/nfs4state.c                                                         |   12 
 fs/nilfs2/ioctl.c                                                          |    2 
 fs/nilfs2/segment.c                                                        |   63 +
 fs/ntfs3/dir.c                                                             |    1 
 fs/ntfs3/fslog.c                                                           |    3 
 fs/ntfs3/index.c                                                           |    6 
 fs/ntfs3/inode.c                                                           |   24 
 fs/ntfs3/ntfs.h                                                            |    2 
 fs/ntfs3/record.c                                                          |   11 
 fs/ntfs3/super.c                                                           |    2 
 fs/openpromfs/inode.c                                                      |    8 
 fs/overlayfs/dir.c                                                         |    3 
 fs/smb/server/mgmt/share_config.c                                          |    6 
 fs/smb/server/oplock.c                                                     |   21 
 fs/smb/server/smb2pdu.c                                                    |    4 
 fs/tracefs/event_inode.c                                                   |  156 ++-
 fs/tracefs/internal.h                                                      |    9 
 fs/udf/inode.c                                                             |   27 
 include/drm/display/drm_dp_helper.h                                        |    6 
 include/drm/drm_displayid.h                                                |    1 
 include/drm/drm_mipi_dsi.h                                                 |    6 
 include/linux/acpi.h                                                       |    2 
 include/linux/bitops.h                                                     |    1 
 include/linux/counter.h                                                    |    1 
 include/linux/cpu.h                                                        |   11 
 include/linux/dev_printk.h                                                 |   25 
 include/linux/f2fs_fs.h                                                    |    6 
 include/linux/fb.h                                                         |    4 
 include/linux/fortify-string.h                                             |   22 
 include/linux/fpga/fpga-bridge.h                                           |   10 
 include/linux/fpga/fpga-mgr.h                                              |   26 
 include/linux/fpga/fpga-region.h                                           |   13 
 include/linux/i3c/device.h                                                 |    2 
 include/linux/ieee80211.h                                                  |    2 
 include/linux/iio/adc/adi-axi-adc.h                                        |   68 -
 include/linux/iio/backend.h                                                |   72 +
 include/linux/iio/buffer-dmaengine.h                                       |    3 
 include/linux/kthread.h                                                    |    1 
 include/linux/mlx5/driver.h                                                |    1 
 include/linux/mlx5/mlx5_ifc.h                                              |    4 
 include/linux/numa.h                                                       |   26 
 include/linux/nvme-tcp.h                                                   |    6 
 include/linux/printk.h                                                     |    2 
 include/linux/pwm.h                                                        |   28 
 include/linux/regulator/driver.h                                           |    3 
 include/linux/tracefs.h                                                    |    3 
 include/media/cec.h                                                        |    1 
 include/media/v4l2-subdev.h                                                |    4 
 include/net/ax25.h                                                         |    3 
 include/net/bluetooth/hci.h                                                |  114 --
 include/net/bluetooth/hci_core.h                                           |   46 -
 include/net/bluetooth/hci_sync.h                                           |    2 
 include/net/bluetooth/l2cap.h                                              |   11 
 include/net/mac80211.h                                                     |    3 
 include/net/tcp.h                                                          |   11 
 include/sound/cs35l56.h                                                    |    1 
 include/sound/soc-acpi-intel-match.h                                       |    2 
 include/sound/tas2781-dsp.h                                                |    7 
 include/trace/events/asoc.h                                                |    2 
 include/uapi/drm/nouveau_drm.h                                             |   21 
 include/uapi/linux/bpf.h                                                   |    2 
 include/uapi/linux/user_events.h                                           |   11 
 include/uapi/linux/virtio_bt.h                                             |    1 
 include/uapi/rdma/bnxt_re-abi.h                                            |   10 
 io_uring/io-wq.c                                                           |   13 
 io_uring/io_uring.h                                                        |    2 
 io_uring/nop.c                                                             |    2 
 kernel/Makefile                                                            |    1 
 kernel/bpf/syscall.c                                                       |    5 
 kernel/bpf/verifier.c                                                      |   39 
 kernel/cgroup/cpuset.c                                                     |    2 
 kernel/cpu.c                                                               |   14 
 kernel/dma/map_benchmark.c                                                 |   22 
 kernel/gen_kheaders.sh                                                     |    7 
 kernel/irq/cpuhotplug.c                                                    |   16 
 kernel/irq/manage.c                                                        |   15 
 kernel/kthread.c                                                           |   18 
 kernel/numa.c                                                              |   26 
 kernel/rcu/tasks.h                                                         |    2 
 kernel/rcu/tree_stall.h                                                    |    3 
 kernel/sched/core.c                                                        |    2 
 kernel/sched/fair.c                                                        |   53 -
 kernel/sched/isolation.c                                                   |    7 
 kernel/sched/topology.c                                                    |    2 
 kernel/smpboot.c                                                           |    3 
 kernel/softirq.c                                                           |   12 
 kernel/trace/ftrace.c                                                      |   39 
 kernel/trace/ring_buffer.c                                                 |    9 
 kernel/trace/rv/rv.c                                                       |    2 
 kernel/trace/trace_events.c                                                |   12 
 kernel/trace/trace_events_user.c                                           |  213 +++--
 kernel/trace/trace_probe.c                                                 |    4 
 lib/fortify_kunit.c                                                        |   16 
 lib/kunit/try-catch.c                                                      |    9 
 lib/slub_kunit.c                                                           |    2 
 lib/test_hmm.c                                                             |    8 
 mm/damon/core.c                                                            |    3 
 mm/userfaultfd.c                                                           |   35 
 net/ax25/ax25_dev.c                                                        |   48 -
 net/bluetooth/hci_conn.c                                                   |   10 
 net/bluetooth/hci_core.c                                                   |  135 ---
 net/bluetooth/hci_event.c                                                  |  310 -------
 net/bluetooth/hci_sock.c                                                   |    9 
 net/bluetooth/hci_sync.c                                                   |  138 ---
 net/bluetooth/l2cap_core.c                                                 |   77 +
 net/bluetooth/l2cap_sock.c                                                 |   91 +-
 net/bluetooth/mgmt.c                                                       |   84 --
 net/bridge/br_device.c                                                     |    6 
 net/bridge/br_mst.c                                                        |   16 
 net/core/dev.c                                                             |    3 
 net/core/pktgen.c                                                          |    3 
 net/ipv4/af_inet.c                                                         |    4 
 net/ipv4/netfilter/nf_tproxy_ipv4.c                                        |    2 
 net/ipv4/tcp_dctcp.c                                                       |   13 
 net/ipv4/tcp_ipv4.c                                                        |   13 
 net/ipv4/udp.c                                                             |   21 
 net/ipv6/reassembly.c                                                      |    2 
 net/ipv6/seg6.c                                                            |    5 
 net/ipv6/seg6_hmac.c                                                       |   42 -
 net/ipv6/seg6_iptunnel.c                                                   |   11 
 net/ipv6/udp.c                                                             |   20 
 net/mac80211/mlme.c                                                        |    3 
 net/mac80211/rate.c                                                        |    6 
 net/mac80211/scan.c                                                        |    1 
 net/mac80211/tx.c                                                          |   13 
 net/mptcp/sockopt.c                                                        |    2 
 net/netfilter/ipset/ip_set_list_set.c                                      |    3 
 net/netfilter/nfnetlink_queue.c                                            |    2 
 net/netfilter/nft_fib.c                                                    |    8 
 net/netfilter/nft_payload.c                                                |   95 +-
 net/netrom/nr_route.c                                                      |   19 
 net/nfc/nci/core.c                                                         |   18 
 net/openvswitch/actions.c                                                  |    6 
 net/openvswitch/flow.c                                                     |    3 
 net/packet/af_packet.c                                                     |    3 
 net/qrtr/ns.c                                                              |   27 
 net/sched/sch_taprio.c                                                     |   14 
 net/sunrpc/auth_gss/svcauth_gss.c                                          |   12 
 net/sunrpc/clnt.c                                                          |    1 
 net/sunrpc/svc.c                                                           |    2 
 net/sunrpc/xprtrdma/verbs.c                                                |    6 
 net/tls/tls_main.c                                                         |   10 
 net/unix/af_unix.c                                                         |   49 -
 net/wireless/nl80211.c                                                     |   14 
 net/wireless/trace.h                                                       |    4 
 scripts/Makefile.vdsoinst                                                  |   45 +
 scripts/kconfig/symbol.c                                                   |    6 
 scripts/module.lds.S                                                       |    1 
 sound/core/init.c                                                          |   20 
 sound/core/jack.c                                                          |   46 -
 sound/core/seq/seq_ump_convert.c                                           |   46 +
 sound/core/timer.c                                                         |   10 
 sound/hda/intel-dsp-config.c                                               |   27 
 sound/pci/emu10k1/io.c                                                     |    1 
 sound/pci/hda/cs35l56_hda.c                                                |   26 
 sound/pci/hda/hda_cs_dsp_ctl.c                                             |   47 -
 sound/pci/hda/patch_realtek.c                                              |    5 
 sound/soc/amd/yc/acp6x-mach.c                                              |    7 
 sound/soc/codecs/cs35l41.c                                                 |   26 
 sound/soc/codecs/cs35l56-shared.c                                          |   41 
 sound/soc/codecs/cs35l56.c                                                 |   21 
 sound/soc/codecs/cs42l43.c                                                 |    5 
 sound/soc/codecs/da7219-aad.c                                              |    6 
 sound/soc/codecs/rt5645.c                                                  |   25 
 sound/soc/codecs/rt715-sdca.c                                              |    8 
 sound/soc/codecs/rt715-sdw.c                                               |    1 
 sound/soc/codecs/rt722-sdca.c                                              |   27 
 sound/soc/codecs/rt722-sdca.h                                              |    3 
 sound/soc/codecs/tas2552.c                                                 |   15 
 sound/soc/codecs/tas2781-fmwlib.c                                          |  109 --
 sound/soc/codecs/tas2781-i2c.c                                             |    4 
 sound/soc/intel/avs/boards/ssm4567.c                                       |    1 
 sound/soc/intel/avs/cldma.c                                                |    2 
 sound/soc/intel/avs/path.c                                                 |    1 
 sound/soc/intel/avs/probes.c                                               |   14 
 sound/soc/intel/boards/bxt_da7219_max98357a.c                              |    1 
 sound/soc/intel/boards/bxt_rt298.c                                         |    1 
 sound/soc/intel/boards/bytcr_rt5640.c                                      |   14 
 sound/soc/intel/boards/glk_rt5682_max98357a.c                              |    2 
 sound/soc/intel/boards/kbl_da7219_max98357a.c                              |    1 
 sound/soc/intel/boards/kbl_da7219_max98927.c                               |    4 
 sound/soc/intel/boards/kbl_rt5660.c                                        |    1 
 sound/soc/intel/boards/kbl_rt5663_max98927.c                               |    2 
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c                        |    1 
 sound/soc/intel/boards/skl_hda_dsp_generic.c                               |    2 
 sound/soc/intel/boards/skl_nau88l25_max98357a.c                            |    1 
 sound/soc/intel/boards/skl_rt286.c                                         |    1 
 sound/soc/intel/common/Makefile                                            |    1 
 sound/soc/intel/common/soc-acpi-intel-arl-match.c                          |   51 +
 sound/soc/kirkwood/kirkwood-dma.c                                          |    3 
 sound/soc/mediatek/common/mtk-soundcard-driver.c                           |    6 
 sound/soc/mediatek/mt8192/mt8192-dai-tdm.c                                 |    4 
 sound/soc/sof/intel/hda.h                                                  |    1 
 sound/soc/sof/intel/lnl.c                                                  |    3 
 sound/soc/sof/intel/lnl.h                                                  |   15 
 sound/soc/sof/intel/mtl.c                                                  |   83 +
 sound/soc/sof/intel/mtl.h                                                  |    4 
 sound/soc/sof/intel/pci-mtl.c                                              |   31 
 sound/soc/sof/ipc3-pcm.c                                                   |    1 
 sound/soc/sof/pcm.c                                                        |   13 
 sound/soc/sof/sof-audio.h                                                  |    2 
 tools/arch/x86/intel_sdsi/intel_sdsi.c                                     |   48 -
 tools/arch/x86/lib/x86-opcode-map.txt                                      |   10 
 tools/bpf/bpftool/common.c                                                 |   96 ++
 tools/bpf/bpftool/iter.c                                                   |    2 
 tools/bpf/bpftool/main.h                                                   |    3 
 tools/bpf/bpftool/prog.c                                                   |    5 
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c                                  |    4 
 tools/bpf/bpftool/struct_ops.c                                             |    2 
 tools/bpf/resolve_btfids/main.c                                            |    2 
 tools/include/nolibc/stdlib.h                                              |    2 
 tools/include/uapi/linux/bpf.h                                             |    2 
 tools/lib/bpf/libbpf.c                                                     |    2 
 tools/lib/perf/evlist.c                                                    |    9 
 tools/lib/perf/include/internal/evlist.h                                   |    2 
 tools/lib/subcmd/parse-options.c                                           |    8 
 tools/perf/Documentation/perf-list.txt                                     |    1 
 tools/perf/arch/arm64/util/pmu.c                                           |    6 
 tools/perf/bench/inject-buildid.c                                          |    2 
 tools/perf/bench/uprobe.c                                                  |    2 
 tools/perf/builtin-annotate.c                                              |   46 -
 tools/perf/builtin-daemon.c                                                |    4 
 tools/perf/builtin-inject.c                                                |    6 
 tools/perf/builtin-record.c                                                |   74 +
 tools/perf/builtin-report.c                                                |   42 -
 tools/perf/builtin-sched.c                                                 |    7 
 tools/perf/builtin-top.c                                                   |   44 -
 tools/perf/pmu-events/arch/s390/cf_z16/transaction.json                    |   28 
 tools/perf/tests/Build                                                     |    1 
 tools/perf/tests/attr/system-wide-dummy                                    |   14 
 tools/perf/tests/attr/test-record-C0                                       |    4 
 tools/perf/tests/builtin-test.c                                            |    1 
 tools/perf/tests/code-reading.c                                            |   10 
 tools/perf/tests/expr.c                                                    |   31 
 tools/perf/tests/shell/test_arm_coresight.sh                               |    2 
 tools/perf/tests/tests.h                                                   |    1 
 tools/perf/tests/util.c                                                    |   31 
 tools/perf/tests/workloads/datasym.c                                       |   16 
 tools/perf/ui/browser.c                                                    |    6 
 tools/perf/ui/browser.h                                                    |    2 
 tools/perf/ui/browsers/annotate.c                                          |    8 
 tools/perf/ui/gtk/annotate.c                                               |    6 
 tools/perf/ui/gtk/gtk.h                                                    |    2 
 tools/perf/util/annotate.c                                                 |  190 ++--
 tools/perf/util/annotate.h                                                 |   32 
 tools/perf/util/event.c                                                    |    4 
 tools/perf/util/evlist.c                                                   |   18 
 tools/perf/util/evlist.h                                                   |    1 
 tools/perf/util/expr.c                                                     |    2 
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c                        |    2 
 tools/perf/util/intel-pt.c                                                 |    2 
 tools/perf/util/machine.c                                                  |   10 
 tools/perf/util/maps.c                                                     |  238 +++++
 tools/perf/util/maps.h                                                     |   12 
 tools/perf/util/perf_event_attr_fprintf.c                                  |   26 
 tools/perf/util/pmu.c                                                      |  147 ++-
 tools/perf/util/pmu.h                                                      |   10 
 tools/perf/util/pmus.c                                                     |   20 
 tools/perf/util/probe-event.c                                              |    1 
 tools/perf/util/python.c                                                   |   10 
 tools/perf/util/session.c                                                  |    5 
 tools/perf/util/stat-display.c                                             |    3 
 tools/perf/util/string.c                                                   |   48 +
 tools/perf/util/string2.h                                                  |    1 
 tools/perf/util/symbol.c                                                   |  259 ------
 tools/perf/util/symbol.h                                                   |    1 
 tools/perf/util/symbol_conf.h                                              |    4 
 tools/perf/util/thread.c                                                   |   14 
 tools/perf/util/thread.h                                                   |   14 
 tools/perf/util/top.h                                                      |    1 
 tools/testing/selftests/bpf/network_helpers.c                              |    2 
 tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c                   |    4 
 tools/testing/selftests/bpf/progs/bench_local_storage_create.c             |    5 
 tools/testing/selftests/bpf/progs/local_storage.c                          |   20 
 tools/testing/selftests/bpf/progs/lsm_cgroup.c                             |    8 
 tools/testing/selftests/bpf/test_sockmap.c                                 |    2 
 tools/testing/selftests/cgroup/cgroup_util.c                               |    8 
 tools/testing/selftests/cgroup/cgroup_util.h                               |    2 
 tools/testing/selftests/cgroup/test_core.c                                 |    7 
 tools/testing/selftests/cgroup/test_cpu.c                                  |    2 
 tools/testing/selftests/cgroup/test_cpuset.c                               |    2 
 tools/testing/selftests/cgroup/test_freezer.c                              |    2 
 tools/testing/selftests/cgroup/test_kill.c                                 |    2 
 tools/testing/selftests/cgroup/test_kmem.c                                 |    2 
 tools/testing/selftests/cgroup/test_memcontrol.c                           |    2 
 tools/testing/selftests/cgroup/test_zswap.c                                |    2 
 tools/testing/selftests/filesystems/binderfs/Makefile                      |    2 
 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc        |    2 
 tools/testing/selftests/kcmp/kcmp_test.c                                   |    2 
 tools/testing/selftests/kvm/aarch64/vgic_init.c                            |   50 +
 tools/testing/selftests/lib.mk                                             |   12 
 tools/testing/selftests/net/amt.sh                                         |   20 
 tools/testing/selftests/net/config                                         |    7 
 tools/testing/selftests/net/forwarding/bridge_igmp.sh                      |    6 
 tools/testing/selftests/net/forwarding/bridge_mld.sh                       |    6 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                            |    8 
 tools/testing/selftests/net/mptcp/simult_flows.sh                          |   10 
 tools/testing/selftests/powerpc/dexcr/Makefile                             |    2 
 tools/testing/selftests/resctrl/Makefile                                   |    4 
 tools/testing/selftests/syscall_user_dispatch/sud_test.c                   |   14 
 tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json             |   44 +
 tools/tracing/latency/latency-collector.c                                  |    8 
 865 files changed, 9357 insertions(+), 6702 deletions(-)

Aapo Vienamo (1):
      mtd: core: Report error if first mtd_otp_size() call fails in mtd_otp_nvmem_add()

Aaron Conole (1):
      openvswitch: Set the skbuff pkt_type for proper pmtud support.

Abdelrahman Morsy (1):
      HID: mcp-2221: cancel delayed_work only when CONFIG_IIO is enabled

Adrian Hunter (4):
      x86/insn: Fix PUSH instruction in x86 instruction decoder opcode map
      x86/insn: Add VEX versions of VPDPBUSD, VPDPBUSDS, VPDPWSSD and VPDPWSSDS
      perf record: Fix debug message placement for test consumption
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

Aleksandr Mishin (7):
      crypto: bcm - Fix pointer arithmetic
      cppc_cpufreq: Fix possible null pointer dereference
      thermal/drivers/tsens: Fix null pointer dereference
      ASoC: kirkwood: Fix potential NULL dereference
      drm: bridge: cdns-mhdp8546: Fix possible null pointer dereference
      drm: vc4: Fix possible null pointer dereference
      drm/msm/dpu: Add callback function pointer check before its call

Alexander Aring (1):
      dlm: fix user space lock decision to copy lvb

Alexander Egorenkov (2):
      s390/ipl: Fix incorrect initialization of len fields in nvme reipl block
      s390/ipl: Fix incorrect initialization of nvme dump block

Alexander Lobakin (1):
      bitops: add missing prototype check

Alexander Maltsev (1):
      netfilter: ipset: Add list flush to cancel_gc

Alexandre Mergnat (1):
      clk: mediatek: mt8365-mm: fix DPI0 parent

Alexei Starovoitov (1):
      bpf: Fix verifier assumptions about socket->sk

Alison Schofield (1):
      cxl/trace: Correct DPA field masks for general_media & dram events

Aloka Dixit (1):
      wifi: ath12k: use correct flag field for 320 MHz channels

Alvin Lee (1):
      drm/amd/display: Remove pixle rate limit for subvp

Andi Shyti (1):
      drm/i915/gt: Fix CCS id's calculation for CCS mode setting

Andrea Mayer (1):
      ipv6: sr: fix missing sk_buff release in seg6_input_core

Andreas Gruenbacher (13):
      gfs2: Don't forget to complete delayed withdraw
      gfs2: Fix "ignore unlock failures after withdraw"
      gfs2: Get rid of gfs2_alloc_blocks generation parameter
      gfs2: Convert gfs2_internal_read to folios
      gfs2: Rename gfs2_lookup_{ simple => meta }
      gfs2: No longer use 'extern' in function declarations
      gfs2: Remove ill-placed consistency check
      gfs2: Fix potential glock use-after-free on unmount
      gfs2: Mark withdraws as unlikely
      gfs2: Rename gfs2_withdrawn to gfs2_withdrawing_or_withdrawn
      gfs2: finish_xmote cleanup
      gfs2: do_xmote fixes
      kthread: add kthread_stop_put

Andrew Halaney (8):
      scsi: ufs: qcom: Perform read back after writing reset bit
      scsi: ufs: qcom: Perform read back after writing REG_UFS_SYS1CLK_1US
      scsi: ufs: qcom: Perform read back after writing unipro mode
      scsi: ufs: qcom: Perform read back after writing CGC enable
      scsi: ufs: cdns-pltfrm: Perform read back after writing HCLKDIV
      scsi: ufs: core: Perform read back after writing UTP_TASK_REQ_LIST_BASE_H
      scsi: ufs: core: Perform read back after disabling interrupts
      scsi: ufs: core: Perform read back after disabling UIC_COMMAND_COMPL

Andrey Konovalov (1):
      kasan, fortify: properly rename memintrinsics

Andrii Nakryiko (1):
      bpf: prevent r10 register from being marked as precise

Andy Chi (1):
      ALSA: hda/realtek: fix mute/micmute LEDs don't work for ProBook 440/460 G11.

Andy Shevchenko (7):
      ACPI: LPSS: Advertise number of chip selects via property
      iio: core: Leave private pointer NULL when no private data supplied
      serial: max3100: Lock port->lock when calling uart_handle_cts_change()
      serial: max3100: Update uart_driver_registered on driver removal
      serial: max3100: Fix bitwise types
      usb: fotg210: Add missing kernel doc description
      spi: Don't mark message DMA mapped when no transfer in it is

AngeloGioacchino Del Regno (1):
      ASoC: mediatek: Assign dummy when codec not specified for a DAI link

Anshuman Khandual (1):
      coresight: etm4x: Fix unbalanced pm_runtime_enable()

Anton Protopopov (1):
      bpf: Pack struct bpf_fib_lookup

Ard Biesheuvel (3):
      x86/boot/64: Clear most of CR4 in startup_64(), except PAE, MCE and LA57
      x86/purgatory: Switch to the position-independent small code model
      x86/efistub: Omit physical KASLR when memory reservations exist

Armin Wolf (1):
      ACPI: Fix Generic Initiator Affinity _OSC bit

Arnaldo Carvalho de Melo (1):
      perf probe: Add missing libgen.h header needed for using basename()

Arnd Bergmann (17):
      nilfs2: fix out-of-range warning
      crypto: ccp - drop platform ifdef checks
      enetc: avoid truncating error message
      qed: avoid truncating work queue length
      mlx5: avoid truncating error message
      mlx5: stop warning for 64KB pages
      wifi: carl9170: re-fix fortified-memset warning
      ACPI: disable -Wstringop-truncation
      fbdev: shmobile: fix snprintf truncation
      powerpc/fsl-soc: hide unused const variable
      fbdev: sisfb: hide unused variables
      media: rcar-vin: work around -Wenum-compare-conditional warning
      firmware: dmi-id: add a release callback function
      greybus: arche-ctrl: move device table to its right location
      module: don't ignore sysfs_create_link() failures
      Input: ims-pcu - fix printf string overflow
      drm/i915/guc: avoid FIELD_PREP warning

Arun T (2):
      ASoC: Intel: common: add ACPI matching tables for Arrow Lake
      ASoC: SOF: Intel: pci-mtl: use ARL specific firmware definitions

Baochen Qiang (2):
      wifi: ath10k: poll service ready message before failing
      wifi: ath11k: don't force enable power save on non-running vdevs

Bart Van Assche (1):
      scsi: ufs: core: mcq: Fix ufshcd_mcq_sqe_search()

Basavaraj Natikar (1):
      HID: amd_sfh: Handle "no sensors" in PM operations

Beau Belgrave (3):
      tracing/user_events: Allow events to persist for perfmon_capable users
      tracing/user_events: Prepare find/delete for same name events
      tracing/user_events: Fix non-spaced field matching

Benjamin Coddington (1):
      NFSv4: Fixup smatch warning for ambiguous return

Benjamin Gray (1):
      selftests/powerpc/dexcr: Add -no-pie to hashchk tests

Bibo Mao (1):
      LoongArch: Lately init pmu after smp is online

Binbin Zhou (3):
      dt-bindings: thermal: loongson,ls2k-thermal: Fix binding check issues
      dt-bindings: thermal: loongson,ls2k-thermal: Add Loongson-2K0500 compatible
      dt-bindings: thermal: loongson,ls2k-thermal: Fix incorrect compatible definition

Bjorn Andersson (1):
      soc: qcom: pmic_glink: Make client-lock non-sleeping

Bjorn Helgaas (1):
      x86/pci: Skip early E820 check for ECAM region

Bob Pearson (3):
      RDMA/rxe: Fix seg fault in rxe_comp_queue_pkt
      RDMA/rxe: Allow good work requests to be executed
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

Carlos López (1):
      tracing/probes: fix error check in parse_btf_field()

Carolina Jubran (1):
      net/mlx5e: Use rx_missed_errors instead of rx_dropped for reporting buffer exhaustion

Catalin Popescu (1):
      clk: rs9: fix wrong default value for clock amplitude

Cezary Rojewski (5):
      ASoC: Intel: Disable route checks for Skylake boards
      ASoC: Intel: avs: ssm4567: Do not ignore route checks
      ASoC: Intel: avs: Fix ASRC module initialization
      ASoC: Intel: avs: Fix potential integer overflow
      ASoC: Intel: avs: Test result of avs_get_module_entry()

Chandramohan Akula (2):
      RDMA/bnxt_re: Refactor the queue index update
      RDMA/bnxt_re: Remove roundup_pow_of_two depth for all hardware queue resources

Chao Yu (15):
      f2fs: multidev: fix to recognize valid zero block address
      f2fs: fix to wait on page writeback in __clone_blkaddrs()
      f2fs: compress: fix to relocate check condition in f2fs_{release,reserve}_compress_blocks()
      f2fs: compress: fix to relocate check condition in f2fs_ioc_{,de}compress_file()
      f2fs: fix to relocate check condition in f2fs_fallocate()
      f2fs: fix to check pinfile flag in f2fs_move_file_range()
      f2fs: support printk_ratelimited() in f2fs_printk()
      f2fs: compress: fix to update i_compr_blocks correctly
      f2fs: introduce get_available_block_count() for cleanup
      f2fs: compress: fix error path of inc_valid_block_count()
      f2fs: compress: fix to cover {reserve,release}_compress_blocks() w/ cp_rwsem lock
      f2fs: fix to release node block count in error path of f2fs_new_node_page()
      f2fs: compress: don't allow unaligned truncation on released compress inode
      f2fs: fix to add missing iput() in gc_data_segment()
      f2fs: use f2fs_{err,info}_ratelimited() for cleanup

Charles Keepax (1):
      ASoC: cs42l43: Only restrict 44.1kHz for the ASP

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

Christian Brauner (1):
      i915: make inject_virtual_interrupt() void

Christian Hewitt (1):
      drm/meson: vclk: fix calculation of 59.94 fractional rates

Christoph Hellwig (2):
      block: refine the EOF check in blkdev_iomap_begin
      virt: acrn: stop using follow_pfn

Christophe JAILLET (4):
      Bluetooth: Remove usage of the deprecated ida_simple_xx() API
      VMCI: Fix an error handling path in vmci_guest_probe_device()
      ppdev: Remove usage of the deprecated ida_simple_xx() API
      i2c: synquacer: Fix an error handling path in synquacer_i2c_probe()

Chuck Lever (2):
      SUNRPC: Fix gss_free_in_token_pages()
      SUNRPC: Fix loop termination condition in gss_free_in_token_pages()

Chun-Kuang Hu (1):
      soc: mediatek: cmdq: Fix typo of CMDQ_JUMP_RELATIVE

Clément Léger (1):
      selftests: sud_test: return correct emulated syscall value on RISC-V

Dae R. Jeong (1):
      tls: fix missing memory barrier in tls_init

Daeho Jeong (3):
      f2fs: separate f2fs_gc_range() to use GC for a range
      f2fs: support file pinning for zoned devices
      f2fs: write missing last sum blk of file pinning section

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

Danila Tikhonov (1):
      pinctrl: qcom: pinctrl-sm7150: Fix sdc1 and ufs special pins regs

Dave Airlie (3):
      nouveau: add an ioctl to return vram bar size.
      nouveau: add an ioctl to report vram usage
      nouveau: report byte usage in VRAM usage.

David Arinzon (1):
      net: ena: Reduce lines with longer column width boundary

David E. Box (3):
      tools/arch/x86/intel_sdsi: Fix maximum meter bundle length
      tools/arch/x86/intel_sdsi: Fix meter_show display
      tools/arch/x86/intel_sdsi: Fix meter_certificate decoding

David Hildenbrand (3):
      mm/userfaultfd: Do not place zeropages when zeropages are disallowed
      s390/mm: Re-enable the shared zeropage for !PV and !skeys KVM guests
      drivers/virt/acrn: fix PFNMAP PTE checks in acrn_vm_ram_map()

Derek Fang (2):
      ASoC: rt5645: Fix the electric noise due to the CBJ contacts floating
      ASoC: dt-bindings: rt5645: add cbj sleeve gpio property

Derek Foreman (1):
      drm/etnaviv: fix tx clock gating on some GC7000 variants

Detlev Casanova (1):
      drm/rockchip: vop2: Do not divide height twice for YUV

Devyn Liu (1):
      gpiolib: acpi: Fix failed in acpi_gpiochip_find() by adding parent node match

Dmitry Baryshkov (18):
      soc: qcom: pmic_glink: don't traverse clients list without a lock
      soc: qcom: pmic_glink: notify clients about the current state
      wifi: ath10k: populate board data for WCN3990
      drm/msm/dp: allow voltage swing / pre emphasis of 3
      drm/mipi-dsi: use correct return type for the DSC functions
      clk: qcom: dispcc-sm8450: fix DisplayPort clocks
      clk: qcom: dispcc-sm6350: fix DisplayPort clocks
      clk: qcom: dispcc-sm8550: fix DisplayPort clocks
      usb: typec: ucsi: always register a link to USB PD device
      usb: typec: ucsi: simplify partner's PD caps registration
      dt-bindings: phy: qcom,sc8280xp-qmp-ufs-phy: fix msm899[68] power-domains
      dt-bindings: phy: qcom,usb-snps-femto-v2: use correct fallback for sc8180x
      drm/msm/dpu: remove irq_idx argument from IRQ callbacks
      drm/msm/dpu: extract dpu_core_irq_is_valid() helper
      drm/msm/dpu: add helper to get IRQ-related data
      drm/msm/dpu: make the irq table size static
      drm/msm/dpu: stop using raw IRQ indices in the kernel output
      drm/msm/dpu: make error messages at dpu_core_irq_register_callback() more sensible

Dmitry Torokhov (1):
      Input: try trimming too long modalias strings

Dongli Zhang (1):
      genirq/cpuhotplug, x86/vector: Prevent vector leak during CPU offline

Dongliang Mu (1):
      media: flexcop-usb: fix sanity check of bNumEndpoints

Doug Berger (1):
      serial: 8250_bcm7271: use default_mux_rate if possible

Douglas Anderson (3):
      drm/dp: Don't attempt AUX transfers when eDP panels are not powered
      drm/panel: atna33xc20: Fix unbalanced regulator in the case HPD doesn't assert
      drm/msm/dp: Avoid a long timeout for AUX transfer if nothing connected

Duanqiang Wen (2):
      Revert "net: txgbe: fix i2c dev name cannot match clkdev"
      Revert "net: txgbe: fix clk_name exceed MAX_DEV_ID limits"

Duoming Zhou (8):
      wifi: brcmfmac: pcie: handle randbuf allocation failure
      ax25: Use kernel universal linked list to implement ax25_dev_list
      ax25: Fix reference count leak issues of ax25_dev
      ax25: Fix reference count leak issue of net_device
      lib/test_hmm.c: handle src_pfns and dst_pfns allocation failure
      PCI: of_property: Return error for int_map allocation failure
      watchdog: cpu5wdt.c: Fix use-after-free bug caused by cpu5wdt_trigger
      um: Fix return value in ubd_init()

Edward Liaw (1):
      selftests/kcmp: remove unused open mode

Eric Biggers (5):
      KEYS: asymmetric: Add missing dependency on CRYPTO_SIG
      KEYS: asymmetric: Add missing dependencies of FIPS_SIGNATURE_SELFTEST
      crypto: x86/nh-avx2 - add missing vzeroupper
      crypto: x86/sha256-avx2 - add missing vzeroupper
      crypto: x86/sha512-avx2 - add missing vzeroupper

Eric Dumazet (8):
      tcp: avoid premature drops in tcp_add_backlog()
      net: give more chances to rcu in netdev_wait_allrefs_any()
      usb: aqc111: stop lying about skb->truesize
      net: usb: sr9700: stop lying about skb->truesize
      net: usb: smsc95xx: stop lying about skb->truesize
      netrom: fix possible dead-lock in nr_rt_ioctl()
      af_packet: do not call packet_read_pending() from tpacket_destruct_skb()
      netfilter: nfnetlink_queue: acquire rcu_read_lock() in instance_destroy_rcu()

Eric Garver (1):
      netfilter: nft_fib: allow from forward/input without iif selector

Eric Sandeen (1):
      openpromfs: finish conversion to the new mount API

Eugen Hristev (1):
      media: mediatek: vcodec: fix possible unbalanced PM counter

Fabio Estevam (4):
      media: dt-bindings: ovti,ov2680: Fix the power supply names
      media: ov2680: Clear the 'ret' variable on success
      media: ov2680: Allow probing if link-frequencies is absent
      media: ov2680: Do not fail if data-lanes property is absent

Fedor Pchelkin (3):
      dma-mapping: benchmark: fix up kthread-related error handling
      dma-mapping: benchmark: fix node id validation
      dma-mapping: benchmark: handle NUMA_NO_NODE correctly

Felix Fietkau (2):
      wifi: mt76: mt7603: fix tx queue of loopback packets
      wifi: mt76: mt7603: add wpdma tx eof flag for PSE client reset

Felix Kuehling (1):
      drm/amdgpu: Update BO eviction priorities

Fenghua Yu (1):
      dmaengine: idxd: Avoid unnecessary destruction of file_ida

Fenglin Wu (1):
      Input: pm8xxx-vibrator - correct VIB_MAX_LEVELS calculation

Finn Thain (2):
      macintosh/via-macii: Fix "BUG: sleeping function called from invalid context"
      m68k: mac: Fix reboot hang on Mac IIci

Florian Fainelli (1):
      net: Always descend into dsa/ folder with CONFIG_NET_DSA enabled

Florian Westphal (1):
      netfilter: tproxy: bail out if IP has been disabled on the device

Frank Li (4):
      i3c: add actual_len in i3c_priv_xfer
      i3c: master: svc: rename read_len as actual_len
      i3c: master: svc: return actual transfer data len
      i3c: master: svc: change ENXIO to EAGAIN when IBI occurs during start frame

Friedrich Vock (1):
      bpf: Fix potential integer overflow in resolve_btfids

Gabor Juhos (1):
      clk: qcom: clk-alpha-pll: remove invalid Stromer register offset

Gabriel Krisman Bertazi (2):
      io-wq: write next_work before dropping acct_lock
      udp: Avoid call to compute_score on multiple sites

Gal Pressman (2):
      net/mlx5: Fix MTMP register capability offset in MCAM register
      net/mlx5e: Fix UDP GSO for encapsulated packets

Geert Uytterhoeven (5):
      sh: kprobes: Merge arch_copy_kprobe() into arch_prepare_kprobe()
      printk: Let no_printk() use _printk()
      dev_printk: Add and use dev_no_printk()
      clk: renesas: r8a779a0: Fix CANFD parent clock
      dt-bindings: PCI: rcar-pci-host: Add missing IOMMU properties

Geliang Tang (3):
      selftests/bpf: Fix umount cgroup2 error in test_sockmap
      selftests/bpf: Fix a fd leak in error paths in open_netns
      selftests: mptcp: add ms units for tc-netem delay

Gerald Loacker (3):
      drm/panel: sitronix-st7789v: fix timing for jt240mhqs_hwt_ek_e3 panel
      drm/panel: sitronix-st7789v: tweak timing for jt240mhqs_hwt_ek_e3 panel
      drm/panel: sitronix-st7789v: fix display size for jt240mhqs_hwt_ek_e3 panel

Gerd Hoffmann (1):
      KVM: x86: Don't advertise guest.MAXPHYADDR as host.MAXPHYADDR in CPUID

Giovanni Cabiddu (1):
      crypto: qat - specify firmware files for 402xx

Greg Kroah-Hartman (1):
      Linux 6.6.33

Guenter Roeck (3):
      mm/slub, kunit: Use inverted data to corrupt kmem cache
      Revert "sh: Handle calling csum_partial with misaligned data"
      hwmon: (shtc1) Fix property misspelling

Guixiong Wei (1):
      x86/boot: Ignore relocations in .notes sections in walk_relocs() too

Hagar Hemdan (1):
      efi: libstub: only free priv.runtime_map when allocated

Hangbin Liu (4):
      ipv6: sr: add missing seg6_local_exit
      ipv6: sr: fix incorrect unregister order
      ipv6: sr: fix invalid unregister error path
      ipv6: sr: fix memleak in seg6_hmac_init_algo

Hannah Peuckmann (1):
      riscv: dts: starfive: visionfive 2: Remove non-existing TDM hardware

Hannes Reinecke (1):
      nvme-tcp: add definitions for TLS cipher suites

Hans Verkuil (4):
      media: cec: cec-adap: always cancel work in cec_transmit_msg_fh
      media: cec: cec-api: add locking in cec_release()
      media: cec: core: avoid recursive cec_claim_log_addrs
      media: cec: core: avoid confusing "transmit timed out" message

Hans de Goede (3):
      ASoC: Intel: bytcr_rt5640: Apply Asus T100TA quirk to Asus T100TAM too
      iio: accel: mxc4005: Reset chip on probe() and resume()
      platform/x86: thinkpad_acpi: Take hotkey_mutex during hotkey_exit()

Hao Chen (1):
      drivers/perf: hisi: hns3: Actually use devm_add_action_or_reset()

Hariprasad Kelam (1):
      Octeontx2-pf: Free send queue buffers incase of leaf to inner

He Zhe (1):
      perf bench internals inject-build-id: Fix trap divide when collecting just one DSO

Hechao Li (1):
      tcp: increase the default TCP scaling ratio

Heiko Carstens (1):
      s390/vdso: Use standard stack frame layout

Heiner Kallweit (1):
      Revert "r8169: don't try to disable interrupts if NAPI is, scheduled already"

Helen Koike (2):
      drm/ci: uprev mesa version: fix container build & crosvm
      drm/ci: add subset-1-gfx to LAVA_TAGS and adjust shards

Henry Wang (1):
      drivers/xen: Improve the late XenStore init protocol

Herve Codina (1):
      net: lan966x: remove debugfs directory in probe() error path

Himanshu Madhani (1):
      scsi: qla2xxx: Fix debugfs output for fw_resource_count

Horatiu Vultur (3):
      net: micrel: Fix receiving the timestamp in the frame for lan8841
      net: lan966x: Remove ptp traps in case the ptp is not enabled.
      net: micrel: Fix lan8841_config_intr after getting out of sleep mode

Hsin-Te Yuan (2):
      drm/bridge: anx7625: Update audio status while detecting
      ASoC: mediatek: mt8192: fix register configuration for tdm

Huacai Chen (1):
      LoongArch: Fix callchain parse error with kernel tracepoint events again

Huai-Yuan Liu (2):
      drm/arm/malidp: fix a possible null pointer dereference
      ppdev: Add an error check in register_device

Hugo Villeneuve (3):
      serial: sc16is7xx: add proper sched.h include for sched_set_fifo()
      serial: sc16is7xx: replace hardcoded divisor value with BIT() macro
      serial: sc16is7xx: fix bug in sc16is7xx_set_baud() when using prescaler

INAGAKI Hiroshi (1):
      block: fix and simplify blkdevparts= cmdline parsing

Ian Rogers (16):
      perf record: Delete session after stopping sideband thread
      perf record: Lazy load kernel symbols
      perf machine thread: Remove exited threads by default
      perf bench uprobe: Remove lib64 from libc.so.6 binary path
      perf docs: Document bpf event modifier
      perf ui browser: Don't save pointer to stack memory
      perf ui browser: Avoid SEGV on title
      perf report: Avoid SEGV in report__setup_sample_type()
      perf thread: Fixes to thread__new() related to initializing comm
      perf maps: Move symbol maps functions to maps.c
      libsubcmd: Fix parse-options memory leak
      perf stat: Don't display metric header for non-leader uncore events
      perf tools: Use pmus to describe type from attribute
      perf tools: Add/use PMU reverse lookup from config to name
      perf pmu: Assume sysfs events are always the same case
      perf pmu: Count sys and cpuid JSON events separately

Igor Artemiev (1):
      wifi: cfg80211: fix the order of arguments for trace events of the tx_rx_evt class

Ilpo Järvinen (1):
      PCI: Wait for Link Training==0 before starting Link retrain

Ilya Denisyev (1):
      jffs2: prevent xattr node from overflowing the eraseblock

Ilya Leoshkevich (1):
      s390/bpf: Emit a barrier for BPF_FETCH instructions

Ilya Maximets (1):
      net: openvswitch: fix overwriting ct original tuple for ICMPv6

Irui Wang (1):
      media: mediatek: vcodec: add encoder power management helper functions

Iulia Tanasescu (1):
      Bluetooth: ISO: Fix BIS cleanup

Jack Xiao (1):
      drm/amdgpu/mes: fix use-after-free issue

Jack Yu (4):
      ASoC: rt722-sdca: modify channel number to support 4 channels
      ASoC: rt722-sdca: add headset microphone vrefo setting
      ASoC: rt715: add vendor clear control register
      ASoC: rt715-sdca: volume step modification

Jacob Keller (2):
      Revert "ixgbe: Manual AN-37 for troublesome link partners for X550 SFI"
      ice: fix accounting if a VLAN already exists

Jaegeuk Kim (3):
      f2fs: use BLKS_PER_SEG, BLKS_PER_SEC, and SEGS_PER_SEC
      f2fs: kill heap-based allocation
      f2fs: deprecate io_bits

Jaewon Kim (1):
      clk: samsung: exynosautov9: fix wrong pll clock id value

Jagan Teki (1):
      drm/bridge: Fix improper bridge init order with pre_enable_prev_first

Jakub Kicinski (3):
      eth: sungem: remove .ndo_poll_controller to avoid deadlocks
      selftests: net: add missing config for amt.sh
      selftests: net: move amt to socat for better compatibility

Jakub Sitnicki (1):
      bpf: Allow delete from sockmap/sockhash only if update is allowed

James Clark (7):
      perf tests: Make "test data symbol" more robust on Neoverse N1
      perf tests: Apply attributes to all events in object code reading test
      perf test shell arm_coresight: Increase buffer size for Coresight basic tests
      perf symbols: Fix ownership of string in dso__load_vmlinux()
      perf test: Add a test for strcmp_cpuid_str() expression
      perf pmu: Move pmu__find_core_pmu() to pmus.c
      perf util: Add a function for replacing characters in a string

Jan Kara (2):
      ext4: avoid excessive credit estimate in ext4_tmpfile()
      udf: Remove GFP_NOFS allocation in udf_expand_file_adinicb()

Jason Gunthorpe (1):
      IB/mlx5: Use __iowrite64_copy() for write combining stores

Jens Axboe (1):
      io_uring: use the right type for work_llist empty check

Jens Remus (2):
      s390/vdso: Generate unwind information for C modules
      s390/vdso: Create .build-id links for unstripped vdso files

Jiangfeng Xiao (1):
      arm64: asm-bug: Add .align 2 to the end of __BUG_ENTRY

Jiawen Wu (1):
      net: wangxun: fix to change Rx features

Jing Zhang (1):
      perf pmu: "Compat" supports regular expression matching identifiers

Jiri Olsa (1):
      libbpf: Fix error message in attach_kprobe_multi

Jiri Pirko (1):
      virtio: delete vq in vp_find_vqs_msix() when request_irq() fails

Johan Hovold (1):
      dt-bindings: spmi: hisilicon,hisi-spmi-controller: fix binding references

Johannes Berg (8):
      wifi: mac80211: don't use rate mask for scanning
      wifi: ieee80211: fix ieee80211_mle_basic_sta_prof_size_ok()
      wifi: iwlwifi: mvm: allocate STA links only for active links
      wifi: iwlwifi: mvm: select STA mask only for active links
      wifi: iwlwifi: reconfigure TLC during HW restart
      wifi: iwlwifi: mvm: fix check in iwl_mvm_sta_fw_id_mask
      wifi: iwlwifi: mvm: init vif works only once
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

KaiLong Wang (1):
      f2fs: Clean up errors in segment.h

Karthikeyan Kathirvel (1):
      wifi: ath12k: fix out-of-bound access of qmi_invoke_handler()

Kees Cook (3):
      kunit/fortify: Fix mismatched kvalloc()/vfree() usage
      lkdtm: Disable CFI checking for perms functions
      wifi: nl80211: Avoid address calculations via out of bounds array indexing

Keith Busch (1):
      nvme-multipath: fix io accounting on failover

Ken Milmore (1):
      r8169: Fix possible ring buffer corruption on fragmented Tx packets.

Kent Overstreet (1):
      kernel/numa.c: Move logging out of numa.h

Konrad Dybcio (2):
      interconnect: qcom: qcm2290: Fix mas_snoc_bimc QoS port assignment
      drm/msm/a6xx: Avoid a nullptr dereference when speedbin setting fails

Konstantin Komarov (7):
      fs/ntfs3: Remove max link count info display during driver init
      fs/ntfs3: Taking DOS names into account during link counting
      fs/ntfs3: Fix case when index is reused during tree transformation
      fs/ntfs3: Break dir enumeration if directory contents error
      fs/ntfs3: Check 'folio' pointer for NULL
      fs/ntfs3: Use 64 bit variable to avoid 32 bit overflow
      fs/ntfs3: Use variable length array instead of fixed size

Krzysztof Kozlowski (3):
      regulator: qcom-refgen: fix module autoloading
      regulator: vqmmc-ipq4019: fix module autoloading
      dt-bindings: PCI: rockchip,rk3399-pcie: Add missing maxItems to ep-gpios

Kuniyuki Iwashima (4):
      af_unix: Update unix_sk(sk)->oob_skb under sk_receive_queue lock.
      tcp: Fix shift-out-of-bounds in dctcp_update_alpha().
      af_unix: Annotate data-race around unix_sk(sk)->addr.
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

Laurent Pinchart (4):
      firmware: raspberrypi: Use correct device for DMA mappings
      media: v4l2-subdev: Fix stream handling for crop API
      media: v4l2-subdev: Document and enforce .s_stream() requirements
      media: vsp1: Remove unbalanced .s_stream(0) calls

Le Ma (1):
      drm/amdgpu: init microcode chip name from ip versions

Leo Ma (1):
      drm/amd/display: Fix DC mode screen flickering on DCN321

Leon Romanovsky (1):
      RDMA/IPoIB: Fix format truncation compilation errors

Li Zhijian (1):
      cxl/region: Fix cxlr_pmem leaks

Lijo Lazar (1):
      drm/amd/pm: Restore config space after reset

Linus Torvalds (2):
      x86/mm: Remove broken vsyscall emulation code from the page fault code
      epoll: be better about file lifetimes

Linus Walleij (1):
      net: ethernet: cortina: Locking fixes

Lorenzo Bianconi (1):
      wifi: mt76: mt7915: workaround too long expansion sparse warnings

Luca Ceresoli (2):
      iio: accel: mxc4005: allow module autoloading via OF compatible
      Revert "drm/bridge: ti-sn65dsi83: Fix enable error path"

Luiz Augusto von Dentz (1):
      Bluetooth: HCI: Remove HCI_AMP support

Lukas Bulwahn (1):
      Bluetooth: hci_event: Remove code to removed CONFIG_BT_HS

Luke D. Jones (1):
      ALSA: hda/realtek: Adjust G814JZR to use SPI init for amp

MD Danish Anwar (1):
      net: ti: icssg-prueth: Fix start counter for ft1 filter

Maher Sanalla (2):
      net/mlx5: Reload only IB representors upon lag disable/enable
      net/mlx5: Lag, do bond only if slaves agree on roce state

Marc Gonzalez (1):
      clk: qcom: mmcc-msm8998: fix venus clock issue

Marco Pagani (3):
      fpga: manager: add owner module and take its refcount
      fpga: bridge: add owner module and take its refcount
      fpga: region: add owner module and take its refcount

Marek Szyprowski (1):
      Input: cyapa - add missing input core locking to suspend/resume functions

Marek Vasut (2):
      drm/lcdif: Do not disable clocks on already suspended hardware
      drm/panel: simple: Add missing Innolux G121X1-L03 format, flags, connector

Marijn Suijten (2):
      drm/msm/dsi: Print dual-DSI-adjusted pclk instead of original mode pclk
      drm/msm/dpu: Always flush the slave INTF on the CTL

Mario Limonciello (1):
      drm/amd/display: Enable colorspace property for MST connectors

Martin Kaiser (1):
      nfs: keep server info for remounts

Masahiro Yamada (4):
      kbuild: unify vdso_install rules
      kbuild: fix build ID symlinks to installed debug VDSO files
      x86/kconfig: Select ARCH_WANT_FRAME_POINTERS again when UNWINDER_FRAME_POINTER=y
      kconfig: fix comparison to constant symbols, 'm', 'n'

Masami Hiramatsu (Google) (1):
      selftests/ftrace: Fix BTFARG testcase to check fprobe is enabled correctly

Mathieu Othacehe (1):
      net: phy: micrel: set soft_reset callback to genphy_soft_reset for KSZ8061

Matthew Bystrin (1):
      riscv: stacktrace: fixed walk_stackframe()

Matthew R. Ochs (1):
      tpm_tis_spi: Account for SPI header when allocating TPM SPI xfer buffer

Matthew Wilcox (Oracle) (1):
      udf: Convert udf_expand_file_adinicb() to use a folio

Matthias Schiffer (2):
      net: dsa: mv88e6xxx: Add support for model-specific pre- and post-reset handlers
      net: dsa: mv88e6xxx: Avoid EEPROM timeout without EEPROM on 88E6250-family switches

Matthieu Baerts (NGI0) (3):
      mptcp: SO_KEEPALIVE: fix getsockopt support
      selftests: mptcp: simult flows: mark 'unbalanced' tests as flaky
      selftests: mptcp: join: mark 'fail' tests as flaky

Matti Vaittinen (5):
      regulator: irq_helpers: duplicate IRQ name
      watchdog: bd9576: Drop "always-running" property
      regulator: bd71828: Don't overwrite runtime voltages
      regulator: pickable ranges: don't always cache vsel
      regulator: tps6287x: Force writing VSEL bit

Maurizio Lombardi (2):
      nvmet-auth: return the error code to the nvmet_auth_host_hash() callers
      nvmet-auth: replace pr_debug() with pr_err() to report an error.

Maxim Korotkov (1):
      mtd: rawnand: hynix: fixed typo

Maxime Ripard (1):
      ARM: configs: sunxi: Enable DRM_DW_HDMI

Meenakshikumar Somasundaram (1):
      drm/amd/display: Allocate zero bw after bw alloc enable

Michael Schmitz (1):
      m68k: Fix spinlock race in kernel thread creation

Michael Walle (1):
      drm/bridge: tc358775: fix support for jeida-18 and jeida-24

Michal Schmidt (2):
      selftests/bpf: Fix pointer arithmetic in test_xdp_do_redirect
      bnxt_re: avoid shift undefined behavior in bnxt_qplib_alloc_init_hwq

Michal Simek (2):
      microblaze: Remove gcc flag for non existing early_printk.c file
      microblaze: Remove early printk call from cpuinfo-static.c

Mickaël Salaün (1):
      kunit: Fix kthread reference

Miguel Ojeda (1):
      kheaders: use `command -v` to test for existence of `cpio`

Miklos Szeredi (1):
      ovl: remove upper umask handling from ovl_create_upper()

Ming Lei (3):
      io_uring: fail NOP if non-zero op flags is passed in
      blk-cgroup: fix list corruption from resetting io stat
      blk-cgroup: fix list corruption from reorder of WRITE ->lqueued

Mohamed Ahmed (1):
      drm/nouveau: use tile_mode and pte_kind for VM_BIND bo allocations

Mukesh Ojha (1):
      firmware: qcom: scm: Fix __scm and waitq completion variable initialization

Mukul Joshi (2):
      drm/amdkfd: Add VRAM accounting for SVM migration
      drm/amdgpu: Fix VRAM memory accounting

Namhyung Kim (8):
      perf annotate: Get rid of duplicate --group option item
      perf annotate: Split branch stack cycles information out of 'struct annotation_line'
      perf annotate: Introduce global annotation_options
      perf report: Convert to the global annotation_options
      perf top: Convert to the global annotation_options
      perf annotate: Use global annotation_options
      perf annotate: Fix annotation_calc_lines() to pass correct address to get_srcline()
      perf/arm-dmc620: Fix lockdep assert in ->event_init()

Namjae Jeon (2):
      ksmbd: avoid to send duplicate oplock break notifications
      ksmbd: fix uninitialized symbol 'share' in smb2_tree_connect()

Nandor Kracser (1):
      ksmbd: ignore trailing slashes in share paths

Nathan Lynch (1):
      powerpc/pseries/lparcfg: drop error message from guest name lookup

Neha Malcom Francis (1):
      regulator: tps6594-regulator: Correct multi-phase configuration

Neil Armstrong (2):
      phy: qcom: qmp-combo: fix duplicate return in qmp_v4_configure_dp_phy
      drm/meson: gate px_clk when setting rate

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

Nilay Shroff (2):
      nvme: find numa distance only if controller has valid numa id
      nvme: cancel pending I/O if nvme controller is in terminal state

Nuno Sa (10):
      iio: adc: ad9467: use spi_get_device_match_data()
      iio: adc: ad9467: use chip_info variables instead of array
      iio: adc: adi-axi-adc: convert to regmap
      iio: buffer-dmaengine: export buffer alloc and free functions
      iio: add the IIO backend framework
      iio: adc: ad9467: convert to backend framework
      iio: adc: adi-axi-adc: move to backend framework
      iio: adc: adi-axi-adc: only error out in major version mismatch
      dt-bindings: adc: axi-adc: update bindings for backend framework
      dt-bindings: adc: axi-adc: add clocks property

Nícolas F. R. A. Prado (9):
      drm/bridge: anx7625: Don't log an error when DSI host can't be found
      drm/bridge: icn6211: Don't log an error when DSI host can't be found
      drm/bridge: lt8912b: Don't log an error when DSI host can't be found
      drm/bridge: lt9611: Don't log an error when DSI host can't be found
      drm/bridge: lt9611uxc: Don't log an error when DSI host can't be found
      drm/bridge: tc358775: Don't log an error when DSI host can't be found
      drm/bridge: dpc3433: Don't log an error when DSI host can't be found
      drm/panel: novatek-nt35950: Don't log an error when DSI host can't be found
      clk: mediatek: pllfh: Don't log error for missing fhctl node

Oleg Nesterov (1):
      sched/isolation: Fix boot crash when maxcpus < first housekeeping CPU

Olga Kornievskaia (1):
      pNFS/filelayout: fixup pNfs allocation modes

Oliver Upton (1):
      KVM: selftests: Add test for uaccesses to non-existent vgic-v2 CPUIF

Or Har-Toov (2):
      RDMA/mlx5: Uncacheable mkey has neither rb_key or cache_ent
      RDMA/mlx5: Adding remote atomic access flag to updatable flags

Oswald Buddenhagen (1):
      ALSA: emu10k1: make E-MU FPGA writes potentially more reliable

Pablo Neira Ayuso (2):
      netfilter: nft_payload: restore vlan q-in-q match support
      netfilter: nft_payload: skbuff vlan metadata mangle support

Paolo Abeni (3):
      tcp: define initial scaling factor value as a macro
      selftests: net: add more missing kernel config
      net: relax socket state check at accept time.

Parthiban Veerasooran (1):
      net: usb: smsc95xx: fix changing LED_SEL bit value updated from EEPROM

Peter Colberg (2):
      fpga: dfl-pci: add PCI subdevice ID for Intel D5005 card
      hwmon: (intel-m10-bmc-hwmon) Fix multiplier for N6000 board power sensor

Peter Oberparleiter (1):
      s390/cio: fix tracepoint subchannel type field

Peter Ujfalusi (4):
      ASoC: SOF: Intel: mtl: Correct rom_status_reg
      ASoC: SOF: Intel: lnl: Correct rom_status_reg
      ASoC: SOF: Intel: mtl: Disable interrupts when firmware boot failed
      ASoC: SOF: Intel: mtl: Implement firmware boot state check

Petr Pavlu (1):
      ring-buffer: Fix a race between readers and resize checks

Pierre-Louis Bossart (4):
      ASoC: da7219-aad: fix usage of device_get_named_child_node()
      ALSA: hda: intel-dsp-config: harden I2C/I2S codec detection
      ASoC: SOF: Intel: pci-mtl: fix ARL-S definitions
      soundwire: cadence: fix invalid PDI offset

Pin-yen Lin (1):
      serial: 8520_mtk: Set RTS on shutdown for Rx in-band wakeup

Portia Stephens (1):
      cpufreq: brcmstb-avs-cpufreq: ISO C90 forbids mixed declarations

Pratyush Yadav (1):
      media: cadence: csi2rx: configure DPHY before starting source stream

Prike Liang (1):
      drm/amdgpu: Fix the ring buffer size for queue VM flush

Puranjay Mohan (2):
      bpf, x86: Fix PROBE_MEM runtime load check
      riscv, bpf: make some atomic operations fully ordered

Rafał Miłecki (1):
      dt-bindings: pinctrl: mediatek: mt7622: fix array properties

Rahul Rameshbabu (2):
      net/mlx5: Use mlx5_ipsec_rx_status_destroy to correctly delete status rules
      net/mlx5e: Fix IPsec tunnel mode offload feature check

Randy Dunlap (4):
      fbdev: sh7760fb: allow modular build
      counter: linux/counter.h: fix Excess kernel-doc description warning
      extcon: max8997: select IRQ_DOMAIN instead of depending on it
      media: sunxi: a83-mips-csi2: also select GENERIC_PHY

Ranjani Sridharan (1):
      ASoC: SOF: pcm: Restrict DSP D0i3 during S0ix to IPC3

Ricardo Ribalda (2):
      media: radio-shark2: Avoid led_names truncations
      media: uvcvideo: Add quirk for Logitech Rally Bar

Richard Fitzgerald (5):
      ALSA: hda: cs35l56: Exit cache-only after cs35l56_wait_for_firmware_boot()
      ALSA: hda/cs_dsp_ctl: Use private_free for control cleanup
      ASoC: cs35l56: Fix to ensure ASP1 registers match cache
      ALSA: hda: cs35l56: Initialize all ASP1 registers
      ALSA: hda: cs35l56: Fix lifetime of cs_dsp instance

Richard Kinder (1):
      wifi: mac80211: ensure beacon is non-S1G prior to extracting the beacon timestamp field

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

Roger Pau Monne (1):
      xen/x86: add extra pages to unpopulated-alloc if available

Romain Gantois (1):
      net: ti: icssg_prueth: Fix NULL pointer dereference in prueth_probe()

Rui Miguel Silva (1):
      greybus: lights: check return of get_channel_from_mode

Ryosuke Yasuoka (2):
      nfc: nci: Fix uninit-value in nci_rx_work
      nfc: nci: Fix handling of zero-length payload packets in nci_rx_work()

Ryusuke Konishi (3):
      nilfs2: fix use-after-free of timer for log writer thread
      nilfs2: fix unexpected freezing of nilfs_segctor_sync()
      nilfs2: fix potential hang in nilfs_detach_log_writer()

Sagi Grimberg (3):
      nvmet-tcp: fix possible memory leak when tearing down a controller
      nvmet: fix nvme status code when namespace is disabled
      nvmet: fix ns enable/disable possible hang

Sahil Siddiq (1):
      bpftool: Mount bpffs on provided dir instead of parent dir

Sai Pavan Boddu (1):
      i2c: cadence: Avoid fifo clear after start

Sakari Ailus (2):
      media: ipu3-cio2: Request IRQ earlier
      media: v4l: Don't turn on privacy LED if streamon fails

Samasth Norway Ananda (1):
      perf daemon: Fix file leak in daemon_session__control

Sean Anderson (1):
      drm: zynqmp_dpsub: Always register bridge

Sean Christopherson (1):
      cpu: Ignore "mitigations" kernel parameter if CPU_MITIGATIONS=n

Sean Young (1):
      pwm: Rename pwm_apply_state() to pwm_apply_might_sleep()

Sebastian Urban (1):
      Bluetooth: compute LE flow credits based on recvbuf space

Selvin Xavier (3):
      RDMA/bnxt_re: Update the HW interface definitions
      RDMA/bnxt_re: Adds MSN table capability for Gen P7 adapters
      RDMA/bnxt_re: Fix the sparse warnings

Sergey Matyukevich (1):
      riscv: prevent pt_regs corruption for secondary idle threads

Sergey Shtylyov (1):
      of: module: add buffer overflow check in of_modalias()

Shay Agroskin (1):
      net: ena: Fix redundant device NUMA node override

Shay Drory (1):
      net/mlx5: Enable 4 ports multiport E-switch

Shenghao Ding (3):
      ASoC: tas2781: Fix a warning reported by robot kernel test
      ASoC: tas2552: Add TX path for capturing AUDIO-OUT data
      ASoC: tas2781: Fix wrong loading calibrated data sequence

Shrikanth Hegde (2):
      sched/fair: Add EAS checks before updating root_domain::overutilized
      powerpc/pseries: Add failure related checks for h_get_mpp and h_get_ppp

Shuah Khan (1):
      tools/latency-collector: Fix -Wformat-security compile warns

Souradeep Chakrabarti (1):
      net: mana: Fix the extra HZ in mana_hwc_send_request

Srinivas Pandruvada (3):
      platform/x86: ISST: Add Grand Ridge to HPM CPU list
      platform/x86/intel/tpmi: Handle error from tpmi_process_info()
      platform/x86/intel-uncore-freq: Don't present root domain on error

Srinivasan Shanmugam (2):
      drm/amd/display: Fix potential index out of bounds in color transformation function
      drm/amdgpu: Fix buffer size in gfx_v9_4_3_init_ cp_compute_microcode() and rlc_microcode()

Stafford Horne (1):
      openrisc: traps: Don't send signals to kernel mode threads

Stanislav Fomichev (1):
      bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type enforcement in BPF_LINK_CREATE

Stefan Binding (1):
      ASoC: cs35l41: Update DSP1RX5/6 Sources for DSP config

Steven Rostedt (1):
      ASoC: tracing: Export SND_SOC_DAPM_DIR_OUT to its value

Steven Rostedt (Google) (5):
      eventfs: Do not differentiate the toplevel events directory
      eventfs: Create eventfs_root_inode to store dentry
      eventfs/tracing: Add callback for release of an eventfs_inode
      eventfs: Free all of the eventfs_inode after RCU
      eventfs: Have "events" directory get permissions from its parent

Su Hui (1):
      wifi: ath10k: Fix an error code problem in ath10k_dbg_sta_write_peer_debug_trigger()

Sumanth Korikkar (1):
      s390/vdso64: filter out munaligned-symbols flag for vdso

Sung Joon Kim (1):
      drm/amd/display: Disable seamless boot on 128b/132b encoding

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

Takashi Iwai (9):
      ALSA: core: Fix NULL module pointer assignment at card init
      ALSA: Fix deadlocks with kctl removals at disconnection
      ALSA: jack: Use guard() for locking
      ALSA: core: Remove debugfs at disconnection
      ALSA: seq: Fix missing bank setup between MIDI1/MIDI2 UMP conversion
      ALSA: seq: Don't clear bank selection at event -> UMP MIDI2 conversion
      ALSA: seq: Fix yet another spot for system message conversion
      ALSA: seq: ump: Fix swapped song position pointer data
      ALSA: timer: Set lower bound of start tick time

Tetsuo Handa (1):
      dma-buf/sw-sync: don't enable IRQ from sync_print_obj()

Thomas Haemmerle (1):
      iio: pressure: dps310: support negative temperature values

Thomas Richter (1):
      perf stat: Do not fail on metrics on s390 z/VM systems

Thomas Weißschuh (2):
      misc/pvpanic: deduplicate common code
      misc/pvpanic-pci: register attributes via pci_driver

Thomas Zimmermann (1):
      fbdev: Provide I/O-memory helpers as module

Thorsten Blum (1):
      net: smc91x: Fix m68k kernel compilation for ColdFire CPU

Tianchen Ding (1):
      selftests: cgroup: skip test_cgcore_lesser_ns_open when cgroup2 mounted without nsdelegate

Tiwei Bie (3):
      um: Fix the -Wmissing-prototypes warning for __switch_mm
      um: Fix the -Wmissing-prototypes warning for get_thread_reg
      um: Fix the declaration of kasan_map_memory

Tony Lindgren (2):
      drm/omapdrm: Fix console by implementing fb_dirty
      drm/omapdrm: Fix console with deferred ops

Tristram Ha (1):
      net: dsa: microchip: fix RGMII error in KSZ DSA driver

Uros Bizjak (1):
      locking/atomic/x86: Correct the definition of __arch_try_cmpxchg128()

Uwe Kleine-König (5):
      pwm: sti: Prepare removing pwm_chip from driver data
      pwm: sti: Simplify probe function using devm functions
      media: i2c: et8ek8: Don't strip remove function when driver is builtin
      leds: pwm: Disable PWM when going to suspend
      spi: stm32: Don't warn about spurious interrupts

Valentin Obst (1):
      selftests: default to host arch for LLVM builds

Vicki Pfau (1):
      Input: xpad - add support for ASUS ROG RAIKIRI

Vidya Sagar (1):
      PCI: tegra194: Fix probe path for Endpoint mode

Vignesh Raghavendra (1):
      mmc: sdhci_am654: Drop lookup for deprecated ti,otap-del-sel

Vignesh Raman (1):
      drm/ci: update device type for volteer devices

Ville Syrjälä (1):
      drm/edid: Parse topology block for all DispID structure v1.x

Viresh Kumar (1):
      cpufreq: exit() callback is optional

Vitalii Bursov (1):
      sched/fair: Allow disabling sched_balance_newidle with sched_relax_domain_level

Vladimir Oltean (2):
      net/sched: taprio: make q->picos_per_byte available to fill_sched_entry()
      net/sched: taprio: extend minimum interval restriction to entire cycle too

Waiman Long (1):
      blk-cgroup: Properly propagate the iostat update up the hierarchy

Wang Yao (1):
      modules: Drop the .export_symbol section from the final modules

Wei Fang (2):
      net: fec: remove .ndo_poll_controller to avoid deadlocks
      net: fec: avoid lock evasion when reading pps_enable

Wenjing Liu (1):
      drm/amd/display: Revert Remove pixle rate limit for subvp

Wojciech Macek (1):
      drm/mediatek: dp: Fix mtk_dp_aux_transfer return value

Wolfram Sang (2):
      dt-bindings: PCI: rcar-pci-host: Add optional regulators
      serial: sh-sci: protect invalidating RXDMA on shutdown

Wu Bo (1):
      f2fs: fix block migration when section is not aligned to pow2

Xianwei Zhao (1):
      arm64: dts: meson: fix S4 power-controller node

Xiaolei Wang (1):
      net:fec: Add fec_enet_deinit()

Xingui Yang (1):
      scsi: libsas: Fix the failure of adding phy with zero-address to port

Yang Jihong (4):
      perf evlist: Add evlist__findnew_tracking_event() helper
      perf record: Move setting tracking events before record__init_thread_masks()
      perf evlist: Add perf_evlist__go_system_wide() helper
      perf sched timehist: Fix -g/--call-graph option failure

Yang Li (1):
      rv: Update rv_en(dis)able_monitor doc to match kernel-doc

Ye Bin (1):
      vfio/pci: fix potential memory leak in vfio_intx_enable()

Yi Liu (1):
      iommu: Undo pasid attachment only for the devices that have succeeded

Yong Zhi (1):
      ASoC: SOF: Intel: mtl: call dsp dump when boot retry fails

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

Zhang Yi (1):
      ext4: remove the redundant folio_wait_stable()

Zheng Yejian (1):
      ftrace: Fix possible use-after-free issue in ftrace_location()

Zhengchao Shao (1):
      RDMA/hns: Fix return value in hns_roce_map_mr_sg

Zhipeng Lu (1):
      media: atomisp: ssh_css: Fix a null-pointer dereference in load_video_binaries

Zhu Yanjun (3):
      null_blk: Fix missing mutex_destroy() at module removal
      RDMA/cma: Fix kmemleak in rdma_core observed during blktests nvme/rdma use siw
      null_blk: Fix the WARNING: modpost: missing MODULE_DESCRIPTION()

Zqiang (1):
      softirq: Fix suspicious RCU usage in __do_softirq()

end.to.start (1):
      ASoC: acp: Support microphone from device Acer 315-24p

gaoxingwang (1):
      net: ipv6: fix wrong start position when receive hop-by-hop fragment


