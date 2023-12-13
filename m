Return-Path: <stable+bounces-6023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BBB80D85E
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94571F21B25
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1344851036;
	Mon, 11 Dec 2023 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hbq5FjZl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C065F4E1D2;
	Mon, 11 Dec 2023 18:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43977C433C9;
	Mon, 11 Dec 2023 18:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320304;
	bh=h04VtMvhF/BKyyKDHfNLDt6XcEv6CUhPMJ/GXgqewZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hbq5FjZlGGb/UpJBN3o4A+lWG6ieRFNlXaoPKCD6WJ4fgj9G8V4yUmeUFMPsgAN8w
	 Lm6Zsuvfo7P/ycGbeift5F3n6zOQQDarmqB6x7kSpdz4jmdpOeK0ekwldsCDc8o7B5
	 6LG4No8acLC4wtq3vXnTAjs6SuRb3V5uTtWSIZJc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 6.1 012/194] x86/entry: Convert INT 0x80 emulation to IDTENTRY
Date: Mon, 11 Dec 2023 19:20:02 +0100
Message-ID: <20231211182037.153799495@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182036.606660304@linuxfoundation.org>
References: <20231211182036.606660304@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

[ upstream commit be5341eb0d43b1e754799498bd2e8756cc167a41 ]

There is no real reason to have a separate ASM entry point implementation
for the legacy INT 0x80 syscall emulation on 64-bit.

IDTENTRY provides all the functionality needed with the only difference
that it does not:

  - save the syscall number (AX) into pt_regs::orig_ax
  - set pt_regs::ax to -ENOSYS

Both can be done safely in the C code of an IDTENTRY before invoking any of
the syscall related functions which depend on this convention.

Aside of ASM code reduction this prepares for detecting and handling a
local APIC injected vector 0x80.

[ kirill.shutemov: More verbose comments ]
Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@vger.kernel.org> # v6.0+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/entry/common.c          |   58 ++++++++++++++++++++++++++++-
 arch/x86/entry/entry_64_compat.S |   77 ---------------------------------------
 arch/x86/include/asm/idtentry.h  |    4 ++
 arch/x86/include/asm/proto.h     |    4 --
 arch/x86/kernel/idt.c            |    2 -
 arch/x86/xen/enlighten_pv.c      |    2 -
 arch/x86/xen/xen-asm.S           |    2 -
 7 files changed, 64 insertions(+), 85 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -119,7 +119,62 @@ static __always_inline void do_syscall_3
 	}
 }
 
-/* Handles int $0x80 */
+#ifdef CONFIG_IA32_EMULATION
+/**
+ * int80_emulation - 32-bit legacy syscall entry
+ *
+ * This entry point can be used by 32-bit and 64-bit programs to perform
+ * 32-bit system calls.  Instances of INT $0x80 can be found inline in
+ * various programs and libraries.  It is also used by the vDSO's
+ * __kernel_vsyscall fallback for hardware that doesn't support a faster
+ * entry method.  Restarted 32-bit system calls also fall back to INT
+ * $0x80 regardless of what instruction was originally used to do the
+ * system call.
+ *
+ * This is considered a slow path.  It is not used by most libc
+ * implementations on modern hardware except during process startup.
+ *
+ * The arguments for the INT $0x80 based syscall are on stack in the
+ * pt_regs structure:
+ *   eax:				system call number
+ *   ebx, ecx, edx, esi, edi, ebp:	arg1 - arg 6
+ */
+DEFINE_IDTENTRY_RAW(int80_emulation)
+{
+	int nr;
+
+	/* Establish kernel context. */
+	enter_from_user_mode(regs);
+
+	instrumentation_begin();
+	add_random_kstack_offset();
+
+	/*
+	 * The low level idtentry code pushed -1 into regs::orig_ax
+	 * and regs::ax contains the syscall number.
+	 *
+	 * User tracing code (ptrace or signal handlers) might assume
+	 * that the regs::orig_ax contains a 32-bit number on invoking
+	 * a 32-bit syscall.
+	 *
+	 * Establish the syscall convention by saving the 32bit truncated
+	 * syscall number in regs::orig_ax and by invalidating regs::ax.
+	 */
+	regs->orig_ax = regs->ax & GENMASK(31, 0);
+	regs->ax = -ENOSYS;
+
+	nr = syscall_32_enter(regs);
+
+	local_irq_enable();
+	nr = syscall_enter_from_user_mode_work(regs, nr);
+	do_syscall_32_irqs_on(regs, nr);
+
+	instrumentation_end();
+	syscall_exit_to_user_mode(regs);
+}
+#else /* CONFIG_IA32_EMULATION */
+
+/* Handles int $0x80 on a 32bit kernel */
 __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 {
 	int nr = syscall_32_enter(regs);
@@ -138,6 +193,7 @@ __visible noinstr void do_int80_syscall_
 	instrumentation_end();
 	syscall_exit_to_user_mode(regs);
 }
