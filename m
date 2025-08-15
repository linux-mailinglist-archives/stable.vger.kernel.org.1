Return-Path: <stable+bounces-169730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 682B0B2825F
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 16:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4938C18941B7
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 14:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E22122FF22;
	Fri, 15 Aug 2025 14:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JtU5jy2i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB3918DB37;
	Fri, 15 Aug 2025 14:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755269188; cv=none; b=c5hWUZ5sVK3FM95I3meltSgUTNxjIW3Kypq58QZeowccPhkPslRhwO1JdTDVK9w16P2DIAVCE1NbR41m6h7qX+CX+y9H47qygQop55HQ5RObO6Sc9IvtpF5Kg9kZWKa+2JRPtk8Ym3oPqkuv/OAR74UrLqRQKX48YSXhMHtbFNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755269188; c=relaxed/simple;
	bh=sIy5d8xNgNDgethaJddo1xaU8L0CMpg3IbBkUotd+2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sBDCRWLSlbaRr8WL8NG+FG9xbnka2IGS5+q68apK6Dx4Q/zBjoQwxpCGE7tvB6blpBUjPbhfi4AbQFL0OzIdmq7C85fXUkTCFJI4TsNbcqBZ9jMUxhgDvC//Q90KHTAranvOWaF0mwqLQIUo1n6nuVWHEjlaHFPXlemiLEvcLew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JtU5jy2i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C0FC4CEEB;
	Fri, 15 Aug 2025 14:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755269188;
	bh=sIy5d8xNgNDgethaJddo1xaU8L0CMpg3IbBkUotd+2o=;
	h=From:To:Cc:Subject:Date:From;
	b=JtU5jy2i2h6yKAuDa9py5W1aT8Ecg717bspbh1HsEWrMNLlRlT5UFIwZlxSgcMz/n
	 C3+WAsHvWIrazCFIZAK7lSmTIcXcIbaKUiGadLqsROAzgYSNrVPTiG0Ovrkh9qD144
	 VYL5BwJMPHIaCTb6bipPdWQTVPOQ6F1OVUUory88=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.16.1
Date: Fri, 15 Aug 2025 16:46:22 +0200
Message-ID: <2025081523-tapered-snarl-0875@gregkh>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.16.1 kernel.

All users of the 6.16 kernel series must upgrade.

