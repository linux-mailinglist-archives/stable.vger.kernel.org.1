Return-Path: <stable+bounces-104208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BEF9F20CA
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 21:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4591885918
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 20:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1970D1B6CE6;
	Sat, 14 Dec 2024 20:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bCKcFzC7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965AB1B3926;
	Sat, 14 Dec 2024 20:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734209599; cv=none; b=sAOeDp7tjXsZ1tPPIaCn4UGGq+HSTCaLV6ZsemSTPMJ27iCx3AnE2ttdELTGwdl6tD5sge4kNRVPULstcn3a2CFFxBnbs0RLcMjzCBpnW/trt2Sqjc6hAlA6BW6D3ThwUcznKA+JoPZnI3qc8diDc37FyIWRJYJHpRr5arxey6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734209599; c=relaxed/simple;
	bh=BTIsirveVB6V9H3yCe5a4nTlhvgVSyxWrgy4tzTGLOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HIAHpoFHg/7bq7WLCwrbA3DT1KRM/cCR0iX9S4s+nGfv1qjbBTfhEY5ryoon9QfNrSmu++zYNTUzbLjv9rnbhoyR2SOo8p5bi3HIyUdy9CyaCqcd0mqk4XQLq1lo06O/EEz6/lYol6o0pEQyEvKiS8AGU9SnxhOaGvNeWkTY2i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bCKcFzC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E6CC4CED1;
	Sat, 14 Dec 2024 20:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734209599;
	bh=BTIsirveVB6V9H3yCe5a4nTlhvgVSyxWrgy4tzTGLOo=;
	h=From:To:Cc:Subject:Date:From;
	b=bCKcFzC7AUw97v1iltBEOljHUkok3ck0RFSS4lCSz9sGz6Qwdw91v4oMlVjjanmDt
	 fqPAkD/4r5eC1Q8Gs1mdaPQ7L6VUXjLVT5wIzjeKRqHo8LZoCqK956RmGclHnUttpg
	 NwCnZNX8Pl1aPGtMwz83A42Ql0F0toDAATpA3OVk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.120
