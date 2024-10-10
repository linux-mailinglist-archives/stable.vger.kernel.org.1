Return-Path: <stable+bounces-83337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EFD99846F
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 13:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02B2DB27069
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 11:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5121C3F15;
	Thu, 10 Oct 2024 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1VcJ4gR2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7361C3F0D;
	Thu, 10 Oct 2024 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558332; cv=none; b=mRSNKQUTj8qXfYolzuuzUz65NjsvyM+TuyOBNj/v8XN/eRLmdraZ1eH4f033NQM250OVaL7AfoYRhtgF6oxUl/aw31TXRcibaJyqGvbpldKD71U/6uGrMEospAZqJAfr0q3YmWIu0pCKeRUgX6wy/2nZp3Y7/mEsDxZmNC2A2OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558332; c=relaxed/simple;
	bh=HhzmqvGjm8w3PX+hKn/P5PoF5EM887rVrIFG5Qsn3i0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AHgZpHlGR/vsxgvNP65cnZxtVC3ZmpuslccNotYiMHWIr7lanB1KmRVU2SUHxF+ccMYVUr8XTz4i3bza+4pSr03M9TK0VTk0sK758Lg4ix90F2g8p9ljRWWk3BQnTFzc6RO4zYX+DAgc5K12W8uzLRyKkU5lHViSmYLUUdvRgZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1VcJ4gR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8E0C4CEC5;
	Thu, 10 Oct 2024 11:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728558332;
	bh=HhzmqvGjm8w3PX+hKn/P5PoF5EM887rVrIFG5Qsn3i0=;
	h=From:To:Cc:Subject:Date:From;
	b=1VcJ4gR2xYVuBytUR4lR2+BHyJZVpZueIwh0ybuNr2bVDMUumE+GoipCEFwjJCsjS
	 XThO4s56frQ11121FmrSCTLBCuogFeoxBd0SYAbFp08CCiCGX8fZYgUSm4nO3+CkhO
	 Od+SFTt7NvojwYjKMWF/57iNp41AP+QPxqrSoTgY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.55
