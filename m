Return-Path: <stable+bounces-127428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCDCA794D0
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 20:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80FEB3AE223
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 18:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F6018A93F;
	Wed,  2 Apr 2025 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TW1X/2uQ"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AC41E4A4;
	Wed,  2 Apr 2025 18:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743617275; cv=none; b=FYSIVHyM3IqszAV1Gslz3wR+Z8bDtWbq31zkOhjSfiblKtpTQ9Ao8dD1uKNhCVSCmtPr7zQiCh3qFxsD3FRtRepuc1DIahe3fIhfPReR/4fBfawQbY17Cq18NpkxhKBmaZZJrPqcIR/1h6z66OluVhPh8iKZklxJt3nrFxFE/xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743617275; c=relaxed/simple;
	bh=xGWBy/ngWNxUQ8+UwLrHFUpJ8QR2LlgiYSjALb6Au2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVxDAxLTumlLlSHVELKwgur1TVo9SmE6X/QO/CSztBRbN9eL7kY8Vpn+bZdUUTIb7ELEHhsTpH95vwmBVLJyhao2obz+sYR6YCFJm2+UW+RPAl/D7FlvTXQanGwMyI7eqRtOcVxIwJSCMsZVW8WBfI46pw5Q16BCBNOQClI//ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TW1X/2uQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ODxfA0e78hN0K1flWNMQHaVHOotVxDCjwp6ErRCC+VA=; b=TW1X/2uQsfY8BKbQx3VxPSNCUJ
	wBwYjnQWEfl0lrecs5ltnrnFP9dZnw6IMLX9uMzxrWH+T984MU70VMXLG/T1Uj3DUzqFYi66vrPyA
	IciSBb4AEApBM0OnBSJZwcE1+LLnV6VF2r5j5lhmRQ65psR+nJ8vCBmzNHdW1EqoPMr3jaXnxyu1x
	j8lEr2Z9eyfjqzKHcNoo4osvApg2SJvX02W9ByaWSchY0m55392Q4Y4oB2abpWbofTUtrWEbIOfK1
	rcvqOrgCusc6rRRh6zf9/yKyDGl9LTyR5IbAgXfz0lLeYSJnNdAMy8D8lsd91Jepe1NSzCy+TKY5t
	pmryugWQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u02Uy-00000009zsy-0rtt;
	Wed, 02 Apr 2025 18:07:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D825430049D; Wed,  2 Apr 2025 20:07:34 +0200 (CEST)
Date: Wed, 2 Apr 2025 20:07:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Rik van Riel <riel@surriel.com>
Cc: Pat Cody <pat@patcody.io>, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org, patcody@meta.com,
	kernel-team@meta.com, stable@vger.kernel.org,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] sched/fair: Add null pointer check to pick_next_entity()
Message-ID: <20250402180734.GX5880@noisy.programming.kicks-ass.net>
References: <20250320205310.779888-1-pat@patcody.io>
 <20250324115613.GD14944@noisy.programming.kicks-ass.net>
 <9d38c61098b426777c1a748cf1baf8e57c41c334.camel@surriel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d38c61098b426777c1a748cf1baf8e57c41c334.camel@surriel.com>