Date: Sat, 14 Dec 2024 21:53:13 +0100
Message-ID: <2024121411-multiple-activist-51a1@gregkh>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.120 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-bus-pci                           |   11 
 Documentation/ABI/testing/sysfs-fs-f2fs                           |    7 
 Documentation/RCU/stallwarn.rst                                   |    2 
 Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml       |   22 
 Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml        |    2 
 Documentation/devicetree/bindings/serial/rs485.yaml               |   19 
 Documentation/devicetree/bindings/sound/mt6359.yaml               |   10 
 Documentation/devicetree/bindings/vendor-prefixes.yaml            |    2 
 Documentation/driver-api/fpga/fpga-bridge.rst                     |    7 
 Documentation/driver-api/fpga/fpga-mgr.rst                        |   34 
 Documentation/filesystems/mount_api.rst                           |    3 
 Documentation/locking/seqlock.rst                                 |    2 
 Documentation/networking/j1939.rst                                |    2 
 Makefile                                                          |    2 
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts                       |    4 
 arch/arm/kernel/entry-armv.S                                      |    8 
 arch/arm/kernel/head.S                                            |    4 
 arch/arm/kernel/psci_smp.c                                        |    7 
 arch/arm/mm/idmap.c                                               |    7 
 arch/arm/mm/ioremap.c                                             |   35 
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi           |    3 
 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi                  |    2 
 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi                  |    2 
 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi                 |    8 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts      |    3 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts       |    2 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts        |    3 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi     |    3 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi            |   56 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi             |    4 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi             |    4 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi              |    4 
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi                   |    2 
 arch/arm64/boot/dts/mediatek/mt8195.dtsi                          |    2 
 arch/arm64/kernel/fpsimd.c                                        |    1 
 arch/arm64/kernel/process.c                                       |    2 
 arch/arm64/kernel/ptrace.c                                        |    6 
 arch/arm64/kernel/smccc-call.S                                    |   35 
 arch/arm64/kernel/vmlinux.lds.S                                   |    6 
 arch/arm64/kvm/arm.c                                              |    2 
 arch/arm64/kvm/mmio.c                                             |   36 
 arch/arm64/kvm/pmu-emul.c                                         |    1 
 arch/arm64/kvm/vgic/vgic-its.c                                    |   32 
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                                |    7 
 arch/arm64/kvm/vgic/vgic.h                                        |   24 
 arch/arm64/mm/context.c                                           |    4 
 arch/arm64/net/bpf_jit_comp.c                                     |   47 
 arch/loongarch/Makefile                                           |   21 
 arch/loongarch/include/asm/hugetlb.h                              |   10 
 arch/loongarch/include/asm/page.h                                 |    5 
 arch/loongarch/include/asm/percpu.h                               |    6 
 arch/loongarch/mm/tlb.c                                           |    2 
 arch/loongarch/net/bpf_jit.c                                      |    2 
 arch/loongarch/vdso/Makefile                                      |    2 
 arch/m68k/coldfire/device.c                                       |    8 
 arch/m68k/include/asm/mcfgpio.h                                   |    2 
 arch/m68k/include/asm/mvme147hw.h                                 |    4 
 arch/m68k/kernel/early_printk.c                                   |    9 
 arch/m68k/mvme147/config.c                                        |   30 
 arch/m68k/mvme147/mvme147.h                                       |    6 
 arch/m68k/mvme16x/config.c                                        |    2 
 arch/m68k/mvme16x/mvme16x.h                                       |    6 
 arch/microblaze/kernel/microblaze_ksyms.c                         |   10 
 arch/mips/boot/dts/loongson/ls7a-pch.dtsi                         |   73 
 arch/mips/include/asm/switch_to.h                                 |    2 
 arch/parisc/kernel/ftrace.c                                       |    2 
 arch/powerpc/Kconfig                                              |    4 
 arch/powerpc/Makefile                                             |   13 
 arch/powerpc/include/asm/cache.h                                  |    4 
 arch/powerpc/include/asm/dtl.h                                    |    4 
 arch/powerpc/include/asm/fadump.h                                 |    7 
 arch/powerpc/include/asm/page_32.h                                |    4 
 arch/powerpc/include/asm/sstep.h                                  |    5 
 arch/powerpc/include/asm/vdso.h                                   |    1 
 arch/powerpc/kernel/fadump.c                                      |   23 
 arch/powerpc/kernel/prom_init.c                                   |   29 
 arch/powerpc/kernel/setup-common.c                                |    6 
 arch/powerpc/kernel/setup_64.c                                    |    1 
 arch/powerpc/kernel/vdso/Makefile                                 |   57 
 arch/powerpc/kexec/file_load_64.c                                 |    9 
 arch/powerpc/kvm/book3s_hv.c                                      |   10 
 arch/powerpc/kvm/book3s_hv_nested.c                               |   14 
 arch/powerpc/lib/sstep.c                                          |   12 
 arch/powerpc/mm/fault.c                                           |   10 
 arch/powerpc/platforms/pseries/dtl.c                              |    8 
 arch/powerpc/platforms/pseries/lpar.c                             |    8 
 arch/s390/kernel/entry.S                                          |    4 
 arch/s390/kernel/kprobes.c                                        |    6 
 arch/s390/kernel/perf_cpum_sf.c                                   |    4 
 arch/s390/kernel/syscalls/Makefile                                |    2 
 arch/sh/kernel/cpu/proc.c                                         |    2 
 arch/um/drivers/net_kern.c                                        |    2 
 arch/um/drivers/ubd_kern.c                                        |    2 
 arch/um/drivers/vector_kern.c                                     |    3 
 arch/um/kernel/physmem.c                                          |    6 
 arch/um/kernel/process.c                                          |    2 
 arch/um/kernel/sysrq.c                                            |    2 
 arch/x86/crypto/aegis128-aesni-asm.S                              |   29 
 arch/x86/events/amd/core.c                                        |   10 
 arch/x86/events/intel/core.c                                      |   34 
 arch/x86/events/intel/pt.c                                        |   11 
 arch/x86/events/intel/pt.h                                        |    2 
 arch/x86/include/asm/amd_nb.h                                     |    5 
 arch/x86/include/asm/barrier.h                                    |   18 
 arch/x86/include/asm/cpufeatures.h                                |    1 
 arch/x86/include/asm/processor.h                                  |   18 
 arch/x86/kernel/cpu/amd.c                                         |    3 
 arch/x86/kernel/cpu/common.c                                      |    7 
 arch/x86/kernel/cpu/hygon.c                                       |    3 
 arch/x86/kvm/mmu/mmu.c                                            |    5 
 arch/x86/kvm/mmu/paging_tmpl.h                                    |    5 
 arch/x86/kvm/mmu/spte.c                                           |   18 
 arch/x86/pci/acpi.c                                               |  119 
 block/blk-merge.c                                                 |   10 
 block/blk-mq.c                                                    |    6 
 block/blk-mq.h                                                    |   13 
 crypto/api.c                                                      |   63 
 crypto/internal.h                                                 |    8 
 crypto/pcrypt.c                                                   |   12 
 drivers/acpi/arm64/gtdt.c                                         |    2 
 drivers/acpi/cppc_acpi.c                                          |    1 
 drivers/base/bus.c                                                |    2 
 drivers/base/core.c                                               |   69 
 drivers/base/property.c                                           |    6 
 drivers/base/regmap/regmap-irq.c                                  |    4 
 drivers/base/regmap/regmap.c                                      |   12 
 drivers/block/brd.c                                               |   66 
 drivers/block/ublk_drv.c                                          |   17 
 drivers/block/virtio_blk.c                                        |   46 
 drivers/bluetooth/btusb.c                                         |    2 
 drivers/clk/clk-apple-nco.c                                       |    3 
 drivers/clk/clk-axi-clkgen.c                                      |   22 
 drivers/clk/imx/clk-fracn-gppll.c                                 |   10 
 drivers/clk/imx/clk-lpcg-scu.c                                    |   37 
 drivers/clk/imx/clk-scu.c                                         |    2 
 drivers/clk/qcom/gcc-qcs404.c                                     |    1 
 drivers/clk/renesas/rzg2l-cpg.c                                   |   11 
 drivers/clk/sunxi-ng/ccu-sun20i-d1.c                              |    2 
 drivers/clocksource/Kconfig                                       |    3 
 drivers/clocksource/timer-ti-dm-systimer.c                        |    4 
 drivers/comedi/comedi_fops.c                                      |   12 
 drivers/counter/stm32-timer-cnt.c                                 |   16 
 drivers/counter/ti-ecap-capture.c                                 |    7 
 drivers/cpufreq/cppc_cpufreq.c                                    |    6 
 drivers/cpufreq/loongson2_cpufreq.c                               |    4 
 drivers/cpufreq/mediatek-cpufreq-hw.c                             |    2 
 drivers/crypto/bcm/cipher.c                                       |    5 
 drivers/crypto/caam/caampkc.c                                     |   11 
 drivers/crypto/caam/qi.c                                          |    2 
 drivers/crypto/cavium/cpt/cptpf_main.c                            |    6 
 drivers/crypto/hisilicon/hpre/hpre_main.c                         |   35 
 drivers/crypto/hisilicon/qm.c                                     |   47 
 drivers/crypto/hisilicon/sec2/sec_main.c                          |   35 
 drivers/crypto/hisilicon/zip/zip_main.c                           |   35 
 drivers/crypto/inside-secure/safexcel_hash.c                      |    2 
 drivers/crypto/qat/qat_common/adf_hw_arbiter.c                    |    4 
 drivers/dax/pmem/Makefile                                         |    7 
 drivers/dax/pmem/pmem.c                                           |   10 
 drivers/dma-buf/dma-fence-array.c                                 |   28 
 drivers/dma-buf/dma-fence-unwrap.c                                |  126 
 drivers/edac/bluefield_edac.c                                     |    2 
 drivers/edac/fsl_ddr_edac.c                                       |   22 
 drivers/edac/igen6_edac.c                                         |    2 
 drivers/firmware/arm_scpi.c                                       |    3 
 drivers/firmware/efi/tpm.c                                        |   17 
 drivers/firmware/google/gsmi.c                                    |    6 
 drivers/firmware/smccc/smccc.c                                    |    4 
 drivers/fpga/fpga-bridge.c                                        |   57 
 drivers/fpga/fpga-mgr.c                                           |   82 
 drivers/gpio/gpio-exar.c                                          |   10 
 drivers/gpio/gpio-grgpio.c                                        |   26 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                          |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                       |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                        |   48 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                           |    5 
 drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c                             |    6 
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c                            |   27 
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                          |    5 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c                 |   14 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c                |    3 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c                |    7 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c                |   11 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c             |    3 
 drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c |    2 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c              |    7 
 drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c     |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c              |    2 
 drivers/gpu/drm/bridge/analogix/anx7625.c                         |    2 
 drivers/gpu/drm/bridge/ite-it6505.c                               |   11 
 drivers/gpu/drm/bridge/tc358767.c                                 |    7 
 drivers/gpu/drm/display/drm_dp_dual_mode_helper.c                 |    4 
 drivers/gpu/drm/display/drm_dp_mst_topology.c                     |   55 
 drivers/gpu/drm/drm_mm.c                                          |    2 
 drivers/gpu/drm/drm_panel_orientation_quirks.c                    |   19 
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c                          |    3 
 drivers/gpu/drm/etnaviv/etnaviv_drv.c                             |   10 
 drivers/gpu/drm/etnaviv/etnaviv_dump.c                            |    7 
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c                             |   48 
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h                             |   21 
 drivers/gpu/drm/fsl-dcu/Kconfig                                   |    1 
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c                         |   15 
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h                         |    3 
 drivers/gpu/drm/imx/dcss/dcss-crtc.c                              |    6 
 drivers/gpu/drm/imx/ipuv3-crtc.c                                  |    6 
 drivers/gpu/drm/mcde/mcde_drv.c                                   |    1 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                             |    4 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                             |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c                     |    2 
 drivers/gpu/drm/msm/msm_debugfs.c                                 |   12 
 drivers/gpu/drm/msm/msm_drv.h                                     |    9 
 drivers/gpu/drm/msm/msm_gpu.h                                     |   15 
 drivers/gpu/drm/msm/msm_gpu_devfreq.c                             |  148 
 drivers/gpu/drm/omapdrm/dss/base.c                                |   25 
 drivers/gpu/drm/omapdrm/dss/omapdss.h                             |    3 
 drivers/gpu/drm/omapdrm/omap_drv.c                                |    4 
 drivers/gpu/drm/omapdrm/omap_gem.c                                |   10 
 drivers/gpu/drm/panel/panel-simple.c                              |   28 
 drivers/gpu/drm/panfrost/panfrost_gpu.c                           |    1 
 drivers/gpu/drm/radeon/r600_cs.c                                  |    2 
 drivers/gpu/drm/scheduler/sched_main.c                            |    8 
 drivers/gpu/drm/sti/sti_cursor.c                                  |    3 
 drivers/gpu/drm/sti/sti_gdp.c                                     |    3 
 drivers/gpu/drm/sti/sti_hqvdp.c                                   |    3 
 drivers/gpu/drm/sti/sti_mixer.c                                   |    2 
 drivers/gpu/drm/ttm/ttm_bo_util.c                                 |   13 
 drivers/gpu/drm/ttm/ttm_tt.c                                      |   12 
 drivers/gpu/drm/v3d/v3d_mmu.c                                     |   29 
 drivers/gpu/drm/v3d/v3d_perfmon.c                                 |    2 
 drivers/gpu/drm/vc4/vc4_drv.h                                     |    1 
 drivers/gpu/drm/vc4/vc4_hdmi.c                                    |    6 
 drivers/gpu/drm/vc4/vc4_hvs.c                                     |   31 
 drivers/hid/hid-ids.h                                             |    1 
 drivers/hid/hid-magicmouse.c                                      |   56 
 drivers/hid/wacom_sys.c                                           |    3 
 drivers/hid/wacom_wac.c                                           |    4 
 drivers/hwmon/nct6775-core.c                                      |    7 
 drivers/hwmon/tps23861.c                                          |    2 
 drivers/i3c/master.c                                              |  201 
 drivers/i3c/master/dw-i3c-master.c                                |    5 
 drivers/i3c/master/i3c-master-cdns.c                              |    5 
 drivers/i3c/master/mipi-i3c-hci/core.c                            |    4 
 drivers/i3c/master/mipi-i3c-hci/dma.c                             |    2 
 drivers/i3c/master/svc-i3c-master.c                               |  148 
 drivers/iio/adc/ad7780.c                                          |    2 
 drivers/iio/adc/ad7923.c                                          |    4 
 drivers/iio/inkern.c                                              |    2 
 drivers/iio/light/al3010.c                                        |   11 
 drivers/iio/light/ltr501.c                                        |    2 
 drivers/iio/magnetometer/yamaha-yas530.c                          |   13 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                          |    7 
 drivers/infiniband/hw/bnxt_re/qplib_fp.h                          |    2 
 drivers/infiniband/hw/hns/hns_roce_cq.c                           |    4 
 drivers/infiniband/hw/hns/hns_roce_device.h                       |    1 
 drivers/infiniband/hw/hns/hns_roce_hem.c                          |   76 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                        |  172 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h                        |    6 
 drivers/infiniband/hw/hns/hns_roce_mr.c                           |   11 
 drivers/infiniband/hw/hns/hns_roce_qp.c                           |   54 
 drivers/infiniband/hw/hns/hns_roce_srq.c                          |    4 
 drivers/iommu/arm/arm-smmu/arm-smmu.c                             |   11 
 drivers/iommu/intel/iommu.c                                       |   40 
 drivers/iommu/io-pgtable-arm.c                                    |   18 
 drivers/leds/flash/leds-mt6360.c                                  |    3 
 drivers/leds/led-class.c                                          |   14 
 drivers/leds/leds-lp55xx-common.c                                 |    3 
 drivers/mailbox/arm_mhuv2.c                                       |    8 
 drivers/mailbox/mtk-cmdq-mailbox.c                                |   12 
 drivers/md/bcache/closure.c                                       |   10 
 drivers/md/bcache/super.c                                         |    2 
 drivers/md/dm-thin.c                                              |    1 
 drivers/media/dvb-frontends/ts2020.c                              |    8 
 drivers/media/i2c/adv7604.c                                       |    5 
 drivers/media/i2c/adv7842.c                                       |   13 
 drivers/media/i2c/dw9768.c                                        |   10 
 drivers/media/i2c/tc358743.c                                      |    4 
 drivers/media/platform/allegro-dvt/allegro-core.c                 |    4 
 drivers/media/platform/amphion/vpu_drv.c                          |    2 
 drivers/media/platform/amphion/vpu_v4l2.c                         |    2 
 drivers/media/platform/aspeed/aspeed-video.c                      |    4 
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c                    |    4 
 drivers/media/platform/qcom/venus/core.c                          |    2 
 drivers/media/platform/qcom/venus/core.h                          |   11 
 drivers/media/platform/qcom/venus/vdec.c                          |    4 
 drivers/media/platform/qcom/venus/venc.c                          |   72 
 drivers/media/platform/samsung/exynos4-is/media-dev.h             |    5 
 drivers/media/radio/wl128x/fmdrv_common.c                         |    3 
 drivers/media/test-drivers/vivid/vivid-vid-cap.c                  |   15 
 drivers/media/usb/cx231xx/cx231xx-cards.c                         |    2 
 drivers/media/usb/gspca/ov534.c                                   |    2 
 drivers/media/usb/uvc/uvc_driver.c                                |  113 
 drivers/media/v4l2-core/v4l2-dv-timings.c                         |  132 
 drivers/memory/renesas-rpc-if.c                                   |   42 
 drivers/message/fusion/mptsas.c                                   |    4 
 drivers/mfd/da9052-spi.c                                          |    2 
 drivers/mfd/intel_soc_pmic_bxtwc.c                                |  126 
 drivers/mfd/rt5033.c                                              |    4 
 drivers/mfd/tps65010.c                                            |    8 
 drivers/misc/apds990x.c                                           |   12 
 drivers/misc/eeprom/eeprom_93cx6.c                                |   10 
 drivers/mmc/core/bus.c                                            |    2 
 drivers/mmc/core/card.h                                           |    7 
 drivers/mmc/core/core.c                                           |    3 
 drivers/mmc/core/quirks.h                                         |    9 
 drivers/mmc/core/sd.c                                             |    2 
 drivers/mmc/host/mmc_spi.c                                        |    9 
 drivers/mmc/host/mtk-sd.c                                         |    9 
 drivers/mmc/host/sdhci-pci-core.c                                 |   72 
 drivers/mmc/host/sdhci-pci.h                                      |    1 
 drivers/mtd/hyperbus/rpc-if.c                                     |   31 
 drivers/mtd/nand/raw/atmel/pmecc.c                                |    8 
 drivers/mtd/nand/raw/atmel/pmecc.h                                |    2 
 drivers/mtd/spi-nor/core.c                                        |    2 
 drivers/mtd/ubi/attach.c                                          |   12 
 drivers/mtd/ubi/fastmap-wl.c                                      |   19 
 drivers/mtd/ubi/wl.c                                              |   11 
 drivers/mtd/ubi/wl.h                                              |    3 
 drivers/net/can/c_can/c_can_main.c                                |   26 
 drivers/net/can/dev/dev.c                                         |    2 
 drivers/net/can/ifi_canfd/ifi_canfd.c                             |   58 
 drivers/net/can/m_can/m_can.c                                     |   33 
 drivers/net/can/sja1000/sja1000.c                                 |   67 
 drivers/net/can/spi/hi311x.c                                      |   50 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c                     |   29 
 drivers/net/can/sun4i_can.c                                       |   22 
 drivers/net/can/usb/ems_usb.c                                     |   58 
 drivers/net/can/usb/gs_usb.c                                      |  104 
 drivers/net/dsa/qca/qca8k-8xxx.c                                  |    2 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c                  |    9 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                         |    8 
 drivers/net/ethernet/broadcom/tg3.c                               |    3 
 drivers/net/ethernet/cavium/liquidio/lio_main.c                   |   11 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ptp.c                    |   13 
 drivers/net/ethernet/freescale/fec_mpc52xx_phy.c                  |    2 
 drivers/net/ethernet/freescale/fec_ptp.c                          |   13 
 drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c              |    2 
 drivers/net/ethernet/google/gve/gve_main.c                        |    7 
 drivers/net/ethernet/google/gve/gve_rx.c                          |    4 
 drivers/net/ethernet/google/gve/gve_tx.c                          |    4 
 drivers/net/ethernet/intel/igb/igb_main.c                         |    4 
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.h                   |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c                    |    2 
 drivers/net/ethernet/intel/ixgbevf/ipsec.c                        |    1 
 drivers/net/ethernet/marvell/octeontx2/af/rpm.c                   |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c                |    5 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c          |    4 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c           |    5 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_dmac_flt.c        |    9 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c         |   10 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c           |   10 
 drivers/net/ethernet/marvell/pxa168_eth.c                         |   14 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c         |   13 
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h                    |    1 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c                |    5 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c           |    4 
 drivers/net/ethernet/qlogic/qed/qed_mcp.c                         |    4 
 drivers/net/ethernet/qlogic/qede/qede_ptp.c                       |   13 
 drivers/net/ethernet/realtek/r8169_main.c                         |   14 
 drivers/net/ethernet/rocker/rocker_main.c                         |    2 
 drivers/net/ethernet/sfc/ptp.c                                    |    7 
 drivers/net/ethernet/sfc/siena/ptp.c                              |    7 
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c               |    2 
 drivers/net/ethernet/ti/am65-cpts.c                               |    5 
 drivers/net/geneve.c                                              |    2 
 drivers/net/mdio/mdio-ipq4019.c                                   |    5 
 drivers/net/netdevsim/ipsec.c                                     |   11 
 drivers/net/phy/sfp.c                                             |    3 
 drivers/net/usb/lan78xx.c                                         |   40 
 drivers/net/usb/qmi_wwan.c                                        |    1 
 drivers/net/usb/r8152.c                                           |    1 
 drivers/net/veth.c                                                |   44 
 drivers/net/vrf.c                                                 |   24 
 drivers/net/wireless/ath/ath10k/mac.c                             |    4 
 drivers/net/wireless/ath/ath5k/pci.c                              |    2 
 drivers/net/wireless/ath/ath9k/htc_hst.c                          |    3 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c         |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c             |    3 
 drivers/net/wireless/intel/ipw2x00/libipw_rx.c                    |    8 
 drivers/net/wireless/intel/iwlwifi/fw/init.c                      |    4 
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c                       |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c                       |   12 
 drivers/net/wireless/intersil/p54/p54spi.c                        |    4 
 drivers/net/wireless/marvell/mwifiex/fw.h                         |    2 
 drivers/net/wireless/marvell/mwifiex/main.c                       |    4 
 drivers/net/wireless/realtek/rtlwifi/efuse.c                      |   11 
 drivers/net/wireless/realtek/rtw89/mac80211.c                     |    4 
 drivers/net/wireless/realtek/rtw89/util.h                         |   18 
 drivers/net/wireless/silabs/wfx/main.c                            |   17 
 drivers/nvdimm/dax_devs.c                                         |    4 
 drivers/nvdimm/nd.h                                               |    7 
 drivers/nvme/host/pci.c                                           |   55 
 drivers/pci/controller/dwc/pci-keystone.c                         |   12 
 drivers/pci/controller/pcie-rockchip-ep.c                         |   16 
 drivers/pci/controller/pcie-rockchip.h                            |    4 
 drivers/pci/endpoint/pci-epc-core.c                               |   13 
 drivers/pci/hotplug/cpqphp_pci.c                                  |   19 
 drivers/pci/pci-sysfs.c                                           |   26 
 drivers/pci/pci.c                                                 |    7 
 drivers/pci/pci.h                                                 |    1 
 drivers/pci/probe.c                                               |   30 
 drivers/pci/quirks.c                                              |   15 
 drivers/pci/slot.c                                                |    4 
 drivers/perf/arm-cmn.c                                            |    4 
 drivers/perf/arm_smmuv3_pmu.c                                     |   19 
 drivers/pinctrl/freescale/Kconfig                                 |    2 
 drivers/pinctrl/pinctrl-k210.c                                    |    2 
 drivers/pinctrl/pinctrl-zynqmp.c                                  |    1 
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c                          |    4 
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c                           |    1 
 drivers/platform/chrome/cros_ec_typec.c                           |    1 
 drivers/platform/x86/dell/dell-smbios-base.c                      |    1 
 drivers/platform/x86/dell/dell-wmi-base.c                         |    6 
 drivers/platform/x86/intel/bxtwc_tmu.c                            |   22 
 drivers/platform/x86/panasonic-laptop.c                           |   10 
 drivers/platform/x86/thinkpad_acpi.c                              |   28 
 drivers/power/supply/bq27xxx_battery.c                            |   37 
 drivers/power/supply/power_supply_core.c                          |    2 
 drivers/ptp/ptp_clock.c                                           |    3 
 drivers/ptp/ptp_dte.c                                             |    5 
 drivers/pwm/pwm-imx27.c                                           |   98 
 drivers/regulator/rk808-regulator.c                               |    2 
 drivers/remoteproc/qcom_q6v5_mss.c                                |    6 
 drivers/remoteproc/qcom_q6v5_pas.c                                |   44 
 drivers/rpmsg/qcom_glink_native.c                                 |  101 
 drivers/rtc/interface.c                                           |    7 
 drivers/rtc/rtc-ab-eoz9.c                                         |    7 
 drivers/rtc/rtc-abx80x.c                                          |    2 
 drivers/rtc/rtc-cmos.c                                            |   31 
 drivers/rtc/rtc-rzn1.c                                            |    8 
 drivers/rtc/rtc-st-lpc.c                                          |    5 
 drivers/s390/cio/cio.c                                            |    6 
 drivers/s390/cio/device.c                                         |   18 
 drivers/scsi/bfa/bfad.c                                           |    3 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                            |    1 
 drivers/scsi/lpfc/lpfc_hbadisc.c                                  |    3 
 drivers/scsi/lpfc/lpfc_scsi.c                                     |   13 
 drivers/scsi/lpfc/lpfc_sli.c                                      |   11 
 drivers/scsi/qedf/qedf_main.c                                     |    1 
 drivers/scsi/qedi/qedi_main.c                                     |    1 
 drivers/scsi/qla2xxx/qla_attr.c                                   |    1 
 drivers/scsi/qla2xxx/qla_bsg.c                                    |  124 
 drivers/scsi/qla2xxx/qla_mid.c                                    |    1 
 drivers/scsi/qla2xxx/qla_os.c                                     |   15 
 drivers/scsi/scsi_debug.c                                         |    2 
 drivers/scsi/st.c                                                 |   31 
 drivers/sh/intc/core.c                                            |    2 
 drivers/soc/fsl/rcpm.c                                            |    1 
 drivers/soc/imx/soc-imx8m.c                                       |  107 
 drivers/soc/qcom/qcom-geni-se.c                                   |    3 
 drivers/soc/qcom/socinfo.c                                        |    8 
 drivers/soc/ti/smartreflex.c                                      |    4 
 drivers/soc/ti/ti_sci_pm_domains.c                                |    4 
 drivers/soc/xilinx/xlnx_event_manager.c                           |    4 
 drivers/spi/atmel-quadspi.c                                       |    2 
 drivers/spi/spi-fsl-lpspi.c                                       |   14 
 drivers/spi/spi-mpc52xx.c                                         |    1 
 drivers/spi/spi-rpc-if.c                                          |   14 
 drivers/spi/spi-tegra210-quad.c                                   |    2 
 drivers/spi/spi-zynqmp-gqspi.c                                    |    2 
 drivers/spi/spi.c                                                 |   13 
 drivers/staging/media/atomisp/pci/sh_css_params.c                 |    2 
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c           |    2 
 drivers/thermal/thermal_core.c                                    |    2 
 drivers/tty/serial/8250/8250_dw.c                                 |    5 
 drivers/tty/serial/8250/8250_fintek.c                             |   14 
 drivers/tty/serial/8250/8250_omap.c                               |    4 
 drivers/tty/serial/amba-pl011.c                                   |   79 
 drivers/tty/serial/sc16is7xx.c                                    |    5 
 drivers/tty/tty_ldisc.c                                           |    2 
 drivers/ufs/core/ufs-sysfs.c                                      |    6 
 drivers/ufs/core/ufshcd.c                                         |   11 
 drivers/ufs/host/ufs-exynos.c                                     |   16 
 drivers/ufs/host/ufs-renesas.c                                    |    9 
 drivers/usb/chipidea/udc.c                                        |    2 
 drivers/usb/dwc3/core.h                                           |    1 
 drivers/usb/dwc3/ep0.c                                            |    7 
 drivers/usb/dwc3/gadget.c                                         |  104 
 drivers/usb/dwc3/gadget.h                                         |    1 
 drivers/usb/gadget/composite.c                                    |   18 
 drivers/usb/host/ehci-spear.c                                     |    7 
 drivers/usb/host/xhci-dbgcap.c                                    |  135 
 drivers/usb/host/xhci-dbgcap.h                                    |    2 
 drivers/usb/host/xhci-ring.c                                      |   18 
 drivers/usb/misc/chaoskey.c                                       |   35 
 drivers/usb/misc/iowarrior.c                                      |   50 
 drivers/usb/misc/yurex.c                                          |    5 
 drivers/usb/musb/musb_gadget.c                                    |   13 
 drivers/usb/typec/tcpm/wcove.c                                    |    4 
 drivers/vdpa/mlx5/core/mr.c                                       |    4 
 drivers/vfio/pci/mlx5/cmd.c                                       |   47 
 drivers/vfio/pci/vfio_pci_config.c                                |   16 
 drivers/video/fbdev/efifb.c                                       |   11 
 drivers/video/fbdev/sh7760fb.c                                    |   11 
 drivers/watchdog/apple_wdt.c                                      |    2 
 drivers/watchdog/iTCO_wdt.c                                       |   21 
 drivers/watchdog/mtk_wdt.c                                        |    6 
 drivers/watchdog/rti_wdt.c                                        |    3 
 drivers/xen/xenbus/xenbus_probe.c                                 |    8 
 fs/btrfs/ctree.c                                                  |   10 
 fs/btrfs/ctree.h                                                  |    2 
 fs/btrfs/extent-tree.c                                            |    3 
 fs/btrfs/inode.c                                                  |   14 
 fs/btrfs/ioctl.c                                                  |   36 
 fs/btrfs/ref-verify.c                                             |    1 
 fs/btrfs/root-tree.c                                              |   10 
 fs/btrfs/volumes.c                                                |   42 
 fs/cachefiles/ondemand.c                                          |    4 
 fs/ceph/super.c                                                   |   10 
 fs/eventpoll.c                                                    |    6 
 fs/exfat/namei.c                                                  |    1 
 fs/ext4/ext4.h                                                    |    1 
 fs/ext4/fsmap.c                                                   |   54 
 fs/ext4/mballoc.c                                                 |   18 
 fs/ext4/mballoc.h                                                 |    1 
 fs/ext4/super.c                                                   |   33 
 fs/f2fs/file.c                                                    |    8 
 fs/f2fs/gc.c                                                      |    2 
 fs/f2fs/inode.c                                                   |    4 
 fs/f2fs/segment.c                                                 |   74 
 fs/f2fs/segment.h                                                 |   41 
 fs/fscache/volume.c                                               |    3 
 fs/hfsplus/hfsplus_fs.h                                           |    3 
 fs/hfsplus/wrapper.c                                              |    2 
 fs/inode.c                                                        |   10 
 fs/jffs2/compr_rtime.c                                            |    3 
 fs/jffs2/erase.c                                                  |    7 
 fs/jfs/jfs_dmap.c                                                 |    6 
 fs/jfs/jfs_dtree.c                                                |   15 
 fs/jfs/xattr.c                                                    |    2 
 fs/nfs/internal.h                                                 |    2 
 fs/nfs/nfs4proc.c                                                 |    8 
 fs/nfsd/export.c                                                  |    5 
 fs/nfsd/nfs4callback.c                                            |   16 
 fs/nfsd/nfs4proc.c                                                |    7 
 fs/nfsd/nfs4recover.c                                             |    3 
 fs/nfsd/nfs4state.c                                               |   19 
 fs/nilfs2/dir.c                                                   |    2 
 fs/notify/fsnotify.c                                              |   23 
 fs/ntfs3/record.c                                                 |   32 
 fs/ocfs2/aops.h                                                   |    2 
 fs/ocfs2/dlmglue.c                                                |    1 
 fs/ocfs2/file.c                                                   |    4 
 fs/ocfs2/localalloc.c                                             |   19 
 fs/ocfs2/namei.c                                                  |    4 
 fs/overlayfs/inode.c                                              |    7 
 fs/overlayfs/util.c                                               |    3 
 fs/proc/kcore.c                                                   |   11 
 fs/proc/softirqs.c                                                |    2 
 fs/quota/dquot.c                                                  |    2 
 fs/smb/client/cached_dir.c                                        |    2 
 fs/smb/client/cifssmb.c                                           |    2 
 fs/smb/client/smb2ops.c                                           |    8 
 fs/smb/server/smb2pdu.c                                           |    6 
 fs/ubifs/super.c                                                  |    6 
 fs/ubifs/tnc_commit.c                                             |    2 
 fs/udf/inode.c                                                    |   46 
 fs/unicode/mkutf8data.c                                           |   70 
 fs/unicode/utf8-core.c                                            |    2 
 fs/unicode/utf8data.c_shipped                                     | 6703 +++++-----
 fs/xfs/libxfs/xfs_sb.c                                            |    7 
 fs/xfs/xfs_log_recover.c                                          |    5 
 include/drm/display/drm_dp_mst_helper.h                           |    7 
 include/drm/ttm/ttm_tt.h                                          |    7 
 include/linux/arm-smccc.h                                         |   30 
 include/linux/blkdev.h                                            |    2 
 include/linux/bpf.h                                               |    7 
 include/linux/cache.h                                             |    6 
 include/linux/crypto.h                                            |    1 
 include/linux/devfreq.h                                           |    7 
 include/linux/dma-mapping.h                                       |    5 
 include/linux/eeprom_93cx6.h                                      |   11 
 include/linux/eventpoll.h                                         |    2 
 include/linux/fpga/fpga-bridge.h                                  |   10 
 include/linux/fpga/fpga-mgr.h                                     |   26 
 include/linux/fwnode.h                                            |    2 
 include/linux/hisi_acc_qm.h                                       |    8 
 include/linux/i3c/master.h                                        |   35 
 include/linux/jiffies.h                                           |    2 
 include/linux/leds.h                                              |    2 
 include/linux/lockdep.h                                           |    2 
 include/linux/mmc/card.h                                          |    1 
 include/linux/netdevice.h                                         |   30 
 include/linux/netpoll.h                                           |    2 
 include/linux/pci-epc.h                                           |    2 
 include/linux/pci.h                                               |    6 
 include/linux/property.h                                          |   20 
 include/linux/rbtree_latch.h                                      |    2 
 include/linux/scatterlist.h                                       |    2 
 include/linux/seqlock.h                                           |  107 
 include/linux/slab.h                                              |   14 
 include/linux/sock_diag.h                                         |   10 
 include/linux/util_macros.h                                       |   56 
 include/media/v4l2-dv-timings.h                                   |   18 
 include/memory/renesas-rpc-if.h                                   |   18 
 include/net/bluetooth/hci_sync.h                                  |   12 
 include/net/sock.h                                                |    2 
 include/trace/trace_events.h                                      |   36 
 include/uapi/linux/rtnetlink.h                                    |    2 
 include/ufs/ufshcd.h                                              |   19 
 init/initramfs.c                                                  |   15 
 io_uring/io_uring.c                                               |   12 
 io_uring/tctx.c                                                   |   13 
 ipc/namespace.c                                                   |    4 
 kernel/bpf/devmap.c                                               |    6 
 kernel/bpf/helpers.c                                              |    6 
 kernel/bpf/lpm_trie.c                                             |   55 
 kernel/bpf/syscall.c                                              |    3 
 kernel/bpf/verifier.c                                             |   41 
 kernel/cgroup/cgroup.c                                            |   21 
 kernel/dma/debug.c                                                |    8 
 kernel/kcsan/debugfs.c                                            |   74 
 kernel/printk/printk.c                                            |    2 
 kernel/rcu/tasks.h                                                |   82 
 kernel/sched/core.c                                               |    4 
 kernel/sched/fair.c                                               |    2 
 kernel/time/ntp.c                                                 |    2 
 kernel/time/sched_clock.c                                         |    2 
 kernel/time/time.c                                                |    2 
 kernel/time/timekeeping.c                                         |    4 
 kernel/trace/bpf_trace.c                                          |    6 
 kernel/trace/ftrace.c                                             |    3 
 kernel/trace/trace_clock.c                                        |    2 
 kernel/trace/trace_eprobe.c                                       |    5 
 kernel/trace/trace_event_perf.c                                   |    6 
 kernel/trace/trace_syscalls.c                                     |   12 
 kernel/trace/tracing_map.c                                        |    6 
 lib/maple_tree.c                                                  |   13 
 lib/stackinit_kunit.c                                             |    1 
 lib/string_helpers.c                                              |    2 
 mm/damon/vaddr-test.h                                             |    1 
 mm/damon/vaddr.c                                                  |    4 
 mm/kasan/report.c                                                 |   65 
 mm/mmap.c                                                         |    4 
 mm/page_alloc.c                                                   |   15 
 mm/swap.c                                                         |   20 
 mm/vmstat.c                                                       |    1 
 net/9p/trans_xen.c                                                |    9 
 net/bluetooth/hci_core.c                                          |   13 
 net/bluetooth/hci_sync.c                                          |  132 
 net/bluetooth/hci_sysfs.c                                         |   15 
 net/bluetooth/l2cap_sock.c                                        |    1 
 net/bluetooth/mgmt.c                                              |   61 
 net/bluetooth/rfcomm/sock.c                                       |   20 
 net/can/af_can.c                                                  |    1 
 net/can/j1939/transport.c                                         |    2 
 net/core/dev.c                                                    |   61 
 net/core/filter.c                                                 |   95 
 net/core/gen_estimator.c                                          |    2 
 net/core/neighbour.c                                              |    1 
 net/core/netpoll.c                                                |    2 
 net/core/rtnetlink.c                                              |    2 
 net/core/skmsg.c                                                  |    4 
 net/core/sock_diag.c                                              |  114 
 net/dccp/feat.c                                                   |    6 
 net/ethtool/bitset.c                                              |   48 
 net/hsr/hsr_device.c                                              |    4 
 net/hsr/hsr_forward.c                                             |    2 
 net/ieee802154/socket.c                                           |   12 
 net/ipv4/af_inet.c                                                |   22 
 net/ipv4/cipso_ipv4.c                                             |    2 
 net/ipv4/inet_connection_sock.c                                   |    2 
 net/ipv4/inet_diag.c                                              |   11 
 net/ipv4/ip_output.c                                              |   13 
 net/ipv4/ipmr.c                                                   |   42 
 net/ipv4/ipmr_base.c                                              |    3 
 net/ipv4/tcp.c                                                    |    2 
 net/ipv4/tcp_bpf.c                                                |   18 
 net/ipv4/tcp_fastopen.c                                           |    7 
 net/ipv4/udp.c                                                    |    2 
 net/ipv6/addrconf.c                                               |   41 
 net/ipv6/af_inet6.c                                               |   24 
 net/ipv6/ip6_fib.c                                                |    2 
 net/ipv6/ip6_output.c                                             |   13 
 net/ipv6/ip6mr.c                                                  |   38 
 net/ipv6/ipv6_sockglue.c                                          |    3 
 net/ipv6/route.c                                                  |   16 
 net/iucv/af_iucv.c                                                |   26 
 net/llc/af_llc.c                                                  |    2 
 net/mac80211/main.c                                               |    2 
 net/mptcp/protocol.c                                              |    4 
 net/netfilter/ipset/ip_set_bitmap_ip.c                            |    7 
 net/netfilter/ipset/ip_set_core.c                                 |    5 
 net/netfilter/ipvs/ip_vs_proto.c                                  |    4 
 net/netfilter/nf_tables_api.c                                     |   19 
 net/netfilter/nft_set_hash.c                                      |   16 
 net/netfilter/nft_socket.c                                        |    2 
 net/netfilter/xt_LED.c                                            |    4 
 net/netlink/diag.c                                                |    1 
 net/packet/af_packet.c                                            |   12 
 net/packet/diag.c                                                 |    1 
 net/rfkill/rfkill-gpio.c                                          |    8 
 net/rxrpc/af_rxrpc.c                                              |    7 
 net/sched/act_api.c                                               |    2 
 net/sched/cls_flower.c                                            |    5 
 net/sched/sch_cbs.c                                               |    2 
 net/sched/sch_tbf.c                                               |   18 
 net/smc/af_smc.c                                                  |    2 
 net/smc/smc_diag.c                                                |    1 
 net/sunrpc/cache.c                                                |    4 
 net/sunrpc/xprtrdma/svc_rdma.c                                    |   40 
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c                           |    8 
 net/sunrpc/xprtsock.c                                             |    1 
 net/tipc/diag.c                                                   |    1 
 net/tipc/udp_media.c                                              |    2 
 net/unix/diag.c                                                   |    1 
 net/vmw_vsock/diag.c                                              |    1 
 net/xdp/xsk_buff_pool.c                                           |    5 
 net/xdp/xsk_diag.c                                                |    1 
 net/xdp/xskmap.c                                                  |    2 
 samples/bpf/test_cgrp2_sock.c                                     |    4 
 samples/bpf/xdp_adjust_tail_kern.c                                |    1 
 scripts/mod/file2alias.c                                          |    5 
 scripts/mod/modpost.c                                             |    4 
 security/apparmor/capability.c                                    |    2 
 security/apparmor/policy_unpack_test.c                            |    6 
 sound/core/pcm_native.c                                           |    6 
 sound/hda/intel-dsp-config.c                                      |    4 
 sound/pci/hda/patch_realtek.c                                     |  157 
 sound/soc/amd/yc/acp6x-mach.c                                     |   39 
 sound/soc/codecs/da7219.c                                         |    9 
 sound/soc/codecs/hdmi-codec.c                                     |  140 
 sound/soc/fsl/fsl_micfil.c                                        |    4 
 sound/soc/generic/audio-graph-card2.c                             |    3 
 sound/soc/intel/atom/sst/sst_acpi.c                               |   64 
 sound/soc/intel/avs/pcm.c                                         |    2 
 sound/soc/intel/boards/bytcr_rt5640.c                             |   48 
 sound/soc/stm/stm32_sai_sub.c                                     |    6 
 sound/usb/6fire/chip.c                                            |   10 
 sound/usb/caiaq/audio.c                                           |   10 
 sound/usb/caiaq/audio.h                                           |    1 
 sound/usb/caiaq/device.c                                          |   19 
 sound/usb/caiaq/input.c                                           |   12 
 sound/usb/caiaq/input.h                                           |    1 
 sound/usb/clock.c                                                 |   24 
 sound/usb/endpoint.c                                              |   14 
 sound/usb/mixer.c                                                 |   58 
 sound/usb/mixer_maps.c                                            |   10 
 sound/usb/quirks-table.h                                          |   14 
 sound/usb/quirks.c                                                |   58 
 sound/usb/usbaudio.h                                              |    4 
 sound/usb/usx2y/us122l.c                                          |    5 
 sound/usb/usx2y/usbusx2y.c                                        |    2 
 tools/bpf/bpftool/jit_disasm.c                                    |   51 
 tools/bpf/bpftool/main.h                                          |   25 
 tools/bpf/bpftool/map.c                                           |    1 
 tools/bpf/bpftool/prog.c                                          |   22 
 tools/lib/bpf/libbpf.c                                            |    4 
 tools/lib/bpf/linker.c                                            |    2 
 tools/lib/thermal/Makefile                                        |    4 
 tools/lib/thermal/commands.c                                      |   52 
 tools/perf/builtin-ftrace.c                                       |    2 
 tools/perf/builtin-stat.c                                         |   52 
 tools/perf/builtin-trace.c                                        |   16 
 tools/perf/util/cs-etm.c                                          |   25 
 tools/perf/util/evlist.c                                          |   19 
 tools/perf/util/evlist.h                                          |    1 
 tools/perf/util/probe-finder.c                                    |   21 
 tools/perf/util/probe-finder.h                                    |    4 
 tools/scripts/Makefile.arch                                       |    4 
 tools/testing/selftests/arm64/mte/check_tags_inclusion.c          |    4 
 tools/testing/selftests/arm64/mte/mte_common_util.c               |    4 
 tools/testing/selftests/arm64/pauth/pac.c                         |    3 
 tools/testing/selftests/bpf/network_helpers.h                     |   44 
 tools/testing/selftests/bpf/test_progs.c                          |    9 
 tools/testing/selftests/bpf/test_sockmap.c                        |  165 
 tools/testing/selftests/mount_setattr/mount_setattr_test.c        |    2 
 tools/testing/selftests/net/pmtu.sh                               |    2 
 tools/testing/selftests/resctrl/resctrl_val.c                     |    3 
 tools/testing/selftests/vDSO/parse_vdso.c                         |    3 
 tools/testing/selftests/watchdog/watchdog-test.c                  |    6 
 tools/testing/selftests/wireguard/netns.sh                        |    1 
 tools/tracing/rtla/src/utils.c                                    |    4 
 tools/tracing/rtla/src/utils.h                                    |    2 
 tools/verification/dot2/automata.py                               |   18 
 773 files changed, 11342 insertions(+), 7062 deletions(-)

