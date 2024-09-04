Return-Path: <stable+bounces-73037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0533496BB21
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E156B28AE0
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FDF1D45EC;
	Wed,  4 Sep 2024 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nTx1HcNO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D12A1D0482;
	Wed,  4 Sep 2024 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725450123; cv=none; b=ZQg9yIoVLakbz9jJBadAVUqYlnJMq9Uog+uZdhoqDjiMXJGqNuowx0jiMDCOpGoCiP8rfV/WkA4b8YBoTR33zrbrIRyTFUjKG3FU3zAcQzRSw0k36G07lniozRVGNAgGW/DOzfmA0mM6RWSB/CkEIJU7WhwTqAxPtBgaVHnNt6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725450123; c=relaxed/simple;
	bh=Jsxe0PMdrFci4qnYlnabENpS+uK1TwAY2EK+ukaG8fA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TN8W7Uh2U771zHBA9B6GnZINKqbkrQa2k/F1ga/gS2D/M3epL8OruHPhAl0o7UNhCszst9hjK4FCj/JeljHK9y3lRI25VwwAY18dg8CpBatUH1bLCfwFZ0Nyac/HWfbrZBLyz/X7bTt3NBnQYA92qwxuDMTQStWPLqVWQ7FUoGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nTx1HcNO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F483C4CEC2;
	Wed,  4 Sep 2024 11:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725450123;
	bh=Jsxe0PMdrFci4qnYlnabENpS+uK1TwAY2EK+ukaG8fA=;
	h=From:To:Cc:Subject:Date:From;
	b=nTx1HcNORQkB1SROg5aJua8Mbu12piWDJrdH9dl2Wp4xRaBMGPARLKH4cjs8c3w4y
	 O6TEmwRdgoB23vMBOHOKKB+ga+vunuhL7gqT5nXNDddDzd9KSeLapUG9jUyc47r4jH
	 MvLEcE6z85GU1hljhUISnr19jbsJLDnPpxnu2PsY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.166
