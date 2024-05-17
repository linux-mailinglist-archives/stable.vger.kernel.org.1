Return-Path: <stable+bounces-45392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6338C860A
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 14:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE0128400D
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 12:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988AC51C5B;
	Fri, 17 May 2024 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N+KWYksQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3E1482E9;
	Fri, 17 May 2024 11:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715947143; cv=none; b=anKHCKSwMrfvm8irrMD5ZlYHgYhMSkVH9Jwmp6k2rOpaDYIpAPTacvqNLAoUNkogUFjXFGgGSIARfoDtSZX6MA+pAf1AgASAN3XHDAEx+SZHlluCcObFRBp3mvzUN0lgdWEVxAM+LAjMaZc2JMZJQvr4vu/ZFTbhvI018iVllqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715947143; c=relaxed/simple;
	bh=ATC8xdEH3hl00eS6i9x5HZs/CmfJYux915vNEQSR2+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O2eBDphlYsBPULLGdDnMup5nseYdexDS459522FTvCvD6tZI16RBLMFUfZUyfLyYfMapo2Hergq2E50Z3bbg6twSSOB42hQm8nMxsFuFYZVbrblL2kUMYL1Sh5ZZE4UeVB4nPbucIbTuUNK5FdXaJUQHfNZvW3Q8zo/6EKssghQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N+KWYksQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375A7C2BD10;
	Fri, 17 May 2024 11:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715947142;
	bh=ATC8xdEH3hl00eS6i9x5HZs/CmfJYux915vNEQSR2+8=;
	h=From:To:Cc:Subject:Date:From;
	b=N+KWYksQxAF1W908lZgd+CqBaYQyFouRgifSZenpIFOrv2+fVP48TEPEFDORMohl0
	 jYu/b2YmHpWRDFgUZLlWNoxKjLV2hrhKLFDNVOOw0eeacTrBAkAlPQbP+fD/7JBLXz
	 r6lg/wFFimqsutxmjNLYa0xgV2DPQUBgXpQJKk6Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.8.10
Date: Fri, 17 May 2024 13:58:52 +0200
Message-ID: <2024051752-satin-propeller-b33f@gregkh>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.8.10 kernel.

All users of the 6.8 kernel series must upgrade.

