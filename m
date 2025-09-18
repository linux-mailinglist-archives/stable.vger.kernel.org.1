Return-Path: <stable+bounces-168339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF468B23439
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1D527B8C19
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F872F4A0A;
	Tue, 12 Aug 2025 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zQusl0LA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55301DB92A;
	Tue, 12 Aug 2025 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023846; cv=none; b=bL8RdiIzA2JrNCArKS/8EIFShiedV4n2FSDhmYDi8aUe8ZWlwVJPE/aRuYxUYIryKEJqGcc9Z7Wa93ZKPMEBTGZACFWT1vxgevoyjCAVKJ6L/NpwlgYdfMhA6Q7VVsh0aHPIq06AtvvUgMQme2snYCO+fqbGR8yo2Mg0JgN3wTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023846; c=relaxed/simple;
	bh=q8PDctpHdxVfZNy6BXNusWgmQzfY16oVF6YxdN61dII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ay2thPr3N4IWBw2VWTGqSqyVlbX4vTbijwTuCnTuokFyUQ0JCjxDpKe6S/Uvbx0HdZ/EDQKShH3GAUPURDQO6OntGGz5ch2yVCAcFa0B2a/VZG8oWQpJHxkz7VCsUCEOC6fCITn6jSSzecC2oDDsceJKohDyeH0KL7kPS6wF2W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zQusl0LA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AC7C4CEF0;
	Tue, 12 Aug 2025 18:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755023846;
	bh=q8PDctpHdxVfZNy6BXNusWgmQzfY16oVF6YxdN61dII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zQusl0LAYa8RXmT3G0Wkx055S2czD3P4YYd9korS4tdLG6BdjcVLiESjHeAnMyk5b
	 01e6SHzF8DUZRSS52pVFsH9hzcBLjtZ3xvHoWXUpismuwBp+z6e0n/YKCXS1MNsq4k
	 rZCc2tBwDvU8BjK+TXQury4qHXfHP8unWiKKp0Qo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 198/627] sched/psi: Optimize psi_group_change() cpu_clock() usage
Date: Tue, 12 Aug 2025 19:28:13 +0200
Message-ID: <20250812173426.814633537@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 570c8efd5eb79c3725ba439ce105ed1bedc5acd9 ]

