Return-Path: <stable+bounces-75994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 531FF976843
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 13:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E7828367D
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 11:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBB91A0BE8;
	Thu, 12 Sep 2024 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ya4Gg3yP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8431A3058;
	Thu, 12 Sep 2024 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726141776; cv=none; b=Dck2tECAndS2I5AJrdGlxYHQp622NXy71VErZ5rQRPTFvRhDoVC8YoRTRIIulmHNJXui+PNQr479ZcFFE1QZsTArv7UGMR3zP7VqzCU5X4vrESYgn4+hTYIhNNKDXKw3K+l7Zthq+pDF6oFyI+NEe9b83MQK2DRy7m/p82fWuiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726141776; c=relaxed/simple;
	bh=s9MRIrWc9sBRwDYMNZe8gG51JfocEcAAj+7IeS9UEOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YPdMQg0o16TNCMS819Z6QbCzpyT0S0oE7kCsMk66dcQYd3QVCVY5aCvEAQdbhimKb1Q/VtlpJdbQckIkXfXn7OOmLImqnka4np5mWRygbAEUxSa78qY+BcNh+oqhJK4qFwgo4C3nbVtVnJRmGb48QX/Q5S0RcGxycX8OIdGrlKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ya4Gg3yP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AD1C4CEC4;
	Thu, 12 Sep 2024 11:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726141776;
	bh=s9MRIrWc9sBRwDYMNZe8gG51JfocEcAAj+7IeS9UEOw=;
	h=From:To:Cc:Subject:Date:From;
	b=Ya4Gg3yP1NtZS5OxLQFjl441wAGbW4JzwH/hia8DZhx2PRffsdQe/3EYGmbQ6sDTS
	 I6afE7yoY0PMjcPWsXAWVGtuFj0kyvpIVr8G+/NaBp2Lh0acG2I+fjZxdm8Ovhseik
	 g1PZ/rkOFL3QG0yU0vTNseVAEP15QXZ6UQXMKF98=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.10.10
Date: Thu, 12 Sep 2024 13:49:31 +0200
Message-ID: <2024091231-operator-walk-1b87@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.10.10 kernel.

All users of the 6.10 kernel series must upgrade.

