Return-Path: <stable+bounces-264006-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k9a9HOtsMWoQjAUAu9opvQ
	(envelope-from <stable+bounces-264006-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:34:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB0E691274
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:34:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="S/5vBlzm";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264006-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-264006-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B271313CE9F
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A07B43E49A;
	Tue, 16 Jun 2026 15:27:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D91134889F;
	Tue, 16 Jun 2026 15:27:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623636; cv=none; b=SNubqVZDdhkKOi8BA3q2N7ZWYHE0j6FlmSzWUHkk6A0kdkzflWa+w6C82O70DpdA18KjDNyd9eFA5sT6w/RAmLARDNT6BtQYaiun8VvBwf4MrXf0ShPEoKK6ZQACNjLvPC0GxrFHQvPMHDXlFSwC3PTbN/rFYkEQPjKT987a5Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623636; c=relaxed/simple;
	bh=4OyvMAmT35nZEvfXRhN5KzXQhsEHhw0SID5dqtvDjtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YkjNmSQOUtZuoMTzHaodWoX1vxpjUAHjJlbeHdl9IZ1jg9CPmDB09JkA1QCz+WLyJwdzZZVRynNK5iI/RfNuBGsSU24bvPpU8ILuF5DAC/nSqxq52ShtxIlWbUG3YKx4DF/Xki6W1DZANzfY616H/1fcionho3kJJO6mUGadPvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S/5vBlzm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42F81F000E9;
	Tue, 16 Jun 2026 15:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623634;
	bh=a2gADEBeXQ43toRYapGuKX0NvyiAmL1O5DpghQhEew0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S/5vBlzmxfWppXTC+TFtqgjpCmcdxuTDhoE+9mcdQTF6Mjv9FMtjK2GM56VDBkSja
	 XFyvslyt25DMNnlI9KL5OzxHhbuH3EojjsoQf58fRQbRtdFXMIJ31tga7M+gN5kZ8Y
	 nqewDBi46KeeygR+PmvEQ7Z7svoEVwc8TiBZwI7k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Tangudu Tilak Tirumalesh <tilak.tirumalesh.tangudu@intel.com>,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 7.0 187/378] Revert "drm/xe: Skip exec queue schedule toggle if queue is idle during suspend"
Date: Tue, 16 Jun 2026 20:26:58 +0530
Message-ID: <20260616145120.228063538@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264006-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:thomas.hellstrom@linux.intel.com,m:tilak.tirumalesh.tangudu@intel.com,m:daniele.ceraolospurio@intel.com,m:rodrigo.vivi@intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BB0E691274

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tangudu Tilak Tirumalesh <tilak.tirumalesh.tangudu@intel.com>

commit fa7c84726dc217ce0c183926ef9411636c7a2213 upstream.

This reverts commit 8533051ce92015e9cc6f75e0d52119b9d91610b6.

The idle-skip optimization bypasses GuC suspend, so the GPU may not
perform the context switch that flushes TLB entries for invalidated
userptr VMAs. In LR/preempt-fence VM mode, this can lead to missed TLB
invalidation and page faults during userptr invalidation tests.

Restore unconditional schedule toggling on suspend so the context-switch
TLB flush is always performed.

This optimization will be reintroduced with a fix that does not skip
suspend in LR/preempt-fence VM mode.

Fixes: 8533051ce920 ("drm/xe: Skip exec queue schedule toggle if queue is idle during suspend")
Cc: stable@vger.kernel.org # v7.0+
Suggested-by: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
Signed-off-by: Tangudu Tilak Tirumalesh <tilak.tirumalesh.tangudu@intel.com>
Reviewed-by: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
Signed-off-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Link: https://patch.msgid.link/20260603065217.3131066-2-tilak.tirumalesh.tangudu@intel.com
(cherry picked from commit 6a1e7934d9a6cf46aecae00a99c2603d1295e170)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/xe/xe_exec_queue.h      |   17 ---------
 drivers/gpu/drm/xe/xe_guc_submit.c      |   55 +-------------------------------
 drivers/gpu/drm/xe/xe_hw_engine_group.c |   10 +----
 3 files changed, 5 insertions(+), 77 deletions(-)