On Wed, Apr 02, 2025 at 10:59:09AM -0400, Rik van Riel wrote:
> On Mon, 2025-03-24 at 12:56 +0100, Peter Zijlstra wrote:
> > On Thu, Mar 20, 2025 at 01:53:10PM -0700, Pat Cody wrote:
> > > pick_eevdf() can return null, resulting in a null pointer
> > > dereference
> > > crash in pick_next_entity()
> > 
> > If it returns NULL while nr_queued, something is really badly wrong.
> > 
> > Your check will hide this badness.
> 
> Looking at the numbers, I suspect vruntime_eligible()
> is simply not allowing us to run the left-most entity
> in the rb tree.
> 
> At the root level we are seeing these numbers:
> 
> *(struct cfs_rq *)0xffff8882b3b80000 = {
> 	.load = (struct load_weight){
> 		.weight = (unsigned long)4750106,
> 		.inv_weight = (u32)0,
> 	},
> 	.nr_running = (unsigned int)3,
> 	.h_nr_running = (unsigned int)3,
> 	.idle_nr_running = (unsigned int)0,
> 	.idle_h_nr_running = (unsigned int)0,
> 	.h_nr_delayed = (unsigned int)0,
> 	.avg_vruntime = (s64)-2206158374744070955,
> 	.avg_load = (u64)4637,
> 	.min_vruntime = (u64)12547674988423219,
> 
> Meanwhile, the cfs_rq->curr entity has a weight of 
> 4699124, a vruntime of 12071905127234526, and a
> vlag of -2826239998
> 
> The left node entity in the cfs_rq has a weight
> of 107666, a vruntime of 16048555717648580,
> and a vlag of -1338888

The thing that stands out is that min_vruntime is a lot smaller than the
leftmost vruntime. This in turn leads to keys being large.

This is undesirable, as it can lead to overflow.

> I cannot for the life of me figure out how the
> avg_vruntime number is so out of whack from what
> the vruntime numbers of the sched entities on the
> runqueue look like.
> 
> The avg_vruntime code is confusing me. On the
> one hand the vruntime number is multiplied by
> the sched entity weight when adding to or
> subtracting to avg_vruntime, but on the other
> hand vruntime_eligible scales the comparison
> by the cfs_rq->avg_load number.
> 
> What even protects the load number in vruntime_eligible
> from going negative in certain cases, when the current
> entity's entity_key is a negative value?
> 
> The latter is probably not the bug we're seeing now, but
> I don't understand how that is supposed to behave.

So there is this giant comment right above avg_vruntime_add() that tries
and explain things.

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

(edit -- this does two things:
 - it keeps the key 'small';
 - it creates a relative 0-point in the modular space)

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

Anyway... we got s64 to track avg_vruntime, that sum over weighted keys,
if you have a ton of entities and large keys and large weights (your
case) you can overflow and things go to shit.

Anyway, seeing how your min_vruntime is weird, let me ask you to try the
below; it removes the old min_vruntime and instead tracks zero vruntime
as the 'current' avg_vruntime. We don't need the monotinicity filter,
all we really need is something 'near' all the other vruntimes in order
to compute this relative key so we can preserve order across the wrap.

This *should* get us near minimal sized keys. If you can still
reproduce, you should probably add something like that patch I send you
privately earlier, that checks the overflows.

The below builds and boots (provided SCHED_CORE=n).

---
 kernel/sched/debug.c |  8 ++---
 kernel/sched/fair.c  | 92 ++++++++--------------------------------------------
 kernel/sched/sched.h |  2 +-
 3 files changed, 19 insertions(+), 83 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 56ae54e0ce6a..5ca512d50e3a 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -807,7 +807,7 @@ static void print_rq(struct seq_file *m, struct rq *rq, int rq_cpu)
 
 void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 {
-	s64 left_vruntime = -1, min_vruntime, right_vruntime = -1, left_deadline = -1, spread;
+	s64 left_vruntime = -1, zero_vruntime, right_vruntime = -1, left_deadline = -1, spread;
 	struct sched_entity *last, *first, *root;
 	struct rq *rq = cpu_rq(cpu);
 	unsigned long flags;
@@ -830,15 +830,15 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
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
index e43993a4e580..17e43980f5a3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -526,24 +526,6 @@ void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec);
  * Scheduling class tree data structure manipulation methods:
  */
 
-static inline __maybe_unused u64 max_vruntime(u64 max_vruntime, u64 vruntime)
-{
-	s64 delta = (s64)(vruntime - max_vruntime);
-	if (delta > 0)
-		max_vruntime = vruntime;
-
-	return max_vruntime;
-}
-
-static inline __maybe_unused u64 min_vruntime(u64 min_vruntime, u64 vruntime)
-{
-	s64 delta = (s64)(vruntime - min_vruntime);
-	if (delta < 0)
-		min_vruntime = vruntime;
-
-	return min_vruntime;
-}
-
 static inline bool entity_before(const struct sched_entity *a,
 				 const struct sched_entity *b)
 {
@@ -556,7 +538,7 @@ static inline bool entity_before(const struct sched_entity *a,
 
 static inline s64 entity_key(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	return (s64)(se->vruntime - cfs_rq->min_vruntime);
+	return (s64)(se->vruntime - cfs_rq->zero_vruntime);
 }
 
 #define __node_2_se(node) \
@@ -608,13 +590,13 @@ static inline s64 entity_key(struct cfs_rq *cfs_rq, struct sched_entity *se)
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
@@ -673,7 +655,7 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
 		avg = div_s64(avg, load);
 	}
 
-	return cfs_rq->min_vruntime + avg;
+	return cfs_rq->zero_vruntime + avg;
 }
 
 /*
@@ -734,7 +716,7 @@ static int vruntime_eligible(struct cfs_rq *cfs_rq, u64 vruntime)
 		load += weight;
 	}
 
-	return avg >= (s64)(vruntime - cfs_rq->min_vruntime) * load;
+	return avg >= (s64)(vruntime - cfs_rq->zero_vruntime) * load;
 }
 
 int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
@@ -742,42 +724,14 @@ int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
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
+	avg_vruntime_update(cfs_rq, delta);
 
-	if (curr) {
-		if (curr->on_rq)
-			vruntime = curr->vruntime;
-		else
-			curr = NULL;
-	}
-
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
@@ -850,6 +804,7 @@ RB_DECLARE_CALLBACKS(static, min_vruntime_cb, struct sched_entity,
 static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	avg_vruntime_add(cfs_rq, se);
+	update_zero_vruntime(cfs_rq);
 	se->min_vruntime = se->vruntime;
 	se->min_slice = se->slice;
 	rb_add_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
@@ -1239,7 +1194,6 @@ static void update_curr(struct cfs_rq *cfs_rq)
 
 	curr->vruntime += calc_delta_fair(delta_exec, curr);
 	resched = update_deadline(cfs_rq, curr);
-	update_min_vruntime(cfs_rq);
 
 	if (entity_is_task(curr)) {
 		struct task_struct *p = task_of(curr);
@@ -3825,15 +3779,6 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		place_entity(cfs_rq, se, 0);
 		if (!curr)
 			__enqueue_entity(cfs_rq, se);
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
 
@@ -5511,15 +5456,6 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
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
 
@@ -13312,7 +13248,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 void init_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
-	cfs_rq->min_vruntime = (u64)(-(1LL << 20));
+	cfs_rq->zero_vruntime = (u64)(-(1LL << 20));
 #ifdef CONFIG_SMP
 	raw_spin_lock_init(&cfs_rq->removed.lock);
 #endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 47972f34ea70..41b312f17f22 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -652,7 +652,7 @@ struct cfs_rq {
 	s64			avg_vruntime;
 	u64			avg_load;
 
-	u64			min_vruntime;
+	u64			zero_vruntime;
 #ifdef CONFIG_SCHED_CORE
 	unsigned int		forceidle_seq;
 	u64			min_vruntime_fi;

