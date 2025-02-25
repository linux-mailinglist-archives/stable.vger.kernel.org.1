Return-Path: <stable+bounces-119483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D973A43D6F
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 12:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA023ADA8D
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 11:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD412673AA;
	Tue, 25 Feb 2025 11:18:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3A81A2391;
	Tue, 25 Feb 2025 11:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740482307; cv=none; b=it45fDCXER2FXmAUWebtlaxKeOyvS4/p24XwjGQTRfF0uAGbhAhLqC9ha3BM0AVxRWm3aP8cG1m9hdqRsJKo1mC5EbU9c7aOUE0Ay9uukG/SoeCFZ1XC5LXeoBR/6lOs1mqsSATWphEeFL8jA7dELQtiDBgCTqzWgQwJw7cnwIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740482307; c=relaxed/simple;
	bh=JomRQni8mtKMJrVY4O7G/UiG3MTsVhu0cW37KZeUnKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iMvtulf/9FgkLU5BddHOUs99xP1sEdO+j9mky2VRgK8vfEGXb7SxElA0XQqiH1E1SIQygyTo0BDQmnMEfIHF5414Yy3Y5nt+hpDS1AC/2NdZSxO0YpSEAEnCskuebQhXao8Siq/X8Nxh15YbT1ZfV+RfhtNH/Oqwhst4+GNHxBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91719C4CEDD;
	Tue, 25 Feb 2025 11:18:24 +0000 (UTC)
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
	stable@vger.kernel.org
Subject: [PATCH] LoongArch: Use polling play_dead() when resuming from hibernation
Date: Tue, 25 Feb 2025 19:18:12 +0800
Message-ID: <20250225111812.3065545-1-chenhuacai@loongson.cn>
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
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/smp.c | 40 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index fbf747447f13..308478f29278 100644
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
@@ -447,6 +448,43 @@ void __noreturn arch_cpu_idle_dead(void)
 	BUG();
 }
 
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
+	play_dead = poll_play_dead;
+	return suspend_disable_secondary_cpus();
+}
+#endif
+
 #endif
 
 /*
-- 
2.47.1


