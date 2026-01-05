Return-Path: <stable+bounces-204826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED635CF454C
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 16:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E0253053F84
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 15:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BBC3093C4;
	Mon,  5 Jan 2026 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dzAAew3W";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h5CuoAbB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dzAAew3W";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h5CuoAbB"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88D83093B8
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 15:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767625767; cv=none; b=Ebwwiqc/WPM9gAV0AHZQ4lbSjjQlnMPQtfTnSbcQU+4qmEc4w5uKF9ILZgl783RZ+IYKttnqMh7eM8q6nR3BIxK0ZsmwRRZVVMJ6/BHoR8BlGkCzGBaEM4+1yrXHpRHby49MEQ7xAgk5/gg19zXfouMJL91OKO1O9VpPmUydVr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767625767; c=relaxed/simple;
	bh=FpnZkQzqTXgpLCeDqbf635ppL7kxREyq/3JaLxYT+kI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=okrlumtAkUFCycmoC9onUYv+5sbwvh6xl7H/xXrWgmhQGcCapinL3rzs9lMmB8wx0ZD9TL/7zwK1QtkrahAXbzeKa8EPUyUSTK7u/b/ZCuvzX2q+ZHbwRXXP+Mk00I2wiioH7tSvyPyoadACYhxxR4rHV3JQT09QNz1IzZwUkAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dzAAew3W; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h5CuoAbB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dzAAew3W; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h5CuoAbB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3BA225BD95;
	Mon,  5 Jan 2026 15:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767625758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nXFJRGDoPP/1NBMbu/mIZ+YgI9XsAfdquYGVHPf/sao=;
	b=dzAAew3W5f3JVFYbqdSx03wQ/AtLH1R8kZmOZoDi6oOjmBmsMzJTt2PQvWb61WgxqVSMEe
	W+Bt01IqcYiJubANGRfa6JpF6NjSL2Z4Mr/idlRmRQgwC7nYdl/otz9PGkQfFx3Cgis45R
	MNb8w9r2YbY3qp11+NjpImUaBRO3vj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767625758;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nXFJRGDoPP/1NBMbu/mIZ+YgI9XsAfdquYGVHPf/sao=;
	b=h5CuoAbBVOuxilN6AjMSr4r5O5yb2+FfLbxhfK1Z+eQOFyLPBnoLyRlOR6A325GlRhg1Py
	xza49PoncpAUeiBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dzAAew3W;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=h5CuoAbB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767625758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nXFJRGDoPP/1NBMbu/mIZ+YgI9XsAfdquYGVHPf/sao=;
	b=dzAAew3W5f3JVFYbqdSx03wQ/AtLH1R8kZmOZoDi6oOjmBmsMzJTt2PQvWb61WgxqVSMEe
	W+Bt01IqcYiJubANGRfa6JpF6NjSL2Z4Mr/idlRmRQgwC7nYdl/otz9PGkQfFx3Cgis45R
	MNb8w9r2YbY3qp11+NjpImUaBRO3vj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767625758;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nXFJRGDoPP/1NBMbu/mIZ+YgI9XsAfdquYGVHPf/sao=;
	b=h5CuoAbBVOuxilN6AjMSr4r5O5yb2+FfLbxhfK1Z+eQOFyLPBnoLyRlOR6A325GlRhg1Py
	xza49PoncpAUeiBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1ECE93EA63;
	Mon,  5 Jan 2026 15:09:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MqczBx7UW2mCDwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 05 Jan 2026 15:09:18 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 05 Jan 2026 16:08:56 +0100
Subject: [PATCH mm-hotfixes] mm/page_alloc: prevent pcp corruption with
 SMP=n
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-fix-pcp-up-v1-1-5579662d2071@suse.cz>
X-B4-Tracking: v=1; b=H4sIAAfUW2kC/yXMSwqAMAxF0a1IxgZqxe9WxIHEaDOollZFKO7do
 sPD5b0Igb1wgD6L4PmSIPuWUOQZkJm2lVHmZNBK16pQFS5yoyOHp8OS2pZU11SaCdLAeU71Oxv
 AWjT78Xt8nhfX6qYaaQAAAA==
