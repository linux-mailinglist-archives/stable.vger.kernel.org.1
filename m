Return-Path: <stable+bounces-206291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7468DD03A56
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A5F030141CF
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 14:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562DF3D34BC;
	Thu,  8 Jan 2026 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="On1AcKDG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275CC3A0E9C;
	Thu,  8 Jan 2026 09:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767865839; cv=none; b=OVm2KbNsXXEwvVCS3CFo4eSlQLI4z6ZQJF9KRdnE0lxyarjFZkgZljy9lDUqjto4NR2Lo0boC/p86QUoH7OpqFmOqhTAoIYmKpmsurJz/bzV2zterRSfnCD1EzcJVR+Tjc93CU8wjYMAol+WzJZbWj71CU5MDEJKJWsbdbBUqyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767865839; c=relaxed/simple;
	bh=tOF5vm2/fzd9Nair/gZvuxW93ciHRl5l/d/srZZfsbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B1HDa9PZRVrSSsQp7XeItmHL8OaMHhPxM0yKo3VLgvdf8ZoQwiG9+btLXR3p3S+BihgctR7E0zVZ8tmbF3C27ml7h+B7MuWyhV+wodYGvs2gNQOpHBo4WjyZNORla0kWnF5HL5HDom5h9LHvZJ51r++17RXvvv+4RDPIk9zlWP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=On1AcKDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCE6C116C6;
	Thu,  8 Jan 2026 09:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767865838;
	bh=tOF5vm2/fzd9Nair/gZvuxW93ciHRl5l/d/srZZfsbY=;
	h=From:To:Cc:Subject:Date:From;
	b=On1AcKDG2BhE29JjGkqrBa3ePtQWL/ejHUpwr5FACQjkrxoStgk+BrPlrpxiBPUXg
	 FyvCpUIGxpuOSVJFHGwVDg0AMrCvhievfKKH/HXcPdJcstbBGfG1JJngnX8XF/Nq8W
	 SNMlxhmwcQ2kXeI2zzy0GjddY6+a7Xds9O9caRNM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.64
