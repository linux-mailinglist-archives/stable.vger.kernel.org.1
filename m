Return-Path: <stable+bounces-73030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7DF96BAFF
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4878B26A18
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F1D1D0496;
	Wed,  4 Sep 2024 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BxFf+92S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF3F1D0173;
	Wed,  4 Sep 2024 11:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725450092; cv=none; b=GuNQQR4wk0Z9S8lSLPuPqxqBQ7Dl9rdK6d0V95TvOvcWXciDJ51x156rIG5DjomFVgji6cGEwdEvy043s/vmAuFmdrl2D2fQWQT8vC+oxCHjCV5Y3NpA+oFYXXItpkAtqavDitzJKRG0bkeIqsizYPNqeia5IeBEUKTswjaSSEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725450092; c=relaxed/simple;
	bh=5pQADllX5iSsmBV+D+KVXwL5x2iww7s39oFp0o7EaZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jzb1rrq0iCjnsakDmvPDUU2frG2GRUtZQKR9hviXuqT/LhsX27i4whGmd6izGDaywLgH2E6Sa3S3JOIuacIGtGH48N0VMg1D9mlxK2jfx4E2doXNzAGSK6ILzZsoWSLMngxalzGoyConO3D/9StwKehAtR17I5QKABE3K+iHcrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BxFf+92S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5C0C4CEC6;
	Wed,  4 Sep 2024 11:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725450092;
	bh=5pQADllX5iSsmBV+D+KVXwL5x2iww7s39oFp0o7EaZg=;
	h=From:To:Cc:Subject:Date:From;
	b=BxFf+92St3ZRvlW+xL7Kiu6J8JukHyP4PMyAfl5FmmAzeVhdOizjJwD6UMWMYhmhj
	 P+YbK4+/lSNPDJOPJ5q276ynNwD8J0i4UUiB+UklJG+B+PrFrlXEJBm+GrJz067las
	 aMw7ph2+ssm0qxore0uMhy5jFlhSbzIPnvYpaG6w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.321