The updated 6.8.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.8.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml      |    2 
 Documentation/devicetree/bindings/net/mediatek,net.yaml               |   22 -
 Documentation/netlink/specs/rt_link.yaml                              |    6 
 Makefile                                                              |    2 
 arch/arm/kernel/sleep.S                                               |    4 
 arch/arm/net/bpf_jit_32.c                                             |   56 ++-
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts           |    3 
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts                              |   30 -
 arch/arm64/kvm/vgic/vgic-kvm-device.c                                 |    8 
 arch/arm64/net/bpf_jit_comp.c                                         |    6 
 arch/mips/include/asm/ptrace.h                                        |    2 
 arch/mips/kernel/asm-offsets.c                                        |    1 
 arch/mips/kernel/ptrace.c                                             |   15 
 arch/mips/kernel/scall32-o32.S                                        |   23 -
 arch/mips/kernel/scall64-n32.S                                        |    3 
 arch/mips/kernel/scall64-n64.S                                        |    3 
 arch/mips/kernel/scall64-o32.S                                        |   33 -
 arch/powerpc/crypto/chacha-p10-glue.c                                 |    8 
 arch/powerpc/include/asm/plpks.h                                      |    5 
 arch/powerpc/platforms/pseries/iommu.c                                |    8 
 arch/powerpc/platforms/pseries/plpks.c                                |   10 
 arch/riscv/net/bpf_jit_comp64.c                                       |    6 
 arch/s390/include/asm/dwarf.h                                         |    1 
 arch/s390/kernel/vdso64/vdso_user_wrapper.S                           |    2 
 arch/s390/mm/gmap.c                                                   |    2 
 arch/s390/mm/hugetlbpage.c                                            |    2 
 arch/x86/kernel/apic/apic.c                                           |   16 
 arch/xtensa/include/asm/processor.h                                   |    8 
 arch/xtensa/include/asm/ptrace.h                                      |    2 
 arch/xtensa/kernel/process.c                                          |    5 
 arch/xtensa/kernel/stacktrace.c                                       |    3 
 block/blk-iocost.c                                                    |   14 
 block/ioctl.c                                                         |    5 
 drivers/accel/ivpu/ivpu_drv.c                                         |   20 -
 drivers/accel/ivpu/ivpu_drv.h                                         |    3 
 drivers/accel/ivpu/ivpu_hw_37xx.c                                     |    4 
 drivers/accel/ivpu/ivpu_mmu.c                                         |    8 
 drivers/accel/ivpu/ivpu_pm.c                                          |    9 
 drivers/ata/sata_gemini.c                                             |    5 
 drivers/base/regmap/regmap.c                                          |   37 ++
 drivers/bluetooth/btqca.c                                             |  138 ++++++-
 drivers/bluetooth/btqca.h                                             |    3 
 drivers/bluetooth/hci_qca.c                                           |    2 
 drivers/clk/clk.c                                                     |   12 
 drivers/clk/qcom/clk-smd-rpm.c                                        |    1 
 drivers/clk/samsung/clk-exynos-clkout.c                               |   13 
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c                                 |    2 
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c                                  |   19 -
 drivers/clk/sunxi-ng/ccu_common.c                                     |   19 +
 drivers/clk/sunxi-ng/ccu_common.h                                     |    3 
 drivers/dma/idxd/cdev.c                                               |   77 ++++
 drivers/dma/idxd/idxd.h                                               |    3 
 drivers/dma/idxd/init.c                                               |    4 
 drivers/dma/idxd/registers.h                                          |    3 
 drivers/dma/idxd/sysfs.c                                              |   27 +
 drivers/edac/versal_edac.c                                            |    4 
 drivers/firewire/nosy.c                                               |    6 
 drivers/firewire/ohci.c                                               |   14 
 drivers/firmware/efi/unaccepted_memory.c                              |    4 
 drivers/firmware/microchip/mpfs-auto-update.c                         |    2 
 drivers/gpio/gpio-crystalcove.c                                       |    2 
 drivers/gpio/gpio-lpc32xx.c                                           |    1 
 drivers/gpio/gpio-wcove.c                                             |    2 
 drivers/gpio/gpiolib-cdev.c                                           |   16 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                            |   26 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c                         |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c                               |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c                            |   14 
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h                            |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                               |   52 +-
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c                            |   15 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c                              |   16 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                              |   11 
 drivers/gpu/drm/amd/amdkfd/kfd_device.c                               |   17 
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c                      |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c                      |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c                       |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                     |   15 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c             |   48 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c                    |    1 
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c      |    6 
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c               |   33 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                             |   27 +
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h                         |    1 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c                  |    8 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c                  |    2 
 drivers/gpu/drm/drm_connector.c                                       |    2 
 drivers/gpu/drm/i915/display/intel_audio.c                            |  113 ------
 drivers/gpu/drm/i915/display/intel_bios.c                             |   19 -
 drivers/gpu/drm/i915/display/intel_vbt_defs.h                         |    5 
 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c                           |    6 
 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h                           |    2 
 drivers/gpu/drm/i915/gt/intel_workarounds.c                           |    4 
 drivers/gpu/drm/imagination/pvr_fw_mips.h                             |    5 
 drivers/gpu/drm/meson/meson_dw_hdmi.c                                 |   70 +--
 drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h                     |    4 
 drivers/gpu/drm/nouveau/nouveau_dp.c                                  |   13 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c                        |   79 ++--
 drivers/gpu/drm/panel/Kconfig                                         |    2 
 drivers/gpu/drm/panel/panel-ilitek-ili9341.c                          |   13 
 drivers/gpu/drm/qxl/qxl_release.c                                     |   50 --
 drivers/gpu/drm/radeon/pptable.h                                      |   10 
 drivers/gpu/drm/ttm/ttm_tt.c                                          |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                                    |    1 
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c                                 |    2 
 drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h                     |    3 
 drivers/gpu/drm/xe/regs/xe_engine_regs.h                              |    2 
 drivers/gpu/drm/xe/xe_lrc.c                                           |   25 -
 drivers/gpu/drm/xe/xe_migrate.c                                       |    8 
 drivers/gpu/host1x/bus.c                                              |    8 
 drivers/hv/channel.c                                                  |   29 +
 drivers/hv/connection.c                                               |   29 +
 drivers/hwmon/corsair-cpro.c                                          |   45 +-
 drivers/hwmon/pmbus/ucd9000.c                                         |    6 
 drivers/iio/accel/mxc4005.c                                           |   92 ++++
 drivers/iio/imu/adis16475.c                                           |    4 
 drivers/iio/pressure/bmp280-core.c                                    |    1 
 drivers/iio/pressure/bmp280-spi.c                                     |   13 
 drivers/iio/pressure/bmp280.h                                         |    1 
 drivers/infiniband/hw/qib/qib_fs.c                                    |    1 
 drivers/iommu/amd/iommu.c                                             |    4 
 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c                          |    4 
 drivers/iommu/mtk_iommu.c                                             |    1 
 drivers/iommu/mtk_iommu_v1.c                                          |    1 
 drivers/misc/mei/hw-me-regs.h                                         |    2 
 drivers/misc/mei/pci-me.c                                             |    2 
 drivers/misc/pvpanic/pvpanic-pci.c                                    |    4 
 drivers/net/dsa/mv88e6xxx/chip.c                                      |   20 -
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                        |   32 +
 drivers/net/ethernet/broadcom/genet/bcmgenet.h                        |    4 
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c                    |    8 
 drivers/net/ethernet/broadcom/genet/bcmmii.c                          |    6 
 drivers/net/ethernet/brocade/bna/bnad_debugfs.c                       |    4 
 drivers/net/ethernet/chelsio/cxgb4/sge.c                              |    6 
 drivers/net/ethernet/hisilicon/hns3/hnae3.h                           |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c               |   52 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h               |    5 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c                |    7 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c             |   20 -
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h             |    2 
 drivers/net/ethernet/intel/e1000e/phy.c                               |    8 
 drivers/net/ethernet/intel/ice/ice_debugfs.c                          |    8 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c               |    4 
 drivers/net/ethernet/micrel/ks8851_common.c                           |   16 
 drivers/net/ethernet/qlogic/qede/qede_filter.c                        |   14 
 drivers/net/hyperv/netvsc.c                                           |    7 
 drivers/net/usb/qmi_wwan.c                                            |    1 
 drivers/net/vxlan/vxlan_core.c                                        |   49 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c                      |    7 
 drivers/net/wireless/intel/iwlwifi/queue/tx.c                         |    2 
 drivers/nvme/host/core.c                                              |    2 
 drivers/nvme/host/nvme.h                                              |    5 
 drivers/nvme/host/pci.c                                               |   14 
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c                            |   34 -
 drivers/pinctrl/core.c                                                |    8 
 drivers/pinctrl/devicetree.c                                          |   10 
 drivers/pinctrl/intel/pinctrl-baytrail.c                              |   74 ++--
 drivers/pinctrl/intel/pinctrl-intel.h                                 |    4 
 drivers/pinctrl/mediatek/pinctrl-paris.c                              |   40 --
 drivers/pinctrl/meson/pinctrl-meson-a1.c                              |    6 
 drivers/platform/x86/acer-wmi.c                                       |    9 
 drivers/platform/x86/amd/pmf/acpi.c                                   |    2 
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c           |    1 
 drivers/power/supply/mt6360_charger.c                                 |    2 
 drivers/power/supply/rt9455_charger.c                                 |    2 
 drivers/regulator/core.c                                              |   27 -
 drivers/regulator/mt6360-regulator.c                                  |   32 +
 drivers/regulator/tps65132-regulator.c                                |    7 
 drivers/s390/cio/cio_inject.c                                         |    2 
 drivers/s390/net/qeth_core_main.c                                     |   61 +--
 drivers/scsi/bnx2fc/bnx2fc_tgt.c                                      |    2 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                                |   10 
 drivers/scsi/libsas/sas_expander.c                                    |    2 
 drivers/scsi/lpfc/lpfc.h                                              |    2 
 drivers/scsi/lpfc/lpfc_attr.c                                         |    4 
 drivers/scsi/lpfc/lpfc_bsg.c                                          |   20 -
 drivers/scsi/lpfc/lpfc_debugfs.c                                      |   12 
 drivers/scsi/lpfc/lpfc_els.c                                          |   20 -
 drivers/scsi/lpfc/lpfc_hbadisc.c                                      |    5 
 drivers/scsi/lpfc/lpfc_init.c                                         |    5 
 drivers/scsi/lpfc/lpfc_nvme.c                                         |    4 
 drivers/scsi/lpfc/lpfc_scsi.c                                         |   13 
 drivers/scsi/lpfc/lpfc_sli.c                                          |   34 -
 drivers/scsi/lpfc/lpfc_vport.c                                        |    8 
 drivers/scsi/mpi3mr/mpi3mr_app.c                                      |    2 
 drivers/slimbus/qcom-ngd-ctrl.c                                       |    6 
 drivers/spi/spi-axi-spi-engine.c                                      |   19 -
 drivers/spi/spi-hisi-kunpeng.c                                        |    2 
 drivers/spi/spi-microchip-core-qspi.c                                 |    1 
 drivers/spi/spi.c                                                     |    1 
 drivers/target/target_core_configfs.c                                 |   12 
 drivers/thermal/thermal_debugfs.c                                     |   59 ++-
 drivers/ufs/core/ufs-mcq.c                                            |    2 
 drivers/ufs/core/ufshcd.c                                             |    9 
 drivers/uio/uio_hv_generic.c                                          |   12 
 drivers/usb/core/hub.c                                                |    5 
 drivers/usb/core/port.c                                               |    8 
 drivers/usb/dwc3/core.c                                               |   90 ++--
 drivers/usb/dwc3/core.h                                               |    1 
 drivers/usb/dwc3/gadget.c                                             |    2 
 drivers/usb/dwc3/host.c                                               |   27 +
 drivers/usb/gadget/composite.c                                        |    6 
 drivers/usb/gadget/function/f_fs.c                                    |    9 
 drivers/usb/gadget/function/uvc_configfs.c                            |    4 
 drivers/usb/host/ohci-hcd.c                                           |    8 
 drivers/usb/host/xhci-plat.h                                          |    4 
 drivers/usb/host/xhci-rzv2m.c                                         |    1 
 drivers/usb/typec/tcpm/tcpm.c                                         |   36 +
 drivers/usb/typec/ucsi/ucsi.c                                         |   12 
 drivers/vfio/pci/vfio_pci.c                                           |    2 
 fs/9p/fid.h                                                           |    3 
 fs/9p/vfs_file.c                                                      |    2 
 fs/9p/vfs_inode.c                                                     |   23 -
 fs/9p/vfs_super.c                                                     |    1 
 fs/btrfs/inode.c                                                      |    2 
 fs/btrfs/ordered-data.c                                               |    1 
 fs/btrfs/qgroup.c                                                     |    2 
 fs/btrfs/transaction.c                                                |    2 
 fs/btrfs/tree-checker.c                                               |   30 -
 fs/btrfs/tree-checker.h                                               |    1 
 fs/btrfs/volumes.c                                                    |   18 
 fs/exfat/file.c                                                       |    7 
 fs/gfs2/bmap.c                                                        |    5 
 fs/nfs/client.c                                                       |    5 
 fs/nfs/inode.c                                                        |   13 
 fs/nfs/internal.h                                                     |    2 
 fs/nfs/netns.h                                                        |    2 
 fs/nfsd/cache.h                                                       |    2 
 fs/nfsd/netns.h                                                       |   21 -
 fs/nfsd/nfs4callback.c                                                |   97 +++++
 fs/nfsd/nfs4proc.c                                                    |    6 
 fs/nfsd/nfs4state.c                                                   |    3 
 fs/nfsd/nfs4xdr.c                                                     |    2 
 fs/nfsd/nfscache.c                                                    |   40 --
 fs/nfsd/nfsctl.c                                                      |   14 
 fs/nfsd/nfsfh.c                                                       |    3 
 fs/nfsd/state.h                                                       |   14 
 fs/nfsd/stats.c                                                       |   43 --
 fs/nfsd/stats.h                                                       |   62 +--
 fs/nfsd/vfs.c                                                         |    6 
 fs/nfsd/xdr4cb.h                                                      |   18 
 fs/proc/task_mmu.c                                                    |   24 -
 fs/smb/client/cifsglob.h                                              |    1 
 fs/smb/client/connect.c                                               |    8 
 fs/smb/client/fs_context.c                                            |   21 +
 fs/smb/client/fs_context.h                                            |    2 
 fs/smb/client/misc.c                                                  |    1 
 fs/smb/client/smb2pdu.c                                               |   11 
 fs/smb/server/oplock.c                                                |   35 +
 fs/smb/server/transport_tcp.c                                         |    4 
 fs/tracefs/event_inode.c                                              |   45 +-
 fs/tracefs/inode.c                                                    |   92 ++++
 fs/tracefs/internal.h                                                 |    7 
 fs/userfaultfd.c                                                      |    4 
 fs/vboxsf/file.c                                                      |    1 
 include/linux/compiler_types.h                                        |   11 
 include/linux/dma-fence.h                                             |    7 
 include/linux/gfp_types.h                                             |    2 
 include/linux/hyperv.h                                                |    1 
 include/linux/pci_ids.h                                               |    2 
 include/linux/regmap.h                                                |    8 
 include/linux/regulator/consumer.h                                    |    4 
 include/linux/skbuff.h                                                |   15 
 include/linux/skmsg.h                                                 |    2 
 include/linux/slab.h                                                  |    4 
 include/linux/sockptr.h                                               |   25 +
 include/linux/sunrpc/clnt.h                                           |    1 
 include/net/gro.h                                                     |    9 
 include/net/xfrm.h                                                    |    3 
 include/sound/emu10k1.h                                               |    3 
 include/trace/events/rxrpc.h                                          |    2 
 include/uapi/linux/kfd_ioctl.h                                        |   17 
 include/uapi/scsi/scsi_bsg_mpi3mr.h                                   |    2 
 kernel/bpf/bloom_filter.c                                             |   13 
 kernel/bpf/verifier.c                                                 |    3 
 kernel/dma/swiotlb.c                                                  |    1 
 kernel/workqueue.c                                                    |    8 
 lib/Kconfig.debug                                                     |    5 
 lib/dynamic_debug.c                                                   |    6 
 lib/maple_tree.c                                                      |   16 
 lib/scatterlist.c                                                     |    2 
 mm/readahead.c                                                        |    4 
 mm/slub.c                                                             |   52 +-
 net/8021q/vlan_core.c                                                 |    2 
 net/bluetooth/hci_core.c                                              |    3 
 net/bluetooth/hci_event.c                                             |    2 
 net/bluetooth/l2cap_core.c                                            |    3 
 net/bluetooth/msft.c                                                  |    2 
 net/bluetooth/msft.h                                                  |    4 
 net/bluetooth/sco.c                                                   |    4 
 net/bridge/br_forward.c                                               |    9 
 net/bridge/br_netlink.c                                               |    3 
 net/core/filter.c                                                     |   42 +-
 net/core/gro.c                                                        |    1 
 net/core/link_watch.c                                                 |    4 
 net/core/net-sysfs.c                                                  |    4 
 net/core/net_namespace.c                                              |   13 
 net/core/rtnetlink.c                                                  |    6 
 net/core/skbuff.c                                                     |   27 +
 net/core/skmsg.c                                                      |    5 
 net/core/sock.c                                                       |    4 
 net/hsr/hsr_device.c                                                  |   31 -
 net/ipv4/af_inet.c                                                    |    1 
 net/ipv4/ip_output.c                                                  |    2 
 net/ipv4/raw.c                                                        |    3 
 net/ipv4/tcp.c                                                        |    4 
 net/ipv4/tcp_input.c                                                  |    2 
 net/ipv4/tcp_ipv4.c                                                   |    8 
 net/ipv4/tcp_output.c                                                 |    4 
 net/ipv4/udp.c                                                        |    3 
 net/ipv4/udp_offload.c                                                |   15 
 net/ipv4/xfrm4_input.c                                                |    6 
 net/ipv6/addrconf.c                                                   |   11 
 net/ipv6/fib6_rules.c                                                 |    6 
 net/ipv6/ip6_input.c                                                  |    4 
 net/ipv6/ip6_offload.c                                                |    1 
 net/ipv6/ip6_output.c                                                 |    4 
 net/ipv6/udp.c                                                        |    3 
 net/ipv6/udp_offload.c                                                |    3 
 net/ipv6/xfrm6_input.c                                                |    6 
 net/l2tp/l2tp_eth.c                                                   |    3 
 net/mac80211/ieee80211_i.h                                            |    4 
 net/mac80211/mlme.c                                                   |    5 
 net/mptcp/ctrl.c                                                      |   39 ++
 net/mptcp/protocol.c                                                  |    3 
 net/nfc/llcp_sock.c                                                   |   12 
 net/nfc/nci/core.c                                                    |    1 
 net/nsh/nsh.c                                                         |   14 
 net/phonet/pn_netlink.c                                               |    2 
 net/rxrpc/ar-internal.h                                               |    2 
 net/rxrpc/call_object.c                                               |    7 
 net/rxrpc/conn_event.c                                                |   16 
 net/rxrpc/conn_object.c                                               |    9 
 net/rxrpc/input.c                                                     |   71 ++-
 net/rxrpc/output.c                                                    |   14 
 net/rxrpc/protocol.h                                                  |    6 
 net/smc/smc_ib.c                                                      |   19 -
 net/sunrpc/clnt.c                                                     |    5 
 net/sunrpc/xprtsock.c                                                 |    1 
 net/tipc/msg.c                                                        |    8 
 net/wireless/nl80211.c                                                |    2 
 net/wireless/trace.h                                                  |    2 
 net/xfrm/xfrm_input.c                                                 |    8 
 rust/macros/module.rs                                                 |  185 ++++++----
 scripts/Makefile.modfinal                                             |    2 
 security/keys/key.c                                                   |    3 
 sound/hda/intel-sdw-acpi.c                                            |    2 
 sound/oss/dmasound/dmasound_paula.c                                   |    8 
 sound/pci/emu10k1/emu10k1.c                                           |    3 
 sound/pci/emu10k1/emu10k1_main.c                                      |  139 ++++---
 sound/pci/hda/patch_realtek.c                                         |   25 +
 sound/soc/codecs/es8326.c                                             |   30 -
 sound/soc/codecs/es8326.h                                             |    2 
 sound/soc/codecs/wsa881x.c                                            |    1 
 sound/soc/intel/avs/topology.c                                        |    2 
 sound/soc/meson/Kconfig                                               |    1 
 sound/soc/meson/axg-card.c                                            |    1 
 sound/soc/meson/axg-fifo.c                                            |   52 +-
 sound/soc/meson/axg-fifo.h                                            |   12 
 sound/soc/meson/axg-frddr.c                                           |    5 
 sound/soc/meson/axg-tdm-interface.c                                   |   34 +
 sound/soc/meson/axg-toddr.c                                           |   22 -
 sound/soc/sof/intel/hda-dsp.c                                         |   20 -
 sound/soc/sof/intel/pci-lnl.c                                         |    3 
 sound/soc/tegra/tegra186_dspk.c                                       |    7 
 sound/soc/ti/davinci-mcasp.c                                          |   12 
 sound/usb/line6/driver.c                                              |    6 
 tools/include/linux/kernel.h                                          |    1 
 tools/include/linux/mm.h                                              |    5 
 tools/include/linux/panic.h                                           |   19 +
 tools/power/x86/turbostat/turbostat.8                                 |    2 
 tools/power/x86/turbostat/turbostat.c                                 |  159 ++++++--
 tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c             |    6 
 tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc |    2 
 tools/testing/selftests/mm/Makefile                                   |    6 
 tools/testing/selftests/net/test_bridge_neigh_suppress.sh             |   14 
 tools/testing/selftests/timers/valid-adjtimex.c                       |   73 +--
 377 files changed, 3360 insertions(+), 1832 deletions(-)

