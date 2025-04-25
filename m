Return-Path: <stable+bounces-136678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFA3A9C2DD
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 11:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8484C1F0D
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 09:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB39238D3A;
	Fri, 25 Apr 2025 09:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UR1fgNQt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99B2238C05;
	Fri, 25 Apr 2025 09:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745571997; cv=none; b=LAjWSZ4XWamzLjsoHzfrzad2PyQf5uMhIj0KKQ+ennsr4PtvcUvBgGpc6w7eag375R9pPRFPqtW4Ihr/xZddLDXSj8m/CmacaWxBDyU6UVDGt5nJYAftBgZ9B9ch3FkWm8UMY80o7J1XASwC6wW/iF09x+AW38WHgYpZ7WUE+p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745571997; c=relaxed/simple;
	bh=YUGz89F7ZvJruhJ3CpMEbAjASbGi5GPA1kvZWgRpsF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OdCRSck5TKZ+ZZyb57h49/3W1apWDTm2zhn9Yi3U8VMX5GOcmfuKOcXDuZcSAT7g5FhXfEvdEqS1RlFCpfXs3MSV7srcZUOACStOvwp3Z+rlLyPwV1hEi8VC8hhZw3dQJNetDJolo28i2NmTw7b3CwTTJjLIspCnwiKvXugYR3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UR1fgNQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A20C4CEE4;
	Fri, 25 Apr 2025 09:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745571997;
	bh=YUGz89F7ZvJruhJ3CpMEbAjASbGi5GPA1kvZWgRpsF0=;
	h=From:To:Cc:Subject:Date:From;
	b=UR1fgNQtRWf3iT+cLBbWNOIWqoJnwc9z6/+9w6gdE+Hjql1oMcrJWrh2wZBzbv9Pv
	 D8UvrngoZTRCcHbWTdfD5QcVgiEPspsbmpDV/WPYp/QmnsdZ1AUJd24UcjFHMqwU3B
	 vlCPK+12NoyA2sQ48ctZlnq7q8wZqxt+mt93Skas=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.88
