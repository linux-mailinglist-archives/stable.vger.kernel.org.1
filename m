Return-Path: <stable+bounces-21568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E42685C970
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615951C20CB1
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C297C151CEA;
	Tue, 20 Feb 2024 21:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mV/PBHbj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FEC1509AC;
	Tue, 20 Feb 2024 21:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708464820; cv=none; b=eN7bsRSSBVZ9Gn8psaEbmG7SHEHeVkUJuBDIUAn7Uwwey07acOr25nb7DLvjAxuFb0m10n1morfgDRgm8nq8PfJuG6iG4FglWxW4iXtQEATQu9lP9at1n5WmKZt/U6UJYWhY+jl7sIcv/OZBgakjba/gvtkHiASmDSnzXix09lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708464820; c=relaxed/simple;
	bh=SWPsx6KEVassQ34P1q3JG+UKaqIJ2FLHEtkLjBIAYbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lfsAMIFdboik4AdrQtdzN9XAZenPt/k6qbM8/uGYsmoAnLB7whjJ6TbrEXnq728t9ScPlpL6unr/4Nol2AYPRxwqR+dLB/D8gybn14zB0WPpmLQ9sYvGPVBcxPlWL31vT8JCsvKoCrVwPvPJNehDc7EvBAGOohsgl1siNQ045b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mV/PBHbj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014B7C433C7;
	Tue, 20 Feb 2024 21:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708464820;
	bh=SWPsx6KEVassQ34P1q3JG+UKaqIJ2FLHEtkLjBIAYbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mV/PBHbj3wuYhF4Ew/rdIWY4yLbQjriyegg2S96cyHeJBoC+JIYnpoL0rddU3TWuG
	 K1Vz3nUitUdZt8FSrKeKPpy0YGKpJwxiDlXJvdS7zHpb+b9JB3UIeha6xqa73gsE5P
	 Zne+oQZ1pfRESlY48NAMsV6TWkDIgQjvotxu7qcg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 6.7 147/309] parisc: Fix random data corruption from exception handler
Date: Tue, 20 Feb 2024 21:55:06 +0100
Message-ID: <20240220205637.768572618@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220205633.096363225@linuxfoundation.org>
References: <20240220205633.096363225@linuxfoundation.org>
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

From: Helge Deller <deller@gmx.de>

commit 8b1d72395635af45410b66cc4c4ab37a12c4a831 upstream.

The current exception handler implementation, which assists when accessing
user space memory, may exhibit random data corruption if the compiler decides
to use a different register than the specified register %r29 (defined in
ASM_EXCEPTIONTABLE_REG) for the error code. If the compiler choose another
register, the fault handler will nevertheless store -EFAULT into %r29 and thus
trash whatever this register is used for.
Looking at the assembly I found that this happens sometimes in emulate_ldd().

To solve the issue, the easiest solution would be if it somehow is
possible to tell the fault handler which register is used to hold the error
code. Using %0 or %1 in the inline assembly is not posssible as it will show
up as e.g. %r29 (with the "%r" prefix), which the GNU assembler can not
convert to an integer.

This patch takes another, better and more flexible approach:
We extend the __ex_table (which is out of the execution path) by one 32-word.
In this word we tell the compiler to insert the assembler instruction
"or %r0,%r0,%reg", where %reg references the register which the compiler
choosed for the error return code.
In case of an access failure, the fault handler finds the __ex_table entry and
can examine the opcode. The used register is encoded in the lowest 5 bits, and
the fault handler can then store -EFAULT into this register.

Since we extend the __ex_table to 3 words we can't use the BUILDTIME_TABLE_SORT
config option any longer.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: <stable@vger.kernel.org> # v6.0+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/Kconfig                     |    1 
 arch/parisc/include/asm/assembly.h      |    1 
 arch/parisc/include/asm/extable.h       |   64 ++++++++++++++++++++++++++++++++
 arch/parisc/include/asm/special_insns.h |    6 ++-
 arch/parisc/include/asm/uaccess.h       |   48 +++---------------------
 arch/parisc/kernel/cache.c              |    4 +-
 arch/parisc/kernel/unaligned.c          |   44 +++++++++++-----------
 arch/parisc/mm/fault.c                  |   11 ++++-
 8 files changed, 108 insertions(+), 71 deletions(-)
 create mode 100644 arch/parisc/include/asm/extable.h

