Return-Path: <stable+bounces-47678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 593798D468D
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 09:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84C1FB20F4A
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 07:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE4A142E60;
	Thu, 30 May 2024 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K8UAhDID"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297B11448E1;
	Thu, 30 May 2024 07:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717055950; cv=none; b=kb9p0UAmUdIY6XO9F2CKk61VwUMqm8v7mjGFFCMi5CDxOCUkJetoJvR0mHf7N7kPynTDh0WN+MCRZ86/BOl7FaHOVqFcZHlj+A/4tXf4VLqju5cCbvupQiI0ppVIuC3tTTZD3lY2rv1S2Tz300TUUyjq5HCzH6/498Rb8d51fxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717055950; c=relaxed/simple;
	bh=oREwnfrOEuk53lY1W9UwsQLqVT+im3atqaGFU7xeF64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BNFSA4CWI1cVp3zXLGJhaEzjjOBjo6fY2OQRcqWT9YvXbh3yFEpMgHDBPamRUWuZ2QU2Eg8O/bPAx6uoXpPCCkTnvWUMgigWSakZf3fgbkvE9dO3S4iQQGt14iAyLD6h0B/tG5xozyGLL2SPWTXIBGr4805E4tUPFUcZ/CaO99A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K8UAhDID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA193C2BBFC;
	Thu, 30 May 2024 07:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717055949;
	bh=oREwnfrOEuk53lY1W9UwsQLqVT+im3atqaGFU7xeF64=;
	h=From:To:Cc:Subject:Date:From;
	b=K8UAhDIDW2oLjDUpawrNKYc2jc/G3mcTSXkF3Qd8jmXT2+0fce3qPqg2V0iz1hvUo
	 8RKoM9fLof8cv2yZJK0SGZz5HnfDx1bCSGJ/1iiNGEBifmQp5+6cpG0q461JurjvPF
	 xX6gaYeDjNHzQj9QFanGScLHXvXZu6XR/foLWbsw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.8.12
Date: Thu, 30 May 2024 09:59:10 +0200
Message-ID: <2024053036-matron-confess-13e0@gregkh>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Note, this the LAST 6.8.y release, this branch is now end-of-life.  Please move
to the 6.9.y branch at this point in time.

-----------------------

I'm announcing the release of the 6.8.12 kernel.

All users of the 6.8 kernel series must upgrade.

