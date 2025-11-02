Return-Path: <stable+bounces-192048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC156C28FDD
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 14:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009D53AE8AE
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 13:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10021A23A5;
	Sun,  2 Nov 2025 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vmbbJTJP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9371E72629;
	Sun,  2 Nov 2025 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762091185; cv=none; b=US/O+yfv/0aNoihXcOjxc2SpJP5peP8C/qbgcSDbe6BgaJksz66A5rGQzyZJheS8RdPT2gOoferxmfo5rfcnCCnOqy6xiBhH3mT6+10ZAYehDl35Ev7gsKUP+KINfR9GD/LajYTwEmFVyRioidyJ+5jomprBVDPyP8zRNOwKnE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762091185; c=relaxed/simple;
	bh=jAPPsYWvZZiGP189F1xwcChVMhlCGHFigc1QhsDVbVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MoFQaqAjbx3vIbnxGlLXUH2HShL5z0xg1xF7LHvcMY12iQeGhQ1khPhhPcP/dZwGXqdfVfAIazNPxGsKBMNupGHuTk0aeHPy3ZSOo9hRf9URhp4b+zdoqU5cBGU5bnd6qFSHubV+/vIfbZ3NlahcpBr3K9vuyu9o/8RI0TGVVT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vmbbJTJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30273C4CEF7;
	Sun,  2 Nov 2025 13:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762091185;
	bh=jAPPsYWvZZiGP189F1xwcChVMhlCGHFigc1QhsDVbVk=;
	h=From:To:Cc:Subject:Date:From;
	b=vmbbJTJP1HTratgcgIjAzo5qPHWvXfVs0X/F/e4HBejHdqenIjtw0GEJBNKq0MBRT
	 c3DhSZV47rCmZGOAwtvuFB2+wBM3rkUoQIoLNhr3qaPzXSXzTOfB8TXPpbpV+e/9/q
	 /HfNijXnCz9xCQLyty2fAo6TuaD+AkX9D/ap0n60=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.57
Date: Sun,  2 Nov 2025 22:46:15 +0900
Message-ID: <2025110216-impulsive-briskly-9820@gregkh>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.57 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/sphinx/kernel_abi.py              |    4 +
 Documentation/sphinx/kernel_feat.py             |    4 +
 Documentation/sphinx/kernel_include.py          |    6 +-
 Documentation/sphinx/maintainers_include.py     |    4 +
 Makefile                                        |    2 
 arch/alpha/kernel/asm-offsets.c                 |    1 
 arch/arc/kernel/asm-offsets.c                   |    1 
 arch/arm/kernel/asm-offsets.c                   |    2 
 arch/arm64/kernel/asm-offsets.c                 |    1 
 arch/csky/kernel/asm-offsets.c                  |    1 
 arch/hexagon/kernel/asm-offsets.c               |    1 
 arch/loongarch/kernel/asm-offsets.c             |    2 
 arch/m68k/kernel/asm-offsets.c                  |    1 
 arch/microblaze/kernel/asm-offsets.c            |    1 
 arch/mips/kernel/asm-offsets.c                  |    2 
 arch/nios2/kernel/asm-offsets.c                 |    1 
 arch/openrisc/kernel/asm-offsets.c              |    1 
 arch/parisc/kernel/asm-offsets.c                |    1 
 arch/powerpc/kernel/asm-offsets.c               |    1 
 arch/riscv/kernel/asm-offsets.c                 |    1 
 arch/s390/kernel/asm-offsets.c                  |    1 
 arch/sh/kernel/asm-offsets.c                    |    1 
 arch/sparc/kernel/asm-offsets.c                 |    1 
 arch/um/kernel/asm-offsets.c                    |    2 
 arch/x86/events/intel/core.c                    |   10 +--
 arch/x86/include/asm/perf_event.h               |    6 +-
 arch/x86/kernel/cpu/bugs.c                      |    9 +--
 arch/x86/kvm/pmu.h                              |    2 
 arch/xtensa/kernel/asm-offsets.c                |    1 
 drivers/dma-buf/udmabuf.c                       |    2 
 drivers/edac/edac_mc_sysfs.c                    |   24 +++++++++
 drivers/gpio/gpio-idio-16.c                     |    5 +
 drivers/gpio/gpio-regmap.c                      |   53 ++++++++++++++++++-
 drivers/iommu/intel/iommu.c                     |    7 +-
 drivers/net/bonding/bond_main.c                 |   11 ++--
 drivers/net/bonding/bond_options.c              |    3 +
 drivers/net/ethernet/sfc/ef100_netdev.c         |    6 +-
 drivers/net/ethernet/sfc/ef100_nic.c            |   47 +++++++----------
 drivers/net/wireless/ath/ath12k/mac.c           |    6 +-
 fs/btrfs/disk-io.c                              |    2 
 fs/btrfs/extent-tree.c                          |    6 +-
 fs/btrfs/inode.c                                |    7 +-
 fs/btrfs/scrub.c                                |    3 -
 fs/btrfs/transaction.c                          |    2 
 fs/btrfs/tree-checker.c                         |   37 +++++++++++++
 fs/btrfs/tree-log.c                             |   64 ++++++++++++++++++------
 fs/btrfs/zoned.c                                |    8 +--
 fs/btrfs/zoned.h                                |    9 ++-
 fs/f2fs/file.c                                  |    8 +--
 fs/f2fs/segment.c                               |   20 +++----
 include/linux/audit.h                           |    2 
 include/linux/bitops.h                          |    1 
 include/linux/bits.h                            |   38 +++++++++++++-
 include/linux/gpio/regmap.h                     |   16 ++++++
 include/net/bonding.h                           |    1 
 include/net/pkt_sched.h                         |   25 +++++++++
 kernel/cgroup/cpuset.c                          |    6 --
 kernel/events/callchain.c                       |   16 +++---
 kernel/events/core.c                            |    7 +-
 kernel/seccomp.c                                |   32 +++++++++---
 net/mptcp/pm_netlink.c                          |    6 ++
 net/sched/sch_api.c                             |   10 ---
 net/sched/sch_hfsc.c                            |   16 ------
 net/sched/sch_qfq.c                             |    2 
 net/wireless/reg.c                              |    4 +
 tools/sched_ext/scx_qmap.bpf.c                  |   18 ++++++
 tools/testing/selftests/net/mptcp/mptcp_join.sh |    3 -
 67 files changed, 441 insertions(+), 163 deletions(-)

