Return-Path: <stable+bounces-206293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B512CD035A8
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 15:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7555A311680C
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 14:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0EC3D3D1A;
	Thu,  8 Jan 2026 09:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xz2pa91N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9873A0EB7;
	Thu,  8 Jan 2026 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767865851; cv=none; b=ITcUltXVfwvg38lMl3JMi0OG1orCRv+eDDx1Zk6MN8VU9Nz5p3WdiEY69RWdhxrra2KthjE8mjF4dimD1ilrpuppPfoArSYDGN68RLcGwW4skNZWXxbW4Q+YIzY5vGPG3uQ3E/TCeBVzWoM3OdFnVTM6s5T/BOvzigTdOgY/ii4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767865851; c=relaxed/simple;
	bh=oJsrShqR5aNgs1JZATtW3fR8K1cOP+9NAYX2KrH6q10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PB4CCHYHQ+tTv15kBf2QeaICFkTo9yDimsgmUYSuCrHCzBfBzO9EiwZe2z1u+sHFZ9ryuPfXI7RTUzTAi5pFVLrlrKABxV+hIOWUtq/uomrlKVeTPLq0SEYMqKgsIGOozQTbHizNgNMxRv3kxKKvvXqvW172l77Z0PqwDYMTy4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xz2pa91N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FAEC116C6;
	Thu,  8 Jan 2026 09:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767865850;
	bh=oJsrShqR5aNgs1JZATtW3fR8K1cOP+9NAYX2KrH6q10=;
	h=From:To:Cc:Subject:Date:From;
	b=Xz2pa91N/QaEbzHpTrzTaWng0k7hgkeD0SH/44jnAuJQ6QqHwEtnWgBBNTCIxjjrW
	 8r0gAbdwA4pC4/RLr9ZgxmM4Odw3+/uqBtchU1QDYtToabi+5mDWCebDsbeBcGGa6Q
	 nlCgJC4XEHRfvup0SB84kC5b7aRrHMT0j9haNPfA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.4
