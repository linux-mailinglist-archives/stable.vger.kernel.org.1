Return-Path: <stable+bounces-20423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B692859414
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 03:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BCA21C20C6B
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 02:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774A015D4;
	Sun, 18 Feb 2024 02:33:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29384A2D
	for <stable@vger.kernel.org>; Sun, 18 Feb 2024 02:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708223592; cv=none; b=A9cVDcaKsqwmc3Po7in59BT3lbcIIgrNGCoX6NSNzX1I6F7GZ/nPqPjDGVNA04NPreE/3+ySxWrpvfOzttC+rkxHIaxYovfP3zEVOX0kDCiQsKns9N3hxoW53xhefDSGLJls+rMqB+JA/Z+fyYTpxJP9fwx2ZnZJFSfdZj/gtRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708223592; c=relaxed/simple;
	bh=YQQNB2Se+JMqbyH6hOmS3O7EH3ynvCKwV09k4gcTQek=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ki1trZJkvgB/XQoQ7y+YESvw31/vE7UAqa/XVs5pdxFX+zcthyvku2vwGn3m5t3D5EJn94EfSq2eTGHaD/foJfBTR8//fLnQPNFrGvzzLJ5+ba/yg22Ehlso0W32DqWd6bpiJQN8XqBxvlU9qN4vXoEpMsvDIg2OKhzMlRcAITI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TcqR95GMGz1Q98N;
	Sun, 18 Feb 2024 10:31:01 +0800 (CST)
Received: from canpemm500006.china.huawei.com (unknown [7.192.105.130])
	by mail.maildlp.com (Postfix) with ESMTPS id F39481404DB;
	Sun, 18 Feb 2024 10:33:07 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 10:33:07 +0800
Received: from huawei.com (10.67.174.111) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 18 Feb
 2024 10:33:07 +0800
From: Xiang Yang <xiangyang3@huawei.com>
To: <ardb@kernel.org>, <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
	<will@kernel.org>
CC: <keescook@chromium.org>, <linux-arm-kernel@lists.infradead.org>,
	<stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<xiangyang3@huawei.com>, <xiujianfeng@huawei.com>, <liaochang1@huawei.com>
Subject: [PATCH 5.10.y 4/5] arm64: entry: convert IRQ+FIQ handlers to C
Date: Sun, 18 Feb 2024 10:30:54 +0800
Message-ID: <20240218023055.145519-5-xiangyang3@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218023055.145519-1-xiangyang3@huawei.com>
References: <20240218023055.145519-1-xiangyang3@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500004.china.huawei.com (7.192.104.92)

From: Mark Rutland <mark.rutland@arm.com>

commit 064dbfb4169141943ec7d9dbfd02974dd008f2ce upstream.

For various reasons we'd like to convert the bulk of arm64's exception
triage logic to C. As a step towards that, this patch converts the EL1
and EL0 IRQ+FIQ triage logic to C.

Separate C functions are added for the native and compat cases so that
in subsequent patches we can handle native/compat differences in C.

Since the triage functions can now call arm64_apply_bp_hardening()
directly, the do_el0_irq_bp_hardening() wrapper function is removed.

Since the user_exit_irqoff macro is now unused, it is removed. The
user_enter_irqoff macro is still used by the ret_to_user code, and
cannot be removed at this time.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Joey Gouly <joey.gouly@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20210607094624.34689-8-mark.rutland@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Xiang Yang <xiangyang3@huawei.com>
---
 arch/arm64/include/asm/exception.h |  3 ++
 arch/arm64/kernel/entry-common.c   | 68 +++++++++++++++++++++++++++++-
 arch/arm64/kernel/entry.S          | 54 +++---------------------
 3 files changed, 77 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index def53267f4a2..846ca8132f76 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -26,6 +26,9 @@ static inline u32 disr_to_esr(u64 disr)
 	return esr;
 }
 