--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -25,7 +25,6 @@ config PARISC
 	select RTC_DRV_GENERIC
 	select INIT_ALL_POSSIBLE
 	select BUG
-	select BUILDTIME_TABLE_SORT
 	select HAVE_KERNEL_UNCOMPRESSED
 	select HAVE_PCI
 	select HAVE_PERF_EVENTS
--- a/arch/parisc/include/asm/assembly.h
+++ b/arch/parisc/include/asm/assembly.h
@@ -576,6 +576,7 @@
 	.section __ex_table,"aw"			!	\
 	.align 4					!	\
 	.word (fault_addr - .), (except_addr - .)	!	\
+	or %r0,%r0,%r0					!	\
 	.previous
 
 
--- /dev/null
+++ b/arch/parisc/include/asm/extable.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PARISC_EXTABLE_H
+#define __PARISC_EXTABLE_H
+
+#include <asm/ptrace.h>
+#include <linux/compiler.h>
+
+/*
+ * The exception table consists of three addresses:
+ *
+ * - A relative address to the instruction that is allowed to fault.
+ * - A relative address at which the program should continue (fixup routine)
+ * - An asm statement which specifies which CPU register will
+ *   receive -EFAULT when an exception happens if the lowest bit in
+ *   the fixup address is set.
+ *
+ * Note: The register specified in the err_opcode instruction will be
+ * modified at runtime if a fault happens. Register %r0 will be ignored.
+ *
+ * Since relative addresses are used, 32bit values are sufficient even on
+ * 64bit kernel.
+ */
+
+struct pt_regs;
+int fixup_exception(struct pt_regs *regs);
+
+#define ARCH_HAS_RELATIVE_EXTABLE
+struct exception_table_entry {
+	int insn;	/* relative address of insn that is allowed to fault. */
+	int fixup;	/* relative address of fixup routine */
+	int err_opcode; /* sample opcode with register which holds error code */
+};
+
+#define ASM_EXCEPTIONTABLE_ENTRY( fault_addr, except_addr, opcode )\
+	".section __ex_table,\"aw\"\n"			   \
+	".align 4\n"					   \
+	".word (" #fault_addr " - .), (" #except_addr " - .)\n" \
+	opcode "\n"					   \
+	".previous\n"
+
+/*
+ * ASM_EXCEPTIONTABLE_ENTRY_EFAULT() creates a special exception table entry
+ * (with lowest bit set) for which the fault handler in fixup_exception() will
+ * load -EFAULT on fault into the register specified by the err_opcode instruction,
+ * and zeroes the target register in case of a read fault in get_user().
+ */
+#define ASM_EXCEPTIONTABLE_VAR(__err_var)		\
+	int __err_var = 0
+#define ASM_EXCEPTIONTABLE_ENTRY_EFAULT( fault_addr, except_addr, register )\
+	ASM_EXCEPTIONTABLE_ENTRY( fault_addr, except_addr + 1, "or %%r0,%%r0," register)
+
+static inline void swap_ex_entry_fixup(struct exception_table_entry *a,
+				       struct exception_table_entry *b,
+				       struct exception_table_entry tmp,
+				       int delta)
+{
+	a->fixup = b->fixup + delta;
+	b->fixup = tmp.fixup - delta;
+	a->err_opcode = b->err_opcode;
+	b->err_opcode = tmp.err_opcode;
+}
+#define swap_ex_entry_fixup swap_ex_entry_fixup
+
+#endif
--- a/arch/parisc/include/asm/special_insns.h
+++ b/arch/parisc/include/asm/special_insns.h
@@ -8,7 +8,8 @@
 		"copy %%r0,%0\n"			\
 		"8:\tlpa %%r0(%1),%0\n"			\
 		"9:\n"					\