Date: Fri, 25 Apr 2025 11:06:29 +0200
Message-ID: <2025042530-climate-bubble-8266@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.88 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml            |    3 
 Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml            |    3 
 Documentation/devicetree/bindings/media/i2c/st,st-mipid02.yaml            |    2 
 Documentation/netlink/specs/rt_link.yaml                                  |   14 
 MAINTAINERS                                                               |    1 
 Makefile                                                                  |    5 
 arch/arm64/boot/dts/mediatek/mt8173.dtsi                                  |    6 
 arch/arm64/include/asm/cputype.h                                          |    4 
 arch/arm64/include/asm/spectre.h                                          |    1 
 arch/arm64/include/asm/tlbflush.h                                         |   22 -
 arch/arm64/kernel/proton-pack.c                                           |  218 +++++-----
 arch/arm64/kvm/arm.c                                                      |    6 
 arch/arm64/mm/mmu.c                                                       |    3 
 arch/loongarch/kernel/acpi.c                                              |   12 
 arch/mips/dec/prom/init.c                                                 |    2 
 arch/mips/include/asm/ds1287.h                                            |    2 
 arch/mips/kernel/cevt-ds1287.c                                            |    1 
 arch/powerpc/kernel/rtas.c                                                |    4 
 arch/riscv/include/asm/kgdb.h                                             |    9 
 arch/riscv/include/asm/syscall.h                                          |    7 
 arch/riscv/kernel/kgdb.c                                                  |    6 
 arch/riscv/kernel/setup.c                                                 |   36 +
 arch/sparc/include/asm/pgtable_64.h                                       |    2 
 arch/sparc/mm/tlb.c                                                       |    5 
 arch/x86/Kconfig                                                          |    1 
 arch/x86/boot/compressed/mem.c                                            |    5 
 arch/x86/boot/compressed/sev.c                                            |   67 ---
 arch/x86/boot/compressed/sev.h                                            |    2 
 arch/x86/coco/tdx/tdx.c                                                   |   26 +
 arch/x86/events/intel/ds.c                                                |    8 
 arch/x86/events/intel/uncore_snbep.c                                      |  107 ----
 arch/x86/include/asm/irqflags.h                                           |   40 +
 arch/x86/include/asm/paravirt.h                                           |   20 
 arch/x86/include/asm/paravirt_types.h                                     |    3 
 arch/x86/include/asm/tdx.h                                                |    4 
 arch/x86/include/asm/xen/hypervisor.h                                     |    5 
 arch/x86/kernel/cpu/amd.c                                                 |   21 
 arch/x86/kernel/cpu/intel.c                                               |   20 
 arch/x86/kernel/cpu/microcode/amd.c                                       |    9 
 arch/x86/kernel/e820.c                                                    |   17 
 arch/x86/kernel/paravirt.c                                                |   14 
 arch/x86/kernel/process.c                                                 |    2 
 arch/x86/kernel/signal_32.c                                               |   62 +-
 arch/x86/kvm/cpuid.c                                                      |    8 
 arch/x86/kvm/x86.c                                                        |    4 
 arch/x86/mm/pat/set_memory.c                                              |    6 
 arch/x86/platform/pvh/enlighten.c                                         |    3 
 arch/x86/xen/enlighten.c                                                  |   10 
 arch/x86/xen/enlighten_pvh.c                                              |   93 ++--
 arch/x86/xen/setup.c                                                      |    3 
 block/blk-sysfs.c                                                         |    2 
 certs/Makefile                                                            |    2 
 certs/extract-cert.c                                                      |  138 +++---
 drivers/acpi/platform_profile.c                                           |   20 
 drivers/ata/ahci.c                                                        |    2 
 drivers/ata/libata-eh.c                                                   |   11 
 drivers/ata/libata-sata.c                                                 |   15 
 drivers/ata/pata_pxa.c                                                    |    6 
 drivers/ata/sata_sx4.c                                                    |   13 
 drivers/base/devres.c                                                     |    7 
 drivers/block/loop.c                                                      |    7 
 drivers/bluetooth/btqca.c                                                 |   13 
 drivers/bluetooth/btrtl.c                                                 |    2 
 drivers/bluetooth/hci_ldisc.c                                             |   19 
 drivers/bluetooth/hci_uart.h                                              |    1 
 drivers/bluetooth/hci_vhci.c                                              |   10 
 drivers/bus/mhi/host/main.c                                               |   16 
 drivers/char/tpm/tpm-chip.c                                               |    5 
 drivers/char/tpm/tpm-interface.c                                          |    7 
 drivers/char/tpm/tpm_tis_core.c                                           |   20 
 drivers/char/tpm/tpm_tis_core.h                                           |    1 
 drivers/clk/qcom/clk-branch.c                                             |    4 
 drivers/clk/qcom/gdsc.c                                                   |   61 +-
 drivers/clocksource/timer-stm32-lp.c                                      |    4 
 drivers/cpufreq/cpufreq.c                                                 |    8 
 drivers/crypto/caam/qi.c                                                  |    6 
 drivers/crypto/ccp/sp-pci.c                                               |   15 
 drivers/firmware/efi/libstub/efistub.h                                    |    2 
 drivers/gpio/gpio-tegra186.c                                              |   27 -
 drivers/gpio/gpio-zynq.c                                                  |    1 
 drivers/gpu/drm/Kconfig                                                   |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c                               |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                                   |   44 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                                  |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_device.c                                   |    5 
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                                  |   17 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c                    |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                         |   14 
 drivers/gpu/drm/amd/display/dc/dc.h                                       |    2 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c                 |   22 -
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c                         |    2 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c          |    2 
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c                          |    5 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c                     |    4 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c                   |    4 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c                   |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c                         |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c                            |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c                            |    2 
 drivers/gpu/drm/drm_atomic_helper.c                                       |    2 
 drivers/gpu/drm/drm_panel.c                                               |    5 
 drivers/gpu/drm/drm_panel_orientation_quirks.c                            |   46 ++
 drivers/gpu/drm/i915/gt/intel_engine_cs.c                                 |    3 
 drivers/gpu/drm/i915/gt/intel_mocs.c                                      |    4 
 drivers/gpu/drm/i915/gt/intel_rc6.c                                       |   19 
 drivers/gpu/drm/i915/gt/uc/intel_huc.c                                    |   11 
 drivers/gpu/drm/i915/gt/uc/intel_huc.h                                    |    1 
 drivers/gpu/drm/i915/gt/uc/intel_uc.c                                     |    1 
 drivers/gpu/drm/i915/gvt/opregion.c                                       |    7 
 drivers/gpu/drm/i915/i915_debugfs.c                                       |    2 
 drivers/gpu/drm/i915/selftests/i915_selftest.c                            |   54 ++
 drivers/gpu/drm/mediatek/mtk_dpi.c                                        |   23 -
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                                     |   72 +--
 drivers/gpu/drm/nouveau/nouveau_bo.c                                      |    3 
 drivers/gpu/drm/nouveau/nouveau_gem.c                                     |    3 
 drivers/gpu/drm/sti/Makefile                                              |    2 
 drivers/gpu/drm/tests/drm_client_modeset_test.c                           |    3 
 drivers/gpu/drm/tests/drm_cmdline_parser_test.c                           |   10 
 drivers/gpu/drm/tests/drm_kunit_helpers.c                                 |  213 +++++++++
 drivers/gpu/drm/tests/drm_modes_test.c                                    |   22 +
 drivers/gpu/drm/tests/drm_probe_helper_test.c                             |    8 
 drivers/gpu/drm/tiny/repaper.c                                            |    4 
 drivers/hid/Kconfig                                                       |   14 
 drivers/hid/Makefile                                                      |    1 
 drivers/hid/hid-ids.h                                                     |   31 +
 drivers/hid/hid-universal-pidff.c                                         |  197 +++++++++
 drivers/hid/usbhid/hid-pidff.c                                            |  173 +++++--
 drivers/hsi/clients/ssi_protocol.c                                        |    1 
 drivers/i2c/busses/i2c-cros-ec-tunnel.c                                   |    3 
 drivers/i2c/i2c-atr.c                                                     |    2 
 drivers/i3c/master.c                                                      |    3 
 drivers/i3c/master/svc-i3c-master.c                                       |    2 
 drivers/infiniband/core/cma.c                                             |    4 
 drivers/infiniband/core/umem_odp.c                                        |    6 
 drivers/infiniband/hw/hns/hns_roce_main.c                                 |    2 
 drivers/infiniband/hw/usnic/usnic_ib_main.c                               |   14 
 drivers/iommu/iommufd/device.c                                            |   18 
 drivers/iommu/mtk_iommu.c                                                 |   26 -
 drivers/leds/rgb/leds-qcom-lpg.c                                          |    8 
 drivers/mailbox/tegra-hsp.c                                               |   72 ++-
 drivers/md/dm-ebs-target.c                                                |    7 
 drivers/md/dm-integrity.c                                                 |    3 
 drivers/md/dm-verity-target.c                                             |    8 
 drivers/md/md-bitmap.c                                                    |    5 
 drivers/md/md.c                                                           |   22 -
 drivers/md/raid10.c                                                       |    1 
 drivers/media/common/siano/smsdvb-main.c                                  |    2 
 drivers/media/i2c/adv748x/adv748x.h                                       |    2 
 drivers/media/i2c/ccs/ccs-core.c                                          |    6 
 drivers/media/i2c/imx219.c                                                |   13 
 drivers/media/i2c/ov7251.c                                                |    4 
 drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c         |    5 
 drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c |    3 
 drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c        |    6 
 drivers/media/platform/qcom/venus/hfi_parser.c                            |  100 +++-
 drivers/media/platform/qcom/venus/hfi_venus.c                             |   18 
 drivers/media/platform/st/stm32/dma2d/dma2d.c                             |    3 
 drivers/media/rc/streamzap.c                                              |   68 +--
 drivers/media/test-drivers/vim2m.c                                        |    6 
 drivers/media/test-drivers/visl/visl-core.c                               |   12 
 drivers/media/usb/uvc/uvc_driver.c                                        |    9 
 drivers/media/v4l2-core/v4l2-dv-timings.c                                 |    4 
 drivers/mfd/ene-kb3930.c                                                  |    2 
 drivers/misc/pci_endpoint_test.c                                          |    6 
 drivers/mmc/host/dw_mmc.c                                                 |   94 ++++
 drivers/mmc/host/dw_mmc.h                                                 |   27 +
 drivers/mtd/inftlcore.c                                                   |    9 
 drivers/mtd/mtdpstore.c                                                   |   12 
 drivers/mtd/nand/raw/brcmnand/brcmnand.c                                  |    2 
 drivers/mtd/nand/raw/r852.c                                               |    3 
 drivers/net/dsa/b53/b53_common.c                                          |   10 
 drivers/net/dsa/mv88e6xxx/chip.c                                          |   30 +
 drivers/net/dsa/mv88e6xxx/devlink.c                                       |    3 
 drivers/net/ethernet/amd/pds_core/debugfs.c                               |    5 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c                        |    1 
 drivers/net/ethernet/google/gve/gve_ethtool.c                             |    4 
 drivers/net/ethernet/intel/igc/igc.h                                      |    1 
 drivers/net/ethernet/intel/igc/igc_defines.h                              |    6 
 drivers/net/ethernet/intel/igc/igc_main.c                                 |    1 
 drivers/net/ethernet/intel/igc/igc_ptp.c                                  |  113 +++--
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c                          |    5 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                               |   10 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                                  |   19 
 drivers/net/ethernet/ti/am65-cpsw-nuss.h                                  |    2 
 drivers/net/ethernet/ti/icssg/icss_iep.c                                  |  154 ++++---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c                               |    3 
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c                             |    3 
 drivers/net/phy/sfp.c                                                     |    2 
 drivers/net/ppp/ppp_synctty.c                                             |    5 
 drivers/net/usb/asix_devices.c                                            |   17 
 drivers/net/usb/cdc_ether.c                                               |    7 
 drivers/net/usb/r8152.c                                                   |    6 
 drivers/net/usb/r8153_ecm.c                                               |    6 
 drivers/net/wireless/ath/ath12k/dp_mon.c                                  |    2 
 drivers/net/wireless/ath/ath12k/dp_rx.c                                   |   42 +
 drivers/net/wireless/atmel/at76c50x-usb.c                                 |    2 
 drivers/net/wireless/mediatek/mt76/eeprom.c                               |    4 
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c                           |    1 
 drivers/net/wireless/realtek/rtw89/core.c                                 |    2 
 drivers/net/wireless/realtek/rtw89/core.h                                 |    6 
 drivers/net/wireless/realtek/rtw89/pci.c                                  |   10 
 drivers/net/wireless/ti/wl1251/tx.c                                       |    4 
 drivers/ntb/ntb_transport.c                                               |    2 
 drivers/nvme/host/rdma.c                                                  |    8 
 drivers/nvme/target/fc.c                                                  |   14 
 drivers/nvme/target/fcloop.c                                              |    2 
 drivers/of/irq.c                                                          |   80 ++-
 drivers/pci/controller/pcie-brcmstb.c                                     |   13 
 drivers/pci/controller/vmd.c                                              |   12 
 drivers/pci/pci.c                                                         |    4 
 drivers/pci/probe.c                                                       |    5 
 drivers/perf/arm_pmu.c                                                    |    8 
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c                                |   11 
 drivers/pinctrl/qcom/pinctrl-msm.c                                        |   12 
 drivers/platform/x86/asus-laptop.c                                        |    9 
 drivers/ptp/ptp_ocp.c                                                     |    1 
 drivers/pwm/pwm-fsl-ftm.c                                                 |    6 
 drivers/pwm/pwm-mediatek.c                                                |    8 
 drivers/pwm/pwm-rcar.c                                                    |   24 -
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c                                    |    9 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                                    |   14 
 drivers/scsi/megaraid/megaraid_sas_base.c                                 |    9 
 drivers/scsi/megaraid/megaraid_sas_fusion.c                               |    5 
 drivers/scsi/scsi_transport_iscsi.c                                       |    7 
 drivers/scsi/st.c                                                         |    2 
 drivers/soc/samsung/exynos-chipid.c                                       |    2 
 drivers/spi/spi-cadence-quadspi.c                                         |    6 
 drivers/target/target_core_spc.c                                          |    2 
 drivers/thermal/rockchip_thermal.c                                        |    1 
 drivers/ufs/host/ufs-exynos.c                                             |    6 
 drivers/usb/typec/ucsi/ucsi_ccg.c                                         |    5 
 drivers/vdpa/mlx5/core/mr.c                                               |    7 
 drivers/video/backlight/led_bl.c                                          |    5 
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c                              |    6 
 drivers/xen/balloon.c                                                     |   34 +
 drivers/xen/xenfs/xensyms.c                                               |    4 
 fs/Kconfig                                                                |    1 
 fs/btrfs/disk-io.c                                                        |   12 
 fs/btrfs/inode.c                                                          |    6 
 fs/btrfs/super.c                                                          |    3 
 fs/btrfs/zoned.c                                                          |    6 
 fs/ext4/inode.c                                                           |   68 ++-
 fs/ext4/namei.c                                                           |    2 
 fs/ext4/super.c                                                           |   17 
 fs/ext4/xattr.c                                                           |   11 
 fs/f2fs/checkpoint.c                                                      |   21 
 fs/f2fs/f2fs.h                                                            |   32 +
 fs/f2fs/inode.c                                                           |    8 
 fs/f2fs/node.c                                                            |  110 +----
 fs/f2fs/super.c                                                           |    4 
 fs/file.c                                                                 |   26 -
 fs/fuse/virtio_fs.c                                                       |    3 
 fs/hfs/bnode.c                                                            |    6 
 fs/hfsplus/bnode.c                                                        |    6 
 fs/isofs/export.c                                                         |    2 
 fs/jbd2/journal.c                                                         |    1 
 fs/jfs/jfs_dmap.c                                                         |   10 
 fs/jfs/jfs_imap.c                                                         |    4 
 fs/namespace.c                                                            |    3 
 fs/nfs/Kconfig                                                            |    2 
 fs/nfs/internal.h                                                         |    7 
 fs/nfs/nfs4session.h                                                      |    4 
 fs/nfsd/Kconfig                                                           |    1 
 fs/nfsd/nfs4state.c                                                       |    2 
 fs/nfsd/nfsfh.h                                                           |    7 
 fs/overlayfs/overlayfs.h                                                  |    2 
 fs/overlayfs/super.c                                                      |    5 
 fs/smb/client/cifsproto.h                                                 |    2 
 fs/smb/client/connect.c                                                   |   36 -
 fs/smb/client/file.c                                                      |   28 +
 fs/smb/client/fs_context.c                                                |    5 
 fs/smb/client/inode.c                                                     |   10 
 fs/smb/client/reparse.c                                                   |    4 
 fs/smb/client/smb2misc.c                                                  |    9 
 fs/smb/server/oplock.c                                                    |   29 -
 fs/smb/server/oplock.h                                                    |    1 
 fs/smb/server/smb2pdu.c                                                   |    4 
 fs/smb/server/transport_ipc.c                                             |    7 
 fs/smb/server/vfs.c                                                       |    3 
 fs/udf/inode.c                                                            |    1 
 fs/userfaultfd.c                                                          |   51 +-
 include/drm/drm_kunit_helpers.h                                           |   28 +
 include/linux/backing-dev.h                                               |    1 
 include/linux/hid.h                                                       |    9 
 include/linux/nfs.h                                                       |    7 
 include/linux/pgtable.h                                                   |   14 
 include/linux/rtnetlink.h                                                 |   22 +
 include/linux/tpm.h                                                       |    1 
 include/net/sctp/structs.h                                                |    3 
 include/net/xdp.h                                                         |    9 
 include/uapi/linux/kfd_ioctl.h                                            |    2 
 include/uapi/linux/landlock.h                                             |    2 
 include/xen/interface/xen-mca.h                                           |    2 
 io_uring/kbuf.c                                                           |    2 
 io_uring/net.c                                                            |    2 
 kernel/locking/lockdep.c                                                  |    3 
 kernel/sched/cpufreq_schedutil.c                                          |   18 
 kernel/trace/ftrace.c                                                     |    8 
 kernel/trace/trace_events.c                                               |    4 
 kernel/trace/trace_events_filter.c                                        |    4 
 kernel/trace/trace_events_synth.c                                         |    1 
 kernel/trace/trace_probe.c                                                |   28 +
 lib/sg_split.c                                                            |    2 
 lib/string.c                                                              |   13 
 lib/zstd/common/portability_macros.h                                      |    2 
 mm/filemap.c                                                              |    1 
 mm/gup.c                                                                  |    4 
 mm/hugetlb.c                                                              |    2 
 mm/memory-failure.c                                                       |   11 
 mm/memory.c                                                               |    4 
 mm/mremap.c                                                               |   10 
 mm/page_vma_mapped.c                                                      |   13 
 mm/rmap.c                                                                 |    2 
 mm/vmscan.c                                                               |    2 
 net/8021q/vlan_dev.c                                                      |   31 -
 net/bluetooth/hci_event.c                                                 |    5 
 net/bluetooth/l2cap_core.c                                                |   21 
 net/bridge/br_vlan.c                                                      |    4 
 net/core/filter.c                                                         |   80 ++-
 net/core/page_pool.c                                                      |    8 
 net/dsa/dsa.c                                                             |   59 ++
 net/dsa/tag_8021q.c                                                       |    2 
 net/ethtool/netlink.c                                                     |    8 
 net/ipv6/route.c                                                          |    8 
 net/mac80211/iface.c                                                      |    3 
 net/mac80211/mesh_hwmp.c                                                  |   14 
 net/mctp/af_mctp.c                                                        |    3 
 net/mptcp/sockopt.c                                                       |   28 +
 net/mptcp/subflow.c                                                       |   19 
 net/netfilter/nft_set_pipapo_avx2.c                                       |    3 
 net/openvswitch/flow_netlink.c                                            |    3 
 net/sched/cls_api.c                                                       |   74 ++-
 net/sched/sch_codel.c                                                     |    5 
 net/sched/sch_fq_codel.c                                                  |    6 
 net/sched/sch_sfq.c                                                       |   66 ++-
 net/sctp/socket.c                                                         |   22 -
 net/sctp/transport.c                                                      |    2 
 net/tipc/link.c                                                           |    1 
 net/tls/tls_main.c                                                        |    6 
 scripts/sign-file.c                                                       |  132 +++---
 scripts/ssl-common.h                                                      |   32 +
 security/landlock/errata.h                                                |   87 +++
 security/landlock/setup.c                                                 |   30 +
 security/landlock/setup.h                                                 |    3 
 security/landlock/syscalls.c                                              |   22 -
 sound/pci/hda/hda_intel.c                                                 |   44 +-
 sound/pci/hda/patch_realtek.c                                             |    1 
 sound/soc/amd/yc/acp6x-mach.c                                             |   14 
 sound/soc/codecs/cs42l43-jack.c                                           |    3 
 sound/soc/codecs/lpass-wsa-macro.c                                        |  117 +++--
 sound/soc/dwc/dwc-i2s.c                                                   |   13 
 sound/soc/fsl/fsl_audmix.c                                                |   16 
 sound/soc/intel/avs/pcm.c                                                 |    3 
 sound/soc/qcom/lpass.h                                                    |    3 
 sound/soc/qcom/qdsp6/q6apm-dai.c                                          |    9 
 sound/soc/qcom/qdsp6/q6apm.c                                              |   18 
 sound/soc/qcom/qdsp6/q6apm.h                                              |    3 
 sound/soc/qcom/qdsp6/q6asm-dai.c                                          |   19 
 sound/soc/sof/topology.c                                                  |    4 
 sound/usb/midi.c                                                          |   80 +++
 tools/objtool/check.c                                                     |    5 
 tools/power/cpupower/bench/parse.c                                        |    4 
 tools/testing/ktest/ktest.pl                                              |    8 
 tools/testing/kunit/qemu_configs/sh.py                                    |    4 
 tools/testing/radix-tree/linux.c                                          |    4 
 tools/testing/selftests/futex/functional/futex_wait_wouldblock.c          |    2 
 tools/testing/selftests/landlock/base_test.c                              |   46 ++
 tools/testing/selftests/mm/charge_reserved_hugetlb.sh                     |    4 
 tools/testing/selftests/mm/hugetlb_reparenting_test.sh                    |    2 
 tools/testing/selftests/net/mptcp/diag.sh                                 |   23 -
 tools/testing/selftests/net/mptcp/mptcp_connect.c                         |   11 
 tools/testing/selftests/net/mptcp/mptcp_connect.sh                        |   19 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                           |   20 
 tools/testing/selftests/net/mptcp/mptcp_lib.sh                            |   18 
 tools/testing/selftests/net/mptcp/simult_flows.sh                         |   19 
 376 files changed, 4203 insertions(+), 1859 deletions(-)

