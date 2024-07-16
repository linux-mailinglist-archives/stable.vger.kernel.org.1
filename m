Return-Path: <stable+bounces-60102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB52932D61
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2929F1F2115F
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4A419AD59;
	Tue, 16 Jul 2024 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rwtI0T4k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C83C1DDCE;
	Tue, 16 Jul 2024 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145880; cv=none; b=NGhf7Gfpt1EqmwNgFdfTDi8+u79gZYqKZU3cqjxkwcRC0nDhBPczLbsPhFG1cjb/H42kqkiQPrclXTxkXU9tDlxRNHqFdui7OjHsS29Fn1kNoCL2KhbYn4uHi3vPOla6wNWOFsjQkQQG4axKKLOC8dQ6Ef7dorC+wE11AMji5ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145880; c=relaxed/simple;
	bh=Bk/aGZTsnpf9ncIiSmBHnd4x/Q7bbBRn/FZkfSr90ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kV6NspPGhDFghr7tTWgDfzweSXVlbU65JOJdyy+UZDgkdQcJ3nGOnkT9AZ13ixoy/RQZLeWGqQPbGu/txE4I6Ua975ZXD/ESIJuCiDKGrDaQvxQ5+E/pWmYrMRXT2MiTr0Ef6o82sZiErsY4iSBN2E7TbJioAg+6CR9PjeZPQAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rwtI0T4k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1CFC116B1;
	Tue, 16 Jul 2024 16:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721145879;
	bh=Bk/aGZTsnpf9ncIiSmBHnd4x/Q7bbBRn/FZkfSr90ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rwtI0T4kAkeTmHuOm81aNd56cyQ36znAoufeypegedzXHmOK407YNfPvpYaQ3y4Ql
	 AgLNazsj+Ifr6rDpj6FQ/w8UNZo2ZLUCboZLjxseUeELmr1uclRJ+fya1V5A/SXtBf
	 4DpxUVDGmcHihhKCO7UGnCgzCuRJm4Av2YaplOmc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jimmy Shiu <jimmyshiu@google.com>,
	John Stultz <jstultz@google.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 6.6 108/121] sched: Move psi_account_irqtime() out of update_rq_clock_task() hotpath
Date: Tue, 16 Jul 2024 17:32:50 +0200
Message-ID: <20240716152755.484904405@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152751.312512071@linuxfoundation.org>
References: <20240716152751.312512071@linuxfoundation.org>
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

From: John Stultz <jstultz@google.com>

commit ddae0ca2a8fe12d0e24ab10ba759c3fbd755ada8 upstream.

It was reported that in moving to 6.1, a larger then 10%
regression was seen in the performance of
clock_gettime(CLOCK_THREAD_CPUTIME_ID,...).

Using a simple reproducer, I found:
5.10:
100000000 calls in 24345994193 ns => 243.460 ns per call
100000000 calls in 24288172050 ns => 242.882 ns per call
100000000 calls in 24289135225 ns => 242.891 ns per call

6.1:
100000000 calls in 28248646742 ns => 282.486 ns per call
100000000 calls in 28227055067 ns => 282.271 ns per call
100000000 calls in 28177471287 ns => 281.775 ns per call

