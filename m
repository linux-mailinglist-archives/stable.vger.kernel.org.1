Return-Path: <stable+bounces-203497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39085CE68C4
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 12:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34DFD30024F5
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 11:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8996030BF78;
	Mon, 29 Dec 2025 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eXMblZJf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE29530CD8A
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 11:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767008186; cv=none; b=KSsan7PqHBFDQWyAstqMofwYFvmeuY6NIyreB6TGrYNUQjDg37x7C+3df2VXqXbOJUUeY3P8QOM6pLl7HrPjMqder/EQmrpTeoJigs4fE6HRalWcsJhggMr8AFBxxZr4LP5+/fqUJsEbxUdCbycf36EN9zBZaGqSOkzM5accjdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767008186; c=relaxed/simple;
	bh=PaxtwEUNN5MmN9UpfeRjFroBa/g9z3m/WXiz5mgO33g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FQ8vPJK+gQoT/x+LkUanwjoNWl4MBHtNRZEa6WkdwgBTCLjNsOBpvOAG2p/IydiEx8IYUm3m4aJlD71I9o68ZPWUGoncYzghI6uPgjg0HVEd9T3w/kdeHg15o018LxvP6qSWyficqlXq7Eljfb1ju4wRIe/8I8D1otUKnW/mAhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eXMblZJf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87115C4CEF7;
	Mon, 29 Dec 2025 11:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767008184;
	bh=PaxtwEUNN5MmN9UpfeRjFroBa/g9z3m/WXiz5mgO33g=;
	h=Subject:To:Cc:From:Date:From;
	b=eXMblZJfAsw/sMJVqCUpbSZcaQp9kpzBULyKaT0jpQPUXGd2QnxVoaQdWXYC4u+Zr
	 GZxhoK3hhDmky3qhxYwjqNuVhTGWwSk1E2Sm8yiBlDCLA7CxSRxCm7UmNZePgUYN+2
	 K8CZ70f3nWZuI4jrVfVY9mrOwcKB43fN2Kg+X2Y0=
Subject: FAILED: patch "[PATCH] sched_ext: Factor out local_dsq_post_enq() from" failed to apply to 6.12-stable tree
To: tj@kernel.org,arighi@nvidia.com,emil@etsalapatis.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 12:36:22 +0100
Message-ID: <2025122922-chubby-doctrine-9c07@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 530b6637c79e728d58f1d9b66bd4acf4b735b86d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122922-chubby-doctrine-9c07@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 530b6637c79e728d58f1d9b66bd4acf4b735b86d Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Thu, 11 Dec 2025 15:45:03 -1000
Subject: [PATCH] sched_ext: Factor out local_dsq_post_enq() from
 dispatch_enqueue()

Factor out local_dsq_post_enq() which performs post-enqueue handling for
local DSQs - triggering resched_curr() if SCX_ENQ_PREEMPT is specified or if
the current CPU is idle. No functional change.

This will be used by the next patch to fix move_local_task_to_local_dsq().

Cc: stable@vger.kernel.org # v6.12+
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Tejun Heo <tj@kernel.org>

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


