Return-Path: <stable+bounces-71521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A60964B04
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 18:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38A87B24EB0
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 16:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5361B3B38;
	Thu, 29 Aug 2024 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LEebD1Hd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89D71B3731;
	Thu, 29 Aug 2024 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947591; cv=none; b=V9BM86WfhGPXYouYBRCFHQDzt9nDVnMZ8i6PW31j2DYxMHFdybORqOzR0OtURJHenAFJAK5s37Ore/BLv5kf3FTNKuqDwCHQPHfwZ7DZVZgbA2KS7zS9fSrjjgjs5J3ibCClA2IgFhbwu5SGxI71CCy5NlRzzMlLHdVyQ6bb+Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947591; c=relaxed/simple;
	bh=/A9HVyGFoZDYtpq7tgqNjx0544C+5QvfQOj82gCYBas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A5VUvJFPPYym+tOjyCCQv2FZBeLHQFIT1x8xN3ZBCKmPFFEofMtCXz9qE1+PfzMLaXRufsmVENQZBdSDUYClmrvoGFUYyvRsj4+LWRGMe24o9mZmqAUkIH83bkQgEZ6Y32GBNjbkvNS+7sAtqJfuOss1sOCZH8xd3GBeiaKRoL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LEebD1Hd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B83CC4CEC1;
	Thu, 29 Aug 2024 16:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724947590;
	bh=/A9HVyGFoZDYtpq7tgqNjx0544C+5QvfQOj82gCYBas=;
	h=From:To:Cc:Subject:Date:From;
	b=LEebD1HdV81NSTyDJ006MObl8S8evNDpgWUB+i8nGyT69T4qXIkN+5QeZh3suvgjF
	 0bLpb65V3QlXtAPAshydwFmwu7deLYdEiotm5UB0fLG/kGvZu7ajFn72qh9kDhj2Lb
	 6kiQXrrTARRfWHAS3Cz0mI+/FacPRm7nI3Nd+or8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.48