-		ASM_EXCEPTIONTABLE_ENTRY(8b, 9b)	\
+		ASM_EXCEPTIONTABLE_ENTRY(8b, 9b,	\
+				"or %%r0,%%r0,%%r0")	\
 		: "=&r" (pa)				\
 		: "r" (va)				\
 		: "memory"				\
@@ -22,7 +23,8 @@
 		"copy %%r0,%0\n"			\
 		"8:\tlpa %%r0(%%sr3,%1),%0\n"		\
 		"9:\n"					\
-		ASM_EXCEPTIONTABLE_ENTRY(8b, 9b)	\
+		ASM_EXCEPTIONTABLE_ENTRY(8b, 9b,	\
+				"or %%r0,%%r0,%%r0")	\
 		: "=&r" (pa)				\
 		: "r" (va)				\
 		: "memory"				\
--- a/arch/parisc/include/asm/uaccess.h
+++ b/arch/parisc/include/asm/uaccess.h
@@ -7,6 +7,7 @@
  */
 #include <asm/page.h>
 #include <asm/cache.h>
+#include <asm/extable.h>
 
 #include <linux/bug.h>
 #include <linux/string.h>
@@ -26,37 +27,6 @@
 #define STD_USER(sr, x, ptr)	__put_user_asm(sr, "std", x, ptr)
 #endif
 
-/*
- * The exception table contains two values: the first is the relative offset to
- * the address of the instruction that is allowed to fault, and the second is
- * the relative offset to the address of the fixup routine. Since relative
- * addresses are used, 32bit values are sufficient even on 64bit kernel.
- */
-
-#define ARCH_HAS_RELATIVE_EXTABLE
-struct exception_table_entry {
-	int insn;	/* relative address of insn that is allowed to fault. */
-	int fixup;	/* relative address of fixup routine */
-};
-
-#define ASM_EXCEPTIONTABLE_ENTRY( fault_addr, except_addr )\
-	".section __ex_table,\"aw\"\n"			   \
-	".align 4\n"					   \
-	".word (" #fault_addr " - .), (" #except_addr " - .)\n\t" \
-	".previous\n"
-
-/*
- * ASM_EXCEPTIONTABLE_ENTRY_EFAULT() creates a special exception table entry
- * (with lowest bit set) for which the fault handler in fixup_exception() will
- * load -EFAULT into %r29 for a read or write fault, and zeroes the target
- * register in case of a read fault in get_user().
- */
-#define ASM_EXCEPTIONTABLE_REG	29
-#define ASM_EXCEPTIONTABLE_VAR(__variable)		\
-	register long __variable __asm__ ("r29") = 0
-#define ASM_EXCEPTIONTABLE_ENTRY_EFAULT( fault_addr, except_addr )\
-	ASM_EXCEPTIONTABLE_ENTRY( fault_addr, except_addr + 1)
-
 #define __get_user_internal(sr, val, ptr)		\
 ({							\
 	ASM_EXCEPTIONTABLE_VAR(__gu_err);		\
@@ -83,7 +53,7 @@ struct exception_table_entry {
 							\
 	__asm__("1: " ldx " 0(%%sr%2,%3),%0\n"		\
 		"9:\n"					\
-		ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 9b)	\
+		ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 9b, "%1")	\
 		: "=r"(__gu_val), "+r"(__gu_err)        \
 		: "i"(sr), "r"(ptr));			\
 							\
@@ -115,8 +85,8 @@ struct exception_table_entry {
 		"1: ldw 0(%%sr%2,%3),%0\n"		\
 		"2: ldw 4(%%sr%2,%3),%R0\n"		\
 		"9:\n"					\
-		ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 9b)	\
-		ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 9b)	\
+		ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 9b, "%1")	\
+		ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 9b, "%1")	\
 		: "=&r"(__gu_tmp.l), "+r"(__gu_err)	\
 		: "i"(sr), "r"(ptr));			\
 							\
