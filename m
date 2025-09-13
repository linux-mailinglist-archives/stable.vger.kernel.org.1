Return-Path: <stable+bounces-179513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BCBB5626E
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 19:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 748D2487C7C
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 17:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF0F212568;
	Sat, 13 Sep 2025 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Il2Fuzf5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hBX3S+Wd"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF95B1F8755;
	Sat, 13 Sep 2025 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757786289; cv=none; b=cPH8D47QWjFHX+QV2WRtWd+LWTkmKJH2DhDfIi4+H9ZAV5n82ThYfJSN+b6SJTLUaHNcbRuHxy0YedYFH5LL0jIQ2wRntQNEi7H7FF+Hwnc0sSl4599I5ajSmjRsVZrIzwPamYKIspJ9HXXPHxCcwRlPBof7zQrbpLur175sNe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757786289; c=relaxed/simple;
	bh=2LZvUgz0+ujuD7Av7wfeuscl1IarReSY88YOPWk5770=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OBX1UPUL/DnHMv7vy/+vBP3x2NyX06h/2ALJgc1J/V97SJ7G1LpgtZ601RchmgxBjmFC/Qr78fv348TdbNkjAonP61XeSuMOCEMTHXnp3uqOF0+xxyo5st4J1ZlTO7C2uX3xTX+3IvlHPJylJGmihlt+WhEeIr9s097u33UlwP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Il2Fuzf5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hBX3S+Wd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Sep 2025 17:57:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757786278;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uoq7m//PTGreKxasKT+FkkfsHv7zRWFK64rf3auJEzI=;
	b=Il2Fuzf52sS3HevGLIJ8d3Ynlr9PFqRjiaLW9LaxBCPyfLVbrQbKFtfJLGPMJpoMFGY8ud
	QKIYh3tiz34MVxDGSUFmjSkY+H78DdN8iYCXvP461NJEDvj1QuUu7tdBIiJSn6f4qk9/tF
	rY+EtR2T+pUbXYqprX5V3+22wHTOTunrHaQ1hmrRwZFYUF3m+FLs0aVXS5kjUnUWNzz3cW
	mboSTZo68oo1Zxy5TegtK97gRRONQF484MdaUJ9TIoGNWbFaMtetMJazAmJooI56jIg+Jw
	wbszVijBwbvDHEcxXFXXyHBuNiJ6ppCMIoVdLSJSDgzlKOAE4PPWRvExmP3zkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757786278;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uoq7m//PTGreKxasKT+FkkfsHv7zRWFK64rf3auJEzI=;
	b=hBX3S+WdVri1fSGGGRilXBbDnco4z8sGw9wlKLj45F9UL97RZBZsAaUeAnntrvHYRJ/uWE
	AH4eD36rk2oIyIBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Protect event mask against membarrier IPI
Cc: Thomas Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <87o6sj6z95.ffs@tglx>
References: <87o6sj6z95.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175778627751.709179.2586417410168504568.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     6eb350a2233100a283f882c023e5ad426d0ed63b
Gitweb:        https://git.kernel.org/tip/6eb350a2233100a283f882c023e5ad426d0=
ed63b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Aug 2025 17:02:30 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 13 Sep 2025 19:51:59 +02:00

rseq: Protect event mask against membarrier IPI

rseq_need_restart() reads and clears task::rseq_event_mask with preemption
disabled to guard against the scheduler.

But membarrier() uses an IPI and sets the PREEMPT bit in the event mask
from the IPI, which leaves that RMW operation unprotected.

Use guard(irq) if CONFIG_MEMBARRIER is enabled to fix that.

Fixes: 2a36ab717e8f ("rseq/membarrier: Add MEMBARRIER_CMD_PRIVATE_EXPEDITED_R=
SEQ")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: stable@vger.kernel.org
---
 include/linux/rseq.h | 11 ++++++++---
 kernel/rseq.c        | 10 +++++-----
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index bc8af3e..1fbeb61 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -7,6 +7,12 @@
 #include <linux/preempt.h>
 #include <linux/sched.h>
=20
+#ifdef CONFIG_MEMBARRIER
+# define RSEQ_EVENT_GUARD	irq
+#else
+# define RSEQ_EVENT_GUARD	preempt
+#endif
+
 /*
  * Map the event mask on the user-space ABI enum rseq_cs_flags
  * for direct mask checks.
@@ -41,9 +47,8 @@ static inline void rseq_handle_notify_resume(struct ksignal=
 *ksig,
 static inline void rseq_signal_deliver(struct ksignal *ksig,
 				       struct pt_regs *regs)
 {
-	preempt_disable();
-	__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
-	preempt_enable();
+	scoped_guard(RSEQ_EVENT_GUARD)
+		__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
 	rseq_handle_notify_resume(ksig, regs);
 }
=20
diff --git a/kernel/rseq.c b/kernel/rseq.c
index b7a1ec3..2452b73 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -342,12 +342,12 @@ static int rseq_need_restart(struct task_struct *t, u32=
 cs_flags)
=20
 	/*
 	 * Load and clear event mask atomically with respect to
-	 * scheduler preemption.
+	 * scheduler preemption and membarrier IPIs.
 	 */
-	preempt_disable();
-	event_mask =3D t->rseq_event_mask;
-	t->rseq_event_mask =3D 0;
-	preempt_enable();
+	scoped_guard(RSEQ_EVENT_GUARD) {
+		event_mask =3D t->rseq_event_mask;
+		t->rseq_event_mask =3D 0;
+	}
=20
 	return !!event_mask;
 }

