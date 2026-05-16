Return-Path: <stable+bounces-249011-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4B5WAHSVCGoQwwMAu9opvQ
	(envelope-from <stable+bounces-249011-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 18:04:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5754D55C85B
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 18:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EDAA3009B22
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 16:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C0730C62D;
	Sat, 16 May 2026 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLV5pPKS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18557175A9A
	for <stable@vger.kernel.org>; Sat, 16 May 2026 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778947440; cv=none; b=SI+pC2GOnJ5zQYyGzJZsKswz63mg8GLPuwz2uJH9ixpy6UmmKFZIc6YrfLPX4/KoGQVRczsoiKVS9FEcZiIxCZvjf01f7zkN25senxyHcYbb0bhNjNuWmjb9KddifLU6a2IQrwEsstUFptM1mMsGrUvhNt3B3ziuJOpFHR84T0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778947440; c=relaxed/simple;
	bh=CNueQ6av6vb/Vzp8W1mNKKBHHt/ejH4dYcXnmuVKO7g=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=hHSakodJSq1pcPA2bgCP4UX+BQflmy5ScOxHBqNTnCLbTYQ5+jtraUUjiXJphv5K/CoHIQcM3NrtZs1GZVrao+z3vJ1emW3qYQhzSK7YmC+lGH683H4h07nCi6hn1FK4vgm4gJxnFEieqFxEu331dVJPhWWTTtVDqZWbEwElIjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLV5pPKS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A196C19425;
	Sat, 16 May 2026 16:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778947439;
	bh=CNueQ6av6vb/Vzp8W1mNKKBHHt/ejH4dYcXnmuVKO7g=;
	h=Date:From:To:Cc:Subject:References:From;
	b=hLV5pPKSo9wGRNXaB/OIlLuj1wTrBeUqp0YZNk82uRdTRw5sbMaPEJdPmVKCGVmAb
	 v0h3RLG/hfSim6FOGSBnWMkrU1/JYowjv+x9iVMkGrt3wAT6BxGqJIHtI4zuwbCjY+
	 pYVMx5Q6wYNyVJu6lGL3/G1iEL+3MqgnjYmzp4OEPyz2Mo0lq/4NZh3U/hhbb9Qxpy
	 yppTN9FbkD3LxGrPQICs4mVT+Grt8TiUCrTKDkmY9YUn4dwONuGrq88undLJsTDU8j
	 o83/walLQzBXWy605ZFKjp6+HqwdgVSTe+gFpLPjUAGD5988LQQLZTE5Q202h83fSX
	 phWGL6ZsS1egA==
Date: Sat, 16 May 2026 18:03:56 +0200
Message-ID: <20260516160322.966715026@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dmitry Vyukov <dvyukov@google.com>
Subject: [patch backport 7.0.y 2/3] rseq: Implement read only ABI enforcement
 for optimized RSEQ V2 mode
References: <20260516160138.835556923@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: 5754D55C85B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249011-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Thomas Gleixner <tglx@kernel.org>

commit 82f572449cfe75f12ea985986da60e11f308f77d upstream.

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
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Tested-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://patch.msgid.link/20260428224427.845230956%40kernel.org
Cc: stable@vger.kernel.org
---
 include/linux/rseq_entry.h |   83 ++++++++++++++++-----------------------------
 include/linux/rseq_types.h |    4 +-
 kernel/rseq.c              |    5 +-
 3 files changed, 35 insertions(+), 57 deletions(-)
---
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -238,7 +238,6 @@ static __always_inline bool rseq_grant_s
 #endif /* !CONFIG_RSEQ_SLICE_EXTENSION */
 
 bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long csaddr);
-bool rseq_debug_validate_ids(struct task_struct *t);
 
 static __always_inline void rseq_note_user_irq_entry(void)
 {
@@ -358,43 +357,6 @@ bool rseq_debug_update_user_cs(struct ta
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
@@ -504,20 +466,32 @@ rseq_update_user_cs(struct task_struct *
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
@@ -529,10 +503,13 @@ bool rseq_set_ids_get_csaddr(struct task
 
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
@@ -542,11 +519,11 @@ bool rseq_set_ids_get_csaddr(struct task
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
@@ -649,12 +626,12 @@ static __always_inline bool rseq_exit_us
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
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -263,7 +263,6 @@ static void rseq_slowpath_update_usr(str
 	};
 	struct task_struct *t = current;
 	struct rseq_ids ids;
-	u32 node_id;
 	bool event;
 
 	if (unlikely(t->flags & PF_EXITING))
@@ -299,9 +298,9 @@ static void rseq_slowpath_update_usr(str
 	if (!event)
 		return;
 
-	node_id = cpu_to_node(ids.cpu_id);
+	ids.node_id = cpu_to_node(ids.cpu_id);
 
-	if (unlikely(!rseq_update_usr(t, regs, &ids, node_id))) {
+	if (unlikely(!rseq_update_usr(t, regs, &ids))) {
 		/*
 		 * Clear the errors just in case this might survive magically, but
 		 * leave the rest intact.


