Return-Path: <stable+bounces-208015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F092CD0F1EA
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 15:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D327302D524
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 14:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394BD34889C;
	Sun, 11 Jan 2026 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="daIE5DrJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA52E33EAF5;
	Sun, 11 Jan 2026 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768141970; cv=none; b=pZ378IjvsUT5l6uNjZL3OLijE+ra+tUJ0Rd7dCKS+6FN3hrEdvokZ1U1rUp35vh/4R1e6GCAXMqoXS6AeKWY/k+7JY9XBupSdxCIGPU0KQmblIrPqw+wjbVmFLCD8VDhpxTfoYXWujU0+hJzbpUcM8RPRxgwjvelb/Jicr33g7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768141970; c=relaxed/simple;
	bh=YrCMe78csQ6dy0L2AlKnLjXIeN/FuVaoZdCCzCej/bc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JDByGGn5j7McUIxDHc7xDan4+gv6fyAFjq5nH6tZ0Ho4FpSOJpZU0CTF6cCgESSFElvT6+V+G075iSZy7RiCcBQ/BxNikaB7aiY+t+20Iw1ipgsMnBWfMpGGYyJTJc5kFeKBnbEIC0nVCLqU0lODN6SVd+cBW6OzootEhylWzHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=daIE5DrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C54C4CEF7;
	Sun, 11 Jan 2026 14:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768141970;
	bh=YrCMe78csQ6dy0L2AlKnLjXIeN/FuVaoZdCCzCej/bc=;
	h=From:To:Cc:Subject:Date:From;
	b=daIE5DrJUlt9sVXVzjDpZM4HlcyXOYGR/153lBo6/aCrbuIvNoJjSjOVD1zHTuzKg
	 LhUL251S/ftZWfJFlX/rupH086mjg4Q/78mxPWBL2Y8KvhJQptb35AgkRLV+vY2R9U
	 cb+d1GRRyZMxbgvxRNkspRhwk3w9W0MlcGP0Pw18=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.120