Date: Thu, 29 Aug 2024 18:06:11 +0200
Message-ID: <2024082910-squad-legwarmer-937c@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.48 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-devices-system-cpu          |    3 
 Makefile                                                    |    2 
 arch/alpha/kernel/pci_iommu.c                               |    2 
 arch/arm64/kernel/acpi_numa.c                               |    2 
 arch/arm64/kernel/setup.c                                   |    3 
 arch/arm64/kernel/smp.c                                     |    2 
 arch/arm64/kvm/sys_regs.c                                   |    6 
 arch/arm64/kvm/vgic/vgic.h                                  |    7 
 arch/mips/jazz/jazzdma.c                                    |    2 
 arch/mips/kernel/cpu-probe.c                                |    4 
 arch/openrisc/kernel/setup.c                                |    6 
 arch/parisc/kernel/irq.c                                    |    4 
 arch/powerpc/boot/simple_alloc.c                            |    7 
 arch/powerpc/include/asm/topology.h                         |   13 
 arch/powerpc/kernel/dma-iommu.c                             |    2 
 arch/powerpc/platforms/ps3/system-bus.c                     |    4 
 arch/powerpc/platforms/pseries/papr-sysparm.c               |   47 ++
 arch/powerpc/platforms/pseries/vio.c                        |    2 
 arch/powerpc/sysdev/xics/icp-native.c                       |    2 
 arch/riscv/include/asm/asm.h                                |   10 
 arch/riscv/kernel/entry.S                                   |    3 
 arch/riscv/kernel/traps.c                                   |    3 
 arch/riscv/mm/init.c                                        |    4 
 arch/s390/include/asm/uv.h                                  |    5 
 arch/s390/kernel/early.c                                    |   12 
 arch/s390/kernel/smp.c                                      |    4 
 arch/s390/kvm/kvm-s390.h                                    |    7 
 arch/x86/kernel/amd_gart_64.c                               |    2 
 arch/x86/kernel/process.c                                   |    5 
 block/blk-mq-tag.c                                          |    5 
 drivers/accel/habanalabs/common/debugfs.c                   |   14 
 drivers/accel/habanalabs/common/irq.c                       |    3 
 drivers/accel/habanalabs/common/memory.c                    |   15 
 drivers/accel/habanalabs/gaudi2/gaudi2_security.c           |    1 
 drivers/acpi/acpica/acevents.h                              |    6 
 drivers/acpi/acpica/evregion.c                              |   12 
 drivers/acpi/acpica/evxfregn.c                              |   64 ---
 drivers/acpi/ec.c                                           |   14 
 drivers/acpi/internal.h                                     |    1 
 drivers/acpi/scan.c                                         |    2 
 drivers/atm/idt77252.c                                      |    9 
 drivers/char/xillybus/xillyusb.c                            |   42 +-
 drivers/clk/visconti/pll.c                                  |    6 
 drivers/clocksource/arm_global_timer.c                      |   11 
 drivers/edac/skx_common.c                                   |    4 
 drivers/firmware/cirrus/cs_dsp.c                            |    7 
 drivers/gpio/gpio-mlxbf3.c                                  |   14 
 drivers/gpio/gpiolib-sysfs.c                                |   15 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h                  |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c            |   40 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                      |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c                     |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c                  |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c                     |   53 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h                     |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c                   |    6 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                      |   13 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                      |   13 
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c                      |    2 
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c                      |    4 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c                    |   63 +++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h                    |    6 
 drivers/gpu/drm/amd/amdgpu/soc15d.h                         |    6 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                    |   22 -
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c   |    4 
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c     |    3 
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                          |   14 
 drivers/gpu/drm/bridge/tc358768.c                           |  213 ++++++++++-
 drivers/gpu/drm/lima/lima_gp.c                              |   12 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                 |   96 +++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h                 |   22 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h            |    9 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c        |   43 --
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c        |   22 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c         |   21 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c                     |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h                     |   14 
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c                   |   23 +
 drivers/gpu/drm/msm/dp/dp_ctrl.c                            |    2 
 drivers/gpu/drm/msm/dp/dp_panel.c                           |   19 -
 drivers/gpu/drm/msm/msm_drv.h                               |   12 
 drivers/gpu/drm/msm/msm_gem_shrinker.c                      |    2 
 drivers/gpu/drm/msm/msm_mdss.c                              |   84 +++-
 drivers/gpu/drm/msm/msm_mdss.h                              |    1 
 drivers/gpu/drm/nouveau/nvkm/core/firmware.c                |    9 
 drivers/gpu/drm/nouveau/nvkm/falcon/fw.c                    |    6 
 drivers/gpu/drm/panel/panel-novatek-nt36523.c               |    6 
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c                |    5 
 drivers/gpu/drm/tegra/gem.c                                 |    2 
 drivers/hid/wacom_wac.c                                     |    4 
 drivers/hwmon/ltc2992.c                                     |    8 
 drivers/hwmon/pc87360.c                                     |    6 
 drivers/i2c/busses/i2c-qcom-geni.c                          |    4 
 drivers/i2c/busses/i2c-riic.c                               |    2 
 drivers/i2c/busses/i2c-stm32f7.c                            |   51 ++
 drivers/i2c/busses/i2c-tegra.c                              |    4 
 drivers/i3c/master/mipi-i3c-hci/dma.c                       |    5 
 drivers/infiniband/hw/hfi1/chip.c                           |    5 
 drivers/infiniband/ulp/rtrs/rtrs.c                          |    2 
 drivers/input/input-mt.c                                    |    3 
 drivers/input/serio/i8042-acpipnpio.h                       |   20 -
 drivers/input/serio/i8042.c                                 |   10 
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c                  |    1 
 drivers/iommu/dma-iommu.c                                   |    2 
 drivers/irqchip/irq-gic-v3-its.c                            |    2 
 drivers/irqchip/irq-renesas-rzg2l.c                         |    5 
 drivers/md/dm-clone-metadata.c                              |    5 
 drivers/md/dm-ioctl.c                                       |   22 +
 drivers/md/dm.c                                             |    4 
 drivers/md/md.c                                             |    5 
 drivers/md/persistent-data/dm-space-map-metadata.c          |    4 
 drivers/md/raid5-cache.c                                    |   47 +-
 drivers/media/dvb-core/dvb_frontend.c                       |   12 
 drivers/media/pci/cx23885/cx23885-video.c                   |    8 
 drivers/media/platform/qcom/venus/pm_helpers.c              |    2 
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c        |    2 
 drivers/media/radio/radio-isa.c                             |    2 
 drivers/memory/stm32-fmc2-ebi.c                             |  122 ++++--
 drivers/memory/tegra/tegra186.c                             |    3 
 drivers/misc/fastrpc.c                                      |   22 -
 drivers/mmc/core/mmc_test.c                                 |    9 
 drivers/mmc/host/dw_mmc.c                                   |    8 
 drivers/mmc/host/mtk-sd.c                                   |    8 
 drivers/net/bonding/bond_main.c                             |   21 -
 drivers/net/bonding/bond_options.c                          |    2 
 drivers/net/dsa/microchip/ksz_ptp.c                         |    5 
 drivers/net/dsa/mv88e6xxx/global1_atu.c                     |    3 
 drivers/net/dsa/ocelot/felix.c                              |   11 
 drivers/net/dsa/vitesse-vsc73xx-core.c                      |   69 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c               |    5 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c           |    3 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c         |    7 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c             |    3 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c     |   28 +
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c      |    7 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c     |    3 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c   |    4 
 drivers/net/ethernet/i825xx/sun3_82586.c                    |    2 
 drivers/net/ethernet/intel/ice/ice_base.c                   |   21 +
 drivers/net/ethernet/intel/ice/ice_txrx.c                   |   47 --
 drivers/net/ethernet/intel/igb/igb_main.c                   |    1 
 drivers/net/ethernet/intel/igc/igc_defines.h                |    6 
 drivers/net/ethernet/intel/igc/igc_main.c                   |    8 
 drivers/net/ethernet/intel/igc/igc_tsn.c                    |   76 +++-
 drivers/net/ethernet/intel/igc/igc_tsn.h                    |    1 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c         |   23 -
 drivers/net/ethernet/mediatek/mtk_wed.c                     |    6 
 drivers/net/ethernet/mediatek/mtk_wed_mcu.c                 |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c    |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c     |    2 
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige.h       |    8 
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c  |   10 
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_regs.h  |    2 
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c    |   50 ++
 drivers/net/ethernet/microsoft/mana/mana_en.c               |   30 +
 drivers/net/ethernet/mscc/ocelot.c                          |   91 ++++-
 drivers/net/ethernet/mscc/ocelot_fdma.c                     |    3 
 drivers/net/ethernet/mscc/ocelot_vsc7514.c                  |    4 
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c         |    9 
 drivers/net/ethernet/pensando/ionic/ionic_dev.c             |   33 +
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c         |    7 
 drivers/net/ethernet/pensando/ionic/ionic_fw.c              |    5 
 drivers/net/ethernet/pensando/ionic/ionic_main.c            |    3 
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c               |    6 
 drivers/net/ethernet/xilinx/xilinx_axienet.h                |   17 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c           |   25 -
 drivers/net/gtp.c                                           |    3 
 drivers/net/wireless/ath/ath11k/mac.c                       |   44 +-
 drivers/net/wireless/ath/ath12k/mac.c                       |   27 +
 drivers/net/wireless/ath/ath12k/qmi.c                       |    7 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |   13 
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c             |    6 
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c                |    6 
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c                 |    3 
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c           |    7 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c               |    2 
 drivers/net/wireless/mediatek/mt76/mac80211.c               |   50 ++
 drivers/net/wireless/mediatek/mt76/mt76.h                   |   24 -
 drivers/net/wireless/mediatek/mt76/mt7603/main.c            |    4 
 drivers/net/wireless/mediatek/mt76/mt7615/main.c            |    4 
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c           |    4 
 drivers/net/wireless/mediatek/mt76/mt7915/main.c            |    4 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c            |    2 
 drivers/net/wireless/mediatek/mt76/mt792x_core.c            |    2 
 drivers/net/wireless/mediatek/mt76/mt7996/main.c            |    4 
 drivers/net/wireless/mediatek/mt76/tx.c                     |  108 ++++--
 drivers/net/wireless/st/cw1200/txrx.c                       |    2 
 drivers/nvme/host/core.c                                    |  107 +++--
 drivers/nvme/host/ioctl.c                                   |   15 
 drivers/nvme/host/multipath.c                               |   21 -
 drivers/nvme/host/nvme.h                                    |    4 
 drivers/nvme/target/rdma.c                                  |   16 
 drivers/nvme/target/tcp.c                                   |    1 
 drivers/nvme/target/trace.c                                 |    6 
 drivers/nvme/target/trace.h                                 |   28 -
 drivers/parisc/ccio-dma.c                                   |    2 
 drivers/parisc/sba_iommu.c                                  |    2 
 drivers/platform/surface/aggregator/controller.c            |    3 
 drivers/platform/x86/intel/ifs/load.c                       |    9 
 drivers/platform/x86/lg-laptop.c                            |    2 
 drivers/pmdomain/imx/imx93-pd.c                             |    5 
 drivers/pmdomain/imx/scu-pd.c                               |    5 
 drivers/rtc/rtc-nct3018y.c                                  |    6 
 drivers/s390/block/dasd.c                                   |   36 +-
 drivers/s390/block/dasd_3990_erp.c                          |   10 
 drivers/s390/block/dasd_diag.c                              |    1 
 drivers/s390/block/dasd_eckd.c                              |   56 +--
 drivers/s390/block/dasd_int.h                               |    2 
 drivers/s390/cio/idset.c                                    |   12 
 drivers/scsi/lpfc/lpfc_sli.c                                |    2 
 drivers/scsi/scsi_transport_spi.c                           |    4 
 drivers/ssb/main.c                                          |    2 
 drivers/staging/iio/resolver/ad2s1210.c                     |    7 
 drivers/staging/ks7010/ks7010_sdio.c                        |    4 
 drivers/thunderbolt/switch.c                                |    1 
 drivers/tty/serial/atmel_serial.c                           |    2 
 drivers/tty/serial/fsl_lpuart.c                             |    1 
 drivers/usb/dwc3/core.c                                     |   13 
 drivers/usb/gadget/udc/fsl_udc_core.c                       |    2 
 drivers/usb/host/xhci.c                                     |    8 
 drivers/usb/typec/tcpm/tcpm.c                               |    1 
 drivers/xen/grant-dma-ops.c                                 |    2 
 drivers/xen/swiotlb-xen.c                                   |    2 
 fs/afs/file.c                                               |    8 
 fs/binfmt_elf_fdpic.c                                       |    2 
 fs/binfmt_misc.c                                            |  216 +++++++++---
 fs/btrfs/compression.c                                      |   23 -
 fs/btrfs/compression.h                                      |    2 
 fs/btrfs/defrag.c                                           |    2 
 fs/btrfs/delayed-inode.c                                    |    4 
 fs/btrfs/disk-io.c                                          |    2 
 fs/btrfs/extent_io.c                                        |    4 
 fs/btrfs/free-space-cache.c                                 |   22 -
 fs/btrfs/inode.c                                            |   24 -
 fs/btrfs/ioctl.c                                            |    2 
 fs/btrfs/qgroup.c                                           |    2 
 fs/btrfs/reflink.c                                          |    6 
 fs/btrfs/send.c                                             |   71 +++
 fs/btrfs/super.c                                            |    2 
 fs/btrfs/tests/extent-io-tests.c                            |   28 +
 fs/btrfs/tree-checker.c                                     |   74 ++++
 fs/btrfs/zlib.c                                             |   73 +---
 fs/ext4/extents.c                                           |    3 
 fs/ext4/mballoc.c                                           |    3 
 fs/f2fs/segment.c                                           |   17 
 fs/file.c                                                   |   30 -
 fs/fscache/cookie.c                                         |    4 
 fs/fuse/cuse.c                                              |    3 
 fs/fuse/dev.c                                               |    6 
 fs/fuse/fuse_i.h                                            |    1 
 fs/fuse/inode.c                                             |   15 
 fs/fuse/virtio_fs.c                                         |   10 
 fs/gfs2/inode.c                                             |    2 
 fs/gfs2/super.c                                             |    2 
 fs/inode.c                                                  |   39 ++
 fs/jfs/jfs_dinode.h                                         |    2 
 fs/jfs/jfs_imap.c                                           |    6 
 fs/jfs/jfs_incore.h                                         |    2 
 fs/jfs/jfs_txnmgr.c                                         |    4 
 fs/jfs/jfs_xtree.c                                          |    4 
 fs/jfs/jfs_xtree.h                                          |   37 +-
 fs/kernfs/file.c                                            |    8 
 fs/nfs/pnfs.c                                               |    8 
 fs/nfsd/nfssvc.c                                            |   14 
 fs/ntfs3/bitmap.c                                           |    4 
 fs/ntfs3/fsntfs.c                                           |    2 
 fs/ntfs3/index.c                                            |   11 
 fs/ntfs3/ntfs_fs.h                                          |    4 
 fs/ntfs3/super.c                                            |    2 
 fs/quota/dquot.c                                            |    5 
 fs/smb/client/reparse.c                                     |   11 
 fs/smb/server/connection.c                                  |   34 +
 fs/smb/server/connection.h                                  |    3 
 fs/smb/server/mgmt/user_session.c                           |    8 
 fs/smb/server/smb2pdu.c                                     |    5 
 include/acpi/acpixf.h                                       |    5 
 include/linux/bitmap.h                                      |   20 -
 include/linux/bpf_verifier.h                                |    4 
 include/linux/cpumask.h                                     |    2 
 include/linux/dma-map-ops.h                                 |    2 
 include/linux/dsa/ocelot.h                                  |   47 ++
 include/linux/evm.h                                         |    6 
 include/linux/f2fs_fs.h                                     |    1 
 include/linux/fs.h                                          |    5 
 include/linux/slab.h                                        |    5 
 include/net/af_vsock.h                                      |    4 
 include/net/inet_timewait_sock.h                            |    2 
 include/net/kcm.h                                           |    1 
 include/net/mana/mana.h                                     |    1 
 include/net/tcp.h                                           |    2 
 include/scsi/scsi_cmnd.h                                    |    2 
 include/soc/mscc/ocelot.h                                   |   12 
 include/uapi/misc/fastrpc.h                                 |    3 
 init/Kconfig                                                |    7 
 kernel/bpf/verifier.c                                       |    5 
 kernel/cgroup/cgroup.c                                      |    4 
 kernel/cpu.c                                                |   12 
 kernel/dma/mapping.c                                        |    4 
 kernel/rcu/rcu.h                                            |    7 
 kernel/rcu/srcutiny.c                                       |    1 
 kernel/rcu/srcutree.c                                       |    1 
 kernel/rcu/tasks.h                                          |    1 
 kernel/rcu/tiny.c                                           |    1 
 kernel/rcu/tree.c                                           |    3 
 kernel/sched/topology.c                                     |    3 
 kernel/time/clocksource.c                                   |   42 +-
 kernel/time/hrtimer.c                                       |    5 
 kernel/time/tick-sched.h                                    |    2 
 lib/cpumask.c                                               |    4 
 lib/math/prime_numbers.c                                    |    2 
 mm/huge_memory.c                                            |   30 -
 mm/memcontrol.c                                             |    7 
 mm/memory-failure.c                                         |   20 -
 mm/memory.c                                                 |   33 -
 mm/page_alloc.c                                             |   42 +-
 mm/slab_common.c                                            |   41 --
 mm/util.c                                                   |    4 
 mm/vmalloc.c                                                |   11 
 net/bluetooth/bnep/core.c                                   |    3 
 net/bluetooth/hci_conn.c                                    |   11 
 net/bluetooth/hci_core.c                                    |   19 -
 net/bluetooth/mgmt.c                                        |    4 
 net/bluetooth/smp.c                                         |  144 ++++----
 net/bridge/br_netfilter_hooks.c                             |    6 
 net/core/sock_map.c                                         |    6 
 net/dccp/ipv4.c                                             |    2 
 net/dccp/ipv6.c                                             |    6 
 net/dsa/tag_ocelot.c                                        |   37 --
 net/ipv4/inet_timewait_sock.c                               |   16 
 net/ipv4/tcp_input.c                                        |   28 -
 net/ipv4/tcp_ipv4.c                                         |   16 
 net/ipv4/tcp_minisocks.c                                    |    7 
 net/ipv4/udp_offload.c                                      |    3 
 net/ipv6/ip6_output.c                                       |   10 
 net/ipv6/ip6_tunnel.c                                       |   12 
 net/ipv6/netfilter/nf_conntrack_reasm.c                     |    4 
 net/ipv6/tcp_ipv6.c                                         |    6 
 net/iucv/iucv.c                                             |    3 
 net/kcm/kcmsock.c                                           |    4 
 net/mac80211/agg-tx.c                                       |    6 
 net/mac80211/driver-ops.c                                   |    3 
 net/mac80211/iface.c                                        |   14 
 net/mac80211/main.c                                         |   22 +
 net/mac80211/sta_info.c                                     |   46 +-
 net/mctp/test/route-test.c                                  |    2 
 net/mptcp/diag.c                                            |    2 
 net/mptcp/pm.c                                              |   13 
 net/mptcp/pm_netlink.c                                      |  142 +++++--
 net/mptcp/protocol.h                                        |    3 
 net/netfilter/nf_flow_table_inet.c                          |    3 
 net/netfilter/nf_flow_table_ip.c                            |    3 
 net/netfilter/nf_flow_table_offload.c                       |    2 
 net/netfilter/nf_tables_api.c                               |  209 +++++++----
 net/netfilter/nfnetlink_queue.c                             |   35 +
 net/netfilter/nft_counter.c                                 |    9 
 net/netlink/af_netlink.c                                    |   13 
 net/openvswitch/datapath.c                                  |    2 
 net/rxrpc/rxkad.c                                           |    8 
 net/sched/sch_netem.c                                       |   47 +-
 net/vmw_vsock/af_vsock.c                                    |   50 +-
 net/vmw_vsock/vsock_bpf.c                                   |    4 
 net/wireless/core.h                                         |    8 
 scripts/rust_is_available.sh                                |    6 
 security/integrity/evm/evm_main.c                           |    7 
 security/security.c                                         |    2 
 security/selinux/avc.c                                      |    8 
 security/selinux/hooks.c                                    |   12 
 sound/core/timer.c                                          |    2 
 sound/pci/hda/patch_realtek.c                               |    1 
 sound/pci/hda/tas2781_hda_i2c.c                             |   14 
 sound/soc/codecs/cs35l45.c                                  |    5 
 sound/soc/sof/intel/hda-dsp.c                               |    3 
 sound/soc/sof/ipc4.c                                        |    9 
 sound/usb/quirks-table.h                                    |    1 
 sound/usb/quirks.c                                          |    2 
 tools/include/linux/align.h                                 |   12 
 tools/include/linux/bitmap.h                                |    9 
 tools/include/linux/mm.h                                    |    5 
 tools/testing/selftests/bpf/progs/cpumask_failure.c         |    3 
 tools/testing/selftests/bpf/progs/dynptr_fail.c             |   12 
 tools/testing/selftests/bpf/progs/iters.c                   |   54 +++
 tools/testing/selftests/bpf/progs/jeq_infer_not_null_fail.c |    4 
 tools/testing/selftests/bpf/progs/test_tunnel_kern.c        |   47 +-
 tools/testing/selftests/core/close_range_test.c             |   35 +
 tools/testing/selftests/mm/Makefile                         |    2 
 tools/testing/selftests/mm/run_vmtests.sh                   |   53 ++
 tools/testing/selftests/net/lib.sh                          |   11 
 tools/testing/selftests/net/mptcp/mptcp_join.sh             |   28 +
 tools/testing/selftests/net/udpgro.sh                       |   44 +-
 tools/testing/selftests/tc-testing/tdc.py                   |    1 
 tools/tracing/rtla/src/osnoise_top.c                        |   11 
 391 files changed, 3848 insertions(+), 1967 deletions(-)