The updated 6.16.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.16.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 .gitignore                                                        |    1 
 Documentation/admin-guide/kernel-parameters.txt                   |    8 
 Documentation/filesystems/f2fs.rst                                |    6 
 Documentation/netlink/specs/ethtool.yaml                          |    6 
 Makefile                                                          |    2 
 arch/arm/boot/dts/microchip/sam9x7.dtsi                           |    2 
 arch/arm/boot/dts/microchip/sama7d65.dtsi                         |    2 
 arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-common.dtsi           |    1 
 arch/arm/boot/dts/nxp/vf/vfxxx.dtsi                               |    2 
 arch/arm/boot/dts/ti/omap/am335x-boneblack.dts                    |    2 
 arch/arm/crypto/aes-neonbs-glue.c                                 |    2 
 arch/arm/mach-s3c/gpio-samsung.c                                  |    2 
 arch/arm64/boot/dts/exynos/google/gs101.dtsi                      |    3 
 arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi              |    2 
 arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi              |    2 
 arch/arm64/boot/dts/freescale/imx8mp-toradex-smarc-dev.dts        |    5 
 arch/arm64/boot/dts/freescale/imx8mp-toradex-smarc.dtsi           |    2 
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts            |    8 
 arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi                 |    6 
 arch/arm64/boot/dts/qcom/msm8976.dtsi                             |    2 
 arch/arm64/boot/dts/qcom/qcs615.dtsi                              |    4 
 arch/arm64/boot/dts/qcom/sa8775p.dtsi                             |   10 
 arch/arm64/boot/dts/qcom/sc7180.dtsi                              |   10 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                              |   10 
 arch/arm64/boot/dts/qcom/x1e80100.dtsi                            |    2 
 arch/arm64/boot/dts/qcom/x1p42100.dtsi                            |  556 ++++++++
 arch/arm64/boot/dts/renesas/Makefile                              |    1 
 arch/arm64/boot/dts/rockchip/px30-evb.dts                         |    3 
 arch/arm64/boot/dts/rockchip/px30-pp1516.dtsi                     |    3 
 arch/arm64/boot/dts/rockchip/px30.dtsi                            |    2 
 arch/arm64/boot/dts/rockchip/rk3528-pinctrl.dtsi                  |   20 
 arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts                |    1 
 arch/arm64/boot/dts/rockchip/rk3528.dtsi                          |   16 
 arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts                   |    6 
 arch/arm64/boot/dts/st/stm32mp251.dtsi                            |    2 
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi            |    2 
 arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi                       |    8 
 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts          |    2 
 arch/arm64/include/asm/gcs.h                                      |    2 
 arch/arm64/include/asm/kvm_host.h                                 |    4 
 arch/arm64/kernel/Makefile                                        |    2 
 arch/arm64/kernel/process.c                                       |    6 
 arch/arm64/kvm/hyp/exception.c                                    |    6 
 arch/arm64/kvm/hyp/vhe/switch.c                                   |   14 
 arch/arm64/net/bpf_jit_comp.c                                     |    1 
 arch/m68k/Kconfig.debug                                           |    2 
 arch/m68k/kernel/early_printk.c                                   |   42 
 arch/m68k/kernel/head.S                                           |    8 
 arch/mips/alchemy/common/gpiolib.c                                |   12 
 arch/mips/mm/tlb-r4k.c                                            |   56 
 arch/powerpc/configs/ppc6xx_defconfig                             |    1 
 arch/powerpc/kernel/eeh.c                                         |    1 
 arch/powerpc/kernel/eeh_driver.c                                  |   48 
 arch/powerpc/kernel/eeh_pe.c                                      |   10 
 arch/powerpc/kernel/pci-hotplug.c                                 |    3 
 arch/powerpc/platforms/pseries/dlpar.c                            |   52 
 arch/riscv/boot/dts/sophgo/sg2044-cpus.dtsi                       |   64 +
 arch/riscv/kvm/vcpu_onereg.c                                      |   83 -
 arch/s390/boot/startup.c                                          |    2 
 arch/s390/crypto/hmac_s390.c                                      |   12 
 arch/s390/crypto/sha.h                                            |    3 
 arch/s390/crypto/sha3_256_s390.c                                  |   24 
 arch/s390/crypto/sha3_512_s390.c                                  |   25 
 arch/s390/include/asm/ap.h                                        |    2 
 arch/s390/kernel/setup.c                                          |    6 
 arch/s390/mm/pgalloc.c                                            |    5 
 arch/s390/mm/vmem.c                                               |    5 
 arch/sh/Makefile                                                  |   10 
 arch/sh/boot/compressed/Makefile                                  |    4 
 arch/sh/boot/romimage/Makefile                                    |    4 
 arch/um/drivers/rtc_user.c                                        |    2 
 arch/x86/boot/cpuflags.c                                          |   13 
 arch/x86/boot/startup/sev-shared.c                                |    7 
 arch/x86/coco/sev/core.c                                          |   21 
 arch/x86/include/asm/cpufeatures.h                                |    1 
 arch/x86/include/asm/hw_irq.h                                     |   12 
 arch/x86/include/asm/kvm-x86-ops.h                                |    1 
 arch/x86/include/asm/kvm_host.h                                   |    8 
 arch/x86/include/asm/msr-index.h                                  |    1 
 arch/x86/include/asm/sev.h                                        |   19 
 arch/x86/kernel/cpu/bugs.c                                        |   56 
 arch/x86/kernel/cpu/scattered.c                                   |    1 
 arch/x86/kernel/irq.c                                             |   63 -
 arch/x86/kvm/svm/svm.c                                            |   14 
 arch/x86/kvm/vmx/main.c                                           |   15 
 arch/x86/kvm/vmx/tdx.c                                            |   18 
 arch/x86/kvm/vmx/vmx.c                                            |   16 
 arch/x86/kvm/vmx/x86_ops.h                                        |    4 
 arch/x86/kvm/x86.c                                                |   13 
 arch/x86/mm/extable.c                                             |    5 
 block/blk-mq.c                                                    |   84 +
 block/blk-settings.c                                              |   19 
 block/blk.h                                                       |    2 
 block/elevator.c                                                  |   10 
 crypto/ahash.c                                                    |   13 
 crypto/krb5/selftest.c                                            |    1 
 drivers/base/auxiliary.c                                          |    2 
 drivers/block/mtip32xx/mtip32xx.c                                 |   27 
 drivers/block/nbd.c                                               |   12 
 drivers/block/ublk_drv.c                                          |   49 
 drivers/block/zloop.c                                             |    3 
 drivers/bluetooth/btintel.c                                       |    4 
 drivers/bluetooth/btintel.h                                       |    2 
 drivers/bluetooth/btintel_pcie.c                                  |   42 
 drivers/bluetooth/btusb.c                                         |   14 
 drivers/bluetooth/hci_intel.c                                     |   10 
 drivers/bus/mhi/host/pci_generic.c                                |    8 
 drivers/char/hw_random/mtk-rng.c                                  |    4 
 drivers/clk/at91/sam9x7.c                                         |   20 
 drivers/clk/clk-axi-clkgen.c                                      |    2 
 drivers/clk/davinci/psc.c                                         |    5 
 drivers/clk/imx/clk-imx95-blk-ctl.c                               |   13 
 drivers/clk/renesas/rzv2h-cpg.c                                   |    1 
 drivers/clk/spacemit/ccu-k1.c                                     |    3 
 drivers/clk/spacemit/ccu_mix.h                                    |   11 
 drivers/clk/spacemit/ccu_pll.c                                    |    2 
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c                              |    3 
 drivers/clk/thead/clk-th1520-ap.c                                 |  104 -
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c                        |    2 
 drivers/clk/xilinx/xlnx_vcu.c                                     |    4 
 drivers/cpufreq/Makefile                                          |    1 
 drivers/cpufreq/armada-8k-cpufreq.c                               |    3 
 drivers/cpufreq/cpufreq.c                                         |   21 
 drivers/cpufreq/intel_pstate.c                                    |    4 
 drivers/cpufreq/powernv-cpufreq.c                                 |    4 
 drivers/cpufreq/powernv-trace.h                                   |   44 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c               |    4 
 drivers/crypto/ccp/ccp-debugfs.c                                  |    3 
 drivers/crypto/ccp/sev-dev.c                                      |   16 
 drivers/crypto/img-hash.c                                         |    2 
 drivers/crypto/inside-secure/safexcel_hash.c                      |    8 
 drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c               |    8 
 drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c            |    9 
 drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.c              |   20 
 drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.h              |    2 
 drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c            |   29 
 drivers/crypto/intel/qat/qat_common/adf_sriov.c                   |    1 
 drivers/crypto/intel/qat/qat_common/adf_transport_debug.c         |    4 
 drivers/crypto/intel/qat/qat_common/qat_bl.c                      |    6 
 drivers/crypto/intel/qat/qat_common/qat_compression.c             |    8 
 drivers/crypto/marvell/cesa/cipher.c                              |    4 
 drivers/crypto/marvell/cesa/hash.c                                |    5 
 drivers/cxl/core/core.h                                           |    1 
 drivers/cxl/core/edac.c                                           |    5 
 drivers/cxl/core/hdm.c                                            |    7 
 drivers/devfreq/devfreq.c                                         |   12 
 drivers/dma-buf/Kconfig                                           |    1 
 drivers/dma-buf/udmabuf.c                                         |   23 
 drivers/dma/mmp_tdma.c                                            |    2 
 drivers/dma/mv_xor.c                                              |   21 
 drivers/dma/nbpfaxi.c                                             |   13 
 drivers/firmware/arm_scmi/perf.c                                  |    2 
 drivers/firmware/efi/libstub/Makefile.zboot                       |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c                        |   24 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h                        |   25 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c               |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                        |   11 
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c                           |   39 
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c                          |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c                         |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                            |   38 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                            |   12 
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c                            |   12 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                             |    9 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c                           |   10 
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c                            |    8 
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c                            |    8 
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c                            |    8 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c                            |    8 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c                          |    8 
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c                          |    8 
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c                            |   20 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c                          |   35 
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c                            |    5 
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c                            |    5 
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c                            |    6 
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c                            |    6 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c                             |    7 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c                           |    6 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c                           |    7 
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c                           |    7 
 drivers/gpu/drm/amd/amdkfd/kfd_device.c                           |   54 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c               |    2 
 drivers/gpu/drm/display/drm_hdmi_state_helper.c                   |    4 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h           |    1 
 drivers/gpu/drm/panfrost/panfrost_devfreq.c                       |    4 
 drivers/gpu/drm/panthor/panthor_gem.c                             |   31 
 drivers/gpu/drm/panthor/panthor_gem.h                             |    3 
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c                        |    9 
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c                      |   29 
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h                      |   33 
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c                      |   89 +
 drivers/gpu/drm/sitronix/Kconfig                                  |   10 
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c                            |    2 
 drivers/gpu/drm/xe/xe_configfs.c                                  |    3 
 drivers/gpu/drm/xe/xe_device.c                                    |    1 
 drivers/gpu/drm/xe/xe_gt_sriov_pf.c                               |   32 
 drivers/gpu/drm/xe/xe_vsec.c                                      |   20 
 drivers/hid/hid-apple.c                                           |   20 
 drivers/hid/hid-core.c                                            |    6 
 drivers/hid/hid-magicmouse.c                                      |   62 
 drivers/i2c/muxes/i2c-mux-mule.c                                  |    3 
 drivers/i3c/master/svc-i3c-master.c                               |   22 
 drivers/infiniband/core/counters.c                                |    2 
 drivers/infiniband/core/device.c                                  |   27 
 drivers/infiniband/core/nldev.c                                   |    2 
 drivers/infiniband/core/rdma_core.c                               |   29 
 drivers/infiniband/core/uverbs_cmd.c                              |    7 
 drivers/infiniband/core/uverbs_std_types_qp.c                     |    2 
 drivers/infiniband/hw/erdma/erdma_verbs.c                         |    3 
 drivers/infiniband/hw/hns/hns_roce_device.h                       |    1 
 drivers/infiniband/hw/hns/hns_roce_hem.c                          |   18 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                        |   87 -
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h                        |    8 
 drivers/infiniband/hw/hns/hns_roce_main.c                         |   22 
 drivers/infiniband/hw/mana/qp.c                                   |    2 
 drivers/infiniband/hw/mlx5/devx.c                                 |    2 
 drivers/infiniband/hw/mlx5/dm.c                                   |    2 
 drivers/infiniband/hw/mlx5/fs.c                                   |    4 
 drivers/infiniband/hw/mlx5/umr.c                                  |    6 
 drivers/infiniband/ulp/ipoib/ipoib_main.c                         |    2 
 drivers/interconnect/qcom/sc8180x.c                               |    6 
 drivers/interconnect/qcom/sc8280xp.c                              |    1 
 drivers/iommu/amd/iommu.c                                         |   19 
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c                        |    3 
 drivers/iommu/intel/cache.c                                       |   18 
 drivers/iommu/intel/iommu.c                                       |    3 
 drivers/irqchip/Kconfig                                           |    1 
 drivers/leds/flash/Kconfig                                        |    1 
 drivers/leds/leds-lp8860.c                                        |    4 
 drivers/leds/leds-pca955x.c                                       |    4 
 drivers/md/dm-flakey.c                                            |    9 
 drivers/md/md.c                                                   |   41 
 drivers/md/raid10.c                                               |    3 
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c                    |   47 
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h                    |    1 
 drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c             |    1 
 drivers/media/v4l2-core/v4l2-ctrls-core.c                         |    8 
 drivers/mfd/tps65219.c                                            |    2 
 drivers/misc/mei/platform-vsc.c                                   |    8 
 drivers/misc/mei/vsc-tp.c                                         |   68 -
 drivers/misc/mei/vsc-tp.h                                         |    3 
 drivers/misc/sram.c                                               |   10 
 drivers/mtd/ftl.c                                                 |    2 
 drivers/mtd/nand/raw/atmel/nand-controller.c                      |    2 
 drivers/mtd/nand/raw/atmel/pmecc.c                                |    6 
 drivers/mtd/nand/raw/rockchip-nand-controller.c                   |   15 
 drivers/mtd/spi-nor/spansion.c                                    |   31 
 drivers/net/can/kvaser_pciefd.c                                   |    1 
 drivers/net/can/sja1000/Kconfig                                   |    2 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c                  |    1 
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c                        |   17 
 drivers/net/dsa/microchip/ksz8.c                                  |    3 
 drivers/net/dsa/microchip/ksz8_reg.h                              |    4 
 drivers/net/ethernet/airoha/airoha_npu.c                          |    2 
 drivers/net/ethernet/airoha/airoha_ppe.c                          |   26 
 drivers/net/ethernet/emulex/benet/be_cmds.c                       |    2 
 drivers/net/ethernet/intel/igb/igb_xsk.c                          |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en.h                      |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c          |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c          |    7 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c     |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                 |   26 
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c                   |    1 
 drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c                  |    4 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                    |    3 
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c                    |   14 
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c                      |    4 
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h                      |    6 
 drivers/net/ethernet/microsoft/mana/mana_en.c                     |   28 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                 |    2 
 drivers/net/ethernet/ti/icssg/icssg_common.c                      |   15 
 drivers/net/ipa/Kconfig                                           |    2 
 drivers/net/ipa/ipa_sysfs.c                                       |    6 
 drivers/net/macsec.c                                              |    2 
 drivers/net/mdio/mdio-bcm-unimac.c                                |    5 
 drivers/net/netconsole.c                                          |   30 
 drivers/net/phy/mscc/mscc_ptp.c                                   |    1 
 drivers/net/phy/mscc/mscc_ptp.h                                   |    1 
 drivers/net/ppp/pptp.c                                            |   18 
 drivers/net/team/team_core.c                                      |   96 -
 drivers/net/team/team_mode_activebackup.c                         |    3 
 drivers/net/team/team_mode_loadbalance.c                          |   13 
 drivers/net/usb/usbnet.c                                          |   11 
 drivers/net/vrf.c                                                 |    2 
 drivers/net/wireless/ath/ath11k/hal.c                             |    4 
 drivers/net/wireless/ath/ath11k/mac.c                             |   12 
 drivers/net/wireless/ath/ath12k/core.c                            |    1 
 drivers/net/wireless/ath/ath12k/core.h                            |    8 
 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h               |    6 
 drivers/net/wireless/ath/ath12k/dp.h                              |    1 
 drivers/net/wireless/ath/ath12k/dp_mon.c                          |    1 
 drivers/net/wireless/ath/ath12k/dp_tx.c                           |   10 
 drivers/net/wireless/ath/ath12k/mac.c                             |  118 +
 drivers/net/wireless/ath/ath12k/p2p.c                             |    3 
 drivers/net/wireless/ath/ath12k/reg.c                             |  116 +
 drivers/net/wireless/ath/ath12k/reg.h                             |    1 
 drivers/net/wireless/ath/ath12k/wmi.c                             |   14 
 drivers/net/wireless/ath/ath12k/wmi.h                             |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c       |   38 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c       |   26 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h |    2 
 drivers/net/wireless/intel/iwlwifi/dvm/main.c                     |   12 
 drivers/net/wireless/intel/iwlwifi/mld/rx.c                       |    9 
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c                      |    4 
 drivers/net/wireless/marvell/mwl8k.c                              |    4 
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c                   |    4 
 drivers/net/wireless/mediatek/mt76/mt7996/main.c                  |   21 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                   |    3 
 drivers/net/wireless/purelifi/plfxlc/mac.c                        |   11 
 drivers/net/wireless/purelifi/plfxlc/mac.h                        |    2 
 drivers/net/wireless/purelifi/plfxlc/usb.c                        |   29 
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c                |    3 
 drivers/net/wireless/realtek/rtl8xxxu/core.c                      |    2 
 drivers/net/wireless/realtek/rtw88/main.c                         |    4 
 drivers/net/wireless/realtek/rtw89/core.c                         |    8 
 drivers/net/wireless/realtek/rtw89/phy.c                          |   12 
 drivers/net/wireless/realtek/rtw89/sar.c                          |    5 
 drivers/nvme/target/core.c                                        |   14 
 drivers/nvme/target/pci-epf.c                                     |   23 
 drivers/pci/controller/dwc/pcie-dw-rockchip.c                     |    1 
 drivers/pci/controller/dwc/pcie-qcom.c                            |    1 
 drivers/pci/controller/pcie-rockchip-host.c                       |    2 
 drivers/pci/controller/plda/pcie-starfive.c                       |    2 
 drivers/pci/endpoint/functions/pci-epf-vntb.c                     |    4 
 drivers/pci/hotplug/pnv_php.c                                     |  233 +++
 drivers/pci/pci-driver.c                                          |    6 
 drivers/pci/pci.h                                                 |    2 
 drivers/pci/quirks.c                                              |    6 
 drivers/perf/arm-ni.c                                             |    2 
 drivers/phy/phy-snps-eusb2.c                                      |    3 
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c                    |   87 -
 drivers/pinctrl/berlin/berlin.c                                   |    8 
 drivers/pinctrl/cirrus/pinctrl-madera-core.c                      |   14 
 drivers/pinctrl/pinctrl-k230.c                                    |   13 
 drivers/pinctrl/pinmux.c                                          |   20 
 drivers/pinctrl/sunxi/pinctrl-sunxi.c                             |   11 
 drivers/platform/x86/intel/pmt/class.c                            |    3 
 drivers/platform/x86/intel/pmt/class.h                            |    1 
 drivers/platform/x86/oxpec.c                                      |   37 
 drivers/power/reset/Kconfig                                       |    1 
 drivers/power/sequencing/pwrseq-qcom-wcn.c                        |    2 
 drivers/power/supply/cpcap-charger.c                              |    5 
 drivers/power/supply/max14577_charger.c                           |    4 
 drivers/power/supply/max1720x_battery.c                           |   11 
 drivers/power/supply/qcom_pmi8998_charger.c                       |    4 
 drivers/powercap/dtpm_cpu.c                                       |    2 
 drivers/pps/pps.c                                                 |   11 
 drivers/remoteproc/Kconfig                                        |   11 
 drivers/remoteproc/qcom_q6v5_pas.c                                |  621 ++++------
 drivers/remoteproc/xlnx_r5_remoteproc.c                           |    2 
 drivers/rtc/rtc-ds1307.c                                          |    2 
 drivers/rtc/rtc-hym8563.c                                         |    2 
 drivers/rtc/rtc-nct3018y.c                                        |    2 
 drivers/rtc/rtc-pcf85063.c                                        |    2 
 drivers/rtc/rtc-pcf8563.c                                         |    2 
 drivers/rtc/rtc-rv3028.c                                          |    2 
 drivers/s390/crypto/ap_bus.h                                      |    2 
 drivers/scsi/elx/efct/efct_lio.c                                  |    2 
 drivers/scsi/ibmvscsi_tgt/libsrp.c                                |    6 
 drivers/scsi/isci/request.c                                       |    2 
 drivers/scsi/mpt3sas/mpt3sas_scsih.c                              |    3 
 drivers/scsi/mvsas/mv_sas.c                                       |    4 
 drivers/scsi/scsi.c                                               |    8 
 drivers/scsi/scsi_transport_iscsi.c                               |    2 
 drivers/scsi/sd.c                                                 |    4 
 drivers/soc/qcom/pmic_glink.c                                     |    9 
 drivers/soc/qcom/qmi_encdec.c                                     |   52 
 drivers/soc/qcom/qmi_interface.c                                  |    6 
 drivers/soc/tegra/cbb/tegra234-cbb.c                              |    2 
 drivers/soundwire/debugfs.c                                       |    6 
 drivers/soundwire/mipi_disco.c                                    |    4 
 drivers/soundwire/stream.c                                        |    2 
 drivers/spi/spi-cs42l43.c                                         |    2 
 drivers/spi/spi-nxp-fspi.c                                        |    4 
 drivers/spi/spi-stm32.c                                           |    8 
 drivers/staging/fbtft/fbtft-core.c                                |    1 
 drivers/staging/gpib/cb7210/cb7210.c                              |   15 
 drivers/staging/gpib/common/gpib_os.c                             |    4 
 drivers/staging/greybus/gbphy.c                                   |    6 
 drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c         |    9 
 drivers/staging/nvec/nvec_power.c                                 |    2 
 drivers/ufs/core/ufshcd.c                                         |   10 
 drivers/usb/early/xhci-dbc.c                                      |    4 
 drivers/usb/gadget/composite.c                                    |    5 
 drivers/usb/gadget/function/f_hid.c                               |    7 
 drivers/usb/gadget/function/uvc_configfs.c                        |   10 
 drivers/usb/host/xhci-plat.c                                      |    2 
 drivers/usb/misc/apple-mfi-fastcharge.c                           |   24 
 drivers/usb/serial/option.c                                       |    2 
 drivers/usb/typec/ucsi/ucsi_yoga_c630.c                           |   19 
 drivers/vdpa/mlx5/core/mr.c                                       |    3 
 drivers/vdpa/mlx5/net/mlx5_vnet.c                                 |   12 
 drivers/vdpa/vdpa_user/vduse_dev.c                                |    1 
 drivers/vfio/device_cdev.c                                        |   38 
 drivers/vfio/group.c                                              |    7 
 drivers/vfio/iommufd.c                                            |    4 
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c                    |    1 
 drivers/vfio/pci/mlx5/main.c                                      |    1 
 drivers/vfio/pci/nvgrace-gpu/main.c                               |    2 
 drivers/vfio/pci/pds/vfio_dev.c                                   |    2 
 drivers/vfio/pci/qat/main.c                                       |    1 
 drivers/vfio/pci/vfio_pci.c                                       |    1 
 drivers/vfio/pci/vfio_pci_core.c                                  |   24 
 drivers/vfio/pci/virtio/main.c                                    |    3 
 drivers/vfio/vfio_main.c                                          |    3 
 drivers/vhost/Kconfig                                             |   18 
 drivers/vhost/scsi.c                                              |    6 
 drivers/vhost/vhost.c                                             |  244 +++
 drivers/vhost/vhost.h                                             |   22 
 drivers/video/fbdev/core/fbcon.c                                  |    4 
 drivers/video/fbdev/imxfb.c                                       |    9 
 drivers/watchdog/ziirave_wdt.c                                    |    3 
 drivers/xen/gntdev-common.h                                       |    4 
 drivers/xen/gntdev-dmabuf.c                                       |   28 
 drivers/xen/gntdev.c                                              |   71 -
 fs/btrfs/ctree.c                                                  |   18 
 fs/ceph/crypto.c                                                  |   31 
 fs/eventpoll.c                                                    |   58 
 fs/exfat/file.c                                                   |    5 
 fs/ext4/inline.c                                                  |    2 
 fs/ext4/inode.c                                                   |    7 
 fs/ext4/page-io.c                                                 |   16 
 fs/f2fs/compress.c                                                |   76 -
 fs/f2fs/data.c                                                    |    7 
 fs/f2fs/debug.c                                                   |   17 
 fs/f2fs/extent_cache.c                                            |    2 
 fs/f2fs/f2fs.h                                                    |    4 
 fs/f2fs/gc.c                                                      |    1 
 fs/f2fs/inode.c                                                   |   21 
 fs/f2fs/segment.h                                                 |    5 
 fs/f2fs/super.c                                                   |    1 
 fs/f2fs/sysfs.c                                                   |   21 
 fs/gfs2/glock.c                                                   |    3 
 fs/gfs2/util.c                                                    |   31 
 fs/hfs/inode.c                                                    |    1 
 fs/hfsplus/extents.c                                              |    3 
 fs/hfsplus/inode.c                                                |    1 
 fs/jfs/jfs_dmap.c                                                 |    4 
 fs/nfs/dir.c                                                      |    4 
 fs/nfs/export.c                                                   |   11 
 fs/nfs/flexfilelayout/flexfilelayout.c                            |   26 
 fs/nfs/flexfilelayout/flexfilelayoutdev.c                         |    6 
 fs/nfs/internal.h                                                 |    9 
 fs/nfs/nfs4proc.c                                                 |   10 
 fs/nfs_common/nfslocalio.c                                        |   28 
 fs/nfsd/localio.c                                                 |    5 
 fs/nfsd/vfs.c                                                     |   10 
 fs/notify/fanotify/fanotify.c                                     |    8 
 fs/ntfs3/file.c                                                   |    5 
 fs/ntfs3/frecord.c                                                |    7 
 fs/ntfs3/namei.c                                                  |   10 
 fs/ntfs3/ntfs_fs.h                                                |    3 
 fs/orangefs/orangefs-debugfs.c                                    |    6 
 fs/proc/generic.c                                                 |    2 
 fs/proc/inode.c                                                   |    2 
 fs/proc/internal.h                                                |    5 
 fs/smb/client/cifs_debug.c                                        |    6 
 fs/smb/client/cifsencrypt.c                                       |    4 
 fs/smb/client/cifsfs.c                                            |    2 
 fs/smb/client/connect.c                                           |    9 
 fs/smb/client/fs_context.c                                        |   19 
 fs/smb/client/fs_context.h                                        |   18 
 fs/smb/client/link.c                                              |   11 
 fs/smb/client/reparse.c                                           |    2 
 fs/smb/client/smbdirect.c                                         |  116 -
 fs/smb/client/smbdirect.h                                         |    4 
 fs/smb/server/connection.h                                        |    1 
 fs/smb/server/smb2pdu.c                                           |   22 
 fs/smb/server/smb_common.c                                        |    2 
 fs/smb/server/transport_rdma.c                                    |   97 -
 fs/smb/server/transport_tcp.c                                     |   17 
 fs/smb/server/vfs.c                                               |    3 
 fs/squashfs/block.c                                               |   47 
 include/crypto/internal/hash.h                                    |    6 
 include/linux/audit.h                                             |    9 
 include/linux/bpf-cgroup.h                                        |    5 
 include/linux/bpf.h                                               |   60 
 include/linux/crypto.h                                            |    3 
 include/linux/fortify-string.h                                    |    2 
 include/linux/fs_context.h                                        |    2 
 include/linux/i3c/device.h                                        |    4 
 include/linux/if_team.h                                           |    3 
 include/linux/ioprio.h                                            |    3 
 include/linux/mlx5/device.h                                       |    1 
 include/linux/mmap_lock.h                                         |   30 
 include/linux/moduleparam.h                                       |    5 
 include/linux/padata.h                                            |    4 
 include/linux/pps_kernel.h                                        |    1 
 include/linux/proc_fs.h                                           |    1 
 include/linux/psi_types.h                                         |    6 
 include/linux/ring_buffer.h                                       |    4 
 include/linux/sched/task_stack.h                                  |    2 
 include/linux/skbuff.h                                            |   23 
 include/linux/soc/qcom/qmi.h                                      |    6 
 include/linux/usb/usbnet.h                                        |    1 
 include/linux/vfio.h                                              |    4 
 include/linux/vfio_pci_core.h                                     |    2 
 include/net/bluetooth/hci.h                                       |    1 
 include/net/bluetooth/hci_core.h                                  |    6 
 include/net/dst.h                                                 |   24 
 include/net/lwtunnel.h                                            |    8 
 include/net/route.h                                               |    4 
 include/net/sock.h                                                |   12 
 include/net/tc_act/tc_ctinfo.h                                    |    6 
 include/net/udp.h                                                 |   24 
 include/rdma/ib_verbs.h                                           |   12 
 include/sound/tas2781-tlv.h                                       |    2 
 include/trace/events/power.h                                      |   22 
 include/uapi/drm/panthor_drm.h                                    |    3 
 include/uapi/drm/xe_drm.h                                         |    8 
 include/uapi/linux/vfio.h                                         |   12 
 include/uapi/linux/vhost.h                                        |   29 
 init/Kconfig                                                      |    2 
 kernel/audit.h                                                    |    2 
 kernel/auditsc.c                                                  |    2 
 kernel/bpf/cgroup.c                                               |    8 
 kernel/bpf/core.c                                                 |   55 
 kernel/bpf/helpers.c                                              |   11 
 kernel/bpf/preload/Kconfig                                        |    1 
 kernel/bpf/syscall.c                                              |   19 
 kernel/bpf/verifier.c                                             |    1 
 kernel/cgroup/cgroup-v1.c                                         |   14 
 kernel/events/core.c                                              |   36 
 kernel/events/uprobes.c                                           |    4 
 kernel/kcsan/kcsan_test.c                                         |    2 
 kernel/kexec_core.c                                               |    3 
 kernel/module/main.c                                              |    6 
 kernel/padata.c                                                   |  132 --
 kernel/rcu/refscale.c                                             |   10 
 kernel/rcu/tree_nocb.h                                            |    2 
 kernel/sched/deadline.c                                           |    7 
 kernel/sched/psi.c                                                |  123 +
 kernel/trace/power-traces.c                                       |    1 
 kernel/trace/preemptirq_delay_test.c                              |   13 
 kernel/trace/ring_buffer.c                                        |   63 -
 kernel/trace/rv/monitors/scpd/Kconfig                             |    2 
 kernel/trace/rv/monitors/sncid/Kconfig                            |    2 
 kernel/trace/rv/monitors/snep/Kconfig                             |    2 
 kernel/trace/rv/monitors/wip/Kconfig                              |    2 
 kernel/trace/rv/rv_trace.h                                        |   84 -
 kernel/trace/trace.c                                              |   14 
 kernel/trace/trace_events_filter.c                                |   28 
 kernel/trace/trace_kdb.c                                          |    8 
 kernel/ucount.c                                                   |    2 
 lib/tests/fortify_kunit.c                                         |    4 
 mm/hmm.c                                                          |    2 
 mm/mmap_lock.c                                                    |    3 
 mm/shmem.c                                                        |    4 
 mm/slub.c                                                         |   10 
 mm/swapfile.c                                                     |   65 -
 net/bluetooth/coredump.c                                          |    6 
 net/bluetooth/hci_event.c                                         |    8 
 net/caif/cfctrl.c                                                 |  294 ++--
 net/core/devmem.c                                                 |    6 
 net/core/devmem.h                                                 |    7 
 net/core/dst.c                                                    |    8 
 net/core/filter.c                                                 |   23 
 net/core/neighbour.c                                              |   88 -
 net/core/netclassid_cgroup.c                                      |    4 
 net/core/netpoll.c                                                |    7 
 net/core/skmsg.c                                                  |    7 
 net/core/sock.c                                                   |    8 
 net/ipv4/inet_connection_sock.c                                   |    4 
 net/ipv4/ping.c                                                   |    2 
 net/ipv4/raw.c                                                    |    2 
 net/ipv4/route.c                                                  |    7 
 net/ipv4/syncookies.c                                             |    3 
 net/ipv4/tcp_input.c                                              |    4 
 net/ipv4/udp.c                                                    |    3 
 net/ipv6/af_inet6.c                                               |    2 
 net/ipv6/datagram.c                                               |    2 
 net/ipv6/inet6_connection_sock.c                                  |    4 
 net/ipv6/ip6_fib.c                                                |   24 
 net/ipv6/ip6_offload.c                                            |    4 
 net/ipv6/ip6mr.c                                                  |    3 
 net/ipv6/ping.c                                                   |    2 
 net/ipv6/raw.c                                                    |    2 
 net/ipv6/route.c                                                  |   75 -
 net/ipv6/syncookies.c                                             |    2 
 net/ipv6/tcp_ipv6.c                                               |    2 
 net/ipv6/udp.c                                                    |    5 
 net/kcm/kcmsock.c                                                 |    6 
 net/l2tp/l2tp_ip6.c                                               |    2 
 net/mac80211/cfg.c                                                |   12 
 net/mac80211/ieee80211_i.h                                        |   15 
 net/mac80211/main.c                                               |   13 
 net/mac80211/tdls.c                                               |    2 
 net/mac80211/tx.c                                                 |   14 
 net/mptcp/protocol.c                                              |    2 
 net/netfilter/nf_bpf_link.c                                       |    5 
 net/netfilter/nf_tables_api.c                                     |   29 
 net/netfilter/xt_nfacct.c                                         |    4 
 net/packet/af_packet.c                                            |   12 
 net/sched/act_ctinfo.c                                            |   19 
 net/sched/sch_mqprio.c                                            |    2 
 net/sched/sch_netem.c                                             |   40 
 net/sched/sch_taprio.c                                            |   21 
 net/socket.c                                                      |    8 
 net/sunrpc/svcsock.c                                              |   43 
 net/sunrpc/xprtsock.c                                             |   40 
 net/tls/tls_sw.c                                                  |   13 
 net/vmw_vsock/af_vsock.c                                          |    3 
 net/wireless/nl80211.c                                            |    1 
 net/wireless/reg.c                                                |    2 
 rust/kernel/devres.rs                                             |   10 
 rust/kernel/miscdevice.rs                                         |    8 
 samples/mei/mei-amt-version.c                                     |    2 
 scripts/gdb/linux/constants.py.in                                 |   12 
 scripts/kconfig/qconf.cc                                          |    2 
 security/apparmor/include/match.h                                 |    8 
 security/apparmor/match.c                                         |   23 
 security/apparmor/policy_unpack_test.c                            |    6 
 security/landlock/id.c                                            |   69 -
 sound/pci/hda/patch_ca0132.c                                      |    5 
 sound/pci/hda/patch_realtek.c                                     |    3 
 sound/soc/amd/acp/acp-pci.c                                       |    8 
 sound/soc/amd/acp/amd-acpi-mach.c                                 |    4 
 sound/soc/amd/acp/amd.h                                           |    8 
 sound/soc/fsl/fsl_xcvr.c                                          |   25 
 sound/soc/mediatek/common/mtk-afe-platform-driver.c               |    4 
 sound/soc/mediatek/common/mtk-base-afe.h                          |    1 
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c                        |    7 
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c                        |   21 
 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c                        |    7 
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c                        |    7 
 sound/soc/rockchip/rockchip_sai.c                                 |   16 
 sound/soc/sdca/sdca_asoc.c                                        |   14 
 sound/soc/sdca/sdca_functions.c                                   |    3 
 sound/soc/sdca/sdca_regmap.c                                      |   16 
 sound/soc/soc-dai.c                                               |   16 
 sound/soc/soc-ops.c                                               |   26 
 sound/soc/sof/intel/Kconfig                                       |    3 
 sound/usb/mixer_scarlett2.c                                       |   14 
 sound/x86/intel_hdmi_audio.c                                      |    2 
 tools/bpf/bpftool/net.c                                           |   15 
 tools/cgroup/memcg_slabinfo.py                                    |    4 
 tools/include/nolibc/stdio.h                                      |    4 
 tools/include/nolibc/sys/wait.h                                   |    2 
 tools/lib/subcmd/help.c                                           |   12 
 tools/lib/subcmd/run-command.c                                    |   15 
 tools/perf/.gitignore                                             |    2 
 tools/perf/builtin-sched.c                                        |  147 +-
 tools/perf/tests/bp_account.c                                     |    1 
 tools/perf/util/build-id.c                                        |    2 
 tools/perf/util/evsel.c                                           |   11 
 tools/perf/util/evsel.h                                           |    2 
 tools/perf/util/hwmon_pmu.c                                       |    2 
 tools/perf/util/parse-events.c                                    |   11 
 tools/perf/util/pmu.c                                             |    4 
 tools/perf/util/python.c                                          |   49 
 tools/perf/util/symbol.c                                          |    1 
 tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c        |    4 
 tools/power/x86/turbostat/turbostat.c                             |   34 
 tools/testing/selftests/alsa/utimer-test.c                        |    1 
 tools/testing/selftests/arm64/fp/sve-ptrace.c                     |    2 
 tools/testing/selftests/bpf/bpf_atomic.h                          |    2 
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c           |    2 
 tools/testing/selftests/bpf/veristat.c                            |    1 
 tools/testing/selftests/breakpoints/step_after_suspend_test.c     |   41 
 tools/testing/selftests/cgroup/test_cpu.c                         |   63 -
 tools/testing/selftests/drivers/net/hw/tso.py                     |   99 -
 tools/testing/selftests/drivers/net/lib/py/env.py                 |    2 
 tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc   |   28 
 tools/testing/selftests/landlock/audit.h                          |    7 
 tools/testing/selftests/landlock/audit_test.c                     |    1 
 tools/testing/selftests/net/netfilter/ipvs.sh                     |    4 
 tools/testing/selftests/net/netfilter/nft_interface_stress.sh     |    5 
 tools/testing/selftests/net/rtnetlink.sh                          |    6 
 tools/testing/selftests/net/vlan_hw_filter.sh                     |   16 
 tools/testing/selftests/nolibc/nolibc-test.c                      |   23 
 tools/testing/selftests/perf_events/.gitignore                    |    1 
 tools/testing/selftests/perf_events/Makefile                      |    2 
 tools/testing/selftests/perf_events/mmap.c                        |  236 +++
 tools/testing/selftests/syscall_user_dispatch/sud_test.c          |   50 
 tools/testing/selftests/vDSO/vdso_test_chacha.c                   |    3 
 tools/verification/rv/src/in_kernel.c                             |    4 
 677 files changed, 7139 insertions(+), 3478 deletions(-)