X-Change-ID: 20260105-fix-pcp-up-3c88c09752ec
To: Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 stable@vger.kernel.org, kernel test robot <oliver.sang@intel.com>, 
 Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8903; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=FpnZkQzqTXgpLCeDqbf635ppL7kxREyq/3JaLxYT+kI=;
 b=owGbwMvMwMG4+8GG0kuuHbMYT6slMWRGX5EQOJE0jdPA6XvK4j83sj8vy8rg1lpdsVHjo3qn8
 +6DS69LdzL6szAwcjBYiimyVO8+4Sg6U9ljmofvR5hBrEwgU6RFGhiAgIWBLzcxr9RIx0jPVNtQ
 z9BQB8hk4OIUgKle+YuDYVrKSfHZR/5PqbI5l7skK6Er82f8B82bakarr0YsaNwXx9cts+7Pa88
 H8WHp38sPHQgVjX4+tYL598b1atsunpivmrlOO+bJc4P7pyYLua/qtrM1t/+xd07Akt4dSqoVxW
 y6nY05xs6HBYoFt7W+emxSdvFInsGre6V1yz2EDszcrVzy6E7FrsuSgYXcvwycpkay97ZqTV3Ly
 1uxftL951dvpOySCJ5jlL3z8rPAbz636hw0is/Xt56XEHZKFj947LOOziEV3ogPVWdSm1ZcCVJm
 TJ+6cxnDHqZNwcsrq3MLXn7Q/T1jj5JeDdf93Zse+4lbuV8uu24l7TElPH6b9L5A09zfgiwpggq
 dNj13AA==
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 3BA225BD95
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

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
interrupt that attempts spin_trylock() on the same lock. The code is
designed to work this way without disabling IRQs and occasionally fail
the trylock with a fallback. However, the SMP=n spinlock implementation
assumes spin_trylock() will always succeed, and thus it's normally a
no-op. Here the enabled lock debugging catches the problem, but
otherwise it could cause a corruption of the pcp structure.

