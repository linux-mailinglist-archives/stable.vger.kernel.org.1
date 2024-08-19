Return-Path: <stable+bounces-69446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7433956276
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 06:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5D92814C8
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 04:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D401F14D29A;
	Mon, 19 Aug 2024 04:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fBh5Hskp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D6B14C5BF;
	Mon, 19 Aug 2024 04:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724040802; cv=none; b=eOUU2KTgZgHrU3g1xt+Vk0Ws2U87i1JP/jg8Q5XuRHAjLbkzIG5uvlpH4LO1v3p1lMPOQ9pnWgRAqmVJ+YPTgTXke+YFwgFuGkAAVDOqKEq8FdLF0sxpmpTdR5dajI8DqOJoeZBZj5R3fO3TYQnSE4MpXsFHglgGBQmZSdK4Q6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724040802; c=relaxed/simple;
	bh=LP2gZ4aZllC58L7XXsW+1rVytXnlRbevOQ3lKWNAGkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U2TCt1qw4rjeW4eWuUDey2fY2C/zm3Xa1nymTRvg0OdaNAKfwUENk9R88adIwLIfb85TEzgDBTmp2bw8kZ+Wh0INw7KvGU5NNXRv2wCV1718SCv4M7Loz1l2DZvmMO7jIivwheCJvOG3Wi5VTUPGTJiUBDFvBOJXJlRV5enQqOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fBh5Hskp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A090AC4AF10;
	Mon, 19 Aug 2024 04:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724040802;
	bh=LP2gZ4aZllC58L7XXsW+1rVytXnlRbevOQ3lKWNAGkw=;
	h=From:To:Cc:Subject:Date:From;
	b=fBh5HskpMO0x4Gg8zWfEQ3pf90YwEGA9gyVayTGr1ktR1Iz+Pmap3/MnSQHu3s6Y5
	 PASm4MYmaf8ZKgMLn0auvdQJBe6GUY558VCTluqJsLjxBJhlaP3Zg0wEiO3sShBDhJ
	 5k4AlkNbFFVV2YqtEF6bWoYFpMHs2vzgFF3S4j0s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.47