Aaradhana Sahu (2):
      wifi: ath12k: Block radio bring-up in FTM mode
      wifi: ath12k: Use HTT_TCL_METADATA_VER_V1 in FTM mode

Abdun Nihaal (1):
      staging: fbtft: fix potential memory leak in fbtft_framebuffer_alloc()

Abinash Singh (1):
      f2fs: fix KMSAN uninit-value in extent_info usage

Adam Ford (2):
      arm64: dts: imx8mm-beacon: Fix HS400 USDHC clock speed
      arm64: dts: imx8mn-beacon: Fix HS400 USDHC clock speed

Aditya Garg (2):
      HID: magicmouse: avoid setting up battery timer when not needed
      HID: apple: avoid setting up battery timer for devices without battery

Adrián Larumbe (1):
      drm/panfrost: Fix panfrost device variable name in devfreq

Ahsan Atta (1):
      crypto: qat - allow enabling VFs in the absence of IOMMU

Akash Kumar (1):
      usb: gadget: uvc: Initialize frame-based format color matching descriptor

Akhilesh Patil (1):
      clk: spacemit: ccu_pll: fix error return value in recalc_rate callback

Al Viro (2):
      parse_longname(): strrchr() expects NUL-terminated string
      xen: fix UAF in dmabuf_exp_from_pages()

