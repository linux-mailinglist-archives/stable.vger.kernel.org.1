Return-Path: <stable+bounces-73032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EDD96BB00
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A821C24599
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8124B1D1F64;
	Wed,  4 Sep 2024 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XV24zkm3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390651D0976;
	Wed,  4 Sep 2024 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725450103; cv=none; b=rwmsW459arYGKWMZ8A4mZ6QwYku8FNWc/m0g9WeBfG8J0389MpkQhd1ZsQlUG5Of20lBzm8ix5Kntd28cxo6fXhhoclbZUAlFxB8hXOgX1WhcW9vp0b740pMw994Wnx3DMmBkfBPaQjp6iilRzGaQmULANkS39QMjmaG4bNEH0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725450103; c=relaxed/simple;
	bh=WgtwGPDGa2dS34jaLdo0kGXn8JvdEzNALBSuxcnbrkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EpD1AoHV1GMtMOfqun1XdsNNWekuFYunnX0o0WPqrqFtW8HCqYG5rH1fuQaIlEsrkakTlQ8c9uUuCUe5LnKmK8W4NRPBrpxOcL6DAytwFwNVYt6OvrNKxsoZ82xilZPBmzzNxXoByK6iqNgV0Vu8CkZGiURx0I82kRvKNSmq4FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XV24zkm3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A214C4CEC6;
	Wed,  4 Sep 2024 11:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725450102;
	bh=WgtwGPDGa2dS34jaLdo0kGXn8JvdEzNALBSuxcnbrkw=;
	h=From:To:Cc:Subject:Date:From;
	b=XV24zkm3753rAababLVGYvB2vvbXvbbulj9dp8M3isKpic1Rt1yU5hFZcbwXVhdQM
	 qqjViEXiKyQ6qGPy7QDsAFW3C5CaDhk6jWDv3/3p6QfA7bWRrVgtVMlbAcWJMnT8rN
	 aPZJ58XSsxspUKowOL4KId4zrUku0+Qj9IaqX+ww=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.283