The updated 6.8.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.8.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt                      |    3 
 Documentation/devicetree/bindings/media/i2c/ovti,ov2680.yaml         |   18 
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml              |    1 
 Documentation/devicetree/bindings/sound/rt5645.txt                   |    6 
 Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml |   24 
 Makefile                                                             |    2 
 arch/arm/configs/sunxi_defconfig                                     |    1 
 arch/arm64/include/asm/irqflags.h                                    |    1 
 arch/arm64/kernel/fpsimd.c                                           |   44 
 arch/loongarch/kernel/perf_event.c                                   |    2 
 arch/m68k/kernel/entry.S                                             |    4 
 arch/m68k/mac/misc.c                                                 |   36 
 arch/openrisc/kernel/traps.c                                         |   48 
 arch/parisc/kernel/parisc_ksyms.c                                    |    1 
 arch/powerpc/sysdev/fsl_msi.c                                        |    2 
 arch/riscv/Kconfig.errata                                            |    8 
 arch/riscv/errata/thead/errata.c                                     |   24 
 arch/riscv/include/asm/errata_list.h                                 |   20 
 arch/riscv/net/bpf_jit_comp64.c                                      |   20 
 arch/s390/include/asm/gmap.h                                         |    2 
 arch/s390/include/asm/mmu.h                                          |    5 
 arch/s390/include/asm/mmu_context.h                                  |    1 
 arch/s390/include/asm/pgtable.h                                      |   16 
 arch/s390/kvm/kvm-s390.c                                             |    4 
 arch/s390/mm/gmap.c                                                  |  165 +
 arch/s390/net/bpf_jit_comp.c                                         |    8 
 arch/sh/kernel/kprobes.c                                             |    7 
 arch/sh/lib/checksum.S                                               |   67 
 arch/x86/Kconfig                                                     |    8 
 arch/x86/boot/compressed/head_64.S                                   |    5 
 arch/x86/crypto/nh-avx2-x86_64.S                                     |    1 
 arch/x86/crypto/sha256-avx2-asm.S                                    |    1 
 arch/x86/crypto/sha512-avx2-asm.S                                    |    1 
 arch/x86/entry/vsyscall/vsyscall_64.c                                |   28 
 arch/x86/include/asm/cmpxchg_64.h                                    |    2 
 arch/x86/include/asm/pgtable_types.h                                 |    2 
 arch/x86/include/asm/processor.h                                     |    1 
 arch/x86/include/asm/sparsemem.h                                     |    2 
 arch/x86/kernel/cpu/microcode/amd.c                                  |    2 
 arch/x86/kernel/tsc_sync.c                                           |    6 
 arch/x86/lib/x86-opcode-map.txt                                      |   10 
 arch/x86/mm/fault.c                                                  |   33 
 arch/x86/mm/numa.c                                                   |    4 
 arch/x86/mm/pat/set_memory.c                                         |   68 
 arch/x86/net/bpf_jit_comp.c                                          |   57 
 arch/x86/purgatory/Makefile                                          |    3 
 arch/x86/tools/relocs.c                                              |    9 
 block/blk-core.c                                                     |    9 
 block/blk-merge.c                                                    |    2 
 block/blk-mq.c                                                       |    4 
 block/blk.h                                                          |    1 
 block/fops.c                                                         |    2 
 block/genhd.c                                                        |    2 
 block/partitions/cmdline.c                                           |   49 
 crypto/asymmetric_keys/Kconfig                                       |    3 
 drivers/accessibility/speakup/main.c                                 |    2 
 drivers/acpi/acpi_lpss.c                                             |    1 
 drivers/acpi/acpica/Makefile                                         |    1 
 drivers/acpi/bus.c                                                   |    5 
 drivers/acpi/numa/srat.c                                             |    5 
 drivers/block/null_blk/main.c                                        |    2 
 drivers/bluetooth/btmrvl_main.c                                      |    9 
 drivers/bluetooth/btqca.c                                            |    4 
 drivers/bluetooth/btrsi.c                                            |    1 
 drivers/bluetooth/btsdio.c                                           |    8 
 drivers/bluetooth/btusb.c                                            |    5 
 drivers/bluetooth/hci_bcm4377.c                                      |    1 
 drivers/bluetooth/hci_ldisc.c                                        |    6 
 drivers/bluetooth/hci_serdev.c                                       |    5 
 drivers/bluetooth/hci_uart.h                                         |    1 
 drivers/bluetooth/hci_vhci.c                                         |   10 
 drivers/bluetooth/virtio_bt.c                                        |    2 
 drivers/char/hw_random/stm32-rng.c                                   |   18 
 drivers/clk/clk-renesas-pcie.c                                       |   10 
 drivers/clk/mediatek/clk-mt8365-mm.c                                 |    2 
 drivers/clk/mediatek/clk-pllfh.c                                     |    2 
 drivers/clk/qcom/Kconfig                                             |    2 
 drivers/clk/qcom/apss-ipq-pll.c                                      |    3 
 drivers/clk/qcom/clk-alpha-pll.c                                     |    1 
 drivers/clk/qcom/dispcc-sm6350.c                                     |   11 
 drivers/clk/qcom/dispcc-sm8450.c                                     |   20 
 drivers/clk/qcom/dispcc-sm8550.c                                     |   20 
 drivers/clk/qcom/dispcc-sm8650.c                                     |   20 
 drivers/clk/qcom/mmcc-msm8998.c                                      |    8 
 drivers/clk/renesas/r8a779a0-cpg-mssr.c                              |    2 
 drivers/clk/renesas/r9a07g043-cpg.c                                  |    9 
 drivers/clk/samsung/clk-exynosautov9.c                               |    8 
 drivers/cpufreq/brcmstb-avs-cpufreq.c                                |    5 
 drivers/cpufreq/cppc_cpufreq.c                                       |   14 
 drivers/cpufreq/cpufreq.c                                            |   11 
 drivers/crypto/bcm/spu2.c                                            |    2 
 drivers/crypto/ccp/sp-platform.c                                     |   14 
 drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c               |    2 
 drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c                 |    2 
 drivers/crypto/intel/qat/qat_4xxx/adf_drv.c                          |    2 
 drivers/crypto/intel/qat/qat_common/adf_gen4_tl.c                    |    1 
 drivers/crypto/intel/qat/qat_common/adf_rl.c                         |    2 
 drivers/crypto/intel/qat/qat_common/adf_telemetry.c                  |   21 
 drivers/crypto/intel/qat/qat_common/adf_telemetry.h                  |    1 
 drivers/crypto/marvell/octeontx2/cn10k_cpt.c                         |    4 
 drivers/dma/xilinx/xdma.c                                            |   14 
 drivers/dpll/dpll_core.c                                             |    2 
 drivers/edac/skx_common.c                                            |    2 
 drivers/edac/versal_edac.c                                           |    5 
 drivers/firmware/qcom/qcom_scm.c                                     |   12 
 drivers/firmware/raspberrypi.c                                       |    7 
 drivers/fpga/dfl-pci.c                                               |    3 
 drivers/gpio/gpio-npcm-sgpio.c                                       |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                     |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c                              |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c                           |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                               |    3 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                               |    3 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                                |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c                             |   16 
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                             |    8 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                                 |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                    |    1 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c       |    8 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c         |   15 
 drivers/gpu/drm/amd/display/dc/core/dc.c                             |    3 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c               |    5 
 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c                 |    2 
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c              |    3 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c      |   10 
 drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c       |    1 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c                 |   25 
 drivers/gpu/drm/arm/malidp_mw.c                                      |    5 
 drivers/gpu/drm/bridge/analogix/anx7625.c                            |   15 
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c                  |    3 
 drivers/gpu/drm/bridge/chipone-icn6211.c                             |    6 
 drivers/gpu/drm/bridge/lontium-lt8912b.c                             |    6 
 drivers/gpu/drm/bridge/lontium-lt9611.c                              |    6 
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c                           |    6 
 drivers/gpu/drm/bridge/tc358775.c                                    |    6 
 drivers/gpu/drm/bridge/ti-dlpc3433.c                                 |   17 
 drivers/gpu/drm/bridge/ti-sn65dsi86.c                                |    1 
 drivers/gpu/drm/ci/test.yml                                          |    6 
 drivers/gpu/drm/display/drm_dp_helper.c                              |   35 
 drivers/gpu/drm/drm_bridge.c                                         |   10 
 drivers/gpu/drm/drm_edid.c                                           |    2 
 drivers/gpu/drm/drm_mipi_dsi.c                                       |    6 
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c                                |    4 
 drivers/gpu/drm/imagination/pvr_vm_mips.c                            |    4 
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c                              |    8 
 drivers/gpu/drm/mediatek/mtk_drm_gem.c                               |    3 
 drivers/gpu/drm/meson/meson_vclk.c                                   |    6 
 drivers/gpu/drm/msm/dp/dp_aux.c                                      |   20 
 drivers/gpu/drm/msm/dp/dp_aux.h                                      |    1 
 drivers/gpu/drm/msm/dp/dp_ctrl.c                                     |    6 
 drivers/gpu/drm/msm/dp/dp_display.c                                  |    4 
 drivers/gpu/drm/msm/dp/dp_link.c                                     |   22 
 drivers/gpu/drm/msm/dp/dp_link.h                                     |   14 
 drivers/gpu/drm/mxsfb/lcdif_drv.c                                    |    6 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/r535.c                      |    2 
 drivers/gpu/drm/omapdrm/Kconfig                                      |    2 
 drivers/gpu/drm/omapdrm/omap_fbdev.c                                 |   40 
 drivers/gpu/drm/panel/panel-edp.c                                    |    3 
 drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c                   |    5 
 drivers/gpu/drm/panel/panel-novatek-nt35950.c                        |    6 
 drivers/gpu/drm/panel/panel-samsung-atna33xc20.c                     |   24 
 drivers/gpu/drm/panel/panel-simple.c                                 |    3 
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c                         |   22 
 drivers/gpu/drm/vc4/vc4_hdmi.c                                       |    2 
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c                        |   10 
 drivers/hid/hid-mcp2221.c                                            |    2 
 drivers/hid/hid-nintendo.c                                           |    8 
 drivers/hid/intel-ish-hid/ipc/pci-ish.c                              |    5 
 drivers/infiniband/core/cma.c                                        |    4 
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                             |    3 
 drivers/infiniband/hw/hns/hns_roce_cq.c                              |   24 
 drivers/infiniband/hw/hns/hns_roce_hem.h                             |   12 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                           |    7 
 drivers/infiniband/hw/hns/hns_roce_main.c                            |    1 
 drivers/infiniband/hw/hns/hns_roce_mr.c                              |   15 
 drivers/infiniband/hw/hns/hns_roce_srq.c                             |    6 
 drivers/infiniband/hw/mana/cq.c                                      |   54 
 drivers/infiniband/hw/mana/main.c                                    |   43 
 drivers/infiniband/hw/mana/mana_ib.h                                 |   14 
 drivers/infiniband/hw/mana/qp.c                                      |   26 
 drivers/infiniband/hw/mlx5/mem.c                                     |    8 
 drivers/infiniband/hw/mlx5/mlx5_ib.h                                 |    3 
 drivers/infiniband/hw/mlx5/mr.c                                      |   35 
 drivers/infiniband/sw/rxe/rxe_comp.c                                 |    6 
 drivers/infiniband/sw/rxe/rxe_net.c                                  |   12 
 drivers/infiniband/sw/rxe/rxe_verbs.c                                |    6 
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c                            |    8 
 drivers/input/input.c                                                |  104 +
 drivers/input/joystick/xpad.c                                        |    2 
 drivers/input/mouse/amimouse.c                                       |    8 
 drivers/iommu/iommu.c                                                |   21 
 drivers/irqchip/irq-alpine-msi.c                                     |    2 
 drivers/irqchip/irq-loongson-pch-msi.c                               |    2 
 drivers/macintosh/via-macii.c                                        |   11 
 drivers/md/dm-delay.c                                                |   14 
 drivers/md/md-bitmap.c                                               |    6 
 drivers/media/i2c/et8ek8/et8ek8_driver.c                             |    4 
 drivers/media/pci/intel/ipu3/ipu3-cio2.c                             |   10 
 drivers/media/pci/ngene/ngene-core.c                                 |    4 
 drivers/media/platform/cadence/cdns-csi2rx.c                         |   26 
 drivers/media/platform/renesas/rcar-vin/rcar-vin.h                   |    2 
 drivers/media/radio/radio-shark2.c                                   |    2 
 drivers/media/usb/uvc/uvc_driver.c                                   |   31 
 drivers/media/usb/uvc/uvcvideo.h                                     |    1 
 drivers/media/v4l2-core/v4l2-subdev.c                                |    2 
 drivers/misc/lkdtm/Makefile                                          |    2 
 drivers/misc/lkdtm/perms.c                                           |    2 
 drivers/mtd/mtdcore.c                                                |    6 
 drivers/mtd/nand/raw/nand_hynix.c                                    |    2 
 drivers/net/dsa/mv88e6xxx/chip.c                                     |   50 
 drivers/net/dsa/mv88e6xxx/chip.h                                     |    6 
 drivers/net/dsa/mv88e6xxx/global1.c                                  |   89 +
 drivers/net/dsa/mv88e6xxx/global1.h                                  |    2 
 drivers/net/ethernet/cortina/gemini.c                                |   12 
 drivers/net/ethernet/freescale/enetc/enetc.c                         |    2 
 drivers/net/ethernet/freescale/fec_main.c                            |   26 
 drivers/net/ethernet/intel/ice/ice_base.c                            |  134 +
 drivers/net/ethernet/intel/ice/ice_base.h                            |   10 
 drivers/net/ethernet/intel/ice/ice_common.c                          |    4 
 drivers/net/ethernet/intel/ice/ice_ddp.c                             |   16 
 drivers/net/ethernet/intel/ice/ice_lag.c                             |    6 
 drivers/net/ethernet/intel/ice/ice_lib.c                             |  129 -
 drivers/net/ethernet/intel/ice/ice_lib.h                             |   10 
 drivers/net/ethernet/intel/ice/ice_sched.c                           |    4 
 drivers/net/ethernet/intel/ice/ice_switch.c                          |   10 
 drivers/net/ethernet/intel/ice/ice_xsk.c                             |   22 
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c                       |    3 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                          |  240 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.h                          |   29 
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c                        |   44 
 drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c               |    6 
 drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c                 |    2 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h                    |    4 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c           |   28 
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c                    |    6 
 drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c                  |    4 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                       |   14 
 drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c              |   19 
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c                |    6 
 drivers/net/ethernet/microsoft/mana/hw_channel.c                     |    2 
 drivers/net/ethernet/qlogic/qed/qed_main.c                           |    9 
 drivers/net/ethernet/realtek/r8169_main.c                            |    9 
 drivers/net/ethernet/smsc/smc91x.h                                   |    4 
 drivers/net/ethernet/stmicro/stmmac/common.h                         |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac.h                         |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c                     |    6 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                    |   22 
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c                     |    8 
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c                      |  105 +
 drivers/net/ethernet/sun/sungem.c                                    |   14 
 drivers/net/ethernet/ti/icssg/icssg_prueth.c                         |   14 
 drivers/net/ethernet/wangxun/libwx/wx_hw.c                           |    2 
 drivers/net/ethernet/wangxun/libwx/wx_lib.c                          |   76 
 drivers/net/ethernet/wangxun/libwx/wx_lib.h                          |    2 
 drivers/net/ethernet/wangxun/libwx/wx_type.h                         |   23 
 drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c                     |   18 
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c                        |    1 
 drivers/net/ethernet/wangxun/txgbe/Makefile                          |    1 
 drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c                   |   18 
 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c                       |  269 +++
 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.h                       |    7 
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c                      |  172 --
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c                       |   90 -
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h                       |    3 
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h                      |   18 
 drivers/net/phy/micrel.c                                             |    3 
 drivers/net/usb/aqc111.c                                             |    8 
 drivers/net/usb/qmi_wwan.c                                           |    3 
 drivers/net/usb/smsc95xx.c                                           |   15 
 drivers/net/usb/sr9700.c                                             |   10 
 drivers/net/wireless/ath/ar5523/ar5523.c                             |   14 
 drivers/net/wireless/ath/ath10k/core.c                               |    3 
 drivers/net/wireless/ath/ath10k/debugfs_sta.c                        |    2 
 drivers/net/wireless/ath/ath10k/hw.h                                 |    1 
 drivers/net/wireless/ath/ath10k/targaddrs.h                          |    3 
 drivers/net/wireless/ath/ath10k/wmi.c                                |   26 
 drivers/net/wireless/ath/ath11k/mac.c                                |    9 
 drivers/net/wireless/ath/ath12k/qmi.c                                |    3 
 drivers/net/wireless/ath/ath12k/wmi.c                                |    2 
 drivers/net/wireless/ath/carl9170/tx.c                               |    3 
 drivers/net/wireless/ath/carl9170/usb.c                              |   32 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c              |   15 
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c                    |   19 
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c                |   47 
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c                     |   19 
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h                         |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c                        |    7 
 drivers/net/wireless/marvell/mwl8k.c                                 |    2 
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c                      |   46 
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c                      |    1 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c                 |    1 
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c                  |    6 
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h                      |    2 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                      |   12 
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c                     |    2 
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h                   |    1 
 drivers/net/wireless/realtek/rtw89/ps.c                              |    3 
 drivers/net/wireless/realtek/rtw89/wow.c                             |   12 
 drivers/nvme/host/core.c                                             |   21 
 drivers/nvme/host/multipath.c                                        |    3 
 drivers/nvme/host/nvme.h                                             |   21 
 drivers/nvme/host/pci.c                                              |    8 
 drivers/nvme/host/tcp.c                                              |   10 
 drivers/nvme/target/auth.c                                           |    8 
 drivers/nvme/target/configfs.c                                       |   12 
 drivers/nvme/target/core.c                                           |    5 
 drivers/nvme/target/nvmet.h                                          |    1 
 drivers/nvme/target/tcp.c                                            |   11 
 drivers/of/module.c                                                  |    7 
 drivers/perf/hisilicon/hisi_pcie_pmu.c                               |   14 
 drivers/perf/hisilicon/hns3_pmu.c                                    |   16 
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c          |    1 
 drivers/platform/x86/xiaomi-wmi.c                                    |   18 
 drivers/ptp/ptp_ocp.c                                                |    6 
 drivers/pwm/core.c                                                   |  852 ++++------
 drivers/pwm/pwm-clps711x.c                                           |    1 
 drivers/pwm/pwm-cros-ec.c                                            |    1 
 drivers/pwm/pwm-meson.c                                              |   51 
 drivers/pwm/pwm-pxa.c                                                |    4 
 drivers/pwm/pwm-sti.c                                                |   46 
 drivers/pwm/sysfs.c                                                  |    4 
 drivers/regulator/irq_helpers.c                                      |    3 
 drivers/regulator/qcom-refgen-regulator.c                            |    1 
 drivers/regulator/vqmmc-ipq4019-regulator.c                          |    1 
 drivers/s390/cio/trace.h                                             |    2 
 drivers/scsi/bfa/bfad_debugfs.c                                      |    4 
 drivers/scsi/hpsa.c                                                  |    2 
 drivers/scsi/libsas/sas_expander.c                                   |    3 
 drivers/scsi/qedf/qedf_debugfs.c                                     |    2 
 drivers/scsi/qla2xxx/qla_dfs.c                                       |    2 
 drivers/soc/mediatek/mtk-cmdq-helper.c                               |    5 
 drivers/soc/qcom/pmic_glink.c                                        |   26 
 drivers/staging/media/atomisp/pci/sh_css.c                           |    1 
 drivers/staging/media/starfive/camss/stf-camss.c                     |    6 
 drivers/thermal/mediatek/lvts_thermal.c                              |    4 
 drivers/thermal/qcom/tsens.c                                         |    2 
 drivers/thermal/thermal_core.c                                       |   12 
 drivers/thermal/thermal_debugfs.c                                    |   27 
 drivers/thermal/thermal_debugfs.h                                    |    4 
 drivers/tty/n_gsm.c                                                  |  140 +
 drivers/tty/serial/8250/8250_bcm7271.c                               |  101 -
 drivers/tty/serial/8250/8250_mtk.c                                   |    8 
 drivers/tty/serial/sc16is7xx.c                                       |   23 
 drivers/ufs/core/ufs-mcq.c                                           |    3 
 drivers/ufs/core/ufshcd.c                                            |    6 
 drivers/ufs/host/cdns-pltfrm.c                                       |    2 
 drivers/ufs/host/ufs-qcom.c                                          |    7 
 drivers/ufs/host/ufs-qcom.h                                          |   12 
 drivers/video/fbdev/Kconfig                                          |    4 
 drivers/video/fbdev/core/Kconfig                                     |    6 
 drivers/video/fbdev/sh_mobile_lcdcfb.c                               |    2 
 drivers/video/fbdev/sis/init301.c                                    |    3 
 drivers/virt/acrn/mm.c                                               |   61 
 fs/btrfs/ioctl.c                                                     |   33 
 fs/btrfs/qgroup.c                                                    |   21 
 fs/dlm/ast.c                                                         |   14 
 fs/dlm/dlm_internal.h                                                |    1 
 fs/dlm/user.c                                                        |   15 
 fs/ecryptfs/keystore.c                                               |    4 
 fs/eventpoll.c                                                       |   38 
 fs/exec.c                                                            |   11 
 fs/ext4/inode.c                                                      |    3 
 fs/ext4/mballoc.c                                                    |    1 
 fs/ext4/namei.c                                                      |    2 
 fs/gfs2/glock.c                                                      |   91 -
 fs/gfs2/glock.h                                                      |    1 
 fs/gfs2/glops.c                                                      |    3 
 fs/gfs2/incore.h                                                     |    1 
 fs/gfs2/lock_dlm.c                                                   |   32 
 fs/gfs2/ops_fstype.c                                                 |    1 
 fs/gfs2/super.c                                                      |    3 
 fs/gfs2/util.c                                                       |    1 
 fs/jffs2/xattr.c                                                     |    3 
 fs/libfs.c                                                           |  147 +
 fs/nfsd/nfsctl.c                                                     |    4 
 fs/nilfs2/ioctl.c                                                    |    2 
 fs/nilfs2/segment.c                                                  |   63 
 fs/ntfs3/dir.c                                                       |    1 
 fs/ntfs3/index.c                                                     |    6 
 fs/ntfs3/inode.c                                                     |    7 
 fs/ntfs3/record.c                                                    |   11 
 fs/ntfs3/super.c                                                     |    2 
 fs/openpromfs/inode.c                                                |    8 
 fs/smb/server/mgmt/share_config.c                                    |    6 
 fs/smb/server/oplock.c                                               |   21 
 include/drm/display/drm_dp_helper.h                                  |    6 
 include/drm/drm_displayid.h                                          |    1 
 include/drm/drm_mipi_dsi.h                                           |    6 
 include/linux/acpi.h                                                 |    6 
 include/linux/bitops.h                                               |    1 
 include/linux/cpu.h                                                  |   11 
 include/linux/dev_printk.h                                           |   25 
 include/linux/fb.h                                                   |    4 
 include/linux/fs.h                                                   |    8 
 include/linux/ieee80211.h                                            |    2 
 include/linux/ksm.h                                                  |   13 
 include/linux/maple_tree.h                                           |    7 
 include/linux/mlx5/driver.h                                          |    1 
 include/linux/numa.h                                                 |    7 
 include/linux/overflow.h                                             |   25 
 include/linux/printk.h                                               |    2 
 include/linux/pwm.h                                                  |    7 
 include/linux/stmmac.h                                               |    2 
 include/net/ax25.h                                                   |    3 
 include/net/bluetooth/bluetooth.h                                    |    2 
 include/net/bluetooth/hci.h                                          |  122 -
 include/net/bluetooth/hci_core.h                                     |   53 
 include/net/bluetooth/l2cap.h                                        |   11 
 include/net/mac80211.h                                               |    3 
 include/net/tcp.h                                                    |    5 
 include/trace/events/asoc.h                                          |    2 
 include/uapi/linux/bpf.h                                             |    2 
 include/uapi/linux/virtio_bt.h                                       |    1 
 io_uring/io-wq.c                                                     |   13 
 io_uring/io_uring.h                                                  |    2 
 io_uring/net.c                                                       |   22 
 io_uring/nop.c                                                       |    2 
 kernel/bpf/syscall.c                                                 |    5 
 kernel/bpf/verifier.c                                                |   29 
 kernel/cgroup/cpuset.c                                               |    2 
 kernel/cpu.c                                                         |   14 
 kernel/rcu/tasks.h                                                   |    2 
 kernel/rcu/tree_stall.h                                              |    3 
 kernel/sched/core.c                                                  |    2 
 kernel/sched/fair.c                                                  |   53 
 kernel/sched/isolation.c                                             |    7 
 kernel/sched/topology.c                                              |    2 
 kernel/softirq.c                                                     |   12 
 kernel/trace/ftrace.c                                                |   39 
 kernel/trace/ring_buffer.c                                           |    9 
 kernel/trace/trace_events_user.c                                     |  181 +-
 lib/fortify_kunit.c                                                  |   16 
 lib/kunit/device.c                                                   |    2 
 lib/kunit/test.c                                                     |    3 
 lib/kunit/try-catch.c                                                |    9 
 lib/maple_tree.c                                                     |   93 +
 lib/overflow_kunit.c                                                 |   19 
 lib/slub_kunit.c                                                     |    2 
 lib/test_hmm.c                                                       |    8 
 mm/shmem.c                                                           |    7 
 mm/userfaultfd.c                                                     |   35 
 net/ax25/ax25_dev.c                                                  |   48 
 net/bluetooth/hci_conn.c                                             |   35 
 net/bluetooth/hci_core.c                                             |  144 -
 net/bluetooth/hci_event.c                                            |  313 ---
 net/bluetooth/hci_sock.c                                             |    9 
 net/bluetooth/hci_sync.c                                             |  207 --
 net/bluetooth/iso.c                                                  |  125 -
 net/bluetooth/l2cap_core.c                                           |   77 
 net/bluetooth/l2cap_sock.c                                           |   91 -
 net/bluetooth/mgmt.c                                                 |   84 
 net/bridge/br_device.c                                               |    6 
 net/bridge/br_mst.c                                                  |   16 
 net/core/dev.c                                                       |    3 
 net/ipv4/tcp_ipv4.c                                                  |   13 
 net/ipv4/udp.c                                                       |   21 
 net/ipv6/reassembly.c                                                |    2 
 net/ipv6/seg6.c                                                      |    5 
 net/ipv6/udp.c                                                       |   20 
 net/l2tp/l2tp_core.c                                                 |   44 
 net/mac80211/mlme.c                                                  |    3 
 net/mac80211/rate.c                                                  |    6 
 net/mac80211/scan.c                                                  |   17 
 net/mac80211/tx.c                                                    |   13 
 net/mptcp/protocol.c                                                 |   54 
 net/mptcp/protocol.h                                                 |   45 
 net/mptcp/sockopt.c                                                  |  129 +
 net/netrom/nr_route.c                                                |   19 
 net/openvswitch/flow.c                                               |    3 
 net/packet/af_packet.c                                               |    3 
 net/qrtr/ns.c                                                        |   27 
 net/sunrpc/auth_gss/svcauth_gss.c                                    |   10 
 net/sunrpc/stats.c                                                   |    2 
 net/sunrpc/svc.c                                                     |    2 
 net/unix/af_unix.c                                                   |    2 
 net/wireless/nl80211.c                                               |   14 
 net/wireless/trace.h                                                 |    4 
 samples/landlock/sandboxer.c                                         |    5 
 scripts/module.lds.S                                                 |    1 
 sound/core/init.c                                                    |   11 
 sound/hda/intel-dsp-config.c                                         |   27 
 sound/pci/emu10k1/io.c                                               |    1 
 sound/pci/hda/cs35l41_hda_property.c                                 |    4 
 sound/pci/hda/cs35l56_hda.c                                          |    4 
 sound/pci/hda/patch_realtek.c                                        |    3 
 sound/soc/amd/yc/acp6x-mach.c                                        |    7 
 sound/soc/codecs/cs35l41.c                                           |   26 
 sound/soc/codecs/cs35l56.c                                           |   13 
 sound/soc/codecs/da7219-aad.c                                        |    6 
 sound/soc/codecs/rt5645.c                                            |   25 
 sound/soc/codecs/rt715-sdca.c                                        |    8 
 sound/soc/codecs/rt715-sdw.c                                         |    1 
 sound/soc/codecs/rt722-sdca.c                                        |   27 
 sound/soc/codecs/rt722-sdca.h                                        |    3 
 sound/soc/intel/avs/boards/ssm4567.c                                 |    1 
 sound/soc/intel/avs/cldma.c                                          |    2 
 sound/soc/intel/avs/path.c                                           |    1 
 sound/soc/intel/avs/pcm.c                                            |    4 
 sound/soc/intel/avs/probes.c                                         |   14 
 sound/soc/intel/boards/bxt_da7219_max98357a.c                        |    1 
 sound/soc/intel/boards/bxt_rt298.c                                   |    1 
 sound/soc/intel/boards/bytcr_rt5640.c                                |   14 
 sound/soc/intel/boards/glk_rt5682_max98357a.c                        |    2 
 sound/soc/intel/boards/kbl_da7219_max98357a.c                        |    1 
 sound/soc/intel/boards/kbl_da7219_max98927.c                         |    4 
 sound/soc/intel/boards/kbl_rt5660.c                                  |    1 
 sound/soc/intel/boards/kbl_rt5663_max98927.c                         |    2 
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c                  |    1 
 sound/soc/intel/boards/skl_hda_dsp_generic.c                         |    2 
 sound/soc/intel/boards/skl_nau88l25_max98357a.c                      |    1 
 sound/soc/intel/boards/skl_rt286.c                                   |    1 
 sound/soc/kirkwood/kirkwood-dma.c                                    |    3 
 sound/soc/mediatek/common/mtk-soundcard-driver.c                     |    6 
 sound/soc/sof/intel/hda-dai.c                                        |   31 
 sound/soc/sof/intel/lnl.c                                            |    3 
 sound/soc/sof/intel/lnl.h                                            |   15 
 sound/soc/sof/intel/mtl.c                                            |   42 
 sound/soc/sof/intel/mtl.h                                            |    4 
 sound/soc/sof/ipc3-pcm.c                                             |    1 
 sound/soc/sof/ipc4-pcm.c                                             |   91 -
 sound/soc/sof/pcm.c                                                  |   13 
 sound/soc/sof/sof-audio.h                                            |    2 
 tools/arch/x86/lib/x86-opcode-map.txt                                |   10 
 tools/bpf/bpftool/common.c                                           |   96 -
 tools/bpf/bpftool/iter.c                                             |    2 
 tools/bpf/bpftool/main.h                                             |    3 
 tools/bpf/bpftool/prog.c                                             |    5 
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c                            |    4 
 tools/bpf/bpftool/struct_ops.c                                       |    2 
 tools/include/nolibc/stdlib.h                                        |    2 
 tools/include/uapi/linux/bpf.h                                       |    2 
 tools/lib/bpf/libbpf.c                                               |    9 
 tools/testing/selftests/bpf/cgroup_helpers.c                         |    3 
 tools/testing/selftests/bpf/network_helpers.c                        |    2 
 tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c           |    7 
 tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c             |    4 
 tools/testing/selftests/bpf/progs/bench_local_storage_create.c       |    5 
 tools/testing/selftests/bpf/progs/local_storage.c                    |   20 
 tools/testing/selftests/bpf/progs/lsm_cgroup.c                       |    8 
 tools/testing/selftests/bpf/test_sockmap.c                           |    2 
 tools/testing/selftests/cgroup/cgroup_util.c                         |    8 
 tools/testing/selftests/cgroup/cgroup_util.h                         |    2 
 tools/testing/selftests/cgroup/test_core.c                           |    7 
 tools/testing/selftests/cgroup/test_cpu.c                            |    2 
 tools/testing/selftests/cgroup/test_cpuset.c                         |    2 
 tools/testing/selftests/cgroup/test_freezer.c                        |    2 
 tools/testing/selftests/cgroup/test_hugetlb_memcg.c                  |    2 
 tools/testing/selftests/cgroup/test_kill.c                           |    2 
 tools/testing/selftests/cgroup/test_kmem.c                           |    2 
 tools/testing/selftests/cgroup/test_memcontrol.c                     |    2 
 tools/testing/selftests/cgroup/test_zswap.c                          |    2 
 tools/testing/selftests/damon/_damon_sysfs.py                        |    2 
 tools/testing/selftests/filesystems/binderfs/Makefile                |    2 
 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc  |    2 
 tools/testing/selftests/kcmp/kcmp_test.c                             |    2 
 tools/testing/selftests/kvm/aarch64/vgic_init.c                      |   49 
 tools/testing/selftests/lib.mk                                       |   12 
 tools/testing/selftests/net/amt.sh                                   |   12 
 tools/testing/selftests/net/config                                   |    1 
 tools/testing/selftests/net/forwarding/bridge_igmp.sh                |    6 
 tools/testing/selftests/net/forwarding/bridge_mld.sh                 |    6 
 tools/testing/selftests/net/lib.sh                                   |    6 
 tools/testing/selftests/resctrl/Makefile                             |    4 
 tools/testing/selftests/syscall_user_dispatch/sud_test.c             |   14 
 tools/tracing/latency/latency-collector.c                            |    8 
 565 files changed, 5947 insertions(+), 3932 deletions(-)