Date: Wed,  4 Sep 2024 13:41:46 +0200
Message-ID: <2024090446-hacked-delegate-f779@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.166 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                   |    2 
 arch/arm64/kernel/acpi_numa.c                              |    2 
 arch/arm64/kernel/setup.c                                  |    3 
 arch/arm64/kernel/smp.c                                    |    2 
 arch/arm64/kvm/sys_regs.c                                  |    6 
 arch/arm64/kvm/vgic/vgic.h                                 |    7 
 arch/mips/kernel/cpu-probe.c                               |    4 
 arch/mips/loongson64/reset.c                               |   38 +-
 arch/openrisc/kernel/setup.c                               |    6 
 arch/parisc/kernel/irq.c                                   |    4 
 arch/powerpc/boot/simple_alloc.c                           |    7 
 arch/powerpc/sysdev/xics/icp-native.c                      |    2 
 arch/s390/include/asm/uv.h                                 |    5 
 arch/s390/kernel/early.c                                   |   12 
 arch/s390/kernel/smp.c                                     |    4 
 arch/x86/kernel/process.c                                  |    5 
 drivers/ata/libata-core.c                                  |    3 
 drivers/atm/idt77252.c                                     |    9 
 drivers/bluetooth/hci_ldisc.c                              |    3 
 drivers/char/xillybus/xillyusb.c                           |   42 ++
 drivers/clocksource/arm_global_timer.c                     |   11 
 drivers/dma/dw/core.c                                      |   89 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c                    |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c                    |    3 
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c                     |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                   |    5 
 drivers/gpu/drm/lima/lima_gp.c                             |   12 
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h                    |   14 
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c                  |    3 
 drivers/gpu/drm/msm/dp/dp_ctrl.c                           |    2 
 drivers/hid/hid-ids.h                                      |   10 
 drivers/hid/hid-microsoft.c                                |   11 
 drivers/hid/wacom_wac.c                                    |    4 
 drivers/hwmon/ltc2992.c                                    |    8 
 drivers/i2c/busses/i2c-riic.c                              |    2 
 drivers/i3c/master/mipi-i3c-hci/dma.c                      |    5 
 drivers/infiniband/hw/hfi1/chip.c                          |    5 
 drivers/infiniband/ulp/rtrs/rtrs.c                         |    2 
 drivers/input/input-mt.c                                   |    3 
 drivers/irqchip/irq-gic-v3-its.c                           |    2 
 drivers/md/dm-clone-metadata.c                             |    5 
 drivers/md/dm-ioctl.c                                      |   22 +
 drivers/md/dm.c                                            |    4 
 drivers/md/md.c                                            |    5 
 drivers/md/persistent-data/dm-space-map-metadata.c         |    4 
 drivers/media/dvb-core/dvb_frontend.c                      |   12 
 drivers/media/pci/cx23885/cx23885-video.c                  |    8 
 drivers/media/pci/solo6x10/solo6x10-offsets.h              |   10 
 drivers/media/platform/qcom/venus/pm_helpers.c             |    2 
 drivers/media/radio/radio-isa.c                            |    2 
 drivers/memory/stm32-fmc2-ebi.c                            |  122 +++++--
 drivers/memory/tegra/tegra186.c                            |    3 
 drivers/mmc/core/mmc_test.c                                |    9 
 drivers/mmc/host/dw_mmc.c                                  |    8 
 drivers/net/bonding/bond_main.c                            |   21 -
 drivers/net/bonding/bond_options.c                         |    2 
 drivers/net/dsa/mv88e6xxx/Makefile                         |    4 
 drivers/net/dsa/mv88e6xxx/global1_atu.c                    |   82 ++++
 drivers/net/dsa/mv88e6xxx/trace.c                          |    6 
 drivers/net/dsa/mv88e6xxx/trace.h                          |   66 +++
 drivers/net/dsa/vitesse-vsc73xx-core.c                     |   69 +++-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c          |    3 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c        |    7 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c            |    3 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |    4 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c     |    7 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |    4 
 drivers/net/ethernet/i825xx/sun3_82586.c                   |    2 
 drivers/net/ethernet/intel/ice/ice_txrx.c                  |    2 
 drivers/net/ethernet/intel/igc/igc_base.c                  |   29 +
 drivers/net/ethernet/intel/igc/igc_base.h                  |    2 
 drivers/net/ethernet/intel/igc/igc_defines.h               |   16 
 drivers/net/ethernet/intel/igc/igc_main.c                  |   12 
 drivers/net/ethernet/intel/igc/igc_regs.h                  |    1 
 drivers/net/ethernet/intel/igc/igc_tsn.c                   |  113 +++++-
 drivers/net/ethernet/intel/igc/igc_tsn.h                   |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c    |    2 
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige.h      |    9 
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c |   10 
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_regs.h |    2 
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c   |   50 ++-
 drivers/net/ethernet/microsoft/mana/hw_channel.c           |   62 ++-
 drivers/net/ethernet/microsoft/mana/mana.h                 |    1 
 drivers/net/ethernet/microsoft/mana/mana_en.c              |   24 -
 drivers/net/ethernet/xilinx/xilinx_axienet.h               |   17 -
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c          |   25 -
 drivers/net/gtp.c                                          |    5 
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c            |    6 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c              |    2 
 drivers/net/wireless/marvell/mwifiex/cfg80211.c            |   32 +
 drivers/net/wireless/st/cw1200/txrx.c                      |    2 
 drivers/nfc/pn533/pn533.c                                  |    5 
 drivers/nvme/target/rdma.c                                 |   16 
 drivers/nvme/target/tcp.c                                  |    1 
 drivers/nvme/target/trace.c                                |    6 
 drivers/nvme/target/trace.h                                |   28 +
 drivers/phy/xilinx/phy-zynqmp.c                            |  152 ++++++---
 drivers/pinctrl/pinctrl-rockchip.c                         |    2 
 drivers/pinctrl/pinctrl-single.c                           |    2 
 drivers/platform/surface/aggregator/controller.c           |    3 
 drivers/platform/x86/lg-laptop.c                           |    2 
 drivers/s390/block/dasd.c                                  |   36 +-
 drivers/s390/block/dasd_3990_erp.c                         |   10 
 drivers/s390/block/dasd_eckd.c                             |   55 +--
 drivers/s390/block/dasd_int.h                              |    2 
 drivers/s390/cio/idset.c                                   |   12 
 drivers/scsi/aacraid/comminit.c                            |    2 
 drivers/scsi/lpfc/lpfc_sli.c                               |    2 
 drivers/scsi/scsi_transport_spi.c                          |    4 
 drivers/soc/qcom/cmd-db.c                                  |    2 
 drivers/soundwire/stream.c                                 |    8 
 drivers/ssb/main.c                                         |    2 
 drivers/staging/iio/resolver/ad2s1210.c                    |    7 
 drivers/staging/ks7010/ks7010_sdio.c                       |    4 
 drivers/thunderbolt/switch.c                               |    1 
 drivers/usb/cdns3/cdnsp-gadget.h                           |    3 
 drivers/usb/cdns3/cdnsp-ring.c                             |   30 +
 drivers/usb/class/cdc-acm.c                                |    3 
 drivers/usb/core/sysfs.c                                   |    1 
 drivers/usb/dwc3/core.c                                    |   21 +
 drivers/usb/dwc3/dwc3-omap.c                               |    4 
 drivers/usb/dwc3/dwc3-st.c                                 |   16 
 drivers/usb/gadget/udc/fsl_udc_core.c                      |    2 
 drivers/usb/host/xhci.c                                    |    8 
 drivers/usb/serial/option.c                                |    5 
 fs/afs/file.c                                              |    8 
 fs/binfmt_elf_fdpic.c                                      |    2 
 fs/binfmt_misc.c                                           |  216 ++++++++++---
 fs/btrfs/delayed-inode.c                                   |    2 
 fs/btrfs/free-space-cache.c                                |    8 
 fs/btrfs/inode.c                                           |    9 
 fs/btrfs/qgroup.c                                          |    4 
 fs/btrfs/send.c                                            |    9 
 fs/btrfs/tree-checker.c                                    |   69 ++++
 fs/ext4/extents.c                                          |    3 
 fs/ext4/mballoc.c                                          |    3 
 fs/f2fs/segment.c                                          |    5 
 fs/file.c                                                  |   30 -
 fs/fuse/cuse.c                                             |    3 
 fs/fuse/dev.c                                              |    6 
 fs/fuse/fuse_i.h                                           |    1 
 fs/fuse/inode.c                                            |   15 
 fs/fuse/virtio_fs.c                                        |   10 
 fs/gfs2/inode.c                                            |    2 
 fs/inode.c                                                 |   39 ++
 fs/lockd/svc.c                                             |    3 
 fs/nfs/callback.c                                          |    3 
 fs/nfs/pnfs.c                                              |    8 
 fs/nfsd/export.c                                           |   32 +
 fs/nfsd/export.h                                           |    4 
 fs/nfsd/netns.h                                            |   25 +
 fs/nfsd/nfs4proc.c                                         |    6 
 fs/nfsd/nfscache.c                                         |  200 +++++++-----
 fs/nfsd/nfsctl.c                                           |   24 -
 fs/nfsd/nfsd.h                                             |    1 
 fs/nfsd/nfsfh.c                                            |    3 
 fs/nfsd/nfssvc.c                                           |   24 -
 fs/nfsd/stats.c                                            |   52 +--
 fs/nfsd/stats.h                                            |   85 +----
 fs/nfsd/trace.h                                            |   22 +
 fs/nfsd/vfs.c                                              |    6 
 fs/ntfs3/bitmap.c                                          |    4 
 fs/ntfs3/fsntfs.c                                          |    2 
 fs/ntfs3/index.c                                           |   11 
 fs/ntfs3/ntfs_fs.h                                         |    4 
 fs/ntfs3/super.c                                           |    2 
 fs/quota/dquot.c                                           |    5 
 include/linux/bitmap.h                                     |   20 +
 include/linux/blkdev.h                                     |    2 
 include/linux/cpumask.h                                    |    2 
 include/linux/fs.h                                         |    5 
 include/linux/pm.h                                         |   55 ++-
 include/linux/pm_runtime.h                                 |   14 
 include/linux/sunrpc/svc.h                                 |    5 
 include/net/busy_poll.h                                    |    2 
 include/net/kcm.h                                          |    1 
 include/scsi/scsi_cmnd.h                                   |    2 
 kernel/cgroup/cpuset.c                                     |   13 
 kernel/time/clocksource.c                                  |   42 +-
 kernel/time/hrtimer.c                                      |    2 
 lib/math/prime_numbers.c                                   |    2 
 mm/huge_memory.c                                           |   30 -
 mm/memcontrol.c                                            |    7 
 mm/memory.c                                                |   29 -
 net/bluetooth/bnep/core.c                                  |    3 
 net/bluetooth/hci_core.c                                   |   19 -
 net/bluetooth/mgmt.c                                       |    4 
 net/bluetooth/smp.c                                        |  144 ++++----
 net/bridge/br_netfilter_hooks.c                            |    6 
 net/core/net-sysfs.c                                       |    2 
 net/ethtool/ioctl.c                                        |    3 
 net/ipv6/ip6_output.c                                      |   10 
 net/ipv6/ip6_tunnel.c                                      |   12 
 net/ipv6/netfilter/nf_conntrack_reasm.c                    |    4 
 net/iucv/iucv.c                                            |    3 
 net/kcm/kcmsock.c                                          |    4 
 net/mac80211/agg-tx.c                                      |    6 
 net/mac80211/driver-ops.c                                  |    3 
 net/mac80211/sta_info.c                                    |   14 
 net/mptcp/diag.c                                           |    2 
 net/mptcp/protocol.c                                       |    2 
 net/netfilter/nf_flow_table_inet.c                         |    3 
 net/netfilter/nf_flow_table_ip.c                           |    3 
 net/netfilter/nf_flow_table_offload.c                      |    2 
 net/netfilter/nfnetlink_queue.c                            |   35 +-
 net/netfilter/nft_counter.c                                |    9 
 net/netlink/af_netlink.c                                   |   13 
 net/rds/recv.c                                             |   13 
 net/sched/sch_netem.c                                      |   47 +-
 net/sunrpc/stats.c                                         |    2 
 net/sunrpc/svc.c                                           |   36 +-
 net/wireless/core.h                                        |    8 
 security/apparmor/policy_unpack_test.c                     |    6 
 security/selinux/avc.c                                     |    2 
 sound/core/timer.c                                         |    2 
 sound/pci/hda/patch_realtek.c                              |    1 
 sound/usb/quirks-table.h                                   |    1 
 sound/usb/quirks.c                                         |    2 
 tools/include/linux/align.h                                |   12 
 tools/include/linux/bitmap.h                               |    9 
 tools/testing/selftests/core/close_range_test.c            |   35 ++
 tools/testing/selftests/tc-testing/tdc.py                  |    1 
 222 files changed, 2387 insertions(+), 1046 deletions(-)

