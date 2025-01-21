Return-Path: <stable+bounces-109812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65864A18405
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4AEE3A328A
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 18:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAAE1F543F;
	Tue, 21 Jan 2025 18:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AxoffyCs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2D6E571;
	Tue, 21 Jan 2025 18:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482510; cv=none; b=MpyY3D9zSFJe0K8a/V4V87iPLIRung9Xe0kowjx48KmyyCQiH8lUUTdnx9TnJe6AJlepv/4hpTVDTw0hNnQv7oi3it3fNLJolTS5obOLErNts2ISuAdZe+RFv2WUAbIpxcj6Ni+J3juHDDGacDzxp6XspTjUVmWZclc/kuXvGJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482510; c=relaxed/simple;
	bh=e6WX4eGuq2Kzt9VSXm345l+7/to8y3Haexyh9J/9zPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpFLLIPjZR/3H0ZRDmS2y6vIRHUjQFBTAw8p7Sa+49gMgbo66Nb8zDD+jyInvc4Lev62JADs4L5t28XQS+MTtQ/kR6txOJ3vgP2/6ZMwvKH3sHGVNd28NgDp3n/wmtVVyZKaVl6o8+iBJa21QCVrGSemqblflNeW0EZMKOkPjyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AxoffyCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2487BC4CEDF;
	Tue, 21 Jan 2025 18:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737482510;
	bh=e6WX4eGuq2Kzt9VSXm345l+7/to8y3Haexyh9J/9zPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AxoffyCsGEuyKWSUAXocpp6IwLJni7NRAjCGtU3tw2ZonMw1KJFxcBn6jzQJ32OT0
	 EnMSZ7LuO6ULudW6Dv3pOlarAosw5EivPEyWnwIRVvIFeoJ7lbx/if3eMEHi2IPBpT
	 mRSLWkMz2w3+wMTkvumg+N1gwXsnnrEEhSaVwU14=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Doug Smythies <dsmythies@telus.net>,
	Ingo Molnar <mingo@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 072/122] sched/fair: Fix EEVDF entity placement bug causing scheduling lag
Date: Tue, 21 Jan 2025 18:52:00 +0100
Message-ID: <20250121174535.767690329@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121174532.991109301@linuxfoundation.org>
References: <20250121174532.991109301@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 6d71a9c6160479899ee744d2c6d6602a191deb1f ]

I noticed this in my traces today:

       turbostat-1222    [006] d..2.   311.935649: reweight_entity: (ffff888108f13e00-ffff88885ef38440-6)
                               { weight: 1048576 avg_vruntime: 3184159639071 vruntime: 3184159640194 (-1123) deadline: 3184162621107 } ->
                               { weight: 2 avg_vruntime: 3184177463330 vruntime: 3184748414495 (-570951165) deadline: 4747605329439 }
       turbostat-1222    [006] d..2.   311.935651: reweight_entity: (ffff888108f13e00-ffff88885ef38440-6)
                               { weight: 2 avg_vruntime: 3184177463330 vruntime: 3184748414495 (-570951165) deadline: 4747605329439 } ->
                               { weight: 1048576 avg_vruntime: 3184176414812 vruntime: 3184177464419 (-1049607) deadline: 3184180445332 }

Which is a weight transition: 1048576 -> 2 -> 1048576.

One would expect the lag to shoot out *AND* come back, notably:

  -1123*1048576/2 = -588775424
  -588775424*2/1048576 = -1123

Except the trace shows it is all off. Worse, subsequent cycles shoot it
out further and further.

This made me have a very hard look at reweight_entity(), and
specifically the ->on_rq case, which is more prominent with
DELAY_DEQUEUE.

And indeed, it is all sorts of broken. While the computation of the new
lag is correct, the computation for the new vruntime, using the new lag
is broken for it does not consider the logic set out in place_entity().