Date: Thu,  8 Jan 2026 10:50:31 +0100
Message-ID: <2026010832-rerun-fable-52a8@gregkh>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.64 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml                           |    2 
 Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml                       |    5 
 Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml                     |    3 
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml                       |    5 
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml                       |    5 
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml                       |    5 
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml                       |    5 
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml                       |    5 
 Documentation/driver-api/soundwire/stream.rst                                     |    2 
 Documentation/driver-api/tty/tty_port.rst                                         |    5 
 Documentation/filesystems/nfs/localio.rst                                         |   85 
 Makefile                                                                          |    2 
 arch/arm/boot/dts/microchip/sama5d2.dtsi                                          |   10 
 arch/arm/boot/dts/microchip/sama7g5.dtsi                                          |    4 
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                                            |   12 
 arch/arm64/include/asm/el2_setup.h                                                |   57 
 arch/arm64/kernel/head.S                                                          |   22 
 arch/arm64/kvm/hyp/nvhe/hyp-init.S                                                |   10 
 arch/arm64/kvm/hyp/nvhe/psci-relay.c                                              |    3 
 arch/arm64/net/bpf_jit_comp.c                                                     |    2 
 arch/loongarch/include/asm/pgtable.h                                              |    4 
 arch/loongarch/kernel/mcount_dyn.S                                                |   14 
 arch/loongarch/kernel/relocate.c                                                  |    4 
 arch/loongarch/kernel/setup.c                                                     |    8 
 arch/loongarch/kernel/switch.S                                                    |    4 
 arch/loongarch/net/bpf_jit.c                                                      |   18 
 arch/loongarch/net/bpf_jit.h                                                      |   26 
 arch/loongarch/pci/pci.c                                                          |    2 
 arch/mips/kernel/ftrace.c                                                         |   25 
 arch/mips/sgi-ip22/ip22-gio.c                                                     |    3 
 arch/parisc/kernel/asm-offsets.c                                                  |    2 
 arch/parisc/kernel/entry.S                                                        |   16 
 arch/powerpc/boot/addnote.c                                                       |    7 
 arch/powerpc/include/asm/book3s/32/tlbflush.h                                     |    5 
 arch/powerpc/include/asm/book3s/64/mmu-hash.h                                     |    1 
 arch/powerpc/kernel/btext.c                                                       |    3 
 arch/powerpc/kernel/process.c                                                     |    5 
 arch/powerpc/kexec/core_64.c                                                      |   19 
 arch/powerpc/mm/book3s32/tlb.c                                                    |    9 
 arch/powerpc/mm/book3s64/internal.h                                               |    2 
 arch/powerpc/mm/book3s64/mmu_context.c                                            |    2 
 arch/powerpc/mm/book3s64/slb.c                                                    |   88 
 arch/powerpc/platforms/pseries/cmm.c                                              |    5 
 arch/riscv/crypto/chacha-riscv64-zvkb.S                                           |    5 
 arch/s390/include/uapi/asm/ipl.h                                                  |    1 
 arch/s390/kernel/ipl.c                                                            |   48 
 arch/x86/crypto/blake2s-core.S                                                    |    4 
 arch/x86/entry/common.c                                                           |   72 
 arch/x86/events/amd/core.c                                                        |    7 
 arch/x86/events/amd/uncore.c                                                      |    5 
 arch/x86/include/asm/irq_remapping.h                                              |    7 
 arch/x86/include/asm/ptrace.h                                                     |   20 
 arch/x86/kernel/cpu/mce/threshold.c                                               |    3 
 arch/x86/kernel/cpu/microcode/amd.c                                               |  106 
 arch/x86/kernel/fpu/xstate.c                                                      |    4 
 arch/x86/kernel/irq.c                                                             |   23 
 arch/x86/kvm/lapic.c                                                              |   32 
 arch/x86/kvm/svm/nested.c                                                         |    6 
 arch/x86/kvm/svm/svm.c                                                            |   44 
 arch/x86/kvm/svm/svm.h                                                            |    7 
 arch/x86/kvm/vmx/nested.c                                                         |    3 
 arch/x86/kvm/x86.c                                                                |   25 
 arch/x86/xen/enlighten_pv.c                                                       |   69 
 block/blk-mq.c                                                                    |    2 
 block/blk-zoned.c                                                                 |  191 -
 block/blk.h                                                                       |   14 
 block/genhd.c                                                                     |    2 
 crypto/af_alg.c                                                                   |    5 
 crypto/algif_hash.c                                                               |    3 
 crypto/algif_rng.c                                                                |    3 
 crypto/seqiv.c                                                                    |    8 
 drivers/acpi/acpi_pcc.c                                                           |    2 
 drivers/acpi/acpica/nswalk.c                                                      |    9 
 drivers/acpi/cppc_acpi.c                                                          |    3 
 drivers/acpi/fan.h                                                                |   33 
 drivers/acpi/fan_hwmon.c                                                          |   10 
 drivers/acpi/property.c                                                           |    8 
 drivers/amba/tegra-ahb.c                                                          |    1 
 drivers/base/power/runtime.c                                                      |   22 
 drivers/block/floppy.c                                                            |    2 
 drivers/block/rnbd/rnbd-clt.c                                                     |   13 
 drivers/block/rnbd/rnbd-clt.h                                                     |    2 
 drivers/bluetooth/btusb.c                                                         |   22 
 drivers/bus/ti-sysc.c                                                             |   11 
 drivers/char/applicom.c                                                           |    5 
 drivers/char/ipmi/ipmi_msghandler.c                                               |   20 
 drivers/char/tpm/tpm-chip.c                                                       |    1 
 drivers/char/tpm/tpm1-cmd.c                                                       |    5 
 drivers/char/tpm/tpm2-cmd.c                                                       |   11 
 drivers/char/tpm/tpm2-sessions.c                                                  |   85 
 drivers/clk/mvebu/cp110-system-controller.c                                       |   20 
 drivers/clk/qcom/dispcc-sm7150.c                                                  |    2 
 drivers/clk/samsung/clk-exynos-clkout.c                                           |    2 
 drivers/cpufreq/cpufreq-dt-platdev.c                                              |    1 
 drivers/cpufreq/cpufreq-nforce2.c                                                 |    3 
 drivers/cpufreq/s5pv210-cpufreq.c                                                 |    6 
 drivers/cpuidle/governors/menu.c                                                  |    9 
 drivers/cpuidle/governors/teo.c                                                   |    7 
 drivers/crypto/caam/caamrng.c                                                     |    4 
 drivers/firewire/nosy.c                                                           |   10 
 drivers/firmware/imx/imx-scu-irq.c                                                |    4 
 drivers/firmware/stratix10-svc.c                                                  |   11 
 drivers/gpio/Makefile                                                             |    1 
 drivers/gpio/gpio-regmap.c                                                        |    2 
 drivers/gpio/gpiolib-acpi-core.c                                                  | 1419 ++++++++
 drivers/gpio/gpiolib-acpi-quirks.c                                                |  412 ++
 drivers/gpio/gpiolib-acpi.c                                                       | 1737 ----------
 drivers/gpio/gpiolib-acpi.h                                                       |   15 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                        |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                                           |    2 
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c                                            |   27 
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c                                            |   27 
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h                                    |   62 
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm                            |   37 
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c                                            |    1 
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c                                         |    4 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c                       |   59 
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c                                  |    2 
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c                    |    8 
 drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c                  |    8 
 drivers/gpu/drm/drm_buddy.c                                                       |  394 +-
 drivers/gpu/drm/drm_displayid.c                                                   |   58 
 drivers/gpu/drm/drm_displayid_internal.h                                          |    2 
 drivers/gpu/drm/gma500/fbdev.c                                                    |   43 
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c                                    |   37 
 drivers/gpu/drm/i915/intel_memory_region.h                                        |    2 
 drivers/gpu/drm/imagination/pvr_gem.c                                             |   11 
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c                                           |   33 
 drivers/gpu/drm/mediatek/mtk_ddp_comp.h                                           |    2 
 drivers/gpu/drm/mediatek/mtk_dp.c                                                 |    1 
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                                            |    4 
 drivers/gpu/drm/mgag200/mgag200_mode.c                                            |   25 
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c                                       |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c                               |   10 
 drivers/gpu/drm/nouveau/dispnv50/atom.h                                           |   13 
 drivers/gpu/drm/nouveau/dispnv50/wndw.c                                           |    2 
 drivers/gpu/drm/panel/panel-sony-td4353-jdi.c                                     |    2 
 drivers/gpu/drm/panthor/panthor_gem.c                                             |   18 
 drivers/gpu/drm/ttm/ttm_bo_vm.c                                                   |    6 
 drivers/gpu/drm/xe/xe_bo.c                                                        |   15 
 drivers/gpu/drm/xe/xe_dma_buf.c                                                   |    2 
 drivers/gpu/drm/xe/xe_exec.c                                                      |    3 
 drivers/gpu/drm/xe/xe_gt.c                                                        |    7 
 drivers/gpu/drm/xe/xe_guc_submit.c                                                |   20 
 drivers/gpu/drm/xe/xe_heci_gsc.c                                                  |    4 
 drivers/gpu/drm/xe/xe_oa.c                                                        |   13 
 drivers/gpu/drm/xe/xe_vm.c                                                        |    8 
 drivers/gpu/drm/xe/xe_vm_types.h                                                  |    2 
 drivers/hid/hid-input.c                                                           |   18 
 drivers/hid/hid-logitech-dj.c                                                     |   56 
 drivers/hwmon/dell-smm-hwmon.c                                                    |    9 
 drivers/hwmon/ibmpex.c                                                            |    9 
 drivers/hwmon/ltc4282.c                                                           |    9 
 drivers/hwmon/max16065.c                                                          |    7 
 drivers/hwmon/max6697.c                                                           |    2 
 drivers/hwmon/tmp401.c                                                            |    2 
 drivers/hwmon/w83791d.c                                                           |   17 
 drivers/hwmon/w83l786ng.c                                                         |   26 
 drivers/hwtracing/intel_th/core.c                                                 |   20 
 drivers/i2c/busses/i2c-amd-mp2-pci.c                                              |    5 
 drivers/i2c/busses/i2c-designware-core.h                                          |    1 
 drivers/i2c/busses/i2c-designware-master.c                                        |    7 
 drivers/iio/adc/ti_am335x_adc.c                                                   |    2 
 drivers/infiniband/core/addr.c                                                    |   33 
 drivers/infiniband/core/cma.c                                                     |    3 
 drivers/infiniband/core/device.c                                                  |    4 
 drivers/infiniband/core/verbs.c                                                   |    2 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                                          |    7 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c                                        |    2 
 drivers/infiniband/hw/bnxt_re/qplib_res.c                                         |    8 
 drivers/infiniband/hw/efa/efa_verbs.c                                             |    4 
 drivers/infiniband/hw/irdma/utils.c                                               |    3 
 drivers/infiniband/ulp/rtrs/rtrs-clt.c                                            |    1 
 drivers/input/keyboard/lkkbd.c                                                    |    5 
 drivers/input/mouse/alps.c                                                        |    1 
 drivers/input/serio/i8042-acpipnpio.h                                             |    7 
 drivers/input/touchscreen/ti_am335x_tsc.c                                         |    2 
 drivers/interconnect/qcom/sdx75.c                                                 |   26 
 drivers/interconnect/qcom/sdx75.h                                                 |    2 
 drivers/iommu/amd/init.c                                                          |   15 
 drivers/iommu/amd/iommu.c                                                         |    2 
 drivers/iommu/apple-dart.c                                                        |    2 
 drivers/iommu/arm/arm-smmu/qcom_iommu.c                                           |   10 
 drivers/iommu/exynos-iommu.c                                                      |    9 
 drivers/iommu/intel/irq_remapping.c                                               |    8 
 drivers/iommu/iommu-sva.c                                                         |    3 
 drivers/iommu/iommufd/selftest.c                                                  |    8 
 drivers/iommu/ipmmu-vmsa.c                                                        |    2 
 drivers/iommu/mtk_iommu.c                                                         |   27 
 drivers/iommu/mtk_iommu_v1.c                                                      |   25 
 drivers/iommu/omap-iommu.c                                                        |    2 
 drivers/iommu/omap-iommu.h                                                        |    2 
 drivers/iommu/sun50i-iommu.c                                                      |    2 
 drivers/iommu/tegra-smmu.c                                                        |    5 
 drivers/isdn/capi/capi.c                                                          |    8 
 drivers/leds/leds-cros_ec.c                                                       |    5 
 drivers/leds/leds-lp50xx.c                                                        |   67 
 drivers/md/dm-bufio.c                                                             |   10 
 drivers/md/dm-ebs-target.c                                                        |    2 
 drivers/md/md.c                                                                   |    5 
 drivers/md/raid10.c                                                               |    3 
 drivers/md/raid5.c                                                                |   10 
 drivers/media/cec/core/cec-core.c                                                 |    1 
 drivers/media/common/videobuf2/videobuf2-dma-contig.c                             |    1 
 drivers/media/i2c/adv7604.c                                                       |    4 
 drivers/media/i2c/adv7842.c                                                       |   11 
 drivers/media/i2c/imx219.c                                                        |    9 
 drivers/media/i2c/msp3400-kthreads.c                                              |    2 
 drivers/media/i2c/tda1997x.c                                                      |    1 
 drivers/media/platform/amphion/vpu_malone.c                                       |   35 
 drivers/media/platform/amphion/vpu_v4l2.c                                         |   28 
 drivers/media/platform/amphion/vpu_v4l2.h                                         |   18 
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c                              |   14 
 drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c                 |   14 
 drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c               |   12 
 drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h               |    2 
 drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c                      |    5 
 drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c               |   12 
 drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h               |    2 
 drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c                      |    5 
 drivers/media/platform/renesas/rcar_drif.c                                        |    1 
 drivers/media/platform/samsung/exynos4-is/media-dev.c                             |   10 
 drivers/media/platform/ti/davinci/vpif_capture.c                                  |    4 
 drivers/media/platform/ti/davinci/vpif_display.c                                  |    4 
 drivers/media/platform/verisilicon/hantro_g2.c                                    |   88 
 drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c                           |   17 
 drivers/media/platform/verisilicon/hantro_g2_regs.h                               |   13 
 drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c                            |    2 
 drivers/media/platform/verisilicon/hantro_hw.h                                    |    1 
 drivers/media/platform/verisilicon/imx8m_vpu_hw.c                                 |    2 
 drivers/media/rc/st_rc.c                                                          |    2 
 drivers/media/test-drivers/vidtv/vidtv_channel.c                                  |    3 
 drivers/media/usb/dvb-usb/dtv5100.c                                               |    5 
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c                                           |    2 
 drivers/mfd/altera-sysmgr.c                                                       |    2 
 drivers/mfd/max77620.c                                                            |   15 
 drivers/misc/mei/Kconfig                                                          |    2 
 drivers/misc/vmw_balloon.c                                                        |    3 
 drivers/mmc/host/Kconfig                                                          |    4 
 drivers/mmc/host/sdhci-msm.c                                                      |   27 
 drivers/mmc/host/sdhci-of-arasan.c                                                |    2 
 drivers/mtd/mtdpart.c                                                             |    7 
 drivers/mtd/spi-nor/winbond.c                                                     |   24 
 drivers/net/can/usb/gs_usb.c                                                      |    2 
 drivers/net/dsa/b53/b53_common.c                                                  |    3 
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c                                       |    2 
 drivers/net/ethernet/broadcom/b44.c                                               |    3 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c                                     |    3 
 drivers/net/ethernet/cadence/macb_main.c                                          |    3 
 drivers/net/ethernet/freescale/enetc/enetc.c                                      |    3 
 drivers/net/ethernet/freescale/fec_main.c                                         |    7 
 drivers/net/ethernet/google/gve/gve_main.c                                        |    2 
 drivers/net/ethernet/google/gve/gve_utils.c                                       |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c                           |    3 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c                            |    4 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c                         |    4 
 drivers/net/ethernet/intel/e1000/e1000_main.c                                     |   10 
 drivers/net/ethernet/intel/i40e/i40e.h                                            |   11 
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c                                    |   12 
 drivers/net/ethernet/intel/i40e/i40e_main.c                                       |    1 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c                                |    4 
 drivers/net/ethernet/intel/iavf/iavf_main.c                                       |    4 
 drivers/net/ethernet/intel/idpf/idpf_dev.c                                        |    3 
 drivers/net/ethernet/intel/idpf/idpf_lib.c                                        |    2 
 drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c                               |   61 
 drivers/net/ethernet/intel/idpf/idpf_txrx.c                                       |  750 +---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h                                       |   95 
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c                                     |    3 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c                         |    8 
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c                                 |    5 
 drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c                          |   97 
 drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.h                          |    1 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c                        |    6 
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c                                |   48 
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h                                |    1 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                                    |    1 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c                                 |    2 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c                             |   27 
 drivers/net/ethernet/realtek/r8169_main.c                                         |    5 
 drivers/net/ethernet/smsc/smc91x.c                                                |   10 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                                 |   17 
 drivers/net/fjes/fjes_hw.c                                                        |   12 
 drivers/net/ipvlan/ipvlan_core.c                                                  |    3 
 drivers/net/mdio/mdio-aspeed.c                                                    |    7 
 drivers/net/phy/marvell-88q2xxx.c                                                 |    2 
 drivers/net/team/team_core.c                                                      |    2 
 drivers/net/usb/asix_common.c                                                     |    5 
 drivers/net/usb/rtl8150.c                                                         |    2 
 drivers/net/usb/sr9700.c                                                          |    4 
 drivers/net/usb/usbnet.c                                                          |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c                            |   14 
 drivers/net/wireless/mediatek/mt76/eeprom.c                                       |   37 
 drivers/net/wireless/mediatek/mt76/mt7615/main.c                                  |    4 
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c                                   |    6 
 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c                                  |    4 
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c                                   |    4 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c                              |    4 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h                              |    3 
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                                   |    2 
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c                                   |    6 
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c                                  |    6 
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c                                   |    4 
 drivers/net/wireless/mediatek/mt76/mt7925/init.c                                  |   24 
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c                                   |   51 
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h                                |   21 
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c                                   |   33 
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c                                   |   20 
 drivers/net/wireless/mediatek/mt76/mt792x.h                                       |    2 
 drivers/net/wireless/realtek/rtl8xxxu/core.c                                      |    7 
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c                              |    3 
 drivers/net/wireless/realtek/rtw88/sdio.c                                         |    4 
 drivers/nfc/pn533/usb.c                                                           |    2 
 drivers/nvme/host/fabrics.c                                                       |    2 
 drivers/nvme/host/fc.c                                                            |    6 
 drivers/of/fdt.c                                                                  |    2 
 drivers/parisc/gsc.c                                                              |    4 
 drivers/pci/controller/pcie-brcmstb.c                                             |  107 
 drivers/pci/pci-driver.c                                                          |    4 
 drivers/perf/arm_cspmu/arm_cspmu.c                                                |    4 
 drivers/phy/broadcom/phy-bcm63xx-usbh.c                                           |    6 
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                                           |   75 
 drivers/platform/chrome/cros_ec_ishtp.c                                           |    1 
 drivers/platform/mellanox/mlxbf-pmc.c                                             |   14 
 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c                              |    4 
 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c                               |    2 
 drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c                        |    5 
 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c                         |    5 
 drivers/platform/x86/hp/hp-bioscfg/string-attributes.c                            |    2 
 drivers/platform/x86/ibm_rtl.c                                                    |    2 
 drivers/platform/x86/intel/chtwc_int33fe.c                                        |   29 
 drivers/platform/x86/intel/hid.c                                                  |   12 
 drivers/platform/x86/msi-laptop.c                                                 |    3 
 drivers/pmdomain/imx/gpc.c                                                        |    5 
 drivers/rpmsg/qcom_glink_native.c                                                 |    8 
 drivers/s390/block/dasd_eckd.c                                                    |    8 
 drivers/scsi/aic94xx/aic94xx_init.c                                               |    3 
 drivers/scsi/mpi3mr/mpi/mpi30_ioc.h                                               |    1 
 drivers/scsi/mpi3mr/mpi3mr_fw.c                                                   |    2 
 drivers/scsi/qla2xxx/qla_def.h                                                    |    1 
 drivers/scsi/qla2xxx/qla_gbl.h                                                    |    2 
 drivers/scsi/qla2xxx/qla_isr.c                                                    |   32 
 drivers/scsi/qla2xxx/qla_mbx.c                                                    |    2 
 drivers/scsi/qla2xxx/qla_mid.c                                                    |    4 
 drivers/scsi/qla2xxx/qla_os.c                                                     |   14 
 drivers/scsi/scsi_debug.c                                                         |    2 
 drivers/scsi/smartpqi/smartpqi_init.c                                             |    4 
 drivers/soc/amlogic/meson-canvas.c                                                |    5 
 drivers/soc/apple/mailbox.c                                                       |   15 
 drivers/soc/qcom/ocmem.c                                                          |    2 
 drivers/soc/qcom/qcom-pbs.c                                                       |    2 
 drivers/soc/samsung/exynos-pmu.c                                                  |    2 
 drivers/soc/tegra/fuse/fuse-tegra.c                                               |    2 
 drivers/soundwire/stream.c                                                        |    6 
 drivers/spi/spi-cadence-quadspi.c                                                 |    4 
 drivers/spi/spi-fsl-spi.c                                                         |    2 
 drivers/staging/greybus/uart.c                                                    |    7 
 drivers/target/target_core_transport.c                                            |    1 
 drivers/tty/serial/serial_base_bus.c                                              |    8 
 drivers/tty/serial/serial_core.c                                                  |    7 
 drivers/tty/serial/sh-sci.c                                                       |    2 
 drivers/tty/serial/sprd_serial.c                                                  |    6 
 drivers/tty/serial/xilinx_uartps.c                                                |   16 
 drivers/tty/tty_port.c                                                            |   17 
 drivers/ufs/core/ufshcd.c                                                         |    5 
 drivers/ufs/host/ufs-mediatek.c                                                   |    5 
 drivers/usb/class/cdc-acm.c                                                       |    7 
 drivers/usb/dwc3/dwc3-of-simple.c                                                 |    7 
 drivers/usb/dwc3/gadget.c                                                         |    2 
 drivers/usb/dwc3/host.c                                                           |    2 
 drivers/usb/gadget/udc/lpc32xx_udc.c                                              |   21 
 drivers/usb/host/ohci-nxp.c                                                       |    2 
 drivers/usb/host/xhci-dbgtty.c                                                    |    2 
 drivers/usb/host/xhci-hub.c                                                       |    2 
 drivers/usb/phy/phy-fsl-usb.c                                                     |    1 
 drivers/usb/phy/phy-isp1301.c                                                     |    7 
 drivers/usb/renesas_usbhs/pipe.c                                                  |    2 
 drivers/usb/serial/usb-serial.c                                                   |    7 
 drivers/usb/storage/unusual_uas.h                                                 |    2 
 drivers/usb/typec/altmodes/displayport.c                                          |    8 
 drivers/usb/typec/ucsi/ucsi.c                                                     |    6 
 drivers/usb/usbip/vhci_hcd.c                                                      |    6 
 drivers/vdpa/octeon_ep/octep_vdpa_main.c                                          |    1 
 drivers/vfio/pci/nvgrace-gpu/main.c                                               |    4 
 drivers/vfio/pci/pds/dirty.c                                                      |    7 
 drivers/vfio/pci/vfio_pci_rdwr.c                                                  |   24 
 drivers/vhost/vsock.c                                                             |   15 
 drivers/video/fbdev/gbefb.c                                                       |    5 
 drivers/video/fbdev/pxafb.c                                                       |   12 
 drivers/video/fbdev/tcx.c                                                         |    2 
 drivers/virtio/virtio_balloon.c                                                   |    4 
 drivers/watchdog/via_wdt.c                                                        |    1 
 fs/btrfs/inode.c                                                                  |    1 
 fs/btrfs/ioctl.c                                                                  |    4 
 fs/btrfs/scrub.c                                                                  |    5 
 fs/btrfs/tree-log.c                                                               |   46 
 fs/btrfs/volumes.c                                                                |    1 
 fs/erofs/zdata.c                                                                  |    8 
 fs/exfat/file.c                                                                   |    5 
 fs/exfat/super.c                                                                  |   19 
 fs/ext4/ialloc.c                                                                  |    1 
 fs/ext4/inode.c                                                                   |    1 
 fs/ext4/mballoc.c                                                                 |    2 
 fs/ext4/orphan.c                                                                  |    4 
 fs/ext4/super.c                                                                   |    6 
 fs/ext4/xattr.c                                                                   |    6 
 fs/f2fs/compress.c                                                                |    5 
 fs/f2fs/data.c                                                                    |   17 
 fs/f2fs/extent_cache.c                                                            |    5 
 fs/f2fs/f2fs.h                                                                    |   17 
 fs/f2fs/file.c                                                                    |   20 
 fs/f2fs/gc.c                                                                      |    2 
 fs/f2fs/inode.c                                                                   |    2 
 fs/f2fs/namei.c                                                                   |    6 
 fs/f2fs/recovery.c                                                                |   20 
 fs/f2fs/segment.c                                                                 |    9 
 fs/f2fs/super.c                                                                   |  160 
 fs/f2fs/xattr.c                                                                   |   30 
 fs/f2fs/xattr.h                                                                   |   10 
 fs/fuse/file.c                                                                    |   37 
 fs/gfs2/glops.c                                                                   |    3 
 fs/gfs2/lops.c                                                                    |    2 
 fs/gfs2/quota.c                                                                   |    2 
 fs/gfs2/super.c                                                                   |    4 
 fs/hfsplus/bnode.c                                                                |    4 
 fs/hfsplus/dir.c                                                                  |    7 
 fs/hfsplus/inode.c                                                                |   32 
 fs/iomap/buffered-io.c                                                            |   41 
 fs/iomap/direct-io.c                                                              |   10 
 fs/jbd2/journal.c                                                                 |   20 
 fs/jbd2/transaction.c                                                             |    2 
 fs/libfs.c                                                                        |   50 
 fs/lockd/svc4proc.c                                                               |    4 
 fs/lockd/svclock.c                                                                |   21 
 fs/lockd/svcproc.c                                                                |    5 
 fs/locks.c                                                                        |   12 
 fs/nfs_common/nfslocalio.c                                                        |   10 
 fs/nfsd/blocklayout.c                                                             |    3 
 fs/nfsd/export.c                                                                  |    2 
 fs/nfsd/filecache.c                                                               |    2 
 fs/nfsd/localio.c                                                                 |    4 
 fs/nfsd/netns.h                                                                   |   11 
 fs/nfsd/nfs4state.c                                                               |    4 
 fs/nfsd/nfs4xdr.c                                                                 |    5 
 fs/nfsd/nfssvc.c                                                                  |   45 
 fs/nfsd/vfs.h                                                                     |    3 
 fs/notify/fsnotify.c                                                              |    9 
 fs/ntfs3/file.c                                                                   |   14 
 fs/ntfs3/frecord.c                                                                |   35 
 fs/ntfs3/ntfs_fs.h                                                                |    9 
 fs/ntfs3/run.c                                                                    |    6 
 fs/ntfs3/super.c                                                                  |    5 
 fs/ocfs2/suballoc.c                                                               |   10 
 fs/smb/client/fs_context.c                                                        |    2 
 fs/smb/server/mgmt/tree_connect.c                                                 |   18 
 fs/smb/server/mgmt/tree_connect.h                                                 |    1 
 fs/smb/server/mgmt/user_session.c                                                 |    4 
 fs/smb/server/smb2pdu.c                                                           |   20 
 fs/smb/server/vfs.c                                                               |    5 
 fs/smb/server/vfs_cache.c                                                         |   88 
 fs/xfs/scrub/attr_repair.c                                                        |    2 
 fs/xfs/xfs_attr_item.c                                                            |    2 
 fs/xfs/xfs_buf_item.c                                                             |    1 
 fs/xfs/xfs_qm.c                                                                   |    5 
 include/drm/drm_buddy.h                                                           |   11 
 include/drm/drm_edid.h                                                            |    6 
 include/linux/balloon_compaction.h                                                |   43 
 include/linux/compiler_types.h                                                    |   13 
 include/linux/fs.h                                                                |    2 
 include/linux/genalloc.h                                                          |    1 
 include/linux/hrtimer.h                                                           |   23 
 include/linux/jbd2.h                                                              |    6 
 include/linux/kasan.h                                                             |   16 
 include/linux/nfslocalio.h                                                        |   12 
 include/linux/reset.h                                                             |    1 
 include/linux/soundwire/sdw.h                                                     |    2 
 include/linux/tpm.h                                                               |    8 
 include/linux/tty_port.h                                                          |   21 
 include/linux/vfio_pci_core.h                                                     |   10 
 include/media/v4l2-mem2mem.h                                                      |    3 
 include/net/ip.h                                                                  |    6 
 include/net/ip6_route.h                                                           |    4 
 include/net/route.h                                                               |    2 
 include/uapi/drm/xe_drm.h                                                         |    1 
 include/uapi/linux/mptcp.h                                                        |    1 
 io_uring/io_uring.c                                                               |    3 
 io_uring/openclose.c                                                              |    2 
 io_uring/poll.c                                                                   |    9 
 kernel/kallsyms.c                                                                 |    5 
 kernel/livepatch/core.c                                                           |    8 
 kernel/sched/cpudeadline.c                                                        |   34 
 kernel/sched/cpudeadline.h                                                        |    4 
 kernel/sched/deadline.c                                                           |    8 
 kernel/sched/debug.c                                                              |    8 
 kernel/sched/ext.c                                                                |   58 
 kernel/sched/fair.c                                                               |  103 
 kernel/sched/rt.c                                                                 |   52 
 kernel/sched/sched.h                                                              |    4 
 kernel/scs.c                                                                      |    2 
 kernel/trace/fgraph.c                                                             |   10 
 kernel/trace/trace_events.c                                                       |    2 
 kernel/trace/trace_events_synth.c                                                 |    1 
 lib/idr.c                                                                         |    2 
 mm/balloon_compaction.c                                                           |    9 
 mm/damon/tests/core-kunit.h                                                       |   99 
 mm/damon/tests/sysfs-kunit.h                                                      |   25 
 mm/damon/tests/vaddr-kunit.h                                                      |   26 
 mm/kasan/common.c                                                                 |   32 
 mm/kasan/hw_tags.c                                                                |    2 
 mm/kasan/shadow.c                                                                 |    4 
 mm/ksm.c                                                                          |   18 
 mm/page_owner.c                                                                   |    2 
 mm/shmem.c                                                                        |   18 
 mm/vmalloc.c                                                                      |    8 
 net/bluetooth/rfcomm/tty.c                                                        |    7 
 net/bridge/br_private.h                                                           |    1 
 net/caif/cffrml.c                                                                 |    9 
 net/ceph/osdmap.c                                                                 |  116 
 net/core/sock.c                                                                   |   16 
 net/dsa/dsa.c                                                                     |    8 
 net/ethtool/ioctl.c                                                               |   30 
 net/handshake/request.c                                                           |    8 
 net/hsr/hsr_device.c                                                              |    7 
 net/hsr/hsr_forward.c                                                             |    2 
 net/ipv4/fib_trie.c                                                               |    7 
 net/ipv6/calipso.c                                                                |    3 
 net/ipv6/exthdrs.c                                                                |    2 
 net/ipv6/icmp.c                                                                   |    4 
 net/ipv6/ila/ila_lwt.c                                                            |    2 
 net/ipv6/ioam6_iptunnel.c                                                         |   37 
 net/ipv6/ip6_gre.c                                                                |   17 
 net/ipv6/ip6_output.c                                                             |   19 
 net/ipv6/ip6_tunnel.c                                                             |    4 
 net/ipv6/ip6_udp_tunnel.c                                                         |    2 
 net/ipv6/ip6_vti.c                                                                |    2 
 net/ipv6/ndisc.c                                                                  |    6 
 net/ipv6/netfilter/nf_dup_ipv6.c                                                  |    2 
 net/ipv6/output_core.c                                                            |    2 
 net/ipv6/route.c                                                                  |   33 
 net/ipv6/rpl_iptunnel.c                                                           |    4 
 net/ipv6/seg6_iptunnel.c                                                          |   20 
 net/ipv6/seg6_local.c                                                             |    2 
 net/mac80211/cfg.c                                                                |   10 
 net/mptcp/pm_netlink.c                                                            |    3 
 net/mptcp/protocol.c                                                              |   22 
 net/netfilter/ipvs/ip_vs_xmit.c                                                   |    3 
 net/netfilter/nf_conncount.c                                                      |   25 
 net/netfilter/nf_nat_core.c                                                       |   14 
 net/netfilter/nf_tables_api.c                                                     |   11 
 net/netfilter/nft_ct.c                                                            |    5 
 net/netrom/nr_out.c                                                               |    4 
 net/nfc/core.c                                                                    |    9 
 net/openvswitch/flow_netlink.c                                                    |   13 
 net/openvswitch/vport-netdev.c                                                    |   17 
 net/rose/af_rose.c                                                                |    2 
 net/sched/sch_ets.c                                                               |    6 
 net/sunrpc/auth_gss/svcauth_gss.c                                                 |    3 
 net/sunrpc/xprtrdma/svc_rdma_rw.c                                                 |    7 
 net/wireless/core.c                                                               |    1 
 net/wireless/core.h                                                               |    1 
 net/wireless/mlme.c                                                               |   19 
 net/wireless/sme.c                                                                |    2 
 net/wireless/util.c                                                               |   23 
 samples/ftrace/ftrace-direct-modify.c                                             |    8 
 samples/ftrace/ftrace-direct-multi-modify.c                                       |    8 
 samples/ftrace/ftrace-direct-multi.c                                              |    4 
 samples/ftrace/ftrace-direct-too.c                                                |    4 
 samples/ftrace/ftrace-direct.c                                                    |    4 
 scripts/Makefile.build                                                            |   26 
 scripts/Makefile.modinst                                                          |    2 
 scripts/faddr2line                                                                |   13 
 security/keys/trusted-keys/trusted_tpm2.c                                         |    6 
 sound/isa/wavefront/wavefront_midi.c                                              |  133 
 sound/isa/wavefront/wavefront_synth.c                                             |   18 
 sound/pci/hda/cs35l41_hda.c                                                       |    2 
 sound/pcmcia/pdaudiocf/pdaudiocf.c                                                |    8 
 sound/pcmcia/vx/vxpocket.c                                                        |    8 
 sound/soc/codecs/ak4458.c                                                         |    4 
 sound/soc/codecs/lpass-tx-macro.c                                                 |    3 
 sound/soc/codecs/wcd939x-sdw.c                                                    |    8 
 sound/soc/qcom/qdsp6/q6adm.c                                                      |  146 
 sound/soc/qcom/qdsp6/q6apm-dai.c                                                  |    2 
 sound/soc/qcom/qdsp6/q6asm-dai.c                                                  |    7 
 sound/soc/qcom/sc7280.c                                                           |    2 
 sound/soc/qcom/sc8280xp.c                                                         |    2 
 sound/soc/qcom/sdw.c                                                              |  107 
 sound/soc/qcom/sdw.h                                                              |    1 
 sound/soc/qcom/sm8250.c                                                           |    2 
 sound/soc/qcom/x1e80100.c                                                         |    2 
 sound/soc/sh/rz-ssi.c                                                             |   64 
 sound/soc/stm/stm32_sai.c                                                         |   14 
 sound/soc/stm/stm32_sai_sub.c                                                     |   51 
 sound/usb/mixer_us16x08.c                                                         |   20 
 tools/lib/perf/cpumap.c                                                           |   10 
 tools/mm/page_owner_sort.c                                                        |    6 
 tools/testing/ktest/config-bisect.pl                                              |    4 
 tools/testing/nvdimm/test/nfit.c                                                  |    7 
 tools/testing/radix-tree/idr-test.c                                               |   21 
 tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc          |    5 
 tools/testing/selftests/iommu/iommufd.c                                           |   54 
 tools/testing/selftests/iommu/iommufd_fail_nth.c                                  |    3 
 tools/testing/selftests/iommu/iommufd_utils.h                                     |   38 
 tools/testing/selftests/net/mptcp/pm_netlink.sh                                   |    4 
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c                                     |   11 
 tools/testing/selftests/net/netfilter/conntrack_reverse_clash.c                   |   13 
 tools/testing/selftests/net/netfilter/conntrack_reverse_clash.sh                  |    2 
 tools/testing/selftests/net/netfilter/packetdrill/conntrack_syn_challenge_ack.pkt |    2 
 tools/testing/selftests/net/tap.c                                                 |   16 
 virt/kvm/kvm_main.c                                                               |    2 
 608 files changed, 7293 insertions(+), 5171 deletions(-)