Date: Wed,  4 Sep 2024 13:41:27 +0200
Message-ID: <2024090427-frisbee-album-e019@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 4.19.321 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                |    2 
 arch/arm64/kernel/acpi_numa.c                           |    2 
 arch/openrisc/kernel/setup.c                            |    6 
 arch/parisc/kernel/irq.c                                |    4 
 arch/powerpc/boot/simple_alloc.c                        |    7 
 arch/powerpc/sysdev/xics/icp-native.c                   |    2 
 drivers/ata/libata-core.c                               |    3 
 drivers/atm/idt77252.c                                  |    9 
 drivers/bluetooth/hci_ldisc.c                           |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c                 |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c                 |    3 
 drivers/gpu/drm/drm_fb_helper.c                         |    3 
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h                 |   14 -
 drivers/hid/wacom_wac.c                                 |    4 
 drivers/i2c/busses/i2c-riic.c                           |    2 
 drivers/input/input-mt.c                                |    3 
 drivers/irqchip/irq-gic-v3-its.c                        |    2 
 drivers/md/dm-ioctl.c                                   |   22 +
 drivers/md/dm.c                                         |    2 
 drivers/md/md.c                                         |    5 
 drivers/md/persistent-data/dm-space-map-metadata.c      |    4 
 drivers/media/pci/cx23885/cx23885-video.c               |    8 
 drivers/media/usb/uvc/uvc_video.c                       |   10 
 drivers/mmc/core/mmc_test.c                             |    9 
 drivers/mmc/host/dw_mmc.c                               |    8 
 drivers/net/dsa/vitesse-vsc73xx.c                       |    2 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c       |    3 
 drivers/net/ethernet/i825xx/sun3_82586.c                |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c |    2 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c       |    4 
 drivers/net/gtp.c                                       |    5 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c           |    2 
 drivers/net/wireless/marvell/mwifiex/cfg80211.c         |   32 +-
 drivers/net/wireless/st/cw1200/txrx.c                   |    2 
 drivers/nvme/target/rdma.c                              |   16 -
 drivers/pinctrl/pinctrl-single.c                        |    2 
 drivers/s390/cio/idset.c                                |   12 
 drivers/scsi/aacraid/comminit.c                         |    2 
 drivers/scsi/lpfc/lpfc_sli.c                            |    2 
 drivers/scsi/mpt3sas/mpt3sas_base.c                     |   20 +
 drivers/scsi/scsi_transport_spi.c                       |    4 
 drivers/soundwire/stream.c                              |    8 
 drivers/ssb/main.c                                      |    2 
 drivers/staging/ks7010/ks7010_sdio.c                    |    4 
 drivers/usb/class/cdc-acm.c                             |    3 
 drivers/usb/core/sysfs.c                                |    1 
 drivers/usb/dwc3/core.c                                 |   21 +
 drivers/usb/dwc3/dwc3-omap.c                            |    4 
 drivers/usb/dwc3/dwc3-st.c                              |   11 
 drivers/usb/gadget/udc/fsl_udc_core.c                   |    2 
 drivers/usb/host/xhci.c                                 |    8 
 drivers/usb/serial/option.c                             |    5 
 drivers/video/fbdev/core/fbcon.c                        |   28 ++
 drivers/video/fbdev/core/fbmem.c                        |   20 +
 fs/binfmt_elf_fdpic.c                                   |    2 
 fs/binfmt_misc.c                                        |  216 ++++++++++++----
 fs/btrfs/delayed-inode.c                                |    2 
 fs/btrfs/free-space-cache.c                             |    8 
 fs/btrfs/inode.c                                        |    9 
 fs/btrfs/qgroup.c                                       |    2 
 fs/btrfs/send.c                                         |    7 
 fs/ext4/extents.c                                       |    3 
 fs/ext4/mballoc.c                                       |    3 
 fs/f2fs/segment.c                                       |    5 
 fs/file.c                                               |   30 --
 fs/fuse/dev.c                                           |    6 
 fs/gfs2/inode.c                                         |    2 
 fs/locks.c                                              |    4 
 fs/nfs/pnfs.c                                           |    8 
 fs/quota/dquot.c                                        |    5 
 include/linux/bitmap.h                                  |   20 +
 include/linux/blkdev.h                                  |    2 
 include/linux/cpumask.h                                 |    2 
 include/linux/fbcon.h                                   |    4 
 include/linux/overflow.h                                |  113 ++++++--
 include/net/busy_poll.h                                 |    2 
 include/net/kcm.h                                       |    1 
 ipc/msg.c                                               |    2 
 ipc/sem.c                                               |    7 
 ipc/shm.c                                               |    2 
 kernel/cgroup/cpuset.c                                  |   13 
 kernel/time/hrtimer.c                                   |    2 
 lib/idr.c                                               |    2 
 lib/test_ida.c                                          |   40 ++
 lib/test_overflow.c                                     |   98 +++++++
 mm/memcontrol.c                                         |    7 
 net/bluetooth/bnep/core.c                               |    3 
 net/bluetooth/hci_core.c                                |   58 ++--
 net/bluetooth/mgmt.c                                    |    4 
 net/core/skbuff.c                                       |    3 
 net/ipv6/ip6_output.c                                   |    2 
 net/iucv/iucv.c                                         |    3 
 net/kcm/kcmsock.c                                       |    4 
 net/netfilter/nft_counter.c                             |    5 
 net/rds/recv.c                                          |   13 
 security/selinux/avc.c                                  |    2 
 sound/core/timer.c                                      |    2 
 sound/usb/quirks-table.h                                |    1 
 tools/include/linux/align.h                             |   12 
 tools/include/linux/bitmap.h                            |    8 
 100 files changed, 840 insertions(+), 283 deletions(-)

Al Viro (2):
      fix bitmap corruption on close_range() with CLOSE_RANGE_UNSHARE
      memcg_write_event_control(): fix a user-triggerable oops

Alexander Gordeev (1):
      s390/iucv: fix receive buffer virtual vs physical address confusion

Alexander Lobakin (4):
      bitmap: introduce generic optimized bitmap_size()
      s390/cio: rename bitmap_size() -> idset_bitmap_size()
      btrfs: rename bitmap_set_bits() -> btrfs_bitmap_set_bits()
      tools: move alignment-related macros to new <linux/align.h>

Allison Henderson (1):
      net:rds: Fix possible deadlock in rds_message_put

Andreas Gruenbacher (1):
      gfs2: setattr_chown: Add missing initialization

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

Chengfeng Ye (1):
      staging: ks7010: disable bh on tx_dev_lock

Christian Brauner (1):
      binfmt_misc: cleanup on filesystem umount

Cong Wang (1):
      gtp: fix a potential NULL pointer dereference

Cosmin Ratiu (1):
      net/mlx5e: Correctly report errors for ethtool rx flows

Damien Le Moal (1):
      scsi: mpt3sas: Avoid IOMMU page faults on REPORT ZONES

Dan Carpenter (2):
      atm: idt77252: prevent use after free in dequeue_rx()
      mmc: mmc_test: Fix NULL dereference on allocation failure

Daniel Vetter (1):
      drm/fb-helper: set x/yres_virtual in drm_fb_helper_check_var

