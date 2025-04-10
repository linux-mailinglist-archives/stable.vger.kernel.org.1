Return-Path: <stable+bounces-132114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA37A8442D
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A50C4A7462
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 13:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0285628C5C7;
	Thu, 10 Apr 2025 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vyQCu/AU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C25C28C5C3;
	Thu, 10 Apr 2025 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744290333; cv=none; b=nRn2GmJ1XSJOWsnBLxNxIA4WqK95vPPqssfJet/s5zdv6Ykzwn33mGkJ+HfEftQjMtWJbk4zaNppJ0vvtv7NnW7Tzpb0jfZxAKoTiefOw02cnWRF7p13KUWvBTx1MODvIKAf5Oa20cg9RM2nNGw7Nmhpgjbf7YE33YgDn5yioNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744290333; c=relaxed/simple;
	bh=gZyx6bncRAiFp/oGXpS5RonqPKL3joizPIvtHxJjADA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=asAgz3DF3EtwYXAKE0OaZjcuv6pBCLIKxxJEvP9N4iZYyJwzSHSBQjecN6a1eMFu4Y82YyE3LLzl6vtEp4klV/FcRZb92CGtW8VL9puaCpWcEiF4lpy4exj/sy4wXsz242k63PGD9KiOBX5IS/+Kg5g1jbn8Tu5wKlhKwweNPFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vyQCu/AU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF475C4CEE8;
	Thu, 10 Apr 2025 13:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744290331;
	bh=gZyx6bncRAiFp/oGXpS5RonqPKL3joizPIvtHxJjADA=;
	h=From:To:Cc:Subject:Date:From;
	b=vyQCu/AUFpRCckIywnuek4QCyv6XhJFf+Gu+ilXQaBlZFyqnKBXYkPLiumeWtzR5D
	 Dqzl4i+rV6/TDfcRDNtOzTI/YwzjHnPfntgk+m71RRVbX5ljTMIvWkfevIMlscP9ut
	 IJKjk2N4BK61X9MCYGkXVLLmLupCvOiYiFZtXBNk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.14.2
Date: Thu, 10 Apr 2025 15:03:20 +0200
Message-ID: <2025041021-starry-tree-b0a2@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.14.2 kernel.

All users of the 6.14 kernel series must upgrade.

