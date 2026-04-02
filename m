Return-Path: <stable+bounces-232937-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gI69Ab8qzmnIlQYAu9opvQ
	(envelope-from <stable+bounces-232937-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 10:37:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 591A63861DC
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 10:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B39C3079AFC
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 08:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF39533F5AF;
	Thu,  2 Apr 2026 08:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neo/HNrI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8242C4C6D
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 08:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775118709; cv=none; b=JtsvOIduzjMHQK+CsefIkpYRQuZoF3WD0k2TOCmi7xWUw0OItxwggwskeZjij1ABuv5g7NvdT3hqQXSgsJ+4PNIo+hW9D6gQGMkuxaROcrHni23XQn1tnKgnRvjZIglAoW2IOPOs5joq6gW/m/PE6bYHR1Lo47fjvj5njqeOJCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775118709; c=relaxed/simple;
	bh=70uFdnEd2/QsC+rolHUU4WC0Q8eRBtHnZ4LnKXnBet4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQd/Th53GA7XainjUdAfVeL7AnmqPrXQSniGH/QDUMsyMaWgXKL9GJSwGfnppS9yk2DcuzMhlZzvxT9q84XZcrox24W5vdJrU8epiWOU6xtpm/+NrtdHMlqsMHwMQf201W7VJaRJoK8PSp6jaMMIeTKvObGmJs/tpUd4JZMe/Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neo/HNrI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0E5C116C6;
	Thu,  2 Apr 2026 08:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775118709;
	bh=70uFdnEd2/QsC+rolHUU4WC0Q8eRBtHnZ4LnKXnBet4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=neo/HNrImGFmXwjJYMnyWVJkfNxCSo73gIL79caoHe/3sBDx7jQQAzWRZBwk/HMRA
	 bVFSBUKo14Ukf5tUa3xyiWFU5ai6EL7cdwNYL/uX+Ka1fqcEgJxp2zfMnr19ZF3kgX
	 6djqLS2W/97b9ZnSUN/JnPvSMOLVSOcI4Y/vn50p3q3HVIPnwK07iupZuhb/XdSMXP
	 15lr4kuLuLmtAe5LBDKnkKxW3tVcGFKOyC87LezYzbdloM5ldU3Pbx1FL4zU/1wnQB
	 bjwcmsA+9D7uNddeaKK5ODCi2kk7Vs7AZawDpM3YPl2hNSq2IJ+lW8aI9i1CxGbAGR
	 bLhy6dqdRK6SA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] LoongArch: vDSO: Emit GNU_EH_FRAME correctly
Date: Thu,  2 Apr 2026 04:31:45 -0400
Message-ID: <20260402083145.457510-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026033053-salad-mulch-9066@gregkh>
References: <2026033053-salad-mulch-9066@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232937-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gnu.org:url,xry111.site:email]
X-Rspamd-Queue-Id: 591A63861DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Xi Ruoyao <xry111@xry111.site>

[ Upstream commit e4878c37f6679fdea91b27a0f4e60a871f0b7bad ]

With -fno-asynchronous-unwind-tables and --no-eh-frame-hdr (the default
of the linker), the GNU_EH_FRAME segment (specified by vdso.lds.S) is
empty.  This is not valid, as the current DWARF specification mandates
the first byte of the EH frame to be the version number 1.  It causes
some unwinders to complain, for example the ClickHouse query profiler
spams the log with messages:

    clickhouse-server[365854]: libunwind: unsupported .eh_frame_hdr
    version: 127 at 7ffffffb0000

Here "127" is just the byte located at the p_vaddr (0, i.e. the
beginning of the vDSO) of the empty GNU_EH_FRAME segment. Cross-
checking with /proc/365854/maps has also proven 7ffffffb0000 is the
start of vDSO in the process VM image.