Aboorva Devarajan (1):
      cpuidle: menu: Use residency threshold in polling state override decisions

Ahmed Genidi (1):
      KVM: arm64: Initialize SCTLR_EL1 in __kvm_hyp_init_cpu()

Akhil P Oommen (1):
      drm/msm/a6xx: Fix out of bound IO access in a6xx_get_gmu_registers

Al Viro (1):
      shmem: fix recovery on rename failures

Alessio Belle (1):
      drm/imagination: Disallow exporting of PM/FW protected objects

Alex Deucher (3):
      drm/amd/display: Use GFP_ATOMIC in dc_create_plane_state()
      drm/amdgpu/gmc12: add amdgpu_vm_handle_fault() handling
      drm/amdgpu/gmc11: add amdgpu_vm_handle_fault() handling

Alexander Stein (1):
      serial: core: Fix serial device initialization

Alexey Simakov (2):
      broadcom: b44: prevent uninitialized value usage
      hwmon: (tmp401) fix overflow caused by default conversion rate value

Alexey Velichayshiy (1):
      gfs2: fix freeze error handling

Alice C. Munduruca (1):
      selftests: net: fix "buffer overflow detected" for tap.c

Alison Schofield (1):
      tools/testing/nvdimm: Use per-DIMM device handle

Alok Tiwari (2):
      RDMA/bnxt_re: Fix incorrect BAR check in bnxt_qplib_map_creq_db()
      RDMA/bnxt_re: Fix IB_SEND_IP_CSUM handling in post_send

