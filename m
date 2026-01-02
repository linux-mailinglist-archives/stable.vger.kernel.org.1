Return-Path: <stable+bounces-204479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7DBCEEB6F
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 14:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4CDA13000B45
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 13:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075A43126DA;
	Fri,  2 Jan 2026 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNhbV1Gf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC28E207A32
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767362388; cv=none; b=XtgNZXra17iKPqIz5WAzBM+gFW93AAnCI+KphnWbOZzjQ7l8P/WU8JjOD5GDxLIWD9bZuiJp239ml3EgG0iGUR+7614qk9QS9WqF/rHnJVeGTwYFmYblNT8unkwWRB9kddPSsJL3zHlWvtaTFd8en9MOSz5AJK05DpV8yPXR3xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767362388; c=relaxed/simple;
	bh=yretoUzSFgVBj4ieIumgdS1/hUHfhH8t86hiGcV/cj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZsZUs5EAEsRPOcJ5lWGmsSjylcqR51+P+iyRdVfWA3N8/txq6KIkC+ZTVT9vki9GyXlfC9F/dW9vstrnqxF0JfcAZj4TookRo+Ce7BSoO4ciVTrYby8al/oSMkx8J4KUuSBtL2g6gxnhsQ/y4SQLKRCJXnNxB4L3s0y7/79ZFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNhbV1Gf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D65C116B1;
	Fri,  2 Jan 2026 13:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767362388;
	bh=yretoUzSFgVBj4ieIumgdS1/hUHfhH8t86hiGcV/cj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nNhbV1GfnKQD2NH45DGKSJiG+T+e3nUbCBNZPil2rodDZrZhH1uDoT3crvYBKHUSt
	 LLGP2GV28NfWIEIFXRHAOJFEX2dR/CuYlhig4wbgs/EJGIvgcJ8YxXhTTpO/yEjouy
	 3vxPFP8csXmZO9EG04zHLiFigTBSMSRVsNcG1B3FDKDT+P5+hiVHW7lOrvsVZ/JuXL
	 KJ5VqHMtK4LXSs9Kr2l48qMszOYzDSK/fOCQyCQuUGANx/bz0MMU7ezN9hq2PdyPgM
	 yqx67BVkZPLQzxXH47lfY750tp4Z4xEZHfsZc/0jtIG8pbAwE+NaJQif8Qt6XeOfjY
	 AiUTAh6mhhrHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] sched_ext: Factor out local_dsq_post_enq() from dispatch_enqueue()
Date: Fri,  2 Jan 2026 08:59:44 -0500
Message-ID: <20260102135945.259421-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122922-chubby-doctrine-9c07@gregkh>
References: <2025122922-chubby-doctrine-9c07@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 530b6637c79e728d58f1d9b66bd4acf4b735b86d ]

Factor out local_dsq_post_enq() which performs post-enqueue handling for
local DSQs - triggering resched_curr() if SCX_ENQ_PREEMPT is specified or if
the current CPU is idle. No functional change.

This will be used by the next patch to fix move_local_task_to_local_dsq().

Cc: stable@vger.kernel.org # v6.12+
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
[ adapted function placement to precede dispatch_enqueue() due to missing refill_task_slice_dfl() function in stable branch ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ad1d438b3085..54e194d08d92 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1668,6 +1668,22 @@ static void dsq_mod_nr(struct scx_dispatch_q *dsq, s32 delta)
 	WRITE_ONCE(dsq->nr, dsq->nr + delta);
 }
 
+static void local_dsq_post_enq(struct scx_dispatch_q *dsq, struct task_struct *p,
+			       u64 enq_flags)
+{
+	struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
+	bool preempt = false;
+
+	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
+	    rq->curr->sched_class == &ext_sched_class) {
+		rq->curr->scx.slice = 0;
+		preempt = true;
+	}
+
+	if (preempt || sched_class_above(&ext_sched_class, rq->curr->sched_class))
+		resched_curr(rq);
+}
+
 static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 			     u64 enq_flags)
 {
@@ -1765,22 +1781,10 @@ static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 	if (enq_flags & SCX_ENQ_CLEAR_OPSS)
 		atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
 
-	if (is_local) {
-		struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
-		bool preempt = false;
-
-		if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
-		    rq->curr->sched_class == &ext_sched_class) {
-			rq->curr->scx.slice = 0;
-			preempt = true;
-		}
-
-		if (preempt || sched_class_above(&ext_sched_class,
-						 rq->curr->sched_class))
-			resched_curr(rq);
-	} else {
+	if (is_local)
+		local_dsq_post_enq(dsq, p, enq_flags);
+	else
 		raw_spin_unlock(&dsq->lock);
-	}
 }
 
 static void task_unlink_from_dsq(struct task_struct *p,
-- 
2.51.0


