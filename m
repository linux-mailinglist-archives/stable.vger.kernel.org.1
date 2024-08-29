Return-Path: <stable+bounces-71524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71922964B09
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 18:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22AD4289037
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 16:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282F81B4C40;
	Thu, 29 Aug 2024 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0U/px/v0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A151B3F1F;
	Thu, 29 Aug 2024 16:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947605; cv=none; b=uDdTyAdAzLSYwojPY6UYhFzgl2Uw0z0eu4+IZra7kOV97uifCggLsDxoW/aUIBDZMKsJQH+hrFsDh/gwW6tHB7jNR/+VYMdrgHcFnvlU6SrN2iG+L9v6DS3K3G0kgZNPyhUV9n2m1KIHcnsUJcTolIhGpZZwK7wmT3C8/2kb5dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947605; c=relaxed/simple;
	bh=TZlxf799v/XBX1lPEqFn+Dm1d3Nixi53SjUFYtfYXKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EgoTfsjbGs76F75yTh/WonXkLLym71N1QYKr/RlBZulvaIkDuBSmtIUAT4JK0qGR8waZWEKANfJ619aNBvOmSZwPv1Rhpun48JTosZlqAfN3zlUY5VvmwFd49HJSxhP1qOufiuXJr1Lkq+PzrgYWe7hX/r3kAqNJZ85izzfO6w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0U/px/v0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8308C4CEC1;
	Thu, 29 Aug 2024 16:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724947605;
	bh=TZlxf799v/XBX1lPEqFn+Dm1d3Nixi53SjUFYtfYXKY=;
	h=From:To:Cc:Subject:Date:From;
	b=0U/px/v0BJ2fQaP5Q4RqN2cJEhmMa/D3eCanabXFm2CNcuZKh025SjNkf+4+43ekF
	 enghR2kOT+8fGs5Z9CJ33Hq775tOx5oVWk8C6BmCiI1lSOlnw+l7zBZ0Y0+1K7h5JA
	 1dOzBVnHB6oi4OBiQi0ocdarLLMvQCZOLDlrAJWs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.10.7
Date: Thu, 29 Aug 2024 18:06:23 +0200
Message-ID: <2024082922-module-unsaved-5f2d@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.10.7 kernel.

All users of the 6.10 kernel series must upgrade.

