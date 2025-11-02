Return-Path: <stable+bounces-192046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 118A3C28FC5
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 14:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141743AE3A8
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 13:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A742E18991E;
	Sun,  2 Nov 2025 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LxCI7RvB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6405913A265;
	Sun,  2 Nov 2025 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762091180; cv=none; b=uhW4/0Pv9IY+MM+4zXbrdRt3BSMe+iItoaIkJfomaPynUplMRfrcQdSaY4XtONcH2pWMhenOscwhJfknwxj8N/vKs/3+4CijPnV4+SEBFPvIrCOqyBbn3K+zYVnSBC7rufUhnjqZ3q+BqvNzCEN2r7yqnNa+M3Eyy2ViICryrzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762091180; c=relaxed/simple;
	bh=dVQnvW5I9/t0piGFu8Jk/J/+995dBTc6eUpEC5bsTc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U3M/v1ezyZYwE4lU4OSk5LdkBP40emzviy+5uLLe7wQ65iIsQPYkec6pPr5u/FfLrL8RGhCSBSRCWWPgllDYjL02eWoCsYFZGVHJPNHSDEYqaEG+1QhmmAFlgoln/lNGFcrxbr31IWQwdKPud+GHGswyAe1XPX64polqhqj5WQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LxCI7RvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E424FC4CEF7;
	Sun,  2 Nov 2025 13:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762091180;
	bh=dVQnvW5I9/t0piGFu8Jk/J/+995dBTc6eUpEC5bsTc4=;
	h=From:To:Cc:Subject:Date:From;
	b=LxCI7RvBI8Uo970ktzAkLC2MutrFJ8OLmNfoPDjq8hzcPE0jauj9nVYC2tr1g18gq
	 UTZ7oXBvSpsICcIfS7c+PWzj6stPPuihwXlviXv439xQ0/JEWUCSiKZ8l2XbP8sFk9
	 7VrCO4auSpB0SKQjGPjUkT0+E/KkWNl/GjLYWNyM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.116
Date: Sun,  2 Nov 2025 22:46:09 +0900
Message-ID: <2025110210-tarnish-nearly-cbfe@gregkh>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.116 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-bus-pci-drivers-xhci_hcd |   10 
 Makefile                                                 |    2 
 arch/alpha/kernel/asm-offsets.c                          |    1 
 arch/arc/kernel/asm-offsets.c                            |    1 
 arch/arm/kernel/asm-offsets.c                            |    2 
 arch/arm64/kernel/asm-offsets.c                          |    1 
 arch/csky/kernel/asm-offsets.c                           |    1 
 arch/hexagon/kernel/asm-offsets.c                        |    1 
 arch/loongarch/kernel/asm-offsets.c                      |    2 
 arch/m68k/kernel/asm-offsets.c                           |    1 
 arch/microblaze/kernel/asm-offsets.c                     |    1 
 arch/mips/kernel/asm-offsets.c                           |    2 
 arch/nios2/kernel/asm-offsets.c                          |    1 
 arch/openrisc/kernel/asm-offsets.c                       |    1 
 arch/parisc/kernel/asm-offsets.c                         |    1 
 arch/powerpc/kernel/asm-offsets.c                        |    1 
 arch/riscv/kernel/asm-offsets.c                          |    1 
 arch/s390/kernel/asm-offsets.c                           |    1 
 arch/sh/kernel/asm-offsets.c                             |    1 
 arch/sparc/kernel/asm-offsets.c                          |    1 
 arch/um/kernel/asm-offsets.c                             |    2 
 arch/x86/kernel/cpu/bugs.c                               |    9 
 arch/xtensa/kernel/asm-offsets.c                         |    1 
 drivers/edac/edac_mc_sysfs.c                             |   24 +
 drivers/gpio/gpio-idio-16.c                              |    5 
 drivers/gpio/gpio-regmap.c                               |   53 ++++
 drivers/tty/serial/sc16is7xx.c                           |  185 +++++++--------
 drivers/usb/host/xhci-dbgcap.c                           |   70 +++++
 drivers/usb/host/xhci-dbgcap.h                           |    7 
 fs/btrfs/disk-io.c                                       |    2 
 fs/btrfs/extent-tree.c                                   |    6 
 fs/btrfs/inode.c                                         |    7 
 fs/btrfs/scrub.c                                         |    3 
 fs/btrfs/transaction.c                                   |    2 
 fs/btrfs/tree-log.c                                      |    9 
 fs/btrfs/zoned.c                                         |    8 
 fs/btrfs/zoned.h                                         |    9 
 include/linux/audit.h                                    |    2 
 include/linux/bitops.h                                   |    1 
 include/linux/bits.h                                     |   38 ++-
 include/linux/gpio/regmap.h                              |   16 +
 include/net/pkt_sched.h                                  |   25 +-
 kernel/events/callchain.c                                |   16 -
 kernel/events/core.c                                     |    7 
 net/mptcp/pm_netlink.c                                   |    6 
 net/sched/sch_api.c                                      |   10 
 net/sched/sch_hfsc.c                                     |   16 -
 net/sched/sch_qfq.c                                      |    2 
 tools/testing/selftests/net/mptcp/mptcp_join.sh          |    3 
 49 files changed, 404 insertions(+), 173 deletions(-)