Adam Goldman (1):
      firewire: ohci: mask bus reset interrupts between ISR and bottom half

Adam Skladowski (1):
      clk: qcom: smd-rpm: Restore msm8976 num_clk

Al Viro (1):
      qibfs: fix dentry leak

Alan Stern (2):
      usb: Fix regression caused by invalid ep0 maxpacket in virtual SuperSpeed device
      USB: core: Fix access violation during port device removal

Aleksa Savic (3):
      hwmon: (corsair-cpro) Use a separate buffer for sending commands
      hwmon: (corsair-cpro) Use complete_all() instead of complete() in ccp_raw_event()
      hwmon: (corsair-cpro) Protect ccp->wait_input_report with a spinlock

Alex Deucher (2):
      drm/radeon: silence UBSAN warning (v3)
      drm/amdkfd: don't allow mapping the MMIO HDP page with large pages

Alex Hung (1):
      drm/amd/display: Skip on writeback when it's not applicable

Alexander Potapenko (1):
      kmsan: compiler_types: declare __no_sanitize_or_inline

Alexander Usyskin (1):
      mei: me: add lunar lake point M DID

Alexandra Winter (1):
      s390/qeth: Fix kernel panic after setting hsuid

Amadeusz Sławiński (1):
      ASoC: Intel: avs: Set name of control as in topology