Abhinav Kumar (1):
      drm/msm/dp: reset the link phy params before link training

Adrian Hunter (1):
      clocksource: Make watchdog and suspend-timing multiplication overflow safe

Al Viro (4):
      fix bitmap corruption on close_range() with CLOSE_RANGE_UNSHARE
      memcg_write_event_control(): fix a user-triggerable oops
      afs: fix __afs_break_callback() / afs_drop_open_mmap() race
      fuse: fix UAF in rcu pathwalks

Aleksandr Mishin (1):
      nfc: pn533: Add poll mod list filling check

Alex Deucher (2):
      drm/amdgpu/jpeg2: properly set atomics vmid field
      drm/amdkfd: don't allow mapping the MMIO HDP page with large pages

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

Allison Henderson (1):
      net:rds: Fix possible deadlock in rds_message_put

Andreas Gruenbacher (1):
      gfs2: setattr_chown: Add missing initialization

Antoniu Miclaus (1):
      hwmon: (ltc2992) Avoid division by zero

Ashish Mhetre (1):
      memory: tegra: Skip SID programming if SID registers aren't set

Aurelien Jarno (1):
      media: solo6x10: replace max(a, min(b, c)) by clamp(b, a, c)

Baokun Li (2):
      ext4: do not trim the group with corrupted block bitmap
      ext4: set the type of max_zeroout to unsigned int to avoid overflow

