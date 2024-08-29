Return-Path: <stable+bounces-71519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A89964B00
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 18:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D8F1F26D12
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 16:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD4A1B374C;
	Thu, 29 Aug 2024 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dWSihjSU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08A01B3731;
	Thu, 29 Aug 2024 16:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947567; cv=none; b=KxBrORUIGfSBs2NYmbqozEgb0YM5Edty1CPTPbQGzYlWW6qOcYvslPt6KffAnde1ir9W8JGqFCUa+xgR0Paz3+0g+p4vSfnSmkIi7nfhnhrlSEGlM7P/mFkg7M33342MNoIlJ95dyrHMa6uH7kSrXg2Z5/Igtkl8nH5oCmtT4AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947567; c=relaxed/simple;
	bh=GZvASLzBl+cIfFRHjUPPpvDXxsVACMGVBU9Id96sjfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bG4PqANLs36wt3MwgHGp4eDV7Dv4DnRzT2Bhma/jw5eVR7LkfjdGOVVTcNrVMezKflKOWZR1/oxWJekuoQGK4oKYrE1T1B6H3zxkI14rrzyG4uHwdjLg15u/4N94uiDXV960WRKhomAQOnYH125CXoDEAxqAr2EVABpVv1KYDhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dWSihjSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB89C4CEC1;
	Thu, 29 Aug 2024 16:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724947567;
	bh=GZvASLzBl+cIfFRHjUPPpvDXxsVACMGVBU9Id96sjfo=;
	h=From:To:Cc:Subject:Date:From;
	b=dWSihjSUaahRVtch2B/UyhSox6XGxl2Iuyva9+jw36tNaYpnbBCtkBgNvb+v8Ncxe
	 dOodNYu+qF5kQt7QwkU9RhhMc+zERKGXQOzsyXS561S+Lv+6Ib7eIxUGKJsI+t2c5A
	 Gh9546ug4sHwPINU80mM5imB5EBJjla9SFvDBVgA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.107
