Return-Path: <stable+bounces-204126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE20CE80C7
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 20:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBCB9300BA1E
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 19:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBD91474CC;
	Mon, 29 Dec 2025 19:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nl33+rHc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9183A1E94
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767036943; cv=none; b=qIL5Q1syroMZcr7rUUW3MYY7XunUyxmOElIdEWmqcvXmwt1uEg1aA5TW0HkmP8eTy6dG9kIaBgbsSuo2Vk6/AIazaHp6QQ+LMxSI3ehu3vsZmyg+gk5GvMLBsqG/J2HaHntEdni2ZEeLSPMXhIyVdvwre7h9F6u/XCDwRhaPzzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767036943; c=relaxed/simple;
	bh=w67wbNTU0o1mLHdsW6PZkyAvztB1DW5SPIqFqfmK0HI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mi1qHUTrvGF4J3K+pKrhW85MSuWERvcDXMKW89t10k6jQU1PKS9fUkUwV5pg6oLjDv8LpuSQduvo0sa5jmo7SEkt664U4ecwnYe2B82MXzlPHiQG4SzYYktS4IuPYpdTYNrUhwVaJdTYOikGACHKBxxOs4xT5gA5hhgZMwOmmjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nl33+rHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6BCC16AAE;
	Mon, 29 Dec 2025 19:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767036942;
	bh=w67wbNTU0o1mLHdsW6PZkyAvztB1DW5SPIqFqfmK0HI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nl33+rHc2pigKo4ttlfENtHrRmJLr2ZYMM0aY6N9MzyYRUdq8yqZ3Kl9HvCC7m9/e
	 M7G+vAIfTBtHLeGKpwdJswSTqCv8fGB6ZKBVG6r4e1JKbBwV+JNk2P3gJBRedZZYcN
	 CP81bxRy/Azl+BiTZWIMRA+3Ohj498YNExaI+zxQQ/oas77AbFDaqvU1xWIz9c/Oto
	 iz8/poZHnrr0vXo6vFdDS9aSTfUO9tyeBzZRwXyT33TUpl3tNpYELKtjaxUaiA76L3
	 w/TbrYmwV7673e7aBY1KPGZ/deI4edXLA2rqZGesIs5tacKdiKo8NGYMjHD6qa8oVp
	 9Y2WaNE9CCrhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Zicheng Qu <quzicheng@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] sched/eevdf: Fix min_vruntime vs avg_vruntime
Date: Mon, 29 Dec 2025 14:35:38 -0500
Message-ID: <20251229193539.1640748-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229193539.1640748-1-sashal@kernel.org>
References: <2025122900-pug-tartly-0d84@gregkh>
 <20251229193539.1640748-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 79f3f9bedd149ea438aaeb0fb6a083637affe205 ]

Basically, from the constraint that the sum of lag is zero, you can
infer that the 0-lag point is the weighted average of the individual
vruntime, which is what we're trying to compute:

        \Sum w_i * v_i
  avg = --------------
           \Sum w_i

Now, since vruntime takes the whole u64 (worse, it wraps), this
multiplication term in the numerator is not something we can compute;
instead we do the min_vruntime (v0 henceforth) thing like:

  v_i = (v_i - v0) + v0

This does two things:
 - it keeps the key: (v_i - v0) 'small';
 - it creates a relative 0-point in the modular space.

If you do that subtitution and work it all out, you end up with:

        \Sum w_i * (v_i - v0)
  avg = --------------------- + v0
              \Sum w_i

Since you cannot very well track a ratio like that (and not suffer
terrible numerical problems) we simpy track the numerator and
denominator individually and only perform the division when strictly
needed.

Notably, the numerator lives in cfs_rq->avg_vruntime and the denominator
lives in cfs_rq->avg_load.

The one extra 'funny' is that these numbers track the entities in the
tree, and current is typically outside of the tree, so avg_vruntime()
adds current when needed before doing the division.

(vruntime_eligible() elides the division by cross-wise multiplication)

Anyway, as mentioned above, we currently use the CFS era min_vruntime
for this purpose. However, this thing can only move forward, while the
above avg can in fact move backward (when a non-eligible task leaves,
the average becomes smaller), this can cause trouble when through
happenstance (or construction) these values drift far enough apart to
wreck the game.