Abhinav Kumar (5):
      drm/msm/dp: fix the max supported bpp logic
      drm/msm/dpu: move dpu_encoder's connector assignment to atomic_enable()
      drm/msm/dp: reset the link phy params before link training
      drm/msm/dpu: try multirect based on mdp clock limits
      drm/msm: fix the highest_bank_bit for sc7180

Adrian Hunter (1):
      clocksource: Make watchdog and suspend-timing multiplication overflow safe

Al Viro (4):
      fix bitmap corruption on close_range() with CLOSE_RANGE_UNSHARE
      memcg_write_event_control(): fix a user-triggerable oops
      afs: fix __afs_break_callback() / afs_drop_open_mmap() race
      fuse: fix UAF in rcu pathwalks

Alex Deucher (3):
      drm/amdgpu/jpeg2: properly set atomics vmid field
      drm/amdgpu/jpeg4: properly set atomics vmid field
      drm/amd/pm: fix error flow in sensor fetching

Alex Hung (2):
      drm/amd/display: Validate hw_points_num before using it
      Revert "drm/amd/display: Validate hw_points_num before using it"

Alexander Gordeev (1):
      s390/iucv: fix receive buffer virtual vs physical address confusion

Alexander Lobakin (5):
      fs/ntfs3: add prefix to bitmap_size() and use BITS_TO_U64()
      s390/cio: rename bitmap_size() -> idset_bitmap_size()
      btrfs: rename bitmap_set_bits() -> btrfs_bitmap_set_bits()
      bitmap: introduce generic optimized bitmap_size()
      tools: move alignment-related macros to new <linux/align.h>