The updated 6.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/cgroup-v2.rst                          |   15 
 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml   |    2 
 Makefile                                                         |    2 
 arch/arm64/include/asm/acpi.h                                    |   12 
 arch/arm64/kernel/acpi_numa.c                                    |   11 
 arch/loongarch/include/asm/hugetlb.h                             |    4 
 arch/loongarch/include/asm/kfence.h                              |    6 
 arch/loongarch/include/asm/pgtable.h                             |   48 -
 arch/loongarch/kernel/relocate.c                                 |    4 
 arch/loongarch/kvm/mmu.c                                         |    8 
 arch/loongarch/mm/hugetlbpage.c                                  |    6 
 arch/loongarch/mm/init.c                                         |   10 
 arch/loongarch/mm/kasan_init.c                                   |   10 
 arch/loongarch/mm/pgtable.c                                      |    2 
 arch/mips/kernel/cevt-r4k.c                                      |   15 
 arch/parisc/mm/init.c                                            |   16 
 arch/powerpc/include/asm/nohash/mmu-e500.h                       |    3 
 arch/powerpc/kernel/rtas.c                                       |    4 
 arch/powerpc/kernel/vdso/vdso32.lds.S                            |    4 
 arch/powerpc/kernel/vdso/vdso64.lds.S                            |    4 
 arch/powerpc/lib/qspinlock.c                                     |   10 
 arch/powerpc/mm/nohash/Makefile                                  |    2 
 arch/powerpc/mm/nohash/tlb.c                                     |  398 ----------
 arch/powerpc/mm/nohash/tlb_64e.c                                 |  361 +++++++++
 arch/powerpc/mm/nohash/tlb_low_64e.S                             |  195 ----
 arch/riscv/Kconfig                                               |    4 
 arch/riscv/include/asm/processor.h                               |   26 
 arch/riscv/include/asm/sbi.h                                     |   30 
 arch/riscv/include/asm/trace.h                                   |   54 +
 arch/riscv/kernel/Makefile                                       |    6 
 arch/riscv/kernel/head.S                                         |    3 
 arch/riscv/kernel/probes/kprobes.c                               |    5 
 arch/riscv/kernel/sbi.c                                          |   56 -
 arch/riscv/kernel/sbi_ecall.c                                    |   48 +
 arch/riscv/kernel/traps_misaligned.c                             |    4 
 arch/riscv/mm/init.c                                             |    2 
 arch/s390/boot/startup.c                                         |    8 
 arch/s390/kernel/vmlinux.lds.S                                   |   17 
 arch/um/drivers/line.c                                           |    2 
 arch/x86/coco/tdx/tdx.c                                          |    1 
 arch/x86/events/intel/core.c                                     |   57 +
 arch/x86/include/asm/fpu/types.h                                 |    7 
 arch/x86/include/asm/page_64.h                                   |    1 
 arch/x86/include/asm/pgtable_64_types.h                          |    4 
 arch/x86/kernel/apic/apic.c                                      |   11 
 arch/x86/kernel/fpu/xstate.c                                     |    3 
 arch/x86/kernel/fpu/xstate.h                                     |    4 
 arch/x86/kvm/svm/svm.c                                           |   15 
 arch/x86/kvm/x86.c                                               |    2 
 arch/x86/lib/iomem.c                                             |    5 
 arch/x86/mm/init_64.c                                            |    4 
 arch/x86/mm/kaslr.c                                              |   32 
 arch/x86/mm/pti.c                                                |   45 -
 block/bio.c                                                      |   14 
 drivers/accel/habanalabs/gaudi2/gaudi2_security.c                |    1 
 drivers/acpi/acpi_processor.c                                    |   15 
 drivers/android/binder.c                                         |    1 
 drivers/ata/libata-core.c                                        |    4 
 drivers/ata/libata-scsi.c                                        |   24 
 drivers/ata/pata_macio.c                                         |    7 
 drivers/base/devres.c                                            |    1 
 drivers/base/regmap/regcache-maple.c                             |    3 
 drivers/block/ublk_drv.c                                         |    2 
 drivers/bluetooth/btnxpuart.c                                    |   12 
 drivers/bluetooth/hci_qca.c                                      |    1 
 drivers/clk/qcom/clk-alpha-pll.c                                 |    6 
 drivers/clk/qcom/clk-rcg.h                                       |    1 
 drivers/clk/qcom/clk-rcg2.c                                      |   30 
 drivers/clk/qcom/gcc-ipq9574.c                                   |   12 
 drivers/clk/qcom/gcc-sm8550.c                                    |   54 -
 drivers/clk/qcom/gcc-x1e80100.c                                  |   52 -
 drivers/clk/starfive/clk-starfive-jh7110-sys.c                   |   31 
 drivers/clk/starfive/clk-starfive-jh71x0.h                       |    2 
 drivers/clocksource/timer-imx-tpm.c                              |   16 
 drivers/clocksource/timer-of.c                                   |   17 
 drivers/clocksource/timer-of.h                                   |    1 
 drivers/crypto/intel/qat/qat_common/adf_gen2_pfvf.c              |    4 
 drivers/crypto/intel/qat/qat_common/adf_rl.c                     |    1 
 drivers/crypto/intel/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c     |    8 
 drivers/crypto/starfive/jh7110-cryp.h                            |    4 
 drivers/crypto/starfive/jh7110-rsa.c                             |   15 
 drivers/cxl/core/region.c                                        |   24 
 drivers/firmware/cirrus/cs_dsp.c                                 |    3 
 drivers/gpio/gpio-rockchip.c                                     |    1 
 drivers/gpio/gpio-zynqmp-modepin.c                               |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                           |   15 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                       |   79 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c                      |   30 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c                          |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c                          |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c                          |   15 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h                          |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                          |  123 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h                          |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c                       |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h                        |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c                         |    6 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                           |    8 
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c                         |    8 
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c                            |    3 
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c                             |   28 
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c                          |    8 
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c                            |    3 
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c                            |    3 
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c                            |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                |   15 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c          |   47 -
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c                     |    7 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c              |    3 
 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c          |    2 
 drivers/gpu/drm/amd/display/dc/link/link_factory.c               |    6 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c |    3 
 drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c |    2 
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c       |   15 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                        |    6 
 drivers/gpu/drm/i915/display/intel_display_types.h               |    4 
 drivers/gpu/drm/i915/display/intel_dp.c                          |    4 
 drivers/gpu/drm/i915/display/intel_dp_aux.c                      |   16 
 drivers/gpu/drm/i915/display/intel_dp_aux.h                      |    2 
 drivers/gpu/drm/i915/display/intel_psr.c                         |    2 
 drivers/gpu/drm/i915/display/intel_quirks.c                      |   68 +
 drivers/gpu/drm/i915/display/intel_quirks.h                      |    6 
 drivers/gpu/drm/i915/gt/uc/intel_gsc_uc.c                        |    2 
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.h                         |    5 
 drivers/gpu/drm/i915/i915_sw_fence.c                             |    8 
 drivers/gpu/drm/imagination/pvr_vm.c                             |    4 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/fwsec.c                  |    2 
 drivers/gpu/drm/panthor/panthor_drv.c                            |   23 
 drivers/gpu/drm/panthor/panthor_fw.c                             |    8 
 drivers/gpu/drm/panthor/panthor_mmu.c                            |   21 
 drivers/gpu/drm/panthor/panthor_mmu.h                            |    1 
 drivers/gpu/drm/panthor/panthor_sched.c                          |    2 
 drivers/gpu/drm/xe/regs/xe_gt_regs.h                             |    1 
 drivers/gpu/drm/xe/xe_gsc.c                                      |   12 
 drivers/gpu/drm/xe/xe_uc_fw.h                                    |    9 
 drivers/gpu/drm/xe/xe_wa.c                                       |    8 
 drivers/hid/amd-sfh-hid/amd_sfh_hid.c                            |    4 
 drivers/hid/bpf/Kconfig                                          |    2 
 drivers/hid/hid-cougar.c                                         |    2 
 drivers/hv/vmbus_drv.c                                           |    1 
 drivers/hwmon/adc128d818.c                                       |    4 
 drivers/hwmon/hp-wmi-sensors.c                                   |    2 
 drivers/hwmon/lm95234.c                                          |    9 
 drivers/hwmon/ltc2991.c                                          |    6 
 drivers/hwmon/nct6775-core.c                                     |    2 
 drivers/hwmon/w83627ehf.c                                        |    4 
 drivers/i3c/master/mipi-i3c-hci/dma.c                            |    5 
 drivers/i3c/master/svc-i3c-master.c                              |   58 +
 drivers/iio/adc/ad7124.c                                         |   30 
 drivers/iio/adc/ad7606.c                                         |   28 
 drivers/iio/adc/ad7606.h                                         |    2 
 drivers/iio/adc/ad7606_par.c                                     |   48 +
 drivers/iio/adc/ad_sigma_delta.c                                 |    2 
 drivers/iio/buffer/industrialio-buffer-dmaengine.c               |    4 
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c                    |   13 
 drivers/iio/inkern.c                                             |    8 
 drivers/input/misc/uinput.c                                      |   14 
 drivers/input/touchscreen/ili210x.c                              |    6 
 drivers/iommu/intel/dmar.c                                       |    2 
 drivers/iommu/intel/iommu.c                                      |    4 
 drivers/iommu/intel/iommu.h                                      |    6 
 drivers/iommu/intel/pasid.c                                      |    1 
 drivers/iommu/intel/pasid.h                                      |   10 
 drivers/iommu/iommufd/hw_pagetable.c                             |    3 
 drivers/iommu/sun50i-iommu.c                                     |    1 
 drivers/irqchip/irq-armada-370-xp.c                              |    4 
 drivers/irqchip/irq-gic-v2m.c                                    |    6 
 drivers/irqchip/irq-renesas-rzg2l.c                              |    2 
 drivers/irqchip/irq-riscv-aplic-main.c                           |    4 
 drivers/irqchip/irq-sifive-plic.c                                |  115 +-
 drivers/leds/leds-spi-byte.c                                     |    6 
 drivers/md/dm-init.c                                             |    4 
 drivers/media/platform/qcom/camss/camss.c                        |    5 
 drivers/media/test-drivers/vivid/vivid-vid-cap.c                 |   17 
 drivers/media/test-drivers/vivid/vivid-vid-out.c                 |   16 
 drivers/media/usb/b2c2/flexcop-usb.c                             |    7 
 drivers/misc/fastrpc.c                                           |    5 
 drivers/misc/vmw_vmci/vmci_resource.c                            |    3 
 drivers/mmc/core/quirks.h                                        |   22 
 drivers/mmc/core/sd.c                                            |    4 
 drivers/mmc/host/cqhci-core.c                                    |    2 
 drivers/mmc/host/dw_mmc.c                                        |    4 
 drivers/mmc/host/sdhci-of-aspeed.c                               |    1 
 drivers/net/bareudp.c                                            |   22 
 drivers/net/can/kvaser_pciefd.c                                  |   43 -
 drivers/net/can/m_can/m_can.c                                    |  100 +-
 drivers/net/can/spi/mcp251x.c                                    |    2 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c                   |   28 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ram.c                    |   11 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c                   |   23 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c                     |  165 ++--
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c                    |    2 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c              |   22 
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h                        |   42 -
 drivers/net/dsa/vitesse-vsc73xx-core.c                           |   10 
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c                   |   20 
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c               |   10 
 drivers/net/ethernet/google/gve/gve.h                            |    1 
 drivers/net/ethernet/google/gve/gve_adminq.c                     |   22 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c           |    6 
 drivers/net/ethernet/intel/ice/ice.h                             |    2 
 drivers/net/ethernet/intel/ice/ice_base.c                        |   11 
 drivers/net/ethernet/intel/ice/ice_lib.c                         |  175 +---
 drivers/net/ethernet/intel/ice/ice_lib.h                         |   10 
 drivers/net/ethernet/intel/ice/ice_main.c                        |   63 +
 drivers/net/ethernet/intel/ice/ice_xsk.c                         |   12 
 drivers/net/ethernet/intel/igb/igb_main.c                        |   10 
 drivers/net/ethernet/intel/igc/igc_main.c                        |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en.h                     |   20 
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c              |   12 
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h                |   19 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                |   21 
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c                  |   66 -
 drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c             |   14 
 drivers/net/ethernet/microsoft/mana/mana_en.c                    |   22 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                         |   82 +-
 drivers/net/ethernet/xilinx/xilinx_axienet.h                     |    3 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c                |    8 
 drivers/net/mctp/mctp-serial.c                                   |    4 
 drivers/net/phy/phy_device.c                                     |    2 
 drivers/net/usb/ipheth.c                                         |    2 
 drivers/net/usb/r8152.c                                          |   17 
 drivers/net/usb/usbnet.c                                         |   11 
 drivers/net/wireless/ath/ath11k/ahb.c                            |    4 
 drivers/net/wireless/ath/ath11k/core.c                           |  115 --
 drivers/net/wireless/ath/ath11k/core.h                           |    4 
 drivers/net/wireless/ath/ath11k/hif.h                            |   12 
 drivers/net/wireless/ath/ath11k/mhi.c                            |   12 
 drivers/net/wireless/ath/ath11k/mhi.h                            |    3 
 drivers/net/wireless/ath/ath11k/pci.c                            |   44 -
 drivers/net/wireless/ath/ath11k/qmi.c                            |    2 
 drivers/net/wireless/ath/ath12k/mac.c                            |    9 
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c   |    1 
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h                     |    3 
 drivers/net/wireless/marvell/mwifiex/main.h                      |    3 
 drivers/net/wireless/realtek/rtw88/usb.c                         |   13 
 drivers/net/wireless/realtek/rtw89/core.c                        |    3 
 drivers/nvme/host/constants.c                                    |    2 
 drivers/nvme/host/core.c                                         |   40 -
 drivers/nvme/host/fabrics.c                                      |   10 
 drivers/nvme/host/fault_inject.c                                 |    2 
 drivers/nvme/host/fc.c                                           |    6 
 drivers/nvme/host/multipath.c                                    |    2 
 drivers/nvme/host/nvme.h                                         |    6 
 drivers/nvme/host/pci.c                                          |   17 
 drivers/nvme/host/pr.c                                           |   10 
 drivers/nvme/target/admin-cmd.c                                  |   34 
 drivers/nvme/target/core.c                                       |   46 -
 drivers/nvme/target/discovery.c                                  |   14 
 drivers/nvme/target/fabrics-cmd-auth.c                           |   16 
 drivers/nvme/target/fabrics-cmd.c                                |   36 
 drivers/nvme/target/io-cmd-bdev.c                                |   12 
 drivers/nvme/target/passthru.c                                   |   10 
 drivers/nvme/target/rdma.c                                       |   10 
 drivers/nvme/target/tcp.c                                        |    8 
 drivers/nvme/target/zns.c                                        |   30 
 drivers/nvmem/core.c                                             |    6 
 drivers/nvmem/u-boot-env.c                                       |    7 
 drivers/of/irq.c                                                 |   15 
 drivers/pci/controller/dwc/pci-keystone.c                        |   44 +
 drivers/pci/controller/dwc/pcie-qcom.c                           |   25 
 drivers/pci/hotplug/pnv_php.c                                    |    3 
 drivers/pci/pci.c                                                |   35 
 drivers/pcmcia/yenta_socket.c                                    |    6 
 drivers/phy/xilinx/phy-zynqmp.c                                  |    1 
 drivers/pinctrl/qcom/pinctrl-x1e80100.c                          |    4 
 drivers/platform/x86/dell/dell-smbios-base.c                     |    5 
 drivers/ptp/ptp_ocp.c                                            |  168 ++--
 drivers/scsi/lpfc/lpfc_els.c                                     |   17 
 drivers/scsi/pm8001/pm8001_sas.c                                 |    4 
 drivers/spi/spi-fsl-lpspi.c                                      |   31 
 drivers/spi/spi-hisi-kunpeng.c                                   |    3 
 drivers/spi/spi-intel.c                                          |    3 
 drivers/spi/spi-rockchip.c                                       |   23 
 drivers/staging/iio/frequency/ad9834.c                           |    2 
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c   |   31 
 drivers/ufs/core/ufshcd.c                                        |    7 
 drivers/uio/uio_hv_generic.c                                     |   11 
 drivers/usb/dwc3/core.c                                          |   15 
 drivers/usb/dwc3/core.h                                          |    2 
 drivers/usb/dwc3/gadget.c                                        |   41 -
 drivers/usb/gadget/udc/aspeed_udc.c                              |    2 
 drivers/usb/gadget/udc/cdns2/cdns2-gadget.c                      |   12 
 drivers/usb/gadget/udc/cdns2/cdns2-gadget.h                      |    9 
 drivers/usb/storage/uas.c                                        |    1 
 drivers/usb/typec/ucsi/ucsi.c                                    |   50 -
 drivers/vfio/vfio_iommu_spapr_tce.c                              |   13 
 drivers/virt/coco/sev-guest/sev-guest.c                          |    7 
 drivers/virtio/virtio_ring.c                                     |    4 
 drivers/watchdog/imx7ulp_wdt.c                                   |    5 
 drivers/xen/privcmd.c                                            |   10 
 fs/binfmt_elf.c                                                  |    5 
 fs/btrfs/ctree.c                                                 |   12 
 fs/btrfs/ctree.h                                                 |    1 
 fs/btrfs/extent-tree.c                                           |   62 +
 fs/btrfs/file.c                                                  |   25 
 fs/btrfs/inode.c                                                 |    2 
 fs/btrfs/qgroup.c                                                |   90 ++
 fs/btrfs/transaction.h                                           |    6 
 fs/btrfs/zoned.c                                                 |   30 
 fs/cachefiles/io.c                                               |    2 
 fs/ext4/fast_commit.c                                            |    8 
 fs/fuse/dev.c                                                    |   14 
 fs/fuse/dir.c                                                    |    2 
 fs/fuse/file.c                                                   |    8 
 fs/fuse/inode.c                                                  |    7 
 fs/fuse/xattr.c                                                  |    4 
 fs/jbd2/recovery.c                                               |   30 
 fs/libfs.c                                                       |    6 
 fs/namespace.c                                                   |   93 +-
 fs/netfs/fscache_main.c                                          |    1 
 fs/netfs/io.c                                                    |   19 
 fs/nfs/super.c                                                   |    2 
 fs/nilfs2/recovery.c                                             |   35 
 fs/nilfs2/segment.c                                              |   10 
 fs/nilfs2/sysfs.c                                                |   43 -
 fs/ntfs3/dir.c                                                   |   52 -
 fs/ntfs3/frecord.c                                               |    4 
 fs/smb/client/cifsfs.c                                           |   21 
 fs/smb/client/cifsglob.h                                         |    1 
 fs/smb/client/cifssmb.c                                          |   54 +
 fs/smb/client/file.c                                             |   37 
 fs/smb/client/inode.c                                            |    2 
 fs/smb/client/smb2inode.c                                        |    3 
 fs/smb/client/smb2ops.c                                          |   18 
 fs/smb/client/smb2pdu.c                                          |   41 -
 fs/smb/client/trace.h                                            |    1 
 fs/smb/server/oplock.c                                           |    2 
 fs/smb/server/smb2pdu.c                                          |   14 
 fs/smb/server/transport_tcp.c                                    |    4 
 fs/squashfs/inode.c                                              |    7 
 fs/tracefs/event_inode.c                                         |    2 
 fs/udf/super.c                                                   |   15 
 fs/xattr.c                                                       |   91 +-
 fs/xfs/libxfs/xfs_ialloc_btree.c                                 |    2 
 include/linux/bpf-cgroup.h                                       |    9 
 include/linux/mlx5/device.h                                      |    1 
 include/linux/mm.h                                               |    4 
 include/linux/netfs.h                                            |    1 
 include/linux/nvme.h                                             |   16 
 include/linux/path.h                                             |    9 
 include/linux/regulator/consumer.h                               |    8 
 include/linux/zswap.h                                            |    4 
 include/net/bluetooth/hci_core.h                                 |    5 
 include/net/bluetooth/hci_sync.h                                 |    4 
 include/net/mana/mana.h                                          |    2 
 include/uapi/drm/drm_fourcc.h                                    |   18 
 include/uapi/drm/panthor_drm.h                                   |    6 
 kernel/bpf/btf.c                                                 |    4 
 kernel/bpf/verifier.c                                            |    4 
 kernel/cgroup/cgroup.c                                           |    2 
 kernel/cgroup/cpuset.c                                           |   36 
 kernel/dma/map_benchmark.c                                       |   16 
 kernel/events/core.c                                             |   18 
 kernel/events/internal.h                                         |    1 
 kernel/events/ring_buffer.c                                      |    2 
 kernel/events/uprobes.c                                          |    3 
 kernel/exit.c                                                    |    3 
 kernel/kexec_file.c                                              |    2 
 kernel/locking/rtmutex.c                                         |    9 
 kernel/resource.c                                                |    6 
 kernel/seccomp.c                                                 |   23 
 kernel/smp.c                                                     |    1 
 kernel/trace/trace.c                                             |    2 
 kernel/trace/trace_kprobe.c                                      |  125 ++-
 kernel/trace/trace_osnoise.c                                     |   50 -
 kernel/workqueue.c                                               |   12 
 lib/codetag.c                                                    |   17 
 lib/generic-radix-tree.c                                         |    2 
 lib/maple_tree.c                                                 |    7 
 lib/overflow_kunit.c                                             |    3 
 mm/memcontrol.c                                                  |   12 
 mm/memory_hotplug.c                                              |    2 
 mm/page_alloc.c                                                  |    7 
 mm/slub.c                                                        |    4 
 mm/sparse.c                                                      |    2 
 mm/userfaultfd.c                                                 |   29 
 mm/vmalloc.c                                                     |    7 
 mm/vmscan.c                                                      |   24 
 mm/zswap.c                                                       |    2 
 net/bluetooth/hci_conn.c                                         |    6 
 net/bluetooth/hci_sync.c                                         |   42 +
 net/bluetooth/mgmt.c                                             |  144 +--
 net/bluetooth/smp.c                                              |    7 
 net/bridge/br_fdb.c                                              |    6 
 net/can/bcm.c                                                    |    4 
 net/core/filter.c                                                |    1 
 net/core/net-sysfs.c                                             |    2 
 net/ethtool/channels.c                                           |    6 
 net/ethtool/common.c                                             |   26 
 net/ethtool/common.h                                             |    2 
 net/ethtool/ioctl.c                                              |    4 
 net/ipv4/fou_core.c                                              |   29 
 net/ipv4/tcp_bpf.c                                               |    2 
 net/ipv4/tcp_input.c                                             |    6 
 net/ipv6/ila/ila.h                                               |    1 
 net/ipv6/ila/ila_main.c                                          |    6 
 net/ipv6/ila/ila_xlat.c                                          |   13 
 net/netfilter/nf_conncount.c                                     |    8 
 net/sched/sch_cake.c                                             |   11 
 net/sched/sch_netem.c                                            |    9 
 net/socket.c                                                     |    4 
 net/unix/af_unix.c                                               |    9 
 rust/Makefile                                                    |    2 
 rust/macros/module.rs                                            |    6 
 scripts/gfp-translate                                            |   66 +
 security/smack/smack_lsm.c                                       |   12 
 sound/core/control.c                                             |    6 
 sound/hda/hdmi_chmap.c                                           |   18 
 sound/pci/hda/patch_conexant.c                                   |   11 
 sound/pci/hda/patch_realtek.c                                    |   22 
 sound/soc/codecs/tas2781-fmwlib.c                                |   71 -
 sound/soc/intel/boards/bxt_rt298.c                               |    2 
 sound/soc/intel/boards/bytcht_cx2072x.c                          |    2 
 sound/soc/intel/boards/bytcht_da7213.c                           |    2 
 sound/soc/intel/boards/bytcht_es8316.c                           |    2 
 sound/soc/intel/boards/bytcr_rt5640.c                            |    2 
 sound/soc/intel/boards/bytcr_rt5651.c                            |    2 
 sound/soc/intel/boards/bytcr_wm5102.c                            |    2 
 sound/soc/intel/boards/cht_bsw_rt5645.c                          |    2 
 sound/soc/intel/boards/cht_bsw_rt5672.c                          |    2 
 sound/soc/soc-dapm.c                                             |    1 
 sound/soc/soc-topology.c                                         |    2 
 sound/soc/sof/topology.c                                         |    2 
 sound/soc/sunxi/sun4i-i2s.c                                      |  143 +--
 sound/soc/tegra/tegra210_ahub.c                                  |   10 
 tools/lib/bpf/libbpf.c                                           |    4 
 tools/net/ynl/lib/ynl.py                                         |    7 
 tools/perf/util/bpf_lock_contention.c                            |    3 
 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c               |    4 
 tools/testing/selftests/mm/mseal_test.c                          |   37 
 tools/testing/selftests/mm/seal_elf.c                            |   13 
 tools/testing/selftests/net/Makefile                             |    3 
 tools/testing/selftests/riscv/mm/mmap_bottomup.c                 |    2 
 tools/testing/selftests/riscv/mm/mmap_default.c                  |    2 
 tools/testing/selftests/riscv/mm/mmap_test.h                     |   67 -
 436 files changed, 4628 insertions(+), 3085 deletions(-)