Bas Nieuwenhuizen (1):
      drm/amdgpu: Actually check flags for all context ops.

Ben Hutchings (1):
      scsi: aacraid: Fix double-free on probe failure

Ben Whitten (1):
      mmc: dw_mmc: allow biu and ciu clocks to defer

Chaotian Jing (1):
      scsi: core: Fix the return value of scsi_logical_block_count()

Chen Ridong (1):
      cgroup/cpuset: Prevent UAF in proc_cpuset_show()

Chengfeng Ye (2):
      staging: ks7010: disable bh on tx_dev_lock
      IB/hfi1: Fix potential deadlock on &irq_src_lock and &dd->uctxt_lock

Christian Brauner (1):
      binfmt_misc: cleanup on filesystem umount

Christophe Kerello (1):
      memory: stm32-fmc2-ebi: check regmap_read return value

Chuck Lever (6):
      NFSD: Refactor nfsd_reply_cache_free_locked()
      NFSD: Rename nfsd_reply_cache_alloc()
      NFSD: Replace nfsd_prune_bucket()
      NFSD: Refactor the duplicate reply cache shrinker
      NFSD: Rewrite synopsis of nfsd_percpu_counters_init()
      NFSD: Fix frame size warning in svc_export_parse()

Claudio Imbrenda (1):
      s390/uv: Panic for set and remove shared access UVC errors