Date: Sun, 11 Jan 2026 15:32:31 +0100
Message-ID: <2026011132--8502@gregkh>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.120 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml                  |    2 
 Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml              |    6 
 Documentation/driver-api/tty/tty_port.rst                                |    5 
 Documentation/process/2.Process.rst                                      |    6 
 Makefile                                                                 |    2 
 arch/arm/boot/dts/microchip/sama5d2.dtsi                                 |   10 
 arch/arm/boot/dts/microchip/sama7g5.dtsi                                 |    4 
 arch/arm/boot/dts/renesas/r8a7793-gose.dts                               |    1 
 arch/arm/boot/dts/renesas/r9a06g032-rzn1d400-db.dts                      |    2 
 arch/arm/boot/dts/samsung/exynos4210-i9100.dts                           |    1 
 arch/arm/boot/dts/samsung/exynos4210-trats.dts                           |    1 
 arch/arm/boot/dts/samsung/exynos4210-universal_c210.dts                  |    1 
 arch/arm/boot/dts/samsung/exynos4412-midas.dtsi                          |    1 
 arch/arm/boot/dts/st/stm32mp157c-phycore-stm32mp15-som.dtsi              |    8 
 arch/arm/boot/dts/ti/omap/am335x-netcom-plus-2xx.dts                     |    8 
 arch/arm/boot/dts/ti/omap/omap3-beagle-xm.dts                            |    2 
 arch/arm/boot/dts/ti/omap/omap3-n900.dts                                 |    2 
 arch/arm/include/asm/word-at-a-time.h                                    |   10 
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi                  |   11 
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi                  |   51 -
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw72xx.dtsi                  |   11 
 arch/arm64/boot/dts/qcom/msm8996.dtsi                                    |    3 
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi                      |    4 
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts                         |   15 
 arch/arm64/boot/dts/ti/k3-am62p.dtsi                                     |    2 
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                                   |   12 
 arch/arm64/net/bpf_jit_comp.c                                            |    2 
 arch/loongarch/include/asm/pgtable.h                                     |    4 
 arch/loongarch/kernel/machine_kexec.c                                    |   24 
 arch/loongarch/kernel/mcount_dyn.S                                       |   14 
 arch/loongarch/kernel/relocate.c                                         |    4 
 arch/loongarch/kernel/setup.c                                            |    8 
 arch/loongarch/kernel/switch.S                                           |    4 
 arch/loongarch/net/bpf_jit.c                                             |   18 
 arch/loongarch/net/bpf_jit.h                                             |   26 
 arch/loongarch/pci/pci.c                                                 |    2 
 arch/mips/sgi-ip22/ip22-gio.c                                            |    3 
 arch/parisc/kernel/asm-offsets.c                                         |    2 
 arch/parisc/kernel/entry.S                                               |   16 
 arch/powerpc/boot/addnote.c                                              |    7 
 arch/powerpc/include/asm/book3s/32/tlbflush.h                            |    5 
 arch/powerpc/include/asm/book3s/64/mmu-hash.h                            |    1 
 arch/powerpc/include/asm/kfence.h                                        |   11 
 arch/powerpc/kernel/entry_32.S                                           |   10 
 arch/powerpc/kernel/process.c                                            |    5 
 arch/powerpc/kexec/core_64.c                                             |   19 
 arch/powerpc/mm/book3s32/tlb.c                                           |    9 
 arch/powerpc/mm/book3s64/hash_utils.c                                    |   10 
 arch/powerpc/mm/book3s64/internal.h                                      |    2 
 arch/powerpc/mm/book3s64/mmu_context.c                                   |    2 
 arch/powerpc/mm/book3s64/radix_pgtable.c                                 |   84 ++
 arch/powerpc/mm/book3s64/slb.c                                           |   88 --
 arch/powerpc/mm/init-common.c                                            |    3 
 arch/powerpc/mm/ptdump/hashpagetable.c                                   |    6 
 arch/powerpc/platforms/pseries/cmm.c                                     |    5 
 arch/riscv/kvm/vcpu_insn.c                                               |   22 
 arch/s390/include/uapi/asm/ipl.h                                         |    1 
 arch/s390/kernel/ipl.c                                                   |   48 -
 arch/s390/kernel/smp.c                                                   |    1 
 arch/x86/boot/compressed/pgtable_64.c                                    |   11 
 arch/x86/crypto/blake2s-core.S                                           |    4 
 arch/x86/entry/common.c                                                  |   72 -
 arch/x86/events/amd/core.c                                               |    7 
 arch/x86/events/intel/core.c                                             |    4 
 arch/x86/include/asm/kvm_host.h                                          |    9 
 arch/x86/include/asm/ptrace.h                                            |   20 
 arch/x86/kernel/cpu/microcode/amd.c                                      |    2 
 arch/x86/kernel/dumpstack.c                                              |   23 
 arch/x86/kvm/lapic.c                                                     |   32 
 arch/x86/kvm/svm/nested.c                                                |   26 
 arch/x86/kvm/svm/svm.c                                                   |  162 ++--
 arch/x86/kvm/svm/svm.h                                                   |    8 
 arch/x86/kvm/vmx/nested.c                                                |    2 
 arch/x86/kvm/vmx/vmx.c                                                   |    2 
 arch/x86/kvm/vmx/vmx.h                                                   |    1 
 arch/x86/kvm/x86.c                                                       |   46 -
 arch/x86/xen/enlighten_pv.c                                              |   69 +
 block/blk-mq.c                                                           |  120 ++-
 block/genhd.c                                                            |    2 
 crypto/af_alg.c                                                          |    5 
 crypto/algif_hash.c                                                      |    3 
 crypto/algif_rng.c                                                       |    3 
 crypto/asymmetric_keys/asymmetric_type.c                                 |   14 
 crypto/authenc.c                                                         |   75 +-
 crypto/seqiv.c                                                           |    8 
 drivers/acpi/acpi_pcc.c                                                  |    2 
 drivers/acpi/acpica/nswalk.c                                             |    9 
 drivers/acpi/apei/ghes.c                                                 |   16 
 drivers/acpi/cppc_acpi.c                                                 |    3 
 drivers/acpi/processor_core.c                                            |    2 
 drivers/acpi/property.c                                                  |    9 
 drivers/amba/tegra-ahb.c                                                 |    1 
 drivers/base/power/runtime.c                                             |   22 
 drivers/block/floppy.c                                                   |    2 
 drivers/block/nbd.c                                                      |    5 
 drivers/block/ps3disk.c                                                  |    4 
 drivers/block/rnbd/rnbd-clt.c                                            |   13 
 drivers/block/rnbd/rnbd-clt.h                                            |    2 
 drivers/block/ublk_drv.c                                                 |   35 
 drivers/bluetooth/btrtl.c                                                |   24 
 drivers/bluetooth/btusb.c                                                |   16 
 drivers/bus/ti-sysc.c                                                    |   11 
 drivers/char/applicom.c                                                  |    5 
 drivers/char/ipmi/ipmi_msghandler.c                                      |   20 
 drivers/char/tpm/tpm-chip.c                                              |    1 
 drivers/char/tpm/tpm1-cmd.c                                              |    5 
 drivers/char/tpm/tpm2-cmd.c                                              |    8 
 drivers/char/virtio_console.c                                            |    2 
 drivers/clk/Makefile                                                     |    3 
 drivers/clk/mvebu/cp110-system-controller.c                              |   20 
 drivers/clk/qcom/camcc-sm6350.c                                          |   13 
 drivers/clk/renesas/r7s9210-cpg-mssr.c                                   |    7 
 drivers/clk/renesas/r8a77970-cpg-mssr.c                                  |    8 
 drivers/clk/renesas/r9a06g032-clocks.c                                   |    6 
 drivers/clk/renesas/rcar-gen2-cpg.c                                      |    5 
 drivers/clk/renesas/rcar-gen2-cpg.h                                      |    3 
 drivers/clk/renesas/rcar-gen3-cpg.c                                      |    6 
 drivers/clk/renesas/rcar-gen3-cpg.h                                      |    3 
 drivers/clk/renesas/rcar-gen4-cpg.c                                      |    6 
 drivers/clk/renesas/rcar-gen4-cpg.h                                      |    3 
 drivers/clk/renesas/renesas-cpg-mssr.c                                   |  150 ++--
 drivers/clk/renesas/renesas-cpg-mssr.h                                   |   20 
 drivers/clk/renesas/rzg2l-cpg.c                                          |   15 
 drivers/clk/samsung/clk-exynos-clkout.c                                  |    2 
 drivers/comedi/comedi_fops.c                                             |   42 -
 drivers/comedi/drivers/c6xdigio.c                                        |   46 -
 drivers/comedi/drivers/multiq3.c                                         |    9 
 drivers/comedi/drivers/pcl818.c                                          |    5 
 drivers/cpufreq/amd-pstate.c                                             |    2 
 drivers/cpufreq/cpufreq-dt-platdev.c                                     |    1 
 drivers/cpufreq/cpufreq-nforce2.c                                        |    3 
 drivers/cpufreq/s5pv210-cpufreq.c                                        |    6 
 drivers/cpuidle/governors/menu.c                                         |    9 
 drivers/cpuidle/governors/teo.c                                          |    7 
 drivers/crypto/caam/caamrng.c                                            |    4 
 drivers/crypto/ccree/cc_buffer_mgr.c                                     |    6 
 drivers/crypto/hisilicon/qm.c                                            |   14 
 drivers/crypto/starfive/jh7110-hash.c                                    |    6 
 drivers/firewire/nosy.c                                                  |   10 
 drivers/firmware/arm_scmi/notify.c                                       |    1 
 drivers/firmware/efi/cper-arm.c                                          |   52 -
 drivers/firmware/efi/cper.c                                              |   60 +
 drivers/firmware/efi/libstub/x86-5lvl.c                                  |    4 
 drivers/firmware/imx/imx-scu-irq.c                                       |    8 
 drivers/firmware/stratix10-svc.c                                         |   12 
 drivers/gpio/gpio-regmap.c                                               |    2 
 drivers/gpio/gpiolib-acpi.c                                              |   22 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                                  |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                                   |    6 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c                       |    8 
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c                         |    2 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c                    |    9 
 drivers/gpu/drm/gma500/fbdev.c                                           |   43 -
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c                           |   37 
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c                                |   23 
 drivers/gpu/drm/mediatek/mtk_dp.c                                        |    1 
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c                              |   22 
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h                              |    2 
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                                   |    4 
 drivers/gpu/drm/mgag200/mgag200_mode.c                                   |   25 
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c                                    |    2 
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c                              |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c                      |   10 
 drivers/gpu/drm/nouveau/dispnv50/atom.h                                  |   13 
 drivers/gpu/drm/nouveau/dispnv50/wndw.c                                  |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/base.c                            |    2 
 drivers/gpu/drm/panel/panel-sony-td4353-jdi.c                            |    2 
 drivers/gpu/drm/panel/panel-visionox-rm69299.c                           |    2 
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c                                     |    2 
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                                      |   72 +
 drivers/gpu/drm/tilcdc/tilcdc_drv.h                                      |    2 
 drivers/gpu/drm/ttm/ttm_bo_vm.c                                          |    6 
 drivers/gpu/drm/vgem/vgem_fence.c                                        |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c                               |   12 
 drivers/gpu/host1x/syncpt.c                                              |    4 
 drivers/hid/hid-apple.c                                                  |    1 
 drivers/hid/hid-elecom.c                                                 |    6 
 drivers/hid/hid-ids.h                                                    |    3 
 drivers/hid/hid-input.c                                                  |   23 
 drivers/hid/hid-logitech-dj.c                                            |   56 -
 drivers/hid/hid-logitech-hidpp.c                                         |    9 
 drivers/hid/hid-quirks.c                                                 |    3 
 drivers/hwmon/ibmpex.c                                                   |    9 
 drivers/hwmon/max16065.c                                                 |    7 
 drivers/hwmon/sy7636a-hwmon.c                                            |    7 
 drivers/hwmon/tmp401.c                                                   |    2 
 drivers/hwmon/w83791d.c                                                  |   17 
 drivers/hwmon/w83l786ng.c                                                |   26 
 drivers/hwtracing/coresight/coresight-etm4x-core.c                       |  130 ++-
 drivers/hwtracing/intel_th/core.c                                        |   20 
 drivers/i2c/busses/i2c-amd-mp2-pci.c                                     |    5 
 drivers/i2c/busses/i2c-designware-core.h                                 |    1 
 drivers/i2c/busses/i2c-designware-master.c                               |    7 
 drivers/i3c/master.c                                                     |   12 
 drivers/i3c/master/svc-i3c-master.c                                      |   22 
 drivers/iio/adc/ti_am335x_adc.c                                          |    2 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h                                  |    2 
 drivers/infiniband/core/addr.c                                           |   33 
 drivers/infiniband/core/cma.c                                            |    3 
 drivers/infiniband/core/device.c                                         |    6 
 drivers/infiniband/core/verbs.c                                          |    2 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                                 |    7 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c                               |    2 
 drivers/infiniband/hw/bnxt_re/qplib_res.c                                |    8 
 drivers/infiniband/hw/bnxt_re/qplib_sp.c                                 |    2 
 drivers/infiniband/hw/efa/efa_verbs.c                                    |    4 
 drivers/infiniband/hw/irdma/cm.c                                         |    2 
 drivers/infiniband/hw/irdma/ctrl.c                                       |    3 
 drivers/infiniband/hw/irdma/main.h                                       |    2 
 drivers/infiniband/hw/irdma/pble.c                                       |    6 
 drivers/infiniband/hw/irdma/utils.c                                      |    3 
 drivers/infiniband/hw/irdma/verbs.c                                      |  241 +++++-
 drivers/infiniband/hw/irdma/verbs.h                                      |    3 
 drivers/infiniband/sw/rxe/rxe.c                                          |   22 
 drivers/infiniband/sw/rxe/rxe.h                                          |    3 
 drivers/infiniband/sw/rxe/rxe_mcast.c                                    |   22 
 drivers/infiniband/sw/rxe/rxe_net.c                                      |   25 
 drivers/infiniband/sw/rxe/rxe_srq.c                                      |    7 
 drivers/infiniband/sw/rxe/rxe_verbs.c                                    |   26 
 drivers/infiniband/sw/rxe/rxe_verbs.h                                    |   11 
 drivers/infiniband/ulp/rtrs/rtrs-clt.c                                   |    1 
 drivers/infiniband/ulp/rtrs/rtrs-srv.c                                   |    2 
 drivers/input/serio/i8042-acpipnpio.h                                    |    7 
 drivers/input/touchscreen/ti_am335x_tsc.c                                |    2 
 drivers/interconnect/debugfs-client.c                                    |    7 
 drivers/interconnect/qcom/msm8996.c                                      |    1 
 drivers/iommu/amd/init.c                                                 |   43 -
 drivers/iommu/apple-dart.c                                               |    2 
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c                               |   27 
 drivers/iommu/arm/arm-smmu/qcom_iommu.c                                  |   10 
 drivers/iommu/exynos-iommu.c                                             |    9 
 drivers/iommu/iommu-sva.c                                                |    3 
 drivers/iommu/iommufd/selftest.c                                         |    8 
 drivers/iommu/ipmmu-vmsa.c                                               |    2 
 drivers/iommu/mtk_iommu.c                                                |   27 
 drivers/iommu/mtk_iommu_v1.c                                             |   25 
 drivers/iommu/omap-iommu.c                                               |    2 
 drivers/iommu/omap-iommu.h                                               |    2 
 drivers/iommu/sun50i-iommu.c                                             |    2 
 drivers/iommu/tegra-smmu.c                                               |    5 
 drivers/irqchip/irq-bcm7038-l1.c                                         |    8 
 drivers/irqchip/irq-bcm7120-l2.c                                         |   17 
 drivers/irqchip/irq-brcmstb-l2.c                                         |   12 
 drivers/irqchip/irq-imx-mu-msi.c                                         |   14 
 drivers/irqchip/irq-mchp-eic.c                                           |    2 
 drivers/irqchip/qcom-irq-combiner.c                                      |    2 
 drivers/isdn/capi/capi.c                                                 |    8 
 drivers/leds/leds-lp50xx.c                                               |   67 +
 drivers/leds/leds-netxbig.c                                              |   36 
 drivers/leds/leds-spi-byte.c                                             |   11 
 drivers/macintosh/mac_hid.c                                              |    3 
 drivers/md/dm-bufio.c                                                    |   10 
 drivers/md/dm-ebs-target.c                                               |    2 
 drivers/md/dm-log-writes.c                                               |    1 
 drivers/md/dm-raid.c                                                     |    2 
 drivers/md/raid5.c                                                       |    6 
 drivers/media/cec/core/cec-core.c                                        |    1 
 drivers/media/common/videobuf2/videobuf2-dma-contig.c                    |    1 
 drivers/media/i2c/adv7604.c                                              |    4 
 drivers/media/i2c/adv7842.c                                              |   11 
 drivers/media/i2c/msp3400-kthreads.c                                     |    2 
 drivers/media/i2c/tda1997x.c                                             |    1 
 drivers/media/platform/amphion/vpu_malone.c                              |   35 
 drivers/media/platform/amphion/vpu_v4l2.c                                |   28 
 drivers/media/platform/amphion/vpu_v4l2.h                                |   18 
 drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c        |   14 
 drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c      |   12 
 drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h      |    2 
 drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c             |    5 
 drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c      |   12 
 drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h      |    2 
 drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c             |    5 
 drivers/media/platform/renesas/rcar_drif.c                               |    1 
 drivers/media/platform/samsung/exynos4-is/media-dev.c                    |   10 
 drivers/media/platform/ti/davinci/vpif_capture.c                         |    4 
 drivers/media/platform/ti/davinci/vpif_display.c                         |    4 
 drivers/media/platform/verisilicon/hantro.h                              |    2 
 drivers/media/platform/verisilicon/hantro_g2.c                           |  102 ++
 drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c                  |   35 
 drivers/media/platform/verisilicon/hantro_g2_regs.h                      |   13 
 drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c                   |   30 
 drivers/media/platform/verisilicon/hantro_hw.h                           |    4 
 drivers/media/platform/verisilicon/imx8m_vpu_hw.c                        |    2 
 drivers/media/rc/st_rc.c                                                 |    2 
 drivers/media/test-drivers/vidtv/vidtv_channel.c                         |    3 
 drivers/media/usb/dvb-usb/dtv5100.c                                      |    5 
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c                                  |    2 
 drivers/mfd/altera-sysmgr.c                                              |    2 
 drivers/mfd/da9055-core.c                                                |    1 
 drivers/mfd/max77620.c                                                   |   15 
 drivers/mfd/mt6358-irq.c                                                 |    1 
 drivers/mfd/mt6397-irq.c                                                 |    1 
 drivers/misc/vmw_balloon.c                                               |    3 
 drivers/mmc/host/Kconfig                                                 |    4 
 drivers/mmc/host/sdhci-msm.c                                             |   27 
 drivers/mtd/lpddr/lpddr_cmds.c                                           |    8 
 drivers/mtd/nand/raw/lpc32xx_slc.c                                       |    2 
 drivers/mtd/nand/raw/marvell_nand.c                                      |   13 
 drivers/mtd/nand/raw/nand_base.c                                         |   13 
 drivers/mtd/nand/raw/renesas-nand-controller.c                           |    5 
 drivers/net/can/usb/gs_usb.c                                             |    2 
 drivers/net/dsa/b53/b53_common.c                                         |    3 
 drivers/net/dsa/sja1105/sja1105_static_config.c                          |    6 
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c                              |    2 
 drivers/net/ethernet/broadcom/b44.c                                      |    3 
 drivers/net/ethernet/cadence/macb_main.c                                 |    3 
 drivers/net/ethernet/freescale/enetc/enetc.c                             |    3 
 drivers/net/ethernet/freescale/fec_main.c                                |    7 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c                  |    3 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c                   |    4 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c                |    4 
 drivers/net/ethernet/intel/e1000/e1000_main.c                            |   10 
 drivers/net/ethernet/intel/i40e/i40e_main.c                              |    1 
 drivers/net/ethernet/intel/iavf/iavf_main.c                              |    4 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c                |    8 
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c                        |    5 
 drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c                 |   97 ++
 drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.h                 |    1 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c               |    6 
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c                       |   59 +
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h                       |    1 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                           |    1 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c                        |    2 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c                    |   27 
 drivers/net/ethernet/microchip/lan743x_main.c                            |    3 
 drivers/net/ethernet/realtek/r8169_main.c                                |    5 
 drivers/net/ethernet/smsc/smc91x.c                                       |   10 
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c                             |    5 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c                      |    5 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                        |   19 
 drivers/net/fjes/fjes_hw.c                                               |   12 
 drivers/net/ipvlan/ipvlan_core.c                                         |    3 
 drivers/net/mdio/mdio-aspeed.c                                           |    7 
 drivers/net/phy/adin1100.c                                               |    2 
 drivers/net/phy/mediatek-ge-soc.c                                        |    2 
 drivers/net/phy/mscc/mscc_main.c                                         |    6 
 drivers/net/team/team.c                                                  |    2 
 drivers/net/usb/asix_common.c                                            |    5 
 drivers/net/usb/rtl8150.c                                                |    2 
 drivers/net/usb/sr9700.c                                                 |    4 
 drivers/net/wireless/ath/ath11k/mac.c                                    |    4 
 drivers/net/wireless/ath/ath11k/wmi.c                                    |    7 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c                   |   14 
 drivers/net/wireless/mediatek/mt76/eeprom.c                              |   37 
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c                          |    4 
 drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c                       |    9 
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c                       |   27 
 drivers/net/wireless/realtek/rtw88/rtw8822cu.c                           |    2 
 drivers/net/wireless/realtek/rtw88/sdio.c                                |    4 
 drivers/net/wireless/st/cw1200/bh.c                                      |    6 
 drivers/nfc/pn533/usb.c                                                  |    2 
 drivers/nvme/host/auth.c                                                 |    2 
 drivers/nvme/host/core.c                                                 |    3 
 drivers/nvme/host/fc.c                                                   |    6 
 drivers/parisc/gsc.c                                                     |    4 
 drivers/pci/controller/Kconfig                                           |    7 
 drivers/pci/controller/dwc/pci-keystone.c                                |    2 
 drivers/pci/controller/dwc/pcie-designware.h                             |    2 
 drivers/pci/controller/pcie-brcmstb.c                                    |   10 
 drivers/pci/pci-driver.c                                                 |    4 
 drivers/phy/broadcom/phy-bcm63xx-usbh.c                                  |    6 
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                                 |   20 
 drivers/pinctrl/pinctrl-single.c                                         |   25 
 drivers/pinctrl/qcom/pinctrl-msm.c                                       |    2 
 drivers/pinctrl/stm32/pinctrl-stm32.c                                    |    2 
 drivers/platform/chrome/cros_ec_ishtp.c                                  |    1 
 drivers/platform/x86/acer-wmi.c                                          |    4 
 drivers/platform/x86/amd/pmc/pmc-quirks.c                                |   25 
 drivers/platform/x86/asus-wmi.c                                          |    8 
 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c                     |    4 
 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c                      |    2 
 drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c               |    5 
 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c                |    5 
 drivers/platform/x86/hp/hp-bioscfg/string-attributes.c                   |    2 
 drivers/platform/x86/huawei-wmi.c                                        |    4 
 drivers/platform/x86/ibm_rtl.c                                           |    2 
 drivers/platform/x86/intel/chtwc_int33fe.c                               |   29 
 drivers/platform/x86/intel/hid.c                                         |   12 
 drivers/platform/x86/msi-laptop.c                                        |    3 
 drivers/pmdomain/actions/owl-sps.c                                       |   16 
 drivers/pmdomain/imx/gpc.c                                               |   12 
 drivers/pmdomain/rockchip/pm-domains.c                                   |   13 
 drivers/power/supply/apm_power.c                                         |    3 
 drivers/power/supply/cw2015_battery.c                                    |    8 
 drivers/power/supply/rt9467-charger.c                                    |    6 
 drivers/power/supply/wm831x_power.c                                      |   10 
 drivers/pwm/pwm-bcm2835.c                                                |   28 
 drivers/pwm/pwm-stm32.c                                                  |    3 
 drivers/regulator/core.c                                                 |   37 
 drivers/remoteproc/qcom_q6v5_wcss.c                                      |    8 
 drivers/rpmsg/qcom_glink_native.c                                        |    8 
 drivers/rtc/rtc-gamecube.c                                               |    4 
 drivers/s390/block/dasd_eckd.c                                           |    8 
 drivers/s390/crypto/ap_bus.c                                             |    8 
 drivers/scsi/aic94xx/aic94xx_init.c                                      |    3 
 drivers/scsi/qla2xxx/qla_def.h                                           |    1 
 drivers/scsi/qla2xxx/qla_gbl.h                                           |    2 
 drivers/scsi/qla2xxx/qla_isr.c                                           |   32 
 drivers/scsi/qla2xxx/qla_mbx.c                                           |    2 
 drivers/scsi/qla2xxx/qla_mid.c                                           |    4 
 drivers/scsi/qla2xxx/qla_nvme.c                                          |    2 
 drivers/scsi/qla2xxx/qla_os.c                                            |   14 
 drivers/scsi/sim710.c                                                    |    2 
 drivers/scsi/smartpqi/smartpqi_init.c                                    |   19 
 drivers/scsi/stex.c                                                      |    1 
 drivers/soc/amlogic/meson-canvas.c                                       |    5 
 drivers/soc/qcom/ocmem.c                                                 |    2 
 drivers/soc/qcom/smem.c                                                  |    3 
 drivers/spi/spi-cadence-quadspi.c                                        |    4 
 drivers/spi/spi-fsl-spi.c                                                |    2 
 drivers/spi/spi-imx.c                                                    |   15 
 drivers/spi/spi-tegra210-quad.c                                          |   22 
 drivers/spi/spi-xilinx.c                                                 |    2 
 drivers/staging/fbtft/fbtft-core.c                                       |    4 
 drivers/staging/greybus/uart.c                                           |    7 
 drivers/staging/most/Kconfig                                             |    2 
 drivers/staging/most/Makefile                                            |    1 
 drivers/staging/most/i2c/Kconfig                                         |   13 
 drivers/staging/most/i2c/Makefile                                        |    4 
 drivers/staging/most/i2c/i2c.c                                           |  374 ----------
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c                           |   14 
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c                            |   13 
 drivers/target/target_core_configfs.c                                    |    1 
 drivers/target/target_core_transport.c                                   |    1 
 drivers/tty/serial/8250/8250_pci.c                                       |   37 
 drivers/tty/serial/serial_core.c                                         |    7 
 drivers/tty/serial/sprd_serial.c                                         |    6 
 drivers/tty/tty_port.c                                                   |   17 
 drivers/ufs/core/ufshcd.c                                                |    7 
 drivers/uio/uio_fsl_elbc_gpcm.c                                          |    7 
 drivers/usb/class/cdc-acm.c                                              |    7 
 drivers/usb/core/message.c                                               |    2 
 drivers/usb/dwc2/platform.c                                              |   16 
 drivers/usb/dwc3/dwc3-of-simple.c                                        |    7 
 drivers/usb/dwc3/gadget.c                                                |    2 
 drivers/usb/dwc3/host.c                                                  |    2 
 drivers/usb/gadget/legacy/raw_gadget.c                                   |    3 
 drivers/usb/gadget/udc/lpc32xx_udc.c                                     |   21 
 drivers/usb/gadget/udc/tegra-xudc.c                                      |    6 
 drivers/usb/host/ohci-nxp.c                                              |   20 
 drivers/usb/host/xhci-dbgtty.c                                           |    2 
 drivers/usb/host/xhci-hub.c                                              |    2 
 drivers/usb/host/xhci-mem.c                                              |   10 
 drivers/usb/host/xhci-ring.c                                             |    8 
 drivers/usb/host/xhci.h                                                  |   16 
 drivers/usb/misc/chaoskey.c                                              |   16 
 drivers/usb/phy/phy-fsl-usb.c                                            |    1 
 drivers/usb/phy/phy-isp1301.c                                            |    7 
 drivers/usb/phy/phy.c                                                    |    4 
 drivers/usb/renesas_usbhs/pipe.c                                         |    2 
 drivers/usb/serial/belkin_sa.c                                           |   28 
 drivers/usb/serial/ftdi_sio.c                                            |   72 -
 drivers/usb/serial/kobil_sct.c                                           |   18 
 drivers/usb/serial/option.c                                              |   22 
 drivers/usb/serial/usb-serial.c                                          |    7 
 drivers/usb/storage/unusual_uas.h                                        |    2 
 drivers/usb/typec/ucsi/ucsi.c                                            |    6 
 drivers/usb/usbip/vhci_hcd.c                                             |    6 
 drivers/vdpa/pds/vdpa_dev.c                                              |    2 
 drivers/vhost/vsock.c                                                    |   15 
 drivers/video/backlight/led_bl.c                                         |   13 
 drivers/video/fbdev/gbefb.c                                              |    5 
 drivers/video/fbdev/pxafb.c                                              |   12 
 drivers/video/fbdev/ssd1307fb.c                                          |    4 
 drivers/video/fbdev/tcx.c                                                |    2 
 drivers/virtio/virtio_balloon.c                                          |    4 
 drivers/virtio/virtio_vdpa.c                                             |    2 
 drivers/watchdog/starfive-wdt.c                                          |    4 
 drivers/watchdog/via_wdt.c                                               |    1 
 drivers/watchdog/wdat_wdt.c                                              |   64 +
 fs/9p/v9fs.c                                                             |    4 
 fs/9p/vfs_file.c                                                         |   11 
 fs/9p/vfs_inode.c                                                        |    3 
 fs/9p/vfs_inode_dotl.c                                                   |    2 
 fs/bfs/inode.c                                                           |   19 
 fs/btrfs/ctree.c                                                         |    2 
 fs/btrfs/inode.c                                                         |    1 
 fs/btrfs/ioctl.c                                                         |    4 
 fs/btrfs/scrub.c                                                         |    5 
 fs/btrfs/tree-log.c                                                      |   46 +
 fs/btrfs/volumes.c                                                       |    1 
 fs/exfat/super.c                                                         |   19 
 fs/ext4/ext4.h                                                           |    1 
 fs/ext4/ialloc.c                                                         |    1 
 fs/ext4/inline.c                                                         |   14 
 fs/ext4/inode.c                                                          |    6 
 fs/ext4/mballoc.c                                                        |   58 -
 fs/ext4/move_extent.c                                                    |    2 
 fs/ext4/orphan.c                                                         |    4 
 fs/ext4/super.c                                                          |   26 
 fs/ext4/xattr.c                                                          |   38 -
 fs/ext4/xattr.h                                                          |   10 
 fs/f2fs/compress.c                                                       |    5 
 fs/f2fs/data.c                                                           |   17 
 fs/f2fs/debug.c                                                          |    3 
 fs/f2fs/extent_cache.c                                                   |    5 
 fs/f2fs/f2fs.h                                                           |   41 -
 fs/f2fs/file.c                                                           |   92 ++
 fs/f2fs/inode.c                                                          |   20 
 fs/f2fs/namei.c                                                          |    6 
 fs/f2fs/recovery.c                                                       |   23 
 fs/f2fs/segment.c                                                        |    9 
 fs/f2fs/super.c                                                          |  119 +--
 fs/f2fs/xattr.c                                                          |   30 
 fs/f2fs/xattr.h                                                          |   10 
 fs/fuse/file.c                                                           |   37 
 fs/gfs2/glops.c                                                          |    3 
 fs/gfs2/lops.c                                                           |    2 
 fs/gfs2/super.c                                                          |    4 
 fs/hfsplus/bnode.c                                                       |    4 
 fs/hfsplus/dir.c                                                         |    7 
 fs/hfsplus/inode.c                                                       |   32 
 fs/iomap/buffered-io.c                                                   |   41 -
 fs/iomap/direct-io.c                                                     |   77 +-
 fs/jbd2/journal.c                                                        |   20 
 fs/jbd2/transaction.c                                                    |   21 
 fs/lockd/svc4proc.c                                                      |    4 
 fs/lockd/svclock.c                                                       |   21 
 fs/lockd/svcproc.c                                                       |    5 
 fs/locks.c                                                               |   12 
 fs/nfs/client.c                                                          |   21 
 fs/nfs/dir.c                                                             |   27 
 fs/nfs/inode.c                                                           |    2 
 fs/nfs/internal.h                                                        |    3 
 fs/nfs/namespace.c                                                       |   11 
 fs/nfs/nfs4client.c                                                      |   18 
 fs/nfs/pnfs.c                                                            |    1 
 fs/nfs/super.c                                                           |   33 
 fs/nfsd/blocklayout.c                                                    |    7 
 fs/nfsd/export.c                                                         |    2 
 fs/nfsd/nfs4state.c                                                      |    4 
 fs/nfsd/nfs4xdr.c                                                        |    5 
 fs/nls/nls_base.c                                                        |   27 
 fs/notify/fsnotify.c                                                     |    9 
 fs/ntfs3/frecord.c                                                       |   43 -
 fs/ntfs3/fsntfs.c                                                        |    9 
 fs/ntfs3/inode.c                                                         |    2 
 fs/ntfs3/ntfs_fs.h                                                       |    9 
 fs/ntfs3/run.c                                                           |    6 
 fs/ntfs3/super.c                                                         |    5 
 fs/ocfs2/alloc.c                                                         |    1 
 fs/ocfs2/move_extents.c                                                  |    8 
 fs/ocfs2/suballoc.c                                                      |   10 
 fs/smb/client/fs_context.c                                               |    4 
 fs/smb/server/mgmt/tree_connect.c                                        |   18 
 fs/smb/server/mgmt/tree_connect.h                                        |    1 
 fs/smb/server/mgmt/user_session.c                                        |    4 
 fs/smb/server/smb2pdu.c                                                  |   20 
 fs/smb/server/transport_ipc.c                                            |    7 
 fs/smb/server/vfs.c                                                      |    5 
 fs/smb/server/vfs_cache.c                                                |   88 +-
 fs/tracefs/event_inode.c                                                 |    3 
 fs/xfs/xfs_buf_item.c                                                    |    1 
 include/linux/balloon_compaction.h                                       |   43 -
 include/linux/blk_types.h                                                |    5 
 include/linux/compiler_types.h                                           |   13 
 include/linux/cper.h                                                     |   12 
 include/linux/filter.h                                                   |   16 
 include/linux/genalloc.h                                                 |    1 
 include/linux/ieee80211.h                                                |    4 
 include/linux/if_bridge.h                                                |    6 
 include/linux/jbd2.h                                                     |    6 
 include/linux/kasan.h                                                    |   15 
 include/linux/mm.h                                                       |   10 
 include/linux/nfs_fs_sb.h                                                |    7 
 include/linux/nfs_xdr.h                                                  |   54 -
 include/linux/platform_data/lp855x.h                                     |    4 
 include/linux/rculist_nulls.h                                            |   59 +
 include/linux/reset.h                                                    |    1 
 include/linux/sched/topology.h                                           |    3 
 include/linux/tpm.h                                                      |    8 
 include/linux/tty_port.h                                                 |   21 
 include/linux/virtio_config.h                                            |    6 
 include/media/v4l2-mem2mem.h                                             |    3 
 include/net/ip6_fib.h                                                    |   46 +
 include/net/netfilter/nf_conntrack_count.h                               |   17 
 include/net/netfilter/nf_tables.h                                        |    4 
 include/net/sock.h                                                       |   13 
 include/net/xfrm.h                                                       |   13 
 include/rdma/ib_verbs.h                                                  |    2 
 include/sound/snd_wavefront.h                                            |    4 
 include/uapi/linux/mptcp.h                                               |    1 
 include/uapi/sound/asound.h                                              |    2 
 io_uring/openclose.c                                                     |    2 
 io_uring/poll.c                                                          |    9 
 kernel/bpf/hashtab.c                                                     |   10 
 kernel/bpf/syscall.c                                                     |    3 
 kernel/bpf/trampoline.c                                                  |    7 
 kernel/cgroup/cpuset.c                                                   |   35 
 kernel/dma/pool.c                                                        |    2 
 kernel/irq/irq_sim.c                                                     |    2 
 kernel/kallsyms.c                                                        |    5 
 kernel/livepatch/core.c                                                  |    8 
 kernel/locking/spinlock_debug.c                                          |    4 
 kernel/resource.c                                                        |   78 +-
 kernel/sched/core.c                                                      |    3 
 kernel/sched/cpudeadline.c                                               |   34 
 kernel/sched/cpudeadline.h                                               |    4 
 kernel/sched/deadline.c                                                  |    8 
 kernel/sched/fair.c                                                      |   89 +-
 kernel/sched/features.h                                                  |    5 
 kernel/sched/sched.h                                                     |    7 
 kernel/sched/topology.c                                                  |    6 
 kernel/scs.c                                                             |    2 
 kernel/task_work.c                                                       |    8 
 kernel/trace/ftrace.c                                                    |   40 -
 kernel/trace/trace_events.c                                              |    2 
 kernel/trace/trace_events_synth.c                                        |    1 
 lib/idr.c                                                                |    2 
 lib/vsprintf.c                                                           |    6 
 mm/balloon_compaction.c                                                  |    9 
 mm/damon/core-test.h                                                     |  110 ++
 mm/damon/vaddr-test.h                                                    |   26 
 mm/kasan/common.c                                                        |   17 
 mm/ksm.c                                                                 |   18 
 mm/page-writeback.c                                                      |    4 
 mm/vmalloc.c                                                             |    4 
 net/bluetooth/rfcomm/tty.c                                               |    7 
 net/bridge/br_ioctl.c                                                    |   36 
 net/bridge/br_private.h                                                  |    4 
 net/bridge/netfilter/nft_meta_bridge.c                                   |    2 
 net/caif/cffrml.c                                                        |    9 
 net/ceph/osdmap.c                                                        |  116 +--
 net/core/dev.c                                                           |  162 +++-
 net/core/dev_ioctl.c                                                     |   16 
 net/core/filter.c                                                        |    9 
 net/core/page_pool.c                                                     |   27 
 net/ethtool/ioctl.c                                                      |   30 
 net/handshake/request.c                                                  |    8 
 net/hsr/hsr_forward.c                                                    |    2 
 net/ipv4/fib_trie.c                                                      |    7 
 net/ipv4/inet_hashtables.c                                               |    8 
 net/ipv4/ipcomp.c                                                        |    2 
 net/ipv4/netfilter/nft_dup_ipv4.c                                        |    4 
 net/ipv6/addrconf.c                                                      |   52 +
 net/ipv6/calipso.c                                                       |    3 
 net/ipv6/ip6_fib.c                                                       |   64 +
 net/ipv6/ip6_gre.c                                                       |    9 
 net/ipv6/ipcomp6.c                                                       |    2 
 net/ipv6/ndisc.c                                                         |   10 
 net/ipv6/netfilter/nft_dup_ipv6.c                                        |    4 
 net/ipv6/route.c                                                         |   14 
 net/ipv6/xfrm6_tunnel.c                                                  |    2 
 net/key/af_key.c                                                         |    2 
 net/mac80211/aes_cmac.c                                                  |   63 +
 net/mac80211/aes_cmac.h                                                  |    8 
 net/mac80211/cfg.c                                                       |   10 
 net/mac80211/drop.h                                                      |   33 
 net/mac80211/rx.c                                                        |   57 -
 net/mac80211/wep.c                                                       |    9 
 net/mac80211/wpa.c                                                       |   62 -
 net/mptcp/options.c                                                      |   10 
 net/mptcp/pm_netlink.c                                                   |    3 
 net/mptcp/protocol.c                                                     |   36 
 net/mptcp/protocol.h                                                     |    9 
 net/mptcp/subflow.c                                                      |   10 
 net/netfilter/ipvs/ip_vs_xmit.c                                          |    3 
 net/netfilter/nf_conncount.c                                             |  200 +++--
 net/netfilter/nf_tables_api.c                                            |   52 -
 net/netfilter/nft_bitwise.c                                              |    4 
 net/netfilter/nft_byteorder.c                                            |    2 
 net/netfilter/nft_cmp.c                                                  |    6 
 net/netfilter/nft_connlimit.c                                            |   34 
 net/netfilter/nft_ct.c                                                   |    2 
 net/netfilter/nft_dup_netdev.c                                           |    2 
 net/netfilter/nft_dynset.c                                               |    4 
 net/netfilter/nft_exthdr.c                                               |    2 
 net/netfilter/nft_flow_offload.c                                         |    9 
 net/netfilter/nft_fwd_netdev.c                                           |    6 
 net/netfilter/nft_hash.c                                                 |    2 
 net/netfilter/nft_lookup.c                                               |    2 
 net/netfilter/nft_masq.c                                                 |    4 
 net/netfilter/nft_meta.c                                                 |    2 
 net/netfilter/nft_nat.c                                                  |    8 
 net/netfilter/nft_objref.c                                               |    2 
 net/netfilter/nft_payload.c                                              |    2 
 net/netfilter/nft_queue.c                                                |    2 
 net/netfilter/nft_range.c                                                |    2 
 net/netfilter/nft_redir.c                                                |    4 
 net/netfilter/nft_tproxy.c                                               |    4 
 net/netfilter/xt_connlimit.c                                             |   14 
 net/netrom/nr_out.c                                                      |    4 
 net/nfc/core.c                                                           |    9 
 net/openvswitch/conntrack.c                                              |   16 
 net/openvswitch/flow_netlink.c                                           |   13 
 net/openvswitch/vport-netdev.c                                           |   17 
 net/rose/af_rose.c                                                       |    2 
 net/sched/sch_cake.c                                                     |   58 -
 net/sched/sch_ets.c                                                      |    6 
 net/sctp/socket.c                                                        |    5 
 net/socket.c                                                             |   19 
 net/sunrpc/auth_gss/svcauth_gss.c                                        |    3 
 net/sunrpc/xprtrdma/svc_rdma_rw.c                                        |    5 
 net/wireless/sme.c                                                       |    2 
 net/xfrm/xfrm_ipcomp.c                                                   |    1 
 net/xfrm/xfrm_state.c                                                    |  125 ++-
 net/xfrm/xfrm_user.c                                                     |    2 
 samples/ftrace/ftrace-direct-modify.c                                    |    8 
 samples/ftrace/ftrace-direct-multi-modify.c                              |    8 
 samples/ftrace/ftrace-direct-multi.c                                     |    4 
 samples/ftrace/ftrace-direct-too.c                                       |    4 
 samples/ftrace/ftrace-direct.c                                           |    4 
 samples/vfs/test-statx.c                                                 |    6 
 samples/watch_queue/watch_test.c                                         |    6 
 scripts/Makefile.modinst                                                 |    2 
 security/integrity/ima/ima_policy.c                                      |    2 
 security/keys/trusted-keys/trusted_tpm2.c                                |    6 
 security/smack/smack_lsm.c                                               |   41 -
 sound/firewire/dice/dice-extension.c                                     |    4 
 sound/firewire/motu/motu-hwdep.c                                         |    7 
 sound/isa/wavefront/wavefront.c                                          |   61 -
 sound/isa/wavefront/wavefront_fx.c                                       |   36 
 sound/isa/wavefront/wavefront_midi.c                                     |  148 +--
 sound/isa/wavefront/wavefront_synth.c                                    |  216 ++---
 sound/pci/hda/cs35l41_hda.c                                              |    2 
 sound/pcmcia/pdaudiocf/pdaudiocf.c                                       |    8 
 sound/pcmcia/vx/vxpocket.c                                               |    8 
 sound/soc/bcm/bcm63xx-pcm-whistler.c                                     |    4 
 sound/soc/codecs/ak4458.c                                                |   10 
 sound/soc/codecs/ak5558.c                                                |   10 
 sound/soc/fsl/fsl_xcvr.c                                                 |    2 
 sound/soc/intel/catpt/pcm.c                                              |    4 
 sound/soc/qcom/qdsp6/q6adm.c                                             |  146 +--
 sound/soc/qcom/qdsp6/q6apm-dai.c                                         |    2 
 sound/soc/qcom/qdsp6/q6asm-dai.c                                         |    7 
 sound/soc/stm/stm32_sai.c                                                |   14 
 sound/soc/stm/stm32_sai_sub.c                                            |   51 -
 sound/usb/mixer_us16x08.c                                                |   20 
 sound/usb/quirks.c                                                       |    6 
 tools/include/nolibc/stdio.h                                             |    4 
 tools/lib/perf/cpumap.c                                                  |   10 
 tools/mm/page_owner_sort.c                                               |    6 
 tools/objtool/check.c                                                    |    3 
 tools/objtool/elf.c                                                      |    8 
 tools/perf/builtin-record.c                                              |    2 
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c                    |   37 
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h                    |   26 
 tools/perf/util/bpf_lock_contention.c                                    |    6 
 tools/perf/util/maps.c                                                   |   13 
 tools/perf/util/maps.h                                                   |    2 
 tools/perf/util/symbol.c                                                 |    4 
 tools/testing/ktest/config-bisect.pl                                     |    4 
 tools/testing/nvdimm/test/nfit.c                                         |    7 
 tools/testing/radix-tree/idr-test.c                                      |   21 
 tools/testing/selftests/bpf/prog_tests/perf_branches.c                   |   22 
 tools/testing/selftests/bpf/prog_tests/send_signal.c                     |    5 
 tools/testing/selftests/bpf/progs/test_perf_branches.c                   |    3 
 tools/testing/selftests/drivers/net/bonding/Makefile                     |    2 
 tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh              |   99 --
 tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh       |   97 ++
 tools/testing/selftests/drivers/net/bonding/config                       |    9 
 tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc |    5 
 tools/testing/selftests/net/openvswitch/ovs-dpctl.py                     |   16 
 tools/testing/selftests/net/tap.c                                        |   16 
 754 files changed, 6961 insertions(+), 4355 deletions(-)

