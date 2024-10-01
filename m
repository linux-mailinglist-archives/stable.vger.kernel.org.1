Return-Path: <stable+bounces-78462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E86698BAEC
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 13:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93EB1F22008
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 11:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CAA1BF7FA;
	Tue,  1 Oct 2024 11:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TlNyhQoS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7F41BF7EE
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781772; cv=none; b=JSC00DAvqCNNUx8BHrlR7Q6NToSa223eqghdxCSkJek1v5D00TTNaUmSP5K9qDFwrx10M50zYVl2VlgwC+vBDKhoMmhEua4BUc75GAMAH4GoJoG8t/Jgu19nAAZJ7KtCOP7BdSxURAkbO7+XU0wZY328/sTlan1NdzvF8ixr+Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781772; c=relaxed/simple;
	bh=XtlvONVjxL3DMtmEfEs/bjira7aH6LkqVhh2yluw6Fk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mvnZwz10L4J5vfRT4+I37HYhOgYm5kg7uA+x3eOayybbHCMTzno1FCUP6cMbUE+YOAkVY943mAh3g2rPVw3knbKTPyUZJGq4vnxbh/hjeLQY47NfzQ7v0kOpxYC0jBV3uOmEp5WF3YOyin9lFAgbzAZMQp5mpJbDXCSMp6LQVKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TlNyhQoS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECFEC4CEC6;
	Tue,  1 Oct 2024 11:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727781771;
	bh=XtlvONVjxL3DMtmEfEs/bjira7aH6LkqVhh2yluw6Fk=;
	h=Subject:To:Cc:From:Date:From;
	b=TlNyhQoSkVOEm/sGm/YW6TwNKSv++uM3iKq9A3VeoOcAKTlzln+6RFNv5SLJSnhas
	 rkwA2o+djiiYuyQzOdse7l4bdKZfo93Fz52Hy50dXzp0iule6mnhvAGEotAep38Plj
	 o20vbQ8pZNKeK5E3pPeDQoVWfEVV58EzTUAhBuK8=
Subject: FAILED: patch "[PATCH] x86/entry: Remove unwanted instrumentation in" failed to apply to 5.15-stable tree
To: dvyukov@google.com,glider@google.com,peterz@infradead.org,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 13:22:38 +0200
Message-ID: <2024100138-marital-stumbling-53bc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 477d81a1c47a1b79b9c08fc92b5dea3c5143800b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100138-marital-stumbling-53bc@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