Aloka Dixit (1):
      wifi: mac80211: do not use old MBSSID elements

Amir Goldstein (1):
      fsnotify: do not generate ACCESS/MODIFY events on child for special files

Andreas Gruenbacher (3):
      gfs2: fix remote evict for read-only filesystems
      gfs2: Fix "gfs2: Switch to wait_event in gfs2_quotad"
      gfs2: Fix use of bio_chain

Andrew Jeffery (1):
      dt-bindings: mmc: sdhci-of-aspeed: Switch ref to sdhci-common.yaml

Andrew Morton (1):
      genalloc.h: fix htmldocs warning

Andrey Vatoropin (1):
      scsi: target: Reset t_task_cdb pointer in error case

Andrii Melnychenko (1):
      netfilter: nft_ct: add seqadj extension for natted connections

Andy Shevchenko (6):
      nfsd: Mark variable __maybe_unused to avoid W=1 build break
      serial: core: Restore sysfs fwnode information
      gpiolib: acpi: Switch to use enum in acpi_gpio_in_ignore_list()
      gpiolib: acpi: Handle deferred list via new API
      gpiolib: acpi: Add acpi_gpio_need_run_edge_events_on_boot() getter
      gpiolib: acpi: Move quirks to a separate file

Ankit Garg (1):
      gve: defer interrupt enabling until NAPI registration

Anshumali Gaur (1):
      octeontx2-pf: fix "UBSAN: shift-out-of-bounds error"

Anurag Dutta (1):
      spi: cadence-quadspi: Fix clock disable on probe failure path

Ard Biesheuvel (1):
      drm/i915: Fix format string truncation warning

Armin Wolf (1):
      ACPI: fan: Workaround for 64-bit firmware bug

Arunpravin Paneer Selvam (2):
      drm/buddy: Optimize free block management with RB tree
      drm/buddy: Separate clear and dirty free block trees

Ashutosh Dixit (1):
      drm/xe/oa: Disallow 0 OA property values

Askar Safin (1):
      gpiolib: acpi: Add quirk for Dell Precision 7780

Avadhut Naik (1):
      x86/mce: Do not clear bank's poll bit in mce_poll_banks on AMD SMCA systems

Bagas Sanjaya (1):
      net: bridge: Describe @tunnel_hash member in net_bridge_vlan_group struct

Baokun Li (1):
      ext4: align max orphan file size with e2fsprogs limit

Bartosz Golaszewski (1):
      platform/x86: intel: chtwc_int33fe: don't dereference swnode args

Ben Collins (1):
      powerpc/addnote: Fix overflow on 32-bit builds

