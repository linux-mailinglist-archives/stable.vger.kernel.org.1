Return-Path: <stable+bounces-44746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E608C5435
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D24283F68
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0659139D16;
	Tue, 14 May 2024 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yiQ2SEGS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE97139CE4;
	Tue, 14 May 2024 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687056; cv=none; b=bDn9aba48r7rR6U598MJJnB2pgZnTCBavbZl/Y+aAT7YTNHSU25eAmR+Dcldfy82GHMdLQv3GfLBaqPvWUF5atc8DY0nur0mvRVR9HFTtjbyeiPOqDd9JcdFFh/KU6snhwk6kg18Cp84sqrnifMzxn3SmCXVZAcsxXqG9dQ0kWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687056; c=relaxed/simple;
	bh=AoCKkOPxTIA1n072Ql7oS5gifSLgiPMCviK70BTxG8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0GAOuV+FzIsnI4VhKllblaR5qfXSMXcf2z9zFiwBOt4GavU5+d0H+pbG7Iu2ge2RIPbammNQVPZ3+BX92C6ttQGil9cYF18QlRS0g/cCfdxvPFzatdlpbioq0LRo8sSv2rUg+TPKYznZfw/3iIHYyiJIVqED6gUWGeQDRh/qaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yiQ2SEGS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72A6C32781;
	Tue, 14 May 2024 11:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687056;
	bh=AoCKkOPxTIA1n072Ql7oS5gifSLgiPMCviK70BTxG8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yiQ2SEGSbK5JdUNuNb6FFc1jWDUZTW1mFe/siqNVMT2SG/Kw24YgfqyjBkwsgV1aV
	 JqVIJXJv8pWQpbKB5bS5eFUAc8/fbW6dK/oYZK/trzlz26f70KMLQgMUH1ony0lwPl
	 AYgoO7EnWixUkg3Ue2pN4xQCSj1zVUAwQkLWYRuM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xi Ruoyao <xry111@xry111.site>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 49/84] MIPS: scall: Save thread_info.syscall unconditionally on entry
Date: Tue, 14 May 2024 12:20:00 +0200
Message-ID: <20240514100953.532741490@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514100951.686412426@linuxfoundation.org>
References: <20240514100951.686412426@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

[ Upstream commit 4370b673ccf240bf7587b0cb8e6726a5ccaf1f17 ]

thread_info.syscall is used by syscall_get_nr to supply syscall nr
over a thread stack frame.

Previously, thread_info.syscall is only saved at syscall_trace_enter
when syscall tracing is enabled. However rest of the kernel code do
expect syscall_get_nr to be available without syscall tracing. The
previous design breaks collect_syscall.

Move saving process to syscall entry to fix it.

Reported-by: Xi Ruoyao <xry111@xry111.site>
Link: https://github.com/util-linux/util-linux/issues/2867
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/ptrace.h |  2 +-
 arch/mips/kernel/asm-offsets.c |  1 +
 arch/mips/kernel/ptrace.c      | 15 ++++++---------
 arch/mips/kernel/scall32-o32.S | 23 +++++++++++++----------
 arch/mips/kernel/scall64-n32.S |  3 ++-
 arch/mips/kernel/scall64-n64.S |  3 ++-
 arch/mips/kernel/scall64-o32.S | 33 +++++++++++++++++----------------
 7 files changed, 42 insertions(+), 38 deletions(-)

diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index 2849a9b65a055..ae578860f7295 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -157,7 +157,7 @@ static inline long regs_return_value(struct pt_regs *regs)
 #define instruction_pointer(regs) ((regs)->cp0_epc)
 #define profile_pc(regs) instruction_pointer(regs)
 