Date: Wed,  4 Sep 2024 13:41:33 +0200
Message-ID: <2024090434-majesty-during-0c9d@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.283 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/process/deprecated.rst                    |   20 
 Makefile                                                |    2 
 arch/arm64/kernel/acpi_numa.c                           |    2 
 arch/openrisc/kernel/setup.c                            |    6 
 arch/parisc/kernel/irq.c                                |    4 
 arch/powerpc/boot/simple_alloc.c                        |    7 
 arch/powerpc/sysdev/xics/icp-native.c                   |    2 
 arch/s390/include/asm/uv.h                              |    5 
 arch/x86/kernel/process.c                               |    5 
 drivers/ata/libata-core.c                               |    3 
 drivers/atm/idt77252.c                                  |    9 
 drivers/bluetooth/hci_ldisc.c                           |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c                 |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c                 |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                |    5 
 drivers/gpu/drm/lima/lima_gp.c                          |   12 
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h                 |   14 
 drivers/hid/hid-ids.h                                   |   10 
 drivers/hid/hid-microsoft.c                             |   11 
 drivers/hid/wacom_wac.c                                 |    4 
 drivers/i2c/busses/i2c-riic.c                           |    2 
 drivers/infiniband/hw/hfi1/chip.c                       |    5 
 drivers/input/input-mt.c                                |    3 
 drivers/irqchip/irq-gic-v3-its.c                        |    2 
 drivers/md/dm-clone-metadata.c                          |    5 
 drivers/md/dm-ioctl.c                                   |   22 -
 drivers/md/dm-mpath.c                                   |    9 
 drivers/md/dm-path-selector.h                           |    2 
 drivers/md/dm-queue-length.c                            |    2 
 drivers/md/dm-rq.c                                      |    4 
 drivers/md/dm-service-time.c                            |    2 
 drivers/md/dm.c                                         |   67 ++-
 drivers/md/md.c                                         |    5 
 drivers/md/persistent-data/dm-space-map-metadata.c      |    4 
 drivers/media/pci/cx23885/cx23885-video.c               |    8 
 drivers/media/pci/solo6x10/solo6x10-offsets.h           |   10 
 drivers/media/radio/radio-isa.c                         |    2 
 drivers/media/usb/uvc/uvc_video.c                       |   10 
 drivers/mmc/core/mmc_test.c                             |    9 
 drivers/mmc/host/dw_mmc.c                               |    8 
 drivers/net/dsa/mv88e6xxx/Makefile                      |    4 
 drivers/net/dsa/mv88e6xxx/global1.h                     |    1 
 drivers/net/dsa/mv88e6xxx/global1_atu.c                 |   87 +++-
 drivers/net/dsa/mv88e6xxx/global2.c                     |   13 
 drivers/net/dsa/mv88e6xxx/global2.h                     |   25 +
 drivers/net/dsa/mv88e6xxx/trace.c                       |    6 
 drivers/net/dsa/mv88e6xxx/trace.h                       |   66 +++
 drivers/net/dsa/vitesse-vsc73xx-core.c                  |    2 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c       |    3 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c         |    3 
 drivers/net/ethernet/i825xx/sun3_82586.c                |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c |    2 
 drivers/net/ethernet/xilinx/xilinx_axienet.h            |   34 -
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c       |  337 +++++++++++-----
 drivers/net/gtp.c                                       |    5 
 drivers/net/usb/r8152.c                                 |   73 ---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c           |    2 
 drivers/net/wireless/marvell/mwifiex/cfg80211.c         |   32 +
 drivers/net/wireless/st/cw1200/txrx.c                   |    2 
 drivers/nfc/pn533/pn533.c                               |  210 +++++++++
 drivers/nfc/pn533/pn533.h                               |   19 
 drivers/nvme/host/core.c                                |    5 
 drivers/nvme/target/rdma.c                              |   16 
 drivers/nvme/target/tcp.c                               |    1 
 drivers/nvme/target/trace.c                             |    6 
 drivers/nvme/target/trace.h                             |   28 -
 drivers/pinctrl/pinctrl-single.c                        |    2 
 drivers/s390/block/dasd.c                               |   36 +
 drivers/s390/block/dasd_3990_erp.c                      |   10 
 drivers/s390/block/dasd_eckd.c                          |   55 +-
 drivers/s390/block/dasd_int.h                           |    2 
 drivers/s390/cio/idset.c                                |   12 
 drivers/scsi/aacraid/comminit.c                         |    2 
 drivers/scsi/lpfc/lpfc_sli.c                            |    2 
 drivers/scsi/scsi_transport_spi.c                       |    4 
 drivers/soc/qcom/cmd-db.c                               |    2 
 drivers/soundwire/stream.c                              |    8 
 drivers/ssb/main.c                                      |    2 
 drivers/staging/ks7010/ks7010_sdio.c                    |    4 
 drivers/usb/class/cdc-acm.c                             |    3 
 drivers/usb/core/sysfs.c                                |    1 
 drivers/usb/dwc3/core.c                                 |   21 
 drivers/usb/dwc3/dwc3-omap.c                            |    4 
 drivers/usb/dwc3/dwc3-st.c                              |   16 
 drivers/usb/gadget/udc/fsl_udc_core.c                   |    2 
 drivers/usb/host/xhci.c                                 |    8 
 drivers/usb/serial/option.c                             |    5 
 fs/binfmt_elf_fdpic.c                                   |    2 
 fs/binfmt_misc.c                                        |  216 +++++++---
 fs/btrfs/delayed-inode.c                                |    2 
 fs/btrfs/free-space-cache.c                             |    8 
 fs/btrfs/inode.c                                        |    9 
 fs/btrfs/qgroup.c                                       |    2 
 fs/btrfs/send.c                                         |    7 
 fs/ext4/extents.c                                       |    3 
 fs/ext4/mballoc.c                                       |    3 
 fs/f2fs/segment.c                                       |    5 
 fs/file.c                                               |   30 -
 fs/fuse/dev.c                                           |    6 
 fs/fuse/virtio_fs.c                                     |   10 
 fs/gfs2/inode.c                                         |    2 
 fs/inode.c                                              |   39 +
 fs/locks.c                                              |    4 
 fs/nfs/pnfs.c                                           |    8 
 fs/quota/dquot.c                                        |    5 
 include/linux/bitmap.h                                  |   20 
 include/linux/blkdev.h                                  |    2 
 include/linux/cpumask.h                                 |    2 
 include/linux/device-mapper.h                           |    2 
 include/linux/fs.h                                      |    5 
 include/linux/overflow.h                                |  115 +++--
 include/net/busy_poll.h                                 |    2 
 include/net/kcm.h                                       |    1 
 ipc/util.c                                              |   16 
 kernel/cgroup/cpuset.c                                  |   13 
 kernel/time/hrtimer.c                                   |    2 
 lib/math/prime_numbers.c                                |    2 
 lib/test_overflow.c                                     |   98 ++++
 mm/memcontrol.c                                         |    7 
 net/bluetooth/bnep/core.c                               |    3 
 net/bluetooth/hci_core.c                                |   58 +-
 net/bluetooth/mgmt.c                                    |    4 
 net/core/ethtool.c                                      |    3 
 net/core/net-sysfs.c                                    |    2 
 net/ipv6/ip6_output.c                                   |    2 
 net/iucv/iucv.c                                         |    3 
 net/kcm/kcmsock.c                                       |    4 
 net/netfilter/nft_counter.c                             |    5 
 net/rds/recv.c                                          |   13 
 net/sched/sch_netem.c                                   |   47 +-
 security/selinux/avc.c                                  |    2 
 sound/core/timer.c                                      |    2 
 sound/pci/hda/patch_realtek.c                           |    1 
 sound/usb/quirks-table.h                                |    1 
 tools/include/linux/align.h                             |   12 
 tools/include/linux/bitmap.h                            |    8 
 tools/testing/selftests/tc-testing/tdc.py               |    1 
 137 files changed, 1699 insertions(+), 621 deletions(-)