Date: Thu, 29 Aug 2024 18:05:56 +0200
Message-ID: <2024082955-void-splendor-20fd@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.107 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/bpf/map_lpm_trie.rst                         |  181 ++++++
 Documentation/filesystems/gfs2-glocks.rst                  |    3 
 Makefile                                                   |    2 
 arch/arm64/kernel/acpi_numa.c                              |    2 
 arch/arm64/kernel/setup.c                                  |    3 
 arch/arm64/kernel/smp.c                                    |    2 
 arch/arm64/kvm/sys_regs.c                                  |    6 
 arch/arm64/kvm/vgic/vgic.h                                 |    7 
 arch/mips/kernel/cpu-probe.c                               |    4 
 arch/openrisc/kernel/setup.c                               |    6 
 arch/parisc/kernel/irq.c                                   |    4 
 arch/powerpc/boot/simple_alloc.c                           |    7 
 arch/powerpc/sysdev/xics/icp-native.c                      |    2 
 arch/riscv/mm/init.c                                       |    4 
 arch/s390/include/asm/uv.h                                 |    5 
 arch/s390/kernel/early.c                                   |   12 
 arch/s390/kernel/smp.c                                     |    4 
 arch/x86/kernel/process.c                                  |    5 
 arch/x86/kvm/lapic.c                                       |    8 
 block/blk-mq-tag.c                                         |    5 
 drivers/atm/idt77252.c                                     |    9 
 drivers/bluetooth/hci_ldisc.c                              |    3 
 drivers/char/xillybus/xillyusb.c                           |   42 +
 drivers/clk/visconti/pll.c                                 |    6 
 drivers/clocksource/arm_global_timer.c                     |   11 
 drivers/firmware/cirrus/cs_dsp.c                           |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h                 |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c           |   40 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c                    |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c                 |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c                    |   53 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h                    |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c                  |    6 
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c                     |    2 
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c                     |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                   |   22 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |    2 
 drivers/gpu/drm/bridge/tc358768.c                          |  213 ++++++-
 drivers/gpu/drm/lima/lima_gp.c                             |   12 
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h                    |   14 
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c                  |    3 
 drivers/gpu/drm/msm/dp/dp_ctrl.c                           |    2 
 drivers/gpu/drm/msm/dp/dp_panel.c                          |   19 
 drivers/gpu/drm/msm/msm_gem_shrinker.c                     |    2 
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c               |    5 
 drivers/gpu/drm/tegra/gem.c                                |    2 
 drivers/hid/hid-ids.h                                      |   10 
 drivers/hid/hid-microsoft.c                                |   11 
 drivers/hid/wacom_wac.c                                    |    4 
 drivers/hwmon/ltc2992.c                                    |    8 
 drivers/hwmon/pc87360.c                                    |    6 
 drivers/i2c/busses/i2c-qcom-geni.c                         |    4 
 drivers/i2c/busses/i2c-riic.c                              |    2 
 drivers/i2c/busses/i2c-tegra.c                             |   41 -
 drivers/i3c/master/mipi-i3c-hci/dma.c                      |    5 
 drivers/infiniband/hw/hfi1/chip.c                          |    5 
 drivers/infiniband/ulp/rtrs/rtrs.c                         |    2 
 drivers/input/input-mt.c                                   |    3 
 drivers/input/serio/i8042-acpipnpio.h                      |   20 
 drivers/input/serio/i8042.c                                |   10 
 drivers/irqchip/irq-gic-v3-its.c                           |    2 
 drivers/irqchip/irq-renesas-rzg2l.c                        |    5 
 drivers/md/dm-clone-metadata.c                             |    5 
 drivers/md/dm-ioctl.c                                      |   22 
 drivers/md/dm.c                                            |    4 
 drivers/md/md.c                                            |    5 
 drivers/md/persistent-data/dm-space-map-metadata.c         |    4 
 drivers/md/raid5-cache.c                                   |   47 -
 drivers/media/dvb-core/dvb_frontend.c                      |   12 
 drivers/media/pci/cx23885/cx23885-video.c                  |    8 
 drivers/media/pci/solo6x10/solo6x10-offsets.h              |   10 
 drivers/media/platform/qcom/venus/pm_helpers.c             |    2 
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c       |    2 
 drivers/media/radio/radio-isa.c                            |    2 
 drivers/memory/stm32-fmc2-ebi.c                            |  122 ++--
 drivers/memory/tegra/tegra186.c                            |    3 
 drivers/mmc/core/mmc_test.c                                |    9 
 drivers/mmc/host/dw_mmc.c                                  |    8 
 drivers/net/bonding/bond_main.c                            |   21 
 drivers/net/bonding/bond_options.c                         |    2 
 drivers/net/dsa/mv88e6xxx/global1_atu.c                    |    3 
 drivers/net/dsa/ocelot/felix.c                             |   11 
 drivers/net/dsa/vitesse-vsc73xx-core.c                     |   69 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c          |    3 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c        |    7 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c            |    3 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   28 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c     |    7 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c    |    3 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |    4 
 drivers/net/ethernet/i825xx/sun3_82586.c                   |    2 
 drivers/net/ethernet/intel/ice/ice_base.c                  |    4 
 drivers/net/ethernet/intel/ice/ice_lib.c                   |    8 
 drivers/net/ethernet/intel/ice/ice_main.c                  |   10 
 drivers/net/ethernet/intel/ice/ice_txrx.c                  |  117 +--
 drivers/net/ethernet/intel/ice/ice_txrx.h                  |    6 
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c              |    1 
 drivers/net/ethernet/intel/igc/igc_defines.h               |   15 
 drivers/net/ethernet/intel/igc/igc_main.c                  |    7 
 drivers/net/ethernet/intel/igc/igc_regs.h                  |    1 
 drivers/net/ethernet/intel/igc/igc_tsn.c                   |   64 ++
 drivers/net/ethernet/intel/igc/igc_tsn.h                   |    1 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c        |   23 
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c   |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c    |    2 
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige.h      |    9 
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c |   10 
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_regs.h |    2 
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c   |   50 +
 drivers/net/ethernet/microsoft/mana/mana.h                 |    1 
 drivers/net/ethernet/microsoft/mana/mana_en.c              |   24 
 drivers/net/ethernet/mscc/ocelot.c                         |   91 ++-
 drivers/net/ethernet/mscc/ocelot_fdma.c                    |    3 
 drivers/net/ethernet/mscc/ocelot_vsc7514.c                 |    4 
 drivers/net/ethernet/xilinx/xilinx_axienet.h               |   17 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c          |   25 
 drivers/net/gtp.c                                          |    3 
 drivers/net/ppp/pppoe.c                                    |   23 
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c            |    6 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c              |    2 
 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c       |    2 
 drivers/net/wireless/st/cw1200/txrx.c                      |    2 
 drivers/nvme/host/core.c                                   |    5 
 drivers/nvme/target/rdma.c                                 |   16 
 drivers/nvme/target/tcp.c                                  |    1 
 drivers/nvme/target/trace.c                                |    6 
 drivers/nvme/target/trace.h                                |   28 
 drivers/platform/surface/aggregator/controller.c           |    3 
 drivers/platform/x86/lg-laptop.c                           |    2 
 drivers/rtc/rtc-nct3018y.c                                 |    6 
 drivers/s390/block/dasd.c                                  |   36 -
 drivers/s390/block/dasd_3990_erp.c                         |   10 
 drivers/s390/block/dasd_diag.c                             |    1 
 drivers/s390/block/dasd_eckd.c                             |   56 -
 drivers/s390/block/dasd_int.h                              |    2 
 drivers/s390/cio/idset.c                                   |   12 
 drivers/scsi/lpfc/lpfc_sli.c                               |    2 
 drivers/scsi/scsi_transport_spi.c                          |    4 
 drivers/soc/imx/imx93-pd.c                                 |    5 
 drivers/ssb/main.c                                         |    2 
 drivers/staging/iio/resolver/ad2s1210.c                    |    7 
 drivers/staging/ks7010/ks7010_sdio.c                       |    4 
 drivers/thunderbolt/switch.c                               |    1 
 drivers/tty/serial/atmel_serial.c                          |    2 
 drivers/usb/dwc3/core.c                                    |   13 
 drivers/usb/gadget/udc/fsl_udc_core.c                      |    2 
 drivers/usb/host/xhci.c                                    |    8 
 drivers/video/fbdev/offb.c                                 |    3 
 fs/9p/xattr.c                                              |    8 
 fs/afs/file.c                                              |    8 
 fs/binfmt_elf_fdpic.c                                      |    2 
 fs/binfmt_misc.c                                           |  216 +++++--
 fs/btrfs/delayed-inode.c                                   |    4 
 fs/btrfs/disk-io.c                                         |    2 
 fs/btrfs/extent_io.c                                       |    4 
 fs/btrfs/free-space-cache.c                                |   22 
 fs/btrfs/inode.c                                           |   11 
 fs/btrfs/ioctl.c                                           |    2 
 fs/btrfs/qgroup.c                                          |    2 
 fs/btrfs/reflink.c                                         |    6 
 fs/btrfs/send.c                                            |   63 +-
 fs/btrfs/super.c                                           |    2 
 fs/btrfs/tests/extent-io-tests.c                           |   28 
 fs/btrfs/tree-checker.c                                    |   69 ++
 fs/erofs/decompressor.c                                    |    8 
 fs/ext4/extents.c                                          |    3 
 fs/ext4/mballoc.c                                          |    3 
 fs/ext4/super.c                                            |   23 
 fs/ext4/xattr.c                                            |  158 ++---
 fs/f2fs/segment.c                                          |    5 
 fs/file.c                                                  |   30 -
 fs/fscache/cookie.c                                        |    4 
 fs/fuse/cuse.c                                             |    3 
 fs/fuse/dev.c                                              |    6 
 fs/fuse/fuse_i.h                                           |    1 
 fs/fuse/inode.c                                            |   15 
 fs/fuse/virtio_fs.c                                        |   10 
 fs/gfs2/glock.c                                            |   27 
 fs/gfs2/glock.h                                            |    9 
 fs/gfs2/glops.c                                            |   66 --
 fs/gfs2/incore.h                                           |    2 
 fs/gfs2/inode.c                                            |    2 
 fs/gfs2/lock_dlm.c                                         |    5 
 fs/gfs2/log.c                                              |    2 
 fs/gfs2/ops_fstype.c                                       |   13 
 fs/gfs2/recovery.c                                         |   28 
 fs/gfs2/super.c                                            |  197 ++++--
 fs/gfs2/super.h                                            |    1 
 fs/gfs2/sys.c                                              |    2 
 fs/gfs2/util.c                                             |   55 -
 fs/gfs2/util.h                                             |    5 
 fs/inode.c                                                 |   39 +
 fs/jbd2/journal.c                                          |    9 
 fs/jfs/jfs_dmap.c                                          |    2 
 fs/jfs/jfs_dtree.c                                         |    2 
 fs/kernfs/file.c                                           |    8 
 fs/nfs/pnfs.c                                              |    8 
 fs/nfsd/nfs4proc.c                                         |    4 
 fs/nfsd/nfs4state.c                                        |    2 
 fs/nfsd/nfsctl.c                                           |   32 -
 fs/nfsd/nfsd.h                                             |    3 
 fs/nfsd/nfssvc.c                                           |   85 --
 fs/nfsd/vfs.c                                              |    6 
 fs/nilfs2/btree.c                                          |    1 
 fs/nilfs2/dat.c                                            |   11 
 fs/nilfs2/direct.c                                         |    1 
 fs/ntfs3/bitmap.c                                          |    4 
 fs/ntfs3/frecord.c                                         |   75 ++
 fs/ntfs3/fsntfs.c                                          |    2 
 fs/ntfs3/index.c                                           |   11 
 fs/ntfs3/ntfs_fs.h                                         |    4 
 fs/ntfs3/super.c                                           |    2 
 fs/quota/dquot.c                                           |    5 
 fs/quota/quota_tree.c                                      |  128 +++-
 fs/quota/quota_v2.c                                        |   15 
 fs/reiserfs/stree.c                                        |    2 
 fs/smb/server/smb2pdu.c                                    |    3 
 fs/squashfs/block.c                                        |    2 
 fs/squashfs/file.c                                         |    3 
 fs/squashfs/file_direct.c                                  |    6 
 fs/udf/namei.c                                             |    1 
 include/linux/bitmap.h                                     |   20 
 include/linux/bpf_verifier.h                               |   23 
 include/linux/cpumask.h                                    |    2 
 include/linux/dsa/ocelot.h                                 |   47 +
 include/linux/fs.h                                         |    5 
 include/linux/if_vlan.h                                    |   21 
 include/linux/jbd2.h                                       |    8 
 include/linux/pid.h                                        |    2 
 include/linux/sched/signal.h                               |    2 
 include/linux/slab.h                                       |    5 
 include/linux/sunrpc/svc.h                                 |   13 
 include/linux/udp.h                                        |    2 
 include/linux/virtio_net.h                                 |   35 -
 include/net/cfg80211.h                                     |   40 +
 include/net/inet_timewait_sock.h                           |    2 
 include/net/kcm.h                                          |    1 
 include/net/tcp.h                                          |    2 
 include/scsi/scsi_cmnd.h                                   |    2 
 include/soc/mscc/ocelot.h                                  |   12 
 include/trace/events/huge_memory.h                         |    3 
 include/uapi/linux/bpf.h                                   |   19 
 init/Kconfig                                               |    7 
 kernel/bpf/Makefile                                        |    3 
 kernel/bpf/log.c                                           |   82 ++
 kernel/bpf/lpm_trie.c                                      |   33 -
 kernel/bpf/verifier.c                                      |   69 --
 kernel/cgroup/cgroup.c                                     |    4 
 kernel/pid.c                                               |    7 
 kernel/pid_namespace.c                                     |    2 
 kernel/rcu/rcu.h                                           |    7 
 kernel/rcu/srcutiny.c                                      |    1 
 kernel/rcu/srcutree.c                                      |    1 
 kernel/rcu/tasks.h                                         |    1 
 kernel/rcu/tiny.c                                          |    1 
 kernel/rcu/tree.c                                          |    3 
 kernel/time/clocksource.c                                  |   42 -
 kernel/time/hrtimer.c                                      |    5 
 kernel/time/posix-timers.c                                 |   31 -
 lib/math/prime_numbers.c                                   |    2 
 mm/huge_memory.c                                           |   30 -
 mm/khugepaged.c                                            |   20 
 mm/memcontrol.c                                            |    7 
 mm/memory-failure.c                                        |   20 
 mm/memory.c                                                |   29 
 mm/slab_common.c                                           |   41 -
 mm/util.c                                                  |    4 
 mm/vmalloc.c                                               |   11 
 net/bluetooth/bnep/core.c                                  |    3 
 net/bluetooth/hci_conn.c                                   |   11 
 net/bluetooth/hci_core.c                                   |   24 
 net/bluetooth/mgmt.c                                       |    4 
 net/bluetooth/rfcomm/sock.c                                |   14 
 net/bluetooth/smp.c                                        |  144 ++--
 net/bridge/br_netfilter_hooks.c                            |    6 
 net/core/filter.c                                          |    8 
 net/core/skbuff.c                                          |    8 
 net/dccp/ipv4.c                                            |    2 
 net/dccp/ipv6.c                                            |    6 
 net/dsa/tag_ocelot.c                                       |   37 -
 net/ipv4/fou.c                                             |    2 
 net/ipv4/inet_timewait_sock.c                              |   16 
 net/ipv4/tcp_ipv4.c                                        |   16 
 net/ipv4/tcp_minisocks.c                                   |    7 
 net/ipv4/tcp_offload.c                                     |    3 
 net/ipv4/udp_offload.c                                     |   18 
 net/ipv6/ip6_output.c                                      |   10 
 net/ipv6/ip6_tunnel.c                                      |   12 
 net/ipv6/netfilter/nf_conntrack_reasm.c                    |    4 
 net/ipv6/tcp_ipv6.c                                        |    6 
 net/iucv/iucv.c                                            |    3 
 net/kcm/kcmsock.c                                          |    4 
 net/mac80211/agg-tx.c                                      |    6 
 net/mac80211/debugfs_netdev.c                              |    3 
 net/mac80211/driver-ops.c                                  |    3 
 net/mac80211/ieee80211_i.h                                 |    1 
 net/mac80211/iface.c                                       |   27 
 net/mac80211/rx.c                                          |  387 ++++++-------
 net/mac80211/sta_info.c                                    |   17 
 net/mac80211/sta_info.h                                    |    3 
 net/mctp/test/route-test.c                                 |    2 
 net/mptcp/diag.c                                           |    2 
 net/mptcp/pm_netlink.c                                     |   31 -
 net/netfilter/nf_flow_table_inet.c                         |    3 
 net/netfilter/nf_flow_table_ip.c                           |    3 
 net/netfilter/nf_flow_table_offload.c                      |    2 
 net/netfilter/nf_tables_api.c                              |  209 ++++---
 net/netfilter/nfnetlink_queue.c                            |   35 +
 net/netfilter/nft_counter.c                                |    9 
 net/netlink/af_netlink.c                                   |   13 
 net/rds/recv.c                                             |   13 
 net/sched/sch_generic.c                                    |   11 
 net/sched/sch_netem.c                                      |   47 -
 net/sctp/inqueue.c                                         |   14 
 net/wireless/core.h                                        |    8 
 net/wireless/util.c                                        |  195 ++++--
 samples/bpf/map_perf_test_user.c                           |    2 
 samples/bpf/xdp_router_ipv4_user.c                         |    2 
 scripts/rust_is_available.sh                               |   41 +
 security/selinux/avc.c                                     |    2 
 sound/core/timer.c                                         |    2 
 sound/pci/hda/patch_realtek.c                              |    1 
 sound/soc/sof/ipc4.c                                       |    9 
 sound/usb/mixer.c                                          |    7 
 sound/usb/quirks-table.h                                   |    1 
 sound/usb/quirks.c                                         |    2 
 tools/include/linux/align.h                                |   12 
 tools/include/linux/bitmap.h                               |    9 
 tools/include/linux/mm.h                                   |    5 
 tools/include/uapi/linux/bpf.h                             |   19 
 tools/testing/selftests/bpf/progs/map_ptr_kern.c           |    2 
 tools/testing/selftests/bpf/test_lpm_map.c                 |   18 
 tools/testing/selftests/core/close_range_test.c            |   35 +
 tools/testing/selftests/net/net_helper.sh                  |   25 
 tools/testing/selftests/net/udpgro.sh                      |   57 +
 tools/testing/selftests/net/udpgro_bench.sh                |    5 
 tools/testing/selftests/net/udpgro_frglist.sh              |    5 
 tools/testing/selftests/net/udpgso.c                       |    2 
 tools/testing/selftests/tc-testing/tdc.py                  |    1 
 tools/tracing/rtla/src/osnoise_top.c                       |   11 
 340 files changed, 4069 insertions(+), 2057 deletions(-)