Abdun Nihaal (3):
      wifi: cw1200: Fix potential memory leak in cw1200_bh_rx_helper()
      wifi: rtl818x: Fix potential memory leaks in rtl8180_init_rx_ring()
      fbdev: ssd1307fb: fix potential page leak in ssd1307fb_probe()

Aboorva Devarajan (1):
      cpuidle: menu: Use residency threshold in polling state override decisions

Adrian Moreno (1):
      selftests: openvswitch: Fix escape chars in regexp.

Ahelenia Ziemiańska (1):
      power: supply: apm_power: only unset own apm_get_power_status

Akhil P Oommen (1):
      drm/msm/a6xx: Fix out of bound IO access in a6xx_get_gmu_registers

Al Viro (1):
      tracefs: fix a leak in eventfs_create_events_dir()

Alex Deucher (1):
      drm/amd/display: Use GFP_ATOMIC in dc_create_plane_state()

Alexander Dahl (1):
      net: phy: adin1100: Fix software power-down ready condition

Alexander Sverdlin (1):
      locking/spinlock/debug: Fix data-race in do_raw_write_lock

Alexandru Gagniuc (1):
      remoteproc: qcom_q6v5_wcss: fix parsing of qcom,halt-regs

Alexei Starovoitov (1):
      selftests/bpf: Fix failure paths in send_signal test

