Return-Path: <stable+bounces-204485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B734CEED82
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 16:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91787300E78C
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 15:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B6925F7A5;
	Fri,  2 Jan 2026 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmIgLZGE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579D625B31D
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767367177; cv=none; b=Z4QtzIxCRHv1ionwywZtS4Rk06Zf3y58QYWsnYgOJ9CzHlDAwMB66OIv3OarNFA+DTOI1g9/LRuOXy+wc4w6q8/4qKy1MHUltmy6ieyq9L3MyV1f2YyfxWy91zRp5+to9101cno1od9FIW/p6DCBxwo6jPjI0AfTW9I/Trf2yN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767367177; c=relaxed/simple;
	bh=UEMe/Repnd3Xt4dO6KCwWABVFtzYgO95T/vNVSXKQnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LgRj6C+xGixnRDIxD/jMEo9vwOkAZIn8+rQx/4V2Ox/OeqoL8gJ+rJHIi9WfaLIZ5rV03X+duLe407ti2NXLS8fA8D1iyPN4ky0uyBo0S2n0CIKP6dl4FQKsXNlpsqGV/SuhyZOsjFr3IbfC2dmpqC4hxnhgbnOW7B62d8xK3hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmIgLZGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787E7C116D0;
	Fri,  2 Jan 2026 15:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767367176;
	bh=UEMe/Repnd3Xt4dO6KCwWABVFtzYgO95T/vNVSXKQnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fmIgLZGEp/mGihT/GbIbIBu9nnanMS0g1EIK2L3hE2s1vnjEEw9a5ie0r0nnWUX0h
	 sQbgTv9/51dR64lO28uZy+rZaCiNr53XQDAH/y3FXVyl8vZ+BGPoIbNb8mW+KpM6wt
	 u4Md3oGcu1AgHwYY+eYpI5dnka6oKcjKik3MC3KZBlt0rO3o0bSx1HlbUcPq6O+Vu5
	 P4O5dhhqVExHFpSTRWgKaBNnRgNWEdEs6eVHy3L4D/QmSR53uzY4EmBGZ1T9UYicAg
	 H1zubNlJGuDHCnfVcXhLL5qU+OyyQGoXlCJ7WBiMp0rVwVAfNH7Ib4VOsdFWusBy6j
	 v96LecORt86VA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] sched/core: Add comment explaining force-idle vruntime snapshots
Date: Fri,  2 Jan 2026 10:19:30 -0500
Message-ID: <20260102151931.300967-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260102151931.300967-1-sashal@kernel.org>
References: <2025122903-sterile-from-4520@gregkh>
 <20260102151931.300967-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 9359d9785d85bb53f1ff1738a59aeeec4b878906 ]

I always end up having to re-read these emails every time I look at
this code. And a future patch is going to change this story a little.
This means it is past time to stick them in a comment so it can be
modified and stay current.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200506143506.GH5298@hirez.programming.kicks-ass.net
Link: https://lkml.kernel.org/r/20200515103844.GG2978@hirez.programming.kicks-ass.net
Link: https://patch.msgid.link/20251106111603.GB4068168@noisy.programming.kicks-ass.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/fair.c | 181 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 181 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cf3a51f323e3..e020bcf8b007 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12566,6 +12566,187 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
 		resched_curr(rq);
 }
 