Alan Stern (1):
      HID: core: Harden s32ton() against conversion to 0 bits

Albin Törnqvist (1):
      arm: dts: ti: omap: Fixup pinheader typo

Alex Deucher (6):
      drm/amdgpu/sdma: handle paging queues in amdgpu_sdma_reset_engine()
      drm/amdgpu: move force completion into ring resets
      drm/amdgpu/gfx10: fix KGQ reset sequence
      drm/amdgpu/gfx9: fix kiq locking in KCQ reset
      drm/amdgpu/gfx9.4.3: fix kiq locking in KCQ reset
      drm/amdgpu/gfx10: fix kiq locking in KCQ reset

Alex Elder (1):
      clk: spacemit: mark K1 pll1_d8 as critical

Alex Williamson (1):
      vfio/pci: Separate SR-IOV VF dev_set

Alexander Gordeev (1):
      s390/mm: Set high_memory at the end of the identity mapping

Alexander Stein (1):
      arm64: dts: freescale: imx93-tqma9352: Limit BUCK2 to 600mV

Alexander Wetzel (3):
      wifi: cfg80211: Add missing lock in cfg80211_check_and_end_cac()
      wifi: mac80211: Do not schedule stopped TXQs
      wifi: mac80211: Don't call fq_flow_idx() for management frames

Alexander Wilhelm (2):
      soc: qcom: QMI encoding/decoding for big endian
      soc: qcom: fix endianness for QMI header

Alexei Lazar (1):
      net/mlx5e: Clear Read-Only port buffer size in PBMC before update

Alexey Kardashevskiy (1):
      crypto: ccp - Fix locking on alloc failure handling

Alok Tiwari (2):
      staging: nvec: Fix incorrect null termination of battery manufacturer
      vhost-scsi: Fix check for inline_sg_cnt exceeding preallocated limit

Amir Goldstein (1):
      fanotify: sanitize handle_type values when reporting fid

Ammar Faizi (1):
      net: usbnet: Fix the wrong netif_carrier_on() call

Anders Roxell (1):
      vdpa: Fix IDR memory leak in VDUSE module exit

Andreas Gruenbacher (2):
      gfs2: Minor do_xmote cancelation fix
      gfs2: No more self recovery

André Apitzsch (1):
      arm64: dts: qcom: msm8976: Make blsp_dma controlled-remotely

Andy Shevchenko (2):
      leds: pca955x: Avoid potential overflow when filling default_label (take 2)
      mm/hmm: move pmd_to_hmm_pfn_flags() to the respective #ifdeffery

Andy Yan (2):
      drm/rockchip: cleanup fb when drm_gem_fb_afbc_init failed
      drm/rockchip: vop2: Fix the update of LAYER/PORT select registers when there are multi display output on rk3588/rk3568

Annette Kobou (1):
      ARM: dts: imx6ul-kontron-bl-common: Fix RTS polarity for RS485 interface

Antheas Kapenekakis (1):
      platform/x86: oxpec: Fix turbo register for G1 AMD

Arnd Bergmann (10):
      ASoC: ops: dynamically allocate struct snd_ctl_elem_value
      cpufreq: armada-8k: make both cpu masks static
      caif: reduce stack size, again
      crypto: arm/aes-neonbs - work around gcc-15 warning
      leds: tps6131x: Add V4L2_FLASH_LED_CLASS dependency
      kernel: trace: preemptirq_delay_test: use offstack cpu mask
      i3c: fix module_i3c_i2c_driver() with I3C=n
      ipa: fix compile-testing with qcom-mdt=m
      irqchip: Build IMX_MU_MSI only on ARM
      ASoC: SOF: Intel: hda-sdw-bpt: fix SND_SOF_SOF_HDA_SDW_BPT dependencies

Arseniy Krasnov (1):
      Bluetooth: hci_sync: fix double free in 'hci_discovery_filter_clear()'

Artem Sadovnikov (1):
      refscale: Check that nreaders and loops multiplication doesn't overflow

Ashish Kalra (1):
      crypto: ccp - Fix dereferencing uninitialized error pointer

Bagas Sanjaya (1):
      scsi: core: Fix kernel doc for scsi_track_queue_full()

Bairavi Alagappan (1):
      crypto: qat - disable ZUC-256 capability for QAT GEN5

Balamanikandan Gunasundar (1):
      mtd: rawnand: atmel: set pmecc data setup time