Alexey Kodanev (1):
      net: stmmac: fix rx limit check in stmmac_rx_zc()

Alexey Nepomnyashih (1):
      ext4: add i_data_sem protection in ext4_destroy_inline_data_nolock()

Alexey Simakov (3):
      dm-raid: fix possible NULL dereference with undefined raid type
      broadcom: b44: prevent uninitialized value usage
      hwmon: (tmp401) fix overflow caused by default conversion rate value

Alexey Velichayshiy (1):
      gfs2: fix freeze error handling

Alexis Lothoré (1):
      net: stmmac: make sure that ptp_rate is not 0 before configuring EST

Alice C. Munduruca (1):
      selftests: net: fix "buffer overflow detected" for tap.c

Alison Schofield (1):
      tools/testing/nvdimm: Use per-DIMM device handle

Alok Tiwari (4):
      virtio_vdpa: fix misleading return in void function
      vdpa/pds: use %pe for ERR_PTR() in event handler registration
      RDMA/bnxt_re: Fix incorrect BAR check in bnxt_qplib_map_creq_db()
      RDMA/bnxt_re: Fix IB_SEND_IP_CSUM handling in post_send

Aloka Dixit (1):
      wifi: mac80211: do not use old MBSSID elements

Alvaro Gamez Machado (1):
      spi: xilinx: increase number of retries before declaring stall

Amir Goldstein (1):
      fsnotify: do not generate ACCESS/MODIFY events on child for special files

Amitai Gottlieb (1):
      firmware: arm_scmi: Fix unused notifier-block in unregister

Andreas Gruenbacher (2):
      gfs2: fix remote evict for read-only filesystems
      gfs2: Fix use of bio_chain

Andres J Rosa (1):
      ALSA: uapi: Fix typo in asound.h comment

Andrew Jeffery (1):
      dt-bindings: mmc: sdhci-of-aspeed: Switch ref to sdhci-common.yaml

Andrew Morton (1):
      genalloc.h: fix htmldocs warning

Andrey Vatoropin (1):
      scsi: target: Reset t_task_cdb pointer in error case

Andy Shevchenko (5):
      lib/vsprintf: Check pointer before dereferencing in time_and_date()
      resource: Reuse for_each_resource() macro
      resource: replace open coded resource_intersection()
      resource: introduce is_type_match() helper and use it
      nfsd: Mark variable __maybe_unused to avoid W=1 build break

Anshumali Gaur (1):
      octeontx2-pf: fix "UBSAN: shift-out-of-bounds error"

Antheas Kapenekakis (2):
      platform/x86/amd: pmc: Add Lenovo Legion Go 2 to pmc quirk list
      platform/x86/amd/pmc: Add spurious_8042 to Xbox Ally

Anton Khirnov (1):
      platform/x86: asus-wmi: use brightness_set_blocking() for kbd led

Anurag Dutta (1):
      spi: cadence-quadspi: Fix clock disable on probe failure path

April Grimoire (1):
      HID: apple: Add SONiX AK870 PRO to non_apple_keyboards quirk list

Armin Wolf (3):
      platform/x86: acer-wmi: Ignore backlight event
      fs/nls: Fix utf16 to utf8 conversion
      fs/nls: Fix inconsistency between utf8_to_utf32() and utf32_to_utf8()

Aryan Srivastava (2):
      Revert "mtd: rawnand: marvell: fix layouts"
      mtd: nand: relax ECC parameter validation check

Askar Safin (1):
      gpiolib: acpi: Add quirk for Dell Precision 7780

Aurabindo Pillai (1):
      drm/amd/display: Fix null pointer deref in dcn20_resource.c

Bagas Sanjaya (2):
      Documentation: process: Also mention Sasha Levin as stable tree maintainer
      net: bridge: Describe @tunnel_hash member in net_bridge_vlan_group struct

Baochen Qiang (1):
      wifi: ath11k: fix peer HE MCS assignment

Baokun Li (1):
      ext4: align max orphan file size with e2fsprogs limit

Bart Van Assche (1):
      scsi: target: Do not write NUL characters into ASCII configfs output

Bartosz Golaszewski (1):
      platform/x86: intel: chtwc_int33fe: don't dereference swnode args

Bean Huo (1):
      scsi: ufs: core: fix incorrect buffer duplication in ufshcd_read_string_desc()

Ben Collins (1):
      powerpc/addnote: Fix overflow on 32-bit builds

Benjamin Berg (1):
      tools/nolibc/stdio: let perror work when NOLIBC_IGNORE_ERRNO is set

Benjamin Gaignard (2):
      media: verisilicon: Store chroma and motion vectors offset
      media: verisilicon: g2: Use common helpers to compute chroma and mv offsets

Benjamin Poirier (1):
      selftests: bonding: Add more missing config options

Bernd Schubert (2):
      fuse: Always flush the page cache before FOPEN_DIRECT_IO write
      fuse: Invalidate the page cache after FOPEN_DIRECT_IO write

Bijan Tabatabai (1):
      mm: consider non-anon swap cache folios in folio_expected_ref_count()

Brian Gerst (1):
      x86/xen: Move Xen upcall handler

Byungchul Park (1):
      jbd2: use a weaker annotation in journal handling

Caleb Sander Mateos (1):
      ublk: complete command synchronously on error

Cezary Rojewski (1):
      ASoC: Intel: catpt: Fix error path in hw_params()

Chao Yu (9):
      f2fs: fix to avoid updating zero-sized extent in extent cache
      f2fs: fix return value of f2fs_recover_fsync_data()
      f2fs: use f2fs_err_ratelimited() to avoid redundant logs
      f2fs: fix to avoid potential deadlock
      f2fs: remove unused GC_FAILURE_PIN
      f2fs: fix to avoid updating compression context during writeback
      f2fs: fix to propagate error from f2fs_enable_checkpoint()
      f2fs: use global inline_xattr_slab instead of per-sb slab cache
      f2fs: fix to detect recoverable inode during dryrun of find_fsync_dnodes()

Chen Changcheng (2):
      usb: usb-storage: No additional quirks need to be added to the EL-R12 optical drive.
      usb: usb-storage: Maintain minimal modifications to the bcdDevice range.

Chen Ridong (1):
      cpuset: Treat cpusets in attaching as populated

Chen-Yu Tsai (1):
      media: mediatek: vcodec: Use spinlock for context list protection lock

ChenXiaoSong (1):
      smb/server: fix return value of smb2_ioctl()

