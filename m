Return-Path: <stable+bounces-210734-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMPcOH7CcGkNZwAAu9opvQ
	(envelope-from <stable+bounces-210734-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 13:11:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D87356917
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 13:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9795894B496
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 12:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9073C1FE6;
	Wed, 21 Jan 2026 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnuL+FVl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9307B3AEF46
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768997023; cv=none; b=XLktWt2RnQvh9Apu3def5QXgJrdKVOXoAzLJmbim8XBTlqsqWCXUMwMGwr71jaoYzRaqiZqg7TSqwAaAKVksoYYG4cXdS2i2OgjObAH6V1gx76DU1Gr7L+V9FJjbnYT+g8HnQDtB2G33clkB8Gv7FCgfKTVeMywuhDVVbllTwhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768997023; c=relaxed/simple;
	bh=1MMC6cUKFfLX1Hkl5w1J2SeQDthbH0pDvLF2S+0upDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TB6BSKKX1tIsYHTTfiLzp6ObBfg2N1Mb5hiGRA+R9keRBGF7IwPBihLG1/yCKqdDrLEDDdOGfrNp+HTuAB3nbkv878z/J3xybQD2FU2+twUq9VmVVETRnXDJ9Ny1DgDqv8sYYkMVmmJEt3ZKCDXkKH8CLLsiEI8z3QrTMEHhPwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnuL+FVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC3EC116D0;
	Wed, 21 Jan 2026 12:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768997023;
	bh=1MMC6cUKFfLX1Hkl5w1J2SeQDthbH0pDvLF2S+0upDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rnuL+FVldayHeleIwFb1FOQpcx1fuuzYSTfyuJ5I3RC/9F8cXc0RplXufbV0ILWHf
	 FACZ3H0ULwTOTQCYt/uSzf7DxQ942LB93cgOWy0ji5imH/zMH9P1s7E3Bz7w+RQw+s
	 aFCIyaR/xh0JJcpL3stpelw5gpBj6YILLWvSkr915AyRV/FLnwGoeuCdfX40KX7nk1
	 NmeiffQAqI7MIyo/uXkhPc2Gjoj7kZp5XiLs4ZMbDxOehk2isj9GJpCIujIKw4hHzj
	 shbT5R2PM3RIAWugLsJpLj3YacqmtRkMGY4UTyRAe42AArV/ERCTrXN0YRMWFf2NQ5
	 q9MlJRBKL19Og==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	kernel test robot <oliver.sang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/page_alloc: prevent pcp corruption with SMP=n
Date: Wed, 21 Jan 2026 07:03:39 -0500
Message-ID: <20260121120339.1504037-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012042-scorebook-jawed-016d@gregkh>
References: <2026012042-scorebook-jawed-016d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-210734-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 2D87356917
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Vlastimil Babka <vbabka@suse.cz>

[ Upstream commit 038a102535eb49e10e93eafac54352fcc5d78847 ]

The kernel test robot has reported:

 BUG: spinlock trylock failure on UP on CPU#0, kcompactd0/28
  lock: 0xffff888807e35ef0, .magic: dead4ead, .owner: kcompactd0/28, .owner_cpu: 0
 CPU: 0 UID: 0 PID: 28 Comm: kcompactd0 Not tainted 6.18.0-rc5-00127-ga06157804399 #1 PREEMPT  8cc09ef94dcec767faa911515ce9e609c45db470
 Call Trace:
  <IRQ>
  __dump_stack (lib/dump_stack.c:95)
  dump_stack_lvl (lib/dump_stack.c:123)
  dump_stack (lib/dump_stack.c:130)
  spin_dump (kernel/locking/spinlock_debug.c:71)
  do_raw_spin_trylock (kernel/locking/spinlock_debug.c:?)
  _raw_spin_trylock (include/linux/spinlock_api_smp.h:89 kernel/locking/spinlock.c:138)
  __free_frozen_pages (mm/page_alloc.c:2973)
  ___free_pages (mm/page_alloc.c:5295)
  __free_pages (mm/page_alloc.c:5334)
  tlb_remove_table_rcu (include/linux/mm.h:? include/linux/mm.h:3122 include/asm-generic/tlb.h:220 mm/mmu_gather.c:227 mm/mmu_gather.c:290)
  ? __cfi_tlb_remove_table_rcu (mm/mmu_gather.c:289)
  ? rcu_core (kernel/rcu/tree.c:?)
  rcu_core (include/linux/rcupdate.h:341 kernel/rcu/tree.c:2607 kernel/rcu/tree.c:2861)
  rcu_core_si (kernel/rcu/tree.c:2879)
  handle_softirqs (arch/x86/include/asm/jump_label.h:36 include/trace/events/irq.h:142 kernel/softirq.c:623)
  __irq_exit_rcu (arch/x86/include/asm/jump_label.h:36 kernel/softirq.c:725)
  irq_exit_rcu (kernel/softirq.c:741)
  sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1052)
  </IRQ>
  <TASK>
 RIP: 0010:_raw_spin_unlock_irqrestore (arch/x86/include/asm/preempt.h:95 include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194)
  free_pcppages_bulk (mm/page_alloc.c:1494)
  drain_pages_zone (include/linux/spinlock.h:391 mm/page_alloc.c:2632)
  __drain_all_pages (mm/page_alloc.c:2731)
  drain_all_pages (mm/page_alloc.c:2747)
  kcompactd (mm/compaction.c:3115)
  kthread (kernel/kthread.c:465)
  ? __cfi_kcompactd (mm/compaction.c:3166)
  ? __cfi_kthread (kernel/kthread.c:412)
  ret_from_fork (arch/x86/kernel/process.c:164)
  ? __cfi_kthread (kernel/kthread.c:412)
  ret_from_fork_asm (arch/x86/entry/entry_64.S:255)
  </TASK>