Aapo Vienamo (1):
      mtd: core: Report error if first mtd_otp_size() call fails in mtd_otp_nvmem_add()

Abdelrahman Morsy (1):
      HID: mcp-2221: cancel delayed_work only when CONFIG_IIO is enabled

Adam Guerin (2):
      crypto: qat - improve error message in adf_get_arbiter_mapping()
      crypto: qat - improve error logging to be consistent across features

Adrian Hunter (2):
      x86/insn: Fix PUSH instruction in x86 instruction decoder opcode map
      x86/insn: Add VEX versions of VPDPBUSD, VPDPBUSDS, VPDPWSSD and VPDPWSSDS

Akiva Goldberger (2):
      net/mlx5: Add a timeout to acquire the command queue semaphore
      net/mlx5: Discard command completions in internal error

Al Viro (1):
      parisc: add missing export of __cmpxchg_u8()

Aleksandr Aprelkov (1):
      sunrpc: removed redundant procp check

Aleksandr Burakov (1):
      media: ngene: Add dvb_ca_en50221_init return value check

Aleksandr Mishin (6):
      crypto: bcm - Fix pointer arithmetic
      cppc_cpufreq: Fix possible null pointer dereference
      thermal/drivers/tsens: Fix null pointer dereference
      ASoC: kirkwood: Fix potential NULL dereference
      drm: bridge: cdns-mhdp8546: Fix possible null pointer dereference
      drm: vc4: Fix possible null pointer dereference