Aaradhana Sahu (1):
      wifi: ath12k: fix uninitialize symbol error on ath12k_peer_assoc_h_he()

Abel Vesa (1):
      clk: qcom: gcc-x1e80100: Fix USB 0 and 1 PHY GDSC pwrsts flags

Adam Queler (1):
      ALSA: hda/realtek: Enable Mute Led for HP Victus 15-fb1xxx

Adrian Huang (1):
      mm: vmalloc: optimize vmap_lazy_nr arithmetic when purging each vmap_area

Adrián Larumbe (1):
      drm/panthor: flush FW AS caches in slow reset path

Ajith C (1):
      wifi: ath12k: fix firmware crash due to invalid peer nss

Aleksandr Mishin (2):
      platform/x86: dell-smbios: Fix error path in dell_smbios_init()
      staging: iio: frequency: ad9834: Validate frequency parameter value

Alex Deucher (2):
      Revert "drm/amdgpu: align pp_power_profile_mode with kernel docs"
      drm/amdgpu: always allocate cleared VRAM for GEM allocations

Alex Hung (6):
      drm/amd/display: Check UnboundedRequestEnabled's value
      drm/amd/display: Run DC_LOG_DC after checking link->link_enc
      drm/amd/display: Check HDCP returned status
      drm/amd/display: Validate function returns
      drm/amd/display: Check denominator pbn_div before used
      drm/amd/display: Check denominator crb_pipes before used

