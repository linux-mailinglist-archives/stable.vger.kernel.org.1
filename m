Return-Path: <stable+bounces-211449-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MieEgWPdGmw7AAAu9opvQ
	(envelope-from <stable+bounces-211449-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 10:21:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8C27D113
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 10:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AC5E3009F88
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 09:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4AC1C5D57;
	Sat, 24 Jan 2026 09:21:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306F63EBF34
	for <stable@vger.kernel.org>; Sat, 24 Jan 2026 09:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769246460; cv=none; b=YgU1g08dO45pnEwswzZ4moW/CutNO9Lg2qcm/rpSjDd0eLKATJ/boVHcKzdyz0/CjK0FXM2fGR8+CgJdhQl1KZAs8WfULNg89KRfOsl1gKuDkiKqjjlQ0Lle8JD9rOWx0OLYW1lbt5T3ZH3cFbdQK6cbialAHpLIvIR4VlWGmyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769246460; c=relaxed/simple;
	bh=rZTAfthiwJt1a4xocVQwRQBsKG3CjQ/UQLtqCOLPhrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SCDgWtlzTPhP9uDr9wax7Hlugnz3l48hvOfKBA6ZVVqYsQMyodoyQhwVzJ8wzC6R+Kcu66jd8LcRJT2Ir00U8KpOKz2xWeETUjCfgGGtYJ+4cjT51pqX/FaWLAbbWSJDTjRs/kMIrlyR0ZH2M+bqzX0mlIwZpoOThIXt2938BJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C28D1476;
	Sat, 24 Jan 2026 01:20:52 -0800 (PST)
Received: from e127648.arm.com (unknown [10.57.81.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C5F7C3F73F;
	Sat, 24 Jan 2026 01:20:56 -0800 (PST)
From: Christian Loehle <christian.loehle@arm.com>
To: stable@vger.kernel.org,
	tj@kernel.org
Cc: arighi@nvidia.com,
	void@manifault.com,
	sched-ext@lists.linux.dev,
	Wen-Fang Liu <liuwenfang@honor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/2] sched_ext: Fix SCX_KICK_WAIT to work reliably
Date: Sat, 24 Jan 2026 09:20:43 +0000
Message-Id: <20260124092043.349976-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260124092043.349976-1-christian.loehle@arm.com>
References: <20260124092043.349976-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211449-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[honor.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.loehle@arm.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:mid,honor.com:email]
X-Rspamd-Queue-Id: EA8C27D113
X-Rspamd-Action: no action

From: Tejun Heo <tj@kernel.org>

commit a379fa1e2cae15d7422b4eead83a6366f2f445cb upstream.

SCX_KICK_WAIT is used to synchronously wait for the target CPU to complete
a reschedule and can be used to implement operations like core scheduling.

This used to be implemented by scx_next_task_picked() incrementing pnt_seq,
which was always called when a CPU picks the next task to run, allowing
SCX_KICK_WAIT to reliably wait for the target CPU to enter the scheduler and
pick the next task.

However, commit b999e365c298 ("sched_ext: Replace scx_next_task_picked()
with switch_class()") replaced scx_next_task_picked() with the
switch_class() callback, which is only called when switching between sched
classes. This broke SCX_KICK_WAIT because pnt_seq would no longer be
reliably incremented unless the previous task was SCX and the next task was
not.

This fix leverages commit 4c95380701f5 ("sched/ext: Fold balance_scx() into
pick_task_scx()") which refactored the pick path making put_prev_task_scx()
the natural place to track task switches for SCX_KICK_WAIT. The fix moves
pnt_seq increment to put_prev_task_scx() and also increments it in
pick_task_scx() to handle cases where the same task is re-selected, whether
by BPF scheduler decision or slice refill. The semantics: If the current
task on the target CPU is SCX, SCX_KICK_WAIT waits until the CPU enters the
scheduling path. This provides sufficient guarantee for use cases like core
scheduling while keeping the operation self-contained within SCX.

v2: - Also increment pnt_seq in pick_task_scx() to handle same-task
      re-selection (Andrea Righi).
    - Use smp_cond_load_acquire() for the busy-wait loop for better
      architecture optimization (Peter Zijlstra).

Reported-by: Wen-Fang Liu <liuwenfang@honor.com>
Link: http://lkml.kernel.org/r/228ebd9e6ed3437996dffe15735a9caa@honor.com
Cc: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 46 +++++++++++++++++++++----------------
 kernel/sched/ext_internal.h |  6 +++--
 2 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 3d53b2232937..2ff7034841c7 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2306,12 +2306,6 @@ static void switch_class(struct rq *rq, struct task_struct *next)
 	struct scx_sched *sch = scx_root;
 	const struct sched_class *next_class = next->sched_class;
 
-	/*
-	 * Pairs with the smp_load_acquire() issued by a CPU in
-	 * kick_cpus_irq_workfn() who is waiting for this CPU to perform a
-	 * resched.
-	 */
-	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
 	if (!(sch->ops.flags & SCX_OPS_HAS_CPU_PREEMPT))
 		return;
 
@@ -2351,6 +2345,10 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			      struct task_struct *next)
 {
 	struct scx_sched *sch = scx_root;
+
+	/* see kick_cpus_irq_workfn() */
+	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
+
 	update_curr_scx(rq);
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
@@ -2404,6 +2402,9 @@ static struct task_struct *pick_task_scx(struct rq *rq)
 	bool keep_prev = rq->scx.flags & SCX_RQ_BAL_KEEP;
 	bool kick_idle = false;
 
+	/* see kick_cpus_irq_workfn() */
+	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
+
 	/*
 	 * WORKAROUND:
 	 *
@@ -5186,8 +5187,12 @@ static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *pseqs)
 		}
 
 		if (cpumask_test_cpu(cpu, this_scx->cpus_to_wait)) {
-			pseqs[cpu] = rq->scx.pnt_seq;
-			should_wait = true;
+			if (cur_class == &ext_sched_class) {
+				pseqs[cpu] = rq->scx.pnt_seq;
+				should_wait = true;
+			} else {
+				cpumask_clear_cpu(cpu, this_scx->cpus_to_wait);
+			}
 		}
 
 		resched_curr(rq);
@@ -5248,18 +5253,19 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 	for_each_cpu(cpu, this_scx->cpus_to_wait) {
 		unsigned long *wait_pnt_seq = &cpu_rq(cpu)->scx.pnt_seq;
 
-		if (cpu != cpu_of(this_rq)) {
-			/*
-			 * Pairs with smp_store_release() issued by this CPU in
-			 * switch_class() on the resched path.
-			 *
-			 * We busy-wait here to guarantee that no other task can
-			 * be scheduled on our core before the target CPU has
-			 * entered the resched path.
-			 */
-			while (smp_load_acquire(wait_pnt_seq) == pseqs[cpu])
-				cpu_relax();
-		}
+		/*
+		 * Busy-wait until the task running at the time of kicking is no
+		 * longer running. This can be used to implement e.g. core
+		 * scheduling.
+		 *
+		 * smp_cond_load_acquire() pairs with store_releases in
+		 * pick_task_scx() and put_prev_task_scx(). The former breaks
+		 * the wait if SCX's scheduling path is entered even if the same
+		 * task is picked subsequently. The latter is necessary to break
+		 * the wait when $cpu is taken by a higher sched class.
+		 */
+		if (cpu != cpu_of(this_rq))
+			smp_cond_load_acquire(wait_pnt_seq, VAL != pseqs[cpu]);
 
 		cpumask_clear_cpu(cpu, this_scx->cpus_to_wait);
 	}
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index b3617abed510..601cfae8cc76 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -986,8 +986,10 @@ enum scx_kick_flags {
 	SCX_KICK_PREEMPT	= 1LLU << 1,
 
 	/*
-	 * Wait for the CPU to be rescheduled. The scx_bpf_kick_cpu() call will
-	 * return after the target CPU finishes picking the next task.
+	 * The scx_bpf_kick_cpu() call will return after the current SCX task of
+	 * the target CPU switches out. This can be used to implement e.g. core
+	 * scheduling. This has no effect if the current task on the target CPU
+	 * is not on SCX.
 	 */
 	SCX_KICK_WAIT		= 1LLU << 2,
 };
-- 
2.34.1