David Sterba (4):
      btrfs: change BUG_ON to assertion when checking for delayed_node root
      btrfs: handle invalid root reference found in may_destroy_subvol()
      btrfs: send: handle unexpected data in header buffer in begin_cmd()
      btrfs: delete pointless BUG_ON check on quota root in btrfs_qgroup_account_extent()

Dmitry Baryshkov (1):
      drm/msm/dpu: don't play tricks with debug macros

Eric Dumazet (4):
      gtp: pull network headers in gtp_dev_xmit()
      ipv6: prevent UAF in ip6_send_skb()
      net: prevent mss overflow in skb_segment()
      net: busy-poll: use ktime_get_ns() instead of local_clock()

Greg Kroah-Hartman (1):
      Linux 4.19.321

Griffin Kroah-Hartman (1):
      Bluetooth: MGMT: Add error handling to pair_device()

Guanrui Huang (1):
      irqchip/gic-v3-its: Remove BUG_ON in its_vpe_irq_domain_alloc

Gustavo A. R. Silva (1):
      overflow.h: Add flex_array_size() helper

Haibo Xu (1):
      arm64: ACPI: NUMA: initialize all values of acpi_early_node_map to NUMA_NO_NODE

Hans Verkuil (1):
      media: pci: cx23885: check cx23885_vdev_init() return

Helge Deller (3):
      parisc: Use irq_enter_rcu() to fix warning at kernel/context_tracking.c:367
      fbcon: Prevent that screen size is smaller than font size
      fbmem: Check virtual screen sizes in fb_set_var()

Ian Ray (1):
      cdc-acm: Add DISABLE_ECHO quirk for GE HealthCare UI Controller

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

Juan José Arboleda (1):
      ALSA: usb-audio: Support Yamaha P-125 quirk entry

Justin Tee (1):
      scsi: lpfc: Initialize status local variable in lpfc_sli4_repost_sgl_list()

Kees Cook (2):
      overflow: Implement size_t saturating arithmetic helpers
      net/sun3_82586: Avoid reading past buffer in debug output

Khazhismel Kumykov (1):
      dm resume: don't return EINVAL when signalled

Krishna Kurapati (1):
      usb: dwc3: core: Skip setting event buffers for host only controllers

Krzysztof Kozlowski (3):
      soundwire: stream: fix programming slave ports for non-continous port maps
      usb: dwc3: omap: add missing depopulate in probe error path
      usb: dwc3: st: fix probed platform device ref count on probe error path

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

Matthew Wilcox (Oracle) (1):
      ida: Fix crash in ida_free when the bitmap is empty

Max Filippov (1):
      fs: binfmt_elf_efpic: don't use missing interpreter's properties

Michael Ellerman (1):
      powerpc/boot: Only free if realloc() succeeds

Mike Christie (1):
      scsi: spi: Fix sshdr use

Mikulas Patocka (2):
      dm persistent data: fix memory allocation failure
      dm suspend: return -ERESTARTSYS instead of -EINTR

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

Pawel Dembicki (1):
      net: dsa: vsc73xx: pass value in phy_write operation

Phil Chang (1):
      hrtimer: Prevent queuing of hrtimer without a function callback

Rand Deeb (1):
      ssb: Fix division by zero issue in ssb_calc_clock_rate

Ricardo Ribalda (1):
      media: uvcvideo: Fix integer overflow calculating timestamp

Sagi Grimberg (1):
      nvmet-rdma: fix possible bad dereference when freeing rsps

Sascha Hauer (1):
      wifi: mwifiex: duplicate static structs used in driver instances

Sean Anderson (1):
      net: xilinx: axienet: Always disable promiscuous mode

Sebastian Andrzej Siewior (1):
      netfilter: nft_counter: Synchronize nft_counter_reset() against reader.

Selvarasu Ganesan (1):
      usb: dwc3: core: Prevent USB core invalid event buffer address access

Takashi Iwai (1):
      ALSA: timer: Relax start tick time check for slave timer elements

Tetsuo Handa (2):
      block: use "unsigned long" for blk_validate_block_size().
      Input: MT - limit max slots

Uwe Kleine-König (1):
      usb: gadget: fsl: Increase size of name buffer for endpoints

Vasily Averin (2):
      memcg: enable accounting of ipc resources
      ipc: remove memcg accounting for sops objects in do_semtimedop()

Wolfram Sang (1):
      i2c: riic: avoid potential division by zero

ZHANG Yuntian (1):
      USB: serial: option: add MeiG Smart SRM825L

Zhen Lei (1):
      selinux: fix potential counting error in avc_add_xperms_decision()

Zhiguo Niu (1):
      f2fs: fix to do sanity check in update_sit_entry

Zijun Hu (1):
      usb: core: sysfs: Unmerge @usb3_hardware_lpm_attr_group in remove_power_attributes()