Date: Thu,  8 Jan 2026 10:50:38 +0100
Message-ID: <2026010839-finless-kettle-8091@gregkh>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.18.4 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                                 |    2 
 arch/arm64/boot/dts/qcom/sm6350.dtsi                                     |    4 
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts                               |    1 
 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts                                 |    9 
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                                   |   12 
 arch/loongarch/include/asm/pgtable.h                                     |    4 
 arch/loongarch/kernel/mcount_dyn.S                                       |   14 
 arch/loongarch/kernel/process.c                                          |    5 
 arch/loongarch/kernel/relocate.c                                         |    4 
 arch/loongarch/kernel/setup.c                                            |    8 
 arch/loongarch/kernel/switch.S                                           |    4 
 arch/loongarch/net/bpf_jit.c                                             |   58 +
 arch/loongarch/net/bpf_jit.h                                             |   26 
 arch/loongarch/pci/pci.c                                                 |    2 
 arch/parisc/kernel/asm-offsets.c                                         |    2 
 arch/parisc/kernel/entry.S                                               |   16 
 arch/powerpc/include/asm/book3s/32/tlbflush.h                            |    5 
 arch/powerpc/include/asm/book3s/64/mmu-hash.h                            |    1 
 arch/powerpc/kernel/process.c                                            |    5 
 arch/powerpc/mm/book3s32/tlb.c                                           |    9 
 arch/powerpc/mm/book3s64/internal.h                                      |    2 
 arch/powerpc/mm/book3s64/mmu_context.c                                   |    2 
 arch/powerpc/mm/book3s64/slb.c                                           |   88 --
 arch/powerpc/platforms/pseries/cmm.c                                     |    3 
 arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh                |    1 
 arch/powerpc/tools/gcc-check-mprofile-kernel.sh                          |    1 
 arch/s390/mm/gmap_helpers.c                                              |    9 
 arch/x86/events/amd/uncore.c                                             |    5 
 arch/x86/kernel/cpu/microcode/amd.c                                      |  115 +-
 block/blk-mq.c                                                           |    2 
 block/blk-zoned.c                                                        |  150 ++-
 block/blk.h                                                              |   14 
 crypto/seqiv.c                                                           |    8 
 drivers/block/ublk_drv.c                                                 |  119 ++-
 drivers/bluetooth/btusb.c                                                |   12 
 drivers/clk/qcom/Kconfig                                                 |    4 
 drivers/clk/qcom/mmcc-sdm660.c                                           |    1 
 drivers/clk/samsung/clk-exynos-clkout.c                                  |    2 
 drivers/firewire/nosy.c                                                  |   10 
 drivers/firmware/stratix10-svc.c                                         |   11 
 drivers/gpio/gpiolib-swnode.c                                            |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                               |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                                  |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                                   |    7 
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c                                   |   27 
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c                                   |   27 
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c                                   |    2 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c                                  |    2 
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h                           |   62 -
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm                   |   37 
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c                                   |    1 
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c                                |    4 
 drivers/gpu/drm/bridge/ti-sn65dsi83.c                                    |   11 
 drivers/gpu/drm/drm_buddy.c                                              |  394 ++++++----
 drivers/gpu/drm/drm_displayid.c                                          |   41 -
 drivers/gpu/drm/drm_displayid_internal.h                                 |    2 
 drivers/gpu/drm/drm_gem.c                                                |    8 
 drivers/gpu/drm/drm_gem_shmem_helper.c                                   |    2 
 drivers/gpu/drm/drm_pagemap.c                                            |   17 
 drivers/gpu/drm/gma500/fbdev.c                                           |   43 -
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c                           |   37 
 drivers/gpu/drm/i915/intel_memory_region.h                               |    2 
 drivers/gpu/drm/imagination/pvr_gem.c                                    |   11 
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c                                  |   33 
 drivers/gpu/drm/mediatek/mtk_ddp_comp.h                                  |    2 
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c                          |   12 
 drivers/gpu/drm/mediatek/mtk_dp.c                                        |    1 
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                                   |    4 
 drivers/gpu/drm/mediatek/mtk_hdmi.c                                      |   15 
 drivers/gpu/drm/mgag200/mgag200_mode.c                                   |   25 
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c                                |    1 
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c                              |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c                      |   10 
 drivers/gpu/drm/nouveau/dispnv50/atom.h                                  |   13 
 drivers/gpu/drm/nouveau/dispnv50/wndw.c                                  |    2 
 drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h                        |    4 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/fwsec.c                          |   61 +
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/priv.h                           |    3 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c                    |   10 
 drivers/gpu/drm/nova/Kconfig                                             |    1 
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c                              |    3 
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c                             |   49 +
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c                                     |    2 
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                                      |   53 -
 drivers/gpu/drm/tilcdc/tilcdc_drv.h                                      |    2 
 drivers/gpu/drm/ttm/ttm_bo_vm.c                                          |    6 
 drivers/gpu/drm/xe/xe_bo.c                                               |   15 
 drivers/gpu/drm/xe/xe_dma_buf.c                                          |    2 
 drivers/gpu/drm/xe/xe_eu_stall.c                                         |    2 
 drivers/gpu/drm/xe/xe_guc_ct.c                                           |   14 
 drivers/gpu/drm/xe/xe_guc_submit.c                                       |   20 
 drivers/gpu/drm/xe/xe_migrate.c                                          |   25 
 drivers/gpu/drm/xe/xe_migrate.h                                          |    6 
 drivers/gpu/drm/xe/xe_oa.c                                               |   10 
 drivers/gpu/drm/xe/xe_svm.c                                              |   51 -
 drivers/gpu/drm/xe/xe_vm.c                                               |    5 
 drivers/gpu/drm/xe/xe_vm_types.h                                         |    2 
 drivers/hid/hid-logitech-dj.c                                            |   56 -
 drivers/hwmon/dell-smm-hwmon.c                                           |    4 
 drivers/infiniband/core/addr.c                                           |   33 
 drivers/infiniband/core/cma.c                                            |    3 
 drivers/infiniband/core/device.c                                         |    4 
 drivers/infiniband/core/verbs.c                                          |    2 
 drivers/infiniband/hw/bnxt_re/hw_counters.h                              |    6 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                                 |    7 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c                               |    2 
 drivers/infiniband/hw/bnxt_re/qplib_res.c                                |    8 
 drivers/infiniband/hw/efa/efa_verbs.c                                    |    4 
 drivers/infiniband/hw/irdma/utils.c                                      |    3 
 drivers/infiniband/hw/mana/cq.c                                          |    4 
 drivers/infiniband/sw/rxe/rxe_odp.c                                      |    4 
 drivers/infiniband/ulp/rtrs/rtrs-clt.c                                   |    1 
 drivers/iommu/amd/init.c                                                 |   15 
 drivers/iommu/amd/iommu.c                                                |    2 
 drivers/iommu/apple-dart.c                                               |    2 
 drivers/iommu/arm/arm-smmu/qcom_iommu.c                                  |   10 
 drivers/iommu/exynos-iommu.c                                             |    9 
 drivers/iommu/iommu-sva.c                                                |    3 
 drivers/iommu/ipmmu-vmsa.c                                               |    2 
 drivers/iommu/mtk_iommu.c                                                |    2 
 drivers/iommu/mtk_iommu_v1.c                                             |   25 
 drivers/iommu/omap-iommu.c                                               |    2 
 drivers/iommu/omap-iommu.h                                               |    2 
 drivers/iommu/sun50i-iommu.c                                             |    2 
 drivers/iommu/tegra-smmu.c                                               |    5 
 drivers/leds/leds-cros_ec.c                                              |    5 
 drivers/leds/leds-lp50xx.c                                               |   67 +
 drivers/md/dm-bufio.c                                                    |   10 
 drivers/md/dm-ebs-target.c                                               |    2 
 drivers/md/dm-pcache/cache.c                                             |    5 
 drivers/md/dm-pcache/cache_segment.c                                     |    5 
 drivers/md/md.c                                                          |    5 
 drivers/md/raid5.c                                                       |   10 
 drivers/media/cec/core/cec-core.c                                        |    1 
 drivers/media/common/videobuf2/videobuf2-dma-contig.c                    |    1 
 drivers/media/i2c/adv7604.c                                              |    4 
 drivers/media/i2c/adv7842.c                                              |   11 
 drivers/media/i2c/imx219.c                                               |    9 
 drivers/media/i2c/msp3400-kthreads.c                                     |    2 
 drivers/media/i2c/tda1997x.c                                             |    1 
 drivers/media/platform/amphion/vpu_malone.c                              |   23 
 drivers/media/platform/amphion/vpu_v4l2.c                                |   16 
 drivers/media/platform/amphion/vpu_v4l2.h                                |   10 
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c                     |   14 
 drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c        |   14 
 drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c      |   12 
 drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h      |    2 
 drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c             |    5 
 drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c      |   12 
 drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h      |    2 
 drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c             |    5 
 drivers/media/platform/qcom/iris/iris_common.c                           |    7 
 drivers/media/platform/renesas/rcar_drif.c                               |    1 
 drivers/media/platform/samsung/exynos4-is/media-dev.c                    |   10 
 drivers/media/platform/ti/davinci/vpif_capture.c                         |    4 
 drivers/media/platform/ti/davinci/vpif_display.c                         |    4 
 drivers/media/platform/verisilicon/hantro_g2.c                           |   88 +-
 drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c                  |   17 
 drivers/media/platform/verisilicon/hantro_g2_regs.h                      |   13 
 drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c                   |    2 
 drivers/media/platform/verisilicon/hantro_hw.h                           |    1 
 drivers/media/platform/verisilicon/imx8m_vpu_hw.c                        |    2 
 drivers/media/rc/st_rc.c                                                 |    2 
 drivers/mfd/altera-sysmgr.c                                              |    2 
 drivers/mfd/max77620.c                                                   |   15 
 drivers/mtd/mtdpart.c                                                    |    7 
 drivers/mtd/spi-nor/winbond.c                                            |   24 
 drivers/net/dsa/b53/b53_common.c                                         |    3 
 drivers/net/ethernet/airoha/airoha_eth.c                                 |   39 
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c                              |    2 
 drivers/net/ethernet/broadcom/Kconfig                                    |    8 
 drivers/net/ethernet/broadcom/bnge/bnge.h                                |    2 
 drivers/net/ethernet/broadcom/bnge/bnge_core.c                           |    2 
 drivers/net/ethernet/cadence/macb_main.c                                 |    3 
 drivers/net/ethernet/google/gve/gve_main.c                               |    2 
 drivers/net/ethernet/google/gve/gve_utils.c                              |    2 
 drivers/net/ethernet/intel/e1000/e1000_main.c                            |   10 
 drivers/net/ethernet/intel/i40e/i40e.h                                   |   11 
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c                           |   12 
 drivers/net/ethernet/intel/i40e/i40e_main.c                              |    1 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c                       |    4 
 drivers/net/ethernet/intel/iavf/iavf_main.c                              |    4 
 drivers/net/ethernet/intel/idpf/idpf_lib.c                               |    2 
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c                          |    5 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c                |    8 
 drivers/net/ethernet/smsc/smc91x.c                                       |   10 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                        |   17 
 drivers/net/ethernet/wangxun/Kconfig                                     |    4 
 drivers/net/fjes/fjes_hw.c                                               |   12 
 drivers/net/mdio/mdio-aspeed.c                                           |    7 
 drivers/net/mdio/mdio-realtek-rtl9300.c                                  |    6 
 drivers/net/phy/mediatek/mtk-ge-soc.c                                    |    2 
 drivers/net/team/team_core.c                                             |    2 
 drivers/net/usb/asix_common.c                                            |    5 
 drivers/net/usb/ax88172a.c                                               |    6 
 drivers/net/usb/rtl8150.c                                                |    2 
 drivers/net/usb/sr9700.c                                                 |    4 
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c                             |    4 
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c                     |    3 
 drivers/net/wireless/realtek/rtw88/sdio.c                                |    4 
 drivers/nvme/target/pci-epf.c                                            |    4 
 drivers/pci/controller/dwc/pci-meson.c                                   |   18 
 drivers/pci/controller/dwc/pcie-designware.c                             |   12 
 drivers/pci/controller/pcie-brcmstb.c                                    |   10 
 drivers/pci/pci-driver.c                                                 |    4 
 drivers/platform/mellanox/mlxbf-pmc.c                                    |   14 
 drivers/platform/x86/dell/alienware-wmi-wmax.c                           |   32 
 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c                     |    4 
 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c                      |    2 
 drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c               |    5 
 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c                |    5 
 drivers/platform/x86/hp/hp-bioscfg/string-attributes.c                   |    2 
 drivers/platform/x86/ibm_rtl.c                                           |    2 
 drivers/platform/x86/intel/pmt/discovery.c                               |    8 
 drivers/platform/x86/msi-laptop.c                                        |    3 
 drivers/platform/x86/samsung-galaxybook.c                                |    9 
 drivers/pmdomain/imx/gpc.c                                               |    5 
 drivers/pmdomain/mediatek/mtk-pm-domains.c                               |   21 
 drivers/power/supply/max77705_charger.c                                  |   14 
 drivers/powercap/intel_rapl_common.c                                     |    3 
 drivers/powercap/intel_rapl_msr.c                                        |    3 
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c                           |    1 
 drivers/vfio/pci/nvgrace-gpu/main.c                                      |    4 
 drivers/vfio/pci/pds/dirty.c                                             |    7 
 drivers/vfio/pci/vfio_pci_rdwr.c                                         |   25 
 drivers/video/fbdev/gbefb.c                                              |    5 
 drivers/video/fbdev/pxafb.c                                              |   12 
 drivers/video/fbdev/tcx.c                                                |    2 
 fs/erofs/zdata.c                                                         |   10 
 fs/lockd/svc4proc.c                                                      |    4 
 fs/lockd/svclock.c                                                       |   21 
 fs/lockd/svcproc.c                                                       |    5 
 fs/locks.c                                                               |   12 
 fs/nfsd/nfs4state.c                                                      |   20 
 fs/nfsd/vfs.c                                                            |   14 
 fs/ntfs3/frecord.c                                                       |   35 
 fs/smb/server/smb2pdu.c                                                  |    4 
 include/drm/drm_buddy.h                                                  |   11 
 include/drm/drm_edid.h                                                   |    6 
 include/drm/drm_pagemap.h                                                |   17 
 include/kunit/run-in-irq-context.h                                       |   53 -
 include/linux/compiler_types.h                                           |   13 
 include/linux/genalloc.h                                                 |    1 
 include/linux/huge_mm.h                                                  |    8 
 include/linux/kasan.h                                                    |   16 
 include/linux/kexec.h                                                    |    4 
 include/linux/mm.h                                                       |    8 
 include/linux/vfio_pci_core.h                                            |   10 
 include/net/dsa.h                                                        |    1 
 include/uapi/rdma/irdma-abi.h                                            |    2 
 include/uapi/rdma/rdma_user_cm.h                                         |    4 
 kernel/cgroup/cpuset.c                                                   |   21 
 kernel/kexec_core.c                                                      |   16 
 kernel/sched/deadline.c                                                  |    2 
 kernel/sched/debug.c                                                     |    8 
 kernel/sched/ext.c                                                       |   22 
 kernel/sched/fair.c                                                      |  249 ++++--
 kernel/sched/rt.c                                                        |    2 
 kernel/sched/sched.h                                                     |    4 
 kernel/sched/syscalls.c                                                  |    5 
 kernel/trace/fgraph.c                                                    |   10 
 lib/idr.c                                                                |    2 
 mm/damon/tests/core-kunit.h                                              |  134 +++
 mm/damon/tests/sysfs-kunit.h                                             |   25 
 mm/damon/tests/vaddr-kunit.h                                             |   26 
 mm/huge_memory.c                                                         |   71 -
 mm/kasan/common.c                                                        |   32 
 mm/kasan/hw_tags.c                                                       |    2 
 mm/kasan/shadow.c                                                        |    4 
 mm/page_alloc.c                                                          |   24 
 mm/page_owner.c                                                          |    2 
 mm/swapfile.c                                                            |   40 -
 mm/vmalloc.c                                                             |    8 
 net/bluetooth/mgmt.c                                                     |    6 
 net/bridge/br_private.h                                                  |    1 
 net/dsa/dsa.c                                                            |   67 -
 net/ipv4/fib_semantics.c                                                 |   26 
 net/ipv4/fib_trie.c                                                      |    7 
 net/ipv4/ip_gre.c                                                        |    6 
 net/ipv6/calipso.c                                                       |    3 
 net/ipv6/ip6_gre.c                                                       |   15 
 net/ipv6/route.c                                                         |   13 
 net/mac80211/cfg.c                                                       |   10 
 net/mac80211/rx.c                                                        |    5 
 net/mptcp/options.c                                                      |   10 
 net/mptcp/protocol.h                                                     |    6 
 net/mptcp/subflow.c                                                      |    6 
 net/nfc/core.c                                                           |    9 
 net/openvswitch/vport-netdev.c                                           |   17 
 net/rose/af_rose.c                                                       |    2 
 net/unix/af_unix.c                                                       |   11 
 net/wireless/sme.c                                                       |    2 
 rust/kernel/maple_tree.rs                                                |   11 
 samples/ftrace/ftrace-direct-modify.c                                    |    8 
 samples/ftrace/ftrace-direct-multi-modify.c                              |    8 
 samples/ftrace/ftrace-direct-multi.c                                     |    4 
 samples/ftrace/ftrace-direct-too.c                                       |    4 
 samples/ftrace/ftrace-direct.c                                           |    4 
 scripts/Makefile.build                                                   |   26 
 scripts/mod/devicetable-offsets.c                                        |    3 
 scripts/mod/file2alias.c                                                 |    9 
 security/integrity/ima/ima_kexec.c                                       |    4 
 sound/soc/codecs/cs35l41.c                                               |    7 
 sound/soc/codecs/lpass-tx-macro.c                                        |    3 
 sound/soc/codecs/pm4125.c                                                |   40 -
 sound/soc/codecs/wcd937x.c                                               |   43 -
 sound/soc/codecs/wcd939x-sdw.c                                           |    8 
 sound/soc/qcom/qdsp6/q6adm.c                                             |  146 +--
 sound/soc/qcom/qdsp6/q6apm-dai.c                                         |    2 
 sound/soc/qcom/qdsp6/q6asm-dai.c                                         |    7 
 sound/soc/qcom/sc7280.c                                                  |    2 
 sound/soc/qcom/sc8280xp.c                                                |    2 
 sound/soc/qcom/sdw.c                                                     |  105 +-
 sound/soc/qcom/sdw.h                                                     |    1 
 sound/soc/qcom/sm8250.c                                                  |    2 
 sound/soc/qcom/x1e80100.c                                                |    2 
 sound/soc/renesas/rz-ssi.c                                               |   64 +
 sound/soc/stm/stm32_sai.c                                                |   14 
 sound/soc/stm/stm32_sai_sub.c                                            |   51 -
 tools/mm/page_owner_sort.c                                               |    6 
 tools/sched_ext/scx_show_state.py                                        |    7 
 tools/testing/radix-tree/idr-test.c                                      |   21 
 tools/testing/selftests/drivers/net/psp.py                               |    6 
 tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc |    5 
 tools/testing/selftests/mm/uffd-unit-tests.c                             |    2 
 tools/testing/selftests/net/tap.c                                        |   16 
 326 files changed, 3279 insertions(+), 1652 deletions(-)