Chenghao Duan (2):
      samples/ftrace: Adjust LoongArch register restore order in direct calls
      LoongArch: Refactor register restoration in ftrace_common_return

Chia-Lin Kao (AceLan) (1):
      platform/x86/intel/hid: Add Dell Pro Rugged 10/12 tablet to VGBS DMI quirks

Chien Wong (1):
      wifi: mac80211: fix CMAC functions not handling errors

Chingbin Li (1):
      Bluetooth: btusb: Add new VID/PID 2b89/6275 for RTL8761BUV

Christian Hitz (3):
      leds: leds-lp50xx: Allow LED 0 to be added to module bank
      leds: leds-lp50xx: LP5009 supports 3 modules for a total of 9 LEDs
      leds: leds-lp50xx: Enable chip before any communication

Christoffer Sandberg (1):
      Input: i8042 - add TUXEDO InfinityBook Max Gen10 AMD to i8042 quirk table

Christoph Hellwig (2):
      iomap: factor out a iomap_dio_done helper
      iomap: always run error completions in user context

Christophe JAILLET (1):
      phy: renesas: rcar-gen3-usb2: Fix an error handling path in rcar_gen3_phy_usb2_probe()

Christophe Leroy (2):
      powerpc/32: Fix unpaired stwcx. on interrupt exit
      spi: fsl-cpm: Check length parity before switching to 16 bit mode

Chuck Lever (1):
      NFSD: Clear SECLABEL in the suppattr_exclcreat bitmap

Claudiu Beznea (3):
      clk: renesas: rzg2l: Simplify the logic in rzg2l_mod_clock_endisable()
      clk: renesas: rzg2l: Remove critical area
      clk: renesas: rzg2l: Use %x format specifier to print CLK_ON_R()

Colin Ian King (1):
      media: pvrusb2: Fix incorrect variable used in trace message

Cong Zhang (2):
      blk-mq: Abort suspend when wakeup events are pending
      blk-mq: skip CPU offline notify on unmapped hctx

Cryolitia PukNgae (1):
      ACPICA: Avoid walking the Namespace if start_node is NULL

Dai Ngo (1):
      NFSD: use correct reservation type in nfsd4_scsi_fence_client

Dan Carpenter (5):
      drm/amd/display: Fix logical vs bitwise bug in get_embedded_panel_info_v2_1()
      irqchip/mchp-eic: Fix error code in mchp_eic_domain_alloc()
      nfc: pn533: Fix error code in pn533_acr122_poweron_rdr()
      block: rnbd-clt: Fix signedness bug in init_dev()
      wifi: cfg80211: sme: store capped length in __cfg80211_connect_result()

Daniel Wagner (1):
      nvme-fc: don't hold rport lock when putting ctrl

Dapeng Mi (1):
      perf/x86/intel: Correct large PEBS flag check

Dave Kleikamp (1):
      dma/pool: eliminate alloc_pages warning in atomic_pool_expand

Dave Vasilevsky (1):
      powerpc, mm: Fix mprotect on book3s 32-bit

David Hildenbrand (5):
      powerpc/pseries/cmm: call balloon_devinfo_init() also without CONFIG_BALLOON_COMPACTION
      mm: simplify folio_expected_ref_count()
      mm/balloon_compaction: we cannot have isolated pages in the balloon list
      mm/balloon_compaction: convert balloon_page_delete() to balloon_page_finalize()
      powerpc/pseries/cmm: adjust BALLOON_MIGRATE when migrating pages

Deepakkumar Karn (1):
      net: usb: rtl8150: fix memory leak on usb_submit_urb() failure

Deepanshu Kartikey (5):
      ext4: refresh inline data size before write operations
      btrfs: fix memory leak of fs_devices in degraded seed device path
      f2fs: invalidate dentry cache on failed whiteout creation
      net: usb: asix: validate PHY address before use
      net: nfc: fix deadlock between nfc_unregister_device and rfkill_fop_write

Denis Arefev (1):
      ALSA: hda: cs35l41: Fix NULL pointer dereference in cs35l41_hda_read_acpi()

Dinh Nguyen (1):
      firmware: stratix10-svc: fix make htmldocs warning for stratix10_svc

Diogo Ivo (1):
      usb: phy: Initialize struct usb_phy list_head

Dmitry Antipov (2):
      ocfs2: relax BUG() to ocfs2_error() in __ocfs2_move_extent()
      ocfs2: fix memory leak in ocfs2_merge_rec_left()

Dmitry Baryshkov (3):
      interconnect: qcom: msm8996: add missing link to SLAVE_USB_HS
      arm64: dts: qcom: msm8996: add interconnect paths to USB2 controller
      drm/msm/a2xx: stop over-complaining about the legacy firmware

Dmitry Skorodumov (1):
      ipvlan: Ignore PACKET_LOOPBACK in handle_mode_l2()

Donet Tom (1):
      powerpc/64s/slb: Fix SLB multihit issue during SLB preload

Dong Chenchen (1):
      page_pool: Fix use-after-free in page_pool_recycle_in_ring

Dongli Zhang (1):
      KVM: nVMX: Immediately refresh APICv controls as needed on nested VM-Exit

Doug Berger (1):
      sched/deadline: only set free_cpus for online runqueues

Duoming Zhou (4):
      usb: phy: fsl-usb: Fix use-after-free in delayed work during device removal
      media: TDA1997x: Remove redundant cancel_delayed_work in probe
      media: i2c: ADV7604: Remove redundant cancel_delayed_work in probe
      media: i2c: adv7842: Remove redundant cancel_delayed_work in probe

Dylan Hatch (1):
      objtool: Fix standalone --hacks=jump_label

Edward Adam Davis (3):
      ntfs3: init run lock for extend inode
      fs/ntfs3: out1 also needs to put mi
      fs/ntfs3: Prevent memory leaks in add sub record

Encrow Thorne (1):
      reset: fix BIT macro reference

Eric Biggers (1):
      lib/crypto: x86/blake2s: Fix 32-bit arg treated as 64-bit

Eric Dumazet (2):
      ipv6: avoid possible NULL deref in modify_prefix_route()
      ip6_gre: make ip6gre_header() robust

Eric Sandeen (1):
      9p: fix cache/debug options printing in v9fs_show_options

Ethan Nelson-Moore (1):
      net: usb: sr9700: fix incorrect command used to write single register

Etienne Champetier (1):
      selftests: bonding: add ipvlan over bond testing

FUKAUMI Naoki (2):
      arm64: dts: rockchip: Move the EEPROM to correct I2C bus on Radxa ROCK 5A
      arm64: dts: rockchip: Add eeprom vcc-supply for Radxa ROCK 5A

Fabio Porcedda (2):
      USB: serial: option: add Telit Cinterion FE910C04 new compositions
      USB: serial: option: move Telit 0x10c7 composition in the right place

Fangyu Yu (1):
      RISC-V: KVM: Fix guest page fault within HLV* instructions

Fedor Pchelkin (1):
      ext4: fix string copying in parse_apply_sb_mount_options()

Fernand Sieber (1):
      sched/fair: Forfeit vruntime on yield

Fernando Fernandez Mancera (4):
      ipv6: clear RA flags when adding a static route
      netfilter: nf_conncount: rework API to use sk_buff directly
      netfilter: nft_connlimit: update the count if add was skipped
      netfilter: nf_conncount: fix leaked ct in error paths

Filipe Manana (3):
      btrfs: fix leaf leak in an error path in btrfs_del_items()
      btrfs: do not skip logging new dentries when logging a new name
      btrfs: don't log conflicting inode if it's a dir moved in the current transaction

Florian Westphal (3):
      netfilter: nf_tables: pass context structure to nft_parse_register_load
      netfilter: nf_tables: allow loads only when register is initialized
      xfrm: state: fix out-of-bounds read during lookup

Francesco Lavra (1):
      iio: imu: st_lsm6dsx: Fix measurement unit for odr struct member

Frank Li (1):
      i3c: fix refcount inconsistency in i3c_master_register

Gabor Juhos (1):
      regulator: core: disable supply if enabling main regulator fails

Gabriel Krisman Bertazi (1):
      ext4: fix error message when rejecting the default hash

Gal Pressman (1):
      ethtool: Avoid overflowing userspace buffer on stats query

Gautham R. Shenoy (1):
      cpufreq/amd-pstate: Call cppc_set_auto_sel() only for online CPUs

Geert Uytterhoeven (2):
      clk: renesas: Use str_on_off() helper
      PCI: rcar-gen2: Drop ARM dependency from PCI_RCAR_GEN2

George Kennedy (1):
      perf/x86/amd: Check event before enable to avoid GPF

Gergo Koteles (1):
      arm64: dts: qcom: sdm845-oneplus: Correct gpio used for slider

Gongwei Li (1):
      Bluetooth: btusb: Add new VID/PID 13d3/3533 for RTL8821CE

Gopi Krishna Menon (1):
      usb: raw-gadget: cap raw_io transfer length to KMALLOC_MAX_SIZE

Greg Kroah-Hartman (2):
      Revert "iommu/amd: Skip enabling command/event buffers for kdump"
      Linux 6.6.120

Guangshuo Li (2):
      crypto: caam - Add check for kcalloc() in test_len()
      e1000: fix OOB in e1000_tbi_should_accept()

Gui-Dong Han (3):
      hwmon: (max16065) Use local variable to avoid TOCTOU
      hwmon: (w83791d) Convert macros to functions to avoid TOCTOU
      hwmon: (w83l786ng) Convert macros to functions to avoid TOCTOU

Guido Günther (1):
      drm/panel: visionox-rm69299: Don't clear all mode flags

Gyeyoung Baek (1):
      genirq/irq_sim: Initialize work context pointers properly

H. Peter Anvin (1):
      compiler_types.h: add "auto" as a macro for "__auto_type"

Haibo Chen (1):
      ext4: clear i_state_flags when alloc inode

Hal Feng (1):
      cpufreq: dt-platdev: Add JH7110S SOC to the allowlist

Hangbin Liu (1):
      selftests: bonding: add delay before each xvlan_over_bond connectivity check

Hans de Goede (2):
      wifi: brcmfmac: Add DMI nvram filename quirk for Acer A1 840 tablet
      HID: logitech-dj: Remove duplicate error logging

Haotian Zhang (26):
      mtd: rawnand: lpc32xx_slc: fix GPIO descriptor leak on probe error and remove
      soc: qcom: smem: fix hwspinlock resource leak in probe error paths
      pinctrl: stm32: fix hwspinlock resource leak in probe function
      mfd: da9055: Fix missing regmap_del_irq_chip() in error path
      scsi: stex: Fix reboot_notifier leak in probe error path
      clk: renesas: r9a06g032: Fix memory leak in error path
      ACPI: property: Fix fwnode refcount leak in acpi_fwnode_graph_parse_endpoint()
      scsi: sim710: Fix resource leak by adding missing ioport_unmap() calls
      leds: netxbig: Fix GPIO descriptor leak in error paths
      watchdog: wdat_wdt: Fix ACPI table leak in probe function
      watchdog: starfive: Fix resource leak in probe error path
      mfd: mt6397-irq: Fix missing irq_domain_remove() in error path
      mfd: mt6358-irq: Fix missing irq_domain_remove() in error path
      crypto: starfive - Correctly handle return of sg_nents_for_len
      crypto: ccree - Correctly handle return of sg_nents_for_len
      hwmon: sy7636a: Fix regulator_enable resource leak on error path
      mtd: rawnand: renesas: Handle devm_pm_runtime_enable() errors
      pinctrl: single: Fix incorrect type for error return variable
      ASoC: bcm: bcm63xx-pcm-whistler: Check return value of of_dma_configure()
      rtc: gamecube: Check the return value of ioremap()
      dm log-writes: Add missing set_freezable() for freezable kthread
      ALSA: vxpocket: Fix resource leak in vxpocket_probe error path
      ALSA: pcmcia: Fix resource leak in snd_pdacf_probe error path
      media: rc: st_rc: Fix reset control resource leak
      media: cec: Fix debugfs leak on bus_register() failure
      media: videobuf2: Fix device reference leak in vb2_dc_alloc error path

Haotien Hsu (1):
      usb: gadget: tegra-xudc: Always reinitialize data toggle when clear halt

Haoxiang Li (6):
      MIPS: Fix a reference leak bug in ip22_check_gio()
      usb: renesas_usbhs: Fix a resource leak in usbhs_pipe_malloc()
      xfs: fix a memory leak in xfs_buf_item_init()
      media: mediatek: vcodec: Fix a reference leak in mtk_vcodec_fw_vpu_init()
      fjes: Add missing iounmap in fjes_hw_init()
      nfsd: Drop the client reference in client_states_open()

Hari Bathini (1):
      powerpc/64s/radix/kfence: map __kfence_pool at page granularity

Heiko Carstens (2):
      s390/smp: Fix fallback CPU detection
      s390/ap: Don't leak debug feature files if AP instructions are not available

Helge Deller (1):
      parisc: Do not reprogram affinitiy on ASP chip

Hengqi Chen (2):
      LoongArch: BPF: Zero-extend bpf_tail_call() index
      LoongArch: BPF: Sign extend kfunc call arguments

Herbert Xu (2):
      crypto: authenc - Correctly pass EINPROGRESS back up to the caller
      crypto: seqiv - Do not use req->iv after crypto_aead_encrypt

Honggang LI (1):
      RDMA/rtrs: Fix clt_path::max_pages_per_mr calculation

Hongyu Xie (1):
      usb: xhci: limit run_graceperiod for only usb 3.0 devices

Horatiu Vultur (1):
      phy: mscc: Fix PTP for VSC8574 and VSC8572

Huacai Chen (4):
      LoongArch: Mask all interrupts during kexec/kdump
      LoongArch: Add machine_kexec_mask_interrupts() implementation
      LoongArch: Add new PCI ID for pci_fixup_vgadev()
      LoongArch: Fix build errors for CONFIG_RANDSTRUCT

Ian Abbott (1):
      comedi: c6xdigio: Fix invalid PNP driver unregistration