@@ -174,7 +144,7 @@ struct exception_table_entry {
 	__asm__ __volatile__ (					\
 		"1: " stx " %1,0(%%sr%2,%3)\n"			\
 		"9:\n"						\
-		ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 9b)		\
+		ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 9b, "%0")	\
 		: "+r"(__pu_err)				\
 		: "r"(x), "i"(sr), "r"(ptr))
 
@@ -186,15 +156,14 @@ struct exception_table_entry {
 		"1: stw %1,0(%%sr%2,%3)\n"			\
 		"2: stw %R1,4(%%sr%2,%3)\n"			\
 		"9:\n"						\
-		ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 9b)		\
-		ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 9b)		\
+		ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 9b, "%0")	\
+		ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 9b, "%0")	\
 		: "+r"(__pu_err)				\
 		: "r"(__val), "i"(sr), "r"(ptr));		\
 } while (0)
 
 #endif /* !defined(CONFIG_64BIT) */
 
-
 /*
  * Complex access routines -- external declarations
  */
@@ -216,7 +185,4 @@ unsigned long __must_check raw_copy_from
 #define INLINE_COPY_TO_USER
 #define INLINE_COPY_FROM_USER
 
-struct pt_regs;
-int fixup_exception(struct pt_regs *regs);
-
 #endif /* __PARISC_UACCESS_H */
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -850,7 +850,7 @@ SYSCALL_DEFINE3(cacheflush, unsigned lon
 #endif
 			"   fic,m	%3(%4,%0)\n"
 			"2: sync\n"
-			ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 2b)
+			ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 2b, "%1")
 			: "+r" (start), "+r" (error)
 			: "r" (end), "r" (dcache_stride), "i" (SR_USER));
 	}
@@ -865,7 +865,7 @@ SYSCALL_DEFINE3(cacheflush, unsigned lon
 #endif
 			"   fdc,m	%3(%4,%0)\n"
 			"2: sync\n"
-			ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 2b)
+			ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 2b, "%1")
 			: "+r" (start), "+r" (error)
 			: "r" (end), "r" (icache_stride), "i" (SR_USER));
 	}
--- a/arch/parisc/kernel/unaligned.c
+++ b/arch/parisc/kernel/unaligned.c
@@ -120,8 +120,8 @@ static int emulate_ldh(struct pt_regs *r
 "2:	ldbs	1(%%sr1,%3), %0\n"
 "	depw	%2, 23, 24, %0\n"
 "3:	\n"
-	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 3b)
-	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 3b)
+	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 3b, "%1")
+	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 3b, "%1")
 	: "+r" (val), "+r" (ret), "=&r" (temp1)
 	: "r" (saddr), "r" (regs->isr) );
 
@@ -152,8 +152,8 @@ static int emulate_ldw(struct pt_regs *r
 "	mtctl	%2,11\n"
 "	vshd	%0,%3,%0\n"
 "3:	\n"
-	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 3b)
-	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 3b)
+	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 3b, "%1")
+	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 3b, "%1")
 	: "+r" (val), "+r" (ret), "=&r" (temp1), "=&r" (temp2)
 	: "r" (saddr), "r" (regs->isr) );
 
@@ -189,8 +189,8 @@ static int emulate_ldd(struct pt_regs *r
 "	mtsar	%%r19\n"
 "	shrpd	%0,%%r20,%%sar,%0\n"
 "3:	\n"
-	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 3b)
-	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 3b)
+	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 3b, "%1")
+	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 3b, "%1")
 	: "=r" (val), "+r" (ret)
 	: "0" (val), "r" (saddr), "r" (regs->isr)
 	: "r19", "r20" );