Baochen Qiang (2):
      wifi: ath11k: fix sleeping-in-atomic in ath11k_mac_op_set_bitrate_mask()
      wifi: ath12k: install pairwise key first

Baojun Xu (1):
      ASoC: tas2781: Fix the wrong step for TLV on tas2781

Baokun Li (1):
      ext4: fix inode use after free in ext4_end_io_rsv_work()

Baolin Wang (1):
      mm: shmem: fix the shmem large folio allocation for the i915 driver

Bard Liao (1):
      soundwire: stream: restore params when prepare ports fail

Bartosz Golaszewski (2):
      MIPS: alchemy: gpio: use new GPIO line value setter callbacks for the remaining chips
      ARM: s3c/gpio: complete the conversion to new GPIO value setters

Ben Hutchings (1):
      sh: Do not use hyphen in exported variable name

Bence Csókás (1):
      net: mdio_bus: Use devm for getting reset GPIO

Benjamin Berg (1):
      wifi: iwlwifi: mld: decode EOF bit for AMPDUs

Benjamin Coddington (1):
      NFS: Fixup allocation flags for nfsiod's __GFP_NORETRY

Bitterblue Smith (1):
      wifi: rtw88: Fix macid assigned to TDLS station

Bjorn Andersson (1):
      remoteproc: qcom: pas: Conclude the rename from adsp

Boris Brezillon (1):
      drm/panthor: Add missing explicit padding in drm_panthor_gpu_info

Brahmajit Das (1):
      samples: mei: Fix building on musl libc

Breno Leitao (1):
      netconsole: Only register console drivers when targets are configured

Brett Creeley (1):
      vfio/pds: Fix missing detach_ioas op

Brian Masney (6):
      rtc: ds1307: fix incorrect maximum clock rate handling
      rtc: hym8563: fix incorrect maximum clock rate handling
      rtc: nct3018y: fix incorrect maximum clock rate handling
      rtc: pcf85063: fix incorrect maximum clock rate handling
      rtc: pcf8563: fix incorrect maximum clock rate handling
      rtc: rv3028: fix incorrect maximum clock rate handling

Budimir Markovic (1):
      vsock: Do not allow binding to VMADDR_PORT_ANY

Caleb Sander Mateos (1):
      ublk: use vmalloc for ublk_device's __queues

Casey Connolly (1):
      power: supply: qcom_pmi8998_charger: fix wakeirq

Chanwoo Choi (1):
      PM / devfreq: Fix a index typo in trans_stat

Chao Yu (10):
      f2fs: fix to avoid invalid wait context issue
      f2fs: fix to check upper boundary for gc_valid_thresh_ratio
      f2fs: fix to check upper boundary for gc_no_zoned_gc_percent
      f2fs: doc: fix wrong quota mount option description
      f2fs: fix to avoid UAF in f2fs_sync_inode_meta()
      f2fs: fix to avoid panic in f2fs_evict_inode
      f2fs: fix to avoid out-of-boundary access in devs.path
      f2fs: fix to update upper_p in __get_secs_required() correctly
      f2fs: fix to calculate dirty data during has_not_enough_free_secs()
      f2fs: fix to trigger foreground gc during f2fs_map_blocks() in lfs mode

Charalampos Mitrodimas (2):
      usb: misc: apple-mfi-fastcharge: Make power supply names unique
      net, bpf: Fix RCU usage in task_cls_state() for BPF programs

Charles Han (2):
      power: supply: cpcap-charger: Fix null check for power_supply_get_by_name
      power: supply: max14577: Handle NULL pdata when CONFIG_OF is not set

Charles Keepax (5):
      ASoC: SDCA: Add missing default in switch in entity_pde_event()
      ASoC: SDCA: Update memory allocations to zero initialise
      ASoC: SDCA: Allow read-only controls to be deferrable
      soundwire: Correct some property names
      ASoC: SDCA: Fix some holes in the regmap readable/writeable helpers

Chen Pei (1):
      perf tools: Remove libtraceevent in .gitignore

Chen-Yu Tsai (2):
      ASoC: mediatek: use reserved memory or enable buffer pre-allocation
      ASoC: mediatek: mt8183-afe-pcm: Support >32 bit DMA addresses

Chenyuan Yang (1):
      fbdev: imxfb: Check fb_add_videomode to prevent null-ptr-deref

Chris Down (1):
      Bluetooth: hci_event: Mask data status from LE ext adv reports

Christian König (1):
      drm/amdgpu: rework queue reset scheduler interaction

Christoph Hellwig (1):
      block: ensure discard_granularity is zero when discard is not supported

Christoph Paasch (1):
      net/mlx5: Correctly set gso_segs when LRO is used

Christophe JAILLET (2):
      staging: gpib: Fix error handling paths in cb_gpib_probe()
      i2c: muxes: mule: Fix an error handling path in mule_i2c_mux_probe()

Cindy Lu (1):
      vhost: Reintroduce kthread API and add mode selection

Clément Le Goffic (1):
      spi: stm32: Check for cfg availability in stm32_spi_probe

Colin Ian King (2):
      staging: gpib: fix unset padding field copy back to userspace
      squashfs: fix incorrect argument to sizeof in kmalloc_array call

Cristian Ciocaltea (1):
      drm/connector: hdmi: Evaluate limited range after computing format

Daeho Jeong (1):
      f2fs: turn off one_time when forcibly set to foreground GC

Dan Carpenter (5):
      wifi: rtw89: mcc: prevent shift wrapping in rtw89_core_mlsr_switch()
      wifi: iwlwifi: Fix error code in iwl_op_mode_dvm_start()
      wifi: mt76: mt7925: fix off by one in mt7925_mcu_hw_scan()
      watchdog: ziirave_wdt: check record length in ziirave_firm_verify()
      fs/orangefs: Allow 2 more characters in do_c_string()

Daniel Borkmann (4):
      bpf: Add cookie object to bpf maps
      bpf: Move bpf map owner out of common struct
      bpf: Move cgroup iterator helpers to bpf.h
      bpf: Fix oob access in cgroup local storage

Daniel Zahka (3):
      selftests: drv-net: tso: enable test cases based on hw_features
      selftests: drv-net: tso: fix vxlan tunnel flags to get correct gso_type
      selftests: drv-net: tso: fix non-tunneled tso6 test case name

Daniil Dulov (1):
      wifi: rtl818x: Kill URBs before clearing tx status queue

Danilo Krummrich (1):
      rust: devres: require T: Send for Devres

Dave Hansen (1):
      x86/fpu: Delay instruction pointer fixup until after warning

Denis OSTERLAND-HEIM (1):
      pps: fix poll support

Dmitry Baryshkov (4):
      usb: typec: ucsi: yoga-c630: fix error and remove paths
      interconnect: qcom: sc8280xp: specify num_links for qnm_a1noc_cfg
      interconnect: qcom: sc8180x: specify num_nodes
      iommu/arm-smmu: disable PRR on SM8250

Dmitry Vyukov (1):
      selftests: Fix errno checking in syscall_user_dispatch test

Dragos Tatulea (2):
      vdpa/mlx5: Fix needs_teardown flag calculation
      vdpa/mlx5: Fix release of uninitialized resources on error path

Easwar Hariharan (1):
      iommu/amd: Enable PASID and ATS capabilities in the correct order

Edip Hazuri (3):
      ALSA: hda/realtek - Fix mute LED for HP Victus 16-r1xxx
      ALSA: hda/realtek - Fix mute LED for HP Victus 16-s0xxx
      ALSA: hda/realtek - Fix mute LED for HP Victus 16-d1xxx (MB 8A26)

Eduard Zingerman (1):
      bpf: handle jset (if a & b ...) as a jump in CFG computation

Edward Adam Davis (1):
      fs/ntfs3: cancle set bad inode after removing name fails

Edward Srouji (1):
      RDMA/mlx5: Fix UMR modifying of mkey page size

Emanuele Ghidoli (1):
      arm64: dts: ti: k3-am62p-verdin: Enable pull-ups on I2C_3_HDMI

Emily Deng (1):
      drm/amdkfd: Move the process suspend and resume out of full access

Eric Biggers (1):
      crypto: krb5 - Fix memory leak in krb5_test_one_prf()

Eric Dumazet (14):
      net: annotate races around sk->sk_uid
      net: dst: annotate data-races around dst->input
      net: dst: annotate data-races around dst->output
      net: dst: add four helpers to annotate data-races around dst->dev
      net_sched: act_ctinfo: use atomic64_t for three counters
      tcp: call tcp_measure_rcv_mss() for ooo packets
      ipv6: add a retry logic in net6_rt_notify()
      ipv6: prevent infinite loop in rt6_nlmsg_size()
      ipv6: fix possible infinite loop in fib6_info_uses_dev()
      ipv6: annotate data-races around rt->fib6_nsiblings
      pptp: ensure minimal skb length in pptp_xmit()
      selftests: avoid using ifconfig
      ipv6: reject malicious packets in ipv6_gso_segment()
      pptp: fix pptp_xmit() error path

Erni Sri Satya Vennela (1):
      net: mana: Fix potential deadlocks in mana napi ops

Ethan Milon (1):
      iommu/vt-d: Fix missing PASID in dev TLB flush with cache_tag_flush_all

Fedor Pchelkin (4):
      wifi: rtw89: sar: drop lockdep assertion in rtw89_set_sar_from_acpi
      wifi: rtw89: sar: do not assert wiphy lock held until probing is done
      drm/amd/pm/powerplay/hwmgr/smu_helper: fix order of mask and value
      netfilter: nf_tables: adjust lockdep assertions handling

Finn Thain (1):
      m68k: Don't unregister boot console needlessly

Florian Fainelli (1):
      net: mdio: mdio-bcm-unimac: Correct rate fallback logic

Florian Westphal (1):
      netfilter: xt_nfacct: don't assume acct name is null-terminated

Francesco Dolcini (1):
      arm64: dts: ti: k3-am62p-verdin: add SD_1 CD pull-up

Fushuai Wang (1):
      selftests/bpf: fix signedness bug in redir_partial()

Gabriele Monaco (4):
      tools/rv: Do not skip idle in trace
      rv: Remove trailing whitespace from tracepoint string
      rv: Use strings in da monitors tracepoints
      rv: Adjust monitor dependencies

Gal Pressman (1):
      selftests: drv-net: Fix remote command checking in require_cmd()

Gautham R. Shenoy (1):
      pm: cpupower: Fix printing of CORE, CPU fields in cpupower-monitor

Geert Uytterhoeven (2):
      drm/sitronix: Remove broken backwards-compatibility layer
      power: reset: POWER_RESET_TORADEX_EC should depend on ARCH_MXC

Geoffrey D. Bennett (1):
      ALSA: scarlett2: Add retry on -EPROTO from scarlett2_usb_tx()

Gerald Schaefer (1):
      s390/mm: Remove possible false-positive warning in pte_free_defer()

Giovanni Cabiddu (2):
      crypto: qat - fix DMA direction for compression on GEN2 devices
      crypto: qat - fix seq_file position update in adf_ring_next()

Gokul Sivakumar (1):
      wifi: brcmfmac: fix P2P discovery failure in P2P peer due to missing P2P IE

Greg Kroah-Hartman (4):
      drivers: misc: sram: fix up some const issues with recent attribute changes
      Revert "vmci: Prevent the dispatching of uninitialized payloads"
      staging: greybus: gbphy: fix up const issue with the match callback
      Linux 6.16.1

Guenter Roeck (1):
      block: Fix default IO priority if there is no IO context

Hans Zhang (1):
      PCI: rockchip-host: Fix "Unexpected Completion" log message

Hans de Goede (7):
      mei: vsc: Don't re-init VSC from mei_vsc_hw_reset() on stop
      mei: vsc: Destroy mutex after freeing the IRQ
      mei: vsc: Event notifier fixes
      mei: vsc: Unset the event callback on remove and probe errors
      mei: vsc: Drop unused vsc_tp_request_irq() and vsc_tp_free_irq()
      mei: vsc: Run event callback from a workqueue
      mei: vsc: Fix "BUG: Invalid wait context" lockdep error