Cong Wang (1):
      gtp: fix a potential NULL pointer dereference

Cosmin Ratiu (1):
      net/mlx5e: Correctly report errors for ethtool rx flows

Dan Carpenter (3):
      atm: idt77252: prevent use after free in dequeue_rx()
      dpaa2-switch: Fix error checking in dpaa2_switch_seed_bp()
      mmc: mmc_test: Fix NULL dereference on allocation failure

Daniel Wagner (1):
      nvmet-trace: avoid dereferencing pointer too early

David Lechner (1):
      staging: iio: resolver: ad2s1210: fix use before initialization

David Sterba (5):
      btrfs: change BUG_ON to assertion when checking for delayed_node root
      btrfs: handle invalid root reference found in may_destroy_subvol()
      btrfs: send: handle unexpected data in header buffer in begin_cmd()
      btrfs: change BUG_ON to assertion in tree_move_down()
      btrfs: delete pointless BUG_ON check on quota root in btrfs_qgroup_account_extent()

David Thompson (1):
      mlxbf_gige: disable RX filters until RX path initialized

Dmitry Baryshkov (2):
      drm/msm/dpu: don't play tricks with debug macros
      drm/msm/dpu: cleanup FB if dpu_format_populate_layout fails

Donald Hunter (1):
      netfilter: flowtable: initialise extack before use