Avadhut Naik (1):
      EDAC/mc_sysfs: Increase legacy channel support to 16

David Kaplan (2):
      x86/bugs: Report correct retbleed mitigation status
      x86/bugs: Fix reporting of LFENCE retpoline

Filipe Manana (3):
      btrfs: always drop log root tree reference in btrfs_replay_log()
      btrfs: use level argument in log tree walk callback replay_one_buffer()
      btrfs: use smp_mb__after_atomic() when forcing COW in create_pending_snapshot()

Geliang Tang (1):
      selftests: mptcp: disable add_addr retrans in endpoint_tests

Greg Kroah-Hartman (1):
      Linux 6.6.116

Hugo Villeneuve (4):
      serial: sc16is7xx: remove unused to_sc16is7xx_port macro
      serial: sc16is7xx: reorder code to remove prototype declarations
      serial: sc16is7xx: refactor EFR lock
      serial: sc16is7xx: remove useless enable of enhanced features

Ioana Ciornei (1):
      gpio: regmap: add the .fixed_direction_output configuration parameter

Johannes Thumshirn (1):
      btrfs: zoned: return error from btrfs_zone_finish_endio()

Josh Poimboeuf (2):
      perf: Have get_perf_callchain() return NULL if crosstask and user are set
      perf: Skip user unwind if the task is a kernel thread

Mathias Nyman (4):
      xhci: dbc: poll at different rate depending on data transfer activity
      xhci: dbc: Improve performance by removing delay in transfer event polling.
      xhci: dbc: Avoid event polling busyloop if pending rx transfers are inactive.
      xhci: dbc: fix bogus 1024 byte prefix if ttyDBC read races with stall event

Mathieu Dubois-Briand (1):
      gpio: regmap: Allow to allocate regmap-irq device

Matthieu Baerts (NGI0) (2):
      mptcp: pm: in-kernel: C-flag: handle late ADD_ADDR
      selftests: mptcp: join: mark 'delete re-add signal' as skipped if not supported

Menglong Dong (1):
      arch: Add the macro COMPILE_OFFSETS to all the asm-offsets.c

Naohiro Aota (1):
      btrfs: zoned: refine extent allocator hint selection

Richard Guy Briggs (1):
      audit: record fanotify event regardless of presence of rules

Steven Rostedt (1):
      perf: Use current->flags & PF_KTHREAD|PF_USER_WORKER instead of current->mm == NULL

Thorsten Blum (1):
      btrfs: scrub: replace max_t()/min_t() with clamp() in scrub_throttle_dev_io()

Uday M Bhat (1):
      xhci: dbc: Allow users to modify DbC poll interval via sysfs

Vincent Mailhol (2):
      bits: add comments and newlines to #if, #else and #endif directives
      bits: introduce fixed-type GENMASK_U*()

William Breathitt Gray (1):
      gpio: idio-16: Define fixed direction of the GPIO lines

Xiang Mei (1):
      net/sched: sch_qfq: Fix null-deref in agg_dequeue


