Return-Path: <stable+bounces-210169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C1562D38F8C
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 16:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5890530089A1
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 15:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927CC238D22;
	Sat, 17 Jan 2026 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tgRbxS7F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DF51C8604;
	Sat, 17 Jan 2026 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768664858; cv=none; b=RyUVHs+lXUpUIotKdUZvARbhVd/1yYyNbv43sDsVcwZzk5WoQMme/KKOLxieRASljKNxfRYK3gxOPzrme32t9zrE0RFRnn5Hi6lbaZBoqtYkTC0yFki1jV9kupF02Y+7qjUSzMZ1lzWY9h2764O4wPZ5qK9JypAGikcHDTDZl/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768664858; c=relaxed/simple;
	bh=BMi/1VLnqf7B7ur3ikQnU80pa3bqapAgoehgrECIqww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ueIOk5jhzWe3fzDxmF/ttX7fyf6f2xUpC4J+I5im77x46zxyqZ9XsLx+OuAOCX9rXWtTYpRS4YER52toQw3fE3Ljt2Kjavd5ohQnwAp3SeOksgQ9nwxdvnw7KQceMLkBvVUMjoqpdH2QLnaRFr8bRjU2trHr3Mc9o+xAYgQ4PFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tgRbxS7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCB0C4CEF7;
	Sat, 17 Jan 2026 15:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768664857;
	bh=BMi/1VLnqf7B7ur3ikQnU80pa3bqapAgoehgrECIqww=;
	h=From:To:Cc:Subject:Date:From;
	b=tgRbxS7F5uwsD4LkekWJ4u+z19ucUxKgj4Edne5dKtpzObXoEA+RClhXfpOqPCsfU
	 jBWbttg6h3gg1fNsLPnlH4e88vsI84yPrxtr6ySlSAENZhk4/bPV930mAS5RctDnJU
	 EfgCWgCyIthIB90GGyu476gKmXByZRwD6fAVx3Xg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.121