The updated 6.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.14.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/vendor-prefixes.yaml                   |    2 
 Documentation/netlink/specs/netdev.yaml                                  |    4 
 Documentation/netlink/specs/rt_route.yaml                                |  180 -
 Documentation/networking/xsk-tx-metadata.rst                             |   62 
 Makefile                                                                 |    2 
 arch/arm/Kconfig                                                         |    2 
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1-mba6ulx.dts                    |    3 
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1.dtsi                           |    2 
 arch/arm/boot/dts/ti/omap/omap4-panda-a4.dts                             |    5 
 arch/arm/include/asm/vmlinux.lds.h                                       |   12 
 arch/arm64/boot/dts/freescale/imx8mp-skov-reva.dtsi                      |   39 
 arch/arm64/boot/dts/freescale/imx8mp.dtsi                                |    7 
 arch/arm64/boot/dts/mediatek/mt6359.dtsi                                 |    3 
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi                             |    2 
 arch/arm64/boot/dts/mediatek/mt8173.dtsi                                 |    6 
 arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts                    | 1033 ---------
 arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi                    | 1046 ++++++++++
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi                                |    4 
 arch/arm64/boot/dts/renesas/r8a77990.dtsi                                |    4 
 arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts                           |    2 
 arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts                          |    4 
 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi                         |    2 
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts                          |   14 
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi                            |   25 
 arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dts                     |    3 
 arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-compact.dtsi              |    2 
 arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts                       |    2 
 arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi                        |    6 
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi                    |    8 
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi                                |   26 
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts                                  |    2 
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi                                |   15 
 arch/arm64/include/asm/mem_encrypt.h                                     |   11 
 arch/arm64/kernel/compat_alignment.c                                     |    2 
 arch/loongarch/Kconfig                                                   |    4 
 arch/loongarch/include/asm/cache.h                                       |    2 
 arch/loongarch/include/asm/irq.h                                         |    2 
 arch/loongarch/include/asm/stacktrace.h                                  |    3 
 arch/loongarch/include/asm/unwind_hints.h                                |   10 
 arch/loongarch/kernel/env.c                                              |    2 
 arch/loongarch/kernel/kgdb.c                                             |    5 
 arch/loongarch/net/bpf_jit.c                                             |   12 
 arch/loongarch/net/bpf_jit.h                                             |    5 
 arch/m68k/include/asm/processor.h                                        |   14 
 arch/m68k/sun3/mmu_emu.c                                                 |    7 
 arch/parisc/include/uapi/asm/socket.h                                    |   12 
 arch/powerpc/configs/mpc885_ads_defconfig                                |    2 
 arch/powerpc/crypto/Makefile                                             |    1 
 arch/powerpc/kexec/relocate_32.S                                         |    7 
 arch/powerpc/perf/core-book3s.c                                          |    8 
 arch/powerpc/perf/vpa-pmu.c                                              |    1 
 arch/powerpc/platforms/cell/spufs/gang.c                                 |    1 
 arch/powerpc/platforms/cell/spufs/inode.c                                |   63 
 arch/powerpc/platforms/cell/spufs/spufs.h                                |    2 
 arch/riscv/Kconfig                                                       |    2 
 arch/riscv/errata/Makefile                                               |    6 
 arch/riscv/include/asm/cpufeature.h                                      |    4 
 arch/riscv/include/asm/ftrace.h                                          |    4 
 arch/riscv/kernel/elf_kexec.c                                            |    3 
 arch/riscv/kernel/mcount.S                                               |   24 
 arch/riscv/kernel/traps_misaligned.c                                     |   14 
 arch/riscv/kernel/unaligned_access_speed.c                               |   91 
 arch/riscv/kernel/vec-copy-unaligned.S                                   |    2 
 arch/riscv/kvm/main.c                                                    |    4 
 arch/riscv/kvm/vcpu_pmu.c                                                |    1 
 arch/riscv/mm/hugetlbpage.c                                              |   76 
 arch/riscv/purgatory/entry.S                                             |    1 
 arch/s390/include/asm/io.h                                               |    2 
 arch/s390/include/asm/pgtable.h                                          |    3 
 arch/s390/kernel/entry.S                                                 |    2 
 arch/s390/kernel/perf_pai_crypto.c                                       |    3 
 arch/s390/kernel/perf_pai_ext.c                                          |    3 
 arch/s390/mm/pgtable.c                                                   |   10 
 arch/um/include/shared/os.h                                              |    1 
 arch/um/kernel/Makefile                                                  |    2 
 arch/um/kernel/maccess.c                                                 |   19 
 arch/um/os-Linux/process.c                                               |   51 
 arch/x86/Kconfig                                                         |    3 
 arch/x86/Kconfig.cpu                                                     |    2 
 arch/x86/Makefile.um                                                     |    7 
 arch/x86/coco/tdx/tdx.c                                                  |   26 
 arch/x86/entry/calling.h                                                 |    2 
 arch/x86/entry/common.c                                                  |    2 
 arch/x86/entry/vdso/vdso-layout.lds.S                                    |    2 
 arch/x86/entry/vdso/vma.c                                                |    2 
 arch/x86/events/amd/brs.c                                                |    3 
 arch/x86/events/amd/lbr.c                                                |    3 
 arch/x86/events/core.c                                                   |    5 
 arch/x86/events/intel/core.c                                             |   47 
 arch/x86/events/intel/ds.c                                               |   13 
 arch/x86/events/intel/lbr.c                                              |   50 
 arch/x86/events/perf_event.h                                             |   18 
 arch/x86/hyperv/ivm.c                                                    |    2 
 arch/x86/include/asm/irqflags.h                                          |   40 
 arch/x86/include/asm/paravirt.h                                          |   20 
 arch/x86/include/asm/paravirt_types.h                                    |    3 
 arch/x86/include/asm/tdx.h                                               |    4 
 arch/x86/include/asm/tlbflush.h                                          |    2 
 arch/x86/include/asm/vdso/vsyscall.h                                     |    1 
 arch/x86/kernel/cpu/bus_lock.c                                           |   20 
 arch/x86/kernel/cpu/mce/severity.c                                       |   11 
 arch/x86/kernel/cpu/microcode/amd.c                                      |    2 
 arch/x86/kernel/cpu/resctrl/rdtgroup.c                                   |    3 
 arch/x86/kernel/dumpstack.c                                              |    5 
 arch/x86/kernel/fpu/core.c                                               |    6 
 arch/x86/kernel/paravirt.c                                               |   14 
 arch/x86/kernel/process.c                                                |    9 
 arch/x86/kernel/traps.c                                                  |   18 
 arch/x86/kernel/tsc.c                                                    |    4 
 arch/x86/kernel/uprobes.c                                                |   14 
 arch/x86/kvm/svm/sev.c                                                   |   13 
 arch/x86/kvm/x86.c                                                       |   15 
 arch/x86/lib/copy_user_64.S                                              |   18 
 arch/x86/mm/mem_encrypt_identity.c                                       |    4 
 arch/x86/mm/pat/cpa-test.c                                               |    2 
 arch/x86/mm/pat/memtype.c                                                |   52 
 block/badblocks.c                                                        |  284 --
 block/bio.c                                                              |   11 
 block/blk-settings.c                                                     |   51 
 block/blk-throttle.c                                                     |   13 
 crypto/algapi.c                                                          |    3 
 crypto/api.c                                                             |   17 
 crypto/bpf_crypto_skcipher.c                                             |    1 
 drivers/accel/amdxdna/aie2_smu.c                                         |    2 
 drivers/acpi/acpi_video.c                                                |    9 
 drivers/acpi/nfit/core.c                                                 |    2 
 drivers/acpi/platform_profile.c                                          |   26 
 drivers/acpi/processor_idle.c                                            |    4 
 drivers/acpi/resource.c                                                  |    7 
 drivers/acpi/x86/utils.c                                                 |    3 
 drivers/ata/libata-core.c                                                |    2 
 drivers/auxdisplay/Kconfig                                               |    1 
 drivers/auxdisplay/panel.c                                               |    4 
 drivers/base/power/main.c                                                |   21 
 drivers/base/power/runtime.c                                             |    2 
 drivers/block/null_blk/main.c                                            |   17 
 drivers/block/ublk_drv.c                                                 |   39 
 drivers/bluetooth/btnxpuart.c                                            |    6 
 drivers/bluetooth/btusb.c                                                |    2 
 drivers/bus/qcom-ssc-block-bus.c                                         |   34 
 drivers/clk/clk-stm32f4.c                                                |    4 
 drivers/clk/imx/clk-imx8mp-audiomix.c                                    |    6 
 drivers/clk/meson/g12a.c                                                 |   38 
 drivers/clk/meson/gxbb.c                                                 |   14 
 drivers/clk/mmp/clk-pxa1908-apmu.c                                       |    4 
 drivers/clk/qcom/gcc-ipq5424.c                                           |   24 
 drivers/clk/qcom/gcc-msm8953.c                                           |    2 
 drivers/clk/qcom/gcc-sm8650.c                                            |    4 
 drivers/clk/qcom/gcc-x1e80100.c                                          |   30 
 drivers/clk/qcom/mmcc-sdm660.c                                           |    2 
 drivers/clk/renesas/r9a08g045-cpg.c                                      |    5 
 drivers/clk/renesas/rzg2l-cpg.c                                          |   13 
 drivers/clk/renesas/rzg2l-cpg.h                                          |   10 
 drivers/clk/rockchip/clk-rk3328.c                                        |    2 
 drivers/clk/samsung/clk.c                                                |    2 
 drivers/cpufreq/Kconfig.arm                                              |    2 
 drivers/cpufreq/amd-pstate-trace.h                                       |   46 
 drivers/cpufreq/amd-pstate.c                                             |   80 
 drivers/cpufreq/amd-pstate.h                                             |   18 
 drivers/cpufreq/armada-8k-cpufreq.c                                      |    2 
 drivers/cpufreq/cpufreq-dt.c                                             |    2 
 drivers/cpufreq/cpufreq_governor.c                                       |   45 
 drivers/cpufreq/mediatek-cpufreq-hw.c                                    |    2 
 drivers/cpufreq/mediatek-cpufreq.c                                       |    2 
 drivers/cpufreq/mvebu-cpufreq.c                                          |    2 
 drivers/cpufreq/qcom-cpufreq-hw.c                                        |    2 
 drivers/cpufreq/qcom-cpufreq-nvmem.c                                     |    8 
 drivers/cpufreq/scmi-cpufreq.c                                           |    2 
 drivers/cpufreq/scpi-cpufreq.c                                           |    7 
 drivers/cpufreq/sun50i-cpufreq-nvmem.c                                   |    6 
 drivers/cpufreq/virtual-cpufreq.c                                        |    2 
 drivers/cpuidle/cpuidle-arm.c                                            |    8 
 drivers/cpuidle/cpuidle-big_little.c                                     |    2 
 drivers/cpuidle/cpuidle-psci.c                                           |    4 
 drivers/cpuidle/cpuidle-qcom-spm.c                                       |    2 
 drivers/cpuidle/cpuidle-riscv-sbi.c                                      |    4 
 drivers/crypto/hisilicon/sec2/sec.h                                      |    1 
 drivers/crypto/hisilicon/sec2/sec_crypto.c                               |  125 -
 drivers/crypto/intel/iaa/iaa_crypto_main.c                               |    4 
 drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c                   |    1 
 drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c                       |   59 
 drivers/crypto/nx/nx-common-pseries.c                                    |   37 
 drivers/crypto/tegra/tegra-se-aes.c                                      |  401 ++-
 drivers/crypto/tegra/tegra-se-hash.c                                     |  287 +-
 drivers/crypto/tegra/tegra-se-key.c                                      |   29 
 drivers/crypto/tegra/tegra-se-main.c                                     |   16 
 drivers/crypto/tegra/tegra-se.h                                          |   39 
 drivers/dma/amd/ae4dma/ae4dma-pci.c                                      |    4 
 drivers/dma/amd/ae4dma/ae4dma.h                                          |    2 
 drivers/dma/amd/ptdma/ptdma-dmaengine.c                                  |   90 
 drivers/dma/fsl-edma-main.c                                              |   14 
 drivers/edac/i10nm_base.c                                                |    2 
 drivers/edac/ie31200_edac.c                                              |   19 
 drivers/edac/igen6_edac.c                                                |   21 
 drivers/edac/skx_common.c                                                |   33 
 drivers/edac/skx_common.h                                                |   11 
 drivers/firmware/arm_ffa/bus.c                                           |    3 
 drivers/firmware/arm_ffa/driver.c                                        |   60 
 drivers/firmware/arm_scmi/driver.c                                       |   10 
 drivers/firmware/cirrus/cs_dsp.c                                         |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                               |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c                                  |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c                             |  461 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c                                 |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h                                 |    3 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                                   |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c                                   |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                                    |    1 
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c                                  |   12 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c                    |   15 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c                   |   16 
 drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c                    |    4 
 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c           |   12 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                                   |    3 
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c                      |   12 
 drivers/gpu/drm/bridge/ite-it6505.c                                      |    7 
 drivers/gpu/drm/bridge/ti-sn65dsi86.c                                    |    2 
 drivers/gpu/drm/display/drm_dp_mst_topology.c                            |    8 
 drivers/gpu/drm/drm_file.c                                               |   26 
 drivers/gpu/drm/mediatek/mtk_crtc.c                                      |    7 
 drivers/gpu/drm/mediatek/mtk_dp.c                                        |    6 
 drivers/gpu/drm/mediatek/mtk_dsi.c                                       |    6 
 drivers/gpu/drm/mediatek/mtk_hdmi.c                                      |   33 
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c                              |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c                                 |    4 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                              |  132 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h                              |    4 
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c                                  |   24 
 drivers/gpu/drm/msm/dsi/dsi_host.c                                       |    8 
 drivers/gpu/drm/msm/dsi/dsi_manager.c                                    |   32 
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c                                |    2 
 drivers/gpu/drm/msm/msm_atomic.c                                         |   13 
 drivers/gpu/drm/msm/msm_dsc_helper.h                                     |   11 
 drivers/gpu/drm/msm/msm_gem_submit.c                                     |    2 
 drivers/gpu/drm/msm/msm_kms.h                                            |    7 
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c                            |    2 
 drivers/gpu/drm/panthor/panthor_device.c                                 |   22 
 drivers/gpu/drm/panthor/panthor_drv.c                                    |   14 
 drivers/gpu/drm/panthor/panthor_fw.c                                     |    9 
 drivers/gpu/drm/panthor/panthor_fw.h                                     |    6 
 drivers/gpu/drm/panthor/panthor_heap.c                                   |   54 
 drivers/gpu/drm/panthor/panthor_heap.h                                   |    2 
 drivers/gpu/drm/panthor/panthor_mmu.c                                    |   27 
 drivers/gpu/drm/panthor/panthor_mmu.h                                    |    3 
 drivers/gpu/drm/panthor/panthor_sched.c                                  |   84 
 drivers/gpu/drm/panthor/panthor_sched.h                                  |    3 
 drivers/gpu/drm/solomon/ssd130x-spi.c                                    |    7 
 drivers/gpu/drm/solomon/ssd130x.c                                        |    6 
 drivers/gpu/drm/vkms/vkms_drv.c                                          |   15 
 drivers/gpu/drm/xe/Kconfig                                               |    2 
 drivers/gpu/drm/xlnx/zynqmp_dp.c                                         |    2 
 drivers/gpu/drm/xlnx/zynqmp_dp_audio.c                                   |    4 
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c                                      |    2 
 drivers/greybus/gb-beagleplay.c                                          |    4 
 drivers/hid/Makefile                                                     |    1 
 drivers/hwtracing/coresight/coresight-catu.c                             |    2 
 drivers/hwtracing/coresight/coresight-core.c                             |   20 
 drivers/hwtracing/coresight/coresight-etm4x-core.c                       |   48 
 drivers/i3c/master/svc-i3c-master.c                                      |    2 
 drivers/iio/accel/mma8452.c                                              |   10 
 drivers/iio/accel/msa311.c                                               |   26 
 drivers/iio/adc/ad4130.c                                                 |   41 
 drivers/iio/adc/ad7124.c                                                 |   60 
 drivers/iio/adc/ad7173.c                                                 |   30 
 drivers/iio/adc/ad7192.c                                                 |    5 
 drivers/iio/adc/ad7768-1.c                                               |   15 
 drivers/iio/adc/ad_sigma_delta.c                                         |    1 
 drivers/iio/dac/adi-axi-dac.c                                            |    8 
 drivers/iio/industrialio-backend.c                                       |    4 
 drivers/iio/industrialio-gts-helper.c                                    |   11 
 drivers/iio/light/Kconfig                                                |    1 
 drivers/iio/light/veml6030.c                                             |  577 ++---
 drivers/iio/light/veml6075.c                                             |    8 
 drivers/infiniband/core/device.c                                         |   18 
 drivers/infiniband/core/mad.c                                            |   38 
 drivers/infiniband/core/sysfs.c                                          |    1 
 drivers/infiniband/hw/erdma/erdma_cm.c                                   |    1 
 drivers/infiniband/hw/mana/main.c                                        |    2 
 drivers/infiniband/hw/mlx5/cq.c                                          |    2 
 drivers/infiniband/hw/mlx5/mr.c                                          |   41 
 drivers/infiniband/hw/mlx5/odp.c                                         |   10 
 drivers/iommu/amd/amd_iommu.h                                            |    7 
 drivers/iommu/intel/iommu.c                                              |   17 
 drivers/iommu/io-pgtable-dart.c                                          |    2 
 drivers/iommu/iommu.c                                                    |    5 
 drivers/leds/led-core.c                                                  |   22 
 drivers/leds/leds-st1202.c                                               |    4 
 drivers/md/md-bitmap.c                                                   |    6 
 drivers/md/md.c                                                          |   71 
 drivers/md/md.h                                                          |    6 
 drivers/md/raid1-10.c                                                    |    2 
 drivers/md/raid1.c                                                       |   17 
 drivers/md/raid10.c                                                      |   19 
 drivers/media/dvb-frontends/dib8000.c                                    |    5 
 drivers/media/platform/allegro-dvt/allegro-core.c                        |    1 
 drivers/media/platform/ti/omap3isp/isp.c                                 |    7 
 drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c                  |    1 
 drivers/media/rc/streamzap.c                                             |    2 
 drivers/media/test-drivers/vimc/vimc-streamer.c                          |    6 
 drivers/memory/mtk-smi.c                                                 |   33 
 drivers/mfd/sm501.c                                                      |    6 
 drivers/misc/pci_endpoint_test.c                                         |   22 
 drivers/mmc/host/omap.c                                                  |   19 
 drivers/mmc/host/sdhci-omap.c                                            |    4 
 drivers/mmc/host/sdhci-pxav3.c                                           |    1 
 drivers/net/arcnet/com20020-pci.c                                        |   17 
 drivers/net/bonding/bond_main.c                                          |    8 
 drivers/net/bonding/bond_options.c                                       |    3 
 drivers/net/can/rockchip/rockchip_canfd-core.c                           |    5 
 drivers/net/dsa/microchip/ksz8.c                                         |   11 
 drivers/net/dsa/microchip/ksz_dcb.c                                      |  231 --
 drivers/net/dsa/mv88e6xxx/chip.c                                         |   32 
 drivers/net/dsa/mv88e6xxx/phy.c                                          |    3 
 drivers/net/dsa/sja1105/sja1105_ethtool.c                                |    9 
 drivers/net/dsa/sja1105/sja1105_ptp.c                                    |   20 
 drivers/net/dsa/sja1105/sja1105_static_config.c                          |    6 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                                |   19 
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                                |    6 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c                            |    3 
 drivers/net/ethernet/ibm/ibmveth.c                                       |   39 
 drivers/net/ethernet/ibm/ibmvnic.c                                       |   30 
 drivers/net/ethernet/intel/e1000e/defines.h                              |    3 
 drivers/net/ethernet/intel/e1000e/ich8lan.c                              |   80 
 drivers/net/ethernet/intel/e1000e/ich8lan.h                              |    4 
 drivers/net/ethernet/intel/ice/devlink/health.c                          |    6 
 drivers/net/ethernet/intel/ice/ice_common.c                              |    3 
 drivers/net/ethernet/intel/ice/ice_ptp.c                                 |    6 
 drivers/net/ethernet/intel/ice/ice_virtchnl.c                            |   39 
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c                       |   24 
 drivers/net/ethernet/intel/idpf/idpf_lib.c                               |   31 
 drivers/net/ethernet/intel/idpf/idpf_main.c                              |    6 
 drivers/net/ethernet/intel/igb/igb_ptp.c                                 |    6 
 drivers/net/ethernet/intel/igc/igc.h                                     |    1 
 drivers/net/ethernet/intel/igc/igc_main.c                                |  143 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c                            |    4 
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h                               |    3 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c                          |    3 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c                           |  201 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c                          |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c                  |    2 
 drivers/net/ethernet/mediatek/airoha_eth.c                               |   20 
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c                      |    8 
 drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c                  |    2 
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c                        |    4 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                           |   15 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c          |   27 
 drivers/net/ethernet/microchip/lan743x_ptp.c                             |    6 
 drivers/net/ethernet/renesas/ravb_ptp.c                                  |    3 
 drivers/net/ethernet/sfc/ef100_netdev.c                                  |    7 
 drivers/net/ethernet/sfc/ef100_nic.c                                     |   47 
 drivers/net/ethernet/sfc/efx.c                                           |   24 
 drivers/net/ethernet/sfc/mcdi_port.c                                     |   59 
 drivers/net/ethernet/sfc/mcdi_port_common.c                              |   11 
 drivers/net/ethernet/sfc/net_driver.h                                    |    6 
 drivers/net/ethernet/wangxun/libwx/wx_lib.c                              |   65 
 drivers/net/ipvlan/ipvlan_l3s.c                                          |    1 
 drivers/net/phy/bcm-phy-ptp.c                                            |    3 
 drivers/net/phy/broadcom.c                                               |    6 
 drivers/net/usb/rndis_host.c                                             |   16 
 drivers/net/usb/usbnet.c                                                 |    6 
 drivers/net/virtio_net.c                                                 |   30 
 drivers/net/vmxnet3/vmxnet3_drv.c                                        |   10 
 drivers/net/wireless/ath/ath11k/dp_rx.c                                  |   14 
 drivers/net/wireless/ath/ath11k/mac.c                                    |    5 
 drivers/net/wireless/ath/ath11k/pci.c                                    |    2 
 drivers/net/wireless/ath/ath11k/reg.c                                    |   22 
 drivers/net/wireless/ath/ath12k/core.c                                   |    4 
 drivers/net/wireless/ath/ath12k/dp_rx.c                                  |    2 
 drivers/net/wireless/ath/ath12k/dp_tx.c                                  |    2 
 drivers/net/wireless/ath/ath12k/mac.c                                    |    9 
 drivers/net/wireless/ath/ath12k/pci.c                                    |    2 
 drivers/net/wireless/ath/ath12k/wmi.c                                    |    2 
 drivers/net/wireless/ath/ath9k/common-spectral.c                         |    4 
 drivers/net/wireless/marvell/mwifiex/fw.h                                |   14 
 drivers/net/wireless/marvell/mwifiex/main.c                              |    4 
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c                           |   18 
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c                      |   45 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c                         |    1 
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c                          |    1 
 drivers/net/wireless/realtek/rtw89/core.h                                |    2 
 drivers/net/wireless/realtek/rtw89/fw.c                                  |   12 
 drivers/net/wireless/realtek/rtw89/pci.h                                 |   56 
 drivers/net/wireless/realtek/rtw89/pci_be.c                              |    2 
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c                        |   13 
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c                       |   13 
 drivers/ntb/hw/intel/ntb_hw_gen3.c                                       |    3 
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c                                   |    2 
 drivers/ntb/test/ntb_perf.c                                              |    4 
 drivers/nvdimm/badrange.c                                                |    2 
 drivers/nvdimm/nd.h                                                      |    2 
 drivers/nvdimm/pfn_devs.c                                                |    7 
 drivers/nvdimm/pmem.c                                                    |    2 
 drivers/nvme/host/ioctl.c                                                |    2 
 drivers/nvme/host/pci.c                                                  |    3 
 drivers/nvme/target/debugfs.c                                            |    2 
 drivers/nvme/target/pci-epf.c                                            |   11 
 drivers/pci/controller/cadence/pcie-cadence-ep.c                         |    3 
 drivers/pci/controller/cadence/pcie-cadence.h                            |    2 
 drivers/pci/controller/dwc/pcie-designware-ep.c                          |    1 
 drivers/pci/controller/dwc/pcie-histb.c                                  |   12 
 drivers/pci/controller/pcie-brcmstb.c                                    |   16 
 drivers/pci/controller/pcie-mediatek-gen3.c                              |   28 
 drivers/pci/controller/pcie-xilinx-cpm.c                                 |   10 
 drivers/pci/endpoint/functions/pci-epf-test.c                            |  126 -
 drivers/pci/hotplug/pciehp_hpc.c                                         |    4 
 drivers/pci/iov.c                                                        |   48 
 drivers/pci/pci-sysfs.c                                                  |    4 
 drivers/pci/pci.c                                                        |   22 
 drivers/pci/pcie/aspm.c                                                  |   17 
 drivers/pci/pcie/bwctrl.c                                                |    6 
 drivers/pci/pcie/portdrv.c                                               |    8 
 drivers/pci/probe.c                                                      |    5 
 drivers/pci/setup-bus.c                                                  |   39 
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c                        |   50 
 drivers/pinctrl/bcm/pinctrl-bcm2835.c                                    |   14 
 drivers/pinctrl/intel/pinctrl-intel.c                                    |    1 
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c                                |   10 
 drivers/pinctrl/renesas/pinctrl-rza2.c                                   |    2 
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                                  |    3 
 drivers/pinctrl/renesas/pinctrl-rzv2m.c                                  |    2 
 drivers/pinctrl/tegra/pinctrl-tegra.c                                    |    3 
 drivers/platform/x86/dell/dell-uart-backlight.c                          |    2 
 drivers/platform/x86/dell/dell-wmi-ddv.c                                 |    6 
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c              |    2 
 drivers/platform/x86/lenovo-yoga-tab2-pro-1380-fastcharger.c             |    2 
 drivers/platform/x86/thinkpad_acpi.c                                     |   11 
 drivers/power/supply/bq27xxx_battery.c                                   |    1 
 drivers/power/supply/max77693_charger.c                                  |    2 
 drivers/ptp/ptp_ocp.c                                                    |    4 
 drivers/regulator/pca9450-regulator.c                                    |    6 
 drivers/remoteproc/qcom_q6v5_mss.c                                       |   21 
 drivers/remoteproc/qcom_q6v5_pas.c                                       |   13 
 drivers/remoteproc/remoteproc_core.c                                     |    1 
 drivers/rtc/rtc-renesas-rtca3.c                                          |   15 
 drivers/scsi/hisi_sas/hisi_sas.h                                         |    3 
 drivers/scsi/hisi_sas/hisi_sas_main.c                                    |   28 
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c                                   |    4 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                                   |    4 
 drivers/scsi/mpi3mr/mpi3mr_app.c                                         |    1 
 drivers/scsi/mpt3sas/mpt3sas_base.c                                      |   12 
 drivers/scsi/mpt3sas/mpt3sas_scsih.c                                     |    2 
 drivers/soc/mediatek/mt8167-mmsys.h                                      |   13 
 drivers/soc/mediatek/mt8188-mmsys.h                                      |    2 
 drivers/soc/mediatek/mt8365-mmsys.h                                      |   48 
 drivers/soundwire/generic_bandwidth_allocation.c                         |    5 
 drivers/soundwire/slave.c                                                |    1 
 drivers/spi/spi-amd.c                                                    |    2 
 drivers/spi/spi-bcm2835.c                                                |   18 
 drivers/spi/spi-cadence-xspi.c                                           |    2 
 drivers/staging/gpib/agilent_82350b/agilent_82350b.c                     |    2 
 drivers/staging/gpib/agilent_82357a/agilent_82357a.c                     |  424 +---
 drivers/staging/gpib/cb7210/cb7210.c                                     |    2 
 drivers/staging/gpib/hp_82341/hp_82341.c                                 |    2 
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c                                |  518 ++--
 drivers/staging/rtl8723bs/Kconfig                                        |    1 
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c            |   28 
 drivers/target/loopback/tcm_loop.c                                       |    5 
 drivers/thermal/intel/int340x_thermal/int3402_thermal.c                  |    3 
 drivers/tty/n_tty.c                                                      |   13 
 drivers/tty/serial/fsl_lpuart.c                                          |  312 +-
 drivers/usb/host/xhci-mem.c                                              |    6 
 drivers/usb/typec/altmodes/thunderbolt.c                                 |   10 
 drivers/usb/typec/ucsi/ucsi_ccg.c                                        |    5 
 drivers/vhost/scsi.c                                                     |   25 
 drivers/video/console/Kconfig                                            |    6 
 drivers/video/fbdev/au1100fb.c                                           |    4 
 drivers/video/fbdev/sm501fb.c                                            |    7 
 drivers/w1/masters/w1-uart.c                                             |    4 
 fs/9p/vfs_inode_dotl.c                                                   |    2 
 fs/autofs/autofs_i.h                                                     |    2 
 fs/bcachefs/fs-ioctl.c                                                   |    6 
 fs/btrfs/block-group.c                                                   |   40 
 fs/btrfs/disk-io.c                                                       |    3 
 fs/coredump.c                                                            |    4 
 fs/dlm/lockspace.c                                                       |    2 
 fs/erofs/internal.h                                                      |    2 
 fs/erofs/super.c                                                         |    8 
 fs/exec.c                                                                |   15 
 fs/exfat/fatent.c                                                        |    2 
 fs/exfat/file.c                                                          |   29 
 fs/exfat/inode.c                                                         |   41 
 fs/ext4/dir.c                                                            |    3 
 fs/ext4/ext4.h                                                           |   17 
 fs/ext4/ext4_jbd2.h                                                      |   29 
 fs/ext4/inode.c                                                          |   19 
 fs/ext4/mballoc-test.c                                                   |    2 
 fs/ext4/namei.c                                                          |   16 
 fs/ext4/super.c                                                          |   81 
 fs/ext4/xattr.c                                                          |   32 
 fs/ext4/xattr.h                                                          |   10 
 fs/f2fs/checkpoint.c                                                     |   15 
 fs/f2fs/compress.c                                                       |    1 
 fs/f2fs/data.c                                                           |   10 
 fs/f2fs/f2fs.h                                                           |    3 
 fs/f2fs/file.c                                                           |   20 
 fs/f2fs/inode.c                                                          |    7 
 fs/f2fs/namei.c                                                          |    8 
 fs/f2fs/segment.c                                                        |   29 
 fs/f2fs/segment.h                                                        |    9 
 fs/f2fs/super.c                                                          |   67 
 fs/fsopen.c                                                              |    2 
 fs/fuse/dax.c                                                            |    1 
 fs/fuse/dir.c                                                            |    2 
 fs/fuse/file.c                                                           |    4 
 fs/gfs2/super.c                                                          |   21 
 fs/hostfs/hostfs.h                                                       |    2 
 fs/hostfs/hostfs_kern.c                                                  |    7 
 fs/hostfs/hostfs_user.c                                                  |   59 
 fs/isofs/dir.c                                                           |    3 
 fs/jbd2/journal.c                                                        |   27 
 fs/jfs/inode.c                                                           |    2 
 fs/jfs/jfs_dtree.c                                                       |    3 
 fs/jfs/jfs_extent.c                                                      |   10 
 fs/jfs/jfs_imap.c                                                        |   13 
 fs/jfs/xattr.c                                                           |   15 
 fs/nfs/delegation.c                                                      |   63 
 fs/nfs/nfs4xdr.c                                                         |   18 
 fs/nfs/sysfs.c                                                           |   22 
 fs/nfs/write.c                                                           |    4 
 fs/nfsd/Kconfig                                                          |   12 
 fs/nfsd/nfs4callback.c                                                   |   14 
 fs/nfsd/nfs4state.c                                                      |   53 
 fs/nfsd/nfsctl.c                                                         |   53 
 fs/nfsd/stats.c                                                          |    4 
 fs/nfsd/stats.h                                                          |    2 
 fs/nfsd/vfs.c                                                            |   28 
 fs/ntfs3/attrib.c                                                        |    3 
 fs/ntfs3/file.c                                                          |   22 
 fs/ntfs3/frecord.c                                                       |    6 
 fs/ntfs3/index.c                                                         |    4 
 fs/ntfs3/ntfs.h                                                          |    2 
 fs/ntfs3/super.c                                                         |   89 
 fs/ocfs2/alloc.c                                                         |    8 
 fs/proc/base.c                                                           |    2 
 fs/smb/client/connect.c                                                  |   16 
 fs/smb/server/auth.c                                                     |    6 
 fs/smb/server/connection.h                                               |   11 
 fs/smb/server/mgmt/user_session.c                                        |   37 
 fs/smb/server/mgmt/user_session.h                                        |    2 
 fs/smb/server/oplock.c                                                   |   12 
 fs/smb/server/smb2pdu.c                                                  |   54 
 fs/smb/server/smbacl.c                                                   |   21 
 include/asm-generic/rwonce.h                                             |   10 
 include/drm/display/drm_dp_mst_helper.h                                  |    7 
 include/drm/drm_file.h                                                   |    5 
 include/linux/arm_ffa.h                                                  |    3 
 include/linux/avf/virtchnl.h                                             |    4 
 include/linux/badblocks.h                                                |   10 
 include/linux/context_tracking_irq.h                                     |    8 
 include/linux/coresight.h                                                |    4 
 include/linux/cpuset.h                                                   |   11 
 include/linux/dma-direct.h                                               |   13 
 include/linux/fwnode.h                                                   |    2 
 include/linux/if_bridge.h                                                |    6 
 include/linux/iio/iio-gts-helper.h                                       |    1 
 include/linux/iio/iio.h                                                  |   26 
 include/linux/interrupt.h                                                |    8 
 include/linux/mem_encrypt.h                                              |   23 
 include/linux/nfs_fs_sb.h                                                |    4 
 include/linux/nmi.h                                                      |    4 
 include/linux/perf_event.h                                               |   37 
 include/linux/pgtable.h                                                  |   28 
 include/linux/pm_runtime.h                                               |    2 
 include/linux/rcupdate.h                                                 |    2 
 include/linux/reboot.h                                                   |   18 
 include/linux/sched.h                                                    |    7 
 include/linux/sched/deadline.h                                           |    4 
 include/linux/sched/smt.h                                                |    2 
 include/linux/seccomp.h                                                  |    8 
 include/linux/thermal.h                                                  |    2 
 include/linux/uprobes.h                                                  |    2 
 include/linux/writeback.h                                                |   24 
 include/net/ax25.h                                                       |    1 
 include/net/bluetooth/hci.h                                              |   34 
 include/net/bluetooth/hci_core.h                                         |    5 
 include/net/bonding.h                                                    |    1 
 include/net/xdp_sock.h                                                   |   10 
 include/net/xdp_sock_drv.h                                               |    1 
 include/net/xfrm.h                                                       |   11 
 include/rdma/ib_verbs.h                                                  |    1 
 include/trace/define_trace.h                                             |    7 
 include/trace/events/writeback.h                                         |   21 
 include/uapi/linux/if_xdp.h                                              |   10 
 include/uapi/linux/netdev.h                                              |    3 
 init/Kconfig                                                             |    5 
 io_uring/io-wq.c                                                         |   40 
 io_uring/io-wq.h                                                         |    7 
 io_uring/io_uring.c                                                      |    3 
 io_uring/net.c                                                           |   23 
 kernel/bpf/core.c                                                        |   19 
 kernel/bpf/verifier.c                                                    |    7 
 kernel/cgroup/cpuset.c                                                   |   27 
 kernel/cpu.c                                                             |    5 
 kernel/events/core.c                                                     |   39 
 kernel/events/ring_buffer.c                                              |    2 
 kernel/events/uprobes.c                                                  |   15 
 kernel/fork.c                                                            |    4 
 kernel/kexec_elf.c                                                       |    2 
 kernel/reboot.c                                                          |   84 
 kernel/rseq.c                                                            |   80 
 kernel/sched/core.c                                                      |    8 
 kernel/sched/deadline.c                                                  |   37 
 kernel/sched/debug.c                                                     |    8 
 kernel/sched/fair.c                                                      |   50 
 kernel/sched/rt.c                                                        |    2 
 kernel/sched/sched.h                                                     |    2 
 kernel/sched/topology.c                                                  |   15 
 kernel/seccomp.c                                                         |   14 
 kernel/trace/bpf_trace.c                                                 |    2 
 kernel/trace/ring_buffer.c                                               |    4 
 kernel/trace/trace_events.c                                              |    7 
 kernel/trace/trace_events_synth.c                                        |   36 
 kernel/trace/trace_functions_graph.c                                     |    1 
 kernel/trace/trace_irqsoff.c                                             |    2 
 kernel/trace/trace_osnoise.c                                             |    1 
 kernel/trace/trace_sched_wakeup.c                                        |    2 
 kernel/watch_queue.c                                                     |    9 
 kernel/watchdog.c                                                        |   25 
 kernel/watchdog_perf.c                                                   |   28 
 lib/842/842_compress.c                                                   |    2 
 lib/stackinit_kunit.c                                                    |   30 
 lib/vsprintf.c                                                           |    2 
 mm/gup.c                                                                 |    3 
 mm/memory.c                                                              |   13 
 mm/page-writeback.c                                                      |   37 
 mm/zswap.c                                                               |   30 
 net/ax25/af_ax25.c                                                       |   30 
 net/ax25/ax25_route.c                                                    |   74 
 net/bluetooth/hci_core.c                                                 |   62 
 net/bluetooth/hci_event.c                                                |   25 
 net/bluetooth/hci_sync.c                                                 |   30 
 net/bridge/br_ioctl.c                                                    |   36 
 net/bridge/br_private.h                                                  |    3 
 net/core/dev_ioctl.c                                                     |   19 
 net/core/dst.c                                                           |    8 
 net/core/netdev-genl.c                                                   |    2 
 net/core/rtnetlink.c                                                     |    3 
 net/core/rtnl_net_debug.c                                                |    2 
 net/ipv4/ip_tunnel_core.c                                                |    4 
 net/ipv4/udp.c                                                           |   42 
 net/ipv6/addrconf.c                                                      |   37 
 net/ipv6/calipso.c                                                       |   21 
 net/ipv6/route.c                                                         |   42 
 net/mac80211/cfg.c                                                       |   12 
 net/mac80211/mlme.c                                                      |    9 
 net/netfilter/nf_tables_api.c                                            |    4 
 net/netfilter/nf_tables_core.c                                           |   11 
 net/netfilter/nfnetlink_queue.c                                          |    2 
 net/netfilter/nft_set_hash.c                                             |    3 
 net/netfilter/nft_tunnel.c                                               |    6 
 net/openvswitch/actions.c                                                |    6 
 net/sched/act_tunnel_key.c                                               |    2 
 net/sched/cls_flower.c                                                   |    2 
 net/sched/sch_skbprio.c                                                  |    3 
 net/sctp/sysctl.c                                                        |    4 
 net/socket.c                                                             |   19 
 net/vmw_vsock/af_vsock.c                                                 |    6 
 net/wireless/core.c                                                      |    6 
 net/wireless/nl80211.c                                                   |    2 
 net/xdp/xsk.c                                                            |    8 
 net/xfrm/xfrm_device.c                                                   |   13 
 net/xfrm/xfrm_state.c                                                    |   32 
 net/xfrm/xfrm_user.c                                                     |    2 
 rust/Makefile                                                            |    4 
 rust/kernel/print.rs                                                     |    7 
 samples/bpf/Makefile                                                     |    2 
 samples/trace_events/trace-events-sample.h                               |    8 
 scripts/gdb/linux/symbols.py                                             |   13 
 scripts/package/debian/rules                                             |    6 
 scripts/selinux/install_policy.sh                                        |   15 
 security/smack/smack.h                                                   |    6 
 security/smack/smack_lsm.c                                               |   34 
 sound/core/timer.c                                                       |  147 -
 sound/pci/hda/patch_realtek.c                                            |    9 
 sound/soc/amd/acp/acp-legacy-common.c                                    |   10 
 sound/soc/codecs/cs35l41-spi.c                                           |    5 
 sound/soc/codecs/mt6359.c                                                |    9 
 sound/soc/codecs/rt5665.c                                                |   24 
 sound/soc/fsl/imx-card.c                                                 |    4 
 sound/soc/generic/simple-card-utils.c                                    |    7 
 sound/soc/tegra/tegra210_adx.c                                           |    6 
 sound/soc/ti/j721e-evm.c                                                 |    2 
 sound/usb/mixer_quirks.c                                                 |    7 
 tools/arch/x86/lib/insn.c                                                |    2 
 tools/bpf/runqslower/Makefile                                            |    3 
 tools/include/uapi/linux/if_xdp.h                                        |   10 
 tools/include/uapi/linux/netdev.h                                        |    3 
 tools/lib/bpf/btf.c                                                      |    4 
 tools/lib/bpf/linker.c                                                   |    2 
 tools/lib/bpf/str_error.c                                                |    2 
 tools/lib/bpf/str_error.h                                                |    7 
 tools/objtool/arch/loongarch/decode.c                                    |   28 
 tools/objtool/arch/loongarch/include/arch/elf.h                          |    7 
 tools/objtool/arch/powerpc/decode.c                                      |   14 
 tools/objtool/arch/x86/decode.c                                          |   13 
 tools/objtool/check.c                                                    |   84 
 tools/objtool/elf.c                                                      |    6 
 tools/objtool/include/objtool/arch.h                                     |    3 
 tools/objtool/include/objtool/elf.h                                      |   27 
 tools/perf/Makefile.config                                               |   10 
 tools/perf/Makefile.perf                                                 |    2 
 tools/perf/arch/powerpc/util/header.c                                    |    4 
 tools/perf/arch/x86/util/topdown.c                                       |    2 
 tools/perf/bench/syscall.c                                               |   22 
 tools/perf/builtin-report.c                                              |   32 
 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json          |   10 
 tools/perf/pmu-events/empty-pmu-events.c                                 |    8 
 tools/perf/pmu-events/jevents.py                                         |    8 
 tools/perf/tests/hwmon_pmu.c                                             |   16 
 tools/perf/tests/pmu.c                                                   |   85 
 tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S           |    2 
 tools/perf/tests/shell/record_bpf_filter.sh                              |    4 
 tools/perf/tests/shell/stat_all_pmu.sh                                   |   48 
 tools/perf/tests/shell/test_data_symbol.sh                               |   17 
 tools/perf/tests/tool_pmu.c                                              |    4 
 tools/perf/tests/workloads/datasym.c                                     |   34 
 tools/perf/util/arm-spe.c                                                |    8 
 tools/perf/util/bpf-filter.l                                             |    2 
 tools/perf/util/comm.c                                                   |    2 
 tools/perf/util/debug.c                                                  |    2 
 tools/perf/util/dso.h                                                    |    4 
 tools/perf/util/evlist.c                                                 |   13 
 tools/perf/util/evsel.c                                                  |   16 
 tools/perf/util/expr.c                                                   |    2 
 tools/perf/util/hwmon_pmu.c                                              |   14 
 tools/perf/util/hwmon_pmu.h                                              |   16 
 tools/perf/util/intel-tpebs.c                                            |    2 
 tools/perf/util/machine.c                                                |    4 
 tools/perf/util/parse-events.c                                           |    2 
 tools/perf/util/pmu.c                                                    |  263 +-
 tools/perf/util/pmu.h                                                    |   12 
 tools/perf/util/pmus.c                                                   |  171 +
 tools/perf/util/python.c                                                 |   17 
 tools/perf/util/stat-shadow.c                                            |    3 
 tools/perf/util/stat.c                                                   |   13 
 tools/perf/util/tool_pmu.c                                               |   34 
 tools/perf/util/tool_pmu.h                                               |    2 
 tools/perf/util/units.c                                                  |    2 
 tools/power/x86/turbostat/turbostat.8                                    |    2 
 tools/power/x86/turbostat/turbostat.c                                    |   30 
 tools/testing/selftests/bpf/Makefile                                     |    1 
 tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c                |    5 
 tools/testing/selftests/bpf/prog_tests/tailcalls.c                       |    1 
 tools/testing/selftests/bpf/progs/strncmp_bench.c                        |    5 
 tools/testing/selftests/mm/cow.c                                         |    2 
 tools/testing/selftests/pcie_bwctrl/Makefile                             |    2 
 tools/verification/rv/Makefile.rv                                        |    2 
 748 files changed, 9332 insertions(+), 7044 deletions(-)