Harald Freudenberger (1):
      s390/ap: Unmask SLCF bit in card and queue ap functions sysfs

Haren Myneni (1):
      powerpc/pseries/dlpar: Search DRC index from ibm,drc-indexes for IO add

Harshit Mogalapalli (1):
      staging: gpib: Fix error code in board_type_ioctl()

Harshitha Prem (1):
      wifi: ath12k: update unsupported bandwidth flags in reg rules

Heiko Stuebner (1):
      drm/rockchip: vop2: fail cleanly if missing a primary plane for a video-port

Helge Deller (1):
      apparmor: Fix unaligned memory accesses in KUnit test

Heming Zhao (1):
      md/md-cluster: handle REMOVE message earlier

Henry Martin (1):
      clk: davinci: Add NULL check in davinci_lpsc_clk_register()

Herbert Xu (7):
      crypto: marvell/cesa - Fix engine load inaccuracy
      crypto: s390/hmac - Fix counter in export state
      crypto: s390/sha3 - Use cpu byte-order when exporting
      padata: Fix pd UAF once and for all
      crypto: ahash - Add support for drivers with no fallback
      crypto: ahash - Stop legacy tfms from using the set_virt fallback path
      padata: Remove comment for reorder_work

Horatiu Vultur (1):
      phy: mscc: Fix parsing of unicast frames

Huan Yang (2):
      Revert "udmabuf: fix vmap_udmabuf error page set"
      udmabuf: fix vmap missed offset page

Ian Forbes (1):
      drm/vmwgfx: Fix Host-Backed userspace on Guest-Backed kernel

Ian Rogers (6):
      perf dso: Add missed dso__put to dso__load_kcore
      perf hwmon_pmu: Avoid shortening hwmon PMU name
      perf python: Fix thread check in pyrf_evsel__read
      perf python: Correct pyrf_evsel__read for tool PMUs
      tools subcmd: Tighten the filename size in check_if_command_finished
      perf pmu: Switch FILENAME_MAX to NAME_MAX

Inochi Amaoto (1):
      riscv: dts: sophgo: sg2044: Add missing riscv,cbop-block-size property

Ivan Pravdin (1):
      Bluetooth: hci_devcd_dump: fix out-of-bounds via dev_coredumpv

Ivan Stepchenko (1):
      mtd: fix possible integer overflow in erase_xfer()

Jacob Pan (2):
      vfio: Fix unbalanced vfio_df_close call in no-iommu mode
      vfio: Prevent open_count decrement to negative

Jakub Kicinski (6):
      netpoll: prevent hanging NAPI when netcons gets enabled
      netlink: specs: ethtool: fix module EEPROM input/output arguments
      eth: fbnic: unlink NAPIs from queues on error to open
      net: devmem: fix DMA direction on unmapping
      Revert "net: mdio_bus: Use devm for getting reset GPIO"
      eth: fbnic: remove the debugging trick of super high page bias

James Cowgill (1):
      media: v4l2-ctrls: Fix H264 SEPARATE_COLOUR_PLANE check

Jan Kara (1):
      ext4: Make sure BH_New bit is cleared in ->write_end handler

Jan Prusakowski (1):
      f2fs: vm_unmap_ram() may be called from an invalid context

Jann Horn (2):
      eventpoll: Fix semi-unbounded recursion
      eventpoll: fix sphinx documentation build warning

Jason Gunthorpe (3):
      iommu/vt-d: Do not wipe out the page table NID when devices detach
      iommu/amd: Fix geometry.aperture_end for V2 tables
      vfio/pci: Do vf_token checks for VFIO_DEVICE_BIND_IOMMUFD

Jason Xing (2):
      stmmac: xsk: fix negative overflow of budget in zerocopy mode
      igb: xsk: solve negative overflow of nb_pkts in zerocopy mode

Jeff Johnson (1):
      wifi: ath12k: pack HTT pdev rate stats structs

Jeff Layton (1):
      nfsd: don't set the ctime on delegated atime updates

Jeremy Linton (1):
      arm64/gcs: task_gcs_el0_enable() should use passed task

Jerome Brunet (1):
      PCI: endpoint: pci-epf-vntb: Return -ENOENT if pci_epc_get_next_free_bar() fails

Jianbo Liu (1):
      net/mlx5e: Remove skb secpath if xfrm state is not found

Jiasheng Jiang (1):
      iwlwifi: Add missing check for alloc_ordered_workqueue

Jiaxun Yang (1):
      MIPS: mm: tlb-r4k: Uniquify TLB entries on init

Jiayuan Chen (2):
      bpf, sockmap: Fix psock incorrectly pointing to sk
      bpf, ktls: Fix data corruption when using bpf_msg_pop_data() in ktls

Jie Gan (2):
      arm64: dts: qcom: qcs615: fix a crash issue caused by infinite loop for Coresight
      arm64: dts: qcom: qcs615: disable the CTI device of the camera block

Jimmy Assarsson (2):
      can: kvaser_pciefd: Store device channel index
      can: kvaser_usb: Assign netdev.dev_port based on device channel index

Jiri Olsa (1):
      uprobes: revert ref_ctr_offset in uprobe_unregister error path

Jiwei Sun (1):
      PCI: Adjust the position of reading the Link Control 2 register

Johan Hovold (2):
      driver core: auxiliary bus: fix OF node leak
      soc: qcom: pmic_glink: fix OF node leak

Johan Korsnes (1):
      arch: powerpc: defconfig: Drop obsolete CONFIG_NET_CLS_TCINDEX

Johannes Berg (2):
      wifi: mac80211: fix WARN_ON for monitor mode on some devices
      scripts: gdb: move MNT_* constants to gdb-parsed

John Ernberg (1):
      net: usbnet: Avoid potential RCU stall on LINK_CHANGE event

John Garry (2):
      md/raid10: fix set but not used variable in sync_request_write()
      block: sanitize chunk_sectors for atomic write limits

Jonas Karlman (3):
      arm64: dts: rockchip: Enable eMMC HS200 mode on Radxa E20C
      arm64: dts: rockchip: Fix pinctrl node names for RK3528
      arm64: dts: rockchip: Fix UART DMA support for RK3528

Jonathan Corbet (1):
      slub: Fix a documentation build error for krealloc()

Juergen Gross (1):
      xen/gntdev: remove struct gntdev_copy_batch from stack

Julien Massot (1):
      media: ti: j721e-csi2rx: fix list_del corruption

Junxian Huang (4):
      RDMA/hns: Get message length of ack_req from FW
      RDMA/hns: Fix accessing uninitialized resources
      RDMA/hns: Drop GFP_NOWARN
      RDMA/hns: Fix -Wframe-larger-than issue

Juri Lelli (1):
      sched/deadline: Reset extra_bw to max_bw when clearing root domains

Kang Yang (1):
      wifi: ath12k: update channel list in worker when wait flag is set

Kees Cook (7):
      kunit/fortify: Add back "volatile" for sizeof() constants
      sched/task_stack: Add missing const qualifier to end_of_stack()
      wifi: mac80211: Write cnt before copying in ieee80211_copy_rnr_beacon()
      wifi: nl80211: Set num_sub_specs before looping through sub_specs
      wifi: brcmfmac: cyw: Fix __counted_by to be LE variant
      staging: media: atomisp: Fix stack buffer overflow in gmin_get_var_int()
      fortify: Fix incorrect reporting of read buffer size

Kemeng Shi (3):
      mm: swap: correctly use maxpages in swapon syscall to avoid potential deadloop
      mm: swap: fix potential buffer overflow in setup_clusters()
      mm: swap: move nr_swap_pages counter decrement from folio_alloc_swap() to swap_range_alloc()

Kent Overstreet (1):
      dm-flakey: Fix corrupt_bio_byte setup checks

Kiran K (2):
      Bluetooth: btintel: Define a macro for Intel Reset vendor command
      Bluetooth: btintel_pcie: Make driver wait for alive interrupt

Konrad Dybcio (5):
      arm64: dts: qcom: x1p42100: Fix thermal sensor configuration
      arm64: dts: qcom: sdm845: Expand IMEM region
      arm64: dts: qcom: sc7180: Expand IMEM region
      power: sequencing: qcom-wcn: fix bluetooth-wifi copypasta for WCN6855
      drm/msm/dpu: Fill in min_prefill_lines for SC8180X

Konstantin Komarov (1):
      Revert "fs/ntfs3: Replace inode_trylock with inode_lock"

Krzysztof Kozlowski (2):
      ARM: dts: vfxxx: Correctly use two tuples for timer address
      dmaengine: mmp: Fix again Wvoid-pointer-to-enum-cast warning

Kuan-Chung Chen (1):
      wifi: rtw89: fix EHT 20MHz TX rate for non-AP STA

Kumar Kartikeya Dwivedi (1):
      bpf: Ensure RCU lock is held around bpf_prog_ksym_find

Kuninori Morimoto (1):
      ASoC: soc-dai: tidyup return value of snd_soc_xlate_tdm_slot_mask()

Kuniyuki Iwashima (2):
      bpf: Disable migration in nf_hook_run_bpf().
      neighbour: Fix null-ptr-deref in neigh_flush_dev().

Lad Prabhakar (1):
      clk: renesas: rzv2h: Fix missing CLK_SET_RATE_PARENT flag for ddiv clocks

Laurentiu Palcu (1):
      clk: imx95-blk-ctl: Fix synchronous abort

Len Brown (1):
      tools/power turbostat: regression fix: --show C1E%

Leo Yan (1):
      perf tests bp_account: Fix leaked file descriptor

Leon Romanovsky (1):
      RDMA/uverbs: Add empty rdma_uattrs_has_raw_cap() declaration

Li Lingfeng (1):
      scsi: Revert "scsi: iscsi: Fix HW conn removal use after free"

Li Ming (2):
      cxl/core: Introduce a new helper cxl_resource_contains_addr()
      cxl/edac: Fix wrong dpa checking for PPR operation

Lifeng Zheng (3):
      PM / devfreq: Check governor before using governor->name
      cpufreq: Initialize cpufreq-based frequency-invariance later
      cpufreq: Init policy->rwsem before it may be possibly used

Lijo Lazar (1):
      drm/amdgpu: Remove nbiov7.9 replay count reporting

Lijuan Gao (1):
      arm64: dts: qcom: sa8775p: Correct the interrupt for remoteproc

Lizhi Xu (1):
      vmci: Prevent the dispatching of uninitialized payloads

Lorenzo Bianconi (5):
      wifi: mt76: mt7996: Fix secondary link lookup in mt7996_mcu_sta_mld_setup_tlv()
      wifi: mt76: mt7996: Fix possible OOB access in mt7996_tx()
      wifi: mt76: mt7996: Fix valid_links bitmask in mt7996_mac_sta_{add,remove}
      net: airoha: Fix PPE table access in airoha_ppe_debugfs_foe_show()
      net: airoha: npu: Add missing MODULE_FIRMWARE macros

Lorenzo Stoakes (1):
      selftests/perf_events: Add a mmap() correctness test

Lu Baolu (1):
      iommu/vt-d: Fix UAF on sva unbind with pending IOPFs

Luca Weiss (3):
      phy: qualcomm: phy-qcom-eusb2-repeater: Don't zero-out registers
      phy: qcom: phy-qcom-snps-eusb2: Add missing write from init sequence
      net: ipa: add IPA v5.1 and v5.5 to ipa_version_string()

Lucas De Marchi (1):
      usb: early: xhci-dbc: Fix early_ioremap leak

Lukasz Laguna (1):
      drm/xe/vf: Disable CSC support on VF

Maharaja Kennadyrajan (1):
      wifi: mac80211: use RCU-safe iteration in ieee80211_csa_finish

Maher Azzouzi (1):
      net/sched: mqprio: fix stack out-of-bounds write in tc entry parsing

