Return-Path: <stable+bounces-163286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7C4B092AA
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 19:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F515A26E4
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 17:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C66D2FEE34;
	Thu, 17 Jul 2025 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RKQdeMGc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C2F2FD5BC;
	Thu, 17 Jul 2025 17:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771860; cv=none; b=BM3CuMNTjSotC0YHWPklQVQ0FnBLFStYBUBUexKMBdbB9ZIk059X4kb8zAUeST/8DYTi2f3j+QTKfPKOG5jzSrcORi7FEbgc3cku5IFNR9/hSov3d3FZ9U8mHts7jmRzKjRJ3Ka2zH/eB7ztDv6EQEqHywMkOaUwhizBkvGK608=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771860; c=relaxed/simple;
	bh=vL3rILTRLeppYNCz8a+RuffmJaKJtKFf0PZ221ciFBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qcW7yzHmKRD367WAJxTT08gOHoxuu2SqH6DngmrOF80QFijcOW/QugGscya/coTZX+URpuiwI9/yFwALFmjkz4hYedGECDkijUEsyFsItJqNdgf5qxKZZz4N7TetlCXylB692HkvM1mI/cEIu/mM+ccVk5FEXz3DA6hPPDzgre8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RKQdeMGc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5480C4CEED;
	Thu, 17 Jul 2025 17:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752771860;
	bh=vL3rILTRLeppYNCz8a+RuffmJaKJtKFf0PZ221ciFBY=;
	h=From:To:Cc:Subject:Date:From;
	b=RKQdeMGc4TMwypT4x9DTOCFXqEHeD7mjI7HqDL0azE2fsFOU9xJC5vEjlYzNC1oWg
	 6dJnpk4P+PyxvtblfI0Bk8kZ6+ZlyX98e5sgj4+Km4KHux30HcuyV7NJOmVS577HJ0
	 VGish4ImXF0iFpqv1J34sTS6Q8pD/mQWEpQdKCiE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.99
