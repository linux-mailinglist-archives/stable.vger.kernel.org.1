Return-Path: <stable+bounces-38841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E22BD8A10AA
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4544FB25324
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0790147C69;
	Thu, 11 Apr 2024 10:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WJuLUPXw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2051474D7;
	Thu, 11 Apr 2024 10:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831750; cv=none; b=TxQ4m7dYK4ETih0kNIUl/TJ1Zo+E1xEpc/byL0rTEe9aESASlqGOIR78hXKJ0k/94rrwSNAOcdow/ne27nMDZTxoXjA3zRd4wzOFJtoojliHC53HpaNHWZ9G3RwECDCua5+dLEnTi2+EB/02vaWzpWI1eWQI8xxDS3PkbBYbZe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831750; c=relaxed/simple;
	bh=7Lm7xgn4H6iaRiUL1UHr94mUP2blkXHPpMghuXokvEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H26FV+y+PINNkpDvJt/e6ciCQj99iimBwzf8qJQ14EvoDlZIZ5qKW7nLIoJ2uZXTWXTYS/Gk8PmZF7V1J0osTmhIafNdv0v5jvVkpUWpxNCPm/2DBzppSx7mKEkXDlVcllTFPDbzxsuUxHKXZ563ongzM6ckNInFyMXxogBOEaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WJuLUPXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3B2C433F1;
	Thu, 11 Apr 2024 10:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712831750;
	bh=7Lm7xgn4H6iaRiUL1UHr94mUP2blkXHPpMghuXokvEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WJuLUPXwTLjvFHY/uU4EvifqSkZ+8EAjc64w+AkbP6t21pM7Y8hmb5nmXekrTYsuE
	 rlOGy84LL4zkk7HMCUyH57pRJ2c9v1qL1RbdX/iMFskWogMsUdVPxmxpzhzTQAiwwV
	 CfnHTacatYr/luXkW2CcYXsAvjoP9vvstXu57BLY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 114/294] x86/stackprotector/32: Make the canary into a regular percpu variable
Date: Thu, 11 Apr 2024 11:54:37 +0200
Message-ID: <20240411095439.101219687@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095435.633465671@linuxfoundation.org>
References: <20240411095435.633465671@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

[ Upstream commit 3fb0fdb3bbe7aed495109b3296b06c2409734023 ]

On 32-bit kernels, the stackprotector canary is quite nasty -- it is
stored at %gs:(20), which is nasty because 32-bit kernels use %fs for
percpu storage.  It's even nastier because it means that whether %gs
contains userspace state or kernel state while running kernel code
depends on whether stackprotector is enabled (this is
CONFIG_X86_32_LAZY_GS), and this setting radically changes the way
that segment selectors work.  Supporting both variants is a
maintenance and testing mess.

Merely rearranging so that percpu and the stack canary
share the same segment would be messy as the 32-bit percpu address
layout isn't currently compatible with putting a variable at a fixed
offset.

Fortunately, GCC 8.1 added options that allow the stack canary to be
accessed as %fs:__stack_chk_guard, effectively turning it into an ordinary
percpu variable.  This lets us get rid of all of the code to manage the
stack canary GDT descriptor and the CONFIG_X86_32_LAZY_GS mess.

(That name is special.  We could use any symbol we want for the
 %fs-relative mode, but for CONFIG_SMP=n, gcc refuses to let us use any
 name other than __stack_chk_guard.)

Forcibly disable stackprotector on older compilers that don't support
the new options and turn the stack canary into a percpu variable. The
"lazy GS" approach is now used for all 32-bit configurations.