Aaron Kling (1):
      cpufreq: tegra194: Allow building for Tegra234

Acs, Jakub (1):
      ext4: fix OOB read when checking dotdot dir

Aditya Kumar Singh (1):
      wifi: nl80211: store chandef on the correct link when starting CAC

Adrián Larumbe (5):
      drm/panthor: Fix race condition when gathering fdinfo group samples
      drm/file: Add fdinfo helper for printing regions with prefix
      drm/panthor: Expose size of driver internal BO's over fdinfo
      drm/panthor: Replace sleep locks with spinlocks in fdinfo path
      drm/panthor: Avoid sleep locking in the internal BO size path

Ahmad Fatoum (4):
      arm64: dts: imx8mp-skov: correct PMIC board limits
      arm64: dts: imx8mp-skov: operate CPU at 850 mV by default
      reboot: replace __hw_protection_shutdown bool action parameter with an enum
      reboot: reboot, not shutdown, on hw_protection_reboot timeout

Akhil R (10):
      crypto: tegra - Use separate buffer for setkey
      crypto: tegra - Do not use fixed size buffers
      crypto: tegra - check return value for hash do_one_req
      crypto: tegra - Transfer HASH init function to crypto engine
      crypto: tegra - Fix HASH intermediate result handling
      crypto: tegra - Use HMAC fallback when keyslots are full
      crypto: tegra - Fix CMAC intermediate result handling
      crypto: tegra - Set IV to NULL explicitly for AES ECB
      crypto: tegra - finalize crypto req on error
      crypto: tegra - Reserve keyslots to allocate dynamically