Date: Thu, 17 Jul 2025 19:04:04 +0200
Message-ID: <2025071705-ritzy-monetize-4564@gregkh>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.99 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/bpf/map_hash.rst                     |    8 
 Documentation/bpf/map_lru_hash_update.dot          |    6 
 Makefile                                           |    2 
 arch/um/drivers/vector_kern.c                      |   42 --
 arch/x86/Kconfig                                   |    2 
 arch/x86/include/asm/msr-index.h                   |    1 
 arch/x86/kernel/cpu/amd.c                          |    7 
 arch/x86/kernel/cpu/mce/amd.c                      |   28 -
 arch/x86/kernel/cpu/mce/core.c                     |    8 
 arch/x86/kernel/cpu/mce/intel.c                    |    1 
 arch/x86/kvm/svm/sev.c                             |    4 
 arch/x86/kvm/xen.c                                 |   15 
 crypto/ecc.c                                       |    2 
 drivers/acpi/battery.c                             |   19 -
 drivers/atm/idt77252.c                             |    5 
 drivers/block/nbd.c                                |    6 
 drivers/block/ublk_drv.c                           |    3 
 drivers/char/ipmi/ipmi_msghandler.c                |    3 
 drivers/gpu/drm/drm_framebuffer.c                  |   31 +
 drivers/gpu/drm/drm_gem.c                          |   74 +++-
 drivers/gpu/drm/drm_internal.h                     |    2 
 drivers/gpu/drm/exynos/exynos7_drm_decon.c         |    4 
 drivers/gpu/drm/tegra/nvdec.c                      |    6 
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |   13 
 drivers/hid/hid-ids.h                              |    6 
 drivers/hid/hid-lenovo.c                           |    8 
 drivers/hid/hid-multitouch.c                       |    8 
 drivers/hid/hid-quirks.c                           |    3 
 drivers/input/keyboard/atkbd.c                     |    3 
 drivers/md/md-bitmap.c                             |    3 
 drivers/md/raid1.c                                 |    1 
 drivers/md/raid10.c                                |   10 
 drivers/net/can/m_can/m_can.c                      |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c      |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      |    2 
 drivers/net/ethernet/ibm/ibmvnic.h                 |    8 
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |    3 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |   24 -
 drivers/net/ethernet/xilinx/ll_temac_main.c        |    2 
 drivers/net/phy/microchip.c                        |    2 
 drivers/net/phy/smsc.c                             |   57 +++
 drivers/net/usb/qmi_wwan.c                         |    1 
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c       |    6 
 drivers/pinctrl/pinctrl-amd.c                      |   11 
 drivers/pinctrl/qcom/pinctrl-msm.c                 |   20 +
 drivers/pwm/pwm-mediatek.c                         |   13 
 drivers/tty/vt/vt.c                                |    1 
 drivers/usb/cdns3/cdnsp-debug.h                    |  358 ++++++++++-----------
 drivers/usb/cdns3/cdnsp-ep0.c                      |   18 -
 drivers/usb/cdns3/cdnsp-gadget.c                   |    6 
 drivers/usb/cdns3/cdnsp-gadget.h                   |   11 
 drivers/usb/cdns3/cdnsp-ring.c                     |   27 -
 drivers/usb/dwc3/core.c                            |    9 
 drivers/usb/dwc3/gadget.c                          |   22 -
 drivers/usb/gadget/function/u_serial.c             |   12 
 fs/btrfs/btrfs_inode.h                             |    2 
 fs/btrfs/free-space-tree.c                         |   16 
 fs/btrfs/inode.c                                   |   18 -
 fs/btrfs/transaction.c                             |    2 
 fs/btrfs/tree-log.c                                |  331 +++++++++++--------
 fs/erofs/data.c                                    |    2 
 fs/eventpoll.c                                     |   12 
 fs/proc/inode.c                                    |    2 
 fs/proc/proc_sysctl.c                              |   18 -
 fs/proc/task_mmu.c                                 |   14 
 fs/smb/client/cifsglob.h                           |    3 
 fs/smb/client/cifsproto.h                          |   13 
 fs/smb/client/connect.c                            |   47 +-
 fs/smb/client/dfs.c                                |   73 ++--
 fs/smb/client/dfs.h                                |   42 +-
 fs/smb/client/dfs_cache.c                          |  186 ++++++----
 fs/smb/client/fs_context.h                         |    1 
 fs/smb/client/misc.c                               |    9 
 fs/smb/client/namespace.c                          |    2 
 fs/smb/server/smb2pdu.c                            |   29 -
 fs/smb/server/transport_rdma.c                     |    5 
 fs/smb/server/vfs.c                                |    1 
 include/drm/drm_file.h                             |    3 
 include/drm/drm_framebuffer.h                      |    7 
 include/drm/spsc_queue.h                           |    4 
 include/linux/math.h                               |   12 
 include/linux/mm.h                                 |    5 
 include/net/af_vsock.h                             |    2 
 include/net/netfilter/nf_flow_table.h              |    2 
 io_uring/opdef.c                                   |    1 
 kernel/bpf/bpf_lru_list.c                          |    9 
 kernel/bpf/bpf_lru_list.h                          |    1 
 kernel/events/core.c                               |    6 
 kernel/rseq.c                                      |   60 ++-
 lib/maple_tree.c                                   |   14 
 mm/kasan/report.c                                  |   13 
 mm/vmalloc.c                                       |   22 -
 net/appletalk/ddp.c                                |    1 
 net/atm/clip.c                                     |   64 ++-
 net/bluetooth/hci_event.c                          |   39 --
 net/bluetooth/hci_sync.c                           |  215 +++++++-----
 net/ipv4/tcp.c                                     |    2 
 net/ipv6/addrconf.c                                |    9 
 net/netlink/af_netlink.c                           |   82 ++--
 net/rxrpc/call_accept.c                            |    4 
 net/sched/sch_api.c                                |   23 -
 net/tipc/topsrv.c                                  |    2 
 net/vmw_vsock/af_vsock.c                           |   57 ++-
 net/wireless/util.c                                |   52 ++-
 scripts/gdb/linux/constants.py.in                  |    7 
 scripts/gdb/linux/interrupts.py                    |   16 
 scripts/gdb/linux/mapletree.py                     |  252 ++++++++++++++
 scripts/gdb/linux/xarray.py                        |   28 +
 sound/pci/hda/patch_realtek.c                      |    1 
 sound/soc/amd/yc/acp6x-mach.c                      |    7 
 sound/soc/codecs/cs35l56-shared.c                  |    2 
 sound/soc/fsl/fsl_asrc.c                           |    3 
 tools/arch/x86/include/asm/msr-index.h             |    1 
 tools/build/feature/Makefile                       |   25 +
 tools/include/linux/kallsyms.h                     |    4 
 tools/perf/Makefile.perf                           |   27 +
 tools/testing/selftests/bpf/test_lru_map.c         |  105 +++---
 117 files changed, 1937 insertions(+), 1031 deletions(-)

Achill Gilgenast (1):
      kallsyms: fix build without execinfo

Akira Inoue (1):
      HID: lenovo: Add support for ThinkPad X1 Tablet Thin Keyboard Gen2

Al Viro (2):
      fix proc_sys_compare() handling of in-lookup dentries
      ksmbd: fix a mount write count leak in ksmbd_vfs_kern_path_locked()

Alexander Gordeev (1):
      mm/vmalloc: leave lazy MMU mode on PTE mapping error

Alok Tiwari (1):
      net: ll_temac: Fix missing tx_pending check in ethtools_set_ringparam()

Baolin Wang (1):
      mm: fix the inaccurate memory statistics issue for users

