Return-Path: <stable+bounces-131340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AC9A8096A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC141BA63A8
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903E226B966;
	Tue,  8 Apr 2025 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ESpMfTt+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3AF26B94D;
	Tue,  8 Apr 2025 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116132; cv=none; b=tdDo7x7py5lr5VH4goT3fgnzEM8rqQNDEjOOZJozZOPY4jg1PtNgiAGfL4L3bPmpeQY3b/typm2kSMNqg9uUlO8hYwWC7Eq9Pg+Idixo4WNMDciL5zp9X5YG9SMuuX2wYTi8pSx9yZ20MkynNZEfkVoIN503WqxrMLRqY1SJitg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116132; c=relaxed/simple;
	bh=b+02XH1FHUzocuvhF8SeZdvFpfmaSr9AtqukqWNsqv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdOvFHNJEZluNQTRiB//RPFN8sMpMj49etrPTHKQa45N1Ysts1ssbJrrOEJMvIZEGN9q1bANNyIGSmyuAn6BfYXxGQiq6so6b3Zf9QqeUERZWlFmQ0JNWwzSWbc3iAxXczl1z0HpLcWyh68C4609tnr9CQbOMCdg8PMY/GEvMGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ESpMfTt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4602C4CEE7;
	Tue,  8 Apr 2025 12:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116132;
	bh=b+02XH1FHUzocuvhF8SeZdvFpfmaSr9AtqukqWNsqv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ESpMfTt+C/lFS9HJPPGRU28P3yhS92nQb1/XKo/yFsFhoe/p01eScrlBM0l8ETwU9
	 1uqg7UBmsqPBetVNTqK++WYMWoYek8MkI9cJU5mlKTFDR+RNg60MCcnpGjC50WEeX4
	 fJzruUtQuJi38+XUs13tsBrTloHgz2zByH4ddFYc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guenter Roeck <linux@roeck-us.net>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 027/423] lockdep: Dont disable interrupts on RT in disable_irq_nosync_lockdep.*()
Date: Tue,  8 Apr 2025 12:45:53 +0200
Message-ID: <20250408104846.382179344@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 87886b32d669abc11c7be95ef44099215e4f5788 ]

disable_irq_nosync_lockdep() disables interrupts with lockdep enabled to
avoid false positive reports by lockdep that a certain lock has not been
acquired with disabled interrupts. The user of this macros expects that
a lock can be acquried without disabling interrupts because the IRQ line
triggering the interrupt is disabled.

This triggers a warning on PREEMPT_RT because after
disable_irq_nosync_lockdep.*() the following spinlock_t now is acquired
with disabled interrupts.

On PREEMPT_RT there is no difference between spin_lock() and
spin_lock_irq() so avoiding disabling interrupts in this case works for
the two remaining callers as of today.

Don't disable interrupts on PREEMPT_RT in disable_irq_nosync_lockdep.*().

Closes: https://lore.kernel.org/760e34f9-6034-40e0-82a5-ee9becd24438@roeck-us.net
Fixes: e8106b941ceab ("[PATCH] lockdep: core, add enable/disable_irq_irqsave/irqrestore() APIs")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Suggested-by: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20250212103619.2560503-2-bigeasy@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/interrupt.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 457151f9f263d..b378fbf885ce3 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -448,7 +448,7 @@ irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
 static inline void disable_irq_nosync_lockdep(unsigned int irq)
 {
 	disable_irq_nosync(irq);
-#ifdef CONFIG_LOCKDEP
+#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
 	local_irq_disable();
 #endif
 }
@@ -456,7 +456,7 @@ static inline void disable_irq_nosync_lockdep(unsigned int irq)
 static inline void disable_irq_nosync_lockdep_irqsave(unsigned int irq, unsigned long *flags)
 {
 	disable_irq_nosync(irq);
-#ifdef CONFIG_LOCKDEP
+#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
 	local_irq_save(*flags);
 #endif
 }
@@ -471,7 +471,7 @@ static inline void disable_irq_lockdep(unsigned int irq)
 
 static inline void enable_irq_lockdep(unsigned int irq)
 {
-#ifdef CONFIG_LOCKDEP
+#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
 	local_irq_enable();
 #endif
 	enable_irq(irq);
@@ -479,7 +479,7 @@ static inline void enable_irq_lockdep(unsigned int irq)
 
 static inline void enable_irq_lockdep_irqrestore(unsigned int irq, unsigned long *flags)
 {
-#ifdef CONFIG_LOCKDEP
+#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
 	local_irq_restore(*flags);
 #endif
 	enable_irq(irq);
-- 
2.39.5