Aman Dhoot (1):
      ALSA: hda/realtek: Fix mute led of HP Laptop 15-da3001TU

Amit Sunil Dhamne (1):
      usb: typec: tcpm: unregister existing source caps before re-registration

Anand Jain (1):
      btrfs: return accurate error code on open failure in open_fs_devices()

Andi Shyti (1):
      drm/i915/gt: Automate CCS Mode setting during engine resets

Andrei Matei (1):
      bpf: Check bloom filter map value size

Andrew Price (1):
      gfs2: Fix invalid metadata access in punch_hole

Andrii Nakryiko (1):
      bpf, kconfig: Fix DEBUG_INFO_BTF_MODULES Kconfig definition

André Apitzsch (1):
      regulator: tps65132: Add of_match table

Andy Shevchenko (5):
      drm/panel: ili9341: Correct use of device property APIs
      drm/panel: ili9341: Respect deferred probe
      drm/panel: ili9341: Use predefined error codes
      gpio: wcove: Use -ENOTSUPP consistently
      gpio: crystalcove: Use -ENOTSUPP consistently

AngeloGioacchino Del Regno (2):
      power: supply: mt6360_charger: Fix of_match for usb-otg-vbus regulator
      regulator: mt6360: De-capitalize devicetree regulator subnodes

