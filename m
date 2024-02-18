Return-Path: <stable+bounces-20424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CB3859415
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 03:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50821C20CA2
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 02:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601F217FF;
	Sun, 18 Feb 2024 02:33:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C2A4A39
	for <stable@vger.kernel.org>; Sun, 18 Feb 2024 02:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708223593; cv=none; b=pjgnnsL19FDdcxTmFnKEFgs7RBOTelhhF4hY3Xv1s4qM+ViYxhdpU5lm1T+KLcj+sCHQtcUd3PwoCPdVQHZOZZgd7YMt5S/zUoMLsCUra4DduxvKeZeGz59Sav4mhEF8WfYuPr5RQkyHsPLDUBo7ctTWqGCKHtNMdqqQ42mraCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708223593; c=relaxed/simple;
	bh=u6zdfIrB3TTZ9OodSD8zCTjZtYmMElWZReB0gQyO8/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fkydH1yA7GxjdSzkzNCGNo5prea5rn0Fmp5Xa/ONggOqOBCfj7MRbulWNyAB+IdBYKATzeb2tLV1d+8sui7QkcZ2b5nsbhj7Mnb/96RRwlIZa92cCHRF7HATX+wH2fSp+EzhfnViTWPa7WFaoZV/5TDXggMZpayAfHfoMlkv5ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TcqN33Xp9z1FKWR;
	Sun, 18 Feb 2024 10:28:19 +0800 (CST)
Received: from canpemm500007.china.huawei.com (unknown [7.192.104.62])
	by mail.maildlp.com (Postfix) with ESMTPS id 95D23140157;
	Sun, 18 Feb 2024 10:33:07 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
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
Subject: [PATCH 5.10.y 2/5] arm64: entry: move arm64_preempt_schedule_irq to entry-common.c
Date: Sun, 18 Feb 2024 10:30:52 +0800
Message-ID: <20240218023055.145519-3-xiangyang3@huawei.com>
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

commit 33a3581a76f3a36c7dcc9864120ce681bcfbcff1 upstream.

Subsequent patches will pull more of the IRQ entry handling into C. To
keep this in one place, let's move arm64_preempt_schedule_irq() into
entry-common.c along with the other entry management functions.

We no longer need to include <linux/lockdep.h> in process.c, so the
include directive is removed.

There should be no functional change as a result of this patch.

Reviewed-by Joey Gouly <joey.gouly@arm.com>

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20210607094624.34689-5-mark.rutland@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Xiang Yang <xiangyang3@huawei.com>
---
 arch/arm64/kernel/entry-common.c | 20 ++++++++++++++++++++
 arch/arm64/kernel/process.c      | 17 -----------------
 2 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 7a8cd856ee85..a533f4827253 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -6,7 +6,11 @@
  */
 
 #include <linux/context_tracking.h>
+#include <linux/linkage.h>
+#include <linux/lockdep.h>
 #include <linux/ptrace.h>
+#include <linux/sched.h>
+#include <linux/sched/debug.h>
 #include <linux/thread_info.h>
 
 #include <asm/cpufeature.h>
@@ -109,6 +113,22 @@ asmlinkage void noinstr exit_el1_irq_or_nmi(struct pt_regs *regs)
 		exit_to_kernel_mode(regs);
 }
 
+asmlinkage void __sched arm64_preempt_schedule_irq(void)
+{
+	lockdep_assert_irqs_disabled();
+
+	/*
+	 * Preempting a task from an IRQ means we leave copies of PSTATE
+	 * on the stack. cpufeature's enable calls may modify PSTATE, but
+	 * resuming one of these preempted tasks would undo those changes.
+	 *
+	 * Only allow a task to be preempted once cpufeatures have been
+	 * enabled.
+	 */
+	if (system_capabilities_finalized())
+		preempt_schedule_irq();
+}
+
 static void noinstr el1_abort(struct pt_regs *regs, unsigned long esr)
 {
 	unsigned long far = read_sysreg(far_el1);
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 3696dbcbfa80..a04b152696cf 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -18,7 +18,6 @@
 #include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
 #include <linux/kernel.h>
-#include <linux/lockdep.h>
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/nospec.h>
@@ -702,22 +701,6 @@ static int __init tagged_addr_init(void)
 core_initcall(tagged_addr_init);
 #endif	/* CONFIG_ARM64_TAGGED_ADDR_ABI */
 
-asmlinkage void __sched arm64_preempt_schedule_irq(void)
-{
-	lockdep_assert_irqs_disabled();
-
-	/*
-	 * Preempting a task from an IRQ means we leave copies of PSTATE
-	 * on the stack. cpufeature's enable calls may modify PSTATE, but
-	 * resuming one of these preempted tasks would undo those changes.
-	 *
-	 * Only allow a task to be preempted once cpufeatures have been
-	 * enabled.
-	 */
-	if (system_capabilities_finalized())
-		preempt_schedule_irq();
-}
-
 #ifdef CONFIG_BINFMT_ELF
 int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
 			 bool has_interp, bool is_interp)
-- 
2.34.1