Abdulrasaq Lawani (1):
      fbdev: offb: replace of_node_put with __free(device_node)

Abhinav Kumar (2):
      drm/msm/dp: fix the max supported bpp logic
      drm/msm/dp: reset the link phy params before link training

Adrian Hunter (1):
      clocksource: Make watchdog and suspend-timing multiplication overflow safe

Al Viro (4):
      fix bitmap corruption on close_range() with CLOSE_RANGE_UNSHARE
      memcg_write_event_control(): fix a user-triggerable oops
      afs: fix __afs_break_callback() / afs_drop_open_mmap() race
      fuse: fix UAF in rcu pathwalks

Alex Deucher (1):
      drm/amdgpu/jpeg2: properly set atomics vmid field

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

Alexandre Belloni (1):
      rtc: nct3018y: fix possible NULL dereference

Alexei Starovoitov (1):
      bpf: Avoid kfree_rcu() under lock in bpf_lpm_trie.

Allison Henderson (1):
      net:rds: Fix possible deadlock in rds_message_put

Andi Shyti (1):
      i2c: qcom-geni: Add missing geni_icc_disable in geni_i2c_runtime_resume

Andreas Gruenbacher (12):
      gfs2: Rename remaining "transaction" glock references
      gfs2: Rename the {freeze,thaw}_super callbacks
      gfs2: Rename gfs2_freeze_lock{ => _shared }
      gfs2: Rename SDF_{FS_FROZEN => FREEZE_INITIATOR}
      gfs2: Rework freeze / thaw logic
      gfs2: Stop using gfs2_make_fs_ro for withdraw
      gfs2: setattr_chown: Add missing initialization
      gfs2: Refcounting fix in gfs2_thaw_super
      gfs2: Fix another freeze/thaw hang
      gfs2: don't withdraw if init_threads() got interrupted
      gfs2: Remove LM_FLAG_PRIORITY flag
      gfs2: Remove freeze_go_demote_ok