With the below patch, I now see things like:

    migration/12-55      [012] d..3.   309.006650: reweight_entity: (ffff8881e0e6f600-ffff88885f235f40-12)
                               { weight: 977582 avg_vruntime: 4860513347366 vruntime: 4860513347908 (-542) deadline: 4860516552475 } ->
                               { weight: 2 avg_vruntime: 4860528915984 vruntime: 4860793840706 (-264924722) deadline: 6427157349203 }
    migration/14-62      [014] d..3.   309.006698: reweight_entity: (ffff8881e0e6cc00-ffff88885f3b5f40-15)
                               { weight: 2 avg_vruntime: 4874472992283 vruntime: 4939833828823 (-65360836540) deadline: 6316614641111 } ->
                               { weight: 967149 avg_vruntime: 4874217684324 vruntime: 4874217688559 (-4235) deadline: 4874220535650 }

Which isn't perfect yet, but much closer.

Reported-by: Doug Smythies <dsmythies@telus.net>
Reported-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Fixes: eab03c23c2a1 ("sched/eevdf: Fix vruntime adjustment on reweight")
Link: https://lore.kernel.org/r/20250109105959.GA2981@noisy.programming.kicks-ass.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/fair.c | 145 ++++++--------------------------------------
 1 file changed, 18 insertions(+), 127 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1ca96c99872f0..bf8153af96879 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -689,21 +689,16 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
  *
  * XXX could add max_slice to the augmented data to track this.
  */
-static s64 entity_lag(u64 avruntime, struct sched_entity *se)
+static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	s64 vlag, limit;
 