Alexander Aring (1):
      dlm: fix user space lock decision to copy lvb

Alexander Lobakin (1):
      bitops: add missing prototype check

Alexandre Mergnat (1):
      clk: mediatek: mt8365-mm: fix DPI0 parent

Alexei Starovoitov (1):
      bpf: Fix verifier assumptions about socket->sk

Aloka Dixit (1):
      wifi: ath12k: use correct flag field for 320 MHz channels

Amadeusz Sławiński (1):
      ASoC: Intel: avs: Restore stream decoupling on prepare

Andreas Gruenbacher (6):
      gfs2: Don't forget to complete delayed withdraw
      gfs2: Fix "ignore unlock failures after withdraw"
      gfs2: Remove ill-placed consistency check
      gfs2: Fix potential glock use-after-free on unmount
      gfs2: finish_xmote cleanup
      gfs2: do_xmote fixes

Andrew Halaney (8):
      scsi: ufs: qcom: Perform read back after writing reset bit
      scsi: ufs: qcom: Perform read back after writing REG_UFS_SYS1CLK_1US
      scsi: ufs: qcom: Perform read back after writing unipro mode
      scsi: ufs: qcom: Perform read back after writing CGC enable
      scsi: ufs: cdns-pltfrm: Perform read back after writing HCLKDIV
      scsi: ufs: core: Perform read back after writing UTP_TASK_REQ_LIST_BASE_H
      scsi: ufs: core: Perform read back after disabling interrupts
      scsi: ufs: core: Perform read back after disabling UIC_COMMAND_COMPL