Andrew Melnychenko (1):
      udp: allow header check for dodgy GSO_UDP_L4 packets.

Andrii Nakryiko (2):
      bpf: Split off basic BPF verifier log into separate file
      bpf: drop unnecessary user-triggerable WARN_ONCE in verifierl log

Andy Yan (1):
      drm/rockchip: vop2: clear afbc en and transform bit for cluster window at linear mode

Antoniu Miclaus (1):
      hwmon: (ltc2992) Avoid division by zero

Ashish Mhetre (1):
      memory: tegra: Skip SID programming if SID registers aren't set

Aurelien Jarno (1):
      media: solo6x10: replace max(a, min(b, c)) by clamp(b, a, c)

Baokun Li (2):
      ext4: do not trim the group with corrupted block bitmap
      ext4: set the type of max_zeroout to unsigned int to avoid overflow

Bard Liao (1):
      ASoC: SOF: ipc4: check return value of snd_sof_ipc_msg_data

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

Cosmin Ratiu (1):
      net/mlx5e: Correctly report errors for ethtool rx flows

Costa Shulyupin (1):
      hrtimer: Select housekeeping CPU during migration

Dan Carpenter (4):
      rtla/osnoise: Prevent NULL dereference in error handling
      atm: idt77252: prevent use after free in dequeue_rx()
      dpaa2-switch: Fix error checking in dpaa2_switch_seed_bp()
      mmc: mmc_test: Fix NULL dereference on allocation failure

