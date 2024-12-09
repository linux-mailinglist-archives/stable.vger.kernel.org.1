Return-Path: <stable+bounces-100125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF089E90DB
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 11:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90BCC163673
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 10:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8751A218590;
	Mon,  9 Dec 2024 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JsU89VHr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CAA218583;
	Mon,  9 Dec 2024 10:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741300; cv=none; b=LC5BfehOYLH+H8KFAAIQ+EKQY6s4xljdfuE36WG/Je/wN//+JQK9w+LvK4o96LHgH0+XA6ur5dFn2FG078EfbqCKnnuTLquELvxk638KtpdVMZi0BKHb39Ny5v34r9ousBBJ8hYLacSHBPi44mf83nh1KWE/JvralXt9C8QBBVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741300; c=relaxed/simple;
	bh=IhZ4atQXBsyW/pgAlTMt31aXLUUlzec9UTKlOUgY2KY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E20LnLIlYtEjN9TbRB5Av33q+h0e+PSOfgHGUNdMYkt+2AYx78Veu3JPPxLjBqS09ffU+MGlTccVYrV9I4/Y3DTzt+96dbG9BvqxWS/AQiZaA50J5NtZlmGWGlra3YpjJAj417dMEB/GXkQjJC/99Htjooyr0IYLwwiQI8xw9AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JsU89VHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C543C4CED1;
	Mon,  9 Dec 2024 10:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733741297;
	bh=IhZ4atQXBsyW/pgAlTMt31aXLUUlzec9UTKlOUgY2KY=;
	h=From:To:Cc:Subject:Date:From;
	b=JsU89VHrdwot7LSlv0tIvMKy31DdDliy2P56ZY/H36t9xlzsxi9mNfn0dOAKuUPZa
	 gnRY2JXMigXCIxH+j66an7FFtn4duck9nKethh+f/hAqAl3XhPgMCUQ87SFeQQpUBt
	 2RITkBUW+mKJxOf67pq1W2nuRPHnr1rjRb8w8BPU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.64
