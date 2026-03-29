Return-Path: <stable+bounces-230818-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HxfIRZwyGk9mAUAu9opvQ
	(envelope-from <stable+bounces-230818-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 01:19:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CEF35046F
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 01:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55748302EE8B
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 00:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB421A6800;
	Sun, 29 Mar 2026 00:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5IZ0/NC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20E8175A98;
	Sun, 29 Mar 2026 00:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774743538; cv=none; b=KOsfN3mHXH/XQyx/bB5NPaRq2xJwb8T9HaQUc+POb3xeHXEqkWtdRWJAUFOmeWtEeEKxzbQoQrYP7zxHKkyauYmTvJKrW5i0bnQsZyY+KjHSCCGuDmkS1+h4VX/H+gDFIUIYYVWsRT9qPwixdmvVlp8q1oRSRAKigiT5b/MojFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774743538; c=relaxed/simple;
	bh=wXGjRwI+63KhwECJs2B7Y7XGuAqc92zvgQpVc6jxLsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJU9wyXWAEgpqS0Vqrje7HkzxXidAawYzt9VuRnsv4ydPxz5rMvWmC/I5gIBTi8PLRWVVIqS9yzrFIZjlxgZYhbC0WdtvWp4HRkzSMM8KNsPOUvm6TUt4qEzPkKkAtZiDQQique3DRy5hQyEbMoCfExl45wDa/70tl0L7pOcAcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5IZ0/NC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80EC7C4CEF7;
	Sun, 29 Mar 2026 00:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774743538;
	bh=wXGjRwI+63KhwECJs2B7Y7XGuAqc92zvgQpVc6jxLsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A5IZ0/NCNzwd8pFOOxfElv2RhpiBTeYfDYYjjnWO9Vze04WHmTVrKxr/FgWBhdOFo
	 QRPTeOhAPCZ0sHJYHG5OqH57RcsFluck2/fQewSVgu89XaCsGb97+tNSjwLBZhHM1D
	 uBePViKQXJ8z7TbOJ9RUK5lF5ik1pPzc5MxGfgKZBXpXbZ9v6Vp6nmDKD19L6w1JNO
	 yf9veW0RcTdfY266i3UsoN0lqoMSvWbSyNH0/O/jXIABYUhwHZ9zGZzCaNBTSeiXUs
	 E1sCtxRfhG0oo6pYlZZVNOzfrN2Lc1rEg+pMhR3d60SuwWnL6o0I0vJGbVV0iR+sNm
	 T5M/gtT+WOFvQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] sched_ext: Fix SCX_KICK_WAIT deadlock by deferring wait to balance callback
Date: Sat, 28 Mar 2026 14:18:55 -1000
Message-ID: <20260329001856.835643-2-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329001856.835643-1-tj@kernel.org>
References: <20260329001856.835643-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230818-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email]
X-Rspamd-Queue-Id: E6CEF35046F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SCX_KICK_WAIT busy-waits in kick_cpus_irq_workfn() using
smp_cond_load_acquire() until the target CPU's kick_sync advances. Because
the irq_work runs in hardirq context, the waiting CPU cannot reschedule and
its own kick_sync never advances. If multiple CPUs form a wait cycle, all
CPUs deadlock.

Replace the busy-wait in kick_cpus_irq_workfn() with resched_curr() to
force the CPU through do_pick_task_scx(), which queues a balance callback
to perform the wait. The balance callback drops the rq lock and enables
IRQs following the sched_core_balance() pattern, so the CPU can process
IPIs while waiting. The local CPU's kick_sync is advanced on entry to
do_pick_task_scx() and continuously during the wait, ensuring any CPU that
starts waiting for us sees the advancement and cannot form cyclic
dependencies.