Daniel Wagner (1):
      nvmet-trace: avoid dereferencing pointer too early

Dave Kleikamp (1):
      Revert "jfs: fix shift-out-of-bounds in dbJoin"

David Lechner (1):
      staging: iio: resolver: ad2s1210: fix use before initialization

David Sterba (8):
      btrfs: delayed-inode: drop pointless BUG_ON in __btrfs_remove_delayed_item()
      btrfs: change BUG_ON to assertion when checking for delayed_node root
      btrfs: tests: allocate dummy fs_info and root in test_find_delalloc()
      btrfs: handle invalid root reference found in may_destroy_subvol()
      btrfs: send: handle unexpected data in header buffer in begin_cmd()
      btrfs: change BUG_ON to assertion in tree_move_down()
      btrfs: delete pointless BUG_ON check on quota root in btrfs_qgroup_account_extent()
      btrfs: replace sb::s_blocksize by fs_info::sectorsize

David Thompson (1):
      mlxbf_gige: disable RX filters until RX path initialized

Dmitry Antipov (1):
      net: sctp: fix skb leak in sctp_inq_free()

Dmitry Baryshkov (2):
      drm/msm/dpu: don't play tricks with debug macros
      drm/msm/dpu: cleanup FB if dpu_format_populate_layout fails

Donald Hunter (2):
      docs/bpf: Document BPF_MAP_TYPE_LPM_TRIE map
      netfilter: flowtable: initialise extack before use

Dragos Tatulea (1):
      net/mlx5e: Take state lock during tx timeout reporter

Edward Adam Davis (2):
      reiserfs: fix uninit-value in comp_keys
      jfs: fix null ptr deref in dtInsertEntry

Eli Billauer (3):
      char: xillybus: Don't destroy workqueue from work item running on it
      char: xillybus: Refine workqueue handling
      char: xillybus: Check USB endpoints when probing device

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

Faizal Rahim (1):
      igc: Fix packet still tx after gate close by reducing i226 MAC retry buffer

