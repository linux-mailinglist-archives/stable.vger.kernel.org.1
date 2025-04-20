Return-Path: <stable+bounces-134740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5E3A94736
	for <lists+stable@lfdr.de>; Sun, 20 Apr 2025 10:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E2C3AF981
	for <lists+stable@lfdr.de>; Sun, 20 Apr 2025 08:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DEF203714;
	Sun, 20 Apr 2025 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="shyVbkBB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9653E203703;
	Sun, 20 Apr 2025 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745137970; cv=none; b=JbjtUJppLv6WMbqIicVcQTi9g/SseZfT+gDPAJ7EM+W4IK4FtCKgVaWQQ1nzC+PF9ZPtIyn5BJsz1nwinctpW0D83Ar70vHlDGa85yo3kctv4bzK57fxHQ7L7yZOuTI+Ik1Bm8oCuMOecK7CZzsLn1DrWIf2qnuSyUyDSv2D3VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745137970; c=relaxed/simple;
	bh=DCKRiCvUHnMmGaYFbgIyL1kILtQs1bkEzAS5EqNInzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lBikO2qiAOnomPQ7Wkl70J03XmjsGpaO5tope1OYAQUoiv+VYFkoLYN2fzkkAelfPzyP/xMcyTABZkpKdSfZ6vvgMBZ5sKImfzPI43GuWToCOtn45MZYQJSxCFGnTxXOmBYxpZr+1DVPpK5Q6UdhBTLdQvPXCQ2GW0PZ/qx9gZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=shyVbkBB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0D1C4CEE9;
	Sun, 20 Apr 2025 08:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745137970;
	bh=DCKRiCvUHnMmGaYFbgIyL1kILtQs1bkEzAS5EqNInzc=;
	h=From:To:Cc:Subject:Date:From;
	b=shyVbkBBTYgOIVCEDsqGPXxi6C+m5ejgwWfwGDvChIJA01x5sBY0PKmzoNysT7aMh
	 MrssU5fySaDpuatI5yJ1Q/Rjh92N9M+MRJZLh2i3ByfTUgvn4MeO0HGDQ4xxGvf1CD
	 kkHPZN1Rhzi34ggLqKh8EnIG2Qnk28SFRFNgV6wM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.14.3
Date: Sun, 20 Apr 2025 10:32:38 +0200
Message-ID: <2025042038-propose-pacifist-e2ce@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.14.3 kernel.

All users of the 6.14 kernel series must upgrade.