Date: Mon,  9 Dec 2024 11:48:11 +0100
Message-ID: <2024120911-obstacle-fondly-b810@gregkh>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.64 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-fs-f2fs                           |    7 
 Documentation/RCU/stallwarn.rst                                   |    2 
 Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml       |   22 
 Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml        |    2 
 Documentation/devicetree/bindings/serial/rs485.yaml               |   19 
 Documentation/devicetree/bindings/sound/mt6359.yaml               |   10 
 Documentation/devicetree/bindings/vendor-prefixes.yaml            |    2 
 Documentation/filesystems/mount_api.rst                           |    3 
 Documentation/locking/seqlock.rst                                 |    2 
 Documentation/networking/j1939.rst                                |    2 
 Makefile                                                          |    2 
 arch/arc/kernel/devtree.c                                         |    2 
 arch/arm/boot/dts/allwinner/sun9i-a80-cubieboard4.dts             |    4 
 arch/arm/boot/dts/microchip/sam9x60.dtsi                          |   12 
 arch/arm/boot/dts/ti/omap/omap36xx.dtsi                           |    1 
 arch/arm/kernel/devtree.c                                         |    2 
 arch/arm/kernel/entry-armv.S                                      |    8 
 arch/arm/kernel/head.S                                            |    4 
 arch/arm/kernel/psci_smp.c                                        |    7 
 arch/arm/mm/idmap.c                                               |    7 
 arch/arm/mm/ioremap.c                                             |   35 +
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi           |    3 
 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi                  |    2 
 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi                  |    2 
 arch/arm64/boot/dts/mediatek/mt6357.dtsi                          |    5 
 arch/arm64/boot/dts/mediatek/mt6358.dtsi                          |    9 
 arch/arm64/boot/dts/mediatek/mt6359.dtsi                          |    5 
 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi                 |    8 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts      |    3 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts       |    2 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts        |    3 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi     |    3 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi            |   30 -
 arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi             |    4 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi             |    4 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi              |    4 
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi                   |    2 
 arch/arm64/boot/dts/mediatek/mt8195.dtsi                          |    4 
 arch/arm64/boot/dts/qcom/sc8180x.dtsi                             |    2 
 arch/arm64/boot/dts/qcom/sm6350.dtsi                              |   14 
 arch/arm64/boot/dts/renesas/hihope-rev2.dtsi                      |    3 
 arch/arm64/boot/dts/renesas/hihope-rev4.dtsi                      |    3 
 arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts          |    2 
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi                        |    2 
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts             |    2 
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi                         |   46 +-
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi                   |   18 
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi                   |    6 
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi                        |   16 
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi                  |    6 
 arch/arm64/include/asm/insn.h                                     |    1 
 arch/arm64/include/asm/kvm_host.h                                 |    2 
 arch/arm64/kernel/probes/decode-insn.c                            |    7 
 arch/arm64/kernel/process.c                                       |    2 
 arch/arm64/kernel/setup.c                                         |    6 
 arch/arm64/kernel/vmlinux.lds.S                                   |    6 
 arch/arm64/kvm/arch_timer.c                                       |    3 
 arch/arm64/kvm/arm.c                                              |   18 
 arch/arm64/kvm/pmu-emul.c                                         |    1 
 arch/arm64/kvm/vgic/vgic-its.c                                    |   32 -
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                                |    7 
 arch/arm64/kvm/vgic/vgic.h                                        |   23 +
 arch/arm64/net/bpf_jit_comp.c                                     |   47 +-
 arch/csky/kernel/setup.c                                          |    4 
 arch/loongarch/include/asm/page.h                                 |    5 
 arch/loongarch/kernel/setup.c                                     |    2 
 arch/loongarch/net/bpf_jit.c                                      |    2 
 arch/loongarch/vdso/Makefile                                      |    2 
 arch/m68k/coldfire/device.c                                       |    8 
 arch/m68k/include/asm/mcfgpio.h                                   |    2 
 arch/m68k/include/asm/mvme147hw.h                                 |    4 
 arch/m68k/kernel/early_printk.c                                   |    9 
 arch/m68k/mvme147/config.c                                        |   30 +
 arch/m68k/mvme147/mvme147.h                                       |    6 
 arch/m68k/mvme16x/config.c                                        |    2 
 arch/m68k/mvme16x/mvme16x.h                                       |    6 
 arch/microblaze/kernel/microblaze_ksyms.c                         |   10 
 arch/microblaze/kernel/prom.c                                     |    2 
 arch/mips/include/asm/switch_to.h                                 |    2 
 arch/mips/kernel/prom.c                                           |    2 
 arch/mips/kernel/relocate.c                                       |    2 
 arch/nios2/kernel/prom.c                                          |    4 
 arch/openrisc/Kconfig                                             |    3 
 arch/openrisc/include/asm/fixmap.h                                |   21 
 arch/openrisc/kernel/prom.c                                       |    2 
 arch/openrisc/mm/init.c                                           |   37 +
 arch/parisc/kernel/ftrace.c                                       |    2 
 arch/powerpc/Kconfig                                              |    4 
 arch/powerpc/Makefile                                             |   13 
 arch/powerpc/include/asm/dtl.h                                    |    4 
 arch/powerpc/include/asm/fadump.h                                 |    7 
 arch/powerpc/include/asm/sstep.h                                  |    5 
 arch/powerpc/include/asm/vdso.h                                   |    1 
 arch/powerpc/kernel/dt_cpu_ftrs.c                                 |    2 
 arch/powerpc/kernel/fadump.c                                      |   23 -
 arch/powerpc/kernel/prom.c                                        |    2 
 arch/powerpc/kernel/setup-common.c                                |    6 
 arch/powerpc/kernel/setup_64.c                                    |    1 
 arch/powerpc/kernel/vmlinux.lds.S                                 |    2 
 arch/powerpc/kexec/file_load_64.c                                 |    9 
 arch/powerpc/kvm/book3s_hv.c                                      |   10 
 arch/powerpc/kvm/book3s_hv_nested.c                               |   14 
 arch/powerpc/lib/sstep.c                                          |   12 
 arch/powerpc/mm/fault.c                                           |   10 
 arch/powerpc/platforms/pseries/dtl.c                              |    8 
 arch/powerpc/platforms/pseries/lpar.c                             |    8 
 arch/powerpc/platforms/pseries/plpks.c                            |    2 
 arch/riscv/kernel/setup.c                                         |    2 
 arch/riscv/kvm/aia_aplic.c                                        |    3 
 arch/s390/include/asm/set_memory.h                                |    1 
 arch/s390/kernel/entry.S                                          |    4 
 arch/s390/kernel/kprobes.c                                        |    6 
 arch/s390/kernel/syscalls/Makefile                                |    2 
 arch/s390/mm/pageattr.c                                           |   15 
 arch/sh/kernel/cpu/proc.c                                         |    2 
 arch/sh/kernel/setup.c                                            |    2 
 arch/um/drivers/net_kern.c                                        |    2 
 arch/um/drivers/ubd_kern.c                                        |    2 
 arch/um/drivers/vector_kern.c                                     |    3 
 arch/um/kernel/dtb.c                                              |   16 
 arch/um/kernel/physmem.c                                          |    6 
 arch/um/kernel/process.c                                          |    2 
 arch/um/kernel/sysrq.c                                            |    2 
 arch/x86/Makefile                                                 |    3 
 arch/x86/coco/tdx/tdcall.S                                        |   56 --
 arch/x86/coco/tdx/tdx-shared.c                                    |    8 
 arch/x86/coco/tdx/tdx.c                                           |  145 ++++--
 arch/x86/crypto/aegis128-aesni-asm.S                              |   29 -
 arch/x86/entry/entry.S                                            |   15 
 arch/x86/events/intel/core.c                                      |   34 +
 arch/x86/events/intel/pt.c                                        |   11 
 arch/x86/events/intel/pt.h                                        |    2 
 arch/x86/include/asm/amd_nb.h                                     |    5 
 arch/x86/include/asm/asm-prototypes.h                             |    3 
 arch/x86/include/asm/shared/tdx.h                                 |   31 -
 arch/x86/kernel/asm-offsets.c                                     |   12 
 arch/x86/kernel/cpu/common.c                                      |    2 
 arch/x86/kernel/devicetree.c                                      |   26 -
 arch/x86/kernel/unwind_orc.c                                      |    2 
 arch/x86/kernel/vmlinux.lds.S                                     |    3 
 arch/x86/kvm/mmu/spte.c                                           |   18 
 arch/x86/platform/pvh/head.S                                      |   22 
 arch/x86/virt/vmx/tdx/tdxcall.S                                   |  104 ++--
 arch/xtensa/kernel/setup.c                                        |    2 
 block/bfq-iosched.c                                               |   37 +
 block/blk-merge.c                                                 |   10 
 block/blk-mq.c                                                    |   58 +-
 block/blk-mq.h                                                    |   13 
 crypto/pcrypt.c                                                   |   12 
 drivers/acpi/arm64/gtdt.c                                         |    2 
 drivers/acpi/cppc_acpi.c                                          |    1 
 drivers/base/firmware_loader/main.c                               |    5 
 drivers/base/regmap/regmap-irq.c                                  |    4 
 drivers/block/brd.c                                               |   66 +-
 drivers/block/ublk_drv.c                                          |   17 
 drivers/block/virtio_blk.c                                        |   46 --
 drivers/block/zram/zram_drv.c                                     |    7 
 drivers/char/tpm/tpm-chip.c                                       |    4 
 drivers/char/tpm/tpm-interface.c                                  |   29 -
 drivers/clk/clk-apple-nco.c                                       |    3 
 drivers/clk/clk-axi-clkgen.c                                      |   22 
 drivers/clk/imx/clk-fracn-gppll.c                                 |   10 
 drivers/clk/imx/clk-imx8-acm.c                                    |    4 
 drivers/clk/imx/clk-lpcg-scu.c                                    |   37 +
 drivers/clk/imx/clk-scu.c                                         |    2 
 drivers/clk/mediatek/Kconfig                                      |   15 
 drivers/clk/qcom/gcc-qcs404.c                                     |    1 
 drivers/clk/ralink/clk-mtmips.c                                   |   26 -
 drivers/clk/renesas/rzg2l-cpg.c                                   |   11 
 drivers/clk/sunxi-ng/ccu-sun20i-d1.c                              |    2 
 drivers/clocksource/Kconfig                                       |    3 
 drivers/clocksource/timer-ti-dm-systimer.c                        |    4 
 drivers/comedi/comedi_fops.c                                      |   12 
 drivers/counter/stm32-timer-cnt.c                                 |   16 
 drivers/counter/ti-ecap-capture.c                                 |    7 
 drivers/cpufreq/amd-pstate.c                                      |    2 
 drivers/cpufreq/cppc_cpufreq.c                                    |   63 ++
 drivers/cpufreq/loongson2_cpufreq.c                               |    4 
 drivers/cpufreq/mediatek-cpufreq-hw.c                             |    2 
 drivers/crypto/bcm/cipher.c                                       |    5 
 drivers/crypto/caam/caampkc.c                                     |   11 
 drivers/crypto/caam/qi.c                                          |    2 
 drivers/crypto/cavium/cpt/cptpf_main.c                            |    6 
 drivers/crypto/hisilicon/hpre/hpre_main.c                         |   35 +
 drivers/crypto/hisilicon/qm.c                                     |   47 --
 drivers/crypto/hisilicon/sec2/sec_main.c                          |   35 +
 drivers/crypto/hisilicon/zip/zip_main.c                           |   35 +
 drivers/crypto/inside-secure/safexcel_hash.c                      |    2 
 drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c              |    2 
 drivers/crypto/intel/qat/qat_common/adf_dbgfs.c                   |   13 
 drivers/crypto/intel/qat/qat_common/adf_hw_arbiter.c              |    4 
 drivers/dax/pmem/Makefile                                         |    7 
 drivers/dax/pmem/pmem.c                                           |   10 
 drivers/dma-buf/udmabuf.c                                         |    8 
 drivers/edac/bluefield_edac.c                                     |    2 
 drivers/edac/fsl_ddr_edac.c                                       |   22 
 drivers/edac/i10nm_base.c                                         |    1 
 drivers/edac/igen6_edac.c                                         |    2 
 drivers/edac/skx_common.c                                         |   57 +-
 drivers/edac/skx_common.h                                         |    8 
 drivers/firmware/arm_scmi/common.h                                |    2 
 drivers/firmware/arm_scmi/driver.c                                |    6 
 drivers/firmware/arm_scpi.c                                       |    3 
 drivers/firmware/efi/libstub/efi-stub.c                           |    4 
 drivers/firmware/efi/tpm.c                                        |   17 
 drivers/firmware/google/gsmi.c                                    |    6 
 drivers/gpio/gpio-exar.c                                          |   10 
 drivers/gpio/gpio-zevio.c                                         |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                        |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c                           |    6 
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c                     |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                          |    5 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c       |    4 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c      |    8 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c      |    8 
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c             |    3 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c                |   31 -
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c                |    7 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c             |    3 
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c             |    5 
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c           |    5 
 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c           |    2 
 drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c           |    2 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c                |   11 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c             |    8 
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c           |    2 
 drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c |    2 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c              |    7 
 drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c     |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c              |    2 
 drivers/gpu/drm/bridge/analogix/anx7625.c                         |    2 
 drivers/gpu/drm/bridge/ite-it6505.c                               |    2 
 drivers/gpu/drm/bridge/tc358767.c                                 |    7 
 drivers/gpu/drm/drm_file.c                                        |    2 
 drivers/gpu/drm/drm_mm.c                                          |    2 
 drivers/gpu/drm/drm_panel_orientation_quirks.c                    |    1 
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c                          |    3 
 drivers/gpu/drm/etnaviv/etnaviv_drv.c                             |   10 
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c                             |   28 -
 drivers/gpu/drm/fsl-dcu/Kconfig                                   |    1 
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c                         |   15 
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h                         |    3 
 drivers/gpu/drm/imx/dcss/dcss-crtc.c                              |    6 
 drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c                            |    6 
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                            |    4 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                             |    4 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h           |   12 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h            |   14 
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c                     |    2 
 drivers/gpu/drm/msm/msm_gpu_devfreq.c                             |    9 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c                    |    1 
 drivers/gpu/drm/omapdrm/dss/base.c                                |   25 -
 drivers/gpu/drm/omapdrm/dss/omapdss.h                             |    3 
 drivers/gpu/drm/omapdrm/omap_drv.c                                |    4 
 drivers/gpu/drm/omapdrm/omap_gem.c                                |   10 
 drivers/gpu/drm/panfrost/panfrost_gpu.c                           |    1 
 drivers/gpu/drm/radeon/atombios_encoders.c                        |    2 
 drivers/gpu/drm/radeon/cik.c                                      |   14 
 drivers/gpu/drm/radeon/dce6_afmt.c                                |    2 
 drivers/gpu/drm/radeon/evergreen.c                                |   12 
 drivers/gpu/drm/radeon/ni.c                                       |    2 
 drivers/gpu/drm/radeon/r100.c                                     |   24 -
 drivers/gpu/drm/radeon/r300.c                                     |    6 
 drivers/gpu/drm/radeon/r420.c                                     |    6 
 drivers/gpu/drm/radeon/r520.c                                     |    2 
 drivers/gpu/drm/radeon/r600.c                                     |   12 
 drivers/gpu/drm/radeon/r600_cs.c                                  |    2 
 drivers/gpu/drm/radeon/r600_dpm.c                                 |    4 
 drivers/gpu/drm/radeon/r600_hdmi.c                                |    2 
 drivers/gpu/drm/radeon/radeon.h                                   |    5 
 drivers/gpu/drm/radeon/radeon_acpi.c                              |   10 
 drivers/gpu/drm/radeon/radeon_agp.c                               |    2 
 drivers/gpu/drm/radeon/radeon_atombios.c                          |    2 
 drivers/gpu/drm/radeon/radeon_audio.c                             |   14 
 drivers/gpu/drm/radeon/radeon_combios.c                           |   12 
 drivers/gpu/drm/radeon/radeon_device.c                            |   10 
 drivers/gpu/drm/radeon/radeon_display.c                           |   74 +--
 drivers/gpu/drm/radeon/radeon_fbdev.c                             |   26 -
 drivers/gpu/drm/radeon/radeon_fence.c                             |    8 
 drivers/gpu/drm/radeon/radeon_gem.c                               |    2 
 drivers/gpu/drm/radeon/radeon_i2c.c                               |    2 
 drivers/gpu/drm/radeon/radeon_ib.c                                |    2 
 drivers/gpu/drm/radeon/radeon_irq_kms.c                           |   12 
 drivers/gpu/drm/radeon/radeon_object.c                            |    2 
 drivers/gpu/drm/radeon/radeon_pm.c                                |   20 
 drivers/gpu/drm/radeon/radeon_ring.c                              |    2 
 drivers/gpu/drm/radeon/radeon_ttm.c                               |    6 
 drivers/gpu/drm/radeon/rs400.c                                    |    6 
 drivers/gpu/drm/radeon/rs600.c                                    |   14 
 drivers/gpu/drm/radeon/rs690.c                                    |    2 
 drivers/gpu/drm/radeon/rv515.c                                    |    4 
 drivers/gpu/drm/radeon/rv770.c                                    |    2 
 drivers/gpu/drm/radeon/si.c                                       |    4 
 drivers/gpu/drm/sti/sti_cursor.c                                  |    3 
 drivers/gpu/drm/sti/sti_gdp.c                                     |    3 
 drivers/gpu/drm/sti/sti_hqvdp.c                                   |    3 
 drivers/gpu/drm/v3d/v3d_mmu.c                                     |   29 -
 drivers/gpu/drm/vc4/vc4_drv.h                                     |    1 
 drivers/gpu/drm/vc4/vc4_hdmi.c                                    |    4 
 drivers/gpu/drm/vc4/vc4_hvs.c                                     |   23 -
 drivers/gpu/drm/vkms/vkms_output.c                                |    5 
 drivers/gpu/drm/xlnx/zynqmp_kms.c                                 |    6 
 drivers/hid/hid-hyperv.c                                          |   58 +-
 drivers/hid/wacom_wac.c                                           |    4 
 drivers/hwmon/nct6775-core.c                                      |    7 
 drivers/hwmon/pmbus/pmbus_core.c                                  |   12 
 drivers/hwmon/tps23861.c                                          |    2 
 drivers/i2c/busses/i2c-imx-lpi2c.c                                |   10 
 drivers/i3c/master.c                                              |    2 
 drivers/i3c/master/svc-i3c-master.c                               |    2 
 drivers/iio/accel/kionix-kx022a.c                                 |    2 
 drivers/iio/adc/ad7780.c                                          |    2 
 drivers/iio/adc/ad7923.c                                          |    4 
 drivers/iio/industrialio-gts-helper.c                             |    4 
 drivers/iio/inkern.c                                              |    2 
 drivers/iio/light/al3010.c                                        |   11 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                          |    7 
 drivers/infiniband/hw/bnxt_re/qplib_fp.h                          |    2 
 drivers/infiniband/hw/hns/hns_roce_cq.c                           |    4 
 drivers/infiniband/hw/hns/hns_roce_device.h                       |    1 
 drivers/infiniband/hw/hns/hns_roce_hem.c                          |   48 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                        |  150 +++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h                        |    6 
 drivers/infiniband/hw/hns/hns_roce_mr.c                           |   11 
 drivers/infiniband/hw/hns/hns_roce_qp.c                           |   54 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c                          |    4 
 drivers/infiniband/hw/mlx5/main.c                                 |  185 +++++---
 drivers/infiniband/hw/mlx5/mlx5_ib.h                              |    6 
 drivers/infiniband/hw/mlx5/qp.c                                   |    4 
 drivers/infiniband/hw/mlx5/srq.c                                  |    4 
 drivers/infiniband/sw/rxe/rxe_qp.c                                |    1 
 drivers/infiniband/sw/rxe/rxe_req.c                               |    6 
 drivers/iommu/intel/iommu.c                                       |   40 +
 drivers/iommu/io-pgtable-arm.c                                    |   18 
 drivers/leds/flash/leds-mt6360.c                                  |    3 
 drivers/leds/leds-lp55xx-common.c                                 |    3 
 drivers/mailbox/arm_mhuv2.c                                       |    8 
 drivers/mailbox/mtk-cmdq-mailbox.c                                |   12 
 drivers/md/bcache/closure.c                                       |   10 
 drivers/md/dm-bufio.c                                             |   12 
 drivers/md/dm-cache-background-tracker.c                          |   25 -
 drivers/md/dm-cache-background-tracker.h                          |    8 
 drivers/md/dm-cache-target.c                                      |   25 -
 drivers/md/dm-thin.c                                              |    1 
 drivers/md/md-bitmap.c                                            |    1 
 drivers/md/persistent-data/dm-space-map-common.c                  |    2 
 drivers/media/dvb-frontends/ts2020.c                              |    8 
 drivers/media/i2c/adv7604.c                                       |    5 
 drivers/media/i2c/adv7842.c                                       |   13 
 drivers/media/i2c/ds90ub960.c                                     |    2 
 drivers/media/i2c/dw9768.c                                        |   10 
 drivers/media/i2c/tc358743.c                                      |    4 
 drivers/media/platform/allegro-dvt/allegro-core.c                 |    4 
 drivers/media/platform/amphion/vpu_drv.c                          |    2 
 drivers/media/platform/amphion/vpu_v4l2.c                         |    2 
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c              |   10 
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c            |   11 
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c                    |    4 
 drivers/media/platform/qcom/venus/core.c                          |    2 
 drivers/media/platform/samsung/exynos4-is/media-dev.h             |    5 
 drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c   |    3 
 drivers/media/radio/wl128x/fmdrv_common.c                         |    3 
 drivers/media/test-drivers/vivid/vivid-vid-cap.c                  |   15 
 drivers/media/usb/gspca/ov534.c                                   |    2 
 drivers/media/usb/uvc/uvc_driver.c                                |  102 +++-
 drivers/media/v4l2-core/v4l2-dv-timings.c                         |  132 +++--
 drivers/message/fusion/mptsas.c                                   |    4 
 drivers/mfd/da9052-spi.c                                          |    2 
 drivers/mfd/intel_soc_pmic_bxtwc.c                                |  126 +++--
 drivers/mfd/rt5033.c                                              |    4 
 drivers/mfd/tps65010.c                                            |    8 
 drivers/misc/apds990x.c                                           |   12 
 drivers/misc/lkdtm/bugs.c                                         |    4 
 drivers/mmc/host/mmc_spi.c                                        |    9 
 drivers/mtd/hyperbus/rpc-if.c                                     |   13 
 drivers/mtd/nand/raw/atmel/pmecc.c                                |    8 
 drivers/mtd/nand/raw/atmel/pmecc.h                                |    2 
 drivers/mtd/spi-nor/core.c                                        |    2 
 drivers/mtd/spi-nor/spansion.c                                    |    1 
 drivers/mtd/ubi/attach.c                                          |   12 
 drivers/mtd/ubi/fastmap-wl.c                                      |   19 
 drivers/mtd/ubi/wl.c                                              |   11 
 drivers/mtd/ubi/wl.h                                              |    3 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                         |   20 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c                     |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h                     |    3 
 drivers/net/ethernet/broadcom/tg3.c                               |    3 
 drivers/net/ethernet/intel/ice/ice_virtchnl.c                     |   28 -
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c                   |   97 ++++
 drivers/net/ethernet/marvell/octeontx2/af/cgx.h                   |    6 
 drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h           |    8 
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h                  |    1 
 drivers/net/ethernet/marvell/octeontx2/af/rpm.c                   |  104 +++-
 drivers/net/ethernet/marvell/octeontx2/af/rpm.h                   |   21 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c                   |    1 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h                   |    1 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c               |   74 ++-
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c                |    5 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c          |    4 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h          |    1 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c           |    5 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_dmac_flt.c        |    9 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c         |   10 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c           |   10 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c              |   20 
 drivers/net/ethernet/marvell/pxa168_eth.c                         |   14 
 drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c              |   17 
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c               |    2 
 drivers/net/mdio/mdio-ipq4019.c                                   |    5 
 drivers/net/netdevsim/ipsec.c                                     |   11 
 drivers/net/usb/lan78xx.c                                         |   40 -
 drivers/net/usb/qmi_wwan.c                                        |    1 
 drivers/net/usb/r8152.c                                           |    1 
 drivers/net/wireless/ath/ath10k/mac.c                             |    4 
 drivers/net/wireless/ath/ath11k/qmi.c                             |    3 
 drivers/net/wireless/ath/ath12k/dp.c                              |    5 
 drivers/net/wireless/ath/ath12k/mac.c                             |    5 
 drivers/net/wireless/ath/ath9k/htc_hst.c                          |    3 
 drivers/net/wireless/ath/wil6210/txrx.c                           |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c             |    3 
 drivers/net/wireless/intel/ipw2x00/ipw2100.c                      |    2 
 drivers/net/wireless/intel/ipw2x00/ipw2200.h                      |    2 
 drivers/net/wireless/intel/iwlwifi/fw/init.c                      |    4 
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c                       |    2 
 drivers/net/wireless/intersil/p54/p54spi.c                        |    4 
 drivers/net/wireless/marvell/libertas/radiotap.h                  |    4 
 drivers/net/wireless/marvell/mwifiex/fw.h                         |    2 
 drivers/net/wireless/marvell/mwifiex/main.c                       |    4 
 drivers/net/wireless/microchip/wilc1000/mon.c                     |    4 
 drivers/net/wireless/realtek/rtlwifi/efuse.c                      |   11 
 drivers/net/wireless/silabs/wfx/main.c                            |   17 
 drivers/net/wireless/virtual/mac80211_hwsim.c                     |    4 
 drivers/nvme/host/apple.c                                         |   27 -
 drivers/nvme/host/core.c                                          |    2 
 drivers/nvme/host/ioctl.c                                         |    8 
 drivers/nvme/host/multipath.c                                     |  134 +++++
 drivers/nvme/host/nvme.h                                          |    4 
 drivers/nvme/host/pci.c                                           |   55 +-
 drivers/of/fdt.c                                                  |   14 
 drivers/of/kexec.c                                                |    2 
 drivers/of/unittest.c                                             |    4 
 drivers/pci/controller/cadence/pci-j721e.c                        |  123 ++++-
 drivers/pci/controller/cadence/pcie-cadence-host.c                |   44 +
 drivers/pci/controller/cadence/pcie-cadence.h                     |   12 
 drivers/pci/controller/dwc/pci-keystone.c                         |   12 
 drivers/pci/controller/pcie-rockchip-ep.c                         |   16 
 drivers/pci/controller/pcie-rockchip.h                            |    4 
 drivers/pci/endpoint/functions/pci-epf-mhi.c                      |    6 
 drivers/pci/endpoint/pci-epc-core.c                               |    6 
 drivers/pci/hotplug/cpqphp_pci.c                                  |   19 
 drivers/pci/of_property.c                                         |    2 
 drivers/pci/pci.c                                                 |    5 
 drivers/pci/pci.h                                                 |    3 
 drivers/pci/slot.c                                                |    4 
 drivers/perf/arm-cmn.c                                            |    4 
 drivers/perf/arm_smmuv3_pmu.c                                     |   19 
 drivers/pinctrl/pinctrl-k210.c                                    |    2 
 drivers/pinctrl/pinctrl-zynqmp.c                                  |    1 
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c                          |    2 
 drivers/platform/chrome/cros_ec_typec.c                           |    1 
 drivers/platform/x86/dell/dell-smbios-base.c                      |    1 
 drivers/platform/x86/dell/dell-wmi-base.c                         |    6 
 drivers/platform/x86/intel/bxtwc_tmu.c                            |   22 
 drivers/platform/x86/panasonic-laptop.c                           |   10 
 drivers/platform/x86/thinkpad_acpi.c                              |   28 +
 drivers/platform/x86/x86-android-tablets/core.c                   |    6 
 drivers/pmdomain/ti/ti_sci_pm_domains.c                           |    4 
 drivers/power/supply/bq27xxx_battery.c                            |   37 +
 drivers/power/supply/power_supply_core.c                          |    2 
 drivers/power/supply/rt9471.c                                     |   52 +-
 drivers/pwm/pwm-imx27.c                                           |   98 ++++
 drivers/regulator/rk808-regulator.c                               |   17 
 drivers/remoteproc/qcom_q6v5_mss.c                                |    6 
 drivers/remoteproc/qcom_q6v5_pas.c                                |    2 
 drivers/rpmsg/qcom_glink_native.c                                 |    3 
 drivers/rtc/interface.c                                           |    7 
 drivers/rtc/rtc-ab-eoz9.c                                         |    7 
 drivers/rtc/rtc-abx80x.c                                          |    2 
 drivers/rtc/rtc-rzn1.c                                            |    8 
 drivers/rtc/rtc-st-lpc.c                                          |    5 
 drivers/s390/cio/cio.c                                            |    6 
 drivers/s390/cio/device.c                                         |   18 
 drivers/s390/crypto/pkey_api.c                                    |   16 
 drivers/scsi/bfa/bfad.c                                           |    3 
 drivers/scsi/hisi_sas/hisi_sas_main.c                             |    8 
 drivers/scsi/lpfc/lpfc_hbadisc.c                                  |    3 
 drivers/scsi/lpfc/lpfc_scsi.c                                     |   13 
 drivers/scsi/lpfc/lpfc_sli.c                                      |   11 
 drivers/scsi/qedf/qedf_main.c                                     |    1 
 drivers/scsi/qedi/qedi_main.c                                     |    1 
 drivers/scsi/sg.c                                                 |    9 
 drivers/sh/intc/core.c                                            |    2 
 drivers/soc/fsl/rcpm.c                                            |    1 
 drivers/soc/qcom/qcom-geni-se.c                                   |    3 
 drivers/soc/qcom/socinfo.c                                        |    8 
 drivers/soc/ti/smartreflex.c                                      |    4 
 drivers/soc/xilinx/xlnx_event_manager.c                           |    4 
 drivers/spi/atmel-quadspi.c                                       |    2 
 drivers/spi/spi-fsl-lpspi.c                                       |   12 
 drivers/spi/spi-tegra210-quad.c                                   |    2 
 drivers/spi/spi-zynqmp-gqspi.c                                    |    2 
 drivers/spi/spi.c                                                 |   13 
 drivers/staging/media/atomisp/pci/sh_css_params.c                 |    2 
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c           |    2 
 drivers/thermal/thermal_core.c                                    |    2 
 drivers/tty/serial/8250/8250_fintek.c                             |   14 
 drivers/tty/serial/8250/8250_omap.c                               |    4 
 drivers/tty/serial/sc16is7xx.c                                    |    4 
 drivers/tty/tty_io.c                                              |    2 
 drivers/ufs/host/ufs-exynos.c                                     |   16 
 drivers/usb/dwc3/gadget.c                                         |   15 
 drivers/usb/gadget/composite.c                                    |   18 
 drivers/usb/host/ehci-spear.c                                     |    7 
 drivers/usb/host/xhci-ring.c                                      |   18 
 drivers/usb/misc/chaoskey.c                                       |   35 +
 drivers/usb/misc/iowarrior.c                                      |   50 +-
 drivers/usb/misc/yurex.c                                          |    5 
 drivers/usb/musb/musb_gadget.c                                    |   13 
 drivers/usb/typec/class.c                                         |    6 
 drivers/usb/typec/tcpm/wcove.c                                    |    4 
 drivers/vdpa/mlx5/core/mr.c                                       |    4 
 drivers/vfio/pci/vfio_pci_config.c                                |   16 
 drivers/video/fbdev/sh7760fb.c                                    |    3 
 drivers/xen/xenbus/xenbus_probe.c                                 |    8 
 fs/btrfs/ctree.c                                                  |   57 ++
 fs/btrfs/extent-tree.c                                            |   25 -
 fs/btrfs/extent-tree.h                                            |    8 
 fs/btrfs/free-space-tree.c                                        |   10 
 fs/btrfs/ioctl.c                                                  |    6 
 fs/btrfs/qgroup.c                                                 |    6 
 fs/btrfs/ref-verify.c                                             |    1 
 fs/cachefiles/ondemand.c                                          |    4 
 fs/ceph/super.c                                                   |   10 
 fs/erofs/zmap.c                                                   |   17 
 fs/exfat/namei.c                                                  |    1 
 fs/ext4/balloc.c                                                  |    4 
 fs/ext4/ext4.h                                                    |   12 
 fs/ext4/extents.c                                                 |    2 
 fs/ext4/fsmap.c                                                   |   54 ++
 fs/ext4/ialloc.c                                                  |    5 
 fs/ext4/indirect.c                                                |    2 
 fs/ext4/inode.c                                                   |    4 
 fs/ext4/mballoc.c                                                 |   18 
 fs/ext4/mballoc.h                                                 |    1 
 fs/ext4/mmp.c                                                     |    2 
 fs/ext4/move_extent.c                                             |   47 +-
 fs/ext4/page-io.c                                                 |    3 
 fs/ext4/readpage.c                                                |    1 
 fs/ext4/resize.c                                                  |    2 
 fs/ext4/super.c                                                   |   42 +
 fs/f2fs/checkpoint.c                                              |    2 
 fs/f2fs/data.c                                                    |   26 -
 fs/f2fs/f2fs.h                                                    |    3 
 fs/f2fs/file.c                                                    |   17 
 fs/f2fs/gc.c                                                      |    2 
 fs/f2fs/node.c                                                    |   10 
 fs/f2fs/segment.c                                                 |    5 
 fs/f2fs/segment.h                                                 |   35 +
 fs/f2fs/super.c                                                   |   13 
 fs/fscache/volume.c                                               |    3 
 fs/gfs2/glock.c                                                   |   82 +--
 fs/gfs2/glock.h                                                   |    3 
 fs/gfs2/incore.h                                                  |    2 
 fs/gfs2/log.c                                                     |    2 
 fs/gfs2/rgrp.c                                                    |    2 
 fs/gfs2/super.c                                                   |    6 
 fs/gfs2/util.c                                                    |    2 
 fs/hfsplus/hfsplus_fs.h                                           |    3 
 fs/hfsplus/wrapper.c                                              |    2 
 fs/inode.c                                                        |   10 
 fs/jffs2/erase.c                                                  |    7 
 fs/jfs/xattr.c                                                    |    2 
 fs/nfs/internal.h                                                 |    2 
 fs/nfs/nfs4proc.c                                                 |    8 
 fs/nfsd/export.c                                                  |   36 +
 fs/nfsd/export.h                                                  |    4 
 fs/nfsd/nfs4callback.c                                            |   16 
 fs/nfsd/nfs4proc.c                                                |    7 
 fs/nfsd/nfs4recover.c                                             |    3 
 fs/nfsd/nfs4state.c                                               |   19 
 fs/notify/fsnotify.c                                              |   23 -
 fs/ocfs2/aops.h                                                   |    2 
 fs/ocfs2/file.c                                                   |    4 
 fs/overlayfs/inode.c                                              |    7 
 fs/overlayfs/util.c                                               |    3 
 fs/proc/array.c                                                   |   57 +-
 fs/proc/kcore.c                                                   |   11 
 fs/proc/softirqs.c                                                |    2 
 fs/quota/dquot.c                                                  |    2 
 fs/smb/client/cached_dir.c                                        |  229 ++++++----
 fs/smb/client/cached_dir.h                                        |    6 
 fs/smb/client/cifsfs.c                                            |   12 
 fs/smb/client/cifsglob.h                                          |    4 
 fs/smb/client/cifsproto.h                                         |    1 
 fs/smb/client/connect.c                                           |   59 ++
 fs/smb/client/fs_context.c                                        |   85 +++
 fs/smb/client/fs_context.h                                        |    1 
 fs/smb/client/inode.c                                             |    4 
 fs/smb/client/reparse.c                                           |   95 +++-
 fs/smb/client/reparse.h                                           |    6 
 fs/smb/client/smb1ops.c                                           |    4 
 fs/smb/client/smb2file.c                                          |   21 
 fs/smb/client/smb2inode.c                                         |    6 
 fs/smb/client/smb2ops.c                                           |    2 
 fs/smb/client/smb2pdu.c                                           |    4 
 fs/smb/client/smb2proto.h                                         |    9 
 fs/smb/client/trace.h                                             |    3 
 fs/smb/server/server.c                                            |    4 
 fs/ubifs/super.c                                                  |    6 
 fs/ubifs/tnc_commit.c                                             |    2 
 fs/unicode/utf8-core.c                                            |    2 
 fs/xfs/libxfs/xfs_sb.c                                            |    7 
 fs/xfs/xfs_log_recover.c                                          |    5 
 include/asm-generic/vmlinux.lds.h                                 |   22 
 include/linux/avf/virtchnl.h                                      |   11 
 include/linux/blkdev.h                                            |    2 
 include/linux/bpf_verifier.h                                      |   31 +
 include/linux/compiler_attributes.h                               |   13 
 include/linux/compiler_types.h                                    |   19 
 include/linux/hisi_acc_qm.h                                       |    8 
 include/linux/init.h                                              |   14 
 include/linux/jiffies.h                                           |    2 
 include/linux/lockdep.h                                           |    2 
 include/linux/mmdebug.h                                           |    6 
 include/linux/netpoll.h                                           |    2 
 include/linux/of_fdt.h                                            |    5 
 include/linux/once.h                                              |    4 
 include/linux/once_lite.h                                         |    2 
 include/linux/rcupdate.h                                          |    2 
 include/linux/seqlock.h                                           |   98 +++-
 include/linux/sock_diag.h                                         |   10 
 include/linux/util_macros.h                                       |   56 +-
 include/media/v4l2-dv-timings.h                                   |   18 
 include/net/ieee80211_radiotap.h                                  |   43 +
 include/net/net_debug.h                                           |    2 
 include/net/sock.h                                                |    2 
 include/uapi/linux/rtnetlink.h                                    |    2 
 init/Kconfig                                                      |    9 
 init/initramfs.c                                                  |   15 
 ipc/namespace.c                                                   |    4 
 kernel/bpf/verifier.c                                             |  175 ++++---
 kernel/cgroup/cgroup.c                                            |   21 
 kernel/rcu/rcuscale.c                                             |    6 
 kernel/rcu/tree.c                                                 |   14 
 kernel/signal.c                                                   |    9 
 kernel/time/time.c                                                |    4 
 kernel/trace/bpf_trace.c                                          |    5 
 kernel/trace/ftrace.c                                             |    3 
 kernel/trace/trace_event_perf.c                                   |    6 
 lib/maple_tree.c                                                  |   13 
 lib/string_helpers.c                                              |    2 
 mm/internal.h                                                     |    2 
 mm/slab.h                                                         |    5 
 mm/slub.c                                                         |    9 
 mm/vmstat.c                                                       |    1 
 net/9p/trans_xen.c                                                |    9 
 net/bluetooth/hci_sysfs.c                                         |   15 
 net/bluetooth/mgmt.c                                              |   38 +
 net/bluetooth/rfcomm/sock.c                                       |   10 
 net/core/filter.c                                                 |   88 ++-
 net/core/gen_estimator.c                                          |    2 
 net/core/skmsg.c                                                  |    4 
 net/core/sock_diag.c                                              |  114 ++--
 net/hsr/hsr_device.c                                              |    4 
 net/ipv4/cipso_ipv4.c                                             |    2 
 net/ipv4/inet_connection_sock.c                                   |    2 
 net/ipv4/inet_diag.c                                              |   11 
 net/ipv4/ipmr.c                                                   |   42 +
 net/ipv4/ipmr_base.c                                              |    3 
 net/ipv4/tcp.c                                                    |    2 
 net/ipv4/tcp_bpf.c                                                |    7 
 net/ipv4/tcp_fastopen.c                                           |    7 
 net/ipv4/udp.c                                                    |    2 
 net/ipv6/addrconf.c                                               |   41 +
 net/ipv6/af_inet6.c                                               |    2 
 net/ipv6/ip6_fib.c                                                |    2 
 net/ipv6/ip6mr.c                                                  |   38 +
 net/ipv6/ipv6_sockglue.c                                          |    3 
 net/ipv6/route.c                                                  |   10 
 net/iucv/af_iucv.c                                                |   26 -
 net/llc/af_llc.c                                                  |    2 
 net/mac80211/main.c                                               |    2 
 net/mptcp/protocol.c                                              |    4 
 net/netfilter/ipset/ip_set_bitmap_ip.c                            |    7 
 net/netfilter/nf_tables_api.c                                     |  149 ++++--
 net/netlink/diag.c                                                |    1 
 net/packet/diag.c                                                 |    1 
 net/rfkill/rfkill-gpio.c                                          |    8 
 net/rxrpc/af_rxrpc.c                                              |    7 
 net/sched/act_api.c                                               |    2 
 net/smc/smc_diag.c                                                |    1 
 net/sunrpc/cache.c                                                |    4 
 net/sunrpc/svcsock.c                                              |    4 
 net/sunrpc/xprtrdma/svc_rdma.c                                    |   19 
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c                           |    8 
 net/sunrpc/xprtsock.c                                             |   17 
 net/tipc/diag.c                                                   |    1 
 net/unix/diag.c                                                   |    1 
 net/vmw_vsock/diag.c                                              |    1 
 net/xdp/xsk_diag.c                                                |    1 
 rust/macros/lib.rs                                                |    2 
 samples/bpf/xdp_adjust_tail_kern.c                                |    1 
 scripts/checkpatch.pl                                             |   61 +-
 scripts/mod/file2alias.c                                          |    5 
 scripts/mod/modpost.c                                             |   45 -
 security/apparmor/capability.c                                    |    2 
 security/apparmor/policy_unpack_test.c                            |    6 
 sound/core/pcm_native.c                                           |    6 
 sound/core/ump.c                                                  |    5 
 sound/hda/intel-dsp-config.c                                      |    4 
 sound/pci/hda/patch_realtek.c                                     |  155 +++---
 sound/soc/amd/yc/acp6x-mach.c                                     |   32 +
 sound/soc/codecs/da7219.c                                         |    9 
 sound/soc/codecs/rt5640.c                                         |   27 -
 sound/soc/codecs/rt722-sdca.c                                     |    8 
 sound/soc/codecs/tas2781-fmwlib.c                                 |    1 
 sound/soc/fsl/fsl_micfil.c                                        |    4 
 sound/soc/generic/audio-graph-card2.c                             |    3 
 sound/soc/intel/atom/sst/sst_acpi.c                               |   64 ++
 sound/soc/intel/boards/bytcr_rt5640.c                             |   48 +-
 sound/soc/stm/stm32_sai_sub.c                                     |    6 
 sound/usb/6fire/chip.c                                            |   10 
 sound/usb/caiaq/audio.c                                           |   10 
 sound/usb/caiaq/audio.h                                           |    1 
 sound/usb/caiaq/device.c                                          |   19 
 sound/usb/caiaq/input.c                                           |   12 
 sound/usb/caiaq/input.h                                           |    1 
 sound/usb/clock.c                                                 |   24 +
 sound/usb/quirks-table.h                                          |   14 
 sound/usb/quirks.c                                                |   27 -
 sound/usb/usx2y/us122l.c                                          |    5 
 sound/usb/usx2y/usbusx2y.c                                        |    2 
 tools/bpf/bpftool/jit_disasm.c                                    |   40 +
 tools/include/nolibc/arch-s390.h                                  |    1 
 tools/lib/bpf/libbpf.c                                            |   16 
 tools/lib/bpf/linker.c                                            |    2 
 tools/lib/thermal/Makefile                                        |    4 
 tools/lib/thermal/commands.c                                      |   52 +-
 tools/perf/builtin-ftrace.c                                       |    2 
 tools/perf/builtin-list.c                                         |    4 
 tools/perf/builtin-stat.c                                         |   52 +-
 tools/perf/builtin-trace.c                                        |   23 -
 tools/perf/tests/attr/test-stat-default                           |   90 ++-
 tools/perf/tests/attr/test-stat-detailed-1                        |  106 +++-
 tools/perf/tests/attr/test-stat-detailed-2                        |  130 +++--
 tools/perf/tests/attr/test-stat-detailed-3                        |  138 +++---
 tools/perf/util/cs-etm.c                                          |   25 -
 tools/perf/util/evlist.c                                          |   19 
 tools/perf/util/evlist.h                                          |    1 
 tools/perf/util/pfm.c                                             |    4 
 tools/perf/util/pmus.c                                            |    2 
 tools/perf/util/probe-finder.c                                    |   21 
 tools/perf/util/probe-finder.h                                    |    4 
 tools/testing/selftests/arm64/mte/check_tags_inclusion.c          |    4 
 tools/testing/selftests/arm64/mte/mte_common_util.c               |    4 
 tools/testing/selftests/bpf/progs/test_spin_lock_fail.c           |    4 
 tools/testing/selftests/bpf/progs/verifier_subprog_precision.c    |   23 -
 tools/testing/selftests/bpf/test_sockmap.c                        |  165 ++++++-
 tools/testing/selftests/bpf/verifier/precise.c                    |   38 -
 tools/testing/selftests/mount_setattr/mount_setattr_test.c        |    2 
 tools/testing/selftests/net/pmtu.sh                               |    2 
 tools/testing/selftests/resctrl/fill_buf.c                        |   74 +--
 tools/testing/selftests/resctrl/resctrl.h                         |    2 
 tools/testing/selftests/resctrl/resctrl_val.c                     |    3 
 tools/testing/selftests/vDSO/parse_vdso.c                         |    3 
 tools/testing/selftests/watchdog/watchdog-test.c                  |    6 
 tools/testing/selftests/wireguard/netns.sh                        |    1 
 767 files changed, 7251 insertions(+), 3502 deletions(-)

