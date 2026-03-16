Return-Path: <stable+bounces-225650-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLmKFV5GuGmLbAEAu9opvQ
	(envelope-from <stable+bounces-225650-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:05:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0498529EC5D
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 849B4302F700
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A75A33D4F8;
	Mon, 16 Mar 2026 18:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="CcjwAJIZ"
X-Original-To: stable@vger.kernel.org
Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com [64.215.233.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D25311C15
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 18:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.215.233.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684282; cv=none; b=lzPN0+lowqjCNf4GBFmag1o5pl0YCnV4Kpx6TpEzDFWSiggdG4v2Sg4yFzUbAjCKNPxJI/+Zl/UoGyHO7SDtnk8Abj5Do7qj3XAx4ZOjReAaPgVinrJSvfpAb5rREGdppx3cpo/fb7MY3qo91Y7VPAYCYMKl9NSqAVRuq3R7nbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684282; c=relaxed/simple;
	bh=Zxhg9VEFU/SlJAuBoljTl2acEFCCm+5YrN7JlA3wzMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCaZylxPz2nuKFuGHrYNH56029+5JspQNiBUZ6AnFHO5mxMLVSLr2aM5Jba3PiwsZ7AcdvXsCAbbseGvhLD2BoZgyzaoRj/M5OkQaQHCiT/vDB3W3A3ytGrWwk7r/d3W78lG/Ml+Chk7vYVQuIdCYlbFhQoobTw+jQd/pbAzQOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=CcjwAJIZ; arc=none smtp.client-ip=64.215.233.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
From: Eric Hagberg <ehagberg@janestreet.com>
To: sashal@kernel.org
Cc: patches@lists.linux.dev,
 	stable@vger.kernel.org,
 	peterz@infradead.org,
 	kprateek.nayak@amd.com,
 	shubhang@os.amperecomputing.com,
 	Eric Hagberg <ehagberg@janestreet.com>
Subject: [PATCH] backport of "sched/fair: Fix zero_vruntime tracking" for 6.12
Date: Mon, 16 Mar 2026 14:04:24 -0400
Message-ID: <20260316180424.1513816-1-ehagberg@janestreet.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <abLuj_pax8huB_BR@laps>
References: <05467440d95c78161254bab895be5692e4f0a3f3.1773141555.git.sashal@kernel.org> <20260311161400.1003322-1-ehagberg@janestreet.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1773684273;
  bh=CbZUgAznpkexo5mK8SG6+s3gzCzFbVItcMxaNexmNC4=;
  h=From:To:Cc:Subject:Date:In-Reply-To:References;
  b=CcjwAJIZR2xworY9HtEux32cfJk5AZdtnQbFs/FRqsfDZ6O3JFzZtwEYVwTymzM8z
  +5vnLwSFeE5D7nVMWEO3u8UNqvFrfKqYgCdTGQSCIAZ3DW8UfcgDJOjBkX3NOEA3TF
  tKhtpo1sRQUFAbXziSAev5XFrfTFZD9rIDxexNLS8bskt+ESDKIor3TSyr0aEOBD+g
  HrEj231YX9Ec34n+wDs1Ygt1e4rpBq0+qSFBoAVkLGKxbeCKY+kezgNWQPaE34fiTo
  m4QGmxdibMzFwKJoRazUynXxTZoQGqjf7K1w59Ita/wL/4FhbL4/UFeUpj3/eFqUcW
  /87FP7K6YzlRg==
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[janestreet.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[janestreet.com:s=waixah];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225650-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[janestreet.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ehagberg@janestreet.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0498529EC5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[ Upstream commit b3d99f43c72b56cf7a104a364e7fb34b0702828b ]

This fixes the same problem that was reported upstream and fixed in 6.18
and 6.19 kernels.

Fixes: 79f3f9bedd14 ("sched/eevdf: Fix min_vruntime vs avg_vruntime")
Tested-by: Eric Hagberg <ehagberg@janestreet.com>
---
 kernel/sched/fair.c | 84 ++++++++++++++++++++++++++++++---------------
 1 file changed, 57 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6efb1dfcd943..efd3cbefb5a2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -551,6 +551,21 @@ static inline bool entity_before(const struct sched_entity *a,
 	return (s64)(a->deadline - b->deadline) < 0;
 }
 
+/*
+ * Per avg_vruntime() below, cfs_rq::zero_vruntime is only slightly stale
+ * and this value should be no more than two lag bounds. Which puts it in the
+ * general order of:
+ *
+ *	(slice + TICK_NSEC) << NICE_0_LOAD_SHIFT
+ *
+ * which is around 44 bits in size (on 64bit); that is 20 for
+ * NICE_0_LOAD_SHIFT, another 20 for NSEC_PER_MSEC and then a handful for
+ * however many msec the actual slice+tick ends up begin.
+ *
+ * (disregarding the actual divide-by-weight part makes for the worst case
+ * weight of 2, which nicely cancels vs the fuzz in zero_vruntime not actually
+ * being the zero-lag point).
+ */
 static inline s64 entity_key(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	return (s64)(se->vruntime - cfs_rq->zero_vruntime);
@@ -638,39 +653,61 @@ avg_vruntime_sub(struct cfs_rq *cfs_rq, struct sched_entity *se)
 }
 
 static inline
-void avg_vruntime_update(struct cfs_rq *cfs_rq, s64 delta)
+void update_zero_vruntime(struct cfs_rq *cfs_rq, s64 delta)
 {
 	/*
-	 * v' = v + d ==> avg_vruntime' = avg_runtime - d*avg_load
+	 * v' = v + d ==> avg_vruntime' = avg_vruntime - d*avg_load
 	 */
 	cfs_rq->avg_vruntime -= cfs_rq->avg_load * delta;
+       cfs_rq->zero_vruntime += delta;
 }
 
 /*
- * Specifically: avg_runtime() + 0 must result in entity_eligible() := true
+ * Specifically: avg_vruntime() + 0 must result in entity_eligible() := true
  * For this to be so, the result of this function must have a left bias.
+ *
+ * Called in:
+ *  - place_entity()      -- before enqueue
+ *  - update_entity_lag() -- before dequeue
+ *  - entity_tick()
+ *
+ * This means it is one entry 'behind' but that puts it close enough to where
+ * the bound on entity_key() is at most two lag bounds.
  */
 u64 avg_vruntime(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr = cfs_rq->curr;
-	s64 avg = cfs_rq->avg_vruntime;
-	long load = cfs_rq->avg_load;
+       long weight = cfs_rq->avg_load;
+       s64 delta = 0;
 
-	if (curr && curr->on_rq) {
-		unsigned long weight = scale_load_down(curr->load.weight);
+       if (curr && !curr->on_rq)
+               curr = NULL;
 
-		avg += entity_key(cfs_rq, curr) * weight;
-		load += weight;
-	}
+       if (weight) {
+               s64 runtime = cfs_rq->avg_vruntime;
+
+               if (curr) {
+                       unsigned long w = scale_load_down(curr->load.weight);
+
+                       runtime += entity_key(cfs_rq, curr) * w;
+                       weight += w;
+               }
 
-	if (load) {
 		/* sign flips effective floor / ceiling */
-		if (avg < 0)
-			avg -= (load - 1);
-		avg = div_s64(avg, load);
+               if (runtime < 0)
+                       runtime -= (weight - 1);
+
+               delta = div_s64(runtime, weight);
+       } else if (curr) {
+               /*
+                * When there is but one element, it is the average.
+                */
+               delta = curr->vruntime - cfs_rq->zero_vruntime;
 	}
 
-	return cfs_rq->zero_vruntime + avg;
+       update_zero_vruntime(cfs_rq, delta);
+
+       return cfs_rq->zero_vruntime;
 }
 
 /*
@@ -744,16 +781,6 @@ int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	return vruntime_eligible(cfs_rq, se->vruntime);
 }
 
-static void update_zero_vruntime(struct cfs_rq *cfs_rq)
-{
-	u64 vruntime = avg_vruntime(cfs_rq);
-	s64 delta = (s64)(vruntime - cfs_rq->zero_vruntime);
-
-	avg_vruntime_update(cfs_rq, delta);
-
-	cfs_rq->zero_vruntime = vruntime;
-}
-
 static inline u64 cfs_rq_min_slice(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *root = __pick_root_entity(cfs_rq);
@@ -824,7 +851,6 @@ RB_DECLARE_CALLBACKS(static, min_vruntime_cb, struct sched_entity,
 static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	avg_vruntime_add(cfs_rq, se);
-	update_zero_vruntime(cfs_rq);
 	se->min_vruntime = se->vruntime;
 	se->min_slice = se->slice;
 	rb_add_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
@@ -836,7 +862,6 @@ static void __dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	rb_erase_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
 				  &min_vruntime_cb);
 	avg_vruntime_sub(cfs_rq, se);
-	update_zero_vruntime(cfs_rq);
 }
 
 struct sched_entity *__pick_root_entity(struct cfs_rq *cfs_rq)
@@ -5700,6 +5725,11 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 	update_load_avg(cfs_rq, curr, UPDATE_TG);
 	update_cfs_group(curr);
 
+	/*
+	 * Pulls along cfs_rq::zero_vruntime.
+	 */
+	avg_vruntime(cfs_rq);
+
 #ifdef CONFIG_SCHED_HRTICK
 	/*
 	 * queued ticks are scheduled to match the slice, so don't bother
-- 
2.43.7


