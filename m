Return-Path: <stable+bounces-66073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D65094C1F0
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 17:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304791F2114E
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 15:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F00191F61;
	Thu,  8 Aug 2024 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tCyTc6ek";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VDutRfib"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64C418FDB8;
	Thu,  8 Aug 2024 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132158; cv=none; b=VaD4KSLqPYOH1+GZGZR3pRceQq+RTBGqvLaBDQoIRTInJZLOKnWVESigfwrwit/2JP47KKdyQzAUcMRHWmTdD35wrDiUWrxmSGRSJGyigAugmHw9uHTXsqkXUt+O6AvhKdDN+Mn5mArq4WV+rMjts9KrQRHDVtOkxwpXtBxZTb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132158; c=relaxed/simple;
	bh=unKutB3KywfOO503sUPUXfMUDoNg22MlsH/XwaTO134=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kIUacgzFF3wO5k8DR6ozAUIs04AMINYbXxEdCU0kpgYZKVh+77WGrU4fAJGCf7chX7/dMGPud5RNbIVIVVttMlIveYwUnh6MMFB9t8LkqKeM5giEkp3Xtea000QXBJEK2PYJO+naFEGltwl7jGnEy1qoqPlFOvMoZsrttZIjuww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tCyTc6ek; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VDutRfib; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 15:49:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723132155;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ggWANDbsY3QGkp2FDC08iq6N3UYnkCM8wKZs5oSSq28=;
	b=tCyTc6ekhp+UuWWwdAxIbmWviBlFzwEoXNjfjDetVYHTz0mGl0aMJLwbSKon+Rp8hLXuYp
	6jXUlXkT3S5Zl+YO704MJ1Lug/SXMXmFT6CC05LZCU6u4f04hdPWrbsz0eS/39zQVcVMoI
	KtRbO5Cl++NV8AslyaUpG8GVvqvUoDhFotebSNwBR0osNQgPomzFrpCcScMrNEnQDluhHp
	E5CUw8E8j/IHuQbLUcCwLVJHUhbsvqfADvZUq8j0HQaclHD2jTW45Ajxo8QzY/pLEv8qzl
	QgEfbUNtuGnHezU/le2Rs8/pjAMNbVbJ1r9/GwaWwLeUL3+DB92IY4W3ktlDKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723132155;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ggWANDbsY3QGkp2FDC08iq6N3UYnkCM8wKZs5oSSq28=;
	b=VDutRfibMRi5x0coUXAzH7kEHZ1Xjm1N0pOe/DINLIc5N2Zny/Z2/EHq19VgROLry5BBN/
	tz0C+u6FGM+9bnAg==
From: "tip-bot2 for Dmitry Vyukov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/entry: Remove unwanted instrumentation in
 common_interrupt()
Cc: Dmitry Vyukov <dvyukov@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Alexander Potapenko <glider@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <3f9a1de9e415fcb53d07dc9e19fa8481bb021b1b.1718092070.git.dvyukov@google.com>
References:
 <3f9a1de9e415fcb53d07dc9e19fa8481bb021b1b.1718092070.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172313215486.2215.4344651204261650422.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     477d81a1c47a1b79b9c08fc92b5dea3c5143800b
Gitweb:        https://git.kernel.org/tip/477d81a1c47a1b79b9c08fc92b5dea3c5143800b
Author:        Dmitry Vyukov <dvyukov@google.com>
AuthorDate:    Tue, 11 Jun 2024 09:50:30 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 Aug 2024 17:36:35 +02:00

x86/entry: Remove unwanted instrumentation in common_interrupt()

common_interrupt() and related variants call kvm_set_cpu_l1tf_flush_l1d(),
which is neither marked noinstr nor __always_inline.

So compiler puts it out of line and adds instrumentation to it.  Since the
call is inside of instrumentation_begin/end(), objtool does not warn about
it.