Dietmar reported that commit 3840cbe24cf0 ("sched: psi: fix bogus
pressure spikes from aggregation race") caused a regression for him on
a high context switch rate benchmark (schbench) due to the now
repeating cpu_clock() calls.

In particular the problem is that get_recent_times() will extrapolate
the current state to 'now'. But if an update uses a timestamp from
before the start of the update, it is possible to get two reads
with inconsistent results. It is effectively back-dating an update.

(note that this all hard-relies on the clock being synchronized across
CPUs -- if this is not the case, all bets are off).

Combine this problem with the fact that there are per-group-per-cpu
seqcounts, the commit in question pushed the clock read into the group
iteration, causing tree-depth cpu_clock() calls. On architectures
where cpu_clock() has appreciable overhead, this hurts.

Instead move to a per-cpu seqcount, which allows us to have a single
clock read for all group updates, increasing internal consistency and
lowering update overhead. This comes at the cost of a longer update
side (proportional to the tree depth) which can cause the read side to
retry more often.

Fixes: 3840cbe24cf0 ("sched: psi: fix bogus pressure spikes from aggregation race")
Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>,
Link: https://lkml.kernel.org/20250522084844.GC31726@noisy.programming.kicks-ass.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/psi_types.h |   6 +-
 kernel/sched/psi.c        | 121 +++++++++++++++++++++-----------------
 2 files changed, 68 insertions(+), 59 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index f1fd3a8044e0..dd10c22299ab 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -84,11 +84,9 @@ enum psi_aggregators {
 struct psi_group_cpu {
 	/* 1st cacheline updated by the scheduler */
 
-	/* Aggregator needs to know of concurrent changes */
-	seqcount_t seq ____cacheline_aligned_in_smp;
-
 	/* States of the tasks belonging to this group */
-	unsigned int tasks[NR_PSI_TASK_COUNTS];
+	unsigned int tasks[NR_PSI_TASK_COUNTS]
+			____cacheline_aligned_in_smp;
 
 	/* Aggregate pressure state derived from the tasks */
 	u32 state_mask;
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index ad04a5c3162a..5f7c023c4cca 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -172,6 +172,28 @@ struct psi_group psi_system = {
 	.pcpu = &system_group_pcpu,
 };
 
+static DEFINE_PER_CPU(seqcount_t, psi_seq);
+
+static inline void psi_write_begin(int cpu)
+{
+	write_seqcount_begin(per_cpu_ptr(&psi_seq, cpu));
+}
+
+static inline void psi_write_end(int cpu)
+{
+	write_seqcount_end(per_cpu_ptr(&psi_seq, cpu));
+}
+
+static inline u32 psi_read_begin(int cpu)
+{
+	return read_seqcount_begin(per_cpu_ptr(&psi_seq, cpu));
+}
+
+static inline bool psi_read_retry(int cpu, u32 seq)
+{
+	return read_seqcount_retry(per_cpu_ptr(&psi_seq, cpu), seq);
+}
+
 static void psi_avgs_work(struct work_struct *work);
 
 static void poll_timer_fn(struct timer_list *t);
@@ -182,7 +204,7 @@ static void group_init(struct psi_group *group)
 
 	group->enabled = true;
 	for_each_possible_cpu(cpu)
-		seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
+		seqcount_init(per_cpu_ptr(&psi_seq, cpu));
 	group->avg_last_update = sched_clock();
 	group->avg_next_update = group->avg_last_update + psi_period;
 	mutex_init(&group->avgs_lock);
@@ -262,14 +284,14 @@ static void get_recent_times(struct psi_group *group, int cpu,
 
 	/* Snapshot a coherent view of the CPU state */
 	do {
-		seq = read_seqcount_begin(&groupc->seq);
+		seq = psi_read_begin(cpu);
 		now = cpu_clock(cpu);
 		memcpy(times, groupc->times, sizeof(groupc->times));
 		state_mask = groupc->state_mask;
 		state_start = groupc->state_start;
 		if (cpu == current_cpu)
 			memcpy(tasks, groupc->tasks, sizeof(groupc->tasks));
-	} while (read_seqcount_retry(&groupc->seq, seq));
+	} while (psi_read_retry(cpu, seq));
 
 	/* Calculate state time deltas against the previous snapshot */
 	for (s = 0; s < NR_PSI_STATES; s++) {
@@ -768,30 +790,20 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
 		groupc->times[PSI_NONIDLE] += delta;
 }
 
+#define for_each_group(iter, group) \
+	for (typeof(group) iter = group; iter; iter = iter->parent)
+
 static void psi_group_change(struct psi_group *group, int cpu,
 			     unsigned int clear, unsigned int set,
-			     bool wake_clock)
+			     u64 now, bool wake_clock)
 {
 	struct psi_group_cpu *groupc;
 	unsigned int t, m;
 	u32 state_mask;
-	u64 now;
 
 	lockdep_assert_rq_held(cpu_rq(cpu));
 	groupc = per_cpu_ptr(group->pcpu, cpu);
 
-	/*
-	 * First we update the task counts according to the state
-	 * change requested through the @clear and @set bits.
-	 *
-	 * Then if the cgroup PSI stats accounting enabled, we
-	 * assess the aggregate resource states this CPU's tasks
-	 * have been in since the last change, and account any
-	 * SOME and FULL time these may have resulted in.
-	 */
-	write_seqcount_begin(&groupc->seq);
-	now = cpu_clock(cpu);
-
 	/*
 	 * Start with TSK_ONCPU, which doesn't have a corresponding
 	 * task count - it's just a boolean flag directly encoded in
@@ -843,7 +855,6 @@ static void psi_group_change(struct psi_group *group, int cpu,
 
 		groupc->state_mask = state_mask;
 
-		write_seqcount_end(&groupc->seq);
 		return;
 	}
 
@@ -864,8 +875,6 @@ static void psi_group_change(struct psi_group *group, int cpu,
 
 	groupc->state_mask = state_mask;
 
-	write_seqcount_end(&groupc->seq);
-
 	if (state_mask & group->rtpoll_states)
 		psi_schedule_rtpoll_work(group, 1, false);
 
@@ -900,24 +909,29 @@ static void psi_flags_change(struct task_struct *task, int clear, int set)
 void psi_task_change(struct task_struct *task, int clear, int set)
 {
 	int cpu = task_cpu(task);
-	struct psi_group *group;
+	u64 now;
 
 	if (!task->pid)
 		return;
 
 	psi_flags_change(task, clear, set);
 
-	group = task_psi_group(task);
-	do {
-		psi_group_change(group, cpu, clear, set, true);
-	} while ((group = group->parent));
+	psi_write_begin(cpu);
+	now = cpu_clock(cpu);
+	for_each_group(group, task_psi_group(task))
+		psi_group_change(group, cpu, clear, set, now, true);
+	psi_write_end(cpu);
 }
 
 void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		     bool sleep)
 {
-	struct psi_group *group, *common = NULL;
+	struct psi_group *common = NULL;
 	int cpu = task_cpu(prev);
+	u64 now;
+
+	psi_write_begin(cpu);
+	now = cpu_clock(cpu);
 
 	if (next->pid) {
 		psi_flags_change(next, 0, TSK_ONCPU);
@@ -926,16 +940,15 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		 * ancestors with @prev, those will already have @prev's
 		 * TSK_ONCPU bit set, and we can stop the iteration there.
 		 */
-		group = task_psi_group(next);
-		do {
-			if (per_cpu_ptr(group->pcpu, cpu)->state_mask &
-			    PSI_ONCPU) {
+		for_each_group(group, task_psi_group(next)) {
+			struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
+
+			if (groupc->state_mask & PSI_ONCPU) {
 				common = group;
 				break;
 			}
-
-			psi_group_change(group, cpu, 0, TSK_ONCPU, true);
-		} while ((group = group->parent));
+			psi_group_change(group, cpu, 0, TSK_ONCPU, now, true);
+		}
 	}
 
 	if (prev->pid) {
@@ -968,12 +981,11 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 
 		psi_flags_change(prev, clear, set);
 
-		group = task_psi_group(prev);
-		do {
+		for_each_group(group, task_psi_group(prev)) {
 			if (group == common)
 				break;
-			psi_group_change(group, cpu, clear, set, wake_clock);
-		} while ((group = group->parent));
+			psi_group_change(group, cpu, clear, set, now, wake_clock);
+		}
 
 		/*
 		 * TSK_ONCPU is handled up to the common ancestor. If there are
@@ -983,20 +995,21 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		 */
 		if ((prev->psi_flags ^ next->psi_flags) & ~TSK_ONCPU) {
 			clear &= ~TSK_ONCPU;
-			for (; group; group = group->parent)
-				psi_group_change(group, cpu, clear, set, wake_clock);
+			for_each_group(group, common)
+				psi_group_change(group, cpu, clear, set, now, wake_clock);
 		}
 	}
+	psi_write_end(cpu);
 }
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_struct *prev)
 {
 	int cpu = task_cpu(curr);
-	struct psi_group *group;
 	struct psi_group_cpu *groupc;
 	s64 delta;
 	u64 irq;
+	u64 now;
 
 	if (static_branch_likely(&psi_disabled) || !irqtime_enabled())
 		return;
@@ -1005,8 +1018,7 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
 		return;
 
 	lockdep_assert_rq_held(rq);
-	group = task_psi_group(curr);
-	if (prev && task_psi_group(prev) == group)
+	if (prev && task_psi_group(prev) == task_psi_group(curr))
 		return;
 
 	irq = irq_time_read(cpu);
@@ -1015,25 +1027,22 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
 		return;
 	rq->psi_irq_time = irq;
 
-	do {
-		u64 now;
+	psi_write_begin(cpu);
+	now = cpu_clock(cpu);
 
+	for_each_group(group, task_psi_group(curr)) {
 		if (!group->enabled)
 			continue;
 
 		groupc = per_cpu_ptr(group->pcpu, cpu);
 
-		write_seqcount_begin(&groupc->seq);
-		now = cpu_clock(cpu);
-
 		record_times(groupc, now);
 		groupc->times[PSI_IRQ_FULL] += delta;
 
-		write_seqcount_end(&groupc->seq);
-
 		if (group->rtpoll_states & (1 << PSI_IRQ_FULL))
 			psi_schedule_rtpoll_work(group, 1, false);
-	} while ((group = group->parent));
+	}
+	psi_write_end(cpu);
 }
 #endif
 
@@ -1221,12 +1230,14 @@ void psi_cgroup_restart(struct psi_group *group)
 		return;
 
 	for_each_possible_cpu(cpu) {
-		struct rq *rq = cpu_rq(cpu);
-		struct rq_flags rf;
+		u64 now;
 
-		rq_lock_irq(rq, &rf);
-		psi_group_change(group, cpu, 0, 0, true);
-		rq_unlock_irq(rq, &rf);
+		guard(rq_lock_irq)(cpu_rq(cpu));
+
+		psi_write_begin(cpu);
+		now = cpu_clock(cpu);
+		psi_group_change(group, cpu, 0, 0, now, true);
+		psi_write_end(cpu);
 	}
 }
 #endif /* CONFIG_CGROUPS */
-- 
2.39.5