Anton Protopopov (1):
      bpf: Fix a verifier verbose message

Arjan van de Ven (2):
      VFIO: Add the SPR_DSA and SPR_IAX devices to the denylist
      dmaengine: idxd: add a new security check to deal with a hardware erratum

Arnd Bergmann (1):
      power: rt9455: hide unused rt9455_boost_voltage_values

Asbjørn Sloth Tønnesen (4):
      net: qede: sanitize 'rc' in qede_add_tc_flower_fltr()
      net: qede: use return from qede_parse_flow_attr() for flower
      net: qede: use return from qede_parse_flow_attr() for flow_spec
      net: qede: use return from qede_parse_actions()

Ashutosh Dixit (1):
      drm/xe: Label RING_CONTEXT_CONTROL as masked

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Check for port partner validity before consuming it

Benjamin Berg (1):
      wifi: iwlwifi: mvm: guard against invalid STA ID on removal

Benno Lossin (1):
      rust: macros: fix soundness issue in `module!` macro

Bernhard Rosenkränzer (1):
      platform/x86: acer-wmi: Add support for Acer PH18-71

Billy Tsai (1):
      pinctrl: pinctrl-aspeed-g6: Fix register offset for pinconf of GPIOR-T

Boris Burkov (2):
      btrfs: make btrfs_clear_delalloc_extent() free delalloc reserve
      btrfs: always clear PERTRANS metadata during commit

Borislav Petkov (AMD) (1):
      kbuild: Disable KCSAN for autogenerated *.mod.c intermediaries

Boy.Wu (1):
      ARM: 9381/1: kasan: clear stale stack poison

Bui Quang Minh (4):
      ice: ensure the copied buf is NUL terminated
      bna: ensure the copied buf is NUL terminated
      octeontx2-af: avoid off-by-one read from userspace
      s390/cio: Ensure the copied buf is NUL terminated

Chaitanya Kumar Borah (1):
      drm/i915/audio: Fix audio time stamp programming for DP

Chen Ni (1):
      ata: sata_gemini: Check clk_enable() result

Chen Yu (2):
      efi/unaccepted: touch soft lockup during memory accept
      tools/power turbostat: Do not print negative LPI residency

Chen-Yu Tsai (3):
      pinctrl: mediatek: paris: Fix PIN_CONFIG_INPUT_SCHMITT_ENABLE readback
      pinctrl: mediatek: paris: Rework support for PIN_CONFIG_{INPUT,OUTPUT}_ENABLE
      arm64: dts: mediatek: mt8183-pico6: Fix bluetooth node

Chris Wulff (1):
      usb: gadget: f_fs: Fix a race condition when processing setup packets.

Christian A. Ehrhardt (2):
      usb: typec: ucsi: Check for notifications after init
      usb: typec: ucsi: Fix connector check on init

Christian König (1):
      drm/amdgpu: once more fix the call oder in amdgpu_ttm_move() v2

Chuck Lever (1):
      NFSD: Fix nfsd4_encode_fattr4() crasher

Claudio Imbrenda (2):
      s390/mm: Fix storage key clearing for guest huge pages
      s390/mm: Fix clearing storage keys for huge pages

Conor Dooley (2):
      firmware: microchip: don't unconditionally print validation success
      spi: microchip-core-qspi: fix setting spi bus clock rate

Dai Ngo (1):
      NFSD: add support for CB_GETATTR callback

Dan Carpenter (2):
      pinctrl: core: delete incorrect free in pinctrl_enable()
      mm/slab: make __free(kfree) accept error pointers

Daniel Golle (1):
      dt-bindings: net: mediatek: remove wrongly added clocks and SerDes

Dave Airlie (1):
      Revert "drm/nouveau/firmware: Fix SG_DEBUG error with nvkm_firmware_ctor()"

David Bauer (1):
      net l2tp: drop flow hash on forward

David Howells (4):
      Fix a potential infinite loop in extract_user_to_sg()
      rxrpc: Fix the names of the fields in the ACK trailer struct
      rxrpc: Fix congestion control algorithm
      rxrpc: Only transmit one ACK per jumbo packet received

David Lechner (2):
      spi: axi-spi-engine: use common AXI macros
      spi: axi-spi-engine: fix version format string

Devyn Liu (1):
      spi: hisi-kunpeng: Delete the dump interface of data registers in debugfs

Dominique Martinet (1):
      btrfs: add missing mutex_unlock in btrfs_relocate_sys_chunks()

Donald Hunter (1):
      netlink: specs: Add missing bridge linkinfo attrs

Doug Berger (3):
      net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL access
      net: bcmgenet: synchronize use of bcmgenet_set_rx_mode()
      net: bcmgenet: synchronize UMAC_CMD access

Doug Smythies (1):
      tools/power turbostat: Fix added raw MSR output

Douglas Anderson (1):
      drm/connector: Add \n to message about demoting connector force-probes

Duoming Zhou (2):
      Bluetooth: Fix use-after-free bugs caused by sco_sock_timeout
      Bluetooth: l2cap: fix null-ptr-deref in l2cap_chan_timeout

Eric Dumazet (8):
      net: add copy_safe_from_sockptr() helper
      nfc: llcp: fix nfc_llcp_setsockopt() unsafe copies
      tcp: defer shutdown(SEND_SHUTDOWN) for TCP_SYN_RECV sockets
      phonet: fix rtm_phonet_notify() skb allocation
      ipv6: fib6_rules: avoid possible NULL dereference in fib6_rule_action()
      net-sysfs: convert dev->operstate reads to lockless ones
      ipv6: annotate data-races around cnf.disable_ipv6
      ipv6: prevent NULL dereference in ip6_output()

Eric Van Hensbergen (2):
      fs/9p: fix uninitialized values during inode evict
      fs/9p: remove erroneous nlink init from legacy stat2inode

Felix Fietkau (3):
      net: bridge: fix multicast-to-unicast with fraglist GSO
      net: core: reject skb_copy(_expand) for fraglist GSO skbs
      net: bridge: fix corrupted ethernet header on multicast-to-unicast

Frank Oltmanns (2):
      clk: sunxi-ng: common: Support minimum and maximum rate
      clk: sunxi-ng: a64: Set minimum and maximum rate for PLL-MIPI

Gabe Teeger (1):
      drm/amd/display: Atom Integrated System Info v2_2 for DCN35

Gaurav Batra (1):
      powerpc/pseries/iommu: LPAR panics during boot up with a frozen PE