Bartosz Golaszewski (1):
      pinctrl: qcom: msm: mark certain pins as invalid for interrupts

Chao Yu (1):
      erofs: fix to add missing tracepoint in erofs_read_folio()

Chia-Lin Kao (AceLan) (1):
      HID: quirks: Add quirk for 2 Chicony Electronics HP 5MP Cameras

Christian Eggers (1):
      Bluetooth: HCI: Set extended advertising data synchronously

Christian König (1):
      drm/ttm: fix error handling in ttm_buffer_object_transfer

Dan Carpenter (1):
      ipmi:msghandler: Fix potential memory corruption in ipmi_create_user()

Daniil Dulov (1):
      wifi: zd1211rw: Fix potential NULL pointer dereference in zd_mac_tx_to_dev()

David Howells (2):
      rxrpc: Fix bug due to prealloc collision
      rxrpc: Fix oops due to non-existence of prealloc backlog struct

David Woodhouse (1):
      KVM: x86/xen: Allow 'out of range' event channel ports in IRQ routing table.

Eric Dumazet (1):
      netfilter: flowtable: account for Ethernet header in nf_flow_pppoe_proto()

EricChan (1):
      net: stmmac: Fix interrupt handling for level-triggered mode in DWC_XGMAC2

Fengnan Chang (1):
      io_uring: make fallocate be hashed work

Filipe Manana (6):
      btrfs: remove noinline from btrfs_update_inode()
      btrfs: remove redundant root argument from btrfs_update_inode_fallback()
      btrfs: remove redundant root argument from fixup_inode_link_count()
      btrfs: return a btrfs_inode from btrfs_iget_logging()
      btrfs: fix inode lookup error handling during log replay
      btrfs: fix assertion when building free space tree

Florian Fainelli (3):
      scripts/gdb: fix interrupts display after MCP on x86
      scripts/gdb: de-reference per-CPU MCE interrupts
      scripts/gdb: fix interrupts.py after maple tree conversion

Greg Kroah-Hartman (1):
      Linux 6.6.99

Guillaume Nault (1):
      gre: Fix IPv6 multicast route creation.

Hans de Goede (1):
      Input: atkbd - do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID

Håkon Bugge (1):
      md/md-bitmap: fix GPF in bitmap_get_stats()

JP Kobryn (1):
      x86/mce: Make sure CMCI banks are cleared during shutdown on Intel

Jakub Kicinski (1):
      netlink: make sure we allow at least one dump skb

Jann Horn (1):
      x86/mm: Disable hugetlb page table sharing on 32-bit

Jiayuan Chen (1):
      tcp: Correct signedness in skb remaining space calculation

Kaustabh Chakraborty (1):
      drm/exynos: exynos7_drm_decon: add vblank check in IRQ handling

Kito Xu (1):
      net: appletalk: Fix device refcount leak in atrtr_create()

Kuen-Han Tsai (3):
      usb: gadget: u_serial: Fix race condition in TTY wakeup
      Revert "usb: gadget: u_serial: Add null pointer check in gs_start_io"
      usb: dwc3: Abort suspend on soft disconnect failure

Kuniyuki Iwashima (6):
      netlink: Fix wraparounds of sk->sk_rmem_alloc.
      tipc: Fix use-after-free in tipc_conn_close().
      atm: clip: Fix potential null-ptr-deref in to_atmarpd().
      atm: clip: Fix memory leak of struct clip_vcc.
      atm: clip: Fix infinite recursive call of clip_push().
      netlink: Fix rmem check in netlink_broadcast_deliver().

Lee Jones (1):
      usb: cdnsp: Replace snprintf() with the safer scnprintf() variant

Leo Yan (1):
      perf: build: Setup PKG_CONFIG_LIBDIR for cross compilation

Liam R. Howlett (1):
      maple_tree: fix MA_STATE_PREALLOC flag in mas_preallocate()

Linus Torvalds (1):
      eventpoll: don't decrement ep refcount while still holding the ep mutex

Long Li (1):
      net: mana: Record doorbell physical address in PF mode

Luiz Augusto von Dentz (2):
      Bluetooth: hci_sync: Fix not disabling advertising instance
      Bluetooth: hci_event: Fix not marking Broadcast Sink BIS as connected

Lukas Wunner (1):
      crypto: ecdsa - Harden against integer overflows in DIV_ROUND_UP()

Luo Gengkun (1):
      perf/core: Fix the WARN_ON_ONCE is out of lock protected region

Mario Limonciello (1):
      pinctrl: amd: Clear GPIO debounce for suspend

Mathy Vanhoef (1):
      wifi: prevent A-MSDU attacks in mesh networks

Matthew Brost (1):
      drm/sched: Increment job count before swapping tail spsc queue

Michael Jeanson (1):
      rseq: Fix segfault on registration when rseq_cs is non-zero

