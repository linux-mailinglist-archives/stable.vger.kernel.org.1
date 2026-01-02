Return-Path: <stable+bounces-204422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C73CED99D
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 03:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B5D030006E5
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 02:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A971386DA;
	Fri,  2 Jan 2026 02:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUD7f56u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935BC1C28E
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 02:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767319280; cv=none; b=jwIhOidVY2u1dWQQkInb2yLm4b2wh03eiJ145cYfcN50QupXrXfixu0X0nUWFgJ/ml2mh0Yp/ncf2Ltp5jN8JMC4lohfoLipPuCzOJxnCPSkqDnRPLpc8R/EZYeHj1BznPraK+ZAgMeqqQFouJPTGWm036SU8SJ+kbIE3F4dCm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767319280; c=relaxed/simple;
	bh=ups99G3WUf6rANZTJo7q9lPmu8QRAGdWlehtfWE2YuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUCnWu3bjWV5TAP5R8HqFBiOSaL9xMfABhpHjpkJSVFkwqm9cSqDCYLcJvHGYLY24KW2wdtkC1e+P9+6AFFQrLtk82cBW4urBdcbKe/W+P4dKr4MJRPPcv3EUmWFDrETkHUoEHx7NFORqAAympCTvwwxORFSe1s65AsfTwhHbbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUD7f56u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A40C4CEF7;
	Fri,  2 Jan 2026 02:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767319280;
	bh=ups99G3WUf6rANZTJo7q9lPmu8QRAGdWlehtfWE2YuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KUD7f56ubCFMPDg4kMD/cyuSJrLLJ+NU5RB755hof1pukXi4uS2KxhnrzfHep1GlI
	 qntQl4OQHbjrfnxZyqTdWHYRLQphio+ZrqTkRzZozyh0zJEwiYN9qUGgwCRpBJ9yWD
	 hs6+fJperDCIR24OXCoupMWCNru5OZGBkHF3JVBFBSlg/Q3dGvqHMCalBEDGylB/VF
	 i6Llj1fcCioCsvYVf8o8O+h3rm1gukpBGJmJExhrYNqoK9SgZPtlQMX3gL8mmvC7gS
	 GKQ+lgkYxfpfQKS7TAmmmoIJg9oj8UcgsnJXWK4Ke/9t2KdIqWZ0LdjQAynauzGrl4
	 VFrDHbfxg93qg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] sched_ext: Factor out local_dsq_post_enq() from dispatch_enqueue()
Date: Thu,  1 Jan 2026 21:01:16 -0500
Message-ID: <20260102020117.100465-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122951-giggle-reveler-2e6b@gregkh>
References: <2025122951-giggle-reveler-2e6b@gregkh>
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