Felix Fietkau (14):
      wifi: mac80211: fix and simplify unencrypted drop check for mesh
      wifi: cfg80211: move A-MSDU check in ieee80211_data_to_8023_exthdr
      wifi: cfg80211: factor out bridge tunnel / RFC1042 header check
      wifi: mac80211: remove mesh forwarding congestion check
      wifi: mac80211: fix receiving A-MSDU frames on mesh interfaces
      wifi: mac80211: add a workaround for receiving non-standard mesh A-MSDU
      wifi: mac80211: fix mesh path discovery based on unicast packets
      wifi: mac80211: fix mesh forwarding
      wifi: mac80211: fix flow dissection for forwarded packets
      wifi: mac80211: fix receiving mesh packets in forwarding=0 networks
      wifi: mac80211: drop bogus static keywords in A-MSDU rx
      wifi: mac80211: fix potential null pointer dereference
      wifi: cfg80211: fix receiving mesh packets without RFC1042 header
      udp: fix receiving fraglist GSO packets

Filipe Manana (1):
      btrfs: send: allow cloning non-aligned extent if it ends at i_size

Florian Westphal (2):
      netfilter: nf_queue: drop packets with cloned unconfirmed conntracks
      tcp: prevent concurrent execution of tcp_sk_exit_batch

Gao Xiang (1):
      erofs: avoid debugging output for (de)compressed data

Gavrilov Ilia (1):
      pppoe: Fix memory leak in pppoe_sendmsg()

Gergo Koteles (1):
      platform/x86: lg-laptop: fix %s null argument warning

Greg Kroah-Hartman (2):
      Revert "usb: gadget: uvc: cleanup request when not in correct state"
      Linux 6.1.107

Griffin Kroah-Hartman (1):
      Bluetooth: MGMT: Add error handling to pair_device()

Guanrui Huang (1):
      irqchip/gic-v3-its: Remove BUG_ON in its_vpe_irq_domain_alloc

Gustavo A. R. Silva (1):
      clk: visconti: Add bounds-checking coverage for struct visconti_pll_provider

Haibo Xu (1):
      arm64: ACPI: NUMA: initialize all values of acpi_early_node_map to NUMA_NO_NODE

Hailong Liu (1):
      mm/vmalloc: fix page mapping if vm_area_alloc_pages() with high order fallback to order 0

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

Ivan Orlov (2):
      9P FS: Fix wild-memory-access write in v9fs_get_acl
      mm: khugepaged: fix kernel BUG in hpage_collapse_scan_file()

Jakub Kicinski (1):
      net: don't dump stack on queue timeout

Jan Höppner (1):
      Revert "s390/dasd: Establish DMA alignment"

Jan Kara (5):
      quota: Detect loops in quota tree
      ext4: fold quota accounting into ext4_xattr_inode_lookup_create()
      ext4: do not create EA inode under buffer lock
      udf: Fix bogus checksum computation in udf_rename()
      quota: Remove BUG_ON from dqget()

Jann Horn (1):
      fuse: Initialize beyond-EOF page contents before setting uptodate

Jarkko Nikula (2):
      i3c: mipi-i3c-hci: Remove BUG() when Ring Abort request times out
      i3c: mipi-i3c-hci: Do not unmap region not mapped for transfer

Jason Gerecke (1):
      HID: wacom: Defer calculation of resolution until resolution_code is known

Javier Carrasco (1):
      hwmon: (ltc2992) Fix memory leak in ltc2992_parse_dt()

Jeff Johnson (1):
      wifi: cw1200: Avoid processing an invalid TIM IE

Jeff Layton (1):
      nfsd: drop the nfsd_put helper

Jeremy Kerr (1):
      net: mctp: test: Use correct skb for route input check

Jesse Brandeburg (1):
      ice: fix W=1 headers mismatch

Jesse Zhang (1):
      drm/amdgpu: fix dereference null return value for the function amdgpu_vm_pt_parent

Jian Shen (1):
      net: hns3: add checking for vf id of mailbox

Jiaxun Yang (1):
      MIPS: Loongson64: Set timer mode in cpu-probe

Jie Wang (2):
      net: hns3: fix wrong use of semaphore up
      net: hns3: fix a deadlock problem when config TC during resetting

Johannes Berg (6):
      wifi: mac80211: take wiphy lock for MAC addr change
      wifi: mac80211: fix change_address deadlock during unregister
      wifi: cfg80211: check A-MSDU format more carefully
      wifi: cfg80211: check wiphy mutex is held for wdev mutex
      wifi: mac80211: fix BA session teardown race
      wifi: mac80211: add documentation for amsdu_mesh_control

Joseph Huang (1):
      net: dsa: mv88e6xxx: Fix out-of-bound access

Juan José Arboleda (1):
      ALSA: usb-audio: Support Yamaha P-125 quirk entry

Justin Tee (1):
      scsi: lpfc: Initialize status local variable in lpfc_sli4_repost_sgl_list()

Kamalesh Babulal (1):
      cgroup: Avoid extra dereference in css_populate_dir()

Kees Cook (5):
      pid: Replace struct pid 1-element array with flex-array
      bpf: Replace bpf_lpm_trie_key 0-length array with flexible array
      hwmon: (pc87360) Bounds check data->innr usage
      net/sun3_82586: Avoid reading past buffer in debug output
      x86: Increase brk randomness entropy for 64-bit systems

Keith Busch (1):
      nvme: clear caller pointer on identify failure

Khazhismel Kumykov (1):
      dm resume: don't return EINVAL when signalled

Konstantin Komarov (1):
      fs/ntfs3: Do copy_to_user out of run_lock

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

