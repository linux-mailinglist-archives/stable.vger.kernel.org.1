Return-Path: <stable+bounces-81345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD22993156
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F33284AA7
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 15:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A62F1D90C8;
	Mon,  7 Oct 2024 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FbIvow7D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1801D2714
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315293; cv=none; b=sXjQ5OUvMooD9l0N3kG+JbsoM7IoOipZyL2Z6xBBZ0Zo+qHU7qwm7sbSIhYy6aa645X2Bg1/qArSJTmlaUp3P0R4kW6J8y75cyUfo40WQEcAZyL2SurxC0vWGbfu3IzJfS4Se8AMUyL0hQR26zyY7UT10QCxQtB4dynWM/9sfQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315293; c=relaxed/simple;
	bh=hdXyO3CUcZCS+q0Dtd5IV/69iGBiF4TVLacblQEieLY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=t+i5fT44iWLK2TiM/xTdZcSgNOx0W1nAQKApjC3H+m5loFWCkUCsq+4ABnyawIfLTT4tWxqNz/cbVZ9pJI7n49qtfNjlvdggbwWoWvMXPQ2vN3oAqk4/uQOM+XVbXzmPhAjVenmxKFv7N8fr3eISH1ltzWJ8RB44RQw/wCFbZXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FbIvow7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3098EC4CEC6;
	Mon,  7 Oct 2024 15:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728315292;
	bh=hdXyO3CUcZCS+q0Dtd5IV/69iGBiF4TVLacblQEieLY=;
	h=Subject:To:Cc:From:Date:From;
	b=FbIvow7DNvS8NPHI9ay5puXWknxslRw4hdM/bJu0Ub3vEc4SqP0TTPdVtCO96zyk+
	 o4AhHh4NAxI7fPMukzvX7XXoSM4X3cuKIP0i1+CK1piMPPYSkx6TAoUEFPn+xkAIly
	 538VWaVLjoVX4LEysvNrW75gM9aA7iqe76v24JQ8=
Subject: FAILED: patch "[PATCH] sched: psi: fix bogus pressure spikes from aggregation race" failed to apply to 6.1-stable tree
To: hannes@cmpxchg.org,brandon@buildbuddy.io,chengming.zhou@linux.dev,torvalds@linux-foundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 17:34:44 +0200
Message-ID: <2024100744-slurp-uncouple-456c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3840cbe24cf060ea05a585ca497814609f5d47d1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100744-slurp-uncouple-456c@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

3840cbe24cf0 ("sched: psi: fix bogus pressure spikes from aggregation race")
ddae0ca2a8fe ("sched: Move psi_account_irqtime() out of update_rq_clock_task() hotpath")
0c2924079f5a ("sched/psi: Bail out early from irq time accounting")
a3b2aeac9d15 ("delayacct: track delays from IRQ/SOFTIRQ")
eca7de7cdc38 ("delayacct: improve the average delay precision of getdelay tool to microsecond")
6ab587e8e8b4 ("docs/zh_CN: Update the translation of delay-accounting to 6.1-rc8")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3840cbe24cf060ea05a585ca497814609f5d47d1 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Thu, 3 Oct 2024 07:29:05 -0400
Subject: [PATCH] sched: psi: fix bogus pressure spikes from aggregation race

Brandon reports sporadic, non-sensical spikes in cumulative pressure
time (total=) when reading cpu.pressure at a high rate. This is due to
a race condition between reader aggregation and tasks changing states.

While it affects all states and all resources captured by PSI, in
practice it most likely triggers with CPU pressure, since scheduling
events are so frequent compared to other resource events.

The race context is the live snooping of ongoing stalls during a
pressure read. The read aggregates per-cpu records for stalls that
have concluded, but will also incorporate ad-hoc the duration of any
active state that hasn't been recorded yet. This is important to get
timely measurements of ongoing stalls. Those ad-hoc samples are
calculated on-the-fly up to the current time on that CPU; since the
stall hasn't concluded, it's expected that this is the minimum amount
of stall time that will enter the per-cpu records once it does.

The problem is that the path that concludes the state uses a CPU clock
read that is not synchronized against aggregators; the clock is read
outside of the seqlock protection. This allows aggregators to race and
snoop a stall with a longer duration than will actually be recorded.

With the recorded stall time being less than the last snapshot
remembered by the aggregator, a subsequent sample will underflow and
observe a bogus delta value, resulting in an erratic jump in pressure.

Fix this by moving the clock read of the state change into the seqlock
protection. This ensures no aggregation can snoop live stalls past the
time that's recorded when the state concludes.