George Shen (1):
      drm/amd/display: Handle Y carry-over in VCP X.Y calculation

Greg Kroah-Hartman (1):
      Linux 6.8.10

Gregory Detal (1):
      mptcp: only allow set existing scheduler for net.mptcp.scheduler

Guenter Roeck (1):
      usb: ohci: Prevent missed ohci interrupts

Guillaume Nault (3):
      vxlan: Fix racy device stats updates.
      vxlan: Add missing VNI filter counter update in arp_reduce().
      vxlan: Pull inner IP header in vxlan_rcv().

Hans de Goede (3):
      pinctrl: baytrail: Fix selecting gpio pinctrl state
      iio: accel: mxc4005: Interrupt handling fixes
      iio: accel: mxc4005: Reset chip on probe() and resume()

Hersen Wu (1):
      drm/amd/display: Fix incorrect DSC instance for MST

Himal Prasad Ghimiray (1):
      drm/xe/xe_migrate: Cast to output precision before multiplying operands

Ian Forbes (1):
      drm/vmwgfx: Fix Legacy Display Unit

Ido Schimmel (1):
      selftests: test_bridge_neigh_suppress.sh: Fix failures due to duplicate MAC

Igor Artemiev (1):
      wifi: cfg80211: fix rdev_dump_mpp() arguments order

Ivan Avdeev (1):
      usb: gadget: uvc: use correct buffer size when parsing configfs lists

Jacek Lawrynowicz (2):
      accel/ivpu: Remove d3hot_after_power_off WA
      accel/ivpu: Fix missed error message after VPU rename

Jan Dakinevich (1):
      pinctrl/meson: fix typo in PDM's pin name

Jason Gunthorpe (1):
      iommu/arm-smmu: Use the correct type in nvidia_smmu_context_fault()

Jason Xing (1):
      bpf, skmsg: Fix NULL pointer dereference in sk_psock_skb_ingress_enqueue

Javier Carrasco (1):
      dt-bindings: iio: health: maxim,max30102: fix compatible check

Jeff Johnson (1):
      wifi: mac80211: fix ieee80211_bss_*_flags kernel-doc

Jeff Layton (2):
      vboxsf: explicitly deny setlease attempts
      9p: explicitly deny setlease attempts

Jeffrey Altman (1):
      rxrpc: Clients must accept conn from any address

Jens Remus (1):
      s390/vdso: Add CFI for RA register to asm macro vdso_func

Jernej Skrabec (1):
      clk: sunxi-ng: h6: Reparent CPUX during PLL CPUX rate change

Jerome Brunet (7):
      ASoC: meson: axg-fifo: use FIELD helpers
      ASoC: meson: axg-fifo: use threaded irq to check periods
      ASoC: meson: axg-card: make links nonatomic
      ASoC: meson: axg-tdm-interface: manage formatters in trigger
      ASoC: meson: cards: select SND_DYNAMIC_MINORS
      drm/meson: dw-hdmi: power up phy on device init
      drm/meson: dw-hdmi: add bandgap setting for g12

Jian Shen (1):
      net: hns3: direct return when receive a unknown mailbox message

Jiaxun Yang (1):
      MIPS: scall: Save thread_info.syscall unconditionally on entry

Jim Cromie (1):
      dyndbg: fix old BUG_ON in >control parser

Joakim Sindholt (4):
      fs/9p: only translate RWX permissions for plain 9P2000
      fs/9p: translate O_TRUNC into OTRUNC
      fs/9p: fix the cache always being enabled on files with qid flags
      fs/9p: drop inodes immediately on non-.L too

Joao Paulo Goncalves (1):
      ASoC: ti: davinci-mcasp: Fix race condition during probe

Johan Hovold (9):
      regulator: core: fix debugfs creation regression
      Bluetooth: qca: fix invalid device address check
      Bluetooth: qca: fix wcn3991 device address check
      Bluetooth: qca: add missing firmware sanity checks
      Bluetooth: qca: fix NVM configuration parsing
      Bluetooth: qca: generalise device address check
      Bluetooth: qca: fix info leak when fetching board id
      Bluetooth: qca: fix info leak when fetching fw build id
      Bluetooth: qca: fix firmware check error path

Johannes Berg (3):
      wifi: nl80211: don't free NULL coalescing rule
      wifi: mac80211: fix prep_connection error path
      wifi: iwlwifi: read txq->read_ptr under lock

John Stultz (1):
      selftests: timers: Fix valid-adjtimex signed left-shift undefined behavior

Jonathan Kim (1):
      drm/amdkfd: range check cp bad op exception interrupts

Josef Bacik (7):
      sunrpc: add a struct rpc_stats arg to rpc_create_args
      nfs: expose /proc/net/sunrpc/nfs in net namespaces
      nfs: make the rpc_stat per net namespace
      nfsd: rename NFSD_NET_* to NFSD_STATS_*
      nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
      nfsd: make all of the nfsd stats per-network namespace
      btrfs: make sure that WRITTEN is set on all metadata blocks

Justin Ernst (1):
      tools/power/turbostat: Fix uncore frequency file string

Justin Tee (6):
      scsi: lpfc: Move NPIV's transport unregistration to after resource clean up
      scsi: lpfc: Remove IRQF_ONESHOT flag from threaded IRQ handling
      scsi: lpfc: Update lpfc_ramp_down_queue_handler() logic
      scsi: lpfc: Replace hbalock with ndlp lock in lpfc_nvme_unregister_port()
      scsi: lpfc: Release hbalock before calling lpfc_worker_wake_up()
      scsi: lpfc: Use a dedicated lock for ras_fwlog state

Karthikeyan Ramasubramanian (1):
      drm/i915/bios: Fix parsing backlight BDB data

Kees Cook (1):
      nouveau/gsp: Avoid addressing beyond end of rpc->entries

Kefeng Wang (1):
      mm: use memalloc_nofs_save() in page_cache_ra_order()

Kenneth Feng (1):
      drm/amd/pm: fix the high voltage issue after unload

Kent Gibson (1):
      gpiolib: cdev: fix uninitialised kfifo

Krzysztof Kozlowski (2):
      iommu: mtk: fix module autoloading
      gpio: lpc32xx: fix module autoloading

Kuniyuki Iwashima (3):
      nfs: Handle error of rpc_proc_register() in nfs_net_init().
      nsh: Restore skb->{protocol,data,mac_header} for outer header in nsh_gso_segment().
      tcp: Use refcount_inc_not_zero() in tcp_twsk_unique().

Lakshmi Yadlapati (1):
      hwmon: (pmbus/ucd9000) Increase delay from 250 to 500us

Len Brown (2):
      tools/power turbostat: Expand probe_intel_uncore_frequency()
      tools/power turbostat: Fix warning upon failed /dev/cpu_dma_latency read