Alexander Gordeev (1):
      s390/boot: Do not assume the decompressor range is reserved

Alexandre Ghiti (3):
      riscv: Do not restrict memory size because of linear mapping on nommu
      riscv: Improve sbi_ecall() code generation by reordering arguments
      riscv: Fix RISCV_ALTERNATIVE_EARLY

Alexey Dobriyan (1):
      ELF: fix kernel.randomize_va_space double read

Alison Schofield (1):
      cxl/region: Verify target positions using the ordered target list

Amadeusz Sławiński (1):
      ASoC: topology: Properly initialize soc_enum values

Andreas Hindborg (1):
      rust: kbuild: fix export of bss symbols

Andreas Ziegler (1):
      libbpf: Add NULL checks to bpf_object__{prev_map,next_map}

Andrei Vagin (1):
      seccomp: release task filters when the task exits

Andy Shevchenko (3):
      leds: spi-byte: Call of_node_put() on error path
      drm/i915/fence: Mark debug_fence_init_onstack() with __maybe_unused
      drm/i915/fence: Mark debug_fence_free() with __maybe_unused

Anton Blanchard (1):
      riscv: Fix toolchain vector detection

Anup Patel (1):
      irqchip/sifive-plic: Probe plic driver early for Allwinner D1 platform

Arend van Spriel (1):
      wifi: brcmsmac: advertise MFP_CAPABLE to enable WPA3

