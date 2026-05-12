Return-Path: <stable+bounces-245585-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDRiDmsuA2qd1QEAu9opvQ
	(envelope-from <stable+bounces-245585-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:43:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0525217B9
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B10573402098
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A4E3905F4;
	Tue, 12 May 2026 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GaSdSXam"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05993905E7
	for <stable@vger.kernel.org>; Tue, 12 May 2026 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592376; cv=none; b=FZYP6Cn2b+DjCROga2SE8q6cuXt0IICrYIlGjy8qIrEcgg1JWo9sebxdhS9e/lwDM2Kce0WkJJ+a4GyRrsO/8RYCraWzYoe+B8gjug4Tt2S/H3BlSljLGRF3HV220FTinPQQxaEI3XEVyjMt+tILhWaEmJd38R+WJCdSYEFnDaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592376; c=relaxed/simple;
	bh=CRoSmzukT56FsN2twGxiidKXFuEEPa7fYJVpH2Swt2c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ML3dpSYJ50yXlulNh4jKpZpwDYJ6AKTE3F6JiIQ8YlFrwN2IqGUW7DFnnSTrqT35hxKeerq6IiJgBhAQJNkKyaCcSGLoj2d3BXC7VzAScxHR1HZQJbBoGVsLXyRVnLM4golrPlabCjhowcZJ7z4jc92skCxlfKjsi9mui1Q0000=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GaSdSXam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C3AC2BCF7;
	Tue, 12 May 2026 13:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778592376;
	bh=CRoSmzukT56FsN2twGxiidKXFuEEPa7fYJVpH2Swt2c=;
	h=Subject:To:Cc:From:Date:From;
	b=GaSdSXam0POPkEsMVv1m2bHuqgfds7blk9PLnhfLogJWYwaZwtadNlajI6/Amkdly
	 1N+nw+blMoTvgCbqE8tWq0rxgnnCZvRNasHe4uTk65tqEtOdIoqTS0XzBaRzkdhenn
	 9vMKI6vswl3dVugyF0mH+NX4cBRCVoAh4VJBni5A=
Subject: FAILED: patch "[PATCH] rseq: Implement read only ABI enforcement for optimized RSEQ" failed to apply to 7.0-stable tree
To: tglx@kernel.org,dvyukov@google.com,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 15:26:21 +0200
Message-ID: <2026051221-railroad-uncork-42ad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8F0525217B9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245585-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,linuxfoundation.org:dkim,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x 82f572449cfe75f12ea985986da60e11f308f77d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051221-railroad-uncork-42ad@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 82f572449cfe75f12ea985986da60e11f308f77d Mon Sep 17 00:00:00 2001
From: Thomas Gleixner <tglx@kernel.org>
Date: Sun, 26 Apr 2026 16:21:02 +0200
Subject: [PATCH] rseq: Implement read only ABI enforcement for optimized RSEQ
 V2 mode

The optimized RSEQ V2 mode requires that user space adheres to the ABI
specification and does not modify the read-only fields cpu_id_start,
cpu_id, node_id and mm_cid behind the kernel's back.

While the kernel does not rely on these fields, the adherence to this is a
fundamental prerequisite to allow multiple entities, e.g. libraries, in an
application to utilize the full potential of RSEQ without stepping on each
other toes.

Validate this adherence on every update of these fields. If the kernel
detects that user space modified the fields, the application is force
terminated.

Fixes: d6200245c75e ("rseq: Allow registering RSEQ with slice extension")
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Tested-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://patch.msgid.link/20260428224427.845230956%40kernel.org
Cc: stable@vger.kernel.org

diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index 934db41ec782..2d0295df5107 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -248,7 +248,6 @@ static __always_inline bool rseq_grant_slice_extension(unsigned long ti_work, un
 #endif /* !CONFIG_RSEQ_SLICE_EXTENSION */
 
 bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long csaddr);
-bool rseq_debug_validate_ids(struct task_struct *t);
 
 static __always_inline void rseq_note_user_irq_entry(void)
 {
@@ -368,43 +367,6 @@ bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs,
 	return false;
 }
 
-/*
- * On debug kernels validate that user space did not mess with it if the
- * debug branch is enabled.
- */
-bool rseq_debug_validate_ids(struct task_struct *t)
-{
-	struct rseq __user *rseq = t->rseq.usrptr;
-	u32 cpu_id, uval, node_id;
-
-	/*
-	 * On the first exit after registering the rseq region CPU ID is
-	 * RSEQ_CPU_ID_UNINITIALIZED and node_id in user space is 0!
-	 */
-	node_id = t->rseq.ids.cpu_id != RSEQ_CPU_ID_UNINITIALIZED ?
-		  cpu_to_node(t->rseq.ids.cpu_id) : 0;
-
-	scoped_user_read_access(rseq, efault) {
-		unsafe_get_user(cpu_id, &rseq->cpu_id_start, efault);
-		if (cpu_id != t->rseq.ids.cpu_id)
-			goto die;
-		unsafe_get_user(uval, &rseq->cpu_id, efault);
-		if (uval != cpu_id)
-			goto die;
-		unsafe_get_user(uval, &rseq->node_id, efault);
-		if (uval != node_id)
-			goto die;
-		unsafe_get_user(uval, &rseq->mm_cid, efault);
-		if (uval != t->rseq.ids.mm_cid)
-			goto die;
-	}
-	return true;
-die:
-	t->rseq.event.fatal = true;
-efault:
-	return false;
-}
-
 #endif /* RSEQ_BUILD_SLOW_PATH */
 
 /*
@@ -514,20 +476,32 @@ rseq_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long c
  * faults in task context are fatal too.
  */
 static rseq_inline
-bool rseq_set_ids_get_csaddr(struct task_struct *t, struct rseq_ids *ids,
-			     u32 node_id, u64 *csaddr)
+bool rseq_set_ids_get_csaddr(struct task_struct *t, struct rseq_ids *ids, u64 *csaddr)
 {
 	struct rseq __user *rseq = t->rseq.usrptr;
 
-	if (static_branch_unlikely(&rseq_debug_enabled)) {
-		if (!rseq_debug_validate_ids(t))
-			return false;
-	}
-
 	scoped_user_rw_access(rseq, efault) {
+		/* Validate the R/O fields for debug and optimized mode */
+		if (static_branch_unlikely(&rseq_debug_enabled) || rseq_v2(t)) {
+			u32 cpu_id, uval;
+
+			unsafe_get_user(cpu_id, &rseq->cpu_id_start, efault);
+			if (cpu_id != t->rseq.ids.cpu_id)
+				goto die;
+			unsafe_get_user(uval, &rseq->cpu_id, efault);
+			if (uval != cpu_id)
+				goto die;
+			unsafe_get_user(uval, &rseq->node_id, efault);
+			if (uval != t->rseq.ids.node_id)
+				goto die;
+			unsafe_get_user(uval, &rseq->mm_cid, efault);
+			if (uval != t->rseq.ids.mm_cid)
+				goto die;
+		}
+
 		unsafe_put_user(ids->cpu_id, &rseq->cpu_id_start, efault);
 		unsafe_put_user(ids->cpu_id, &rseq->cpu_id, efault);
-		unsafe_put_user(node_id, &rseq->node_id, efault);
+		unsafe_put_user(ids->node_id, &rseq->node_id, efault);
 		unsafe_put_user(ids->mm_cid, &rseq->mm_cid, efault);
 		if (csaddr)
 			unsafe_get_user(*csaddr, &rseq->rseq_cs, efault);
@@ -539,10 +513,13 @@ bool rseq_set_ids_get_csaddr(struct task_struct *t, struct rseq_ids *ids,
 
 	rseq_slice_clear_grant(t);
 	/* Cache the new values */
-	t->rseq.ids.cpu_cid = ids->cpu_cid;
+	t->rseq.ids = *ids;
 	rseq_stat_inc(rseq_stats.ids);
 	rseq_trace_update(t, ids);
 	return true;
+
+die:
+	t->rseq.event.fatal = true;
 efault:
 	return false;
 }
@@ -552,11 +529,11 @@ bool rseq_set_ids_get_csaddr(struct task_struct *t, struct rseq_ids *ids,
  * is in a critical section.
  */
 static rseq_inline bool rseq_update_usr(struct task_struct *t, struct pt_regs *regs,
-					struct rseq_ids *ids, u32 node_id)
+					struct rseq_ids *ids)
 {
 	u64 csaddr;
 
-	if (!rseq_set_ids_get_csaddr(t, ids, node_id, &csaddr))
+	if (!rseq_set_ids_get_csaddr(t, ids, &csaddr))
 		return false;
 
 	/*
@@ -659,12 +636,12 @@ static __always_inline bool rseq_exit_user_update(struct pt_regs *regs, struct t
 	}
 
 	struct rseq_ids ids = {
-		.cpu_id = task_cpu(t),
-		.mm_cid = task_mm_cid(t),
+		.cpu_id	 = task_cpu(t),
+		.mm_cid	 = task_mm_cid(t),
+		.node_id = cpu_to_node(ids.cpu_id),
 	};
-	u32 node_id = cpu_to_node(ids.cpu_id);
 
-	return rseq_update_usr(t, regs, &ids, node_id);
+	return rseq_update_usr(t, regs, &ids);
 efault:
 	return false;
 }
diff --git a/include/linux/rseq_types.h b/include/linux/rseq_types.h
index a469c1870849..85739a63e85e 100644
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -66,8 +66,9 @@ struct rseq_event {
  *		compiler emit a single compare on 64-bit
  * @cpu_id:	The CPU ID which was written last to user space
  * @mm_cid:	The MM CID which was written last to user space
+ * @node_id:	The node ID which was written last to user space
  *
- * @cpu_id and @mm_cid are updated when the data is written to user space.
+ * @cpu_id, @mm_cid and @node_id are updated when the data is written to user space.
  */
 struct rseq_ids {
 	union {
@@ -77,6 +78,7 @@ struct rseq_ids {
 			u32	mm_cid;
 		};
 	};
+	u32			node_id;
 };
 
 /**
diff --git a/kernel/rseq.c b/kernel/rseq.c
index aa25753ea135..101612027f6a 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -263,7 +263,6 @@ static void rseq_slowpath_update_usr(struct pt_regs *regs)
 	};
 	struct task_struct *t = current;
 	struct rseq_ids ids;
-	u32 node_id;
 	bool event;
 
 	if (unlikely(t->flags & PF_EXITING))
@@ -299,9 +298,9 @@ static void rseq_slowpath_update_usr(struct pt_regs *regs)
 	if (!event)
 		return;
 
-	node_id = cpu_to_node(ids.cpu_id);
+	ids.node_id = cpu_to_node(ids.cpu_id);
 
-	if (unlikely(!rseq_update_usr(t, regs, &ids, node_id))) {
+	if (unlikely(!rseq_update_usr(t, regs, &ids))) {
 		/*
 		 * Clear the errors just in case this might survive magically, but
 		 * leave the rest intact.