@@ -209,9 +209,9 @@ static int emulate_ldd(struct pt_regs *r
 "	vshd	%0,%R0,%0\n"
 "	vshd	%R0,%4,%R0\n"
 "4:	\n"
-	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 4b)
-	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 4b)
-	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(3b, 4b)
+	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 4b, "%1")
+	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 4b, "%1")
+	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(3b, 4b, "%1")
 	: "+r" (val), "+r" (ret), "+r" (saddr), "=&r" (shift), "=&r" (temp1)
 	: "r" (regs->isr) );
     }
@@ -244,8 +244,8 @@ static int emulate_sth(struct pt_regs *r
 "1:	stb %1, 0(%%sr1, %3)\n"
 "2:	stb %2, 1(%%sr1, %3)\n"
 "3:	\n"
-	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 3b)
-	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 3b)
+	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 3b, "%0")
+	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 3b, "%0")
 	: "+r" (ret), "=&r" (temp1)
 	: "r" (val), "r" (regs->ior), "r" (regs->isr) );
 
@@ -285,8 +285,8 @@ static int emulate_stw(struct pt_regs *r
 "	stw	%%r20,0(%%sr1,%2)\n"
 "	stw	%%r21,4(%%sr1,%2)\n"
 "3:	\n"
-	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 3b)
-	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 3b)
+	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 3b, "%0")
+	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 3b, "%0")
 	: "+r" (ret)
 	: "r" (val), "r" (regs->ior), "r" (regs->isr)
 	: "r19", "r20", "r21", "r22", "r1" );
@@ -329,10 +329,10 @@ static int emulate_std(struct pt_regs *r
 "3:	std	%%r20,0(%%sr1,%2)\n"
 "4:	std	%%r21,8(%%sr1,%2)\n"
 "5:	\n"
-	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 5b)
-	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 5b)
-	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(3b, 5b)
-	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(4b, 5b)
+	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 5b, "%0")
+	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 5b, "%0")
+	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(3b, 5b, "%0")
+	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(4b, 5b, "%0")
 	: "+r" (ret)
 	: "r" (val), "r" (regs->ior), "r" (regs->isr)
 	: "r19", "r20", "r21", "r22", "r1" );
@@ -357,11 +357,11 @@ static int emulate_std(struct pt_regs *r
 "4:	stw	%%r1,4(%%sr1,%2)\n"
 "5:	stw	%R1,8(%%sr1,%2)\n"
 "6:	\n"
-	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 6b)
-	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 6b)
-	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(3b, 6b)
-	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(4b, 6b)
-	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(5b, 6b)
+	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 6b, "%0")
+	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 6b, "%0")
+	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(3b, 6b, "%0")
+	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(4b, 6b, "%0")
+	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(5b, 6b, "%0")
 	: "+r" (ret)
 	: "r" (val), "r" (regs->ior), "r" (regs->isr)
 	: "r19", "r20", "r21", "r1" );
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -150,11 +150,16 @@ int fixup_exception(struct pt_regs *regs
 		 * Fix up get_user() and put_user().
 		 * ASM_EXCEPTIONTABLE_ENTRY_EFAULT() sets the least-significant
 		 * bit in the relative address of the fixup routine to indicate
-		 * that gr[ASM_EXCEPTIONTABLE_REG] should be loaded with
-		 * -EFAULT to report a userspace access error.
+		 * that the register encoded in the "or %r0,%r0,register"
+		 * opcode should be loaded with -EFAULT to report a userspace
+		 * access error.
 		 */
 		if (fix->fixup & 1) {
-			regs->gr[ASM_EXCEPTIONTABLE_REG] = -EFAULT;
+			int fault_error_reg = fix->err_opcode & 0x1f;
+			if (!WARN_ON(!fault_error_reg))
+				regs->gr[fault_error_reg] = -EFAULT;
+			pr_debug("Unalignment fixup of register %d at %pS\n",
+				fault_error_reg, (void*)regs->iaoq[0]);
 
 			/* zero target register for get_user() */
 			if (parisc_acctyp(0, regs->iir) == VM_READ) {



