Return-Path: <stable+bounces-242515-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPF2DvkB9WnAHAIAu9opvQ
	(envelope-from <stable+bounces-242515-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 21:41:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A42EF4AF3EF
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 21:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C783D303AE37
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 19:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA36426D2D;
	Fri,  1 May 2026 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PIGLwOc+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RbSUXeJu"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AFE423154;
	Fri,  1 May 2026 19:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777664428; cv=none; b=jxVOFBhqSMLMCNTWVDeM06wxGVV6q9Wghpjq9gSYtlQynDRFXPRGV9UU+cD99tVwfLT/x/uaWXMCQ6TaeHfc3HshPOC1wX6irnpuMB8K/wFSygtAn+oo5jp56I2XTV0Avg+sc0FOflA2qrrYP6S/IPEFzPM2FGIEUxLj8M9lhhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777664428; c=relaxed/simple;
	bh=bPDgOO35Kr2A4Hm6+ZMRz2RbmcCsTeAFuCYxV6T99j8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ksS+JiGAomLQxjhy+9NhorcKvXb8Xf+ofKopB2/Cx75Yor0+hb6zGfPPN7fRq83eLYR9vJ/nzR40kEB+s+w5wBMVYT1WlS+52BSRLO90BZb8qeBwWjXtCHyIVsJXb9Nk4Xt4P7H6dQJYNzvvQQh0eOyBU4tLz+vy/FSZOp2lRB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PIGLwOc+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RbSUXeJu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 01 May 2026 19:40:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777664420;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=JglCU+ecYqnH8BTNfbnTKKBlCG2vwDzV5m94e1KMyqo=;
	b=PIGLwOc+Z9IJKU7dgaiebDElGs53PidOJVyzjCRQ7vEQnUl16SXmo1Tf5tXj2hwx7ImDBr
	EhXDQihfq0qSDffvn/nnFW1WHcXJdMud7zo0pVv7S2rM36vkbE83ff2whlY40mRdPqG4C+
	sSyaAyg3/fc9whP4me/vciAU9ZRznk3nrsjEnHCIX2lsMdGSzMlfG8QYJ04y3tfDYrURhJ
	Dw0QXJwpTv6U5KsfAh9Lugcm7b28WEKAA6oExs7uNFgTSSGfKrLJbln9ANzEugWYX76ljS
	UX1qtZbQvyc2N4rHBm0bgZmB96VhaZsN1ixV9QvvPLaU/QdKsAZWw/3W4WS2FA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777664420;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=JglCU+ecYqnH8BTNfbnTKKBlCG2vwDzV5m94e1KMyqo=;
	b=RbSUXeJuye2MPOSWvntjcN3s6WHmeS4iuRaQ60Bf8+eUhbnAFredDkzQyGEgUVgAb4MVn9
	NPDlxG7/HUSe05AA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/urgent] rseq: Set rseq::cpu_id_start to 0 on unregistration
Cc: Dmitry Vyukov <dvyukov@google.com>, Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177766441866.3521451.3525943251128688603.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A42EF4AF3EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242515-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:dkim,infradead.org:email,msgid.link:url,vger.kernel.org:replyto]

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     2cb68e45120dfc66404c7547d95b8ac6ff0b25ce
Gitweb:        https://git.kernel.org/tip/2cb68e45120dfc66404c7547d95b8ac6ff0=
b25ce
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 28 Apr 2026 10:10:19 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 May 2026 21:32:20 +02:00

rseq: Set rseq::cpu_id_start to 0 on unregistration

The RSEQ rework changed that to RSEQ_CPU_UNINITILIZED, which is obviously
incompatible. Revert back to the original behavior.

Fixes: 0f085b41880e ("rseq: Provide and use rseq_set_ids()")
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Tested-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://patch.msgid.link/20260428224427.271566313%40kernel.org
Cc: stable@vger.kernel.org
---
 kernel/rseq.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index 38d3ef5..b9f1193 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -236,11 +236,6 @@ static int __init rseq_debugfs_init(void)
 }
 __initcall(rseq_debugfs_init);
=20
-static bool rseq_set_ids(struct task_struct *t, struct rseq_ids *ids, u32 no=
de_id)
-{
-	return rseq_set_ids_get_csaddr(t, ids, node_id, NULL);
-}
-
 static bool rseq_handle_cs(struct task_struct *t, struct pt_regs *regs)
 {
 	struct rseq __user *urseq =3D t->rseq.usrptr;
@@ -384,19 +379,22 @@ void rseq_syscall(struct pt_regs *regs)
=20
 static bool rseq_reset_ids(void)
 {
-	struct rseq_ids ids =3D {
-		.cpu_id		=3D RSEQ_CPU_ID_UNINITIALIZED,
-		.mm_cid		=3D 0,
-	};
+	struct rseq __user *rseq =3D current->rseq.usrptr;
=20
 	/*
 	 * If this fails, terminate it because this leaves the kernel in
 	 * stupid state as exit to user space will try to fixup the ids
 	 * again.
 	 */
-	if (rseq_set_ids(current, &ids, 0))
-		return true;
+	scoped_user_rw_access(rseq, efault) {
+		unsafe_put_user(0, &rseq->cpu_id_start, efault);
+		unsafe_put_user(RSEQ_CPU_ID_UNINITIALIZED, &rseq->cpu_id, efault);
+		unsafe_put_user(0, &rseq->node_id, efault);
+		unsafe_put_user(0, &rseq->mm_cid, efault);
+	}
+	return true;
=20
+efault:
 	force_sig(SIGSEGV);
 	return false;
 }

