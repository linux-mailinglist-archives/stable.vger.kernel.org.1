Return-Path: <stable+bounces-163282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A91BEB0929F
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 19:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC731C46302
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 17:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398D72FE32E;
	Thu, 17 Jul 2025 17:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a8g5GJxU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63DB2FE327;
	Thu, 17 Jul 2025 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771842; cv=none; b=i5wIsOLZMRzcZnPyaxoR4j145eoeoDzTk7+h6djSe7wLAfX44wjwhGDasSkGGV5+fB8rwMW2Mgpw3VDhqMqms2dsxWocDO6Dm4MU11Huru1wrs7o0IT51uoOBNW/gL9pgcTDdj/0X287XB+FmzWu4nLATAcxFhlzfhLpTwNQHaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771842; c=relaxed/simple;
	bh=qjq+f6l47wi0zwqGe4O7VASkJUGmWnKe3igFHFl+UC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cWmFjTqvooo5+x1fdfjTt97ywOLqAFikgqE/9njf2Ber48HE4pujqddjShma9vUQNPAO/SvclTgzVpHOizfDZ4xT20OG4rQdIEZhoJFKLONXiLHDMN7GPu8PDvlGbPZKXYpQxxUxavOPfg0X6BQl0TeFUQzDyzkJEQq8Pe4cOFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a8g5GJxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F32C4CEE3;
	Thu, 17 Jul 2025 17:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752771842;
	bh=qjq+f6l47wi0zwqGe4O7VASkJUGmWnKe3igFHFl+UC4=;
	h=From:To:Cc:Subject:Date:From;
	b=a8g5GJxUi96j79Zy2+dBBptJL1NR+wpHeshvzKIm6Tp2vlTYMCFmPlzEJbka2Mr0q
	 s6LEz4BQPVzgVthmMKh0d5HELIObqxMmUeAcCyxFc/hQUa38CegTDY/EmFZRTAamfu
	 Yt2ki/eeodAHoi5si8xbqOtaLOx9hCVsUTVBHALk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.189