Akhil P Oommen (1):
      drm/msm/a6xx: Fix out of bound IO access in a6xx_get_gmu_registers

Alessio Belle (1):
      drm/imagination: Disallow exporting of PM/FW protected objects

Alex Deucher (3):
      drm/amdgpu: don't attach the tlb fence for SI
      drm/amdgpu/gmc12: add amdgpu_vm_handle_fault() handling
      drm/amdgpu/gmc11: add amdgpu_vm_handle_fault() handling

Alexander Gordeev (1):
      mm/page_alloc: change all pageblocks migrate type on coalescing

Alexey Minnekhanov (1):
      clk: qcom: mmcc-sdm660: Add missing MDSS reset

Alice C. Munduruca (1):
      selftests: net: fix "buffer overflow detected" for tap.c

Alice Ryhl (1):
      rust: maple_tree: rcu_read_lock() in destructor to silence lockdep

Alok Tiwari (3):
      platform/x86/intel/pmt/discovery: use valid device pointer in dev_err_probe
      RDMA/bnxt_re: Fix incorrect BAR check in bnxt_qplib_map_creq_db()
      RDMA/bnxt_re: Fix IB_SEND_IP_CSUM handling in post_send

Aloka Dixit (1):
      wifi: mac80211: do not use old MBSSID elements