Date: Thu, 10 Oct 2024 13:05:27 +0200
Message-ID: <2024101027-degree-surprise-277e@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.55 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt                     |   10 
 Documentation/arch/arm64/silicon-errata.rst                         |    6 
 Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml        |    3 
 Makefile                                                            |    2 
 arch/arm/crypto/aes-ce-glue.c                                       |    2 
 arch/arm/crypto/aes-neonbs-glue.c                                   |    2 
 arch/arm64/Kconfig                                                  |    7 
 arch/arm64/include/asm/cputype.h                                    |    2 
 arch/arm64/kernel/cpu_errata.c                                      |    3 
 arch/loongarch/configs/loongson3_defconfig                          |    1 
 arch/parisc/include/asm/mman.h                                      |   14 
 arch/parisc/kernel/entry.S                                          |    6 
 arch/parisc/kernel/syscall.S                                        |   14 
 arch/powerpc/configs/ppc64_defconfig                                |    1 
 arch/powerpc/include/asm/vdso_datapage.h                            |   15 
 arch/powerpc/kernel/asm-offsets.c                                   |    2 
 arch/powerpc/kernel/vdso/cacheflush.S                               |    2 
 arch/powerpc/kernel/vdso/datapage.S                                 |    4 
 arch/powerpc/platforms/pseries/dlpar.c                              |   17 
 arch/powerpc/platforms/pseries/hotplug-cpu.c                        |    2 
 arch/powerpc/platforms/pseries/hotplug-memory.c                     |   16 
 arch/powerpc/platforms/pseries/pmem.c                               |    2 
 arch/riscv/Kconfig                                                  |    8 
 arch/riscv/include/asm/thread_info.h                                |    7 
 arch/x86/crypto/sha256-avx2-asm.S                                   |   16 
 arch/x86/events/core.c                                              |   63 
 arch/x86/include/asm/fpu/signal.h                                   |    2 
 arch/x86/include/asm/syscall.h                                      |    7 
 arch/x86/kernel/apic/io_apic.c                                      |   46 
 arch/x86/kernel/fpu/signal.c                                        |    6 
 arch/x86/kernel/machine_kexec_64.c                                  |   27 
 arch/x86/kernel/signal.c                                            |    3 
 arch/x86/kernel/signal_64.c                                         |    6 
 block/blk-iocost.c                                                  |    8 
 crypto/simd.c                                                       |   76 
 drivers/accel/ivpu/ivpu_fw.c                                        |    4 
 drivers/acpi/acpi_pad.c                                             |    6 
 drivers/acpi/acpica/dbconvert.c                                     |    2 
 drivers/acpi/acpica/exprep.c                                        |    3 
 drivers/acpi/acpica/psargs.c                                        |   47 
 drivers/acpi/battery.c                                              |   28 
 drivers/acpi/cppc_acpi.c                                            |   10 
 drivers/acpi/ec.c                                                   |   55 
 drivers/acpi/resource.c                                             |   14 
 drivers/acpi/video_detect.c                                         |    8 
 drivers/ata/pata_serverworks.c                                      |   16 
 drivers/ata/sata_sil.c                                              |   12 
 drivers/block/aoe/aoecmd.c                                          |   13 
 drivers/block/loop.c                                                |   15 
 drivers/block/null_blk/main.c                                       |   45 
 drivers/bluetooth/btmrvl_sdio.c                                     |    3 
 drivers/bluetooth/btrtl.c                                           |    1 
 drivers/bluetooth/btusb.c                                           |    2 
 drivers/clk/qcom/clk-alpha-pll.c                                    |    2 
 drivers/clk/qcom/clk-rpmh.c                                         |    2 
 drivers/clk/qcom/dispcc-sm8250.c                                    |    3 
 drivers/clk/qcom/gcc-sc8180x.c                                      |   88 
 drivers/clk/qcom/gcc-sm8250.c                                       |    6 
 drivers/clk/qcom/gcc-sm8450.c                                       |    4 
 drivers/clk/rockchip/clk.c                                          |    3 
 drivers/clk/samsung/clk-exynos7885.c                                |    2 
 drivers/cpufreq/intel_pstate.c                                      |   20 
 drivers/crypto/marvell/Kconfig                                      |    2 
 drivers/crypto/marvell/octeontx/otx_cptvf_algs.c                    |  261 -
 drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c                  |  254 -
 drivers/firmware/efi/unaccepted_memory.c                            |    4 
 drivers/firmware/tegra/bpmp.c                                       |    6 
 drivers/gpio/gpio-davinci.c                                         |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c                          |   14 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h                          |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                              |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c                             |   18 
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                             |   43 
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h                             |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                              |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                              |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                               |    6 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                            |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_device.c                             |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c               |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c                        |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                            |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c              |    5 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                   |   19 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c           |    4 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c         |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c             |    3 
 drivers/gpu/drm/amd/display/dc/core/dc.c                            |    6 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c                   |    6 
 drivers/gpu/drm/amd/display/dc/dc_types.h                           |    1 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c              |    2 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c              |    4 
 drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c |    2 
 drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c   |    2 
 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c         |   12 
 drivers/gpu/drm/amd/display/dc/link/link_factory.c                  |    2 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c            |    2 
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c                        |   22 
 drivers/gpu/drm/drm_atomic_uapi.c                                   |    2 
 drivers/gpu/drm/drm_print.c                                         |   13 
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c                             |    2 
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c                     |    4 
 drivers/gpu/drm/msm/adreno/adreno_gpu.c                             |    1 
 drivers/gpu/drm/msm/msm_gpu.c                                       |    1 
 drivers/gpu/drm/omapdrm/omap_drv.c                                  |    5 
 drivers/gpu/drm/radeon/r100.c                                       |   70 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c                         |    4 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h                         |    1 
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c                         |    2 
 drivers/gpu/drm/scheduler/sched_entity.c                            |    2 
 drivers/gpu/drm/stm/drv.c                                           |    3 
 drivers/gpu/drm/stm/ltdc.c                                          |   76 
 drivers/hid/hid-ids.h                                               |   17 
 drivers/hid/hid-input.c                                             |   37 
 drivers/hid/hid-multitouch.c                                        |    6 
 drivers/hwmon/nct6775-platform.c                                    |    1 
 drivers/i2c/busses/i2c-designware-common.c                          |   14 
 drivers/i2c/busses/i2c-designware-core.h                            |    1 
 drivers/i2c/busses/i2c-designware-master.c                          |   38 
 drivers/i2c/busses/i2c-qcom-geni.c                                  |    4 
 drivers/i2c/busses/i2c-stm32f7.c                                    |    6 
 drivers/i2c/busses/i2c-synquacer.c                                  |   12 
 drivers/i2c/busses/i2c-xiic.c                                       |   69 
 drivers/i2c/i2c-core-base.c                                         |   39 
 drivers/i3c/master/svc-i3c-master.c                                 |    1 
 drivers/iio/magnetometer/ak8975.c                                   |   32 
 drivers/iio/pressure/bmp280-core.c                                  |  185 
 drivers/iio/pressure/bmp280-regmap.c                                |   47 
 drivers/iio/pressure/bmp280-spi.c                                   |    4 
 drivers/iio/pressure/bmp280.h                                       |   49 
 drivers/infiniband/hw/mana/main.c                                   |    8 
 drivers/input/keyboard/adp5589-keys.c                               |   22 
 drivers/iommu/intel/dmar.c                                          |   16 
 drivers/iommu/intel/iommu.c                                         |    6 
 drivers/iommu/iommufd/selftest.c                                    |   27 
 drivers/mailbox/bcm2835-mailbox.c                                   |    3 
 drivers/mailbox/rockchip-mailbox.c                                  |    2 
 drivers/media/i2c/ar0521.c                                          |    5 
 drivers/media/i2c/imx335.c                                          |   43 
 drivers/media/i2c/ov5675.c                                          |   12 
 drivers/media/platform/qcom/camss/camss-video.c                     |    6 
 drivers/media/platform/qcom/camss/camss.c                           |    5 
 drivers/media/platform/qcom/venus/core.c                            |    1 
 drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c                  |    5 
 drivers/media/usb/usbtv/usbtv-video.c                               |    7 
 drivers/memory/tegra/tegra186-emc.c                                 |    5 
 drivers/net/can/dev/netlink.c                                       |  102 
 drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c                 |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c                   |    2 
 drivers/net/ethernet/freescale/fec.h                                |    9 
 drivers/net/ethernet/freescale/fec_main.c                           |   11 
 drivers/net/ethernet/freescale/fec_ptp.c                            |   50 
 drivers/net/ethernet/hisilicon/hip04_eth.c                          |    1 
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c                   |    1 
 drivers/net/ethernet/hisilicon/hns_mdio.c                           |    1 
 drivers/net/ethernet/intel/e1000e/netdev.c                          |   19 
 drivers/net/ethernet/intel/ice/ice_sched.c                          |    6 
 drivers/net/ethernet/lantiq_etop.c                                  |    4 
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h                          |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/tir.c                    |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c            |    8 
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c                     |    1 
 drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c               |   10 
 drivers/net/ethernet/microchip/sparx5/sparx5_packet.c               |    6 
 drivers/net/ethernet/microsoft/Kconfig                              |    3 
 drivers/net/ethernet/microsoft/mana/gdma_main.c                     |   10 
 drivers/net/ethernet/microsoft/mana/hw_channel.c                    |   14 
 drivers/net/ethernet/microsoft/mana/mana_en.c                       |    8 
 drivers/net/ethernet/microsoft/mana/shm_channel.c                   |   13 
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c                 |    5 
 drivers/net/ethernet/realtek/r8169_main.c                           |   31 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c                   |   18 
 drivers/net/ethernet/stmicro/stmmac/stmmac.h                        |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c                    |    8 
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c                     |   19 
 drivers/net/ieee802154/Kconfig                                      |    1 
 drivers/net/ieee802154/mcr20a.c                                     |    5 
 drivers/net/pcs/pcs-xpcs-wx.c                                       |    2 
 drivers/net/ppp/ppp_generic.c                                       |    4 
 drivers/net/vrf.c                                                   |    2 
 drivers/net/wireless/ath/ath11k/dp_rx.c                             |    2 
 drivers/net/wireless/ath/ath12k/dp_rx.c                             |    2 
 drivers/net/wireless/ath/ath9k/debug.c                              |    4 
 drivers/net/wireless/ath/ath9k/hif_usb.c                            |    6 
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h                    |   13 
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c                   |   16 
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c                    |   12 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c                       |   42 
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c                         |   12 
 drivers/net/wireless/marvell/mwifiex/fw.h                           |    2 
 drivers/net/wireless/marvell/mwifiex/scan.c                         |    3 
 drivers/net/wireless/mediatek/mt76/mt7915/init.c                    |    1 
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c                     |    4 
 drivers/net/wireless/mediatek/mt76/mt7915/main.c                    |    7 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                     |   10 
 drivers/net/wireless/realtek/rtw88/Kconfig                          |    1 
 drivers/net/wireless/realtek/rtw89/mac80211.c                       |    4 
 drivers/net/wireless/realtek/rtw89/phy.c                            |    4 
 drivers/net/wireless/realtek/rtw89/util.h                           |   18 
 drivers/net/wwan/qcom_bam_dmux.c                                    |   11 
 drivers/net/xen-netback/hash.c                                      |    5 
 drivers/of/address.c                                                |    5 
 drivers/of/irq.c                                                    |   38 
 drivers/perf/arm_spe_pmu.c                                          |    9 
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c         |    4 
 drivers/platform/x86/lenovo-ymc.c                                   |    2 
 drivers/platform/x86/think-lmi.c                                    |   16 
 drivers/platform/x86/touchscreen_dmi.c                              |   26 
 drivers/platform/x86/x86-android-tablets/core.c                     |   57 
 drivers/power/reset/brcmstb-reboot.c                                |    3 
 drivers/power/supply/power_supply_hwmon.c                           |    3 
 drivers/remoteproc/ti_k3_r5_remoteproc.c                            |   86 
 drivers/rtc/rtc-at91sam9.c                                          |    1 
 drivers/scsi/NCR5380.c                                              |    4 
 drivers/scsi/aacraid/aacraid.h                                      |    2 
 drivers/scsi/lpfc/lpfc_els.c                                        |   27 
 drivers/scsi/lpfc/lpfc_nportdisc.c                                  |   22 
 drivers/scsi/pm8001/pm8001_init.c                                   |    6 
 drivers/scsi/smartpqi/smartpqi_init.c                               |    2 
 drivers/scsi/st.c                                                   |    5 
 drivers/spi/spi-bcm63xx.c                                           |    9 
 drivers/spi/spi-cadence.c                                           |   31 
 drivers/spi/spi-imx.c                                               |    2 
 drivers/spi/spi-rpc-if.c                                            |    7 
 drivers/spi/spi-s3c64xx.c                                           |    4 
 drivers/vhost/scsi.c                                                |   27 
 drivers/video/fbdev/efifb.c                                         |   11 
 drivers/video/fbdev/pxafb.c                                         |    1 
 fs/btrfs/backref.c                                                  |   12 
 fs/btrfs/disk-io.c                                                  |   11 
 fs/btrfs/relocation.c                                               |  150 
 fs/btrfs/relocation.h                                               |    9 
 fs/btrfs/send.c                                                     |   23 
 fs/cachefiles/namei.c                                               |    7 
 fs/ceph/addr.c                                                      |    6 
 fs/dax.c                                                            |    6 
 fs/exec.c                                                           |    3 
 fs/exfat/balloc.c                                                   |   10 
 fs/ext4/dir.c                                                       |   14 
 fs/ext4/extents.c                                                   |   55 
 fs/ext4/fast_commit.c                                               |   49 
 fs/ext4/file.c                                                      |    8 
 fs/ext4/inode.c                                                     |   11 
 fs/ext4/migrate.c                                                   |    2 
 fs/ext4/move_extent.c                                               |    1 
 fs/ext4/namei.c                                                     |   14 
 fs/ext4/super.c                                                     |    2 
 fs/ext4/xattr.c                                                     |    3 
 fs/file.c                                                           |   95 
 fs/iomap/buffered-io.c                                              |   16 
 fs/jbd2/checkpoint.c                                                |   21 
 fs/jbd2/journal.c                                                   |    4 
 fs/jfs/jfs_discard.c                                                |   11 
 fs/jfs/jfs_dmap.c                                                   |    7 
 fs/jfs/xattr.c                                                      |    2 
 fs/nfsd/nfs4state.c                                                 |    5 
 fs/nfsd/nfs4xdr.c                                                   |   10 
 fs/nfsd/vfs.c                                                       |    1 
 fs/ocfs2/aops.c                                                     |    5 
 fs/ocfs2/buffer_head_io.c                                           |    4 
 fs/ocfs2/journal.c                                                  |    7 
 fs/ocfs2/localalloc.c                                               |   19 
 fs/ocfs2/quota_local.c                                              |    8 
 fs/ocfs2/refcounttree.c                                             |   26 
 fs/ocfs2/xattr.c                                                    |   11 
 fs/overlayfs/params.c                                               |   38 
 fs/proc/base.c                                                      |   61 
 fs/smb/client/cifsfs.c                                              |   13 
 fs/smb/client/cifsglob.h                                            |    2 
 fs/smb/client/inode.c                                               |   19 
 fs/smb/client/reparse.c                                             |   16 
 fs/smb/client/smb1ops.c                                             |    2 
 fs/smb/client/smb2inode.c                                           |   24 
 fs/smb/client/smb2ops.c                                             |   19 
 fs/smb/server/connection.c                                          |    4 
 fs/smb/server/connection.h                                          |    1 
 fs/smb/server/oplock.c                                              |   55 
 fs/smb/server/vfs_cache.c                                           |    3 
 include/crypto/internal/simd.h                                      |   12 
 include/drm/drm_print.h                                             |   54 
 include/dt-bindings/clock/exynos7885.h                              |    2 
 include/dt-bindings/clock/qcom,gcc-sc8180x.h                        |    3 
 include/linux/cpufreq.h                                             |    6 
 include/linux/fdtable.h                                             |    8 
 include/linux/i2c.h                                                 |    5 
 include/linux/netdevice.h                                           |   18 
 include/linux/perf_event.h                                          |    8 
 include/linux/stmmac.h                                              |    1 
 include/linux/uprobes.h                                             |    2 
 include/linux/virtio_net.h                                          |    4 
 include/net/mana/gdma.h                                             |   10 
 include/net/mana/mana.h                                             |    3 
 include/uapi/linux/cec.h                                            |    6 
 include/uapi/linux/netfilter/nf_tables.h                            |    2 
 io_uring/net.c                                                      |    4 
 kernel/bpf/verifier.c                                               |   26 
 kernel/events/core.c                                                |   33 
 kernel/events/uprobes.c                                             |    4 
 kernel/fork.c                                                       |   32 
 kernel/jump_label.c                                                 |   52 
 kernel/rcu/rcuscale.c                                               |    4 
 kernel/resource.c                                                   |   58 
 kernel/sched/psi.c                                                  |   26 
 kernel/static_call_inline.c                                         |   13 
 kernel/trace/trace_hwlat.c                                          |    2 
 kernel/trace/trace_osnoise.c                                        |   22 
 lib/buildid.c                                                       |   90 
 mm/Kconfig                                                          |   25 
 mm/slab_common.c                                                    |    7 
 net/bluetooth/hci_core.c                                            |    2 
 net/bluetooth/hci_event.c                                           |   15 
 net/bluetooth/hci_sock.c                                            |   21 
 net/bluetooth/iso.c                                                 |   36 
 net/bluetooth/l2cap_core.c                                          |    8 
 net/bluetooth/l2cap_sock.c                                          |   52 
 net/bluetooth/mgmt.c                                                |   23 
 net/core/dev.c                                                      |   14 
 net/core/gro.c                                                      |    9 
 net/core/netpoll.c                                                  |   15 
 net/dsa/slave.c                                                     |    7 
 net/ipv4/devinet.c                                                  |    6 
 net/ipv4/fib_frontend.c                                             |    2 
 net/ipv4/ip_gre.c                                                   |    6 
 net/ipv4/netfilter/nf_dup_ipv4.c                                    |    7 
 net/ipv4/tcp_ipv4.c                                                 |    3 
 net/ipv4/udp_offload.c                                              |   22 
 net/ipv6/netfilter/nf_dup_ipv6.c                                    |    7 
 net/mac80211/chan.c                                                 |    4 
 net/mac80211/mlme.c                                                 |    2 
 net/mac80211/scan.c                                                 |    2 
 net/mac80211/util.c                                                 |    4 
 net/mac802154/scan.c                                                |    4 
 net/netfilter/nf_tables_api.c                                       |   57 
 net/netfilter/nft_set_bitmap.c                                      |    4 
 net/netfilter/nft_set_hash.c                                        |    8 
 net/netfilter/nft_set_pipapo.c                                      |    5 
 net/netfilter/nft_set_rbtree.c                                      |    4 
 net/rxrpc/ar-internal.h                                             |    2 
 net/rxrpc/io_thread.c                                               |   10 
 net/rxrpc/local_object.c                                            |    2 
 net/sched/sch_taprio.c                                              |    4 
 net/sctp/socket.c                                                   |    4 
 net/tipc/bearer.c                                                   |    8 
 net/wireless/nl80211.c                                              |   15 
 rust/kernel/sync/locked_by.rs                                       |   18 
 scripts/kconfig/qconf.cc                                            |    2 
 security/Kconfig                                                    |   32 
 security/tomoyo/domain.c                                            |    9 
 sound/core/init.c                                                   |   14 
 sound/core/oss/mixer_oss.c                                          |    4 
 sound/isa/gus/gus_pcm.c                                             |    4 
 sound/pci/asihpi/hpimsgx.c                                          |    2 
 sound/pci/hda/hda_controller.h                                      |    2 
 sound/pci/hda/hda_generic.c                                         |    4 
 sound/pci/hda/hda_intel.c                                           |   10 
 sound/pci/hda/patch_conexant.c                                      |   24 
 sound/pci/hda/patch_realtek.c                                       |    4 
 sound/pci/rme9652/hdsp.c                                            |    6 
 sound/pci/rme9652/hdspm.c                                           |    6 
 sound/soc/atmel/mchp-pdmc.c                                         |    3 
 sound/soc/codecs/wsa883x.c                                          |   16 
 sound/soc/fsl/imx-card.c                                            |    1 
 sound/usb/card.c                                                    |    6 
 sound/usb/line6/podhd.c                                             |    2 
 sound/usb/mixer.c                                                   |   35 
 sound/usb/mixer.h                                                   |    1 
 sound/usb/quirks-table.h                                            | 2287 ++--------
 sound/usb/quirks.c                                                  |    4 
 tools/arch/x86/kcpuid/kcpuid.c                                      |   12 
 tools/bpf/bpftool/net.c                                             |   11 
 tools/include/nolibc/arch-powerpc.h                                 |    2 
 tools/perf/util/hist.c                                              |    7 
 tools/perf/util/machine.c                                           |   17 
 tools/perf/util/setup.py                                            |    4 
 tools/perf/util/thread.c                                            |    4 
 tools/perf/util/thread.h                                            |    1 
 tools/testing/selftests/breakpoints/step_after_suspend_test.c       |    5 
 tools/testing/selftests/hid/Makefile                                |    2 
 tools/testing/selftests/mm/charge_reserved_hugetlb.sh               |    2 
 tools/testing/selftests/mm/write_to_hugetlbfs.c                     |   21 
 tools/testing/selftests/netfilter/nft_audit.sh                      |   57 
 tools/testing/selftests/nolibc/nolibc-test.c                        |    4 
 tools/testing/selftests/vDSO/parse_vdso.c                           |   17 
 tools/testing/selftests/vDSO/vdso_config.h                          |   10 
 tools/testing/selftests/vDSO/vdso_test_correctness.c                |    6 
 tools/tracing/rtla/src/osnoise_top.c                                |    2 
 tools/tracing/rtla/src/timerlat_top.c                               |    4 
 387 files changed, 4126 insertions(+), 3851 deletions(-)