Bernd Schubert (2):
      fuse: Always flush the page cache before FOPEN_DIRECT_IO write
      fuse: Invalidate the page cache after FOPEN_DIRECT_IO write

Biju Das (2):
      ASoC: renesas: rz-ssi: Fix channel swap issue in full duplex mode
      ASoC: renesas: rz-ssi: Fix rz_ssi_priv::hw_params_cache::sample_width

Bitterblue Smith (1):
      wifi: rtl8xxxu: Fix HT40 channel config for RTL8192CU, RTL8723AU

Boris Brezillon (1):
      drm/panthor: Flush shmem writes before mapping buffers CPU-uncached

Borislav Petkov (AMD) (1):
      x86/microcode/AMD: Select which microcode patch to load

Brian Gerst (1):
      x86/xen: Move Xen upcall handler

Brian Vazquez (1):
      idpf: reduce mbx_task schedule delay to 300us

Byungchul Park (1):
      jbd2: use a weaker annotation in journal handling

Chandrakanth Patil (1):
      scsi: mpi3mr: Read missing IOCFacts flag for reply queue full overflow

Chao Yu (9):
      f2fs: fix to avoid potential deadlock
      f2fs: fix to avoid updating zero-sized extent in extent cache
      f2fs: fix return value of f2fs_recover_fsync_data()
      f2fs: fix to detect recoverable inode during dryrun of find_fsync_dnodes()
      f2fs: use global inline_xattr_slab instead of per-sb slab cache
      f2fs: fix to avoid updating compression context during writeback
      f2fs: add timeout in f2fs_enable_checkpoint()
      f2fs: dump more information for f2fs_{enable,disable}_checkpoint()
      f2fs: fix to propagate error from f2fs_enable_checkpoint()

Chen Changcheng (2):
      usb: usb-storage: No additional quirks need to be added to the EL-R12 optical drive.
      usb: usb-storage: Maintain minimal modifications to the bcdDevice range.

Chen-Yu Tsai (1):
      media: mediatek: vcodec: Use spinlock for context list protection lock

ChenXiaoSong (1):
      smb/server: fix return value of smb2_ioctl()

Chenghao Duan (2):
      samples/ftrace: Adjust LoongArch register restore order in direct calls
      LoongArch: Refactor register restoration in ftrace_common_return

Chia-Lin Kao (AceLan) (1):
      platform/x86/intel/hid: Add Dell Pro Rugged 10/12 tablet to VGBS DMI quirks

Chingbin Li (1):
      Bluetooth: btusb: Add new VID/PID 2b89/6275 for RTL8761BUV

Chris Lu (2):
      Bluetooth: btusb: MT7922: Add VID/PID 0489/e170
      Bluetooth: btusb: MT7920: Add VID/PID 0489/e135

Christian Hitz (3):
      leds: leds-lp50xx: Allow LED 0 to be added to module bank
      leds: leds-lp50xx: LP5009 supports 3 modules for a total of 9 LEDs
      leds: leds-lp50xx: Enable chip before any communication

Christian Marangi (1):
      mtd: mtdpart: ignore error -ENOENT from parsers on subpartitions

Christoffer Sandberg (1):
      Input: i8042 - add TUXEDO InfinityBook Max Gen10 AMD to i8042 quirk table

Christoph Hellwig (2):
      xfs: don't leak a locked dquot when xfs_dquot_attach_buf fails
      iomap: allocate s_dio_done_wq for async reads as well

Christophe Leroy (1):
      spi: fsl-cpm: Check length parity before switching to 16 bit mode

Chuck Lever (2):
      NFSD: Clear SECLABEL in the suppattr_exclcreat bitmap
      NFSD: NFSv4 file creation neglects setting ACL

Claudiu Beznea (2):
      serial: sh-sci: Check that the DMA cookie is valid
      pinctrl: renesas: rzg2l: Fix ISEL restore on resume

Colin Ian King (1):
      media: pvrusb2: Fix incorrect variable used in trace message

Cong Zhang (1):
      blk-mq: skip CPU offline notify on unmapped hctx

Cryolitia PukNgae (1):
      ACPICA: Avoid walking the Namespace if start_node is NULL

Dai Ngo (1):
      NFSD: use correct reservation type in nfsd4_scsi_fence_client

Damien Le Moal (4):
      block: Clear BLK_ZONE_WPLUG_PLUGGED when aborting plugged BIOs
      block: freeze queue when updating zone resources
      block: handle zone management operations completions
      block: fix NULL pointer dereference in blk_zone_reset_all_bio_endio()

Dan Carpenter (3):
      nfc: pn533: Fix error code in pn533_acr122_poweron_rdr()
      block: rnbd-clt: Fix signedness bug in init_dev()
      wifi: cfg80211: sme: store capped length in __cfg80211_connect_result()

Daniel Wagner (1):
      nvme-fc: don't hold rport lock when putting ctrl

Darrick J. Wong (2):
      xfs: fix stupid compiler warning
      xfs: fix a UAF problem in xattr repair

Dave Stevenson (1):
      media: i2c: imx219: Fix 1920x1080 mode to use 1:1 pixel aspect ratio

Dave Vasilevsky (1):
      powerpc, mm: Fix mprotect on book3s 32-bit

David Hildenbrand (4):
      powerpc/pseries/cmm: call balloon_devinfo_init() also without CONFIG_BALLOON_COMPACTION
      mm/balloon_compaction: we cannot have isolated pages in the balloon list
      mm/balloon_compaction: convert balloon_page_delete() to balloon_page_finalize()
      powerpc/pseries/cmm: adjust BALLOON_MIGRATE when migrating pages

David Strahan (1):
      scsi: smartpqi: Add support for Hurray Data new controller PCI device

Deepakkumar Karn (1):
      net: usb: rtl8150: fix memory leak on usb_submit_urb() failure

Deepanshu Kartikey (4):
      btrfs: fix memory leak of fs_devices in degraded seed device path
      f2fs: invalidate dentry cache on failed whiteout creation
      net: usb: asix: validate PHY address before use
      net: nfc: fix deadlock between nfc_unregister_device and rfkill_fop_write

Denis Arefev (1):
      ALSA: hda: cs35l41: Fix NULL pointer dereference in cs35l41_hda_read_acpi()

Denis Sergeev (1):
      hwmon: (dell-smm) Limit fan multiplier to avoid overflow

Dmitry Skorodumov (1):
      ipvlan: Ignore PACKET_LOOPBACK in handle_mode_l2()

Donet Tom (1):
      powerpc/64s/slb: Fix SLB multihit issue during SLB preload

Dongli Zhang (1):
      KVM: nVMX: Immediately refresh APICv controls as needed on nested VM-Exit

Doug Berger (1):
      sched/deadline: only set free_cpus for online runqueues

Duoming Zhou (5):
      Input: alps - fix use-after-free bugs caused by dev3_register_work
      usb: phy: fsl-usb: Fix use-after-free in delayed work during device removal
      media: TDA1997x: Remove redundant cancel_delayed_work in probe
      media: i2c: ADV7604: Remove redundant cancel_delayed_work in probe
      media: i2c: adv7842: Remove redundant cancel_delayed_work in probe

Encrow Thorne (1):
      reset: fix BIT macro reference

Eric Biggers (1):
      lib/crypto: x86/blake2s: Fix 32-bit arg treated as 64-bit

Eric Dumazet (3):
      ip6_gre: make ip6gre_header() robust
      ipv6: adopt dst_dev() helper
      net: use dst_dev_rcu() in sk_setup_caps()

Ethan Nelson-Moore (1):
      net: usb: sr9700: fix incorrect command used to write single register

Fedor Pchelkin (1):
      ext4: fix string copying in parse_apply_sb_mount_options()

Fernando Fernandez Mancera (1):
      netfilter: nf_conncount: fix leaked ct in error paths

Filipe Manana (2):
      btrfs: do not skip logging new dentries when logging a new name
      btrfs: don't log conflicting inode if it's a dir moved in the current transaction

Finn Thain (1):
      powerpc: Add reloc_offset() to font bitmap pointer used for bootx_printf()

Florian Westphal (2):
      netfilter: nf_nat: remove bogus direction check
      selftests: netfilter: packetdrill: avoid failure on HZ=100 kernel

Gal Pressman (1):
      ethtool: Avoid overflowing userspace buffer on stats query

George Kennedy (1):
      perf/x86/amd: Check event before enable to avoid GPF

Gongwei Li (1):
      Bluetooth: btusb: Add new VID/PID 13d3/3533 for RTL8821CE

Greg Kroah-Hartman (1):
      Linux 6.12.64

Gregory CLEMENT (1):
      MIPS: ftrace: Fix memory corruption when kernel is located beyond 32 bits

Gregory Herrero (1):
      i40e: validate ring_len parameter against hardware-specific values

Guangshuo Li (2):
      crypto: caam - Add check for kcalloc() in test_len()
      e1000: fix OOB in e1000_tbi_should_accept()

Gui-Dong Han (3):
      hwmon: (max16065) Use local variable to avoid TOCTOU
      hwmon: (w83791d) Convert macros to functions to avoid TOCTOU
      hwmon: (w83l786ng) Convert macros to functions to avoid TOCTOU

H. Peter Anvin (1):
      compiler_types.h: add "auto" as a macro for "__auto_type"

Haibo Chen (1):
      ext4: clear i_state_flags when alloc inode

Hal Feng (1):
      cpufreq: dt-platdev: Add JH7110S SOC to the allowlist

Hangbin Liu (1):
      hsr: hold rcu and dev lock for hsr_get_port_ndev

Hans de Goede (2):
      wifi: brcmfmac: Add DMI nvram filename quirk for Acer A1 840 tablet
      HID: logitech-dj: Remove duplicate error logging

Haotian Zhang (5):
      ALSA: vxpocket: Fix resource leak in vxpocket_probe error path
      ALSA: pcmcia: Fix resource leak in snd_pdacf_probe error path
      media: rc: st_rc: Fix reset control resource leak
      media: cec: Fix debugfs leak on bus_register() failure
      media: videobuf2: Fix device reference leak in vb2_dc_alloc error path

Haoxiang Li (7):
      MIPS: Fix a reference leak bug in ip22_check_gio()
      usb: typec: altmodes/displayport: Drop the device reference in dp_altmode_probe()
      usb: renesas_usbhs: Fix a resource leak in usbhs_pipe_malloc()
      xfs: fix a memory leak in xfs_buf_item_init()
      media: mediatek: vcodec: Fix a reference leak in mtk_vcodec_fw_vpu_init()
      fjes: Add missing iounmap in fjes_hw_init()
      nfsd: Drop the client reference in client_states_open()

Harshit Agarwal (1):
      sched/rt: Fix race in push_rt_task

Helge Deller (1):
      parisc: Do not reprogram affinitiy on ASP chip

