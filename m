Return-Path: <stable+bounces-186009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E27BE3359
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B833A4F3B49
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 11:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2DA31CA4A;
	Thu, 16 Oct 2025 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANtxdw7I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C236E31B800
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 11:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615962; cv=none; b=AkIbQ2nrX4O+4CofC1HxulQOHg5IOMkflmkw8qD5ZiZ0m89fi7MziNiVllhoeWin6Iuwnb/IQllMbuy72EgQSa57p3Utcp9/KAnP6lazfykULUiE4cBKYU9WZuVuHwC76085Q0S1fpBp93rvjryIfZP3hHj0HbF957ZTE+SVkkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615962; c=relaxed/simple;
	bh=q3IKDh7yLutVzDiJ3P+/8+eKgY1p3xIHoUFYqYTame8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4Paulr/PyH/hpPfG4MTUCdIw+YPWlTTiY46ErtjrWiV7nxzvjf7dgyLR6SsYlKMQuOQyfsS173G4pQVspCYKrVdq6rWS/YbGq3DxOieesbYs4gJIQqeJMNZd2GLNbruwKB4A8pC2RxKkwArwqfXH2fQpXow2QO+20yV/P2gkvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANtxdw7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE30C4CEF1;
	Thu, 16 Oct 2025 11:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760615961;
	bh=q3IKDh7yLutVzDiJ3P+/8+eKgY1p3xIHoUFYqYTame8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ANtxdw7IO8ofqHBbLXobla9VjBMZj+9F8LhOC1W4a9biScZ3L0W2PFGwpLAEOEsUM
	 Ox37pMSgLfBU/gbScP+70kAE/jcVjl41N0aHMMt+0QzuYwnDly+6Omo29EyLiZcovl
	 KzyQ6jfCJXZveK8c4TnvYdVJf3mmJgWGU8MhoX614xuDDo9Cm5hLUpcltFXIt4uQU6
	 RdFHuzW+pPnsgGB6V1s8c+qkmWves9ssxmB0FQXFbdOFtDPH/rFF5HcGg8WpDflFSU
	 9minC5B3D9W6R7AJeCQ6EwlMIe7Tr90etKtSo1+2qVIhQ8u6ZxkpYdRfemxJpUYrtB
	 87DOBHXxd6RNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] rseq: Protect event mask against membarrier IPI
Date: Thu, 16 Oct 2025 07:59:18 -0400
Message-ID: <20251016115918.3270535-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101555-untitled-sighing-27f5@gregkh>
References: <2025101555-untitled-sighing-27f5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 6eb350a2233100a283f882c023e5ad426d0ed63b ]

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
[ Applied changes to include/linux/sched.h instead of include/linux/rseq.h ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sched.h | 11 ++++++++---
 kernel/rseq.c         | 10 +++++-----
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4dc764f3d26f5..37ee1b1c9ed5f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2313,6 +2313,12 @@ enum rseq_event_mask {
 	RSEQ_EVENT_MIGRATE	= (1U << RSEQ_EVENT_MIGRATE_BIT),
 };
 
+#ifdef CONFIG_MEMBARRIER
+# define RSEQ_EVENT_GUARD	irq
+#else
+# define RSEQ_EVENT_GUARD	preempt
+#endif
+
 static inline void rseq_set_notify_resume(struct task_struct *t)
 {
 	if (t->rseq)
@@ -2331,9 +2337,8 @@ static inline void rseq_handle_notify_resume(struct ksignal *ksig,
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
index 840927ac417b1..2fea2782e1799 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -226,12 +226,12 @@ static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
 
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
-- 
2.51.0