Aakash Menon (1):
      net: sparx5: Fix invalid timestamps

Abhishek Tamboli (1):
      ALSA: hda/realtek: Add a quirk for HP Pavilion 15z-ec200

Adrian Ratiu (1):
      proc: add config & param to block forcing mem writes

Ahmed S. Darwish (1):
      tools/x86/kcpuid: Protect against faulty "max subleaf" values

Ai Chao (1):
      ALSA: hda/realtek: Add quirk for Huawei MateBook 13 KLV-WX9

Ajit Pandey (1):
      clk: qcom: clk-alpha-pll: Fix CAL_L_VAL override for LUCID EVO PLL

Al Viro (1):
      close_range(): fix the logics in descriptor table trimming

Aleksander Jan Bajkowski (1):
      net: ethernet: lantiq_etop: fix memory disclosure

Aleksandr Mishin (1):
      ice: Adjust over allocation of memory in ice_sched_add_root_node() and ice_sched_add_node()

Aleksandrs Vinarskis (1):
      ACPICA: iasl: handle empty connection_node

Alex Deucher (3):
      drm/amdgpu/gfx9: use rlc safe mode for soft recovery
      drm/amdgpu/gfx11: use rlc safe mode for soft recovery
      drm/amdgpu/gfx10: use rlc safe mode for soft recovery