Adrian Hunter (1):
      perf/x86/intel/pt: Fix buffer full but size is 0 case

Ahmed Ehab (1):
      locking/lockdep: Avoid creating new name string literals in lockdep_set_subclass()

Ahsan Atta (1):
      crypto: qat - remove faulty arbiter config reset

Aleksandr Mishin (1):
      acpi/arm64: Adjust error handling procedure in gtdt_parse_timer_block()

Alex Hung (3):
      drm/amd/display: Initialize denominators' default to 1
      drm/amd/display: Check null-initialized variables
      drm/amd/display: Check phantom_stream before it is used

Alex Zenla (2):
      9p/xen: fix init sequence
      9p/xen: fix release of IRQ

Alexander Hölzl (1):
      can: j1939: fix error in J1939 documentation.

Alexander Shiyan (1):
      media: i2c: tc358743: Fix crash in the probe error path when using polling

Alexander Stein (1):
      i2c: lpi2c: Avoid calling clk_get_rate during transfer

Alexandru Ardelean (1):
      util_macros.h: fix/rework find_closest() macros

Alper Nebi Yasak (1):
      wifi: mwifiex: Fix memcpy() field-spanning write warning in mwifiex_config_scan()

Amir Goldstein (1):
      fsnotify: fix sending inotify event with unexpected filename