Eli Billauer (3):
      char: xillybus: Don't destroy workqueue from work item running on it
      char: xillybus: Refine workqueue handling
      char: xillybus: Check USB endpoints when probing device

Eric Dumazet (6):
      netlink: hold nlk->cb_mutex longer in __netlink_dump_start()
      gtp: pull network headers in gtp_dev_xmit()
      ipv6: prevent UAF in ip6_send_skb()
      ipv6: fix possible UAF in ip6_finish_output2()
      ipv6: prevent possible UAF in ip6_xmit()
      net: busy-poll: use ktime_get_ns() instead of local_clock()

Erico Nunes (1):
      drm/lima: set gp bus_stop bit before hard reset

Eugene Syromiatnikov (1):
      mptcp: correct MPTCP_SUBFLOW_ATTR_SSN_OFFSET reserved size

Faizal Rahim (3):
      igc: Fix packet still tx after gate close by reducing i226 MAC retry buffer
      igc: Fix reset adapter logics when tx mode change
      igc: Fix qbv tx latency by setting gtxoffset

Florian Westphal (1):
      netfilter: nf_queue: drop packets with cloned unconfirmed conntracks

Gergo Koteles (1):
      platform/x86: lg-laptop: fix %s null argument warning

Greg Kroah-Hartman (2):
      Revert "MIPS: Loongson64: reset: Prioritise firmware service"
      Linux 5.15.166

Griffin Kroah-Hartman (1):
      Bluetooth: MGMT: Add error handling to pair_device()

Guanrui Huang (1):
      irqchip/gic-v3-its: Remove BUG_ON in its_vpe_irq_domain_alloc

Guenter Roeck (1):
      apparmor: fix policy_unpack_test on big endian systems

Haibo Xu (1):
      arm64: ACPI: NUMA: initialize all values of acpi_early_node_map to NUMA_NO_NODE

Haiyang Zhang (1):
      net: mana: Fix race of mana_hwc_post_rx_wqe and new hwc response

Hannes Reinecke (1):
      nvmet-tcp: do not continue for invalid icreq

Hans J. Schultz (1):
      net: dsa: mv88e6xxx: read FID when handling ATU violations

Hans Verkuil (3):
      media: radio-isa: use dev_name to fill in bus_info
      media: qcom: venus: fix incorrect return value
      media: pci: cx23885: check cx23885_vdev_init() return

Heiko Carstens (1):
      s390/smp,mcck: fix early IPI handling

Helge Deller (1):
      parisc: Use irq_enter_rcu() to fix warning at kernel/context_tracking.c:367

Huang-Huang Bao (1):
      pinctrl: rockchip: correct RK3328 iomux width flag for GPIO2-B pins

Ian Ray (1):
      cdc-acm: Add DISABLE_ECHO quirk for GE HealthCare UI Controller

Jamie Bainbridge (1):
      ethtool: check device is present when getting link settings

Jan Kara (1):
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

Jeff Layton (2):
      nfsd: move reply cache initialization into nfsd startup
      nfsd: move init of percpu reply_cache_stats counters back to nfsd_init_net

Jesse Zhang (1):
      drm/amdgpu: Using uninitialized value *size when calling amdgpu_vce_cs_reloc

Jian Shen (1):
      net: hns3: add checking for vf id of mailbox

Jiaxun Yang (1):
      MIPS: Loongson64: Set timer mode in cpu-probe

Jie Wang (2):
      net: hns3: fix wrong use of semaphore up
      net: hns3: fix a deadlock problem when config TC during resetting

Johannes Berg (2):
      wifi: cfg80211: check wiphy mutex is held for wdev mutex
      wifi: mac80211: fix BA session teardown race