Alexander Stein (1):
      pmdomain: imx: scu-pd: Remove duplicated clocks

Alexandre Belloni (1):
      rtc: nct3018y: fix possible NULL dereference

Andi Shyti (1):
      i2c: qcom-geni: Add missing geni_icc_disable in geni_i2c_runtime_resume

Andreas Gruenbacher (2):
      gfs2: setattr_chown: Add missing initialization
      gfs2: Refcounting fix in gfs2_thaw_super

Andy Yan (1):
      drm/rockchip: vop2: clear afbc en and transform bit for cluster window at linear mode

Antoniu Miclaus (1):
      hwmon: (ltc2992) Avoid division by zero

Ashish Mhetre (1):
      memory: tegra: Skip SID programming if SID registers aren't set

Asmaa Mnebhi (1):
      gpio: mlxbf3: Support shutdown() function

Avri Kehat (1):
      accel/habanalabs: fix debugfs files permissions

Baojun Xu (1):
      ALSA: hda/tas2781: fix wrong calibrated data order

Baokun Li (2):
      ext4: do not trim the group with corrupted block bitmap
      ext4: set the type of max_zeroout to unsigned int to avoid overflow

Bard Liao (1):
      ASoC: SOF: ipc4: check return value of snd_sof_ipc_msg_data

