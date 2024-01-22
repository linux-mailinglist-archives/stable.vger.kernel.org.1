Return-Path: <stable+bounces-12757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6033837245
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F131A1C298CB
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 19:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7796C3D96D;
	Mon, 22 Jan 2024 19:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dDMAF4jK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DD31EF1A
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 19:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705951062; cv=none; b=gI9i3K7KEvCpVZxVZ41HYjUSWQ4XOkl22uqxncnGMCrNYYLXGrTcHTcDZwRXgZDMdXaCMoV1Eh9hkv665c6QVJ9duocfGH/O4dgSl4KGEP2sETpmB/zUvLImQxD+pWfppf2HXUOfM3+WTa8tFDbVIFrGD/cZ6Arjpjd2S9t0d3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705951062; c=relaxed/simple;
	bh=PZMe4IQyvlLJp/mXa6TeaN6gR4xV8yjC//UaH10it3Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BlU9PDjOwIDovkLsn2i3EQonWyHawDmy8Uioymywf5v/4t2tM18jAmumYyYH4lqasdPu6KsYECEPWXtA9efat5hkvkKHFQkrn+taVdx5+bUGwZm5HoVgsgPcs/7MJ1cQYjmkgfue7RhJkl4t36FPkwrTu3bdjRE2HzFV5drmWdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dDMAF4jK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10785C433C7;
	Mon, 22 Jan 2024 19:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705951061;
	bh=PZMe4IQyvlLJp/mXa6TeaN6gR4xV8yjC//UaH10it3Q=;
	h=Subject:To:Cc:From:Date:From;
	b=dDMAF4jKHeI4nrWNRS2fHRWwkeiQIpI2lBrLoBZad00vUP+pKfMUeK96uFyvWlv/u
	 ezLMzG3w5OPczDQFjl36DO21T6l6EH5l7UAsv7TiYsu58kIOIPaKQ89bAbLWc+bRPO
	 jyLW4YURPiWior2cmh7Vb7vtz8oGolgulJCjbBlA=
Subject: FAILED: patch "[PATCH] LoongArch: Fix and simplify fcsr initialization on execve()" failed to apply to 6.1-stable tree
To: xry111@xry111.site,chenhuacai@loongson.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 11:17:37 -0800
Message-ID: <2024012237-handed-control-646a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c2396651309eba291c15e32db8fbe44c738b5921
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012237-handed-control-646a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

c2396651309e ("LoongArch: Fix and simplify fcsr initialization on execve()")
bd3c5798484a ("LoongArch: Add Loongson Binary Translation (LBT) extension support")
616500232e63 ("LoongArch: Add vector extensions support")
38bb46f94544 ("LoongArch: Prepare for assemblers with proper FCSR class support")
c23e7f01cf62 ("LoongArch: Relay BCE exceptions to userland as SIGSEGV with si_code=SEGV_BNDERR")
1a69f7a161a7 ("LoongArch: ptrace: Expose hardware breakpoints to debuggers")
edffa33c7bb5 ("LoongArch: Add hardware breakpoints/watchpoints support")
41596803302d ("LoongArch: Make -mstrict-align configurable")
c5ac25e0d78a ("LoongArch: Strip guess unwinder out from prologue unwinder")
5bb8d34449c4 ("LoongArch: Use correct sp value to get graph addr in stack unwinders")
429a9671f235 ("LoongArch: Get frame info in unwind_start() when regs is not available")
28ac0a9e04d7 ("LoongArch: modules/ftrace: Initialize PLT at load time")
a51ac5246d25 ("LoongArch/ftrace: Add HAVE_FUNCTION_GRAPH_RET_ADDR_PTR support")
8778ba2c8a5d ("LoongArch/ftrace: Add HAVE_DYNAMIC_FTRACE_WITH_REGS support")
5fcfad3d41cc ("LoongArch/ftrace: Add dynamic function graph tracer support")
4733f09d8807 ("LoongArch/ftrace: Add dynamic function tracer support")
dbe3ba3018ec ("LoongArch/ftrace: Add basic support")
9151dde40356 ("LoongArch: module: Use got/plt section indices for relocations")
19e5eb15b00c ("LoongArch: Add alternative runtime patching mechanism")
61a6fccc0bd2 ("LoongArch: Add unaligned access support")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c2396651309eba291c15e32db8fbe44c738b5921 Mon Sep 17 00:00:00 2001
From: Xi Ruoyao <xry111@xry111.site>
Date: Wed, 17 Jan 2024 12:43:08 +0800
Subject: [PATCH] LoongArch: Fix and simplify fcsr initialization on execve()

