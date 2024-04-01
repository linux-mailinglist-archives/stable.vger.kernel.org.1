Return-Path: <stable+bounces-34646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CAB894035
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362D61C21488
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D75B4596E;
	Mon,  1 Apr 2024 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kvOCxfYw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0F51CA8F;
	Mon,  1 Apr 2024 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711988823; cv=none; b=HrJ2Wr793dGzUTsT3wbz0a7p2g1MYzFKssjJZNAp9kcvYltf/MFSXZ10tmfjCxUP+YSZu3nC4F0IxtQFPTAqmMe8AnxPiqCToeIUWxSb2VKi1mwsxrml/O80HSvsJ5TS5ZnQIuQcWeLbnKU1adQ4UQ6UKQ/yFmV26shyKZfD8MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711988823; c=relaxed/simple;
	bh=uDCQzKN9hN3eOYHYxZuhOs5O/cCuWeBSQSUhXYeA2fY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDhBgEoX7sc72SRPI6iUx9TvmATO2OpGQ42DnhlBLOdLwTguOhAJXzfNCcEGxmI6Eac5OHyS+T646SGpiYgCRnj929OfTrCtCUC+7t3lylC040AfydJ5R53CJg6+Snt4JPnGRJSN0ZiSODGxj1A/+h/UTi4yCN0WHSi7ovgLEoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kvOCxfYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFBC1C433F1;
	Mon,  1 Apr 2024 16:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711988823;
	bh=uDCQzKN9hN3eOYHYxZuhOs5O/cCuWeBSQSUhXYeA2fY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kvOCxfYwVNtJB7+kcXugV9jVmN1rrMYjEMUxGlW7FJ73A+BV1ETcA4pCSHSaxWBB6
	 hmizcQ8aAqoyPA30vs/n54ex2JJ58mfeiupqBsr30pe/yCAizo+W0LcgQQfIgO7NwV
	 YMu3Kyk7yfL0GeshLEaAMW0ShirKOQLp4jwihXqg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jisheng Zhang <jszhang@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 299/432] ARM: 9352/1: iwmmxt: Remove support for PJ4/PJ4B cores
Date: Mon,  1 Apr 2024 17:44:46 +0200
Message-ID: <20240401152602.104875725@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ardb@kernel.org>

[ Upstream commit b9920fdd5a751df129808e7fa512e9928223ee05 ]

PJ4 is a v7 core that incorporates a iWMMXt coprocessor. However, GCC
does not support this combination (its iWMMXt configuration always
implies v5te), and so there is no v6/v7 user space that actually makes
use of this, beyond generic support for things like setjmp() that
preserve/restore the iWMMXt register file using generic LDC/STC
instructions emitted in assembler.  As [0] appears to imply, this logic
is triggered for the init process at boot, and so most user threads will
have a iWMMXt register context associated with it, even though it is
never used.

At this point, it is highly unlikely that such GCC support will ever
materialize (and Clang does not implement support for iWMMXt to begin
with).

This means that advertising iWMMXt support on these cores results in
context switch overhead without any associated benefit, and so it is
better to simply ignore the iWMMXt unit on these systems. So rip out the
support. Doing so also fixes the issue reported in [0] related to UNDEF
handling of co-processor #0/#1 instructions issued from user space
running in Thumb2 mode.

The PJ4 cores are used in four platforms: Armada 370/xp, Dove (Cubox,
d2plug), MMP2 (xo-1.75) and Berlin (Google TV). Out of these, only the
first is still widely used, but that one actually doesn't have iWMMXt
but instead has only VFPV3-D16, and so it is not impacted by this
change.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218427 [0]

Fixes: 8bcba70cb5c22 ("ARM: entry: Disregard Thumb undef exception ...")
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Nicolas Pitre <nico@fluxnic.net>
Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/Kconfig          |   4 +-
 arch/arm/kernel/Makefile  |   2 -
 arch/arm/kernel/iwmmxt.S  |  51 ++++----------
 arch/arm/kernel/pj4-cp0.c | 135 --------------------------------------
 4 files changed, 15 insertions(+), 177 deletions(-)
 delete mode 100644 arch/arm/kernel/pj4-cp0.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8f47d6762ea4b..f53832383a635 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -591,8 +591,8 @@ source "arch/arm/mm/Kconfig"
 
 config IWMMXT
 	bool "Enable iWMMXt support"
-	depends on CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_PJ4 || CPU_PJ4B
-	default y if PXA27x || PXA3xx || ARCH_MMP || CPU_PJ4 || CPU_PJ4B
+	depends on CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK
+	default y if PXA27x || PXA3xx || ARCH_MMP
 	help
 	  Enable support for iWMMXt context switching at run time if
 	  running on a CPU that supports it.
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 771264d4726a7..ae2f2b2b4e5ab 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -75,8 +75,6 @@ obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_CPU_XSCALE)	+= xscale-cp0.o
 obj-$(CONFIG_CPU_XSC3)		+= xscale-cp0.o
 obj-$(CONFIG_CPU_MOHAWK)	+= xscale-cp0.o
