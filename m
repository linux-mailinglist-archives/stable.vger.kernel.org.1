Return-Path: <stable+bounces-83127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D00995E35
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 05:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7610281652
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 03:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7517710C;
	Wed,  9 Oct 2024 03:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="pzVaILRj"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF723207
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 03:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728445045; cv=none; b=iCPaPnW5GBx6Dd+5zZgrQwc+kFyd2hlK8gHYFG4hIhO44H7P7xUOGrFWK31mh8KU9wfzZurIpRSrcblIL0d8/meExuqdgp5+az9HAuTgBhBXbdNVRLrze0Vjsn9I8NcF9sB+pCvaJmpjGOtun8JNegva3LSfybRWb/2QrTU5v9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728445045; c=relaxed/simple;
	bh=iDXYJolSBaI+BNMbFcP23NyI609ldI0t331l+cJ2e8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CXfwIFbmczQLv2K1dDZNb6k42QoyWql+i5eTNWBv4Lk2jGDiObvBr1uL5Zx/MAVfSYgSKsK3f++uqFsHMUpcPYpB8/WjVUPePit1KD80o3XrY/kQWDb3LPSHTArJCZMblK+Hy13J/u16ELpNDGjLhAdEkSORxxmyYmrw/Ev+KE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=pzVaILRj; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost (unknown [10.102.139.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D13753F1C8;
	Wed,  9 Oct 2024 03:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1728445040;
	bh=IEwoDka519o9UDq2Z22va7aQH/El2dWWfkgm4Y78mQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=pzVaILRjS3bi/0qG2exnPUqxP22SU+KTi2tRH76CKXPFsdH7vk+kozLNl94bcBsP7
	 cnKMAqyElq0s7OOGfVGJu1MCIav67LsrLQZbrsAtgaPa/hAUd6eN95/um1dWgscdZL
	 iERIjshR+hV171AJ0GeJkR6k0psCZHKEFasc7MGlVW2peys8ReCEwiPDiFHwzzrhnU
	 mlOjUHKYQTCerD7b1gzCIslWoi+Ddc0boe+SSlRRKnBv3A4ox0ebC4D6GOC2ufWxJ2
	 9fIJi22RpORFoJsoXvfJnx4qYlkFWbVbcYtifiBsCfcG0/x1S6UDPPjKWKZhllqWP2
	 jgMOzIN5+JwgA==
From: "Yo-Jung (Leo) Lin" <leo.lin@canonical.com>
To: leo.lin@canonical.com
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Brandon Duffany <brandon@buildbuddy.io>,
	stable@vger.kernel.org,
	Chengming Zhou <chengming.zhou@linux.dev>
Subject: [PATCH] sched: psi: fix bogus pressure spikes from aggregation race
Date: Wed,  9 Oct 2024 11:37:16 +0800
Message-ID: <20241009033716.72852-1-leo.lin@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Weiner <hannes@cmpxchg.org>

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
---
 kernel/sched/psi.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

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
-- 
2.43.0