Lee, Chun-Yi (1):
      Bluetooth: hci_ldisc: check HCI_UART_PROTO_READY flag in HCIUARTGETPROTO

Leon Hwang (1):
      bpf: Fix updating attached freplace prog in prog_array map

Li Lingfeng (1):
      block: Fix lockdep warning in blk_mq_mark_tag_wait

Li Nan (1):
      md: clean up invalid BUG_ON in md_ioctl

Li RongQing (1):
      KVM: x86: fire timer when it is migrated and expired, and in oneshot mode

Li Zhong (1):
      ext4: check the return value of ext4_xattr_inode_dec_ref()

Li zeming (1):
      powerpc/boot: Handle allocation failure in simple_realloc()

Lianqin Hu (1):
      ALSA: usb-audio: Add delay quirk for VIVO USB-C-XE710 HEADSET

Lizhi Xu (1):
      squashfs: squashfs_read_data need to check if the length is 0

Long Li (1):
      net: mana: Fix doorbell out of order violation and avoid unnecessary doorbell rings

Lucas Karpinski (1):
      selftests/net: synchronize udpgro tests' tx and rx connection

Luiz Augusto von Dentz (4):
      Bluetooth: RFCOMM: Fix not validating setsockopt user input
      Bluetooth: bnep: Fix out-of-bound access
      Bluetooth: hci_core: Fix LE quote calculation
      Bluetooth: SMP: Fix assumption of Central always being Initiator

Maciej Fijalkowski (6):
      ice: Prepare legacy-rx for upcoming XDP multi-buffer support
      ice: Add xdp_buff to ice_rx_ring struct
      ice: Store page count inside ice_rx_buf
      ice: Pull out next_to_clean bump out of ice_put_rx_buf()
      ice: fix page reuse when PAGE_SIZE is over 8k
      ice: fix ICE_LAST_OFFSET formula

Manas Ghandat (1):
      jfs: fix shift-out-of-bounds in dbJoin

Marc Zyngier (1):
      KVM: arm64: Make ICC_*SGI*_EL1 undef in the absence of a vGICv3

Martin Blumenstingl (1):
      clocksource/drivers/arm_global_timer: Guard against division by zero

Masahiro Yamada (2):
      rust: suppress error messages from CONFIG_{RUSTC,BINDGEN}_VERSION_TEXT
      rust: fix the default format for CONFIG_{RUSTC,BINDGEN}_VERSION_TEXT

Mathias Nyman (1):
      xhci: Fix Panther point NULL pointer deref at full-speed re-enumeration

Mathieu Othacehe (1):
      tty: atmel_serial: use the correct RTS flag.

Matthieu Baerts (NGI0) (4):
      mptcp: pm: re-using ID of unused removed ADD_ADDR
      mptcp: pm: re-using ID of unused removed subflows
      mptcp: pm: re-using ID of unused flushed subflows
      mptcp: pm: only decrement add_addr_accepted for MPJ req

Max Filippov (1):
      fs: binfmt_elf_efpic: don't use missing interpreter's properties

Max Kellermann (1):
      fs/netfs/fscache_cookie: add missing "n_accesses" check

Maximilian Luz (1):
      platform/surface: aggregator: Fix warning when controller is destroyed in probe

Michael Ellerman (1):
      powerpc/boot: Only free if realloc() succeeds

Michael Grzeschik (1):
      usb: gadget: uvc: cleanup request when not in correct state

Michał Mirosław (2):
      i2c: tegra: allow DVC support to be compiled out
      i2c: tegra: allow VI support to be compiled out

Miguel Ojeda (3):
      kbuild: rust_is_available: normalize version matching
      kbuild: rust_is_available: handle failures calling `$RUSTC`/`$BINDGEN`
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

Miri Korenblit (1):
      wifi: iwlwifi: abort scan when rfkill on but device enabled

Muhammad Husaini Zulkifli (1):
      igc: Correct the launchtime offset

Mukesh Sisodiya (1):
      wifi: iwlwifi: fw: Fix debugfs command sending

Nam Cao (1):
      riscv: change XIP's kernel_map.size to be size of the entire kernel

Namjae Jeon (1):
      ksmbd: the buffer of smb2 query dir response has at least 1 byte

Naohiro Aota (1):
      btrfs: zoned: properly take lock to read/update block group's zoned variables

Neel Natu (1):
      kernfs: fix false-positive WARN(nr_mmapped) in kernfs_drain_open_files

NeilBrown (6):
      NFS: avoid infinite loop in pnfs_update_layout.
      nfsd: Simplify code around svc_exit_thread() call in nfsd()
      nfsd: separate nfsd_last_thread() from nfsd_put()
      NFSD: simplify error paths in nfsd_svc()
      nfsd: call nfsd_last_thread() before final nfsd_put()
      nfsd: don't call locks_release_private() twice concurrently

Nikolay Aleksandrov (4):
      bonding: fix bond_ipsec_offload_ok return type
      bonding: fix null pointer deref in bond_ipsec_offload_ok
      bonding: fix xfrm real_dev null pointer dereference
      bonding: fix xfrm state handling when clearing active slave

Nikolay Kuratov (1):
      cxgb4: add forgotten u64 ivlan cast before shift

Oreoluwa Babatunde (1):
      openrisc: Call setup_memory() earlier in the init sequence

Pablo Neira Ayuso (1):
      netfilter: flowtable: validate vlan header