Manivannan Sadhasivam (1):
      PCI: endpoint: pci-epf-vntb: Fix the incorrect usage of __iomem attribute

Marc Zyngier (2):
      KVM: arm64: Check for SYSREGS_ON_CPU before accessing the CPU state
      KVM: arm64: Filter out HCR_EL2 bits when running in hypervisor context

Marco Elver (1):
      kcsan: test: Initialize dummy variable

Mark Bloch (1):
      RDMA/ipoib: Use parent rdma device net namespace

Mark Brown (1):
      kselftest/arm64: Fix check for setting new VLs in sve-ptrace

Martin Kaistra (1):
      wifi: rtl8xxxu: Fix RX skb size for aggregation disabled

Masahiro Yamada (2):
      arm64: fix unnecessary rebuilding when CONFIG_DEBUG_EFI=y
      kconfig: qconf: fix ConfigList::updateListAllforAll()

Matthew Wilcox (Oracle) (2):
      memcg_slabinfo: Fix use of PG_slab
      squashfs: use folios in squashfs_bio_read_cached()

Max Krummenacher (1):
      arm64: dts: freescale: imx8mp-toradex-smarc: fix lvds dsi mux gpio

Meghana Malladi (1):
      net: ti: icssg-prueth: Fix skb handling for XDP_PASS

Mengbiao Xiong (1):
      crypto: ccp - Fix crash when rebind ccp device for ccp.ko

Michael J. Ruhl (3):
      drm/xe: Correct the rev value for the DVSEC entries
      drm/xe: Correct BMG VSEC header sizing
      platform/x86/intel/pmt: fix a crashlog NULL pointer access

Michael Walle (1):
      arm64: dts: ti: k3-am62p-j722s: fix pinctrl-single size

Michal Koutný (1):
      cgroup: Add compatibility option for content of /proc/cgroups

Michal Luczaj (1):
      kcm: Fix splice support

Michal Schmidt (1):
      benet: fix BUG when creating VFs

Michal Wajdeczko (2):
      drm/xe/configfs: Fix pci_dev reference leak
      drm/xe/pf: Disable PF restart worker on device removal

Mickaël Salaün (1):
      selftests/landlock: Fix readlink check

Mike Christie (1):
      vhost-scsi: Fix log flooding with target does not exist errors

Mikhail Zaslonko (1):
      s390/boot: Fix startup debugging log

Ming Lei (2):
      nbd: fix lockdep deadlock warning
      ublk: validate ublk server pid

Ming Qian (1):
      media: imx-jpeg: Account for data_offset when getting image address

Mohamed Khalfella (2):
      nvmet: initialize discovery subsys after debugfs is initialized
      nvmet: exit debugfs after discovery subsystem exits

Mohsin Bashir (2):
      eth: fbnic: Fix tx_dropped reporting
      eth: fbnic: Lock the tx_dropped update

Moon Hee Lee (2):
      selftests: breakpoints: use suspend_stats to reliably check suspend success
      wifi: mac80211: reject TDLS operations when station is not associated

Mukesh Ojha (1):
      pinmux: fix race causing mux_owner NULL with active mux_usecount

Murad Masimov (1):
      wifi: plfxlc: Fix error handling in usb driver probe

Mykyta Yatsenko (1):
      selftests/bpf: Fix unintentional switch case fall through

Namhyung Kim (10):
      perf parse-events: Set default GH modifier properly
      perf tools: Fix use-after-free in help_unknown_cmd()
      perf sched: Make sure it frees the usage string
      perf sched: Free thread->priv using priv_destructor
      perf sched: Fix memory leaks in 'perf sched map'
      perf sched: Fix thread leaks in 'perf sched timehist'
      perf sched: Fix memory leaks for evsel->priv in timehist
      perf sched: Use RC_CHK_EQUAL() to compare pointers
      perf sched: Fix memory leaks in 'perf sched latency'
      perf record: Cache build-ID of hit DSOs only

Namjae Jeon (4):
      ksmbd: fix null pointer dereference error in generate_encryptionkey
      ksmbd: fix Preauh_HashValue race condition
      ksmbd: fix corrupted mtime and ctime in smb2_open
      ksmbd: limit repeated connections from clients with the same IP

NeilBrown (1):
      nfsd: avoid ref leak in nfsd_open_local_fh()

Niklas Cassel (3):
      PCI: Rename PCIE_RESET_CONFIG_DEVICE_WAIT_MS to PCIE_RESET_CONFIG_WAIT_MS
      PCI: dw-rockchip: Wait PCIE_RESET_CONFIG_WAIT_MS after link-up IRQ
      PCI: qcom: Wait PCIE_RESET_CONFIG_WAIT_MS after link-up IRQ

Niklas Söderlund (1):
      arm64: dts: renesas: r8a779g3-sparrow-hawk-fan-pwm: Add missing install target

Nilay Shroff (1):
      block: restore two stage elevator switch while running nr_hw_queue update

Nuno Sá (1):
      clk: clk-axi-clkgen: fix fpfd_max frequency for zynq

Olga Kornievskaia (3):
      NFSv4.2: another fix for listxattr
      sunrpc: fix client side handling of tls alerts
      sunrpc: fix handling of server side tls alerts

Ovidiu Panait (2):
      crypto: sun8i-ce - fix nents passed to dma_unmap_sg()
      hwrng: mtk - handle devm_pm_runtime_enable errors

P Praneesh (1):
      wifi: ath12k: Fix double budget decrement while reaping monitor ring

Parav Pandit (8):
      RDMA/uverbs: Check CAP_NET_RAW in user namespace for flow create
      RDMA/mlx5: Check CAP_NET_RAW in user namespace for flow create
      RDMA/mlx5: Check CAP_NET_RAW in user namespace for anchor create
      RDMA/uverbs: Check CAP_NET_RAW in user namespace for QP create
      RDMA/uverbs: Check CAP_NET_RAW in user namespace for RAW QP create
      RDMA/mlx5: Check CAP_NET_RAW in user namespace for devx create
      RDMA/nldev: Check CAP_NET_RAW in user namespace for QP modify
      RDMA/counter: Check CAP_NET_RAW check in user namespace for RDMA counters

Parth Pancholi (1):
      arm64: dts: ti: k3-am62p-verdin: fix PWM_3_DSI GPIO direction

Patrick Delaunay (1):
      arm64: dts: st: fix timer used for ticks

Paul Chaignon (3):
      bpf: Reject narrower access to pointer ctx fields
      bpf: Check flow_dissector ctx accesses are aligned
      bpf: Check netfilter ctx accesses are aligned

Paul Kocialkowski (1):
      clk: sunxi-ng: v3s: Fix de clock definition

Paulo Alcantara (3):
      smb: client: allow parsing zero-length AV pairs
      smb: client: set symlink type as native for POSIX mounts
      smb: client: default to nonativesocket under POSIX mounts

Pawan Gupta (4):
      x86/bugs: Avoid AUTO after the select step in the retbleed mitigation
      x86/bugs: Simplify the retbleed=stuff checks
      x86/bugs: Introduce cdt_possible()
      x86/bugs: Allow ITS stuffing in eIBRS+retpoline mode also

Pei Xiao (1):
      ASOC: rockchip: fix capture stream handling in rockchip_sai_xfer_stop

Peter Zijlstra (2):
      sched/psi: Optimize psi_group_change() cpu_clock() usage
      sched/psi: Fix psi_seq initialization

Petr Machata (1):
      net: ipv6: ip6mr: Fix in/out netdev to pass to the FORWARD chain

Petr Pavlu (1):
      module: Restore the moduleparam prefix length check

Phil Sutter (2):
      netfilter: nf_tables: Drop dead code from fill_*_info routines
      selftests: netfilter: Ignore tainted kernels in interface stress test

Puranjay Mohan (2):
      selftests/bpf: fix implementation of smp_mb()
      bpf, arm64: Fix fp initialization for exception boundary

Qasim Ijaz (1):
      HID: apple: validate feature-report field count to prevent NULL pointer dereference

Quang Le (1):
      net/packet: fix a race in packet_set_ring() and packet_notifier()

Quentin Schulz (1):
      arm64: dts: rockchip: fix endpoint dtc warning for PX30 ISP

Rafael J. Wysocki (2):
      cpufreq: intel_pstate: Always use HWP_DESIRED_PERF in passive mode
      kexec_core: Fix error code path in the KEXEC_JUMP flow

Rameshkumar Sundaram (2):
      wifi: mac80211: Fix bssid_indicator for MBSSID in AP mode
      wifi: ath12k: Avoid accessing uninitialized arvif->ar during beacon miss

Randy Dunlap (2):
      io_uring: fix breakage in EXPERT menu
      can: tscan1: CAN_TSCAN1 can depend on PC104

Remi Pommarel (2):
      wifi: mac80211: Check 802.11 encaps offloading in ieee80211_tx_h_select_key()
      Reapply "wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()"

Richard Guy Briggs (1):
      audit,module: restore audit logging in load failure case

Rick Wertenbroek (1):
      nvmet: pci-epf: Do not complete commands twice if nvmet_req_init() fails

Robin Murphy (2):
      PCI: Fix driver_managed_dma check
      perf/arm-ni: Set initial IRQ affinity

Rodrigo Gobbi (1):
      soundwire: debugfs: move debug statement outside of error handling

Rohit Visavalia (1):
      clk: xilinx: vcu: unregister pll_post only if registered correctly

RubenKelevra (1):
      fs_context: fix parameter name in infofc() macro

Ryan Lee (2):
      apparmor: ensure WB_HISTORY_SIZE value is a power of 2
      apparmor: fix loop detection used in conflicting attachment resolution

Ryan Wanner (2):
      ARM: dts: microchip: sama7d65: Add clock name property
      ARM: dts: microchip: sam9x7: Add clock name property

Salomon Dushimirimana (1):
      scsi: sd: Make sd shutdown issue START STOP UNIT appropriately

Samuel Holland (1):
      RISC-V: KVM: Fix inclusion of Smnpm in the guest ISA bitmap

Sean Christopherson (3):
      KVM: x86: Convert vcpu_run()'s immediate exit param into a generic bitmap
      KVM: x86: Drop kvm_x86_ops.set_dr6() in favor of a new KVM_RUN flag
      KVM: VMX: Allow guest to set DEBUGCTL.RTM_DEBUG if RTM is supported

Sebastian Reichel (1):
      arm64: dts: rockchip: fix PHY handling for ROCK 4D

Sergey Senozhatsky (1):
      wifi: ath11k: clear initialized flag for deinit-ed srng lists

Seunghui Lee (1):
      scsi: ufs: core: Use link recovery when h8 exit fails during runtime resume

Seungjin Bae (1):
      usb: host: xhci-plat: fix incorrect type for of_match variable in xhci_plat_probe()

Shahar Shitrit (1):
      net/mlx5e: Fix potential deadlock by deferring RX timeout recovery

Shankari Anand (1):
      rust: miscdevice: clarify invariant for `MiscDeviceRegistration`

Shashank Balaji (1):
      selftests/cgroup: fix cpu.max tests

Sheng Yong (1):
      f2fs: fix bio memleak when committing super block

Shengjiu Wang (2):
      ASoC: fsl_xcvr: get channel status data when PHY is not exists
      ASoC: fsl_xcvr: get channel status data with firmware exists

Shin'ichiro Kawasaki (1):
      zloop: fix KASAN use-after-free of tag set

Shiraz Saleem (1):
      RDMA/mana_ib: Fix DSCP value in modify QP

Shixiong Ou (1):
      fbcon: Fix outdated registered_fb reference in comment

Shree Ramamoorthy (1):
      mfd: tps65219: Update TPS65214 MFD cell's GPIO compatible string

Shubhrajyoti Datta (1):
      clk: clocking-wizard: Fix the round rate handling for versal

Shuicheng Lin (1):
      drm/xe/uapi: Correct sync type definition in comments

