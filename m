Return-Path: <stable+bounces-498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5A37F7B56
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96645B212D5
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373C239FFD;
	Fri, 24 Nov 2023 18:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Oiz62aJn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BCC381DF;
	Fri, 24 Nov 2023 18:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A4BC433C8;
	Fri, 24 Nov 2023 18:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849046;
	bh=v70gn/VXjjS36f6fM7iLtBaeeil90BuO6aYjtkfgZdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oiz62aJnDLF1l7ko01v7P3YQJXb7w5MfdCT9dr1uSuiN74vjdDwPAKCKTVHGu44Ae
	 cq84uUqo0pdyoieapRgHYNw/VotOWwGalmoI+lHmVlj8qCZ+JzU+BNriFy53NvL2iA
	 dDVCriSXRjS+WjbwXBUZUZ9Kj07n2afyrZYHGtyg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhen Lei <thunder.leizhen@huawei.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 006/530] rcu: Dump memory object info if callback function is invalid
Date: Fri, 24 Nov 2023 17:42:52 +0000
Message-ID: <20231124172028.299415130@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhen Lei <thunder.leizhen@huawei.com>

[ Upstream commit 2cbc482d325ee58001472c4359b311958c4efdd1 ]

When a structure containing an RCU callback rhp is (incorrectly) freed
and reallocated after rhp is passed to call_rcu(), it is not unusual for
rhp->func to be set to NULL. This defeats the debugging prints used by
__call_rcu_common() in kernels built with CONFIG_DEBUG_OBJECTS_RCU_HEAD=y,
which expect to identify the offending code using the identity of this
function.

And in kernels build without CONFIG_DEBUG_OBJECTS_RCU_HEAD=y, things
are even worse, as can be seen from this splat:

Unable to handle kernel NULL pointer dereference at virtual address 0
... ...
PC is at 0x0
LR is at rcu_do_batch+0x1c0/0x3b8
... ...
 (rcu_do_batch) from (rcu_core+0x1d4/0x284)
 (rcu_core) from (__do_softirq+0x24c/0x344)
 (__do_softirq) from (__irq_exit_rcu+0x64/0x108)
 (__irq_exit_rcu) from (irq_exit+0x8/0x10)
 (irq_exit) from (__handle_domain_irq+0x74/0x9c)
 (__handle_domain_irq) from (gic_handle_irq+0x8c/0x98)
 (gic_handle_irq) from (__irq_svc+0x5c/0x94)
 (__irq_svc) from (arch_cpu_idle+0x20/0x3c)
 (arch_cpu_idle) from (default_idle_call+0x4c/0x78)
 (default_idle_call) from (do_idle+0xf8/0x150)
 (do_idle) from (cpu_startup_entry+0x18/0x20)
 (cpu_startup_entry) from (0xc01530)

This commit therefore adds calls to mem_dump_obj(rhp) to output some
information, for example:

  slab kmalloc-256 start ffff410c45019900 pointer offset 0 size 256

This provides the rough size of the memory block and the offset of the
rcu_head structure, which as least provides at least a few clues to help
locate the problem. If the problem is reproducible, additional slab
debugging can be enabled, for example, CONFIG_DEBUG_SLAB=y, which can
provide significantly more information.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/rcu.h      | 7 +++++++
 kernel/rcu/srcutiny.c | 1 +
 kernel/rcu/srcutree.c | 1 +
 kernel/rcu/tasks.h    | 1 +
 kernel/rcu/tiny.c     | 1 +
 kernel/rcu/tree.c     | 1 +
 6 files changed, 12 insertions(+)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 98e13be411afd..d612731feea48 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -10,6 +10,7 @@
 #ifndef __LINUX_RCU_H
 #define __LINUX_RCU_H
 
+#include <linux/slab.h>
 #include <trace/events/rcu.h>
 
 /*
@@ -248,6 +249,12 @@ static inline void debug_rcu_head_unqueue(struct rcu_head *head)
 }
 #endif	/* #else !CONFIG_DEBUG_OBJECTS_RCU_HEAD */
 
+static inline void debug_rcu_head_callback(struct rcu_head *rhp)
+{
+	if (unlikely(!rhp->func))
+		kmem_dump_obj(rhp);
+}
+
 extern int rcu_cpu_stall_suppress_at_boot;
 
 static inline bool rcu_stall_is_suppressed_at_boot(void)
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 336af24e0fe35..c38e5933a5d69 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -138,6 +138,7 @@ void srcu_drive_gp(struct work_struct *wp)
 	while (lh) {
 		rhp = lh;
 		lh = lh->next;
+		debug_rcu_head_callback(rhp);
 		local_bh_disable();
 		rhp->func(rhp);
 		local_bh_enable();
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 253ed509b6abb..c6481032d42be 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1735,6 +1735,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 	rhp = rcu_cblist_dequeue(&ready_cbs);
 	for (; rhp != NULL; rhp = rcu_cblist_dequeue(&ready_cbs)) {
 		debug_rcu_head_unqueue(rhp);
+		debug_rcu_head_callback(rhp);
 		local_bh_disable();
 		rhp->func(rhp);
 		local_bh_enable();
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 8d65f7d576a34..7c845532a50ac 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -538,6 +538,7 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 	len = rcl.len;
 	for (rhp = rcu_cblist_dequeue(&rcl); rhp; rhp = rcu_cblist_dequeue(&rcl)) {
+		debug_rcu_head_callback(rhp);
 		local_bh_disable();
 		rhp->func(rhp);
 		local_bh_enable();
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 42f7589e51e09..fec804b790803 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -97,6 +97,7 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
 
 	trace_rcu_invoke_callback("", head);
 	f = head->func;
+	debug_rcu_head_callback(head);
 	WRITE_ONCE(head->func, (rcu_callback_t)0L);
 	f(head);
 	rcu_lock_release(&rcu_callback_map);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cb1caefa8bd07..29e4acbafefda 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2135,6 +2135,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 		trace_rcu_invoke_callback(rcu_state.name, rhp);
 
 		f = rhp->func;
+		debug_rcu_head_callback(rhp);
 		WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
 		f(rhp);
 
-- 
2.42.0