Reported-by: Brandon Duffany <brandon@buildbuddy.io>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219194
Link: https://lore.kernel.org/lkml/20240827121851.GB438928@cmpxchg.org/
Fixes: df77430639c9 ("psi: Reduce calls to sched_clock() in psi")
Cc: stable@vger.kernel.org
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 020d58967d4e..84dad1511d1e 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -769,12 +769,13 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
 }
 
 static void psi_group_change(struct psi_group *group, int cpu,
-			     unsigned int clear, unsigned int set, u64 now,
+			     unsigned int clear, unsigned int set,
 			     bool wake_clock)
 {
 	struct psi_group_cpu *groupc;
 	unsigned int t, m;
 	u32 state_mask;
+	u64 now;
 
 	lockdep_assert_rq_held(cpu_rq(cpu));
 	groupc = per_cpu_ptr(group->pcpu, cpu);
@@ -789,6 +790,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	 * SOME and FULL time these may have resulted in.
 	 */
 	write_seqcount_begin(&groupc->seq);
+	now = cpu_clock(cpu);
 
 	/*
 	 * Start with TSK_ONCPU, which doesn't have a corresponding
@@ -899,18 +901,15 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 {
 	int cpu = task_cpu(task);
 	struct psi_group *group;
-	u64 now;
 
 	if (!task->pid)
 		return;
 
 	psi_flags_change(task, clear, set);
 
-	now = cpu_clock(cpu);
-
 	group = task_psi_group(task);
 	do {
-		psi_group_change(group, cpu, clear, set, now, true);
+		psi_group_change(group, cpu, clear, set, true);
 	} while ((group = group->parent));
 }
 
@@ -919,7 +918,6 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 {
 	struct psi_group *group, *common = NULL;
 	int cpu = task_cpu(prev);
-	u64 now = cpu_clock(cpu);
 
 	if (next->pid) {
 		psi_flags_change(next, 0, TSK_ONCPU);
@@ -936,7 +934,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 				break;
 			}
 
-			psi_group_change(group, cpu, 0, TSK_ONCPU, now, true);
+			psi_group_change(group, cpu, 0, TSK_ONCPU, true);
 		} while ((group = group->parent));
 	}
 
@@ -974,7 +972,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		do {
 			if (group == common)
 				break;
-			psi_group_change(group, cpu, clear, set, now, wake_clock);
+			psi_group_change(group, cpu, clear, set, wake_clock);
 		} while ((group = group->parent));
 
 		/*
@@ -986,7 +984,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		if ((prev->psi_flags ^ next->psi_flags) & ~TSK_ONCPU) {
 			clear &= ~TSK_ONCPU;
 			for (; group; group = group->parent)
-				psi_group_change(group, cpu, clear, set, now, wake_clock);
+				psi_group_change(group, cpu, clear, set, wake_clock);
 		}
 	}
 }
@@ -997,8 +995,8 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
 	int cpu = task_cpu(curr);
 	struct psi_group *group;
 	struct psi_group_cpu *groupc;
-	u64 now, irq;
 	s64 delta;
+	u64 irq;
 
 	if (static_branch_likely(&psi_disabled))
 		return;
@@ -1011,7 +1009,6 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
 	if (prev && task_psi_group(prev) == group)
 		return;
 
-	now = cpu_clock(cpu);
 	irq = irq_time_read(cpu);
 	delta = (s64)(irq - rq->psi_irq_time);
 	if (delta < 0)
@@ -1019,12 +1016,15 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
 	rq->psi_irq_time = irq;
 
 	do {
+		u64 now;
+
 		if (!group->enabled)
 			continue;
 
 		groupc = per_cpu_ptr(group->pcpu, cpu);
 
 		write_seqcount_begin(&groupc->seq);
+		now = cpu_clock(cpu);
 
 		record_times(groupc, now);
 		groupc->times[PSI_IRQ_FULL] += delta;
@@ -1223,11 +1223,9 @@ void psi_cgroup_restart(struct psi_group *group)
 	for_each_possible_cpu(cpu) {
 		struct rq *rq = cpu_rq(cpu);
 		struct rq_flags rf;
-		u64 now;
 
 		rq_lock_irq(rq, &rf);
-		now = cpu_clock(cpu);
-		psi_group_change(group, cpu, 0, 0, now, true);
+		psi_group_change(group, cpu, 0, 0, true);
 		rq_unlock_irq(rq, &rf);
 	}
 }


