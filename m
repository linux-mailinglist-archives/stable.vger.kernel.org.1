Return-Path: <stable+bounces-163283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E79AEB092A4
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 19:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230BE5A26ED
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 17:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780E32FE371;
	Thu, 17 Jul 2025 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rfeBvgGN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320D72FE38C;
	Thu, 17 Jul 2025 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771847; cv=none; b=HKfFFQLM7goSwm3QDdSxL5etRK4sig/NczrgIe7tlGbztmc8ex/aXP2WEew6j0IueaNIQclCCpG6xXzaAhx6fOdy8u0JqcMxrL40HvoUfU90FGEhzaoZc4Mprdcw7MYCLqSxhCpwh0V0YRHpCS7wsF4NTJREu53E0ApWBy3Pn0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771847; c=relaxed/simple;
	bh=bS8iRO9kFs74jZO8lNwodoWbIFAuylnReXi54x+5uRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aS9HOa2SJV3HEz6M7p0BzTEL7QHOF+Wxy7JfL/bMmMQcvA1BGjupNnRelxX3LRJYEA7PlV9Vfw8n9mc2kQYAXotie/ZMDclrSToQOs+wPJlBBUgiw3Q6Q5RsY0T/IcxYPWAW2WahbUqqnRsPKfukYTz4gOj6R7d05MQ46CDnl6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rfeBvgGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0D8C4CEF4;
	Thu, 17 Jul 2025 17:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752771846;
	bh=bS8iRO9kFs74jZO8lNwodoWbIFAuylnReXi54x+5uRs=;
	h=From:To:Cc:Subject:Date:From;
	b=rfeBvgGNXbGbDj/W2kHX75G/MbkeJzleWUSuAsCs2cMkyFYYwJT4AyAff9EK34+rm
	 fK93MBewVP9LEiwOF4IOH9noAGRGRDYhqJvZGCF+D07X6tJsRmobiaKwg537Sv9R4D
	 oSqPcXaL5kce0dkkFm7QL7KgI12UByF715fsj99g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.146