Matthew has analyzed the report and identified that in drain_page_zone()
we are in a section protected by spin_lock(&pcp->lock) and then get an
interrupt that attempts spin_trylock() on the same lock.  The code is
designed to work this way without disabling IRQs and occasionally fail the
trylock with a fallback.  However, the SMP=n spinlock implementation
assumes spin_trylock() will always succeed, and thus it's normally a
no-op.  Here the enabled lock debugging catches the problem, but otherwise
it could cause a corruption of the pcp structure.

The problem has been introduced by commit 574907741599 ("mm/page_alloc:
leave IRQs enabled for per-cpu page allocations").  The pcp locking scheme
recognizes the need for disabling IRQs to prevent nesting spin_trylock()
sections on SMP=n, but the need to prevent the nesting in spin_lock() has
not been recognized.  Fix it by introducing local wrappers that change the
spin_lock() to spin_lock_iqsave() with SMP=n and use them in all places
that do spin_lock(&pcp->lock).

[vbabka@suse.cz: add pcp_ prefix to the spin_lock_irqsave wrappers, per Steven]
Link: https://lkml.kernel.org/r/20260105-fix-pcp-up-v1-1-5579662d2071@suse.cz
Fixes: 574907741599 ("mm/page_alloc: leave IRQs enabled for per-cpu page allocations")
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202512101320.e2f2dd6f-lkp@intel.com
Analyzed-by: Matthew Wilcox <willy@infradead.org>
Link: https://lore.kernel.org/all/aUW05pyc9nZkvY-1@casper.infradead.org/
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ drop changes to decay_pcp_high() and zone_pcp_update_cacheinfo() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 93cb65c6553ec..fbcc560578831 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -160,6 +160,33 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
 #define pcp_spin_unlock(ptr)						\
 	pcpu_spin_unlock(lock, ptr)
 
+/*
+ * With the UP spinlock implementation, when we spin_lock(&pcp->lock) (for i.e.
+ * a potentially remote cpu drain) and get interrupted by an operation that
+ * attempts pcp_spin_trylock(), we can't rely on the trylock failure due to UP
+ * spinlock assumptions making the trylock a no-op. So we have to turn that
+ * spin_lock() to a spin_lock_irqsave(). This works because on UP there are no
+ * remote cpu's so we can only be locking the only existing local one.
+ */
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
+static inline void __flags_noop(unsigned long *flags) { }
+#define pcp_spin_lock_maybe_irqsave(ptr, flags)		\
+({							\
+	 __flags_noop(&(flags));			\
+	 spin_lock(&(ptr)->lock);			\
+})
+#define pcp_spin_unlock_maybe_irqrestore(ptr, flags)	\
+({							\
+	 spin_unlock(&(ptr)->lock);			\
+	 __flags_noop(&(flags));			\
+})
+#else
+#define pcp_spin_lock_maybe_irqsave(ptr, flags)		\
+		spin_lock_irqsave(&(ptr)->lock, flags)
+#define pcp_spin_unlock_maybe_irqrestore(ptr, flags)	\
+		spin_unlock_irqrestore(&(ptr)->lock, flags)
+#endif
+
 #ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
 DEFINE_PER_CPU(int, numa_node);
 EXPORT_PER_CPU_SYMBOL(numa_node);
@@ -2181,14 +2208,15 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
  */
 void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 {
+	unsigned long UP_flags;
 	int to_drain, batch;
 
 	batch = READ_ONCE(pcp->batch);
 	to_drain = min(pcp->count, batch);
 	if (to_drain > 0) {
-		spin_lock(&pcp->lock);
+		pcp_spin_lock_maybe_irqsave(pcp, UP_flags);
 		free_pcppages_bulk(zone, to_drain, pcp, 0);
-		spin_unlock(&pcp->lock);
+		pcp_spin_unlock_maybe_irqrestore(pcp, UP_flags);
 	}
 }
 #endif
@@ -2199,10 +2227,11 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 {
 	struct per_cpu_pages *pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
+	unsigned long UP_flags;
 	int count;
 
 	do {
-		spin_lock(&pcp->lock);
+		pcp_spin_lock_maybe_irqsave(pcp, UP_flags);
 		count = pcp->count;
 		if (count) {
 			int to_drain = min(count,
@@ -2211,7 +2240,7 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 			free_pcppages_bulk(zone, to_drain, pcp, 0);
 			count -= to_drain;
 		}
-		spin_unlock(&pcp->lock);
+		pcp_spin_unlock_maybe_irqrestore(pcp, UP_flags);
 	} while (count);
 }
 
-- 
2.51.0


