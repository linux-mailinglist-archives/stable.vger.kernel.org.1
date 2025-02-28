Return-Path: <stable+bounces-119894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCF7A49209
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 08:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4C21683D8
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 07:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D421C5D52;
	Fri, 28 Feb 2025 07:19:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B91276D12;
	Fri, 28 Feb 2025 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740727155; cv=none; b=Tq2Bg0Fl7ArZD+XtA5rUPmnD2J6Ifns2HJBDeMyRZ88RXRBdTYb4bQOLVgO/3aI8ClhMUBxYwQHifG4DnVxp4RpGvw2Qw1QcazmavZJkzLRoTrVNk+FpJARrq3ezVljkl/zYWXob3dWQYzG8YtGXf3fsWn6GM+B6ixQ3pi0QdpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740727155; c=relaxed/simple;
	bh=6owDAMkr5e1jMDchDZzOuBuh5wYNshJ/TkcS+/opak4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B8YQ0ZCGDh3uG6JmJ8H3DsOjoyXzXdW7X00PGlJ52DSXeg/4FmdV5tbFcSOdtyn/bt+qkiD0syP/9vnpfcjt06S9q2BE4TLUd0NthkPqTwhXV1QgzxI0eg3XC4ikF1V9op7odg/HYm98gC8H2TAbDtCM78pY7dTjDKY68471Oq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62661C4CED6;
	Fri, 28 Feb 2025 07:19:11 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org,
	Erpeng Xu <xuerpeng@uniontech.com>,
	Yuli Wang <wangyuli@uniontech.com>
Subject: [PATCH V2] LoongArch: Use polling play_dead() when resuming from hibernation
Date: Fri, 28 Feb 2025 15:18:48 +0800
Message-ID: <20250228071848.1763966-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_RANDOM_KMALLOC_CACHES or other randomization infrastructrue
enabled, the idle_task's stack may different between the booting kernel
and target kernel. So when resuming from hibernation, an ACTION_BOOT_CPU
IPI wakeup the idle instruction in arch_cpu_idle_dead() and jump to the
interrupt handler. But since the stack pointer is changed, the interrupt
handler cannot restore correct context.

So rename the current arch_cpu_idle_dead() to idle_play_dead(), make it
as the default version of play_dead(), and the new arch_cpu_idle_dead()
call play_dead() directly. For hibernation, implement an arch-specific
hibernate_resume_nonboot_cpu_disable() to use the polling version (idle
instruction is replace by nop, and irq is disabled) of play_dead(), i.e.
poll_play_dead(), to avoid IPI handler corrupting the idle_task's stack
when resuming from hibernation.

This solution is a little similar to commit 406f992e4a372dafbe3c ("x86 /
hibernate: Use hlt_play_dead() when resuming from hibernation").

Cc: stable@vger.kernel.org
Tested-by: Erpeng Xu <xuerpeng@uniontech.com>
Tested-by: Yuli Wang <wangyuli@uniontech.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Fix build for !HIBERNATION and restore to idle_play_dead() if fails.

 arch/loongarch/kernel/smp.c | 47 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index fbf747447f13..4b24589c0b56 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -19,6 +19,7 @@
 #include <linux/smp.h>
 #include <linux/threads.h>
 #include <linux/export.h>
+#include <linux/suspend.h>
 #include <linux/syscore_ops.h>
 #include <linux/time.h>
 #include <linux/tracepoint.h>
@@ -423,7 +424,7 @@ void loongson_cpu_die(unsigned int cpu)
 	mb();
 }
 
-void __noreturn arch_cpu_idle_dead(void)
+static void __noreturn idle_play_dead(void)
 {
 	register uint64_t addr;
 	register void (*init_fn)(void);
@@ -447,6 +448,50 @@ void __noreturn arch_cpu_idle_dead(void)
 	BUG();
 }
 
+#ifdef CONFIG_HIBERNATION
+static void __noreturn poll_play_dead(void)
+{
+	register uint64_t addr;
+	register void (*init_fn)(void);
+
+	idle_task_exit();
+	__this_cpu_write(cpu_state, CPU_DEAD);
+
+	__smp_mb();
+	do {
+		__asm__ __volatile__("nop\n\t");
+		addr = iocsr_read64(LOONGARCH_IOCSR_MBUF0);
+	} while (addr == 0);
+
+	init_fn = (void *)TO_CACHE(addr);
+	iocsr_write32(0xffffffff, LOONGARCH_IOCSR_IPI_CLEAR);
+
+	init_fn();
+	BUG();
+}
+#endif
+
+static void (*play_dead)(void) = idle_play_dead;
+
+void __noreturn arch_cpu_idle_dead(void)
+{
+	play_dead();
+	BUG(); /* play_dead() doesn't return */
+}
+
+#ifdef CONFIG_HIBERNATION
+int hibernate_resume_nonboot_cpu_disable(void)
+{
+	int ret;
+
+	play_dead = poll_play_dead;
+	ret = suspend_disable_secondary_cpus();
+	play_dead = idle_play_dead;
+
+	return ret;
+}
+#endif
+
 #endif
 
 /*
-- 
2.47.1