Arkadiusz Kubalewski (1):
      tools/net/ynl: fix cli.py --subscribe feature

Armin Wolf (1):
      hwmon: (hp-wmi-sensors) Check if WMI event data exists

Arnd Bergmann (2):
      regmap: maple: work around gcc-14.1 false-positive warning
      hid: bpf: add BPF_JIT dependency

Aurabindo Pillai (1):
      drm/amd: Add gfx12 swizzle mode defs

Baochen Qiang (2):
      Revert "wifi: ath11k: restore country code during resume"
      Revert "wifi: ath11k: support hibernation"

Baokun Li (1):
      fscache: delete fscache_cookie_lru_timer when fscache exits to avoid UAF

Benjamin Marzinski (1):
      dm init: Handle minors larger than 255

Bernd Schubert (1):
      fuse: disable the combination of passthrough and writeback cache

Bob Zhou (1):
      drm/amdgpu: add missing error handling in function amdgpu_gmc_flush_gpu_tlb_pasid

Bommu Krishnaiah (2):
      drm/xe/xe2: Add workaround 14021402888
      drm/xe/xe2lpg: Extend workaround 14021402888

Boqun Feng (1):
      rust: macros: provide correct provenance when constructing THIS_MODULE

Breno Leitao (1):
      net: dqs: Do not use extern for unused dql_group

Brian Johannesmeyer (1):
      x86/kmsan: Fix hook for unaligned accesses

Brian Norris (1):
      spi: rockchip: Resolve unbalanced runtime PM / system PM handling

Bryan O'Donoghue (1):
      clk: qcom: gcc-x1e80100: Don't use parking clk_ops for QUPs

Camila Alvarez (1):
      HID: cougar: fix slab-out-of-bounds Read in cougar_report_fixup

Carlos Llamas (1):
      binder: fix UAF caused by offsets overwrite

Carlos Song (1):
      spi: spi-fsl-lpspi: limit PRESCALE bit in TCR register

Charles Han (1):
      spi: intel: Add check devm_kasprintf() returned value

Charlie Jenkins (2):
      riscv: selftests: Remove mmap hint address checks
      riscv: mm: Do not restrict mmap address based on hint

Chen Ni (1):
      media: qcom: camss: Add check for v4l2_fwnode_endpoint_parse

Chen-Yu Tsai (1):
      ASoc: SOF: topology: Clear SOF link platform name upon unload

ChenXiaoSong (1):
      smb/server: fix potential null-ptr-deref of lease_ctx_info in smb2_open()

Chih-Kang Chang (1):
      wifi: rtw89: wow: prevent to send unexpected H2C during download Firmware

Christian Brauner (7):
      libfs: fix get_stashed_dentry()
      fs: don't copy to userspace under namespace semaphore
      fs: relax permissions for statmount()
      fs: only copy to userspace on success in listmount()
      path: add cleanup helper
      fs: simplify error handling
      fs: relax permissions for listmount()

Christian König (1):
      drm/amdgpu: reject gang submit on reserved VMIDs

Christoffer Sandberg (1):
      ALSA: hda/conexant: Add pincfg quirk to enable top speakers on Sirius devices

Christoph Hellwig (1):
      block: don't call bio_uninit from bio_endio

Christophe Leroy (2):
      powerpc/64e: Define mmu_pte_psize static
      powerpc/vdso: Don't discard rela sections

Cong Wang (1):
      tcp_bpf: fix return value of tcp_bpf_sendmsg()

Daiwei Li (1):
      igb: Fix not clearing TimeSync interrupts for 82580

Dan Carpenter (3):
      ksmbd: Unlock on in ksmbd_tcp_set_interfaces()
      irqchip/riscv-aplic: Fix an IS_ERR() vs NULL bug in probe()
      igc: Unlock on error in igc_io_resume()

Dan Williams (1):
      PCI: Add missing bridge lock to pci_bus_lock()

Daniel Lezcano (1):
      clocksource/drivers/timer-of: Remove percpu irq related code

Daniele Ceraolo Spurio (2):
      drm/xe/gsc: Do not attempt to load the GSC multiple times
      drm/i915: Do not attempt to load the GSC multiple times

Danijel Slivka (1):
      drm/amdgpu: clear RB_OVERFLOW bit when enabling interrupts

Dave Airlie (1):
      nouveau: fix the fwsec sb verification register.

Dave Chinner (1):
      xfs: xfs_finobt_count_blocks() walks the wrong btree

David Fernandez Gonzalez (1):
      VMCI: Fix use-after-free when removing resource in vmci_resource_remove()

David Howells (8):
      cifs: Fix lack of credit renegotiation on read retry
      netfs, cifs: Fix handling of short DIO read
      cifs: Fix copy offload to flush destination region
      cifs: Fix FALLOC_FL_ZERO_RANGE to preflush buffered part of target region
      cachefiles: Set the max subreq size for cache writes to MAX_RW_COUNT
      vfs: Fix potential circular locking through setxattr() and removexattr()
      cifs: Fix zero_point init on inode initialisation
      cifs: Fix SMB1 readv/writev callback in the same way as SMB2/3

David Lechner (1):
      iio: buffer-dmaengine: fix releasing dma channel on error

David Sterba (1):
      btrfs: initialize location to fix -Wmaybe-uninitialized in btrfs_lookup_dentry()

Dawid Osuchowski (1):
      ice: Add netif_device_attach/detach into PF reset flow

Devyn Liu (1):
      spi: hisi-kunpeng: Add verification for the max_frequency provided by the firmware

Dmitry Torokhov (2):
      Input: ili210x - use kvmalloc() to allocate buffer for firmware update
      Input: uinput - reject requests with unreasonable number of slots

Douglas Anderson (2):
      regulator: core: Stub devm_regulator_bulk_get_const() if !CONFIG_REGULATOR
      Bluetooth: qca: If memdump doesn't work, re-enable IBS

Dragos Tatulea (1):
      net/mlx5e: SHAMPO, Fix page leak

Dumitru Ceclan (3):
      iio: adc: ad7124: fix config comparison
      iio: adc: ad7124: fix chip ID mismatch
      iio: adc: ad7124: fix DT configuration parsing

Eric Dumazet (1):
      ila: call nf_unregister_net_hooks() sooner

Eric Joyner (1):
      ice: Check all ice_vsi_rebuild() errors in function

Faisal Hassan (1):
      usb: dwc3: core: update LC timer as per USB Spec V3.2

Fedor Pchelkin (1):
      btrfs: qgroup: don't use extent changeset when not needed

Filipe Manana (3):
      btrfs: replace BUG_ON() with error handling at update_ref_for_cow()
      btrfs: don't BUG_ON() when 0 reference count at btrfs_lookup_extent_info()
      btrfs: fix race between direct IO write and fsync when using same fd

Frank Li (1):
      i3c: master: svc: resend target address when get NACK

Geert Uytterhoeven (1):
      nvmem: Fix return type of devm_nvmem_device_get() in kerneldoc

Georg Gottleuber (1):
      nvme-pci: Add sleep quirk for Samsung 990 Evo

Greg Kroah-Hartman (1):
      Linux 6.10.10

Guenter Roeck (4):
      hwmon: (adc128d818) Fix underflows seen when writing limit attributes
      hwmon: (lm95234) Fix underflows seen when writing limit attributes
      hwmon: (nct6775-core) Fix underflows seen when writing limit attributes
      hwmon: (w83627ehf) Fix underflows seen when writing limit attributes

