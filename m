Return-Path: <stable+bounces-233790-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMSlGO791Wn4/gcAu9opvQ
	(envelope-from <stable+bounces-233790-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:04:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FE63B7DA1
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DABD3035D5F
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 07:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB194351C0D;
	Wed,  8 Apr 2026 07:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SDAjnqv2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691F72367D9
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 07:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775631651; cv=none; b=Lmyj+foTFZVlxIxWx78eS6fRAdlgA8An3rb+CTE5uUJOR2Rqo7uaTRoPdxLxHnyOUGveruqaDa6w9tOjAWe9dn6O9z+VQWXY7qFkpGmEKJETvU8/PJZbqhxaglDdTcsPkH+RN7wYwqDZTb3c71YxJzcECJq+XkEiDnyyu2V33nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775631651; c=relaxed/simple;
	bh=vnJ2tS7dMzPvFmb6y+QMfDKx+KZJcONhQYufHgRnxU8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=j40hzE3JgSfHNW35X0xyD9hT11yzlA6axDiM4g6+NCk50/6GK8LxjfgQVAM1gBBLiWOKtVMABHELYeyeI5SQwoJZgy82QaoXDv62XmcKi0edAeOj/vb2c01hbLotSA4IHeZQKKsxr88a835I4D0KH9yi/hT4qnL+35z4mnBFTiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SDAjnqv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5C0C19425;
	Wed,  8 Apr 2026 07:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775631651;
	bh=vnJ2tS7dMzPvFmb6y+QMfDKx+KZJcONhQYufHgRnxU8=;
	h=Subject:To:Cc:From:Date:From;
	b=SDAjnqv2Eo2fx4uigPwoVtVIiWk2SsaHzuI5oQyhM3KLrgI8R3liJ2OoEuS5vNXdc
	 mCYhkfDOOlZGr1TMeBAEgjQxcSghNPljHNBdKJfbkmoYOQxxd9QukWdJXyJ7mpZjeB
	 wEdPxfIaFFY7OkpAHJ1X5cCUIrw12adT1ILxVEjU=
Subject: FAILED: patch "[PATCH] sched_ext: Fix stale direct dispatch state in ddsp_dsq_id" failed to apply to 6.12-stable tree
To: arighi@nvidia.com,hodgesd@meta.com,patsomaru@meta.com,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 08 Apr 2026 09:00:40 +0200
Message-ID: <2026040840-slightly-linked-0149@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233790-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email,linuxfoundation.org:dkim,gregkh:email,nvidia.com:email]
X-Rspamd-Queue-Id: D0FE63B7DA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 7e0ffb72de8aa3b25989c2d980e81b829c577010
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040840-slightly-linked-0149@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7e0ffb72de8aa3b25989c2d980e81b829c577010 Mon Sep 17 00:00:00 2001
From: Andrea Righi <arighi@nvidia.com>
Date: Fri, 3 Apr 2026 08:57:20 +0200
Subject: [PATCH] sched_ext: Fix stale direct dispatch state in ddsp_dsq_id

@p->scx.ddsp_dsq_id can be left set (non-SCX_DSQ_INVALID) triggering a
spurious warning in mark_direct_dispatch() when the next wakeup's
ops.select_cpu() calls scx_bpf_dsq_insert(), such as:

 WARNING: kernel/sched/ext.c:1273 at scx_dsq_insert_commit+0xcd/0x140

The root cause is that ddsp_dsq_id was only cleared in dispatch_enqueue(),
which is not reached in all paths that consume or cancel a direct dispatch
verdict.

Fix it by clearing it at the right places:

 - direct_dispatch(): cache the direct dispatch state in local variables
   and clear it before dispatch_enqueue() on the synchronous path. For
   the deferred path, the direct dispatch state must remain set until
   process_ddsp_deferred_locals() consumes them.

 - process_ddsp_deferred_locals(): cache the dispatch state in local
   variables and clear it before calling dispatch_to_local_dsq(), which
   may migrate the task to another rq.

 - do_enqueue_task(): clear the dispatch state on the enqueue path
   (local/global/bypass fallbacks), where the direct dispatch verdict is
   ignored.

 - dequeue_task_scx(): clear the dispatch state after dispatch_dequeue()
   to handle both the deferred dispatch cancellation and the holding_cpu
   race, covering all cases where a pending direct dispatch is
   cancelled.

 - scx_disable_task(): clear the direct dispatch state when
   transitioning a task out of the current scheduler. Waking tasks may
   have had the direct dispatch state set by the outgoing scheduler's
   ops.select_cpu() and then been queued on a wake_list via
   ttwu_queue_wakelist(), when SCX_OPS_ALLOW_QUEUED_WAKEUP is set. Such
   tasks are not on the runqueue and are not iterated by scx_bypass(),
   so their direct dispatch state won't be cleared. Without this clear,
   any subsequent SCX scheduler that tries to direct dispatch the task
   will trigger the WARN_ON_ONCE() in mark_direct_dispatch().