The updated 6.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-devices-system-cpu               |    3 
 Makefile                                                         |    4 
 arch/arm64/kernel/acpi_numa.c                                    |    2 
 arch/arm64/kernel/setup.c                                        |    3 
 arch/arm64/kernel/smp.c                                          |    2 
 arch/arm64/kvm/sys_regs.c                                        |    6 
 arch/arm64/kvm/vgic/vgic-debug.c                                 |    2 
 arch/arm64/kvm/vgic/vgic.h                                       |    7 
 arch/mips/kernel/cpu-probe.c                                     |    4 
 arch/powerpc/include/asm/topology.h                              |   13 
 arch/riscv/kernel/traps.c                                        |    4 
 arch/riscv/mm/init.c                                             |    4 
 arch/s390/boot/startup.c                                         |   55 +--
 arch/s390/boot/vmem.c                                            |   14 
 arch/s390/boot/vmlinux.lds.S                                     |    7 
 arch/s390/include/asm/page.h                                     |    3 
 arch/s390/include/asm/uv.h                                       |    5 
 arch/s390/kernel/vmlinux.lds.S                                   |    2 
 arch/s390/kvm/kvm-s390.h                                         |    7 
 arch/s390/tools/relocs.c                                         |    2 
 block/blk-mq-tag.c                                               |    5 
 drivers/acpi/acpica/acevents.h                                   |    6 
 drivers/acpi/acpica/evregion.c                                   |   12 
 drivers/acpi/acpica/evxfregn.c                                   |   64 ---
 drivers/acpi/ec.c                                                |   14 
 drivers/acpi/internal.h                                          |    1 
 drivers/acpi/scan.c                                              |    2 
 drivers/acpi/video_detect.c                                      |   22 +
 drivers/ata/pata_macio.c                                         |   23 -
 drivers/atm/idt77252.c                                           |    9 
 drivers/bluetooth/btintel.c                                      |   10 
 drivers/bluetooth/btintel_pcie.c                                 |    3 
 drivers/bluetooth/btmtksdio.c                                    |    3 
 drivers/bluetooth/btrtl.c                                        |    1 
 drivers/bluetooth/btusb.c                                        |    4 
 drivers/bluetooth/hci_qca.c                                      |    4 
 drivers/bluetooth/hci_vhci.c                                     |    2 
 drivers/char/xillybus/xillyusb.c                                 |   42 +-
 drivers/gpio/gpio-mlxbf3.c                                       |   14 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                           |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c                          |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c                       |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c                          |   53 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h                          |    1 
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c                           |    4 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c                         |   63 +++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h                         |    7 
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c                         |    1 
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c                           |   18 -
 drivers/gpu/drm/amd/amdgpu/soc15d.h                              |    6 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                |   32 +
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c          |    4 
 drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c |    3 
 drivers/gpu/drm/i915/display/intel_dp_hdcp.c                     |    4 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                      |    4 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c                   |    4 
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h                          |   14 
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c                        |   20 -
 drivers/gpu/drm/msm/dp/dp_ctrl.c                                 |    2 
 drivers/gpu/drm/msm/dp/dp_panel.c                                |   19 -
 drivers/gpu/drm/msm/msm_mdss.c                                   |    2 
 drivers/gpu/drm/nouveau/nvkm/core/firmware.c                     |    9 
 drivers/gpu/drm/nouveau/nvkm/falcon/fw.c                         |    6 
 drivers/gpu/drm/v3d/v3d_sched.c                                  |   14 
 drivers/gpu/drm/xe/display/xe_display.c                          |    6 
 drivers/gpu/drm/xe/xe_device.c                                   |    4 
 drivers/gpu/drm/xe/xe_exec_queue.c                               |   19 -
 drivers/gpu/drm/xe/xe_exec_queue_types.h                         |   10 
 drivers/gpu/drm/xe/xe_gt_pagefault.c                             |   18 -
 drivers/gpu/drm/xe/xe_guc_submit.c                               |    8 
 drivers/gpu/drm/xe/xe_hw_fence.c                                 |   59 ++-
 drivers/gpu/drm/xe/xe_hw_fence.h                                 |    7 
 drivers/gpu/drm/xe/xe_lrc.c                                      |   48 ++
 drivers/gpu/drm/xe/xe_lrc.h                                      |    3 
 drivers/gpu/drm/xe/xe_mmio.c                                     |   41 +-
 drivers/gpu/drm/xe/xe_mmio.h                                     |    2 
 drivers/gpu/drm/xe/xe_ring_ops.c                                 |   22 -
 drivers/gpu/drm/xe/xe_sched_job.c                                |  180 +++++-----
 drivers/gpu/drm/xe/xe_sched_job.h                                |    7 
 drivers/gpu/drm/xe/xe_sched_job_types.h                          |   20 +
 drivers/gpu/drm/xe/xe_trace.h                                    |   11 
 drivers/hid/wacom_wac.c                                          |    4 
 drivers/i2c/busses/i2c-qcom-geni.c                               |    4 
 drivers/i2c/busses/i2c-tegra.c                                   |    4 
 drivers/input/input-mt.c                                         |    3 
 drivers/input/serio/i8042-acpipnpio.h                            |   20 -
 drivers/input/serio/i8042.c                                      |   10 
 drivers/iommu/io-pgfault.c                                       |    1 
 drivers/iommu/iommufd/device.c                                   |    2 
 drivers/md/dm-ioctl.c                                            |   22 +
 drivers/md/dm.c                                                  |    4 
 drivers/md/persistent-data/dm-space-map-metadata.c               |    4 
 drivers/md/raid1.c                                               |   14 
 drivers/misc/fastrpc.c                                           |   22 -
 drivers/mmc/core/mmc_test.c                                      |    9 
 drivers/mmc/host/dw_mmc.c                                        |    8 
 drivers/mmc/host/mtk-sd.c                                        |    8 
 drivers/net/bonding/bond_main.c                                  |   21 -
 drivers/net/bonding/bond_options.c                               |    2 
 drivers/net/dsa/microchip/ksz_ptp.c                              |    5 
 drivers/net/dsa/mv88e6xxx/global1_atu.c                          |    3 
 drivers/net/dsa/ocelot/felix.c                                   |   11 
 drivers/net/dsa/vitesse-vsc73xx-core.c                           |   45 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c                    |    5 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c                |    3 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c              |    7 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c                  |    3 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c          |   28 +
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c          |    3 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c        |    4 
 drivers/net/ethernet/intel/ice/devlink/devlink_port.c            |    4 
 drivers/net/ethernet/intel/ice/ice_base.c                        |   21 +
 drivers/net/ethernet/intel/ice/ice_txrx.c                        |   47 --
 drivers/net/ethernet/intel/igb/igb_main.c                        |    1 
 drivers/net/ethernet/intel/igc/igc_defines.h                     |    6 
 drivers/net/ethernet/intel/igc/igc_main.c                        |    8 
 drivers/net/ethernet/intel/igc/igc_tsn.c                         |   76 +++-
 drivers/net/ethernet/intel/igc/igc_tsn.h                         |    1 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c              |   23 -
 drivers/net/ethernet/mediatek/mtk_wed.c                          |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c         |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c          |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                |   13 
 drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c      |    6 
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c                 |   18 -
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige.h            |    8 
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c       |   10 
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_regs.h       |    2 
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c         |   50 ++
 drivers/net/ethernet/microsoft/mana/mana_en.c                    |   30 +
 drivers/net/ethernet/mscc/ocelot.c                               |   91 ++++-
 drivers/net/ethernet/mscc/ocelot_fdma.c                          |    3 
 drivers/net/ethernet/mscc/ocelot_vsc7514.c                       |    4 
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c                    |    8 
 drivers/net/ethernet/xilinx/xilinx_axienet.h                     |   17 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c                |   25 -
 drivers/net/gtp.c                                                |    3 
 drivers/net/wireless/ath/ath12k/dp_tx.c                          |   72 ++++
 drivers/net/wireless/ath/ath12k/hw.c                             |    6 
 drivers/net/wireless/ath/ath12k/hw.h                             |    4 
 drivers/net/wireless/ath/ath12k/mac.c                            |    1 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c      |   13 
 drivers/nvme/host/core.c                                         |    2 
 drivers/platform/surface/aggregator/controller.c                 |    3 
 drivers/platform/x86/dell/Kconfig                                |    1 
 drivers/platform/x86/dell/dell-uart-backlight.c                  |    8 
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c      |    3 
 drivers/pmdomain/imx/imx93-pd.c                                  |    5 
 drivers/pmdomain/imx/scu-pd.c                                    |    5 
 drivers/s390/block/dasd.c                                        |   36 +-
 drivers/s390/block/dasd_3990_erp.c                               |   10 
 drivers/s390/block/dasd_eckd.c                                   |   55 +--
 drivers/s390/block/dasd_genhd.c                                  |    1 
 drivers/s390/block/dasd_int.h                                    |    2 
 drivers/s390/crypto/ap_bus.c                                     |    7 
 drivers/spi/spi-cadence-quadspi.c                                |   14 
 drivers/staging/media/atomisp/pci/ia_css_stream_public.h         |    8 
 drivers/staging/media/atomisp/pci/sh_css_internal.h              |   19 -
 drivers/thermal/gov_bang_bang.c                                  |   87 +++-
 drivers/thermal/thermal_core.c                                   |    3 
 drivers/thermal/thermal_debugfs.c                                |    6 
 drivers/thermal/thermal_of.c                                     |   23 -
 drivers/thunderbolt/switch.c                                     |    1 
 drivers/tty/serial/8250/8250_omap.c                              |   33 -
 drivers/tty/serial/atmel_serial.c                                |    2 
 drivers/tty/serial/fsl_lpuart.c                                  |    1 
 drivers/tty/vt/conmakehash.c                                     |   12 
 drivers/usb/host/xhci-mem.c                                      |    2 
 drivers/usb/host/xhci.c                                          |    8 
 drivers/usb/misc/usb-ljca.c                                      |    1 
 drivers/usb/typec/tcpm/tcpm.c                                    |    1 
 fs/btrfs/delayed-ref.c                                           |   67 +++
 fs/btrfs/delayed-ref.h                                           |    2 
 fs/btrfs/extent-tree.c                                           |   51 ++
 fs/btrfs/extent_io.c                                             |   14 
 fs/btrfs/extent_map.c                                            |   22 -
 fs/btrfs/free-space-cache.c                                      |   14 
 fs/btrfs/send.c                                                  |   52 ++
 fs/btrfs/super.c                                                 |   18 -
 fs/btrfs/tree-checker.c                                          |   74 ++++
 fs/ceph/addr.c                                                   |   19 +
 fs/file.c                                                        |   30 -
 fs/fuse/dev.c                                                    |    6 
 fs/inode.c                                                       |   39 ++
 fs/libfs.c                                                       |   35 +
 fs/locks.c                                                       |    2 
 fs/netfs/buffered_read.c                                         |    8 
 fs/netfs/buffered_write.c                                        |    2 
 fs/netfs/fscache_cookie.c                                        |    4 
 fs/netfs/io.c                                                    |  144 ++++++++
 fs/smb/client/cifsglob.h                                         |   17 
 fs/smb/client/file.c                                             |   55 ++-
 fs/smb/client/reparse.c                                          |   11 
 fs/smb/client/smb1ops.c                                          |    2 
 fs/smb/client/smb2ops.c                                          |   42 ++
 fs/smb/client/smb2pdu.c                                          |   40 ++
 fs/smb/client/trace.h                                            |   55 +++
 fs/smb/client/transport.c                                        |    8 
 fs/smb/server/connection.c                                       |   34 +
 fs/smb/server/connection.h                                       |    3 
 fs/smb/server/mgmt/user_session.c                                |    8 
 fs/smb/server/smb2pdu.c                                          |    5 
 include/acpi/acpixf.h                                            |    5 
 include/acpi/video.h                                             |    1 
 include/asm-generic/vmlinux.lds.h                                |   19 -
 include/linux/bitmap.h                                           |   12 
 include/linux/bpf_verifier.h                                     |    4 
 include/linux/dsa/ocelot.h                                       |   47 ++
 include/linux/fs.h                                               |    5 
 include/linux/hugetlb.h                                          |   33 +
 include/linux/io_uring_types.h                                   |    2 
 include/linux/mm.h                                               |   11 
 include/linux/panic.h                                            |    1 
 include/linux/pgalloc_tag.h                                      |   13 
 include/linux/thermal.h                                          |    1 
 include/net/af_vsock.h                                           |    4 
 include/net/bluetooth/hci.h                                      |   17 
 include/net/bluetooth/hci_core.h                                 |    2 
 include/net/kcm.h                                                |    1 
 include/net/mana/mana.h                                          |    1 
 include/scsi/scsi_cmnd.h                                         |    2 
 include/soc/mscc/ocelot.h                                        |   12 
 include/trace/events/netfs.h                                     |    1 
 include/uapi/misc/fastrpc.h                                      |    3 
 init/Kconfig                                                     |   25 -
 io_uring/io_uring.h                                              |    2 
 io_uring/kbuf.c                                                  |    9 
 io_uring/napi.c                                                  |   50 +-
 io_uring/napi.h                                                  |    2 
 kernel/bpf/verifier.c                                            |    5 
 kernel/cgroup/cpuset.c                                           |    5 
 kernel/cpu.c                                                     |   12 
 kernel/events/core.c                                             |    3 
 kernel/kallsyms.c                                                |   60 ---
 kernel/kallsyms_internal.h                                       |    6 
 kernel/kallsyms_selftest.c                                       |   22 -
 kernel/panic.c                                                   |    8 
 kernel/printk/printk.c                                           |    2 
 kernel/trace/trace.c                                             |    2 
 kernel/vmcore_info.c                                             |    4 
 kernel/workqueue.c                                               |   47 +-
 mm/huge_memory.c                                                 |   29 -
 mm/memcontrol.c                                                  |    7 
 mm/memory-failure.c                                              |   20 -
 mm/memory.c                                                      |   33 -
 mm/mm_init.c                                                     |   12 
 mm/mseal.c                                                       |   14 
 mm/page_alloc.c                                                  |   51 +-
 mm/vmalloc.c                                                     |   11 
 net/bluetooth/hci_core.c                                         |   19 -
 net/bluetooth/hci_event.c                                        |    2 
 net/bluetooth/mgmt.c                                             |    4 
 net/bluetooth/smp.c                                              |  144 ++++----
 net/bridge/br_netfilter_hooks.c                                  |    6 
 net/dsa/tag_ocelot.c                                             |   37 --
 net/ipv4/tcp_input.c                                             |   28 -
 net/ipv4/tcp_ipv4.c                                              |   14 
 net/ipv4/udp_offload.c                                           |    3 
 net/ipv6/ip6_output.c                                            |   10 
 net/ipv6/ip6_tunnel.c                                            |   12 
 net/ipv6/netfilter/nf_conntrack_reasm.c                          |    4 
 net/iucv/iucv.c                                                  |    4 
 net/kcm/kcmsock.c                                                |    4 
 net/mctp/test/route-test.c                                       |    2 
 net/mptcp/diag.c                                                 |    2 
 net/mptcp/pm.c                                                   |   13 
 net/mptcp/pm_netlink.c                                           |  142 +++++--
 net/mptcp/protocol.h                                             |    3 
 net/netfilter/nf_flow_table_inet.c                               |    3 
 net/netfilter/nf_flow_table_ip.c                                 |    3 
 net/netfilter/nf_flow_table_offload.c                            |    2 
 net/netfilter/nf_tables_api.c                                    |  147 +++++---
 net/netfilter/nfnetlink.c                                        |    5 
 net/netfilter/nfnetlink_queue.c                                  |   35 +
 net/netfilter/nft_counter.c                                      |    9 
 net/openvswitch/datapath.c                                       |    2 
 net/sched/sch_netem.c                                            |   47 +-
 net/vmw_vsock/af_vsock.c                                         |   50 +-
 net/vmw_vsock/vsock_bpf.c                                        |    4 
 scripts/kallsyms.c                                               |  111 +-----
 scripts/link-vmlinux.sh                                          |  106 +++--
 scripts/rust_is_available.sh                                     |    6 
 security/keys/trusted-keys/trusted_dcp.c                         |   35 +
 security/selinux/avc.c                                           |    8 
 security/selinux/hooks.c                                         |   12 
 sound/core/timer.c                                               |    2 
 sound/pci/hda/patch_realtek.c                                    |    1 
 sound/pci/hda/tas2781_hda_i2c.c                                  |   14 
 sound/usb/quirks-table.h                                         |    1 
 sound/usb/quirks.c                                               |    2 
 tools/perf/tests/vmlinux-kallsyms.c                              |    1 
 tools/testing/selftests/bpf/progs/iters.c                        |   54 +++
 tools/testing/selftests/core/close_range_test.c                  |   35 +
 tools/testing/selftests/drivers/net/mlxsw/ethtool_lanes.sh       |    3 
 tools/testing/selftests/mm/Makefile                              |    2 
 tools/testing/selftests/mm/run_vmtests.sh                        |    3 
 tools/testing/selftests/net/af_unix/msg_oob.c                    |    2 
 tools/testing/selftests/net/lib.sh                               |   11 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                  |   28 +
 tools/testing/selftests/net/udpgro.sh                            |   53 +-
 tools/testing/selftests/tc-testing/tdc.py                        |    1 
 tools/tracing/rtla/src/osnoise_top.c                             |   11 
 302 files changed, 3441 insertions(+), 1720 deletions(-)