The manifestation is that KCOV produces spurious coverage in
kvm_set_cpu_l1tf_flush_l1d() in random places because the call happens when
preempt count is not yet updated to say that the kernel is in an interrupt.

Mark kvm_set_cpu_l1tf_flush_l1d() as __always_inline and move it out of the
instrumentation_begin/end() section.  It only calls __this_cpu_write()
which is already safe to call in noinstr contexts.

Fixes: 6368558c3710 ("x86/entry: Provide IDTENTRY_SYSVEC")
Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexander Potapenko <glider@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/3f9a1de9e415fcb53d07dc9e19fa8481bb021b1b.1718092070.git.dvyukov@google.com

---
 arch/x86/include/asm/hardirq.h  | 8 ++++++--
 arch/x86/include/asm/idtentry.h | 6 +++---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index c67fa6a..6ffa8b7 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -69,7 +69,11 @@ extern u64 arch_irq_stat(void);
 #define local_softirq_pending_ref       pcpu_hot.softirq_pending
 
 #if IS_ENABLED(CONFIG_KVM_INTEL)
-static inline void kvm_set_cpu_l1tf_flush_l1d(void)
+/*
+ * This function is called from noinstr interrupt contexts
+ * and must be inlined to not get instrumentation.
+ */
+static __always_inline void kvm_set_cpu_l1tf_flush_l1d(void)
 {
 	__this_cpu_write(irq_stat.kvm_cpu_l1tf_flush_l1d, 1);
 }
@@ -84,7 +88,7 @@ static __always_inline bool kvm_get_cpu_l1tf_flush_l1d(void)
 	return __this_cpu_read(irq_stat.kvm_cpu_l1tf_flush_l1d);
 }
 #else /* !IS_ENABLED(CONFIG_KVM_INTEL) */
-static inline void kvm_set_cpu_l1tf_flush_l1d(void) { }
+static __always_inline void kvm_set_cpu_l1tf_flush_l1d(void) { }
 #endif /* IS_ENABLED(CONFIG_KVM_INTEL) */
 
 #endif /* _ASM_X86_HARDIRQ_H */
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index d4f2449..ad5c68f 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -212,8 +212,8 @@ __visible noinstr void func(struct pt_regs *regs,			\
 	irqentry_state_t state = irqentry_enter(regs);			\
 	u32 vector = (u32)(u8)error_code;				\
 									\
+	kvm_set_cpu_l1tf_flush_l1d();                                   \
 	instrumentation_begin();					\
-	kvm_set_cpu_l1tf_flush_l1d();					\
 	run_irq_on_irqstack_cond(__##func, regs, vector);		\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
@@ -250,7 +250,6 @@ static void __##func(struct pt_regs *regs);				\
 									\
 static __always_inline void instr_##func(struct pt_regs *regs)		\
 {									\
-	kvm_set_cpu_l1tf_flush_l1d();					\
 	run_sysvec_on_irqstack_cond(__##func, regs);			\
 }									\
 									\
@@ -258,6 +257,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 {									\
 	irqentry_state_t state = irqentry_enter(regs);			\
 									\
+	kvm_set_cpu_l1tf_flush_l1d();                                   \
 	instrumentation_begin();					\
 	instr_##func (regs);						\
 	instrumentation_end();						\
@@ -288,7 +288,6 @@ static __always_inline void __##func(struct pt_regs *regs);		\
 static __always_inline void instr_##func(struct pt_regs *regs)		\
 {									\
 	__irq_enter_raw();						\
-	kvm_set_cpu_l1tf_flush_l1d();					\
 	__##func (regs);						\
 	__irq_exit_raw();						\
 }									\
@@ -297,6 +296,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 {									\
 	irqentry_state_t state = irqentry_enter(regs);			\
 									\
+	kvm_set_cpu_l1tf_flush_l1d();                                   \
 	instrumentation_begin();					\
 	instr_##func (regs);						\
 	instrumentation_end();						\