In LoongArch the -fno-asynchronous-unwind-tables option seems just a
MIPS legacy, and MIPS only uses this option to satisfy the MIPS-specific
"genvdso" program, per the commit cfd75c2db17e ("MIPS: VDSO: Explicitly
use -fno-asynchronous-unwind-tables").  IIRC it indicates some inherent
limitation of the MIPS ELF ABI and has nothing to do with LoongArch.  So
we can simply flip it over to -fasynchronous-unwind-tables and pass
--eh-frame-hdr for linking the vDSO, allowing the profilers to unwind the
stack for statistics even if the sample point is taken when the PC is in
the vDSO.

However simply adjusting the options above would exploit an issue: when
the libgcc unwinder saw the invalid GNU_EH_FRAME segment, it silently
falled back to a machine-specific routine to match the code pattern of
rt_sigreturn() and extract the registers saved in the sigframe if the
code pattern is matched.  As unwinding from signal handlers is vital for
libgcc to support pthread cancellation etc., the fall-back routine had
been silently keeping the LoongArch Linux systems functioning since
Linux 5.19.  But when we start to emit GNU_EH_FRAME with the correct
format, fall-back routine will no longer be used and libgcc will fail
to unwind the sigframe, and unwinding from signal handlers will no
longer work, causing dozens of glibc test failures.  To make it possible
to unwind from signal handlers again, it's necessary to code the unwind
info in __vdso_rt_sigreturn via .cfi_* directives.

The offsets in the .cfi_* directives depend on the layout of struct
sigframe, notably the offset of sigcontext in the sigframe.  To use the
offset in the assembly file, factor out struct sigframe into a header to
allow asm-offsets.c to output the offset for assembly.

To work around a long-term issue in the libgcc unwinder (the pc is
unconditionally substracted by 1: doing so is technically incorrect for
a signal frame), a nop instruction is included with the two real
instructions in __vdso_rt_sigreturn in the same FDE PC range.  The same
hack has been used on x86 for a long time.

Cc: stable@vger.kernel.org
Fixes: c6b99bed6b8f ("LoongArch: Add VDSO and VSYSCALL support")
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/include/asm/linkage.h  | 36 +++++++++++++++++++++++++++
 arch/loongarch/include/asm/sigframe.h |  9 +++++++
 arch/loongarch/kernel/asm-offsets.c   |  2 ++
 arch/loongarch/kernel/signal.c        |  6 +----
 arch/loongarch/vdso/Makefile          |  4 +--
 arch/loongarch/vdso/sigreturn.S       |  6 ++---
 6 files changed, 53 insertions(+), 10 deletions(-)
 create mode 100644 arch/loongarch/include/asm/sigframe.h

diff --git a/arch/loongarch/include/asm/linkage.h b/arch/loongarch/include/asm/linkage.h
index e2eca1a25b4ef..a1bd6a3ee03a1 100644
--- a/arch/loongarch/include/asm/linkage.h
+++ b/arch/loongarch/include/asm/linkage.h
@@ -41,4 +41,40 @@
 	.cfi_endproc;					\
 	SYM_END(name, SYM_T_NONE)
 
+/*
+ * This is for the signal handler trampoline, which is used as the return
+ * address of the signal handlers in userspace instead of called normally.
+ * The long standing libgcc bug https://gcc.gnu.org/PR124050 requires a
+ * nop between .cfi_startproc and the actual address of the trampoline, so
+ * we cannot simply use SYM_FUNC_START.
+ *
+ * This wrapper also contains all the .cfi_* directives for recovering
+ * the content of the GPRs and the "return address" (where the rt_sigreturn
+ * syscall will jump to), assuming there is a struct rt_sigframe (where
+ * a struct sigcontext containing those information we need to recover) at
+ * $sp.  The "DWARF for the LoongArch(TM) Architecture" manual states
+ * column 0 is for $zero, but it does not make too much sense to
+ * save/restore the hardware zero register.  Repurpose this column here
+ * for the return address (here it's not the content of $ra we cannot use
+ * the default column 3).
+ */
+#define SYM_SIGFUNC_START(name)				\
+	.cfi_startproc;					\
+	.cfi_signal_frame;				\
+	.cfi_def_cfa 3, RT_SIGFRAME_SC;			\
+	.cfi_return_column 0;				\
+	.cfi_offset 0, SC_PC;				\
+							\
+	.irp num, 1,  2,  3,  4,  5,  6,  7,  8, 	\
+		  9,  10, 11, 12, 13, 14, 15, 16,	\
+		  17, 18, 19, 20, 21, 22, 23, 24,	\
+		  25, 26, 27, 28, 29, 30, 31;		\
+	.cfi_offset \num, SC_REGS + \num * SZREG;	\
+	.endr;						\
+							\
+	nop;						\
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
+
+#define SYM_SIGFUNC_END(name) SYM_FUNC_END(name)
+
 #endif
diff --git a/arch/loongarch/include/asm/sigframe.h b/arch/loongarch/include/asm/sigframe.h
new file mode 100644
index 0000000000000..109298b8d7e0b
--- /dev/null
+++ b/arch/loongarch/include/asm/sigframe.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#include <asm/siginfo.h>
+#include <asm/ucontext.h>
+
+struct rt_sigframe {
+	struct siginfo rs_info;
+	struct ucontext rs_uctx;
+};
diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
index 110afd3cc8f34..10c66ec95fa19 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -15,6 +15,7 @@
 #include <asm/ptrace.h>
 #include <asm/processor.h>
 #include <asm/ftrace.h>
+#include <asm/sigframe.h>
 
 void output_ptreg_defines(void)
 {
@@ -218,6 +219,7 @@ void output_sc_defines(void)
 	COMMENT("Linux sigcontext offsets.");
 	OFFSET(SC_REGS, sigcontext, sc_regs);
 	OFFSET(SC_PC, sigcontext, sc_pc);
+	OFFSET(RT_SIGFRAME_SC, rt_sigframe, rs_uctx.uc_mcontext);
 	BLANK();
 }
 
diff --git a/arch/loongarch/kernel/signal.c b/arch/loongarch/kernel/signal.c
index 0e90cd2df0ea3..c9a0fd40e8b57 100644
--- a/arch/loongarch/kernel/signal.c
+++ b/arch/loongarch/kernel/signal.c
@@ -34,6 +34,7 @@
 #include <asm/cpu-features.h>
 #include <asm/fpu.h>
 #include <asm/lbt.h>
+#include <asm/sigframe.h>
 #include <asm/ucontext.h>
 #include <asm/vdso.h>
 
@@ -71,11 +72,6 @@ extern asmlinkage int _save_ftop_context(void __user *ftop);
 extern asmlinkage int _restore_ftop_context(void __user *ftop);
 #endif
 
-struct rt_sigframe {
-	struct siginfo rs_info;
-	struct ucontext rs_uctx;
-};
-
 struct _ctx_layout {
 	struct sctx_info *addr;
 	unsigned int size;
diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index 1a0f6ca0247b4..ebf3b4d521727 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -24,7 +24,7 @@ cflags-vdso := $(ccflags-vdso) \
 	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
 	-std=gnu11 -O2 -g -fno-strict-aliasing -fno-common -fno-builtin \
 	-fno-stack-protector -fno-jump-tables -DDISABLE_BRANCH_PROFILING \
-	$(call cc-option, -fno-asynchronous-unwind-tables) \
+	$(call cc-option, -fasynchronous-unwind-tables) \
 	$(call cc-option, -fno-stack-protector)
 aflags-vdso := $(ccflags-vdso) \
 	-D__ASSEMBLY__ -Wa,-gdwarf-2
@@ -36,7 +36,7 @@ endif
 # VDSO linker flags.
 ldflags-y := -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
 	$(filter -E%,$(KBUILD_CFLAGS)) -nostdlib -shared \
-	--hash-style=sysv --build-id -T
+	--hash-style=sysv --build-id --eh-frame-hdr -T
 
 GCOV_PROFILE := n
 
diff --git a/arch/loongarch/vdso/sigreturn.S b/arch/loongarch/vdso/sigreturn.S
index 9cb3c58fad03b..59f940d928de7 100644
--- a/arch/loongarch/vdso/sigreturn.S
+++ b/arch/loongarch/vdso/sigreturn.S
@@ -12,13 +12,13 @@
 
 #include <asm/regdef.h>
 #include <asm/asm.h>
+#include <asm/asm-offsets.h>
 
 	.section	.text
-	.cfi_sections	.debug_frame
 
-SYM_FUNC_START(__vdso_rt_sigreturn)
+SYM_SIGFUNC_START(__vdso_rt_sigreturn)
 
 	li.w	a7, __NR_rt_sigreturn
 	syscall	0
 
-SYM_FUNC_END(__vdso_rt_sigreturn)
+SYM_SIGFUNC_END(__vdso_rt_sigreturn)
-- 
2.53.0