Hengqi Chen (2):
      LoongArch: BPF: Zero-extend bpf_tail_call() index
      LoongArch: BPF: Sign extend kfunc call arguments

Herbert Xu (1):
      crypto: seqiv - Do not use req->iv after crypto_aead_encrypt

Honggang LI (1):
      RDMA/rtrs: Fix clt_path::max_pages_per_mr calculation

Hongyu Xie (1):
      usb: xhci: limit run_graceperiod for only usb 3.0 devices

Huacai Chen (2):
      LoongArch: Add new PCI ID for pci_fixup_vgadev()
      LoongArch: Fix build errors for CONFIG_RANDSTRUCT

Ian Rogers (1):
      libperf cpumap: Fix perf_cpu_map__max for an empty/NULL map

Ido Schimmel (4):
      mlxsw: spectrum_router: Fix possible neighbour reference count leak
      mlxsw: spectrum_router: Fix neighbour use-after-free
      mlxsw: spectrum_mr: Fix use-after-free when updating multicast route stats
      ipv4: Fix reference count leak when using error routes with nexthop objects

Ilya Dryomov (1):
      libceph: make decode_pool() more resilient against corrupted osdmaps

Ilya Maximets (1):
      net: openvswitch: fix middle attribute validation in push_nsh() action

Ivan Abramov (2):
      media: adv7842: Avoid possible out-of-bounds array accesses in adv7842_cp_log_status()
      media: msp3400: Avoid possible out-of-bounds array accesses in msp3400c_thread()

Jacky Chou (1):
      net: mdio: aspeed: add dummy read to avoid read-after-write issue

Jaegeuk Kim (1):
      f2fs: drop inode from the donation list when the last file is closed

Jamal Hadi Salim (1):
      net/sched: ets: Always remove class from active list before deleting in ets_qdisc_change

Jan Maslak (1):
      drm/xe: Restore engine registers before restarting schedulers after GT reset

Jan Prusakowski (1):
      f2fs: ensure node page reads complete before f2fs_put_super() finishes

Jang Ingyu (1):
      RDMA/core: Fix logic error in ib_get_gids_from_rdma_hdr()

Jani Nikula (3):
      drm/displayid: pass iter to drm_find_displayid_extension()
      drm/edid: add DRM_EDID_IDENT_INIT() to initialize struct drm_edid_ident
      drm/displayid: add quirk to ignore DisplayID checksum errors

Jared Kangas (1):
      mmc: sdhci-esdhc-imx: add alternate ARCH_S32 dependency to Kconfig

Jarkko Sakkinen (3):
      KEYS: trusted: Fix a memory leak in tpm2_load_cmd
      tpm: Cap the number of PCR banks
      tpm2-sessions: Fix tpm2_read_public range checks

Jason Gunthorpe (4):
      iommufd/selftest: Make it clearer to gcc that the access is not out of bounds
      iommufd/selftest: Check for overflow in IOMMU_TEST_OP_ADD_RESERVED
      RDMA/core: Check for the presence of LS_NLA_TYPE_DGID correctly
      RDMA/cm: Fix leaking the multicast GID table reference

Jay Cornwall (1):
      drm/amdkfd: Trap handler support for expert scheduling mode

Jens Axboe (2):
      io_uring/poll: correctly handle io_poll_add() return value on update
      io_uring: fix min_wait wakeups for SQPOLL

Jens Reidel (1):
      clk: qcom: dispcc-sm7150: Fix dispcc_mdss_pclk0_clk_src

Jeongjun Park (2):
      media: dvb-usb: dtv5100: fix out-of-bounds in dtv5100_i2c_msg()
      media: vidtv: initialize local pointers upon transfer of memory ownership

Jian Shen (3):
      net: hns3: using the num_tqps in the vf driver to apply for resources
      net: hns3: using the num_tqps to check whether tqp_index is out of range when vf get ring info from mbx
      net: hns3: add VLAN id validation before using

Jianpeng Chang (1):
      arm64: kdump: Fix elfcorehdr overlap caused by reserved memory processing reorder

Jiayuan Chen (2):
      ipv6: fix a BUG in rt6_get_pcpu_route() under PREEMPT_RT
      mm/kasan: fix incorrect unpoisoning in vrealloc for KASAN

Jim Mattson (2):
      KVM: SVM: Mark VMCB_NPT as dirty on nested VMRUN
      KVM: SVM: Mark VMCB_PERM_MAP as dirty on nested VMRUN

Jim Quinlan (2):
      PCI: brcmstb: Set MLW based on "num-lanes" DT property if present
      PCI: brcmstb: Fix disabling L0s capability

Jinhui Guo (5):
      ipmi: Fix the race between __scan_channels() and deliver_response()
      ipmi: Fix __scan_channels() failing to rescan channels
      i2c: designware: Disable SMBus interrupts to prevent storms from mis-configured firmware
      iommu/amd: Fix pci_segment memleak in alloc_pci_segment()
      iommu/amd: Propagate the error code returned by __modify_irte_ga() in modify_irte_ga()

Jiri Pirko (1):
      team: fix check for port enabled in team_queue_override_port_prio_changed()

Jiri Slaby (SUSE) (2):
      tty: introduce and use tty_port_tty_vhangup() helper
      tty: fix tty_port_tty_*hangup() kernel-doc

Joanne Koong (3):
      iomap: adjust read range correctly for non-block-aligned positions
      iomap: account for unaligned end offsets when truncating read range
      fuse: fix readahead reclaim deadlock

Johan Hovold (34):
      phy: broadcom: bcm63xx-usbh: fix section mismatches
      usb: ohci-nxp: fix device leak on probe failure
      usb: phy: isp1301: fix non-OF device reference imbalance
      usb: gadget: lpc32xx_udc: fix clock imbalance in error path
      amba: tegra-ahb: Fix device leak on SMMU enable
      soc: samsung: exynos-pmu: fix device leak on regmap lookup
      soc: qcom: pbs: fix device leak on lookup
      soc: qcom: ocmem: fix device leak on lookup
      soc: apple: mailbox: fix device leak on lookup
      soc: amlogic: canvas: fix device leak on lookup
      hwmon: (max6697) fix regmap leak on probe failure
      iommu/mediatek: fix use-after-free on probe deferral
      ASoC: codecs: wcd939x: fix regmap leak on probe failure
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
      media: platform: mtk-mdp3: fix device leaks at probe
      media: vpif_capture: fix section mismatch
      media: vpif_display: fix section mismatch
      drm/mediatek: Fix probe resource leaks
      drm/mediatek: Fix probe memory leak
      drm/mediatek: Fix probe device leaks
      serial: core: fix OF node leak

Johannes Berg (2):
      wifi: cfg80211: stop radar detection in cfg80211_leave()
      wifi: cfg80211: use cfg80211_leave() in iftype change

John Garry (1):
      scsi: scsi_debug: Fix atomic write enable module param description

Jonas Gorski (1):
      net: dsa: b53: skip multicast entries for fdb_dump()

Jonathan Kim (1):
      drm/amdkfd: bump minimum vgpr size for gfx1151

Josef Bacik (1):
      btrfs: don't rewrite ret from inode_permission

Joshua Hay (8):
      idpf: add support for SW triggered interrupts
      idpf: trigger SW interrupt when exiting wb_on_itr mode
      idpf: add support for Tx refillqs in flow scheduling mode
      idpf: improve when to set RE bit logic
      idpf: simplify and fix splitq Tx packet rollback error path
      idpf: replace flow scheduling buffer ring with buffer pool
      idpf: stop Tx if there are insufficient buffer resources
      idpf: remove obsolete stashing code

Joshua Rogers (4):
      svcrdma: return 0 on success from svc_rdma_copy_inline_range
      svcrdma: use rc_pageoff for memcpy byte offset
      SUNRPC: svcauth_gss: avoid NULL deref on zero length gss_token in gss_read_proxy_verf
      svcrdma: bound check rq_pages index in inline path

Josua Mayer (1):
      clk: mvebu: cp110 add CLK_IGNORE_UNUSED to pcie_x10, pcie_x11 & pcie_x4

Juergen Gross (1):
      x86/xen: Fix sparse warning in enlighten_pv.c

Junbeom Yeom (1):
      erofs: fix unexpected EIO under memory pressure

Junjie Cao (1):
      Input: ti_am335x_tsc - fix off-by-one error in wire_order validation

Junrui Luo (6):
      caif: fix integer underflow in cffrml_receive()
      hwmon: (ibmpex) fix use-after-free in high/low store
      scsi: aic94xx: fix use-after-free in device removal path
      ALSA: wavefront: Clear substream pointers on close
      platform/x86: ibm_rtl: fix EBDA signature search pointer arithmetic
      platform/x86: hp-bioscfg: Fix out-of-bounds array access in ACPI package parsing

Junxiao Chang (2):
      drm/me/gsc: mei interrupt top half should be in irq disabled context
      mei: gsc: add dependency on Xe driver

Justin Iurman (1):
      net: ipv6: ioam6: use consistent dst names

Justin Tee (1):
      nvme-fabrics: add ENOKEY to no retry criteria for authentication failures

Kalesh AP (1):
      RDMA/bnxt_re: Fix to use correct page size for PDE table

Karina Yankevich (1):
      ext4: xattr: fix null pointer deref in ext4_raw_inode()

Kartik Rajput (1):
      soc/tegra: fuse: Do not register SoC device on ACPI boot

Kaushlendra Kumar (1):
      tools/mm/page_owner_sort: fix timestamp comparison for stable sorting

Kevin Tian (1):
      vfio/pci: Disable qword access to the PCI ROM bar

Kohei Enju (1):
      iavf: fix off-by-one issues in iavf_config_rss_reg()

Konstantin Komarov (3):
      fs/ntfs3: Support timestamps prior to epoch
      fs/ntfs3: check for shutdown in fsync
      fs/ntfs3: fix mount failure for sparse runs in run_unpack()

Krzysztof Kozlowski (8):
      dt-bindings: PCI: qcom,pcie-sc7280: Add missing required power-domains and resets
      dt-bindings: PCI: qcom,pcie-sc8280xp: Add missing required power-domains and resets
      dt-bindings: PCI: qcom,pcie-sm8150: Add missing required power-domains and resets
      dt-bindings: PCI: qcom,pcie-sm8250: Add missing required power-domains and resets
      dt-bindings: PCI: qcom,pcie-sm8350: Add missing required power-domains and resets
      dt-bindings: PCI: qcom,pcie-sm8450: Add missing required power-domains and resets
      dt-bindings: PCI: qcom,pcie-sm8550: Add missing required power-domains and resets
      mfd: max77620: Fix potential IRQ chip conflict when probing two devices

Krzysztof Niemiec (1):
      drm/i915/gem: Zero-initialize the eb.vma array in i915_gem_do_execbuffer

Laurent Pinchart (2):
      media: v4l2-mem2mem: Fix outdated documentation
      media: amphion: Make some vpu_v4l2 functions static