Andrii Nakryiko (1):
      bpf: prevent r10 register from being marked as precise

Andy Chi (1):
      ALSA: hda/realtek: fix mute/micmute LEDs don't work for ProBook 440/460 G11.

Andy Shevchenko (1):
      ACPI: LPSS: Advertise number of chip selects via property

AngeloGioacchino Del Regno (1):
      ASoC: mediatek: Assign dummy when codec not specified for a DAI link

Anton Protopopov (1):
      bpf: Pack struct bpf_fib_lookup

Ard Biesheuvel (3):
      arm64/fpsimd: Avoid erroneous elide of user state reload
      x86/boot/64: Clear most of CR4 in startup_64(), except PAE, MCE and LA57
      x86/purgatory: Switch to the position-independent small code model

Armin Wolf (6):
      ACPI: bus: Indicate support for _TFP thru _OSC
      ACPI: bus: Indicate support for more than 16 p-states thru _OSC
      ACPI: bus: Indicate support for the Generic Event Device thru _OSC
      ACPI: Fix Generic Initiator Affinity _OSC bit
      ACPI: bus: Indicate support for IRQ ResourceSource thru _OSC
      platform/x86: xiaomi-wmi: Fix race condition when reporting key events

Arnd Bergmann (14):
      nilfs2: fix out-of-range warning
      crypto: ccp - drop platform ifdef checks
      enetc: avoid truncating error message
      qed: avoid truncating work queue length
      mlx5: avoid truncating error message
      mlx5: stop warning for 64KB pages
      wifi: carl9170: re-fix fortified-memset warning
      x86/microcode/AMD: Avoid -Wformat warning with clang-15
      ACPI: disable -Wstringop-truncation
      drm/imagination: avoid -Woverflow warning
      fbdev: shmobile: fix snprintf truncation
      powerpc/fsl-soc: hide unused const variable
      fbdev: sisfb: hide unused variables
      media: rcar-vin: work around -Wenum-compare-conditional warning

Ayala Beker (1):
      wifi: mac80211: don't select link ID if not provided in scan request

Baochen Qiang (2):
      wifi: ath10k: poll service ready message before failing
      wifi: ath11k: don't force enable power save on non-running vdevs

Bart Van Assche (1):
      scsi: ufs: core: mcq: Fix ufshcd_mcq_sqe_search()

Basavaraj Natikar (1):
      HID: amd_sfh: Handle "no sensors" in PM operations

Beau Belgrave (2):
      tracing/user_events: Prepare find/delete for same name events
      tracing/user_events: Fix non-spaced field matching

Benjamin Berg (1):
      wifi: iwlwifi: mvm: fix active link counting during recovery

Benjamin Marzinski (2):
      dm-delay: fix workqueue delay_timer race
      dm-delay: fix max_delay calculations

Bibo Mao (1):
      LoongArch: Lately init pmu after smp is online

Binbin Zhou (2):
      dt-bindings: thermal: loongson,ls2k-thermal: Add Loongson-2K0500 compatible
      dt-bindings: thermal: loongson,ls2k-thermal: Fix incorrect compatible definition

Bjorn Andersson (1):
      soc: qcom: pmic_glink: Make client-lock non-sleeping

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

Catalin Popescu (1):
      clk: rs9: fix wrong default value for clock amplitude

Cezary Rojewski (5):
      ASoC: Intel: Disable route checks for Skylake boards
      ASoC: Intel: avs: ssm4567: Do not ignore route checks
      ASoC: Intel: avs: Fix ASRC module initialization
      ASoC: Intel: avs: Fix potential integer overflow
      ASoC: Intel: avs: Test result of avs_get_module_entry()

Chad Monroe (1):
      wifi: mt76: mt7996: fix size of txpower MCU command

Changhuang Liang (1):
      staging: media: starfive: Remove links when unregistering devices

Chen Ni (3):
      crypto: octeontx2 - add missing check for dma_map_single
      HID: intel-ish-hid: ipc: Add check for pci_alloc_irq_vectors
      dpll: fix return value check for kmemdup

Cheng Yu (1):
      sched/core: Fix incorrect initialization of the 'burst' parameter in cpu_max_write()

Chengchang Tang (5):
      RDMA/hns: Fix deadlock on SRQ async events.
      RDMA/hns: Fix UAF for cq async event
      RDMA/hns: Fix GMV table pagesize
      RDMA/hns: Use complete parentheses in macros
      RDMA/hns: Modify the print level of CQE error

Chih-Kang Chang (1):
      wifi: rtw89: wow: refine WoWLAN flows of HCI interrupts and low power mode

Chris Lew (1):
      net: qrtr: ns: Fix module refcnt

Christian Hewitt (1):
      drm/meson: vclk: fix calculation of 59.94 fractional rates

Christoph Hellwig (2):
      block: refine the EOF check in blkdev_iomap_begin
      virt: acrn: stop using follow_pfn

Christoph Müllner (2):
      riscv: thead: Rename T-Head PBMT to MAE
      riscv: T-Head: Test availability bit before enabling MAE errata

Christophe JAILLET (1):
      Bluetooth: Remove usage of the deprecated ida_simple_xx() API

Chuck Lever (9):
      libfs: Re-arrange locking in offset_iterate_dir()
      libfs: Define a minimum directory offset
      libfs: Add simple_offset_empty()
      maple_tree: Add mtree_alloc_cyclic()
      libfs: Convert simple directory offsets to use a Maple Tree
      libfs: Fix simple_offset_rename_exchange()
      libfs: Add simple_offset_rename() API
      shmem: Fix shmem_rename2()
      SUNRPC: Fix gss_free_in_token_pages()

Chun-Kuang Hu (1):
      soc: mediatek: cmdq: Fix typo of CMDQ_JUMP_RELATIVE

Clément Léger (1):
      selftests: sud_test: return correct emulated syscall value on RISC-V

Dan Carpenter (6):
      speakup: Fix sizeof() vs ARRAY_SIZE() bug
      nvmet: prevent sprintf() overflow in nvmet_subsys_nsid_exists()
      wifi: mwl8k: initialize cmd->addr[] properly
      Bluetooth: qca: Fix error code in qca_read_fw_build_info()
      Bluetooth: ISO: Clean up returns values in iso_connect_ind()
      ext4: fix potential unnitialized variable

Dan Nowlin (1):
      ice: Fix package download algorithm