The updated 6.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.14.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt                                      |    2 
 Documentation/arch/arm64/silicon-errata.rst                                          |    2 
 Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml                       |    3 
 Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml                       |    3 
 Documentation/devicetree/bindings/media/i2c/st,st-mipid02.yaml                       |    2 
 Makefile                                                                             |    5 
 arch/arm/lib/crc-t10dif-glue.c                                                       |    4 
 arch/arm64/Kconfig                                                                   |    9 
 arch/arm64/boot/dts/exynos/google/gs101.dtsi                                         |    1 
 arch/arm64/boot/dts/mediatek/mt8173.dtsi                                             |    6 
 arch/arm64/boot/dts/mediatek/mt8188.dtsi                                             |    2 
 arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767.dtsi                            |    7 
 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi                             |    6 
 arch/arm64/include/asm/cputype.h                                                     |    4 
 arch/arm64/include/asm/kvm_arm.h                                                     |    4 
 arch/arm64/include/asm/spectre.h                                                     |    1 
 arch/arm64/include/asm/traps.h                                                       |    4 
 arch/arm64/kernel/proton-pack.c                                                      |  218 ++-
 arch/arm64/kvm/arm.c                                                                 |    6 
 arch/arm64/kvm/sys_regs.c                                                            |  204 +--
 arch/arm64/lib/crc-t10dif-glue.c                                                     |    4 
 arch/arm64/mm/mmu.c                                                                  |    3 
 arch/powerpc/kvm/powerpc.c                                                           |    5 
 arch/s390/Makefile                                                                   |    2 
 arch/s390/kernel/perf_cpum_cf.c                                                      |    9 
 arch/s390/kernel/perf_cpum_sf.c                                                      |    3 
 arch/s390/pci/pci_bus.c                                                              |    3 
 arch/s390/pci/pci_mmio.c                                                             |   18 
 arch/sparc/include/asm/pgtable_64.h                                                  |    2 
 arch/sparc/mm/tlb.c                                                                  |    5 
 arch/x86/Kbuild                                                                      |    4 
 arch/x86/Kconfig                                                                     |   20 
 arch/x86/coco/sev/core.c                                                             |    2 
 arch/x86/kernel/acpi/boot.c                                                          |   11 
 arch/x86/kernel/cpu/amd.c                                                            |    3 
 arch/x86/kernel/e820.c                                                               |   17 
 arch/x86/kernel/head64.c                                                             |    2 
 arch/x86/kernel/signal_32.c                                                          |   62 -
 arch/x86/kvm/cpuid.c                                                                 |    8 
 arch/x86/kvm/x86.c                                                                   |    4 
 arch/x86/mm/kasan_init_64.c                                                          |    1 
 arch/x86/mm/mem_encrypt_amd.c                                                        |    2 
 arch/x86/mm/mem_encrypt_identity.c                                                   |    2 
 arch/x86/mm/pat/set_memory.c                                                         |    6 
 arch/x86/xen/enlighten.c                                                             |   10 
 arch/x86/xen/setup.c                                                                 |    3 
 block/blk-mq.c                                                                       |    1 
 drivers/accel/ivpu/ivpu_debugfs.c                                                    |    4 
 drivers/accel/ivpu/ivpu_ipc.c                                                        |    3 
 drivers/accel/ivpu/ivpu_ms.c                                                         |   24 
 drivers/acpi/Makefile                                                                |    4 
 drivers/ata/ahci.c                                                                   |   11 
 drivers/ata/ahci.h                                                                   |    1 
 drivers/ata/libahci.c                                                                |    4 
 drivers/ata/libata-core.c                                                            |   38 
 drivers/ata/libata-eh.c                                                              |   11 
 drivers/ata/pata_pxa.c                                                               |    6 
 drivers/ata/sata_sx4.c                                                               |   13 
 drivers/auxdisplay/hd44780.c                                                         |    4 
 drivers/base/devres.c                                                                |    7 
 drivers/block/ublk_drv.c                                                             |   30 
 drivers/bluetooth/btintel_pcie.c                                                     |    1 
 drivers/bluetooth/btqca.c                                                            |   27 
 drivers/bluetooth/btqca.h                                                            |    4 
 drivers/bluetooth/btusb.c                                                            |   32 
 drivers/bluetooth/hci_ldisc.c                                                        |   19 
 drivers/bluetooth/hci_qca.c                                                          |   27 
 drivers/bluetooth/hci_uart.h                                                         |    1 
 drivers/bus/mhi/host/main.c                                                          |   16 
 drivers/char/tpm/tpm-chip.c                                                          |    6 
 drivers/char/tpm/tpm-interface.c                                                     |    7 
 drivers/char/tpm/tpm_tis_core.c                                                      |   20 
 drivers/char/tpm/tpm_tis_core.h                                                      |    1 
 drivers/clk/qcom/clk-branch.c                                                        |    4 
 drivers/clk/qcom/gdsc.c                                                              |   61 -
 drivers/clk/renesas/r9a07g043-cpg.c                                                  |    7 
 drivers/clocksource/timer-stm32-lp.c                                                 |    4 
 drivers/cpufreq/amd-pstate.c                                                         |    5 
 drivers/cpuidle/Makefile                                                             |    3 
 drivers/crypto/ccp/sp-pci.c                                                          |   15 
 drivers/firmware/cirrus/test/cs_dsp_test_control_parse.c                             |   51 
 drivers/gpio/gpio-mpc8xxx.c                                                          |    4 
 drivers/gpio/gpio-tegra186.c                                                         |   27 
 drivers/gpio/gpio-zynq.c                                                             |    1 
 drivers/gpio/gpiolib-of.c                                                            |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                           |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                                               |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h                                               |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c                                            |   43 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                                             |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_device.c                                              |    5 
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                                             |   17 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c                               |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                                                 |   31 
 drivers/gpu/drm/amd/display/dc/core/dc.c                                             |    8 
 drivers/gpu/drm/amd/display/dc/dc.h                                                  |    2 
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h                                         |    8 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c       |    2 
 drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c                          |   26 
 drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c                               |    2 
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c                              |   22 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c                   |   12 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c                     |    2 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c |    3 
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c                                     |    5 
 drivers/gpu/drm/drm_atomic_helper.c                                                  |    2 
 drivers/gpu/drm/drm_debugfs.c                                                        |    2 
 drivers/gpu/drm/drm_panel.c                                                          |    5 
 drivers/gpu/drm/drm_panel_orientation_quirks.c                                       |   46 
 drivers/gpu/drm/i915/gt/intel_rc6.c                                                  |   19 
 drivers/gpu/drm/i915/gt/uc/intel_huc.c                                               |   11 
 drivers/gpu/drm/i915/gt/uc/intel_huc.h                                               |    1 
 drivers/gpu/drm/i915/gt/uc/intel_uc.c                                                |    1 
 drivers/gpu/drm/i915/selftests/i915_selftest.c                                       |   18 
 drivers/gpu/drm/mediatek/mtk_dpi.c                                                   |   23 
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c                                          |   16 
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c                                       |   29 
 drivers/gpu/drm/tests/drm_client_modeset_test.c                                      |    3 
 drivers/gpu/drm/tests/drm_cmdline_parser_test.c                                      |   10 
 drivers/gpu/drm/tests/drm_kunit_helpers.c                                            |   22 
 drivers/gpu/drm/tests/drm_modes_test.c                                               |   22 
 drivers/gpu/drm/tests/drm_probe_helper_test.c                                        |    8 
 drivers/gpu/drm/virtio/virtgpu_prime.c                                               |    2 
 drivers/gpu/drm/virtio/virtgpu_vq.c                                                  |    3 
 drivers/gpu/drm/xe/xe_gt.c                                                           |    4 
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c                                           |    4 
 drivers/gpu/drm/xe/xe_gt_sriov_vf.c                                                  |   16 
 drivers/gpu/drm/xe/xe_gt_sriov_vf.h                                                  |    1 
 drivers/gpu/drm/xe/xe_guc_pc.c                                                       |    1 
 drivers/gpu/drm/xe/xe_hw_engine_class_sysfs.c                                        |  108 -
 drivers/gpu/drm/xe/xe_tuning.c                                                       |    8 
 drivers/gpu/drm/xe/xe_wa.c                                                           |    7 
 drivers/hid/Kconfig                                                                  |   14 
 drivers/hid/Makefile                                                                 |    1 
 drivers/hid/hid-ids.h                                                                |   37 
 drivers/hid/hid-lenovo.c                                                             |    2 
 drivers/hid/hid-universal-pidff.c                                                    |  202 +++
 drivers/hid/usbhid/hid-core.c                                                        |    1 
 drivers/hid/usbhid/hid-pidff.c                                                       |  569 ++++++----
 drivers/hid/usbhid/hid-pidff.h                                                       |   33 
 drivers/hsi/clients/ssi_protocol.c                                                   |    1 
 drivers/i3c/master.c                                                                 |    3 
 drivers/i3c/master/svc-i3c-master.c                                                  |    2 
 drivers/idle/Makefile                                                                |    5 
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c                                       |   32 
 drivers/iommu/exynos-iommu.c                                                         |    4 
 drivers/iommu/intel/iommu.c                                                          |    2 
 drivers/iommu/intel/irq_remapping.c                                                  |   71 -
 drivers/iommu/iommufd/device.c                                                       |  123 ++
 drivers/iommu/iommufd/fault.c                                                        |    8 
 drivers/iommu/iommufd/iommufd_private.h                                              |   33 
 drivers/iommu/mtk_iommu.c                                                            |   26 
 drivers/irqchip/irq-gic-v3-its.c                                                     |   23 
 drivers/irqchip/irq-renesas-rzv2h.c                                                  |    2 
 drivers/leds/rgb/leds-qcom-lpg.c                                                     |    8 
 drivers/mailbox/tegra-hsp.c                                                          |   72 +
 drivers/md/dm-ebs-target.c                                                           |    7 
 drivers/md/dm-integrity.c                                                            |   48 
 drivers/md/dm-verity-target.c                                                        |    8 
 drivers/media/common/siano/smsdvb-main.c                                             |    2 
 drivers/media/i2c/adv748x/adv748x.h                                                  |    2 
 drivers/media/i2c/ccs/ccs-core.c                                                     |    6 
 drivers/media/i2c/hi556.c                                                            |    5 
 drivers/media/i2c/imx214.c                                                           |   25 
 drivers/media/i2c/imx219.c                                                           |  106 +
 drivers/media/i2c/imx319.c                                                           |    9 
 drivers/media/i2c/ov08x40.c                                                          |    8 
 drivers/media/i2c/ov7251.c                                                           |    4 
 drivers/media/pci/intel/ipu6/ipu6-isys-video.c                                       |    1 
 drivers/media/pci/mgb4/mgb4_cmt.c                                                    |    8 
 drivers/media/platform/chips-media/wave5/wave5-hw.c                                  |    2 
 drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c                             |   31 
 drivers/media/platform/chips-media/wave5/wave5-vpu.c                                 |    4 
 drivers/media/platform/chips-media/wave5/wave5-vpuapi.c                              |   10 
 drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c                    |    5 
 drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c                   |    6 
 drivers/media/platform/nuvoton/npcm-video.c                                          |    6 
 drivers/media/platform/qcom/venus/hfi_parser.c                                       |  100 +
 drivers/media/platform/qcom/venus/hfi_venus.c                                        |   18 
 drivers/media/platform/rockchip/rga/rga-hw.c                                         |    2 
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c                              |    5 
 drivers/media/platform/st/stm32/dma2d/dma2d.c                                        |    3 
 drivers/media/platform/xilinx/xilinx-tpg.c                                           |    2 
 drivers/media/rc/streamzap.c                                                         |   68 -
 drivers/media/test-drivers/vim2m.c                                                   |    6 
 drivers/media/test-drivers/visl/visl-core.c                                          |   12 
 drivers/media/usb/uvc/uvc_driver.c                                                   |    9 
 drivers/media/v4l2-core/v4l2-dv-timings.c                                            |    4 
 drivers/mfd/ene-kb3930.c                                                             |    2 
 drivers/misc/pci_endpoint_test.c                                                     |    7 
 drivers/mmc/host/dw_mmc.c                                                            |   94 +
 drivers/mmc/host/dw_mmc.h                                                            |   27 
 drivers/mtd/inftlcore.c                                                              |    9 
 drivers/mtd/mtdpstore.c                                                              |   12 
 drivers/mtd/nand/raw/brcmnand/brcmnand.c                                             |    2 
 drivers/mtd/nand/raw/r852.c                                                          |    3 
 drivers/net/can/flexcan/flexcan-core.c                                               |   35 
 drivers/net/can/flexcan/flexcan.h                                                    |    5 
 drivers/net/dsa/mv88e6xxx/chip.c                                                     |   23 
 drivers/net/ethernet/google/gve/gve_ethtool.c                                        |    4 
 drivers/net/ethernet/google/gve/gve_rx_dqo.c                                         |    3 
 drivers/net/ethernet/intel/igc/igc.h                                                 |    2 
 drivers/net/ethernet/intel/igc/igc_main.c                                            |    4 
 drivers/net/ethernet/intel/igc/igc_xdp.c                                             |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c                                     |    5 
 drivers/net/ethernet/microsoft/mana/mana_en.c                                        |   46 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                                    |   11 
 drivers/net/ethernet/wangxun/libwx/wx_lib.c                                          |    6 
 drivers/net/ethernet/wangxun/libwx/wx_type.h                                         |    3 
 drivers/net/phy/phy_device.c                                                         |   57 -
 drivers/net/phy/sfp.c                                                                |   13 
 drivers/net/ppp/ppp_synctty.c                                                        |    5 
 drivers/net/usb/asix_devices.c                                                       |   17 
 drivers/net/usb/cdc_ether.c                                                          |    7 
 drivers/net/usb/r8152.c                                                              |    6 
 drivers/net/usb/r8153_ecm.c                                                          |    6 
 drivers/net/wireless/ath/ath11k/ahb.c                                                |    4 
 drivers/net/wireless/ath/ath11k/core.c                                               |    4 
 drivers/net/wireless/ath/ath11k/core.h                                               |    5 
 drivers/net/wireless/ath/ath11k/dp.c                                                 |   35 
 drivers/net/wireless/ath/ath11k/fw.c                                                 |    3 
 drivers/net/wireless/ath/ath11k/mac.c                                                |   14 
 drivers/net/wireless/ath/ath11k/pci.c                                                |    3 
 drivers/net/wireless/ath/ath11k/reg.c                                                |   85 +
 drivers/net/wireless/ath/ath11k/reg.h                                                |    3 
 drivers/net/wireless/ath/ath11k/wmi.h                                                |    1 
 drivers/net/wireless/ath/ath12k/dp_mon.c                                             |   66 -
 drivers/net/wireless/ath/ath12k/dp_rx.c                                              |   42 
 drivers/net/wireless/ath/ath12k/hal_rx.h                                             |    3 
 drivers/net/wireless/ath/ath12k/pci.c                                                |    2 
 drivers/net/wireless/ath/ath9k/ath9k.h                                               |    2 
 drivers/net/wireless/mediatek/mt76/eeprom.c                                          |    4 
 drivers/net/wireless/mediatek/mt76/mt76.h                                            |    1 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c                                 |    4 
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c                                      |    1 
 drivers/net/wireless/mediatek/mt76/mt7925/init.c                                     |    1 
 drivers/net/wireless/mediatek/mt76/mt7925/main.c                                     |  160 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c                                      |  170 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h                                      |    6 
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h                                   |    3 
 drivers/net/wireless/mediatek/mt76/mt792x.h                                          |    9 
 drivers/net/wireless/mediatek/mt76/mt792x_core.c                                     |    3 
 drivers/net/wireless/realtek/rtw88/rtw8822bu.c                                       |    4 
 drivers/ntb/ntb_transport.c                                                          |    2 
 drivers/nvme/target/fcloop.c                                                         |    2 
 drivers/of/irq.c                                                                     |   80 -
 drivers/pci/controller/cadence/pci-j721e.c                                           |    5 
 drivers/pci/controller/dwc/pci-layerscape.c                                          |    2 
 drivers/pci/controller/pcie-brcmstb.c                                                |   13 
 drivers/pci/controller/pcie-rockchip-host.c                                          |    2 
 drivers/pci/controller/pcie-rockchip.h                                               |    1 
 drivers/pci/controller/vmd.c                                                         |   12 
 drivers/pci/devres.c                                                                 |   18 
 drivers/pci/hotplug/pciehp_core.c                                                    |    5 
 drivers/pci/iomap.c                                                                  |   29 
 drivers/pci/pci.c                                                                    |    6 
 drivers/pci/pci.h                                                                    |   16 
 drivers/pci/probe.c                                                                  |   22 
 drivers/perf/arm_pmu.c                                                               |    8 
 drivers/perf/dwc_pcie_pmu.c                                                          |   51 
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c                                           |   11 
 drivers/pinctrl/qcom/pinctrl-msm.c                                                   |   12 
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c                                       |   98 -
 drivers/pinctrl/samsung/pinctrl-exynos.h                                             |   22 
 drivers/pinctrl/samsung/pinctrl-samsung.c                                            |    1 
 drivers/pinctrl/samsung/pinctrl-samsung.h                                            |    4 
 drivers/platform/chrome/cros_ec_lpc.c                                                |   22 
 drivers/platform/x86/x86-android-tablets/Kconfig                                     |    1 
 drivers/pwm/pwm-fsl-ftm.c                                                            |    6 
 drivers/pwm/pwm-mediatek.c                                                           |    8 
 drivers/pwm/pwm-rcar.c                                                               |   24 
 drivers/pwm/pwm-stm32.c                                                              |   12 
 drivers/s390/virtio/virtio_ccw.c                                                     |   16 
 drivers/scsi/lpfc/lpfc_sli.c                                                         |    2 
 drivers/scsi/mpi3mr/mpi3mr.h                                                         |   14 
 drivers/scsi/mpi3mr/mpi3mr_app.c                                                     |   24 
 drivers/scsi/mpi3mr/mpi3mr_fw.c                                                      |   99 +
 drivers/scsi/st.c                                                                    |    2 
 drivers/soc/samsung/exynos-chipid.c                                                  |    2 
 drivers/spi/spi-cadence-quadspi.c                                                    |    6 
 drivers/spi/spi-fsl-qspi.c                                                           |   36 
 drivers/target/target_core_spc.c                                                     |    2 
 drivers/thermal/mediatek/lvts_thermal.c                                              |   52 
 drivers/thermal/rockchip_thermal.c                                                   |    1 
 drivers/vdpa/mlx5/core/mr.c                                                          |    7 
 drivers/video/backlight/led_bl.c                                                     |    5 
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c                                         |    6 
 drivers/xen/balloon.c                                                                |   34 
 drivers/xen/xenfs/xensyms.c                                                          |    4 
 fs/btrfs/disk-io.c                                                                   |   12 
 fs/btrfs/extent-tree.c                                                               |    8 
 fs/btrfs/tests/extent-map-tests.c                                                    |    1 
 fs/btrfs/transaction.c                                                               |   12 
 fs/btrfs/zoned.c                                                                     |    6 
 fs/dlm/lock.c                                                                        |    2 
 fs/erofs/fileio.c                                                                    |    2 
 fs/ext4/inode.c                                                                      |   68 -
 fs/ext4/namei.c                                                                      |    2 
 fs/ext4/super.c                                                                      |   17 
 fs/ext4/xattr.c                                                                      |   11 
 fs/f2fs/checkpoint.c                                                                 |   21 
 fs/f2fs/f2fs.h                                                                       |   32 
 fs/f2fs/inode.c                                                                      |    8 
 fs/f2fs/node.c                                                                       |  110 -
 fs/f2fs/super.c                                                                      |    8 
 fs/file.c                                                                            |   26 
 fs/fuse/dev.c                                                                        |   34 
 fs/fuse/dev_uring.c                                                                  |   15 
 fs/fuse/dev_uring_i.h                                                                |    6 
 fs/fuse/fuse_dev_i.h                                                                 |    1 
 fs/fuse/fuse_i.h                                                                     |    3 
 fs/jbd2/journal.c                                                                    |    1 
 fs/jfs/jfs_dmap.c                                                                    |   10 
 fs/jfs/jfs_imap.c                                                                    |    4 
 fs/namespace.c                                                                       |    3 
 fs/smb/client/cifsencrypt.c                                                          |   16 
 fs/smb/client/connect.c                                                              |    3 
 fs/smb/client/fs_context.c                                                           |    5 
 fs/smb/client/inode.c                                                                |   10 
 fs/smb/client/reparse.c                                                              |   29 
 fs/smb/client/sess.c                                                                 |    7 
 fs/smb/client/smb2misc.c                                                             |    9 
 fs/smb/client/smb2ops.c                                                              |    6 
 fs/smb/client/smb2pdu.c                                                              |   11 
 fs/smb/common/smb2pdu.h                                                              |    6 
 fs/udf/inode.c                                                                       |    1 
 fs/userfaultfd.c                                                                     |   51 
 include/drm/drm_kunit_helpers.h                                                      |    3 
 include/drm/intel/pciids.h                                                           |   11 
 include/linux/cgroup-defs.h                                                          |    1 
 include/linux/cgroup.h                                                               |    2 
 include/linux/damon.h                                                                |   11 
 include/linux/hid.h                                                                  |    6 
 include/linux/io_uring_types.h                                                       |    3 
 include/linux/kvm_host.h                                                             |    2 
 include/linux/mtd/spinand.h                                                          |    2 
 include/linux/page-flags.h                                                           |    6 
 include/linux/pci_ids.h                                                              |    2 
 include/linux/perf_event.h                                                           |   17 
 include/linux/pgtable.h                                                              |   14 
 include/linux/printk.h                                                               |    6 
 include/linux/tpm.h                                                                  |    1 
 include/net/mac80211.h                                                               |    6 
 include/net/sctp/structs.h                                                           |    3 
 include/net/sock.h                                                                   |   40 
 include/uapi/linux/kfd_ioctl.h                                                       |    2 
 include/uapi/linux/landlock.h                                                        |    2 
 include/uapi/linux/psp-sev.h                                                         |   21 
 include/uapi/linux/rkisp1-config.h                                                   |    2 
 include/xen/interface/xen-mca.h                                                      |    2 
 io_uring/io_uring.c                                                                  |    4 
 io_uring/kbuf.c                                                                      |    2 
 io_uring/net.c                                                                       |    3 
 kernel/Makefile                                                                      |    5 
 kernel/cgroup/cgroup.c                                                               |    6 
 kernel/cgroup/cpuset.c                                                               |   55 
 kernel/entry/Makefile                                                                |    3 
 kernel/events/core.c                                                                 |  184 +--
 kernel/events/uprobes.c                                                              |   15 
 kernel/locking/lockdep.c                                                             |    3 
 kernel/power/hibernate.c                                                             |    6 
 kernel/printk/printk.c                                                               |    4 
 kernel/rcu/srcutree.c                                                                |   11 
 kernel/reboot.c                                                                      |    1 
 kernel/sched/Makefile                                                                |    5 
 kernel/sched/ext.c                                                                   |    4 
 kernel/time/Makefile                                                                 |    6 
 kernel/trace/fprobe.c                                                                |  170 ++
 kernel/trace/ftrace.c                                                                |    9 
 kernel/trace/ring_buffer.c                                                           |    5 
 kernel/trace/trace_eprobe.c                                                          |    2 
 kernel/trace/trace_events.c                                                          |    4 
 kernel/trace/trace_events_synth.c                                                    |    1 
 kernel/trace/trace_fprobe.c                                                          |   31 
 kernel/trace/trace_kprobe.c                                                          |    5 
 kernel/trace/trace_probe.c                                                           |   28 
 kernel/trace/trace_probe.h                                                           |    1 
 kernel/trace/trace_uprobe.c                                                          |    9 
 lib/Makefile                                                                         |    5 
 lib/sg_split.c                                                                       |    2 
 lib/zstd/common/portability_macros.h                                                 |    2 
 mm/damon/core.c                                                                      |    1 
 mm/damon/ops-common.c                                                                |    2 
 mm/damon/paddr.c                                                                     |   57 -
 mm/hugetlb.c                                                                         |    2 
 mm/memory-failure.c                                                                  |   11 
 mm/memory_hotplug.c                                                                  |    3 
 mm/mremap.c                                                                          |   10 
 mm/page_vma_mapped.c                                                                 |   13 
 mm/rmap.c                                                                            |    2 
 mm/shmem.c                                                                           |    3 
 mm/vmscan.c                                                                          |    2 
 net/8021q/vlan_dev.c                                                                 |   31 
 net/core/filter.c                                                                    |   80 -
 net/core/page_pool.c                                                                 |    8 
 net/core/page_pool_user.c                                                            |    2 
 net/core/sock.c                                                                      |    5 
 net/ethtool/cmis.h                                                                   |    1 
 net/ethtool/cmis_cdb.c                                                               |   18 
 net/ethtool/common.c                                                                 |    1 
 net/ethtool/netlink.c                                                                |    8 
 net/ipv6/route.c                                                                     |    8 
 net/mac80211/debugfs.c                                                               |   44 
 net/mac80211/iface.c                                                                 |    5 
 net/mac80211/mesh_hwmp.c                                                             |   14 
 net/mac80211/mlme.c                                                                  |   59 -
 net/mptcp/sockopt.c                                                                  |   28 
 net/mptcp/subflow.c                                                                  |   19 
 net/netfilter/nft_set_pipapo_avx2.c                                                  |    3 
 net/sched/cls_api.c                                                                  |   66 -
 net/sched/sch_codel.c                                                                |    5 
 net/sched/sch_fq_codel.c                                                             |    6 
 net/sched/sch_sfq.c                                                                  |   66 -
 net/sctp/socket.c                                                                    |   22 
 net/sctp/transport.c                                                                 |    2 
 net/sunrpc/xprtrdma/svc_rdma_transport.c                                             |    3 
 net/tipc/link.c                                                                      |    1 
 net/tls/tls_main.c                                                                   |    6 
 scripts/generate_builtin_ranges.awk                                                  |    5 
 security/integrity/ima/ima.h                                                         |    3 
 security/integrity/ima/ima_main.c                                                    |   18 
 security/landlock/errata.h                                                           |   99 +
 security/landlock/errata/abi-4.h                                                     |   15 
 security/landlock/errata/abi-6.h                                                     |   19 
 security/landlock/fs.c                                                               |   39 
 security/landlock/setup.c                                                            |   38 
 security/landlock/setup.h                                                            |    3 
 security/landlock/syscalls.c                                                         |   22 
 security/landlock/task.c                                                             |   12 
 sound/pci/hda/hda_intel.c                                                            |   44 
 sound/pci/hda/patch_realtek.c                                                        |   41 
 sound/soc/amd/acp/acp-sdw-legacy-mach.c                                              |   34 
 sound/soc/amd/acp/soc_amd_sdw_common.h                                               |    1 
 sound/soc/amd/ps/acp63.h                                                             |    1 
 sound/soc/amd/ps/pci-ps.c                                                            |    2 
 sound/soc/amd/yc/acp6x-mach.c                                                        |   14 
 sound/soc/codecs/wcd937x.c                                                           |    2 
 sound/soc/fsl/fsl_audmix.c                                                           |   16 
 sound/soc/intel/common/soc-acpi-intel-adl-match.c                                    |   29 
 sound/soc/qcom/qdsp6/q6apm-dai.c                                                     |   60 -
 sound/soc/qcom/qdsp6/q6apm.c                                                         |   18 
 sound/soc/qcom/qdsp6/q6apm.h                                                         |    3 
 sound/soc/qcom/qdsp6/q6asm-dai.c                                                     |   19 
 sound/soc/sof/topology.c                                                             |    4 
 sound/usb/midi.c                                                                     |   80 +
 tools/objtool/check.c                                                                |    5 
 tools/power/cpupower/bench/parse.c                                                   |    4 
 tools/testing/ktest/ktest.pl                                                         |    8 
 tools/testing/selftests/futex/functional/futex_wait_wouldblock.c                     |    2 
 tools/testing/selftests/landlock/base_test.c                                         |   46 
 tools/testing/selftests/landlock/common.h                                            |    1 
 tools/testing/selftests/landlock/scoped_signal_test.c                                |  108 +
 tools/testing/selftests/net/mptcp/mptcp_connect.c                                    |   11 
 virt/kvm/Kconfig                                                                     |    2 
 virt/kvm/eventfd.c                                                                   |   10 
 455 files changed, 5761 insertions(+), 2514 deletions(-)