Abel Vesa (1):
      remoteproc: qcom: q6v5: Use _clk_get_optional for aggre2_clk

Adrian Hunter (1):
      perf/x86/intel/pt: Fix buffer full but size is 0 case

Ahmed Ehab (1):
      locking/lockdep: Avoid creating new name string literals in lockdep_set_subclass()

Ahsan Atta (1):
      crypto: qat - remove faulty arbiter config reset

Ajay Kaher (1):
      ptp: Add error handling for adjfine callback in ptp_clock_adjtime

Aleksandr Mishin (1):
      acpi/arm64: Adjust error handling procedure in gtdt_parse_timer_block()

Alex Deucher (2):
      drm/amdgpu/hdp5.2: do a posting read when flushing HDP
      drm/amdgpu: rework resume handling for display (v2)

Alex Hung (4):
      drm/amd/display: Check null-initialized variables
      drm/amd/display: Initialize denominators' default to 1
      drm/amd/display: Check phantom_stream before it is used
      drm/amd/display: Check BIOS images before it is used

Alex Zenla (2):
      9p/xen: fix init sequence
      9p/xen: fix release of IRQ

Alexander Hölzl (1):
      can: j1939: fix error in J1939 documentation.

Alexander Kozhinov (1):
      can: gs_usb: add usb endpoint address detection at driver probe step