Daniel Golle (1):
      net: ethernet: mediatek: use ADMAv1 instead of ADMAv2.0 on MT7981 and MT7986

Daniel J Blueman (1):
      x86/tsc: Trust initial offset in architectural TSC-adjust MSRs

Daniel Starke (2):
      tty: n_gsm: fix possible out-of-bounds in gsm0_receive()
      tty: n_gsm: fix missing receive state reset after mode switch

Daniele Palmas (1):
      net: usb: qmi_wwan: add Telit FN920C04 compositions

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

Dmitry Baryshkov (9):
      soc: qcom: pmic_glink: don't traverse clients list without a lock
      soc: qcom: pmic_glink: notify clients about the current state
      wifi: ath10k: populate board data for WCN3990
      drm/msm/dp: allow voltage swing / pre emphasis of 3
      drm/mipi-dsi: use correct return type for the DSC functions
      clk: qcom: dispcc-sm8450: fix DisplayPort clocks
      clk: qcom: dispcc-sm6350: fix DisplayPort clocks
      clk: qcom: dispcc-sm8550: fix DisplayPort clocks
      clk: qcom: dispcc-sm8650: fix DisplayPort clocks

Dmitry Torokhov (1):
      Input: try trimming too long modalias strings

Doug Berger (1):
      serial: 8250_bcm7271: use default_mux_rate if possible

Douglas Anderson (4):
      drm/dp: Don't attempt AUX transfers when eDP panels are not powered
      drm/panel: atna33xc20: Fix unbalanced regulator in the case HPD doesn't assert
      drm/mediatek: Init `ddp_comp` with devm_kcalloc()
      drm/msm/dp: Avoid a long timeout for AUX transfer if nothing connected

Duanqiang Wen (2):
      Revert "net: txgbe: fix i2c dev name cannot match clkdev"
      Revert "net: txgbe: fix clk_name exceed MAX_DEV_ID limits"

Duoming Zhou (5):
      wifi: brcmfmac: pcie: handle randbuf allocation failure
      ax25: Use kernel universal linked list to implement ax25_dev_list
      ax25: Fix reference count leak issues of ax25_dev
      ax25: Fix reference count leak issue of net_device
      lib/test_hmm.c: handle src_pfns and dst_pfns allocation failure

Edward Liaw (1):
      selftests/kcmp: remove unused open mode

Eric Biggers (5):
      KEYS: asymmetric: Add missing dependency on CRYPTO_SIG
      KEYS: asymmetric: Add missing dependencies of FIPS_SIGNATURE_SELFTEST
      crypto: x86/nh-avx2 - add missing vzeroupper
      crypto: x86/sha256-avx2 - add missing vzeroupper
      crypto: x86/sha512-avx2 - add missing vzeroupper

Eric Dumazet (7):
      tcp: avoid premature drops in tcp_add_backlog()
      net: give more chances to rcu in netdev_wait_allrefs_any()
      usb: aqc111: stop lying about skb->truesize
      net: usb: sr9700: stop lying about skb->truesize
      net: usb: smsc95xx: stop lying about skb->truesize
      netrom: fix possible dead-lock in nr_rt_ioctl()
      af_packet: do not call packet_read_pending() from tpacket_destruct_skb()

Eric Sandeen (1):
      openpromfs: finish conversion to the new mount API

Fabio Estevam (1):
      media: dt-bindings: ovti,ov2680: Fix the power supply names

Felix Fietkau (2):
      wifi: mt76: mt7603: fix tx queue of loopback packets
      wifi: mt76: mt7603: add wpdma tx eof flag for PSE client reset

Felix Kuehling (1):
      drm/amdgpu: Update BO eviction priorities

Finn Thain (2):
      macintosh/via-macii: Fix "BUG: sleeping function called from invalid context"
      m68k: mac: Fix reboot hang on Mac IIci

Gabor Juhos (2):
      clk: qcom: clk-alpha-pll: remove invalid Stromer register offset
      clk: qcom: apss-ipq-pll: fix PLL rate for IPQ5018

Gabriel Krisman Bertazi (2):
      io-wq: write next_work before dropping acct_lock
      udp: Avoid call to compute_score on multiple sites

Geert Uytterhoeven (4):
      sh: kprobes: Merge arch_copy_kprobe() into arch_prepare_kprobe()
      printk: Let no_printk() use _printk()
      dev_printk: Add and use dev_no_printk()
      clk: renesas: r8a779a0: Fix CANFD parent clock

Geliang Tang (2):
      selftests/bpf: Fix umount cgroup2 error in test_sockmap
      selftests/bpf: Fix a fd leak in error paths in open_netns

George Stark (2):
      pwm: meson: Add check for error from clk_round_rate()
      pwm: meson: Use mul_u64_u64_div_u64() for frequency calculating

Giovanni Cabiddu (1):
      crypto: qat - specify firmware files for 402xx

Greg Kroah-Hartman (1):
      Linux 6.8.12

Guenter Roeck (2):
      mm/slub, kunit: Use inverted data to corrupt kmem cache
      Revert "sh: Handle calling csum_partial with misaligned data"

Guixiong Wei (1):
      x86/boot: Ignore relocations in .notes sections in walk_relocs() too

Gustavo A. R. Silva (1):
      Bluetooth: hci_conn, hci_sync: Use __counted_by() to avoid -Wfamnae warnings

Hangbin Liu (4):
      ipv6: sr: add missing seg6_local_exit
      ipv6: sr: fix incorrect unregister order
      ipv6: sr: fix invalid unregister error path
      selftests/net/lib: no need to record ns name if it already exist

Hannes Reinecke (1):
      nvme-tcp: strict pdu pacing to avoid send stalls on TLS

Hans de Goede (1):
      ASoC: Intel: bytcr_rt5640: Apply Asus T100TA quirk to Asus T100TAM too

Hao Chen (1):
      drivers/perf: hisi: hns3: Actually use devm_add_action_or_reset()

Hechao Li (1):
      tcp: increase the default TCP scaling ratio

Heiko Stuebner (2):
      drm/panel: ltk050h3146w: add MIPI_DSI_MODE_VIDEO to LTK050H3148W flags
      drm/panel: ltk050h3146w: drop duplicate commands from LTK050H3148W init

Heiner Kallweit (1):
      Revert "r8169: don't try to disable interrupts if NAPI is, scheduled already"

Herve Codina (1):
      net: lan966x: remove debugfs directory in probe() error path

Himanshu Madhani (1):
      scsi: qla2xxx: Fix debugfs output for fw_resource_count

Horatiu Vultur (1):
      net: micrel: Fix receiving the timestamp in the frame for lan8841

Howard Hsu (1):
      wifi: mt76: mt7996: fix potential memory leakage when reading chip temperature

Hsin-Te Yuan (2):
      thermal/drivers/mediatek/lvts_thermal: Add coeff for mt8192
      drm/bridge: anx7625: Update audio status while detecting

Huai-Yuan Liu (1):
      drm/arm/malidp: fix a possible null pointer dereference

Hugo Villeneuve (1):
      serial: sc16is7xx: fix bug in sc16is7xx_set_baud() when using prescaler

INAGAKI Hiroshi (1):
      block: fix and simplify blkdevparts= cmdline parsing

Igor Artemiev (1):
      wifi: cfg80211: fix the order of arguments for trace events of the tx_rx_evt class

Ilan Peer (1):
      wifi: iwlwifi: mvm: Do not warn on invalid link on scan complete

Ilya Denisyev (1):
      jffs2: prevent xattr node from overflowing the eraseblock

Ilya Leoshkevich (1):
      s390/bpf: Emit a barrier for BPF_FETCH instructions

Ilya Maximets (1):
      net: openvswitch: fix overwriting ct original tuple for ICMPv6

Iulia Tanasescu (2):
      Bluetooth: ISO: Add hcon for listening bis sk
      Bluetooth: ISO: Make iso_get_sock_listen generic

Ivanov Mikhail (1):
      samples/landlock: Fix incorrect free in populate_ruleset_net

Jack Xiao (1):
      drm/amdgpu/mes: fix use-after-free issue

Jack Yu (4):
      ASoC: rt722-sdca: modify channel number to support 4 channels
      ASoC: rt722-sdca: add headset microphone vrefo setting
      ASoC: rt715: add vendor clear control register
      ASoC: rt715-sdca: volume step modification

Jaewon Kim (1):
      clk: samsung: exynosautov9: fix wrong pll clock id value

Jagan Teki (1):
      drm/bridge: Fix improper bridge init order with pre_enable_prev_first

Jakub Kicinski (3):
      eth: sungem: remove .ndo_poll_controller to avoid deadlocks
      selftests: net: add missing config for amt.sh
      selftests: net: move amt to socat for better compatibility

Jan Kara (1):
      ext4: avoid excessive credit estimate in ext4_tmpfile()

Jason Gunthorpe (1):
      IB/mlx5: Use __iowrite64_copy() for write combining stores

Jens Axboe (3):
      io_uring: use the right type for work_llist empty check
      io_uring/net: remove dependency on REQ_F_PARTIAL_IO for sr->done_io
      io_uring/net: ensure async prep handlers always initialize ->done_io