Abdun Nihaal (5):
      wifi: at76c50x: fix use after free access in at76_disconnect
      wifi: wl1251: fix memory leak in wl1251_tx_work
      pds_core: fix memory leak in pdsc_debugfs_add_qcq()
      net: ngbe: fix memory leak in ngbe_probe() error path
      cxgb4: fix memory leak in cxgb4_init_ethtool_filters() error path

Abel Vesa (2):
      leds: rgb: leds-qcom-lpg: Fix pwm resolution max for Hi-Res PWMs
      leds: rgb: leds-qcom-lpg: Fix calculation of best period Hi-Res PWMs

Abhinav Kumar (1):
      drm: allow encoder mode_set even when connectors change for crtc

Ajit Pandey (1):
      clk: qcom: clk-branch: Fix invert halt status bit check for votable clocks

Akhil P Oommen (1):
      drm/msm/a6xx: Fix stale rpmh votes from GPU

Alain Volmat (1):
      dt-bindings: media: st,stmipid02: correct lane-polarities maxItems

Alex Williamson (1):
      Revert "PCI: Avoid reset when disabled via sysfs"

Alexander Sverdlin (1):
      net: ethernet: ti: am65-cpsw-nuss: rename phy_node -> port_np

Alexandra Diupina (1):
      cifs: avoid NULL pointer dereference in dbg call