Andrew Morton (1):
      genalloc.h: fix htmldocs warning

Andy Yan (1):
      drm/rockchip: vop2: Use OVL_LAYER_SEL configuration instead of use win_mask calculate used layers

Ankit Garg (1):
      gve: defer interrupt enabling until NAPI registration

Anna Maniscalco (1):
      drm/msm: add PERFCTR_CNTL to ifpc_reglist

Anshumali Gaur (1):
      octeontx2-pf: fix "UBSAN: shift-out-of-bounds error"

Ard Biesheuvel (1):
      drm/i915: Fix format string truncation warning

Armin Wolf (2):
      hwmon: (dell-smm) Fix off-by-one error in dell_smm_is_visible()
      platform/x86: samsung-galaxybook: Fix problematic pointer cast

Arnd Bergmann (3):
      net: wangxun: move PHYLINK dependency
      RDMA/ucma: Fix rdma_ucm_query_ib_service_resp struct padding
      RDMA/irdma: Fix irdma_alloc_ucontext_resp padding

Arunpravin Paneer Selvam (2):
      drm/buddy: Optimize free block management with RB tree
      drm/buddy: Separate clear and dirty free block trees

Ashutosh Dixit (2):
      drm/xe/oa: Disallow 0 OA property values
      drm/xe/eustall: Disallow 0 EU stall property values

Bagas Sanjaya (1):
      net: bridge: Describe @tunnel_hash member in net_bridge_vlan_group struct