Aakarsh Jain (1):
      media: s5p-mfc: Corrected NV12M/NV21M plane-sizes

Abel Vesa (2):
      leds: rgb: leds-qcom-lpg: Fix pwm resolution max for Hi-Res PWMs
      leds: rgb: leds-qcom-lpg: Fix calculation of best period Hi-Res PWMs

Abhinav Kumar (1):
      drm: allow encoder mode_set even when connectors change for crtc

Ajit Pandey (1):
      clk: qcom: clk-branch: Fix invert halt status bit check for votable clocks

Akihiko Odaki (1):
      KVM: arm64: PMU: Set raw values from user to PM{C,I}NTEN{SET,CLR}, PMOVS{SET,CLR}

Alain Volmat (1):
      dt-bindings: media: st,stmipid02: correct lane-polarities maxItems

Alexander Aring (2):
      dlm: fix error if inactive rsb is not hashed
      dlm: fix error if active rsb is not hashed

Alexandra Diupina (1):
      cifs: avoid NULL pointer dereference in dbg call

Alexandre Torgue (1):
      clocksource/drivers/stm32-lptimer: Use wakeup capable instead of init wakeup

Alexey Klimov (1):
      ASoC: qdsp6: q6asm-dai: fix q6asm_dai_compr_set_params error path