-extern asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall);
+extern asmlinkage long syscall_trace_enter(struct pt_regs *regs);
 extern asmlinkage void syscall_trace_leave(struct pt_regs *regs);
 
 extern void die(const char *, struct pt_regs *) __noreturn;
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index aebfda81120a1..6c5269d3aacba 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -100,6 +100,7 @@ void output_thread_info_defines(void)
 	OFFSET(TI_PRE_COUNT, thread_info, preempt_count);
 	OFFSET(TI_ADDR_LIMIT, thread_info, addr_limit);
 	OFFSET(TI_REGS, thread_info, regs);
+	OFFSET(TI_SYSCALL, thread_info, syscall);
 	DEFINE(_THREAD_SIZE, THREAD_SIZE);
 	DEFINE(_THREAD_MASK, THREAD_MASK);
 	DEFINE(_IRQ_STACK_SIZE, IRQ_STACK_SIZE);
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 414b6e9c900b2..cfb548fd2712c 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -1399,16 +1399,13 @@ long arch_ptrace(struct task_struct *child, long request,
  * Notification of system call entry/exit
  * - triggered by current->work.syscall_trace
  */
-asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
+asmlinkage long syscall_trace_enter(struct pt_regs *regs)
 {
 	user_exit();
 
-	current_thread_info()->syscall = syscall;
-
 	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
 		if (tracehook_report_syscall_entry(regs))
 			return -1;
-		syscall = current_thread_info()->syscall;
 	}
 
 #ifdef CONFIG_SECCOMP
@@ -1417,7 +1414,7 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
 		struct seccomp_data sd;
 		unsigned long args[6];
 
-		sd.nr = syscall;
+		sd.nr = current_thread_info()->syscall;
 		sd.arch = syscall_get_arch(current);
 		syscall_get_arguments(current, regs, args);
 		for (i = 0; i < 6; i++)
@@ -1427,23 +1424,23 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
 		ret = __secure_computing(&sd);
 		if (ret == -1)
 			return ret;
-		syscall = current_thread_info()->syscall;
 	}
 #endif
 
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->regs[2]);
 
-	audit_syscall_entry(syscall, regs->regs[4], regs->regs[5],
+	audit_syscall_entry(current_thread_info()->syscall,
+			    regs->regs[4], regs->regs[5],
 			    regs->regs[6], regs->regs[7]);
 
 	/*
 	 * Negative syscall numbers are mistaken for rejected syscalls, but
 	 * won't have had the return value set appropriately, so we do so now.
 	 */
-	if (syscall < 0)
+	if (current_thread_info()->syscall < 0)
 		syscall_set_return_value(current, regs, -ENOSYS, 0);
-	return syscall;
+	return current_thread_info()->syscall;
 }
 
 /*
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index b449b68662a9a..80747719a35ca 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -80,6 +80,18 @@ loads_done:
 	PTR	load_a7, bad_stack_a7
 	.previous
 
+	/*
+	 * syscall number is in v0 unless we called syscall(__NR_###)
+	 * where the real syscall number is in a0
+	 */
+	subu	t2, v0,  __NR_O32_Linux
+	bnez	t2, 1f /* __NR_syscall at offset 0 */
+	LONG_S	a0, TI_SYSCALL($28)	# Save a0 as syscall number
+	b	2f
+1:
+	LONG_S	v0, TI_SYSCALL($28)	# Save v0 as syscall number
+2:
+
 	lw	t0, TI_FLAGS($28)	# syscall tracing enabled?
 	li	t1, _TIF_WORK_SYSCALL_ENTRY
 	and	t0, t1
@@ -117,16 +129,7 @@ syscall_trace_entry:
 	SAVE_STATIC
 	move	a0, sp
 
-	/*
-	 * syscall number is in v0 unless we called syscall(__NR_###)
-	 * where the real syscall number is in a0
-	 */
-	move	a1, v0
-	subu	t2, v0,  __NR_O32_Linux
-	bnez	t2, 1f /* __NR_syscall at offset 0 */
-	lw	a1, PT_R4(sp)
-
-1:	jal	syscall_trace_enter
+	jal	syscall_trace_enter
 
 	bltz	v0, 1f			# seccomp failed? Skip syscall
 
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 35d8c86b160ea..a8679e34c95e3 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -44,6 +44,8 @@ NESTED(handle_sysn32, PT_SIZE, sp)
 
 	sd	a3, PT_R26(sp)		# save a3 for syscall restarting
 