+/*
+ * Consider any infeasible weight scenario. Take for instance two tasks,
+ * each bound to their respective sibling, one with weight 1 and one with
+ * weight 2. Then the lower weight task will run ahead of the higher weight
+ * task without bound.
+ *
+ * This utterly destroys the concept of a shared time base.
+ *
+ * Remember; all this is about a proportionally fair scheduling, where each
+ * tasks receives:
+ *
+ *              w_i
+ *   dt_i = ---------- dt                                     (1)
+ *          \Sum_j w_j
+ *
+ * which we do by tracking a virtual time, s_i:
+ *
+ *          1
+ *   s_i = --- d[t]_i                                         (2)
+ *         w_i
+ *
+ * Where d[t] is a delta of discrete time, while dt is an infinitesimal.
+ * The immediate corollary is that the ideal schedule S, where (2) to use
+ * an infinitesimal delta, is:
+ *
+ *           1
+ *   S = ---------- dt                                        (3)
+ *       \Sum_i w_i
+ *
+ * From which we can define the lag, or deviation from the ideal, as:
+ *
+ *   lag(i) = S - s_i                                         (4)
+ *
+ * And since the one and only purpose is to approximate S, we get that:
+ *
+ *   \Sum_i w_i lag(i) := 0                                   (5)
+ *
+ * If this were not so, we no longer converge to S, and we can no longer
+ * claim our scheduler has any of the properties we derive from S. This is
+ * exactly what you did above, you broke it!
+ *
+ *
+ * Let's continue for a while though; to see if there is anything useful to
+ * be learned. We can combine (1)-(3) or (4)-(5) and express S in s_i:
+ *
+ *       \Sum_i w_i s_i
+ *   S = --------------                                       (6)
+ *         \Sum_i w_i
+ *
+ * Which gives us a way to compute S, given our s_i. Now, if you've read
+ * our code, you know that we do not in fact do this, the reason for this
+ * is two-fold. Firstly, computing S in that way requires a 64bit division
+ * for every time we'd use it (see 12), and secondly, this only describes
+ * the steady-state, it doesn't handle dynamics.
+ *
+ * Anyway, in (6):  s_i -> x + (s_i - x), to get:
+ *
+ *           \Sum_i w_i (s_i - x)
+ *   S - x = --------------------                             (7)
+ *              \Sum_i w_i
+ *
+ * Which shows that S and s_i transform alike (which makes perfect sense
+ * given that S is basically the (weighted) average of s_i).
+ *
+ * Then:
+ *
+ *   x -> s_min := min{s_i}                                   (8)
+ *
+ * to obtain:
+ *
+ *               \Sum_i w_i (s_i - s_min)
+ *   S = s_min + ------------------------                     (9)
+ *                     \Sum_i w_i
+ *
+ * Which already looks familiar, and is the basis for our current
+ * approximation:
+ *
+ *   S ~= s_min                                              (10)
+ *
+ * Now, obviously, (10) is absolute crap :-), but it sorta works.
+ *
+ * So the thing to remember is that the above is strictly UP. It is
+ * possible to generalize to multiple runqueues -- however it gets really
+ * yuck when you have to add affinity support, as illustrated by our very
+ * first counter-example.
+ *
+ * Luckily I think we can avoid needing a full multi-queue variant for
+ * core-scheduling (or load-balancing). The crucial observation is that we
+ * only actually need this comparison in the presence of forced-idle; only
+ * then do we need to tell if the stalled rq has higher priority over the
+ * other.
+ *
+ * [XXX assumes SMT2; better consider the more general case, I suspect
+ * it'll work out because our comparison is always between 2 rqs and the
+ * answer is only interesting if one of them is forced-idle]
+ *
+ * And (under assumption of SMT2) when there is forced-idle, there is only
+ * a single queue, so everything works like normal.
+ *
+ * Let, for our runqueue 'k':
+ *
+ *   T_k = \Sum_i w_i s_i
+ *   W_k = \Sum_i w_i      ; for all i of k                  (11)
+ *
+ * Then we can write (6) like:
+ *
+ *         T_k
+ *   S_k = ---                                               (12)
+ *         W_k
+ *
+ * From which immediately follows that:
+ *
+ *           T_k + T_l
+ *   S_k+l = ---------                                       (13)
+ *           W_k + W_l
+ *
+ * On which we can define a combined lag:
+ *
+ *   lag_k+l(i) := S_k+l - s_i                               (14)
+ *
+ * And that gives us the tools to compare tasks across a combined runqueue.
+ *
+ *
+ * Combined this gives the following:
+ *
+ *  a) when a runqueue enters force-idle, sync it against it's sibling rq(s)
+ *     using (7); this only requires storing single 'time'-stamps.
+ *
+ *  b) when comparing tasks between 2 runqueues of which one is forced-idle,
+ *     compare the combined lag, per (14).
+ *
+ * Now, of course cgroups (I so hate them) make this more interesting in
+ * that a) seems to suggest we need to iterate all cgroup on a CPU at such
+ * boundaries, but I think we can avoid that. The force-idle is for the
+ * whole CPU, all it's rqs. So we can mark it in the root and lazily
+ * propagate downward on demand.
+ */
+
+/*
+ * So this sync is basically a relative reset of S to 0.
+ *
+ * So with 2 queues, when one goes idle, we drop them both to 0 and one
+ * then increases due to not being idle, and the idle one builds up lag to
+ * get re-elected. So far so simple, right?
+ *
+ * When there's 3, we can have the situation where 2 run and one is idle,
+ * we sync to 0 and let the idle one build up lag to get re-election. Now
+ * suppose another one also drops idle. At this point dropping all to 0
+ * again would destroy the built-up lag from the queue that was already
+ * idle, not good.
+ *
+ * So instead of syncing everything, we can:
+ *
+ *   less := !((s64)(s_a - s_b) <= 0)
+ *
+ *   (v_a - S_a) - (v_b - S_b) == v_a - v_b - S_a + S_b
+ *                             == v_a - (v_b - S_a + S_b)
+ *
+ * IOW, we can recast the (lag) comparison to a one-sided difference.
+ * So if then, instead of syncing the whole queue, sync the idle queue
+ * against the active queue with S_a + S_b at the point where we sync.
+ *
+ * (XXX consider the implication of living in a cyclic group: N / 2^n N)
+ *
+ * This gives us means of syncing single queues against the active queue,
+ * and for already idle queues to preserve their build-up lag.
+ *
+ * Of course, then we get the situation where there's 2 active and one
+ * going idle, who do we pick to sync against? Theory would have us sync
+ * against the combined S, but as we've already demonstrated, there is no
+ * such thing in infeasible weight scenarios.
+ *
+ * One thing I've considered; and this is where that core_active rudiment
+ * came from, is having active queues sync up between themselves after
+ * every tick. This limits the observed divergence due to the work
+ * conservancy.
+ *
+ * On top of that, we can improve upon things by moving away from our
+ * horrible (10) hack and moving to (9) and employing (13) here.
+ */
+
 /*
  * se_fi_update - Update the cfs_rq->min_vruntime_fi in a CFS hierarchy if needed.
  */
-- 
2.51.0