Date: Thu, 17 Jul 2025 19:03:45 +0200
Message-ID: <2025071746-acid-pyromania-0233@gregkh>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.189 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                |    2 
 arch/um/drivers/vector_kern.c                           |   42 -
 arch/x86/Kconfig                                        |    2 
 arch/x86/include/asm/cpufeatures.h                      |    2 
 arch/x86/include/asm/xen/page.h                         |    3 
 arch/x86/kernel/cpu/mce/amd.c                           |   15 
 arch/x86/kernel/cpu/mce/core.c                          |    8 
 arch/x86/kernel/cpu/mce/intel.c                         |    1 
 drivers/acpi/battery.c                                  |   19 
 drivers/atm/idt77252.c                                  |    5 
 drivers/block/aoe/aoeblk.c                              |    5 
 drivers/block/nbd.c                                     |    6 
 drivers/dma-buf/dma-resv.c                              |  171 ++++---
 drivers/gpu/drm/drm_gem.c                               |   10 
 drivers/gpu/drm/exynos/exynos7_drm_decon.c              |    4 
 drivers/hid/hid-ids.h                                   |    6 
 drivers/hid/hid-lenovo.c                                |    8 
 drivers/hid/hid-multitouch.c                            |    8 
 drivers/hid/hid-quirks.c                                |    3 
 drivers/infiniband/hw/mlx5/main.c                       |   33 +
 drivers/input/joystick/xpad.c                           |    2 
 drivers/input/keyboard/atkbd.c                          |    3 
 drivers/md/raid1.c                                      |    1 
 drivers/md/raid10.c                                     |   10 
 drivers/net/can/m_can/m_can.c                           |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c           |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c           |    2 
 drivers/net/ethernet/intel/ice/ice_main.c               |   29 -
 drivers/net/ethernet/xilinx/ll_temac_main.c             |    2 
 drivers/net/phy/microchip.c                             |    2 
 drivers/net/phy/smsc.c                                  |   28 +
 drivers/net/usb/qmi_wwan.c                              |    1 
 drivers/net/virtio_net.c                                |   44 +
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c            |    6 
 drivers/pinctrl/qcom/pinctrl-msm.c                      |   20 
 drivers/pwm/pwm-mediatek.c                              |   15 
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c |    9 
 drivers/tty/hvc/hvc_xen.c                               |    2 
 drivers/tty/vt/vt.c                                     |    1 
 drivers/usb/cdns3/cdnsp-debug.h                         |  358 +++++++---------
 drivers/usb/cdns3/cdnsp-ep0.c                           |   18 
 drivers/usb/cdns3/cdnsp-gadget.c                        |    6 
 drivers/usb/cdns3/cdnsp-gadget.h                        |   11 
 drivers/usb/cdns3/cdnsp-ring.c                          |   27 -
 drivers/usb/dwc3/core.c                                 |    9 
 drivers/usb/dwc3/gadget.c                               |   22 
 drivers/usb/gadget/function/u_serial.c                  |    6 
 drivers/usb/host/xhci-mem.c                             |    4 
 drivers/usb/host/xhci-pci.c                             |   30 +
 drivers/usb/host/xhci-plat.c                            |    3 
 drivers/usb/host/xhci.h                                 |    1 
 drivers/vhost/scsi.c                                    |    7 
 drivers/xen/grant-table.c                               |    6 
 drivers/xen/xenbus/xenbus_probe.c                       |    3 
 fs/btrfs/inode.c                                        |   36 -
 fs/jfs/jfs_dtree.c                                      |    2 
 fs/ksmbd/transport_rdma.c                               |    5 
 fs/ksmbd/vfs.c                                          |    1 
 fs/proc/array.c                                         |    6 
 fs/proc/inode.c                                         |    2 
 fs/proc/proc_sysctl.c                                   |   18 
 include/drm/drm_file.h                                  |    3 
 include/drm/spsc_queue.h                                |    4 
 include/linux/dma-resv.h                                |   95 ++++
 include/net/netfilter/nf_flow_table.h                   |    2 
 include/xen/arm/page.h                                  |    3 
 kernel/bpf/verifier.c                                   |   21 
 kernel/events/core.c                                    |    2 
 kernel/rseq.c                                           |   60 ++
 net/appletalk/ddp.c                                     |    1 
 net/atm/clip.c                                          |   64 ++
 net/core/skmsg.c                                        |   12 
 net/ipv6/addrconf.c                                     |    9 
 net/netlink/af_netlink.c                                |   82 ++-
 net/rxrpc/call_accept.c                                 |    3 
 net/sched/sch_api.c                                     |   23 -
 net/tipc/topsrv.c                                       |    2 
 net/vmw_vsock/af_vsock.c                                |   57 ++
 sound/soc/fsl/fsl_asrc.c                                |    3 
 79 files changed, 1015 insertions(+), 546 deletions(-)

Akira Inoue (1):
      HID: lenovo: Add support for ThinkPad X1 Tablet Thin Keyboard Gen2

Al Viro (2):
      fix proc_sys_compare() handling of in-lookup dentries
      ksmbd: fix a mount write count leak in ksmbd_vfs_kern_path_locked()

Alok Tiwari (1):
      net: ll_temac: Fix missing tx_pending check in ethtools_set_ringparam()

Andrii Nakryiko (1):
      bpf: fix precision backtracking instruction iteration

Bartosz Golaszewski (1):
      pinctrl: qcom: msm: mark certain pins as invalid for interrupts

Basavaraj Natikar (1):
      xhci: Allow RPM on the USB controller (1022:43f7) by default

Bui Quang Minh (1):
      virtio-net: ensure the received length does not exceed allocated size

Chia-Lin Kao (AceLan) (1):
      HID: quirks: Add quirk for 2 Chicony Electronics HP 5MP Cameras

Christian König (3):
      dma-buf: add dma_resv_for_each_fence_unlocked v8
      dma-buf: use new iterator in dma_resv_wait_timeout
      dma-buf: fix timeout handling in dma_resv_wait_timeout v2

Daniil Dulov (1):
      wifi: zd1211rw: Fix potential NULL pointer dereference in zd_mac_tx_to_dev()

