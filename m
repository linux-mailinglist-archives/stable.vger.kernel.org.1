Return-Path: <stable+bounces-244424-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMFzJLtj+2kuaQMAu9opvQ
	(envelope-from <stable+bounces-244424-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 17:52:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1810A4DDA1C
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 17:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 553CE3011C6B
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 15:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C572E4963C4;
	Wed,  6 May 2026 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RgTwHiV6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RM8zTTlK"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4A03EDAA6;
	Wed,  6 May 2026 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778082723; cv=none; b=BfB4ktuP1RJ34D12nTHVdFvLSGmYgcAMTH2PECnAl4ONCzaMCqkHRpFW1DhAUA1Lh14RFWFibE6WHuVG2krxlu2Lp1qGOVh/iCZdGnc/j+2g8aOsOfN7BAuleL7kxz5/gHrjYmqZN2M0GVnT/c/DaBPL3J2DgqiU4Wwk/jxSeuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778082723; c=relaxed/simple;
	bh=IcXQ2+E1BzakmUciIcPVhFPKhOWTIPOEaYukzS1Sh+o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ec5v3aUyK+18vyCG9LKGEWH/bZsCYvpL1oxbTbxp4YJKeasM7k37FckYVPA1sRTR9zl9/ma0bzYWC9SMi6e71V6VjIv5ydkQmJ1D3MsQHThidn79hzeb3OH6G8M/7niqgcAZvXeWsGGbmQQgtKwQf+n0a1ZHbLSnJpTBfabgbec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RgTwHiV6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RM8zTTlK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 06 May 2026 15:51:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778082715;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nVwJSEp0WyUTHj5zeqY0lyVbboyDKMm0eObVgriGWYo=;
	b=RgTwHiV6cLvcCjzTOPSvzHATIf1GD6aWXsrH6/dQ5aj/x4MB2jw8WwA7NIkvIEHcRmX5qb
	JdS9DTY8oosuYKFiJ1EMJ85H/vY7d+enm5cL/HTTAW8SDwvbjzayiR5dGGd4evHa37jrWV
	5g/SlcYIzmjczAIkIH993E91r2abJ97d1VTSs3rQ6tTjKSdPCWOZDsPlno/VawAFJjUkRR
	gcogrZgtS3olHThs+ZGzqEgXI0poZrGu8muLlkh7DcXo4Ivzhnkt39NRFwq0SdmtYjqd+6
	ZI0Zg2lYWMRT8xFBZ/7RXRGaH9WQTVMK0897D33euS1v1mASQ/LnGXmk2r+5OA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778082715;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nVwJSEp0WyUTHj5zeqY0lyVbboyDKMm0eObVgriGWYo=;
	b=RM8zTTlKJf4opNa5mhVHnFd+tjNjYOHHTLBGe0/dP+/jshvawDIx5nmbPNvRuMYpRDm14b
	PpcJoSJp6u2pX+Aw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] rseq: Implement read only ABI enforcement for
 optimized RSEQ V2 mode
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dmitry Vyukov <dvyukov@google.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260428224427.845230956@kernel.org>
References: <20260428224427.845230956@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177808271392.424702.10111712244337696790.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1810A4DDA1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244424-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:replyto,infradead.org:email,linutronix.de:dkim]

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     82f572449cfe75f12ea985986da60e11f308f77d
Gitweb:        https://git.kernel.org/tip/82f572449cfe75f12ea985986da60e11f30=
8f77d
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Sun, 26 Apr 2026 16:21:02 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 06 May 2026 17:40:15 +02:00

rseq: Implement read only ABI enforcement for optimized RSEQ V2 mode

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
---
 include/linux/rseq_entry.h | 83 +++++++++++++------------------------
 include/linux/rseq_types.h |  4 +-
 kernel/rseq.c              |  5 +--
 3 files changed, 35 insertions(+), 57 deletions(-)

diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index 934db41..2d0295d 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -248,7 +248,6 @@ static __always_inline bool rseq_grant_slice_extension(un=
signed long ti_work, un
 #endif /* !CONFIG_RSEQ_SLICE_EXTENSION */
=20
 bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, =
unsigned long csaddr);
-bool rseq_debug_validate_ids(struct task_struct *t);
=20
 static __always_inline void rseq_note_user_irq_entry(void)
 {
@@ -368,43 +367,6 @@ efault:
 	return false;
 }
=20
-/*
- * On debug kernels validate that user space did not mess with it if the
- * debug branch is enabled.
- */
-bool rseq_debug_validate_ids(struct task_struct *t)
-{
-	struct rseq __user *rseq =3D t->rseq.usrptr;
-	u32 cpu_id, uval, node_id;
-
-	/*
-	 * On the first exit after registering the rseq region CPU ID is
-	 * RSEQ_CPU_ID_UNINITIALIZED and node_id in user space is 0!
-	 */
-	node_id =3D t->rseq.ids.cpu_id !=3D RSEQ_CPU_ID_UNINITIALIZED ?
-		  cpu_to_node(t->rseq.ids.cpu_id) : 0;
-
-	scoped_user_read_access(rseq, efault) {
-		unsafe_get_user(cpu_id, &rseq->cpu_id_start, efault);
-		if (cpu_id !=3D t->rseq.ids.cpu_id)
-			goto die;
-		unsafe_get_user(uval, &rseq->cpu_id, efault);
-		if (uval !=3D cpu_id)
-			goto die;
-		unsafe_get_user(uval, &rseq->node_id, efault);
-		if (uval !=3D node_id)
-			goto die;
-		unsafe_get_user(uval, &rseq->mm_cid, efault);
-		if (uval !=3D t->rseq.ids.mm_cid)
-			goto die;
-	}
-	return true;
-die:
-	t->rseq.event.fatal =3D true;
-efault:
-	return false;
-}
-
 #endif /* RSEQ_BUILD_SLOW_PATH */