Li Chen (1):
      block: rate-limit capacity change info log

Li Nan (1):
      md: Fix static checker warning in analyze_sbs

Li Qiang (1):
      via_wdt: fix critical boot hang due to unnamed resource allocation

Lizhi Xu (1):
      usbip: Fix locking bug in RT-enabled kernels

Lu Baolu (1):
      iommu: disable SVA when CONFIG_X86 is set

Lukas Wunner (1):
      PCI/PM: Reinstate clearing state_saved in legacy and !PM codepaths

Lyude Paul (1):
      drm/nouveau/dispnv50: Don't call drm_atomic_get_crtc_state() in prepare_fb

Ma Ke (4):
      perf: arm_cspmu: fix error handling in arm_cspmu_impl_unregister()
      USB: lpc32xx_udc: Fix error handling in probe
      intel_th: Fix error handling in intel_th_output_open
      i2c: amd-mp2: fix reference leak in MP2 PCI device

Maciej Wieczor-Retman (2):
      kasan: refactor pcpu kasan vmalloc unpoison
      kasan: unpoison vms[area] addresses with a common tag

Mahesh Rao (1):
      firmware: stratix10-svc: Add mutex in stratix10 memory management

Marc Kleine-Budde (1):
      can: gs_usb: gs_can_open(): fix error handling

Marc Zyngier (1):
      arm64: Revamp HCR_EL2.E2H RES1 detection

Marek Szyprowski (1):
      media: samsung: exynos4-is: fix potential ABBA deadlock on init

Marijn Suijten (1):
      drm/panel: sony-td4353-jdi: Enable prepare_prev_first

Mario Limonciello (3):
      Revert "drm/amd/display: Fix pbn to kbps Conversion"
      drm/amdkfd: Export the cwsr_size and ctl_stack_size to userspace
      gpiolib: acpi: Add a quirk for Acer Nitro V15

Mario Limonciello (AMD) (2):
      Revert "drm/amd: Skip power ungate during suspend for VPE"
      gpiolib: acpi: Add quirk for ASUS ProArt PX13

Mark Pearson (1):
      usb: typec: ucsi: Handle incorrect num_connectors capability

Mark Rutland (1):
      KVM: arm64: Initialize HCR_EL2.E2H early

Matthew Brost (2):
      drm/xe: Adjust long-running workload timeslices to reasonable values
      drm/xe: Use usleep_range for accurate long-running workload timeslicing

Matthew Wilcox (Oracle) (2):
      ntfs: Do not overwrite uptodate pages
      idr: fix idr_alloc() returning an ID out of range

Matthias Schiffer (1):
      ti-sysc: allow OMAP2 and OMAP4 timers to be reserved on AM33xx

Matthieu Baerts (NGI0) (2):
      selftests: mptcp: pm: ensure unknown flags are ignored
      mptcp: pm: ignore unknown endpoint flags

Max Chou (1):
      Bluetooth: btusb: Add new VID/PID 0x0489/0xE12F for RTL8852BE-VT

Maxim Levitsky (1):
      KVM: x86: Don't clear async #PF queue when CR0.PG is disabled (e.g. on #SMI)

Miaoqian Lin (5):
      usb: dwc3: of-simple: fix clock resource leak in dwc3_of_simple_probe
      cpufreq: nforce2: fix reference count leak in nforce2
      virtio: vdpa: Fix reference count leak in octep_sriov_enable()
      media: renesas: rcar_drif: fix device node reference leak in rcar_drif_bond_enabled
      drm/mediatek: Fix device node reference leak in mtk_dp_dt_parse()

Michael Chan (1):
      bnxt_en: Fix XDP_TX path

Michael Margolin (1):
      RDMA/efa: Remove possible negative shift

Michal Schmidt (1):
      RDMA/irdma: avoid invalid read in irdma_net_event

Mike Snitzer (2):
      nfsd: update percpu_ref to manage references on nfsd_net
      nfsd: rename nfsd_serv_ prefixed methods and variables with nfsd_net_

Mikhail Malyshev (1):
      kbuild: Use objtree for module signing key path

Mikulas Patocka (1):
      dm-bufio: align write boundary on physical block size

Ming Qian (3):
      media: amphion: Cancel message work before releasing the VPU core
      media: amphion: Add a frame flush mode for decoder
      media: amphion: Remove vpu_vb_is_codecconfig

Minseong Kim (1):
      Input: lkkbd - disable pending work before freeing device

Miquel Raynal (6):
      mtd: spi-nor: winbond: Add support for W25Q01NWxxIQ chips
      mtd: spi-nor: winbond: Add support for W25Q01NWxxIM chips
      mtd: spi-nor: winbond: Add support for W25Q02NWxxIM chips
      mtd: spi-nor: winbond: Add support for W25H512NWxxAM chips
      mtd: spi-nor: winbond: Add support for W25H01NWxxAM chips
      mtd: spi-nor: winbond: Add support for W25H02NWxxAM chips

Morning Star (1):
      wifi: rtlwifi: 8192cu: fix tid out of range in rtl92cu_tx_fill_desc()

Moshe Shemesh (2):
      net/mlx5: fw reset, clear reset requested on drain_fw_reset
      net/mlx5: Drain firmware reset in shutdown callback

Nam Cao (2):
      hrtimers: Introduce hrtimer_update_function()
      serial: xilinx_uartps: Use helper function hrtimer_update_function()

Namjae Jeon (3):
      ksmbd: fix use-after-free in ksmbd_tree_connect_put under concurrency
      ksmbd: Fix refcount leak when invalid session is found on session lookup
      ksmbd: fix buffer validation by including null terminator size in EA length

Nathan Chancellor (1):
      clk: samsung: exynos-clkout: Assign .num before accessing .hws

NeilBrown (1):
      lockd: fix vfs_test_lock() calls

Nicolas Dufresne (2):
      media: verisilicon: Fix CPU stalls on G2 bus error
      media: verisilicon: Protect G2 HEVC decoder against invalid DPB index

Nicolas Ferre (2):
      ARM: dts: microchip: sama5d2: fix spi flexcom fifo size to 32
      ARM: dts: microchip: sama7g5: fix uart fifo size to 32

Nicolin Chen (1):
      iommufd/selftest: Update hw_info coverage for an input data_type

Nikolay Kuratov (1):
      drm/msm/dpu: Add missing NULL pointer check for pingpong interface

Nuno Sá (1):
      hwmon: (ltc4282): Fix reset_history file permissions

Nysal Jan K.A. (1):
      powerpc/kexec: Enable SMT before waking offline CPUs

Ondrej Mosnacek (1):
      bpf, arm64: Do not audit capability check in do_jit()

Pablo Neira Ayuso (1):
      netfilter: nf_tables: remove redundant chain validation on register store

Pankaj Raghav (1):
      scripts/faddr2line: Fix "Argument list too long" error

Paolo Abeni (2):
      mptcp: schedule rtx timer only after pushing data
      mptcp: avoid deadlock on fallback while reinjecting

Pedro Demarchi Gomes (1):
      ntfs: set dummy blocksize to read boot_block when mounting

Pei Xiao (1):
      iio: adc: ti_am335x_adc: Limit step_avg to valid range for gcc complains

Peng Fan (1):
      firmware: imx: scu-irq: Init workqueue before request mbox channel

Pengjie Zhang (2):
      ACPI: PCC: Fix race condition by removing static qualifier
      ACPI: CPPC: Fix missing PCC check for guaranteed_perf

Peter Wang (1):
      scsi: ufs: host: mediatek: Fix shutdown/suspend race condition

Peter Zijlstra (3):
      sched/fair: Revert max_newidle_lb_cost bump
      x86/ptrace: Always inline trivial accessors
      sched/eevdf: Fix min_vruntime vs avg_vruntime

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: add missing lock to amdgpu_ttm_access_memory_sdma

Pierre-Louis Bossart (1):
      soundwire: stream: extend sdw_alloc_stream() to take 'type' parameter

Ping Cheng (1):
      HID: input: map HID_GD_Z to ABS_DISTANCE for stylus/pen

Ping-Ke Shih (1):
      wifi: rtw88: limit indirect IO under powered off for RTL8822CS

Prithvi Tambewagh (2):
      io_uring: fix filename leak in __io_openat_prep()
      ocfs2: fix kernel BUG in ocfs2_find_victim_chain

Przemyslaw Korba (1):
      i40e: fix scheduling in set_rx_mode

Pwnverse (1):
      net: rose: fix invalid array index in rose_kill_by_device()

Qianchang Zhao (2):
      ksmbd: vfs: fix race on m_flags in vfs_cache
      ksmbd: skip lock-range check on equal size to avoid size==0 underflow

Qiang Ma (1):
      LoongArch: Correct the calculation logic of thread_count

Qu Wenruo (2):
      btrfs: fix a potential path leak in print_data_reloc_error()
      btrfs: scrub: always update btrfs_scrub_progress::last_physical

Quan Zhou (4):
      wifi: mt76: mt792x: fix wifi init fail by setting MCU_RUNNING after CLC load
      wifi: mt76: mt7925: fix the unfinished command of regd_notifier before suspend
      wifi: mt76: mt7925: fix CLC command timeout when suspend/resume
      wifi: mt76: mt7925: add handler to hif suspend/resume event

Rafael J. Wysocki (2):
      cpuidle: governors: teo: Drop misguided target residency check
      PM: runtime: Do not clear needs_force_resume with enabled runtime PM

Raju Rangoju (1):
      amd-xgbe: reset retries and mode on RX adapt failures

Ran Xiaokai (1):
      mm/page_owner: fix memory leak in page_owner_stack_fops->release()

Raphael Pinsonneault-Thibeault (1):
      Bluetooth: btusb: revert use of devm_kzalloc in btusb

Raviteja Laggyshetty (1):
      interconnect: qcom: sdx75: Drop QPIC interconnect and BCM nodes

Ray Wu (2):
      drm/amd/display: Fix scratch registers offsets for DCN35
      drm/amd/display: Fix scratch registers offsets for DCN351

Rene Rebe (2):
      floppy: fix for PAGE_SIZE != 4KB
      fbdev: gbefb: fix to use physical address instead of dma address

René Rebe (3):
      r8169: fix RTL8117 Wake-on-Lan in DASH mode
      fbdev: tcx.c fix mem_map to correct smem_start offset
      drm/mgag200: Fix big-endian support

Rong Zhang (1):
      x86/microcode/AMD: Fix Entrysign revision check for Zen5/Strix Halo

Sai Krishna Potthuri (1):
      mmc: sdhci-of-arasan: Increase CD stable timeout to 2 seconds

Sakari Ailus (1):
      ACPI: property: Use ACPI functions in acpi_graph_get_next_endpoint() only

Sandipan Das (1):
      perf/x86/amd/uncore: Fix the return value of amd_uncore_df_event_init() on error