Replace cfs_rq::min_vruntime with cfs_rq::zero_vruntime which is kept
near/at avg_vruntime, following its motion.

The down-side is that this requires computing the avg more often.

Fixes: 147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling policy")
Reported-by: Zicheng Qu <quzicheng@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251106111741.GC4068168@noisy.programming.kicks-ass.net
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/debug.c |   8 +--
 kernel/sched/fair.c  | 114 ++++++++++---------------------------------
 kernel/sched/sched.h |   4 +-
 3 files changed, 31 insertions(+), 95 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 02e16b70a790..41caa22e0680 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -796,7 +796,7 @@ static void print_rq(struct seq_file *m, struct rq *rq, int rq_cpu)
 
 void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 {
-	s64 left_vruntime = -1, min_vruntime, right_vruntime = -1, left_deadline = -1, spread;
+	s64 left_vruntime = -1, zero_vruntime, right_vruntime = -1, left_deadline = -1, spread;
 	struct sched_entity *last, *first, *root;
 	struct rq *rq = cpu_rq(cpu);
 	unsigned long flags;
@@ -819,15 +819,15 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	last = __pick_last_entity(cfs_rq);
 	if (last)
 		right_vruntime = last->vruntime;
-	min_vruntime = cfs_rq->min_vruntime;
+	zero_vruntime = cfs_rq->zero_vruntime;
 	raw_spin_rq_unlock_irqrestore(rq, flags);
 
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "left_deadline",
 			SPLIT_NS(left_deadline));
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "left_vruntime",
 			SPLIT_NS(left_vruntime));
-	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "min_vruntime",
-			SPLIT_NS(min_vruntime));
+	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "zero_vruntime",
+			SPLIT_NS(zero_vruntime));
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "avg_vruntime",
 			SPLIT_NS(avg_vruntime(cfs_rq)));
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "right_vruntime",
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6d6b2205f23e..0149d346b266 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -554,7 +554,7 @@ static inline bool entity_before(const struct sched_entity *a,
 
 static inline s64 entity_key(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	return (s64)(se->vruntime - cfs_rq->min_vruntime);
+	return (s64)(se->vruntime - cfs_rq->zero_vruntime);
 }
 
 #define __node_2_se(node) \
@@ -606,13 +606,13 @@ static inline s64 entity_key(struct cfs_rq *cfs_rq, struct sched_entity *se)
  *
  * Which we track using:
  *
- *                    v0 := cfs_rq->min_vruntime
+ *                    v0 := cfs_rq->zero_vruntime
  * \Sum (v_i - v0) * w_i := cfs_rq->avg_vruntime
  *              \Sum w_i := cfs_rq->avg_load
  *
- * Since min_vruntime is a monotonic increasing variable that closely tracks
- * the per-task service, these deltas: (v_i - v), will be in the order of the
- * maximal (virtual) lag induced in the system due to quantisation.
+ * Since zero_vruntime closely tracks the per-task service, these
+ * deltas: (v_i - v), will be in the order of the maximal (virtual) lag
+ * induced in the system due to quantisation.
  *
  * Also, we use scale_load_down() to reduce the size.
  *
@@ -671,7 +671,7 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
 		avg = div_s64(avg, load);
 	}
 
-	return cfs_rq->min_vruntime + avg;
+	return cfs_rq->zero_vruntime + avg;
 }
 
 /*
@@ -732,7 +732,7 @@ static int vruntime_eligible(struct cfs_rq *cfs_rq, u64 vruntime)
 		load += weight;
 	}
 
-	return avg >= (s64)(vruntime - cfs_rq->min_vruntime) * load;
+	return avg >= (s64)(vruntime - cfs_rq->zero_vruntime) * load;
 }
 
 int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
@@ -740,42 +740,14 @@ int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	return vruntime_eligible(cfs_rq, se->vruntime);
 }
 
-static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
+static void update_zero_vruntime(struct cfs_rq *cfs_rq)
 {
-	u64 min_vruntime = cfs_rq->min_vruntime;
-	/*
-	 * open coded max_vruntime() to allow updating avg_vruntime
-	 */
-	s64 delta = (s64)(vruntime - min_vruntime);
-	if (delta > 0) {
-		avg_vruntime_update(cfs_rq, delta);
-		min_vruntime = vruntime;
-	}
-	return min_vruntime;
-}
+	u64 vruntime = avg_vruntime(cfs_rq);
+	s64 delta = (s64)(vruntime - cfs_rq->zero_vruntime);
 
