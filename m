Return-Path: <stable+bounces-242511-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFKWNcYB9WmYHAIAu9opvQ
	(envelope-from <stable+bounces-242511-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 21:40:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7BF4AF3BA
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 21:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F1F03023E0E
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 19:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C510B423A81;
	Fri,  1 May 2026 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zfDq2pP4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vFcbuU34"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8250421F18;
	Fri,  1 May 2026 19:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777664422; cv=none; b=cJBH5N1q/SfL64UxR+f47q3mi7I+0TOmulivvblmZA5CfhQb3sxRugr+Nd1SXomIO8OUQSKNutE+5Fx1iGOLjAys6oRxF45OUDFwINFIW3113Ntyt1CrikpUpstCmgHo3pKrUdxS9rU34Pt14E46Hw3fQk65uCTRzbe38NDPbi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777664422; c=relaxed/simple;
	bh=wJ6WRpVSUgVR7oexSJ6szV/Ws9XKm/Pqc7smBUYBZKU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=BDuqFHgZsv11R1o/RwwkcVYTPxmFKWDC7BK3INRTCI65cx2Qfh2L4lyK6Eyy6Syg8G7p4ThT1cHR/BvXPpImqdIEjaRg1EnVeAuCA95ezhJNkfWUu0xlDSHeHz+IeHDcVawq3PstBJe5c5sO8e5JnqVRHVvy6Hg88TLr3CXmesE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zfDq2pP4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vFcbuU34; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 01 May 2026 19:40:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777664418;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=jVlbZ8Tjfm2FmysIL31u1osJtQgBaoOAZc1dK9h5Ii4=;
	b=zfDq2pP4P7JT+ByQeYs51psygzsNJKtiehNN3I3O4s68Q1FPk0x+kMhIbPhCTHA+998dR9
	4jNM3H0+aEHEoFnZaUZ1ZveTcuzhYb+UutWzcBXM2o31j/aNx3gCO3pl0w0Qb9P6RaPRmO
	zhiXmD+YOUJLoeqR0GMxdOPQvdEZvSm/IJQNK0kFtFRfM6RhOPCVRqV0MPkqPhChWoldCC
	g723UaypwixqiH7sZc51emJzTv1r5a9otw0+ol3xAaIIQU1C8RTMkns3usQSc/2XwWS3Zi
	KX7jzGubBso6juNH8nHuOV6vrPmIqMKqWhESRHzNtAdOiFiIx7236HQ/xosDfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777664418;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=jVlbZ8Tjfm2FmysIL31u1osJtQgBaoOAZc1dK9h5Ii4=;
	b=vFcbuU34daEqB1veOF1EoonSNKDJZKU6qLTpbHpMnGL5olMCfSVVplA8LhDy8lq1QXIr1S
	L0s+5NP4+tx060Cw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] rseq: Protect rseq_reset() against interrupts
Cc: Dmitry Vyukov <dvyukov@google.com>, Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177766441737.3521451.7725340476474981912.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5A7BF4AF3BA
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
	TAGGED_FROM(0.00)[bounces-242511-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:dkim,infradead.org:email,vger.kernel.org:replyto,msgid.link:url]

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     e9766e6f7d330dce7530918d8c6e3ec96d6c6e24
Gitweb:        https://git.kernel.org/tip/e9766e6f7d330dce7530918d8c6e3ec96d6=
c6e24
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 28 Apr 2026 10:14:41 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 May 2026 21:32:20 +02:00

rseq: Protect rseq_reset() against interrupts

rseq_reset() uses memset() to clear the tasks rseq data. That's racy
against membarrier() and preemption.

Guard it with irqsave to cure this.

Fixes: faba9d250eae ("rseq: Introduce struct rseq_data")
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Tested-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://patch.msgid.link/20260428224427.353887714%40kernel.org
Cc: stable@vger.kernel.org
---
 include/linux/rseq.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index b9d62fc..f446909 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -119,6 +119,8 @@ static inline void rseq_virt_userspace_exit(void)
=20
 static inline void rseq_reset(struct task_struct *t)
 {
+	/* Protect against preemption and membarrier IPI */
+	guard(irqsave)();
 	memset(&t->rseq, 0, sizeof(t->rseq));
 	t->rseq.ids.cpu_id =3D RSEQ_CPU_ID_UNINITIALIZED;
 }