Alexandre Torgue (1):
      clocksource/drivers/stm32-lptimer: Use wakeup capable instead of init wakeup

Alexey Klimov (1):
      ASoC: qdsp6: q6asm-dai: fix q6asm_dai_compr_set_params error path

Andreas Gruenbacher (1):
      writeback: fix false warning in inode_to_wb()

Andrew Wyatt (5):
      drm: panel-orientation-quirks: Add support for AYANEO 2S
      drm: panel-orientation-quirks: Add quirks for AYA NEO Flip DS and KB
      drm: panel-orientation-quirks: Add quirk for AYA NEO Slide
      drm: panel-orientation-quirks: Add new quirk for GPD Win 2
      drm: panel-orientation-quirks: Add quirk for OneXPlayer Mini (Intel)

Andy Shevchenko (1):
      i2c: atr: Fix wrong include

AngeloGioacchino Del Regno (2):
      drm/mediatek: mtk_dpi: Move the input_2p_en bit to platform data
      drm/mediatek: mtk_dpi: Explicitly manage TVD clock in power on/off

Ard Biesheuvel (1):
      x86/boot/sev: Avoid shared GHCB page for early memory acceptance

Arnaud Lecomte (1):
      net: ppp: Add bound checking for skb data on ppp_sync_txmung

Arnd Bergmann (2):
      media: mtk-vcodec: venc: avoid -Wenum-compare-conditional warning
      media: mediatek: vcodec: mark vdec_vp9_slice_map_counts_eob_coef noinline

Arseniy Krasnov (2):
      Bluetooth: hci_uart: fix race during initialization
      Bluetooth: hci_uart: Fix another race during initialization

Artem Sadovnikov (1):
      ext4: fix off-by-one error in do_split

Ayush Jain (1):
      ktest: Fix Test Failures Due to Missing LOG_FILE Directories

Badal Nilawar (1):
      drm/i915: Disable RPG during live selftest

Baoquan He (1):
      mm/gup: fix wrongly calculated returned value in fault_in_safe_writeable()

Bhupesh (1):
      ext4: ignore xattrs past end

Birger Koblitz (1):
      net: sfp: add quirk for 2.5G OEM BX SFP

Björn Töpel (1):
      riscv: Properly export reserved regions in /proc/iomem