Bartosz Golaszewski (1):
      gpio: sysfs: extend the critical section for unregistering sysfs devices

Bas Nieuwenhuizen (1):
      drm/amdgpu: Actually check flags for all context ops.

Ben Whitten (1):
      mmc: dw_mmc: allow biu and ciu clocks to defer

Bharat Bhushan (1):
      octeontx2-af: Fix CPT AF register offset calculation

Biju Das (1):
      irqchip/renesas-rzg2l: Do not set TIEN and TINT source at the same time

Boyuan Zhang (2):
      drm/amdgpu/vcn: identify unified queue in sw init
      drm/amdgpu/vcn: not pause dpg for unified queue

Breno Leitao (1):
      i2c: tegra: Do not mark ACPI devices as irq safe

Candice Li (1):
      drm/amdgpu: Validate TA binary size

Celeste Liu (1):
      riscv: entry: always initialize regs->a0 to -ENOSYS

Chaotian Jing (1):
      scsi: core: Fix the return value of scsi_logical_block_count()

Chengfeng Ye (3):
      staging: ks7010: disable bh on tx_dev_lock
      media: s5p-mfc: Fix potential deadlock on condlock
      IB/hfi1: Fix potential deadlock on &irq_src_lock and &dd->uctxt_lock

Christian Brauner (1):
      binfmt_misc: cleanup on filesystem umount

Christophe Kerello (1):
      memory: stm32-fmc2-ebi: check regmap_read return value

Claudio Imbrenda (1):
      s390/uv: Panic for set and remove shared access UVC errors

Clément Léger (1):
      riscv: blacklist assembly symbols for kprobe

Cong Wang (1):
      vsock: fix recursive ->recvmsg calls

Cosmin Ratiu (1):
      net/mlx5e: Correctly report errors for ethtool rx flows

Costa Shulyupin (1):
      hrtimer: Select housekeeping CPU during migration

Cupertino Miranda (1):
      selftests/bpf: Fix a few tests for GCC related warnings.

Dan Carpenter (4):
      rtla/osnoise: Prevent NULL dereference in error handling
      atm: idt77252: prevent use after free in dequeue_rx()
      dpaa2-switch: Fix error checking in dpaa2_switch_seed_bp()
      mmc: mmc_test: Fix NULL dereference on allocation failure

Daniel Wagner (1):
      nvmet-trace: avoid dereferencing pointer too early

Dave Airlie (1):
      nouveau/firmware: use dma non-coherent allocator

Dave Kleikamp (1):
      jfs: define xtree root and page independently

David (Ming Qiang) Wu (1):
      drm/amd/amdgpu: command submission parser for JPEG

David Howells (1):
      rxrpc: Don't pick values out of the wire header when setting up security

David Lechner (1):
      staging: iio: resolver: ad2s1210: fix use before initialization

David Sterba (11):
      btrfs: delayed-inode: drop pointless BUG_ON in __btrfs_remove_delayed_item()
      btrfs: defrag: change BUG_ON to assertion in btrfs_defrag_leaves()
      btrfs: change BUG_ON to assertion when checking for delayed_node root
      btrfs: tests: allocate dummy fs_info and root in test_find_delalloc()
      btrfs: push errors up from add_async_extent()
      btrfs: handle invalid root reference found in may_destroy_subvol()
      btrfs: send: handle unexpected data in header buffer in begin_cmd()
      btrfs: send: handle unexpected inode in header process_recorded_refs()
      btrfs: change BUG_ON to assertion in tree_move_down()
      btrfs: delete pointless BUG_ON check on quota root in btrfs_qgroup_account_extent()
      btrfs: replace sb::s_blocksize by fs_info::sectorsize

David Thompson (1):
      mlxbf_gige: disable RX filters until RX path initialized

Dmitry Antipov (2):
      wifi: ath11k: fix ath11k_mac_op_remain_on_channel() stack usage
      wifi: iwlwifi: check for kmemdup() return value in iwl_parse_tlv_firmware()

Dmitry Baryshkov (10):
      drm/msm/dpu: don't play tricks with debug macros
      drm/msm/dpu: use drmm-managed allocation for dpu_encoder_phys
      drm/msm/dpu: drop MSM_ENC_VBLANK support
      drm/msm/dpu: split dpu_encoder_wait_for_event into two functions
      drm/msm/dpu: capture snapshot on the first commit_done timeout
      drm/msm/dpu: cleanup FB if dpu_format_populate_layout fails
      drm/msm/dpu: take plane rotation into account for wide planes
      drm/msm/mdss: switch mdss to use devm_of_icc_get()
      drm/msm/mdss: Handle the reg bus ICC path
      drm/msm/mdss: specify cfg bandwidth for SDM670

Donald Hunter (1):
      netfilter: flowtable: initialise extack before use

Dragos Tatulea (1):
      net/mlx5e: Take state lock during tx timeout reporter

Eli Billauer (3):
      char: xillybus: Don't destroy workqueue from work item running on it
      char: xillybus: Refine workqueue handling
      char: xillybus: Check USB endpoints when probing device

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: fix recovery flow in CSA

Eric Dumazet (8):
      netlink: hold nlk->cb_mutex longer in __netlink_dump_start()
      gtp: pull network headers in gtp_dev_xmit()
      tcp/dccp: bypass empty buckets in inet_twsk_purge()
      tcp/dccp: do not care about families in inet_twsk_purge()
      ipv6: prevent UAF in ip6_send_skb()
      ipv6: fix possible UAF in ip6_finish_output2()
      ipv6: prevent possible UAF in ip6_xmit()
      tcp: do not export tcp_twsk_purge()

Erico Nunes (1):
      drm/lima: set gp bus_stop bit before hard reset

Eugene Syromiatnikov (1):
      mptcp: correct MPTCP_SUBFLOW_ATTR_SSN_OFFSET reserved size

Faizal Rahim (4):
      igc: Fix packet still tx after gate close by reducing i226 MAC retry buffer
      igc: Fix qbv_config_change_errors logics
      igc: Fix reset adapter logics when tx mode change
      igc: Fix qbv tx latency by setting gtxoffset

Felix Fietkau (2):
      wifi: mt76: fix race condition related to checking tx queue fill status
      udp: fix receiving fraglist GSO packets

Filipe Manana (1):
      btrfs: send: allow cloning non-aligned extent if it ends at i_size