Sibi Sankar (1):
      firmware: arm_scmi: Fix up turbo frequencies selection

Simon Trimmer (1):
      spi: cs42l43: Property entry should be a null-terminated array

Simona Vetter (1):
      drm/panthor: Fix UAF in panthor_gem_create_with_handle() debugfs code

Sivan Zohar-Kotzer (1):
      powercap: dtpm_cpu: Fix NULL pointer dereference in get_pd_power_uw()

Slark Xiao (2):
      bus: mhi: host: pci_generic: Fix the modem name of Foxconn T99W640
      USB: serial: option: add Foxconn T99W709

Song Liu (1):
      selftests/landlock: Fix build of audit_test

Stanislav Fomichev (3):
      team: replace team lock with rtnl lock
      macsec: set IFF_UNICAST_FLT priv flag
      vrf: Drop existing dst reference in vrf_ip6_input_dst

Stanley Chu (1):
      i3c: master: svc: Fix npcm845 FIFO_EMPTY quirk

Stav Aviram (1):
      net/mlx5: Check device memory pointer before usage

Stefan Metzmacher (9):
      smb: server: remove separate empty_recvmsg_queue
      smb: server: make sure we call ib_dma_unmap_single() only if we called ib_dma_map_single already
      smb: server: let recv_done() consistently call put_recvmsg/smb_direct_disconnect_rdma_connection
      smb: server: let recv_done() avoid touching data_transfer after cleanup/move
      smb: client: remove separate empty_packet_queue
      smb: client: make sure we call ib_dma_unmap_single() only if we called ib_dma_map_single already
      smb: client: let recv_done() cleanup before notifying the callers.
      smb: client: let recv_done() avoid touching data_transfer after cleanup/move
      smb: client: return an error if rdma_connect does not return within 5 seconds

Stephane Grosjean (1):
      can: peak_usb: fix USB FD devices potential malfunction

Steven Rostedt (4):
      selftests/tracing: Fix false failure of subsystem event test
      PM: cpufreq: powernv/tracing: Move powernv_throttle trace event
      ring-buffer: Remove ring_buffer_read_prepare_sync()
      tracing: Use queue_rcu_work() to free filters

Suman Kumar Chakraborty (3):
      crypto: qat - use unmanaged allocation for dc_data
      crypto: qat - restore ASYM service support for GEN6 devices
      crypto: qat - fix virtual channel configuration for GEN6 devices

Sumanth Korikkar (1):
      s390/mm: Allocate page table with PAGE_SIZE granularity

Sumit Gupta (1):
      soc/tegra: cbb: Clear ERR_FORCE register with ERR_STATUS

Sun YangKai (1):
      btrfs: remove partial support for lowest level from btrfs_search_forward()

Suren Baghdasaryan (1):
      mm: fix a UAF when vma->mm is freed after vma->vm_refcnt got dropped

Svyatoslav Pankratov (1):
      crypto: qat - fix state restore for banks with exceptions

Takahiro Kuwano (1):
      mtd: spi-nor: spansion: Fixup params->set_4byte_addr_mode for SEMPER

Takamitsu Iwai (1):
      net/sched: taprio: enforce minimum value for picos_per_byte

Takashi Iwai (2):
      ALSA: usb: scarlett2: Fix missing NULL check
      ALSA: hda/ca0132: Fix missing error handling in ca0132_alt_select_out()

Tamizh Chelvam Raja (2):
      wifi: ath12k: Pass ab pointer directly to ath12k_dp_tx_get_encap_type()
      wifi: ath12k: fix endianness handling while accessing wmi service bit

Tanmay Shah (1):
      remoteproc: xlnx: Disable unsupported features

Tao Xue (1):
      usb: gadget : fix use-after-free in composite_dev_cleanup()

Thiraviyam Mariyappan (1):
      wifi: ath12k: Clear auth flag only for actual association in security mode

Thomas Antoine (1):
      power: supply: max1720x correct capacity computation

Thomas Fourier (14):
      block: mtip32xx: Fix usage of dma_map_sg()
      mwl8k: Add missing check after DMA map
      Fix dma_unmap_sg() nents value
      crypto: inside-secure - Fix `dma_unmap_sg()` nents value
      scsi: ibmvscsi_tgt: Fix dma_unmap_sg() nents value
      scsi: elx: efct: Fix dma_unmap_sg() nents value
      scsi: mvsas: Fix dma_unmap_sg() nents value
      scsi: isci: Fix dma_unmap_sg() nents value
      crypto: keembay - Fix dma_unmap_sg() nents value
      crypto: img-hash - Fix dma_unmap_sg() nents value
      dmaengine: mv_xor: Fix missing check after DMA map and missing unmap
      dmaengine: nbpfaxi: Add missing check after DMA map
      mtd: rawnand: atmel: Fix dma_mapping_error() address
      mtd: rawnand: rockchip: Add missing check after DMA map

Thomas Gleixner (6):
      x86/irq: Plug vector setup race
      perf/core: Preserve AUX buffer allocation failure result
      perf/core: Don't leak AUX buffer refcount on allocation failure
      perf/core: Exit early on perf_mmap() fail
      perf/core: Handle buffer mapping fail correctly in perf_mmap()
      perf/core: Prevent VMA split of buffer mappings

Thomas Richard (1):
      pinctrl: cirrus: madera-core: Use devm_pinctrl_register_mappings()

Thomas Weißschuh (6):
      selftests: vDSO: chacha: Correctly skip test if necessary
      selftests/nolibc: correctly report errors from printf() and friends
      tools/nolibc: avoid false-positive -Wmaybe-uninitialized through waitpid()
      spi: spi-nxp-fspi: Check return value of devm_mutex_init()
      leds: lp8860: Check return value of devm_mutex_init()
      bpf/preload: Don't select USERMODE_DRIVER

Thorsten Blum (2):
      smb: server: Fix extension string in ksmbd_extract_shortname()
      ALSA: intel_hdmi: Fix off-by-one error in __hdmi_lpe_audio_probe()

Tigran Mkrtchyan (1):
      pNFS/flexfiles: don't attempt pnfs on fatal DS errors

Tim Harvey (1):
      arm64: dts: imx8mp-venice-gw74xx: update name of M2SKT_WDIS2# gpio

Timothy Pearson (5):
      PCI: pnv_php: Clean up allocated IRQs on unplug
      PCI: pnv_php: Work around switches with broken presence detection
      powerpc/eeh: Export eeh_unfreeze_pe()
      powerpc/eeh: Make EEH driver device hotplug safe
      PCI: pnv_php: Fix surprise plug detection and recovery

Ting-Ying Li (1):
      wifi: brcmfmac: fix EXTSAE WPA3 connection failure due to AUTH TX failure

Tingmao Wang (1):
      landlock: Fix warning from KUnit tests

Tiwei Bie (1):
      um: rtc: Avoid shadowing err in uml_rtc_start()

Tom Lendacky (1):
      x86/sev: Evict cache lines during SNP memory validation

Tomas Henzl (1):
      scsi: mpt3sas: Fix a fw_event memory leak

Tristram Ha (1):
      net: dsa: microchip: Fix wrong rx drop MIB counter for KSZ8863

Trond Myklebust (5):
      NFS: Fix wakeup of __nfs_lookup_revalidate() in unblock_revalidate()
      NFS: Fix filehandle bounds checking in nfs_fh_to_dentry()
      NFS/localio: nfs_close_local_fh() fix check for file closed
      NFS/localio: nfs_uuid_put() fix races with nfs_open/close_local_fh()
      NFS/localio: nfs_uuid_put() fix the wake up after unlinking the file

Tze-nan Wu (1):
      rcu: Fix delayed execution of hurry callbacks

Uday Shankar (1):
      ublk: speed up ublk server exit handling

Uros Bizjak (1):
      ucount: fix atomic_long_inc_below() argument type

Varshini Rajendran (1):
      clk: at91: sam9x7: update pll clk ranges

Venkata Prasad Potturu (1):
      ASoC: amd: acp: Fix pointer assignments for snd_soc_acpi_mach structures

Vincent Mailhol (1):
      can: tscan1: Kconfig: add COMPILE_TEST

Vitaly Prosyak (3):
      drm/amdgpu: fix slab-use-after-free in amdgpu_userq_mgr_fini+0x70c
      Revert "drm/amdgpu: fix slab-use-after-free in amdgpu_userq_mgr_fini"
      drm/amdgpu: fix use-after-free in amdgpu_userq_suspend+0x51a/0x5a0

Wadim Egorov (1):
      arm64: dts: ti: k3-am642-phyboard-electra: Fix PRU-ICSSG Ethernet ports

Wang Liang (1):
      net: drop UFO packets in udp_rcv_segment()

Wang Zhaolong (1):
      smb: client: fix netns refcount leak after net_passive changes

WangYuli (2):
      gitignore: allow .pylintrc to be tracked
      selftests: ALSA: fix memory leak in utimer test

Will Deacon (1):
      arm64: dts: exynos: gs101: Add 'local-timer-stop' to cpuidle nodes

William Liu (1):
      net/sched: Restrict conditions for adding duplicating netems to qdisc tree

Xiu Jianfeng (1):
      wifi: iwlwifi: Fix memory leak in iwl_mvm_init()

Xiumei Mu (1):
      selftests: rtnetlink.sh: remove esp4_offload after test

Yang Erkun (1):
      md: make rdev_addable usable for rcu mode

Yangtao Li (3):
      hfsplus: make splice write available again
      hfs: make splice write available again
      hfsplus: remove mutex_lock check in hfsplus_free_extents

Yao Zi (2):
      clk: thead: th1520-ap: Correctly refer the parent of osc_12m
      clk: thead: th1520-ap: Describe mux clocks with clk_mux

Yi Chen (1):
      selftests: netfilter: ipvs.sh: Explicity disable rp_filter on interface tunl0

Yuan Chen (3):
      bpftool: Fix memory leak in dump_xx_nlmsg on realloc failure
      pinctrl: sunxi: Fix memory leak on krealloc failure
      pinctrl: berlin: fix memory leak in berlin_pinctrl_build_state()

Yuhao Jiang (1):
      USB: gadget: f_hid: Fix memory leak in hidg_bind error path

Ze Huang (2):
      pinctrl: canaan: k230: add NULL check in DT parse
      pinctrl: canaan: k230: Fix order of DT parse and pinctrl register

Zenm Chen (1):
      Bluetooth: btusb: Add USB ID 3625:010b for TP-LINK Archer TX10UB Nano

Zhang Rui (2):
      tools/power turbostat: Fix bogus SysWatt for forked program
      tools/power turbostat: Fix DMR support

Zhang Yi (1):
      ext4: fix insufficient credits calculation in ext4_meta_trans_blocks()

Zheng Qixing (1):
      md: allow removing faulty rdev during resync

Zheng Yu (1):
      jfs: fix metapage reference count leak in dbAllocCtl

Zhengxu Zhang (1):
      exfat: fdatasync flag should be same like generic_write_sync()

Zhiguo Niu (2):
      f2fs: compress: change the first parameter of page_array_{alloc,free} to sbi
      f2fs: compress: fix UAF of f2fs_inode_info in f2fs_free_dic

Zhongqiu Han (1):
      Bluetooth: btusb: Fix potential NULL dereference on kmalloc failure

Zong-Zhe Yang (1):
      wifi: rtw89: avoid NULL dereference when RX problematic packet on unsupported 6 GHz band

wangzijie (1):
      proc: use the same treatment to check proc_lseek as ones for proc_read_iter et.al

wenglianfa (2):
      RDMA/hns: Fix double destruction of rsv_qp
      RDMA/hns: Fix HW configurations not cleared in error flow

xin.guo (1):
      tcp: fix tcp_ofo_queue() to avoid including too much DUP SACK range

yohan.joung (1):
      f2fs: fix to check upper boundary for value of gc_boost_zoned_gc_percent