The problem has been introduced by commit 574907741599 ("mm/page_alloc:
leave IRQs enabled for per-cpu page allocations"). The pcp locking
scheme recognizes the need for disabling IRQs to prevent nesting
spin_trylock() sections on SMP=n, but the need to prevent the nesting in
spin_lock() has not been recognized. Fix it by introducing local
wrappers that change the spin_lock() to spin_lock_iqsave() with SMP=n
and use them in all places that do spin_lock(&pcp->lock).

Fixes: 574907741599 ("mm/page_alloc: leave IRQs enabled for per-cpu page allocations")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202512101320.e2f2dd6f-lkp@intel.com
Analyzed-by: Matthew Wilcox <willy@infradead.org>
Link: https://lore.kernel.org/all/aUW05pyc9nZkvY-1@casper.infradead.org/
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
This fix is intentionally made self-contained and not trying to expand
upon the existing pcp[u]_spin() helpers. This is to make stable
backports easier due to recent cleanups to that helpers.

We could follow up with a proper helpers integration going forward.
However I think the assumptions SMP=n of the spinlock UP implementation
are just wrong. It should be valid to do a spin_lock() without disabling
irq's and rely on a nested spin_trylock() to fail. I will thus try
proposing the remove the UP implementation first. It should be within
the current trend of removing stuff that's optimized for a minority
configuration if it makes maintainability of the majority worse.
(c.f. recent scheduler SMP=n removal)
---
 mm/page_alloc.c | 45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 822e05f1a964..ec3551d56cde 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -167,6 +167,31 @@ static inline void __pcp_trylock_noop(unsigned long *flags) { }
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
+#define spin_lock_maybe_irqsave(lock, flags)		\
+({							\
+	 __flags_noop(&(flags));			\
+	 spin_lock(lock);				\
+})
+#define spin_unlock_maybe_irqrestore(lock, flags)	\
+({							\
+	 spin_unlock(lock);				\
+	 __flags_noop(&(flags));			\
+})
+#else
+#define spin_lock_maybe_irqsave(lock, flags)		spin_lock_irqsave(lock, flags)
+#define spin_unlock_maybe_irqrestore(lock, flags)	spin_unlock_irqrestore(lock, flags)
+#endif
+
 #ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
 DEFINE_PER_CPU(int, numa_node);
 EXPORT_PER_CPU_SYMBOL(numa_node);
@@ -2556,6 +2581,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
 {
 	int high_min, to_drain, to_drain_batched, batch;
+	unsigned long UP_flags;
 	bool todo = false;
 
 	high_min = READ_ONCE(pcp->high_min);
@@ -2575,9 +2601,9 @@ bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
 	to_drain = pcp->count - pcp->high;
 	while (to_drain > 0) {
 		to_drain_batched = min(to_drain, batch);
-		spin_lock(&pcp->lock);
+		spin_lock_maybe_irqsave(&pcp->lock, UP_flags);
 		free_pcppages_bulk(zone, to_drain_batched, pcp, 0);
-		spin_unlock(&pcp->lock);
+		spin_unlock_maybe_irqrestore(&pcp->lock, UP_flags);
 		todo = true;
 
 		to_drain -= to_drain_batched;
@@ -2594,14 +2620,15 @@ bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
  */
 void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 {
+	unsigned long UP_flags;
 	int to_drain, batch;
 
 	batch = READ_ONCE(pcp->batch);
 	to_drain = min(pcp->count, batch);
 	if (to_drain > 0) {
-		spin_lock(&pcp->lock);
+		spin_lock_maybe_irqsave(&pcp->lock, UP_flags);
 		free_pcppages_bulk(zone, to_drain, pcp, 0);
-		spin_unlock(&pcp->lock);
+		spin_unlock_maybe_irqrestore(&pcp->lock, UP_flags);
 	}
 }
 #endif
@@ -2612,10 +2639,11 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 {
 	struct per_cpu_pages *pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
+	unsigned long UP_flags;
 	int count;
 
 	do {
-		spin_lock(&pcp->lock);
+		spin_lock_maybe_irqsave(&pcp->lock, UP_flags);
 		count = pcp->count;
 		if (count) {
 			int to_drain = min(count,
@@ -2624,7 +2652,7 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 			free_pcppages_bulk(zone, to_drain, pcp, 0);
 			count -= to_drain;
 		}
-		spin_unlock(&pcp->lock);
+		spin_unlock_maybe_irqrestore(&pcp->lock, UP_flags);
 	} while (count);
 }
 
@@ -6109,6 +6137,7 @@ static void zone_pcp_update_cacheinfo(struct zone *zone, unsigned int cpu)
 {
 	struct per_cpu_pages *pcp;
 	struct cpu_cacheinfo *cci;
+	unsigned long UP_flags;
 
 	pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
 	cci = get_cpu_cacheinfo(cpu);
@@ -6119,12 +6148,12 @@ static void zone_pcp_update_cacheinfo(struct zone *zone, unsigned int cpu)
 	 * This can reduce zone lock contention without hurting
 	 * cache-hot pages sharing.
 	 */
-	spin_lock(&pcp->lock);
+	spin_lock_maybe_irqsave(&pcp->lock, UP_flags);
 	if ((cci->per_cpu_data_slice_size >> PAGE_SHIFT) > 3 * pcp->batch)
 		pcp->flags |= PCPF_FREE_HIGH_BATCH;
 	else
 		pcp->flags &= ~PCPF_FREE_HIGH_BATCH;
-	spin_unlock(&pcp->lock);
+	spin_unlock_maybe_irqrestore(&pcp->lock, UP_flags);
 }
 
 void setup_pcp_cacheinfo(unsigned int cpu)

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260105-fix-pcp-up-3c88c09752ec

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>