Guillaume Nault (1):
      bareudp: Fix device stats updates.

Guillaume Stols (1):
      iio: adc: ad7606: remove frstdata check for serial mode

Hans Verkuil (3):
      media: b2c2: flexcop-usb: fix flexcop_usb_memory_req
      media: vivid: fix wrong sizeimage value for mplane
      media: vivid: don't set HDMI TX controls if there are no HDMI outputs

Hans de Goede (1):
      ASoC: Intel: Boards: Fix NULL pointer deref in BYT/CHT boards harder

Hao Ge (2):
      codetag: debug: mark codetags for poisoned page as empty
      mm/slub: add check for s->flags in the alloc_tagging_slab_free_hook

Hareshx Sankar Raj (1):
      crypto: qat - fix unintentional re-enabling of error interrupts

Hawking Zhang (3):
      drm/amdgpu: Fix register access violation
      drm/amdgpu: Fix smatch static checker warning
      drm/amdgpu: Correct register used to clear fault status

Hayes Wang (1):
      r8152: fix the firmware doesn't work

Heikki Krogerus (1):
      usb: typec: ucsi: Fix the partner PD revision

Heiko Carstens (1):
      s390/vmlinux.lds.S: Move ro_after_init section behind rodata section

Helge Deller (1):
      parisc: Delay write-protection until mark_rodata_ro() call

Huacai Chen (2):
      LoongArch: Use correct API to map cmdline in relocate_kernel()
      LoongArch: Use accessors to page table entries instead of direct dereference

Huang Ying (1):
      cxl/region: Fix a race condition in memory hotplug notifier

Igor Pylypiv (3):
      scsi: pm80xx: Set phy->enable_completion only when we wait for it
      ata: libata-scsi: Remove redundant sense_buffer memsets
      ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED before using result_tf

Ivan Orlov (1):
      kunit/overflow: Fix UB in overflow_allocation_test

Jacky Bai (2):
      clocksource/drivers/imx-tpm: Fix return -ETIME when delta exceeds INT_MAX
      clocksource/drivers/imx-tpm: Fix next event not taking effect sometime

Jacob Pan (1):
      iommu/vt-d: Handle volatile descriptor status read

Jakub Kicinski (1):
      ethtool: fail closed if we can't get max channel used in indirection tables

James Morse (1):
      arm64: acpi: Move get_cpu_for_acpi_id() to a header

Jamie Bainbridge (1):
      selftests: net: enable bind tests

Jan Kara (1):
      udf: Avoid excessive partition lengths

Jann Horn (3):
      fuse: use unsigned type for getxattr/listxattr size truncation
      userfaultfd: don't BUG_ON() if khugepaged yanks our page table
      userfaultfd: fix checks for huge PMDs

Jarkko Nikula (1):
      i3c: mipi-i3c-hci: Error out instead on BUG_ON() in IBI DMA setup

Jason Gunthorpe (1):
      iommufd: Require drivers to supply the cache_invalidate_user ops

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_mpu6050: fix interrupt status read for old buggy chips

Jens Emil Schulz Østergaard (1):
      net: microchip: vcap: Fix use-after-free error in kunit test

Jeongjun Park (1):
      bpf: add check for invalid name in btf_name_valid_section()

Jernej Skrabec (1):
      iommu: sun50i: clear bypass register

Jia Jie Ho (2):
      crypto: starfive - Align rsa input data to 32-bit
      crypto: starfive - Fix nent assignment in rsa dec

Jiaxun Yang (1):
      MIPS: cevt-r4k: Don't call get_c0_compare_int if timer irq is installed

Jinjie Ruan (1):
      net: phy: Fix missing of_node_put() for leds

Jiwei Sun (1):
      crypto: qat - initialize user_input.lock for rate_limiting

Joanne Koong (2):
      fuse: update stats for pages in dropped aux writeback list
      fuse: check aborted connection before adding requests to pending list for resending

Johannes Berg (2):
      wifi: iwlwifi: mvm: use IWL_FW_CHECK for link ID check
      um: line: always fill *error_out in setup_one_line()

John Thomson (1):
      nvmem: u-boot-env: error if NVMEM device is too small

Jonas Gorski (1):
      net: bridge: br_fdb_external_learn_add(): always set EXT_LEARN

Jonathan Bell (1):
      mmc: core: apply SD quirks earlier during probe

Jonathan Cameron (3):
      ACPI: processor: Return an error if acpi_processor_get_info() fails in processor_add()
      ACPI: processor: Fix memory leaks in error paths of processor_add()
      arm64: acpi: Harden get_cpu_for_acpi_id() against missing CPU entry

Josef Bacik (4):
      btrfs: don't BUG_ON on ENOMEM from btrfs_lookup_extent_info() in walk_down_proc()
      btrfs: replace BUG_ON with ASSERT in walk_down_proc()
      btrfs: clean up our handling of refs == 0 in snapshot delete
      btrfs: handle errors from btrfs_dec_ref() properly

Jouni Högander (2):
      drm/i915/display: Add mechanism to use sink model when applying quirk
      drm/i915/display: Increase Fast Wake Sync length as a quirk

Jules Irenge (1):
      pcmcia: Use resource_size function on resource object

Justin Tee (1):
      scsi: lpfc: Handle mailbox timeouts in lpfc_get_sfp_info

Kan Liang (2):
      perf/x86/intel: Limit the period on Haswell
      perf/x86/intel: Hide Topdown metrics events if the feature is not enumerated

Keith Busch (1):
      nvme-pci: allocate tagset on reset if necessary

Kent Overstreet (1):
      lib/generic-radix-tree.c: Fix rare race in __genradix_ptr_alloc()

Kirill A. Shutemov (1):
      x86/tdx: Fix data leak in mmio_read()

Kishon Vijay Abraham I (1):
      PCI: keystone: Add workaround for Errata #i2037 (AM65x SR 1.0)

Konstantin Andreev (1):
      smack: unix sockets: fix accept()ed socket label

Konstantin Komarov (2):
      fs/ntfs3: One more reason to mark inode bad
      fs/ntfs3: Check more cases when directory is corrupted

Krishna Kumar (1):
      pci/hotplug/pnv_php: Fix hotplug driver crash on Powernv

Krzysztof Kozlowski (1):
      gpio: rockchip: fix OF node leak in probe()

Kuniyuki Iwashima (4):
      af_unix: Remove put_pid()/put_cred() in copy_peercred().
      can: bcm: Remove proc entry when dev is unregistered.
      fou: Fix null-ptr-deref in GRO.
      tcp: Don't drop SYN+ACK for simultaneous connect().

Kyoungrul Kim (1):
      scsi: ufs: core: Remove SCSI host only if added

Lad Prabhakar (1):
      irqchip/renesas-rzg2l: Reorder function calls in rzg2l_irqc_irq_disable()

Larysa Zaremba (5):
      ice: move netif_queue_set_napi to rtnl-protected sections
      ice: protect XDP configuration with a mutex
      ice: check ICE_VSI_DOWN under rtnl_lock when preparing for reset
      ice: remove ICE_CFG_BUSY locking from AF_XDP code
      ice: do not bring the VSI up, if it was down before the XDP setup

Leo Li (1):
      drm/amd/display: Lock DC and exit IPS when changing backlight

Leon Hwang (1):
      bpf, verifier: Correct tail_call_reachable for bpf prog

Li Nan (1):
      ublk_drv: fix NULL pointer dereference in ublk_ctrl_start_recovery()

