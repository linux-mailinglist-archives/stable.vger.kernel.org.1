Return-Path: <stable+bounces-200831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C2ECB790C
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 02:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1084230365A4
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 01:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F670289376;
	Fri, 12 Dec 2025 01:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1TWmuQQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4377A288505;
	Fri, 12 Dec 2025 01:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765503907; cv=none; b=DzF+xHZHtgMalzcgYLlGVvJmQGyXynovKZmbO2sRpOJL9Gmvpug7KIOy4sU1Biz0dcIrovgzDOXOFd197R94VcUdhAufr+2F99tduTbb+JpK/KbqEBAaHYP8gH954PIfNffQvdXxyeE6dv0Sn5cxQ0UqIIp1I/8vaInhPD7SgbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765503907; c=relaxed/simple;
	bh=UJJkARlwEbP8LGXAUAsb+Fr0+h9ebWX3NcTfKIf8Nx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMgRh9Tj3jQ1ehwjo1Vqug24L6b/wjgSHQJh8fuyag/4pUhQjduJgIC7uZsY7YPTwVkIhz+nPf71PvKqAGT4qA8lQXIynuBrmNPQH3erewFcKgif6ZRc0dLoAhxLmnbS3ibksw/WaMqZvURnkyAMFu3/ULz8jHK2cjKS4eDpNwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1TWmuQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D99C113D0;
	Fri, 12 Dec 2025 01:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765503906;
	bh=UJJkARlwEbP8LGXAUAsb+Fr0+h9ebWX3NcTfKIf8Nx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m1TWmuQQuuYuEASRt/3KgBER+RwTwUvj5zwCM8wvzSyNBN6L2hOvM+YKQPpdcbgyz
	 y6jOzEZo7h0O0JBZsDFTbSsFxDYUjhIr5Hz4hPKgycrHzSotPQcKrjhi8FMWjDDaMA
	 87rh3IhqBspItojTKWYEZNw+lwlLcQ7+rTHlc6j4sfurPN1vPEZf30hCmJgckffGvL
	 VQBz/33l22z+uX6d8hPHh/2gFbnSawBFv7tlCpYSubQ8norQZHP10rNhEY4OuS86gA
	 6rltMma6PAFcIb2RBxCUyjDnGryJOyAyNRqouWcch21xIs7RbjKFxyGTjYHL9suBIG
	 lOORaJcPrrHqw==
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/2] sched_ext: Factor out local_dsq_post_enq() from dispatch_enqueue()
Date: Thu, 11 Dec 2025 15:45:03 -1000
Message-ID: <20251212014504.3431169-2-tj@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251212014504.3431169-1-tj@kernel.org>
References: <20251211224809.3383633-1-tj@kernel.org>
 <20251212014504.3431169-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out local_dsq_post_enq() which performs post-enqueue handling for
local DSQs - triggering resched_curr() if SCX_ENQ_PREEMPT is specified or if
the current CPU is idle. No functional change.

This will be used by the next patch to fix move_local_task_to_local_dsq().

Cc: stable@vger.kernel.org # v6.12+
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c4465ccefea4..c78efa99406f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -982,6 +982,22 @@ static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
 	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
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
 static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 			     struct task_struct *p, u64 enq_flags)
 {
@@ -1093,22 +1109,10 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
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
2.52.0