David Howells (1):
      rxrpc: Fix oops due to non-existence of prealloc backlog struct

Dongli Zhang (1):
      vhost-scsi: protect vq->log_used with vq->mutex

Edward Adam Davis (1):
      jfs: fix null ptr deref in dtInsertEntry

Eric Dumazet (1):
      netfilter: flowtable: account for Ethernet header in nf_flow_pppoe_proto()

Filipe Manana (2):
      btrfs: propagate last_unlink_trans earlier when doing a rmdir
      btrfs: use btrfs_record_snapshot_destroy() during rmdir

Greg Kroah-Hartman (1):
      Linux 5.15.189

Guillaume Nault (1):
      gre: Fix IPv6 multicast route creation.

Hans de Goede (1):
      Input: atkbd - do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID

Hongyu Xie (1):
      xhci: Disable stream for xHC controller with XHCI_BROKEN_STREAMS

JP Kobryn (1):
      x86/mce: Make sure CMCI banks are cleared during shutdown on Intel

Jack Wang (1):
      x86: Fix X86_FEATURE_VERW_CLEAR definition

Jakub Kicinski (1):
      netlink: make sure we allow at least one dump skb

Jann Horn (1):
      x86/mm: Disable hugetlb page table sharing on 32-bit

Jesse Brandeburg (1):
      ice: safer stats processing

John Fastabend (1):
      bpf, sockmap: Fix skb refcnt race after locking changes

Juergen Gross (1):
      xen: replace xen_remap() with memremap()

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

Lee, Chun-Yi (1):
      thermal/int340x_thermal: handle data_vault when the value is ZERO_SIZE_PTR

Maksim Kiselev (1):
      aoe: avoid potential deadlock at set_capacity

Matthew Brost (1):
      drm/sched: Increment job count before swapping tail spsc queue

Michael Jeanson (1):
      rseq: Fix segfault on registration when rseq_cs is non-zero

Michal Luczaj (3):
      vsock: Fix transport_{g2h,h2g} TOCTOU
      vsock: Fix transport_* TOCTOU
      vsock: Fix IOCTL_VM_SOCKETS_GET_LOCAL_CID to check also `transport_local`

Nicolas Pitre (1):
      vt: add missing notification when switching back to text mode

Nigel Croxon (1):
      raid10: cleanup memleak at raid10_make_request

Nilton Perim Neto (1):
      Input: xpad - support Acer NGR 200 Controller

Oleg Nesterov (1):
      fs/proc: do_task_stat: use __for_each_thread()

Oleksij Rempel (3):
      net: phy: smsc: Fix Auto-MDIX configuration when disabled by strap
      net: phy: smsc: Fix link failure in forced mode with Auto-MDIX
      net: phy: microchip: limit 100M workaround to link-down events on LAN88xx

Patrisious Haddad (1):
      RDMA/mlx5: Fix vport loopback for MPV device

Pawel Laszczak (2):
      usb:cdnsp: remove TRB_FLUSH_ENDPOINT command
      usb: cdnsp: Fix issue with CV Bad Descriptor test

Peter Zijlstra (1):
      perf: Revert to requiring CAP_SYS_ADMIN for uprobes

Rafael J. Wysocki (1):
      Revert "ACPI: battery: negate current when discharging"

Raju Rangoju (1):
      usb: xhci: quirk for data loss in ISOC transfers

Sean Nyekjaer (1):
      can: m_can: m_can_handle_lost_msg(): downgrade msg lost in rx message to debug level

Shengjiu Wang (1):
      ASoC: fsl_asrc: use internal measured ratio for non-ideal ratio mode

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

Xiaowei Li (1):
      net: usb: qmi_wwan: add SIMCom 8230C composition

Yazen Ghannam (2):
      x86/mce/amd: Fix threshold limit reset
      x86/mce: Don't remove sysfs if thresholding sysfs init fails

Yue Haibing (1):
      atm: clip: Fix NULL pointer dereference in vcc_sendmsg()

Zhang Heng (1):
      HID: Add IGNORE quirk for SMARTLINKTECHNOLOGY

Zheng Qixing (1):
      nbd: fix uaf in nbd_genl_connect() error path