Fixes: 5b26f7b920f7 ("sched_ext: Allow SCX_DSQ_LOCAL_ON for direct dispatches")
Cc: stable@vger.kernel.org # v6.12+
Cc: Daniel Hodges <hodgesd@meta.com>
Cc: Patrick Somaru <patsomaru@meta.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d5bdcdb3f700..064eaa76be4b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1109,15 +1109,6 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 	dsq_mod_nr(dsq, 1);
 	p->scx.dsq = dsq;
 
-	/*
-	 * scx.ddsp_dsq_id and scx.ddsp_enq_flags are only relevant on the
-	 * direct dispatch path, but we clear them here because the direct
-	 * dispatch verdict may be overridden on the enqueue path during e.g.
-	 * bypass.
-	 */
-	p->scx.ddsp_dsq_id = SCX_DSQ_INVALID;
-	p->scx.ddsp_enq_flags = 0;
-
 	/*
 	 * We're transitioning out of QUEUEING or DISPATCHING. store_release to
 	 * match waiters' load_acquire.
@@ -1283,12 +1274,34 @@ static void mark_direct_dispatch(struct scx_sched *sch,
 	p->scx.ddsp_enq_flags = enq_flags;
 }
 
+/*
+ * Clear @p direct dispatch state when leaving the scheduler.
+ *
+ * Direct dispatch state must be cleared in the following cases:
+ *  - direct_dispatch(): cleared on the synchronous enqueue path, deferred
+ *    dispatch keeps the state until consumed
+ *  - process_ddsp_deferred_locals(): cleared after consuming deferred state,
+ *  - do_enqueue_task(): cleared on enqueue fallbacks where the dispatch
+ *    verdict is ignored (local/global/bypass)
+ *  - dequeue_task_scx(): cleared after dispatch_dequeue(), covering deferred
+ *    cancellation and holding_cpu races
+ *  - scx_disable_task(): cleared for queued wakeup tasks, which are excluded by
+ *    the scx_bypass() loop, so that stale state is not reused by a subsequent
+ *    scheduler instance
+ */
+static inline void clear_direct_dispatch(struct task_struct *p)
+{
+	p->scx.ddsp_dsq_id = SCX_DSQ_INVALID;
+	p->scx.ddsp_enq_flags = 0;
+}
+
 static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
 			    u64 enq_flags)
 {
 	struct rq *rq = task_rq(p);
 	struct scx_dispatch_q *dsq =
 		find_dsq_for_dispatch(sch, rq, p->scx.ddsp_dsq_id, p);
+	u64 ddsp_enq_flags;
 
 	touch_core_sched_dispatch(rq, p);
 
@@ -1329,8 +1342,10 @@ static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
 		return;
 	}
 
-	dispatch_enqueue(sch, dsq, p,
-			 p->scx.ddsp_enq_flags | SCX_ENQ_CLEAR_OPSS);
+	ddsp_enq_flags = p->scx.ddsp_enq_flags;
+	clear_direct_dispatch(p);
+
+	dispatch_enqueue(sch, dsq, p, ddsp_enq_flags | SCX_ENQ_CLEAR_OPSS);
 }
 
 static bool scx_rq_online(struct rq *rq)
@@ -1439,6 +1454,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	 */
 	touch_core_sched(rq, p);
 	refill_task_slice_dfl(sch, p);
+	clear_direct_dispatch(p);
 	dispatch_enqueue(sch, dsq, p, enq_flags);
 }
 
@@ -1610,6 +1626,7 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 	sub_nr_running(rq, 1);
 
 	dispatch_dequeue(rq, p);
+	clear_direct_dispatch(p);
 	return true;
 }
 
@@ -2293,13 +2310,15 @@ static void process_ddsp_deferred_locals(struct rq *rq)
 				struct task_struct, scx.dsq_list.node))) {
 		struct scx_sched *sch = scx_root;
 		struct scx_dispatch_q *dsq;
+		u64 dsq_id = p->scx.ddsp_dsq_id;
+		u64 enq_flags = p->scx.ddsp_enq_flags;
 
 		list_del_init(&p->scx.dsq_list.node);
+		clear_direct_dispatch(p);
 
-		dsq = find_dsq_for_dispatch(sch, rq, p->scx.ddsp_dsq_id, p);
+		dsq = find_dsq_for_dispatch(sch, rq, dsq_id, p);
 		if (!WARN_ON_ONCE(dsq->id != SCX_DSQ_LOCAL))
-			dispatch_to_local_dsq(sch, rq, dsq, p,
-					      p->scx.ddsp_enq_flags);
+			dispatch_to_local_dsq(sch, rq, dsq, p, enq_flags);
 	}
 }
 
@@ -3015,6 +3034,8 @@ static void scx_disable_task(struct task_struct *p)
 	lockdep_assert_rq_held(rq);
 	WARN_ON_ONCE(scx_get_task_state(p) != SCX_TASK_ENABLED);
 
+	clear_direct_dispatch(p);
+
 	if (SCX_HAS_OP(sch, disable))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, disable, rq, p);
 	scx_set_task_state(p, SCX_TASK_READY);