Bo-Cun Chen (2):
      net: ethernet: mtk_eth_soc: correct the max weight of the queue limit for 100Mbps
      net: ethernet: mtk_eth_soc: revise QDMA packet scheduler settings

Boqun Feng (1):
      locking/lockdep: Decrease nr_unused_locks if lock unused in zap_class()

Boris Burkov (1):
      btrfs: fix qgroup reserve leaks in cow_file_range

Borislav Petkov (AMD) (1):
      x86/microcode/AMD: Extend the SHA check to Zen5, block loading of any unreleased standalone Zen5 microcode patches

Brady Norander (1):
      ASoC: dwc: always enable/disable i2s irqs

Brendan Tam (1):
      drm/amd/display: add workaround flag to link to force FFE preset

Bryan O'Donoghue (2):
      clk: qcom: gdsc: Release pm subdomains in reverse add order
      clk: qcom: gdsc: Capture pm_genpd_add_subdomain result code

Chandrakanth Patil (1):
      scsi: megaraid_sas: Block zero-length ATA VPD inquiry

Chao Yu (3):
      f2fs: don't retry IO for corrupted data scenario
      f2fs: fix to avoid out-of-bounds access in f2fs_truncate_inode_blocks()
      Revert "f2fs: rebuild nat_bits during umount"

Chaohai Chen (1):
      scsi: target: spc: Fix RSOC parameter data header size

Charles Keepax (1):
      ASoC: cs42l43: Reset clamp override on jack removal

Chen-Yu Tsai (1):
      arm64: dts: mediatek: mt8173: Fix disp-pwm compatible string

Chengchang Tang (1):
      RDMA/hns: Fix wrong maximum DMA segment size

Chenyuan Yang (3):
      net: libwx: handle page_pool_dev_alloc_pages error
      soc: samsung: exynos-chipid: Add NULL pointer check in exynos_chipid_probe()
      mfd: ene-kb3930: Fix a potential NULL pointer dereference

Chris Bainbridge (1):
      drm/nouveau: prime: fix ttm_bo_delayed_delete oops

Christian König (1):
      drm/amdgpu: grab an additional reference on the gang fence v2

Christopher S M Hall (6):
      igc: fix PTM cycle trigger logic
      igc: increase wait time before retrying PTM
      igc: move ktime snapshot into PTM retry loop
      igc: handle the IGC_PTP_ENABLED flag correctly
      igc: cleanup PTP module if probe fails
      igc: add lock preventing multiple simultaneous PTM transactions

Chunguang.xu (1):
      nvme-rdma: unquiesce admin_q before destroy it

Chunjie Zhu (1):
      smb3 client: fix open hardlink on deferred close file error

Cong Liu (1):
      selftests: mptcp: fix incorrect fd checks in main_loop

Cong Wang (1):
      codel: remove sch->q.qlen check before qdisc_tree_reduce_backlog()

Dan Carpenter (2):
      Bluetooth: btrtl: Prevent potential NULL dereference
      usb: typec: fix potential array underflow in ucsi_ccg_sync_control()

Daniel Kral (1):
      ahci: add PCI ID for Marvell 88SE9215 SATA Controller

Daniel Wagner (1):
      nvmet-fcloop: swap list_add_tail arguments

Daniele Ceraolo Spurio (1):
      drm/i915/dg2: wait for HuC load completion before running selftests

Dapeng Mi (1):
      perf/x86/intel: Allow to update user space GPRs from PEBS records

David Hildenbrand (1):
      mm/rmap: reject hugetlb folios in folio_make_device_exclusive()

David Yat Sin (1):
      drm/amdkfd: clamp queue size to minimum

Denis Arefev (8):
      asus-laptop: Fix an uninitialized variable
      ksmbd: Prevent integer overflow in calculation of deadtime
      drm/amd/pm: Prevent division by zero
      drm/amd/pm/powerplay: Prevent division by zero
      drm/amd/pm/smu11: Prevent division by zero
      drm/amd/pm/powerplay/hwmgr/smu7_thermal: Prevent division by zero
      drm/amd/pm/swsmu/smu13/smu_v13_0: Prevent division by zero
      drm/amd/pm/powerplay/hwmgr/vega20_thermal: Prevent division by zero

Dmitry Baryshkov (1):
      Bluetooth: qca: simplify WCN399x NVM loading

Douglas Anderson (6):
      arm64: cputype: Add QCOM_CPU_PART_KRYO_3XX_GOLD
      arm64: cputype: Add MIDR_CORTEX_A76AE
      arm64: errata: Add QCOM_KRYO_4XX_GOLD to the spectre_bhb_k24_list
      arm64: errata: Assume that unknown CPUs _are_ vulnerable to Spectre BHB
      arm64: errata: Add KRYO 2XX/3XX/4XX silver cores to Spectre BHB safe list
      arm64: errata: Add newer ARM cores to the spectre_bhb_loop_affected() lists

Edward Adam Davis (3):
      jfs: Prevent copying of nlink with value 0 from disk inode
      jfs: add sanity check for agwidth in dbMount
      isofs: Prevent the use of too small fid

Edward Liaw (1):
      selftests/futex: futex_waitv wouldblock test should fail

Eric Biggers (1):
      nfs: add missing selections of CONFIG_CRC32

Evgeny Pimenov (1):
      ASoC: qcom: Fix sc7280 lpass potential buffer overflow

Fedor Pchelkin (1):
      ntb: use 64-bit arithmetic for the MSI doorbell mask

Filipe Manana (1):
      btrfs: fix non-empty delayed iputs list on unmount due to compressed write workers

Florian Westphal (1):
      nft_set_pipapo: fix incorrect avx2 match of 5th field octet

Frédéric Danis (2):
      Bluetooth: l2cap: Check encryption key size on incoming connection
      Bluetooth: l2cap: Process valid commands in too long frame

GONG Ruiqi (1):
      usb: typec: fix pm usage counter imbalance in ucsi_ccg_sync_control()

Gabriele Paoloni (1):
      tracing: fix return value in __ftrace_event_enable_disable for TRACE_REG_UNREGISTER

Gang Yan (1):
      mptcp: fix NULL pointer in can_accept_new_subflow

Gavrilov Ilia (1):
      wifi: mac80211: fix integer overflow in hwmp_route_info_get()

Geliang Tang (2):
      selftests: mptcp: close fd_in before returning in main_loop
      selftests: mptcp: add mptcp_lib_wait_local_port_listen

Giuseppe Scrivano (1):
      ovl: remove unused forward declaration

Greg Kroah-Hartman (1):
      Linux 6.6.88

Guixin Liu (1):
      gpio: tegra186: fix resource handling in ACPI probe path

Haisu Wang (1):
      btrfs: fix the length of reserved qgroup to free

Hamza Mahfooz (1):
      efi/libstub: Bump up EFI_MMAP_NR_SLACK_SLOTS to 32

Haoxiang Li (1):
      wifi: mt76: Add check for devm_kstrdup()

Hariprasad Kelam (1):
      octeontx2-pf: qos: fix VF root node parent queue index

Harish Chegondi (1):
      drm/i915/xelpg: Extend driver code of Xe_LPG to Xe_LPG+

Henry Martin (2):
      ata: pata_pxa: Fix potential NULL pointer dereference in pxa_ata_probe()
      ASoC: Intel: avs: Fix null-ptr-deref in avs_component_probe()