-static void update_min_vruntime(struct cfs_rq *cfs_rq)
-{
-	struct sched_entity *se = __pick_root_entity(cfs_rq);
-	struct sched_entity *curr = cfs_rq->curr;
-	u64 vruntime = cfs_rq->min_vruntime;
-
-	if (curr) {
-		if (curr->on_rq)
-			vruntime = curr->vruntime;
-		else
-			curr = NULL;
-	}
+	avg_vruntime_update(cfs_rq, delta);
 
-	if (se) {
-		if (!curr)
-			vruntime = se->min_vruntime;
-		else
-			vruntime = min_vruntime(vruntime, se->min_vruntime);
-	}
-
-	/* ensure we never gain time by being placed backwards. */
-	cfs_rq->min_vruntime = __update_min_vruntime(cfs_rq, vruntime);
+	cfs_rq->zero_vruntime = vruntime;
 }
 
 static inline u64 cfs_rq_min_slice(struct cfs_rq *cfs_rq)
@@ -848,6 +820,7 @@ RB_DECLARE_CALLBACKS(static, min_vruntime_cb, struct sched_entity,
 static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	avg_vruntime_add(cfs_rq, se);
+	update_zero_vruntime(cfs_rq);
 	se->min_vruntime = se->vruntime;
 	se->min_slice = se->slice;
 	rb_add_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
@@ -859,6 +832,7 @@ static void __dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	rb_erase_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
 				  &min_vruntime_cb);
 	avg_vruntime_sub(cfs_rq, se);
+	update_zero_vruntime(cfs_rq);
 }
 
 struct sched_entity *__pick_root_entity(struct cfs_rq *cfs_rq)
@@ -1226,7 +1200,6 @@ static void update_curr(struct cfs_rq *cfs_rq)
 
 	curr->vruntime += calc_delta_fair(delta_exec, curr);
 	resched = update_deadline(cfs_rq, curr);
-	update_min_vruntime(cfs_rq);
 
 	if (entity_is_task(curr)) {
 		/*
@@ -3808,15 +3781,6 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		if (!curr)
 			__enqueue_entity(cfs_rq, se);
 		cfs_rq->nr_queued++;
-
-		/*
-		 * The entity's vruntime has been adjusted, so let's check
-		 * whether the rq-wide min_vruntime needs updated too. Since
-		 * the calculations above require stable min_vruntime rather
-		 * than up-to-date one, we do the update at the end of the
-		 * reweight process.
-		 */
-		update_min_vruntime(cfs_rq);
 	}
 }
 
@@ -5432,15 +5396,6 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	update_cfs_group(se);
 
-	/*
-	 * Now advance min_vruntime if @se was the entity holding it back,
-	 * except when: DEQUEUE_SAVE && !DEQUEUE_MOVE, in this case we'll be
-	 * put back on, and if we advance min_vruntime, we'll be placed back
-	 * further than we started -- i.e. we'll be penalized.
-	 */
-	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) != DEQUEUE_SAVE)
-		update_min_vruntime(cfs_rq);
-
 	if (flags & DEQUEUE_DELAYED)
 		finish_delayed_dequeue_entity(se);
 
@@ -9028,7 +8983,6 @@ static void yield_task_fair(struct rq *rq)
 	if (entity_eligible(cfs_rq, se)) {
 		se->vruntime = se->deadline;
 		se->deadline += calc_delta_fair(se->slice, se);
-		update_min_vruntime(cfs_rq);
 	}
 }
 
@@ -13090,23 +13044,6 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
  * Which shows that S and s_i transform alike (which makes perfect sense
  * given that S is basically the (weighted) average of s_i).
  *
- * Then:
- *
- *   x -> s_min := min{s_i}                                   (8)
- *
- * to obtain:
- *
- *               \Sum_i w_i (s_i - s_min)
- *   S = s_min + ------------------------                     (9)
- *                     \Sum_i w_i
- *
- * Which already looks familiar, and is the basis for our current
- * approximation:
- *
- *   S ~= s_min                                              (10)
- *
- * Now, obviously, (10) is absolute crap :-), but it sorta works.
- *
  * So the thing to remember is that the above is strictly UP. It is
  * possible to generalize to multiple runqueues -- however it gets really
  * yuck when you have to add affinity support, as illustrated by our very
