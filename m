Return-Path: <stable+bounces-194467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6747C4D749
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 12:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2263AEFBC
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 11:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DA735A938;
	Tue, 11 Nov 2025 11:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="auGGAl0Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JWlaP1XX"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB8435A138;
	Tue, 11 Nov 2025 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861044; cv=none; b=ZulSl4s3pHWlMXvdjQOdQa4b+ji8b6+u1IwSLhw97PGgehdspqrhfpeWG5CBQ17UKD87rq6gCRiNVQou3Q5vY0b8dVLrqUhb+ZShajggTMTaDczkd9w/HPMz3pVI1TMe9Vy92dVbsS9H7CMVtmp7EfoGFZqyr3mAL2zDlqru924=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861044; c=relaxed/simple;
	bh=L0Un56rrqhvhKY9CqJJSdzhsLEJmnjczbVdxUADq/Ko=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RJv2k/c9iDaqtXDOsqx/qp4RY7VWFtV454Y9PN/LI3sAv01E+z39jHjxAR1PfwMqiWwcQCX2pVsRKclSrYLpV7kFoC0qCMZP4oNxESVXZG9kEWvM4gA8X1b9Pkmy3IAA5xOe7C8y9YE8TGm+Z4OJ4TiB30TtHwJsQpa3vjCOYPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=auGGAl0Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JWlaP1XX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 11:37:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762861040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kh6q3BkU1EXBsTKVi3B2ck2awwCQmr/SUPdjpuJG/xE=;
	b=auGGAl0Y5tTbNi04fvfmGbgzDcbYj7ZzmxOK7ClRkKCtA6oIFxvfItL3nCPjRV86XS/I2c
	HddVo2P7nS3yLswsqd/Ohyw/8L+iQU7C0umLnJQ877ccN7K9ym73l1RPtO0o2LwEthCP7s
	YezOqgRuhRAAjDot+sOT8L3Ws0TBz7fW/eJcAITndLRgk3IYMUdLunwbJ5f8OhnSQ+MRTG
	r71j9OdBMwtbICimStbwD+WcN6JPi6PHD+0YssjJoo5DLVtQl+TWsujDJo7UvUUs6Xel3a
	kfL8Tyfa8aRtHpNOrhCG0MpFWlY2Mq/yCB374TtQvEKKIazY4Dcs7LDXwpyUeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762861040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kh6q3BkU1EXBsTKVi3B2ck2awwCQmr/SUPdjpuJG/xE=;
	b=JWlaP1XXuDZFMsGZD3X+MSA8nP4hZzjkPeKdAyvY9/++pBdmhP5r7DT6QmAkgW8HqPhb2l
	u3QQJLoFdNNVxgDw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/eevdf: Fix min_vruntime vs avg_vruntime
Cc: Zicheng Qu <quzicheng@huawei.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251106111741.GC4068168@noisy.programming.kicks-ass.net>
References: <20251106111741.GC4068168@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176286103936.498.5645956678159757464.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     79f3f9bedd149ea438aaeb0fb6a083637affe205
Gitweb:        https://git.kernel.org/tip/79f3f9bedd149ea438aaeb0fb6a083637af=
fe205
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 02 Apr 2025 20:07:34 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 11 Nov 2025 12:33:38 +01:00

sched/eevdf: Fix min_vruntime vs avg_vruntime

Basically, from the constraint that the sum of lag is zero, you can
infer that the 0-lag point is the weighted average of the individual
vruntime, which is what we're trying to compute:

        \Sum w_i * v_i
  avg =3D --------------
           \Sum w_i

Now, since vruntime takes the whole u64 (worse, it wraps), this
multiplication term in the numerator is not something we can compute;
instead we do the min_vruntime (v0 henceforth) thing like:

  v_i =3D (v_i - v0) + v0

This does two things:
 - it keeps the key: (v_i - v0) 'small';
 - it creates a relative 0-point in the modular space.