Alexander Shiyan (1):
      media: i2c: tc358743: Fix crash in the probe error path when using polling

Alexander Stein (1):
      spi: spi-fsl-lpspi: downgrade log level for pio mode

Alexander Sverdlin (1):
      watchdog: rti: of: honor timeout-sec property

Alexandru Ardelean (1):
      util_macros.h: fix/rework find_closest() macros

Alexis Lothoré (eBPF Foundation) (1):
      selftests/bpf: add missing header include for htons

Alper Nebi Yasak (1):
      wifi: mwifiex: Fix memcpy() field-spanning write warning in mwifiex_config_scan()

Amadeusz Sławiński (1):
      ASoC: Intel: avs: Fix return status of avs_pcm_hw_constraints_init()

Amir Goldstein (1):
      fsnotify: fix sending inotify event with unexpected filename

Amir Mohammadi (1):
      bpftool: fix potential NULL pointer dereferencing in prog_dump()

Andre Przywara (4):
      kselftest/arm64: mte: fix printf type warnings about __u64
      kselftest/arm64: mte: fix printf type warnings about longs
      ARM: dts: cubieboard4: Fix DCDC5 regulator constraints
      clk: sunxi-ng: d1: Fix PLL_AUDIO0 preset

Andrej Shadura (1):
      Bluetooth: Fix type of len in rfcomm_sock_getsockopt{,_old}()

Andrew Lunn (1):
      dsa: qca8k: Use nested lock to avoid splat

Andrey Konovalov (1):
      kasan: suppress recursive reports for HW_TAGS

Andrii Nakryiko (2):
      libbpf: fix sym_is_subprog() logic for weak global subprogs
      libbpf: never interpret subprogs in .text as entry programs

André Almeida (1):
      unicode: Fix utf8_load() error path

Andy Shevchenko (7):
      regmap: irq: Set lockdep class for hierarchical IRQ domains
      drm/mm: Mark drm_mm_interval_tree*() functions with __maybe_unused
      mfd: intel_soc_pmic_bxtwc: Use IRQ domain for USB Type-C device
      mfd: intel_soc_pmic_bxtwc: Use IRQ domain for TMU device
      mfd: intel_soc_pmic_bxtwc: Use IRQ domain for PMIC devices
      device property: Constify device child node APIs
      iio: light: ltr501: Add LTER0303 to the supported devices

Andy-ld Lu (1):
      mmc: mtk-sd: Fix error handle of probe function

Angelo Dureghello (1):
      dt-bindings: iio: dac: ad3552r: fix maximum spi speed

Anil Gurumurthy (1):
      scsi: qla2xxx: Supported speed displayed incorrectly for VPorts

Antonio Quartulli (1):
      m68k: coldfire/device.c: only build FEC when HW macros are defined

Arnaldo Carvalho de Melo (1):
      perf ftrace latency: Fix unit on histogram first entry when using --use-nsec

Arnd Bergmann (2):
      x86/amd_nb: Fix compile-testing without CONFIG_AMD_NB
      serial: amba-pl011: fix build regression

Artem Sadovnikov (1):
      jfs: xattr: check invalid xattr size more strictly

Avihai Horon (1):
      vfio/pci: Properly hide first-in-list PCIe extended capability

Baochen Qiang (2):
      wifi: ath10k: fix invalid VHT parameters in supported_vht_mcs_rate_nss1
      wifi: ath10k: fix invalid VHT parameters in supported_vht_mcs_rate_nss2

Barnabás Czémán (3):
      power: supply: bq27xxx: Fix registers of bq27426
      pinctrl: qcom-pmic-gpio: add support for PM8937
      pinctrl: qcom: spmi-mpp: Add PM8937 compatible

Bart Van Assche (2):
      power: supply: core: Remove might_sleep() from power_supply_put()
      scsi: ufs: core: Make DMA mask configuration more flexible

Bartosz Golaszewski (4):
      mmc: mmc_spi: drop buggy snprintf()
      pinctrl: zynqmp: drop excess struct member description
      lib: string_helpers: silence snprintf() output truncation warning
      gpio: grgpio: use a helper variable to store the address of ofdev->dev

Baruch Siach (1):
      doc: rcu: update printed dynticks counter bits