@@ -13128,23 +13065,23 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
  * Let, for our runqueue 'k':
  *
  *   T_k = \Sum_i w_i s_i
- *   W_k = \Sum_i w_i      ; for all i of k                  (11)
+ *   W_k = \Sum_i w_i      ; for all i of k                  (8)
  *
  * Then we can write (6) like:
  *
  *         T_k
- *   S_k = ---                                               (12)
+ *   S_k = ---                                               (9)
  *         W_k
  *
  * From which immediately follows that:
  *
  *           T_k + T_l
- *   S_k+l = ---------                                       (13)
+ *   S_k+l = ---------                                       (10)
  *           W_k + W_l
  *
  * On which we can define a combined lag:
  *
- *   lag_k+l(i) := S_k+l - s_i                               (14)
+ *   lag_k+l(i) := S_k+l - s_i                               (11)
  *
  * And that gives us the tools to compare tasks across a combined runqueue.
  *
@@ -13155,7 +13092,7 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
  *     using (7); this only requires storing single 'time'-stamps.
  *
  *  b) when comparing tasks between 2 runqueues of which one is forced-idle,
- *     compare the combined lag, per (14).
+ *     compare the combined lag, per (11).
  *
  * Now, of course cgroups (I so hate them) make this more interesting in
  * that a) seems to suggest we need to iterate all cgroup on a CPU at such
@@ -13203,12 +13140,11 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
  * every tick. This limits the observed divergence due to the work
  * conservancy.
  *
- * On top of that, we can improve upon things by moving away from our
- * horrible (10) hack and moving to (9) and employing (13) here.
+ * On top of that, we can improve upon things by employing (10) here.
  */
 
 /*
- * se_fi_update - Update the cfs_rq->min_vruntime_fi in a CFS hierarchy if needed.
+ * se_fi_update - Update the cfs_rq->zero_vruntime_fi in a CFS hierarchy if needed.
  */
 static void se_fi_update(const struct sched_entity *se, unsigned int fi_seq,
 			 bool forceidle)
@@ -13222,7 +13158,7 @@ static void se_fi_update(const struct sched_entity *se, unsigned int fi_seq,
 			cfs_rq->forceidle_seq = fi_seq;
 		}
 
-		cfs_rq->min_vruntime_fi = cfs_rq->min_vruntime;
+		cfs_rq->zero_vruntime_fi = cfs_rq->zero_vruntime;
 	}
 }
 
@@ -13275,11 +13211,11 @@ bool cfs_prio_less(const struct task_struct *a, const struct task_struct *b,
 
 	/*
 	 * Find delta after normalizing se's vruntime with its cfs_rq's
-	 * min_vruntime_fi, which would have been updated in prior calls
+	 * zero_vruntime_fi, which would have been updated in prior calls
 	 * to se_fi_update().
 	 */
 	delta = (s64)(sea->vruntime - seb->vruntime) +
-		(s64)(cfs_rqb->min_vruntime_fi - cfs_rqa->min_vruntime_fi);
+		(s64)(cfs_rqb->zero_vruntime_fi - cfs_rqa->zero_vruntime_fi);
 
 	return delta > 0;
 }
@@ -13515,7 +13451,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 void init_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
-	cfs_rq->min_vruntime = (u64)(-(1LL << 20));
+	cfs_rq->zero_vruntime = (u64)(-(1LL << 20));
 	raw_spin_lock_init(&cfs_rq->removed.lock);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index adfb6e3409d7..92ec751799f5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -682,10 +682,10 @@ struct cfs_rq {
 	s64			avg_vruntime;
 	u64			avg_load;
 
-	u64			min_vruntime;
+	u64			zero_vruntime;
 #ifdef CONFIG_SCHED_CORE
 	unsigned int		forceidle_seq;
-	u64			min_vruntime_fi;
+	u64			zero_vruntime_fi;
 #endif
 
 	struct rb_root_cached	tasks_timeline;
-- 
2.51.0