Date: Sat, 17 Jan 2026 16:47:30 +0100
Message-ID: <2026011731-scouring-backpedal-e105@gregkh>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.121 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                      |    2 
 arch/alpha/include/uapi/asm/ioctls.h                          |    8 
 arch/arm/Kconfig                                              |    2 
 arch/arm/boot/dts/nxp/imx/imx6q-ba16.dtsi                     |    2 
 arch/arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi           |    1 
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts                  |    1 
 arch/csky/mm/fault.c                                          |    4 
 arch/loongarch/include/asm/inst.h                             |   13 +
 arch/riscv/include/asm/cacheflush.h                           |   15 -
 arch/riscv/kernel/probes/uprobes.c                            |   10 
 arch/x86/kernel/cpu/microcode/amd.c                           |  104 +++++---
 drivers/atm/he.c                                              |    3 
 drivers/counter/104-quad-8.c                                  |   20 +
 drivers/counter/interrupt-cnt.c                               |    3 
 drivers/gpio/gpio-pca953x.c                                   |   93 +++++--
 drivers/gpio/gpio-rockchip.c                                  |    1 
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c   |    8 
 drivers/gpu/drm/pl111/pl111_drv.c                             |    2 
 drivers/gpu/drm/radeon/pptable.h                              |    2 
 drivers/hid/hid-quirks.c                                      |    9 
 drivers/md/dm-exception-store.h                               |    2 
 drivers/md/dm-snap.c                                          |   73 ++---
 drivers/misc/mei/hw-me-regs.h                                 |    2 
 drivers/misc/mei/pci-me.c                                     |    2 
 drivers/net/ethernet/3com/3c59x.c                             |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                     |   15 -
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                     |    4 
 drivers/net/ethernet/freescale/enetc/enetc.h                  |    4 
 drivers/net/ethernet/marvell/prestera/prestera_devlink.c      |    2 
 drivers/net/ethernet/mellanox/mlx5/core/port.c                |    3 
 drivers/net/ethernet/mscc/ocelot.c                            |    6 
 drivers/net/usb/pegasus.c                                     |    2 
 drivers/net/wwan/iosm/iosm_ipc_mux.c                          |    6 
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c                      |    2 
 drivers/powercap/powercap_sys.c                               |   22 +
 drivers/scsi/ipr.c                                            |   28 ++
 drivers/scsi/libsas/sas_internal.h                            |   14 -
 drivers/scsi/sg.c                                             |   20 +
 drivers/ufs/core/ufshcd.c                                     |   36 ++
 fs/btrfs/tree-log.c                                           |    6 
 fs/nfs/Kconfig                                                |    1 
 fs/nfs/namespace.c                                            |    5 
 fs/nfs/nfs2xdr.c                                              |   70 -----
 fs/nfs/nfs3xdr.c                                              |  108 +-------
 fs/nfs/nfs4proc.c                                             |   13 -
 fs/nfs/nfs4trace.h                                            |    1 
 fs/nfs/nfs4xdr.c                                              |    4 
 fs/nfs_common/Makefile                                        |    2 
 fs/nfs_common/common.c                                        |   66 +++++
 fs/nfsd/Kconfig                                               |    1 
 fs/nfsd/blocklayout.c                                         |    3 
 fs/nfsd/netns.h                                               |    2 
 fs/nfsd/nfs3proc.c                                            |   10 
 fs/nfsd/nfs3xdr.c                                             |    5 
 fs/nfsd/nfs4proc.c                                            |   13 -
 fs/nfsd/nfs4state.c                                           |   44 +++
 fs/nfsd/nfsctl.c                                              |    5 
 fs/nfsd/nfsd.h                                                |    1 
 fs/nfsd/nfsproc.c                                             |    6 
 fs/nfsd/state.h                                               |    2 
 fs/nfsd/vfs.c                                                 |   26 +-
 fs/nfsd/vfs.h                                                 |   11 
 fs/nfsd/xdr3.h                                                |    2 
 fs/smb/client/nterr.h                                         |    6 
 include/linux/netdevice.h                                     |    3 
 include/linux/nfs_common.h                                    |   16 +
 include/net/dst.h                                             |   12 
 include/net/netfilter/nf_tables.h                             |   34 ++
 include/trace/misc/nfs.h                                      |    3 
 include/uapi/linux/nfs.h                                      |    1 
 lib/crypto/aes.c                                              |    4 
 mm/ksm.c                                                      |  126 ++++++++--
 net/bpf/test_run.c                                            |   60 +++-
 net/bridge/br_vlan_tunnel.c                                   |   11 
 net/can/j1939/transport.c                                     |    2 
 net/ceph/messenger_v2.c                                       |    2 
 net/ceph/mon_client.c                                         |    2 
 net/ceph/osd_client.c                                         |   14 -
 net/ceph/osdmap.c                                             |   24 +
 net/core/skbuff.c                                             |    8 
 net/core/sock.c                                               |    7 
 net/ipv4/arp.c                                                |    7 
 net/ipv4/ip_output.c                                          |   15 -
 net/ipv4/ping.c                                               |    4 
 net/netfilter/nf_conncount.c                                  |    2 
 net/netfilter/nf_tables_api.c                                 |   72 +++++
 net/netfilter/nft_synproxy.c                                  |    6 
 net/sched/sch_qfq.c                                           |    2 
 net/tls/tls_device.c                                          |   18 -
 net/wireless/wext-core.c                                      |    4 
 net/wireless/wext-priv.c                                      |    4 
 sound/ac97/bus.c                                              |   32 +-
 sound/soc/amd/yc/acp6x-mach.c                                 |    7 
 sound/soc/fsl/fsl_sai.c                                       |    3 
 sound/usb/quirks.c                                            |   10 
 tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c      |   96 +++++++
 tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c |    4 
 tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c |    8 
 98 files changed, 1057 insertions(+), 527 deletions(-)

Alex Deucher (1):
      drm/radeon: Remove __counted_by from ClockInfoArray.clockInfo[]

Alexander Stein (1):
      ASoC: fsl_sai: Add missing registers to cache default