Ben Greear (1):
      mac80211: fix user-power when emulating chanctx

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

Bibo Mao (1):
      LoongArch: Add architecture specific huge_pte_clear()

Biju Das (2):
      mtd: hyperbus: rpc-if: Add missing MODULE_DEVICE_TABLE
      clk: renesas: rzg2l: Fix FOUTPOSTDIV clk

Bin Liu (1):
      serial: 8250: omap: Move pm_runtime_get_sync

Bjorn Andersson (1):
      rpmsg: glink: Fix GLINK command prefix

Björn Töpel (1):
      tools: Override makefile ARCH variable if defined, but empty

Boris Burkov (2):
      btrfs: qgroup: fix qgroup prealloc rsv leak in subvolume operations
      btrfs: do not clear read-only when adding sprout device

Borislav Petkov (AMD) (1):
      x86/barrier: Do not serialize MSR accesses on AMD

Brahmajit Das (1):
      drm/display: Fix building with GCC 15

Breno Leitao (5):
      ipmr: Fix access to mfc_cache_list without lock held
      spi: tegra210-quad: Avoid shift-out-of-bounds
      netpoll: Use rcu_access_pointer() in netpoll_poll_lock
      perf/x86/amd: Warn only on new bits set
      netpoll: Use rcu_access_pointer() in __netpoll_setup

Callahan Kovacs (1):
      HID: magicmouse: Apple Magic Trackpad 2 USB-C driver support

Carlos Song (2):
      i3c: master: support to adjust first broadcast address speed
      i3c: master: svc: use slow speed for first broadcast address

Catalin Marinas (4):
      mm/slab: decouple ARCH_KMALLOC_MINALIGN from ARCH_DMA_MINALIGN
      powerpc: move the ARCH_DMA_MINALIGN definition to asm/cache.h
      dma: allow dma_get_cache_alignment() to be overridden by the arch code
      arm64: Ensure bits ASID[15:8] are masked out when the kernel uses 8-bit ASIDs

Chao Yu (2):
      f2fs: fix to account dirty data in __get_secs_required()
      f2fs: fix to avoid forcing direct write to use buffered IO on inline_data inode

Charles Han (3):
      soc: qcom: Add check devm_kasprintf() returned value
      clk: clk-apple-nco: Add NULL check in applnco_probe
      gpio: grgpio: Add NULL check in grgpio_probe

Chen Ridong (4):
      crypto: caam - add error check to caam_rsa_set_priv_key_form
      crypto: bcm - add error check in the ahash_hmac_init function
      Revert "cgroup: Fix memory leak caused by missing cgroup_bpf_offline"
      cgroup/bpf: only cgroup v2 can be attached by bpf programs

Chen-Yu Tsai (6):
      arm64: dts: mediatek: mt8173-elm-hana: Add vdd-supply to second source trackpad
      arm64: dts: mediatek: mt8183-kukui-jacuzzi: Fix DP bridge supply names
      arm64: dts: mediatek: mt8183-kukui-jacuzzi: Add supplies for fixed regulators
      Revert "arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0 on xhci1 as disabled"
      arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0 on xhci1 as disabled
      drm/bridge: it6505: Fix inverted reset polarity

ChenXiaoSong (1):
      btrfs: add might_sleep() annotations

Cheng Ming Lin (1):
      mtd: spi-nor: core: replace dummy buswidth from addr to data

Chengchang Tang (1):
      RDMA/hns: Add clear_hem return value to log

Chih-Kang Chang (1):
      wifi: rtw89: avoid to add interface to list twice when SER

Christian Brauner (1):
      epoll: annotate racy check

Christian König (1):
      dma-buf: fix dma_fence_array_signaled v4

Christoph Hellwig (8):
      nvme-pci: fix freeing of the HMB descriptor table
      block: fix bio_split_rw_at to take zone_write_granularity into account
      nvme-pci: reverse request order in nvme_queue_rqs
      virtio_blk: reverse request order in virtio_queue_rqs
      f2fs: remove struct segment_allocation default_salloc_ops
      f2fs: open code allocate_segment_by_default
      f2fs: remove the unused flush argument to change_curseg
      block: return unsigned int from bdev_io_min

Christophe JAILLET (3):
      crypto: caam - Fix the pointer passed to caam_qi_shutdown()
      crypto: cavium - Fix an error handling path in cpt_ucode_load_fw()
      iio: light: al3010: Fix an error handling path in al3010_probe()

Christophe Leroy (2):
      powerpc/vdso: Flag VDSO64 entry points as functions
      powerpc/vdso: Refactor CFLAGS for CVDSO build

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

Cosmin Tanislav (1):
      regmap: detach regmap from dev on regmap_exit

Csókás, Bence (1):
      spi: atmel-quadspi: Fix register name in verbose logging function

Damien Le Moal (1):
      PCI: rockchip-ep: Fix address translation unit programming

Dan Carpenter (3):
      soc: qcom: geni-se: fix array underflow in geni_se_clk_tbl_get()
      mailbox: arm_mhuv2: clean up loop in get_irq_chan_comb()
      sh: intc: Fix use-after-free bug in register_intc_controller()

Daniel Borkmann (2):
      bpf: Fix helper writes to read-only maps
      net: Move {l,t,d}stats allocation to core and convert veth & vrf

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

Dario Binacchi (9):
      can: c_can: c_can_handle_bus_err(): update statistics if skb allocation fails
      can: sun4i_can: sun4i_can_err(): call can_change_state() even if cf is NULL
      can: hi311x: hi3110_can_ist(): fix potential use-after-free
      can: m_can: m_can_handle_lec_err(): fix {rx,tx}_errors statistics
      can: ifi_canfd: ifi_canfd_handle_lec_err(): fix {rx,tx}_errors statistics
      can: hi311x: hi3110_can_ist(): fix {rx,tx}_errors statistics
      can: sja1000: sja1000_err(): fix {rx,tx}_errors statistics
      can: sun4i_can: sun4i_can_err(): fix {rx,tx}_errors statistics
      can: ems_usb: ems_usb_rx_err(): fix {rx,tx}_errors statistics

Dave Stevenson (5):
      drm/vc4: hvs: Don't write gamma luts on 2711
      drm/vc4: hvs: Fix dlist debug not resetting the next entry pointer
      drm/vc4: hvs: Remove incorrect limit from hvs_dlist debugfs function
      drm/vc4: hvs: Correct logic on stopping an HVS channel
      drm/vc4: hvs: Set AXI panic modes for the HVS

David Disseldorp (1):
      initramfs: avoid filename buffer overrun

David Given (1):
      media: uvcvideo: Add a quirk for the Kaiweets KTI-W02 infrared camera

David Thompson (1):
      EDAC/bluefield: Fix potential integer overflow

David Wang (1):
      proc/softirqs: replace seq_printf with seq_put_decimal_ull_width

Defa Li (1):
      i3c: Use i3cdev->desc->info instead of calling i3c_device_get_info() to avoid deadlock

Dikshita Agarwal (1):
      venus: venc: add handling for VIDIOC_ENCODER_CMD

Dinesh Kumar (1):
      ALSA: hda/realtek: Fix Internal Speaker and Mic boost of Infinix Y4 Max

Dipendra Khadka (6):
      octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_common.c
      octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_ethtool.c
      octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_flows.c
      octeontx2-pf: handle otx2_mbox_get_rsp errors in cn10k.c
      octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_dmac_flt.c
      octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_dcbnl.c

Dmitry Antipov (5):
      Bluetooth: fix use-after-free in device_for_each_child()
      ocfs2: fix uninitialized value in ocfs2_file_read_iter()
      netfilter: x_tables: fix LED ID check in led_tg_check()
      can: j1939: j1939_session_new(): fix skb reference counting
      rocker: fix link status detection in rocker_carrier_init()

Dmitry Baryshkov (1):
      remoteproc: qcom: pas: add minidump_id to SM8350 resources

Dmitry Kandybka (1):
      mptcp: fix possible integer overflow in mptcp_reset_tout_timer

Dmitry Torokhov (1):
      rtc: cmos: avoid taking rtc_lock for extended period of time

Dom Cobley (2):
      drm/vc4: hdmi: Avoid hang with debug registers when suspended
      drm/vc4: hdmi: Avoid log spam for audio start failure

Dong Aisheng (1):
      clk: imx: clk-scu: fix clk enable state save and restore

Doug Brown (1):
      drm/etnaviv: fix power register offset on GC300

Dragan Simic (1):
      arm64: dts: allwinner: pinephone: Add mount matrix to accelerometer

Eduard Zingerman (1):
      selftests/bpf: Fix backtrace printing for selftests crashes

Edward Adam Davis (1):
      USB: chaoskey: Fix possible deadlock chaoskey_list_lock

Elena Salomatkina (1):
      net/sched: cbs: Fix integer overflow in cbs_set_port_rate()

Eric Biggers (1):
      crypto: x86/aegis128 - access 32-bit arguments as 32-bit

Eric Dumazet (7):
      sock_diag: add module pointer to "struct sock_diag_handler"
      sock_diag: allow concurrent operations
      sock_diag: allow concurrent operation in sock_diag_rcv_msg()
      net: use unrcu_pointer() helper
      net: hsr: fix hsr_init_sk() vs network/transport headers.
      net: hsr: avoid potential out-of-bound access in fill_frame_info()
      geneve: do not assume mac header is set in geneve_xmit_skb()

Eryk Zagorski (1):
      ALSA: usb-audio: Fix Yamaha P-125 Quirk Entry

Esben Haabendal (1):
      pinctrl: freescale: fix COMPILE_TEST error with PINCTRL_IMX_SCU

Esther Shimanovich (1):
      PCI: Detect and trust built-in Thunderbolt chips

Everest K.C (1):
      crypto: cavium - Fix the if condition to exit loop after timeout

Filip Brozovic (1):
      serial: 8250_fintek: Add support for F81216E

Filipe Manana (3):
      btrfs: don't loop for nowait writes when checking for cross references
      btrfs: ref-verify: fix use-after-free after invalid ref action
      btrfs: fix missing snapshot drew unlock when root is dead during swap activation

Florian Westphal (1):
      netfilter: nf_tables: must hold rcu read lock while iterating object type list

Francesco Dolcini (2):
      arm64: dts: freescale: imx8mm-verdin: Fix SD regulator startup delay
      arm64: dts: freescale: imx8mp-verdin: Fix SD regulator startup delay

Frank Li (10):
      i3c: master: Fix miss free init_dyn_addr at i3c_master_put_i3c_addrs()
      i3c: master: add enable(disable) hot join in sys entry
      i3c: master: svc: add hot join support
      i3c: master: fix kernel-doc check warning
      i3c: master: svc: Modify enabled_events bit 7:0 to act as IBI enable counter
      i3c: master: Replace hard code 2 with macro I3C_ADDR_SLOT_STATUS_BITS
      i3c: master: Extend address status bit to 4 and add I3C_ADDR_SLOT_EXT_DESIRED
      i3c: master: Fix dynamic address leak when 'assigned-address' is present
      i3c: master: Remove i3c_dev_disable_ibi_locked(olddev) on device hotjoin
      i3c: master: svc: fix possible assignment of the same address to two devices

Fuad Tabba (1):
      KVM: arm64: Change kvm_handle_mmio_return() return polarity

Gabor Juhos (1):
      clk: qcom: gcc-qcs404: fix initial rate of GPLL3

Gabriele Monaco (1):
      verification/dot2: Improve dot parser robustness

Gaosheng Cui (2):
      drivers: soc: xilinx: add the missing kfree in xlnx_add_cb_for_suspend()
      media: platform: allegro-dvt: Fix possible memory leak in allocate_buffers_internal()

Gautam Menghani (3):
      KVM: PPC: Book3S HV: Stop using vc->dpdes for nested KVM guests
      KVM: PPC: Book3S HV: Avoid returning to nested hypervisor on pending doorbells
      powerpc/pseries: Fix KVM guest detection for disabling hardlockup detector

Geert Uytterhoeven (4):
      m68k: mvme16x: Add and use "mvme16x.h"
      memory: renesas-rpc-if: Improve Runtime PM handling
      memory: renesas-rpc-if: Pass device instead of rpcif to rpcif_*()
      memory: renesas-rpc-if: Remove Runtime PM wrappers

Ghanshyam Agrawal (3):
      jfs: array-index-out-of-bounds fix in dtReadFirst
      jfs: fix shift-out-of-bounds in dbSplit
      jfs: fix array-index-out-of-bounds in jfs_readdir

Greg Kroah-Hartman (2):
      Revert "serial: sh-sci: Clean sci_ports[0] after at earlycon exit"
      Linux 6.1.120

Gregory Price (1):
      tpm: fix signed/unsigned bug when checking event logs

Guilherme G. Piccoli (1):
      wifi: rtlwifi: Drastically reduce the attempts to read efuse in case of failures

Gwendal Grignou (1):
      scsi: ufs: core: sysfs: Prevent div by zero

Hangbin Liu (3):
      netdevsim: copy addresses for both in and out paths
      wireguard: selftests: load nf_conntrack if not present
      net/ipv6: delete temporary address if mngtmpaddr is removed or unmanaged

Hans Verkuil (1):
      media: v4l2-core: v4l2-dv-timings: check cvt/gtf result