If you do that subtitution and work it all out, you end up with:

        \Sum w_i * (v_i - v0)
  avg =3D --------------------- + v0
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
Link: https://patch.msgid.link/20251106111741.GC4068168@noisy.programming.kic=
ks-ass.net
Cc: stable@vger.kernel.org
---
 kernel/sched/debug.c |   8 +--
 kernel/sched/fair.c  | 114 +++++++++---------------------------------
 kernel/sched/sched.h |   4 +-
 3 files changed, 31 insertions(+), 95 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 02e16b7..41caa22 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -796,7 +796,7 @@ static void print_rq(struct seq_file *m, struct rq *rq, i=
nt rq_cpu)
=20
 void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 {
-	s64 left_vruntime =3D -1, min_vruntime, right_vruntime =3D -1, left_deadlin=
e =3D -1, spread;
+	s64 left_vruntime =3D -1, zero_vruntime, right_vruntime =3D -1, left_deadli=
ne =3D -1, spread;
 	struct sched_entity *last, *first, *root;
 	struct rq *rq =3D cpu_rq(cpu);
 	unsigned long flags;
@@ -819,15 +819,15 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct c=
fs_rq *cfs_rq)
 	last =3D __pick_last_entity(cfs_rq);
 	if (last)
 		right_vruntime =3D last->vruntime;
-	min_vruntime =3D cfs_rq->min_vruntime;
+	zero_vruntime =3D cfs_rq->zero_vruntime;
 	raw_spin_rq_unlock_irqrestore(rq, flags);
=20
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
index 4a11a83..8d971d4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -554,7 +554,7 @@ static inline bool entity_before(const struct sched_entit=
y *a,
=20
 static inline s64 entity_key(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	return (s64)(se->vruntime - cfs_rq->min_vruntime);
+	return (s64)(se->vruntime - cfs_rq->zero_vruntime);
 }
=20
 #define __node_2_se(node) \
@@ -606,13 +606,13 @@ static inline s64 entity_key(struct cfs_rq *cfs_rq, str=
uct sched_entity *se)
  *
  * Which we track using:
  *
- *                    v0 :=3D cfs_rq->min_vruntime
+ *                    v0 :=3D cfs_rq->zero_vruntime
  * \Sum (v_i - v0) * w_i :=3D cfs_rq->avg_vruntime
  *              \Sum w_i :=3D cfs_rq->avg_load
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
 		avg =3D div_s64(avg, load);
 	}
=20
-	return cfs_rq->min_vruntime + avg;
+	return cfs_rq->zero_vruntime + avg;
 }
=20
 /*
@@ -732,7 +732,7 @@ static int vruntime_eligible(struct cfs_rq *cfs_rq, u64 v=
runtime)
 		load +=3D weight;
 	}
=20
-	return avg >=3D (s64)(vruntime - cfs_rq->min_vruntime) * load;
+	return avg >=3D (s64)(vruntime - cfs_rq->zero_vruntime) * load;
 }
=20
 int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
@@ -740,42 +740,14 @@ int entity_eligible(struct cfs_rq *cfs_rq, struct sched=
_entity *se)
 	return vruntime_eligible(cfs_rq, se->vruntime);
 }
=20
-static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
+static void update_zero_vruntime(struct cfs_rq *cfs_rq)
 {
-	u64 min_vruntime =3D cfs_rq->min_vruntime;
-	/*
-	 * open coded max_vruntime() to allow updating avg_vruntime
-	 */
-	s64 delta =3D (s64)(vruntime - min_vruntime);
-	if (delta > 0) {
-		avg_vruntime_update(cfs_rq, delta);
-		min_vruntime =3D vruntime;
-	}
-	return min_vruntime;
-}
+	u64 vruntime =3D avg_vruntime(cfs_rq);
+	s64 delta =3D (s64)(vruntime - cfs_rq->zero_vruntime);
=20
-static void update_min_vruntime(struct cfs_rq *cfs_rq)
-{
-	struct sched_entity *se =3D __pick_root_entity(cfs_rq);
-	struct sched_entity *curr =3D cfs_rq->curr;
-	u64 vruntime =3D cfs_rq->min_vruntime;
-
-	if (curr) {
-		if (curr->on_rq)
-			vruntime =3D curr->vruntime;
-		else
-			curr =3D NULL;
-	}
+	avg_vruntime_update(cfs_rq, delta);
=20
-	if (se) {
-		if (!curr)
-			vruntime =3D se->min_vruntime;
-		else
-			vruntime =3D min_vruntime(vruntime, se->min_vruntime);
-	}
-
-	/* ensure we never gain time by being placed backwards. */
-	cfs_rq->min_vruntime =3D __update_min_vruntime(cfs_rq, vruntime);
+	cfs_rq->zero_vruntime =3D vruntime;
 }