Bijan Tabatabai (1):
      mm: consider non-anon swap cache folios in folio_expected_ref_count()

Biju Das (2):
      ASoC: renesas: rz-ssi: Fix channel swap issue in full duplex mode
      ASoC: renesas: rz-ssi: Fix rz_ssi_priv::hw_params_cache::sample_width

Borislav Petkov (AMD) (1):
      x86/microcode/AMD: Select which microcode patch to load

Brian Vazquez (1):
      idpf: reduce mbx_task schedule delay to 300us

Charles Keepax (1):
      Revert "gpio: swnode: don't use the swnode's name as the key for GPIO lookup"

Chen Ridong (1):
      cpuset: fix warning when disabling remote partition

Chen-Yu Tsai (1):
      media: mediatek: vcodec: Use spinlock for context list protection lock

Chenghao Duan (6):
      samples/ftrace: Adjust LoongArch register restore order in direct calls
      LoongArch: Refactor register restoration in ftrace_common_return
      LoongArch: BPF: Save return address register ra to t0 before trampoline
      LoongArch: BPF: Enable trampoline-based tracing for module functions
      LoongArch: BPF: Adjust the jump offset of tail calls
      LoongArch: BPF: Enhance the bpf_arch_text_poke() function

Christian Hitz (3):
      leds: leds-lp50xx: Allow LED 0 to be added to module bank
      leds: leds-lp50xx: LP5009 supports 3 modules for a total of 9 LEDs
      leds: leds-lp50xx: Enable chip before any communication

Christian Marangi (1):
      mtd: mtdpart: ignore error -ENOENT from parsers on subpartitions

Chuck Lever (2):
      NFSD: Make FILE_SYNC WRITEs comply with spec
      nfsd: fix nfsd_file reference leak in nfsd4_add_rdaccess_to_wrdeleg()

Claudio Imbrenda (1):
      KVM: s390: Fix gmap_helper_zap_one_page() again

Cong Zhang (1):
      blk-mq: skip CPU offline notify on unmapped hctx

Damien Le Moal (3):
      block: handle zone management operations completions
      block: Clear BLK_ZONE_WPLUG_PLUGGED when aborting plugged BIOs
      block: fix NULL pointer dereference in blk_zone_reset_all_bio_endio()

Dan Carpenter (1):
      wifi: cfg80211: sme: store capped length in __cfg80211_connect_result()

Daniel Zahka (2):
      selftests: drv-net: psp: fix templated test names in psp_ip_ver_test_builder()
      selftests: drv-net: psp: fix test names in ipver_test_builder()

Danilo Krummrich (1):
      drm: nova: depend on CONFIG_64BIT

Dave Stevenson (1):
      media: i2c: imx219: Fix 1920x1080 mode to use 1:1 pixel aspect ratio

Dave Vasilevsky (1):
      powerpc, mm: Fix mprotect on book3s 32-bit

David Gow (1):
      kunit: Enforce task execution in {soft,hard}irq contexts

David Hildenbrand (2):
      powerpc/pseries/cmm: adjust BALLOON_MIGRATE when migrating pages
      powerpc/pseries/cmm: call balloon_devinfo_init() also without CONFIG_BALLOON_COMPACTION

Deepakkumar Karn (1):
      net: usb: rtl8150: fix memory leak on usb_submit_urb() failure

Deepanshu Kartikey (2):
      net: usb: asix: validate PHY address before use
      net: nfc: fix deadlock between nfc_unregister_device and rfkill_fop_write

Dikshita Agarwal (1):
      media: iris: Refine internal buffer reconfiguration logic for resolution change

Ding Hui (1):
      RDMA/bnxt_re: Fix OOB write in bnxt_re_copy_err_stats()

Dmitry Osipenko (1):
      drm/rockchip: Set VOP for the DRM DMA device

Donet Tom (1):
      powerpc/64s/slb: Fix SLB multihit issue during SLB preload

Duoming Zhou (3):
      media: TDA1997x: Remove redundant cancel_delayed_work in probe
      media: i2c: ADV7604: Remove redundant cancel_delayed_work in probe
      media: i2c: adv7842: Remove redundant cancel_delayed_work in probe

Eric Dumazet (1):
      ip6_gre: make ip6gre_header() robust

Eric Naim (1):
      ASoC: cs35l41: Always return 0 when a subsystem ID is found

Ethan Nelson-Moore (1):
      net: usb: sr9700: fix incorrect command used to write single register

Fernand Sieber (1):
      sched/proxy: Yield the donor task

Frode Nordahl (1):
      erspan: Initialize options_len before referencing options.

Greg Kroah-Hartman (1):
      Linux 6.18.4

Gregory Herrero (1):
      i40e: validate ring_len parameter against hardware-specific values

Guangshuo Li (1):
      e1000: fix OOB in e1000_tbi_should_accept()

H. Peter Anvin (1):
      compiler_types.h: add "auto" as a macro for "__auto_type"

Hans de Goede (1):
      HID: logitech-dj: Remove duplicate error logging

Haotian Zhang (3):
      media: rc: st_rc: Fix reset control resource leak
      media: cec: Fix debugfs leak on bus_register() failure
      media: videobuf2: Fix device reference leak in vb2_dc_alloc error path

Haoxiang Li (3):
      media: mediatek: vcodec: Fix a reference leak in mtk_vcodec_fw_vpu_init()
      fjes: Add missing iounmap in fjes_hw_init()
      nfsd: Drop the client reference in client_states_open()

Hengqi Chen (2):
      LoongArch: BPF: Zero-extend bpf_tail_call() index
      LoongArch: BPF: Sign extend kfunc call arguments

Herbert Xu (1):
      crypto: seqiv - Do not use req->iv after crypto_aead_encrypt

Honggang LI (1):
      RDMA/rtrs: Fix clt_path::max_pages_per_mr calculation

Huacai Chen (3):
      LoongArch: Add new PCI ID for pci_fixup_vgadev()
      LoongArch: Fix arch_dup_task_struct() for CONFIG_RANDSTRUCT
      LoongArch: Fix build errors for CONFIG_RANDSTRUCT