Josef Bacik (11):
      sunrpc: don't change ->sv_stats if it doesn't exist
      nfsd: stop setting ->pg_stats for unused stats
      sunrpc: pass in the sv_stats struct through svc_create_pooled
      sunrpc: remove ->pg_stats from svc_program
      sunrpc: use the struct net as the svc proc private
      nfsd: rename NFSD_NET_* to NFSD_STATS_*
      nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
      nfsd: make all of the nfsd stats per-network namespace
      nfsd: remove nfsd_stats, make th_cnt a global counter
      nfsd: make svc_stat per-network namespace instead of global
      btrfs: run delayed iputs when flushing delalloc

Joseph Huang (1):
      net: dsa: mv88e6xxx: Fix out-of-bound access

Juan José Arboleda (1):
      ALSA: usb-audio: Support Yamaha P-125 quirk entry

Justin Tee (1):
      scsi: lpfc: Initialize status local variable in lpfc_sli4_repost_sgl_list()

Kees Cook (2):
      net/sun3_82586: Avoid reading past buffer in debug output
      x86: Increase brk randomness entropy for 64-bit systems

Khazhismel Kumykov (1):
      dm resume: don't return EINVAL when signalled

Krishna Kurapati (1):
      usb: dwc3: core: Skip setting event buffers for host only controllers

Krzysztof Kozlowski (4):
      soundwire: stream: fix programming slave ports for non-continous port maps
      usb: dwc3: omap: add missing depopulate in probe error path
      usb: dwc3: st: fix probed platform device ref count on probe error path
      usb: dwc3: st: add missing depopulate in probe error path

Kuniyuki Iwashima (1):
      kcm: Serialise kcm_sendmsg() for the same socket.

Kunwu Chan (1):
      powerpc/xics: Check return value of kasprintf in icp_native_map_one_cpu

Lee, Chun-Yi (1):
      Bluetooth: hci_ldisc: check HCI_UART_PROTO_READY flag in HCIUARTGETPROTO

Li Nan (1):
      md: clean up invalid BUG_ON in md_ioctl

Li zeming (1):
      powerpc/boot: Handle allocation failure in simple_realloc()

Lianqin Hu (1):
      ALSA: usb-audio: Add delay quirk for VIVO USB-C-XE710 HEADSET

Long Li (1):
      net: mana: Fix doorbell out of order violation and avoid unnecessary doorbell rings

Luiz Augusto von Dentz (3):
      Bluetooth: bnep: Fix out-of-bound access
      Bluetooth: hci_core: Fix LE quote calculation
      Bluetooth: SMP: Fix assumption of Central always being Initiator

Ma Ke (1):
      pinctrl: single: fix potential NULL dereference in pcs_get_function()

Maciej Fijalkowski (1):
      ice: fix ICE_LAST_OFFSET formula

Marc Zyngier (1):
      KVM: arm64: Make ICC_*SGI*_EL1 undef in the absence of a vGICv3

Martin Blumenstingl (1):
      clocksource/drivers/arm_global_timer: Guard against division by zero

Mathias Nyman (1):
      xhci: Fix Panther point NULL pointer deref at full-speed re-enumeration

Matthieu Baerts (NGI0) (1):
      mptcp: sched: check both backup in retrans

Max Filippov (1):
      fs: binfmt_elf_efpic: don't use missing interpreter's properties

Maximilian Luz (1):
      platform/surface: aggregator: Fix warning when controller is destroyed in probe

Michael Ellerman (1):
      powerpc/boot: Only free if realloc() succeeds

Mika Westerberg (1):
      thunderbolt: Mark XDomain as unplugged when router is removed

Mike Christie (1):
      scsi: spi: Fix sshdr use

Mikulas Patocka (2):
      dm persistent data: fix memory allocation failure
      dm suspend: return -ERESTARTSYS instead of -EINTR

Miri Korenblit (1):
      wifi: iwlwifi: abort scan when rfkill on but device enabled

Muhammad Husaini Zulkifli (2):
      igc: Correct the launchtime offset
      igc: remove I226 Qbv BaseTime restriction

Mukesh Sisodiya (1):
      wifi: iwlwifi: fw: Fix debugfs command sending