Liam R. Howlett (1):
      maple_tree: remove rcu_read_lock() from mt_validate()

Liao Chen (2):
      mmc: sdhci-of-aspeed: fix module autoloading
      gpio: modepin: Enable module autoloading

Lu Baolu (1):
      iommu/vt-d: Remove control over Execute-Requested requests

Luis Henriques (SUSE) (1):
      ext4: fix possible tid_t sequence overflows

Luiz Augusto von Dentz (4):
      Revert "Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE"
      Bluetooth: MGMT: Ignore keys being loaded with invalid type
      Bluetooth: hci_sync: Introduce hci_cmd_sync_run/hci_cmd_sync_run_once
      Bluetooth: MGMT: Fix not generating command complete for MGMT_OP_DISCONNECT

Ma Ke (2):
      irqchip/gic-v2m: Fix refcount leak in gicv2m_of_init()
      usb: gadget: aspeed_udc: validate endpoint index for ast udc

Marc Kleine-Budde (5):
      can: mcp251xfd: fix ring configuration when switching from CAN-CC to CAN-FD mode
      can: mcp251xfd: mcp251xfd_handle_rxif_ring_uinc(): factor out in separate function
      can: mcp251xfd: rx: prepare to workaround broken RX FIFO head index erratum
      can: mcp251xfd: clarify the meaning of timestamp
      can: mcp251xfd: rx: add workaround for erratum DS80000789E 6 of mcp2518fd

Marc Zyngier (1):
      scripts: fix gfp-translate after ___GFP_*_BITS conversion to an enum

Marcin Ślusarz (1):
      wifi: rtw88: usb: schedule rx work after everything is set up

Marek Marczykowski-Górecki (1):
      ALSA: hda/realtek: extend quirks for Clevo V5[46]0

Marek Olšák (3):
      drm/amdgpu: check for LINEAR_ALIGNED correctly in check_tiling_flags_gfx6
      drm/amdgpu/display: handle gfx12 in amdgpu_dm_plane_format_mod_supported
      drm/amdgpu: handle gfx12 in amdgpu_display_verify_sizes

Markus Schneider-Pargmann (6):
      can: m_can: Reset coalescing during suspend/resume
      can: m_can: Remove coalesing disable in isr during suspend
      can: m_can: Remove m_can_rx_peripheral indirection
      can: m_can: Do not cancel timer from within timer
      can: m_can: disable_all_interrupts, not clear active_interrupts
      can: m_can: Reset cached active_interrupts on start

Martin Jocic (5):
      can: kvaser_pciefd: Skip redundant NULL pointer check in ISR
      can: kvaser_pciefd: Remove unnecessary comment
      can: kvaser_pciefd: Rename board_irq to pci_irq
      can: kvaser_pciefd: Move reset of DMA RX buffers to the end of the ISR
      can: kvaser_pciefd: Use a single write when releasing RX buffers

Mary Guillemard (1):
      drm/panthor: Restrict high priorities on group_create

Masami Hiramatsu (Google) (1):
      tracing/kprobes: Add symbol counting check when module loads

Matt Coster (1):
      drm/imagination: Free pvr_vm_gpuva after unlink

Matt Johnston (1):
      net: mctp-serial: Fix missing escapes on transmit

Matteo Martelli (2):
      iio: fix scale application in iio_convert_raw_to_processed_unlocked
      ASoC: sunxi: sun4i-i2s: fix LRCLK polarity in i2s mode

Matthieu Baerts (NGI0) (1):
      tcp: process the 3rd ACK with sk_socket for TFO/MPTCP

Maurizio Lombardi (2):
      nvmet-tcp: fix kernel crash if commands allocation fails
      nvmet: Identify-Active Namespace ID List command should reject invalid nsid

Maxim Levitsky (1):
      KVM: SVM: fix emulation of msr reads/writes of MSR_FS_BASE and MSR_GS_BASE

Maximilien Perreault (1):
      ALSA: hda/realtek: Support mute LED on HP Laptop 14-dq2xxx

Michael Ellerman (3):
      ata: pata_macio: Use WARN instead of BUG
      powerpc/64e: remove unused IBM HTW code
      powerpc/64e: split out nohash Book3E 64-bit code

Michal Simek (1):
      dt-bindings: nvmem: Use soc-nvmem node name instead of nvmem

Mike Yuan (1):
      mm/memcontrol: respect zswap.writeback setting from parent cg too

Miklos Szeredi (1):
      fuse: clear PG_uptodate when using a stolen page

Mitchell Levy (1):
      x86/fpu: Avoid writing LBR bit to IA32_XSS unless supported

Mohan Kumar (1):
      ASoC: tegra: Fix CBB error during probe()

Mrinmay Sarkar (1):
      PCI: qcom: Override NO_SNOOP attribute for SA8775P RC

Muhammad Usama Anjum (1):
      selftests: mm: fix build errors on armhf

Naman Jain (1):
      Drivers: hv: vmbus: Fix rescind handling in uio_hv_generic

Namhyung Kim (1):
      perf lock contention: Fix spinlock and rwlock accounting

Namjae Jeon (1):
      ksmbd: unset the binding mark of a reused connection

Naohiro Aota (1):
      btrfs: zoned: handle broken write pointer on zones

Nathan Lynch (1):
      powerpc/rtas: Prevent Spectre v1 gadget construction in sys_rtas()

Neeraj Sanjay Kale (1):
      Bluetooth: btnxpuart: Fix Null pointer dereference in btnxpuart_flush()

Nicholas Piggin (2):
      workqueue: wq_watchdog_touch is always called with valid CPU
      workqueue: Improve scalability of workqueue watchdog touch

Nuno Sa (1):
      iio: adc: ad_sigma_delta: fix irq_flags on irq request

Nysal Jan K.A. (1):
      powerpc/qspinlock: Fix deadlock in MCS queue

Oliver Neukum (2):
      usbnet: modern method to get random MAC
      usbnet: ipheth: race between ipheth_close and error handling

Olivier Sobrie (1):
      HID: amd_sfh: free driver_data after destroying hid device

Pali Rohár (1):
      irqchip/armada-370-xp: Do not allow mapping IRQ 0 and 1

Paulo Alcantara (2):
      smb: client: fix double put of @cfile in smb2_set_path_size()
      smb: client: fix double put of @cfile in smb2_rename_path()

Pawel Dembicki (2):
      hwmon: ltc2991: fix register bits defines
      net: dsa: vsc73xx: fix possible subblocks range of CAPT block

Pawel Laszczak (1):
      usb: cdns2: Fix controller reset issue

Peiyang Wang (1):
      net: hns3: void array out of bound when loop tnl_num

Peter Zijlstra (1):
      perf/aux: Fix AUX buffer serialization

Petr Tesarik (1):
      kexec_file: fix elfcorehdr digest exclusion when CONFIG_CRASH_HOTPLUG=y

Phillip Lougher (1):
      Squashfs: sanity check symbolic link size

Prashanth K (1):
      usb: dwc3: Avoid waking up gadget during startxfer

Qu Wenruo (1):
      btrfs: slightly loosen the requirement for qgroup removal

Rakesh Ughreja (1):
      accel/habanalabs/gaudi2: unsecure edma max outstanding register

Ravi Bangoria (1):
      KVM: SVM: Don't advertise Bus Lock Detect to guest if SVM support is missing

Richard Fitzgerald (1):
      firmware: cs_dsp: Don't allow writes to read-only controls

Roger Quadros (3):
      net: ethernet: ti: am65-cpsw: Fix NULL dereference on XDP_TX
      net: ethernet: ti: am65-cpsw: fix XDP_DROP, XDP_TX and XDP_REDIRECT
      net: ethernet: ti: am65-cpsw: Fix RX statistics for XDP_TX and XDP_REDIRECT