Li Ma (1):
      drm/amd/display: add DCN 351 version for microcode load

Li Nan (2):
      block: fix overflow in blk_ioctl_discard()
      blk-iocost: do not WARN if iocg was already offlined

Liam R. Howlett (1):
      maple_tree: fix mas_empty_area_rev() null pointer dereference

Lijo Lazar (2):
      drm/amdgpu: Refine IB schedule error logging
      drm/amdgpu: Fix VCN allocation in CPX partition

Linus Torvalds (1):
      Reapply "drm/qxl: simplify qxl_fence_wait"

Lucas De Marchi (2):
      drm/xe/display: Fix ADL-N detection
      drm/xe: Fix END redefinition

Lukasz Majewski (1):
      hsr: Simplify code for announcing HSR nodes timer setup

Lyude Paul (3):
      drm/nouveau/dp: Don't probe eDP ports twice harder
      drm/nouveau/firmware: Fix SG_DEBUG error with nvkm_firmware_ctor()
      drm/nouveau/gsp: Use the sg allocator for level 2 of radix3

Mans Rullgard (1):
      spi: fix null pointer dereference within spi_sync

Marek Behún (1):
      net: dsa: mv88e6xxx: Fix number of databases for 88E6141 / 88E6341

Marek Szyprowski (1):
      clk: samsung: Revert "clk: Use device_get_match_data()"

Marek Vasut (1):
      net: ks8851: Queue RX packets in IRQ handler instead of disabling BHs

Mario Limonciello (2):
      platform/x86/amd: pmf: Decrease error message to debug
      dm/amd/pm: Fix problems with reboot/shutdown for some SMU 13.0.4/13.0.11 users

Mark Rutland (1):
      selftests/ftrace: Fix event filter target_func selection

Matt Coster (1):
      drm/imagination: Ensure PVR_MIPS_PT_PAGE_COUNT is never zero

Matti Vaittinen (2):
      regulator: change stubbed devm_regulator_get_enable to return Ok
      regulator: change devm_regulator_get_enable_optional() stub to return Ok

Maurizio Lombardi (1):
      scsi: target: Fix SELinux error when systemd-modules loads the target module

Max Filippov (1):
      xtensa: fix MAKE_PC_FROM_RA second argument

Michael Ellerman (2):
      powerpc/crypto/chacha-p10: Fix failure on non Power10
      selftests/mm: fix powerpc ARCH check

Michael Kelley (1):
      Drivers: hv: vmbus: Don't free ring buffers that couldn't be re-encrypted

Michel Dänzer (1):
      drm/amdgpu: Fix comparison in amdgpu_res_cpu_visible

Mukul Joshi (1):
      drm/amdkfd: Check cgroup when returning DMABuf info

Namjae Jeon (3):
      ksmbd: off ipv6only for both ipv4/ipv6 binding
      ksmbd: avoid to send duplicate lease break notifications
      ksmbd: do not grant v2 lease if parent lease key and epoch are not set

Nayna Jain (1):
      powerpc/pseries: make max polling consistent for longer H_CALLs

Nicholas Kazlauskas (1):
      drm/amd/display: Fix idle optimization checks for multi-display and dual eDP

Nicolas Bouchinet (1):
      mm/slub: avoid zeroing outside-object freepointer for single free

Nikhil Rao (1):
      dmaengine: idxd: add a write() method for applications to submit work

Olga Kornievskaia (1):
      SUNRPC: add a missing rpc_stat for TCP TLS

Oliver Upton (1):
      KVM: arm64: vgic-v2: Check for non-NULL vCPU in vgic_v2_parse_attr()

Oswald Buddenhagen (4):
      ALSA: emu10k1: fix E-MU card dock presence monitoring
      ALSA: emu10k1: factor out snd_emu1010_load_dock_firmware()
      ALSA: emu10k1: move the whole GPIO event handling to the workqueue
      ALSA: emu10k1: fix E-MU dock initialization

Paolo Abeni (2):
      mptcp: ensure snd_nxt is properly initialized on connect
      tipc: fix UAF in error path

Patryk Wlazlyn (1):
      tools/power turbostat: Print ucode revision only if valid

Paul Davey (1):
      xfrm: Preserve vlan tags for transport mode software GRO

Peiyang Wang (4):
      net: hns3: using user configure after hardware reset
      net: hns3: change type of numa_node_mask as nodemask_t
      net: hns3: release PTP resources if pf initialization failed
      net: hns3: use appropriate barrier function after setting a bit value

Peng Liu (1):
      tools/power turbostat: Fix Bzy_MHz documentation typo

Peter Korsgaard (1):
      usb: gadget: composite: fix OS descriptors w_value logic

Peter Ujfalusi (1):
      ASoC: SOF: Intel: hda-dsp: Skip IMR boot on ACE platforms in case of S3 suspend

Peter Wang (2):
      scsi: ufs: core: WLUN suspend dev/link state error recovery
      scsi: ufs: core: Fix MCQ mode dev command timeout

Peter Xu (1):
      mm/userfaultfd: reset ptes when close() for wr-protected ones

Phil Elwell (1):
      net: bcmgenet: Reset RBUF on first open

Pierre-Louis Bossart (2):
      ASoC: SOF: Intel: add default firmware library path for LNL
      ALSA: hda: intel-sdw-acpi: fix usage of device_get_named_child_node()

Puranjay Mohan (1):
      arm32, bpf: Reimplement sign-extension mov instruction

Qu Wenruo (2):
      btrfs: set correct ram_bytes when splitting ordered extent
      btrfs: qgroup: do not check qgroup inherit if qgroup is disabled

RD Babiera (1):
      usb: typec: tcpm: clear pd_event queue in PORT_RESET

Rafael J. Wysocki (3):
      thermal/debugfs: Free all thermal zone debug memory on zone removal
      thermal/debugfs: Fix two locking issues with thermal zone debug
      thermal/debugfs: Prevent use-after-free from occurring after cdev removal

Ramona Gradinariu (1):
      iio:imu: adis16475: Fix sync mode setting

Richard Fitzgerald (1):
      regmap: Add regmap_read_bypassed()

Richard Gobert (2):
      net: gro: fix udp bad offset in socket lookup by adding {inner_}network_offset to napi_gro_cb
      net: gro: add flush check in udp_gro_receive_segment

Rick Edgecombe (4):
      Drivers: hv: vmbus: Leak pages if set_memory_encrypted() fails
      Drivers: hv: vmbus: Track decrypted status in vmbus_gpadl
      hv_netvsc: Don't free decrypted memory
      uio_hv_generic: Don't free decrypted memory

Rik van Riel (1):
      blk-iocost: avoid out of bounds shift

