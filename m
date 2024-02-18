Return-Path: <stable+bounces-20422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB82859413
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 03:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B761C20CB9
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 02:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735BA15D0;
	Sun, 18 Feb 2024 02:33:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C584C61
	for <stable@vger.kernel.org>; Sun, 18 Feb 2024 02:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708223592; cv=none; b=HF6mJZ0oNgPanAQEfBQFMoDz35uAoGEVnv2x775/dN8Ebdv+KtIoMTzRF0bK4C03vFC0QwaOmqXBkguT4+zaj+eLSrneReyr8rg2q3V9eWz0uwB748H8jLniweCucTiJWM1qzEY0oGAIpThqtX3S7PnubVJq6kXXZPlwsV+kwEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708223592; c=relaxed/simple;
	bh=X9YzacXbIe9hORCs5ZLTezqCNPMFTIAu+rPi6ooHsZE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLN6uu/5iZpXoon+S34kFu2ZTtVzRwmEG2AjfKqep7Le8YkiVnGug4mbGqLTX6hM3qKZgFhvNPW4PrDVGO3Q1U8Qlucg2bx+7IRovIFMaDzDP2fK7xEQIykCmtZ326n65//N9N1I/AYUAh0lp1k5kikaovexJtF2lF7NtOH+fJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TcqN34yK9z1FKYK;
	Sun, 18 Feb 2024 10:28:19 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id CA4AA1A016B;
	Sun, 18 Feb 2024 10:33:07 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
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
Subject: [PATCH 5.10.y 3/5] arm64: entry: add a call_on_irq_stack helper
Date: Sun, 18 Feb 2024 10:30:53 +0800
Message-ID: <20240218023055.145519-4-xiangyang3@huawei.com>
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

commit f8049488e7d37b0a0e438ee449e83b3e46958743 upstream.

When handling IRQ/FIQ exceptions the entry assembly may transition from
a task's stack to a CPU's IRQ stack (and IRQ shadow call stack).

In subsequent patches we want to migrate the IRQ/FIQ triage logic to C,
and as we want to perform some actions on the task stack (e.g. EL1
preemption), we need to switch stacks within the C handler. So that we
can do so, this patch adds a helper to call a function on a CPU's IRQ
stack (and shadow stack as appropriate).

Subsequent patches will make use of the new helper function.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20210607094624.34689-7-mark.rutland@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Xiang Yang <xiangyang3@huawei.com>
---
 arch/arm64/include/asm/exception.h |  2 ++
 arch/arm64/kernel/entry.S          | 36 ++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index cc5b2203d876..def53267f4a2 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -28,6 +28,8 @@ static inline u32 disr_to_esr(u64 disr)
 
 asmlinkage void noinstr enter_el1_irq_or_nmi(struct pt_regs *regs);
 asmlinkage void noinstr exit_el1_irq_or_nmi(struct pt_regs *regs);
+asmlinkage void call_on_irq_stack(struct pt_regs *regs,
+				  void (*func)(struct pt_regs *));
 asmlinkage void enter_from_user_mode(void);
 asmlinkage void exit_to_user_mode(void);
 void arm64_enter_nmi(struct pt_regs *regs);
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 020a455824be..8b17d83e8c87 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -1043,6 +1043,42 @@ SYM_CODE_START(ret_from_fork)
 SYM_CODE_END(ret_from_fork)
 NOKPROBE(ret_from_fork)
 
+/*
+ * void call_on_irq_stack(struct pt_regs *regs,
+ * 		          void (*func)(struct pt_regs *));
+ *
+ * Calls func(regs) using this CPU's irq stack and shadow irq stack.
+ */
+SYM_FUNC_START(call_on_irq_stack)
+#ifdef CONFIG_SHADOW_CALL_STACK
+	stp	scs_sp, xzr, [sp, #-16]!
+	adr_this_cpu scs_sp, irq_shadow_call_stack, x17
+#endif
+	/* Create a frame record to save our LR and SP (implicit in FP) */
+	stp	x29, x30, [sp, #-16]!
+	mov	x29, sp
+
+	ldr_this_cpu x16, irq_stack_ptr, x17
+	mov	x15, #IRQ_STACK_SIZE
+	add	x16, x16, x15
+
+	/* Move to the new stack and call the function there */
+	mov	sp, x16
+	blr	x1
+
+	/*
+	 * Restore the SP from the FP, and restore the FP and LR from the frame
+	 * record.
+	 */
+	mov	sp, x29
+	ldp	x29, x30, [sp], #16
+#ifdef CONFIG_SHADOW_CALL_STACK
+	ldp	scs_sp, xzr, [sp], #16
+#endif
+	ret
+SYM_FUNC_END(call_on_irq_stack)
+NOKPROBE(call_on_irq_stack)
+
 #ifdef CONFIG_ARM_SDE_INTERFACE
 
 #include <asm/sdei.h>
-- 
2.34.1