Date: Thu, 17 Jul 2025 19:03:54 +0200
Message-ID: <2025071755-dispute-neutron-dff5@gregkh>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.146 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                      |    2 
 arch/um/drivers/vector_kern.c                 |   42 ---
 arch/x86/Kconfig                              |    2 
 arch/x86/Makefile                             |    2 
 arch/x86/include/asm/cpufeatures.h            |    2 
 arch/x86/kernel/cpu/mce/amd.c                 |   15 -
 arch/x86/kernel/cpu/mce/core.c                |    8 
 arch/x86/kernel/cpu/mce/intel.c               |    1 
 arch/x86/kvm/svm/sev.c                        |    4 
 arch/x86/kvm/xen.c                            |   15 -
 drivers/acpi/battery.c                        |   19 -
 drivers/atm/idt77252.c                        |    5 
 drivers/block/nbd.c                           |    6 
 drivers/char/ipmi/ipmi_msghandler.c           |    3 
 drivers/gpu/drm/drm_gem.c                     |   10 
 drivers/gpu/drm/exynos/exynos7_drm_decon.c    |    4 
 drivers/gpu/drm/tegra/nvdec.c                 |    6 
 drivers/gpu/drm/ttm/ttm_bo_util.c             |   13 
 drivers/hid/hid-ids.h                         |    6 
 drivers/hid/hid-lenovo.c                      |    8 
 drivers/hid/hid-multitouch.c                  |    8 
 drivers/hid/hid-quirks.c                      |    3 
 drivers/input/joystick/xpad.c                 |    2 
 drivers/input/keyboard/atkbd.c                |    3 
 drivers/md/md-bitmap.c                        |    3 
 drivers/md/raid1.c                            |    1 
 drivers/md/raid10.c                           |   10 
 drivers/net/can/m_can/m_can.c                 |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |    2 
 drivers/net/ethernet/ibm/ibmvnic.h            |    8 
 drivers/net/ethernet/xilinx/ll_temac_main.c   |    2 
 drivers/net/phy/microchip.c                   |    2 
 drivers/net/phy/smsc.c                        |   28 +-
 drivers/net/usb/qmi_wwan.c                    |    1 
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c  |    6 
 drivers/pinctrl/qcom/pinctrl-msm.c            |   20 +
 drivers/platform/x86/ideapad-laptop.c         |   19 +
 drivers/pwm/pwm-mediatek.c                    |   13 
 drivers/tty/vt/vt.c                           |    1 
 drivers/usb/cdns3/cdnsp-debug.h               |  358 ++++++++++++--------------
 drivers/usb/cdns3/cdnsp-ep0.c                 |   18 +
 drivers/usb/cdns3/cdnsp-gadget.c              |    6 
 drivers/usb/cdns3/cdnsp-gadget.h              |   11 
 drivers/usb/cdns3/cdnsp-ring.c                |   27 -
 drivers/usb/dwc3/core.c                       |    9 
 drivers/usb/dwc3/gadget.c                     |   22 -
 drivers/usb/gadget/function/u_serial.c        |    6 
 drivers/usb/host/xhci-mem.c                   |    4 
 drivers/usb/host/xhci-pci.c                   |   30 ++
 drivers/usb/host/xhci.h                       |    1 
 drivers/vhost/scsi.c                          |    7 
 fs/anon_inodes.c                              |   23 +
 fs/btrfs/free-space-tree.c                    |   16 -
 fs/btrfs/inode.c                              |   28 +-
 fs/erofs/data.c                               |    2 
 fs/erofs/zdata.c                              |  126 +++------
 fs/proc/inode.c                               |    2 
 fs/proc/proc_sysctl.c                         |   18 -
 fs/smb/server/smb2pdu.c                       |   29 --
 fs/smb/server/transport_rdma.c                |    5 
 fs/smb/server/vfs.c                           |    1 
 include/drm/drm_file.h                        |    3 
 include/drm/spsc_queue.h                      |    4 
 include/linux/fs.h                            |    2 
 include/net/netfilter/nf_flow_table.h         |    2 
 include/trace/events/erofs.h                  |   16 -
 kernel/events/core.c                          |    2 
 kernel/rseq.c                                 |   60 +++-
 lib/maple_tree.c                              |    7 
 mm/kasan/report.c                             |   13 
 mm/secretmem.c                                |   11 
 net/appletalk/ddp.c                           |    1 
 net/atm/clip.c                                |   64 +++-
 net/bluetooth/hci_sync.c                      |    2 
 net/ipv6/addrconf.c                           |    9 
 net/netlink/af_netlink.c                      |   82 +++--
 net/rxrpc/call_accept.c                       |    3 
 net/sched/sch_api.c                           |   23 +
 net/tipc/topsrv.c                             |    2 
 net/vmw_vsock/af_vsock.c                      |   57 +++-
 net/wireless/util.c                           |   52 +++
 sound/pci/hda/patch_realtek.c                 |    1 
 sound/soc/amd/yc/acp6x-mach.c                 |    7 
 sound/soc/fsl/fsl_asrc.c                      |    3 
 tools/include/linux/kallsyms.h                |    4 
 86 files changed, 900 insertions(+), 588 deletions(-)

Achill Gilgenast (1):
      kallsyms: fix build without execinfo

Akira Inoue (1):
      HID: lenovo: Add support for ThinkPad X1 Tablet Thin Keyboard Gen2

Al Viro (2):
      fix proc_sys_compare() handling of in-lookup dentries
      ksmbd: fix a mount write count leak in ksmbd_vfs_kern_path_locked()

Alexey Dobriyan (1):
      x86/boot: Compile boot code with -std=gnu11 too

Alok Tiwari (1):
      net: ll_temac: Fix missing tx_pending check in ethtools_set_ringparam()

Bartosz Golaszewski (1):
      pinctrl: qcom: msm: mark certain pins as invalid for interrupts

Basavaraj Natikar (1):
      xhci: Allow RPM on the USB controller (1022:43f7) by default

Chao Yu (1):
      erofs: fix to add missing tracepoint in erofs_read_folio()

Chia-Lin Kao (AceLan) (1):
      HID: quirks: Add quirk for 2 Chicony Electronics HP 5MP Cameras

Christian König (1):
      drm/ttm: fix error handling in ttm_buffer_object_transfer

Dan Carpenter (1):
      ipmi:msghandler: Fix potential memory corruption in ipmi_create_user()

Daniil Dulov (1):
      wifi: zd1211rw: Fix potential NULL pointer dereference in zd_mac_tx_to_dev()

David Howells (1):
      rxrpc: Fix oops due to non-existence of prealloc backlog struct

David Woodhouse (1):
      KVM: x86/xen: Allow 'out of range' event channel ports in IRQ routing table.

Dongli Zhang (1):
      vhost-scsi: protect vq->log_used with vq->mutex

Eric Dumazet (1):
      netfilter: flowtable: account for Ethernet header in nf_flow_pppoe_proto()