Hans de Goede (6):
      ASoC: Intel: bytcr_rt5640: Add support for non ACPI instantiated codec
      ASoC: Intel: bytcr_rt5640: Add DMI quirk for Vexia Edu Atla 10 tablet
      ASoC: Intel: sst: Support LPE0F28 ACPI HID
      drm: panel-orientation-quirks: Make Lenovo Yoga Tab 3 X90F DMI match less strict
      ASoC: Intel: sst: Fix used of uninitialized ctx to log an error
      mmc: sdhci-pci: Add DMI quirk for missing CD GPIO on Vexia Edu Atla 10 tablet

Hariprasad Kelam (1):
      octeontx2-af: RPM: Fix mismatch in lmac type

Harith G (1):
      ARM: 9420/1: smp: Fix SMP for xip kernels

Harshit Mogalapalli (1):
      dax: delete a stale directory pmem

Heiner Kallweit (1):
      r8169: don't apply UDP padding quirk on RTL8126A

Heming Zhao (1):
      ocfs2: Revert "ocfs2: fix the la space leak when unmounting an ocfs2 volume"

Herbert Xu (2):
      crypto: api - Add crypto_tfm_get
      crypto: api - Add crypto_clone_tfm

Hilda Wu (1):
      Bluetooth: btusb: Add RTL8852BE device 0489:e123 to device tables

Hou Tao (4):
      bpf: Handle BPF_EXIST and BPF_NOEXIST for LPM trie
      bpf: Remove unnecessary kfree(im_node) in lpm_trie_update_elem
      bpf: Handle in-place update for full LPM trie correctly
      bpf: Fix exact match conditions in trie_get_next_key()

Hsin-Te Yuan (2):
      arm64: dts: mt8183: krane: Fix the address of eeprom at i2c4
      arm64: dts: mt8183: kukui: Fix the address of eeprom at i2c4

Hsin-Yi Wang (1):
      arm64: dts: mt8183: jacuzzi: Move panel under aux-bus

Huacai Chen (2):
      sh: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTACK
      LoongArch: Fix sleeping in atomic context for PREEMPT_RT

Hubert Wiśniewski (1):
      usb: musb: Fix hardware lockup on first Rx endpoint request

Hugo Villeneuve (1):
      serial: sc16is7xx: fix invalid FIFO access with special register set

Ian Rogers (2):
      perf stat: Fix affinity memory leaks on error path
      perf probe: Fix libdw memory leak

Ido Schimmel (1):
      mlxsw: spectrum_acl_tcam: Fix NULL pointer dereference in error path

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

Igor Prusov (1):
      dt-bindings: vendor-prefixes: Add NeoFidelity, Inc

Ilpo Järvinen (1):
      PCI: cpqphp: Fix PCIBIOS_* return value confusion

Ilya Zverev (1):
      ASoC: amd: yc: Add a quirk for microfone on Lenovo ThinkPad P14s Gen 5 21MES00B00

Imre Deak (3):
      drm/dp_mst: Fix MST sideband message body length check
      drm/dp_mst: Verify request type in the corresponding down message reply
      drm/dp_mst: Fix resetting msg rx state after topology removal

Inochi Amaoto (1):
      serial: 8250_dw: Add Sophgo SG2044 quirk

Ivan Solodovnikov (1):
      dccp: Fix memory leak in dccp_feat_change_recv

Jacob Keller (3):
      ptp: convert remaining drivers to adjfine interface
      ixgbevf: stop attempting IPSEC offload on Mailbox API 1.5
      ixgbe: downgrade logging of unsupported VF API version to debug

Jakob Hauser (1):
      iio: magnetometer: yas530: use signed integer type for clamp limits

Jakub Kicinski (1):
      net/neighbor: clear error in case strict check is not set

James Clark (1):
      perf cs-etm: Don't flush when packet_queue fills up

Jammy Huang (1):
      media: aspeed: Fix memory overwrite if timing is 1600x900

Jan Kara (3):
      ext4: make 'abort' mount option handling standard
      ext4: avoid remount errors with 'abort' mount option
      udf: Fold udf_getblk() into udf_bread()

Jan Stancek (1):
      tools/rtla: fix collision with glibc sched_attr/sched_set_attr

Jann Horn (1):
      comedi: Flush partial mappings in error case

Jared Kangas (1):
      kasan: make report_lock a raw spinlock

Jarkko Nikula (1):
      i3c: mipi-i3c-hci: Mask ring interrupts before ring stop request

Jason Gerecke (1):
      HID: wacom: Interpret tilt data from Intuos Pro BT as signed values

Jason-JH.Lin (1):
      mailbox: mtk-cmdq: Move devm_mbox_controller_register() after devm_pm_runtime_enable()

Javier Carrasco (5):
      clocksource/drivers/timer-ti-dm: Fix child node refcount handling
      wifi: brcmfmac: release 'root' node in all execution paths
      platform/chrome: cros_ec_typec: fix missing fwnode reference decrement
      soc: fsl: rcpm: fix missing of_node_put() in copy_ippdexpcr1_setting()
      leds: flash: mt6360: Fix device_for_each_child_node() refcounting in error paths

Jean-Michel Hautbois (1):
      m68k: mcfgpio: Fix incorrect register offset for CONFIG_M5441x

Jens Axboe (1):
      io_uring/tctx: work around xa_store() allocation error issue

Jeongjun Park (4):
      wifi: ath9k: add range check for conn_rsp_epid in htc_connect_service()
      usb: using mutex lock and supporting O_NONBLOCK flag in iowarrior_read()
      ext4: supress data-race warnings in ext4_free_inodes_{count,set}()
      netfilter: ipset: add missing range check in bitmap_ip_uadt

Jianbo Liu (1):
      net/mlx5e: Remove workaround to avoid syndrome for internal port

Jiapeng Chong (1):
      wifi: ipw2x00: libipw_rx_any(): fix bad alignment

Jiasheng Jiang (2):
      counter: stm32-timer-cnt: Add check for clk_enable()
      counter: ti-ecap-capture: Add check for clk_enable()

Jiayuan Chen (2):
      bpf: fix filed access without lock
      bpf: fix recursive lock when verdict program return SK_PASS

Jing Zhang (1):
      KVM: arm64: vgic-its: Add a data length check in vgic_its_save_*

Jinghao Jia (1):
      ipvs: fix UB due to uninitialized stack access in ip_vs_protocol_init()

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

Jiri Olsa (1):
      fs/proc/kcore.c: Clear ret value in read_kcore_iter after successful iov_iter_zero

Jiri Wiesner (1):
      net/ipv6: release expired exception dst cached in socket

Joaquín Ignacio Aramendía (3):
      drm: panel-orientation-quirks: Add quirk for AYA NEO 2 model
      drm: panel-orientation-quirks: Add quirk for AYA NEO Founder edition
      drm: panel-orientation-quirks: Add quirk for AYA NEO GEEK

Joe Hattori (1):
      media: platform: exynos4-is: Fix an OF node reference leak in fimc_md_is_isp_available

Johan Hovold (1):
      pinctrl: qcom: spmi: fix debugfs drive strength

John Garry (1):
      scsi: scsi_debug: Fix hrtimer support for ndelay

John Watts (1):
      ASoC: audio-graph-card2: Purge absent supplies for device tree nodes

Jonas Gorski (1):
      mips: asm: fix warning when disabling MIPS_FP_SUPPORT

Jonas Karlman (1):
      ASoC: hdmi-codec: reorder channel allocation list

Jonathan Cameron (2):
      device property: Add cleanup.h based fwnode_handle_put() scope based cleanup.
      device property: Introduce device_for_each_child_node_scoped()

Jonathan Marek (1):
      rpmsg: glink: use only lower 16-bits of param2 for CMD_OPEN name length

Jordy Zomer (2):
      ksmbd: fix Out-of-Bounds Read in ksmbd_vfs_stream_read
      ksmbd: fix Out-of-Bounds Write in ksmbd_vfs_stream_write

Josef Bacik (1):
      btrfs: don't BUG_ON on ENOMEM from btrfs_lookup_extent_info() in walk_down_proc()

Josh Poimboeuf (1):
      parisc/ftrace: Fix function graph tracing disablement

Junxian Huang (4):
      RDMA/hns: Use dev_* printings in hem code instead of ibdev_*
      RDMA/hns: Remove unnecessary QP type checks
      RDMA/hns: Fix out-of-order issue of requester when setting FENCE
      RDMA/hns: Fix NULL pointer derefernce in hns_roce_map_mr_sg()

Justin Tee (1):
      scsi: lpfc: Validate hdwq pointers before dereferencing in reset/errata paths

K Prateek Nayak (3):
      sched/core: Remove the unnecessary need_resched() check in nohz_csd_func()
      sched/fair: Check idle_cpu() before need_resched() to detect ilb CPU turning busy
      sched/core: Prevent wakeup of ksoftirqd during idle load balance

Kai Mäkisara (2):
      scsi: st: Don't modify unknown block number in MTIOCGET
      scsi: st: Add MTIOCGET and MTLOAD to ioctls allowed after device reset

Kailang Yang (3):
      ALSA: hda/realtek: Update ALC256 depop procedure
      ALSA: hda/realtek: Update ALC225 depop procedure
      ALSA: hda/realtek: Set PCBeep to default value for ALC274

Kaixin Wang (1):
      i3c: master: svc: Fix use after free vulnerability in svc_i3c_master Driver Due to Race Condition

Kan Liang (1):
      perf/x86/intel: Hide Topdown metrics events if the feature is not enumerated

Kartik Rajput (1):
      serial: amba-pl011: Fix RX stall when DMA is used

Kashyap Desai (1):
      RDMA/bnxt_re: Check cqe flags to know imm_data vs inv_irkey

Kees Cook (2):
      lib: stackinit: hide never-taken branch from compiler
      smb: client: memcpy() with surrounding object base address

Keita Aihara (1):
      mmc: core: Add SD card quirk for broken poweroff notification

Keith Busch (1):
      PCI: Add 'reset_subordinate' to reset hierarchy below bridge

Kent Overstreet (1):
      closures: Change BUG_ON() to WARN_ON()

Kinsey Moore (1):
      jffs2: Prevent rtime decompress memory corruption

Kishon Vijay Abraham I (2):
      PCI: keystone: Set mode as Root Complex for "ti,keystone-pcie" compatible
      PCI: keystone: Add link up check to ks_pcie_other_map_bus()

Konstantin Komarov (2):
      fs/ntfs3: Fixed overflow check in mi_enum_attr()
      fs/ntfs3: Sequential field availability check in mi_enum_attr()

Kory Maincent (1):
      ethtool: Fix wrong mod state in case of verbose and no_mask bitset

Kuan-Wei Chiu (1):
      tracing: Fix cmp_entries_dup() to respect sort() comparison rules

Kuniyuki Iwashima (2):
      tcp: Fix use-after-free of nreq in reqsk_timer_handler().
      tipc: Fix use-after-free of kernel socket in cleanup_bearer().

Kunkun Jiang (2):
      KVM: arm64: vgic-its: Clear DTE when MAPD unmaps a device
      KVM: arm64: vgic-its: Clear ITE when DISCARD frees an ITE

Kuro Chung (1):
      drm/bridge: it6505: update usleep_range for RC circuit charge time

Kurt Borja (2):
      platform/x86: dell-smbios-base: Extends support to Alienware products
      platform/x86: dell-wmi-base: Handle META key Lock/Unlock events

Lang Yu (1):
      drm/amdgpu: refine error handling in amdgpu_ttm_tt_pin_userptr

Larysa Zaremba (1):
      xsk: always clear DMA mapping information when unmapping the pool

Leo Yan (1):
      perf probe: Correct demangled symbols in C++ program

Levi Yun (3):
      trace/trace_event_perf: remove duplicate samples on the first tracepoint event
      perf stat: Close cork_fd when create_perf_stat_counter() failed
      dma-debug: fix a possible deadlock on radix_lock

Li Huafei (2):
      crypto: inside-secure - Fix the return value of safexcel_xcbcmac_cra_init()
      media: atomisp: Add check for rgby_data memory allocation failure

Li Lingfeng (1):
      nfs: ignore SB_RDONLY when mounting nfs

Li Zetao (1):
      media: ts2020: fix null-ptr-deref in ts2020_probe()

Li Zhijian (2):
      selftests/watchdog-test: Fix system accidentally reset after watchdog-test
      fs/inode: Prevent dump_mapping() accessing invalid dentry.d_name.name

Liao Chen (2):
      drm/bridge: it6505: Enable module autoloading
      drm/mcde: Enable module autoloading

Liequan Che (1):
      bcache: revert replacing IS_ERR_OR_NULL with IS_ERR again

Lifeng Zheng (1):
      ACPI: CPPC: Fix _CPC register setting issue

Linus Torvalds (1):
      Revert "unicode: Don't special case ignorable code points"

Linus Walleij (3):
      ARM: 9429/1: ioremap: Sync PGDs for VMALLOC shadow
      ARM: 9430/1: entry: Do a dummy read from VMAP shadow
      ARM: 9431/1: mm: Pair atomic_set_release() with _read_acquire()

Liu Jian (1):
      sunrpc: clear XPRT_SOCK_UPD_TIMEOUT when reset transport

Lizhi Xu (1):
      btrfs: add a sanity check for btrfs root in btrfs_search_slot()

Long Li (1):
      xfs: remove unknown compat feature check in superblock write validation

LongPing Wei (1):
      f2fs: fix the wrong f2fs_bug_on condition in f2fs_do_replace_block

Louis Leseur (1):
      net/qed: allow old cards not supporting "num_images" to work