Fixes: 90e55164dad4 ("sched_ext: Implement SCX_KICK_WAIT")
Cc: stable@vger.kernel.org # v6.12+
Reported-by: Christian Loehle <christian.loehle@arm.com>
Link: https://lore.kernel.org/r/20260316100249.1651641-1-christian.loehle@arm.com
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c   | 95 ++++++++++++++++++++++++++++++++------------
 kernel/sched/sched.h |  3 ++
 2 files changed, 73 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 26a6ac2f8826..d5bdcdb3f700 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2404,7 +2404,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 {
 	struct scx_sched *sch = scx_root;
 
-	/* see kick_cpus_irq_workfn() */
+	/* see kick_sync_wait_bal_cb() */
 	smp_store_release(&rq->scx.kick_sync, rq->scx.kick_sync + 1);
 
 	update_curr_scx(rq);
@@ -2447,6 +2447,48 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		switch_class(rq, next);
 }
 
+static void kick_sync_wait_bal_cb(struct rq *rq)
+{
+	struct scx_kick_syncs __rcu *ks = __this_cpu_read(scx_kick_syncs);
+	unsigned long *ksyncs = rcu_dereference_sched(ks)->syncs;
+	bool waited;
+	s32 cpu;
+
+	/*
+	 * Drop rq lock and enable IRQs while waiting. IRQs must be enabled
+	 * — a target CPU may be waiting for us to process an IPI (e.g. TLB
+	 * flush) while we wait for its kick_sync to advance.
+	 *
+	 * Also, keep advancing our own kick_sync so that new kick_sync waits
+	 * targeting us, which can start after we drop the lock, cannot form
+	 * cyclic dependencies.
+	 */
+retry:
+	waited = false;
+	for_each_cpu(cpu, rq->scx.cpus_to_sync) {
+		/*
+		 * smp_load_acquire() pairs with smp_store_release() on
+		 * kick_sync updates on the target CPUs.
+		 */
+		if (cpu == cpu_of(rq) ||
+		    smp_load_acquire(&cpu_rq(cpu)->scx.kick_sync) != ksyncs[cpu]) {
+			cpumask_clear_cpu(cpu, rq->scx.cpus_to_sync);
+			continue;
+		}
+
+		raw_spin_rq_unlock_irq(rq);
+		while (READ_ONCE(cpu_rq(cpu)->scx.kick_sync) == ksyncs[cpu]) {
+			smp_store_release(&rq->scx.kick_sync, rq->scx.kick_sync + 1);
+			cpu_relax();
+		}
+		raw_spin_rq_lock_irq(rq);
+		waited = true;
+	}
+
+	if (waited)
+		goto retry;
+}
+
 static struct task_struct *first_local_task(struct rq *rq)
 {
 	return list_first_entry_or_null(&rq->scx.local_dsq.list,
@@ -2460,7 +2502,7 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 	bool keep_prev;
 	struct task_struct *p;
 
-	/* see kick_cpus_irq_workfn() */
+	/* see kick_sync_wait_bal_cb() */
 	smp_store_release(&rq->scx.kick_sync, rq->scx.kick_sync + 1);
 
 	rq_modified_begin(rq, &ext_sched_class);
@@ -2470,6 +2512,17 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 	rq_repin_lock(rq, rf);
 	maybe_queue_balance_callback(rq);
 
+	/*
+	 * Defer to a balance callback which can drop rq lock and enable
+	 * IRQs. Waiting directly in the pick path would deadlock against
+	 * CPUs sending us IPIs (e.g. TLB flushes) while we wait for them.
+	 */
+	if (unlikely(rq->scx.kick_sync_pending)) {
+		rq->scx.kick_sync_pending = false;
+		queue_balance_callback(rq, &rq->scx.kick_sync_bal_cb,
+				       kick_sync_wait_bal_cb);
+	}
+
 	/*
 	 * If any higher-priority sched class enqueued a runnable task on
 	 * this rq during balance_one(), abort and return RETRY_TASK, so
@@ -4713,6 +4766,9 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 		if (!cpumask_empty(rq->scx.cpus_to_wait))
 			dump_line(&ns, "  cpus_to_wait   : %*pb",
 				  cpumask_pr_args(rq->scx.cpus_to_wait));
+		if (!cpumask_empty(rq->scx.cpus_to_sync))
+			dump_line(&ns, "  cpus_to_sync   : %*pb",
+				  cpumask_pr_args(rq->scx.cpus_to_sync));
 
 		used = seq_buf_used(&ns);
 		if (SCX_HAS_OP(sch, dump_cpu)) {
@@ -5610,11 +5666,11 @@ static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *ksyncs)
 
 		if (cpumask_test_cpu(cpu, this_scx->cpus_to_wait)) {
 			if (cur_class == &ext_sched_class) {
+				cpumask_set_cpu(cpu, this_scx->cpus_to_sync);
 				ksyncs[cpu] = rq->scx.kick_sync;
 				should_wait = true;
-			} else {
-				cpumask_clear_cpu(cpu, this_scx->cpus_to_wait);
 			}
+			cpumask_clear_cpu(cpu, this_scx->cpus_to_wait);
 		}
 
 		resched_curr(rq);
@@ -5669,27 +5725,15 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 		cpumask_clear_cpu(cpu, this_scx->cpus_to_kick_if_idle);
 	}
 
-	if (!should_wait)
-		return;
-
-	for_each_cpu(cpu, this_scx->cpus_to_wait) {
-		unsigned long *wait_kick_sync = &cpu_rq(cpu)->scx.kick_sync;
-
-		/*
-		 * Busy-wait until the task running at the time of kicking is no
-		 * longer running. This can be used to implement e.g. core
-		 * scheduling.
-		 *
-		 * smp_cond_load_acquire() pairs with store_releases in
-		 * pick_task_scx() and put_prev_task_scx(). The former breaks
-		 * the wait if SCX's scheduling path is entered even if the same
-		 * task is picked subsequently. The latter is necessary to break
-		 * the wait when $cpu is taken by a higher sched class.
-		 */
-		if (cpu != cpu_of(this_rq))
-			smp_cond_load_acquire(wait_kick_sync, VAL != ksyncs[cpu]);
-
-		cpumask_clear_cpu(cpu, this_scx->cpus_to_wait);
+	/*
+	 * Can't wait in hardirq — kick_sync can't advance, deadlocking if
+	 * CPUs wait for each other. Defer to kick_sync_wait_bal_cb().
+	 */
+	if (should_wait) {
+		raw_spin_rq_lock(this_rq);
+		this_scx->kick_sync_pending = true;
+		resched_curr(this_rq);
+		raw_spin_rq_unlock(this_rq);
 	}
 }
 
@@ -5794,6 +5838,7 @@ void __init init_sched_ext_class(void)
 		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_kick_if_idle, GFP_KERNEL, n));
 		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_preempt, GFP_KERNEL, n));
 		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_wait, GFP_KERNEL, n));
+		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_sync, GFP_KERNEL, n));
 		rq->scx.deferred_irq_work = IRQ_WORK_INIT_HARD(deferred_irq_workfn);
 		rq->scx.kick_cpus_irq_work = IRQ_WORK_INIT_HARD(kick_cpus_irq_workfn);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 43bbf0693cca..1ef9ba480f51 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -805,9 +805,12 @@ struct scx_rq {
 	cpumask_var_t		cpus_to_kick_if_idle;
 	cpumask_var_t		cpus_to_preempt;
 	cpumask_var_t		cpus_to_wait;
+	cpumask_var_t		cpus_to_sync;
+	bool			kick_sync_pending;
 	unsigned long		kick_sync;
 	local_t			reenq_local_deferred;
 	struct balance_callback	deferred_bal_cb;
+	struct balance_callback	kick_sync_bal_cb;
 	struct irq_work		deferred_irq_work;
 	struct irq_work		kick_cpus_irq_work;
 	struct scx_dispatch_q	bypass_dsq;
-- 
2.53.0