Alex Hung (7):
      drm/amd/display: Check null pointers before using dc->clk_mgr
      drm/amd/display: Check stream before comparing them
      drm/amd/display: Check link_res->hpo_dp_link_enc before using it
      drm/amd/display: Avoid overflow assignment in link_dp_cts
      drm/amd/display: Initialize get_bytes_per_element's default to 1
      drm/amd/display: Add HDR workaround for specific eDP
      drm/amd/display: enable_hpo_dp_link_output: Check link_res->hpo_dp_link_enc before using it

Alexander F. Lent (1):
      accel/ivpu: Add missing MODULE_FIRMWARE metadata

Alexander Shiyan (1):
      media: i2c: ar0521: Use cansleep version of gpiod_set_value()

Alexandre Ghiti (1):
      riscv: Fix kernel stack size when KASAN is enabled

Alexey Dobriyan (1):
      build-id: require program headers to be right after ELF header

Alice Ryhl (1):
      rust: sync: require `T: Sync` for `LockedBy::access`

Andrei Simion (1):
      ASoC: atmel: mchp-pdmc: Skip ALSA restoration if substream runtime is uninitialized

Andrew Davis (1):
      power: reset: brcmstb: Do not go into infinite loop if reset fails

Andrew Jones (1):
      of/irq: Support #msi-cells=<0> in of_msi_get_domain

Andrii Nakryiko (2):
      perf,x86: avoid missing caller address in stack traces captured in uprobe
      lib/buildid: harden build ID parsing logic

Angel Iglesias (1):
      iio: pressure: bmp280: Allow multiple chips id per family of devices

Anton Danilov (1):
      ipv4: ip_gre: Fix drops of small packets in ipgre_xmit

Ard Biesheuvel (1):
      i2c: synquacer: Deal with optional PCLK correctly

Armin Wolf (4):
      ACPICA: Fix memory leak if acpi_ps_get_next_namepath() fails
      ACPICA: Fix memory leak if acpi_ps_get_next_field() fails
      ACPI: battery: Simplify battery hook locking
      ACPI: battery: Fix possible crash when unregistering a battery hook

Arnaldo Carvalho de Melo (2):
      perf python: Disable -Wno-cast-function-type-mismatch if present on clang
      perf python: Allow checking for the existence of warning options in clang

Artem Sadovnikov (1):
      ext4: fix i_data_sem unlock order in ext4_ind_migrate()

Aruna Ramakrishna (2):
      x86/pkeys: Add PKRU as a parameter in signal handling functions
      x86/pkeys: Restore altstack access in sigreturn()

Asad Kamal (1):
      drm/amdgpu: Fix get each xcp macro

Baojun Xu (1):
      ALSA: hda/tas2781: Add new quirk for Lenovo Y990 Laptop

Baokun Li (9):
      ext4: avoid use-after-free in ext4_ext_show_leaf()
      ext4: fix slab-use-after-free in ext4_split_extent_at()
      ext4: propagate errors from ext4_find_extent() in ext4_insert_range()
      ext4: drop ppath from ext4_ext_replay_update_ex() to avoid double-free
      ext4: aovid use-after-free in ext4_ext_insert_extent()
      ext4: fix double brelse() the buffer of the extents path
      ext4: update orig_path in ext4_find_extent()
      jbd2: stop waiting for space when jbd2_cleanup_journal_tail() returns error
      cachefiles: fix dentry leak in cachefiles_open_file()

Barnabás Czémán (1):
      iio: magnetometer: ak8975: Fix reading for ak099xx sensors