Lucas Stach (2):
      drm/etnaviv: hold GPU lock across perfmon sampling
      drm/etnaviv: flush shader L1 cache after user commandstream

Luis Chamberlain (1):
      sunrpc: simplify two-level sysctl registration for svcrdma_parm_table

Luiz Augusto von Dentz (5):
      Bluetooth: hci_sync: Add helper functions to manipulate cmd_sync queue
      Bluetooth: MGMT: Fix possible crash on mgmt_index_removed
      Bluetooth: MGMT: Fix slab-use-after-free Read in set_powered_sync
      Bluetooth: hci_core: Fix not checking skb length on hci_acldata_packet
      Bluetooth: MGMT: Fix possible deadlocks

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

Maciej Fijalkowski (2):
      bpf: fix OOB devmap writes when deleting elements
      xsk: fix OOB map writes when deleting elements

Macpaul Lin (2):
      arm64: dts: mt8195: Fix dtbs_check error for infracfg_ao node
      ASoC: dt-bindings: mt6359: Update generic node name and dmic-mode

Manikandan Muralidharan (1):
      drm/panel: simple: Add Microchip AC69T88A LVDS Display panel

Manikanta Mylavarapu (1):
      soc: qcom: socinfo: fix revision check in qcom_socinfo_probe()

Manivannan Sadhasivam (1):
      PCI: endpoint: Use a separate lock for protecting epc->pci_epf list

Marc Kleine-Budde (6):
      can: gs_usb: remove leading space from goto labels
      can: gs_usb: gs_usb_probe(): align block comment
      can: gs_usb: uniformly use "parent" as variable name for struct gs_usb
      can: gs_usb: add VID/PID for Xylanta SAINT3 product family
      can: dev: can_set_termination(): allow sleeping GPIOs
      can: mcp251xfd: mcp251xfd_get_tef_len(): work around erratum DS80000789E 6.

Marc Zyngier (1):
      KVM: arm64: vgic-v3: Sanitise guest writes to GICR_INVLPIR

Marcelo Dalmas (1):
      ntp: Remove invalid cast in time offset math

Marco Elver (3):
      kcsan, seqlock: Support seqcount_latch_t
      kcsan, seqlock: Fix incorrect assumption in read_seqbegin()
      kcsan: Turn report_filterlist_lock into a raw_spinlock

Marco Pagani (2):
      fpga: bridge: add owner module and take its refcount
      fpga: manager: add owner module and take its refcount

Marcus Folkesson (1):
      mfd: da9052-spi: Change read-mask to write-mask

Marek Vasut (1):
      soc: imx8m: Probe the SoC driver as platform driver

Marie Ramlow (1):
      ALSA: usb-audio: add mixer mapping for Corsair HS80

Mark Brown (3):
      clocksource/drivers:sp804: Make user selectable
      kselftest/arm64: Don't leak pipe fds in pac.exec_sign_all()
      arm64/sve: Discard stale CPU state when handling SVE traps

Mark Rutland (2):
      arm64: ptrace: fix partial SETREGSET for NT_ARM_TAGGED_ADDR_CTRL
      arm64: smccc: Remove broken support for SMCCCv1.3 SVE discard hint

Markus Petri (1):
      ASoC: amd: yc: Support dmic on another model of Lenovo Thinkpad E14 Gen 6

Martin Ottens (1):
      net/sched: tbf: correct backlog statistic for GSO packets

Masahiro Yamada (3):
      arm64: fix .data.rel.ro size assertion when CONFIG_LTO_CLANG
      s390/syscalls: Avoid creation of arch/arch/ directory
      modpost: remove incorrect code in do_eisa_entry()

Masami Hiramatsu (Google) (1):
      tracing/eprobe: Fix to release eprobe when failed to add dyn_event

Mathias Nyman (1):
      xhci: dbc: Fix STALL transfer event handling

Mathieu Desnoyers (1):
      tracing/ftrace: disable preemption in syscall probe

Matthias Schiffer (1):
      drm: fsl-dcu: enable PIXCLK on LS1021A

Maurice Lambert (1):
      netlink: typographical error in nlmsg_type constants definition

Maxime Chevallier (2):
      net: stmmac: dwmac-socfpga: Set RX watchdog interrupt as broken
      rtc: ab-eoz9: don't fail temperature reads on undervoltage notification

Maíra Canal (2):
      drm/v3d: Address race-condition in MMU flush
      drm/v3d: Enable Performance Counters before clearing them

MengEn Sun (1):
      vmstat: call fold_vm_zone_numa_events() before show per zone NUMA event

Mengyuan Lou (1):
      PCI: Add ACS quirk for Wangxun FF5xxx NICs

Michael Ellerman (3):
      powerpc/pseries: Fix dtl_access_lock to be a rw_semaphore
      selftests/mount_setattr: Fix failures on 64K PAGE_SIZE kernels
      powerpc/prom_init: Fixup missing powermac #size-cells

Michael Grzeschik (1):
      usb: dwc3: ep0: Don't reset resource alloc flag (including ep0)

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

Miguel Ojeda (1):
      time: Fix references to _msecs_to_jiffies() handling of values

Mikhail Rudenko (1):
      regulator: rk808: Add apply_bit for BUCK3 on RK809

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

Miri Korenblit (1):
      wifi: iwlwifi: mvm: avoid NULL pointer dereference

Mirsad Todorovac (1):
      fs/proc/kcore.c: fix coccinelle reported ERROR instances

Mostafa Saleh (1):
      iommu/io-pgtable-arm: Fix stage-2 map/unmap for concatenated tables

Muchun Song (1):
      block: fix ordering between checking BLK_MQ_S_STOPPED request adding

Mukesh Ojha (1):
      leds: class: Protect brightness_show() with led_cdev->led_access mutex

Murad Masimov (1):
      hwmon: (tps23861) Fix reporting of negative temperatures

Namhyung Kim (1):
      perf/arm-cmn: Ensure port and device id bits are set properly

Namjae Jeon (1):
      exfat: fix uninit-value in __exfat_get_dentry_set

Nathan Chancellor (7):
      powerpc: Fix stack protector Kconfig test for clang
      powerpc: Adjust adding stack protector flags to KBUILD_CLAGS for clang
      powerpc/vdso: Remove unused '-s' flag from ASFLAGS
      powerpc/vdso: Improve linker flags
      powerpc/vdso: Remove an unsupported flag from vgettimeofday-32.o with clang
      powerpc/vdso: Include CLANG_FLAGS explicitly in ldflags-y
      powerpc/vdso: Drop -mstack-protector-guard flags in 32-bit files with clang

Nazar Bilinskyi (1):
      ALSA: hda/realtek: Enable mute and micmute LED on HP ProBook 430 G8

Nick Chan (1):
      watchdog: apple: Actually flush writes after requesting watchdog restart

Nicolas Bouchinet (1):
      tty: ldsic: fix tty_ldisc_autoload sysctl's proc_handler

Nihar Chaithanya (1):
      jfs: add a check to prevent array-index-out-of-bounds in dbAdjTree

Nikolay Kuratov (1):
      KVM: x86/mmu: Ensure that kvm_release_pfn_clean() takes exact pfn from kvm_faultin_pfn()

Nobuhiro Iwamatsu (1):
      rtc: abx80x: Fix WDT bit position of the status register

Norbert van Bolhuis (1):
      wifi: brcmfmac: Fix oops due to NULL pointer dereference in brcmf_sdiod_sglist_rw()

Nuno Sa (3):
      dt-bindings: clock: axi-clkgen: include AXI clk
      clk: clk-axi-clkgen: make sure to enable the AXI bus clock
      iio: adc: ad7923: Fix buffer overflow for tx_buf and ring_xfer

Ojaswin Mujoo (1):
      quota: flush quota_release_work upon quota writeback

Oleksandr Ocheretnyi (1):
      iTCO_wdt: mask NMI_NOW bit for update_no_reboot_bit() call

Oleksandr Tymoshenko (1):
      ovl: properly handle large files in ovl_security_fileattr

Oleksij Rempel (3):
      net: usb: lan78xx: Fix double free issue with interrupt buffer allocation
      net: usb: lan78xx: Fix memory leak on device unplug by freeing PHY device
      net: usb: lan78xx: Fix refcounting and autosuspend on invalid WoL configuration

Oliver Neukum (2):
      usb: yurex: make waiting on yurex_write interruptible
      USB: chaoskey: fail open after removal

Oliver Upton (1):
      KVM: arm64: Don't retire aborted MMIO instruction

Orange Kao (1):
      EDAC/igen6: Avoid segmentation fault on module unload

Pablo Neira Ayuso (3):
      netfilter: nf_tables: skip transaction if update object is not implemented
      netfilter: nft_socket: remove WARN_ON_ONCE on maximum cgroup level
      netfilter: nft_set_hash: skip duplicated elements pending gc run

Pali Rohár (1):
      cifs: Fix buffer overflow when parsing NFS reparse points

Paolo Abeni (4):
      ipv6: release nexthop on device removal
      selftests: net: really check for bg process completion
      ip6mr: fix tables suspicious RCU usage
      ipmr: fix tables suspicious RCU usage

Parker Newman (1):
      misc: eeprom: eeprom_93cx6: Add quirk for extra read clock cycle

Patrick Donnelly (1):
      ceph: extract entity name from device id

Paul Aurich (1):
      smb: cached directories can be more than root file handle

Pavan Chebbi (1):
      tg3: Set coherent DMA mask bits to 31 for BCM57766 chipsets

Pavel Begunkov (1):
      io_uring: wake up optimisations

Pei Xiao (3):
      hwmon: (nct6775-core) Fix overflows seen when writing limit attributes
      drm/sti: Add __iomem for mixer_dbg_mxn's parameter
      spi: mpc52xx: Add cancel_work_sync before module remove

Peilin Ye (2):
      bpf: Fix dev's rx stats for bpf_redirect_peer traffic
      veth: Use tstats per-CPU traffic counters

Peng Fan (3):
      clk: imx: lpcg-scu: SW workaround for errata (e10858)
      clk: imx: fracn-gppll: correct PLL initialization flow
      clk: imx: fracn-gppll: fix pll power up

Peter Griffin (1):
      scsi: ufs: exynos: Fix hibern8 notify callbacks

Peter Wang (1):
      scsi: ufs: core: Add missing post notify for power mode change

Peter Zijlstra (1):
      seqlock/latch: Provide raw_read_seqcount_latch_retry()

Phil Sutter (1):
      netfilter: ipset: Hold module reference while requesting a module

Philipp Stanner (1):
      drm/sched: memset() 'job' in drm_sched_job_init()

Pin-yen Lin (1):
      drm/bridge: anx7625: Drop EDID cache on bridge power off

Piyush Raj Chouhan (1):
      ALSA: hda/realtek: Add subwoofer quirk for Infinix ZERO BOOK 13

Pratyush Brahma (1):
      iommu/arm-smmu: Defer probe of clients after smmu device bound

Prike Liang (2):
      drm/amdgpu: Dereference the ATCS ACPI buffer
      drm/amdgpu: set the right AMDGPU sg segment limitation

Priyanka Singh (1):
      EDAC/fsl_ddr: Fix bad bit shift operations

Qi Han (2):
      f2fs: compress: fix inconsistent update of i_blocks in release_compress_blocks and reserve_compress_blocks
      f2fs: fix f2fs_bug_on when uninstalling filesystem call f2fs_evict_inode.

Qingfang Deng (1):
      jffs2: fix use of uninitialized variable

Qiu-ji Chen (3):
      xen: Fix the issue of resource not being properly released in xenbus_dev_probe()
      ASoC: codecs: Fix atomicity violation in snd_soc_component_get_drvdata()
      media: wl128x: Fix atomicity violation in fmc_send_cmd()

Qu Wenruo (1):
      btrfs: avoid unnecessary device path update for the same device

Quentin Monnet (1):
      bpftool: Remove asserts from JIT disassembler

Quinn Tran (3):
      scsi: qla2xxx: Fix abort in bsg timeout
      scsi: qla2xxx: Fix NVMe and NPIV connect issue
      scsi: qla2xxx: Fix use after free on unload

Rafael J. Wysocki (1):
      thermal: core: Initialize thermal zones before registering them

Raghavendra Rao Ananta (1):
      KVM: arm64: Ignore PMCNTENSET_EL0 while checking for overflow status

Randy Dunlap (3):
      fs_parser: update mount_api doc to match function signature
      scatterlist: fix incorrect func name in kernel-doc
      drm/msm: DEVFREQ_GOV_SIMPLE_ONDEMAND is no longer needed

Reinette Chatre (1):
      selftests/resctrl: Protect against array overrun during iMC config parsing

Ricardo Ribalda (1):
      media: uvcvideo: Stop stream during unregister

Richard Weinberger (1):
      jffs2: Fix rtime decompressor

Ritesh Harjani (IBM) (3):
      powerpc/fadump: Refactor and prepare fadump_cma_init for late init
      powerpc/fadump: Move fadump_cma_init to setup_arch() after initmem_init()
      powerpc/mm/fault: Fix kfence page fault reporting

Rob Clark (3):
      drm/msm/gpu: Add devfreq tuning debugfs
      drm/msm/gpu: Bypass PM QoS constraint for idle clamp
      PM / devfreq: Fix build issues with devfreq disabled

Rohan Barar (1):
      media: cx231xx: Add support for Dexatek USB Video Grabber 1d19:6108