Also makes load_gs_index() work on 32-bit kernels. On 64-bit kernels,
it loads the GS selector and updates the user GSBASE accordingly. (This
is unchanged.) On 32-bit kernels, it loads the GS selector and updates
GSBASE, which is now always the user base. This means that the overall
effect is the same on 32-bit and 64-bit, which avoids some ifdeffery.

 [ bp: Massage commit message. ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/c0ff7dba14041c7e5d1cae5d4df052f03759bef3.1613243844.git.luto@kernel.org
Stable-dep-of: e3f269ed0acc ("x86/pm: Work around false positive kmemleak report in msr_build_context()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/Kconfig                          |  7 +-
 arch/x86/Makefile                         |  8 +++
 arch/x86/entry/entry_32.S                 | 56 ++--------------
 arch/x86/include/asm/processor.h          | 15 ++---
 arch/x86/include/asm/ptrace.h             |  5 +-
 arch/x86/include/asm/segment.h            | 30 +++------
 arch/x86/include/asm/stackprotector.h     | 79 +++++------------------
 arch/x86/include/asm/suspend_32.h         |  6 +-
 arch/x86/kernel/asm-offsets_32.c          |  5 --
 arch/x86/kernel/cpu/common.c              |  5 +-
 arch/x86/kernel/doublefault_32.c          |  4 +-
 arch/x86/kernel/head_32.S                 | 18 +-----
 arch/x86/kernel/setup_percpu.c            |  1 -
 arch/x86/kernel/tls.c                     |  8 +--
 arch/x86/lib/insn-eval.c                  |  4 --
 arch/x86/platform/pvh/head.S              | 14 ----
 arch/x86/power/cpu.c                      |  6 +-
 arch/x86/xen/enlighten_pv.c               |  1 -
 scripts/gcc-x86_32-has-stack-protector.sh |  6 +-
 19 files changed, 60 insertions(+), 218 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6dc670e363939..47c94e9de03e4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -352,10 +352,6 @@ config X86_64_SMP
 	def_bool y
 	depends on X86_64 && SMP
 
-config X86_32_LAZY_GS
-	def_bool y
-	depends on X86_32 && !STACKPROTECTOR
-
 config ARCH_SUPPORTS_UPROBES
 	def_bool y
 
@@ -378,7 +374,8 @@ config CC_HAS_SANE_STACKPROTECTOR
 	default $(success,$(srctree)/scripts/gcc-x86_32-has-stack-protector.sh $(CC))
 	help
 	   We have to make sure stack protector is unconditionally disabled if
-	   the compiler produces broken code.
+	   the compiler produces broken code or if it does not let us control
+	   the segment on 32-bit kernels.
 
 menu "Processor type and features"
 
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1f796050c6dde..8b9fa777f513b 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -87,6 +87,14 @@ ifeq ($(CONFIG_X86_32),y)
 
         # temporary until string.h is fixed
         KBUILD_CFLAGS += -ffreestanding
+
+	ifeq ($(CONFIG_STACKPROTECTOR),y)
+		ifeq ($(CONFIG_SMP),y)
+			KBUILD_CFLAGS += -mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard
+		else
+			KBUILD_CFLAGS += -mstack-protector-guard=global
+		endif
+	endif
 else
         BITS := 64
         UTS_MACHINE := x86_64
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 70bd81b6c612e..10b7c62a3e97a 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -20,7 +20,7 @@
  *	1C(%esp) - %ds
  *	20(%esp) - %es
  *	24(%esp) - %fs
- *	28(%esp) - %gs		saved iff !CONFIG_X86_32_LAZY_GS
+ *	28(%esp) - unused -- was %gs on old stackprotector kernels
  *	2C(%esp) - orig_eax
  *	30(%esp) - %eip
  *	34(%esp) - %cs
@@ -56,14 +56,9 @@
 /*
  * User gs save/restore
  *
- * %gs is used for userland TLS and kernel only uses it for stack
- * canary which is required to be at %gs:20 by gcc.  Read the comment
- * at the top of stackprotector.h for more info.
- *
- * Local labels 98 and 99 are used.
+ * This is leftover junk from CONFIG_X86_32_LAZY_GS.  A subsequent patch
+ * will remove it entirely.
  */
-#ifdef CONFIG_X86_32_LAZY_GS
-
  /* unfortunately push/pop can't be no-op */
 .macro PUSH_GS
 	pushl	$0
@@ -86,49 +81,6 @@
 .macro SET_KERNEL_GS reg
 .endm
 
-#else	/* CONFIG_X86_32_LAZY_GS */
-
-.macro PUSH_GS
-	pushl	%gs
-.endm
-
-.macro POP_GS pop=0
-98:	popl	%gs
-  .if \pop <> 0
-	add	$\pop, %esp
-  .endif
-.endm
-.macro POP_GS_EX
-.pushsection .fixup, "ax"
-99:	movl	$0, (%esp)
-	jmp	98b
-.popsection
-	_ASM_EXTABLE(98b, 99b)
-.endm
-
-.macro PTGS_TO_GS
-98:	mov	PT_GS(%esp), %gs
-.endm
-.macro PTGS_TO_GS_EX
-.pushsection .fixup, "ax"
-99:	movl	$0, PT_GS(%esp)
-	jmp	98b
-.popsection
-	_ASM_EXTABLE(98b, 99b)
-.endm
-
-.macro GS_TO_REG reg
-	movl	%gs, \reg
-.endm
-.macro REG_TO_PTGS reg
-	movl	\reg, PT_GS(%esp)
-.endm
-.macro SET_KERNEL_GS reg
-	movl	$(__KERNEL_STACK_CANARY), \reg
-	movl	\reg, %gs
-.endm
-
-#endif /* CONFIG_X86_32_LAZY_GS */
 
 /* Unconditionally switch to user cr3 */
 .macro SWITCH_TO_USER_CR3 scratch_reg:req
@@ -779,7 +731,7 @@ SYM_CODE_START(__switch_to_asm)
 
 #ifdef CONFIG_STACKPROTECTOR
 	movl	TASK_stack_canary(%edx), %ebx
-	movl	%ebx, PER_CPU_VAR(stack_canary)+stack_canary_offset
+	movl	%ebx, PER_CPU_VAR(__stack_chk_guard)
 #endif
 
 	/*
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index d7e017b0b4c3b..6dc3c5f0be076 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -441,6 +441,9 @@ struct fixed_percpu_data {
 	 * GCC hardcodes the stack canary as %gs:40.  Since the
 	 * irq_stack is the object at %gs:0, we reserve the bottom
 	 * 48 bytes of the irq stack for the canary.
+	 *
+	 * Once we are willing to require -mstack-protector-guard-symbol=
+	 * support for x86_64 stackprotector, we can get rid of this.
 	 */
 	char		gs_base[40];
 	unsigned long	stack_canary;
@@ -461,17 +464,7 @@ extern asmlinkage void ignore_sysret(void);
 void current_save_fsgs(void);
 #else	/* X86_64 */
 #ifdef CONFIG_STACKPROTECTOR
-/*
- * Make sure stack canary segment base is cached-aligned:
- *   "For Intel Atom processors, avoid non zero segment base address
- *    that is not aligned to cache line boundary at all cost."
- * (Optim Ref Manual Assembly/Compiler Coding Rule 15.)
- */
-struct stack_canary {
-	char __pad[20];		/* canary at %gs:20 */
-	unsigned long canary;
-};
-DECLARE_PER_CPU_ALIGNED(struct stack_canary, stack_canary);
+DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
 #endif
 /* Per CPU softirq stack pointer */
 DECLARE_PER_CPU(struct irq_stack *, softirq_stack_ptr);
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 409f661481e11..b94f615600d57 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -37,7 +37,10 @@ struct pt_regs {
 	unsigned short __esh;
 	unsigned short fs;
 	unsigned short __fsh;
-	/* On interrupt, gs and __gsh store the vector number. */
+	/*
+	 * On interrupt, gs and __gsh store the vector number.  They never
+	 * store gs any more.
+	 */
 	unsigned short gs;
 	unsigned short __gsh;
 	/* On interrupt, this is the error code. */
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 7fdd4facfce71..72044026eb3c2 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -95,7 +95,7 @@
  *
  *  26 - ESPFIX small SS
  *  27 - per-cpu			[ offset to per-cpu data area ]
- *  28 - stack_canary-20		[ for stack protector ]		<=== cacheline #8
+ *  28 - unused
  *  29 - unused
  *  30 - unused
  *  31 - TSS for double fault handler
@@ -118,7 +118,6 @@
 
 #define GDT_ENTRY_ESPFIX_SS		26
 #define GDT_ENTRY_PERCPU		27
-#define GDT_ENTRY_STACK_CANARY		28
 
 #define GDT_ENTRY_DOUBLEFAULT_TSS	31
 
@@ -158,12 +157,6 @@
 # define __KERNEL_PERCPU		0
 #endif
 
-#ifdef CONFIG_STACKPROTECTOR
-# define __KERNEL_STACK_CANARY		(GDT_ENTRY_STACK_CANARY*8)
-#else
-# define __KERNEL_STACK_CANARY		0
-#endif
-
 #else /* 64-bit: */
 
 #include <asm/cache.h>
@@ -364,22 +357,15 @@ static inline void __loadsegment_fs(unsigned short value)
 	asm("mov %%" #seg ",%0":"=r" (value) : : "memory")
 
 /*
- * x86-32 user GS accessors:
+ * x86-32 user GS accessors.  This is ugly and could do with some cleaning up.
  */
 #ifdef CONFIG_X86_32
-# ifdef CONFIG_X86_32_LAZY_GS
-#  define get_user_gs(regs)		(u16)({ unsigned long v; savesegment(gs, v); v; })
-#  define set_user_gs(regs, v)		loadsegment(gs, (unsigned long)(v))
-#  define task_user_gs(tsk)		((tsk)->thread.gs)
-#  define lazy_save_gs(v)		savesegment(gs, (v))
-#  define lazy_load_gs(v)		loadsegment(gs, (v))
-# else	/* X86_32_LAZY_GS */
-#  define get_user_gs(regs)		(u16)((regs)->gs)
-#  define set_user_gs(regs, v)		do { (regs)->gs = (v); } while (0)
-#  define task_user_gs(tsk)		(task_pt_regs(tsk)->gs)
-#  define lazy_save_gs(v)		do { } while (0)
-#  define lazy_load_gs(v)		do { } while (0)
-# endif	/* X86_32_LAZY_GS */
+# define get_user_gs(regs)		(u16)({ unsigned long v; savesegment(gs, v); v; })
+# define set_user_gs(regs, v)		loadsegment(gs, (unsigned long)(v))
+# define task_user_gs(tsk)		((tsk)->thread.gs)
+# define lazy_save_gs(v)		savesegment(gs, (v))
+# define lazy_load_gs(v)		loadsegment(gs, (v))
+# define load_gs_index(v)		loadsegment(gs, (v))
 #endif	/* X86_32 */
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index 7fb482f0f25b0..b6ffe58c70fab 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -5,30 +5,23 @@
  * Stack protector works by putting predefined pattern at the start of
  * the stack frame and verifying that it hasn't been overwritten when
  * returning from the function.  The pattern is called stack canary
- * and unfortunately gcc requires it to be at a fixed offset from %gs.
- * On x86_64, the offset is 40 bytes and on x86_32 20 bytes.  x86_64
- * and x86_32 use segment registers differently and thus handles this
- * requirement differently.
+ * and unfortunately gcc historically required it to be at a fixed offset
+ * from the percpu segment base.  On x86_64, the offset is 40 bytes.
  *
- * On x86_64, %gs is shared by percpu area and stack canary.  All
- * percpu symbols are zero based and %gs points to the base of percpu
- * area.  The first occupant of the percpu area is always
- * fixed_percpu_data which contains stack_canary at offset 40.  Userland
- * %gs is always saved and restored on kernel entry and exit using
- * swapgs, so stack protector doesn't add any complexity there.
+ * The same segment is shared by percpu area and stack canary.  On
+ * x86_64, percpu symbols are zero based and %gs (64-bit) points to the
+ * base of percpu area.  The first occupant of the percpu area is always
+ * fixed_percpu_data which contains stack_canary at the approproate
+ * offset.  On x86_32, the stack canary is just a regular percpu
+ * variable.
  *
- * On x86_32, it's slightly more complicated.  As in x86_64, %gs is
- * used for userland TLS.  Unfortunately, some processors are much
- * slower at loading segment registers with different value when
- * entering and leaving the kernel, so the kernel uses %fs for percpu
- * area and manages %gs lazily so that %gs is switched only when
- * necessary, usually during task switch.
+ * Putting percpu data in %fs on 32-bit is a minor optimization compared to
+ * using %gs.  Since 32-bit userspace normally has %fs == 0, we are likely
+ * to load 0 into %fs on exit to usermode, whereas with percpu data in
+ * %gs, we are likely to load a non-null %gs on return to user mode.
  *
- * As gcc requires the stack canary at %gs:20, %gs can't be managed
- * lazily if stack protector is enabled, so the kernel saves and
- * restores userland %gs on kernel entry and exit.  This behavior is
- * controlled by CONFIG_X86_32_LAZY_GS and accessors are defined in
- * system.h to hide the details.
+ * Once we are willing to require GCC 8.1 or better for 64-bit stackprotector
+ * support, we can remove some of this complexity.
  */
 
 #ifndef _ASM_STACKPROTECTOR_H
@@ -44,14 +37,6 @@
 #include <linux/random.h>
 #include <linux/sched.h>
 
-/*
- * 24 byte read-only segment initializer for stack canary.  Linker
- * can't handle the address bit shifting.  Address will be set in
- * head_32 for boot CPU and setup_per_cpu_areas() for others.
- */
-#define GDT_STACK_CANARY_INIT						\
-	[GDT_ENTRY_STACK_CANARY] = GDT_ENTRY_INIT(0x4090, 0, 0x18),
-
 /*
  * Initialize the stackprotector canary value.
  *
@@ -86,7 +71,7 @@ static __always_inline void boot_init_stack_canary(void)
 #ifdef CONFIG_X86_64
 	this_cpu_write(fixed_percpu_data.stack_canary, canary);
 #else
-	this_cpu_write(stack_canary.canary, canary);
+	this_cpu_write(__stack_chk_guard, canary);
 #endif
 }
 
@@ -95,48 +80,16 @@ static inline void cpu_init_stack_canary(int cpu, struct task_struct *idle)
 #ifdef CONFIG_X86_64
 	per_cpu(fixed_percpu_data.stack_canary, cpu) = idle->stack_canary;
 #else
-	per_cpu(stack_canary.canary, cpu) = idle->stack_canary;
-#endif
-}
-
-static inline void setup_stack_canary_segment(int cpu)
-{
-#ifdef CONFIG_X86_32
-	unsigned long canary = (unsigned long)&per_cpu(stack_canary, cpu);
-	struct desc_struct *gdt_table = get_cpu_gdt_rw(cpu);
-	struct desc_struct desc;
-
-	desc = gdt_table[GDT_ENTRY_STACK_CANARY];
-	set_desc_base(&desc, canary);
-	write_gdt_entry(gdt_table, GDT_ENTRY_STACK_CANARY, &desc, DESCTYPE_S);
-#endif
-}
-
-static inline void load_stack_canary_segment(void)
-{
-#ifdef CONFIG_X86_32
-	asm("mov %0, %%gs" : : "r" (__KERNEL_STACK_CANARY) : "memory");
+	per_cpu(__stack_chk_guard, cpu) = idle->stack_canary;
 #endif
 }
 
 #else	/* STACKPROTECTOR */
 
-#define GDT_STACK_CANARY_INIT
-
 /* dummy boot_init_stack_canary() is defined in linux/stackprotector.h */
 
-static inline void setup_stack_canary_segment(int cpu)
-{ }
-
 static inline void cpu_init_stack_canary(int cpu, struct task_struct *idle)
 { }
 
-static inline void load_stack_canary_segment(void)
-{
-#ifdef CONFIG_X86_32
-	asm volatile ("mov %0, %%gs" : : "r" (0));
-#endif
-}
-
 #endif	/* STACKPROTECTOR */
 #endif	/* _ASM_STACKPROTECTOR_H */
diff --git a/arch/x86/include/asm/suspend_32.h b/arch/x86/include/asm/suspend_32.h
index 3b97aa9215430..a800abb1a9925 100644
--- a/arch/x86/include/asm/suspend_32.h
+++ b/arch/x86/include/asm/suspend_32.h
@@ -13,12 +13,10 @@
 /* image of the saved processor state */
 struct saved_context {
 	/*
-	 * On x86_32, all segment registers, with the possible exception of
-	 * gs, are saved at kernel entry in pt_regs.
+	 * On x86_32, all segment registers except gs are saved at kernel
+	 * entry in pt_regs.
 	 */
-#ifdef CONFIG_X86_32_LAZY_GS
 	u16 gs;
-#endif
 	unsigned long cr0, cr2, cr3, cr4;
 	u64 misc_enable;
 	struct saved_msrs saved_msrs;
diff --git a/arch/x86/kernel/asm-offsets_32.c b/arch/x86/kernel/asm-offsets_32.c
index 6e043f295a605..2b411cd00a4e2 100644
--- a/arch/x86/kernel/asm-offsets_32.c
+++ b/arch/x86/kernel/asm-offsets_32.c
@@ -53,11 +53,6 @@ void foo(void)
 	       offsetof(struct cpu_entry_area, tss.x86_tss.sp1) -
 	       offsetofend(struct cpu_entry_area, entry_stack_page.stack));
 
-#ifdef CONFIG_STACKPROTECTOR
-	BLANK();
-	OFFSET(stack_canary_offset, stack_canary, canary);
-#endif
-
 	BLANK();
 	DEFINE(EFI_svam, offsetof(efi_runtime_services_t, set_virtual_address_map));
 }
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0c72ff732aa08..33002cb5a1c62 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -166,7 +166,6 @@ DEFINE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page) = { .gdt = {
 
 	[GDT_ENTRY_ESPFIX_SS]		= GDT_ENTRY_INIT(0xc092, 0, 0xfffff),
 	[GDT_ENTRY_PERCPU]		= GDT_ENTRY_INIT(0xc092, 0, 0xfffff),
-	GDT_STACK_CANARY_INIT
 #endif
 } };
 EXPORT_PER_CPU_SYMBOL_GPL(gdt_page);
@@ -600,7 +599,6 @@ void load_percpu_segment(int cpu)
 	__loadsegment_simple(gs, 0);
 	wrmsrl(MSR_GS_BASE, cpu_kernelmode_gs_base(cpu));
 #endif
-	load_stack_canary_segment();
 }
 
 #ifdef CONFIG_X86_32
@@ -1940,7 +1938,8 @@ DEFINE_PER_CPU(unsigned long, cpu_current_top_of_stack) =
 EXPORT_PER_CPU_SYMBOL(cpu_current_top_of_stack);
 
 #ifdef CONFIG_STACKPROTECTOR
-DEFINE_PER_CPU_ALIGNED(struct stack_canary, stack_canary);
+DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
+EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
 #endif
 
 #endif	/* CONFIG_X86_64 */
diff --git a/arch/x86/kernel/doublefault_32.c b/arch/x86/kernel/doublefault_32.c
index 759d392cbe9f0..d1d49e3d536b8 100644
--- a/arch/x86/kernel/doublefault_32.c
+++ b/arch/x86/kernel/doublefault_32.c
@@ -100,9 +100,7 @@ DEFINE_PER_CPU_PAGE_ALIGNED(struct doublefault_stack, doublefault_stack) = {
 		.ss		= __KERNEL_DS,
 		.ds		= __USER_DS,
 		.fs		= __KERNEL_PERCPU,
-#ifndef CONFIG_X86_32_LAZY_GS
-		.gs		= __KERNEL_STACK_CANARY,
-#endif
+		.gs		= 0,
 
 		.__cr3		= __pa_nodebug(swapper_pg_dir),
 	},
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 3f1691b89231f..0359333f6bdee 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -319,8 +319,8 @@ SYM_FUNC_START(startup_32_smp)
 	movl $(__KERNEL_PERCPU), %eax
 	movl %eax,%fs			# set this cpu's percpu
 
-	movl $(__KERNEL_STACK_CANARY),%eax
-	movl %eax,%gs
+	xorl %eax,%eax
+	movl %eax,%gs			# clear possible garbage in %gs
 
 	xorl %eax,%eax			# Clear LDT
 	lldt %ax
@@ -340,20 +340,6 @@ SYM_FUNC_END(startup_32_smp)
  */
 __INIT
 setup_once:
-#ifdef CONFIG_STACKPROTECTOR
-	/*
-	 * Configure the stack canary. The linker can't handle this by
-	 * relocation.  Manually set base address in stack canary
-	 * segment descriptor.
-	 */
-	movl $gdt_page,%eax
-	movl $stack_canary,%ecx
-	movw %cx, 8 * GDT_ENTRY_STACK_CANARY + 2(%eax)
-	shrl $16, %ecx
-	movb %cl, 8 * GDT_ENTRY_STACK_CANARY + 4(%eax)
-	movb %ch, 8 * GDT_ENTRY_STACK_CANARY + 7(%eax)
-#endif
-
 	andl $0,setup_once_ref	/* Once is enough, thanks */
 	RET
 
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index fd945ce78554e..0941d2f44f2a2 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -224,7 +224,6 @@ void __init setup_per_cpu_areas(void)
 		per_cpu(this_cpu_off, cpu) = per_cpu_offset(cpu);
 		per_cpu(cpu_number, cpu) = cpu;
 		setup_percpu_segment(cpu);
-		setup_stack_canary_segment(cpu);
 		/*
 		 * Copy data used in early init routines from the
 		 * initial arrays to the per cpu data areas.  These
diff --git a/arch/x86/kernel/tls.c b/arch/x86/kernel/tls.c
index 64a496a0687f6..3c883e0642424 100644
--- a/arch/x86/kernel/tls.c
+++ b/arch/x86/kernel/tls.c
@@ -164,17 +164,11 @@ int do_set_thread_area(struct task_struct *p, int idx,
 		savesegment(fs, sel);
 		if (sel == modified_sel)
 			loadsegment(fs, sel);
-
-		savesegment(gs, sel);
-		if (sel == modified_sel)
-			load_gs_index(sel);
 #endif
 
-#ifdef CONFIG_X86_32_LAZY_GS
 		savesegment(gs, sel);
 		if (sel == modified_sel)
-			loadsegment(gs, sel);
-#endif
+			load_gs_index(sel);
 	} else {
 #ifdef CONFIG_X86_64
 		if (p->thread.fsindex == modified_sel)
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index ffc8b7dcf1feb..6ed542e310adc 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -404,10 +404,6 @@ static short get_segment_selector(struct pt_regs *regs, int seg_reg_idx)
 	case INAT_SEG_REG_FS:
 		return (unsigned short)(regs->fs & 0xffff);
 	case INAT_SEG_REG_GS:
-		/*
-		 * GS may or may not be in regs as per CONFIG_X86_32_LAZY_GS.
-		 * The macro below takes care of both cases.
-		 */
 		return get_user_gs(regs);
 	case INAT_SEG_REG_IGNORE:
 	default:
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 43b4d864817ec..afbf0bb252da5 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -45,10 +45,8 @@
 
 #define PVH_GDT_ENTRY_CS	1
 #define PVH_GDT_ENTRY_DS	2
-#define PVH_GDT_ENTRY_CANARY	3
 #define PVH_CS_SEL		(PVH_GDT_ENTRY_CS * 8)
 #define PVH_DS_SEL		(PVH_GDT_ENTRY_DS * 8)
-#define PVH_CANARY_SEL		(PVH_GDT_ENTRY_CANARY * 8)
 
 SYM_CODE_START_LOCAL(pvh_start_xen)
 	cld
@@ -109,17 +107,6 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 
 #else /* CONFIG_X86_64 */
 
-	/* Set base address in stack canary descriptor. */
-	movl $_pa(gdt_start),%eax
-	movl $_pa(canary),%ecx
-	movw %cx, (PVH_GDT_ENTRY_CANARY * 8) + 2(%eax)
-	shrl $16, %ecx
-	movb %cl, (PVH_GDT_ENTRY_CANARY * 8) + 4(%eax)
-	movb %ch, (PVH_GDT_ENTRY_CANARY * 8) + 7(%eax)
-
-	mov $PVH_CANARY_SEL,%eax
-	mov %eax,%gs
-
 	call mk_early_pgtbl_32
 
 	mov $_pa(initial_page_table), %eax
@@ -163,7 +150,6 @@ SYM_DATA_START_LOCAL(gdt_start)
 	.quad GDT_ENTRY(0xc09a, 0, 0xfffff) /* PVH_CS_SEL */
 #endif
 	.quad GDT_ENTRY(0xc092, 0, 0xfffff) /* PVH_DS_SEL */
-	.quad GDT_ENTRY(0x4090, 0, 0x18)    /* PVH_CANARY_SEL */
 SYM_DATA_END_LABEL(gdt_start, SYM_L_LOCAL, gdt_end)
 
 	.balign 16
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 4e4e76ecd3ecd..84c7b2312ea9e 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -101,11 +101,8 @@ static void __save_processor_state(struct saved_context *ctxt)
 	/*
 	 * segment registers
 	 */
-#ifdef CONFIG_X86_32_LAZY_GS
 	savesegment(gs, ctxt->gs);
-#endif
 #ifdef CONFIG_X86_64
-	savesegment(gs, ctxt->gs);
 	savesegment(fs, ctxt->fs);
 	savesegment(ds, ctxt->ds);
 	savesegment(es, ctxt->es);
@@ -234,7 +231,6 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	wrmsrl(MSR_GS_BASE, ctxt->kernelmode_gs_base);
 #else
 	loadsegment(fs, __KERNEL_PERCPU);
-	loadsegment(gs, __KERNEL_STACK_CANARY);
 #endif
 
 	/* Restore the TSS, RO GDT, LDT, and usermode-relevant MSRs. */
@@ -257,7 +253,7 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	 */
 	wrmsrl(MSR_FS_BASE, ctxt->fs_base);
 	wrmsrl(MSR_KERNEL_GS_BASE, ctxt->usermode_gs_base);
-#elif defined(CONFIG_X86_32_LAZY_GS)
+#else
 	loadsegment(gs, ctxt->gs);
 #endif
 
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 815030b7f6fa8..94804670caab8 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1193,7 +1193,6 @@ static void __init xen_setup_gdt(int cpu)
 	pv_ops.cpu.write_gdt_entry = xen_write_gdt_entry_boot;
 	pv_ops.cpu.load_gdt = xen_load_gdt_boot;
 
-	setup_stack_canary_segment(cpu);
 	switch_to_new_gdt(cpu);
 
 	pv_ops.cpu.write_gdt_entry = xen_write_gdt_entry;
diff --git a/scripts/gcc-x86_32-has-stack-protector.sh b/scripts/gcc-x86_32-has-stack-protector.sh
index f5c1194952540..825c75c5b7150 100755
--- a/scripts/gcc-x86_32-has-stack-protector.sh
+++ b/scripts/gcc-x86_32-has-stack-protector.sh
@@ -1,4 +1,8 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
-echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m32 -O0 -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
+# This requires GCC 8.1 or better.  Specifically, we require
+# -mstack-protector-guard-reg, added by
+# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81708
+
+echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m32 -O0 -fstack-protector -mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard - -o - 2> /dev/null | grep -q "%fs"
-- 
2.43.0




