Return-Path: <stable+bounces-238213-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBVrNPD/32kjbgAAu9opvQ
	(envelope-from <stable+bounces-238213-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 23:15:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3764081E8
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 23:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9ADF1305930C
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C6F38D019;
	Wed, 15 Apr 2026 21:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iTvp8Y5A"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45873859DF
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 21:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776287531; cv=none; b=IpQzhJ+n/MVnyKLK+8nae/8zuWe9x1Zlj9sCtx24CBOvEzq844dfTg0GrEImccnC9KdeYzGIgAHXzjmIjIh1ed1nRhFUYp74ddd9aAQ3sujyOJ9Sx8W2RuTBRni/5ir/LlhSGllnsPJupyRGh6x1lGnY1uDlJ7CblQBCKVvAqnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776287531; c=relaxed/simple;
	bh=Ar8UJdZpGXM+duOCl1JySoRd1307I6DkyqGZII+JwpM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sLnrTTYl4CJIkI8LZjIcl4W0UgS6MR8JLzycF/XsKX1Gub67MUH+Zs0D/AvDPn8HXI2NlDIFW6r+P9fWjwsvqlfQ2ilKjlFpxDJnCbq09KFgioiSCjBasbVHXIhejbxdLBwZ/gL6cbkmpREEZwOY4rpgeXQw91ustoSOnBITliI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iTvp8Y5A; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b45cd0bb96so42131015ad.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 14:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776287528; x=1776892328; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f++IkkhO6iiKTMtOgrcXNiV0MCS3xXw8Z+Ww77FoANc=;
        b=iTvp8Y5A9yzaD5lx3FGZlRhhEXubg3P2pHfdcP3eGde8CKoOvCR+0PYcSNW6/fznSq
         GUDWEVxIv+3C8nLD6nRE11+JOAnc78faVPifG1B7sAd9+hcTeY3BfsiBXAR1dQIudhhD
         toQZzIPZ9LkZdd86iB6Pwg3cx/K+gUY/HIEvrDjv1Whj0pcx4OW7rHUgX2uKh634DvYH
         Nau/khbCd2aBdezkdETHyv0ZsGSN3324RDMI5l3N0ouJE/q/e/5AJ8mn1xHh10nYu/4n
         uyDXLJ5O5jCQWucBHcE/mknPkFT5UVG6B8a/wJ15TfDnj10uD6iCtM2dcqDoONb5NnCR
         hZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776287528; x=1776892328;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f++IkkhO6iiKTMtOgrcXNiV0MCS3xXw8Z+Ww77FoANc=;
        b=T2+cC7e/lEIBPmisxV4EEQ4PEe7z9gFOpCSRkGVC5ROnMZ0FnsU+1CUt408039ay4X
         8UlvqU2pZv2ROhPPejSZ84KhvkV+PDhX0lbMyGizSJ8hAf0dTCcYh8Qoqa+P4g1h+whh
         UjFENqj+a+uxB71VQJwR7psjqx5iLcs1hrL12PT2TYWC7/w3ToNQYdheI8h3Sy/8suRK
         hUi0QVRN7EYLJNe0AKVvV5eE4BnT+dvEIQ2pM5jMDP7QuNk77qpkvpY8nSOK3zKyYnMq
         0H6esHkvwM2iahwecja2SmNZTjSXaT/y6X7Qg9rlT0W3+n7Z8DjK80vnR2qeKtOASPQa
         DOCw==
X-Gm-Message-State: AOJu0YzR7lCXdaDVOC545m72mRo8C06K4xWasoB7Z7pQvlm8z5VH97Q0
	XK/SvlHzb2Kiy0A05BXO95vVk+ouvTzgtlkrYhGMZfhQtDzdt4GY0NWe4JHgKutqYpde1+2ZSRF
	FanRrbRgQ4K+dBm2xBXaPWTPzQl5dioSJzYbnOp5zD4Da4Z57XFLA1b2m8DmlBZik49DyNTd5+9
	nlTZ/lzL3+6qwpcUMEb1Nx/s7toE7v36YFlCy2DY4K
X-Received: from plbkb5.prod.google.com ([2002:a17:903:3385:b0:2b4:5bcc:fc4a])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:b490:b0:2b0:6e60:9582
 with SMTP id d9443c01a7336-2b2d59661ddmr180947685ad.18.1776287527842; Wed, 15
 Apr 2026 14:12:07 -0700 (PDT)
Date: Wed, 15 Apr 2026 21:10:53 +0000
In-Reply-To: <20260324100126.3502-1-willymontaz@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260324100126.3502-1-willymontaz@gmail.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260415211149.2658910-1-jstultz@google.com>
Subject: [PATCH 6.18] sched/fair: Revert 6d71a9c61604 ("sched/fair: Fix EEVDF
 entity placement bug causing scheduling lag")
From: John Stultz <jstultz@google.com>
To: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Zicheng Qu <quzicheng@huawei.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Shubhang Kaushik <shubhang@os.amperecomputing.com>, John Stultz <jstultz@google.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Xuewen Yan <xuewen.yan@unisoc.com>, 
	William Montaz <willymontaz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,huawei.com,linaro.org,amd.com,os.amperecomputing.com,google.com,arm.com,unisoc.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-238213-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jstultz@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6C3764081E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 101f3498b4bdfef97152a444847948de1543f692 ]

Zicheng Qu reported that, because avg_vruntime() always includes
cfs_rq->curr, when ->on_rq, place_entity() doesn't work right.

Specifically, the lag scaling in place_entity() relies on
avg_vruntime() being the state *before* placement of the new entity.
However in this case avg_vruntime() will actually already include the
entity, which breaks things.

Also, Zicheng Qu argues that avg_vruntime should be invariant under
reweight. IOW commit 6d71a9c61604 ("sched/fair: Fix EEVDF entity
placement bug causing scheduling lag") was wrong!

The issue reported in 6d71a9c61604 could possibly be explained by
rounding artifacts -- notably the extreme weight '2' is outside of the
range of avg_vruntime/sum_w_vruntime, since that uses
scale_load_down(). By scaling vruntime by the real weight, but
accounting it in vruntime with a factor 1024 more, the average moves
significantly. However, that is now cured.

Tested by reverting 66951e4860d3 ("sched/fair: Fix update_cfs_group()
vs DELAY_DEQUEUE") and tracing vruntime and vlag figures again.

Reported-by: Zicheng Qu <quzicheng@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Shubhang Kaushik <shubhang@os.amperecomputing.com>
Link: https://patch.msgid.link/20260219080625.066102672%40infradead.org
(cherry picked from commit 101f3498b4bdfef97152a444847948de1543f692)
[jstultz: Resolved minor collision in the revert against 6.18-stable]
Signed-off-by: John Stultz <jstultz@google.com>
---
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: "Xuewen Yan" <xuewen.yan@unisoc.com>
Cc: William Montaz <willymontaz@gmail.com>
---
 kernel/sched/fair.c | 148 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 124 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d9777c81db0da..4279035367dbb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -764,17 +764,22 @@ static inline u64 cfs_rq_max_slice(struct cfs_rq *cfs_rq);
  *
  *   -r_max < lag < max(r_max, q)
  */
-static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
+static s64 entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se, u64 avruntime)
 {
 	u64 max_slice = cfs_rq_max_slice(cfs_rq) + TICK_NSEC;
 	s64 vlag, limit;
 
-	WARN_ON_ONCE(!se->on_rq);
-
-	vlag = avg_vruntime(cfs_rq) - se->vruntime;
+	vlag = avruntime - se->vruntime;
 	limit = calc_delta_fair(max_slice, se);
 
-	se->vlag = clamp(vlag, -limit, limit);
+	return clamp(vlag, -limit, limit);
+}
+
+static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	WARN_ON_ONCE(!se->on_rq);
+
+	se->vlag = entity_lag(cfs_rq, se, avg_vruntime(cfs_rq));
 }
 
 /*
@@ -3831,23 +3836,125 @@ dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 					  cfs_rq->avg.load_avg * PELT_MIN_DIVIDER);
 }
 
-static void place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags);
+static void
+rescale_entity(struct sched_entity *se, unsigned long weight, bool rel_vprot)
+{
+	unsigned long old_weight = se->load.weight;
+
+	/*
+	 * VRUNTIME
+	 * --------
+	 *
+	 * COROLLARY #1: The virtual runtime of the entity needs to be
+	 * adjusted if re-weight at !0-lag point.
+	 *
+	 * Proof: For contradiction assume this is not true, so we can
+	 * re-weight without changing vruntime at !0-lag point.
+	 *
+	 *             Weight	VRuntime   Avg-VRuntime
+	 *     before    w          v            V
+	 *      after    w'         v'           V'
+	 *
+	 * Since lag needs to be preserved through re-weight:
+	 *
+	 *	lag = (V - v)*w = (V'- v')*w', where v = v'
+	 *	==>	V' = (V - v)*w/w' + v		(1)
+	 *
+	 * Let W be the total weight of the entities before reweight,
+	 * since V' is the new weighted average of entities:
+	 *
+	 *	V' = (WV + w'v - wv) / (W + w' - w)	(2)
+	 *
+	 * by using (1) & (2) we obtain:
+	 *
+	 *	(WV + w'v - wv) / (W + w' - w) = (V - v)*w/w' + v
+	 *	==> (WV-Wv+Wv+w'v-wv)/(W+w'-w) = (V - v)*w/w' + v
+	 *	==> (WV - Wv)/(W + w' - w) + v = (V - v)*w/w' + v
+	 *	==>	(V - v)*W/(W + w' - w) = (V - v)*w/w' (3)
+	 *
+	 * Since we are doing at !0-lag point which means V != v, we
+	 * can simplify (3):
+	 *
+	 *	==>	W / (W + w' - w) = w / w'
+	 *	==>	Ww' = Ww + ww' - ww
+	 *	==>	W * (w' - w) = w * (w' - w)
+	 *	==>	W = w	(re-weight indicates w' != w)
+	 *
+	 * So the cfs_rq contains only one entity, hence vruntime of
+	 * the entity @v should always equal to the cfs_rq's weighted
+	 * average vruntime @V, which means we will always re-weight
+	 * at 0-lag point, thus breach assumption. Proof completed.
+	 *
+	 *
+	 * COROLLARY #2: Re-weight does NOT affect weighted average
+	 * vruntime of all the entities.
+	 *
+	 * Proof: According to corollary #1, Eq. (1) should be:
+	 *
+	 *	(V - v)*w = (V' - v')*w'
+	 *	==>    v' = V' - (V - v)*w/w'		(4)
+	 *
+	 * According to the weighted average formula, we have:
+	 *
+	 *	V' = (WV - wv + w'v') / (W - w + w')
+	 *	   = (WV - wv + w'(V' - (V - v)w/w')) / (W - w + w')
+	 *	   = (WV - wv + w'V' - Vw + wv) / (W - w + w')
+	 *	   = (WV + w'V' - Vw) / (W - w + w')
+	 *
+	 *	==>  V'*(W - w + w') = WV + w'V' - Vw
+	 *	==>	V' * (W - w) = (W - w) * V	(5)
+	 *
+	 * If the entity is the only one in the cfs_rq, then reweight
+	 * always occurs at 0-lag point, so V won't change. Or else
+	 * there are other entities, hence W != w, then Eq. (5) turns
+	 * into V' = V. So V won't change in either case, proof done.
+	 *
+	 *
+	 * So according to corollary #1 & #2, the effect of re-weight
+	 * on vruntime should be:
+	 *
+	 *	v' = V' - (V - v) * w / w'		(4)
+	 *	   = V  - (V - v) * w / w'
+	 *	   = V  - vl * w / w'
+	 *	   = V  - vl'
+	 */
+	se->vlag = div64_long(se->vlag * old_weight, weight);
+
+	/*
+	 * DEADLINE
+	 * --------
+	 *
+	 * When the weight changes, the virtual time slope changes and
+	 * we should adjust the relative virtual deadline accordingly.
+	 *
+	 *	d' = v' + (d - v)*w/w'
+	 *	   = V' - (V - v)*w/w' + (d - v)*w/w'
+	 *	   = V  - (V - v)*w/w' + (d - v)*w/w'
+	 *	   = V  + (d - V)*w/w'
+	 */
+	if (se->rel_deadline)
+		se->deadline = div64_long(se->deadline * old_weight, weight);
+
+	if (rel_vprot)
+		se->vprot = div64_long(se->vprot * old_weight, weight);
+}
 
 static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 			    unsigned long weight)
 {
 	bool curr = cfs_rq->curr == se;
 	bool rel_vprot = false;
-	u64 vprot;
+	u64 avruntime = 0;
 
 	if (se->on_rq) {
 		/* commit outstanding execution time */
 		update_curr(cfs_rq);
-		update_entity_lag(cfs_rq, se);
-		se->deadline -= se->vruntime;
+		avruntime = avg_vruntime(cfs_rq);
+		se->vlag = entity_lag(cfs_rq, se, avruntime);
+		se->deadline -= avruntime;
 		se->rel_deadline = 1;
 		if (curr && protect_slice(se)) {
-			vprot = se->vprot - se->vruntime;
+			se->vprot -= avruntime;
 			rel_vprot = true;
 		}
 
@@ -3858,30 +3965,23 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 	}
 	dequeue_load_avg(cfs_rq, se);
 
-	/*
-	 * Because we keep se->vlag = V - v_i, while: lag_i = w_i*(V - v_i),
-	 * we need to scale se->vlag when w_i changes.
-	 */
-	se->vlag = div_s64(se->vlag * se->load.weight, weight);
-	if (se->rel_deadline)
-		se->deadline = div_s64(se->deadline * se->load.weight, weight);
-
-	if (rel_vprot)
-		vprot = div_s64(vprot * se->load.weight, weight);
+	rescale_entity(se, weight, rel_vprot);
 
 	update_load_set(&se->load, weight);
 
 	do {
 		u32 divider = get_pelt_divider(&se->avg);
-
 		se->avg.load_avg = div_u64(se_weight(se) * se->avg.load_sum, divider);
 	} while (0);
 
 	enqueue_load_avg(cfs_rq, se);
 	if (se->on_rq) {
-		place_entity(cfs_rq, se, 0);
 		if (rel_vprot)
-			se->vprot = se->vruntime + vprot;
+			se->vprot += avruntime;
+		se->deadline += avruntime;
+		se->rel_deadline = 0;
+		se->vruntime = avruntime - se->vlag;
+
 		update_load_add(&cfs_rq->load, se->load.weight);
 		if (!curr)
 			__enqueue_entity(cfs_rq, se);
@@ -5281,7 +5381,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	se->vruntime = vruntime - lag;
 
-	if (se->rel_deadline) {
+	if (sched_feat(PLACE_REL_DEADLINE) && se->rel_deadline) {
 		se->deadline += se->vruntime;
 		se->rel_deadline = 0;
 		return;
-- 
2.54.0.rc1.513.gad8abe7a5a-goog