Andre Przywara (4):
      kselftest/arm64: mte: fix printf type warnings about __u64
      kselftest/arm64: mte: fix printf type warnings about longs
      ARM: dts: cubieboard4: Fix DCDC5 regulator constraints
      clk: sunxi-ng: d1: Fix PLL_AUDIO0 preset

Andrea della Porta (1):
      PCI: of_property: Assign PCI instead of CPU bus address to dynamic PCI nodes

Andreas Gruenbacher (7):
      gfs2: Get rid of gfs2_glock_queue_put in signal_our_withdraw
      gfs2: Replace gfs2_glock_queue_put with gfs2_glock_put_async
      gfs2: Rename GLF_VERIFY_EVICT to GLF_VERIFY_DELETE
      gfs2: Allow immediate GLF_VERIFY_DELETE work
      gfs2: Fix unlinked inode cleanup
      gfs2: Don't set GLF_LOCK in gfs2_dispose_glock_lru
      gfs2: Remove and replace gfs2_glock_queue_work

Andreas Kemnade (1):
      ARM: dts: omap36xx: declare 1GHz OPP as turbo again

Andrei Simion (1):
      ARM: dts: microchip: sam9x60: Add missing property atmel,usart-mode

Andrej Shadura (1):
      Bluetooth: Fix type of len in rfcomm_sock_getsockopt{,_old}()

Andrii Nakryiko (4):
      bpf: support non-r10 register spill/fill to/from stack in precision tracking
      libbpf: fix sym_is_subprog() logic for weak global subprogs
      libbpf: never interpret subprogs in .text as entry programs
      selftests/bpf: fix test_spin_lock_fail.c's global vars usage

André Almeida (1):
      unicode: Fix utf8_load() error path

Andy Shevchenko (6):
      regmap: irq: Set lockdep class for hierarchical IRQ domains
      drm/mm: Mark drm_mm_interval_tree*() functions with __maybe_unused
      mfd: intel_soc_pmic_bxtwc: Use IRQ domain for USB Type-C device
      mfd: intel_soc_pmic_bxtwc: Use IRQ domain for TMU device
      mfd: intel_soc_pmic_bxtwc: Use IRQ domain for PMIC devices
      gpio: zevio: Add missed label initialisation

Angelo Dureghello (1):
      dt-bindings: iio: dac: ad3552r: fix maximum spi speed

AngeloGioacchino Del Regno (1):
      arm64: dts: mediatek: Add ADC node on MT6357, MT6358, MT6359 PMICs

Antonio Quartulli (1):
      m68k: coldfire/device.c: only build FEC when HW macros are defined

Anurag Dutta (3):
      arm64: dts: ti: k3-j7200: Fix clock ids for MCSPI instances
      arm64: dts: ti: k3-j721e: Fix clock IDs for MCSPI instances
      arm64: dts: ti: k3-j721s2: Fix clock IDs for MCSPI instances

Ard Biesheuvel (3):
      x86/stackprotector: Work around strict Clang TLS symbol requirements
      x86/pvh: Call C code via the kernel virtual mapping
      efi/libstub: Free correct pointer on failure

Arnaldo Carvalho de Melo (1):
      perf ftrace latency: Fix unit on histogram first entry when using --use-nsec

Arnd Bergmann (1):
      x86/amd_nb: Fix compile-testing without CONFIG_AMD_NB

Artem Sadovnikov (1):
      jfs: xattr: check invalid xattr size more strictly

Avihai Horon (1):
      vfio/pci: Properly hide first-in-list PCIe extended capability

Balaji Pothunoori (1):
      wifi: ath11k: Fix CE offset address calculation for WCN6750 in SSR

Baochen Qiang (2):
      wifi: ath10k: fix invalid VHT parameters in supported_vht_mcs_rate_nss1
      wifi: ath10k: fix invalid VHT parameters in supported_vht_mcs_rate_nss2

Barnabás Czémán (1):
      power: supply: bq27xxx: Fix registers of bq27426

Bart Van Assche (3):
      scsi: sg: Enable runtime power management
      power: supply: core: Remove might_sleep() from power_supply_put()
      blk-mq: Make blk_mq_quiesce_tagset() hold the tag list mutex less long