NeilBrown (1):
      NFS: avoid infinite loop in pnfs_update_layout.

Niklas Cassel (1):
      ata: libata-core: Fix null pointer dereference on error

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

Parsa Poorshikhian (1):
      ALSA: hda/realtek: Fix noise from speakers on Lenovo IdeaPad 3 15IAU7

Paul Cercueil (3):
      PM: core: Remove DEFINE_UNIVERSAL_DEV_PM_OPS() macro
      PM: core: Add EXPORT[_GPL]_SIMPLE_DEV_PM_OPS macros
      PM: runtime: Add DEFINE_RUNTIME_DEV_PM_OPS() macro

Pawel Dembicki (3):
      net: dsa: vsc73xx: pass value in phy_write operation
      net: dsa: vsc73xx: use read_poll_timeout instead delay loop
      net: dsa: vsc73xx: check busy flag in MDIO operations

Pawel Laszczak (2):
      usb: cdnsp: fix incorrect index in cdnsp_get_hw_deq function
      usb: cdnsp: fix for Link TRB with TC

Phil Chang (1):
      hrtimer: Prevent queuing of hrtimer without a function callback

Philipp Stanner (1):
      media: drivers/media/dvb-core: copy user arrays safely

Piyush Mehta (3):
      phy: xilinx: add runtime PM support
      phy: xilinx: phy-zynqmp: dynamic clock support for power-save
      phy: xilinx: phy-zynqmp: Fix SGMII linkup failure on resume

Qu Wenruo (1):
      btrfs: tree-checker: add dev extent item checks

Radhey Shyam Pandey (1):
      net: axienet: Fix register defines comment description

Rand Deeb (1):
      ssb: Fix division by zero issue in ssb_calc_clock_rate

Sagi Grimberg (1):
      nvmet-rdma: fix possible bad dereference when freeing rsps

Samuel Holland (1):
      arm64: Fix KASAN random tag seed initialization

Sascha Hauer (1):
      wifi: mwifiex: duplicate static structs used in driver instances

Sean Anderson (3):
      net: xilinx: axienet: Always disable promiscuous mode
      net: xilinx: axienet: Fix dangling multicast addresses
      phy: zynqmp: Enable reference clock correctly

Sebastian Andrzej Siewior (2):
      netfilter: nft_counter: Disable BH in nft_counter_offload_stats().
      netfilter: nft_counter: Synchronize nft_counter_reset() against reader.

Selvarasu Ganesan (1):
      usb: dwc3: core: Prevent USB core invalid event buffer address access

Serge Semin (2):
      dmaengine: dw: Add peripheral bus width verification
      dmaengine: dw: Add memory bus width verification

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

Takashi Iwai (1):
      ALSA: timer: Relax start tick time check for slave timer elements

Tetsuo Handa (2):
      block: use "unsigned long" for blk_validate_block_size().
      Input: MT - limit max slots

Thomas Bogendoerfer (1):
      ip6_tunnel: Fix broken GRO

Tom Hughes (1):
      netfilter: allow ipv6 fragments to arrive on different devices

Uwe Kleine-König (1):
      usb: gadget: fsl: Increase size of name buffer for endpoints

Vladimir Oltean (1):
      net: dsa: mv88e6xxx: replace ATU violation prints with trace points

Volodymyr Babchuk (1):
      soc: qcom: cmd-db: Map shared memory as WC, not WB

Wolfram Sang (1):
      i2c: riic: avoid potential division by zero

Yue Haibing (1):
      mlxbf_gige: Remove two unused function declarations

ZHANG Yuntian (1):
      USB: serial: option: add MeiG Smart SRM825L

Zhen Lei (1):
      selinux: fix potential counting error in avc_add_xperms_decision()

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
      usb: core: sysfs: Unmerge @usb3_hardware_lpm_attr_group in remove_power_attributes()