Ido Schimmel (1):
      ipv4: Fix reference count leak when using error routes with nexthop objects

Ivan Abramov (2):
      media: adv7842: Avoid possible out-of-bounds array accesses in adv7842_cp_log_status()
      media: msp3400: Avoid possible out-of-bounds array accesses in msp3400c_thread()

Jacky Chou (1):
      net: mdio: aspeed: add dummy read to avoid read-after-write issue

Jan Stancek (1):
      powerpc/tools: drop `-o pipefail` in gcc check scripts

Jang Ingyu (1):
      RDMA/core: Fix logic error in ib_get_gids_from_rdma_hdr()

Jani Nikula (2):
      drm/edid: add DRM_EDID_IDENT_INIT() to initialize struct drm_edid_ident
      drm/displayid: add quirk to ignore DisplayID checksum errors

Jason Gunthorpe (2):
      RDMA/core: Check for the presence of LS_NLA_TYPE_DGID correctly
      RDMA/cm: Fix leaking the multicast GID table reference

Jay Cornwall (1):
      drm/amdkfd: Trap handler support for expert scheduling mode

Jeff Layton (1):
      nfsd: use ATTR_DELEG in nfsd4_finalize_deleg_timestamps()

Jens Axboe (1):
      af_unix: don't post cmsg for SO_INQ unless explicitly asked for

Jiayuan Chen (2):
      ipv6: fix a BUG in rt6_get_pcpu_route() under PREEMPT_RT
      mm/kasan: fix incorrect unpoisoning in vrealloc for KASAN

Jim Quinlan (1):
      PCI: brcmstb: Fix disabling L0s capability

Jinhui Guo (2):
      iommu/amd: Fix pci_segment memleak in alloc_pci_segment()
      iommu/amd: Propagate the error code returned by __modify_irte_ga() in modify_irte_ga()

Jiri Pirko (1):
      team: fix check for port enabled in team_queue_override_port_prio_changed()

Johan Hovold (23):
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
      drm/mediatek: mtk_hdmi: Fix probe device leaks
      drm/mediatek: ovl_adaptor: Fix probe device leaks

Jonas Gorski (1):
      net: dsa: b53: skip multicast entries for fdb_dump()

Jonathan Cavitt (1):
      drm/xe/guc: READ/WRITE_ONCE g2h_fence->done

Jonathan Kim (1):
      drm/amdkfd: bump minimum vgpr size for gfx1151

Jose Javier Rodriguez Barbarin (1):
      mcb: Add missing modpost build support

Jouni Malinen (1):
      wifi: mac80211: Discard Beacon frames to non-broadcast address

Junbeom Yeom (1):
      erofs: fix unexpected EIO under memory pressure

Junrui Luo (2):
      platform/x86: ibm_rtl: fix EBDA signature search pointer arithmetic
      platform/x86: hp-bioscfg: Fix out-of-bounds array access in ACPI package parsing

Kairui Song (1):
      mm, swap: do not perform synchronous discard during allocation

Kalesh AP (1):
      RDMA/bnxt_re: Fix to use correct page size for PDE table

Karol Wachowski (1):
      drm: Fix object leak in DRM_IOCTL_GEM_CHANGE_HANDLE

Kaushlendra Kumar (3):
      platform/x86/intel/pmt: Fix kobject memory leak on init failure
      tools/mm/page_owner_sort: fix timestamp comparison for stable sorting
      powercap: intel_rapl: Add support for Nova Lake processors

Kevin Tian (1):
      vfio/pci: Disable qword access to the PCI ROM bar

Kohei Enju (2):
      iavf: fix off-by-one issues in iavf_config_rss_reg()
      tools/sched_ext: fix scx_show_state.py for scx_root change

Konstantin Taranov (1):
      RDMA/mana_ib: check cqe length for kernel CQs

Kory Maincent (TI.com) (1):
      drm/tilcdc: Fix removal actions in case of failed probe

Krzysztof Kozlowski (4):
      ASoC: codecs: pm4125: Fix potential conflict when probing two devices
      ASoC: codecs: pm4125: Remove irq_chip on component unbind
      mfd: max77620: Fix potential IRQ chip conflict when probing two devices
      power: supply: max77705: Fix potential IRQ chip conflict when probing two devices

Krzysztof Niemiec (1):
      drm/i915/gem: Zero-initialize the eb.vma array in i915_gem_do_execbuffer

Kurt Borja (3):
      platform/x86: alienware-wmi-wmax: Add support for new Area-51 laptops
      platform/x86: alienware-wmi-wmax: Add AWCC support for Alienware x16
      platform/x86: alienware-wmi-wmax: Add support for Alienware 16X Aurora

Larysa Zaremba (1):
      idpf: fix LAN memory regions command on some NVMs

Li Chen (2):
      dm pcache: fix cache info indexing
      dm pcache: fix segment info indexing

Li Nan (1):
      md: Fix static checker warning in analyze_sbs

Li Zhijian (1):
      IB/rxe: Fix missing umem_odp->umem_mutex unlock on error path

Liang Jie (1):
      sched_ext: fix uninitialized ret on alloc_percpu() failure

Lorenzo Bianconi (1):
      net: airoha: Move net_devs registration in a dedicated routine

Lu Baolu (1):
      iommu: disable SVA when CONFIG_X86 is set

Luca Ceresoli (1):
      drm/bridge: ti-sn65dsi83: ignore PLL_UNLOCK errors

Luca Weiss (1):
      arm64: dts: qcom: sm6350: Fix wrong order of freq-table-hz for UFS

Lukas Wunner (1):
      PCI/PM: Reinstate clearing state_saved in legacy and !PM codepaths

Lyude Paul (2):
      drm/nouveau/gsp: Allocate fwsec-sb at boot
      drm/nouveau/dispnv50: Don't call drm_atomic_get_crtc_state() in prepare_fb

Ma Ke (2):
      ASoC: codecs: wcd937x: Fix error handling in wcd937x codec driver
      ASoC: codecs: Fix error handling in pm4125 audio codec driver

Maciej Wieczor-Retman (2):
      kasan: refactor pcpu kasan vmalloc unpoison
      kasan: unpoison vms[area] addresses with a common tag