There has been a lingering bug in LoongArch Linux systems causing some
GCC tests to intermittently fail (see Closes link).  I've made a minimal
reproducer:

    zsh% cat measure.s
    .align 4
    .globl _start
    _start:
        movfcsr2gr  $a0, $fcsr0
        bstrpick.w  $a0, $a0, 16, 16
        beqz        $a0, .ok
        break       0
    .ok:
        li.w        $a7, 93
        syscall     0
    zsh% cc mesaure.s -o measure -nostdlib
    zsh% echo $((1.0/3))
    0.33333333333333331
    zsh% while ./measure; do ; done

This while loop should not stop as POSIX is clear that execve must set
fenv to the default, where FCSR should be zero.  But in fact it will
just stop after running for a while (normally less than 30 seconds).
Note that "$((1.0/3))" is needed to reproduce this issue because it
raises FE_INVALID and makes fcsr0 non-zero.

The problem is we are currently relying on SET_PERSONALITY2() to reset
current->thread.fpu.fcsr.  But SET_PERSONALITY2() is executed before
start_thread which calls lose_fpu(0).  We can see if kernel preempt is
enabled, we may switch to another thread after SET_PERSONALITY2() but
before lose_fpu(0).  Then bad thing happens: during the thread switch
the value of the fcsr0 register is stored into current->thread.fpu.fcsr,
making it dirty again.

The issue can be fixed by setting current->thread.fpu.fcsr after
lose_fpu(0) because lose_fpu() clears TIF_USEDFPU, then the thread
switch won't touch current->thread.fpu.fcsr.

The only other architecture setting FCSR in SET_PERSONALITY2() is MIPS.
I've ran a similar test on MIPS with mainline kernel and it turns out
MIPS is buggy, too.  Anyway MIPS do this for supporting different FP
flavors (NaN encodings, etc.) which do not exist on LoongArch.  So for
LoongArch, we can simply remove the current->thread.fpu.fcsr setting
from SET_PERSONALITY2() and do it in start_thread(), after lose_fpu(0).

The while loop failing with the mainline kernel has survived one hour
after this change on LoongArch.

Fixes: 803b0fc5c3f2baa ("LoongArch: Add process management")
Closes: https://github.com/loongson-community/discussions/issues/7
Link: https://lore.kernel.org/linux-mips/7a6aa1bbdbbe2e63ae96ff163fab0349f58f1b9e.camel@xry111.site/
Cc: stable@vger.kernel.org
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

diff --git a/arch/loongarch/include/asm/elf.h b/arch/loongarch/include/asm/elf.h
index 9b16a3b8e706..f16bd42456e4 100644
--- a/arch/loongarch/include/asm/elf.h
+++ b/arch/loongarch/include/asm/elf.h
@@ -241,8 +241,6 @@ void loongarch_dump_regs64(u64 *uregs, const struct pt_regs *regs);
 do {									\
 	current->thread.vdso = &vdso_info;				\
 									\
-	loongarch_set_personality_fcsr(state);				\
-									\
 	if (personality(current->personality) != PER_LINUX)		\
 		set_personality(PER_LINUX);				\
 } while (0)
@@ -259,7 +257,6 @@ do {									\
 	clear_thread_flag(TIF_32BIT_ADDR);				\
 									\
 	current->thread.vdso = &vdso_info;				\
-	loongarch_set_personality_fcsr(state);				\
 									\
 	p = personality(current->personality);				\
 	if (p != PER_LINUX32 && p != PER_LINUX)				\
@@ -340,6 +337,4 @@ extern int arch_elf_pt_proc(void *ehdr, void *phdr, struct file *elf,
 extern int arch_check_elf(void *ehdr, bool has_interpreter, void *interp_ehdr,
 			  struct arch_elf_state *state);
 
-extern void loongarch_set_personality_fcsr(struct arch_elf_state *state);
-
 #endif /* _ASM_ELF_H */
diff --git a/arch/loongarch/kernel/elf.c b/arch/loongarch/kernel/elf.c
index 183e94fc9c69..0fa81ced28dc 100644
--- a/arch/loongarch/kernel/elf.c
+++ b/arch/loongarch/kernel/elf.c
@@ -23,8 +23,3 @@ int arch_check_elf(void *_ehdr, bool has_interpreter, void *_interp_ehdr,
 {
 	return 0;
 }
-
-void loongarch_set_personality_fcsr(struct arch_elf_state *state)
-{
-	current->thread.fpu.fcsr = boot_cpu_data.fpu_csr0;
-}
diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
index 767d94cce0de..f2ff8b5d591e 100644
--- a/arch/loongarch/kernel/process.c
+++ b/arch/loongarch/kernel/process.c
@@ -85,6 +85,7 @@ void start_thread(struct pt_regs *regs, unsigned long pc, unsigned long sp)
 	regs->csr_euen = euen;
 	lose_fpu(0);
 	lose_lbt(0);
+	current->thread.fpu.fcsr = boot_cpu_data.fpu_csr0;
 
 	clear_thread_flag(TIF_LSX_CTX_LIVE);
 	clear_thread_flag(TIF_LASX_CTX_LIVE);