+	LONG_S	v0, TI_SYSCALL($28)     # Store syscall number
+
 	li	t1, _TIF_WORK_SYSCALL_ENTRY
 	LONG_L	t0, TI_FLAGS($28)	# syscall tracing enabled?
 	and	t0, t1, t0
@@ -72,7 +74,6 @@ syscall_common:
 n32_syscall_trace_entry:
 	SAVE_STATIC
 	move	a0, sp
-	move	a1, v0
 	jal	syscall_trace_enter
 
 	bltz	v0, 1f			# seccomp failed? Skip syscall
diff --git a/arch/mips/kernel/scall64-n64.S b/arch/mips/kernel/scall64-n64.S
index 23b2e2b1609cf..a3b5ab509b412 100644
--- a/arch/mips/kernel/scall64-n64.S
+++ b/arch/mips/kernel/scall64-n64.S
@@ -47,6 +47,8 @@ NESTED(handle_sys64, PT_SIZE, sp)
 
 	sd	a3, PT_R26(sp)		# save a3 for syscall restarting
 
+	LONG_S	v0, TI_SYSCALL($28)     # Store syscall number
+
 	li	t1, _TIF_WORK_SYSCALL_ENTRY
 	LONG_L	t0, TI_FLAGS($28)	# syscall tracing enabled?
 	and	t0, t1, t0
@@ -83,7 +85,6 @@ n64_syscall_exit:
 syscall_trace_entry:
 	SAVE_STATIC
 	move	a0, sp
-	move	a1, v0
 	jal	syscall_trace_enter
 
 	bltz	v0, 1f			# seccomp failed? Skip syscall
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 41df8221bb8fd..d8f41e919c171 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -79,6 +79,22 @@ loads_done:
 	PTR	load_a7, bad_stack_a7
 	.previous
 
+	/*
+	 * absolute syscall number is in v0 unless we called syscall(__NR_###)
+	 * where the real syscall number is in a0
+	 * note: NR_syscall is the first O32 syscall but the macro is
+	 * only defined when compiling with -mabi=32 (CONFIG_32BIT)
+	 * therefore __NR_O32_Linux is used (4000)
+	 */
+
+	subu	t2, v0,  __NR_O32_Linux
+	bnez	t2, 1f /* __NR_syscall at offset 0 */
+	LONG_S	a0, TI_SYSCALL($28)	# Save a0 as syscall number
+	b	2f
+1:
+	LONG_S	v0, TI_SYSCALL($28)	# Save v0 as syscall number
+2:
+
 	li	t1, _TIF_WORK_SYSCALL_ENTRY
 	LONG_L	t0, TI_FLAGS($28)	# syscall tracing enabled?
 	and	t0, t1, t0
@@ -113,22 +129,7 @@ trace_a_syscall:
 	sd	a7, PT_R11(sp)		# For indirect syscalls
 
 	move	a0, sp
-	/*
-	 * absolute syscall number is in v0 unless we called syscall(__NR_###)
-	 * where the real syscall number is in a0
-	 * note: NR_syscall is the first O32 syscall but the macro is
-	 * only defined when compiling with -mabi=32 (CONFIG_32BIT)
-	 * therefore __NR_O32_Linux is used (4000)
-	 */
-	.set	push
-	.set	reorder
-	subu	t1, v0,  __NR_O32_Linux
-	move	a1, v0
-	bnez	t1, 1f /* __NR_syscall at offset 0 */
-	ld	a1, PT_R4(sp) /* Arg1 for __NR_syscall case */
-	.set	pop
-
-1:	jal	syscall_trace_enter
+	jal	syscall_trace_enter
 
 	bltz	v0, 1f			# seccomp failed? Skip syscall
 
-- 
2.43.0