Aman (1):
      CIFS: Propagate min offload along with other parameters from primary to secondary channels.

Amit Machhiwal (1):
      KVM: PPC: Enable CAP_SPAPR_TCE_VFIO on pSeries KVM guests

Andrew Wyatt (5):
      drm: panel-orientation-quirks: Add support for AYANEO 2S
      drm: panel-orientation-quirks: Add quirks for AYA NEO Flip DS and KB
      drm: panel-orientation-quirks: Add quirk for AYA NEO Slide
      drm: panel-orientation-quirks: Add new quirk for GPD Win 2
      drm: panel-orientation-quirks: Add quirk for OneXPlayer Mini (Intel)

Andrii Nakryiko (1):
      uprobes: Avoid false-positive lockdep splat on CONFIG_PREEMPT_RT=y in the ri_timer() uprobe timer callback, use raw_write_seqcount_*()

Andy Chiu (1):
      ftrace: Properly merge notrace hashes

Andy Shevchenko (1):
      gpiolib: of: Fix the choice for Ingenic NAND quirk

AngeloGioacchino Del Regno (2):
      drm/mediatek: mtk_dpi: Move the input_2p_en bit to platform data
      drm/mediatek: mtk_dpi: Explicitly manage TVD clock in power on/off

Arnaud Lecomte (1):
      net: ppp: Add bound checking for skb data on ppp_sync_txmung

Arnd Bergmann (1):
      media: mtk-vcodec: venc: avoid -Wenum-compare-conditional warning

Arseniy Krasnov (2):
      Bluetooth: hci_uart: fix race during initialization
      Bluetooth: hci_uart: Fix another race during initialization

Artem Sadovnikov (1):
      ext4: fix off-by-one error in do_split

Ayush Jain (1):
      ktest: Fix Test Failures Due to Missing LOG_FILE Directories

Badal Nilawar (1):
      drm/i915: Disable RPG during live selftest

Bard Liao (1):
      ASoC: Intel: adl: add 2xrt1316 audio configuration

Bernd Schubert (1):
      fuse: {io-uring} Fix a possible req cancellation race

Bhupesh (1):
      ext4: ignore xattrs past end

Biju Das (1):
      irqchip/renesas-rzv2h: Fix wrong variable usage in rzv2h_tint_set_type()

Bingbu Cao (1):
      media: intel/ipu6: set the dev_parent of video device to pdev

Birger Koblitz (1):
      net: sfp: add quirk for 2.5G OEM BX SFP

Bjorn Helgaas (1):
      PCI: Enable Configuration RRS SV early

Boqun Feng (1):
      locking/lockdep: Decrease nr_unused_locks if lock unused in zap_class()

Boris Burkov (1):
      btrfs: harden block_group::bg_list against list_del() races