Abhinav Jain (1):
      selftest: af_unix: Fix kselftest compilation warnings

Abhinav Kumar (4):
      drm/msm/dp: fix the max supported bpp logic
      drm/msm/dpu: move dpu_encoder's connector assignment to atomic_enable()
      drm/msm/dp: reset the link phy params before link training
      drm/msm: fix the highest_bank_bit for sc7180

Al Viro (2):
      fix bitmap corruption on close_range() with CLOSE_RANGE_UNSHARE
      memcg_write_event_control(): fix a user-triggerable oops

Alex Deucher (3):
      drm/amdgpu/jpeg2: properly set atomics vmid field
      drm/amdgpu/jpeg4: properly set atomics vmid field
      drm/amdgpu/sdma5.2: limit wptr workaround to sdma 5.2.1

Alexander Gordeev (2):
      s390/boot: Avoid possible physmem_info segment corruption
      s390/boot: Fix KASLR base offset off by __START_KERNEL bytes

Alexander Stein (1):
      pmdomain: imx: scu-pd: Remove duplicated clocks

Alexandra Winter (1):
      s390/iucv: Fix vargs handling in iucv_alloc_device()

Alexandre Courbot (1):
      Makefile: add $(srctree) to dependency of compile_commands.json target

Andi Shyti (1):
      i2c: qcom-geni: Add missing geni_icc_disable in geni_i2c_runtime_resume