Macpaul Lin (1):
      pmdomain: mtk-pm-domains: Fix spinlock recursion fix in probe

Mahesh Rao (1):
      firmware: stratix10-svc: Add mutex in stratix10 memory management

Manivannan Sadhasivam (1):
      PCI: meson: Fix parsing the DBI register region

Marek Szyprowski (1):
      media: samsung: exynos4-is: fix potential ABBA deadlock on init

Mario Limonciello (1):
      drm/amdkfd: Export the cwsr_size and ctl_stack_size to userspace

Mario Limonciello (AMD) (2):
      Revert "drm/amd: Skip power ungate during suspend for VPE"
      drm/amd: Fix unbind/rebind for VCN 4.0.5

Matthew Brost (2):
      drm/xe: Adjust long-running workload timeslices to reasonable values
      drm/xe: Use usleep_range for accurate long-running workload timeslicing

Matthew Wilcox (Oracle) (2):
      ntfs: Do not overwrite uptodate pages
      idr: fix idr_alloc() returning an ID out of range

Miaoqian Lin (3):
      media: renesas: rcar_drif: fix device node reference leak in rcar_drif_bond_enabled
      net: phy: mediatek: fix nvmem cell reference leak in mt798x_phy_calibration
      drm/mediatek: Fix device node reference leak in mtk_dp_dt_parse()

Michael Margolin (1):
      RDMA/efa: Remove possible negative shift

Michal Schmidt (1):
      RDMA/irdma: avoid invalid read in irdma_net_event

Mikulas Patocka (1):
      dm-bufio: align write boundary on physical block size

Ming Lei (2):
      ublk: implement NUMA-aware memory allocation
      ublk: scan partition in async way

Ming Qian (2):
      media: amphion: Remove vpu_vb_is_codecconfig
      media: amphion: Cancel message work before releasing the VPU core

Miquel Raynal (6):
      mtd: spi-nor: winbond: Add support for W25Q01NWxxIQ chips
      mtd: spi-nor: winbond: Add support for W25Q01NWxxIM chips
      mtd: spi-nor: winbond: Add support for W25Q02NWxxIM chips
      mtd: spi-nor: winbond: Add support for W25H512NWxxAM chips
      mtd: spi-nor: winbond: Add support for W25H01NWxxAM chips
      mtd: spi-nor: winbond: Add support for W25H02NWxxAM chips

Morning Star (1):
      wifi: rtlwifi: 8192cu: fix tid out of range in rtl92cu_tx_fill_desc()

Natalie Vock (1):
      drm/amdgpu: Forward VMID reservation errors

Nathan Chancellor (3):
      clk: samsung: exynos-clkout: Assign .num before accessing .hws
      clk: qcom: Fix SM_VIDEOCC_6350 dependencies
      clk: qcom: Fix dependencies of QCS_{DISP,GPU,VIDEO}CC_615

NeilBrown (1):
      lockd: fix vfs_test_lock() calls

Nicolas Dufresne (2):
      media: verisilicon: Fix CPU stalls on G2 bus error
      media: verisilicon: Protect G2 HEVC decoder against invalid DPB index

Nikolay Kuratov (1):
      drm/msm/dpu: Add missing NULL pointer check for pingpong interface

Paolo Abeni (1):
      mptcp: fallback earlier on simult connection

Paresh Bhagat (2):
      arm64: dts: ti: k3-am62d2-evm: Fix regulator properties
      arm64: dts: ti: k3-am62d2-evm: Fix PMIC padconfig

Patrice Chotard (1):
      arm64: dts: st: Add memory-region-names property for stm32mp257f-ev1

Pauli Virtanen (1):
      Bluetooth: MGMT: report BIS capability flags in supported settings

Peter Zijlstra (2):
      sched/core: Add comment explaining force-idle vruntime snapshots
      sched/eevdf: Fix min_vruntime vs avg_vruntime

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: add missing lock to amdgpu_ttm_access_memory_sdma

Ping-Ke Shih (1):
      wifi: rtw88: limit indirect IO under powered off for RTL8822CS

Pingfan Liu (2):
      kernel/kexec: change the prototype of kimage_map_segment()
      kernel/kexec: fix IMA when allocation happens in CMA area

Przemyslaw Korba (1):
      i40e: fix scheduling in set_rx_mode

Pwnverse (1):
      net: rose: fix invalid array index in rose_kill_by_device()

Qiang Ma (1):
      LoongArch: Correct the calculation logic of thread_count

Raghavendra Rao Ananta (1):
      hisi_acc_vfio_pci: Add .match_token_uuid callback in hisi_acc_vfio_pci_migrn_ops

Rajashekar Hudumula (1):
      bng_en: update module description

Raju Rangoju (1):
      amd-xgbe: reset retries and mode on RX adapt failures

Ran Xiaokai (1):
      mm/page_owner: fix memory leak in page_owner_stack_fops->release()

Raphael Pinsonneault-Thibeault (1):
      Bluetooth: btusb: revert use of devm_kzalloc in btusb

Rene Rebe (1):
      fbdev: gbefb: fix to use physical address instead of dma address

René Rebe (2):
      fbdev: tcx.c fix mem_map to correct smem_start offset
      drm/mgag200: Fix big-endian support

Rong Zhang (1):
      x86/microcode/AMD: Fix Entrysign revision check for Zen5/Strix Halo

Rosen Penev (1):
      net: mdio: rtl9300: use scoped for loops

Sandipan Das (1):
      perf/x86/amd/uncore: Fix the return value of amd_uncore_df_event_init() on error

Sanjay Yadav (1):
      drm/xe/oa: Fix potential UAF in xe_oa_add_config_ioctl()

