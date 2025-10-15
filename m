Return-Path: <stable+bounces-185790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11898BDE0EF
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 12:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C12094E3FAD
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 10:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3C12E2DCB;
	Wed, 15 Oct 2025 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I7eYAMlW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5691A5BA2
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524798; cv=none; b=kx3nTaoNDW+0W6sfWfZbDycHpuDq9CT0By43pBMA4foiqHWv+w5KNxjaJUYIx5+lcUddZbt94iKB4fozj51Erhyd+oLvaCW/Av3plz504Y+P8L2vzNQ+rbX7OktlO3YvUihfMjIjzK+YN0uuh7Zyg3jVhU0UeR6jE4DgOqe+VTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524798; c=relaxed/simple;
	bh=p7gOyZ//x9REMtcrHjX/JMdnAR/De4CIZgHL9y5+/9w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VBmZymOuVr335H42cM7Ie6ILv0U6AxRjFGAHHdjMNdDKurqvTYrr/ty+UvMQlF7J55mzdbbZnL8tx2RLyag8BScI1+yM+mmFh4w23CUXXiWgedWEkkMJ+65G7kjfJIwFDhzAl8EI94SeeZyIuV1gMRtFVNXSjRr70ADXYOB4H/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I7eYAMlW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73439C4CEF8;
	Wed, 15 Oct 2025 10:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760524797;
	bh=p7gOyZ//x9REMtcrHjX/JMdnAR/De4CIZgHL9y5+/9w=;
	h=Subject:To:Cc:From:Date:From;
	b=I7eYAMlWLxlCYVJZutXiyfscs58lZ9oyy2uz+slqRwz0waY7AR/kbqcKkZxv9xWQT
	 JHAJvkdVQwR6hChU4PZoh+Mq5Pbvwt4diS2EihRmpz276zipWBpj62TLkY9FYXHflf
	 X9hpD5tICcDnTutsFiWgXEIbOuBoBgFAMC3dTy+Y=
Subject: FAILED: patch "[PATCH] rseq: Protect event mask against membarrier IPI" failed to apply to 6.6-stable tree
To: tglx@linutronix.de,boqun.feng@gmail.com,mathieu.desnoyers@efficios.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Oct 2025 12:39:55 +0200
Message-ID: <2025101555-glimpse-gauntlet-5c2a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6eb350a2233100a283f882c023e5ad426d0ed63b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101555-glimpse-gauntlet-5c2a@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


