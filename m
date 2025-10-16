Return-Path: <stable+bounces-185872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9F5BE12C0
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 03:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC59A4E9ED3
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 01:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D43E15746F;
	Thu, 16 Oct 2025 01:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWxdpGo/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3E6128816
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 01:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760578308; cv=none; b=X0OWoMfIw0iqOIpJCqfGzLSt6Xb2wfl3v/cWWfcU2KGb5b7H9WVLcp884Tl8uzUNKYxVsmTiu45JK5x/P/VHVkIDWdbRzyOAujffTkeH1R5AITwCu+rcneQwka0nuDQ8UVx/l/zbn+y/hP4yTFSMkokruHmVvN4R2c5PZZQJrK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760578308; c=relaxed/simple;
	bh=/O+KvSK6ZNqk67j+pEivLfHqGMLjOhJDGdzZAoQuJiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rT3farg52CviZMTRhL3oxDGxGFr9gYmxyO2s66KsZb/bFwYXrpa30rPmERZGuMLHOhNzuJNLUWoH8+YtgqsBjI1VKwj/RyZ18FBctBByB79yzCHR7JhQsQuG8iKtqTT6/N53epDs0xQbrEYyWhBXEiSpi8sYm0AeM+6yLr7Ap4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWxdpGo/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0820EC4CEF8;
	Thu, 16 Oct 2025 01:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760578307;
	bh=/O+KvSK6ZNqk67j+pEivLfHqGMLjOhJDGdzZAoQuJiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TWxdpGo/41sQFmS81AfMeAikAKm9lumHWc/hanoWXxlraj0VNDBeNLuuE972rWZI6
	 436IeJ765rZj1LsjWtS7oA6ZiIDZ0WotKYqQ3N/aEDmA3lmcdbyJbEgWaI3MVw/fVz
	 eLHiQVLwYz1Si8wGGHxSi7/92jN4CzgR37sf++lb4VxyuvwMa11PDCtSG17yqstN8j
	 f6CidxW83sNBdiJDbrGgR9X8LnSqLMk+GRJGtlHWFOWQK33+cZ+7M3KOUMf1hNZXKa
	 rjo2wzo13F08a5fwKahFZmBGkdfNhMkvQnKMeS4xPKz6E/LWaAqIUtUV44YNQVC7r+
	 SoONxBDL5nFRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] rseq: Protect event mask against membarrier IPI
Date: Wed, 15 Oct 2025 21:31:44 -0400
Message-ID: <20251016013144.1560902-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101555-glimpse-gauntlet-5c2a@gregkh>
References: <2025101555-glimpse-gauntlet-5c2a@gregkh>
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
index cb38eee732fd0..9559501236af0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2343,6 +2343,12 @@ enum rseq_event_mask {
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
@@ -2361,9 +2367,8 @@ static inline void rseq_handle_notify_resume(struct ksignal *ksig,
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
index 23894ba8250cf..810005f927d7c 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -255,12 +255,12 @@ static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
 
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