Asmaa Mnebhi (1):
      gpio: mlxbf3: Support shutdown() function

Baochen Qiang (1):
      wifi: ath12k: use 128 bytes aligned iova in transmit path for WCN7850

Baojun Xu (1):
      ALSA: hda/tas2781: fix wrong calibrated data order

Barak Biber (1):
      iommu: Restore lost return in iommu_report_device_fault()

Bas Nieuwenhuizen (1):
      drm/amdgpu: Actually check flags for all context ops.

Ben Whitten (1):
      mmc: dw_mmc: allow biu and ciu clocks to defer

Bharat Bhushan (1):
      octeontx2-af: Fix CPT AF register offset calculation

Boyuan Zhang (2):
      drm/amdgpu/vcn: identify unified queue in sw init
      drm/amdgpu/vcn: not pause dpg for unified queue

Breno Leitao (1):
      i2c: tegra: Do not mark ACPI devices as irq safe

Candice Li (1):
      drm/amdgpu: Validate TA binary size

Carolina Jubran (1):
      net/mlx5e: XPS, Fix oversight of Multi-PF Netdev changes

Celeste Liu (1):
      riscv: entry: always initialize regs->a0 to -ENOSYS

Chaotian Jing (1):
      scsi: core: Fix the return value of scsi_logical_block_count()

