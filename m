Return-Path: <stable+bounces-192051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AFDC28FE9
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 14:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE793A52EA
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 13:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9330F212B3D;
	Sun,  2 Nov 2025 13:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W9H4i/rK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7351E98E3;
	Sun,  2 Nov 2025 13:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762091194; cv=none; b=if2MkPHtDmn5AuIGJ2MFrwxTnkixIlQASAEjS/uZZya7/CxfaHgLgtjnBhnpWQDfYdcmAbCTPGxI8lJm0WcHSB1/lY5SZRSO1foaWMNYjQTgVLBiS4hJTzkgkh14S31TkQp8aXDvZHOClcLkCwklfO6zkCvPhdTdS/j08s/thOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762091194; c=relaxed/simple;
	bh=/ZlpRyVu6W1qt+rhyAVSSBJWpuMFSLVXTEzN50xpyZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eide1o2+uqKqucaH3Xd0wHkwaibrk7yDgFPBdqPnJXLG318rUgpZBrdNJzGHdq23q4nHz5KHLH7MVzwJvcBry7Z+VpPLNW6lJmcZwvGNLJVz+aArfxiyK+yX9+oebhMXNtO9I0balLLHQtD5xjCbC1Tah+gzemKKbh7sYsR5iDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W9H4i/rK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D851DC4CEF7;
	Sun,  2 Nov 2025 13:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762091194;
	bh=/ZlpRyVu6W1qt+rhyAVSSBJWpuMFSLVXTEzN50xpyZU=;
	h=From:To:Cc:Subject:Date:From;
	b=W9H4i/rKtVN8EDjpx2N4UnLVnJkbLh719OjY37Z/XZHWg1rr19fIZD3FlQJehQIXG
	 fZm9Bma5ltpWVMa6FD1EFs7ebQgOpMYFR8yOvdqVDT51UqhUW4DY2zHrc8Bw+5LP8l
	 SldHN9muc0nfUyrave0o88ddtNviMoUQWiC9ZbxA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.17.7
Date: Sun,  2 Nov 2025 22:46:21 +0900
Message-ID: <2025110222-sizzling-underarm-ae35@gregkh>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.17.7 kernel.

All users of the 6.17 kernel series must upgrade.

The updated 6.17.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.17.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/hw-vuln/attack_vector_controls.rst |    1 
 Makefile                                                     |    2 
 arch/alpha/kernel/asm-offsets.c                              |    1 
 arch/arc/kernel/asm-offsets.c                                |    1 
 arch/arm/kernel/asm-offsets.c                                |    2 
 arch/arm64/kernel/asm-offsets.c                              |    1 
 arch/csky/kernel/asm-offsets.c                               |    1 
 arch/hexagon/kernel/asm-offsets.c                            |    1 
 arch/loongarch/kernel/asm-offsets.c                          |    2 
 arch/m68k/kernel/asm-offsets.c                               |    1 
 arch/microblaze/kernel/asm-offsets.c                         |    1 
 arch/mips/kernel/asm-offsets.c                               |    2 
 arch/nios2/kernel/asm-offsets.c                              |    1 
 arch/openrisc/kernel/asm-offsets.c                           |    1 
 arch/parisc/kernel/asm-offsets.c                             |    1 
 arch/powerpc/kernel/asm-offsets.c                            |    1 
 arch/riscv/kernel/asm-offsets.c                              |    1 
 arch/s390/kernel/asm-offsets.c                               |    1 
 arch/sh/kernel/asm-offsets.c                                 |    1 
 arch/sparc/kernel/asm-offsets.c                              |    1 
 arch/um/kernel/asm-offsets.c                                 |    2 
 arch/x86/events/intel/core.c                                 |   10 
 arch/x86/include/asm/perf_event.h                            |    6 
 arch/x86/kernel/cpu/bugs.c                                   |   27 
 arch/x86/kvm/pmu.h                                           |    2 
 arch/xtensa/kernel/asm-offsets.c                             |    1 
 drivers/edac/edac_mc_sysfs.c                                 |   24 
 drivers/edac/ie31200_edac.c                                  |    4 
 fs/btrfs/disk-io.c                                           |    2 
 fs/btrfs/extent-tree.c                                       |    6 
 fs/btrfs/inode.c                                             |    7 
 fs/btrfs/scrub.c                                             |    3 
 fs/btrfs/transaction.c                                       |    2 
 fs/btrfs/tree-checker.c                                      |   37 
 fs/btrfs/tree-log.c                                          |   64 
 fs/btrfs/zoned.c                                             |    8 
 fs/btrfs/zoned.h                                             |    9 
 include/linux/audit.h                                        |    2 
 kernel/cgroup/cpuset.c                                       |    6 
 kernel/events/callchain.c                                    |   16 
 kernel/events/core.c                                         |    7 
 kernel/irq/chip.c                                            |    2 
 kernel/irq/manage.c                                          |    4 
 kernel/sched/build_policy.c                                  |    1 
 kernel/sched/ext.c                                           | 1056 ----------
 kernel/sched/ext.h                                           |   23 
 kernel/sched/ext_internal.h                                  | 1064 +++++++++++
 kernel/seccomp.c                                             |   32 
 kernel/time/timekeeping.c                                    |    2 
 tools/sched_ext/scx_qmap.bpf.c                               |   18 
 50 files changed, 1325 insertions(+), 1146 deletions(-)