=20
 /*
@@ -514,20 +476,32 @@ efault:
  * faults in task context are fatal too.
  */
 static rseq_inline
-bool rseq_set_ids_get_csaddr(struct task_struct *t, struct rseq_ids *ids,
-			     u32 node_id, u64 *csaddr)
+bool rseq_set_ids_get_csaddr(struct task_struct *t, struct rseq_ids *ids, u6=
4 *csaddr)
 {
 	struct rseq __user *rseq =3D t->rseq.usrptr;
=20
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
+			if (cpu_id !=3D t->rseq.ids.cpu_id)
+				goto die;
+			unsafe_get_user(uval, &rseq->cpu_id, efault);
+			if (uval !=3D cpu_id)
+				goto die;
+			unsafe_get_user(uval, &rseq->node_id, efault);
+			if (uval !=3D t->rseq.ids.node_id)
+				goto die;
+			unsafe_get_user(uval, &rseq->mm_cid, efault);
+			if (uval !=3D t->rseq.ids.mm_cid)
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
@@ -539,10 +513,13 @@ bool rseq_set_ids_get_csaddr(struct task_struct *t, str=
uct rseq_ids *ids,
=20
 	rseq_slice_clear_grant(t);
 	/* Cache the new values */
-	t->rseq.ids.cpu_cid =3D ids->cpu_cid;
+	t->rseq.ids =3D *ids;
 	rseq_stat_inc(rseq_stats.ids);
 	rseq_trace_update(t, ids);
 	return true;
+
+die:
+	t->rseq.event.fatal =3D true;
 efault:
 	return false;
 }
@@ -552,11 +529,11 @@ efault:
  * is in a critical section.
  */
 static rseq_inline bool rseq_update_usr(struct task_struct *t, struct pt_reg=
s *regs,
-					struct rseq_ids *ids, u32 node_id)
+					struct rseq_ids *ids)
 {
 	u64 csaddr;
=20
-	if (!rseq_set_ids_get_csaddr(t, ids, node_id, &csaddr))
+	if (!rseq_set_ids_get_csaddr(t, ids, &csaddr))
 		return false;
=20
 	/*
@@ -659,12 +636,12 @@ static __always_inline bool rseq_exit_user_update(struc=
t pt_regs *regs, struct t
 	}
=20
 	struct rseq_ids ids =3D {
-		.cpu_id =3D task_cpu(t),
-		.mm_cid =3D task_mm_cid(t),
+		.cpu_id	 =3D task_cpu(t),
+		.mm_cid	 =3D task_mm_cid(t),
+		.node_id =3D cpu_to_node(ids.cpu_id),
 	};
-	u32 node_id =3D cpu_to_node(ids.cpu_id);
=20
-	return rseq_update_usr(t, regs, &ids, node_id);
+	return rseq_update_usr(t, regs, &ids);
 efault:
 	return false;
 }
diff --git a/include/linux/rseq_types.h b/include/linux/rseq_types.h
index a469c18..85739a6 100644
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -66,8 +66,9 @@ struct rseq_event {
  *		compiler emit a single compare on 64-bit
  * @cpu_id:	The CPU ID which was written last to user space
  * @mm_cid:	The MM CID which was written last to user space
+ * @node_id:	The node ID which was written last to user space
  *
- * @cpu_id and @mm_cid are updated when the data is written to user space.
+ * @cpu_id, @mm_cid and @node_id are updated when the data is written to use=
r space.
  */
 struct rseq_ids {
 	union {
@@ -77,6 +78,7 @@ struct rseq_ids {
 			u32	mm_cid;
 		};
 	};
+	u32			node_id;
 };
=20
 /**
diff --git a/kernel/rseq.c b/kernel/rseq.c
index aa25753..1016120 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -263,7 +263,6 @@ static void rseq_slowpath_update_usr(struct pt_regs *regs)
 	};
 	struct task_struct *t =3D current;
 	struct rseq_ids ids;
-	u32 node_id;
 	bool event;
=20
 	if (unlikely(t->flags & PF_EXITING))
@@ -299,9 +298,9 @@ static void rseq_slowpath_update_usr(struct pt_regs *regs)
 	if (!event)
 		return;
=20
-	node_id =3D cpu_to_node(ids.cpu_id);
+	ids.node_id =3D cpu_to_node(ids.cpu_id);
=20
-	if (unlikely(!rseq_update_usr(t, regs, &ids, node_id))) {
+	if (unlikely(!rseq_update_usr(t, regs, &ids))) {
 		/*
 		 * Clear the errors just in case this might survive magically, but
 		 * leave the rest intact.