Brendan Tam (1):
      drm/amd/display: add workaround flag to link to force FFE preset

Bryan O'Donoghue (2):
      clk: qcom: gdsc: Release pm subdomains in reverse add order
      clk: qcom: gdsc: Capture pm_genpd_add_subdomain result code

Chao Yu (3):
      f2fs: don't retry IO for corrupted data scenario
      f2fs: fix to avoid out-of-bounds access in f2fs_truncate_inode_blocks()
      Revert "f2fs: rebuild nat_bits during umount"

Chaohai Chen (1):
      scsi: target: spc: Fix RSOC parameter data header size

Chen-Yu Tsai (1):
      arm64: dts: mediatek: mt8173: Fix disp-pwm compatible string

Chenyuan Yang (3):
      net: libwx: handle page_pool_dev_alloc_pages error
      soc: samsung: exynos-chipid: Add NULL pointer check in exynos_chipid_probe()
      mfd: ene-kb3930: Fix a potential NULL pointer dereference

Chris Chiu (2):
      ALSA: hda/realtek: fix micmute LEDs on HP Laptops with ALC3315
      ALSA: hda/realtek: fix micmute LEDs on HP Laptops with ALC3247

Christian König (1):
      drm/amdgpu: grab an additional reference on the gang fence v2

Ciprian Marian Costea (2):
      can: flexcan: Add quirk to handle separate interrupt lines for mailboxes
      can: flexcan: add NXP S32G2/S32G3 SoC support

Cong Liu (1):
      selftests: mptcp: fix incorrect fd checks in main_loop

Cong Wang (1):
      codel: remove sch->q.qlen check before qdisc_tree_reduce_backlog()

Dan Carpenter (1):
      media: xilinx-tpg: fix double put in xtpg_parse_of()

Daniel Kral (1):
      ahci: add PCI ID for Marvell 88SE9215 SATA Controller

Daniel Schaefer (1):
      platform/chrome: cros_ec_lpc: Match on Framework ACPI device

Daniel Wagner (1):
      nvmet-fcloop: swap list_add_tail arguments

Dave Hansen (1):
      x86/cpu: Avoid running off the end of an AMD erratum table

Dave Stevenson (1):
      media: imx219: Adjust PLL settings based on the number of MIPI lanes

David Hildenbrand (2):
      mm/rmap: reject hugetlb folios in folio_make_device_exclusive()
      s390/virtio_ccw: Don't allocate/assign airqs for non-existing queues

David Yat Sin (1):
      drm/amdkfd: clamp queue size to minimum

Derek Foreman (1):
      drm/rockchip: Don't change hdmi reference clock rate

Dionna Glaze (1):
      crypto: ccp - Fix uAPI definitions of PSP errors

Dmitry Antipov (1):
      wifi: ath9k: use unsigned long for activity check timestamp

Dmitry Baryshkov (2):
      Bluetooth: qca: simplify WCN399x NVM loading
      Bluetooth: qca: add WCN3950 support

Dmitry Osipenko (2):
      irqchip/gic-v3: Add Rockchip 3568002 erratum workaround
      drm/virtio: Set missing bo->attached flag

Dorian Cruveiller (1):
      Bluetooth: btusb: Add new VID/PID for WCN785x

Douglas Anderson (6):
      arm64: cputype: Add QCOM_CPU_PART_KRYO_3XX_GOLD
      arm64: cputype: Add MIDR_CORTEX_A76AE
      arm64: errata: Add QCOM_KRYO_4XX_GOLD to the spectre_bhb_k24_list
      arm64: errata: Assume that unknown CPUs _are_ vulnerable to Spectre BHB
      arm64: errata: Add KRYO 2XX/3XX/4XX silver cores to Spectre BHB safe list
      arm64: errata: Add newer ARM cores to the spectre_bhb_loop_affected() lists

Edward Adam Davis (2):
      jfs: Prevent copying of nlink with value 0 from disk inode
      jfs: add sanity check for agwidth in dbMount

Edward Liaw (1):
      selftests/futex: futex_waitv wouldblock test should fail

Emily Deng (1):
      drm/amdgpu: Fix the race condition for draining retry fault

Eric Biggers (2):
      arm/crc-t10dif: fix use of out-of-scope array in crc_t10dif_arch()
      arm64/crc-t10dif: fix use of out-of-scope array in crc_t10dif_arch()

Ewan D. Milne (1):
      scsi: lpfc: Restore clearing of NLP_UNREG_INP in ndlp->nlp_flag

Fedor Pchelkin (1):
      ntb: use 64-bit arithmetic for the MSI doorbell mask

Filipe Manana (2):
      btrfs: fix non-empty delayed iputs list on unmount due to compressed write workers
      btrfs: tests: fix chunk map leak after failure to add it to the tree

Florian Westphal (1):
      nft_set_pipapo: fix incorrect avx2 match of 5th field octet

Frederic Weisbecker (1):
      perf: Fix hang while freeing sigtrap event

Gabriele Paoloni (1):
      tracing: fix return value in __ftrace_event_enable_disable for TRACE_REG_UNREGISTER

Gang Yan (1):
      mptcp: fix NULL pointer in can_accept_new_subflow

Gavrilov Ilia (1):
      wifi: mac80211: fix integer overflow in hwmp_route_info_get()

Geliang Tang (1):
      selftests: mptcp: close fd_in before returning in main_loop

Greg Kroah-Hartman (1):
      Linux 6.14.3

Guixin Liu (1):
      gpio: tegra186: fix resource handling in ACPI probe path

Haiyang Zhang (1):
      net: mana: Switch to page pool for jumbo frames

Han Xu (1):
      spi: fsl-qspi: use devm function instead of driver remove

Hans de Goede (3):
      platform/x86: x86-android-tablets: Add select POWER_SUPPLY to Kconfig
      media: ov08x40: Properly turn sensor on/off when runtime-suspended
      media: hi556: Fix memory leak (on error) in hi556_check_hwcfg()

Haoxiang Li (3):
      auxdisplay: hd44780: Fix an API misuse in hd44780.c
      wifi: mt76: Add check for devm_kstrdup()
      ASoC: codecs: wcd937x: fix a potential memory leak in wcd937x_soc_codec_probe()

Hariprasad Kelam (1):
      octeontx2-pf: qos: fix VF root node parent queue index

Harshitha Ramamurthy (1):
      gve: unlink old napi only if page pool exists

Henry Martin (1):
      ata: pata_pxa: Fix potential NULL pointer dereference in pxa_ata_probe()

Herve Codina (1):
      backlight: led_bl: Hold led_access lock when calling led_sysfs_disable()

Huacai Chen (1):
      ahci: Marvell 88SE9215 controllers prefer DMA for ATAPI

Icenowy Zheng (1):
      wifi: mt76: mt76x2u: add TP-Link TL-WDN6200 ID to device table

Ido Schimmel (2):
      ipv6: Align behavior across nexthops during path selection
      ethtool: cmis_cdb: Fix incorrect read / write length extension

Ingo Molnar (1):
      zstd: Increase DYNAMIC_BMI2 GCC version cutoff from 4.8 to 11.0 to work around compiler segfault

Ioana Ciornei (1):
      PCI: layerscape: Fix arg_count to syscon_regmap_lookup_by_phandle_args()

Jacek Lawrynowicz (3):
      accel/ivpu: Fix PM related deadlocks in MS IOCTLs
      accel/ivpu: Fix warning in ivpu_ipc_send_receive_internal()
      accel/ivpu: Fix deadlock in ivpu_ms_cleanup()

Jackson.lee (4):
      media: chips-media: wave5: Fix gray color on screen
      media: chips-media: wave5: Avoid race condition in the interrupt handler
      media: chips-media: wave5: Fix a hang after seeking
      media: chips-media: wave5: Fix timeout while testing 10bit hevc fluster

Jaegeuk Kim (1):
      f2fs: fix the missing write pointer correction

Jake Hillion (1):
      sched_ext: create_dsq: Return -EEXIST on duplicate request

Jakub Kicinski (1):
      net: tls: explicitly disallow disconnect

Jan Beulich (1):
      xenfs/xensyms: respect hypervisor's "next" indication

Jan Kara (2):
      udf: Fix inode_getblk() return value
      jbd2: remove wrong sb->s_sequence check

Janaki Ramaiah Thota (1):
      Bluetooth: hci_qca: use the power sequencer for wcn6750

Jane Chu (1):
      mm: make page_mapped_in_vma() hugetlb walk aware

Jani Nikula (1):
      drm/rockchip: stop passing non struct drm_device to drm_err() and friends

Jann Horn (1):
      ext4: don't treat fhandle lookup of ea_inode as FS corruption

Janusz Krzysztofik (1):
      drm/i915/huc: Fix fence not released on early probe errors

Jason Xing (1):
      page_pool: avoid infinite loop to schedule delayed worker

Jeff Hugo (1):
      bus: mhi: host: Fix race between unprepare and queue_buf