Ian Forbes (1):
      drm/vmwgfx: Use kref in vmw_bo_dirty

Ian Rogers (2):
      perf maps: Add maps__load_first()
      libperf cpumap: Fix perf_cpu_map__max for an empty/NULL map

Ido Schimmel (4):
      mlxsw: spectrum_router: Fix possible neighbour reference count leak
      mlxsw: spectrum_router: Fix neighbour use-after-free
      mlxsw: spectrum_mr: Fix use-after-free when updating multicast route stats
      ipv4: Fix reference count leak when using error routes with nexthop objects

Ilias Stamatis (1):
      Reinstate "resource: avoid unnecessary lookups in find_next_iomem_res()"

Ilya Dryomov (1):
      libceph: make decode_pool() more resilient against corrupted osdmaps

Ilya Maximets (1):
      net: openvswitch: fix middle attribute validation in push_nsh() action

Israel Rukshin (1):
      nvme-auth: use kvfree() for memory allocated with kvcalloc()

Ivan Abramov (5):
      power: supply: cw2015: Check devm_delayed_work_autocancel() return code
      power: supply: rt9467: Return error on failure in rt9467_set_value_from_ranges()
      power: supply: wm831x: Check wm831x_set_bits() return value
      media: adv7842: Avoid possible out-of-bounds array accesses in adv7842_cp_log_status()
      media: msp3400: Avoid possible out-of-bounds array accesses in msp3400c_thread()

Ivan Stepchenko (1):
      mtd: lpddr_cmds: fix signed shifts in lpddr_cmds

Jacky Chou (1):
      net: mdio: aspeed: add dummy read to avoid read-after-write issue

Jacob Moroni (1):
      RDMA/irdma: Do not directly rely on IB_PD_UNSAFE_GLOBAL_RKEY

Jaegeuk Kim (2):
      f2fs: keep POSIX_FADV_NOREUSE ranges
      f2fs: drop inode from the donation list when the last file is closed

Jakub Kicinski (1):
      selftests: bonding: add missing build configs

Jamal Hadi Salim (1):
      net/sched: ets: Always remove class from active list before deleting in ets_qdisc_change

Jan Prusakowski (1):
      f2fs: ensure node page reads complete before f2fs_put_super() finishes

Jang Ingyu (1):
      RDMA/core: Fix logic error in ib_get_gids_from_rdma_hdr()

Janusz Krzysztofik (1):
      drm/vgem-fence: Fix potential deadlock on release

Jared Kangas (1):
      mmc: sdhci-esdhc-imx: add alternate ARCH_S32 dependency to Kconfig

Jarkko Nikula (1):
      i3c: master: Inherit DMA masks and parameters from parent device

Jarkko Sakkinen (2):
      KEYS: trusted: Fix a memory leak in tpm2_load_cmd
      tpm: Cap the number of PCR banks

Jason Gunthorpe (3):
      iommufd/selftest: Check for overflow in IOMMU_TEST_OP_ADD_RESERVED
      RDMA/core: Check for the presence of LS_NLA_TYPE_DGID correctly
      RDMA/cm: Fix leaking the multicast GID table reference

Jay Liu (1):
      drm/mediatek: Fix CCORR mtk_ctm_s31_32_to_s1_n function issue

Jens Axboe (1):
      io_uring/poll: correctly handle io_poll_add() return value on update

Jeongjun Park (2):
      media: dvb-usb: dtv5100: fix out-of-bounds in dtv5100_i2c_msg()
      media: vidtv: initialize local pointers upon transfer of memory ownership

Jia Ston (1):
      platform/x86: huawei-wmi: add keys for HONOR models

Jian Shen (3):
      net: hns3: using the num_tqps in the vf driver to apply for resources
      net: hns3: using the num_tqps to check whether tqp_index is out of range when vf get ring info from mbx
      net: hns3: add VLAN id validation before using

Jianglei Nie (1):
      staging: fbtft: core: fix potential memory leak in fbtft_probe_common()

Jihed Chaibi (3):
      ARM: dts: omap3: beagle-xm: Correct obsolete TWL4030 power compatible
      ARM: dts: omap3: n900: Correct obsolete TWL4030 power compatible
      ARM: dts: stm32: stm32mp157c-phycore: Fix STMPE811 touchscreen node properties

Jim Mattson (2):
      KVM: SVM: Mark VMCB_NPT as dirty on nested VMRUN
      KVM: SVM: Mark VMCB_PERM_MAP as dirty on nested VMRUN

Jim Quinlan (1):
      PCI: brcmstb: Fix disabling L0s capability

Jingbo Xu (2):
      mm: fix arithmetic for bdi min_ratio
      mm: fix arithmetic for max_prop_frac when setting max_ratio

Jinhui Guo (4):
      ipmi: Fix the race between __scan_channels() and deliver_response()
      ipmi: Fix __scan_channels() failing to rescan channels
      i2c: designware: Disable SMBus interrupts to prevent storms from mis-configured firmware
      iommu/amd: Fix pci_segment memleak in alloc_pci_segment()

Jiri Pirko (1):
      team: fix check for port enabled in team_queue_override_port_prio_changed()

Jiri Slaby (SUSE) (2):
      tty: introduce and use tty_port_tty_vhangup() helper
      tty: fix tty_port_tty_*hangup() kernel-doc

Jisheng Zhang (3):
      usb: dwc2: disable platform lowlevel hw resources during shutdown
      usb: dwc2: fix hang during shutdown if set as peripheral
      usb: dwc2: fix hang during suspend if set as peripheral

Joanne Koong (3):
      iomap: adjust read range correctly for non-block-aligned positions
      iomap: account for unaligned end offsets when truncating read range
      fuse: fix readahead reclaim deadlock

Johan Hovold (36):
      USB: serial: ftdi_sio: match on interface number for jtag
      USB: serial: belkin_sa: fix TIOCMBIS and TIOCMBIC
      USB: serial: kobil_sct: fix TIOCMBIS and TIOCMBIC
      irqchip/irq-bcm7038-l1: Fix section mismatch
      irqchip/irq-bcm7120-l2: Fix section mismatch
      irqchip/irq-brcmstb-l2: Fix section mismatch
      irqchip/imx-mu-msi: Fix section mismatch
      irqchip/qcom-irq-combiner: Fix section mismatch
      staging: most: remove broken i2c driver
      clk: keystone: fix compile testing
      phy: broadcom: bcm63xx-usbh: fix section mismatches
      usb: phy: isp1301: fix non-OF device reference imbalance
      amba: tegra-ahb: Fix device leak on SMMU enable
      soc: qcom: ocmem: fix device leak on lookup
      soc: amlogic: canvas: fix device leak on lookup
      iommu/mediatek: fix use-after-free on probe deferral
      ASoC: stm32: sai: fix device leak on probe
      ASoC: stm32: sai: fix clk prepare imbalance on probe failure
      ASoC: stm32: sai: fix OF node leak on probe
      iommu/apple-dart: fix device leak on of_xlate()
      iommu/exynos: fix device leak on of_xlate()
      iommu/ipmmu-vmsa: fix device leak on of_xlate()
      iommu/mediatek-v1: fix device leak on probe_device()
      iommu/mediatek-v1: fix device leaks on probe()
      iommu/mediatek: fix device leak on of_xlate()
      iommu/omap: fix device leaks on probe_device()
      iommu/qcom: fix device leak on of_xlate()
      iommu/sun50i: fix device leak on of_xlate()
      iommu/tegra: fix device leak on probe_device()
      mfd: altera-sysmgr: Fix device leak on sysmgr regmap lookup
      media: vpif_capture: fix section mismatch
      media: vpif_display: fix section mismatch
      usb: gadget: lpc32xx_udc: fix clock imbalance in error path
      usb: ohci-nxp: fix device leak on probe failure
      drm/mediatek: Fix probe memory leak
      drm/mediatek: Fix probe resource leaks

Johannes Berg (1):
      wifi: mac80211: remove RX_DROP_UNUSABLE

Jonas Gorski (1):
      net: dsa: b53: skip multicast entries for fdb_dump()

Jonathan Curley (1):
      NFSv4/pNFS: Clear NFS_INO_LAYOUTCOMMIT in pnfs_mark_layout_stateid_invalid

Jose Fernandez (1):
      bpf: Improve program stats run-time calculation

Josef Bacik (1):
      btrfs: don't rewrite ret from inode_permission

Josh Poimboeuf (1):
      objtool: Fix weak symbol detection

Joshua Rogers (3):
      svcrdma: return 0 on success from svc_rdma_copy_inline_range
      SUNRPC: svcauth_gss: avoid NULL deref on zero length gss_token in gss_read_proxy_verf
      svcrdma: bound check rq_pages index in inline path

Josua Mayer (1):
      clk: mvebu: cp110 add CLK_IGNORE_UNUSED to pcie_x10, pcie_x11 & pcie_x4

Jouni Malinen (1):
      wifi: mac80211: Discard Beacon frames to non-broadcast address

Juergen Gross (1):
      x86/xen: Fix sparse warning in enlighten_pv.c

Junjie Cao (1):
      Input: ti_am335x_tsc - fix off-by-one error in wire_order validation

Junrui Luo (10):
      ALSA: firewire-motu: fix buffer overflow in hwdep read for DSP events
      ALSA: firewire-motu: add bounds check in put_user loop for DSP events
      ALSA: dice: fix buffer overflow in detect_stream_formats()
      caif: fix integer underflow in cffrml_receive()
      hwmon: (ibmpex) fix use-after-free in high/low store
      scsi: aic94xx: fix use-after-free in device removal path
      platform/x86: ibm_rtl: fix EBDA signature search pointer arithmetic
      platform/x86: hp-bioscfg: Fix out-of-bounds array access in ACPI package parsing
      ALSA: wavefront: Fix integer overflow in sample size validation
      ALSA: wavefront: Clear substream pointers on close

Kalesh AP (1):
      RDMA/bnxt_re: Fix to use correct page size for PDE table

Karina Yankevich (1):
      ext4: xattr: fix null pointer deref in ext4_raw_inode()

Kaushlendra Kumar (1):
      tools/mm/page_owner_sort: fix timestamp comparison for stable sorting

Keith Busch (1):
      nvme: fix admin request_queue lifetime

Kemeng Shi (1):
      ext4: remove unused return value of __mb_check_buddy

Kevin Brodsky (1):
      ublk: prevent invalid access with DEBUG

Kohei Enju (1):
      iavf: fix off-by-one issues in iavf_config_rss_reg()

Konstantin Andreev (1):
      smack: fix bug: unprivileged task can create labels

Konstantin Komarov (2):
      fs/ntfs3: Support timestamps prior to epoch
      fs/ntfs3: fix mount failure for sparse runs in run_unpack()

Kory Maincent (TI.com) (1):
      drm/tilcdc: Fix removal actions in case of failed probe

Krzysztof Czurylo (2):
      RDMA/irdma: Fix data race in irdma_sc_ccq_arm
      RDMA/irdma: Fix data race in irdma_free_pble

Krzysztof Kozlowski (1):
      mfd: max77620: Fix potential IRQ chip conflict when probing two devices

Krzysztof Niemiec (1):
      drm/i915/gem: Zero-initialize the eb.vma array in i915_gem_do_execbuffer

Kuan-Wei Chiu (1):
      interconnect: debugfs: Fix incorrect error handling for NULL path

Kui-Feng Lee (1):
      net/ipv6: Remove expired routes with a separated list of routes.

Kuniyuki Iwashima (2):
      sctp: Defer SCTP_DBG_OBJCNT_DEC() to sctp_destroy_sock().
      mptcp: Initialise rcv_mss before calling tcp_send_active_reset() in mptcp_do_fastclose().

Laurent Pinchart (2):
      media: v4l2-mem2mem: Fix outdated documentation
      media: amphion: Make some vpu_v4l2 functions static

Leo Yan (5):
      coresight: etm4x: Correct polling IDLE bit
      coresight: etm4x: Extract the trace unit controlling
      coresight: etm4x: Add context synchronization before enabling trace
      perf arm-spe: Extend branch operations
      perf arm_spe: Fix memset subclass in operation

Leon Hwang (1):
      bpf: Free special fields when update [lru_,]percpu_hash maps

Li Chen (1):
      block: rate-limit capacity change info log

Li Qiang (2):
      uio: uio_fsl_elbc_gpcm:: Add null pointer check to uio_fsl_elbc_gpcm_probe
      via_wdt: fix critical boot hang due to unnamed resource allocation

Linus Torvalds (1):
      samples: work around glibc redefining some of our defines wrong

Liyuan Pang (1):
      ARM: 9464/1: fix input-only operand modification in load_unaligned_zeropad()

Lizhi Xu (2):
      usbip: Fix locking bug in RT-enabled kernels
      ext4: filesystems without casefold feature cannot be mounted with siphash

Long Li (1):
      macintosh/mac_hid: fix race condition in mac_hid_toggle_emumouse

Lu Baolu (1):
      iommu: disable SVA when CONFIG_X86 is set

Luca Ceresoli (1):
      backlight: led-bl: Add devlink to supplier LEDs

Luca Weiss (1):
      clk: qcom: camcc-sm6350: Fix PLL config of PLL2

Lukas Wunner (1):
      PCI/PM: Reinstate clearing state_saved in legacy and !PM codepaths

Lushih Hsieh (1):
      ALSA: usb-audio: Add native DSD quirks for PureAudio DAC series

Lyude Paul (1):
      drm/nouveau/dispnv50: Don't call drm_atomic_get_crtc_state() in prepare_fb

Ma Ke (4):
      RDMA/rtrs: server: Fix error handling in get_or_create_srv
      USB: lpc32xx_udc: Fix error handling in probe
      intel_th: Fix error handling in intel_th_output_open
      i2c: amd-mp2: fix reference leak in MP2 PCI device

Maciej Wieczor-Retman (1):
      kasan: refactor pcpu kasan vmalloc unpoison

Magne Bruno (1):
      serial: add support of CPCI cards