=20
 static inline u64 cfs_rq_min_slice(struct cfs_rq *cfs_rq)
@@ -848,6 +820,7 @@ RB_DECLARE_CALLBACKS(static, min_vruntime_cb, struct sche=
d_entity,
 static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	avg_vruntime_add(cfs_rq, se);
+	update_zero_vruntime(cfs_rq);
 	se->min_vruntime =3D se->vruntime;
 	se->min_slice =3D se->slice;
 	rb_add_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
@@ -859,6 +832,7 @@ static void __dequeue_entity(struct cfs_rq *cfs_rq, struc=
t sched_entity *se)
 	rb_erase_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
 				  &min_vruntime_cb);
 	avg_vruntime_sub(cfs_rq, se);
+	update_zero_vruntime(cfs_rq);
 }
=20
 struct sched_entity *__pick_root_entity(struct cfs_rq *cfs_rq)
@@ -1226,7 +1200,6 @@ static void update_curr(struct cfs_rq *cfs_rq)
=20
 	curr->vruntime +=3D calc_delta_fair(delta_exec, curr);
 	resched =3D update_deadline(cfs_rq, curr);
-	update_min_vruntime(cfs_rq);
=20
 	if (entity_is_task(curr)) {
 		/*
@@ -3808,15 +3781,6 @@ static void reweight_entity(struct cfs_rq *cfs_rq, str=
uct sched_entity *se,
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
=20
@@ -5429,15 +5393,6 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_ent=
ity *se, int flags)
=20
 	update_cfs_group(se);
=20
-	/*
-	 * Now advance min_vruntime if @se was the entity holding it back,
-	 * except when: DEQUEUE_SAVE && !DEQUEUE_MOVE, in this case we'll be
-	 * put back on, and if we advance min_vruntime, we'll be placed back
-	 * further than we started -- i.e. we'll be penalized.
-	 */
-	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) !=3D DEQUEUE_SAVE)
-		update_min_vruntime(cfs_rq);
-
 	if (flags & DEQUEUE_DELAYED)
 		finish_delayed_dequeue_entity(se);
=20
@@ -9015,7 +8970,6 @@ static void yield_task_fair(struct rq *rq)
 	if (entity_eligible(cfs_rq, se)) {
 		se->vruntime =3D se->deadline;
 		se->deadline +=3D calc_delta_fair(se->slice, se);
-		update_min_vruntime(cfs_rq);
 	}
 }
=20
@@ -13078,23 +13032,6 @@ static inline void task_tick_core(struct rq *rq, str=
uct task_struct *curr)
  * Which shows that S and s_i transform alike (which makes perfect sense
  * given that S is basically the (weighted) average of s_i).
  *
- * Then:
- *
- *   x -> s_min :=3D min{s_i}                                   (8)
- *
- * to obtain:
- *
- *               \Sum_i w_i (s_i - s_min)
- *   S =3D s_min + ------------------------                     (9)
- *                     \Sum_i w_i
- *
- * Which already looks familiar, and is the basis for our current
- * approximation:
- *
- *   S ~=3D s_min                                              (10)
- *
- * Now, obviously, (10) is absolute crap :-), but it sorta works.
- *
  * So the thing to remember is that the above is strictly UP. It is
  * possible to generalize to multiple runqueues -- however it gets really
  * yuck when you have to add affinity support, as illustrated by our very
@@ -13116,23 +13053,23 @@ static inline void task_tick_core(struct rq *rq, st=
ruct task_struct *curr)
  * Let, for our runqueue 'k':
  *
  *   T_k =3D \Sum_i w_i s_i