Jens Axboe (1):
      io_uring/kbuf: reject zero sized provided buffers

Jiande Lu (1):
      Bluetooth: btusb: Add 2 HWIDs for MT7922

Jiasheng Jiang (4):
      media: mediatek: vcodec: Fix a resource leak related to the scp device in FW initialization
      media: platform: stm32: Add check for clk_enable()
      mtd: Add check for devm_kcalloc()
      mtd: Replace kcalloc() with devm_kcalloc()

Jiawen Wu (1):
      net: libwx: Fix the wrong Rx descriptor field

Jinjiang Tu (1):
      mm/hwpoison: introduce folio_contain_hwpoisoned_page() helper

Jo Van Bulck (1):
      dm-integrity: fix non-constant-time tag verification

Joe Damato (1):
      igc: Fix XSK queue NAPI ID mapping

Johannes Berg (2):
      wifi: mac80211: add strict mode disabling workarounds
      wifi: mac80211: fix userspace_selectors corruption

Johannes Thumshirn (2):
      btrfs: zoned: fix zone activation with missing devices
      btrfs: zoned: fix zone finishing with missing devices

John Keeping (1):
      media: rockchip: rga: fix rga offset lookup

Jonathan McDowell (3):
      tpm, tpm_tis: Workaround failed command reception on Infineon devices
      tpm: End any active auth session before shutdown
      tpm, tpm_tis: Fix timeout handling when waiting for TPM status

Josh Poimboeuf (3):
      objtool: Fix INSN_CONTEXT_SWITCH handling in validate_unret()
      tracing: Disable branch profiling in noinstr code
      pwm: mediatek: Prevent divide-by-zero in pwm_mediatek_config()

Joshua Washington (1):
      gve: handle overflow when reporting TX consumed descriptors

Kai Mäkisara (1):
      scsi: st: Fix array overflow in st_setup()

Kaixin Wang (1):
      HSI: ssi_protocol: Fix use after free vulnerability in ssi_protocol Driver Due to Race Condition

Kamal Dasu (1):
      mtd: rawnand: brcmnand: fix PM resume warning

Karina Yankevich (1):
      media: v4l2-dv-timings: prevent possible overflow in v4l2_detect_gtf()

Kartik Rajput (1):
      mailbox: tegra-hsp: Define dimensioning masks in SoC data

Kaustabh Chakraborty (1):
      mmc: dw_mmc: add a quirk for accessing 64-bit FIFOs in two halves

Keerthy (1):
      arm64: dts: ti: k3-j784s4-j742s2-main-common: Correct the GICD size

Kees Cook (1):
      xen/mcelog: Add __nonstring annotations for unterminated strings

Keir Fraser (1):
      arm64: mops: Do not dereference src reg for a set operation

Kevin Hao (1):
      spi: fsl-qspi: Fix double cleanup in probe error path

Kiran K (1):
      Bluetooth: btintel_pcie: Add device id of Whale Peak

Kris Van Hees (1):
      kbuild: exclude .rodata.(cst|str)* when building ranges

Krzysztof Kozlowski (4):
      dt-bindings: coresight: qcom,coresight-tpda: Fix too many 'reg'
      dt-bindings: coresight: qcom,coresight-tpdm: Fix too many 'reg'
      gpio: mpc8xxx: Fix wakeup source leaks on device unbind
      gpio: zynq: Fix wakeup source leaks on device unbind

Kunihiko Hayashi (3):
      misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
      misc: pci_endpoint_test: Fix displaying 'irq_type' after 'request_irq' error
      misc: pci_endpoint_test: Fix 'irq_type' to convey the correct type

Kuniyuki Iwashima (1):
      net: Fix null-ptr-deref by sock_lock_init_class_and_name() and rmmod.

Lad Prabhakar (1):
      clk: renesas: r9a07g043: Fix HP clock source for RZ/Five

Leonid Arapov (1):
      fbdev: omapfb: Add 'plane' value check

Lizhi Xu (1):
      PM: hibernate: Avoid deadlock in hibernate_compressor_param_set()

Lorenzo Stoakes (1):
      mm/mremap: correctly handle partial mremap() of VMA starting at 0

Louis-Alexis Eyraud (1):
      iommu/mediatek: Fix NULL pointer deference in mtk_iommu_device_group

Lu Baolu (1):
      iommu/vt-d: Fix possible circular locking dependency

Luca Ceresoli (2):
      drm/debugfs: fix printk format for bridge index
      drm/bridge: panel: forbid initializing a panel with unknown connector type

Lucas De Marchi (1):
      drivers: base: devres: Allow to release group on device release

Lukas Wunner (1):
      PCI: pciehp: Avoid unnecessary device replacement check

Ma Ke (2):
      PCI: Fix reference leak in pci_alloc_child_bus()
      PCI: Fix reference leak in pci_register_host_bridge()

Manish Dharanenthiran (1):
      wifi: ath12k: Fix invalid data access in ath12k_dp_rx_h_undecap_nwifi

Manjunatha Venkatesh (1):
      i3c: Add NULL pointer check in i3c_master_queue_ibi()

Marc Herbert (1):
      mm/hugetlb: move hugetlb_sysctl_init() to the __init section

Marek Behún (2):
      net: dsa: mv88e6xxx: workaround RGMII transmit delay erratum for 6320 family
      net: dsa: mv88e6xxx: fix internal PHYs for 6320 family

Marek Szyprowski (1):
      iommu/exynos: Fix suspend/resume with IDENTITY domain

Mario Limonciello (1):
      cpufreq/amd-pstate: Invalidate cppc_req_cached during suspend

Mark Rutland (1):
      perf: arm_pmu: Don't disable counter in armpmu_add()

Martin Schiller (1):
      net: sfp: add quirk for FS SFP-10GM-T copper SFP+ module

Martin Tůma (2):
      media: mgb4: Fix CMT registers update logic
      media: mgb4: Fix switched CMT frequency range "magic values" sets

Masami Hiramatsu (Google) (5):
      tracing: fprobe: Cleanup fprobe hash when module unloading
      tracing: probe-events: Log error for exceeding the number of arguments
      tracing: probe-events: Add comments about entry data storing code
      tracing: fprobe: Fix to lock module while registering fprobe
      tracing: fprobe events: Fix possible UAF on modules

Mateusz Guzik (1):
      fs: consistently deref the files table with rcu_dereference_raw()

Mathieu Desnoyers (1):
      mm: add missing release barrier on PGDAT_RECLAIM_LOCKED unlock

Matt Atwood (1):
      drm/xe/ptl: Update the PTL pci id table

Matthew Majewski (1):
      media: vim2m: print device name after registering device

Matthew Wilcox (Oracle) (1):
      x86/mm: Clear _PAGE_DIRTY for kernel mappings when we clear _PAGE_RW

Matthieu Baerts (NGI0) (3):
      mptcp: sockopt: fix getting IPV6_V6ONLY
      mptcp: sockopt: fix getting freebind & transparent
      mptcp: only inc MPJoinAckHMacFailure for HMAC failures

Max Grobecker (1):
      x86/cpu: Don't clear X86_FEATURE_LAHF_LM flag in init_amd_k8() on AMD when running in a virtual machine

Max Schulze (1):
      net: usb: asix_devices: add FiberGecko DeviceID

Maxim Mikityanskiy (2):
      ALSA: hda: intel: Fix Optimus when GPU has no sound
      ALSA: hda: intel: Add Lenovo IdeaPad Z570 to probe denylist

Maxime Chevallier (1):
      net: ethtool: Don't call .cleanup_data when prepare_data fails

Maxime Ripard (5):
      drm/tests: modeset: Fix drm_display_mode memory leak
      drm/tests: helpers: Create kunit helper to destroy a drm_display_mode
      drm/tests: cmdline: Fix drm_display_mode memory leak
      drm/tests: modes: Fix drm_display_mode memory leak
      drm/tests: probe-helper: Fix drm_display_mode memory leak

Miaoqing Pan (2):
      wifi: ath11k: fix memory leak in ath11k_xxx_remove()
      wifi: ath12k: fix memory leak in ath12k_pci_remove()

Michael Strauss (1):
      drm/amd/display: Update FIXED_VS Link Rate Toggle Workaround Usage

Michal Wajdeczko (2):
      drm/xe/pf: Don't send BEGIN_ID if VF has no context/doorbells
      drm/xe/vf: Don't try to trigger a full GT reset if VF

Mickaël Salaün (7):
      landlock: Move code to ease future backports
      landlock: Add the errata interface
      landlock: Add erratum for TCP fix
      landlock: Always allow signals between threads of the same process
      landlock: Prepare to add second errata
      selftests/landlock: Split signal_scoping_threads tests
      selftests/landlock: Add a new test for setuid()

Mike Katsnelson (1):
      drm/amd/display: stop DML2 from removing pipes based on planes