Bartosz Golaszewski (3):
      mmc: mmc_spi: drop buggy snprintf()
      pinctrl: zynqmp: drop excess struct member description
      lib: string_helpers: silence snprintf() output truncation warning

Baruch Siach (1):
      doc: rcu: update printed dynticks counter bits

Ben Greear (1):
      mac80211: fix user-power when emulating chanctx

Benjamin Coddington (1):
      SUNRPC: timeout and cancel TLS handshake with -ETIMEDOUT

Benjamin Gaignard (1):
      media: verisilicon: av1: Fix reference video buffer pointer assignment

Benjamin Große (1):
      usb: add support for new USB device ID 0x17EF:0x3098 for the r8152 driver

Benjamin Peterson (3):
      perf trace: avoid garbage when not printing a trace event's arguments
      perf trace: Do not lose last events in a race
      perf trace: Avoid garbage when not printing a syscall's arguments

Benoît Monin (1):
      net: usb: qmi_wwan: add Quectel RG650V

Benoît Sevens (1):
      ALSA: usb-audio: Fix potential out-of-bound accesses for Extigy and Mbox devices

Biju Das (2):
      mtd: hyperbus: rpc-if: Add missing MODULE_DEVICE_TABLE
      clk: renesas: rzg2l: Fix FOUTPOSTDIV clk

Bin Liu (1):
      serial: 8250: omap: Move pm_runtime_get_sync

Breno Leitao (4):
      ipmr: Fix access to mfc_cache_list without lock held
      spi: tegra210-quad: Avoid shift-out-of-bounds
      netpoll: Use rcu_access_pointer() in netpoll_poll_lock
      nvme/multipath: Fix RCU list traversal to use SRCU primitive

Cabiddu, Giovanni (1):
      crypto: qat - remove check after debugfs_create_dir()

Chao Yu (4):
      f2fs: fix to account dirty data in __get_secs_required()
      f2fs: fix to avoid potential deadlock in f2fs_record_stop_reason()
      f2fs: fix to avoid forcing direct write to use buffered IO on inline_data inode
      f2fs: fix to do sanity check on node blkaddr in truncate_node()

Charles Han (2):
      soc: qcom: Add check devm_kasprintf() returned value
      clk: clk-apple-nco: Add NULL check in applnco_probe

Chen Ridong (4):
      crypto: caam - add error check to caam_rsa_set_priv_key_form
      crypto: bcm - add error check in the ahash_hmac_init function
      Revert "cgroup: Fix memory leak caused by missing cgroup_bpf_offline"
      cgroup/bpf: only cgroup v2 can be attached by bpf programs

Chen-Yu Tsai (5):
      arm64: dts: mediatek: mt8173-elm-hana: Add vdd-supply to second source trackpad
      arm64: dts: mediatek: mt8183-kukui-jacuzzi: Fix DP bridge supply names
      arm64: dts: mediatek: mt8183-kukui-jacuzzi: Add supplies for fixed regulators
      Revert "arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0 on xhci1 as disabled"
      arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0 on xhci1 as disabled

Cheng Ming Lin (1):
      mtd: spi-nor: core: replace dummy buswidth from addr to data

ChiYuan Huang (2):
      power: supply: rt9471: Fix wrong WDT function regfield declaration
      power: supply: rt9471: Use IC status regfield to report real charger status

Chris Morgan (1):
      arm64: dts: rockchip: correct analog audio name on Indiedroid Nova

Christoph Hellwig (5):
      nvme-pci: fix freeing of the HMB descriptor table
      block: fix bio_split_rw_at to take zone_write_granularity into account
      nvme-pci: reverse request order in nvme_queue_rqs
      virtio_blk: reverse request order in virtio_queue_rqs
      block: return unsigned int from bdev_io_min

Christophe JAILLET (3):
      crypto: caam - Fix the pointer passed to caam_qi_shutdown()
      crypto: cavium - Fix an error handling path in cpt_ucode_load_fw()
      iio: light: al3010: Fix an error handling path in al3010_probe()

Christophe Leroy (1):
      powerpc/vdso: Flag VDSO64 entry points as functions

Chuck Lever (5):
      svcrdma: Address an integer overflow
      NFSD: Prevent NULL dereference in nfsd4_process_cb_update()
      NFSD: Cap the number of bytes copied by nfs4_reset_recoverydir()
      NFSD: Fix nfsd4_shutdown_copy()
      NFSD: Prevent a potential integer overflow

Chun-Tse Shao (1):
      perf/arm-smmuv3: Fix lockdep assert in ->event_init()

Clark Wang (1):
      pwm: imx27: Workaround of the pwm output bug when decrease the duty cycle

Claudiu Beznea (1):
      serial: sh-sci: Clean sci_ports[0] after at earlycon exit

Colin Ian King (1):
      media: i2c: ds90ub960: Fix missing return check on ub960_rxport_read call

Cristian Marussi (1):
      firmware: arm_scmi: Reject clear channel request on A2P

Csókás, Bence (1):
      spi: atmel-quadspi: Fix register name in verbose logging function

Daejun Park (1):
      f2fs: fix null reference error when checking end of zone

Damien Le Moal (1):
      PCI: rockchip-ep: Fix address translation unit programming

Dan Carpenter (6):
      crypto: qat/qat_4xxx - fix off by one in uof_get_name()
      soc: qcom: geni-se: fix array underflow in geni_se_clk_tbl_get()
      checkpatch: check for missing Fixes tags
      mailbox: arm_mhuv2: clean up loop in get_irq_chan_comb()
      cifs: unlock on error in smb3_reconfigure()
      sh: intc: Fix use-after-free bug in register_intc_controller()

Daniel Gabay (1):
      wifi: iwlwifi: mvm: Use the sync timepoint API in suspend

Daniel Lezcano (2):
      tools/lib/thermal: Make more generic the command encoding function
      thermal/lib: Fix memory leak on error in thermal_genl_auto()

Daniel Palmer (2):
      m68k: mvme147: Fix SCSI controller IRQ numbers
      m68k: mvme147: Reinstate early console

Daolong Zhu (4):
      arm64: dts: mt8183: fennel: add i2c2's i2c-scl-internal-delay-ns
      arm64: dts: mt8183: burnet: add i2c2's i2c-scl-internal-delay-ns
      arm64: dts: mt8183: cozmo: add i2c2's i2c-scl-internal-delay-ns
      arm64: dts: mt8183: Damu: add i2c2's i2c-scl-internal-delay-ns

Dave Stevenson (5):
      drm/vc4: hvs: Don't write gamma luts on 2711
      drm/vc4: hvs: Fix dlist debug not resetting the next entry pointer
      drm/vc4: hvs: Remove incorrect limit from hvs_dlist debugfs function
      drm/vc4: hvs: Correct logic on stopping an HVS channel
      drm/vc4: Match drm_dev_enter and exit calls in vc4_hvs_atomic_flush

David Disseldorp (1):
      initramfs: avoid filename buffer overrun

David Thompson (1):
      EDAC/bluefield: Fix potential integer overflow

David Wang (1):
      proc/softirqs: replace seq_printf with seq_put_decimal_ull_width

Dinesh Kumar (1):
      ALSA: hda/realtek: Fix Internal Speaker and Mic boost of Infinix Y4 Max

Dipendra Khadka (6):
      octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_common.c
      octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_ethtool.c
      octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_flows.c
      octeontx2-pf: handle otx2_mbox_get_rsp errors in cn10k.c
      octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_dmac_flt.c
      octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_dcbnl.c

Dmitry Antipov (2):
      Bluetooth: fix use-after-free in device_for_each_child()
      ocfs2: fix uninitialized value in ocfs2_file_read_iter()

Dmitry Baryshkov (4):
      drm/msm/dpu: on SDM845 move DSPP_3 to LM_5 block
      drm/msm/dpu: drop LM_3 / LM_4 on SDM845
      drm/msm/dpu: drop LM_3 / LM_4 on MSM8998
      remoteproc: qcom: pas: add minidump_id to SM8350 resources

Dmitry Kandybka (1):
      mptcp: fix possible integer overflow in mptcp_reset_tout_timer

Dom Cobley (1):
      drm/vc4: hdmi: Avoid hang with debug registers when suspended

Dong Aisheng (1):
      clk: imx: clk-scu: fix clk enable state save and restore

Dragan Simic (2):
      regulator: rk808: Restrict DVS GPIOs to the RK808 variant only
      arm64: dts: allwinner: pinephone: Add mount matrix to accelerometer

Edward Adam Davis (1):
      USB: chaoskey: Fix possible deadlock chaoskey_list_lock

Eric Biggers (1):
      crypto: x86/aegis128 - access 32-bit arguments as 32-bit

Eric Dumazet (5):
      sock_diag: add module pointer to "struct sock_diag_handler"
      sock_diag: allow concurrent operations
      sock_diag: allow concurrent operation in sock_diag_rcv_msg()
      net: use unrcu_pointer() helper
      net: hsr: fix hsr_init_sk() vs network/transport headers.

Eryk Zagorski (1):
      ALSA: usb-audio: Fix Yamaha P-125 Quirk Entry

Everest K.C (2):
      crypto: cavium - Fix the if condition to exit loop after timeout
      ASoC: rt722-sdca: Remove logically deadcode in rt722-sdca.c

Filip Brozovic (1):
      serial: 8250_fintek: Add support for F81216E

Filipe Manana (3):
      btrfs: do not BUG_ON() when freeing tree block after error
      btrfs: don't loop for nowait writes when checking for cross references
      btrfs: ref-verify: fix use-after-free after invalid ref action

Florian Westphal (3):
      netfilter: nf_tables: avoid false-positive lockdep splat on rule deletion
      netfilter: nf_tables: must hold rcu read lock while iterating expression type list
      netfilter: nf_tables: must hold rcu read lock while iterating object type list

Francesco Dolcini (3):
      arm64: dts: freescale: imx8mm-verdin: Fix SD regulator startup delay
      arm64: dts: ti: k3-am62-verdin: Fix SD regulator startup delay
      arm64: dts: freescale: imx8mp-verdin: Fix SD regulator startup delay

Frank Li (1):
      i3c: master: Fix miss free init_dyn_addr at i3c_master_put_i3c_addrs()

Frederic Weisbecker (1):
      posix-timers: Target group sigqueue to current task only if not exiting

Gabor Juhos (1):
      clk: qcom: gcc-qcs404: fix initial rate of GPLL3

Gao Xiang (1):
      erofs: handle NONHEAD !delta[1] lclusters gracefully

Gaosheng Cui (3):
      drivers: soc: xilinx: add the missing kfree in xlnx_add_cb_for_suspend()
      firmware_loader: Fix possible resource leak in fw_log_firmware_info()
      media: platform: allegro-dvt: Fix possible memory leak in allocate_buffers_internal()

Gautam Menghani (3):
      KVM: PPC: Book3S HV: Stop using vc->dpdes for nested KVM guests
      KVM: PPC: Book3S HV: Avoid returning to nested hypervisor on pending doorbells
      powerpc/pseries: Fix KVM guest detection for disabling hardlockup detector

Gautham R. Shenoy (1):
      amd-pstate: Set min_perf to nominal_perf for active mode performance gov

Geert Uytterhoeven (1):
      m68k: mvme16x: Add and use "mvme16x.h"

Greg Kroah-Hartman (2):
      Revert "serial: sh-sci: Clean sci_ports[0] after at earlycon exit"
      Linux 6.6.64

Gregory Price (1):
      tpm: fix signed/unsigned bug when checking event logs

Guenter Roeck (1):
      net: microchip: vcap: Add typegroup table terminators in kunit tests

Guilherme G. Piccoli (1):
      wifi: rtlwifi: Drastically reduce the attempts to read efuse in case of failures

Guoqing Jiang (1):
      media: mtk-jpeg: Fix null-ptr-deref during unload module

Gustavo A. R. Silva (1):
      wifi: radiotap: Avoid -Wflex-array-member-not-at-end warnings

Haiyue Wang (1):
      ice: Support FCS/CRC strip disable for VF

Hangbin Liu (3):
      netdevsim: copy addresses for both in and out paths
      wireguard: selftests: load nf_conntrack if not present
      net/ipv6: delete temporary address if mngtmpaddr is removed or unmanaged

Hannes Reinecke (1):
      nvme-multipath: avoid hang on inaccessible namespaces

Hans Verkuil (1):
      media: v4l2-core: v4l2-dv-timings: check cvt/gtf result

Hans de Goede (7):
      ASoC: codecs: rt5640: Always disable IRQs from rt5640_cancel_work()
      ASoC: Intel: bytcr_rt5640: Add support for non ACPI instantiated codec
      ASoC: Intel: bytcr_rt5640: Add DMI quirk for Vexia Edu Atla 10 tablet
      ASoC: Intel: sst: Support LPE0F28 ACPI HID
      drm: panel-orientation-quirks: Make Lenovo Yoga Tab 3 X90F DMI match less strict
      platform/x86: x86-android-tablets: Unregister devices in reverse order
      ASoC: Intel: sst: Fix used of uninitialized ctx to log an error

Hariprasad Kelam (5):
      octeontx2-af: RPM: Fix mismatch in lmac type
      octeontx2-af: RPM: Fix low network performance
      octeontx2-af: RPM: fix stale RSFEC counters
      octeontx2-af: RPM: fix stale FCFEC counters
      octeontx2-af: Quiesce traffic before NIX block reset