Chen Ridong (1):
      cgroup/cpuset: fix panic caused by partcmd_update

Christian Brauner (2):
      pidfd: prevent creation of pidfds for kthreads
      Revert "pidfd: prevent creation of pidfds for kthreads"

Claudio Imbrenda (1):
      s390/uv: Panic for set and remove shared access UVC errors

Cong Wang (1):
      vsock: fix recursive ->recvmsg calls

Cosmin Ratiu (1):
      net/mlx5e: Correctly report errors for ethtool rx flows

Dan Carpenter (4):
      rtla/osnoise: Prevent NULL dereference in error handling
      atm: idt77252: prevent use after free in dequeue_rx()
      dpaa2-switch: Fix error checking in dpaa2_switch_seed_bp()
      mmc: mmc_test: Fix NULL dereference on allocation failure

Dave Airlie (1):
      nouveau/firmware: use dma non-coherent allocator

David (Ming Qiang) Wu (1):
      drm/amd/amdgpu: command submission parser for JPEG

David Gstir (2):
      KEYS: trusted: fix DCP blob payload length assignment
      KEYS: trusted: dcp: fix leak of blob encryption key

David Hildenbrand (1):
      mm/hugetlb: fix hugetlb vs. core-mm PT locking

David Howells (2):
      netfs, ceph: Revert "netfs: Remove deprecated use of PG_private_2 as a second writeback flag"
      cifs: Add a tracepoint to track credits involved in R/W requests

David Thompson (1):
      mlxbf_gige: disable RX filters until RX path initialized

Dmitry Baryshkov (5):
      drm/msm/dpu: don't play tricks with debug macros
      drm/msm/dpu: cleanup FB if dpu_format_populate_layout fails
      drm/msm/dpu: limit QCM2290 to RGB formats only
      drm/msm/dpu: relax YUV requirements
      drm/msm/dpu: take plane rotation into account for wide planes

Donald Hunter (2):
      netfilter: nfnetlink: Initialise extack before use in ACKs
      netfilter: flowtable: initialise extack before use

Dragos Tatulea (1):
      net/mlx5e: Take state lock during tx timeout reporter

Eli Billauer (3):
      char: xillybus: Don't destroy workqueue from work item running on it
      char: xillybus: Refine workqueue handling
      char: xillybus: Check USB endpoints when probing device

Eric Dumazet (4):
      gtp: pull network headers in gtp_dev_xmit()
      ipv6: prevent UAF in ip6_send_skb()
      ipv6: fix possible UAF in ip6_finish_output2()
      ipv6: prevent possible UAF in ip6_xmit()

Eric Farman (1):
      s390/dasd: Remove DMA alignment

Eugene Syromiatnikov (1):
      mptcp: correct MPTCP_SUBFLOW_ATTR_SSN_OFFSET reserved size

Faizal Rahim (4):
      igc: Fix packet still tx after gate close by reducing i226 MAC retry buffer
      igc: Fix qbv_config_change_errors logics
      igc: Fix reset adapter logics when tx mode change
      igc: Fix qbv tx latency by setting gtxoffset

Felix Fietkau (1):
      udp: fix receiving fraglist GSO packets

Filipe Manana (2):
      btrfs: send: allow cloning non-aligned extent if it ends at i_size
      btrfs: only run the extent map shrinker from kswapd tasks

Florian Westphal (2):
      netfilter: nf_queue: drop packets with cloned unconfirmed conntracks
      tcp: prevent concurrent execution of tcp_sk_exit_batch