Akihiko Odaki (1):
      virtio_net: Fix endian with virtio_net_ctrl_rss

Al Viro (3):
      spufs: fix a leak on spufs_new_file() failure
      spufs: fix gang directory lifetimes
      spufs: fix a leak in spufs_create_context()

Alex Deucher (7):
      drm/amdgpu/umsch: declare umsch firmware
      drm/amdgpu/umsch: fix ucode check
      drm/amdgpu/vcn5.0.1: use correct dpm helper
      drm/amdgpu/mes: optimize compute loop handling
      drm/amdgpu/mes: enable compute pipes across all MEC
      drm/amdgpu/gfx11: fix num_mec
      drm/amdgpu/gfx12: fix num_mec

Alexandre Ghiti (2):
      riscv: Fix missing __free_pages() in check_vector_unaligned_access()
      riscv: Fix hugetlb retrieval of number of ptes in case of !present pte

Alexandru Gagniuc (1):
      kbuild: deb-pkg: don't set KBUILD_BUILD_VERSION unconditionally

Alice Ryhl (1):
      rust: fix signature of rust_fmt_argument

Alistair Popple (1):
      fuse: fix dax truncate/punch_hole fault path

Andreas Gruenbacher (2):
      gfs2: minor evict fix
      gfs2: skip if we cannot defer delete

Andrew Jones (6):
      riscv: Annotate unaligned access init functions
      riscv: Fix riscv_online_cpu_vec
      riscv: Fix check_unaligned_access_all_cpus
      riscv: Change check_unaligned_access_speed_all_cpus to void
      riscv: Fix set up of cpu hotplug callbacks
      riscv: Fix set up of vector cpu hotplug callback

Andrii Nakryiko (1):
      libbpf: Fix hypothetical STT_SECTION extern NULL deref case

Andy Shevchenko (3):
      auxdisplay: panel: Fix an API misuse in panel.c
      pinctrl: npcm8xx: Fix incorrect struct npcm8xx_pincfg assignment
      pinctrl: intel: Fix wrong bypass assignment in intel_pinctrl_probe_pwm()

Angelo Dureghello (1):
      iio: dac: adi-axi-dac: modify stream enable

AngeloGioacchino Del Regno (5):
      soc: mediatek: mtk-mmsys: Fix MT8188 VDO1 DPI1 output selection
      soc: mediatek: mt8167-mmsys: Fix missing regval in all entries
      soc: mediatek: mt8365-mmsys: Fix routing table masks and values
      drm/mediatek: mtk_hdmi: Unregister audio platform device on failure
      drm/mediatek: mtk_hdmi: Fix typo for aud_sampe_size member

Angelos Oikonomopoulos (1):
      arm64: Don't call NULL in do_compat_alignment_fixup()

Anshuman Khandual (1):
      arch/powerpc: drop GENERIC_PTDUMP from mpc885_ads_defconfig

Antoine Tenart (1):
      net: decrease cached dst counters in dst_release

Antonio Quartulli (1):
      scripts/gdb/linux/symbols.py: address changes to module_sect_attrs

Anuj Gupta (2):
      block: ensure correct integrity capability propagation in stacked devices
      block: Correctly initialize BLK_INTEGRITY_NOGENERATE and BLK_INTEGRITY_NOVERIFY

Armin Wolf (1):
      platform/x86: dell-ddv: Fix temperature calculation

Arnaldo Carvalho de Melo (5):
      perf units: Fix insufficient array space
      perf python: Fixup description of sample.id event member
      perf python: Decrement the refcount of just created event on failure
      perf python: Don't keep a raw_data pointer to consumed ring buffer space
      perf python: Check if there is space to copy all the event

Arnd Bergmann (6):
      x86/platform: Only allow CONFIG_EISA for 32-bit
      firmware: arm_scmi: use ioread64() instead of ioread64_hi_lo()
      dummycon: fix default rows/cols
      mdacon: rework dependency list
      crypto: bpf - Add MODULE_DESCRIPTION for skcipher
      x86/Kconfig: Add cmpxchg8b support back to Geode CPUs

Artur Weber (1):
      power: supply: max77693: Fix wrong conversion of charge input threshold value

Asahi Lina (1):
      iommu/io-pgtable-dart: Only set subpage protection disable for DART 1

Ashley Smith (1):
      drm/panthor: Update CS_STATUS_ defines to correct values

Atish Patra (2):
      RISC-V: KVM: Disable the kernel perf counter during configure
      RISC-V: KVM: Teardown riscv specific bits after kvm_exit

Aurabindo Pillai (1):
      drm/amd/display: fix an indent issue in DML21

Bairavi Alagappan (2):
      crypto: qat - set parity error mask for qat_420xx
      crypto: qat - remove access to parity register for QAT GEN4

Baochen Qiang (1):
      wifi: ath12k: use link specific bss_conf as well in ath12k_mac_vif_cache_flush()

Baokun Li (5):
      ext4: convert EXT4_FLAGS_* defines to enum
      ext4: add EXT4_FLAGS_EMERGENCY_RO bit
      ext4: correct behavior under errors=remount-ro mode
      ext4: show 'emergency_ro' when EXT4_FLAGS_EMERGENCY_RO is set
      ext4: goto right label 'out_mmap_sem' in ext4_setattr()

Bard Liao (1):
      soundwire: take in count the bandwidth of a prepared stream

Barnabás Czémán (1):
      clk: qcom: mmcc-sdm660: fix stuck video_subcore0 clock

