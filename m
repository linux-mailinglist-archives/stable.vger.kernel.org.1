Return-Path: <stable+bounces-78461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F195D98BAEB
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 13:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FAC61C2216D
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 11:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5848719D88B;
	Tue,  1 Oct 2024 11:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qLAd6NDN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197F119AD4F
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781769; cv=none; b=p1WmMX/qKtgxdlZV1L7USCCIk1JlvQ3gzBQQwkCFxZEWBHJ0TsHzc2EnPGEL8SQXFuanVcM+RzC0Qz7+DRRwzzMO3Q7WHmMCVBlxjUkdcG73qWRy+go8ot6ObrBONPDNJi5ES8HKJq6fQ8rnidz2JEQuU4kJEsfPj+/I3TYM1zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781769; c=relaxed/simple;
	bh=FVFXUlAq3hcmYIQeBSNNZJfv3rig2AJ5fsq0rKqqDts=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aMO9ve7vlQl+gdBQI/n/vevf5xjIZn+L+IBdx+pCC1aO5FupceXaVDpBkVrRl3ixZCmChoPeCKoqyeecNx1Wil2lQuE1BcqY+fkTRcpAVqMm1ljw1tpfIwOzs7JLNKRhXffULrGSNCk4pSw4zoG6hnCpDWRYWSBS7+N4qnSuGVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qLAd6NDN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A6EC4CEC6;
	Tue,  1 Oct 2024 11:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727781768;
	bh=FVFXUlAq3hcmYIQeBSNNZJfv3rig2AJ5fsq0rKqqDts=;
	h=Subject:To:Cc:From:Date:From;
	b=qLAd6NDNi4r0faYzKfqZUyVcnAwNl8iOp+LfUubch+G0pR1fpBbZlMtFVLvN72kLO
	 PTw2w5DkVDAJfzPBBbWATmjmhLrD8hooJTBLjCZT73oPJz70Y3he2SoGpa8KhtMQku
	 udDg3S70XJNFMoFI9LpVZhVnPiOPlE6ITw7aeFug=
Subject: FAILED: patch "[PATCH] x86/entry: Remove unwanted instrumentation in" failed to apply to 6.1-stable tree
To: dvyukov@google.com,glider@google.com,peterz@infradead.org,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 13:22:37 +0200
Message-ID: <2024100137-overdraft-spongy-2e3f@gregkh>
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
git cherry-pick -x 477d81a1c47a1b79b9c08fc92b5dea3c5143800b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100137-overdraft-spongy-2e3f@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

477d81a1c47a ("x86/entry: Remove unwanted instrumentation in common_interrupt()")
90f357208200 ("x86/idtentry: Incorporate definitions/declarations of the FRED entries")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 477d81a1c47a1b79b9c08fc92b5dea3c5143800b Mon Sep 17 00:00:00 2001
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 11 Jun 2024 09:50:30 +0200
Subject: [PATCH] x86/entry: Remove unwanted instrumentation in
 common_interrupt()

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

diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index c67fa6ad098a..6ffa8b75f4cd 100644
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
index d4f24499b256..ad5c68f0509d 100644
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