Greg Kroah-Hartman (1):
      Linux 6.10.7

Griffin Kroah-Hartman (3):
      Revert "misc: fastrpc: Restrict untrusted app to attach to privileged PD"
      Revert "serial: 8250_omap: Set the console genpd always on if no console suspend"
      Bluetooth: MGMT: Add error handling to pair_device()

Haibo Xu (1):
      arm64: ACPI: NUMA: initialize all values of acpi_early_node_map to NUMA_NO_NODE

Hailong Liu (1):
      mm/vmalloc: fix page mapping if vm_area_alloc_pages() with high order fallback to order 0

Haiyang Zhang (1):
      net: mana: Fix RX buf alloc_size alignment and atomic op panic

Hamza Mahfooz (1):
      drm/amd/display: fix s2idle entry for DCN3.5+

Hangbin Liu (2):
      selftests: udpgro: report error when receive failed
      selftests: udpgro: no need to load xdp for gro

Hans de Goede (5):
      usb: misc: ljca: Add Lunar Lake ljca GPIO HID to ljca_gpio_hids[]
      media: atomisp: Fix streaming no longer working on BYT / ISP2400 devices
      ACPI: video: Add Dell UART backlight controller detection
      ACPI: video: Add backlight=native quirk for Dell OptiPlex 7760 AIO
      platform/x86: dell-uart-backlight: Use acpi_video_get_backlight_type()

Harald Freudenberger (1):
      s390/ap: Refine AP bus bindings complete processing

Ido Schimmel (1):
      selftests: mlxsw: ethtool_lanes: Source ethtool lib from correct path

Jann Horn (2):
      fuse: Initialize beyond-EOF page contents before setting uptodate
      kallsyms: get rid of code for absolute kallsyms

Janne Grunau (1):
      wifi: brcmfmac: cfg80211: Handle SSID based pmksa deletion

Jason Gerecke (1):
      HID: wacom: Defer calculation of resolution until resolution_code is known

Jens Axboe (1):
      io_uring/kbuf: sanitize peek buffer setup

Jeremy Kerr (1):
      net: mctp: test: Use correct skb for route input check

Jiaxun Yang (1):
      MIPS: Loongson64: Set timer mode in cpu-probe

Jie Wang (2):
      net: hns3: fix wrong use of semaphore up
      net: hns3: fix a deadlock problem when config TC during resetting

Josef Bacik (1):
      btrfs: check delayed refs when we're checking if a ref exists

Joseph Huang (1):
      net: dsa: mv88e6xxx: Fix out-of-bound access

Juan José Arboleda (1):
      ALSA: usb-audio: Support Yamaha P-125 quirk entry

Khazhismel Kumykov (1):
      dm resume: don't return EINVAL when signalled

Kirill A. Shutemov (1):
      mm: fix endless reclaim on machines with unaccepted memory

Krzysztof Kozlowski (3):
      thermal: of: Fix OF node leak in thermal_of_trips_init() error path
      thermal: of: Fix OF node leak in thermal_of_zone_register()
      thermal: of: Fix OF node leak in of_thermal_zone_find() error paths

Kuniyuki Iwashima (1):
      kcm: Serialise kcm_sendmsg() for the same socket.

Kyle Huey (1):
      perf/bpf: Don't call bpf_overflow_handler() for tracing events

Leon Hwang (1):
      bpf: Fix updating attached freplace prog in prog_array map

Li Lingfeng (1):
      block: Fix lockdep warning in blk_mq_mark_tag_wait

Lianqin Hu (1):
      ALSA: usb-audio: Add delay quirk for VIVO USB-C-XE710 HEADSET

Loan Chen (1):
      drm/amd/display: Enable otg synchronization logic for DCN321

Long Li (1):
      net: mana: Fix doorbell out of order violation and avoid unnecessary doorbell rings

Lucas De Marchi (1):
      drm/xe: Fix opregion leak

Luiz Augusto von Dentz (3):
      Bluetooth: HCI: Invert LE State quirk to be opt-out rather then opt-in
      Bluetooth: hci_core: Fix LE quote calculation
      Bluetooth: SMP: Fix assumption of Central always being Initiator

Maciej Fijalkowski (3):
      ice: fix page reuse when PAGE_SIZE is over 8k
      ice: fix ICE_LAST_OFFSET formula
      ice: fix truesize operations for PAGE_SIZE >= 8192

Marc Zyngier (2):
      usb: xhci: Check for xhci->interrupters being allocated in xhci_mem_clearup()
      KVM: arm64: Make ICC_*SGI*_EL1 undef in the absence of a vGICv3

Mario Limonciello (1):
      drm/amd/display: Don't register panel_power_savings on OLED panels

Martin Whitaker (1):
      net: dsa: microchip: fix PTP config failure when using multiple ports

Masahiro Yamada (7):
      tty: vt: conmakehash: remove non-portable code printing comment header
      kbuild: refactor variables in scripts/link-vmlinux.sh
      kbuild: remove PROVIDE() for kallsyms symbols
      rust: suppress error messages from CONFIG_{RUSTC,BINDGEN}_VERSION_TEXT
      rust: fix the default format for CONFIG_{RUSTC,BINDGEN}_VERSION_TEXT
      kbuild: merge temporary vmlinux for BTF and kallsyms
      kbuild: avoid scripts/kallsyms parsing /dev/null