Bart Van Assche (5):
      wifi: ath12k: Fix locking in "QMI firmware ready" error paths
      scsi: mpi3mr: Fix locking in an error path
      scsi: mpt3sas: Fix a locking bug in an error path
      drm: zynqmp_dp: Fix a deadlock in zynqmp_dp_ignore_hpd_set()
      fs/procfs: fix the comment above proc_pid_wchan()

Bartosz Golaszewski (1):
      pinctrl: bcm2835: don't -EINVAL on alternate funcs from get_direction()

Basavaraj Natikar (2):
      dmaengine: ae4dma: Use the MSI count and its corresponding IRQ number
      dmaengine: ptdma: Utilize the AE4DMA engine's multi-queue functionality

Benjamin Berg (3):
      x86/fpu: Avoid copying dynamic FP state from init_task in arch_dup_task_struct()
      um: remove copy_from_kernel_nofault_allowed
      um: hostfs: avoid issues on inode number reuse by host

Benjamin Gaignard (1):
      media: verisilicon: HEVC: Initialize start_bit field

Benson Leung (2):
      usb: typec: thunderbolt: Fix loops that iterate TYPEC_PLUG_SOP_P and TYPEC_PLUG_SOP_PP
      usb: typec: thunderbolt: Remove IS_ERR check for plug

Björn Töpel (1):
      riscv/purgatory: 4B align purgatory_start

Boris Brezillon (1):
      drm/panthor: Fix a race between the reset and suspend path

Boris Burkov (1):
      btrfs: fix block group refcount race in btrfs_create_pending_block_groups()

Boris Ostrovsky (1):
      x86/microcode/AMD: Fix __apply_microcode_amd()'s return value

Caleb Sander Mateos (3):
      io_uring/net: only import send_zc buffer once
      io_uring: use lockless_cq flag in io_req_complete_post()
      nvme/ioctl: don't warn on vectorized uring_cmd with fixed buffer

Candice Li (1):
      Remove unnecessary firmware version check for gc v9_4_2

Chao Gao (1):
      x86/fpu/xstate: Fix inconsistencies in guest FPU xfeatures

Chao Yu (7):
      f2fs: quota: fix to avoid warning in dquot_writeback_dquots()
      f2fs: fix to avoid panic once fallocation fails for pinfile
      f2fs: fix to set .discard_granularity correctly
      f2fs: fix potential deadloop in prepare_compress_overwrite()
      f2fs: fix to call f2fs_recover_quota_end() correctly
      f2fs: fix to avoid accessing uninitialized curseg
      f2fs: fix to avoid running out of free segments

Charles Han (3):
      ext4: fix potential null dereference in ext4 kunit test
      drm: xlnx: zynqmp_dpsub: Add NULL check in zynqmp_audio_init
      clk: mmp: Fix NULL vs IS_ERR() check

Chen-Yu Tsai (3):
      arm64: dts: mediatek: mt8173-elm: Drop pmic's #address-cells and #size-cells
      arm64: dts: mediatek: mt8173: Fix some node names
      arm64: dts: rockchip: Remove bluetooth node from rock-3a

Cheng Xu (1):
      RDMA/erdma: Prevent use-after-free in erdma_accept_newconn()

Chenyuan Yang (3):
      thermal: int340x: Add NULL check for adev
      netfilter: nfnetlink_queue: Initialize ctx to avoid memory allocation error
      w1: fix NULL pointer dereference in probe

Chiara Meiohas (1):
      RDMA/mlx5: Fix calculation of total invalidated pages

Christian Brauner (1):
      fs: support O_PATH fds with FSCONFIG_SET_FD

Christian Eggers (1):
      ARM: 9444/1: add KEEP() keyword to ARM_VECTORS

Christian Schoenebeck (1):
      fs/9p: fix NULL pointer dereference on mkdir

Christophe JAILLET (4):
      bus: qcom-ssc-block-bus: Remove some duplicated iounmap() calls
      bus: qcom-ssc-block-bus: Fix the error handling path of qcom_ssc_block_bus_probe()
      PCI: histb: Fix an error handling path in histb_pcie_probe()
      ASoC: codecs: rt5665: Fix some error handling paths in rt5665_probe()

Christophe Leroy (2):
      crypto: powerpc: Mark ghashp8-ppc.o as an OBJECT_FILES_NON_STANDARD
      powerpc/kexec: fix physical address calculation in clear_utlb_entry()

Chuck Lever (5):
      NFSD: Fix callback decoder status codes
      NFSD: Add a Kconfig setting to enable delegated timestamps
      NFSD: nfsd_unlink() clobbers non-zero status returned from fh_fill_pre_attrs()
      NFSD: Never return NFS4ERR_FILE_OPEN when removing a directory
      NFSD: Skip sending CB_RECALL_ANY when the backchannel isn't up

Chukun Pan (1):
      arm64: dts: rockchip: Move rk356x scmi SHMEM to reserved memory

Chunhai Guo (1):
      f2fs: fix missing discard for active segments

Claudiu Beznea (3):
      pinctrl: renesas: rzg2l: Suppress binding attributes
      clk: renesas: r8a08g045: Check the source of the CPU PLL settings
      rtc: renesas-rtca3: Disable interrupts only if the RTC is enabled

Cong Wang (1):
      net_sched: skbprio: Remove overly strict queue assertions

Cyan Yang (1):
      selftests/mm/cow: fix the incorrect error handling

Dan Carpenter (7):
      drm/msm/gem: Fix error code msm_parse_deps()
      PCI: Remove stray put_device() in pci_register_host_bridge()
      drm/mediatek: dsi: fix error codes in mtk_dsi_host_transfer()
      PCI: dwc: ep: Return -ENOMEM for allocation failures
      fs/ntfs3: Fix a couple integer overflows on 32bit systems
      fs/ntfs3: Prevent integer overflow in hdr_first_de()
      nfs: Add missing release on error in nfs_lock_and_join_requests()

Daniel Stodden (1):
      PCI/ASPM: Fix link state exit during switch upstream function removal

Danila Chernetsov (1):
      fbdev: sm501fb: Add some geometry checks.

Dapeng Mi (1):
      perf x86/topdown: Fix topdown leader sampling test error on hybrid

Dario Binacchi (1):
      clk: stm32f4: fix an uninitialized variable

Dave Marquardt (1):
      net: ibmveth: make veth_pool_store stop hanging

Dave Penkler (7):
      staging: gpib: Add missing interface entry point
      staging: gpib: Fix pr_err format warning
      staging: gpib: Fix cb7210 pcmcia Oops
      staging: gpib: ni_usb console messaging cleanup
      staging: gpib: Fix Oops after disconnect in ni_usb
      staging: gpib: agilent usb console messaging cleanup
      staging: gpib: Fix Oops after disconnect in agilent usb

David Gow (1):
      um: Pass the correct Rust target and options with gcc

David Hildenbrand (3):
      x86/mm/pat: Fix VM_PAT handling when fork() fails in copy_page_range()
      kernel/events/uprobes: handle device-exclusive entries correctly in __replace_page()
      mm/gup: reject FOLL_SPLIT_PMD with hugetlb VMAs

David Laight (1):
      objtool: Fix verbose disassembly if CROSS_COMPILE isn't set

David Oberhollenzer (1):
      net: dsa: mv88e6xxx: propperly shutdown PPU re-enable timer on destroy

Debin Zhu (1):
      netlabel: Fix NULL pointer exception caused by CALIPSO on IPv4 sockets

Dhananjay Ugwekar (4):
      cpufreq/amd-pstate: Modify the min_perf calculation in adjust_perf callback
      cpufreq/amd-pstate: Pass min/max_limit_perf as min/max_perf to amd_pstate_update
      cpufreq/amd-pstate: Convert all perf values to u8
      cpufreq/amd-pstate: Add missing NULL ptr check in amd_pstate_update

Dmitry Antipov (3):
      wifi: ath9k: do not submit zero bytes to the entropy pool
      jfs: reject on-disk inodes of an unsupported type
      wifi: rtw89: rtw8852b{t}: fix TSSI debug timestamps

Dmitry Baryshkov (4):
      drm/msm/dpu: don't use active in atomic_check()
      drm/msm/dpu: move needs_cdm setting to dpu_encoder_get_topology()
      drm/msm/dpu: simplify dpu_encoder_get_topology() interface
      drm/msm/dpu: don't set crtc_state->mode_changed from atomic_check()

Dmitry Vyukov (1):
      perf report: Fix input reload/switch with symbol sort key

Douglas Anderson (1):
      drm/mediatek: dp: drm_err => dev_err in HPD path to avoid NULL ptr

Douglas Raillard (2):
      tracing: Ensure module defining synth event cannot be unloaded while tracing
      tracing: Fix synth event printk format for str fields

Eduard Christian Dumitrescu (1):
      platform/x86: thinkpad_acpi: disable ACPI fan access for T495* and E560

Edward Adam Davis (1):
      wifi: cfg80211: init wiphy_work before allocating rfkill fails

Edward Cree (2):
      sfc: rip out MDIO support
      sfc: fix NULL dereferences in ef100_process_design_param()

Emil Tantilov (2):
      idpf: check error for register_netdev() on init
      idpf: fix adapter NULL pointer dereference on reboot

Eric Dumazet (1):
      sctp: add mutual exclusion in proc_sctp_do_udp_port()

Eric Sandeen (1):
      watch_queue: fix pipe accounting mismatch

Fabrizio Castro (3):
      pinctrl: renesas: rza2: Fix missing of_node_put() call
      pinctrl: renesas: rzg2l: Fix missing of_node_put() call
      pinctrl: renesas: rzv2m: Fix missing of_node_put() call

Feng Tang (1):
      PCI/portdrv: Only disable pciehp interrupts early when needed

Feng Yang (1):
      ring-buffer: Fix bytes_dropped calculation issue

Fernando Fernandez Mancera (1):
      ipv6: fix omitted netlink attributes when using RTEXT_FILTER_SKIP_STATS

Filipe Manana (2):
      btrfs: get used bytes while holding lock at btrfs_reclaim_bgs_work()
      btrfs: fix reclaimed bytes accounting after automatic block group reclaim

Florian Fainelli (2):
      spi: bcm2835: Do not call gpiod_put() on invalid descriptor
      spi: bcm2835: Restore native CS probing when pinctrl-bcm2835 is absent

Florian Westphal (1):
      netfilter: nf_tables: don't unregister hook when table is dormant

Francesco Dolcini (1):
      arm64: dts: ti: k3-am62p: Enable AUDIO_REFCLKx

Frieder Schrempf (1):
      regulator: pca9450: Fix enable register for LDO5

Gabriele Monaco (1):
      tracing: Fix DECLARE_TRACE_CONDITION

Gao Xiang (1):
      erofs: allow 16-byte volume name again

Geert Uytterhoeven (5):
      m68k: sun3: Fix DEBUG_MMU_EMU build
      auxdisplay: MAX6959 should select BITREVERSE
      arm64: dts: renesas: r8a774c0: Re-add voltages to OPP table
      arm64: dts: renesas: r8a77990: Re-add voltages to OPP table
      drm/bridge: ti-sn65dsi86: Fix multiple instances

Geetha sowjanya (2):
      octeontx2-af: Fix mbox INTR handler when num VFs > 64
      octeontx2-af: Free NIX_AF_INT_VEC_GEN irq

Gergo Koteles (1):
      ACPI: video: Handle fetching EDID as ACPI_TYPE_PACKAGE

Giovanni Gherdovich (1):
      ACPI: processor: idle: Return an error if both P_LVL{2,3} idle states are invalid

Greg Kroah-Hartman (1):
      Linux 6.14.2

Guilherme G. Piccoli (1):
      x86/tsc: Always save/restore TSC sched_clock() on suspend/resume

Guillaume Nault (1):
      tunnels: Accept PACKET_HOST in skb_tunnel_check_pmtu().

Guixin Liu (1):
      scsi: target: tcm_loop: Fix wrong abort tag

Hans Zhang (1):
      PCI: cadence-ep: Fix the driver to send MSG TLP for INTx without data payload

Hans de Goede (1):
      ACPI: x86: Extend Lenovo Yoga Tab 3 quirk with skip GPIO event-handlers

Heiko Stuebner (1):
      phy: phy-rockchip-samsung-hdptx: Don't use dt aliases to determine phy-id

Hengqi Chen (3):
      LoongArch: BPF: Fix off-by-one error in build_prologue()
      LoongArch: BPF: Don't override subprog's return value
      LoongArch: BPF: Use move_addr() for BPF_PSEUDO_FUNC

Henry Martin (2):
      ASoC: imx-card: Add NULL check in imx_card_probe()
      arcnet: Add NULL check in com20020pci_probe()

Herbert Xu (4):
      crypto: iaa - Test the correct request flag
      crypto: api - Fix larval relookup type and mask
      crypto: api - Call crypto_alg_put in crypto_unregister_alg
      crypto: nx - Fix uninitialised hv_nxc on error

Hermes Wu (1):
      drm/bridge: it6505: fix HDCP V match check is not performed correctly

Herton R. Krzesinski (1):
      x86/uaccess: Improve performance by aligning writes to 8 bytes in copy_user_generic(), on non-FSRM/ERMS CPUs

Hou Tao (1):
      bpf: Use preempt_count() directly in bpf_send_signal_common()

Hrushikesh Salunke (1):
      arm64: dts: ti: k3-j722s-evm: Fix USB2.0_MUX_SEL to select Type-C

Huacai Chen (2):
      LoongArch: Increase ARCH_DMA_MINALIGN up to 16
      LoongArch: Increase MAX_IO_PICS up to 8