Avadhut Naik (1):
      EDAC/mc_sysfs: Increase legacy channel support to 16

Charles Keepax (3):
      genirq/chip: Add buslock back in to irq_set_handler()
      genirq/manage: Add buslock back in to __disable_irq_nosync()
      genirq/manage: Add buslock back in to enable_irq()

Chen Ridong (1):
      cpuset: Use new excpus for nocpu error check when enabling root partition

Dan Carpenter (1):
      btrfs: tree-checker: fix bounds check in check_inode_extref()

Dapeng Mi (1):
      perf/x86/intel: Add ICL_FIXED_0_ADAPTIVE bit into INTEL_FIXED_BITS_MASK

David Kaplan (4):
      x86/bugs: Report correct retbleed mitigation status
      x86/bugs: Qualify RETBLEED_INTEL_MSG
      x86/bugs: Add attack vector controls for VMSCAPE
      x86/bugs: Fix reporting of LFENCE retpoline

Filipe Manana (6):
      btrfs: abort transaction on specific error places when walking log tree
      btrfs: abort transaction in the process_one_buffer() log tree walk callback
      btrfs: always drop log root tree reference in btrfs_replay_log()
      btrfs: use level argument in log tree walk callback replay_one_buffer()
      btrfs: abort transaction if we fail to update inode in log replay dir fixup
      btrfs: use smp_mb__after_atomic() when forcing COW in create_pending_snapshot()

Greg Kroah-Hartman (1):
      Linux 6.17.7

Haofeng Li (1):
      timekeeping: Fix aux clocks sysfs initialization loop bound

Jiri Olsa (1):
      seccomp: passthrough uprobe systemcall without filtering

Johannes Thumshirn (1):
      btrfs: zoned: return error from btrfs_zone_finish_endio()

Josh Poimboeuf (2):
      perf: Have get_perf_callchain() return NULL if crosstask and user are set
      perf: Skip user unwind if the task is a kernel thread

Kuan-Wei Chiu (1):
      EDAC: Fix wrong executable file modes for C source files

Kyle Manna (1):
      EDAC/ie31200: Add two more Intel Alder Lake-S SoCs for EDAC support

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

Tejun Heo (5):
      sched_ext: Move internal type and accessor definitions to ext_internal.h
      sched_ext: Put event_stats_cpu in struct scx_sched_pcpu
      sched_ext: Sync error_irq_work before freeing scx_sched
      sched_ext: Keep bypass on between enable failure and scx_disable_workfn()
      sched_ext: Make qmap dump operation non-destructive

Thorsten Blum (1):
      btrfs: scrub: replace max_t()/min_t() with clamp() in scrub_throttle_dev_io()