Mathias Nyman (1):
      xhci: Fix Panther point NULL pointer deref at full-speed re-enumeration

Mathieu Othacehe (1):
      tty: atmel_serial: use the correct RTS flag.

Matthew Auld (3):
      drm/xe/display: stop calling domains_driver_remove twice
      drm/xe/mmio: move mmio_fini over to devm
      drm/xe: reset mmio mappings with devm

Matthew Brost (4):
      drm/xe: Fix tile fini sequence
      drm/xe: Decouple job seqno and lrc seqno
      drm/xe: Free job before xe_exec_queue_put
      drm/xe: Do not dereference NULL job->fence in trace points

Matthew Wilcox (Oracle) (1):
      netfs: Fault in smaller chunks for non-large folio mappings

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

Max Kellermann (1):
      fs/netfs/fscache_cookie: add missing "n_accesses" check

Maximilian Luz (1):
      platform/surface: aggregator: Fix warning when controller is destroyed in probe

Maíra Canal (1):
      drm/v3d: Fix out-of-bounds read in `v3d_csd_job_run()`

Melissa Wen (1):
      drm/amd/display: fix cursor offset on rotation 180

Menglong Dong (1):
      net: ovs: fix ovs_drop_reasons error

Mengqi Zhang (1):
      mmc: mtk-sd: receive cmd8 data when hs400 tuning fail

Mengyuan Lou (1):
      net: ngbe: Fix phy mode set to external phy

Michael Ellerman (1):
      ata: pata_macio: Fix DMA table overflow

Michael Mueller (1):
      KVM: s390: fix validity interception issue when gisa is switched off

Michal Swiatkowski (1):
      ice: use internal pf id instead of function number

Miguel Ojeda (1):
      rust: work around `bindgen` 0.69.0 issue

Mika Westerberg (1):
      thunderbolt: Mark XDomain as unplugged when router is removed

Mikulas Patocka (2):
      dm persistent data: fix memory allocation failure
      dm suspend: return -ERESTARTSYS instead of -EINTR

Ming Lei (1):
      nvme: move stopping keep-alive into nvme_uninit_ctrl()

Muhammad Usama Anjum (1):
      selftests: memfd_secret: don't build memfd_secret test on unsupported arches

Nam Cao (1):
      riscv: change XIP's kernel_map.size to be size of the entire kernel

Namjae Jeon (2):
      ksmbd: the buffer of smb2 query dir response has at least 1 byte
      ksmbd: fix race condition between destroy_previous_session() and smb2 operations()

Naohiro Aota (2):
      btrfs: zoned: properly take lock to read/update block group's zoned variables
      btrfs: fix invalid mapping of extent xarray state

Nicolin Chen (1):
      iommufd/device: Fix hwpt at err_unresv in iommufd_device_do_replace()

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

Olivier Langlois (1):
      io_uring/napi: check napi_enabled in io_napi_add() before proceeding

Omar Sandoval (1):
      filelock: fix name of file_lease slab cache

Pablo Neira Ayuso (1):
      netfilter: flowtable: validate vlan header

Paolo Abeni (1):
      igb: cope with large MAX_SKB_FRAGS

Parsa Poorshikhian (1):
      ALSA: hda/realtek: Fix noise from speakers on Lenovo IdeaPad 3 15IAU7

Patrisious Haddad (1):
      net/mlx5: Fix IPsec RoCE MPV trace call

Paul Moore (1):
      selinux: revert our use of vma_is_initial_heap()

Paulo Alcantara (1):
      smb: client: ignore unhandled reparse tags

Pavel Begunkov (1):
      io_uring/napi: use ktime in busy polling

Pawel Dembicki (3):
      net: dsa: vsc73xx: fix port MAC configuration in full duplex mode
      net: dsa: vsc73xx: pass value in phy_write operation
      net: dsa: vsc73xx: check busy flag in MDIO operations

Pedro Falcato (1):
      mseal: fix is_madv_discard()

Peiyang Wang (1):
      net: hns3: use the user's cfg after reset

Peng Fan (2):
      tty: serial: fsl_lpuart: mark last busy before uart_add_one_port
      pmdomain: imx: wait SSAR when i.MX93 power domain on

Phil Sutter (3):
      netfilter: nf_tables: Audit log dump reset after the fact
      netfilter: nf_tables: Introduce nf_tables_getobj_single
      netfilter: nf_tables: Add locking for NFT_MSG_GETOBJ_RESET requests

Qu Wenruo (3):
      btrfs: tree-checker: reject BTRFS_FT_UNKNOWN dir type
      btrfs: tree-checker: add dev extent item checks
      btrfs: only enable extent map shrinker for DEBUG builds

Radhey Shyam Pandey (1):
      net: axienet: Fix register defines comment description

Rafael J. Wysocki (8):
      Revert "ACPI: EC: Evaluate orphan _REG under EC device"
      thermal: gov_bang_bang: Call __thermal_cdev_update() directly
      ACPICA: Add a depth argument to acpi_execute_reg_methods()
      ACPI: EC: Evaluate _REG outside the EC scope more carefully
      thermal: gov_bang_bang: Drop unnecessary cooling device target state checks
      thermal: gov_bang_bang: Split bang_bang_control()
      thermal: gov_bang_bang: Add .manage() callback
      thermal: gov_bang_bang: Use governor_data to reduce overhead