Mahesh Rao (1):
      firmware: stratix10-svc: Add mutex in stratix10 memory management

Mainak Sen (1):
      gpu: host1x: Fix race in syncpt alloc/free

Manivannan Sadhasivam (1):
      dt-bindings: PCI: amlogic: Fix the register name of the DBI region

Marc Kleine-Budde (1):
      can: gs_usb: gs_can_open(): fix error handling

Marek Szyprowski (5):
      ARM: dts: samsung: universal_c210: turn off SDIO WLAN chip during system suspend
      ARM: dts: samsung: exynos4210-i9100: turn off SDIO WLAN chip during system suspend
      ARM: dts: samsung: exynos4210-trats: turn off SDIO WLAN chip during system suspend
      ARM: dts: samsung: exynos4412-midas: turn off SDIO WLAN chip during system suspend
      media: samsung: exynos4-is: fix potential ABBA deadlock on init

Marek Vasut (2):
      clk: renesas: cpg-mssr: Add missing 1ms delay into reset toggle callback
      clk: renesas: cpg-mssr: Read back reset registers to assure values latched

Marijn Suijten (1):
      drm/panel: sony-td4353-jdi: Enable prepare_prev_first

Mario Limonciello (AMD) (1):
      HID: hid-input: Extend Elan ignore battery quirk to USB

Mark Pearson (1):
      usb: typec: ucsi: Handle incorrect num_connectors capability

Martin KaFai Lau (1):
      bpf: Check skb->transport_header is set in bpf_skb_check_mtu

Matt Bobrowski (2):
      selftests/bpf: skip test_perf_branches_hw() on unsupported platforms
      selftests/bpf: Improve reliability of test_perf_branches_no_hw()

Matthew Wilcox (Oracle) (2):
      ntfs: Do not overwrite uptodate pages
      idr: fix idr_alloc() returning an ID out of range

Matthias Schiffer (1):
      ti-sysc: allow OMAP2 and OMAP4 timers to be reserved on AM33xx

Matthieu Baerts (NGI0) (1):
      mptcp: pm: ignore unknown endpoint flags

Matthijs Kooijman (1):
      pinctrl: single: Fix PIN_CONFIG_BIAS_DISABLE handling

Mauro Carvalho Chehab (3):
      efi/cper: Add a new helper function to print bitmasks
      efi/cper: Adjust infopfx size to accept an extra space
      efi/cper: align ARM CPER type with UEFI 2.9A/2.10 specs

Mavroudis Chatzilazaridis (1):
      HID: logitech-hidpp: Do not assume FAP in hidpp_send_message_sync()

Max Chou (1):
      Bluetooth: btrtl: Avoid loading the config file on security chips

Maxim Levitsky (1):
      KVM: x86: Don't clear async #PF queue when CR0.PG is disabled (e.g. on #SMI)

Maximilian Immanuel Brandtner (1):
      virtio_console: fix order of fields cols and rows

Menglong Dong (1):
      bpf: Handle return value of ftrace_set_filter_ip in register_fentry

Miaoqian Lin (5):
      usb: dwc3: of-simple: fix clock resource leak in dwc3_of_simple_probe
      cpufreq: nforce2: fix reference count leak in nforce2
      media: renesas: rcar_drif: fix device node reference leak in rcar_drif_bond_enabled
      drm/mediatek: Fix device node reference leak in mtk_dp_dt_parse()
      net: phy: mediatek: fix nvmem cell reference leak in mt798x_phy_calibration

Michael Margolin (1):
      RDMA/efa: Remove possible negative shift

Michael S. Tsirkin (3):
      virtio: fix typo in virtio_device_ready() comment
      virtio: fix whitespace in virtio_config_ops
      virtio: fix virtqueue_set_affinity() docs

Michal Pecio (1):
      usb: xhci: Apply the link chain quirk on NEC isoc endpoints

Michal Schmidt (1):
      RDMA/irdma: avoid invalid read in irdma_net_event

Mike McGowen (1):
      scsi: smartpqi: Fix device resources accessed after device removal

Mikhail Malyshev (1):
      kbuild: Use objtree for module signing key path

Mikulas Patocka (1):
      dm-bufio: align write boundary on physical block size

Ming Lei (4):
      ublk: make sure io cmd handled in submitter task context
      blk-mq: don't schedule block kworker on isolated CPUs
      blk-mq: add helper for checking if one CPU is mapped to specified hctx
      blk-mq: setup queue ->tag_set before initializing hctx

Ming Qian (3):
      media: amphion: Cancel message work before releasing the VPU core
      media: amphion: Add a frame flush mode for decoder
      media: amphion: Remove vpu_vb_is_codecconfig

Mohamed Khalfella (1):
      block: Use RCU in blk_mq_[un]quiesce_tagset() instead of set->tag_list_lock

Moshe Shemesh (3):
      net/mlx5: fw reset, clear reset requested on drain_fw_reset
      net/mlx5: Drain firmware reset in shutdown callback
      net/mlx5: Skip HotPlug check on sync reset using hot reset

Murad Masimov (1):
      power: supply: rt9467: Prevent using uninitialized local variable in rt9467_set_value_from_ranges()

Namhyung Kim (2):
      perf lock contention: Load kernel map before lookup
      perf tools: Fix split kallsyms DSO counting

Namjae Jeon (3):
      ksmbd: fix use-after-free in ksmbd_tree_connect_put under concurrency
      ksmbd: Fix refcount leak when invalid session is found on session lookup
      ksmbd: fix buffer validation by including null terminator size in EA length

Naoki Ueki (1):
      HID: elecom: Add support for ELECOM M-XT3URBK (018F)

Natalie Vock (1):
      drm/amdgpu: Forward VMID reservation errors

Nathan Chancellor (1):
      clk: samsung: exynos-clkout: Assign .num before accessing .hws

Navaneeth K (3):
      staging: rtl8723bs: fix out-of-bounds read in rtw_get_ie() parser
      staging: rtl8723bs: fix stack buffer overflow in OnAssocReq IE parsing
      staging: rtl8723bs: fix out-of-bounds read in OnBeacon ESR IE parsing

NeilBrown (1):
      lockd: fix vfs_test_lock() calls

Nicolas Dufresne (2):
      media: verisilicon: Protect G2 HEVC decoder against invalid DPB index
      media: verisilicon: Fix CPU stalls on G2 bus error

Nicolas Ferre (2):
      ARM: dts: microchip: sama5d2: fix spi flexcom fifo size to 32
      ARM: dts: microchip: sama7g5: fix uart fifo size to 32

Nikita Zhandarovich (3):
      comedi: pcl818: fix null-ptr-deref in pcl818_ai_cancel()
      comedi: multiq3: sanitize config options in multiq3_attach()
      comedi: check device's attached status in compat ioctls

Niklas Neronin (1):
      usb: xhci: move link chain bit quirk checks into one helper function.

Nikolay Kuratov (1):
      drm/msm/dpu: Add missing NULL pointer check for pingpong interface

Nysal Jan K.A. (1):
      powerpc/kexec: Enable SMT before waking offline CPUs

Oliver Neukum (1):
      usb: chaoskey: fix locking for O_NONBLOCK

Omar Sandoval (1):
      KVM: SVM: Don't skip unrelated instruction if INT3/INTO is replaced

Ondrej Mosnacek (1):
      bpf, arm64: Do not audit capability check in do_jit()

Pablo Neira Ayuso (2):
      netfilter: flowtable: check for maximum number of encapsulations in bridge vlan
      netfilter: nf_tables: remove redundant chain validation on register store

Paolo Abeni (4):
      mptcp: schedule rtx timer only after pushing data
      mptcp: avoid deadlock on fallback while reinjecting
      mptcp: fallback earlier on simult connection
      mptcp: ensure context reset on disconnect()

Pedro Demarchi Gomes (1):
      ntfs: set dummy blocksize to read boot_block when mounting

Pei Xiao (1):
      iio: adc: ti_am335x_adc: Limit step_avg to valid range for gcc complains

Peng Fan (2):
      firmware: imx: scu-irq: fix OF node leak in
      firmware: imx: scu-irq: Init workqueue before request mbox channel

Pengjie Zhang (2):
      ACPI: PCC: Fix race condition by removing static qualifier
      ACPI: CPPC: Fix missing PCC check for guaranteed_perf

Peter Zijlstra (5):
      task_work: Fix NMI race condition
      sched/fair: Revert max_newidle_lb_cost bump
      x86/ptrace: Always inline trivial accessors
      sched/fair: Small cleanup to sched_balance_newidle()
      sched/fair: Small cleanup to update_newidle_cost()

Peter Zijlstra (Intel) (1):
      sched/fair: Proportional newidle balance

Philipp Stanner (1):
      drm/tilcdc: request and mapp iomem with devres

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: add missing lock to amdgpu_ttm_access_memory_sdma

Ping Cheng (1):
      HID: input: map HID_GD_Z to ABS_DISTANCE for stylus/pen

Ping-Ke Shih (1):
      wifi: rtw88: limit indirect IO under powered off for RTL8822CS

Praveen Talari (1):
      pinctrl: qcom: msm: Fix deadlock in pinmux configuration

Prithvi Tambewagh (2):
      io_uring: fix filename leak in __io_openat_prep()
      ocfs2: fix kernel BUG in ocfs2_find_victim_chain

Przemyslaw Korba (1):
      i40e: fix scheduling in set_rx_mode

Pu Lehui (1):
      bpf: Fix invalid prog->stats access when update_effective_progs fails

Pwnverse (1):
      net: rose: fix invalid array index in rose_kill_by_device()

Qianchang Zhao (3):
      ksmbd: ipc: fix use-after-free in ipc_msg_send_request
      ksmbd: vfs: fix race on m_flags in vfs_cache
      ksmbd: skip lock-range check on equal size to avoid size==0 underflow

Qiang Ma (1):
      LoongArch: Correct the calculation logic of thread_count

Qu Wenruo (2):
      btrfs: fix a potential path leak in print_data_reloc_error()
      btrfs: scrub: always update btrfs_scrub_progress::last_physical

Rafael J. Wysocki (2):
      cpuidle: governors: teo: Drop misguided target residency check
      PM: runtime: Do not clear needs_force_resume with enabled runtime PM

Raju Rangoju (1):
      amd-xgbe: reset retries and mode on RX adapt failures

Randolph Sapp (1):
      arm64: dts: ti: k3-am62p: Fix memory ranges for GPU

Randy Dunlap (1):
      backlight: lp855x: Fix lp855x.h kernel-doc warnings

Raphael Pinsonneault-Thibeault (2):
      ntfs3: fix uninit memory after failed mi_read in mi_format_new
      Bluetooth: btusb: revert use of devm_kzalloc in btusb

Rene Rebe (3):
      ps3disk: use memcpy_{from,to}_bvec index
      floppy: fix for PAGE_SIZE != 4KB
      fbdev: gbefb: fix to use physical address instead of dma address

René Rebe (4):
      ACPI: processor_core: fix map_x2apic_id for amd-pstate on am4
      r8169: fix RTL8117 Wake-on-Lan in DASH mode
      fbdev: tcx.c fix mem_map to correct smem_start offset
      drm/mgag200: Fix big-endian support

Ria Thomas (1):
      wifi: ieee80211: correct FILS status codes

Ritesh Harjani (IBM) (2):
      powerpc/64s/hash: Restrict stress_hpt_struct memblock region to within RMA limit
      powerpc/64s/ptdump: Fix kernel_hash_pagetable dump for ISA v3.00 HPTE format

Rob Herring (1):
      pmdomain: Use device_get_match_data()

Robin Gong (1):
      spi: imx: keep dma request disabled before dma transfer setup

Rong Zhang (1):
      x86/microcode/AMD: Fix Entrysign revision check for Zen5/Strix Halo

Sabrina Dubroca (4):
      xfrm: delete x->tunnel as we delete x
      Revert "xfrm: destroy xfrm_state synchronously on net exit path"
      xfrm: also call xfrm_state_delete_tunnel at destroy time for states that were never added
      xfrm: flush all states in xfrm_state_fini

Sakari Ailus (1):
      ACPI: property: Use ACPI functions in acpi_graph_get_next_endpoint() only

Sarthak Garg (1):
      mmc: sdhci-msm: Avoid early clock doubling during HS400 transition

Scott Mayhew (1):
      net/handshake: duplicate handshake cancellations leak socket

Sean Christopherson (3):
      KVM: x86: WARN if hrtimer callback for periodic APIC timer fires with period=0
      KVM: nSVM: Set exit_code_hi to -1 when synthesizing SVM_EXIT_ERR (failed VMRUN)
      KVM: nSVM: Clear exit_code_hi in VMCB when synthesizing nested VM-Exits

Sean Nyekjaer (1):
      pwm: stm32: Always program polarity

Sebastian Andrzej Siewior (2):
      net: Remove conditional threaded-NAPI wakeup based on task state.
      net: Allow to use SMP threads for backlog NAPI.

Selvin Xavier (1):
      RDMA/bnxt_re: Fix the inline size for GenP7 devices

SeongJae Park (16):
      mm/damon/tests/vaddr-kunit: handle alloc failures in damon_test_split_evenly_fail()
      mm/damon/tests/vaddr-kunit: handle alloc failures on damon_do_test_apply_three_regions()
      mm/damon/tests/vaddr-kunit: handle alloc failures on damon_test_split_evenly_succ()
      mm/damon/tests/core-kunit: handle alloc failres in damon_test_new_filter()
      mm/damon/tests/core-kunit: handle allocation failures in damon_test_regions()
      mm/damon/tests/core-kunit: handle alloc failures on damon_test_split_at()
      mm/damon/tests/core-kunit: handle alloc failures on dasmon_test_merge_regions_of()
      mm/damon/tests/core-kunit: handle alloc failures on damon_test_merge_two()
      mm/damon/tests/core-kunit: handle memory failure from damon_test_target()
      mm/damon/tests/core-kunit: handle alloc failures on damon_test_split_regions_of()
      mm/damon/tests/core-kunit: handle memory alloc failure from damon_test_aggregate()
      mm/damon/tests/core-kunit: handle alloc failures on damos_test_filter_out()
      mm/damon/tests/core-kunit: handle alloc failures in damon_test_set_regions()
      mm/damon/tests/core-kunit: handle alloc failures in damon_test_ops_registration()
      mm/damon/tests/core-kunit: handle alloc failure on damon_test_set_attrs()
      mm/damon/tests/core-kunit: handle alloc failures in damon_test_update_monitoring_result()