-	vlag = avruntime - se->vruntime;
-	limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
-
-	return clamp(vlag, -limit, limit);
-}
-
-static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
-{
 	SCHED_WARN_ON(!se->on_rq);
 
-	se->vlag = entity_lag(avg_vruntime(cfs_rq), se);
+	vlag = avg_vruntime(cfs_rq) - se->vruntime;
+	limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
+
+	se->vlag = clamp(vlag, -limit, limit);
 }
 
 /*
@@ -3774,137 +3769,32 @@ static inline void
 dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
 #endif
 
-static void reweight_eevdf(struct sched_entity *se, u64 avruntime,
-			   unsigned long weight)
-{
-	unsigned long old_weight = se->load.weight;
-	s64 vlag, vslice;
-
-	/*
-	 * VRUNTIME
-	 * --------
-	 *
-	 * COROLLARY #1: The virtual runtime of the entity needs to be
-	 * adjusted if re-weight at !0-lag point.
-	 *
-	 * Proof: For contradiction assume this is not true, so we can
-	 * re-weight without changing vruntime at !0-lag point.
-	 *
-	 *             Weight	VRuntime   Avg-VRuntime
-	 *     before    w          v            V
-	 *      after    w'         v'           V'
-	 *
-	 * Since lag needs to be preserved through re-weight:
-	 *
-	 *	lag = (V - v)*w = (V'- v')*w', where v = v'
-	 *	==>	V' = (V - v)*w/w' + v		(1)
-	 *
-	 * Let W be the total weight of the entities before reweight,
-	 * since V' is the new weighted average of entities:
-	 *
-	 *	V' = (WV + w'v - wv) / (W + w' - w)	(2)
-	 *
-	 * by using (1) & (2) we obtain:
-	 *
-	 *	(WV + w'v - wv) / (W + w' - w) = (V - v)*w/w' + v
-	 *	==> (WV-Wv+Wv+w'v-wv)/(W+w'-w) = (V - v)*w/w' + v
-	 *	==> (WV - Wv)/(W + w' - w) + v = (V - v)*w/w' + v
-	 *	==>	(V - v)*W/(W + w' - w) = (V - v)*w/w' (3)
-	 *
-	 * Since we are doing at !0-lag point which means V != v, we
-	 * can simplify (3):
-	 *
-	 *	==>	W / (W + w' - w) = w / w'
-	 *	==>	Ww' = Ww + ww' - ww
-	 *	==>	W * (w' - w) = w * (w' - w)
-	 *	==>	W = w	(re-weight indicates w' != w)
-	 *
-	 * So the cfs_rq contains only one entity, hence vruntime of
-	 * the entity @v should always equal to the cfs_rq's weighted
-	 * average vruntime @V, which means we will always re-weight
-	 * at 0-lag point, thus breach assumption. Proof completed.
-	 *
-	 *
-	 * COROLLARY #2: Re-weight does NOT affect weighted average
-	 * vruntime of all the entities.
-	 *
-	 * Proof: According to corollary #1, Eq. (1) should be:
-	 *
-	 *	(V - v)*w = (V' - v')*w'
-	 *	==>    v' = V' - (V - v)*w/w'		(4)
-	 *
-	 * According to the weighted average formula, we have:
-	 *
-	 *	V' = (WV - wv + w'v') / (W - w + w')
-	 *	   = (WV - wv + w'(V' - (V - v)w/w')) / (W - w + w')
-	 *	   = (WV - wv + w'V' - Vw + wv) / (W - w + w')
-	 *	   = (WV + w'V' - Vw) / (W - w + w')
-	 *
-	 *	==>  V'*(W - w + w') = WV + w'V' - Vw
-	 *	==>	V' * (W - w) = (W - w) * V	(5)
-	 *
-	 * If the entity is the only one in the cfs_rq, then reweight
-	 * always occurs at 0-lag point, so V won't change. Or else
-	 * there are other entities, hence W != w, then Eq. (5) turns
-	 * into V' = V. So V won't change in either case, proof done.
-	 *
-	 *
-	 * So according to corollary #1 & #2, the effect of re-weight
-	 * on vruntime should be:
-	 *
-	 *	v' = V' - (V - v) * w / w'		(4)
-	 *	   = V  - (V - v) * w / w'
-	 *	   = V  - vl * w / w'
-	 *	   = V  - vl'
-	 */
-	if (avruntime != se->vruntime) {
-		vlag = entity_lag(avruntime, se);
-		vlag = div_s64(vlag * old_weight, weight);
-		se->vruntime = avruntime - vlag;
-	}
-
-	/*
-	 * DEADLINE
-	 * --------
-	 *
-	 * When the weight changes, the virtual time slope changes and
-	 * we should adjust the relative virtual deadline accordingly.
-	 *
-	 *	d' = v' + (d - v)*w/w'
-	 *	   = V' - (V - v)*w/w' + (d - v)*w/w'
-	 *	   = V  - (V - v)*w/w' + (d - v)*w/w'
-	 *	   = V  + (d - V)*w/w'
-	 */
-	vslice = (s64)(se->deadline - avruntime);
-	vslice = div_s64(vslice * old_weight, weight);
-	se->deadline = avruntime + vslice;
-}
+static void place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags);
 
 static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 			    unsigned long weight)
 {
 	bool curr = cfs_rq->curr == se;
-	u64 avruntime;
 
 	if (se->on_rq) {
 		/* commit outstanding execution time */
 		update_curr(cfs_rq);
-		avruntime = avg_vruntime(cfs_rq);
+		update_entity_lag(cfs_rq, se);
+		se->deadline -= se->vruntime;
+		se->rel_deadline = 1;
 		if (!curr)
 			__dequeue_entity(cfs_rq, se);
 		update_load_sub(&cfs_rq->load, se->load.weight);
 	}
 	dequeue_load_avg(cfs_rq, se);
 
-	if (se->on_rq) {
-		reweight_eevdf(se, avruntime, weight);
-	} else {
-		/*
-		 * Because we keep se->vlag = V - v_i, while: lag_i = w_i*(V - v_i),
-		 * we need to scale se->vlag when w_i changes.
-		 */
-		se->vlag = div_s64(se->vlag * se->load.weight, weight);
-	}
+	/*
+	 * Because we keep se->vlag = V - v_i, while: lag_i = w_i*(V - v_i),
+	 * we need to scale se->vlag when w_i changes.
+	 */
+	se->vlag = div_s64(se->vlag * se->load.weight, weight);
+	if (se->rel_deadline)
+		se->deadline = div_s64(se->deadline * se->load.weight, weight);
 
 	update_load_set(&se->load, weight);
 
@@ -3919,6 +3809,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 	enqueue_load_avg(cfs_rq, se);
 	if (se->on_rq) {
 		update_load_add(&cfs_rq->load, se->load.weight);
+		place_entity(cfs_rq, se, 0);
 		if (!curr)
 			__enqueue_entity(cfs_rq, se);
 
@@ -5359,7 +5250,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	se->vruntime = vruntime - lag;
 
-	if (sched_feat(PLACE_REL_DEADLINE) && se->rel_deadline) {
+	if (se->rel_deadline) {
 		se->deadline += se->vruntime;
 		se->rel_deadline = 0;
 		return;
-- 
2.39.5