Roland Xu (1):
      rtmutex: Drop rt_mutex::wait_lock before scheduling

Ryusuke Konishi (3):
      nilfs2: fix missing cleanup on rollforward recovery error
      nilfs2: protect references to superblock parameters exposed in sysfs
      nilfs2: fix state management in error path of log writing function

Sam Protsenko (1):
      mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K

Samuel Holland (3):
      riscv: misaligned: Restrict user access to kernel memory
      riscv: kprobes: Use patch_text_nosync() for insn slots
      riscv: Add tracepoints for SBI calls and returns

Sascha Hauer (2):
      wifi: mwifiex: Do not return unused priv in mwifiex_get_priv_by_id()
      watchdog: imx7ulp_wdt: keep already running watchdog enabled

Satya Priya Kakitapalli (2):
      clk: qcom: clk-alpha-pll: Fix the pll post div mask
      clk: qcom: clk-alpha-pll: Fix the trion pll postdiv set rate API

Saurabh Sengar (1):
      uio_hv_generic: Fix kernel NULL pointer dereference in hv_uio_rescind

Sean Anderson (2):
      net: xilinx: axienet: Fix race in axienet_stop
      phy: zynqmp: Take the phy mutex in xlate

Sean Christopherson (1):
      KVM: x86: Acquire kvm->srcu when handling KVM_SET_VCPU_EVENTS

Sebastian Andrzej Siewior (1):
      bpf: Remove tst_run from lwt_seg6local_prog_ops.

Seunghwan Baek (1):
      mmc: cqhci: Fix checking of CQHCI_HALT state

Shantanu Goel (1):
      usb: uas: set host status byte on data completion error

Shenghao Ding (1):
      ASoc: TAS2781: replace beXX_to_cpup with get_unaligned_beXX for potentially broken alignment

Shivaprasad G Bhat (1):
      vfio/spapr: Always clear TCEs before unsetting the window

Simon Arlott (1):
      can: mcp251x: fix deadlock if an interrupt occurs during mcp251x_open

Simon Horman (1):
      can: m_can: Release irq on error in m_can_open

Souradeep Chakrabarti (1):
      net: mana: Fix error handling in mana_create_txq/rxq's NAPI cleanup

Stefan Wahren (1):
      spi: spi-fsl-lpspi: Fix off-by-one in prescale max

Stefan Wiehler (1):
      of/irq: Prevent device address out-of-bounds read in interrupt map walk

Stephan Gerhold (1):
      pinctrl: qcom: x1e80100: Bypass PDC wakeup parent for now

Stephen Boyd (2):
      clk: qcom: gcc-sm8550: Don't use parking clk_ops for QUPs
      clk: qcom: gcc-sm8550: Don't park the USB RCG at registration time

Stephen Hemminger (1):
      sch/netem: fix use after free in netem_dequeue

Steven Rostedt (4):
      tracing/osnoise: Use a cpumask to know what threads are kthreads
      tracing/timerlat: Only clear timer if a kthread exists
      tracing/timerlat: Add interface_lock around clearing of kthread in stop_kthread()
      eventfs: Use list_del_rcu() for SRCU protected list variable

Sukrut Bellary (1):
      misc: fastrpc: Fix double free of 'buf' in error path

Suren Baghdasaryan (1):
      alloc_tag: fix allocation tag reporting when CONFIG_MODULES=n

Sven Schnelle (1):
      uprobes: Use kzalloc to allocate xol area

Takashi Iwai (2):
      ALSA: control: Apply sanity check of input values for user elements
      ALSA: hda: Add input value sanity checks to HDMI channel map controls

Terry Cheong (1):
      ALSA: hda/realtek: add patch for internal mic in Lenovo V145

Thomas Gleixner (2):
      x86/kaslr: Expose and use the end of the physical memory address space
      x86/mm: Fix PTI for i386 some more

Toke Høiland-Jørgensen (1):
      sched: sch_cake: fix bulk flow accounting logic for host fairness

Trond Myklebust (1):
      NFSv4: Add missing rescheduling points in nfs_client_return_marked_delegations

Tze-nan Wu (1):
      bpf, net: Fix a potential race in do_sock_getsockopt()

Umang Jain (1):
      staging: vchiq_core: Bubble up wait_event_interruptible() return value

Usama Arif (1):
      Revert "mm: skip CMA pages when they are not available"

Uwe Kleine-König (1):
      virt: sev-guest: Mark driver struct with __refdata to prevent section mismatch

Vadim Fedorenko (2):
      ptp: ocp: convert serial ports to array
      ptp: ocp: adjust sysfs entries to expose tty information

Vasiliy Kovalev (1):
      ALSA: hda/realtek - Fix inactive headset mic jack for ASUS Vivobook 15 X1504VAP

Viresh Kumar (1):
      xen: privcmd: Fix possible access to a freed kirqfd instance

Vladimir Oltean (1):
      net: dpaa: avoid on-stack arrays of NR_CPUS elements

Waiman Long (2):
      cgroup/cpuset: Delay setting of CS_CPU_EXCLUSIVE until valid partition
      cgroup: Protect css->cgroup write under css_set_lock

Weiwen Hu (3):
      nvme: rename nvme_sc_to_pr_err to nvme_status_to_pr_err
      nvme: fix status magic numbers
      nvme: rename CDR/MORE/DNR to NVME_STATUS_*

Will Deacon (1):
      mm: vmalloc: ensure vmap_block is initialised before adding to queue

Xingyu Wu (1):
      clk: starfive: jh7110-sys: Add notifier for PLL0 clock

Xuan Zhuo (1):
      virtio_ring: fix KMSAN error for premapped mode

Ye Bin (1):
      jbd2: avoid mount failed when commit block is partial submitted

YiPeng Chai (1):
      drm/amdgpu: add mutex to protect ras shared memory

Yicong Yang (1):
      dma-mapping: benchmark: Don't starve others when doing the test

Yifan Zha (1):
      drm/amdgpu: Set no_hw_access when VF request full GPU fails

Yoray Zack (1):
      net/mlx5e: SHAMPO, Use KSMs instead of KLMs

Yosry Ahmed (1):
      mm: zswap: rename is_zswap_enabled() to zswap_is_enabled()

Yunjian Wang (1):
      netfilter: nf_conncount: fix wrong variable type

Yuntao Wang (1):
      x86/apic: Make x2apic_disable() work correctly

Yunxiang Li (3):
      drm/amdgpu: Fix two reset triggered in a row
      drm/amdgpu: Add reset_context flag for host FLR
      drm/amdgpu: Fix amdgpu_device_reset_sriov retry logic

Zenghui Yu (1):
      kselftests: dmabuf-heaps: Ensure the driver name is null-terminated

Zheng Qixing (1):
      ata: libata: Fix memory leak for error path in ata_host_alloc()

Zheng Yejian (1):
      tracing: Avoid possible softlockup in tracing_iter_reset()

Zijun Hu (1):
      devres: Initialize an uninitialized struct member

Ziwei Xiao (1):
      gve: Add adminq mutex lock

Zqiang (1):
      smp: Add missing destroy_work_on_stack() call in smp_call_on_cpu()

devi priya (1):
      clk: qcom: ipq9574: Update the alpha PLL type for GPLLs

robelin (1):
      ASoC: dapm: Fix UAF for snd_soc_pcm_runtime object

yang.zhang (1):
      riscv: set trap vector earlier

yangyun (1):
      fuse: fix memory leak in fuse_create_open