SeongJae Park (20):
      mm/damon/tests/sysfs-kunit: handle alloc failures on damon_sysfs_test_add_targets()
      mm/damon/tests/vaddr-kunit: handle alloc failures on damon_do_test_apply_three_regions()
      mm/damon/tests/vaddr-kunit: handle alloc failures in damon_test_split_evenly_fail()
      mm/damon/tests/vaddr-kunit: handle alloc failures on damon_test_split_evenly_succ()
      mm/damon/tests/core-kunit: fix memory leak in damon_test_set_filters_default_reject()
      mm/damon/tests/core-kunit: handle alloc failres in damon_test_new_filter()
      mm/damon/tests/core-kunit: handle alloc failures on damon_test_split_at()
      mm/damon/tests/core-kunit: handle allocation failures in damon_test_regions()
      mm/damon/tests/core-kunit: handle memory failure from damon_test_target()
      mm/damon/tests/core-kunit: handle memory alloc failure from damon_test_aggregate()
      mm/damon/tests/core-kunit: handle alloc failures on dasmon_test_merge_regions_of()
      mm/damon/tests/core-kunit: handle alloc failures on damon_test_merge_two()
      mm/damon/tests/core-kunit: handle alloc failures in damon_test_set_regions()
      mm/damon/tests/core-kunit: handle alloc failures in damon_test_update_monitoring_result()
      mm/damon/tests/core-kunit: handle alloc failures on damon_test_set_filters_default_reject()
      mm/damon/tests/core-kunit: handle alloc failures on damos_test_filter_out()
      mm/damon/tests/core-kunit: handle alloc failures in damon_test_ops_registration()
      mm/damon/tests/core-kunit: handle alloc failure on damon_test_set_attrs()
      mm/damon/tests/core-kunit: handle alloc failure on damos_test_commit_filter()
      mm/damon/tests/core-kunit: handle alloc failures on damon_test_split_regions_of()

Shengming Hu (2):
      fgraph: Initialize ftrace_ops->private for function graph ops
      fgraph: Check ftrace_pids_enabled on registration for early filtering

Shin'ichiro Kawasaki (1):
      nvmet: pci-epf: move DMA initialization to EPC init callback

Shravan Kumar Ramani (1):
      platform/mellanox: mlxbf-pmc: Remove trailing whitespaces from event names

Siddharth Vadapalli (1):
      arm64: dts: ti: k3-j721e-sk: Fix pinmux for pin Y1 used by power regulator

Simon Richter (1):
      drm/ttm: Avoid NULL pointer deref for evicted BOs

Srinivas Kandagatla (6):
      ASoC: codecs: lpass-tx-macro: fix SM6115 support
      ASoC: qcom: sdw: fix memory leak for sdw_stream_runtime
      ASoC: qcom: q6apm-dai: set flags to reflect correct operation of appl_ptr
      ASoC: qcom: q6asm-dai: perform correct state check before closing
      ASoC: qcom: q6adm: the the copp device only during last instance
      ASoC: qcom: qdsp6: q6asm-dai: set 10 ms period and buffer alignment.

Srinivas Pandruvada (1):
      powercap: intel_rapl: Add support for Wildcat Lake platform

Srinivasan Shanmugam (1):
      drm/amdgpu/sdma6: Update SDMA 6.0.3 FW version to include UMQ protected-fence fix

Sven Schnelle (2):
      parisc: entry.S: fix space adjustment on interruption for 64-bit userspace
      parisc: entry: set W bit for !compat tasks in syscall_restore_rfi()

Tetsuo Handa (1):
      RDMA/core: always drop device refcount in ib_del_sub_device_and_put()

Thomas De Schampheleire (1):
      kbuild: fix compilation of dtb specified on command-line without make rule

Thomas Fourier (3):
      platform/x86: msi-laptop: add missing sysfs_remove_group()
      firewire: nosy: Fix dma_free_coherent() size
      RDMA/bnxt_re: fix dma_free_coherent() pointer

Thomas Hellström (4):
      drm/xe/bo: Don't include the CCS metadata in the dma-buf sg-table
      drm/xe: Drop preempt-fences when destroying imported dma-bufs.
      drm/xe/svm: Fix a debug printout
      drm/pagemap, drm/xe: Ensure that the devmem allocation is idle before use

Thomas Weißschuh (1):
      leds: leds-cros_ec: Skip LEDs without color components

Thomas Zimmermann (2):
      drm/gem-shmem: Fix the MODULE_LICENSE() string
      drm/gma500: Remove unused helper psb_fbdev_fb_setcolreg()

Thorsten Blum (1):
      fbdev: pxafb: Fix multiple clamped values in pxafb_adjust_timing

Tiezhu Yang (1):
      LoongArch: Use unsigned long for _end and _text

Toke Høiland-Jørgensen (1):
      net: openvswitch: Avoid needlessly taking the RTNL on vport destroy

Tuo Li (1):
      md/raid5: fix possible null-pointer dereferences in raid5_store_group_thread_cnt()

Uladzislau Rezki (Sony) (1):
      dm-ebs: Mark full buffer dirty even on partial write

Vadim Fedorenko (1):
      net: fib: restore ECMP balance from loopback

Ville Syrjälä (1):
      wifi: iwlwifi: Fix firmware version handling

Vladimir Oltean (2):
      net: dsa: properly keep track of conduit reference
      net: dsa: fix missing put_device() in dsa_tree_find_first_conduit()

Wake Liu (1):
      selftests/mm: fix thread state check in uffd-unit-tests

WangYuli (1):
      LoongArch: Use __pmd()/__pte() for swap entry conversions

Wei Fang (1):
      net: stmmac: fix the crash issue for zero copy XDP_TX action

Wei Yang (1):
      mm/huge_memory: merge uniform_split_supported() and non_uniform_split_supported()

Wentao Liang (1):
      pmdomain: imx: Fix reference count leak in imx_gpc_probe()

Will Rosenberg (1):
      ipv6: BUG() in pskb_expand_head() as part of calipso_skbuff_setattr()

Xiaolei Wang (1):
      net: macb: Relocate mog_init_rings() callback from macb_mac_link_up() to macb_open()

Yeoreum Yun (1):
      smc91x: fix broken irq-context in PREEMPT_RT

Yipeng Zou (1):
      selftests/ftrace: traceonoff_triggers: strip off names

Zilin Guan (2):
      vfio/pds: Fix memory leak in pds_vfio_dirty_enable()
      ksmbd: Fix memory leak in get_file_all_info()

Zqiang (1):
      sched_ext: Fix incorrect sched_class settings for per-cpu migration tasks