+asmlinkage void el1_irq_handler(struct pt_regs *regs);
+asmlinkage void el0_irq_handler(struct pt_regs *regs);
+asmlinkage void el0_irq_compat_handler(struct pt_regs *regs);
 asmlinkage void noinstr enter_el1_irq_or_nmi(struct pt_regs *regs);
 asmlinkage void noinstr exit_el1_irq_or_nmi(struct pt_regs *regs);
 asmlinkage void call_on_irq_stack(struct pt_regs *regs,
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index a533f4827253..340249c65007 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -19,6 +19,8 @@
 #include <asm/exception.h>
 #include <asm/kprobes.h>
 #include <asm/mmu.h>
+#include <asm/processor.h>
+#include <asm/stacktrace.h>
 #include <asm/sysreg.h>
 
 /*
@@ -113,7 +115,7 @@ asmlinkage void noinstr exit_el1_irq_or_nmi(struct pt_regs *regs)
 		exit_to_kernel_mode(regs);
 }
 
-asmlinkage void __sched arm64_preempt_schedule_irq(void)
+static void __sched arm64_preempt_schedule_irq(void)
 {
 	lockdep_assert_irqs_disabled();
 
@@ -141,6 +143,42 @@ static void noinstr el1_abort(struct pt_regs *regs, unsigned long esr)
 	exit_to_kernel_mode(regs);
 }
 
+static void do_interrupt_handler(struct pt_regs *regs,
+                                void (*handler)(struct pt_regs *))
+{
+	if (on_thread_stack())
+		call_on_irq_stack(regs, handler);
+	else
+		handler(regs);
+}
+
+extern void (*handle_arch_irq)(struct pt_regs *);
+
+static void noinstr el1_interrupt(struct pt_regs *regs,
+				  void (*handler)(struct pt_regs *))
+{
+	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
+
+	enter_el1_irq_or_nmi(regs);
+	do_interrupt_handler(regs, handler);
+
+	/*
+	 * Note: thread_info::preempt_count includes both thread_info::count
+	 * and thread_info::need_resched, and is not equivalent to
+	 * preempt_count().
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPTION) &&
+	    READ_ONCE(current_thread_info()->preempt_count) == 0)
+		arm64_preempt_schedule_irq();
+
+	exit_el1_irq_or_nmi(regs);
+}
+
+asmlinkage void noinstr el1_irq_handler(struct pt_regs *regs)
+{
+	el1_interrupt(regs, handle_arch_irq);
+}
+
 static void noinstr el1_pc(struct pt_regs *regs, unsigned long esr)
 {
 	unsigned long far = read_sysreg(far_el1);
@@ -445,6 +483,29 @@ asmlinkage void noinstr el0_sync_handler(struct pt_regs *regs)
 	}
 }
 
+static void noinstr el0_interrupt(struct pt_regs *regs,
+				  void (*handler)(struct pt_regs *))
+{
+	enter_from_user_mode();
+
+	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
+
+	if (regs->pc & BIT(55))
+		arm64_apply_bp_hardening();
+
+	do_interrupt_handler(regs, handler);
+}
+
+static void noinstr __el0_irq_handler_common(struct pt_regs *regs)
+{
+	el0_interrupt(regs, handle_arch_irq);
+}
+
+asmlinkage void noinstr el0_irq_handler(struct pt_regs *regs)
+{
+	__el0_irq_handler_common(regs);
+}
+
 #ifdef CONFIG_COMPAT
 static void noinstr el0_cp15(struct pt_regs *regs, unsigned long esr)
 {
@@ -453,6 +514,11 @@ static void noinstr el0_cp15(struct pt_regs *regs, unsigned long esr)
 	do_el0_cp15(esr, regs);
 }
 
+asmlinkage void noinstr el0_irq_compat_handler(struct pt_regs *regs)
+{
+	__el0_irq_handler_common(regs);
+}
+
 static void noinstr el0_svc_compat(struct pt_regs *regs)
 {
 	enter_from_user_mode();
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 8b17d83e8c87..b0d102669dde 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -429,49 +429,6 @@ SYM_CODE_START_LOCAL(__swpan_exit_el0)
 SYM_CODE_END(__swpan_exit_el0)
 #endif
 
-	.macro	irq_stack_entry
-	mov	x19, sp			// preserve the original sp
-#ifdef CONFIG_SHADOW_CALL_STACK
-	mov	x24, scs_sp		// preserve the original shadow stack
-#endif
-
-	/*
-	 * Compare sp with the base of the task stack.
-	 * If the top ~(THREAD_SIZE - 1) bits match, we are on a task stack,
-	 * and should switch to the irq stack.
-	 */
-	ldr	x25, [tsk, TSK_STACK]
-	eor	x25, x25, x19
-	and	x25, x25, #~(THREAD_SIZE - 1)
-	cbnz	x25, 9998f
-
-	ldr_this_cpu x25, irq_stack_ptr, x26
-	mov	x26, #IRQ_STACK_SIZE
-	add	x26, x25, x26
-
-	/* switch to the irq stack */
-	mov	sp, x26
-
-#ifdef CONFIG_SHADOW_CALL_STACK
-	/* also switch to the irq shadow stack */
-	adr_this_cpu scs_sp, irq_shadow_call_stack, x26
-#endif
-
-9998:
-	.endm
-
-	/*
-	 * The callee-saved regs (x19-x29) should be preserved between
-	 * irq_stack_entry and irq_stack_exit, but note that kernel_entry
-	 * uses x20-x23 to store data for later use.
-	 */
-	.macro	irq_stack_exit
-	mov	sp, x19
-#ifdef CONFIG_SHADOW_CALL_STACK
-	mov	scs_sp, x24
-#endif
-	.endm
-
 /* GPRs used by entry code */
 tsk	.req	x28		// current thread_info
 
@@ -675,7 +632,8 @@ SYM_CODE_END(el1_sync)
 	.align	6
 SYM_CODE_START_LOCAL_NOALIGN(el1_irq)
 	kernel_entry 1
-	el1_interrupt_handler handle_arch_irq
+	mov	x0, sp
+	bl	el1_irq_handler
 	kernel_exit 1
 SYM_CODE_END(el1_irq)
 
@@ -702,7 +660,9 @@ SYM_CODE_END(el0_sync_compat)
 	.align	6
 SYM_CODE_START_LOCAL_NOALIGN(el0_irq_compat)
 	kernel_entry 0, 32
-	b	el0_irq_naked
+	mov	x0, sp
+	bl	el0_irq_compat_handler
+	b	ret_to_user
 SYM_CODE_END(el0_irq_compat)
 
 SYM_CODE_START_LOCAL_NOALIGN(el0_error_compat)
@@ -714,8 +674,8 @@ SYM_CODE_END(el0_error_compat)
 	.align	6
 SYM_CODE_START_LOCAL_NOALIGN(el0_irq)
 	kernel_entry 0
-el0_irq_naked:
-	el0_interrupt_handler handle_arch_irq
+	mov	x0, sp
+	bl	el0_irq_handler
 	b	ret_to_user
 SYM_CODE_END(el0_irq)
 
-- 
2.34.1