Roded Zats (1):
      rtnetlink: Correct nested IFLA_VF_VLAN_LIST attribute validation

Rohit Ner (1):
      scsi: ufs: core: Fix MCQ MAC configuration

Ryan Roberts (2):
      fs/proc/task_mmu: fix loss of young/dirty bits during pagemap scan
      fs/proc/task_mmu: fix uffd-wp confusion in pagemap_scan_pmd_entry()

Sameer Pujar (1):
      ASoC: tegra: Fix DSPK 16-bit playback

Saurav Kashyap (1):
      scsi: bnx2fc: Remove spin_lock_bh while releasing resources after upload

Sean Anderson (1):
      nvme-pci: Add quirk for broken MSIs

Sebastian Andrzej Siewior (1):
      cxgb4: Properly lock TX queue for the selftest.

Shashank Sharma (1):
      drm/amdgpu: fix doorbell regression

Shigeru Yoshida (2):
      ipv4: Fix uninit-value access in __ip_make_skb()
      ipv6: Fix potential uninit-value access in __ip6_make_skb()

Shin'ichiro Kawasaki (1):
      scsi: mpi3mr: Avoid memcpy field-spanning write WARNING

Shubhrajyoti Datta (1):
      EDAC/versal: Do not log total error counts

Silvio Gissi (1):
      keys: Fix overwrite of key expiration on instantiation

Srinivas Kandagatla (1):
      ASoC: codecs: wsa881x: set clk_stop_mode1 flag

Srinivas Pandruvada (1):
      platform/x86: ISST: Add Granite Rapids-D to HPM CPU list

Steffen Bätz (1):
      net: dsa: mv88e6xxx: add phylink_get_caps for the mv88e6320/21 family

Stephen Boyd (1):
      clk: Don't hold prepare_lock when calling kref_put()

Steve French (1):
      smb3: fix broken reconnect when password changing on the server by allowing password rotation

Steven Rostedt (Google) (3):
      tracefs: Reset permissions on remount if permissions are options
      tracefs: Still use mount point as default permissions for instances
      eventfs: Do not treat events directory different than other directories

Sungwoo Kim (2):
      Bluetooth: msft: fix slab-use-after-free in msft_do_close()
      Bluetooth: HCI: Fix potential null-ptr-deref

Sven Schnelle (1):
      workqueue: Fix selection of wake_cpu in kick_pool()

Takashi Iwai (2):
      ALSA: line6: Zero-initialize message buffers
      ALSA: hda/realtek: Fix conflicting PCI SSID 17aa:386f for Lenovo Legion models

Takashi Sakamoto (1):
      firewire: ohci: fulfill timestamp for some local asynchronous transaction

Tao Zhou (1):
      drm/amdgpu: implement IRQ_STATE_ENABLE for SDMA v4.4.2

Tetsuo Handa (1):
      nfc: nci: Fix kcov check in nci_rx_work()

Thadeu Lima de Souza Cascardo (1):
      net: fix out-of-bounds access in ops_init

Thanassis Avgerinos (1):
      firewire: nosy: ensure user_length is taken into account when fetching packet contents

Thierry Reding (1):
      gpu: host1x: Do not setup DMA for virtual devices

Thinh Nguyen (2):
      usb: xhci-plat: Don't include xhci.h
      usb: dwc3: core: Prevent phy suspend during init

Thomas Bertschinger (1):
      rust: module: place generated init_module() function in .init.text

Thomas Gleixner (1):
      x86/apic: Don't access the APIC when disabling x2APIC

Thomas Weißschuh (1):
      misc/pvpanic-pci: register attributes via pci_driver

Toke Høiland-Jørgensen (1):
      xdp: use flags field to disambiguate broadcast redirect

Uwe Kleine-König (1):
      OSS: dmasound/paula: Mark driver struct with __refdata to prevent section mismatch

Vanillan Wang (1):
      net:usb:qmi_wwan: support Rolling modules

Vasant Hegde (1):
      iommu/amd: Enhance def_domain_type to handle untrusted device

Vasileios Amoiridis (2):
      iio: pressure: Fixes BME280 SPI driver data
      iio: pressure: Fixes SPI support for BMP3xx devices

Viken Dadhaniya (1):
      slimbus: qcom-ngd-ctrl: Add timeout for wait operation

Vitaly Lifshits (1):
      e1000e: change usleep_range to udelay in PHY mdic access

Volodymyr Babchuk (1):
      arm64: dts: qcom: sa8155p-adp: fix SDHC2 CD pin configuration

Wachowski, Karol (1):
      accel/ivpu: Improve clarity of MMU error messages

Wei Yang (3):
      memblock tests: fix undefined reference to `early_pfn_to_nid'
      memblock tests: fix undefined reference to `panic'
      memblock tests: fix undefined reference to `BIT'

Wen Gu (1):
      net/smc: fix neighbour and rtable leak in smc_ib_find_route()

Wesley Cheng (1):
      usb: gadget: f_fs: Fix race between aio_cancel() and AIO request complete

Will Deacon (1):
      swiotlb: initialise restricted pool list_head when SWIOTLB_DYNAMIC=y

Wyes Karny (1):
      tools/power turbostat: Increase the limit for fd opened

Xiang Chen (1):
      scsi: hisi_sas: Handle the NCQ error returned by D2H frame

Xin Long (1):
      tipc: fix a possible memleak in tipc_buf_append

Xu Kuohai (2):
      bpf, arm64: Fix incorrect runtime stats
      riscv, bpf: Fix incorrect runtime stats

Yi Zhang (1):
      nvme: fix warn output about shared namespaces without CONFIG_NVME_MULTIPATH

Yifan Zhang (1):
      drm/amdgpu: add smu 14.0.1 discovery support

Yihang Li (1):
      scsi: libsas: Align SMP request allocation to ARCH_DMA_MINALIGN

Yonglong Liu (2):
      net: hns3: fix port vlan filter not disabled issue
      net: hns3: fix kernel crash when devlink reload during initialization

Yuezhang Mo (1):
      exfat: fix timing of synchronizing bitmap and inode

Zack Rusin (2):
      drm/ttm: Print the memory decryption status just once
      drm/vmwgfx: Fix invalid reads in fence signaled events

Zeng Heng (1):
      pinctrl: devicetree: fix refcount leak in pinctrl_dt_to_map()

Zhang Yi (2):
      ASoC: codecs: ES8326: Solve error interruption issue
      ASoC: codecs: ES8326: modify clock table

Zhigang Luo (1):
      amd/amdkfd: sync all devices to wait all processes being evicted

Zhongqiu Han (1):
      gpiolib: cdev: Fix use after free in lineinfo_changed_notify

linke li (1):
      net: mark racy access on sk->sk_rcvbuf