Harith G (1):
      ARM: 9420/1: smp: Fix SMP for xip kernels

Harshit Mogalapalli (1):
      dax: delete a stale directory pmem

Heiko Carstens (1):
      s390/pageattr: Implement missing kernel_page_present()

Henrique Carvalho (1):
      smb: client: disable directory caching when dir_cache_timeout is zero

Hersen Wu (1):
      drm/amd/display: Add NULL pointer check for kzalloc

Holger Dengler (1):
      s390/pkey: Wipe copies of clear-key structures on failure

Howard Chu (1):
      perf trace: Fix tracing itself, creating feedback loops

Hsin-Te Yuan (2):
      arm64: dts: mt8183: krane: Fix the address of eeprom at i2c4
      arm64: dts: mt8183: kukui: Fix the address of eeprom at i2c4

Huacai Chen (1):
      sh: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTACK

Hubert Wiśniewski (1):
      usb: musb: Fix hardware lockup on first Rx endpoint request

Hugo Villeneuve (1):
      serial: sc16is7xx: fix invalid FIFO access with special register set

Ian Rogers (2):
      perf stat: Fix affinity memory leaks on error path
      perf probe: Fix libdw memory leak

Igor Prusov (1):
      dt-bindings: vendor-prefixes: Add NeoFidelity, Inc

Ilpo Järvinen (3):
      selftests/resctrl: Split fill_buf to allow tests finer-grained control
      selftests/resctrl: Refactor fill_buf functions
      PCI: cpqphp: Fix PCIBIOS_* return value confusion

Ilya Zverev (1):
      ASoC: amd: yc: Add a quirk for microfone on Lenovo ThinkPad P14s Gen 5 21MES00B00

Jacob Keller (1):
      ice: consistently use q_idx in ice_vc_cfg_qs_msg()

James Clark (1):
      perf cs-etm: Don't flush when packet_queue fills up

Jan Hendrik Farr (1):
      Compiler Attributes: disable __counted_by for clang < 19.1.3

Jan Kara (1):
      ext4: avoid remount errors with 'abort' mount option

Jann Horn (1):
      comedi: Flush partial mappings in error case

Jared McArthur (1):
      arm64: dts: ti: k3-j7200: Fix register map for main domain pmx

Jarkko Sakkinen (1):
      tpm: Lock TPM chip in tpm_pm_suspend() first

Jason Andryuk (1):
      x86/pvh: Set phys_base when calling xen_prepare_pvh()

Jason Gerecke (1):
      HID: wacom: Interpret tilt data from Intuos Pro BT as signed values

Jason-JH.Lin (1):
      mailbox: mtk-cmdq: Move devm_mbox_controller_register() after devm_pm_runtime_enable()

Javier Carrasco (7):
      usb: typec: use cleanup facility for 'altmodes_node'
      clocksource/drivers/timer-ti-dm: Fix child node refcount handling
      wifi: brcmfmac: release 'root' node in all execution paths
      platform/chrome: cros_ec_typec: fix missing fwnode reference decrement
      soc: fsl: rcpm: fix missing of_node_put() in copy_ippdexpcr1_setting()
      leds: flash: mt6360: Fix device_for_each_child_node() refcounting in error paths
      drm/mediatek: Fix child node refcount handling in early exit

Jean-Michel Hautbois (1):
      m68k: mcfgpio: Fix incorrect register offset for CONFIG_M5441x

Jean-Philippe Romain (1):
      perf list: Fix topic and pmu_name argument order

Jeongjun Park (4):
      wifi: ath9k: add range check for conn_rsp_epid in htc_connect_service()
      usb: using mutex lock and supporting O_NONBLOCK flag in iowarrior_read()
      ext4: supress data-race warnings in ext4_free_inodes_{count,set}()
      netfilter: ipset: add missing range check in bitmap_ip_uadt

Jerome Brunet (1):
      hwmon: (pmbus/core) clear faults after setting smbalert mask

Jianbo Liu (1):
      IB/mlx5: Allocate resources just before first QP/SRQ is created

Jiasheng Jiang (2):
      counter: stm32-timer-cnt: Add check for clk_enable()
      counter: ti-ecap-capture: Add check for clk_enable()

Jiayuan Chen (2):
      bpf: fix filed access without lock
      bpf: fix recursive lock when verdict program return SK_PASS

Jie Zhan (1):
      cppc_cpufreq: Use desired perf if feedback ctrs are 0 or unchanged

Jing Zhang (1):
      KVM: arm64: vgic-its: Add a data length check in vgic_its_save_*

Jinjie Ruan (22):
      spi: spi-fsl-lpspi: Use IRQF_NO_AUTOEN flag in request_irq()
      soc: ti: smartreflex: Use IRQF_NO_AUTOEN flag in request_irq()
      spi: zynqmp-gqspi: Undo runtime PM changes at driver exit time​
      wifi: p54: Use IRQF_NO_AUTOEN flag in request_irq()
      wifi: mwifiex: Use IRQF_NO_AUTOEN flag in request_irq()
      drm/imx/dcss: Use IRQF_NO_AUTOEN flag in request_irq()
      drm/imx/ipuv3: Use IRQF_NO_AUTOEN flag in request_irq()
      drm/msm/adreno: Use IRQF_NO_AUTOEN flag in request_irq()
      mfd: tps65010: Use IRQF_NO_AUTOEN flag in request_irq() to fix race
      cpufreq: CPPC: Fix possible null-ptr-deref for cpufreq_cpu_get_raw()
      cpufreq: CPPC: Fix possible null-ptr-deref for cppc_get_cpu_cost()
      cpufreq: CPPC: Fix wrong return value in cppc_get_cpu_cost()
      cpufreq: CPPC: Fix wrong return value in cppc_get_cpu_power()
      misc: apds990x: Fix missing pm_runtime_disable()
      apparmor: test: Fix memory leak for aa_unpack_strdup()
      cpufreq: mediatek-hw: Fix wrong return value in mtk_cpufreq_get_cpu_power()
      rtc: st-lpc: Use IRQF_NO_AUTOEN flag in request_irq()
      media: i2c: dw9768: Fix pm_runtime_set_suspended() with runtime pm enabled
      media: amphion: Fix pm_runtime_set_suspended() with runtime pm enabled
      media: venus: Fix pm_runtime_set_suspended() with runtime pm enabled
      media: gspca: ov534-ov772x: Fix off-by-one error in set_frame_rate()
      i3c: master: svc: Fix pm_runtime_set_suspended() with runtime pm enabled

Jiri Olsa (2):
      bpf: Force uprobe bpf program to always return 0
      fs/proc/kcore.c: Clear ret value in read_kcore_iter after successful iov_iter_zero

Joe Hattori (1):
      media: platform: exynos4-is: Fix an OF node reference leak in fimc_md_is_isp_available

Johan Hovold (1):
      pinctrl: qcom: spmi: fix debugfs drive strength

John Meneghini (1):
      nvme-multipath: prepare for "queue-depth" iopolicy

John Watts (1):
      ASoC: audio-graph-card2: Purge absent supplies for device tree nodes

Jonas Gorski (1):
      mips: asm: fix warning when disabling MIPS_FP_SUPPORT

Jonathan Gray (1):
      drm: use ATOMIC64_INIT() for atomic64_t

Jonathan Marek (2):
      efi/libstub: fix efi_parse_options() ignoring the default command line
      rpmsg: glink: use only lower 16-bits of param2 for CMD_OPEN name length

Jose Ignacio Tornos Martinez (2):
      wifi: ath12k: fix warning when unbinding
      wifi: ath12k: fix crash when unbinding

Josef Bacik (1):
      btrfs: don't BUG_ON on ENOMEM from btrfs_lookup_extent_info() in walk_down_proc()

Josh Poimboeuf (1):
      parisc/ftrace: Fix function graph tracing disablement

José Expósito (1):
      drm/vkms: Drop unnecessary call to drm_crtc_cleanup()

Junxian Huang (3):
      RDMA/hns: Use dev_* printings in hem code instead of ibdev_*
      RDMA/hns: Fix out-of-order issue of requester when setting FENCE
      RDMA/hns: Fix NULL pointer derefernce in hns_roce_map_mr_sg()

Justin Tee (1):
      scsi: lpfc: Validate hdwq pointers before dereferencing in reset/errata paths

Kai Huang (4):
      x86/tdx: Skip saving output regs when SEAMCALL fails with VMFailInvalid
      x86/tdx: Make macros of TDCALLs consistent with the spec
      x86/tdx: Rename __tdx_module_call() to __tdcall()
      x86/tdx: Pass TDCALL/SEAMCALL input/output registers via a structure

Kailang Yang (3):
      ALSA: hda/realtek: Update ALC256 depop procedure
      ALSA: hda/realtek: Update ALC225 depop procedure
      ALSA: hda/realtek: Set PCBeep to default value for ALC274

Kan Liang (1):
      perf/x86/intel: Hide Topdown metrics events if the feature is not enumerated

Kashyap Desai (1):
      RDMA/bnxt_re: Check cqe flags to know imm_data vs inv_irkey

Keith Busch (1):
      nvme: apple: fix device reference counting

Kent Overstreet (1):
      closures: Change BUG_ON() to WARN_ON()

Kirill A. Shutemov (3):
      x86/tdx: Introduce wrappers to read and write TD metadata
      x86/tdx: Rename tdx_parse_tdinfo() to tdx_setup()
      x86/tdx: Dynamically disable SEPT violations from causing #VEs

Kishon Vijay Abraham I (2):
      PCI: keystone: Set mode as Root Complex for "ti,keystone-pcie" compatible
      PCI: keystone: Add link up check to ks_pcie_other_map_bus()

Konrad Dybcio (1):
      arm64: dts: qcom: sc8180x: Add a SoC-specific compatible to cpufreq-hw

Kristina Martsenko (1):
      arm64: probes: Disable kprobes/uprobes on MOPS instructions

Kuniyuki Iwashima (1):
      tcp: Fix use-after-free of nreq in reqsk_timer_handler().

Kunkun Jiang (2):
      KVM: arm64: vgic-its: Clear ITE when DISCARD frees an ITE
      KVM: arm64: vgic-its: Clear DTE when MAPD unmaps a device

Kurt Borja (2):
      platform/x86: dell-smbios-base: Extends support to Alienware products
      platform/x86: dell-wmi-base: Handle META key Lock/Unlock events

Lad Prabhakar (1):
      arm64: dts: renesas: hihope: Drop #sound-dai-cells

Leo Yan (1):
      perf probe: Correct demangled symbols in C++ program

Leon Hwang (1):
      bpf, bpftool: Fix incorrect disasm pc

Levi Yun (2):
      trace/trace_event_perf: remove duplicate samples on the first tracepoint event
      perf stat: Close cork_fd when create_perf_stat_counter() failed

Li Huafei (3):
      crypto: inside-secure - Fix the return value of safexcel_xcbcmac_cra_init()
      media: atomisp: Add check for rgby_data memory allocation failure
      drm/nouveau/gr/gf100: Fix missing unlock in gf100_gr_chan_new()

Li Lingfeng (1):
      nfs: ignore SB_RDONLY when mounting nfs

Li Zetao (1):
      media: ts2020: fix null-ptr-deref in ts2020_probe()

Li Zhijian (2):
      selftests/watchdog-test: Fix system accidentally reset after watchdog-test
      fs/inode: Prevent dump_mapping() accessing invalid dentry.d_name.name

Lifeng Zheng (1):
      ACPI: CPPC: Fix _CPC register setting issue

Lijo Lazar (1):
      drm/amdkfd: Use the correct wptr size

Linus Walleij (3):
      ARM: 9429/1: ioremap: Sync PGDs for VMALLOC shadow
      ARM: 9430/1: entry: Do a dummy read from VMAP shadow
      ARM: 9431/1: mm: Pair atomic_set_release() with _read_acquire()

Liu Jian (3):
      RDMA/rxe: Set queue pair cur_qp_state when being queried
      sunrpc: clear XPRT_SOCK_UPD_TIMEOUT when reset transport
      sunrpc: fix one UAF issue caused by sunrpc kernel tcp socket

Lizhi Xu (1):
      btrfs: add a sanity check for btrfs root in btrfs_search_slot()

Long Li (3):
      ext4: fix race in buffer_head read fault injection
      f2fs: fix race in concurrent f2fs_stop_gc_thread
      xfs: remove unknown compat feature check in superblock write validation

LongPing Wei (1):
      f2fs: fix the wrong f2fs_bug_on condition in f2fs_do_replace_block

Luca Weiss (1):
      arm64: dts: qcom: sm6350: Fix GPU frequencies missing on some speedbins

Lucas Stach (2):
      drm/etnaviv: hold GPU lock across perfmon sampling
      drm/etnaviv: flush shader L1 cache after user commandstream

Luiz Augusto von Dentz (2):
      Bluetooth: MGMT: Fix slab-use-after-free Read in set_powered_sync
      Bluetooth: MGMT: Fix possible deadlocks

Lukas Bulwahn (1):
      clk: mediatek: drop two dead config options

Lukas Wunner (1):
      PCI: Fix use-after-free of slot->bus on hot remove

Lukasz Luba (1):
      drm/msm/gpu: Check the status of registration to PM QoS

Luo Qiu (1):
      firmware: arm_scpi: Check the DVFS OPP count returned by the firmware