-obj-$(CONFIG_CPU_PJ4)		+= pj4-cp0.o
-obj-$(CONFIG_CPU_PJ4B)		+= pj4-cp0.o
 obj-$(CONFIG_IWMMXT)		+= iwmmxt.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_regs.o perf_callchain.o
 obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event_xscale.o perf_event_v6.o \
diff --git a/arch/arm/kernel/iwmmxt.S b/arch/arm/kernel/iwmmxt.S
index a0218c4867b9b..4a335d3c59690 100644
--- a/arch/arm/kernel/iwmmxt.S
+++ b/arch/arm/kernel/iwmmxt.S
@@ -18,18 +18,6 @@
 #include <asm/assembler.h>
 #include "iwmmxt.h"
 
-#if defined(CONFIG_CPU_PJ4) || defined(CONFIG_CPU_PJ4B)
-#define PJ4(code...)		code
-#define XSC(code...)
-#elif defined(CONFIG_CPU_MOHAWK) || \
-	defined(CONFIG_CPU_XSC3) || \
-	defined(CONFIG_CPU_XSCALE)
-#define PJ4(code...)
-#define XSC(code...)		code
-#else
-#error "Unsupported iWMMXt architecture"
-#endif
-
 #define MMX_WR0		 	(0x00)
 #define MMX_WR1		 	(0x08)
 #define MMX_WR2		 	(0x10)
@@ -81,17 +69,13 @@ ENDPROC(iwmmxt_undef_handler)
 ENTRY(iwmmxt_task_enable)
 	inc_preempt_count r10, r3
 
-	XSC(mrc	p15, 0, r2, c15, c1, 0)
-	PJ4(mrc p15, 0, r2, c1, c0, 2)
+	mrc	p15, 0, r2, c15, c1, 0
 	@ CP0 and CP1 accessible?