Florian Westphal (2):
      netfilter: nf_queue: drop packets with cloned unconfirmed conntracks
      tcp: prevent concurrent execution of tcp_sk_exit_batch

Frederic Weisbecker (1):
      tick: Move got_idle_tick away from common flags

Gergo Koteles (1):
      platform/x86: lg-laptop: fix %s null argument warning

Greg Kroah-Hartman (2):
      Revert "usb: gadget: uvc: cleanup request when not in correct state"
      Linux 6.6.48

Griffin Kroah-Hartman (2):
      Revert "misc: fastrpc: Restrict untrusted app to attach to privileged PD"
      Bluetooth: MGMT: Add error handling to pair_device()

Guanrui Huang (1):
      irqchip/gic-v3-its: Remove BUG_ON in its_vpe_irq_domain_alloc

Gustavo A. R. Silva (1):
      clk: visconti: Add bounds-checking coverage for struct visconti_pll_provider

Haibo Xu (1):
      arm64: ACPI: NUMA: initialize all values of acpi_early_node_map to NUMA_NO_NODE

Hailong Liu (1):
      mm/vmalloc: fix page mapping if vm_area_alloc_pages() with high order fallback to order 0

Haiyang Zhang (1):
      net: mana: Fix RX buf alloc_size alignment and atomic op panic

Hangbin Liu (1):
      selftests: udpgro: report error when receive failed

Hannes Reinecke (1):
      nvmet-tcp: do not continue for invalid icreq

Hans Verkuil (3):
      media: radio-isa: use dev_name to fill in bus_info
      media: qcom: venus: fix incorrect return value
      media: pci: cx23885: check cx23885_vdev_init() return

Heiko Carstens (1):
      s390/smp,mcck: fix early IPI handling

Helge Deller (1):
      parisc: Use irq_enter_rcu() to fix warning at kernel/context_tracking.c:367

Itaru Kitayama (1):
      tools/testing/selftests/mm/run_vmtests.sh: lower the ptrace permissions

Jakub Sitnicki (1):
      Revert "bpf, sockmap: Prevent lock inversion deadlock in map delete elem"

Jan Höppner (1):
      Revert "s390/dasd: Establish DMA alignment"

Jan Kara (1):
      quota: Remove BUG_ON from dqget()

Jann Horn (1):
      fuse: Initialize beyond-EOF page contents before setting uptodate

Janne Grunau (1):
      wifi: brcmfmac: cfg80211: Handle SSID based pmksa deletion

Jarkko Nikula (2):
      i3c: mipi-i3c-hci: Remove BUG() when Ring Abort request times out
      i3c: mipi-i3c-hci: Do not unmap region not mapped for transfer

Jason Gerecke (1):
      HID: wacom: Defer calculation of resolution until resolution_code is known

Javier Carrasco (1):
      hwmon: (ltc2992) Fix memory leak in ltc2992_parse_dt()

Jeff Johnson (2):
      wifi: cw1200: Avoid processing an invalid TIM IE
      wifi: ath12k: Add missing qmi_txn_cancel() calls

Jeremy Kerr (1):
      net: mctp: test: Use correct skb for route input check

Jesse Zhang (1):
      drm/amdgpu: fix dereference null return value for the function amdgpu_vm_pt_parent

Jian Shen (1):
      net: hns3: add checking for vf id of mailbox

Jianhua Lu (1):
      drm/panel: nt36523: Set 120Hz fps for xiaomi,elish panels

Jiaxun Yang (1):
      MIPS: Loongson64: Set timer mode in cpu-probe

Jie Wang (2):
      net: hns3: fix wrong use of semaphore up
      net: hns3: fix a deadlock problem when config TC during resetting

Jithu Joseph (2):
      platform/x86/intel/ifs: Validate image size
      platform/x86/intel/ifs: Call release_firmware() when handling errors.

Johannes Berg (4):
      wifi: mac80211: lock wiphy in IP address notifier
      wifi: cfg80211: check wiphy mutex is held for wdev mutex
      wifi: mac80211: fix BA session teardown race
      wifi: mac80211: flush STA queues on unauthorization

Joseph Huang (1):
      net: dsa: mv88e6xxx: Fix out-of-bound access

Juan José Arboleda (1):
      ALSA: usb-audio: Support Yamaha P-125 quirk entry

Justin Tee (1):
      scsi: lpfc: Initialize status local variable in lpfc_sli4_repost_sgl_list()

Kamalesh Babulal (1):
      cgroup: Avoid extra dereference in css_populate_dir()

Kees Cook (3):
      hwmon: (pc87360) Bounds check data->innr usage
      net/sun3_82586: Avoid reading past buffer in debug output
      x86: Increase brk randomness entropy for 64-bit systems

Keith Busch (3):
      nvme: clear caller pointer on identify failure
      nvme: use srcu for iterating namespace list
      nvme: fix namespace removal list

Khazhismel Kumykov (1):
      dm resume: don't return EINVAL when signalled

Kirill A. Shutemov (1):
      mm: fix endless reclaim on machines with unaccepted memory

Konrad Dybcio (1):
      drm/msm/mdss: Rename path references to mdp_path

Krishna Kurapati (1):
      usb: dwc3: core: Skip setting event buffers for host only controllers

Kuniyuki Iwashima (1):
      kcm: Serialise kcm_sendmsg() for the same socket.

Kunwu Chan (1):
      powerpc/xics: Check return value of kasprintf in icp_native_map_one_cpu

Lang Yu (1):
      drm/amdkfd: reserve the BO before validating it

Lee Jones (1):
      drm/amd/amdgpu/imu_v11_0: Increase buffer size to ensure all possible values can be stored

Leon Hwang (1):
      bpf: Fix updating attached freplace prog in prog_array map

Li Lingfeng (1):
      block: Fix lockdep warning in blk_mq_mark_tag_wait

Li Nan (1):
      md: clean up invalid BUG_ON in md_ioctl

Li zeming (1):
      powerpc/boot: Handle allocation failure in simple_realloc()

Lianqin Hu (1):
      ALSA: usb-audio: Add delay quirk for VIVO USB-C-XE710 HEADSET

Loan Chen (1):
      drm/amd/display: Enable otg synchronization logic for DCN321

Long Li (1):
      net: mana: Fix doorbell out of order violation and avoid unnecessary doorbell rings

Lorenzo Bianconi (1):
      net: ethernet: mtk_wed: check update_wo_rx_stats in mtk_wed_update_rx_stats()

Luiz Augusto von Dentz (3):
      Bluetooth: bnep: Fix out-of-bound access
      Bluetooth: hci_core: Fix LE quote calculation
      Bluetooth: SMP: Fix assumption of Central always being Initiator