Michal Luczaj (3):
      vsock: Fix transport_{g2h,h2g} TOCTOU
      vsock: Fix transport_* TOCTOU
      vsock: Fix IOCTL_VM_SOCKETS_GET_LOCAL_CID to check also `transport_local`

Mikhail Paulyshka (1):
      x86/rdrand: Disable RDSEED on AMD Cyan Skillfish

Mikko Perttunen (1):
      drm/tegra: nvdec: Fix dma_alloc_coherent error check

Mingming Cao (1):
      ibmvnic: Fix hardcoded NUM_RX_STATS/NUM_TX_STATS with dynamic sizeof

Namjae Jeon (1):
      ksmbd: fix potential use-after-free in oplock/lease break ack

Nicolas Pitre (1):
      vt: add missing notification when switching back to text mode

Nigel Croxon (1):
      raid10: cleanup memleak at raid10_make_request

Oleksij Rempel (4):
      net: phy: smsc: Fix Auto-MDIX configuration when disabled by strap
      net: phy: smsc: Force predictable MDI-X state on LAN87xx
      net: phy: smsc: Fix link failure in forced mode with Auto-MDIX
      net: phy: microchip: limit 100M workaround to link-down events on LAN88xx

Paulo Alcantara (3):
      smb: client: avoid unnecessary reconnects when refreshing referrals
      smb: client: fix DFS interlink failover
      smb: client: fix potential race in cifs_put_tcon()

Pawel Laszczak (2):
      usb:cdnsp: remove TRB_FLUSH_ENDPOINT command
      usb: cdnsp: Fix issue with CV Bad Descriptor test

Peter Zijlstra (1):
      perf: Revert to requiring CAP_SYS_ADMIN for uprobes

Rafael J. Wysocki (1):
      Revert "ACPI: battery: negate current when discharging"

Richard Fitzgerald (1):
      ASoC: cs35l56: probe() should fail if the device ID is not recognized

Ronnie Sahlberg (1):
      ublk: sanity check add_dev input for underflow

Sean Christopherson (1):
      KVM: SVM: Reject SEV{-ES} intra host migration if vCPU creation is in-flight

Sean Nyekjaer (1):
      can: m_can: m_can_handle_lost_msg(): downgrade msg lost in rx message to debug level

Shengjiu Wang (1):
      ASoC: fsl_asrc: use internal measured ratio for non-ideal ratio mode

Shravya KN (1):
      bnxt_en: Fix DCB ETS validation

Shyam Prasad N (1):
      cifs: all initializations for tcon should happen in tcon_info_alloc

Simona Vetter (1):
      drm/gem: Fix race in drm_gem_handle_create_tail()

Somnath Kotur (1):
      bnxt_en: Set DMA unmap len correctly for XDP_REDIRECT

Stefan Metzmacher (1):
      smb: server: make use of rdma_destroy_qp()

Stefano Garzarella (1):
      vsock: fix `vsock_proto` declaration

Thomas Fourier (1):
      atm: idt77252: Add missing `dma_map_error()`

Thomas Zimmermann (2):
      drm/gem: Acquire references on GEM handles for framebuffers
      drm/framebuffer: Acquire internal references on GEM handles

Tiwei Bie (1):
      um: vector: Reduce stack usage in vector_eth_configure()

Uwe Kleine-König (1):
      pwm: mediatek: Ensure to disable clocks in error path

Victor Nogueira (1):
      net/sched: Abort __tc_modify_qdisc if parent class does not exist

Wang Jinchao (1):
      md/raid1: Fix stack memory use after return in raid1_reshape

Wei Yang (1):
      maple_tree: fix mt_destroy_walk() on root leaf node

Willem de Bruijn (2):
      bpf: Adjust free target to avoid global starvation of LRU map
      selftests/bpf: adapt one more case in test_lru_map to the new target_free

Xiaowei Li (1):
      net: usb: qmi_wwan: add SIMCom 8230C composition

Yasmin Fitzgerald (1):
      ALSA: hda/realtek - Enable mute LED on HP Pavilion Laptop 15-eg100

Yazen Ghannam (3):
      x86/mce/amd: Add default names for MCA banks and blocks
      x86/mce/amd: Fix threshold limit reset
      x86/mce: Don't remove sysfs if thresholding sysfs init fails

Yeoreum Yun (1):
      kasan: remove kasan_find_vm_area() to prevent possible deadlock

Yue Haibing (1):
      atm: clip: Fix NULL pointer dereference in vcc_sendmsg()

Yuzuru10 (1):
      ASoC: amd: yc: add quirk for Acer Nitro ANV15-41 internal mic

Zhang Heng (1):
      HID: Add IGNORE quirk for SMARTLINKTECHNOLOGY

Zheng Qixing (1):
      nbd: fix uaf in nbd_genl_connect() error path