Al Viro (2):
      fix bitmap corruption on close_range() with CLOSE_RANGE_UNSHARE
      memcg_write_event_control(): fix a user-triggerable oops

Aleksandr Mishin (1):
      nfc: pn533: Add poll mod list filling check

Alex Deucher (1):
      drm/amdkfd: don't allow mapping the MMIO HDP page with large pages

Alexander Gordeev (1):
      s390/iucv: fix receive buffer virtual vs physical address confusion

Alexander Lobakin (4):
      bitmap: introduce generic optimized bitmap_size()
      s390/cio: rename bitmap_size() -> idset_bitmap_size()
      btrfs: rename bitmap_set_bits() -> btrfs_bitmap_set_bits()
      tools: move alignment-related macros to new <linux/align.h>

Allison Henderson (1):
      net:rds: Fix possible deadlock in rds_message_put

Andre Przywara (8):
      net: axienet: Fix DMA descriptor cleanup path
      net: axienet: Improve DMA error handling
      net: axienet: Factor out TX descriptor chain cleanup
      net: axienet: Check for DMA mapping errors
      net: axienet: Drop MDIO interrupt registers from ethtools dump
      net: axienet: Wrap DMA pointer writes to prepare for 64 bit
      net: axienet: Upgrade descriptors to hold 64-bit addresses
      net: axienet: Autodetect 64-bit DMA capability

Andreas Gruenbacher (1):
      gfs2: setattr_chown: Add missing initialization

Andrew Lunn (3):
      net: dsa: mv88e6xxx: global2: Expose ATU stats register
      net: dsa: mv88e6xxx: global1_atu: Add helper for get next
      net: dsa: mv8e6xxx: Fix stub function parameters

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

Chen Ridong (1):
      cgroup/cpuset: Prevent UAF in proc_cpuset_show()

Chengfeng Ye (2):
      staging: ks7010: disable bh on tx_dev_lock
      IB/hfi1: Fix potential deadlock on &irq_src_lock and &dd->uctxt_lock

Christian Brauner (1):
      binfmt_misc: cleanup on filesystem umount