Mikulas Patocka (3):
      dm-ebs: fix prefetch-vs-suspend race
      dm-integrity: set ti->error on memory allocation failure
      dm-verity: fix prefetch-vs-suspend race

Mimi Zohar (2):
      ima: limit the number of open-writers integrity violations
      ima: limit the number of ToMToU integrity violations

Ming Lei (2):
      ublk: fix handling recovery & reissue in ublk_abort_queue()
      block: make sure ->nr_integrity_segments is cloned in blk_rq_prep_clone

Ming Yen Hsieh (8):
      wifi: mt76: mt792x: re-register CHANCTX_STA_CSA only for the mt7921 series
      wifi: mt76: mt7925: ensure wow pattern command align fw format
      wifi: mt76: mt7925: fix country count limitation for CLC
      wifi: mt76: mt7925: fix the wrong link_idx when a p2p_device is present
      wifi: mt76: mt7925: fix the wrong simultaneous cap for MLO
      wifi: mt76: mt7925: adjust rm BSS flow to prevent next connection failure
      wifi: mt76: mt7925: integrate *mlo_sta_cmd and *sta_cmd
      wifi: mt76: mt7925: update the power-saving flow

Miquel Raynal (2):
      spi: cadence-qspi: Fix probe on AM62A LP SK
      mtd: spinand: Fix build with gcc < 7.5

Miri Korenblit (1):
      wifi: mac80211: ensure sdata->work is canceled before initialized.

Murad Masimov (1):
      media: streamzap: prevent processing IR data on URB failure

Myrrh Periwinkle (1):
      x86/e820: Fix handling of subpage regions when calculating nosave ranges in e820__register_nosave_regions()

Nathan Chancellor (1):
      kbuild: Add '-fno-builtin-wcslen'

Nicolas Dufresne (1):
      media: visl: Fix ERANGE error when setting enum controls

Nicolin Chen (3):
      iommufd: Fix uninitialized rc in iommufd_access_rw()
      iommu/tegra241-cmdqv: Fix warnings due to dmam_free_coherent()
      iommufd: Make attach_handle generic than fault specific

Niklas Cassel (2):
      ata: libata-core: Add 'external' to the libata.force kernel parameter
      ata: libata-eh: Do not use ATAPI DMA for a device limited to PIO mode

Niklas Schnelle (2):
      s390/pci: Fix s390_mmio_read/write syscall page fault handling
      s390/pci: Fix zpci_bus_is_isolated_vf() for non-VFs

Niklas Söderlund (2):
      media: uapi: rkisp1-config: Fix typo in extensible params example
      media: i2c: adv748x: Fix test pattern selection mask

Ninad Malwade (1):
      arm64: tegra: Remove the Orin NX/Nano suspend key

Nícolas F. R. A. Prado (3):
      arm64: dts: mediatek: mt8188: Assign apll1 clock as parent to avoid hang
      thermal/drivers/mediatek/lvts: Disable monitor mode during suspend
      thermal/drivers/mediatek/lvts: Disable Stage 3 thermal threshold

Octavian Purdila (2):
      net_sched: sch_sfq: use a temporary work area for validating configuration
      net_sched: sch_sfq: move the limit validation

Ojaswin Mujoo (1):
      ext4: protect ext4_release_dquot against freezing

Olga Kornievskaia (1):
      svcrdma: do not unregister device for listeners

Oliver Upton (1):
      KVM: arm64: Set HCR_EL2.TID1 unconditionally

P Praneesh (3):
      wifi: ath11k: Fix DMA buffer allocation to resolve SWIOTLB issues
      wifi: ath12k: Fix invalid entry fetch in ath12k_dp_mon_srng_process
      wifi: ath12k: Avoid memory leak while enabling statistics

Pali Rohár (2):
      cifs: Fix support for WSL-style symlinks
      cifs: Ensure that all non-client-specific reparse points are processed by the server

Paul E. McKenney (2):
      srcu: Force synchronization for srcu_get_delay()
      Flush console log from kernel_power_off()

Paulo Alcantara (1):
      smb: client: fix UAF in decryption with multichannel

Pavel Begunkov (3):
      net: page_pool: don't cast mp param to devmem
      io_uring/net: fix accept multishot handling
      io_uring/net: fix io_req_post_cqe abuse by send bundle

Peter Griffin (2):
      arm64: dts: exynos: gs101: disable pinctrl_gsacore node
      pinctrl: samsung: add support for eint_fltcon_offset

Peter Xu (1):
      mm/userfaultfd: fix release hang over concurrent GUP

Peter Zijlstra (1):
      perf/core: Simplify the perf_event_alloc() error path

Petr Vaněk (1):
      x86/acpi: Don't limit CPUs to 1 for Xen PV guests due to disabled ACPI

Philip Yang (4):
      drm/amdgpu: Unlocked unmap only clear page table leaves
      drm/amdkfd: Fix mode1 reset crash issue
      drm/amdkfd: Fix pqm_destroy_queue race with GPU reset
      drm/amdkfd: debugfs hang_hws skip GPU with MES

Philipp Hahn (1):
      cdc_ether|r8152: ThinkPad Hybrid USB-C/A Dock quirk

Philipp Stanner (2):
      PCI: Check BAR index for validity
      PCI: Fix wrong length of devres array

Qingfang Deng (1):
      net: stmmac: Fix accessing freed irq affinity_hint

Rand Deeb (2):
      fs/jfs: cast inactags to s64 to prevent potential overflow
      fs/jfs: Prevent integer overflow in AG size calculation

Ranjan Kumar (2):
      scsi: mpi3mr: Avoid reply queue full condition
      scsi: mpi3mr: Synchronous access b/w reset and tm thread for reply queue

Ricard Wanderlof (1):
      ALSA: usb-audio: Fix CME quirk for UF series keyboards

Ricardo Cañuelo Navarro (1):
      sctp: detect and prevent references to a freed transport in sendmsg

Ricardo Ribalda (3):
      media: uvcvideo: Add quirk for Actions UVC05
      media: nuvoton: Fix reference handling of ece_node
      media: nuvoton: Fix reference handling of ece_pdev

Rodrigo Vivi (1):
      drm/xe: Restore EIO errno return when GuC PC start fails

Roger Pau Monne (1):
      x86/xen: fix balloon target initialization for PVH dom0

Roman Smirnov (1):
      cifs: fix integer overflow in match_server()

Ryan Roberts (3):
      sparc/mm: disable preemption in lazy mmu mode
      sparc/mm: avoid calling arch_enter/leave_lazy_mmu() in set_ptes
      mm: fix lazy mmu docs and usage

Ryan Seto (1):
      drm/amd/display: Prevent VStartup Overflow

Ryo Takakura (1):
      PCI: vmd: Make vmd_dev::cfg_lock a raw_spinlock_t type

Sakari Ailus (8):
      Revert "media: imx214: Fix the error handling in imx214_probe()"
      media: i2c: ccs: Set the device's runtime PM status correctly in remove
      media: i2c: ccs: Set the device's runtime PM status correctly in probe
      media: i2c: ov7251: Set enable GPIO low in probe
      media: i2c: ov7251: Introduce 1 ms delay between regulators and en GPIO
      media: i2c: imx319: Rectify runtime PM handling probe and remove
      media: i2c: imx219: Rectify runtime PM handling in probe and remove
      media: i2c: imx214: Rectify probe error handling related to runtime PM

Sean Christopherson (6):
      iommu/vt-d: Put IRTE back into posted MSI mode if vCPU posting is disabled
      iommu/vt-d: Don't clobber posted vCPU IRTE when host IRQ affinity changes
      iommu/vt-d: Wire up irq_ack() to irq_move_irq() for posted MSIs
      KVM: Allow building irqbypass.ko as as module when kvm.ko is a module
      KVM: x86: Explicitly zero-initialize on-stack CPUID unions
      KVM: x86: Acquire SRCU in KVM_GET_MP_STATE to protect guest memory accesses

Sean Wang (1):
      Revert "wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba for MLO"

SeongJae Park (1):
      mm/damon: avoid applying DAMOS action to same entity multiple times

Sharan Kumar M (1):
      ALSA: hda/realtek: Enable Mute LED on HP OMEN 16 Laptop xd000xx

Shawn Lin (1):
      PCI: Add Rockchip Vendor ID

Shekhar Chauhan (1):
      drm/xe/bmg: Add new PCI IDs

Sheng Yong (1):
      erofs: set error to bio if file-backed IO fails

Shengjiu Wang (1):
      ASoC: fsl_audmix: register card device depends on 'dais' property

Shuai Xue (1):
      mm/hwpoison: do not send SIGBUS to processes with recovered clean pages

Si-Wei Liu (1):
      vdpa/mlx5: Fix oversized null mkey longer than 32bit

Siddharth Vadapalli (2):
      arm64: dts: ti: k3-j784s4-j742s2-main-common: Fix serdes_ln_ctrl reg-masks
      PCI: j721e: Fix the value of .linkdown_irq_regfield for J784S4