Jiawen Wu (7):
      net: wangxun: fix to change Rx features
      net: wangxun: match VLAN CTAG and STAG features
      net: txgbe: move interrupt codes to a separate file
      net: txgbe: use irq_domain for interrupt controller
      net: txgbe: fix to control VLAN strip
      net: txgbe: fix to clear interrupt status after handling IRQ
      net: txgbe: fix GPIO interrupt blocking

Jim Liu (1):
      gpio: nuvoton: Fix sgpio irq handle error

Jinjiang Tu (1):
      mm/ksm: fix ksm exec support for prctl

Jinjie Ruan (1):
      arm64: Remove unnecessary irqflags alternative.h include

Jiri Olsa (1):
      libbpf: Fix error message in attach_kprobe_multi

Joel Colledge (1):
      dm-delay: fix hung task introduced by kthread mode

Johannes Berg (7):
      wifi: mac80211: don't use rate mask for scanning
      wifi: ieee80211: fix ieee80211_mle_basic_sta_prof_size_ok()
      wifi: iwlwifi: mvm: allocate STA links only for active links
      wifi: iwlwifi: mvm: select STA mask only for active links
      wifi: iwlwifi: reconfigure TLC during HW restart
      wifi: iwlwifi: mvm: fix check in iwl_mvm_sta_fw_id_mask
      wifi: iwlwifi: mvm: init vif works only once

John Hubbard (2):
      selftests/binderfs: use the Makefile's rules, not Make's implicit rules
      selftests/resctrl: fix clang build failure: use LOCAL_HDRS

Josef Bacik (2):
      sunrpc: use the struct net as the svc proc private
      btrfs: take the cleaner_mutex earlier in qgroup disable

Joshua Ashton (1):
      drm/amd/display: Set color_mgmt_changed to true on unsuspend

Juergen Gross (3):
      x86/pat: Introduce lookup_address_in_pgd_attr()
      x86/pat: Restructure _lookup_address_cpa()
      x86/pat: Fix W^X violation false-positives when running as Xen PV guest

Junhao He (2):
      drivers/perf: hisi_pcie: Fix out-of-bound access when valid event group
      drivers/perf: hisi: hns3: Fix out-of-bound access when valid event group

Justin Green (1):
      drm/mediatek: Add 0 size check to mtk_drm_gem_obj

Karthikeyan Kathirvel (1):
      wifi: ath12k: fix out-of-bound access of qmi_invoke_handler()

Kees Cook (4):
      kunit/fortify: Fix mismatched kvalloc()/vfree() usage
      lkdtm: Disable CFI checking for perms functions
      wifi: nl80211: Avoid address calculations via out of bounds array indexing
      overflow: Change DEFINE_FLEX to take __counted_by member

Ken Milmore (1):
      r8169: Fix possible ring buffer corruption on fragmented Tx packets.

Konstantin Komarov (4):
      fs/ntfs3: Remove max link count info display during driver init
      fs/ntfs3: Taking DOS names into account during link counting
      fs/ntfs3: Fix case when index is reused during tree transformation
      fs/ntfs3: Break dir enumeration if directory contents error

Konstantin Taranov (3):
      RDMA/mana_ib: Introduce helpers to create and destroy mana queues
      RDMA/mana_ib: Use struct mana_ib_queue for CQs
      RDMA/mana_ib: boundary check before installing cq callbacks

Krzysztof Kozlowski (3):
      regulator: qcom-refgen: fix module autoloading
      regulator: vqmmc-ipq4019: fix module autoloading
      firmware: qcom: qcm: fix unused qcom_scm_qseecom_allowlist

Lad Prabhakar (1):
      clk: renesas: r9a07g043: Add clock and reset entry for PLIC

Lancelot SIX (1):
      drm/amdkfd: Flush the process wq before creating a kfd_process

Laurent Pinchart (2):
      firmware: raspberrypi: Use correct device for DMA mappings
      media: v4l2-subdev: Fix stream handling for crop API

Leo Ma (1):
      drm/amd/display: Fix DC mode screen flickering on DCN321

Leon Romanovsky (1):
      RDMA/IPoIB: Fix format truncation compilation errors

Lijo Lazar (1):
      drm/amd/pm: Restore config space after reset

Linus Torvalds (2):
      x86/mm: Remove broken vsyscall emulation code from the page fault code
      epoll: be better about file lifetimes

Linus Walleij (1):
      net: ethernet: cortina: Locking fixes

Lorenzo Bianconi (3):
      wifi: mt76: mt7915: workaround too long expansion sparse warnings
      wifi: mt76: mt7996: fix uninitialized variable in mt7996_irq_tasklet()
      net: ethernet: mediatek: split tx and rx fields in mtk_soc_data struct

Lucas Segarra Fernandez (1):
      crypto: qat - validate slices count returned by FW

Luiz Augusto von Dentz (2):
      Bluetooth: HCI: Remove HCI_AMP support
      Bluetooth: hci_core: Fix not handling hdev->le_num_of_adv_sets=1

Lukas Bulwahn (1):
      Bluetooth: hci_event: Remove code to removed CONFIG_BT_HS

Lyude Paul (1):
      drm/nouveau/dp: Fix incorrect return code in r535_dp_aux_xfer()

Maciej Fijalkowski (2):
      ice: make ice_vsi_cfg_rxq() static
      ice: make ice_vsi_cfg_txq() static

Maher Sanalla (1):
      net/mlx5: Reload only IB representors upon lag disable/enable

Marc Gonzalez (1):
      clk: qcom: mmcc-msm8998: fix venus clock issue

Marek Vasut (5):
      hwrng: stm32 - use logical OR in conditional
      hwrng: stm32 - put IP into RPM suspend on failure
      hwrng: stm32 - repair clock handling
      drm/lcdif: Do not disable clocks on already suspended hardware
      drm/panel: simple: Add missing Innolux G121X1-L03 format, flags, connector

Masami Hiramatsu (Google) (1):
      selftests/ftrace: Fix BTFARG testcase to check fprobe is enabled correctly

Matthias Schiffer (2):
      net: dsa: mv88e6xxx: Add support for model-specific pre- and post-reset handlers
      net: dsa: mv88e6xxx: Avoid EEPROM timeout without EEPROM on 88E6250-family switches

Matthieu Baerts (NGI0) (2):
      mptcp: SO_KEEPALIVE: fix getsockopt support
      mptcp: fix full TCP keep-alive support

Matti Vaittinen (1):
      regulator: irq_helpers: duplicate IRQ name

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

Michal Schmidt (3):
      selftests/bpf: Fix pointer arithmetic in test_xdp_do_redirect
      bnxt_re: avoid shift undefined behavior in bnxt_qplib_alloc_init_hwq
      idpf: don't skip over ethtool tcp-data-split setting

Mickaël Salaün (1):
      kunit: Fix kthread reference

Ming Lei (1):
      io_uring: fail NOP if non-zero op flags is passed in

Ming Yen Hsieh (1):
      wifi: mt76: mt7925: ensure 4-byte alignment for suspend & wow command

Miquel Raynal (1):
      dmaengine: xilinx: xdma: Clarify kdoc in XDMA driver

Miri Korenblit (1):
      wifi: iwlwifi: implement can_activate_links callback

Mukesh Ojha (1):
      firmware: qcom: scm: Fix __scm and waitq completion variable initialization

Mukul Joshi (2):
      drm/amdkfd: Add VRAM accounting for SVM migration
      drm/amdgpu: Fix VRAM memory accounting

Namjae Jeon (1):
      ksmbd: avoid to send duplicate oplock break notifications

Nandor Kracser (1):
      ksmbd: ignore trailing slashes in share paths

Nathan Chancellor (2):
      clk: qcom: Fix SC_CAMCC_8280XP dependencies
      clk: qcom: Fix SM_GPUCC_8650 dependencies

NeilBrown (1):
      nfsd: don't create nfsv4recoverydir in nfsdfs when not used.

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

Nuno Pereira (1):
      HID: nintendo: Fix N64 controller being identified as mouse

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

Oliver Upton (1):
      KVM: selftests: Add test for uaccesses to non-existent vgic-v2 CPUIF

Or Har-Toov (3):
      RDMA/mlx5: Uncacheable mkey has neither rb_key or cache_ent
      RDMA/mlx5: Change check for cacheable mkeys
      RDMA/mlx5: Adding remote atomic access flag to updatable flags

Oswald Buddenhagen (1):
      ALSA: emu10k1: make E-MU FPGA writes potentially more reliable

Paolo Abeni (4):
      mptcp: cleanup writer wake-up
      mptcp: avoid some duplicate code in socket option handling
      mptcp: implement TCP_NOTSENT_LOWAT support
      mptcp: cleanup SOL_TCP handling

Pavel Begunkov (1):
      io_uring/net: fix sendzc lazy wake polling

Peter Colberg (1):
      fpga: dfl-pci: add PCI subdevice ID for Intel D5005 card

Peter Oberparleiter (1):
      s390/cio: fix tracepoint subchannel type field