-	XSC(tst	r2, #0x3)
-	PJ4(tst	r2, #0xf)
+	tst	r2, #0x3
 	bne	4f				@ if so no business here
 	@ enable access to CP0 and CP1
-	XSC(orr	r2, r2, #0x3)
-	XSC(mcr	p15, 0, r2, c15, c1, 0)
-	PJ4(orr	r2, r2, #0xf)
-	PJ4(mcr	p15, 0, r2, c1, c0, 2)
+	orr	r2, r2, #0x3
+	mcr	p15, 0, r2, c15, c1, 0
 
 	ldr	r3, =concan_owner
 	ldr	r2, [r0, #S_PC]			@ current task pc value
@@ -218,12 +202,9 @@ ENTRY(iwmmxt_task_disable)
 	bne	1f				@ no: quit
 
 	@ enable access to CP0 and CP1
-	XSC(mrc	p15, 0, r4, c15, c1, 0)
-	XSC(orr	r4, r4, #0x3)
-	XSC(mcr	p15, 0, r4, c15, c1, 0)
-	PJ4(mrc p15, 0, r4, c1, c0, 2)
-	PJ4(orr	r4, r4, #0xf)
-	PJ4(mcr	p15, 0, r4, c1, c0, 2)
+	mrc	p15, 0, r4, c15, c1, 0
+	orr	r4, r4, #0x3
+	mcr	p15, 0, r4, c15, c1, 0
 
 	mov	r0, #0				@ nothing to load
 	str	r0, [r3]			@ no more current owner
@@ -232,10 +213,8 @@ ENTRY(iwmmxt_task_disable)
 	bl	concan_save
 
 	@ disable access to CP0 and CP1
-	XSC(bic	r4, r4, #0x3)
-	XSC(mcr	p15, 0, r4, c15, c1, 0)
-	PJ4(bic	r4, r4, #0xf)
-	PJ4(mcr	p15, 0, r4, c1, c0, 2)
+	bic	r4, r4, #0x3
+	mcr	p15, 0, r4, c15, c1, 0
 
 	mrc	p15, 0, r2, c2, c0, 0
 	mov	r2, r2				@ cpwait
@@ -330,11 +309,9 @@ ENDPROC(iwmmxt_task_restore)
  */
 ENTRY(iwmmxt_task_switch)
 
-	XSC(mrc	p15, 0, r1, c15, c1, 0)
-	PJ4(mrc	p15, 0, r1, c1, c0, 2)
+	mrc	p15, 0, r1, c15, c1, 0
 	@ CP0 and CP1 accessible?
-	XSC(tst	r1, #0x3)
-	PJ4(tst	r1, #0xf)
+	tst	r1, #0x3
 	bne	1f				@ yes: block them for next task
 
 	ldr	r2, =concan_owner
@@ -344,10 +321,8 @@ ENTRY(iwmmxt_task_switch)
 	retne	lr				@ no: leave Concan disabled
 
 1:	@ flip Concan access
-	XSC(eor	r1, r1, #0x3)
-	XSC(mcr	p15, 0, r1, c15, c1, 0)
-	PJ4(eor r1, r1, #0xf)
-	PJ4(mcr	p15, 0, r1, c1, c0, 2)
+	eor	r1, r1, #0x3
+	mcr	p15, 0, r1, c15, c1, 0
 
 	mrc	p15, 0, r1, c2, c0, 0
 	sub	pc, lr, r1, lsr #32		@ cpwait and return
diff --git a/arch/arm/kernel/pj4-cp0.c b/arch/arm/kernel/pj4-cp0.c
deleted file mode 100644
index 4bca8098c4ff5..0000000000000
--- a/arch/arm/kernel/pj4-cp0.c
+++ /dev/null
@@ -1,135 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * linux/arch/arm/kernel/pj4-cp0.c
- *
- * PJ4 iWMMXt coprocessor context switching and handling
- *
- * Copyright (c) 2010 Marvell International Inc.
- */
-
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <asm/thread_notify.h>
-#include <asm/cputype.h>
-
-static int iwmmxt_do(struct notifier_block *self, unsigned long cmd, void *t)
-{
-	struct thread_info *thread = t;
-
-	switch (cmd) {
-	case THREAD_NOTIFY_FLUSH:
-		/*
-		 * flush_thread() zeroes thread->fpstate, so no need
-		 * to do anything here.
-		 *
-		 * FALLTHROUGH: Ensure we don't try to overwrite our newly
-		 * initialised state information on the first fault.
-		 */
-
-	case THREAD_NOTIFY_EXIT:
-		iwmmxt_task_release(thread);
-		break;
-
-	case THREAD_NOTIFY_SWITCH:
-		iwmmxt_task_switch(thread);
-		break;
-	}
-
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block __maybe_unused iwmmxt_notifier_block = {
-	.notifier_call	= iwmmxt_do,
-};
-
-
-static u32 __init pj4_cp_access_read(void)
-{
-	u32 value;
-
-	__asm__ __volatile__ (
-		"mrc	p15, 0, %0, c1, c0, 2\n\t"
-		: "=r" (value));
-	return value;
-}
-
-static void __init pj4_cp_access_write(u32 value)
-{
-	u32 temp;
-
-	__asm__ __volatile__ (
-		"mcr	p15, 0, %1, c1, c0, 2\n\t"
-#ifdef CONFIG_THUMB2_KERNEL
-		"isb\n\t"
-#else
-		"mrc	p15, 0, %0, c1, c0, 2\n\t"
-		"mov	%0, %0\n\t"
-		"sub	pc, pc, #4\n\t"
-#endif
-		: "=r" (temp) : "r" (value));
-}
-
-static int __init pj4_get_iwmmxt_version(void)
-{
-	u32 cp_access, wcid;
-
-	cp_access = pj4_cp_access_read();
-	pj4_cp_access_write(cp_access | 0xf);
-
-	/* check if coprocessor 0 and 1 are available */
-	if ((pj4_cp_access_read() & 0xf) != 0xf) {
-		pj4_cp_access_write(cp_access);
-		return -ENODEV;
-	}
-
-	/* read iWMMXt coprocessor id register p1, c0 */
-	__asm__ __volatile__ ("mrc    p1, 0, %0, c0, c0, 0\n" : "=r" (wcid));
-
-	pj4_cp_access_write(cp_access);
-
-	/* iWMMXt v1 */
-	if ((wcid & 0xffffff00) == 0x56051000)
-		return 1;
-	/* iWMMXt v2 */
-	if ((wcid & 0xffffff00) == 0x56052000)
-		return 2;
-
-	return -EINVAL;
-}
-
-/*
- * Disable CP0/CP1 on boot, and let call_fpe() and the iWMMXt lazy
- * switch code handle iWMMXt context switching.
- */
-static int __init pj4_cp0_init(void)
-{
-	u32 __maybe_unused cp_access;
-	int vers;
-
-	if (!cpu_is_pj4())
-		return 0;
-
-	vers = pj4_get_iwmmxt_version();
-	if (vers < 0)
-		return 0;
-
-#ifndef CONFIG_IWMMXT
-	pr_info("PJ4 iWMMXt coprocessor detected, but kernel support is missing.\n");
-#else
-	cp_access = pj4_cp_access_read() & ~0xf;
-	pj4_cp_access_write(cp_access);
-
-	pr_info("PJ4 iWMMXt v%d coprocessor enabled.\n", vers);
-	elf_hwcap |= HWCAP_IWMMXT;
-	thread_register_notifier(&iwmmxt_notifier_block);
-	register_iwmmxt_undef_handler();
-#endif
-
-	return 0;
-}
-
-late_initcall(pj4_cp0_init);
-- 
2.43.0