Rodrigo Siqueira (1):
      drm/amd/display: Adjust cursor position

Rodrigo Vivi (1):
      drm/xe: Relax runtime pm protection during execution

Ryo Takakura (1):
      printk/panic: Allow cpu backtraces to be written into ringbuffer during panic

Samuel Holland (1):
      arm64: Fix KASAN random tag seed initialization

Sean Anderson (2):
      net: xilinx: axienet: Always disable promiscuous mode
      net: xilinx: axienet: Fix dangling multicast addresses

Sebastian Andrzej Siewior (2):
      netfilter: nft_counter: Disable BH in nft_counter_offload_stats().
      netfilter: nft_counter: Synchronize nft_counter_reset() against reader.

Simon Horman (1):
      tc-testing: don't access non-existent variable on exception

Somnath Kotur (1):
      bnxt_en: Fix double DMA unmapping for XDP_REDIRECT

Song Liu (2):
      kallsyms: Do not cleanup .llvm.<hash> suffix before sorting symbols
      kallsyms: Match symbols exactly with CONFIG_LTO_CLANG

Srinivas Pandruvada (1):
      platform/x86: ISST: Fix return value on last invalid resource

Stefan Haberland (1):
      s390/dasd: fix error recovery leading to data corruption on ESE devices

Stephen Hemminger (1):
      netem: fix return value if duplicate enqueue fails

Steve French (2):
      smb3: fix lock breakage for cached writes
      smb3: fix broken cached reads when posix locks

Steven Rostedt (1):
      tracing: Return from tracing_buffers_read() if the file has been closed

Stuart Summers (1):
      drm/xe: Fix missing workqueue destroy in xe_gt_pagefault

Su Hui (1):
      smb/client: avoid possible NULL dereference in cifs_free_subrequest()

Subash Abhinov Kasiviswanathan (1):
      tcp: Update window clamping condition

Suraj Kandpal (1):
      drm/i915/hdcp: Use correct cp_irq_count

Suren Baghdasaryan (2):
      alloc_tag: mark pages reserved during CMA activation as not tagged
      alloc_tag: introduce clear_page_tag_ref() helper function

Takashi Iwai (2):
      ALSA: timer: Relax start tick time check for slave timer elements
      ALSA: hda/tas2781: Use correct endian conversion

Tariq Toukan (1):
      net/mlx5: SD, Do not query MPIR register if no sd_group

Tejun Heo (1):
      workqueue: Fix spruious data race in __flush_work()

Tetsuo Handa (1):
      Input: MT - limit max slots

Thomas Bogendoerfer (1):
      ip6_tunnel: Fix broken GRO

Thomas Hellström (2):
      drm/xe: Split lrc seqno fence creation up
      drm/xe: Don't initialize fences at xe_sched_job_create()

Thorsten Blum (1):
      io_uring/napi: Remove unnecessary s64 cast

Tom Hughes (1):
      netfilter: allow ipv6 fragments to arrive on different devices

Vignesh Raghavendra (1):
      spi: spi-cadence-quadspi: Fix OSPI NOR failures during system resume

Vladimir Oltean (3):
      net: mscc: ocelot: use ocelot_xmit_get_vlan_info() also for FDMA and register injection
      net: mscc: ocelot: fix QoS class for injected packets with "ocelot-8021q"
      net: mscc: ocelot: serialize access to the injection/extraction groups

Waiman Long (2):
      mm/memory-failure: use raw_spinlock_t in struct memory_failure_cpu
      cgroup/cpuset: Clear effective_xcpus on cpus_allowed clearing only if cpus.exclusive not set

Werner Sembach (2):
      Input: i8042 - add forcenorestore quirk to leave controller untouched even on s3
      Input: i8042 - use new forcenorestore quirk to replace old buggy quirk combination

Will Deacon (1):
      workqueue: Fix UBSAN 'subtraction overflow' error in shift_and_mask()

Xu Yang (1):
      Revert "usb: typec: tcpm: clear pd_event queue in PORT_RESET"

Yang Ruibin (1):
      thermal/debugfs: Fix the NULL vs IS_ERR() confusion in debugfs_create_dir()

Yonghong Song (2):
      bpf: Fix a kernel verifier crash in stacksafe()
      selftests/bpf: Add a test to verify previous stacksafe() fix

Yu Kuai (1):
      md/raid1: Fix data corruption for degraded array with slow disk

Zenghui Yu (1):
      KVM: arm64: vgic-debug: Don't put unmarked LPIs

Zhen Lei (2):
      selinux: fix potential counting error in avc_add_xperms_decision()
      selinux: add the processing of the failure of avc_add_xperms_decision()

Zheng Zhang (1):
      net: ethernet: mtk_wed: fix use-after-free panic in mtk_wed_setup_tc_block_cb()

Zhihao Cheng (1):
      vfs: Don't evict inode under the inode lru traversing context

Zi Yan (2):
      mm/numa: no task_numa_fault() call if PMD is changed
      mm/numa: no task_numa_fault() call if PTE is changed

yangerkun (1):
      libfs: fix infinite directory reads for offset dir