Luo Yifan (2):
      ASoC: stm: Prevent potential division by zero in stm32_sai_mclk_round_rate()
      ASoC: stm: Prevent potential division by zero in stm32_sai_get_clk_div()

Ma Ke (3):
      drm/sti: avoid potential dereference of error pointers in sti_hqvdp_atomic_check
      drm/sti: avoid potential dereference of error pointers in sti_gdp_atomic_check
      drm/sti: avoid potential dereference of error pointers

Ma Wupeng (1):
      ipc: fix memleak if msg_init_ns failed in create_ipc_ns

Macpaul Lin (4):
      arm64: dts: mt8195: Fix dtbs_check error for mutex node
      arm64: dts: mt8195: Fix dtbs_check error for infracfg_ao node
      arm64: dts: mediatek: mt6358: fix dtbs_check error
      ASoC: dt-bindings: mt6359: Update generic node name and dmic-mode

Manikanta Mylavarapu (1):
      soc: qcom: socinfo: fix revision check in qcom_socinfo_probe()

Marc Zyngier (1):
      KVM: arm64: vgic-v3: Sanitise guest writes to GICR_INVLPIR

Marco Elver (2):
      kcsan, seqlock: Support seqcount_latch_t
      kcsan, seqlock: Fix incorrect assumption in read_seqbegin()

Marcus Folkesson (1):
      mfd: da9052-spi: Change read-mask to write-mask

Mark Brown (1):
      clocksource/drivers:sp804: Make user selectable

Markus Petri (1):
      ASoC: amd: yc: Support dmic on another model of Lenovo Thinkpad E14 Gen 6

Masahiro Yamada (13):
      arm64: fix .data.rel.ro size assertion when CONFIG_LTO_CLANG
      s390/syscalls: Avoid creation of arch/arch/ directory
      modpost: remove ALL_EXIT_DATA_SECTIONS macro
      modpost: disallow *driver to reference .meminit* sections
      modpost: remove MEM_INIT_SECTIONS macro
      modpost: remove EXIT_SECTIONS macro
      modpost: disallow the combination of EXPORT_SYMBOL and __meminit*
      modpost: use ALL_INIT_SECTIONS for the section check from DATA_SECTIONS
      modpost: squash ALL_{INIT,EXIT}_TEXT_SECTIONS to ALL_TEXT_SECTIONS
      init/modpost: conditionally check section mismatch to __meminit*
      Rename .data.unlikely to .data..unlikely
      Rename .data.once to .data..once to fix resetting WARN*_ONCE
      modpost: remove incorrect code in do_eisa_entry()

Matt Ranostay (2):
      PCI: j721e: Add per platform maximum lane settings
      PCI: j721e: Add PCIe 4x lane selection support

Matthew Wilcox (Oracle) (3):
      ext4: remove calls to to set/clear the folio error flag
      ext4: pipeline buffer reads in mext_page_mkuptodate()
      ext4: remove array of buffer_heads from mext_page_mkuptodate()

Matthias Schiffer (1):
      drm: fsl-dcu: enable PIXCLK on LS1021A

Matti Vaittinen (1):
      iio: accel: kx022a: Fix raw read format

Maurice Lambert (1):
      netlink: typographical error in nlmsg_type constants definition

Maxime Chevallier (2):
      net: stmmac: dwmac-socfpga: Set RX watchdog interrupt as broken
      rtc: ab-eoz9: don't fail temperature reads on undervoltage notification

Maíra Canal (1):
      drm/v3d: Address race-condition in MMU flush

Meetakshi Setiya (1):
      cifs: support mounting with alternate password to allow password rotation

MengEn Sun (1):
      vmstat: call fold_vm_zone_numa_events() before show per zone NUMA event

Michael Chan (2):
      bnxt_en: Refactor bnxt_ptp_init()
      bnxt_en: Unregister PTP during PCI shutdown and suspend

Michael Ellerman (2):
      powerpc/pseries: Fix dtl_access_lock to be a rw_semaphore
      selftests/mount_setattr: Fix failures on 64K PAGE_SIZE kernels

Michael Petlan (1):
      perf trace: Keep exited threads for summary

Michal Luczaj (2):
      llc: Improve setsockopt() handling of malformed user input
      rxrpc: Improve setsockopt() handling of malformed user input

Michal Pecio (1):
      usb: xhci: Fix TD invalidation under pending Set TR Dequeue

Michal Simek (2):
      microblaze: Export xmb_manager functions
      dt-bindings: serial: rs485: Fix rs485-rts-delay property

Michal Suchanek (1):
      powerpc/sstep: make emulate_vsx_load and emulate_vsx_store static

Michal Vokáč (1):
      leds: lp55xx: Remove redundant test for invalid channel number

Michal Vrastil (1):
      Revert "usb: gadget: composite: fix OS descriptors w_value logic"

Miguel Ojeda (2):
      time: Partially revert cleanup on msecs_to_jiffies() documentation
      time: Fix references to _msecs_to_jiffies() handling of values

Mikhail Rudenko (1):
      regulator: rk808: Add apply_bit for BUCK3 on RK809

Mikulas Patocka (2):
      dm-cache: fix warnings about duplicate slab caches
      dm-bufio: fix warnings about duplicate slab caches

Ming Lei (2):
      ublk: fix ublk_ch_mmap() for 64K page size
      ublk: fix error code for unsupported command

Ming Qian (3):
      media: amphion: Set video drvdata before register video device
      media: imx-jpeg: Set video drvdata before register video device
      media: imx-jpeg: Ensure power suppliers be suspended before detach them

Mingwei Zheng (1):
      net: rfkill: gpio: Add check for clk_enable()

Miquel Raynal (1):
      mtd: rawnand: atmel: Fix possible memory leak

Mirsad Todorovac (1):
      fs/proc/kcore.c: fix coccinelle reported ERROR instances

Mostafa Saleh (1):
      iommu/io-pgtable-arm: Fix stage-2 map/unmap for concatenated tables

Muchun Song (3):
      block: fix missing dispatching request when queue is started or unquiesced
      block: fix ordering between checking QUEUE_FLAG_QUIESCED request adding
      block: fix ordering between checking BLK_MQ_S_STOPPED request adding

Murad Masimov (1):
      hwmon: (tps23861) Fix reporting of negative temperatures

Namhyung Kim (1):
      perf/arm-cmn: Ensure port and device id bits are set properly

Namjae Jeon (1):
      exfat: fix uninit-value in __exfat_get_dentry_set

Nathan Chancellor (2):
      powerpc: Fix stack protector Kconfig test for clang
      powerpc: Adjust adding stack protector flags to KBUILD_CLAGS for clang

Nicolas Bouchinet (1):
      tty: ldsic: fix tty_ldisc_autoload sysctl's proc_handler

Nobuhiro Iwamatsu (1):
      rtc: abx80x: Fix WDT bit position of the status register

Nuno Sa (3):
      dt-bindings: clock: axi-clkgen: include AXI clk
      clk: clk-axi-clkgen: make sure to enable the AXI bus clock
      iio: adc: ad7923: Fix buffer overflow for tx_buf and ring_xfer

Ojaswin Mujoo (1):
      quota: flush quota_release_work upon quota writeback

Oleg Nesterov (1):
      fs/proc: do_task_stat: use sig->stats_lock to gather the threads/children stats

Oleksandr Tymoshenko (1):
      ovl: properly handle large files in ovl_security_fileattr

Oleksij Rempel (3):
      net: usb: lan78xx: Fix double free issue with interrupt buffer allocation
      net: usb: lan78xx: Fix memory leak on device unplug by freeing PHY device
      net: usb: lan78xx: Fix refcounting and autosuspend on invalid WoL configuration

Oliver Neukum (2):
      usb: yurex: make waiting on yurex_write interruptible
      USB: chaoskey: fail open after removal

Orange Kao (1):
      EDAC/igen6: Avoid segmentation fault on module unload

Pablo Neira Ayuso (1):
      netfilter: nf_tables: skip transaction if update object is not implemented

Pali Rohár (2):
      cifs: Fix parsing native symlinks relative to the export
      cifs: Fix parsing reparse point with native symlink in SMB1 non-UNICODE session

Paolo Abeni (4):
      ipv6: release nexthop on device removal
      selftests: net: really check for bg process completion
      ip6mr: fix tables suspicious RCU usage
      ipmr: fix tables suspicious RCU usage

Paolo Bonzini (1):
      rust: macros: fix documentation of the paste! macro

Patrick Donnelly (1):
      ceph: extract entity name from device id

Patrick Rudolph (1):
      hwmon: (pmbus_core) Allow to hook PMBUS_SMBALERT_MASK

Patrisious Haddad (1):
      RDMA/mlx5: Move events notifier registration to be after device registration

Paul Aurich (5):
      smb: cached directories can be more than root file handle
      smb: Don't leak cfid when reconnect races with open_cached_dir
      smb: prevent use-after-free due to open_cached_dir error paths
      smb: During unmount, ensure all cached dir instances drop their dentry
      smb: Initialize cfid->tcon before performing network ops

Paul M Stillwell Jr (1):
      virtchnl: Add CRC stripping capability

Paulo Alcantara (2):
      smb: client: fix NULL ptr deref in crypto_aead_setkey()
      smb: client: handle max length for SMB symlinks

Pavan Chebbi (1):
      tg3: Set coherent DMA mask bits to 31 for BCM57766 chipsets

Pei Xiao (1):
      hwmon: (nct6775-core) Fix overflows seen when writing limit attributes

Peng Fan (3):
      clk: imx: lpcg-scu: SW workaround for errata (e10858)
      clk: imx: fracn-gppll: correct PLL initialization flow
      clk: imx: fracn-gppll: fix pll power up

Peter Griffin (1):
      scsi: ufs: exynos: Fix hibern8 notify callbacks

Phil Sutter (2):
      netfilter: nf_tables: Open-code audit log call in nf_tables_getrule()
      netfilter: nf_tables: Introduce nf_tables_getrule_single()

Pin-yen Lin (2):
      drm/bridge: anx7625: Drop EDID cache on bridge power off
      drm/bridge: it6505: Drop EDID cache on bridge power off

Piyush Raj Chouhan (1):
      ALSA: hda/realtek: Add subwoofer quirk for Infinix ZERO BOOK 13

Priyanka Singh (1):
      EDAC/fsl_ddr: Fix bad bit shift operations

Puranjay Mohan (1):
      nvme: fix metadata handling in nvme-passthrough

Qi Han (1):
      f2fs: compress: fix inconsistent update of i_blocks in release_compress_blocks and reserve_compress_blocks

Qingfang Deng (1):
      jffs2: fix use of uninitialized variable

Qiu-ji Chen (3):
      xen: Fix the issue of resource not being properly released in xenbus_dev_probe()
      ASoC: codecs: Fix atomicity violation in snd_soc_component_get_drvdata()
      media: wl128x: Fix atomicity violation in fmc_send_cmd()

Qiuxu Zhuo (2):
      EDAC/skx_common: Differentiate memory error sources
      EDAC/{skx_common,i10nm}: Fix incorrect far-memory error source indicator

Rafael J. Wysocki (1):
      thermal: core: Initialize thermal zones before registering them

Raghavendra Rao Ananta (2):
      KVM: arm64: Ignore PMCNTENSET_EL0 while checking for overflow status
      KVM: arm64: Get rid of userspace_irqchip_in_use

Ramya Gnanasekar (1):
      wifi: ath12k: Skip Rx TID cleanup for self peer

Randy Dunlap (1):
      fs_parser: update mount_api doc to match function signature

Reinette Chatre (2):
      selftests/resctrl: Fix memory overflow due to unhandled wraparound
      selftests/resctrl: Protect against array overrun during iMC config parsing

Ricardo Ribalda (1):
      media: uvcvideo: Stop stream during unregister

Ritesh Harjani (IBM) (3):
      powerpc/fadump: Refactor and prepare fadump_cma_init for late init
      powerpc/fadump: Move fadump_cma_init to setup_arch() after initmem_init()
      powerpc/mm/fault: Fix kfence page fault reporting

Rodrigo Siqueira (1):
      drm/amd/display: Check null pointer before try to access it

Rosen Penev (1):
      net: mdio-ipq4019: add missing error check

Sai Krishna (1):
      octeontx2-pf: Reset MAC stats during probe

Sai Kumar Cholleti (1):
      gpio: exar: set value when external pull-up or pull-down is present

Saravanan Vajravel (1):
      bnxt_en: Reserve rings after PCIe AER recovery if NIC interface is down

Sean Anderson (1):
      drm: zynqmp_kms: Unplug DRM device before removal

Sean Christopherson (1):
      KVM: x86/mmu: Skip the "try unsync" path iff the old SPTE was a leaf SPTE

Sergey Senozhatsky (1):
      zram: clear IDLE flag after recompression

Sergio Paracuellos (2):
      clk: ralink: mtmips: fix clock plan for Ralink SoC RT3883
      clk: ralink: mtmips: fix clocks probe order in oldest ralink SoCs

Shenghao Ding (1):
      ASoC: tas2781: Add new driver version for tas2563 & tas2781 qfn chip

Shengjiu Wang (1):
      ASoC: fsl_micfil: fix regmap_write_bits usage

Shyam Prasad N (1):
      cifs: during remount, make sure passwords are in sync

Si-Wei Liu (1):
      vdpa/mlx5: Fix suboptimal range on iotlb iteration