Peter Ujfalusi (7):
      ASoC: SOF: ipc4-pcm: Use consistent name for snd_sof_pcm_stream pointer
      ASoC: SOF: ipc4-pcm: Use consistent name for sof_ipc4_timestamp_info pointer
      ASoC: SOF: ipc4-pcm: Introduce generic sof_ipc4_pcm_stream_priv
      ASoC: SOF: Intel: mtl: Correct rom_status_reg
      ASoC: SOF: Intel: lnl: Correct rom_status_reg
      ASoC: SOF: Intel: mtl: Disable interrupts when firmware boot failed
      ASoC: SOF: Intel: mtl: Implement firmware boot state check

Petr Pavlu (1):
      ring-buffer: Fix a race between readers and resize checks

Pierre-Louis Bossart (4):
      ASoC: da7219-aad: fix usage of device_get_named_child_node()
      ASoC: cs35l56: fix usages of device_get_named_child_node()
      ALSA: hda: intel-dsp-config: harden I2C/I2S codec detection
      ASoC: SOF: Intel: hda-dai: fix channel map configuration for aggregated dailink

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

Qiuxu Zhuo (1):
      EDAC/skx_common: Allow decoding of SGX addresses

Quentin Monnet (1):
      libbpf: Prevent null-pointer dereference when prog to load has no BTF

Rafael J. Wysocki (3):
      thermal/debugfs: Avoid excessive updates of trip point statistics
      thermal/debugfs: Create records for cdev states as they get used
      thermal/debugfs: Pass cooling device state to thermal_debug_cdev_add()

Randy Dunlap (1):
      fbdev: sh7760fb: allow modular build

Ranjani Sridharan (1):
      ASoC: SOF: pcm: Restrict DSP D0i3 during S0ix to IPC3

Ricardo Ribalda (2):
      media: radio-shark2: Avoid led_names truncations
      media: uvcvideo: Add quirk for Logitech Rally Bar

Richard Fitzgerald (1):
      ALSA: hda: cs35l56: Exit cache-only after cs35l56_wait_for_firmware_boot()

Richard Kinder (1):
      wifi: mac80211: ensure beacon is non-S1G prior to extracting the beacon timestamp field

Rob Herring (1):
      dt-bindings: rockchip: grf: Add missing type to 'pcie-phy' node

Robert Richter (1):
      x86/numa: Fix SRAT lookup of CFMWS ranges with numa_fill_memblks()

Rodrigo Siqueira (2):
      drm/amd/display: Ensure that dmcub support flag is set for DCN20
      drm/amd/display: Add VCO speed parameter for DCN31 FPU

Rohan G Thomas (3):
      net: stmmac: Offload queueMaxSDU from tc-taprio
      net: stmmac: est: Per Tx-queue error count for HLBF
      net: stmmac: Report taprio offload status

Romain Gantois (1):
      net: ti: icssg_prueth: Fix NULL pointer dereference in prueth_probe()

Ryusuke Konishi (3):
      nilfs2: fix use-after-free of timer for log writer thread
      nilfs2: fix unexpected freezing of nilfs_segctor_sync()
      nilfs2: fix potential hang in nilfs_detach_log_writer()

Sagi Grimberg (2):
      nvmet-tcp: fix possible memory leak when tearing down a controller
      nvmet: fix nvme status code when namespace is disabled

Sahil Siddiq (1):
      bpftool: Mount bpffs on provided dir instead of parent dir

Sakari Ailus (1):
      media: ipu3-cio2: Request IRQ earlier

Scott Mayhew (1):
      kunit: bail out early in __kunit_test_suites_init() if there are no suites to test

Sean Christopherson (1):
      cpu: Ignore "mitigations" kernel parameter if CPU_MITIGATIONS=n

Sebastian Urban (1):
      Bluetooth: compute LE flow credits based on recvbuf space

SeongJae Park (1):
      selftests/damon/_damon_sysfs: check errors from nr_schemes file reads

Sergey Shtylyov (1):
      of: module: add buffer overflow check in of_modalias()

Shay Drory (1):
      net/mlx5: Fix peer devlink set for SF representor devlink port

Shrikanth Hegde (1):
      sched/fair: Add EAS checks before updating root_domain::overutilized

Shuah Khan (1):
      tools/latency-collector: Fix -Wformat-security compile warns

Shubhrajyoti Datta (1):
      EDAC/versal: Do not register for NOC errors

Souradeep Chakrabarti (1):
      net: mana: Fix the extra HZ in mana_hwc_send_request

Srinivas Pandruvada (1):
      platform/x86: ISST: Add Grand Ridge to HPM CPU list

Srinivasan Shanmugam (2):
      drm/amd/display: Fix potential index out of bounds in color transformation function
      drm/amd/display: Remove redundant condition in dcn35_calc_blocks_to_gate()

Stafford Horne (1):
      openrisc: traps: Don't send signals to kernel mode threads

Stanislav Fomichev (1):
      bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type enforcement in BPF_LINK_CREATE

Stefan Binding (2):
      ASoC: cs35l41: Update DSP1RX5/6 Sources for DSP config
      ALSA: hda: cs35l41: Remove Speaker ID for Lenovo Legion slim 7 16ARHA7

Steven Rostedt (1):
      ASoC: tracing: Export SND_SOC_DAPM_DIR_OUT to its value

Su Hui (1):
      wifi: ath10k: Fix an error code problem in ath10k_dbg_sta_write_peer_debug_trigger()

Sung Joon Kim (1):
      drm/amd/display: Disable seamless boot on 128b/132b encoding

Swapnil Patel (1):
      drm/amd/display: Add dtbclk access to dcn315

Takashi Iwai (2):
      ALSA: core: Fix NULL module pointer assignment at card init
      ALSA: Fix deadlocks with kctl removals at disconnection

Thorsten Blum (1):
      net: smc91x: Fix m68k kernel compilation for ColdFire CPU

Tianchen Ding (1):
      selftests: cgroup: skip test_cgcore_lesser_ns_open when cgroup2 mounted without nsdelegate

Tom Parkin (1):
      l2tp: fix ICMP error handling for UDP-encap sockets

Tony Lindgren (2):
      drm/omapdrm: Fix console by implementing fb_dirty
      drm/omapdrm: Fix console with deferred ops

Uros Bizjak (1):
      locking/atomic/x86: Correct the definition of __arch_try_cmpxchg128()

Uwe Kleine-König (12):
      Input: amimouse - mark driver struct with __refdata to prevent section mismatch
      pwm: sti: Prepare removing pwm_chip from driver data
      pwm: sti: Simplify probe function using devm functions
      pwm: Drop useless member .of_pwm_n_cells of struct pwm_chip
      pwm: Let the of_xlate callbacks accept references without period
      pwm: Drop duplicate check against chip->npwm in of_pwm_xlate_with_flags()
      pwm: Reorder symbols in core.c
      pwm: Provide an inline function to get the parent device of a given chip
      pwm: meson: Change prototype of a few helpers to prepare further changes
      pwm: meson: Make use of pwmchip_parent() accessor
      media: i2c: et8ek8: Don't strip remove function when driver is builtin
      pwm: Fix setting period with #pwm-cells = <1> and of_pwm_single_xlate()

Vadim Fedorenko (1):
      ptp: ocp: fix DPLL functions

Valentin Obst (1):
      selftests: default to host arch for LLVM builds

Vicki Pfau (1):
      Input: xpad - add support for ASUS ROG RAIKIRI

Vignesh Raman (1):
      drm/ci: update device type for volteer devices

Viktor Malik (1):
      selftests/bpf: Run cgroup1_hierarchy test in own mount namespace

Ville Syrjälä (1):
      drm/edid: Parse topology block for all DispID structure v1.x

Viresh Kumar (1):
      cpufreq: exit() callback is optional

Vitalii Bursov (1):
      sched/fair: Allow disabling sched_balance_newidle with sched_relax_domain_level

Wander Lairson Costa (1):
      kunit: unregister the device on error

Wang Yao (1):
      modules: Drop the .export_symbol section from the final modules

Wei Fang (1):
      net: fec: remove .ndo_poll_controller to avoid deadlocks

Will Deacon (2):
      Revert "arm64: fpsimd: Implement lazy restore for kernel mode FPSIMD"
      Reapply "arm64: fpsimd: Implement lazy restore for kernel mode FPSIMD"

Xiaolei Wang (1):
      net: stmmac: move the EST lock to struct stmmac_priv

Xingui Yang (1):
      scsi: libsas: Fix the failure of adding phy with zero-address to port

Yi Liu (1):
      iommu: Undo pasid attachment only for the devices that have succeeded

Yonghong Song (1):
      bpftool: Fix missing pids during link show

Yu Kuai (2):
      md: fix resync softlockup when bitmap size is less than array size
      block: support to account io_ticks precisely

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

Zhu Yanjun (2):
      null_blk: Fix missing mutex_destroy() at module removal
      RDMA/cma: Fix kmemleak in rdma_core observed during blktests nvme/rdma use siw

Zqiang (1):
      softirq: Fix suspicious RCU usage in __do_softirq()

end.to.start (1):
      ASoC: acp: Support microphone from device Acer 315-24p

gaoxingwang (1):
      net: ipv6: fix wrong start position when receive hop-by-hop fragment


