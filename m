Return-Path: <stable+bounces-62854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDDC9415E6
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 273B2B23169
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 15:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911E81B5831;
	Tue, 30 Jul 2024 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vNHdR41N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4657D29A2;
	Tue, 30 Jul 2024 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722354851; cv=none; b=MHxTvk/TtzZRvsWqDYaxVMdu0KnoKCQeV8Us2bxeRDfoSXMenghS3jhpxR+C5bFhp7NABrnCRIuUusKxx55SXYceKPGUnvIXqnDMVHPTvNHFAsGlBQDX3AJ3UB5ZlGDzNYx7gwn7qeSPcVUfODe6UqpkoTIOE7A35wuBD+Ubr1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722354851; c=relaxed/simple;
	bh=w2Wb77Vm8h0doNx6PX58ymXObvSbBKt5e6M2v9Ywp24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/WYLzWYuwQt6BX2cqa9Tv6QPJLS4Zk81WGDPs4Rbu+RCGJO167E5qRdkP4wiac0/Z6ZcFXsqWCRQatwOVgdcWpfCOlc457iF4/5lzIbeRKQdMdroOS7z7qcSYIwtm9qHBzrwpTChh75uHudQ/xjFHYDy+/Xsq39c9hujq8Q1t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vNHdR41N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92556C32782;
	Tue, 30 Jul 2024 15:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722354851;
	bh=w2Wb77Vm8h0doNx6PX58ymXObvSbBKt5e6M2v9Ywp24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vNHdR41NolQe45ZyeeoDcF/EWzTd79/x8N6BdQpHGY+ITVMEJqkvBa5+fKOghnhph
	 g2u5QI4s+cgLuN9bZFj48O9ifUaBsH8AXu9calXQSttzYpenXFxiWiaVbW9wBVPc6S
	 ZnTx21msr8hpVEu8rUedar7oHEF9FHJGC3qJulF0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 004/440] rcu/tasks: Fix stale task snaphot for Tasks Trace
Date: Tue, 30 Jul 2024 17:43:57 +0200
Message-ID: <20240730151615.932536964@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frederic Weisbecker <frederic@kernel.org>

[ Upstream commit 399ced9594dfab51b782798efe60a2376cd5b724 ]

When RCU-TASKS-TRACE pre-gp takes a snapshot of the current task running
on all online CPUs, no explicit ordering synchronizes properly with a
context switch.  This lack of ordering can permit the new task to miss
pre-grace-period update-side accesses.  The following diagram, courtesy
of Paul, shows the possible bad scenario:

        CPU 0                                           CPU 1
        -----                                           -----

        // Pre-GP update side access
        WRITE_ONCE(*X, 1);
        smp_mb();
        r0 = rq->curr;
                                                        RCU_INIT_POINTER(rq->curr, TASK_B)
                                                        spin_unlock(rq)
                                                        rcu_read_lock_trace()
                                                        r1 = X;
        /* ignore TASK_B */

Either r0==TASK_B or r1==1 is needed but neither is guaranteed.

One possible solution to solve this is to wait for an RCU grace period
at the beginning of the RCU-tasks-trace grace period before taking the
current tasks snaphot. However this would introduce large additional
latencies to RCU-tasks-trace grace periods.

Another solution is to lock the target runqueue while taking the current
task snapshot. This ensures that the update side sees the latest context
switch and subsequent context switches will see the pre-grace-period
update side accesses.

This commit therefore adds runqueue locking to cpu_curr_snapshot().

Fixes: e386b6725798 ("rcu-tasks: Eliminate RCU Tasks Trace IPIs to online CPUs")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/tasks.h  | 10 ++++++++++
 kernel/sched/core.c | 14 +++++++-------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 6f48f565e3acb..456c956f481ef 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1531,6 +1531,16 @@ static void rcu_tasks_trace_pregp_step(struct list_head *hop)
 	// allow safe access to the hop list.
 	for_each_online_cpu(cpu) {
 		rcu_read_lock();
+		// Note that cpu_curr_snapshot() picks up the target
+		// CPU's current task while its runqueue is locked with
+		// an smp_mb__after_spinlock().  This ensures that either
+		// the grace-period kthread will see that task's read-side
+		// critical section or the task will see the updater's pre-GP
+		// accesses.  The trailing smp_mb() in cpu_curr_snapshot()
+		// does not currently play a role other than simplify
+		// that function's ordering semantics.  If these simplified
+		// ordering semantics continue to be redundant, that smp_mb()
+		// might be removed.
 		t = cpu_curr_snapshot(cpu);
 		if (rcu_tasks_trace_pertask_prep(t, true))
 			trc_add_holdout(t, hop);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cac41c49bd2f5..753d7208123bb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4318,12 +4318,7 @@ int task_call_func(struct task_struct *p, task_call_f func, void *arg)
  * @cpu: The CPU on which to snapshot the task.
  *
  * Returns the task_struct pointer of the task "currently" running on
- * the specified CPU.  If the same task is running on that CPU throughout,
- * the return value will be a pointer to that task's task_struct structure.
- * If the CPU did any context switches even vaguely concurrently with the
- * execution of this function, the return value will be a pointer to the
- * task_struct structure of a randomly chosen task that was running on
- * that CPU somewhere around the time that this function was executing.
+ * the specified CPU.
  *
  * If the specified CPU was offline, the return value is whatever it
  * is, perhaps a pointer to the task_struct structure of that CPU's idle
@@ -4337,11 +4332,16 @@ int task_call_func(struct task_struct *p, task_call_f func, void *arg)
  */
 struct task_struct *cpu_curr_snapshot(int cpu)
 {
+	struct rq *rq = cpu_rq(cpu);
 	struct task_struct *t;
+	struct rq_flags rf;
 
-	smp_mb(); /* Pairing determined by caller's synchronization design. */
+	rq_lock_irqsave(rq, &rf);
+	smp_mb__after_spinlock(); /* Pairing determined by caller's synchronization design. */
 	t = rcu_dereference(cpu_curr(cpu));
+	rq_unlock_irqrestore(rq, &rf);
 	smp_mb(); /* Pairing determined by caller's synchronization design. */
+
 	return t;
 }
 
-- 
2.43.0