Beleswar Padhi (1):
      remoteproc: k3-r5: Acquire mailbox handle during probe routine

Ben Dooks (1):
      spi: s3c64xx: fix timeout counters in flush_fifo

Benjamin Gaignard (1):
      media: usbtv: Remove useless locks in usbtv_video_free()

Benjamin Lin (1):
      wifi: mt76: mt7915: add dummy HW offload of IEEE 802.11 fragmentation

Biju Das (1):
      spi: rpc-if: Add missing MODULE_DEVICE_TABLE

Breno Leitao (1):
      netpoll: Ensure clean state on setup failures

Bryan O'Donoghue (3):
      media: ov5675: Fix power on/off delay timings
      media: qcom: camss: Remove use_count guard in stop_streaming
      media: qcom: camss: Fix ordering of pm_runtime_enable

Chen Yu (1):
      efi/unaccepted: touch soft lockup during memory accept

Chih-Kang Chang (1):
      wifi: rtw89: avoid to add interface to list twice when SER

Christoph Hellwig (2):
      loop: don't set QUEUE_FLAG_NOMERGES
      iomap: handle a post-direct I/O invalidate race in iomap_write_delalloc_release

Christophe JAILLET (4):
      ALSA: mixer_oss: Remove some incorrect kfree_const() usages
      ALSA: gus: Fix some error handling paths related to get_bpos() usage
      i2c: synquacer: Remove a clk reference from struct synquacer_i2c
      null_blk: Remove usage of the deprecated ida_simple_xx() API

Christophe Leroy (4):
      selftests: vDSO: fix vDSO name for powerpc
      selftests: vDSO: fix vdso_config for powerpc
      selftests: vDSO: fix vDSO symbols lookup for powerpc64
      powerpc/vdso: Fix VDSO data access when running in a non-root time namespace

Chuck Lever (1):
      NFSD: Fix NFSv4's PUTPUBFH operation

Chun-Yi Lee (1):
      aoe: fix the potential use-after-free problem in more places

Ckath (1):
      platform/x86: touchscreen_dmi: add nanote-next quirk

Colin Ian King (1):
      r8169: Fix spelling mistake: "tx_underun" -> "tx_underrun"

Csókás, Bence (2):
      net: fec: Restart PPS after link state change
      net: fec: Reload PTP registers after link-state change

Damien Le Moal (3):
      ata: pata_serverworks: Do not use the term blacklist
      ata: sata_sil: Rename sil_blacklist to sil_quirks
      null_blk: Fix return value of nullb_device_power_store()

Daniel Borkmann (2):
      net: Add netif_get_gro_max_size helper for GRO
      net: Fix gso_features_check to check for both dev->gso_{ipv4_,}max_size

Daniel Wagner (1):
      scsi: pm8001: Do not overwrite PCI queue mapping

Danilo Krummrich (1):
      mm: krealloc: consider spare memory for __GFP_ZERO

Darrick J. Wong (1):
      iomap: constrain the file range passed to iomap_file_unshare

David Hildenbrand (1):
      selftests/mm: fix charge_reserved_hugetlb.sh test

David Howells (1):
      rxrpc: Fix a race between socket set up and I/O thread creation

David Sterba (2):
      btrfs: relocation: return bool from btrfs_should_ignore_reloc_root
      btrfs: relocation: constify parameters where possible

David Virag (2):
      dt-bindings: clock: exynos7885: Fix duplicated binding
      clk: samsung: exynos7885: Update CLKS_NR_FSYS after bindings fix

Denis Pauk (1):
      hwmon: (nct6775) add G15CF to ASUS WMI monitoring list

Dmitry Antipov (1):
      net: sched: consistently use rcu_replace_pointer() in taprio_change()

Dmitry Baryshkov (1):
      clk: qcom: dispcc-sm8250: use CLK_SET_RATE_PARENT for branch clocks

Dmitry Kandybka (1):
      wifi: ath9k: fix possible integer overflow in ath9k_get_et_stats()

Easwar Hariharan (1):
      arm64: Subscribe Microsoft Azure Cobalt 100 to erratum 3194386

Eder Zulian (1):
      rtla: Fix the help text in osnoise and timerlat top tools

Edward Adam Davis (3):
      jfs: Fix uaf in dbFreeBits
      jfs: check if leafidx greater than num leaves per dmap tree
      ext4: no need to continue when the number of entries is 1

Elena Salomatkina (1):
      net/mlx5e: Fix NULL deref in mlx5e_tir_builder_alloc()

Emanuele Ghidoli (1):
      gpio: davinci: fix lazy disable

Eric Dumazet (5):
      netfilter: nf_tables: prevent nf_skb_duplicated corruption
      net: avoid potential underflow in qdisc_pkt_len_init() with UFO
      net: add more sanity checks to qdisc_pkt_len_init()
      net: test for not too small csum_start in virtio_net_hdr_to_skb()
      ppp: do not assume bh is held in ppp_channel_bridge_input()

Fangrui Song (1):
      crypto: x86/sha256 - Add parentheses around macros' single arguments

Felix Fietkau (2):
      wifi: mt76: mt7915: disable tx worker during tx BA session enable/disable
      wifi: mt76: mt7915: hold dev->mt76.mutex while disabling tx worker

Filipe Manana (2):
      btrfs: send: fix invalid clone operation for file that got its size decreased
      btrfs: wait for fixup workers before stopping cleaner kthread during umount

Finn Thain (1):
      scsi: NCR5380: Initialize buffer for MSG IN and STATUS transfers

Gabe Teeger (1):
      drm/amd/display: Revert Avoid overflow assignment

Gautham Ananthakrishna (1):
      ocfs2: reserve space for inline xattr before attaching reflink tree

Geert Uytterhoeven (2):
      drm/radeon/r100: Handle unknown family in r100_cp_init_microcode()
      of/irq: Refer to actual buffer size in of_irq_parse_one()

Gerd Bayer (1):
      net/mlx5: Fix error path in multi-packet WQE transmit

Gergo Koteles (1):
      platform/x86: lenovo-ymc: Ignore the 0x0 state

Greg Kroah-Hartman (1):
      Linux 6.6.55

Gustavo A. R. Silva (1):
      wifi: mwifiex: Fix memcpy() field-spanning write warning in mwifiex_cmd_802_11_scan_ext()

Haiyang Zhang (2):
      net: mana: Enable MANA driver on ARM64 with 4K page size
      net: mana: Add support for page sizes other than 4KB on ARM64

Hans P. Moller (1):
      ALSA: line6: add hw monitor volume control to POD HD500X

Hans Verkuil (1):
      media: uapi/linux/cec.h: cec_msg_set_reply_to: zero flags

Hans de Goede (7):
      ACPI: video: Add force_vendor quirk for Panasonic Toughbook CF-18
      HID: Ignore battery for all ELAN I2C-HID devices
      power: supply: hwmon: Fix missing temp1_max_alarm attribute
      ACPI: resource: Add Asus Vivobook X1704VAP to irq1_level_low_skip_override[]
      ACPI: resource: Add Asus ExpertBook B2502CVA to irq1_level_low_skip_override[]
      platform/x86: x86-android-tablets: Create a platform_device from module_init()
      platform/x86: x86-android-tablets: Fix use after free on platform_device_register() errors

