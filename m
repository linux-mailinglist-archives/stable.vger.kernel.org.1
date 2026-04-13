Return-Path: <stable+bounces-236354-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LiBB5Eb3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236354-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:36:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7804A3EF5C1
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1894D3068EE8
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D512A303CB0;
	Mon, 13 Apr 2026 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J+4kOWCK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9860E28314C;
	Mon, 13 Apr 2026 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096689; cv=none; b=mThsebvNPsu06WuHwkAoDdnA5zIcTmhEQCAUcxXmYienBLjE7XTbf5nuIWRE7zYaG7itebd2l6wI0v4CfeIrTWNRFkRB4pSxYK0GzMTkN1GPaHUUmNOlpH+x1lDOWZNA7xi776TcozJZdYCZ4t295rM+fCSV4UcNYeoyMDorw+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096689; c=relaxed/simple;
	bh=YUrfJAtOSaX1iCVEw7UMSHtp+KpZOuMap+IcpQLObRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kk9pXrn2IgSflhibqXpc5Cuq1nwta5j8U6N89w5KLhnVBucEqdAo2eQ7ozts4dFeIQsfUbc0NaG3pKsG9RqOPSJ3jXB7y9xZW6sxlyNZNfbq/h2MBVIgxTihWp8u4Qz00wUGGEQGDehDg9XsuGsUL6nYPgK9YOEQwCH8psA3DeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J+4kOWCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D97BC2BCB0;
	Mon, 13 Apr 2026 16:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096689;
	bh=YUrfJAtOSaX1iCVEw7UMSHtp+KpZOuMap+IcpQLObRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J+4kOWCKEZNRqLFdsuY78/iu7Cd9ULdn0k0BWv4JiLsNb2e6cw5u4yjhpNe/nwt1B
	 dp8oMotfrs5ZMF0sEFOAd2QwyBTUFic2IBv4VFwVglNsO4Qwi+qokB/RBwZL6zwn2X
	 aP9OQlyojLkyNdB8o84kbHwPsy39gIDeTNXdHE6A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Hodges <hodgesd@meta.com>,
	Patrick Somaru <patsomaru@meta.com>,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 25/70] sched_ext: Fix stale direct dispatch state in ddsp_dsq_id
Date: Mon, 13 Apr 2026 18:00:20 +0200
Message-ID: <20260413155729.127432382@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155728.181580293@linuxfoundation.org>
References: <20260413155728.181580293@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236354-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7804A3EF5C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/ext.c |   48 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 12 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1782,15 +1782,6 @@ static void dispatch_enqueue(struct scx_
 	p->scx.dsq = dsq;
 
 	/*
-	 * scx.ddsp_dsq_id and scx.ddsp_enq_flags are only relevant on the
-	 * direct dispatch path, but we clear them here because the direct
-	 * dispatch verdict may be overridden on the enqueue path during e.g.
-	 * bypass.
-	 */
-	p->scx.ddsp_dsq_id = SCX_DSQ_INVALID;
-	p->scx.ddsp_enq_flags = 0;
-
-	/*
 	 * We're transitioning out of QUEUEING or DISPATCHING. store_release to
 	 * match waiters' load_acquire.
 	 */
@@ -1930,11 +1921,33 @@ static void mark_direct_dispatch(struct
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
 
@@ -1975,7 +1988,10 @@ static void direct_dispatch(struct task_
 		return;
 	}
 
-	dispatch_enqueue(dsq, p, p->scx.ddsp_enq_flags | SCX_ENQ_CLEAR_OPSS);
+	ddsp_enq_flags = p->scx.ddsp_enq_flags;
+	clear_direct_dispatch(p);
+
+	dispatch_enqueue(dsq, p, ddsp_enq_flags | SCX_ENQ_CLEAR_OPSS);
 }
 
 static bool scx_rq_online(struct rq *rq)
@@ -2060,12 +2076,14 @@ local:
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
 
@@ -2225,6 +2243,7 @@ static bool dequeue_task_scx(struct rq *
 	sub_nr_running(rq, 1);
 
 	dispatch_dequeue(rq, p);
+	clear_direct_dispatch(p);
 	return true;
 }
 
@@ -2905,12 +2924,15 @@ static void process_ddsp_deferred_locals
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
 
@@ -3707,6 +3729,8 @@ static void scx_ops_disable_task(struct
 	lockdep_assert_rq_held(task_rq(p));
 	WARN_ON_ONCE(scx_get_task_state(p) != SCX_TASK_ENABLED);
 
+	clear_direct_dispatch(p);
+
 	if (SCX_HAS_OP(disable))
 		SCX_CALL_OP_TASK(SCX_KF_REST, disable, p);
 	scx_set_task_state(p, SCX_TASK_READY);