Maciej Fijalkowski (3):
      ice: fix page reuse when PAGE_SIZE is over 8k
      ice: fix ICE_LAST_OFFSET formula
      ice: fix truesize operations for PAGE_SIZE >= 8192

Manish Dharanenthiran (1):
      wifi: ath12k: fix WARN_ON during ath12k_mac_update_vif_chan

Marc Zyngier (1):
      KVM: arm64: Make ICC_*SGI*_EL1 undef in the absence of a vGICv3

Martin Blumenstingl (1):
      clocksource/drivers/arm_global_timer: Guard against division by zero

Martin Whitaker (1):
      net: dsa: microchip: fix PTP config failure when using multiple ports

Masahiro Yamada (2):
      rust: suppress error messages from CONFIG_{RUSTC,BINDGEN}_VERSION_TEXT
      rust: fix the default format for CONFIG_{RUSTC,BINDGEN}_VERSION_TEXT

Mathias Nyman (1):
      xhci: Fix Panther point NULL pointer deref at full-speed re-enumeration

Mathieu Othacehe (1):
      tty: atmel_serial: use the correct RTS flag.

Matthieu Baerts (NGI0) (14):
      selftests: net: lib: ignore possible errors
      selftests: net: lib: kill PIDs before del netns
      mptcp: pm: re-using ID of unused removed ADD_ADDR
      mptcp: pm: re-using ID of unused removed subflows
      mptcp: pm: re-using ID of unused flushed subflows
      mptcp: pm: remove mptcp_pm_remove_subflow()
      mptcp: pm: only mark 'subflow' endp as available
      mptcp: pm: only decrement add_addr_accepted for MPJ req
      mptcp: pm: check add_addr_accept_max before accepting new ADD_ADDR
      mptcp: pm: only in-kernel cannot have entries with ID 0
      mptcp: pm: fullmesh: select the right ID later
      mptcp: pm: avoid possible UaF when selecting endp
      selftests: mptcp: join: validate fullmesh endp on 1st sf
      selftests: mptcp: join: check re-using ID of closed subflow

Max Filippov (1):
      fs: binfmt_elf_efpic: don't use missing interpreter's properties

Max Kellermann (1):
      fs/netfs/fscache_cookie: add missing "n_accesses" check

Maximilian Luz (1):
      platform/surface: aggregator: Fix warning when controller is destroyed in probe

Melissa Wen (1):
      drm/amd/display: fix cursor offset on rotation 180

Menglong Dong (1):
      net: ovs: fix ovs_drop_reasons error

Mengqi Zhang (1):
      mmc: mtk-sd: receive cmd8 data when hs400 tuning fail

Mengyuan Lou (1):
      net: ngbe: Fix phy mode set to external phy

Michael Ellerman (1):
      powerpc/boot: Only free if realloc() succeeds

Michael Grzeschik (1):
      usb: gadget: uvc: cleanup request when not in correct state

Michael Mueller (1):
      KVM: s390: fix validity interception issue when gisa is switched off

Miguel Ojeda (1):
      rust: work around `bindgen` 0.69.0 issue

Mika Westerberg (1):
      thunderbolt: Mark XDomain as unplugged when router is removed

Mike Christie (1):
      scsi: spi: Fix sshdr use

Mikko Perttunen (1):
      drm/tegra: Zero-initialize iosys_map

Mikulas Patocka (2):
      dm persistent data: fix memory allocation failure
      dm suspend: return -ERESTARTSYS instead of -EINTR

Mimi Zohar (1):
      evm: don't copy up 'security.evm' xattr

Miri Korenblit (1):
      wifi: iwlwifi: abort scan when rfkill on but device enabled

Muhammad Usama Anjum (1):
      selftests: memfd_secret: don't build memfd_secret test on unsupported arches

Mukesh Sisodiya (1):
      wifi: iwlwifi: fw: Fix debugfs command sending

Nam Cao (1):
      riscv: change XIP's kernel_map.size to be size of the entire kernel

Namjae Jeon (2):
      ksmbd: the buffer of smb2 query dir response has at least 1 byte
      ksmbd: fix race condition between destroy_previous_session() and smb2 operations()

Naohiro Aota (1):
      btrfs: zoned: properly take lock to read/update block group's zoned variables

Nathan Lynch (1):
      powerpc/pseries/papr-sysparm: Validate buffer object lengths

Neel Natu (1):
      kernfs: fix false-positive WARN(nr_mmapped) in kernfs_drain_open_files

NeilBrown (2):
      NFS: avoid infinite loop in pnfs_update_layout.
      NFSD: simplify error paths in nfsd_svc()

Nikolay Aleksandrov (4):
      bonding: fix bond_ipsec_offload_ok return type
      bonding: fix null pointer deref in bond_ipsec_offload_ok
      bonding: fix xfrm real_dev null pointer dereference
      bonding: fix xfrm state handling when clearing active slave

Nikolay Kuratov (1):
      cxgb4: add forgotten u64 ivlan cast before shift

Nysal Jan K.A (2):
      cpu/SMT: Enable SMT only if a core is online
      powerpc/topology: Check if a core is online

Ofir Bitton (1):
      accel/habanalabs/gaudi2: unsecure tpc count registers

Oreoluwa Babatunde (1):
      openrisc: Call setup_memory() earlier in the init sequence

Pablo Neira Ayuso (1):
      netfilter: flowtable: validate vlan header

Paolo Abeni (1):
      igb: cope with large MAX_SKB_FRAGS

Parsa Poorshikhian (1):
      ALSA: hda/realtek: Fix noise from speakers on Lenovo IdeaPad 3 15IAU7

Paul E. McKenney (1):
      rcu: Eliminate rcu_gp_slow_unregister() false positive

Paul Moore (1):
      selinux: revert our use of vma_is_initial_heap()

Paulo Alcantara (1):
      smb: client: ignore unhandled reparse tags

Pawel Dembicki (3):
      net: dsa: vsc73xx: pass value in phy_write operation
      net: dsa: vsc73xx: use read_poll_timeout instead delay loop
      net: dsa: vsc73xx: check busy flag in MDIO operations

Peiyang Wang (1):
      net: hns3: use the user's cfg after reset

Peng Fan (2):
      tty: serial: fsl_lpuart: mark last busy before uart_add_one_port
      pmdomain: imx: wait SSAR when i.MX93 power domain on

Peter Ujfalusi (1):
      ASoC: SOF: Intel: hda-dsp: Make sure that no irq handler is pending before suspend

Phil Chang (1):
      hrtimer: Prevent queuing of hrtimer without a function callback