Haoran Zhang (1):
      vhost/scsi: null-ptr-dereference in vhost_scsi_get_req()

Haren Myneni (1):
      powerpc/pseries: Use correct data types from pseries_hp_errorlog struct

Heiko Carstens (1):
      selftests: vDSO: fix vdso_config for s390

Heiner Kallweit (2):
      i2c: core: Lock address during client device instantiation
      r8169: add tally counter fields added with RTL8125

Helge Deller (4):
      parisc: Fix itlb miss handler for 64-bit programs
      parisc: Fix 64-bit userspace syscall path
      parisc: Allow mmap(MAP_STACK) memory to automatically expand upwards
      parisc: Fix stack start for ADDR_NO_RANDOMIZE personality

Heming Zhao (1):
      ocfs2: fix the la space leak when unmounting an ocfs2 volume

Herbert Xu (4):
      crypto: octeontx - Fix authenc setkey
      crypto: octeontx2 - Fix authenc setkey
      crypto: simd - Do not call crypto_alloc_tfm during registration
      crypto: octeontx* - Select CRYPTO_AUTHENC

Hilda Wu (2):
      Bluetooth: btusb: Add Realtek RTL8852C support ID 0x0489:0xe122
      Bluetooth: btrtl: Set msft ext address filter quirk for RTL8852B

Huang Ying (1):
      resource: fix region_intersects() vs add_memory_driver_managed()

Hui Wang (1):
      ASoC: imx-card: Set card.owner to avoid a warning calltrace if SND=m

Ian Rogers (1):
      perf callchain: Fix stitch LBR memory leaks

Ido Schimmel (1):
      ipv4: Mask upper DSCP bits and ECN bits in NETLINK_FIB_LOOKUP family

Ilan Peer (1):
      wifi: iwlwifi: mvm: Fix a race in scan abort flow

Issam Hamdi (1):
      wifi: cfg80211: Set correct chandef when starting CAC

James Clark (1):
      drivers/perf: arm_spe: Use perf_allow_kernel() for permissions

Jan Kiszka (1):
      remoteproc: k3-r5: Fix error handling when power-up failed

Jan Lalinsky (1):
      ALSA: usb-audio: Add native DSD support for Luxman D-08u

Jani Nikula (1):
      drm/i915/gem: fix bitwise and logical AND mixup

Jaroslav Kysela (1):
      ALSA: core: add isascii() check to card ID generator

Jason Xing (1):
      tcp: avoid reusing FIN_WAIT2 when trying to find port in connect() process

Javier Carrasco (1):
      drm/mediatek: ovl_adaptor: Add missing of_node_put()

Jens Axboe (1):
      io_uring/net: harden multishot termination case for recv

Jens Remus (1):
      selftests: vDSO: fix ELF hash table entry size for s390x

Jeongjun Park (1):
      net/xen-netback: prevent UAF in xenvif_flush_hash()

Jesse Zhang (1):
      drm/amdkfd: Fix resource leak in criu restore queue

Jianbo Liu (1):
      net/mlx5e: Fix crash caused by calling __xfrm_state_delete() twice

Jiawei Ye (1):
      mac802154: Fix potential RCU dereference issue in mac802154_scan_worker

Jiawen Wu (1):
      net: pcs: xpcs: fix the wrong register that was written back

Jinjie Ruan (12):
      ieee802154: Fix build error
      net: ieee802154: mcr20a: Use IRQF_NO_AUTOEN flag in request_irq()
      net: wwan: qcom_bam_dmux: Fix missing pm_runtime_disable()
      Bluetooth: btmrvl: Use IRQF_NO_AUTOEN flag in request_irq()
      nfp: Use IRQF_NO_AUTOEN flag in request_irq()
      spi: spi-imx: Fix pm_runtime_set_suspended() with runtime pm enabled
      spi: spi-cadence: Fix pm_runtime_set_suspended() with runtime pm enabled
      spi: spi-cadence: Fix missing spi_controller_is_target() check
      i2c: qcom-geni: Use IRQF_NO_AUTOEN flag in request_irq()
      i2c: xiic: Fix pm_runtime_set_suspended() with runtime pm enabled
      spi: bcm63xx: Fix module autoloading
      spi: bcm63xx: Fix missing pm_runtime_disable()

Jisheng Zhang (1):
      riscv: define ILLEGAL_POINTER_VALUE for 64bit

Johannes Berg (3):
      wifi: iwlwifi: mvm: drop wrong STA selection in TX
      wifi: iwlwifi: mvm: use correct key iteration
      wifi: mac80211: fix RCU list iterations

Johannes Weiner (1):
      sched: psi: fix bogus pressure spikes from aggregation race

Jonathan Gray (1):
      Revert "drm/amd/display: Skip Recompute DSC Params if no Stream on Link"

Josef Bacik (1):
      btrfs: drop the backref cache during relocation if we commit

Joseph Qi (2):
      ocfs2: fix uninit-value in ocfs2_get_block()
      ocfs2: cancel dqi_sync_work before freeing oinfo

Joshua Pius (1):
      ALSA: usb-audio: Add logitech Audio profile quirk

Julian Sun (1):
      ocfs2: fix null-ptr-deref when journal load failed.

Juntong Deng (1):
      bpf: Make the pointer returned by iter next method valid

Justin Tee (1):
      scsi: lpfc: Update PRLO handling in direct attached topology

Kaixin Wang (2):
      fbdev: pxafb: Fix possible use after free in pxafb_task()
      i3c: master: svc: Fix use after free vulnerability in svc_i3c_master Driver Due to Race Condition

Karthikeyan Periyasamy (2):
      wifi: ath12k: fix array out-of-bound access in SoC stats
      wifi: ath11k: fix array out-of-bound access in SoC stats

Katya Orlova (1):
      drm/stm: Avoid use-after-free issues with crtc and plane

Kees Cook (2):
      x86/syscall: Avoid memcpy() for ia32 syscall_get_arguments()
      scsi: aacraid: Rearrange order of struct aac_srb_unit

Kemeng Shi (1):
      jbd2: correctly compare tids with tid_geq function in jbd2_fc_begin_commit

KhaiWenTan (1):
      net: stmmac: Fix zero-division error when disabling tc cbs

Kieran Bingham (1):
      media: i2c: imx335: Enable regulator supplies

Kimriver Liu (1):
      i2c: designware: fix controller is holding SCL low while ENABLE bit is disabled

Konrad Dybcio (1):
      drm/msm/adreno: Assign msm_gpu->pdev earlier to avoid nullptrs

Konstantin Ovsepian (1):
      blk_iocost: fix more out of bound shifts

Krzysztof Kozlowski (7):
      net: hisilicon: hip04: fix OF node leak in probe()
      net: hisilicon: hns_dsaf_mac: fix OF node leak in hns_mac_get_info()
      net: hisilicon: hns_mdio: fix OF node leak in probe()
      ASoC: codecs: wsa883x: Handle reading version failure
      firmware: tegra: bpmp: Drop unused mbox_client_to_bpmp()
      memory: tegra186-emc: drop unused to_tegra186_emc()
      rtc: at91sam9: fix OF node leak in probe() error path

Kuan-Wei Chiu (2):
      bpftool: Fix undefined behavior caused by shifting into the sign bit
      bpftool: Fix undefined behavior in qsort(NULL, 0, ...)