--- a/drivers/gpu/drm/xe/xe_exec_queue.h
+++ b/drivers/gpu/drm/xe/xe_exec_queue.h
@@ -161,21 +161,4 @@ int xe_exec_queue_contexts_hwsp_rebase(s
 
 struct xe_lrc *xe_exec_queue_lrc(struct xe_exec_queue *q);
 
-/**
- * xe_exec_queue_idle_skip_suspend() - Can exec queue skip suspend
- * @q: The exec_queue
- *
- * If an exec queue is not parallel and is idle, the suspend steps can be
- * skipped in the submission backend immediatley signaling the suspend fence.
- * Parallel queues cannot skip this step due to limitations in the submission
- * backend.
- *
- * Return: True if exec queue is idle and can skip suspend steps, False
- * otherwise
- */
-static inline bool xe_exec_queue_idle_skip_suspend(struct xe_exec_queue *q)
-{
-	return !xe_exec_queue_is_parallel(q) && xe_exec_queue_is_idle(q);
-}
-
 #endif
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -72,7 +72,6 @@ exec_queue_to_guc(struct xe_exec_queue *
 #define EXEC_QUEUE_STATE_WEDGED			(1 << 8)
 #define EXEC_QUEUE_STATE_BANNED			(1 << 9)
 #define EXEC_QUEUE_STATE_PENDING_RESUME		(1 << 10)
-#define EXEC_QUEUE_STATE_IDLE_SKIP_SUSPEND	(1 << 11)
 
 static bool exec_queue_registered(struct xe_exec_queue *q)
 {
@@ -224,21 +223,6 @@ static void clear_exec_queue_pending_res
 	atomic_and(~EXEC_QUEUE_STATE_PENDING_RESUME, &q->guc->state);
 }
 
-static bool exec_queue_idle_skip_suspend(struct xe_exec_queue *q)
-{
-	return atomic_read(&q->guc->state) & EXEC_QUEUE_STATE_IDLE_SKIP_SUSPEND;
-}
-
-static void set_exec_queue_idle_skip_suspend(struct xe_exec_queue *q)
-{
-	atomic_or(EXEC_QUEUE_STATE_IDLE_SKIP_SUSPEND, &q->guc->state);
-}
-
-static void clear_exec_queue_idle_skip_suspend(struct xe_exec_queue *q)
-{
-	atomic_and(~EXEC_QUEUE_STATE_IDLE_SKIP_SUSPEND, &q->guc->state);
-}
-
 static bool exec_queue_killed_or_banned_or_wedged(struct xe_exec_queue *q)
 {
 	return (atomic_read(&q->guc->state) &
@@ -1110,7 +1094,7 @@ static void submit_exec_queue(struct xe_
 	if (!job->restore_replay || job->last_replay) {
 		if (xe_exec_queue_is_parallel(q))
 			wq_item_append(q);
-		else if (!exec_queue_idle_skip_suspend(q))
+		else
 			xe_lrc_set_ring_tail(lrc, lrc->ring.tail);
 		job->last_replay = false;
 	}
@@ -1781,10 +1765,9 @@ static void __guc_exec_queue_process_msg
 {
 	struct xe_exec_queue *q = msg->private_data;
 	struct xe_guc *guc = exec_queue_to_guc(q);
-	bool idle_skip_suspend = xe_exec_queue_idle_skip_suspend(q);
 
-	if (!idle_skip_suspend && guc_exec_queue_allowed_to_change_state(q) &&
-	    !exec_queue_suspended(q) && exec_queue_enabled(q)) {
+	if (guc_exec_queue_allowed_to_change_state(q) && !exec_queue_suspended(q) &&
+	    exec_queue_enabled(q)) {
 		wait_event(guc->ct.wq, vf_recovery(guc) ||
 			   ((q->guc->resume_time != RESUME_PENDING ||
 			   xe_guc_read_stopped(guc)) && !exec_queue_pending_disable(q)));
@@ -1803,33 +1786,11 @@ static void __guc_exec_queue_process_msg
 			disable_scheduling(q, false);
 		}
 	} else if (q->guc->suspend_pending) {
-		if (idle_skip_suspend)
-			set_exec_queue_idle_skip_suspend(q);
 		set_exec_queue_suspended(q);
 		suspend_fence_signal(q);
 	}
 }
 
-static void sched_context(struct xe_exec_queue *q)
-{
-	struct xe_guc *guc = exec_queue_to_guc(q);
-	struct xe_lrc *lrc = q->lrc[0];
-	u32 action[] = {
-		XE_GUC_ACTION_SCHED_CONTEXT,
-		q->guc->id,
-	};
-
-	xe_gt_assert(guc_to_gt(guc), !xe_exec_queue_is_parallel(q));
-	xe_gt_assert(guc_to_gt(guc), !exec_queue_destroyed(q));
-	xe_gt_assert(guc_to_gt(guc), exec_queue_registered(q));
-	xe_gt_assert(guc_to_gt(guc), !exec_queue_pending_disable(q));
-
-	trace_xe_exec_queue_submit(q);
-
-	xe_lrc_set_ring_tail(lrc, lrc->ring.tail);
-	xe_guc_ct_send(&guc->ct, action, ARRAY_SIZE(action), 0, 0);
-}
-
 static void __guc_exec_queue_process_msg_resume(struct xe_sched_msg *msg)
 {
 	struct xe_exec_queue *q = msg->private_data;
@@ -1837,22 +1798,12 @@ static void __guc_exec_queue_process_msg
 	if (guc_exec_queue_allowed_to_change_state(q)) {
 		clear_exec_queue_suspended(q);
 		if (!exec_queue_enabled(q)) {
-			if (exec_queue_idle_skip_suspend(q)) {
-				struct xe_lrc *lrc = q->lrc[0];
-
-				clear_exec_queue_idle_skip_suspend(q);
-				xe_lrc_set_ring_tail(lrc, lrc->ring.tail);
-			}
 			q->guc->resume_time = RESUME_PENDING;
 			set_exec_queue_pending_resume(q);
 			enable_scheduling(q);
-		} else if (exec_queue_idle_skip_suspend(q)) {
-			clear_exec_queue_idle_skip_suspend(q);
-			sched_context(q);
 		}
 	} else {
 		clear_exec_queue_suspended(q);
-		clear_exec_queue_idle_skip_suspend(q);
 	}
 }
 
--- a/drivers/gpu/drm/xe/xe_hw_engine_group.c
+++ b/drivers/gpu/drm/xe/xe_hw_engine_group.c
@@ -207,21 +207,15 @@ static int xe_hw_engine_group_suspend_fa
 	lockdep_assert_held_write(&group->mode_sem);
 
 	list_for_each_entry(q, &group->exec_queue_list, hw_engine_group_link) {
-		bool idle_skip_suspend;
 
 		if (!xe_vm_in_fault_mode(q->vm))
 			continue;
 
-		idle_skip_suspend = xe_exec_queue_idle_skip_suspend(q);
-		if (!idle_skip_suspend && has_deps)
+		if (has_deps)
 			return -EAGAIN;
 
 		xe_gt_stats_incr(q->gt, XE_GT_STATS_ID_HW_ENGINE_GROUP_SUSPEND_LR_QUEUE_COUNT, 1);
-		if (idle_skip_suspend)
-			xe_gt_stats_incr(q->gt,
-					 XE_GT_STATS_ID_HW_ENGINE_GROUP_SKIP_LR_QUEUE_COUNT, 1);
-
-		need_resume |= !idle_skip_suspend;
+		need_resume = true;
 		q->ops->suspend(q);
 		gt = q->gt;
 	}



