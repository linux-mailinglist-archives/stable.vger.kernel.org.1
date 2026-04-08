Return-Path: <stable+bounces-233913-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPOCLl9c1mmNEggAu9opvQ
	(envelope-from <stable+bounces-233913-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 15:47:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C013BD2AD
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 15:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A58B3045026
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 13:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423F53CF674;
	Wed,  8 Apr 2026 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNDfS7BV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044743CD8B1
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 13:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775655853; cv=none; b=i6ZHKty6nfUVB2IDpYS+2/a3BzHP4wrDhMylmvh/SKYLSG/ALoCNhOPgt2Opt5lXPgn3X7u7TH7234KOsO55f7nNNfVXJ+QQEXFCT9OEzFzlbr91KNePRoIuX0ydlwhjHAI1GODK9IqFNvtSUwYMjmgXZsZfBZ861vMA1QvPono=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775655853; c=relaxed/simple;
	bh=TeXZd4SvEekJjL4VhVFXCLvOGiataq9QzheSFFxxVX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUFMhexLcTz5fx5QjnN4mXcF3SHR2U/vuo/MbCRXT4KYXRnWZh5QO+JetFrNW7VU/BLpO4sXZxzf08Q58R9NOS8S31BQkZA7USvsHXFTyrK+KtXKga/r2ZrOc781ERD3b5BlzpX1ZCZa4HQ0uYZaO8YMWC3DqPDkanuWA5VUBQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNDfS7BV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7A4C2BC9E;
	Wed,  8 Apr 2026 13:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775655852;
	bh=TeXZd4SvEekJjL4VhVFXCLvOGiataq9QzheSFFxxVX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YNDfS7BVCVVyBC3yv2MeFSaTS7XIYUtJvk0SmsvP1GzfodsiQzHtCybqBNsg7x9Pv
	 eDmC7oVvwVzw7ip2qLh1fTN6H8Ktw8B1tLh1LszZEE3ZMzkBx1i/dvAkzqbsI+QwQv
	 idEfqJny7BAPaTKK7AQ8brZYCZCtwNe6hXynpZ95d8EjPMJbia0cEhVV9EWbgtzJtN
	 NNzFDU8JboXuHy/DYBvhAXzbCuuz+BTEK69EHAhfdM13WbVqLwhGj+H9e0vOkVDdI/
	 0Wwnxi+ph/ad7E/J8G1fYeN17b12dCojIZvqjSHhw+SR7ONLsFzDQFDx9VFmhB9V2h
	 yJncW5tR5Pbog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrea Righi <arighi@nvidia.com>,
	Daniel Hodges <hodgesd@meta.com>,
	Patrick Somaru <patsomaru@meta.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] sched_ext: Fix stale direct dispatch state in ddsp_dsq_id
Date: Wed,  8 Apr 2026 09:44:09 -0400
Message-ID: <20260408134409.1100876-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026040840-slightly-linked-0149@gregkh>
References: <2026040840-slightly-linked-0149@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233913-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email,nvidia.com:email]
X-Rspamd-Queue-Id: 31C013BD2AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Andrea Righi <arighi@nvidia.com>

[ Upstream commit 7e0ffb72de8aa3b25989c2d980e81b829c577010 ]

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
[ adapted function signatures and code paths ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 48 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 86ef9c8f45dae..25df16aed142a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1781,15 +1781,6 @@ static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
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
@@ -1930,11 +1921,33 @@ static void mark_direct_dispatch(struct task_struct *ddsp_task,
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
 static void direct_dispatch(struct task_struct *p, u64 enq_flags)
 {
 	struct rq *rq = task_rq(p);
 	struct scx_dispatch_q *dsq =
 		find_dsq_for_dispatch(rq, p->scx.ddsp_dsq_id, p);
+	u64 ddsp_enq_flags;
 
 	touch_core_sched_dispatch(rq, p);
 
@@ -1975,7 +1988,10 @@ static void direct_dispatch(struct task_struct *p, u64 enq_flags)
 		return;
 	}
 
-	dispatch_enqueue(dsq, p, p->scx.ddsp_enq_flags | SCX_ENQ_CLEAR_OPSS);
+	ddsp_enq_flags = p->scx.ddsp_enq_flags;
+	clear_direct_dispatch(p);
+
+	dispatch_enqueue(dsq, p, ddsp_enq_flags | SCX_ENQ_CLEAR_OPSS);
 }
 
 static bool scx_rq_online(struct rq *rq)
@@ -2060,12 +2076,14 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	touch_core_sched(rq, p);
 	p->scx.slice = SCX_SLICE_DFL;
 local_norefill:
+	clear_direct_dispatch(p);
 	dispatch_enqueue(&rq->scx.local_dsq, p, enq_flags);
 	return;
 
 global:
 	touch_core_sched(rq, p);	/* see the comment in local: */
 	p->scx.slice = SCX_SLICE_DFL;
+	clear_direct_dispatch(p);
 	dispatch_enqueue(find_global_dsq(p), p, enq_flags);
 }
 
@@ -2225,6 +2243,7 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 	sub_nr_running(rq, 1);
 
 	dispatch_dequeue(rq, p);
+	clear_direct_dispatch(p);
 	return true;
 }
 
@@ -2905,12 +2924,15 @@ static void process_ddsp_deferred_locals(struct rq *rq)
 	while ((p = list_first_entry_or_null(&rq->scx.ddsp_deferred_locals,
 				struct task_struct, scx.dsq_list.node))) {
 		struct scx_dispatch_q *dsq;
+		u64 dsq_id = p->scx.ddsp_dsq_id;
+		u64 enq_flags = p->scx.ddsp_enq_flags;
 
 		list_del_init(&p->scx.dsq_list.node);
+		clear_direct_dispatch(p);
 
-		dsq = find_dsq_for_dispatch(rq, p->scx.ddsp_dsq_id, p);
+		dsq = find_dsq_for_dispatch(rq, dsq_id, p);
 		if (!WARN_ON_ONCE(dsq->id != SCX_DSQ_LOCAL))
-			dispatch_to_local_dsq(rq, dsq, p, p->scx.ddsp_enq_flags);
+			dispatch_to_local_dsq(rq, dsq, p, enq_flags);
 	}
 }
 
@@ -3707,6 +3729,8 @@ static void scx_ops_disable_task(struct task_struct *p)
 	lockdep_assert_rq_held(task_rq(p));
 	WARN_ON_ONCE(scx_get_task_state(p) != SCX_TASK_ENABLED);
 
+	clear_direct_dispatch(p);
+
 	if (SCX_HAS_OP(disable))
 		SCX_CALL_OP_TASK(SCX_KF_REST, disable, p);
 	scx_set_task_state(p, SCX_TASK_READY);
-- 
2.53.0


