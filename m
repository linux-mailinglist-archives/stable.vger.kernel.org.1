Return-Path: <stable+bounces-244160-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAqVOlL9+WkqFwMAu9opvQ
	(envelope-from <stable+bounces-244160-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 16:23:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 404664CF529
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 16:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3706D309197E
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 14:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0F5480DC9;
	Tue,  5 May 2026 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mjXWmkQp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4qgklIjS"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F4F48094B;
	Tue,  5 May 2026 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777990419; cv=none; b=Vj3qGP4w8p4s+XOjsw49aZbHbNkLesJXP2I9A1KYK7eK0ubViewXO1KI/QrA57GoJ40Tz5UxVru7ILGEs/RC8JP/0h3U2A4oDFN/f4sgVJgDYNb71aElVSzdMtOo9yubV09ReeQl/QjsWt2W3EFL4850ND5dh2k+yuuWXc0OIdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777990419; c=relaxed/simple;
	bh=cS9UQ2LE7gyq+pKPhW/92Qkg7TAmjnc9knsajJ3GfHQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TtFaJl5iQiQlbHr7UKX4tT5pObpGEQLXEuekWA2crjd8Dsm+lpAXDJk0j373jF4+smuz6lIjjPc7KKlVpdSW/nDg6xrG6RLKF+p/ZFSgWozd4qtV5u5k76GHqWe5gC2/hadrMm9KMUG824//zhmSx+LL+HZDTOEhempzJIBa1qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mjXWmkQp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4qgklIjS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 05 May 2026 14:13:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777990416;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sXK9sfh74wTOx4op38UNS/5dvNksMDwGVQrqKFifrUM=;
	b=mjXWmkQpQbF6bs+A3hkTKbofqq1Qms+u+42tIEqRJXQYKsbxihLFaZtoadueG6Rn3zx9ZK
	bAALDkXWvMQSj8g+PikoYKFY9ltT+xRVsij8OiMbOOqdkoSdJ4jIXdhlEEPOtq/OMfvybH
	ju0k9oRHJWhFEjsfutDhoM7bzR7ffdHEpi8ptitb0hvH5R0i+fRZe5rj1Jkt3Q4aKaVLTY
	0fRzO5zBHAK8eiL8/lk6A4hciBmnvTckV0fnpLc+d6KTiAv2jAO+xNpxJharMbFBvNKK4s
	rz46iOp/DhrCbRdei2iHZUzkZwRhCIs660Yu2hyGbYpvPYAUxZRQKM6UK6dE+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777990416;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sXK9sfh74wTOx4op38UNS/5dvNksMDwGVQrqKFifrUM=;
	b=4qgklIjSxfNHAzawUxcNZrW3yrMHLg6h1E/445fnCEufAx4vOhg+XQ1h9n8/hkufDRe92y
	zvLTLG+iFeX6q3Dg==
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
Message-ID: <177799041465.424702.1139943311887662662.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 404664CF529
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
	TAGGED_FROM(0.00)[bounces-244160-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linutronix.de:dkim,infradead.org:email]

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     867d5e3305886b78109e68983783a8688341ec31
Gitweb:        https://git.kernel.org/tip/867d5e3305886b78109e68983783a868834=
1ec31
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Sun, 26 Apr 2026 16:21:02 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 May 2026 16:03:11 +02:00

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
 include/linux/rseq_entry.h | 71 ++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 43 deletions(-)

diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index 934db41..fde12cf 100644
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
@@ -519,12 +481,32 @@ bool rseq_set_ids_get_csaddr(struct task_struct *t, str=
uct rseq_ids *ids,
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
+			u32 cpu_id, uval, node_id;
+
+			/*
+			 * On the first exit after registering the rseq region CPU ID is
+			 * RSEQ_CPU_ID_UNINITIALIZED and node_id in user space is 0!
+			 */
+			node_id =3D t->rseq.ids.cpu_id !=3D RSEQ_CPU_ID_UNINITIALIZED ?
+				cpu_to_node(t->rseq.ids.cpu_id) : 0;
+
+			unsafe_get_user(cpu_id, &rseq->cpu_id_start, efault);
+			if (cpu_id !=3D t->rseq.ids.cpu_id)
+				goto die;
+			unsafe_get_user(uval, &rseq->cpu_id, efault);
+			if (uval !=3D cpu_id)
+				goto die;
+			unsafe_get_user(uval, &rseq->node_id, efault);
+			if (uval !=3D node_id)
+				goto die;
+			unsafe_get_user(uval, &rseq->mm_cid, efault);
+			if (uval !=3D t->rseq.ids.mm_cid)
+				goto die;
+		}
+
 		unsafe_put_user(ids->cpu_id, &rseq->cpu_id_start, efault);
 		unsafe_put_user(ids->cpu_id, &rseq->cpu_id, efault);
 		unsafe_put_user(node_id, &rseq->node_id, efault);
@@ -543,6 +525,9 @@ bool rseq_set_ids_get_csaddr(struct task_struct *t, struc=
t rseq_ids *ids,
 	rseq_stat_inc(rseq_stats.ids);
 	rseq_trace_update(t, ids);
 	return true;
+
+die:
+	t->rseq.event.fatal =3D true;
 efault:
 	return false;
 }

