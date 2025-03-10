Return-Path: <stable+bounces-122023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78236A59D8A
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7279216F888
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AED22D799;
	Mon, 10 Mar 2025 17:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="11LPjSnX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B83233136;
	Mon, 10 Mar 2025 17:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627306; cv=none; b=Sr6W3Ua8a+yz0lpAcUl9pVAmItias1pV2WKyt8gC363hrMyiWHmJEGm0VYkMqH3O+jw7inicaMaRQZJYrZ78/B8uKlHORHxJkXqs+lgwsi2OWHQWRQ7/h5ORaqE8s6EgLraRPqJzIqg5hQH6ycsjCOmtDinVD7cXt1fWa0urr2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627306; c=relaxed/simple;
	bh=lN9Plcqy2M4KZnE9ZW6QQ9iaRS6Y+D6GlU6X91kDhaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcywutNVDMKA06N6NTSwoQQHPGVxH0jmeV9JBZHyKipq4y13OpILGrYR/vPV3peVXHMP8vQCpPr9Z7D+XwOJgicKxmHJ/Q85fqE/hHnx9MKdl1rHAeeebyGvJ1k+rlhRIaAn2p71KorQVJV8bevqrPE3fnmgjBVu282SoJOznFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=11LPjSnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37490C4CEED;
	Mon, 10 Mar 2025 17:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741627306;
	bh=lN9Plcqy2M4KZnE9ZW6QQ9iaRS6Y+D6GlU6X91kDhaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=11LPjSnX0u1NWx9+SHYPfqaU6fyUFJV4g/iUAPhRfWtZiCpbiBFaY0NGgIeqrl8eq
	 1ttrK9ZNu95LPyE332x8zxVMHScdVAS16WUVqb1IPf3ct7WRN2Lfj8AuxJuTR1Kj/D
	 vXYO4pAaK+sf77ItXLtlCsH/LkRGfw/uryxYkUho=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Erpeng Xu <xuerpeng@uniontech.com>,
	Yuli Wang <wangyuli@uniontech.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.12 077/269] LoongArch: Use polling play_dead() when resuming from hibernation
Date: Mon, 10 Mar 2025 18:03:50 +0100
Message-ID: <20250310170500.794065489@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170457.700086763@linuxfoundation.org>
References: <20250310170457.700086763@linuxfoundation.org>
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

From: Huacai Chen <chenhuacai@loongson.cn>

commit c9117434c8f7523f0b77db4c5766f5011cc94677 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/kernel/smp.c |   47 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

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