Roman Gushchin (1):
      mm: page_alloc: move mlocked flag clearance into free_pages_prepare()

Rosen Penev (3):
      net: mdio-ipq4019: add missing error check
      wifi: ath5k: add PCI ID for SX76X
      wifi: ath5k: add PCI ID for Arcadyan devices

Ryusuke Konishi (1):
      nilfs2: fix potential out-of-bounds memory access in nilfs_find_entry()

Sahas Leelodharry (1):
      ALSA: hda/realtek: Add support for Samsung Galaxy Book3 360 (NP730QFG)

Sai Kumar Cholleti (1):
      gpio: exar: set value when external pull-up or pull-down is present

Saravana Kannan (3):
      driver core: fw_devlink: Improve logs for cycle detection
      driver core: Add FWLINK_FLAG_IGNORE to completely ignore a fwnode link
      driver core: fw_devlink: Stop trying to optimize cycle detection logic

Saravanan Vajravel (1):
      bnxt_en: Reserve rings after PCIe AER recovery if NIC interface is down

Sathvika Vasireddy (1):
      powerpc/vdso: Skip objtool from running on VDSO files

Saurav Kashyap (1):
      scsi: qla2xxx: Remove check req_sg_cnt should be equal to rsp_sg_cnt

Sean Christopherson (1):
      KVM: x86/mmu: Skip the "try unsync" path iff the old SPTE was a leaf SPTE

Sergey Senozhatsky (1):
      media: venus: provide ctx queue lock for ioctl synchronization

Shengjiu Wang (1):
      ASoC: fsl_micfil: fix regmap_write_bits usage

Shengyu Qu (1):
      net: sfp: change quirks for Alcatel Lucent G-010S-P

Shu Han (1):
      mm: call the security_mmap_file() LSM hook in remap_file_pages()

Si-Wei Liu (1):
      vdpa/mlx5: Fix suboptimal range on iotlb iteration

Sibi Sankar (1):
      remoteproc: qcom_q6v5_mss: Re-order writes to the IMEM region

Sidraya Jayagond (1):
      s390/iucv: MSG_PEEK causes memory leak in iucv_sock_destruct()

Simon Horman (2):
      net: fec_mpc52xx_phy: Use %pa to format resource_size_t
      net: ethernet: fs_enet: Use %pa to format resource_size_t

Srinivas Pandruvada (1):
      thermal: int3400: Fix reading of current_uuid for active policy

Srinivasan Shanmugam (4):
      drm/amd/display: Add NULL check for function pointer in dcn32_set_output_transfer_func
      drm/amd/display: Add NULL check for clk_mgr and clk_mgr->funcs in dcn30_init_hw
      drm/amd/display: Add NULL check for clk_mgr in dcn32_init_hw
      drm/amd/display: Add NULL check for function pointer in dcn20_set_output_transfer_func

Stanislav Fomichev (1):
      selftests/bpf: Add csum helpers

Stanislaw Gruszka (1):
      spi: Fix acpi deferred irq probe

Steve French (1):
      smb3: request handle caching when caching directories

Steven Price (1):
      drm/panfrost: Remove unused id_mask from struct panfrost_model

Takashi Iwai (9):
      ALSA: usx2y: Use snd_card_free_when_closed() at disconnection
      ALSA: us122l: Use snd_card_free_when_closed() at disconnection
      ALSA: caiaq: Use snd_card_free_when_closed() at disconnection
      ALSA: 6fire: Release resources at card release
      ALSA: usb-audio: Fix out of bounds reads when finding clock sources
      ALSA: pcm: Add sanity NULL check for the default mmap fault handler
      ALSA: hda/realtek: Apply quirk for Medion E15433
      ALSA: usb-audio: Notify xrun for low-latency mode
      ALSA: usb-audio: Make mic volume workarounds globally applicable

Tetsuo Handa (1):
      ocfs2: free inode when ocfs2_get_init_inode() fails

Thadeu Lima de Souza Cascardo (2):
      hfsplus: don't query the device logical block size multiple times
      media: uvcvideo: Require entities to have a non-zero unique ID

Theodore Ts'o (1):
      ext4: fix FS_IOC_GETFSMAP handling

Thinh Nguyen (5):
      usb: dwc3: gadget: Fix checking for number of TRBs left
      usb: dwc3: gadget: Fix looping of queued SG entries
      usb: dwc3: gadget: Rewrite endpoint allocation flow
      usb: dwc3: ep0: Don't clear ep0 DWC3_EP_TRANSFER_STARTED
      usb: dwc3: ep0: Don't reset resource alloc flag

Thomas Gleixner (2):
      serial: amba-pl011: Use port lock wrappers
      modpost: Add .irqentry.text to OTHER_SECTIONS

Thomas Richter (1):
      s390/cpum_sf: Handle CPU hotplug remove during sampling

Thomas Weißschuh (1):
      fbdev: efifb: Register sysfs groups through driver core

Thomas Zimmermann (1):
      fbdev/sh7760fb: Alloc DMA memory from hardware device

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

Tvrtko Ursulin (2):
      dma-fence: Fix reference leak on fence merge failure path
      dma-fence: Use kernel's sort for merging fences

Ulf Hansson (1):
      mmc: core: Further prevent card detect during shutdown

Umio Yasuno (1):
      drm/amd/pm: update current_socclk and current_uclk in gpu_metrics on smu v13.0.7

Uros Bizjak (1):
      tracing: Use atomic64_inc_return() in trace_clock_counter()

Uwe Kleine-König (3):
      mtd: hyperbus: rpc-if: Convert to platform remove callback returning void
      i3c: Make i3c_master_unregister() return void
      ASoC: amd: yc: Add quirk for microphone on Lenovo Thinkpad T14s Gen 6 21M1CTO1WW

Vadim Fedorenko (1):
      net-timestamp: make sk_tskey more predictable in error path

Vasiliy Kovalev (1):
      ovl: Filter invalid inodes with missing lookup function

Vasily Gorbik (1):
      s390/entry: Mark IRQ entries to fix stack depot warnings

Venkata Prasad Potturu (1):
      ASoC: amd: yc: Fix for enabling DMIC on acp6x via _DSD entry

Victor Lu (1):
      drm/amdgpu: clear RB_OVERFLOW bit when enabling interrupts for vega20_ih

Victor Zhao (1):
      drm/amdgpu: skip amdgpu_device_cache_pci_state under sriov

Vineeth Vijayan (1):
      s390/cio: Do not unregister the subchannel based on DNV

Vishnu Sankar (1):
      platform/x86: thinkpad_acpi: Fix for ThinkPad's with ECFW showing incorrect fan speed

Vitalii Mordan (2):
      marvell: pxa168_eth: fix call balance of pep->clk handling routines
      usb: ehci-spear: fix call balance of sehci clk handling routines

WANG Xuerui (1):
      LoongArch: Tweak CFLAGS for Clang compatibility

Wang Liang (1):
      net: fix crash when config small gso_max_size/gso_ipv4_max_size

WangYuli (1):
      HID: wacom: fix when get product name maybe null pointer

Waqar Hameed (1):
      ubifs: authentication: Fix use-after-free in ubifs_tnc_end_commit

Wei Yang (1):
      maple_tree: refine mas_store_root() on storing NULL

Weili Qian (1):
      crypto: hisilicon/qm - disable same error report before resetting

Wen Gu (1):
      net/smc: fix LGR and link use-after-free issue

Wengang Wang (1):
      ocfs2: update seq_file index in ocfs2_dlm_seq_next

Will Deacon (1):
      arm64: tls: Fix context-switching of tpidrro_el0 when kpti is enabled

Wolfram Sang (1):
      rtc: rzn1: fix BCD to rtc_time conversion errors

Xi Ruoyao (1):
      MIPS: Loongson64: DTS: Really fix PCIe port nodes for ls7a

Xiaolei Wang (1):
      drm/etnaviv: Request pages from DMA32 zone on addressing_limited

Xin Long (1):
      net: sched: fix erspan_opt settings in cls_flower

Xu Kuohai (1):
      bpf, arm64: Remove garbage frame for struct_ops trampoline

Xu Yang (1):
      usb: chipidea: udc: handle USB Error Interrupt if IOC not set

Yang Erkun (4):
      brd: defer automatic disk creation until module initialization succeeds
      SUNRPC: make sure cache entry active before cache_show
      nfsd: make sure exp active before svc_export_show
      nfsd: fix nfs4_openowner leak when concurrent nfsd4_open occur

Yao Zi (1):
      platform/x86: panasonic-laptop: Return errno correctly in show callback

Yassine Oudjana (1):
      watchdog: mediatek: Make sure system reset gets asserted in mtk_wdt_restart()

Ye Bin (2):
      scsi: bfa: Fix use-after-free in bfad_im_module_exit()
      svcrdma: fix miss destroy percpu_counter in svc_rdma_proc_init()

Yi Yang (2):
      crypto: pcrypt - Call crypto layer directly when padata_do_parallel() return -EBUSY
      nvdimm: rectify the illogical code within nd_dax_probe()

Yihang Li (1):
      scsi: hisi_sas: Add cond_resched() for no forced preemption model

Yishai Hadas (1):
      vfio/mlx5: Align the page tracking max message size with the device capability

Yongliang Gao (1):
      rtc: check if __rtc_read_time was successful in rtc_timer_do_work()

Yongpeng Yang (1):
      f2fs: check curseg->inited before write_sum_page in change_curseg

Yuan Can (6):
      firmware: google: Unregister driver_info on failure
      wifi: wfx: Fix error handling in wfx_core_init()
      drm/amdkfd: Fix wrong usage of INIT_WORK()
      cpufreq: loongson2: Unregister platform_driver on failure
      dm thin: Add missing destroy_work_on_stack()
      igb: Fix potential invalid memory access in igb_init_module()

Yuan Chen (1):
      bpf: Fix the xdp_adjust_tail sample prog issue

Yuli Wang (1):
      LoongArch: Define a default value for VM_DATA_DEFAULT_FLAGS

Zack Rusin (2):
      drm/ttm: Make sure the mapped tt pages are decrypted when needed
      drm/ttm: Print the memory decryption status just once

Zeng Heng (1):
      scsi: fusion: Remove unused variable 'rc'

Zhang Changzhong (1):
      mfd: rt5033: Fix missing regmap_del_irq_chip()

Zhang Zekun (3):
      pmdomain: ti-sci: Add missing of_node_put() for args.np
      powerpc/kexec: Fix return of uninitialized variable
      Revert "drm/amdgpu: add missing size check in amdgpu_debugfs_gprwave_read()"

Zhen Lei (3):
      scsi: qedf: Fix a possible memory leak in qedf_alloc_and_init_sb()
      scsi: qedi: Fix a possible memory leak in qedi_alloc_and_init_sb()
      fbdev: sh7760fb: Fix a possible memory leak in sh7760fb_alloc_mem()

Zheng Yejian (1):
      mm/damon/vaddr: fix issue in damon_va_evenly_split_region()

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

Zhu Jun (1):
      samples/bpf: Fix a resource leak

Zichen Xie (1):
      drm/msm/dpu: cast crtc_clk calculation to u64 in _dpu_core_perf_calc_clk()

Zicheng Qu (2):
      ad7780: fix division by zero in ad7780_write_raw()
      iio: Fix fwnode_handle in __fwnode_iio_channel_get_by_name()

Zijian Zhang (10):
      selftests/bpf: Fix msg_verify_data in test_sockmap
      selftests/bpf: Fix txmsg_redir of test_txmsg_pull in test_sockmap
      selftests/bpf: Add txmsg_pass to pull/push/pop in test_sockmap
      selftests/bpf: Fix SENDPAGE data logic in test_sockmap
      selftests/bpf: Fix total_bytes in msg_loop_rx in test_sockmap
      selftests/bpf: Add push/pop checking for msg_verify_data in test_sockmap
      bpf, sockmap: Several fixes to bpf_msg_push_data
      bpf, sockmap: Several fixes to bpf_msg_pop_data
      bpf, sockmap: Fix sk_msg_reset_curr
      tcp_bpf: Fix the sk_mem_uncharge logic in tcp_bpf_sendmsg

Zijun Hu (2):
      driver core: bus: Fix double free in driver API bus_register()
      PCI: endpoint: Clear secondary (not primary) EPC in pci_epc_remove_epf()

Ziwei Xiao (1):
      gve: Fixes for napi_poll when budget is 0

Zizhi Wo (2):
      cachefiles: Fix missing pos updates in cachefiles_ondemand_fd_write_iter()
      netfs/fscache: Add a memory barrier for FSCACHE_VOLUME_CREATING

Zqiang (1):
      rcu-tasks: Fix access non-existent percpu rtpcp variable in rcu_tasks_need_gpcb()

chao liu (1):
      apparmor: fix 'Do simple duplicate message elimination'

guoweikang (1):
      ftrace: Fix regression with module command in stack_trace_filter

lei lu (2):
      ntfs3: Add bounds checking to mi_enum_attr()
      xfs: add bounds checking to xlog_recover_process_data

weiyufeng (1):
      PCI: cpqphp: Use PCI_POSSIBLE_ERROR() to check config reads

wenglianfa (2):
      RDMA/hns: Fix an AEQE overflow error caused by untimely update of eq_db_ci
      RDMA/hns: Fix cpu stuck caused by printings during reset

zhang jiao (2):
      tools/lib/thermal: Remove the thermal.h soft link when doing make clean
      pinctrl: k210: Undef K210_PC_DEFAULT