Ian Rogers (10):
      libbpf: Add namespace for errstr making it libbpf_errstr
      perf stat: Fix find_stat for mixed legacy/non-legacy events
      perf stat: Don't merge counters purely on name
      perf pmus: Restructure pmu_read_sysfs to scan fewer PMUs
      tools/x86: Fix linux/unaligned.h include path in lib/insn.c
      perf tests: Fix data symbol test with LTO builds
      perf debug: Avoid stack overflow in recursive error message
      perf evlist: Add success path to evlist__create_syswide_maps
      perf evsel: tp_format accessing improvements
      perf pmu: Rename name matching for no suffix or wildcard variants

Ido Schimmel (2):
      ipv6: Start path selection from the first nexthop
      ipv6: Do not consider link down nexthops in path selection

Ilkka Koskinen (2):
      coresight: catu: Fix number of pages while using 64k pages
      perf vendor events arm64 AmpereOneX: Fix frontend_bound calculation

Ilpo Järvinen (8):
      platform/x86: lenovo-yoga-tab2-pro-1380-fastcharger: Make symbol static
      platform/x86: dell-uart-backlight: Make dell_uart_bl_serdev_driver static
      PCI: Remove add_align overwrite unrelated to size0
      PCI: Simplify size1 assignment logic
      PCI: Allow relaxed bridge window tail sizing for optional resources
      PCI: Fix BAR resizing when VF BARs are assigned
      PCI: pciehp: Don't enable HPIE when resuming in poll mode
      PCI/bwctrl: Fix pcie_bwctrl_select_speed() return type

Jacky Bai (2):
      cpuidle: Init cpuidle only for present CPUs
      cpufreq: Init cpufreq only for present CPUs

Jacob Keller (5):
      igb: reject invalid external timestamp requests for 82580-based HW
      renesas: reject PTP_STRICT_FLAGS as unsupported
      net: lan743x: reject unsupported external timestamp requests
      broadcom: fix supported flag check in periodic output function
      ptp: ocp: reject unsupported periodic output flags

Jakub Kicinski (1):
      netlink: specs: rt_route: pull the ifa- prefix out of the names

James Clark (5):
      perf: Always feature test reallocarray
      perf tests: Fix Tool PMU test segfault
      perf pmu: Dynamically allocate tool PMU
      perf pmu: Don't double count common sysfs and json events
      perf: intel-tpebs: Fix incorrect usage of zfree()

James Morse (1):
      x86/resctrl: Fix allocation of cleanest CLOSID on platforms with no monitors

Jan Glaza (3):
      virtchnl: make proto and filter action count unsigned
      ice: stop truncating queue ids when checking
      ice: validate queue quanta parameters to prevent OOB access

Jan Kara (1):
      ext4: verify fast symlink length

Jann Horn (5):
      rwonce: handle KCSAN like KASAN in read_word_at_a_time()
      rwonce: fix crash by removing READ_ONCE() for unaligned read
      x86/entry: Fix ORC unwinder for PUSH_REGS with save_ret=1
      x86/dumpstack: Fix inaccurate unwinding from exception stacks due to misplaced assignment
      x86/mm: Fix flush_tlb_range() when used for zapping normal PMDs

Jason-JH Lin (1):
      drm/mediatek: Fix config_updating flag never false when no mbox channel

Javier Carrasco (3):
      iio: light: veml6030: extend regmap to support regfields
      iio: gts-helper: export iio_gts_get_total_gain()
      iio: light: veml6030: fix scale to conform to ABI

Javier Martinez Canillas (1):
      drm/ssd130x: Set SPI .id_table to prevent an SPI core warning

Jayesh Choudhary (1):
      ASoC: ti: j721e-evm: Fix clock configuration for ti,j7200-cpb-audio compatible

Jeff Chen (2):
      wifi: mwifiex: Fix premature release of RF calibration data.
      wifi: mwifiex: Fix RF calibration data download from file

Jeff Layton (2):
      nfsd: don't ignore the return code of svc_proc_register()
      nfsd: allow SC_STATUS_FREEABLE when searching via nfs4_lookup_stateid()

Jens Axboe (1):
      io_uring/net: improve recv bundles

Jerome Brunet (4):
      clk: amlogic: gxbb: drop incorrect flag on 32k clock
      clk: amlogic: g12b: fix cluster A parent data
      clk: amlogic: gxbb: drop non existing 32k clock parent
      clk: amlogic: g12a: fix mmc A peripheral clock

Jesse Brandeburg (1):
      ice: fix reservation of resources for RDMA when disabled

Jianfeng Liu (1):
      arm64: dts: rockchip: Fix pcie reset gpio on Orange Pi 5 Max

Jiawen Wu (2):
      net: libwx: fix Tx descriptor content for some tunnel packets
      net: libwx: fix Tx L4 checksum

Jiayuan Chen (1):
      bpf: Fix array bounds error with may_goto

Jie Zhan (1):
      cpufreq: governor: Fix negative 'idle_time' handling in dbs_update()

Jim Liu (1):
      net: phy: broadcom: Correct BCM5221 PHY model detection

Jim Quinlan (4):
      PCI: brcmstb: Set generation limit before PCIe link up
      PCI: brcmstb: Use internal register to change link capability
      PCI: brcmstb: Fix error path after a call to regulator_bulk_get()
      PCI: brcmstb: Fix potential premature regulator disabling

Jinghao Jia (1):
      samples/bpf: Fix broken vmlinux path for VMLINUX_BTF

Jiri Kosina (1):
      HID: remove superfluous (and wrong) Makefile entry for CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER

Jiri Olsa (1):
      uprobes/x86: Harden uretprobe syscall trampoline check

Jiri Slaby (SUSE) (1):
      tty: n_tty: use uint for space returned by tty_write_room()

Joe Hattori (2):
      media: platform: allgro-dvt: unregister v4l2_device on the error path
      soundwire: slave: fix an OF node reference leak in soundwire slave device

Johannes Berg (1):
      wifi: mac80211: remove SSID from ML reconf

John Keeping (3):
      drm/ssd130x: fix ssd132x encoding
      drm/ssd130x: ensure ssd132x pitch is correct
      drm/panel: ilitek-ili9882t: fix GPIO name in error message

Jonathan Cameron (3):
      iio: accel: mma8452: Ensure error return on failure to matching oversampling ratio
      iio: accel: msa311: Fix failure to release runtime pm if direct mode claim fails.
      iio: core: Rework claim and release of direct mode to work with sparse.

Jonathan Santos (1):
      iio: adc: ad7768-1: set MOSI idle state to prevent accidental reset

Josh Poimboeuf (11):
      x86/traps: Make exc_double_fault() consistently noreturn
      objtool: Fix detection of consecutive jump tables on Clang 20
      objtool, spi: amd: Fix out-of-bounds stack access in amd_set_spi_freq()
      objtool, nvmet: Fix out-of-bounds stack access in nvmet_ctrl_state_show()
      objtool, media: dib8000: Prevent divide-by-zero in dib8000_set_dds()
      objtool: Fix segfault in ignore_unreachable_insn()
      sched/smt: Always inline sched_smt_active()
      context_tracking: Always inline ct_{nmi,irq}_{enter,exit}()
      rcu-tasks: Always inline rcu_irq_work_resched()
      objtool/loongarch: Add unwind hints in prepare_frametrace()
      spi: cadence: Fix out-of-bounds array access in cdns_mrvl_xspi_setup_clock()

José Expósito (1):
      drm/vkms: Fix use after free and double free on init error

Juhan Jin (1):
      riscv: ftrace: Add parentheses in macro definitions of make_call_t0 and make_call_ra

Juri Lelli (5):
      sched/deadline: Ignore special tasks when rebuilding domains
      sched/topology: Wrappers for sched_domains_mutex
      sched/deadline: Generalize unique visiting of root domains
      sched/deadline: Rebuild root domain accounting after every update
      include/{topology,cpuset}: Move dl_rebuild_rd_accounting to cpuset.h

Kai-Heng Feng (1):
      PCI: Use downstream bridges for distributing resources

Kan Liang (5):
      perf: Save PMU specific data in task_struct
      perf: Supply task information to sched_task()
      perf/x86/lbr: Fix shorter LBRs call stacks for the system-wide mode
      perf tools: Add skip check in tool_pmu__event_to_str()
      perf/x86/intel: Avoid disable PMU if !cpuc->enabled in sample read

Kang Yang (1):
      wifi: ath11k: add srng->lock for ath11k_hal_srng_* in monitor mode

Karan Sanghavi (1):
      iio: light: Add check for array bounds in veml6075_read_int_time_ms

Karel Balej (1):
      mmc: sdhci-pxav3: set NEED_RSP_BUSY capability

Karol Kolacinski (1):
      ice: ensure periodic output start time is in the future

Kees Bakker (1):
      RDMA/mana_ib: Ensure variable err is initialized

Kees Cook (1):
      kunit/stackinit: Use fill byte different from Clang i386 pattern

Kemeng Shi (1):
      ext4: add missing brelse() for bh2 in ext4_dx_add_entry()

Kent Overstreet (1):
      bcachefs: bch2_ioctl_subvolume_destroy() fixes

Kevin Loughlin (1):
      x86/sev: Add missing RIP_REL_REF() invocations during sme_enable()

Kirill A. Shutemov (1):
      x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT

Konrad Dybcio (1):
      clk: qcom: gcc-x1e80100: Unregister GCC_GPU_CFG_AHB_CLK/GCC_DISP_XO_CLK

Konstantin Andreev (2):
      smack: dont compile ipv6 code unless ipv6 is configured
      smack: ipv4/ipv6: tcp/dccp/sctp: fix incorrect child socket label

Konstantin Komarov (1):
      fs/ntfs3: Update inode->i_mapping->a_ops on compression state

Krzysztof Kozlowski (1):
      drm/msm/dsi/phy: Program clock inverters in correct register

Kuninori Morimoto (1):
      ASoC: simple-card-utils: Don't use __free(device_node) at graph_util_parse_dai()

Kuniyuki Iwashima (4):
      net: Remove RTNL dance for SIOCBRADDIF and SIOCBRDELIF.
      rtnetlink: Use register_pernet_subsys() in rtnl_net_debug_init().
      udp: Fix multiple wraparounds of sk->sk_rmem_alloc.
      udp: Fix memory accounting leak.

Lama Kayal (1):
      net/mlx5e: SHAMPO, Make reserved size independent of page size

Laurentiu Mihalcea (3):
      arm64: dts: imx8mp: add AUDIO_AXI_CLK_ROOT to AUDIOMIX block
      arm64: dts: imx8mp: change AUDIO_AXI_CLK_ROOT freq. to 800MHz
      clk: clk-imx8mp-audiomix: fix dsp/ocram_a clock parents

Len Brown (1):
      tools/power turbostat: report CoreThr per measurement interval

Leo Stone (1):
      f2fs: add check for deleted inode

Leo Yan (1):
      perf arm-spe: Fix load-store operation checking

Leon Romanovsky (1):
      xfrm: delay initialization of offload path till its actually requested

Li Huafei (1):
      watchdog/hardlockup/perf: Fix perf_event memory leak

Li Lingfeng (1):
      nfsd: put dl_stid if fail to queue dl_recall

Li Nan (8):
      md: ensure resync is prioritized over recovery
      badblocks: Fix error shitf ops
      badblocks: factor out a helper try_adjacent_combine
      badblocks: attempt to merge adjacent badblocks during ack_all_badblocks
      badblocks: return error directly when setting badblocks exceeds 512
      badblocks: return error if any badblock set fails
      badblocks: fix the using of MAX_BADBLOCKS
      badblocks: fix merge issue when new badblocks align with pre+1

Liang Jie (1):
      wifi: rtw89: Correct immediate cfg_len calculation for scan_offload_be

Likhitha Korrapati (1):
      perf tools: Fix is_compat_mode build break in ppc64

Lin Ma (2):
      netfilter: nft_tunnel: fix geneve_opt type confusion addition
      net: fix geneve_opt length integer overflow

Lizhi Hou (1):
      accel/amdxdna: Return error when setting clock failed for npu1

Lorenzo Bianconi (4):
      net: airoha: Fix lan4 support in airoha_qdma_get_gdm_port()
      PCI: mediatek-gen3: Configure PBUS_CSR registers for EN7581 SoC
      net: airoha: Fix qid report in airoha_tc_get_htb_get_leaf_queue()
      net: airoha: Fix ETS priomap validation

Louis-Alexis Eyraud (3):
      arm64: dts: mediatek: mt8390-genio-700-evk: Move common parts to dtsi
      arm64: dts: mediatek: mt8390-genio-common: Fix duplicated regulator name
      ASoC: mediatek: mt6359: Fix DT parse error due to wrong child node name

Lubomir Rintel (1):
      rndis_host: Flag RNDIS modems as WWAN devices

Luca Ceresoli (1):
      perf build: Fix in-tree build due to symbolic link

Luca Weiss (4):
      remoteproc: qcom_q6v5_pas: Make single-PD handling more robust
      remoteproc: qcom: pas: add minidump_id to SC7280 WPSS
      remoteproc: qcom_q6v5_pas: Use resource with CX PD for MSM8226
      remoteproc: qcom_q6v5_mss: Handle platforms with one power domain

Luiz Augusto von Dentz (2):
      Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
      Bluetooth: hci_event: Fix handling of HCI_EV_LE_DIRECT_ADV_REPORT

Lukas Wunner (1):
      PCI/bwctrl: Fix NULL pointer dereference on bus number exhaustion

Lukasz Czapnik (1):
      ice: fix input validation for virtchnl BW