Kuniyuki Iwashima (1):
      ipv4: Check !in_dev earlier for ioctl(SIOCSIFADDR).

Laurent Pinchart (1):
      media: sun4i_csi: Implement link validate for sun4i_csi subdev

Li Lingfeng (1):
      nfsd: map the EBADMSG to nfserr_io to avoid warning

Li Zetao (1):
      spi: spi-cadence: Use helper function devm_clk_get_enabled()

Lianqin Hu (1):
      ALSA: usb-audio: Add delay quirk for VIVO USB-C HEADSET

Liao Chen (1):
      mailbox: rockchip: fix a typo in module autoloading

Lizhi Xu (2):
      ocfs2: remove unreasonable unlock in ocfs2_read_blocks
      ocfs2: fix possible null-ptr-deref in ocfs2_set_buffer_uptodate

Long Li (2):
      RDMA/mana_ib: use the correct page size for mapping user-mode doorbell page
      RDMA/mana_ib: use the correct page table index based on hardware page size

Lu Baolu (1):
      iommu/vt-d: Always reserve a domain ID for identity setup

Luis Henriques (SUSE) (7):
      ext4: fix incorrect tid assumption in ext4_fc_mark_ineligible()
      ext4: fix incorrect tid assumption in __jbd2_log_wait_for_space()
      ext4: fix incorrect tid assumption in ext4_wait_for_tail_page_commit()
      ext4: fix incorrect tid assumption in jbd2_journal_shrink_checkpoint_list()
      ext4: fix fast commit inode enqueueing during a full journal commit
      ext4: use handle to mark fc as ineligible in __track_dentry_update()
      ext4: mark fc as ineligible using an handle in ext4_xattr_set()

Luiz Augusto von Dentz (6):
      Bluetooth: MGMT: Fix possible crash on mgmt_index_removed
      Bluetooth: L2CAP: Fix uaf in l2cap_connect
      Bluetooth: hci_sock: Fix not validating setsockopt user input
      Bluetooth: ISO: Fix not validating setsockopt user input
      Bluetooth: L2CAP: Fix not validating setsockopt user input
      Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE

Luo Gengkun (1):
      perf/core: Fix small negative period being ignored

Ma Ke (1):
      drm: omapdrm: Add missing check for alloc_ordered_workqueue

Mads Bligaard Nielsen (1):
      drm/bridge: adv7511: fix crash on irq during probe

Mahesh Rajashekhara (1):
      scsi: smartpqi: correct stream detection

Manivannan Sadhasivam (3):
      clk: qcom: gcc-sm8450: Do not turn off PCIe GDSCs during gdsc_disable()
      clk: qcom: gcc-sm8250: Do not turn off PCIe GDSCs during gdsc_disable()
      dt-bindings: clock: qcom: Add missing UFS QREF clocks

Marc Ferland (1):
      i2c: xiic: improve error message when transfer fails to start

Marek Vasut (1):
      i2c: stm32f7: Do not prepare/unprepare clock during runtime suspend/resume

Mario Limonciello (2):
      ACPI: CPPC: Add support for setting EPP register in FFH
      drm/amd/display: Allow backlight to go below `AMDGPU_DM_DEFAULT_MIN_BACKLIGHT`

Mark Pearson (1):
      platform/x86: think-lmi: Fix password opcode ordering for workstations

Mark Rutland (3):
      arm64: fix selection of HAVE_DYNAMIC_FTRACE_WITH_ARGS
      arm64: cputype: Add Neoverse-N3 definitions
      arm64: errata: Expand speculative SSBS workaround once more

Masahiro Yamada (1):
      kconfig: qconf: fix buffer overflow in debug links

Matt Fleming (1):
      perf hist: Update hist symbol when updating maps

Matthew Brost (1):
      drm/printer: Allow NULL data in devcoredump printer

Mike Baynton (1):
      ovl: fail if trusted xattrs are needed but caller lacks permission

Mike Tipton (1):
      clk: qcom: clk-rpmh: Fix overflow in BCM vote

Miquel Sabaté Solà (1):
      cpufreq: Avoid a bad reference count on CPU node

Miri Korenblit (1):
      wifi: iwlwifi: mvm: avoid NULL pointer dereference

Mohamed Khalfella (1):
      net/mlx5: Added cond_resched() to crdump collection

Namhyung Kim (2):
      perf: Really fix event_function_call() locking
      perf report: Fix segfault when 'sym' sort key is not used

Namjae Jeon (1):
      ksmbd: add refcnt to ksmbd_conn struct

NeilBrown (1):
      nfsd: fix delegation_blocked() to block correctly for at least 30 seconds

Nicolin Chen (1):
      iommufd: Fix protection fault in iommufd_test_syz_conv_iova

Nuno Sa (2):
      Input: adp5589-keys - fix NULL pointer dereference
      Input: adp5589-keys - fix adp5589_gpio_get_value()

Oder Chiou (1):
      ALSA: hda/realtek: Fix the push button function for the ALC257

Oleg Nesterov (1):
      uprobes: fix kernel info leak via "[uprobes]" vma

Pablo Neira Ayuso (2):
      netfilter: nf_tables: fix memleak in map from abort path
      netfilter: nf_tables: restore set elements when delete set fails

Pali Rohár (3):
      cifs: Remove intermediate object of failed create reparse call
      cifs: Fix buffer overflow when parsing NFS reparse points
      cifs: Do not convert delimiter when parsing NFS-style symlinks

Patrick Donnelly (1):
      ceph: fix cap ref leak via netfs init_request

Paul E. McKenney (1):
      rcuscale: Provide clear error when async specified without primitives

Pei Xiao (1):
      ACPICA: check null return of ACPI_ALLOCATE_ZEROED() in acpi_db_convert_to_package()

Peng Liu (2):
      drm/amdgpu: add raven1 gfxoff quirk
      drm/amdgpu: enable gfxoff quirk on HP 705G4

Peter Zijlstra (2):
      jump_label: Fix static_key_slow_dec() yet again
      perf: Fix event_function_call() locking

Phil Sutter (2):
      netfilter: uapi: NFTA_FLOWTABLE_HOOK is NLA_NESTED
      selftests: netfilter: Fix nft_audit.sh for newer nft binaries

Philip Yang (1):
      drm/amdkfd: amdkfd_free_gtt_mem clear the correct pointer

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: disallow multiple BO_HANDLES chunks in one submit

Ping-Ke Shih (1):
      wifi: rtw89: correct base HT rate mask for firmware

Qu Wenruo (1):
      btrfs: fix a NULL pointer dereference when failed to start a new trasacntion

Rafael J. Wysocki (1):
      ACPI: EC: Do not release locks during operation region accesses

Rafael Rocha (1):
      scsi: st: Fix input/output error on empty drive reset

Ravikanth Tuniki (1):
      dt-bindings: net: xlnx,axi-ethernet: Add missing reg minItems

Remington Brasga (1):
      jfs: UBSAN: shift-out-of-bounds in dbFindBits

Robert Hancock (2):
      i2c: xiic: Try re-initialization on bus busy timeout
      i2c: xiic: Wait for TX empty to avoid missed TX NAKs

Sanjay K Kumar (1):
      iommu/vt-d: Fix potential lockup if qi_submit_sync called with 0 count