Sergey Bashirov (1):
      NFSD/blocklayout: Fix minlength check in proc_layoutget

Seunghwan Baek (1):
      scsi: ufs: core: Add ufshcd_update_evt_hist() for UFS suspend error

Seungjin Bae (2):
      USB: Fix descriptor count when handling invalid MBIM extended descriptor
      wifi: rtl818x: rtl8187: Fix potential buffer underflow in rtl8187_rx_cb()

Shaurya Rane (1):
      net/hsr: fix NULL pointer dereference in prp_get_untagged_frame()

Shawn Lin (1):
      PCI: dwc: Fix wrong PORT_LOGIC_LTSSM_STATE_MASK definition

Shay Drory (3):
      net/mlx5: fw_tracer, Validate format string parameters
      net/mlx5: fw_tracer, Handle escaped percent properly
      net/mlx5: Serialize firmware reset with devlink

Shengjiu Wang (3):
      ASoC: fsl_xcvr: clear the channel status control memory
      ASoC: ak4458: Disable regulator when error happens
      ASoC: ak5558: Disable regulator when error happens

Shipei Qu (1):
      ALSA: usb-mixer: us16x08: validate meter packet indices

Shivani Agarwal (1):
      crypto: af_alg - zero initialize memory allocated via sock_kmalloc

Shuai Xue (1):
      perf record: skip synthesize event when open evsel failed

Shuhao Fu (1):
      cpufreq: s5pv210: fix refcount leak

Siddharth Vadapalli (2):
      PCI: keystone: Exit ks_pcie_probe() for invalid mode
      arm64: dts: ti: k3-j721e-sk: Fix pinmux for pin Y1 used by power regulator

Sidharth Seela (1):
      ntfs3: Fix uninit buffer allocated by __getname()

Simon Richter (1):
      drm/ttm: Avoid NULL pointer deref for evicted BOs

Sindhu Devale (1):
      RDMA/irdma: Add support to re-register a memory region

Slark Xiao (1):
      USB: serial: option: add Foxconn T99W760

Slavin Liu (1):
      ipvs: fix ipv4 null-ptr-deref in route error path

Song Liu (2):
      ftrace: bpf: Fix IPMODIFY + DIRECT in modify_ftrace_direct()
      livepatch: Match old_sympos 0 and 1 in klp_find_func()

Srinivas Kandagatla (5):
      rpmsg: glink: fix rpmsg device leak
      ASoC: qcom: q6apm-dai: set flags to reflect correct operation of appl_ptr
      ASoC: qcom: q6asm-dai: perform correct state check before closing
      ASoC: qcom: q6adm: the the copp device only during last instance
      ASoC: qcom: qdsp6: q6asm-dai: set 10 ms period and buffer alignment.

Stanley Chu (1):
      i3c: master: svc: Prevent incomplete IBI transaction

Stefan Haberland (1):
      s390/dasd: Fix gendisk parent after copy pair swap

Stefan Kalscheuer (1):
      leds: spi-byte: Use devm_led_classdev_register_ext()

Stefano Garzarella (1):
      vhost/vsock: improve RCU read sections around vhost_vsock_get()

Stephan Gerhold (1):
      iommu/arm-smmu-qcom: Enable use of all SMR groups when running bare-metal

Steven Rostedt (3):
      ktest.pl: Fix uninitialized var in config-bisect.pl
      tracing: Do not register unsupported perf events
      tracing: Fix fixed array of synthetic event

Sven Eckelmann (Plasma Cloud) (1):
      wifi: mt76: Fix DTS power-limits on little endian systems

Sven Schnelle (3):
      s390/ipl: Clear SBP flag when bootprog is set
      parisc: entry.S: fix space adjustment on interruption for 64-bit userspace
      parisc: entry: set W bit for !compat tasks in syscall_restore_rfi()

Takashi Iwai (2):
      ALSA: wavefront: Use standard print API
      ALSA: wavefront: Use guard() for spin locks

Tengda Wu (1):
      x86/dumpstack: Prevent KASAN false positive warnings in __show_regs()

Tetsuo Handa (3):
      bfs: Reconstruct file type when loading from disk
      hfsplus: Verify inode mode when loading from disk
      jbd2: use a per-journal lock_class_key for jbd2_trans_commit_key

Thadeu Lima de Souza Cascardo (1):
      net: Remove RTNL dance for SIOCBRADDIF and SIOCBRDELIF.

Thangaraj Samynathan (1):
      net: lan743x: Allocate rings outside ZONE_DMA

Thierry Bultel (1):
      clk: renesas: Pass sub struct of cpg_mssr_priv to cpg_clk_register

Thomas Fourier (4):
      block: rnbd-clt: Fix leaked ID in init_dev()
      platform/x86: msi-laptop: add missing sysfs_remove_group()
      firewire: nosy: Fix dma_free_coherent() size
      RDMA/bnxt_re: fix dma_free_coherent() pointer

Thomas Zimmermann (1):
      drm/gma500: Remove unused helper psb_fbdev_fb_setcolreg()

Thorsten Blum (2):
      crypto: asymmetric_keys - prevent overflow in asymmetric_key_generate_id
      fbdev: pxafb: Fix multiple clamped values in pxafb_adjust_timing

Tianchu Chen (1):
      char: applicom: fix NULL pointer dereference in ac_ioctl

Tiezhu Yang (1):
      LoongArch: Use unsigned long for _end and _text

Tim Harvey (4):
      arm64: dts: freescale: imx8mp-venice-gw7905-2x: remove duplicate usdhc1 props
      arm64: dts: imx8mm-venice-gw72xx: remove unused sdhc1 pinctrl
      arm64: dts: imx8mp-venice-gw702x: remove off-board uart
      arm64: dts: imx8mp-venice-gw702x: remove off-board sdhc1

Timur Tabi (1):
      drm/nouveau: restrict the flush page to a 32-bit address

Tingmao Wang (1):
      fs/9p: Don't open remote file with APPEND mode when writeback cache is used

Toke Høiland-Jørgensen (1):
      net: openvswitch: Avoid needlessly taking the RTNL on vport destroy

Tony Battersby (4):
      scsi: qla2xxx: Fix lost interrupts with qlini_mode=disabled
      scsi: qla2xxx: Fix initiator mode with qlini_mode=exclusive
      scsi: qla2xxx: Use reinit_completion on mbx_intr_comp
      scsi: Revert "scsi: qla2xxx: Perform lockless command completion in abort path"

Trond Myklebust (9):
      NFS: Avoid changing nlink when file removes and attribute updates race
      NFS: Initialise verifiers for visible dentries in readdir and lookup
      NFS: Initialise verifiers for visible dentries in nfs_atomic_open()
      Revert "nfs: ignore SB_RDONLY when remounting nfs"
      Revert "nfs: clear SB_RDONLY before getting superblock"
      Revert "nfs: ignore SB_RDONLY when mounting nfs"
      NFS: Automounted filesystems should inherit ro,noexec,nodev,sync flags
      Expand the type of nfs_fattr->valid
      NFS: Fix inheritance of the block sizes when automounting

Tzung-Bi Shih (1):
      platform/chrome: cros_ec_ishtp: Fix UAF after unbinding driver

Udipto Goswami (1):
      usb: dwc3: keep susphy enabled during exit to avoid controller faults

Uladzislau Rezki (Sony) (1):
      dm-ebs: Mark full buffer dirty even on partial write

Usama Arif (2):
      x86/boot: Fix page table access in 5-level to 4-level paging transition
      efi/libstub: Fix page table access in 5-level to 4-level paging transition

Uwe Kleine-König (2):
      staging: most: i2c: Drop explicit initialization of struct i2c_device_id::driver_data to 0
      pwm: bcm2835: Make sure the channel is enabled after pwm_request()

Viacheslav Dubeyko (2):
      hfsplus: fix volume corruption issue for generic/070
      hfsplus: fix volume corruption issue for generic/073

Victor Nogueira (1):
      net/sched: ets: Remove drr class from the active list if it changes to strict

Vishwaroop A (1):
      spi: tegra210-quad: Fix timeout handling

Vladimir Oltean (1):
      net: dsa: sja1105: fix kasan out-of-bounds warning in sja1105_table_delete_entry()

Vladimir Zapolskiy (1):
      clk: qcom: camcc-sm6350: Specify Titan GDSC power domain as a parent to other

Wang Liang (1):
      netrom: Fix memory leak in nr_sendmsg()

WangYuli (1):
      LoongArch: Use __pmd()/__pte() for swap entry conversions

Wei Fang (3):
      net: fec: ERR007885 Workaround for XDP TX path
      net: enetc: do not transmit redirected XDP frames when the link is down
      net: stmmac: fix the crash issue for zero copy XDP_TX action

Wenhua Lin (1):
      serial: sprd: Return -EPROBE_DEFER when uart clock is not ready

Wentao Guan (1):
      gpio: regmap: Fix memleak in error path in gpio_regmap_register()

Wentao Liang (1):
      pmdomain: imx: Fix reference count leak in imx_gpc_probe()

Will Rosenberg (1):
      ipv6: BUG() in pskb_expand_head() as part of calipso_skbuff_setattr()

Wolfram Sang (2):
      ARM: dts: renesas: gose: Remove superfluous port property
      ARM: dts: renesas: r9a06g032-rzn1d400-db: Drop invalid #cells properties

Xiang Mei (1):
      net/sched: sch_cake: Fix incorrect qlen reduction in cake_drop

Xiaole He (1):
      f2fs: fix age extent cache insertion skip on counter overflow

Xiaolei Wang (1):
      net: macb: Relocate mog_init_rings() callback from macb_mac_link_up() to macb_open()

Xin Long (1):
      ipv6: add exception routes to GC list in rt6_insert_exception

Xuanqiang Luo (2):
      rculist: Add hlist_nulls_replace_rcu() and hlist_nulls_replace_init_rcu()
      inet: Avoid ehash lookup race in inet_ehash_insert()

Yang Chenzhi (1):
      hfsplus: fix missing hfs_bnode_get() in __hfs_bnode_create

Ye Bin (4):
      jbd2: avoid bug_on in jbd2_journal_get_create_access() when file system corrupted
      jbd2: fix the inconsistency between checksum and data in memory for journal sb
      ext4: introduce ITAIL helper
      ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()

Yegor Yefremov (1):
      ARM: dts: am335x-netcom-plus-2xx: add missing GPIO labels

Yeoreum Yun (1):
      smc91x: fix broken irq-context in PREEMPT_RT

Yipeng Zou (1):
      selftests/ftrace: traceonoff_triggers: strip off names

Yiqi Sun (1):
      smb: fix invalid username check in smb3_fs_context_parse_param()

Yongjian Sun (2):
      ext4: improve integrity checking in __mb_check_buddy by enhancing order-0 validation
      ext4: fix incorrect group number assertion in mb_check_buddy

Yosry Ahmed (6):
      KVM: nSVM: Avoid incorrect injection of SVM_EXIT_CR0_SEL_WRITE
      KVM: nSVM: Propagate SVM_EXIT_CR0_SEL_WRITE correctly for LMSW emulation
      KVM: SVM: Introduce svm_recalc_lbr_msr_intercepts()
      KVM: nSVM: Always recalculate LBR MSR intercepts in svm_update_lbrv()
      KVM: nSVM: Fix and simplify LBR virtualization handling with nested
      KVM: SVM: Fix redundant updates of LBR MSR intercepts

Yu Kuai (1):
      md/raid5: fix IO hang when array is broken with IO inflight

Yuezhang Mo (1):
      exfat: fix remount failure in different process environments

Zenm Chen (1):
      wifi: rtw88: Add USB ID 2001:3329 for D-Link AC13U rev. A1

Zhang Yi (1):
      ext4: correct the checking of quota files before moving extents

Zhang Zekun (1):
      usb: ohci-nxp: Use helper function devm_clk_get_enabled()

Zhao Yipeng (1):
      ima: Handle error code returned by ima_filter_rule_match()

Zheng Qixing (2):
      nbd: defer config put in recv_work
      nbd: defer config unlock in nbd_genl_connect

Zheng Yejian (1):
      kallsyms: Fix wrong "big" kernel symbol type read from procfs

Zhichi Lin (1):
      scs: fix a wrong parameter in __scs_magic

Zhu Yanjun (4):
      RDMA/rxe: Fix null deref on srq->rq.queue after resize failure
      RDMA/core: Fix "KASAN: slab-use-after-free Read in ib_register_device" problem
      RDMA/rxe: Remove the direct link to net_device
      RDMA/rxe: Fix the failure of ibv_query_device() and ibv_query_device_ex() tests

Zilin Guan (4):
      scsi: qla2xxx: Fix improper freeing of purex item
      mt76: mt7615: Fix memory leak in mt7615_mcu_wtbl_sta_add()
      cifs: Fix memory and information leak in smb3_reconfigure()
      ksmbd: Fix memory leak in get_file_all_info()

caoping (1):
      net/handshake: restore destructor on submit failure

fuqiang wang (2):
      KVM: x86: Explicitly set new periodic hrtimer expiration in apic_timer_fn()
      KVM: x86: Fix VM hard lockup after prolonged inactivity with periodic HV timer

nieweiqiang (1):
      crypto: hisilicon/qm - restore original qos values

shechenglong (1):
      block: fix comment for op_is_zone_mgmt() to include RESET_ALL

sparkhuang (1):
      regulator: core: Protect regulator_supply_alias_list with regulator_list_mutex

xu xin (1):
      mm/ksm: fix exec/fork inheritance support for prctl

Łukasz Bartosik (1):
      xhci: dbgtty: fix device unregister: fixup