Claudio Imbrenda (1):
      s390/uv: Panic for set and remove shared access UVC errors

Cong Wang (1):
      gtp: fix a potential NULL pointer dereference

Cosmin Ratiu (1):
      net/mlx5e: Correctly report errors for ethtool rx flows

Dan Carpenter (2):
      atm: idt77252: prevent use after free in dequeue_rx()
      mmc: mmc_test: Fix NULL dereference on allocation failure

Daniel Wagner (1):
      nvmet-trace: avoid dereferencing pointer too early

David Sterba (4):
      btrfs: change BUG_ON to assertion when checking for delayed_node root
      btrfs: handle invalid root reference found in may_destroy_subvol()
      btrfs: send: handle unexpected data in header buffer in begin_cmd()
      btrfs: delete pointless BUG_ON check on quota root in btrfs_qgroup_account_extent()

Dmitry Baryshkov (1):
      drm/msm/dpu: don't play tricks with debug macros

Eric Dumazet (3):
      gtp: pull network headers in gtp_dev_xmit()
      ipv6: prevent UAF in ip6_send_skb()
      net: busy-poll: use ktime_get_ns() instead of local_clock()

Erico Nunes (1):
      drm/lima: set gp bus_stop bit before hard reset

Gabriel Krisman Bertazi (1):
      dm mpath: pass IO start time to path selector

Greg Kroah-Hartman (1):
      Linux 5.4.283

Griffin Kroah-Hartman (1):
      Bluetooth: MGMT: Add error handling to pair_device()

Guanrui Huang (1):
      irqchip/gic-v3-its: Remove BUG_ON in its_vpe_irq_domain_alloc

Gustavo A. R. Silva (1):
      overflow.h: Add flex_array_size() helper

Haibo Xu (1):
      arm64: ACPI: NUMA: initialize all values of acpi_early_node_map to NUMA_NO_NODE

Hannes Reinecke (1):
      nvmet-tcp: do not continue for invalid icreq

Hans J. Schultz (1):
      net: dsa: mv88e6xxx: read FID when handling ATU violations

Hans Verkuil (2):
      media: radio-isa: use dev_name to fill in bus_info
      media: pci: cx23885: check cx23885_vdev_init() return

Helge Deller (1):
      parisc: Use irq_enter_rcu() to fix warning at kernel/context_tracking.c:367

Ian Ray (1):
      cdc-acm: Add DISABLE_ECHO quirk for GE HealthCare UI Controller

Jamie Bainbridge (1):
      ethtool: check device is present when getting link settings

Jan Kara (1):
      quota: Remove BUG_ON from dqget()

Jani Nikula (1):
      drm/msm: use drm_debug_enabled() to check for debug categories

Jann Horn (1):
      fuse: Initialize beyond-EOF page contents before setting uptodate

Jason Gerecke (1):
      HID: wacom: Defer calculation of resolution until resolution_code is known

Jeff Johnson (1):
      wifi: cw1200: Avoid processing an invalid TIM IE

Jesse Zhang (1):
      drm/amdgpu: Using uninitialized value *size when calling amdgpu_vce_cs_reloc

Jie Wang (1):
      net: hns3: fix a deadlock problem when config TC during resetting

Joseph Huang (1):
      net: dsa: mv88e6xxx: Fix out-of-bound access

Juan José Arboleda (1):
      ALSA: usb-audio: Support Yamaha P-125 quirk entry

Justin Tee (1):
      scsi: lpfc: Initialize status local variable in lpfc_sli4_repost_sgl_list()

Kees Cook (3):
      overflow: Implement size_t saturating arithmetic helpers
      net/sun3_82586: Avoid reading past buffer in debug output
      x86: Increase brk randomness entropy for 64-bit systems

Keith Busch (1):
      nvme: clear caller pointer on identify failure

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

Lars Poeschel (2):
      nfc: pn533: Add dev_up/dev_down hooks to phy_ops
      nfc: pn533: Add autopoll capability

Lee, Chun-Yi (1):
      Bluetooth: hci_ldisc: check HCI_UART_PROTO_READY flag in HCIUARTGETPROTO