Date: Mon, 19 Aug 2024 06:13:08 +0200
Message-ID: <2024081908-bath-greedily-2e38@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.47 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/bpf/map_lpm_trie.rst               |    2 
 Documentation/mm/page_table_check.rst            |    9 
 Makefile                                         |    2 
 arch/arm64/kvm/hyp/pgtable.c                     |   12 -
 arch/loongarch/include/uapi/asm/unistd.h         |    1 
 arch/x86/include/asm/pgtable.h                   |   18 -
 drivers/ata/libata-scsi.c                        |   15 +
 drivers/isdn/mISDN/socket.c                      |   10 
 drivers/media/usb/dvb-usb/dvb-usb-init.c         |   35 ---
 drivers/net/ppp/pppoe.c                          |   23 --
 drivers/nvme/host/pci.c                          |    7 
 fs/binfmt_flat.c                                 |    4 
 fs/buffer.c                                      |    2 
 fs/cramfs/inode.c                                |    2 
 fs/erofs/decompressor.c                          |    8 
 fs/exec.c                                        |    8 
 fs/ext4/inode.c                                  |   24 +-
 fs/ext4/xattr.c                                  |  155 ++++++--------
 fs/f2fs/extent_cache.c                           |   48 +---
 fs/f2fs/f2fs.h                                   |    2 
 fs/f2fs/gc.c                                     |   10 
 fs/f2fs/inode.c                                  |   10 
 fs/fhandle.c                                     |    6 
 fs/jfs/jfs_dmap.c                                |    2 
 fs/jfs/jfs_dtree.c                               |    2 
 fs/jfs/jfs_logmgr.c                              |   33 +--
 fs/jfs/jfs_logmgr.h                              |    2 
 fs/jfs/jfs_mount.c                               |    3 
 fs/lockd/svc.c                                   |    3 
 fs/nfs/callback.c                                |    3 
 fs/nfsd/cache.h                                  |    2 
 fs/nfsd/export.c                                 |   32 ++
 fs/nfsd/export.h                                 |    4 
 fs/nfsd/netns.h                                  |   25 +-
 fs/nfsd/nfs4proc.c                               |    6 
 fs/nfsd/nfs4state.c                              |    3 
 fs/nfsd/nfscache.c                               |   40 ---
 fs/nfsd/nfsctl.c                                 |   16 -
 fs/nfsd/nfsd.h                                   |    1 
 fs/nfsd/nfsfh.c                                  |    3 
 fs/nfsd/nfssvc.c                                 |   14 -
 fs/nfsd/stats.c                                  |   54 ++--
 fs/nfsd/stats.h                                  |   90 +++-----
 fs/nfsd/vfs.c                                    |    6 
 fs/ntfs3/frecord.c                               |   75 ++++++
 fs/quota/quota_tree.c                            |  128 ++++++++---
 fs/quota/quota_v2.c                              |   15 -
 fs/reiserfs/stree.c                              |    2 
 fs/romfs/super.c                                 |    2 
 fs/squashfs/block.c                              |    2 
 fs/squashfs/file.c                               |    3 
 fs/squashfs/file_direct.c                        |    6 
 fs/super.c                                       |   15 -
 include/linux/cgroup-defs.h                      |    7 
 include/linux/fs.h                               |    3 
 include/linux/sockptr.h                          |   25 ++
 include/linux/sunrpc/svc.h                       |    5 
 include/uapi/linux/bpf.h                         |   19 +
 kernel/bpf/lpm_trie.c                            |   33 +--
 kernel/cgroup/cgroup-internal.h                  |    3 
 kernel/cgroup/cgroup.c                           |   23 +-
 kernel/irq/cpuhotplug.c                          |   27 ++
 kernel/irq/manage.c                              |   12 -
 mm/debug_vm_pgtable.c                            |   31 --
 mm/gup.c                                         |  251 +++++++++++------------
 mm/huge_memory.c                                 |    6 
 mm/hugetlb.c                                     |    2 
 mm/internal.h                                    |    4 
 mm/page_table_check.c                            |   30 ++
 net/bluetooth/rfcomm/sock.c                      |   14 -
 net/core/filter.c                                |    8 
 net/ipv4/fou_core.c                              |    2 
 net/ipv4/tcp_metrics.c                           |    7 
 net/mac80211/iface.c                             |   27 ++
 net/nfc/llcp_sock.c                              |   12 -
 net/rds/recv.c                                   |   13 +
 net/sched/sch_generic.c                          |    5 
 net/sctp/inqueue.c                               |   14 -
 net/sunrpc/stats.c                               |    2 
 net/sunrpc/svc.c                                 |   39 ++-
 net/wireless/nl80211.c                           |    6 
 samples/bpf/map_perf_test_user.c                 |    2 
 samples/bpf/xdp_router_ipv4_user.c               |    2 
 sound/soc/soc-topology.c                         |   32 --
 sound/usb/mixer.c                                |    7 
 tools/include/uapi/linux/bpf.h                   |   19 +
 tools/testing/selftests/bpf/progs/map_ptr_kern.c |    2 
 tools/testing/selftests/bpf/test_lpm_map.c       |   18 -
 tools/testing/selftests/net/tls.c                |   14 +
 89 files changed, 1003 insertions(+), 728 deletions(-)

Alexei Starovoitov (1):
      bpf: Avoid kfree_rcu() under lock in bpf_lpm_trie.

Allison Henderson (1):
      net:rds: Fix possible deadlock in rds_message_put

Amadeusz Sławiński (2):
      ASoC: topology: Clean up route loading
      ASoC: topology: Fix route memory corruption

Chao Yu (2):
      f2fs: fix to do sanity check on F2FS_INLINE_DATA flag in inode during GC
      f2fs: fix to cover read extent cache access with lock

Chuck Lever (2):
      NFSD: Rewrite synopsis of nfsd_percpu_counters_init()
      NFSD: Fix frame size warning in svc_export_parse()

Dave Kleikamp (1):
      Revert "jfs: fix shift-out-of-bounds in dbJoin"

David Stevens (1):
      genirq/cpuhotplug: Skip suspended interrupts when restoring affinity

Dmitry Antipov (1):
      net: sctp: fix skb leak in sctp_inq_free()