Sibi Sankar (1):
      remoteproc: qcom_q6v5_mss: Re-order writes to the IMEM region

Siddharth Vadapalli (1):
      PCI: j721e: Deassert PERST# after a delay of PCIE_T_PVPERL_MS milliseconds

Sidraya Jayagond (1):
      s390/iucv: MSG_PEEK causes memory leak in iucv_sock_destruct()

Srinivas Pandruvada (1):
      thermal: int3400: Fix reading of current_uuid for active policy

Srinivasan Shanmugam (5):
      drm/amd/display: Add NULL check for function pointer in dcn32_set_output_transfer_func
      drm/amd/display: Add null check for pipe_ctx->plane_state in dcn20_program_pipe
      drm/amd/display: Add NULL check for clk_mgr and clk_mgr->funcs in dcn30_init_hw
      drm/amd/display: Add NULL check for clk_mgr in dcn32_init_hw
      drm/amd/display: Add NULL check for function pointer in dcn20_set_output_transfer_func

Ssuhung Yeh (1):
      dm: Fix typo in error message

Stafford Horne (1):
      openrisc: Implement fixmap to fix earlycon

Stanislaw Gruszka (1):
      spi: Fix acpi deferred irq probe

Steffen Dirkwinkel (1):
      drm: xlnx: zynqmp_dpsub: fix hotplug detection

Stephen Boyd (2):
      um: Unconditionally call unflatten_device_tree()
      x86/of: Unconditionally call unflatten_and_copy_device_tree()

Steve French (1):
      smb3: request handle caching when caching directories

Steven 'Steve' Kendall (1):
      drm/radeon: Fix spurious unplug event on radeon HDMI

Steven Price (1):
      drm/panfrost: Remove unused id_mask from struct panfrost_model

Takahiro Kuwano (1):
      mtd: spi-nor: spansion: Use nor->addr_nbytes in octal DTR mode in RD_ANY_REG_OP

Takashi Iwai (8):
      ALSA: usx2y: Use snd_card_free_when_closed() at disconnection
      ALSA: us122l: Use snd_card_free_when_closed() at disconnection
      ALSA: caiaq: Use snd_card_free_when_closed() at disconnection
      ALSA: 6fire: Release resources at card release
      ALSA: usb-audio: Fix out of bounds reads when finding clock sources
      ALSA: ump: Fix evaluation of MIDI 1.0 FB info
      ALSA: pcm: Add sanity NULL check for the default mmap fault handler
      ALSA: hda/realtek: Apply quirk for Medion E15433

Tamir Duberstein (1):
      checkpatch: always parse orig_commit in fixes tag

Tao Chen (1):
      libbpf: Fix expected_attach_type set handling in program load callback

Thadeu Lima de Souza Cascardo (2):
      hfsplus: don't query the device logical block size multiple times
      media: uvcvideo: Require entities to have a non-zero unique ID

Theodore Ts'o (1):
      ext4: fix FS_IOC_GETFSMAP handling

Thinh Nguyen (2):
      usb: dwc3: gadget: Fix checking for number of TRBs left
      usb: dwc3: gadget: Fix looping of queued SG entries

Thomas Richard (4):
      arm64: dts: ti: k3-j7200: use ti,j7200-padconf compatible
      PCI: cadence: Extract link setup sequence from cdns_pcie_host_setup()
      PCI: cadence: Set cdns_pcie_host_init() global
      PCI: j721e: Use T_PERST_CLK_US macro

Thomas Song (1):
      nvme-multipath: implement "queue-depth" iopolicy

Thomas Weißschuh (1):
      tools/nolibc: s390: include std.h

Théo Lebrun (2):
      PCI: j721e: Add reset GPIO to struct j721e_pcie
      PCI: j721e: Add suspend and resume support

Tiezhu Yang (2):
      LoongArch: Fix build failure with GCC 15 (-std=gnu23)
      LoongArch: BPF: Sign-extend return values

Tiwei Bie (6):
      um: ubd: Do not use drvdata in release
      um: net: Do not use drvdata in release
      um: vector: Do not use drvdata in release
      um: Fix potential integer overflow during physmem setup
      um: Fix the return value of elf_core_copy_task_fpregs
      um: Always dump trace for specified task in show_stack

Todd Kjos (1):
      PCI: Fix reset_method_store() memory leak

Tomi Valkeinen (3):
      drm/omap: Fix possible NULL dereference
      drm/omap: Fix locking in omap_gem_new_dmabuf()
      drm/bridge: tc358767: Fix link properties discovery

Tony Ambardar (1):
      libbpf: Fix output .symtab byte-order during linking

Trond Myklebust (1):
      NFSv4.0: Fix a use-after-free problem in the asynchronous open()

Uladzislau Rezki (Sony) (2):
      rcu/kvfree: Fix data-race in __mod_timer / kvfree_call_rcu
      rcuscale: Do a proper cleanup if kfree_scale_init() fails

Umio Yasuno (1):
      drm/amd/pm: update current_socclk and current_uclk in gpu_metrics on smu v13.0.7

Usama Arif (1):
      of/fdt: add dt_phys arg to early_init_dt_scan and early_init_dt_verify

Uwe Kleine-König (1):
      mtd: hyperbus: rpc-if: Convert to platform remove callback returning void

Vasiliy Kovalev (1):
      ovl: Filter invalid inodes with missing lookup function

Vasily Gorbik (1):
      s390/entry: Mark IRQ entries to fix stack depot warnings

Venkata Prasad Potturu (1):
      ASoC: amd: yc: Fix for enabling DMIC on acp6x via _DSD entry

Veronika Molnarova (1):
      perf test attr: Add back missing topdown events

Vineeth Vijayan (1):
      s390/cio: Do not unregister the subchannel based on DNV

Vishnu Sankar (1):
      platform/x86: thinkpad_acpi: Fix for ThinkPad's with ECFW showing incorrect fan speed

Vitalii Mordan (2):
      marvell: pxa168_eth: fix call balance of pep->clk handling routines
      usb: ehci-spear: fix call balance of sehci clk handling routines

Vitaly Kuznetsov (1):
      HID: hyperv: streamline driver probe to avoid devres issues

Vitaly Prosyak (1):
      drm/amdgpu: fix usage slab after free

Vivek Kasireddy (1):
      udmabuf: use vmf_insert_pfn and VM_PFNMAP for handling mmap

Waqar Hameed (1):
      ubifs: authentication: Fix use-after-free in ubifs_tnc_end_commit

Wayne Lin (1):
      drm/amd/display: Don't refer to dc_sink in is_dsc_need_re_compute

Wei Yang (1):
      maple_tree: refine mas_store_root() on storing NULL

Weili Qian (1):
      crypto: hisilicon/qm - disable same error report before resetting

Will Deacon (1):
      arm64: tls: Fix context-switching of tpidrro_el0 when kpti is enabled

Wolfram Sang (1):
      rtc: rzn1: fix BCD to rtc_time conversion errors

Wu Hoi Pok (2):
      drm/radeon: add helper rdev_to_drm(rdev)
      drm/radeon: change rdev->ddev to rdev_to_drm(rdev)

Xiaolei Wang (1):
      drm/etnaviv: Request pages from DMA32 zone on addressing_limited

Xiuhong Wang (1):
      f2fs: fix fiemap failure issue when page size is 16KB

Xu Kuohai (1):
      bpf, arm64: Remove garbage frame for struct_ops trampoline

Yang Erkun (5):
      brd: defer automatic disk creation until module initialization succeeds
      nfsd: release svc_expkey/svc_export with rcu_work
      SUNRPC: make sure cache entry active before cache_show
      nfsd: make sure exp active before svc_export_show
      nfsd: fix nfs4_openowner leak when concurrent nfsd4_open occur

Yang Yingliang (1):
      clk: imx: imx8-acm: Fix return value check in clk_imx_acm_attach_pm_domains()

Yao Zi (1):
      platform/x86: panasonic-laptop: Return errno correctly in show callback

Ye Bin (2):
      scsi: bfa: Fix use-after-free in bfad_im_module_exit()
      svcrdma: fix miss destroy percpu_counter in svc_rdma_proc_init()

Yi Yang (1):
      crypto: pcrypt - Call crypto layer directly when padata_do_parallel() return -EBUSY

Yihang Li (1):
      scsi: hisi_sas: Enable all PHYs that are not disabled by user during controller reset

Yong-Xuan Wang (1):
      RISC-V: KVM: Fix APLIC in_clrip and clripnum write emulation

Yongliang Gao (1):
      rtc: check if __rtc_read_time was successful in rtc_timer_do_work()

Yongpeng Yang (1):
      f2fs: check curseg->inited before write_sum_page in change_curseg

Yoshihiro Shimoda (1):
      PCI: Add T_PVPERL macro

Yu Kuai (1):
      block, bfq: fix bfqq uaf in bfq_limit_depth()

Yuan Can (6):
      firmware: google: Unregister driver_info on failure
      wifi: wfx: Fix error handling in wfx_core_init()
      drm/amdkfd: Fix wrong usage of INIT_WORK()
      cpufreq: loongson2: Unregister platform_driver on failure
      md/md-bitmap: Add missing destroy_work_on_stack()
      dm thin: Add missing destroy_work_on_stack()

Yuan Chen (1):
      bpf: Fix the xdp_adjust_tail sample prog issue

Yuli Wang (1):
      LoongArch: Define a default value for VM_DATA_DEFAULT_FLAGS

Yunseong Kim (1):
      ksmbd: fix use-after-free in SMB request handling

Zeng Heng (1):
      scsi: fusion: Remove unused variable 'rc'

Zhang Changzhong (1):
      mfd: rt5033: Fix missing regmap_del_irq_chip()

Zhang Zekun (2):
      pmdomain: ti-sci: Add missing of_node_put() for args.np
      powerpc/kexec: Fix return of uninitialized variable

Zhen Lei (3):
      scsi: qedf: Fix a possible memory leak in qedf_alloc_and_init_sb()
      scsi: qedi: Fix a possible memory leak in qedi_alloc_and_init_sb()
      fbdev: sh7760fb: Fix a possible memory leak in sh7760fb_alloc_mem()

Zheng Yejian (1):
      x86/unwind/orc: Fix unwind for newly forked tasks

Zhenzhong Duan (2):
      iommu/vt-d: Fix checks and print in dmar_fault_dump_ptes()
      iommu/vt-d: Fix checks and print in pgtable_walk()

Zhiguo Niu (1):
      f2fs: fix to avoid use GC_AT when setting gc_mode as GC_URGENT_LOW or GC_URGENT_MID

Zhihao Cheng (4):
      ubi: wl: Put source PEB into correct list if trying locking LEB failed
      ubi: fastmap: wl: Schedule fm_work if wear-leveling pool is empty
      ubifs: Correct the total block count by deducting journal reservation
      ubi: fastmap: Fix duplicate slab cache names while attaching

Zhongqiu Han (1):
      PCI: endpoint: epf-mhi: Avoid NULL dereference if DT lacks 'mmio'

Zhu Yanjun (1):
      RDMA/rxe: Fix the qp flush warnings in req

Zichen Xie (1):
      drm/msm/dpu: cast crtc_clk calculation to u64 in _dpu_core_perf_calc_clk()

Zicheng Qu (5):
      drm/amd/display: Fix null check for pipe_ctx->plane_state in hwss_setup_dpp
      iio: gts: Fix uninitialized symbol 'ret'
      ad7780: fix division by zero in ad7780_write_raw()
      iio: Fix fwnode_handle in __fwnode_iio_channel_get_by_name()
      iio: gts: fix infinite loop for gain_to_scaletables()

Zijian Zhang (9):
      selftests/bpf: Fix msg_verify_data in test_sockmap
      selftests/bpf: Fix txmsg_redir of test_txmsg_pull in test_sockmap
      selftests/bpf: Add txmsg_pass to pull/push/pop in test_sockmap
      selftests/bpf: Fix SENDPAGE data logic in test_sockmap
      selftests/bpf: Fix total_bytes in msg_loop_rx in test_sockmap
      selftests/bpf: Add push/pop checking for msg_verify_data in test_sockmap
      bpf, sockmap: Several fixes to bpf_msg_push_data
      bpf, sockmap: Several fixes to bpf_msg_pop_data
      bpf, sockmap: Fix sk_msg_reset_curr

Zijun Hu (1):
      PCI: endpoint: Clear secondary (not primary) EPC in pci_epc_remove_epf()

Zizhi Wo (2):
      cachefiles: Fix missing pos updates in cachefiles_ondemand_fd_write_iter()
      netfs/fscache: Add a memory barrier for FSCACHE_VOLUME_CREATING

chao liu (1):
      apparmor: fix 'Do simple duplicate message elimination'

guoweikang (1):
      ftrace: Fix regression with module command in stack_trace_filter

lei lu (1):
      xfs: add bounds checking to xlog_recover_process_data

weiyufeng (1):
      PCI: cpqphp: Use PCI_POSSIBLE_ERROR() to check config reads

wenglianfa (2):
      RDMA/hns: Fix an AEQE overflow error caused by untimely update of eq_db_ci
      RDMA/hns: Fix cpu stuck caused by printings during reset

yuan.gao (1):
      mm/slub: Avoid list corruption when removing a slab from the full list

zhang jiao (2):
      tools/lib/thermal: Remove the thermal.h soft link when doing make clean
      pinctrl: k210: Undef K210_PC_DEFAULT