+#endif /* !CONFIG_IA32_EMULATION */
 
 static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 {
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -277,80 +277,3 @@ SYM_INNER_LABEL(entry_SYSRETL_compat_end
 	ANNOTATE_NOENDBR
 	int3
 SYM_CODE_END(entry_SYSCALL_compat)
-
-/*
- * 32-bit legacy system call entry.
- *
- * 32-bit x86 Linux system calls traditionally used the INT $0x80
- * instruction.  INT $0x80 lands here.
- *
- * This entry point can be used by 32-bit and 64-bit programs to perform
- * 32-bit system calls.  Instances of INT $0x80 can be found inline in
- * various programs and libraries.  It is also used by the vDSO's
- * __kernel_vsyscall fallback for hardware that doesn't support a faster
- * entry method.  Restarted 32-bit system calls also fall back to INT
- * $0x80 regardless of what instruction was originally used to do the
- * system call.
- *
- * This is considered a slow path.  It is not used by most libc
- * implementations on modern hardware except during process startup.
- *
- * Arguments:
- * eax  system call number
- * ebx  arg1
- * ecx  arg2
- * edx  arg3
- * esi  arg4
- * edi  arg5
- * ebp  arg6
- */
-SYM_CODE_START(entry_INT80_compat)
-	UNWIND_HINT_ENTRY
-	ENDBR
-	/*
-	 * Interrupts are off on entry.
-	 */
-	ASM_CLAC			/* Do this early to minimize exposure */
-	ALTERNATIVE "swapgs", "", X86_FEATURE_XENPV
-
-	/*
-	 * User tracing code (ptrace or signal handlers) might assume that
-	 * the saved RAX contains a 32-bit number when we're invoking a 32-bit
-	 * syscall.  Just in case the high bits are nonzero, zero-extend
-	 * the syscall number.  (This could almost certainly be deleted
-	 * with no ill effects.)
-	 */
-	movl	%eax, %eax
-
-	/* switch to thread stack expects orig_ax and rdi to be pushed */
-	pushq	%rax			/* pt_regs->orig_ax */
-
-	/* Need to switch before accessing the thread stack. */
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
-
-	/* In the Xen PV case we already run on the thread stack. */
-	ALTERNATIVE "", "jmp .Lint80_keep_stack", X86_FEATURE_XENPV
-
-	movq	%rsp, %rax
-	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
-
-	pushq	5*8(%rax)		/* regs->ss */
-	pushq	4*8(%rax)		/* regs->rsp */
-	pushq	3*8(%rax)		/* regs->eflags */
-	pushq	2*8(%rax)		/* regs->cs */
-	pushq	1*8(%rax)		/* regs->ip */
-	pushq	0*8(%rax)		/* regs->orig_ax */
-.Lint80_keep_stack:
-
-	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
-	UNWIND_HINT_REGS
-
-	cld
-
-	IBRS_ENTER
-	UNTRAIN_RET
-
-	movq	%rsp, %rdi
-	call	do_int80_syscall_32
-	jmp	swapgs_restore_regs_and_return_to_usermode
-SYM_CODE_END(entry_INT80_compat)
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -569,6 +569,10 @@ DECLARE_IDTENTRY_RAW(X86_TRAP_UD,		exc_i
 DECLARE_IDTENTRY_RAW(X86_TRAP_BP,		exc_int3);
 DECLARE_IDTENTRY_RAW_ERRORCODE(X86_TRAP_PF,	exc_page_fault);
 
+#if defined(CONFIG_IA32_EMULATION)
+DECLARE_IDTENTRY_RAW(IA32_SYSCALL_VECTOR,	int80_emulation);
+#endif
+
 #ifdef CONFIG_X86_MCE
 #ifdef CONFIG_X86_64
 DECLARE_IDTENTRY_MCE(X86_TRAP_MC,	exc_machine_check);
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -32,10 +32,6 @@ void entry_SYSCALL_compat(void);
 void entry_SYSCALL_compat_safe_stack(void);
 void entry_SYSRETL_compat_unsafe_stack(void);
 void entry_SYSRETL_compat_end(void);
-void entry_INT80_compat(void);
-#ifdef CONFIG_XEN_PV
-void xen_entry_INT80_compat(void);
-#endif
 #endif
 
 void x86_configure_nx(void);
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -117,7 +117,7 @@ static const __initconst struct idt_data
 
 	SYSG(X86_TRAP_OF,		asm_exc_overflow),
 #if defined(CONFIG_IA32_EMULATION)
-	SYSG(IA32_SYSCALL_VECTOR,	entry_INT80_compat),
+	SYSG(IA32_SYSCALL_VECTOR,	asm_int80_emulation),
 #elif defined(CONFIG_X86_32)
 	SYSG(IA32_SYSCALL_VECTOR,	entry_INT80_32),
 #endif
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -623,7 +623,7 @@ static struct trap_array_entry trap_arra
 	TRAP_ENTRY(exc_int3,				false ),
 	TRAP_ENTRY(exc_overflow,			false ),
 #ifdef CONFIG_IA32_EMULATION
-	{ entry_INT80_compat,          xen_entry_INT80_compat,          false },
+	TRAP_ENTRY(int80_emulation,			false ),
 #endif
 	TRAP_ENTRY(exc_page_fault,			false ),
 	TRAP_ENTRY(exc_divide_error,			false ),
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -156,7 +156,7 @@ xen_pv_trap asm_xenpv_exc_machine_check
 #endif /* CONFIG_X86_MCE */
 xen_pv_trap asm_exc_simd_coprocessor_error
 #ifdef CONFIG_IA32_EMULATION
-xen_pv_trap entry_INT80_compat
+xen_pv_trap asm_int80_emulation
 #endif
 xen_pv_trap asm_exc_xen_unknown_trap
 xen_pv_trap asm_exc_xen_hypervisor_callback