Herbert Xu (1):
      crypto: caam/qi - Fix drv_ctx refcount bug

Hersen Wu (1):
      drm/amd/display: Stop amdgpu_dm initialize when link nums greater than max_links

Herve Codina (1):
      backlight: led_bl: Hold led_access lock when calling led_sysfs_disable()

Icenowy Zheng (1):
      wifi: mt76: mt76x2u: add TP-Link TL-WDN6200 ID to device table

Ido Schimmel (1):
      ipv6: Align behavior across nexthops during path selection

Ilya Maximets (1):
      net: openvswitch: fix nested key length validation in the set() action

Ingo Molnar (1):
      zstd: Increase DYNAMIC_BMI2 GCC version cutoff from 4.8 to 11.0 to work around compiler segfault

Jakub Kicinski (3):
      net: tls: explicitly disallow disconnect
      netlink: specs: rt-link: add an attr layer around alt-ifname
      netlink: specs: rt-link: adjust mctp attribute naming

Jamal Hadi Salim (1):
      rtnl: add helper to check if rtnl group has listeners

Jan Beulich (1):
      xenfs/xensyms: respect hypervisor's "next" indication

Jan Kara (2):
      udf: Fix inode_getblk() return value
      jbd2: remove wrong sb->s_sequence check

Jan Stancek (3):
      sign-file,extract-cert: move common SSL helper functions to a header
      sign-file,extract-cert: avoid using deprecated ERR_get_error_line()
      sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3

Jane Chu (1):
      mm: make page_mapped_in_vma() hugetlb walk aware

Jani Nikula (2):
      drm/i915/mocs: use to_gt() instead of direct &i915->gt
      drm/i915/gvt: fix unterminated-string-initialization warning

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

Jiasheng Jiang (4):
      media: mediatek: vcodec: Fix a resource leak related to the scp device in FW initialization
      media: platform: stm32: Add check for clk_enable()
      mtd: Add check for devm_kcalloc()
      mtd: Replace kcalloc() with devm_kcalloc()

Jinjie Ruan (1):
      drm/tests: helpers: Add helper for drm_display_mode_from_cea_vic()

Johannes Berg (1):
      Revert "wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()"

Johannes Kimmel (1):
      btrfs: correctly escape subvol in btrfs_show_options()

Johannes Thumshirn (2):
      btrfs: zoned: fix zone activation with missing devices
      btrfs: zoned: fix zone finishing with missing devices

Jonas Gorski (2):
      net: b53: enable BPDU reception for management port
      net: bridge: switchdev: do not notify new brentries as changed

Jonathan McDowell (2):
      tpm, tpm_tis: Workaround failed command reception on Infineon devices
      tpm, tpm_tis: Fix timeout handling when waiting for TPM status

Josh Poimboeuf (2):
      objtool: Fix INSN_CONTEXT_SWITCH handling in validate_unret()
      pwm: mediatek: Prevent divide-by-zero in pwm_mediatek_config()

Joshua Washington (1):
      gve: handle overflow when reporting TX consumed descriptors

Kai Mäkisara (1):
      scsi: st: Fix array overflow in st_setup()

Kaixin Wang (1):
      HSI: ssi_protocol: Fix use after free vulnerability in ssi_protocol Driver Due to Race Condition

Kamal Dasu (1):
      mtd: rawnand: brcmnand: fix PM resume warning

Kan Liang (3):
      perf/x86/intel/uncore: Fix the scale of IIO free running counters on SNR
      perf/x86/intel/uncore: Fix the scale of IIO free running counters on ICX
      perf/x86/intel/uncore: Fix the scale of IIO free running counters on SPR

Karina Yankevich (1):
      media: v4l2-dv-timings: prevent possible overflow in v4l2_detect_gtf()

Karolina Stolarek (1):
      drm/tests: Build KMS helpers when DRM_KUNIT_TEST_HELPERS is enabled

Kartik Rajput (1):
      mailbox: tegra-hsp: Define dimensioning masks in SoC data

Kaustabh Chakraborty (1):
      mmc: dw_mmc: add a quirk for accessing 64-bit FIFOs in two halves

Kees Cook (2):
      xen/mcelog: Add __nonstring annotations for unterminated strings
      Bluetooth: vhci: Avoid needless snprintf() calls

Kirill A. Shutemov (2):
      x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT
      mm: fix apply_to_existing_page_range()

Krzysztof Kozlowski (3):
      dt-bindings: coresight: qcom,coresight-tpda: Fix too many 'reg'
      dt-bindings: coresight: qcom,coresight-tpdm: Fix too many 'reg'
      gpio: zynq: Fix wakeup source leaks on device unbind

Kunihiko Hayashi (3):
      misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
      misc: pci_endpoint_test: Fix displaying 'irq_type' after 'request_irq' error
      misc: pci_endpoint_test: Fix 'irq_type' to convey the correct type

Kuniyuki Iwashima (2):
      Revert "smb: client: Fix netns refcount imbalance causing leaks and use-after-free"
      Revert "smb: client: fix TCP timers deadlock after rmmod"

Leonid Arapov (1):
      fbdev: omapfb: Add 'plane' value check

Li Lingfeng (1):
      nfsd: decrease sc_count directly if fail to queue dl_recall

Lorenzo Stoakes (1):
      mm/mremap: correctly handle partial mremap() of VMA starting at 0

Louis-Alexis Eyraud (1):
      iommu/mediatek: Fix NULL pointer deference in mtk_iommu_device_group

Luca Ceresoli (1):
      drm/bridge: panel: forbid initializing a panel with unknown connector type

Lucas De Marchi (1):
      drivers: base: devres: Allow to release group on device release

Luiz Augusto von Dentz (1):
      Bluetooth: hci_event: Fix sending MGMT_EV_DEVICE_FOUND for invalid address

Ma Ke (1):
      PCI: Fix reference leak in pci_alloc_child_bus()

Maksim Davydov (1):
      x86/split_lock: Fix the delayed detection logic

Manish Dharanenthiran (1):
      wifi: ath12k: Fix invalid data access in ath12k_dp_rx_h_undecap_nwifi

Manjunatha Venkatesh (1):
      i3c: Add NULL pointer check in i3c_master_queue_ibi()

Marc Herbert (1):
      mm/hugetlb: move hugetlb_sysctl_init() to the __init section

Marek Behún (1):
      net: dsa: mv88e6xxx: workaround RGMII transmit delay erratum for 6320 family

Mario Limonciello (1):
      drm/amd: Handle being compiled without SI or CIK support better

Mark Brown (1):
      selftests/mm: generate a temporary mountpoint for cgroup filesystem

Mark Rutland (1):
      perf: arm_pmu: Don't disable counter in armpmu_add()

Masami Hiramatsu (Google) (1):
      tracing: probe-events: Add comments about entry data storing code

Mateusz Guzik (1):
      fs: consistently deref the files table with rcu_dereference_raw()

Mathieu Desnoyers (1):
      mm: add missing release barrier on PGDAT_RECLAIM_LOCKED unlock

Matt Johnston (1):
      net: mctp: Set SOCK_RCU_FREE