Paolo Abeni (1):
      selftests: net: more strict check in net_helper

Parsa Poorshikhian (1):
      ALSA: hda/realtek: Fix noise from speakers on Lenovo IdeaPad 3 15IAU7

Paul E. McKenney (1):
      rcu: Eliminate rcu_gp_slow_unregister() false positive

Pawel Dembicki (3):
      net: dsa: vsc73xx: pass value in phy_write operation
      net: dsa: vsc73xx: use read_poll_timeout instead delay loop
      net: dsa: vsc73xx: check busy flag in MDIO operations

Pei Li (1):
      jfs: Fix shift-out-of-bounds in dbDiscardAG

Peiyang Wang (1):
      net: hns3: use the user's cfg after reset

Peng Fan (1):
      pmdomain: imx: wait SSAR when i.MX93 power domain on

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

Phillip Lougher (1):
      Squashfs: fix variable overflow triggered by sysbot

Qu Wenruo (1):
      btrfs: tree-checker: add dev extent item checks

Radhey Shyam Pandey (1):
      net: axienet: Fix register defines comment description

Rand Deeb (1):
      ssb: Fix division by zero issue in ssb_calc_clock_rate

Richard Fitzgerald (1):
      firmware: cirrus: cs_dsp: Initialize debugfs_root to invalid

Rob Clark (1):
      drm/msm: Reduce fallout of fence signaling vs reclaim hangs

Rodrigo Siqueira (1):
      drm/amd/display: Adjust cursor position

Ryusuke Konishi (1):
      nilfs2: prevent WARNING in nilfs_dat_commit_end()

Sagi Grimberg (1):
      nvmet-rdma: fix possible bad dereference when freeing rsps

Samuel Holland (1):
      arm64: Fix KASAN random tag seed initialization

Sean Anderson (2):
      net: xilinx: axienet: Always disable promiscuous mode
      net: xilinx: axienet: Fix dangling multicast addresses

Sebastian Andrzej Siewior (2):
      netfilter: nft_counter: Disable BH in nft_counter_offload_stats().
      netfilter: nft_counter: Synchronize nft_counter_reset() against reader.

Siarhei Vishniakou (1):
      HID: microsoft: Add rumble support to latest xbox controllers

Simon Horman (1):
      tc-testing: don't access non-existent variable on exception

Stefan Haberland (1):
      s390/dasd: fix error recovery leading to data corruption on ESE devices

Stefan Hajnoczi (1):
      virtiofs: forbid newlines in tags

Stephen Hemminger (1):
      netem: fix return value if duplicate enqueue fails

Takashi Iwai (2):
      ALSA: usb: Fix UBSAN warning in parse_audio_unit()
      ALSA: timer: Relax start tick time check for slave timer elements

Tetsuo Handa (2):
      nilfs2: initialize "struct nilfs_binfo_dat"->bi_pad field
      Input: MT - limit max slots

Theodore Ts'o (1):
      ext4, jbd2: add an optimized bmap for the journal inode

Thomas Bogendoerfer (1):
      ip6_tunnel: Fix broken GRO

Thomas Gleixner (1):
      posix-timers: Ensure timer ID search-loop limit is valid

Tom Hughes (1):
      netfilter: allow ipv6 fragments to arrive on different devices

Tomi Valkeinen (1):
      drm/bridge: tc358768: Attempt to fix DSI horizontal timings

Trond Myklebust (1):
      nfsd: Fix a regression in nfsd_setattr()

Uwe Kleine-König (1):
      usb: gadget: fsl: Increase size of name buffer for endpoints

Vladimir Oltean (5):
      net: dsa: tag_ocelot: do not rely on skb_mac_header() for VLAN xmit
      net: dsa: tag_ocelot: call only the relevant portion of __skb_vlan_pop() on TX
      net: mscc: ocelot: use ocelot_xmit_get_vlan_info() also for FDMA and register injection
      net: mscc: ocelot: fix QoS class for injected packets with "ocelot-8021q"
      net: mscc: ocelot: serialize access to the injection/extraction groups

Waiman Long (1):
      mm/memory-failure: use raw_spinlock_t in struct memory_failure_cpu

Werner Sembach (2):
      Input: i8042 - add forcenorestore quirk to leave controller untouched even on s3
      Input: i8042 - use new forcenorestore quirk to replace old buggy quirk combination

Willem de Bruijn (3):
      fou: remove warn in gue_gro_receive on unsupported protocol
      net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation
      net: drop bad gso csum_start and offset in virtio_net_hdr

Wolfram Sang (1):
      i2c: riic: avoid potential division by zero

Yajun Deng (1):
      net: sched: Print msecs when transmit queue time out

Yan Zhai (1):
      gso: fix dodgy bit handling for GSO_UDP_L4

Ying Hsu (1):
      Bluetooth: Fix hci_link_tx_to RCU lock usage

Yu Kuai (1):
      md/raid5-cache: use READ_ONCE/WRITE_ONCE for 'conf->log'

Yue Haibing (1):
      mlxbf_gige: Remove two unused function declarations

Yuri Benditovich (1):
      net: change maximum number of UDP segments to 128

Zhen Lei (3):
      selinux: fix potential counting error in avc_add_xperms_decision()
      mm: Remove kmem_valid_obj()
      rcu: Dump memory object info if callback function is invalid

Zhiguo Niu (1):
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

yunshui (1):
      bpf, net: Use DEV_STAT_INC()