Phil Sutter (9):
      netfilter: nf_tables: Audit log dump reset after the fact
      netfilter: nf_tables: Drop pointless memset in nf_tables_dump_obj
      netfilter: nf_tables: Unconditionally allocate nft_obj_filter
      netfilter: nf_tables: A better name for nft_obj_filter
      netfilter: nf_tables: Carry s_idx in nft_obj_dump_ctx
      netfilter: nf_tables: nft_obj_filter fits into cb->ctx
      netfilter: nf_tables: Carry reset boolean in nft_obj_dump_ctx
      netfilter: nf_tables: Introduce nf_tables_getobj_single
      netfilter: nf_tables: Add locking for NFT_MSG_GETOBJ_RESET requests

Philip Yang (1):
      drm/amdkfd: Move dma unmapping after TLB flush

Philipp Stanner (1):
      media: drivers/media/dvb-core: copy user arrays safely

Qiuxu Zhuo (2):
      EDAC/skx_common: Filter out the invalid address
      EDAC/skx_common: Allow decoding of SGX addresses

Qu Wenruo (3):
      btrfs: tree-checker: reject BTRFS_FT_UNKNOWN dir type
      btrfs: tree-checker: add dev extent item checks
      btrfs: zlib: fix and simplify the inline extent decompression

Radhey Shyam Pandey (1):
      net: axienet: Fix register defines comment description

Rafael J. Wysocki (3):
      Revert "ACPI: EC: Evaluate orphan _REG under EC device"
      ACPICA: Add a depth argument to acpi_execute_reg_methods()
      ACPI: EC: Evaluate _REG outside the EC scope more carefully

Rand Deeb (1):
      ssb: Fix division by zero issue in ssb_calc_clock_rate

Ricardo Rivera-Matos (1):
      ASoC: cs35l45: Checks index of cs35l45_irqs[]

Richard Acayan (1):
      iommu/arm-smmu-qcom: Add SDM670 MDSS compatible

Richard Fitzgerald (1):
      firmware: cirrus: cs_dsp: Initialize debugfs_root to invalid

Rob Clark (1):
      drm/msm: Reduce fallout of fence signaling vs reclaim hangs

Rodrigo Siqueira (1):
      drm/amd/display: Adjust cursor position

Ryan Roberts (1):
      selftests/mm: log run_vmtests.sh results in TAP format

Sagi Grimberg (1):
      nvmet-rdma: fix possible bad dereference when freeing rsps

Samuel Holland (1):
      arm64: Fix KASAN random tag seed initialization

Sean Anderson (2):
      net: xilinx: axienet: Always disable promiscuous mode
      net: xilinx: axienet: Fix dangling multicast addresses

Sean Nyekjaer (1):
      i2c: stm32f7: Add atomic_xfer method to driver

Sebastian Andrzej Siewior (2):
      netfilter: nft_counter: Disable BH in nft_counter_offload_stats().
      netfilter: nft_counter: Synchronize nft_counter_reset() against reader.

Shannon Nelson (4):
      ionic: prevent pci disable of already disabled device
      ionic: no fw read when PCI reset failed
      ionic: use pci_is_enabled not open code
      ionic: check cmd_regs before copying in or out

Shaul Triebitz (1):
      wifi: iwlwifi: mvm: avoid garbage iPN

Simon Horman (1):
      tc-testing: don't access non-existent variable on exception

Somnath Kotur (1):
      bnxt_en: Fix double DMA unmapping for XDP_REDIRECT

Stefan Haberland (1):
      s390/dasd: fix error recovery leading to data corruption on ESE devices

Stefan Hajnoczi (1):
      virtiofs: forbid newlines in tags

Stephen Hemminger (1):
      netem: fix return value if duplicate enqueue fails

Subash Abhinov Kasiviswanathan (1):
      tcp: Update window clamping condition

Suren Baghdasaryan (1):
      change alloc_pages name in dma_map_ops to avoid name conflicts

Takashi Iwai (2):
      ALSA: hda/tas2781: Use correct endian conversion
      ALSA: timer: Relax start tick time check for slave timer elements

Tetsuo Handa (1):
      Input: MT - limit max slots

Thomas Bogendoerfer (1):
      ip6_tunnel: Fix broken GRO

Tom Hughes (1):
      netfilter: allow ipv6 fragments to arrive on different devices

Tomer Tayar (1):
      accel/habanalabs: export dma-buf only if size/offset multiples of PAGE_SIZE

Tomi Valkeinen (1):
      drm/bridge: tc358768: Attempt to fix DSI horizontal timings

Uwe Kleine-König (1):
      usb: gadget: fsl: Increase size of name buffer for endpoints

Vladimir Oltean (3):
      net: mscc: ocelot: use ocelot_xmit_get_vlan_info() also for FDMA and register injection
      net: mscc: ocelot: fix QoS class for injected packets with "ocelot-8021q"
      net: mscc: ocelot: serialize access to the injection/extraction groups

Waiman Long (1):
      mm/memory-failure: use raw_spinlock_t in struct memory_failure_cpu

Werner Sembach (2):
      Input: i8042 - add forcenorestore quirk to leave controller untouched even on s3
      Input: i8042 - use new forcenorestore quirk to replace old buggy quirk combination

Wolfram Sang (1):
      i2c: riic: avoid potential division by zero

Xu Yang (1):
      Revert "usb: typec: tcpm: clear pd_event queue in PORT_RESET"

Yonghong Song (2):
      bpf: Fix a kernel verifier crash in stacksafe()
      selftests/bpf: Add a test to verify previous stacksafe() fix

Yu Kuai (1):
      md/raid5-cache: use READ_ONCE/WRITE_ONCE for 'conf->log'

Yury Norov (1):
      sched/topology: Handle NUMA_NO_NODE in sched_numa_find_nth_cpu()

Zhen Lei (4):
      selinux: fix potential counting error in avc_add_xperms_decision()
      selinux: add the processing of the failure of avc_add_xperms_decision()
      mm: Remove kmem_valid_obj()
      rcu: Dump memory object info if callback function is invalid

ZhenGuo Yin (1):
      drm/amdgpu: access RLC_SPM_MC_CNTL through MMIO in SRIOV runtime

Zheng Zhang (1):
      net: ethernet: mtk_wed: fix use-after-free panic in mtk_wed_setup_tc_block_cb()

Zhiguo Niu (2):
      f2fs: stop checkpoint when get a out-of-bounds segment
      f2fs: fix to do sanity check in update_sit_entry

Zhihao Cheng (1):
      vfs: Don't evict inode under the inode lru traversing context

Zhu Yanjun (1):
      RDMA/rtrs: Fix the problem of variable not initialized fully

Zi Yan (2):
      mm/numa: no task_numa_fault() call if PMD is changed
      mm/numa: no task_numa_fault() call if PTE is changed

Zijun Hu (1):
      Bluetooth: hci_conn: Check non NULL function before calling for HFP offload

farah kassabri (1):
      accel/habanalabs: fix bug in timestamp interrupt handling