Matthew Auld (1):
      drm/amdgpu/dma_buf: fix page_link check

Matthew Majewski (1):
      media: vim2m: print device name after registering device

Matthew Wilcox (Oracle) (2):
      x86/mm: Clear _PAGE_DIRTY for kernel mappings when we clear _PAGE_RW
      test suite: use %zu to print size_t

Matthieu Baerts (NGI0) (3):
      mptcp: sockopt: fix getting IPV6_V6ONLY
      mptcp: only inc MPJoinAckHMacFailure for HMAC failures
      mptcp: sockopt: fix getting freebind & transparent

Max Grobecker (1):
      x86/cpu: Don't clear X86_FEATURE_LAHF_LM flag in init_amd_k8() on AMD when running in a virtual machine

Max Schulze (1):
      net: usb: asix_devices: add FiberGecko DeviceID

Maxim Mikityanskiy (2):
      ALSA: hda: intel: Fix Optimus when GPU has no sound
      ALSA: hda: intel: Add Lenovo IdeaPad Z570 to probe denylist

Maxime Chevallier (1):
      net: ethtool: Don't call .cleanup_data when prepare_data fails

Maxime Ripard (8):
      drm/tests: modeset: Fix drm_display_mode memory leak
      drm/tests: helpers: Add atomic helpers
      drm/tests: Add helper to create mock plane
      drm/tests: Add helper to create mock crtc
      drm/tests: helpers: Create kunit helper to destroy a drm_display_mode
      drm/tests: cmdline: Fix drm_display_mode memory leak
      drm/tests: modes: Fix drm_display_mode memory leak
      drm/tests: probe-helper: Fix drm_display_mode memory leak

Meghana Malladi (3):
      net: ti: icss-iep: Add pwidth configuration for perout signal
      net: ti: icss-iep: Add phase offset configuration for perout signal
      net: ti: icss-iep: Fix possible NULL pointer dereference for perout request

Menglong Dong (1):
      ftrace: fix incorrect hash size in register_ftrace_direct()

Miaoqian Lin (1):
      scsi: iscsi: Fix missing scsi_host_put() in error path

Michael Walle (1):
      net: ethernet: ti: am65-cpsw: fix port_np reference counting

Mickaël Salaün (1):
      landlock: Add the errata interface

Miklos Szeredi (1):
      ovl: don't allow datadir only

Mikulas Patocka (3):
      dm-ebs: fix prefetch-vs-suspend race
      dm-integrity: set ti->error on memory allocation failure
      dm-verity: fix prefetch-vs-suspend race

Miquel Raynal (1):
      spi: cadence-qspi: Fix probe on AM62A LP SK

Murad Masimov (1):
      media: streamzap: prevent processing IR data on URB failure

Myrrh Periwinkle (1):
      x86/e820: Fix handling of subpage regions when calculating nosave ranges in e820__register_nosave_regions()

Namjae Jeon (2):
      ksmbd: fix use-after-free in smb_break_all_levII_oplock()
      ksmbd: fix the warning from __kernel_write_iter

Nathan Chancellor (3):
      ACPI: platform-profile: Fix CFI violation when accessing sysfs files
      riscv: Avoid fortify warning in syscall_get_arguments()
      kbuild: Add '-fno-builtin-wcslen'

Nathan Lynch (1):
      powerpc/rtas: Prevent Spectre v1 gadget construction in sys_rtas()

Nicolas Dufresne (1):
      media: visl: Fix ERANGE error when setting enum controls

Nicolin Chen (1):
      iommufd: Fix uninitialized rc in iommufd_access_rw()

Nikita Zhandarovich (1):
      drm/repaper: fix integer overflows in repeat functions

Niklas Cassel (2):
      ata: libata-eh: Do not use ATAPI DMA for a device limited to PIO mode
      ata: libata-sata: Save all fields from sense data descriptor

Niklas Söderlund (1):
      media: i2c: adv748x: Fix test pattern selection mask

Octavian Purdila (2):
      net_sched: sch_sfq: use a temporary work area for validating configuration
      net_sched: sch_sfq: move the limit validation

Ojaswin Mujoo (1):
      ext4: protect ext4_release_dquot against freezing

P Praneesh (1):
      wifi: ath12k: Fix invalid entry fetch in ath12k_dp_mon_srng_process

Pali Rohár (1):
      cifs: Ensure that all non-client-specific reparse points are processed by the server

Pavel Begunkov (1):
      io_uring/net: fix accept multishot handling

Pedro Tammela (1):
      net/sched: cls_api: conditional notification of events

Peter Collingbourne (1):
      string: Add load_unaligned_zeropad() code path to sized_strscpy()

Peter Griffin (1):
      scsi: ufs: exynos: Ensure consistent phy reference counts

Peter Xu (1):
      mm/userfaultfd: fix release hang over concurrent GUP

Philip Yang (3):
      drm/amdkfd: Fix mode1 reset crash issue
      drm/amdkfd: Fix pqm_destroy_queue race with GPU reset
      drm/amdkfd: debugfs hang_hws skip GPU with MES

Philipp Hahn (1):
      cdc_ether|r8152: ThinkPad Hybrid USB-C/A Dock quirk

Ping-Ke Shih (2):
      wifi: rtw89: pci: add pre_deinit to be called after probe complete
      wifi: rtw89: pci: disable PCIE wake bit when PCIE deinit

Piotr Jaroszynski (1):
      Fix mmu notifiers for range-based invalidates

Rafael J. Wysocki (2):
      cpufreq/sched: Fix the usage of CPUFREQ_NEED_UPDATE_LIMITS
      cpufreq: Reference count policy in cpufreq_update_limits()

Rand Deeb (2):
      fs/jfs: cast inactags to s64 to prevent potential overflow
      fs/jfs: Prevent integer overflow in AG size calculation

Remi Pommarel (2):
      wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()
      wifi: mac80211: Purge vif txq in ieee80211_do_stop()

Ricard Wanderlof (1):
      ALSA: usb-audio: Fix CME quirk for UF series keyboards

Ricardo Cañuelo Navarro (1):
      sctp: detect and prevent references to a freed transport in sendmsg

Ricardo Ribalda (1):
      media: uvcvideo: Add quirk for Actions UVC05

Roger Pau Monne (3):
      x86/xen: fix balloon target initialization for PVH dom0
      x86/xen: move xen_reserve_extra_memory()
      x86/xen: fix memblock_reserve() usage on PVH

Rolf Eike Beer (1):
      drm/sti: remove duplicate object names

Roman Smirnov (1):
      cifs: fix integer overflow in match_server()

Ryan Roberts (3):
      sparc/mm: disable preemption in lazy mmu mode
      sparc/mm: avoid calling arch_enter/leave_lazy_mmu() in set_ptes
      mm: fix lazy mmu docs and usage

Ryo Takakura (1):
      PCI: vmd: Make vmd_dev::cfg_lock a raw_spinlock_t type

Sagi Maimon (1):
      ptp: ocp: fix start time alignment in ptp_ocp_signal_set

Sakari Ailus (5):
      media: i2c: ccs: Set the device's runtime PM status correctly in remove
      media: i2c: ccs: Set the device's runtime PM status correctly in probe
      media: i2c: ov7251: Set enable GPIO low in probe
      media: i2c: ov7251: Introduce 1 ms delay between regulators and en GPIO
      media: i2c: imx219: Rectify runtime PM handling in probe and remove