- *   W_k =3D \Sum_i w_i      ; for all i of k                  (11)
+ *   W_k =3D \Sum_i w_i      ; for all i of k                  (8)
  *
  * Then we can write (6) like:
  *
  *         T_k
- *   S_k =3D ---                                               (12)
+ *   S_k =3D ---                                               (9)
  *         W_k
  *
  * From which immediately follows that:
  *
  *           T_k + T_l
- *   S_k+l =3D ---------                                       (13)
+ *   S_k+l =3D ---------                                       (10)
  *           W_k + W_l
  *
  * On which we can define a combined lag:
  *
- *   lag_k+l(i) :=3D S_k+l - s_i                               (14)
+ *   lag_k+l(i) :=3D S_k+l - s_i                               (11)
  *
  * And that gives us the tools to compare tasks across a combined runqueue.
  *
@@ -13143,7 +13080,7 @@ static inline void task_tick_core(struct rq *rq, stru=
ct task_struct *curr)
  *     using (7); this only requires storing single 'time'-stamps.
  *
  *  b) when comparing tasks between 2 runqueues of which one is forced-idle,
- *     compare the combined lag, per (14).
+ *     compare the combined lag, per (11).
  *
  * Now, of course cgroups (I so hate them) make this more interesting in
  * that a) seems to suggest we need to iterate all cgroup on a CPU at such
@@ -13191,12 +13128,11 @@ static inline void task_tick_core(struct rq *rq, st=
ruct task_struct *curr)
  * every tick. This limits the observed divergence due to the work
  * conservancy.
  *
- * On top of that, we can improve upon things by moving away from our
- * horrible (10) hack and moving to (9) and employing (13) here.
+ * On top of that, we can improve upon things by employing (10) here.
  */
=20
 /*
- * se_fi_update - Update the cfs_rq->min_vruntime_fi in a CFS hierarchy if n=
eeded.
+ * se_fi_update - Update the cfs_rq->zero_vruntime_fi in a CFS hierarchy if =
needed.
  */
 static void se_fi_update(const struct sched_entity *se, unsigned int fi_seq,
 			 bool forceidle)
@@ -13210,7 +13146,7 @@ static void se_fi_update(const struct sched_entity *s=
e, unsigned int fi_seq,
 			cfs_rq->forceidle_seq =3D fi_seq;
 		}
=20
-		cfs_rq->min_vruntime_fi =3D cfs_rq->min_vruntime;
+		cfs_rq->zero_vruntime_fi =3D cfs_rq->zero_vruntime;
 	}
 }
=20
@@ -13263,11 +13199,11 @@ bool cfs_prio_less(const struct task_struct *a, con=
st struct task_struct *b,
=20
 	/*
 	 * Find delta after normalizing se's vruntime with its cfs_rq's
-	 * min_vruntime_fi, which would have been updated in prior calls
+	 * zero_vruntime_fi, which would have been updated in prior calls
 	 * to se_fi_update().
 	 */
 	delta =3D (s64)(sea->vruntime - seb->vruntime) +
-		(s64)(cfs_rqb->min_vruntime_fi - cfs_rqa->min_vruntime_fi);
+		(s64)(cfs_rqb->zero_vruntime_fi - cfs_rqa->zero_vruntime_fi);
=20
 	return delta > 0;
 }
@@ -13513,7 +13449,7 @@ static void set_next_task_fair(struct rq *rq, struct =
task_struct *p, bool first)
 void init_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->tasks_timeline =3D RB_ROOT_CACHED;
-	cfs_rq->min_vruntime =3D (u64)(-(1LL << 20));
+	cfs_rq->zero_vruntime =3D (u64)(-(1LL << 20));
 	raw_spin_lock_init(&cfs_rq->removed.lock);
 }
=20
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 82e74e8..5a3cf81 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -681,10 +681,10 @@ struct cfs_rq {
 	s64			avg_vruntime;
 	u64			avg_load;
=20
-	u64			min_vruntime;
+	u64			zero_vruntime;
 #ifdef CONFIG_SCHED_CORE
 	unsigned int		forceidle_seq;
-	u64			min_vruntime_fi;
+	u64			zero_vruntime_fi;
 #endif
=20
 	struct rb_root_cached	tasks_timeline;