The cause of this was finally narrowed down to the addition of
psi_account_irqtime() in update_rq_clock_task(), in commit
52b1364ba0b1 ("sched/psi: Add PSI_IRQ to track IRQ/SOFTIRQ
pressure").

In my initial attempt to resolve this, I leaned towards moving
all accounting work out of the clock_gettime() call path, but it
wasn't very pretty, so it will have to wait for a later deeper
rework. Instead, Peter shared this approach:

Rework psi_account_irqtime() to use its own psi_irq_time base
for accounting, and move it out of the hotpath, calling it
instead from sched_tick() and __schedule().

In testing this, we found the importance of ensuring
psi_account_irqtime() is run under the rq_lock, which Johannes
Weiner helpfully explained, so also add some lockdep annotations
to make that requirement clear.

With this change the performance is back in-line with 5.10:
6.1+fix:
100000000 calls in 24297324597 ns => 242.973 ns per call
100000000 calls in 24318869234 ns => 243.189 ns per call
100000000 calls in 24291564588 ns => 242.916 ns per call

Reported-by: Jimmy Shiu <jimmyshiu@google.com>
Originally-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Reviewed-by: Qais Yousef <qyousef@layalina.io>
Link: https://lore.kernel.org/r/20240618215909.4099720-1-jstultz@google.com
Fixes: 52b1364ba0b1 ("sched/psi: Add PSI_IRQ to track IRQ/SOFTIRQ pressure")
[jstultz: Fixed up minor collisions w/ 6.6-stable]
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/core.c  |    7 +++++--
 kernel/sched/psi.c   |   21 ++++++++++++++++-----
 kernel/sched/sched.h |    1 +
 kernel/sched/stats.h |   11 ++++++++---
 4 files changed, 30 insertions(+), 10 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -722,7 +722,6 @@ static void update_rq_clock_task(struct
 
 	rq->prev_irq_time += irq_delta;
 	delta -= irq_delta;
-	psi_account_irqtime(rq->curr, irq_delta);
 	delayacct_irq(rq->curr, irq_delta);
 #endif
 #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
@@ -5641,7 +5640,7 @@ void scheduler_tick(void)
 {
 	int cpu = smp_processor_id();
 	struct rq *rq = cpu_rq(cpu);
-	struct task_struct *curr = rq->curr;
+	struct task_struct *curr;
 	struct rq_flags rf;
 	unsigned long thermal_pressure;
 	u64 resched_latency;
@@ -5653,6 +5652,9 @@ void scheduler_tick(void)
 
 	rq_lock(rq, &rf);
 
+	curr = rq->curr;
+	psi_account_irqtime(rq, curr, NULL);
+
 	update_rq_clock(rq);
 	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
 	update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
@@ -6690,6 +6692,7 @@ static void __sched notrace __schedule(u
 		++*switch_count;
 
 		migrate_disable_switch(rq, prev);
+		psi_account_irqtime(rq, prev, next);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
 
 		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next, prev_state);
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -784,6 +784,7 @@ static void psi_group_change(struct psi_
 	enum psi_states s;
 	u32 state_mask;
 
+	lockdep_assert_rq_held(cpu_rq(cpu));
 	groupc = per_cpu_ptr(group->pcpu, cpu);
 
 	/*
@@ -1002,19 +1003,29 @@ void psi_task_switch(struct task_struct
 }
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
-void psi_account_irqtime(struct task_struct *task, u32 delta)
+void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_struct *prev)
 {
-	int cpu = task_cpu(task);
+	int cpu = task_cpu(curr);
 	struct psi_group *group;
 	struct psi_group_cpu *groupc;
-	u64 now;
+	u64 now, irq;
+	s64 delta;
 
-	if (!task->pid)
+	if (!curr->pid)
+		return;
+
+	lockdep_assert_rq_held(rq);
+	group = task_psi_group(curr);
+	if (prev && task_psi_group(prev) == group)
 		return;
 
 	now = cpu_clock(cpu);
+	irq = irq_time_read(cpu);
+	delta = (s64)(irq - rq->psi_irq_time);
+	if (delta < 0)
+		return;
+	rq->psi_irq_time = irq;
 
-	group = task_psi_group(task);
 	do {
 		if (!group->enabled)
 			continue;
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1094,6 +1094,7 @@ struct rq {
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 	u64			prev_irq_time;
+	u64			psi_irq_time;
 #endif
 #ifdef CONFIG_PARAVIRT
 	u64			prev_steal_time;
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -110,8 +110,12 @@ __schedstats_from_se(struct sched_entity
 void psi_task_change(struct task_struct *task, int clear, int set);
 void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		     bool sleep);
-void psi_account_irqtime(struct task_struct *task, u32 delta);
-
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_struct *prev);
+#else
+static inline void psi_account_irqtime(struct rq *rq, struct task_struct *curr,
+				       struct task_struct *prev) {}
+#endif /*CONFIG_IRQ_TIME_ACCOUNTING */
 /*
  * PSI tracks state that persists across sleeps, such as iowaits and
  * memory stalls. As a result, it has to distinguish between sleeps,
@@ -192,7 +196,8 @@ static inline void psi_ttwu_dequeue(stru
 static inline void psi_sched_switch(struct task_struct *prev,
 				    struct task_struct *next,
 				    bool sleep) {}
-static inline void psi_account_irqtime(struct task_struct *task, u32 delta) {}
+static inline void psi_account_irqtime(struct rq *rq, struct task_struct *curr,
+				       struct task_struct *prev) {}
 #endif /* CONFIG_PSI */
 
 #ifdef CONFIG_SCHED_INFO



