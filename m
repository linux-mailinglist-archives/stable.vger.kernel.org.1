Return-Path: <stable+bounces-210529-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC/+AzKKcWkLJAAAu9opvQ
	(envelope-from <stable+bounces-210529-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 03:23:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 206E460DAF
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 03:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 000138AC13A
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 13:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E32442316E;
	Tue, 20 Jan 2026 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dkd05aGe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AF919F40A
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 13:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768914530; cv=none; b=Oguzco9IW87ETKXT6gg3HzDL7VMRG+F9N9l4xx7Lkp9vmqf3yBKtox978njXFsMJ+Ykw6OO1P2nDHyelbXU77m6QJmSjO40tUFG1YSzcr2unOSO/i+WIzl73KK4m11dNnslFz8pAzgL6p9o8C2AVNbStn2llxTak3mGjqjPcLBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768914530; c=relaxed/simple;
	bh=M56PHhLJOctFVRIh9v7wMCK6P6Z6rSe4KjpnUnFUXqE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=X6wACSRoyXjSJPPAJdyWhwg5+v045PtBeTRCFM0T76XZXlV/lye7mTf+artB0+w3oh3QLfvWcqrXSOEWNNfL78BfTxcCAzI4uVkDR/wTGwgHEN/8xn+ru2+F/5uDbKq2ko0Hd+xKb0FJUPJGJJ56hK+O6VsODEdJYlG5RO/Np4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dkd05aGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2575EC19422;
	Tue, 20 Jan 2026 13:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768914529;
	bh=M56PHhLJOctFVRIh9v7wMCK6P6Z6rSe4KjpnUnFUXqE=;
	h=Subject:To:Cc:From:Date:From;
	b=Dkd05aGeGIxtmFF+wbkgYD/Oqxwn1qGAQ5AuaWiboDe7reuLkNHbvN4hvhNwXEwn8
	 vLFlvwbUA99LvkSko/FqR/+ZvxXbekeRqyQSlMbeogEGDWLVygNcSEF1yQv+y27OKq
	 lSfsoFGwsca3cw6KOpXkysoU3Zl51w+k9opGycC0=
Subject: FAILED: patch "[PATCH] mm/page_alloc: prevent pcp corruption with SMP=n" failed to apply to 6.6-stable tree
To: vbabka@suse.cz,akpm@linux-foundation.org,bigeasy@linutronix.de,hannes@cmpxchg.org,jackmanb@google.com,mgorman@techsingularity.net,mhocko@suse.com,oliver.sang@intel.com,rostedt@goodmis.org,stable@vger.kernel.org,surenb@google.com,willy@infradead.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 20 Jan 2026 14:08:42 +0100
Message-ID: <2026012042-scorebook-jawed-016d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.54 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DATE_IN_PAST(1.00)[37];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TAGGED_FROM(0.00)[bounces-210529-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_NONE(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,intel.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,infradead.org:email,cmpxchg.org:email,suse.cz:email,linuxfoundation.org:dkim,goodmis.org:email,suse.com:email,linux-foundation.org:email,linutronix.de:email]
X-Rspamd-Queue-Id: 206E460DAF
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 038a102535eb49e10e93eafac54352fcc5d78847
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012042-scorebook-jawed-016d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 038a102535eb49e10e93eafac54352fcc5d78847 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 5 Jan 2026 16:08:56 +0100
Subject: [PATCH] mm/page_alloc: prevent pcp corruption with SMP=n

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

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3dce96f3be49..f65c4edf199d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -167,6 +167,33 @@ static inline void __pcp_trylock_noop(unsigned long *flags) { }
 	pcp_trylock_finish(UP_flags);					\
 })
 
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
@@ -2556,6 +2583,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
 {
 	int high_min, to_drain, to_drain_batched, batch;
+	unsigned long UP_flags;
 	bool todo = false;
 
 	high_min = READ_ONCE(pcp->high_min);
@@ -2575,9 +2603,9 @@ bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
 	to_drain = pcp->count - pcp->high;
 	while (to_drain > 0) {
 		to_drain_batched = min(to_drain, batch);
-		spin_lock(&pcp->lock);
+		pcp_spin_lock_maybe_irqsave(pcp, UP_flags);
 		free_pcppages_bulk(zone, to_drain_batched, pcp, 0);
-		spin_unlock(&pcp->lock);
+		pcp_spin_unlock_maybe_irqrestore(pcp, UP_flags);
 		todo = true;
 
 		to_drain -= to_drain_batched;
@@ -2594,14 +2622,15 @@ bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
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
@@ -2612,10 +2641,11 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
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
@@ -2624,7 +2654,7 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 			free_pcppages_bulk(zone, to_drain, pcp, 0);
 			count -= to_drain;
 		}
-		spin_unlock(&pcp->lock);
+		pcp_spin_unlock_maybe_irqrestore(pcp, UP_flags);
 	} while (count);
 }
 
@@ -6109,6 +6139,7 @@ static void zone_pcp_update_cacheinfo(struct zone *zone, unsigned int cpu)
 {
 	struct per_cpu_pages *pcp;
 	struct cpu_cacheinfo *cci;
+	unsigned long UP_flags;
 
 	pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
 	cci = get_cpu_cacheinfo(cpu);
@@ -6119,12 +6150,12 @@ static void zone_pcp_update_cacheinfo(struct zone *zone, unsigned int cpu)
 	 * This can reduce zone lock contention without hurting
 	 * cache-hot pages sharing.
 	 */
-	spin_lock(&pcp->lock);
+	pcp_spin_lock_maybe_irqsave(pcp, UP_flags);
 	if ((cci->per_cpu_data_slice_size >> PAGE_SHIFT) > 3 * pcp->batch)
 		pcp->flags |= PCPF_FREE_HIGH_BATCH;
 	else
 		pcp->flags &= ~PCPF_FREE_HIGH_BATCH;
-	spin_unlock(&pcp->lock);
+	pcp_spin_unlock_maybe_irqrestore(pcp, UP_flags);
 }
 
 void setup_pcp_cacheinfo(unsigned int cpu)