Aditya Kumar Singh (1):
      wifi: ath12k: fix read pointer after free in ath12k_mac_assign_vif_to_vdev()

Alexander Wetzel (1):
      wifi: cfg80211: Add missing lock in cfg80211_check_and_end_cac()

Avadhut Naik (1):
      EDAC/mc_sysfs: Increase legacy channel support to 16

Chao Yu (1):
      f2fs: fix to avoid panic once fallocation fails for pinfile

Chen Ridong (1):
      cpuset: Use new excpus for nocpu error check when enabling root partition

Dan Carpenter (1):
      btrfs: tree-checker: fix bounds check in check_inode_extref()

Dapeng Mi (1):
      perf/x86/intel: Add ICL_FIXED_0_ADAPTIVE bit into INTEL_FIXED_BITS_MASK

David Kaplan (2):
      x86/bugs: Report correct retbleed mitigation status
      x86/bugs: Fix reporting of LFENCE retpoline

Edward Cree (1):
      sfc: fix NULL dereferences in ef100_process_design_param()

Filipe Manana (6):
      btrfs: abort transaction on specific error places when walking log tree
      btrfs: abort transaction in the process_one_buffer() log tree walk callback
      btrfs: always drop log root tree reference in btrfs_replay_log()
      btrfs: use level argument in log tree walk callback replay_one_buffer()
      btrfs: abort transaction if we fail to update inode in log replay dir fixup
      btrfs: use smp_mb__after_atomic() when forcing COW in create_pending_snapshot()

Geliang Tang (1):
      selftests: mptcp: disable add_addr retrans in endpoint_tests

Greg Kroah-Hartman (1):
      Linux 6.12.57

Hangbin Liu (1):
      bonding: return detailed error when loading native XDP fails

Ioana Ciornei (1):
      gpio: regmap: add the .fixed_direction_output configuration parameter

Jiri Olsa (1):
      seccomp: passthrough uprobe systemcall without filtering

Johannes Thumshirn (1):
      btrfs: zoned: return error from btrfs_zone_finish_endio()

Jonathan Corbet (1):
      docs: kdoc: handle the obsolescensce of docutils.ErrorString()

Josh Poimboeuf (2):
      perf: Have get_perf_callchain() return NULL if crosstask and user are set
      perf: Skip user unwind if the task is a kernel thread

Kees Bakker (1):
      iommu/vt-d: Avoid use of NULL after WARN_ON_ONCE

Mathieu Dubois-Briand (1):
      gpio: regmap: Allow to allocate regmap-irq device

Matthieu Baerts (NGI0) (2):
      selftests: mptcp: join: mark 'delete re-add signal' as skipped if not supported
      mptcp: pm: in-kernel: C-flag: handle late ADD_ADDR

Menglong Dong (1):
      arch: Add the macro COMPILE_OFFSETS to all the asm-offsets.c

Naohiro Aota (1):
      btrfs: zoned: refine extent allocator hint selection

Qu Wenruo (1):
      btrfs: tree-checker: add inode extref checks

Richard Guy Briggs (1):
      audit: record fanotify event regardless of presence of rules

Steven Rostedt (1):
      perf: Use current->flags & PF_KTHREAD|PF_USER_WORKER instead of current->mm == NULL

Tejun Heo (1):
      sched_ext: Make qmap dump operation non-destructive

Thorsten Blum (1):
      btrfs: scrub: replace max_t()/min_t() with clamp() in scrub_throttle_dev_io()

Vincent Mailhol (2):
      bits: add comments and newlines to #if, #else and #endif directives
      bits: introduce fixed-type GENMASK_U*()

Wang Liang (1):
      bonding: check xdp prog when set bond mode

William Breathitt Gray (1):
      gpio: idio-16: Define fixed direction of the GPIO lines

Xiang Mei (1):
      net/sched: sch_qfq: Fix null-deref in agg_dequeue

Xiaogang Chen (1):
      udmabuf: fix a buf size overflow issue during udmabuf creation