Sandipan Das (1):
      x86/cpu/amd: Fix workaround for erratum 1054

Sean Christopherson (2):
      KVM: x86: Explicitly zero-initialize on-stack CPUID unions
      KVM: x86: Acquire SRCU in KVM_GET_MP_STATE to protect guest memory accesses

Sean Heelan (1):
      ksmbd: Fix dangling pointer in krb_authenticate

Sebastian Andrzej Siewior (1):
      xdp: Reset bpf_redirect_info before running a xdp's BPF prog.

Sharath Srinivasan (1):
      RDMA/cma: Fix workqueue crash in cma_netevent_work_handler

Shay Drory (1):
      RDMA/core: Silence oversized kvmalloc() warning

Shengjiu Wang (1):
      ASoC: fsl_audmix: register card device depends on 'dais' property

Shuai Xue (1):
      mm/hwpoison: do not send SIGBUS to processes with recovered clean pages

Si-Wei Liu (1):
      vdpa/mlx5: Fix oversized null mkey longer than 32bit

Srinivas Kandagatla (5):
      ASoC: q6apm: add q6apm_get_hw_pointer helper
      ASoC: qdsp6: q6apm-dai: set 10 ms period and buffer alignment.
      ASoC: qdsp6: q6apm-dai: fix capture pipeline overruns.
      ASoC: codecs:lpass-wsa-macro: Fix vi feedback rate
      ASoC: codecs:lpass-wsa-macro: Fix logic of enabling vi channels

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
      tracing: Fix filter string testing

Syed Saba kareem (1):
      ASoC: amd: yc: update quirk data for new Lenovo model

T Pratham (1):
      lib: scatterlist: fix sg_split_phys to preserve original scatterlist offsets

Takashi Iwai (1):
      ALSA: hda/realtek: Fix built-in mic on another ASUS VivoBook model

Taniya Das (1):
      clk: qcom: gdsc: Set retain_ff before moving to HW CTRL

Thadeu Lima de Souza Cascardo (2):
      tpm: do not start chip while suspended
      i2c: cros-ec-tunnel: defer probe if parent EC is not present

Thomas Weißschuh (3):
      kunit: qemu_configs: SH: Respect kunit cmdline
      loop: properly send KOBJ_CHANGED uevent for disk device
      loop: LOOP_SET_FD: send uevents for partitions

Toke Høiland-Jørgensen (1):
      tc: Ensure we have enough buffer space when sending filter netlink notifications

Tom Lendacky (1):
      crypto: ccp - Fix check for the primary ASP device

Tomasz Pakuła (10):
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

Trevor Woerner (1):
      thermal/drivers/rockchip: Add missing rk3328 mapping entry

Trond Myklebust (1):
      umount: Allow superblock owners to force umount

Tung Nguyen (1):
      tipc: fix memory leak in tipc_link_xmit

Uwe Kleine-König (2):
      pwm: rcar: Improve register calculation
      pwm: fsl-ftm: Handle clk_get_rate() returning 0

Vasiliy Kovalev (1):
      hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key

Victor Nogueira (1):
      rtnl: add helper to check if a notification is needed

Vikash Garodia (4):
      media: venus: hfi: add a check to handle OOB in sfr region
      media: venus: hfi: add check to handle incorrect queue size
      media: venus: hfi_parser: add check to avoid out of bound access
      media: venus: hfi_parser: refactor hfi packet parsing logic

Vishal Annapurve (1):
      x86/tdx: Fix arch_safe_halt() execution for TDX VMs

Vishal Moola (Oracle) (1):
      mm: fix filemap_get_folios_contig returning batches of identical folios

Vladimir Oltean (5):
      net: dsa: mv88e6xxx: avoid unregistering devlink regions which were never registered
      net: dsa: mv88e6xxx: fix -ENOENT when deleting VLANs and MST is unsupported
      net: dsa: clean up FDB, MDB, VLAN entries on unbind
      net: dsa: free routing table on probe failure
      net: dsa: avoid refcount warnings when ds->ops->tag_8021q_vlan_del() fails

WangYuli (6):
      riscv: KGDB: Do not inline arch_kgdb_breakpoint()
      riscv: KGDB: Remove ".option norvc/.option rvc" for kgdb_compiled_break
      nvmet-fc: Remove unused functions
      MIPS: dec: Declare which_prom() as static
      MIPS: cevt-ds1287: Add missing ds1287.h include
      MIPS: ds1287: Match ds1287_set_base_clock() function types

Wentao Liang (4):
      ata: sata_sx4: Add error handling in pdc20621_i2c_read()
      drm/amdgpu: handle amdgpu_cgs_create_device() errors in amd_powerplay_create()
      mtd: inftlcore: Add error check for inftl_read_oob()
      mtd: rawnand: Add status chack in r852_ready()

Will Deacon (1):
      KVM: arm64: Tear down vGIC on failed vCPU creation

Willem de Bruijn (1):
      bpf: support SKF_NET_OFF and SKF_LL_OFF on skb frags

Xiangsheng Hou (1):
      virtiofs: add filesystem context source name check

Xin Li (Intel) (1):
      x86/ia32: Leave NULL selector values 0~3 unchanged

Xingui Yang (1):
      scsi: hisi_sas: Enable force phy when SATA disk directly connected

Yeongjin Gil (1):
      f2fs: fix to avoid atomicity corruption of atomic file

Yi Liu (1):
      iommufd: Fail replace if device has not been attached

Yu Kuai (2):
      md/raid10: fix missing discard IO accounting
      md: fix mddev uaf while iterating all_mddevs list

Yu-Chun Lin (1):
      drm/tests: helpers: Fix compiler warning

Yuan Can (1):
      media: siano: Fix error handling in smsdvb_module_init()

Yue Haibing (1):
      RDMA/usnic: Fix passing zero to PTR_ERR in usnic_ib_pci_probe()

Yuli Wang (1):
      LoongArch: Eliminate superfluous get_numa_distances_cnt()

Zhang Heng (1):
      ASoC: SOF: topology: Use krealloc_array() to replace krealloc()

Zheng Qixing (2):
      md/md-bitmap: fix stats collection for external bitmaps
      block: fix resource leak in blk_register_queue() error path

Zhenhua Huang (1):
      arm64: mm: Correct the update of max_pfn

Zhikai Zhai (1):
      drm/amd/display: Update Cursor request mode to the beginning prefetch always

Zhongqiu Han (2):
      pm: cpupower: bench: Prevent NULL dereference on malloc failure
      jfs: Fix uninit-value access of imap allocated in the diMount() function

Zijun Hu (5):
      of/irq: Fix device node refcount leakage in API of_irq_parse_one()
      of/irq: Fix device node refcount leakage in API of_irq_parse_raw()
      of/irq: Fix device node refcount leakages in of_irq_count()
      of/irq: Fix device node refcount leakage in API irq_of_parse_and_map()
      of/irq: Fix device node refcount leakages in of_irq_init()

keenplify (1):
      ASoC: amd: Add DMI quirk for ACP6X mic support

zhoumin (1):
      ftrace: Add cond_resched() to ftrace_graph_set_hash()