Sanjay Yadav (1):
      drm/xe/oa: Fix potential UAF in xe_oa_add_config_ioctl()

Sarthak Garg (1):
      mmc: sdhci-msm: Avoid early clock doubling during HS400 transition

Scott Mayhew (1):
      net/handshake: duplicate handshake cancellations leak socket

Sean Christopherson (4):
      KVM: Disallow toggling KVM_MEM_GUEST_MEMFD on an existing memslot
      KVM: x86: WARN if hrtimer callback for periodic APIC timer fires with period=0
      KVM: nSVM: Set exit_code_hi to -1 when synthesizing SVM_EXIT_ERR (failed VMRUN)
      KVM: nSVM: Clear exit_code_hi in VMCB when synthesizing nested VM-Exits

SeongJae Park (16):
      mm/damon/tests/sysfs-kunit: handle alloc failures on damon_sysfs_test_add_targets()
      mm/damon/tests/vaddr-kunit: handle alloc failures in damon_test_split_evenly_fail()
      mm/damon/tests/vaddr-kunit: handle alloc failures on damon_test_split_evenly_succ()
      mm/damon/tests/core-kunit: handle alloc failures on damon_test_split_at()
      mm/damon/tests/core-kunit: handle allocation failures in damon_test_regions()
      mm/damon/tests/core-kunit: handle memory failure from damon_test_target()
      mm/damon/tests/core-kunit: handle memory alloc failure from damon_test_aggregate()
      mm/damon/tests/core-kunit: handle alloc failures on dasmon_test_merge_regions_of()
      mm/damon/tests/core-kunit: handle alloc failures on damon_test_merge_two()
      mm/damon/tests/core-kunit: handle alloc failures in damon_test_set_regions()
      mm/damon/tests/core-kunit: handle alloc failures in damon_test_update_monitoring_result()
      mm/damon/tests/core-kunit: handle alloc failures in damon_test_ops_registration()
      mm/damon/tests/core-kunit: handle alloc failure on damon_test_set_attrs()
      mm/damon/tests/core-kunit: handle alloc failures on damon_test_split_regions_of()
      mm/damon/tests/core-kunit: handle alloc failres in damon_test_new_filter()
      mm/damon/tests/vaddr-kunit: handle alloc failures on damon_do_test_apply_three_regions()

Seunghwan Baek (1):
      scsi: ufs: core: Add ufshcd_update_evt_hist() for UFS suspend error

Shardul Bankar (1):
      nfsd: fix memory leak in nfsd_create_serv error paths

Shaurya Rane (1):
      net/hsr: fix NULL pointer dereference in prp_get_untagged_frame()

Shay Drory (3):
      net/mlx5: fw_tracer, Validate format string parameters
      net/mlx5: fw_tracer, Handle escaped percent properly
      net/mlx5: Serialize firmware reset with devlink

Sheng Yong (1):
      f2fs: clear SBI_POR_DOING before initing inmem curseg

Shengjiu Wang (1):
      ASoC: ak4458: remove the reset operation in probe and remove

Shengming Hu (2):
      fgraph: Initialize ftrace_ops->private for function graph ops
      fgraph: Check ftrace_pids_enabled on registration for early filtering

Shipei Qu (1):
      ALSA: usb-mixer: us16x08: validate meter packet indices

Shivani Agarwal (1):
      crypto: af_alg - zero initialize memory allocated via sock_kmalloc

Shravan Kumar Ramani (1):
      platform/mellanox: mlxbf-pmc: Remove trailing whitespaces from event names

Shuhao Fu (1):
      cpufreq: s5pv210: fix refcount leak

Shuicheng Lin (2):
      drm/xe: Limit num_syncs to prevent oversized allocations
      drm/xe/oa: Limit num_syncs to prevent oversized allocations

Siddharth Vadapalli (1):
      arm64: dts: ti: k3-j721e-sk: Fix pinmux for pin Y1 used by power regulator

Simon Richter (1):
      drm/ttm: Avoid NULL pointer deref for evicted BOs

Slavin Liu (1):
      ipvs: fix ipv4 null-ptr-deref in route error path

Song Liu (1):
      livepatch: Match old_sympos 0 and 1 in klp_find_func()

Srinivas Kandagatla (7):
      rpmsg: glink: fix rpmsg device leak
      ASoC: codecs: lpass-tx-macro: fix SM6115 support
      ASoC: qcom: q6apm-dai: set flags to reflect correct operation of appl_ptr
      ASoC: qcom: q6asm-dai: perform correct state check before closing
      ASoC: qcom: q6adm: the the copp device only during last instance
      ASoC: qcom: qdsp6: q6asm-dai: set 10 ms period and buffer alignment.
      ASoC: qcom: sdw: fix memory leak for sdw_stream_runtime

Stanimir Varbanov (1):
      PCI: brcmstb: Reuse pcie_cfg_data structure

Stefan Haberland (1):
      s390/dasd: Fix gendisk parent after copy pair swap

Stefano Garzarella (1):
      vhost/vsock: improve RCU read sections around vhost_vsock_get()

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

Takashi Iwai (1):
      ALSA: wavefront: Use guard() for spin locks

Tejun Heo (2):
      sched_ext: Factor out local_dsq_post_enq() from dispatch_enqueue()
      sched_ext: Fix missing post-enqueue handling in move_local_task_to_local_dsq()

Tetsuo Handa (3):
      hfsplus: Verify inode mode when loading from disk
      jbd2: use a per-journal lock_class_key for jbd2_trans_commit_key
      RDMA/core: always drop device refcount in ib_del_sub_device_and_put()

Thomas De Schampheleire (1):
      kbuild: fix compilation of dtb specified on command-line without make rule

Thomas Fourier (4):
      block: rnbd-clt: Fix leaked ID in init_dev()
      platform/x86: msi-laptop: add missing sysfs_remove_group()
      firewire: nosy: Fix dma_free_coherent() size
      RDMA/bnxt_re: fix dma_free_coherent() pointer

Thomas Gleixner (2):
      x86/msi: Make irq_retrigger() functional for posted MSI
      hrtimers: Make hrtimer_update_function() less expensive

Thomas Hellström (2):
      drm/xe/bo: Don't include the CCS metadata in the dma-buf sg-table
      drm/xe: Drop preempt-fences when destroying imported dma-bufs.

Thomas Weißschuh (1):
      leds: leds-cros_ec: Skip LEDs without color components

Thomas Zimmermann (1):
      drm/gma500: Remove unused helper psb_fbdev_fb_setcolreg()

Thorsten Blum (2):
      net: phy: marvell-88q2xxx: Fix clamped value in mv88q2xxx_hwmon_write
      fbdev: pxafb: Fix multiple clamped values in pxafb_adjust_timing

Tianchu Chen (1):
      char: applicom: fix NULL pointer dereference in ac_ioctl

Tiezhu Yang (1):
      LoongArch: Use unsigned long for _end and _text

Toke Høiland-Jørgensen (1):
      net: openvswitch: Avoid needlessly taking the RTNL on vport destroy

Tony Battersby (4):
      scsi: qla2xxx: Fix lost interrupts with qlini_mode=disabled
      scsi: qla2xxx: Fix initiator mode with qlini_mode=exclusive
      scsi: qla2xxx: Use reinit_completion on mbx_intr_comp
      scsi: Revert "scsi: qla2xxx: Perform lockless command completion in abort path"

Tuo Li (1):
      md/raid5: fix possible null-pointer dereferences in raid5_store_group_thread_cnt()

Tzung-Bi Shih (1):
      platform/chrome: cros_ec_ishtp: Fix UAF after unbinding driver

Udipto Goswami (1):
      usb: dwc3: keep susphy enabled during exit to avoid controller faults

Uladzislau Rezki (Sony) (1):
      dm-ebs: Mark full buffer dirty even on partial write

Viacheslav Dubeyko (2):
      hfsplus: fix volume corruption issue for generic/070
      hfsplus: fix volume corruption issue for generic/073

Victor Nogueira (1):
      net/sched: ets: Remove drr class from the active list if it changes to strict

Vivian Wang (1):
      lib/crypto: riscv/chacha: Avoid s0/fp register

Vladimir Oltean (1):
      net: dsa: fix missing put_device() in dsa_tree_find_first_conduit()

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

Xiao Ni (1):
      md/raid10: wait barrier before returning discard request with REQ_NOWAIT

Xiaole He (2):
      f2fs: fix age extent cache insertion skip on counter overflow
      f2fs: fix uninitialized one_time_gc in victim_sel_policy

Xiaolei Wang (1):
      net: macb: Relocate mog_init_rings() callback from macb_mac_link_up() to macb_open()

Yang Chenzhi (1):
      hfsplus: fix missing hfs_bnode_get() in __hfs_bnode_create

Ye Bin (1):
      jbd2: fix the inconsistency between checksum and data in memory for journal sb

Yeoreum Yun (1):
      smc91x: fix broken irq-context in PREEMPT_RT

Yi Liu (1):
      iommufd/selftest: Add coverage for reporting max_pasid_log2 via IOMMU_HW_INFO

Yipeng Zou (1):
      selftests/ftrace: traceonoff_triggers: strip off names

Yongjian Sun (1):
      ext4: fix incorrect group number assertion in mb_check_buddy

Yongxin Liu (1):
      x86/fpu: Fix FPU state core dump truncation on CPUs with no extended xfeatures

Yosry Ahmed (2):
      KVM: nSVM: Avoid incorrect injection of SVM_EXIT_CR0_SEL_WRITE
      KVM: nSVM: Propagate SVM_EXIT_CR0_SEL_WRITE correctly for LMSW emulation

Yuezhang Mo (2):
      exfat: fix remount failure in different process environments
      exfat: zero out post-EOF page cache on file extension

Zheng Yejian (1):
      kallsyms: Fix wrong "big" kernel symbol type read from procfs

Zhichi Lin (1):
      scs: fix a wrong parameter in __scs_magic

Zilin Guan (3):
      cifs: Fix memory and information leak in smb3_reconfigure()
      vfio/pds: Fix memory leak in pds_vfio_dirty_enable()
      ksmbd: Fix memory leak in get_file_all_info()

Zqiang (2):
      sched_ext: Fix incorrect sched_class settings for per-cpu migration tasks
      usbnet: Fix using smp_processor_id() in preemptible code warnings

caoping (1):
      net/handshake: restore destructor on submit failure

fuqiang wang (2):
      KVM: x86: Explicitly set new periodic hrtimer expiration in apic_timer_fn()
      KVM: x86: Fix VM hard lockup after prolonged inactivity with periodic HV timer

j.turek (1):
      serial: xilinx_uartps: fix rs485 delay_rts_after_send

xu xin (1):
      mm/ksm: fix exec/fork inheritance support for prctl

Łukasz Bartosik (1):
      xhci: dbgtty: fix device unregister: fixup