Macpaul Lin (1):
      arm64: dts: mediatek: mt6359: fix dtbs_check error for audio-codec

Maher Sanalla (1):
      IB/mad: Check available slots before posting receive WRs

Maksim Davydov (1):
      x86/split_lock: Fix the delayed detection logic

Manikanta Mylavarapu (2):
      drivers: clk: qcom: ipq5424: fix the freq table of sdcc1_apps clock
      clk: qcom: ipq5424: fix software and hardware flow control error of UART

Manivannan Sadhasivam (2):
      wifi: ath11k: Clear affinity hint before calling ath11k_pcic_free_irq() in error path
      wifi: ath12k: Clear affinity hint before calling ath12k_pci_free_irq() in error path

Marcus Meissner (1):
      perf tools: annotate asm_pure_loop.S

Marek Behún (5):
      net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
      net: dsa: mv88e6xxx: enable PVT for 6321 switch
      net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
      net: dsa: mv88e6xxx: fix VTU methods for 6320 family
      net: dsa: mv88e6xxx: enable STU methods for 6320 family

Marijn Suijten (4):
      drm/msm/dsi: Use existing per-interface slice count in DSC timing
      drm/msm/dsi: Set PHY usescase (and mode) before registering DSI host
      drm/msm/dpu: Fall back to a single DSC encoder (1:1:1) on small SoCs
      drm/msm/dpu: Remove arbitrary limit of 1 interface in DSC topology

Mario Limonciello (1):
      ucsi_ccg: Don't show failed to get FW build information error

Mark Bloch (1):
      net/mlx5: LAG, reload representors on LAG creation failure

Mark Harmstone (1):
      btrfs: don't clobber ret in btrfs_validate_super()

Mark Zhang (1):
      rtnetlink: Allocate vfinfo size for VF GUIDs when supported

Markus Elfring (2):
      fbdev: au1100fb: Move a variable assignment behind a null pointer check
      ntb_perf: Delete duplicate dmaengine_unmap_put() call in perf_copy_chunk()

Mateusz Polchlopek (1):
      ice: fix using untrusted value of pkt_len in ice_vc_fdir_parse_raw()

Maud Spierings (1):
      dt-bindings: vendor-prefixes: add GOcontroll

Maurizio Lombardi (1):
      nvme-pci: skip nvme_write_sq_db on empty rqlist

Max Kellermann (3):
      io_uring/io-wq: eliminate redundant io_work_get_acct() calls
      io_uring/io-wq: cache work->flags in variable
      io_uring/io-wq: do not use bogus hash value

Max Merchel (1):
      ARM: dts: imx6ul-tqma6ul1: Change include order to disable fec2 node

Maxim Mikityanskiy (1):
      net/mlx5e: Fix ethtool -N flow-type ip4 to RSS context

Miaoqian Lin (3):
      ksmbd: use aead_request_free to match aead_request_alloc
      LoongArch: Fix device node refcount leak in fdt_cpu_clk_init()
      mmc: omap: Fix memory leak in mmc_omap_new_slot

Michael Chan (2):
      bnxt_en: Mask the bd_cnt field in the TX BD properly
      bnxt_en: Linearize TX SKB if the fragments exceed the max

Michael Guralnik (2):
      RDMA/mlx5: Fix page_size variable overflow
      RDMA/mlx5: Fix MR cache initialization error flow

Michael Jeanson (1):
      rseq: Update kernel fields in lockstep with CONFIG_DEBUG_RSEQ=y

Michael Walle (2):
      arm64: dts: ti: k3-am62p: fix pinctrl settings
      arm64: dts: ti: k3-j722s: fix pinctrl settings

Mike Christie (1):
      vhost-scsi: Fix handling of multiple calls to vhost_scsi_set_endpoint

Mike Rapoport (Microsoft) (1):
      x86/mm/pat: cpa-test: fix length for CPA_ARRAY test

Mikhail Lobanov (1):
      wifi: mac80211: check basic rates validity in sta_link_apply_parameters

Ming Lei (2):
      block: fix adding folio to bio
      ublk: make sure ubq->canceling is set when queue is frozen

Ming Yen Hsieh (2):
      wifi: mt76: mt7925: remove unused acpi function for clc
      wifi: mt76: mt7921: fix kernel panic due to null pointer dereference

Moshe Shemesh (1):
      net/mlx5: Start health poll after enable hca

Murad Masimov (3):
      ax25: Remove broken autobind
      acpi: nfit: fix narrowing conversion in acpi_nfit_ctl
      media: streamzap: fix race between device disconnection and urb callback

Namhyung Kim (4):
      perf report: Switch data file correctly in TUI
      perf machine: Fixup kernel maps ends after adding extra maps
      perf test: Add timeout to datasym workload
      perf bpf-filter: Fix a parsing error with comma

Namjae Jeon (6):
      ksmbd: fix multichannel connection failure
      ksmbd: fix r_count dec/increment mismatch
      ksmbd: add bounds check for durable handle context
      ksmbd: fix use-after-free in ksmbd_sessions_deregister()
      ksmbd: fix session use-after-free in multichannel connection
      ksmbd: fix null pointer dereference in alloc_preauth_hash()

Nathan Chancellor (3):
      crypto: tegra - Fix format specifier in tegra_sha_prep_cmd()
      ACPI: platform-profile: Fix CFI violation when accessing sysfs files
      ARM: 9443/1: Require linker to support KEEP within OVERLAY for DCE

Neeraj Sanjay Kale (1):
      Bluetooth: btnxpuart: Fix kernel panic during FW release

Neil Armstrong (1):
      clk: qcom: gcc-sm8650: Do not turn off USB GDSCs during gdsc_disable()

NeilBrown (1):
      NFS: fix open_owner_id_maxsz and related fields.

Nick Child (1):
      ibmvnic: Use kernel helpers for hex dumps

Nicolas Bouchinet (1):
      coredump: Fixes core_pipe_limit sysctl proc_handler

Nicolas Escande (2):
      wifi: ath12k: fix skb_ext_desc leak in ath12k_dp_tx() error path
      wifi: ath12k: Add missing htt_metadata flag in ath12k_dp_tx()

Nicolas Frattaroli (1):
      arm64: dts: rockchip: remove ethm0_clk0_25m_out from Sige5 gmac0

Nikita Shubin (1):
      ntb: intel: Fix using link status DB's

Nikita Zhandarovich (3):
      wifi: mt76: mt7915: fix possible integer overflows in mt7915_muru_stats_show()
      mfd: sm501: Switch to BIT() to mitigate integer overflows
      media: vimc: skip .s_stream() for stopped entities

Niklas Cassel (5):
      ata: libata: Fix NCQ Non-Data log not supported print
      nvmet: pci-epf: Always configure BAR0 as 64-bit
      misc: pci_endpoint_test: Fix pci_endpoint_test_bars_read_bar() error handling
      misc: pci_endpoint_test: Handle BAR sizes larger than INT_MAX
      PCI: endpoint: pci-epf-test: Handle endianness properly

Niklas Neronin (1):
      usb: xhci: correct debug message page size calculation

Niklas Schnelle (1):
      s390: Remove ioremap_wt() and pgprot_writethrough()

Nishanth Aravamudan (1):
      PCI: Avoid reset when disabled via sysfs

Norbert Szetei (3):
      ksmbd: add bounds check for create lease context
      ksmbd: fix overflow in dacloffset bounds check
      ksmbd: validate zero num_subauth before sub_auth is accessed

Nuno Sá (1):
      iio: backend: make sure to NULL terminate stack buffer

Ojaswin Mujoo (2):
      ext4: define ext4_journal_destroy wrapper
      ext4: avoid journaling sb update on error if journal is destroying

Oleg Nesterov (2):
      seccomp: fix the __secure_computing() stub for !HAVE_ARCH_SECCOMP_FILTER
      exec: fix the racy usage of fs_struct->in_exec

Oleksij Rempel (1):
      net: dsa: microchip: fix DCB apptrust configuration on KSZ88x3

Olga Kornievskaia (1):
      nfsd: fix management of listener transports

Olivia Mackintosh (1):
      ALSA: usb-audio: separate DJM-A9 cap lvl options

P Praneesh (1):
      wifi: ath11k: fix RCU stall while reaping monitor destination ring

Pablo Neira Ayuso (1):
      netfilter: nft_set_hash: GC reaps elements with conncount for dynamic sets only

Palmer Dabbelt (1):
      RISC-V: errata: Use medany for relocatable builds

Paolo Bonzini (1):
      KVM: x86: block KVM_CAP_SYNC_REGS if guest state is protected

Patrisious Haddad (1):
      RDMA/mlx5: Fix mlx5_poll_one() cur_qp update flow

Paul Menzel (2):
      scsi: mpt3sas: Reduce log level of ignore_delay_remove message to KERN_INFO
      ACPI: resource: Skip IRQ override on ASUS Vivobook 14 X1404VAP

Pavel Begunkov (2):
      io_uring: check for iowq alloc_workqueue failure
      io_uring: fix retry handling off iowq

Pedro Nishiyama (3):
      Bluetooth: Add quirk for broken READ_VOICE_SETTING
      Bluetooth: Add quirk for broken READ_PAGE_SCAN_TYPE
      Bluetooth: btusb: Fix regression in the initialization of fake Bluetooth controllers

Peng Fan (3):
      remoteproc: core: Clear table_sz when rproc_shutdown
      dmaengine: fsl-edma: cleanup chan after dma_async_device_unregister
      dmaengine: fsl-edma: free irq correctly in remove path

Peter Geis (1):
      clk: rockchip: rk3328: fix wrong clk_ref_usb3otg parent

Peter Zijlstra (1):
      lockdep/mm: Fix might_fault() lockdep check of current->mm->mmap_lock

Peter Zijlstra (Intel) (1):
      perf/x86/intel: Apply static call for drain_pebs

Ping-Ke Shih (2):
      wifi: rtw89: fw: correct debug message format in rtw89_build_txpwr_trk_tbl_from_elm()
      wifi: rtw89: pci: correct ISR RDU bit for 8922AE

Piotr Kwapulinski (1):
      ixgbe: fix media type detection for E610 device

Pranjal Shrivastava (1):
      net: Fix the devmem sock opts and msgs for parisc

Prathamesh Shete (1):
      pinctrl: tegra: Set SFIO mode to Mux Register

Przemek Kitszel (1):
      ice: health.c: fix compilation on gcc 7.5

Pu Lehui (2):
      riscv: fgraph: Select HAVE_FUNCTION_GRAPH_TRACER depends on HAVE_DYNAMIC_FTRACE_WITH_ARGS
      riscv: fgraph: Fix stack layout to match __arch_ftrace_regs argument of ftrace_return_to_handler

Qasim Ijaz (2):
      isofs: fix KMSAN uninit-value bug in do_isofs_readdir()
      jfs: fix slab-out-of-bounds read in ea_get()

Qiuxu Zhuo (5):
      EDAC/igen6: Fix the flood of invalid error reports
      EDAC/{skx_common,i10nm}: Fix some missing error reports on Emerald Rapids
      EDAC/ie31200: Fix the size of EDAC_MC_LAYER_CHIP_SELECT layer
      EDAC/ie31200: Fix the DIMM size mask for several SoCs
      EDAC/ie31200: Fix the error path order of ie31200_init()

Rafael J. Wysocki (2):
      PM: sleep: Adjust check before setting power.must_resume
      PM: sleep: Fix handling devices with direct_complete set on errors

Rameshkumar Sundaram (1):
      wifi: ath12k: Fix pdev lookup in WBM error processing

Ran Xiaokai (1):
      tracing/osnoise: Fix possible recursive locking for cpus_read_lock()

Remi Pommarel (1):
      leds: Fix LED_OFF brightness race

Richard Fitzgerald (1):
      firmware: cs_dsp: Ensure cs_dsp_load[_coeff]() returns 0 on success

Ritu Chaudhary (1):
      ASoC: tegra: Use non-atomic timeout for ADX status register

Rob Clark (1):
      drm/msm/a6xx: Fix a6xx indexed-regs in devcoreduump

Robin Murphy (2):
      iommu: Handle race with default domain setup
      media: omap3isp: Handle ARM dma_iommu_mapping

Robin van der Gracht (1):
      can: rockchip_canfd: rkcanfd_chip_fifo_setup(): remove duplicated setup of RX FIFO

Roman Gushchin (1):
      RDMA/core: Don't expose hw_counters outside of init net namespace

Roman Smirnov (1):
      jfs: add index corruption check to DT_GETPAGE()

Saket Kumar Bhaskar (1):
      selftests/bpf: Select NUMA_NO_NODE to create map

Saleemkhan Jamadar (1):
      drm/amdgpu/umsch: remove vpe test from umsch

Sankararaman Jayaraman (1):
      vmxnet3: unregister xdp rxq info in the reset path

Sathishkumar Muruganandam (1):
      wifi: ath12k: encode max Tx power in scan channel list command

Sean Christopherson (1):
      KVM: SVM: Don't change target vCPU state on AP Creation VMGEXIT error

Sebastian Andrzej Siewior (1):
      lockdep: Don't disable interrupts on RT in disable_irq_nosync_lockdep.*()

Shay Drory (1):
      PCI: Fix NULL dereference in SR-IOV VF creation error path

Sherry Sun (4):
      tty: serial: fsl_lpuart: Use u32 and u8 for register variables
      tty: serial: fsl_lpuart: use port struct directly to simply code
      tty: serial: fsl_lpuart: Fix unused variable 'sport' build warning
      tty: serial: lpuart: only disable CTS instead of overwriting the whole UARTMODIR register