Dongli Zhang (1):
      genirq/cpuhotplug: Retry with cpu_online_mask when migration fails

Edward Adam Davis (2):
      reiserfs: fix uninit-value in comp_keys
      jfs: fix null ptr deref in dtInsertEntry

Eric Dumazet (5):
      tcp_metrics: optimize tcp_metrics_flush_all()
      mISDN: fix MISDN_TIME_STAMP handling
      net: add copy_safe_from_sockptr() helper
      nfc: llcp: fix nfc_llcp_setsockopt() unsafe copies
      wifi: cfg80211: restrict NL80211_ATTR_TXQ_QUANTUM values

Gao Xiang (1):
      erofs: avoid debugging output for (de)compressed data

Gavrilov Ilia (1):
      pppoe: Fix memory leak in pppoe_sendmsg()

Greg Kroah-Hartman (1):
      Linux 6.6.47

Gustavo A. R. Silva (1):
      fs: Annotate struct file_handle with __counted_by() and use struct_size()

Huacai Chen (1):
      LoongArch: Define __ARCH_WANT_NEW_STAT in unistd.h

Jakub Kicinski (1):
      net: don't dump stack on queue timeout

Jan Kara (5):
      fs: Convert to bdev_open_by_dev()
      jfs: Convert to bdev_open_by_dev()
      quota: Detect loops in quota tree
      ext4: fold quota accounting into ext4_xattr_inode_lookup_create()
      ext4: do not create EA inode under buffer lock

Javier Carrasco (2):
      Input: bcm5974 - check endpoint type before starting traffic
      Revert "Input: bcm5974 - check endpoint type before starting traffic"

Johannes Berg (2):
      wifi: mac80211: take wiphy lock for MAC addr change
      wifi: mac80211: fix change_address deadlock during unregister

John Fastabend (1):
      net: tls, add test to capture error on large splice

Josef Bacik (10):
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

Kees Cook (3):
      exec: Fix ToCToU between perm check and set-uid/gid usage
      bpf: Replace bpf_lpm_trie_key 0-length array with flexible array
      binfmt_flat: Fix corruption when not offsetting data start

Konstantin Komarov (1):
      fs/ntfs3: Do copy_to_user out of run_lock

Lizhi Xu (2):
      jfs: fix log->bdev_handle null ptr deref in lbmStartIO
      squashfs: squashfs_read_data need to check if the length is 0

Luiz Augusto von Dentz (1):
      Bluetooth: RFCOMM: Fix not validating setsockopt user input

Manas Ghandat (1):
      jfs: fix shift-out-of-bounds in dbJoin

Matthew Wilcox (Oracle) (1):
      ext4: convert ext4_da_do_write_end() to take a folio

Niklas Cassel (1):
      Revert "ata: libata-scsi: Honor the D_SENSE bit for CK_COND=1 and no error"

Pei Li (1):
      jfs: Fix shift-out-of-bounds in dbDiscardAG

Peter Xu (2):
      mm/page_table_check: support userfault wr-protect entries
      mm/debug_vm_pgtable: drop RANDOM_ORVALUE trick

Phillip Lougher (1):
      Squashfs: fix variable overflow triggered by sysbot

Sean Young (1):
      media: Revert "media: dvb-usb: Fix unexpected infinite loop in dvb_usb_read_remote_control()"

Takashi Iwai (1):
      ALSA: usb: Fix UBSAN warning in parse_audio_unit()

Waiman Long (1):
      cgroup: Move rcu_head up near the top of cgroup_root

WangYuli (1):
      nvme/pci: Add APST quirk for Lenovo N60z laptop

Will Deacon (2):
      KVM: arm64: Don't defer TLB invalidation when zapping table entries
      KVM: arm64: Don't pass a TLBI level hint when zapping table entries

Willem de Bruijn (1):
      fou: remove warn in gue_gro_receive on unsupported protocol

Wojciech Gładysz (1):
      ext4: sanity check for NULL pointer after ext4_force_shutdown

Yafang Shao (1):
      cgroup: Make operations on the cgroup root_list RCU safe

Yang Shi (1):
      mm: gup: stop abusing try_grab_folio

yunshui (1):
      bpf, net: Use DEV_STAT_INC()