Srinivas Kandagatla (5):
      ASoC: q6apm: add q6apm_get_hw_pointer helper
      ASoC: q6apm-dai: schedule all available frames to avoid dsp under-runs
      ASoC: q6apm-dai: make use of q6apm_get_hw_pointer
      ASoC: qdsp6: q6apm-dai: set 10 ms period and buffer alignment.
      ASoC: qdsp6: q6apm-dai: fix capture pipeline overruns.

Stanimir Varbanov (1):
      PCI: brcmstb: Fix missing of_node_put() in brcm_pcie_probe()

Stanislav Fomichev (1):
      net: vlan: don't propagate flags on open

Stanley Chu (1):
      i3c: master: svc: Use readsb helper for reading MDB

Stefan Eichenberger (1):
      phy: freescale: imx8m-pcie: assert phy reset and perst in power off

Stephan Gerhold (1):
      pinctrl: qcom: Clear latched interrupt status when changing IRQ type

Steve French (1):
      smb311 client: fix missing tcon check when mounting with linux/posix extensions

Steven Rostedt (2):
      tracing: Do not add length to print format in synthetic events
      ring-buffer: Use flush_kernel_vmap_range() over flush_dcache_folio()

Sumanth Korikkar (1):
      s390: Fix linker error when -no-pie option is unavailable

Sung Lee (1):
      drm/amd/display: Guard Possible Null Pointer Dereference

Syed Saba kareem (1):
      ASoC: amd: yc: update quirk data for new Lenovo model

T Pratham (1):
      lib: scatterlist: fix sg_split_phys to preserve original scatterlist offsets

Taehee Yoo (1):
      net: ethtool: fix ethtool_ringparam_get_cfg() returns a hds_thresh value always as 0.

Taniya Das (1):
      clk: qcom: gdsc: Set retain_ff before moving to HW CTRL

Tejas Upadhyay (1):
      drm/xe/hw_engine: define sysfs_ops on all directories

Thadeu Lima de Souza Cascardo (1):
      tpm: do not start chip while suspended

Thomas Richter (1):
      s390/cpumf: Fix double free on error in cpumf_pmu_event_init()

Thomas Weißschuh (1):
      firmware: cs_dsp: test_control_parse: null-terminate test strings

Toke Høiland-Jørgensen (1):
      tc: Ensure we have enough buffer space when sending filter netlink notifications

Tom Lendacky (1):
      crypto: ccp - Fix check for the primary ASP device

Tomasz Pakuła (31):
      HID: pidff: Convert infinite length from Linux API to PID standard
      HID: pidff: Do not send effect envelope if it's empty
      HID: pidff: Add MISSING_DELAY quirk and its detection
      HID: pidff: Add MISSING_PBO quirk and its detection
      HID: pidff: Add PERMISSIVE_CONTROL quirk
      HID: pidff: Add hid_pidff_init_with_quirks and export as GPL symbol
      HID: pidff: Add FIX_WHEEL_DIRECTION quirk
      HID: Add hid-universal-pidff driver and supported device ids
      HID: pidff: Add PERIODIC_SINE_ONLY quirk
      HID: pidff: Fix null pointer dereference in pidff_find_fields
      HID: pidff: Clamp PERIODIC effect period to device's logical range
      HID: pidff: Stop all effects before enabling actuators
      HID: pidff: Completely rework and fix pidff_reset function
      HID: pidff: Simplify pidff_upload_effect function
      HID: pidff: Define values used in pidff_find_special_fields
      HID: pidff: Rescale time values to match field units
      HID: pidff: Factor out code for setting gain
      HID: pidff: Move all hid-pidff definitions to a dedicated header
      HID: pidff: Simplify pidff_rescale_signed
      HID: pidff: Use macros instead of hardcoded min/max values for shorts
      HID: pidff: Factor out pool report fetch and remove excess declaration
      HID: pidff: Make sure to fetch pool before checking SIMULTANEOUS_MAX
      HID: hid-universal-pidff: Add Asetek wheelbases support
      HID: pidff: Comment and code style update
      HID: pidff: Support device error response from PID_BLOCK_LOAD
      HID: pidff: Remove redundant call to pidff_find_special_keys
      HID: pidff: Rename two functions to align them with naming convention
      HID: pidff: Clamp effect playback LOOP_COUNT value
      HID: pidff: Compute INFINITE value instead of using hardcoded 0xffff
      HID: pidff: Fix 90 degrees direction name North -> East
      HID: pidff: Fix set_device_control()

Trevor Woerner (1):
      thermal/drivers/rockchip: Add missing rk3328 mapping entry

Trond Myklebust (1):
      umount: Allow superblock owners to force umount

Tung Nguyen (1):
      tipc: fix memory leak in tipc_link_xmit

Tvrtko Ursulin (1):
      drm/xe/xelp: Move Wa_16011163337 from tunings to workarounds

Uros Bizjak (1):
      x86/percpu: Disable named address spaces for UBSAN_BOOL with KASAN for GCC < 14.2

Usama Arif (1):
      mm/damon/ops: have damon_get_folio return folio even for tail pages

Uwe Kleine-König (3):
      pwm: rcar: Improve register calculation
      pwm: fsl-ftm: Handle clk_get_rate() returning 0
      pwm: stm32: Search an appropriate duty_cycle if period cannot be modified

Vijendar Mukunda (2):
      ASoC: amd: ps: use macro for ACP6.3 pci revision id
      ASoC: amd: amd_sdw: Add quirks for Dell SKU's

Vikash Garodia (4):
      media: venus: hfi: add a check to handle OOB in sfr region
      media: venus: hfi: add check to handle incorrect queue size
      media: venus: hfi_parser: add check to avoid out of bound access
      media: venus: hfi_parser: refactor hfi packet parsing logic

Vishnu Sankar (1):
      HID: lenovo: Fix to ensure the data as __le32 instead of u32

Vivek Kasireddy (1):
      drm/virtio: Fix flickering issue seen with imported dmabufs

Vladimir Oltean (2):
      net: phy: move phy_link_change() prior to mdio_bus_phy_may_suspend()
      net: phy: allow MDIO bus PM ops to start/stop state machine for phylink-controlled PHY

Waiman Long (3):
      cgroup/cpuset: Fix incorrect isolated_cpus update in update_parent_effective_cpumask()
      cgroup/cpuset: Fix error handling in remote_partition_disable()
      cgroup/cpuset: Fix race between newly created partition and dying one

Wen Gong (1):
      wifi: ath11k: update channel list in worker when wait flag is set

Wentao Liang (4):
      ata: sata_sx4: Add error handling in pdc20621_i2c_read()
      drm/amdgpu: handle amdgpu_cgs_create_device() errors in amd_powerplay_create()
      mtd: inftlcore: Add error check for inftl_read_oob()
      mtd: rawnand: Add status chack in r852_ready()

Will Deacon (1):
      KVM: arm64: Tear down vGIC on failed vCPU creation

Willem de Bruijn (1):
      bpf: support SKF_NET_OFF and SKF_LL_OFF on skb frags

Xin Li (Intel) (1):
      x86/ia32: Leave NULL selector values 0~3 unchanged

Yeongjin Gil (1):
      f2fs: fix to avoid atomicity corruption of atomic file

Yi Liu (1):
      iommufd: Fail replace if device has not been attached

Yuan Can (1):
      media: siano: Fix error handling in smsdvb_module_init()

Yunhui Cui (2):
      perf/dwc_pcie: fix some unreleased resources
      perf/dwc_pcie: fix duplicate pci_dev devices

Zenm Chen (1):
      wifi: rtw88: Add support for Mercusys MA30N and D-Link DWA-T185 rev. A1

Zhang Heng (1):
      ASoC: SOF: topology: Use krealloc_array() to replace krealloc()

Zhenhua Huang (1):
      arm64: mm: Correct the update of max_pfn

Zhikai Zhai (1):
      drm/amd/display: Update Cursor request mode to the beginning prefetch always

Zhongqiu Han (2):
      pm: cpupower: bench: Prevent NULL dereference on malloc failure
      jfs: Fix uninit-value access of imap allocated in the diMount() function

Zijun Hu (6):
      Bluetooth: btusb: Add 13 USB device IDs for Qualcomm WCN785x
      of/irq: Fix device node refcount leakage in API of_irq_parse_one()
      of/irq: Fix device node refcount leakage in API of_irq_parse_raw()
      of/irq: Fix device node refcount leakages in of_irq_count()
      of/irq: Fix device node refcount leakage in API irq_of_parse_and_map()
      of/irq: Fix device node refcount leakages in of_irq_init()

keenplify (1):
      ASoC: amd: Add DMI quirk for ACP6X mic support

zhoumin (1):
      ftrace: Add cond_resched() to ftrace_graph_set_hash()