Shuai Xue (1):
      x86/mce: use is_copy_from_user() to determine copy-from-user context

Sicelo A. Mhlongo (1):
      power: supply: bq27xxx_battery: do not update cached flags prematurely

Song Yoong Siang (3):
      xsk: Add launch time hardware offload support to XDP Tx metadata
      igc: Refactor empty frame insertion for launch time support
      igc: Add launch time support to XDP ZC

Sourabh Jain (1):
      kexec: initialize ELF lowest address to ULONG_MAX

Srinivas Pandruvada (1):
      platform/x86: ISST: Correct command storage data length

Srinivasan Shanmugam (2):
      drm/amdgpu: Replace Mutex with Spinlock for RLCG register access to avoid Priority Inversion in SRIOV
      drm/amdkfd: Fix Circular Locking Dependency in 'svm_range_cpu_invalidate_pagetables'

Stanislav Spassov (1):
      x86/fpu: Fix guest FPU state buffer allocation size

Stanley Chu (1):
      i3c: master: svc: Fix missing the IBI rules

Stefan Eichenberger (1):
      arm64: dts: ti: k3-am62-verdin-dahlia: add Microphone Jack to sound card

Stefan Wahren (3):
      staging: vchiq_arm: Register debugfs after cdev
      staging: vchiq_arm: Fix possible NPR of keep-alive thread
      staging: vchiq_arm: Stop kthreads if vchiq cdev register fails

Stefano Garzarella (1):
      vsock: avoid timeout during connect() if the socket is closing

Stephen Brennan (1):
      perf dso: fix dso__is_kallsyms() check

Steven Price (1):
      drm/panthor: Clean up FW version information display

Steven Rostedt (2):
      tracing: Verify event formats that have "%*p.."
      tracing: Do not use PERF enums when perf is not defined

Su Yue (1):
      md/md-bitmap: fix wrong bitmap_limit for clustermd when write sb

Sudeep Holla (4):
      firmware: arm_ffa: Unregister the FF-A devices when cleaning up the partitions
      firmware: arm_ffa: Explicitly cast return value from FFA_VERSION before comparison
      firmware: arm_ffa: Explicitly cast return value from NOTIFICATION_INFO_GET
      firmware: arm_ffa: Skip the first/partition ID when parsing vCPU list

Sungjong Seo (2):
      exfat: fix random stack corruption after get_block
      exfat: fix potential wrong error return from get_block

Suzuki K Poulose (3):
      dma: Fix encryption bit clearing for dma_to_phys
      dma: Introduce generic dma_addr_*crypted helpers
      arm64: realm: Use aliased addresses for device DMA to shared buffers

Sven Schnelle (1):
      s390/entry: Fix setting _CIF_MCCK_GUEST with lowcore relocation

Taehee Yoo (1):
      eth: bnxt: fix out-of-range access of vnic_info array

Takashi Iwai (5):
      ALSA: hda/realtek: Always honor no_shutup_pins
      ALSA: timer: Don't take register_mutex with copy_from/to_user()
      ALSA: hda/realtek: Fix built-in mic assignment on ASUS VivoBook X515UA
      ALSA: hda/realtek: Fix built-in mic breakage on ASUS VivoBook X515JA
      ALSA: hda/realtek: Fix built-in mic on another ASUS VivoBook model

Tang Yizhou (2):
      writeback: let trace_balance_dirty_pages() take struct dtc as parameter
      writeback: fix calculations in trace_balance_dirty_pages() for cgwb

Tanya Agarwal (1):
      lib: 842: Improve error handling in sw842_compress()

Tao Chen (1):
      perf/ring_buffer: Allow the EPOLLRDNORM flag for poll

Tengda Wu (2):
      selftests/bpf: Fix freplace_link segfault in tailcalls prog test
      tracing: Fix use-after-free in print_graph_function_flags during tracer switching

Thadeu Lima de Souza Cascardo (2):
      dlm: prevent NPD when writing a positive value to event_done
      drm/amd/display: avoid NPD when ASIC does not support DMUB

Theodore Ts'o (1):
      ext4: don't over-report free space or inodes in statvfs

Thippeswamy Havalige (1):
      PCI: xilinx-cpm: Fix IRQ domain leak in error path of probe

Thomas Richter (3):
      perf test: Fix Hwmon PMU test endianess issue
      perf bench: Fix perf bench syscall loop count
      perf pmu: Handle memory failure in tool_pmu__new()

Thomas Weißschuh (2):
      x86/vdso: Fix latent bug in vclock_pages calculation
      leds: st1202: Check for error code from devm_mutex_init() call

Thorsten Blum (1):
      m68k: sun3: Use str_read_write() helper in mmu_emu_handle_fault()

Tianchen Ding (1):
      sched/eevdf: Force propagating min_slice of cfs_rq when {en,de}queue tasks

Tianyu Lan (1):
      x86/hyperv: Fix check of return value from snp_set_vmsa()

Tiezhu Yang (3):
      objtool: Handle various symbol types of rodata
      objtool: Handle different entry size of rodata
      objtool: Handle PC relative relocation type

Tim Schumacher (1):
      selinux: Chain up tool resolving errors in install_policy.sh

Tingbo Liao (1):
      riscv: Fix the __riscv_copy_vec_words_unaligned implementation

Tobias Waldekranz (1):
      net: mvpp2: Prevent parser TCAM memory corruption

Tom Rini (1):
      ARM: dts: omap4-panda-a4: Add missing model and compatible properties

Tomas Glozar (1):
      tools/rv: Keep user LDFLAGS in build

Tomi Valkeinen (1):
      drm: xlnx: zynqmp: Fix max dma segment size

Tony Ambardar (2):
      selftests/bpf: Fix runqslower cross-endian build
      libbpf: Fix accessing BTF.ext core_relo header

Trond Myklebust (5):
      NFSv4: Don't trigger uneccessary scans for return-on-close delegations
      NFSv4: Avoid unnecessary scans of filesystems for returning delegations
      NFSv4: Avoid unnecessary scans of filesystems for expired delegations
      NFSv4: Avoid unnecessary scans of filesystems for delayed delegations
      NFS: Shut down the nfs_client only after all the superblocks

Tushar Dave (1):
      PCI/ACS: Fix 'pci=config_acs=' parameter

Ulf Hansson (1):
      mmc: sdhci-omap: Disable MMC_CAP_AGGRESSIVE_PM for eMMC/SD

Uwe Kleine-König (8):
      iio: adc: ad7124: Micro-optimize channel disabling
      iio: adc: ad7124: Really disable all channels at probe time
      iio: adc: ad7173: Grab direct mode for calibration
      iio: adc: ad7192: Grab direct mode for calibration
      iio: adc: ad_sigma_delta: Disable channel after calibration
      iio: adc: ad4130: Fix comparison of channel setups
      iio: adc: ad7124: Fix comparison of channel configs
      iio: adc: ad7173: Fix comparison of channel configs

Vaibhav Jain (1):
      powerpc/perf: Fix ref-counting on the PMU 'vpa_pmu'

Vasant Hegde (1):
      iommu/amd: Fix header file

Vasiliy Kovalev (3):
      jfs: add check read-only before txBeginAnon() call
      jfs: add check read-only before truncation in jfs_truncate_nolock()
      ocfs2: validate l_tree_depth to avoid out-of-bounds access

Venkata Prasad Potturu (1):
      ASoC: amd: acp: Fix for enabling DMIC on acp platforms via _DSD entry

Veronika Molnarova (1):
      perf test stat_all_pmu.sh: Correctly check 'perf stat' result

Viktor Malik (1):
      selftests/bpf: Fix string read in strncmp benchmark

Viresh Kumar (1):
      firmware: arm_ffa: Refactor addition of partition information into XArray

Vishal Annapurve (1):
      x86/tdx: Fix arch_safe_halt() execution for TDX VMs

Vitalii Mordan (1):
      gpu: cdns-mhdp8546: fix call balance of mhdp->clk handling routines

Vitaliy Shevtsov (2):
      ASoC: cs35l41: check the return value from spi_setup()
      drm/amd/display: fix type mismatch in CalculateDynamicMetadataParameters()

Vitaly Kuznetsov (1):
      x86/entry: Add __init to ia32_emulation_override_cmdline()

Vitaly Lifshits (1):
      e1000e: change k1 configuration on MTP and later platforms

Vladimir Lypak (1):
      clk: qcom: gcc-msm8953: fix stuck venus0_core0 clock

Vladimir Oltean (3):
      net: dsa: sja1105: fix displaced ethtool statistics counters
      net: dsa: sja1105: reject other RX filters than HWTSTAMP_FILTER_PTP_V2_L2_EVENT
      net: dsa: sja1105: fix kasan out-of-bounds warning in sja1105_table_delete_entry()

WANG Rui (1):
      rust: Fix enabling Rust and building with GCC for LoongArch

Wang Liang (4):
      bonding: check xdp prog when set bond mode
      net: fix NULL pointer dereference in l3mdev_l3_rcv
      RDMA/core: Fix use-after-free when rename device name
      xsk: Fix __xsk_generic_xmit() error code when cq is full

Wang Zhaolong (1):
      smb: client: Fix netns refcount imbalance causing leaks and use-after-free

WangYuli (2):
      netfilter: nf_tables: Only use nf_skip_indirect_calls() when MITIGATION_RETPOLINE
      mlxsw: spectrum_acl_bloom_filter: Workaround for some LLVM versions

Wayne Lin (1):
      drm/dp_mst: Fix drm RAD print

Wen Gong (1):
      wifi: ath11k: update channel list in reg notifier instead reg worker

Wenkai Lin (3):
      crypto: hisilicon/sec2 - fix for aead authsize alignment
      crypto: hisilicon/sec2 - fix for sec spec check
      crypto: hisilicon/sec2 - fix for aead auth key length

Wentao Guan (1):
      Bluetooth: HCI: Add definition of hci_rp_remote_name_req_cancel

Wentao Liang (1):
      greybus: gb-beagleplay: Add error handling for gb_greybus_init

Will McVicker (1):
      clk: samsung: Fix UBSAN panic in samsung_clk_init()

Xiao Ni (1):
      md/raid10: wait barrier before returning discard request with REQ_NOWAIT

Xingui Yang (1):
      scsi: hisi_sas: Fixed failure to issue vendor specific commands

Xueqi Zhang (1):
      memory: mtk-smi: Add ostd setting for mt8192

Yajun Deng (1):
      ntb_hw_switchtec: Fix shift-out-of-bounds in switchtec_ntb_mw_set_trans

Yang Wang (1):
      drm/amdgpu: refine smu send msg debug log format

Yao Zi (2):
      arm64: dts: rockchip: Fix PWM pinctrl names
      riscv/kexec_file: Handle R_RISCV_64 in purgatory relocator

Ye Bin (5):
      ext4: introduce ITAIL helper
      ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()
      fs/ntfs3: Factor out ntfs_{create/remove}_procdir()
      fs/ntfs3: Factor out ntfs_{create/remove}_proc_root()
      fs/ntfs3: Fix 'proc_info_root' leak when init ntfs failed

Yeoreum Yun (1):
      perf/core: Fix child_total_time_enabled accounting bug at task exit

Yi Lai (1):
      selftests/pcie_bwctrl: Add 'set_pcie_speed.sh' to TEST_PROGS

Ying Lu (1):
      usbnet:fix NPE during rx_complete

Yosry Ahmed (1):
      mm: zswap: fix crypto_free_acomp() deadlock in zswap_cpu_comp_dead()

Yu Kuai (3):
      md: fix mddev uaf while iterating all_mddevs list
      md/raid1,raid10: don't ignore IO flags
      blk-throttle: fix lower bps rate by throtl_trim_slice()

Yu Zhang(Yuriy) (1):
      wifi: ath11k: fix wrong overriding for VHT Beamformee STS Capability

Yuanfang Zhang (1):
      coresight-etm4x: add isb() before reading the TRCSTATR

Yue Haibing (2):
      pinctrl: nuvoton: npcm8xx: Fix error handling in npcm8xx_gpio_fw()
      drm/xe: Fix unmet direct dependencies warning

Yuezhang Mo (2):
      exfat: fix the infinite loop in exfat_find_last_cluster()
      exfat: fix missing shutdown check

Yuli Wang (1):
      LoongArch: Rework the arch_kgdb_breakpoint() implementation

Yunhui Cui (1):
      iommu/vt-d: Fix system hang on reboot -f

Zdenek Bouska (1):
      igc: Fix TX drops in XDP ZC

Zhang Rui (2):
      tools/power turbostat: Allow Zero return value for some RAPL registers
      tools/power turbostat: Restore GFX sysfs fflush() call

Zhang Yi (2):
      jbd2: fix off-by-one while erasing journal
      jbd2: add a missing data flush during file and fs synchronization

Zheng Qixing (4):
      md/raid1: fix memory leak in raid1_run() if no active rdev
      badblocks: fix missing bad blocks on retry in _badblocks_check()
      badblocks: return boolean from badblocks_set() and badblocks_clear()
      badblocks: use sector_t instead of int to avoid truncation of badblocks length

Zijun Hu (1):
      of: property: Increase NR_FWNODE_REFERENCE_ARGS

xueqin Luo (1):
      thermal: core: Remove duplicate struct declaration

zihan zhou (1):
      sched: Cancel the slice protection of the idle entity

zuoqian (1):
      cpufreq: scpi: compare kHz instead of Hz

谢致邦 (XIE Zhibang) (2):
      staging: rtl8723bs: select CONFIG_CRYPTO_LIB_AES
      LoongArch: Fix help text of CMDLINE_EXTEND in Kconfig


