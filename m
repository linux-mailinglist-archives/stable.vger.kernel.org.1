Return-Path: <stable+bounces-223893-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM4jNVv7r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223893-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:07:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5240249FC9
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2AC51303D10A
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7056C34B197;
	Tue, 10 Mar 2026 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANIz9WLH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AD33859EF;
	Tue, 10 Mar 2026 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140793; cv=none; b=pPW/70sFIym2/xwTJuovKxDgHAfatE+q+QaoBept57ZI3BDXIbOz00FRJLE4UKyt4jOQ8O7nFAtxx94jiA5zeFV4UVFJbln+qkX8qzdMsd+HnuLDgNrJGWOzLsrQfdleUXDtBFhIWNT9mj5eBuN/z/YQKhSyD8rTnVrXi2yfr8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140793; c=relaxed/simple;
	bh=CF/liMupwQSJpQfN3YrSSKe+EtgS5ZRGgxkxYk37J90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9P8I+S1bebTstnrKjVvKuENwZNeQGqa/Dak8iKZli831gRasEcQGzfHJ+1VgSCAeSeLQPrICyA7ZjLwJC05l36PQa9u0Lvw5a5ETdhla/usMyqgLusMMqXfBdtF7cqsycilVv5Eq12xmiPFvL/eIFHL4m9T1I6j8LjeZhKpBT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANIz9WLH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5486AC19423;
	Tue, 10 Mar 2026 11:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773140793;
	bh=CF/liMupwQSJpQfN3YrSSKe+EtgS5ZRGgxkxYk37J90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ANIz9WLHpC8uGymBoUPjCMOSZ7fyIvsCUqjvsIZh5HszqaeM5AbU2YzfgT/eMSkJC
	 g1hULsHZSxg32OFk+pglDWNApnn508BaTxhi3LOFJJBIfTztRKWbEzFXD3jzTRNJ+4
	 D7scyeh1xE7e7uE8hp4IMpxl1e5Ptp/Qfbw/hUExiEGmEAUA8mb13b9e/Z5H+BWFDu
	 bUU4mkRscMzO5WT56BI2d4wjinSP0KAdbtYit7gI9RKRPmqyTfeFxVVxwij3kJGxoD
	 PGFVAOhKmMrQHNOJb8UcbhjvcnGaB87QzxJ3URJU0mllRuaPn+3xOdGNx0okYfyqeW
	 E6zJxm6muL6uQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Shubhang Kaushik <shubhang@os.amperecomputing.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 029/311] sched/fair: Fix lag clamp
Date: Tue, 10 Mar 2026 07:01:16 -0400
Message-ID: <127aaf40b63de3e7f24eeff9231f9936072dc249.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B5240249FC9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223893-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linaro.org:email,infradead.org:email,amd.com:email,msgid.link:url,amperecomputing.com:email]
X-Rspamd-Action: no action

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 6e3c0a4e1ad1e0455b7880fad02b3ee179f56c09 ]

Vincent reported that he was seeing undue lag clamping in a mixed
slice workload. Implement the max_slice tracking as per the todo
comment.

Fixes: 147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling policy")
Reported-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Shubhang Kaushik <shubhang@os.amperecomputing.com>
Link: https://patch.msgid.link/20250422101628.GA33555@noisy.programming.kicks-ass.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sched.h |  1 +
 kernel/sched/fair.c   | 39 +++++++++++++++++++++++++++++++++++----
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5f00b5ed0f3b7..eb1c4c347a5cf 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -574,6 +574,7 @@ struct sched_entity {
 	u64				deadline;
 	u64				min_vruntime;
 	u64				min_slice;
+	u64				max_slice;
 
 	struct list_head		group_node;
 	unsigned char			on_rq;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c8a6dac54e220..a8e766eaca1f9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -748,6 +748,8 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
 	return cfs_rq->zero_vruntime;
 }
 
+static inline u64 cfs_rq_max_slice(struct cfs_rq *cfs_rq);
+
 /*
  * lag_i = S - s_i = w_i * (V - v_i)
  *
@@ -761,17 +763,16 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
  * EEVDF gives the following limit for a steady state system:
  *
  *   -r_max < lag < max(r_max, q)
- *
- * XXX could add max_slice to the augmented data to track this.
  */
 static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	u64 max_slice = cfs_rq_max_slice(cfs_rq) + TICK_NSEC;
 	s64 vlag, limit;
 
 	WARN_ON_ONCE(!se->on_rq);
 
 	vlag = avg_vruntime(cfs_rq) - se->vruntime;
-	limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
+	limit = calc_delta_fair(max_slice, se);
 
 	se->vlag = clamp(vlag, -limit, limit);
 }
@@ -829,6 +830,21 @@ static inline u64 cfs_rq_min_slice(struct cfs_rq *cfs_rq)
 	return min_slice;
 }
 
+static inline u64 cfs_rq_max_slice(struct cfs_rq *cfs_rq)
+{
+	struct sched_entity *root = __pick_root_entity(cfs_rq);
+	struct sched_entity *curr = cfs_rq->curr;
+	u64 max_slice = 0ULL;
+
+	if (curr && curr->on_rq)
+		max_slice = curr->slice;
+
+	if (root)
+		max_slice = max(max_slice, root->max_slice);
+
+	return max_slice;
+}
+
 static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
 {
 	return entity_before(__node_2_se(a), __node_2_se(b));
@@ -853,6 +869,15 @@ static inline void __min_slice_update(struct sched_entity *se, struct rb_node *n
 	}
 }
 
+static inline void __max_slice_update(struct sched_entity *se, struct rb_node *node)
+{
+	if (node) {
+		struct sched_entity *rse = __node_2_se(node);
+		if (rse->max_slice > se->max_slice)
+			se->max_slice = rse->max_slice;
+	}
+}
+
 /*
  * se->min_vruntime = min(se->vruntime, {left,right}->min_vruntime)
  */
@@ -860,6 +885,7 @@ static inline bool min_vruntime_update(struct sched_entity *se, bool exit)
 {
 	u64 old_min_vruntime = se->min_vruntime;
 	u64 old_min_slice = se->min_slice;
+	u64 old_max_slice = se->max_slice;
 	struct rb_node *node = &se->run_node;
 
 	se->min_vruntime = se->vruntime;
@@ -870,8 +896,13 @@ static inline bool min_vruntime_update(struct sched_entity *se, bool exit)
 	__min_slice_update(se, node->rb_right);
 	__min_slice_update(se, node->rb_left);
 
+	se->max_slice = se->slice;
+	__max_slice_update(se, node->rb_right);
+	__max_slice_update(se, node->rb_left);
+
 	return se->min_vruntime == old_min_vruntime &&
-	       se->min_slice == old_min_slice;
+	       se->min_slice == old_min_slice &&
+	       se->max_slice == old_max_slice;
 }
 
 RB_DECLARE_CALLBACKS(static, min_vruntime_cb, struct sched_entity,
-- 
2.51.0