Alexander Sverdlin (1):
      counter: interrupt-cnt: Drop IRQF_NO_THREAD flag

Alexander Usyskin (1):
      mei: me: add nova lake point S DID

Alexandre Knecht (1):
      bridge: fix C-VLAN preservation in 802.1ad vlan_tunnel egress

Alok Tiwari (1):
      net: marvell: prestera: fix NULL dereference on devlink_alloc() failure

Amery Hung (2):
      bpf: Make variables in bpf_prog_test_run_xdp less confusing
      bpf: Support specifying linear xdp packet data size for BPF_PROG_TEST_RUN

Andrew Elantsev (1):
      ASoC: amd: yc: Add quirk for Honor MagicBook X16 2025

Andy Shevchenko (2):
      gpio: pca953x: Utilise dev_err_probe() where it makes sense
      gpio: pca953x: Utilise temporary variable for struct device

Bartosz Golaszewski (2):
      gpio: rockchip: mark the GPIO controller as sleeping
      pinctrl: qcom: lpass-lpi: mark the GPIO controller as sleeping

Björn Töpel (2):
      riscv: uprobes: Add missing fence.i after building the XOL buffer
      riscv: Replace function-like macro by static inline function

Borislav Petkov (AMD) (1):
      x86/microcode/AMD: Select which microcode patch to load

Brian Kao (1):
      scsi: ufs: core: Fix EH failure after W-LUN resume error

Charlene Liu (1):
      drm/amd/display: Fix DP no audio issue

Chen Hanxiao (1):
      NFS: trace: show TIMEDOUT instead of 0x6e

ChenXiaoSong (3):
      smb/client: fix NT_STATUS_UNABLE_TO_FREE_VM value
      smb/client: fix NT_STATUS_DEVICE_DOOR_OPEN value
      smb/client: fix NT_STATUS_NO_DATA_DETECTED value

Chuck Lever (2):
      NFSD: NFSv4 file creation neglects setting ACL
      NFSD: Remove NFSERR_EAGAIN

Di Zhu (1):
      netdev: preserve NETIF_F_ALL_FOR_ALL across TSO updates

Eric Biggers (1):
      lib/crypto: aes: Fix missing MMU protection for AES S-box

Eric Dumazet (2):
      wifi: avoid kernel-infoleak from struct iw_point
      arp: do not assume dev_hard_header() does not change skb->head

Ernest Van Hoecke (1):
      gpio: pca953x: handle short interrupt pulses on PCAL devices

Fernando Fernandez Mancera (2):
      netfilter: nft_synproxy: avoid possible data-race on update operation
      netfilter: nf_conncount: update last_gc only when GC has been performed

Filipe Manana (1):
      btrfs: always detect conflicting inodes when logging inode refs

Florian Westphal (1):
      netfilter: nf_tables: avoid chain re-validation if possible

Gal Pressman (1):
      net/mlx5e: Don't print error message due to invalid module

Greg Kroah-Hartman (1):
      Linux 6.6.121

Haibo Chen (1):
      arm64: dts: add off-on-delay-us for usdhc2 regulator

Haotian Zhang (1):
      counter: 104-quad-8: Fix incorrect return value in IRQ handler

Haoxiang Li (1):
      ALSA: ac97: fix a double free in snd_ac97_controller_register()

Hengqi Chen (1):
      LoongArch: Add more instruction opcodes and emit_* helpers

Ian Ray (1):
      ARM: dts: imx6q-ba16: fix RTC interrupt level

Ilya Dryomov (3):
      libceph: replace overzealous BUG_ON in osdmap_apply_incremental()
      libceph: return the handler error from mon_handle_auth_done()
      libceph: make calc_target() set t->paused, not just clear it

Jeff Layton (1):
      nfsd: convert to new timestamp accessors

Jerry Wu (1):
      net: mscc: ocelot: Fix crash when adding interface under a lag

Jussi Laako (1):
      ALSA: usb-audio: Update for native DSD support quirks

Kuniyuki Iwashima (1):
      tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().