Filipe Manana (2):
      btrfs: propagate last_unlink_trans earlier when doing a rmdir
      btrfs: fix assertion when building free space tree

Gao Xiang (3):
      erofs: allocate extra bvec pages directly instead of retrying
      erofs: avoid on-stack pagepool directly passed by arguments
      erofs: adapt folios for z_erofs_read_folio()

Greg Kroah-Hartman (1):
      Linux 6.1.146

Guillaume Nault (1):
      gre: Fix IPv6 multicast route creation.

Hans de Goede (1):
      Input: atkbd - do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID

Håkon Bugge (1):
      md/md-bitmap: fix GPF in bitmap_get_stats()

JP Kobryn (1):
      x86/mce: Make sure CMCI banks are cleared during shutdown on Intel

Jack Wang (1):
      x86: Fix X86_FEATURE_VERW_CLEAR definition

Jakub Kicinski (1):
      netlink: make sure we allow at least one dump skb

Jann Horn (1):
      x86/mm: Disable hugetlb page table sharing on 32-bit

Kaustabh Chakraborty (1):
      drm/exynos: exynos7_drm_decon: add vblank check in IRQ handling

Kito Xu (1):
      net: appletalk: Fix device refcount leak in atrtr_create()

Kuen-Han Tsai (2):
      usb: gadget: u_serial: Fix race condition in TTY wakeup
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

Liam R. Howlett (1):
      maple_tree: fix MA_STATE_PREALLOC flag in mas_preallocate()

Luiz Augusto von Dentz (1):
      Bluetooth: hci_sync: Fix not disabling advertising instance

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

Nilton Perim Neto (1):
      Input: xpad - support Acer NGR 200 Controller

Oleksij Rempel (3):
      net: phy: smsc: Fix Auto-MDIX configuration when disabled by strap
      net: phy: smsc: Fix link failure in forced mode with Auto-MDIX
      net: phy: microchip: limit 100M workaround to link-down events on LAN88xx

Pawel Laszczak (2):
      usb:cdnsp: remove TRB_FLUSH_ENDPOINT command
      usb: cdnsp: Fix issue with CV Bad Descriptor test

Peter Zijlstra (1):
      perf: Revert to requiring CAP_SYS_ADMIN for uprobes

Rafael J. Wysocki (1):
      Revert "ACPI: battery: negate current when discharging"

Raju Rangoju (1):
      usb: xhci: quirk for data loss in ISOC transfers

Rong Zhang (1):
      platform/x86: ideapad-laptop: use usleep_range() for EC polling

Sean Christopherson (1):
      KVM: SVM: Reject SEV{-ES} intra host migration if vCPU creation is in-flight

Sean Nyekjaer (1):
      can: m_can: m_can_handle_lost_msg(): downgrade msg lost in rx message to debug level

Shengjiu Wang (1):
      ASoC: fsl_asrc: use internal measured ratio for non-ideal ratio mode

Shivank Garg (1):
      fs: export anon_inode_make_secure_inode() and fix secretmem LSM bypass

Shravya KN (1):
      bnxt_en: Fix DCB ETS validation

Simona Vetter (1):
      drm/gem: Fix race in drm_gem_handle_create_tail()

Somnath Kotur (1):
      bnxt_en: Set DMA unmap len correctly for XDP_REDIRECT

Stefan Metzmacher (1):
      smb: server: make use of rdma_destroy_qp()

Thomas Fourier (1):
      atm: idt77252: Add missing `dma_map_error()`

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

Xiaowei Li (1):
      net: usb: qmi_wwan: add SIMCom 8230C composition

Yasmin Fitzgerald (1):
      ALSA: hda/realtek - Enable mute LED on HP Pavilion Laptop 15-eg100

Yazen Ghannam (2):
      x86/mce/amd: Fix threshold limit reset
      x86/mce: Don't remove sysfs if thresholding sysfs init fails

Yeoreum Yun (1):
      kasan: remove kasan_find_vm_area() to prevent possible deadlock

Yue Haibing (1):
      atm: clip: Fix NULL pointer dereference in vcc_sendmsg()

Yue Hu (2):
      erofs: remove the member readahead from struct z_erofs_decompress_frontend
      erofs: clean up z_erofs_pcluster_readmore()

Yuzuru10 (1):
      ASoC: amd: yc: add quirk for Acer Nitro ANV15-41 internal mic

Zhang Heng (1):
      HID: Add IGNORE quirk for SMARTLINKTECHNOLOGY

Zheng Qixing (1):
      nbd: fix uaf in nbd_genl_connect() error path