Li Nan (1):
      md: clean up invalid BUG_ON in md_ioctl

Li zeming (1):
      powerpc/boot: Handle allocation failure in simple_realloc()

Long Li (1):
      filelock: Correct the filelock owner in fcntl_setlk/fcntl_setlk64

Luiz Augusto von Dentz (4):
      Bluetooth: bnep: Fix out-of-bound access
      Bluetooth: Make use of __check_timeout on hci_sched_le
      Bluetooth: hci_core: Fix not handling link timeouts propertly
      Bluetooth: hci_core: Fix LE quote calculation

Ma Ke (1):
      pinctrl: single: fix potential NULL dereference in pcs_get_function()

Mathias Nyman (1):
      xhci: Fix Panther point NULL pointer deref at full-speed re-enumeration

Max Filippov (1):
      fs: binfmt_elf_efpic: don't use missing interpreter's properties

Michael Ellerman (1):
      powerpc/boot: Only free if realloc() succeeds

Mike Christie (1):
      scsi: spi: Fix sshdr use

Mikulas Patocka (2):
      dm persistent data: fix memory allocation failure
      dm suspend: return -ERESTARTSYS instead of -EINTR

Ming Lei (1):
      dm: do not use waitqueue for request-based DM

Miri Korenblit (1):
      wifi: iwlwifi: abort scan when rfkill on but device enabled

NeilBrown (1):
      NFS: avoid infinite loop in pnfs_update_layout.

Niklas Cassel (1):
      ata: libata-core: Fix null pointer dereference on error

Nikolay Kuratov (1):
      cxgb4: add forgotten u64 ivlan cast before shift

Oreoluwa Babatunde (1):
      openrisc: Call setup_memory() earlier in the init sequence

Parsa Poorshikhian (1):
      ALSA: hda/realtek: Fix noise from speakers on Lenovo IdeaPad 3 15IAU7

Pawel Dembicki (1):
      net: dsa: vsc73xx: pass value in phy_write operation

Phil Chang (1):
      hrtimer: Prevent queuing of hrtimer without a function callback

Prashant Malani (1):
      r8152: Factor out OOB link list waits

Radhey Shyam Pandey (1):
      net: axienet: Fix register defines comment description

Rafael Aquini (1):
      ipc: replace costly bailout check in sysvipc_find_ipc()

Rand Deeb (1):
      ssb: Fix division by zero issue in ssb_calc_clock_rate

Ricardo Ribalda (1):
      media: uvcvideo: Fix integer overflow calculating timestamp

Sagi Grimberg (1):
      nvmet-rdma: fix possible bad dereference when freeing rsps

Sascha Hauer (1):
      wifi: mwifiex: duplicate static structs used in driver instances

Sean Anderson (2):
      net: xilinx: axienet: Always disable promiscuous mode
      net: xilinx: axienet: Fix dangling multicast addresses

Sebastian Andrzej Siewior (1):
      netfilter: nft_counter: Synchronize nft_counter_reset() against reader.

Selvarasu Ganesan (1):
      usb: dwc3: core: Prevent USB core invalid event buffer address access

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

Uwe Kleine-König (1):
      usb: gadget: fsl: Increase size of name buffer for endpoints

Vladimir Oltean (1):
      net: dsa: mv88e6xxx: replace ATU violation prints with trace points

Volodymyr Babchuk (1):
      soc: qcom: cmd-db: Map shared memory as WC, not WB

Wolfram Sang (1):
      i2c: riic: avoid potential division by zero

ZHANG Yuntian (1):
      USB: serial: option: add MeiG Smart SRM825L

Zhen Lei (1):
      selinux: fix potential counting error in avc_add_xperms_decision()

Zhiguo Niu (1):
      f2fs: fix to do sanity check in update_sit_entry

Zhihao Cheng (1):
      vfs: Don't evict inode under the inode lru traversing context

Zijun Hu (1):
      usb: core: sysfs: Unmerge @usb3_hardware_lpm_attr_group in remove_power_attributes()