Marek Vasut (1):
      arm64: dts: imx8mp: Fix LAN8740Ai PHY reference clock on DH electronics i.MX8M Plus DHCOM

Miaoqian Lin (1):
      drm/pl111: Fix error handling in pl111_amba_probe

Michal Rábek (1):
      scsi: sg: Fix occasional bogus elapsed time that exceeds timeout

Mike Snitzer (1):
      nfs_common: factor out nfs_errtbl and nfs_stat_to_errno

Mikulas Patocka (1):
      dm-snapshot: fix 'scheduling while atomic' on real-time kernels

Mohammad Heib (1):
      net: fix memory leak in skb_segment_list for GRO packets

NeilBrown (1):
      nfsd: provide locking for v4_end_grace

Pedro Demarchi Gomes (1):
      ksm: use range-walk function to jump over holes in scan_get_next_rmap_item

Petko Manolov (1):
      net: usb: pegasus: fix memory leak in update_eth_regs_async()

Potin Lai (1):
      gpio: pca953x: Add support for level-triggered interrupts

René Rebe (1):
      HID: quirks: work around VID/PID conflict for appledisplay

Sam Edwards (1):
      libceph: reset sparse-read state in osd_fault()

Sam James (1):
      alpha: don't reference obsolete termio struct for TC* constants

Sascha Hauer (1):
      gpio: pca953x: fix wrong error probe return value

Scott Mayhew (2):
      NFSD: Fix permission check for read access to executable-only files
      NFSv4: ensure the open stateid seqid doesn't go backwards

Sebastian Andrzej Siewior (1):
      ARM: 9461/1: Disable HIGHPTE on PREEMPT_RT kernels

Sharath Chandra Vurukala (1):
      net: Add locking to protect skb->dev access in ip_output

Shardul Bankar (1):
      bpf: test_run: Fix ctx leak in bpf_prog_test_run_xdp error path

Srijit Bose (1):
      bnxt_en: Fix potential data corruption with HW GRO/LRO

Stephen Smalley (1):
      nfsd: set security label during create operations

Sumeet Pawnikar (2):
      powercap: fix race condition in register_control_type()
      powercap: fix sscanf() error return value handling

Takashi Iwai (1):
      ALSA: ac97bus: Use guard() for mutex locks

Tetsuo Handa (2):
      bpf: Fix reference count leak in bpf_prog_test_run_xdp()
      can: j1939: make j1939_session_activate() fail if device is no longer registered

Thomas Fourier (2):
      atm: Fix dma_free_coherent() size
      net: 3com: 3c59x: fix possible null dereference in vortex_probe1()

Toke Høiland-Jørgensen (1):
      bpf, test_run: Subtract size of xdp_frame from allowed metadata size

Trond Myklebust (2):
      nfsd: Fix NFSv3 atomicity bugs in nfsd_setattr()
      NFS: Fix up the automount fs_context to use the correct cred

Tuo Li (1):
      libceph: make free_choose_arg_map() resilient to partial allocation

Wei Fang (1):
      net: enetc: fix build warning when PAGE_SIZE is greater than 128K

Weiming Shi (1):
      net: sock: fix hardened usercopy panic in sock_recv_errqueue

Wen Xiong (1):
      scsi: ipr: Enable/disable IRQD_NO_BALANCING during reset

Xiang Mei (1):
      net/sched: sch_qfq: Fix NULL deref when deactivating inactive aggregate in qfq_reset

Xingui Yang (1):
      scsi: Revert "scsi: libsas: Fix exp-attached device scan after probe failure scanned in again after probe failed"

Yang Li (1):
      csky: fix csky_cmpxchg_fixup not working

Yonghong Song (1):
      bpf: Fix an issue in bpf_prog_test_run_xdp when page size greater than 4K

Zilin Guan (2):
      netfilter: nf_tables: fix memory leak in nf_tables_newrule()
      net: wwan: iosm: Fix memory leak in ipc_mux_deinit()

yuan.gao (1):
      inet: ping: Fix icmp out counting

ziming zhang (1):
      libceph: prevent potential out-of-bounds reads in handle_auth_done()