Satya Priya Kakitapalli (4):
      clk: qcom: gcc-sm8150: De-register gcc_cpuss_ahb_clk_src
      clk: qcom: gcc-sc8180x: Fix the sdcc2 and sdcc4 clocks freq table
      dt-bindings: clock: qcom: Add GPLL9 support on gcc-sc8180x
      clk: qcom: gcc-sc8180x: Add GPLL9 support

Sebastian Reichel (1):
      clk: rockchip: fix error for unknown clocks

Seiji Nishikawa (1):
      ACPI: PAD: fix crash in exit_round_robin()

Shenwei Wang (1):
      net: stmmac: dwmac4: extend timeout for VLAN Tag register busy bit check

Simon Horman (4):
      tipc: guard against string buffer overrun
      net: mvpp2: Increase size of queue_name buffer
      bnxt_en: Extend maximum length of version string by 1 byte
      net: atlantic: Avoid warning about potential string truncation

Srinivasan Shanmugam (6):
      drm/amd/display: Add null check for top_pipe_to_program in commit_planes_for_stream
      drm/amd/display: Handle null 'stream_status' in 'planes_changed_for_existing_stream'
      drm/amd/display: Add null check for 'afb' in amdgpu_dm_plane_handle_cursor_update (v2)
      drm/amd/display: Fix index out of bounds in DCN30 degamma hardware format translation
      drm/amd/display: Fix index out of bounds in degamma hardware format translation
      drm/amd/display: Fix index out of bounds in DCN30 color transformation

Stefan Mätje (1):
      can: netlink: avoid call to do_set_data_bittiming callback with stale can_priv::ctrlmode

Stefan Wahren (1):
      mailbox: bcm2835: Fix timeout during suspend mode

Steve French (1):
      smb3: fix incorrect mode displayed for read-only files

Takashi Iwai (8):
      ALSA: hda/generic: Unconditionally prefer preferred_dacs pairs
      ALSA: hda/conexant: Fix conflicting quirk for System76 Pangolin
      ALSA: usb-audio: Add input value sanity checks for standard types
      ALSA: usb-audio: Define macros for quirk table entries
      ALSA: usb-audio: Replace complex quirk lines with macros
      ALSA: asihpi: Fix potential OOB array access
      ALSA: hdsp: Break infinite MIDI input flush loop
      Revert "ALSA: hda: Conditionally use snooping for AMD HDMI"

Tao Liu (1):
      x86/kexec: Add EFI config table identity mapping for kexec kernel

Tetsuo Handa (1):
      tomoyo: fallback to realpath if symlink's pathname does not exist

Thadeu Lima de Souza Cascardo (1):
      ext4: ext4_search_dir should return a proper error

Thomas Gleixner (4):
      static_call: Handle module init failure correctly in static_call_del_module()
      static_call: Replace pointless WARN_ON() in static_call_module_notify()
      jump_label: Simplify and clarify static_key_fast_inc_cpus_locked()
      x86/ioapic: Handle allocation failures gracefully

Thomas Weißschuh (4):
      tools/nolibc: powerpc: limit stack-protector workaround to GCC
      selftests/nolibc: avoid passing NULL to printf("%s")
      fbdev: efifb: Register sysfs groups through driver core
      of: address: Report error on resource bounds overflow

Thomas Zimmermann (1):
      drm: Consistently use struct drm_mode_rect for FB_DAMAGE_CLIPS

Tim Huang (3):
      drm/amd/display: fix double free issue during amdgpu module unload
      drm/amdgpu: fix unchecked return value warning for amdgpu_gfx
      drm/amd/pm: ensure the fw_info is not null before using it

Toke Høiland-Jørgensen (1):
      wifi: ath9k_htc: Use __skb_set_length() for resetting urb before resubmit

Tom Chung (1):
      drm/amd/display: Fix system hang while resume with TBT monitor

Tvrtko Ursulin (1):
      drm/sched: Add locking to drm_sched_entity_modify_sched

Udit Kumar (1):
      remoteproc: k3-r5: Delay notification of wakeup event

Umang Jain (1):
      media: imx335: Fix reset-gpio handling

Uwe Kleine-König (1):
      cpufreq: intel_pstate: Make hwp_notify_lock a raw spinlock

Val Packett (2):
      drm/rockchip: vop: clear DMA stop bit on RK3066
      drm/rockchip: vop: enable VOP_FEATURE_INTERNAL_RGB on RK3066

Vasileios Amoiridis (4):
      iio: pressure: bmp280: Improve indentation and line wrapping
      iio: pressure: bmp280: Use BME prefix for BME280 specifics
      iio: pressure: bmp280: Fix regmap for BMP280 device
      iio: pressure: bmp280: Fix waiting time for BMP3xx configuration

Victor Skvortsov (1):
      drm/amdgpu: Block MMR_READ IOCTL in reset

Vishnu Sankar (1):
      HID: multitouch: Add support for Thinkpad X12 Gen 2 Kbd Portfolio

Vitaly Lifshits (1):
      e1000e: avoid failing the system during pm_suspend

Vladimir Oltean (1):
      net: dsa: fix netdev_priv() dereference before check on non-DSA netdevice events

Wei Li (4):
      tracing/hwlat: Fix a race during cpuhp processing
      tracing/timerlat: Drop interface_lock in stop_kthread()
      tracing/timerlat: Fix a race during cpuhp processing
      tracing/timerlat: Fix duplicated kthread creation due to CPU online/offline

Willem de Bruijn (2):
      vrf: revert "vrf: Remove unnecessary RCU-bh critical section"
      gso: fix udp gso fraglist segmentation after pull from frag_list

Wolfram Sang (1):
      i2c: create debugfs entry per adapter

Xiaolei Wang (1):
      net: stmmac: move the EST lock to struct stmmac_priv

Xiaxi Shen (1):
      ext4: fix timer use-after-free on failed mount

Xin Long (1):
      sctp: set sk_state back to CLOSED if autobind fails in sctp_listen_start

Xiubo Li (1):
      ceph: remove the incorrect Fw reference check when dirtying pages

Yannick Fertre (1):
      drm/stm: ltdc: reset plane transparency after plane disable

Yifei Liu (1):
      selftests: breakpoints: use remaining time to check if suspend succeed

Yosry Ahmed (1):
      mm: z3fold: deprecate CONFIG_Z3FOLD

Yu Kuai (1):
      null_blk: fix null-ptr-dereference while configuring 'power' and 'submit_queues'

Yuezhang Mo (1):
      exfat: fix memory leak in exfat_load_bitmap()

Yun Lu (1):
      selftest: hid: add missing run-hid-tools-tests.sh

Zach Wade (1):
      platform/x86: ISST: Fix the KASAN report slab-out-of-bounds bug

Zhao Mengmeng (1):
      jfs: Fix uninit-value access of new_ea in ea_buffer

Zheng Wang (1):
      media: venus: fix use after free bug in venus_remove due to race condition

Zhihao Cheng (3):
      ext4: dax: fix overflowing extents beyond inode size when partially writing
      ubifs: ubifs_symlink: Fix memleak of inode->i_link in error path
      Revert "ubifs: ubifs_symlink: Fix memleak of inode->i_link in error path"

Zong-Zhe Yang (1):
      wifi: rtw88: select WANT_DEV_COREDUMP

wangrong (1):
      smb: client: use actual path when queryfs

yao.ly (1):
      ext4: correct encrypted dentry name hash when not casefolded


