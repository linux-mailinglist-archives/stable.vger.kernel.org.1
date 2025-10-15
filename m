Return-Path: <stable+bounces-185791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA35BDE0F8
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 12:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF8F3A47C7
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 10:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AAC3176EE;
	Wed, 15 Oct 2025 10:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TGe2/vBj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EB42E2DCB
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 10:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524806; cv=none; b=XwKXc+WzRmAwXNZP6zngHlrKaT7zVIotSM/JIdELBaq0oMROU0GL2oYq4fXddNBo7Tv//HpVySEeKkSyK/Iudzi99xT6pS0QaR/HLVP0kFqW9RQLNkt+jJJUejI9VZuuUH8EBm8CD/eGpj9OFub/36i6pZwF0BPVhYHP8NuQ2vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524806; c=relaxed/simple;
	bh=GzWyDmhQoBHg6jhVlQgtVYuWIWnqFg2sO+QLwbqmrdY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=skzdzu+16ay/0wL1+JrAFq1ByphuOJ38VBCkjsKu4nKFaYzfA2etP8brl/xFqFMoqBqqj2B1V5g4Q273GscKejhEIVU7eHUQS8ytZKV0AK2h9oxByF2eBE7O+SJslqQPzNi0GyKiAX9N+pE7HMXOGaBZrSMKEAJv92UzfDgBwD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TGe2/vBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DA3C4CEF8;
	Wed, 15 Oct 2025 10:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760524806;
	bh=GzWyDmhQoBHg6jhVlQgtVYuWIWnqFg2sO+QLwbqmrdY=;
	h=Subject:To:Cc:From:Date:From;
	b=TGe2/vBjhwKKEvrTq7QN2xzqoJjUfIXgZLYZbGTGwIJM6tQ+I0uDN5n/6SD2+9Ty+
	 7h2/+LTcfDUv2TvbICBLrv7inVaWzPCK0bzpv0ANscCgFAycEwKPS+SXj1H+Gi/DPr
	 9Oncg0Vs3Ec5G0P1wBObtIv7uVd8v6GAOsBislm8=
Subject: FAILED: patch "[PATCH] rseq: Protect event mask against membarrier IPI" failed to apply to 6.1-stable tree
To: tglx@linutronix.de,boqun.feng@gmail.com,mathieu.desnoyers@efficios.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Oct 2025 12:39:55 +0200
Message-ID: <2025101555-untitled-sighing-27f5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6eb350a2233100a283f882c023e5ad426d0ed63b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101555-untitled-sighing-27f5@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6eb350a2233100a283f882c023e5ad426d0ed63b Mon Sep 17 00:00:00 2001
From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 13 Aug 2025 17:02:30 +0200
Subject: [PATCH] rseq: Protect event mask against membarrier IPI

rseq_need_restart() reads and clears task::rseq_event_mask with preemption
disabled to guard against the scheduler.

But membarrier() uses an IPI and sets the PREEMPT bit in the event mask
from the IPI, which leaves that RMW operation unprotected.

Use guard(irq) if CONFIG_MEMBARRIER is enabled to fix that.

Fixes: 2a36ab717e8f ("rseq/membarrier: Add MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: stable@vger.kernel.org

diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index bc8af3eb5598..1fbeb61babeb 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -7,6 +7,12 @@
 #include <linux/preempt.h>
 #include <linux/sched.h>
 
+#ifdef CONFIG_MEMBARRIER
+# define RSEQ_EVENT_GUARD	irq
+#else
+# define RSEQ_EVENT_GUARD	preempt
+#endif
+
 /*
  * Map the event mask on the user-space ABI enum rseq_cs_flags
  * for direct mask checks.
@@ -41,9 +47,8 @@ static inline void rseq_handle_notify_resume(struct ksignal *ksig,
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
 
diff --git a/kernel/rseq.c b/kernel/rseq.c
index b7a1ec327e81..2452b7366b00 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -342,12 +342,12 @@ static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
 
 	/*
 	 * Load and clear event mask atomically with respect to
-	 * scheduler preemption.
+	 * scheduler preemption and membarrier IPIs.
 	 */
-	preempt_disable();
-	event_mask = t->rseq_event_mask;
-	t->rseq_event_mask = 0;
-	preempt_enable();
+	scoped_guard(RSEQ_EVENT_GUARD) {
+		event_mask = t->rseq_event_mask;
+		t->rseq_event_mask = 0;
+	}
 
 	return !!event_mask;
 }


