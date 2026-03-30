Return-Path: <stable+bounces-231110-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBIcOUxIymkQ7QUAu9opvQ
	(envelope-from <stable+bounces-231110-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:54:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F751358A30
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46B013028E88
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E41A3803C3;
	Mon, 30 Mar 2026 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="to2gbAtN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7683A75A6
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 09:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864137; cv=none; b=s0DLYiUb3k0RWkM6ttQuu4FhYuRbCV8RbWknRn5o2/UIfxbwV+z9SzAYcZGeZumAOl0oN+aq4RRaSc8DfBa3fy3IVFMVsidH7fjUqe+j9ECEupLBWXCJiKumJyc93npoSiDsL6n8AxdXWi64s2TJH9b38J+rlkK/SePpbBfYK6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864137; c=relaxed/simple;
	bh=U06GtA0ld1gBIw/ky+wkVPPgg8MehqKVh1ljpjUNWtM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qcQbajiaeBjBXX2dH7bKFQTd5IF5vcRd08cPsXnFYvQqzKa6sYX520gG1PGuXeAId98SLH5jhKiMIrQq3zVuefbTwpz2Y4uO3oR2jsaE+muHKQjLH/sIlTonFUtYZTzQ/8P9pAhtTfPJQMvxTjuwv9TFP3F8GpWUMi7bi0S796E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=to2gbAtN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83238C4CEF7;
	Mon, 30 Mar 2026 09:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774864137;
	bh=U06GtA0ld1gBIw/ky+wkVPPgg8MehqKVh1ljpjUNWtM=;
	h=Subject:To:Cc:From:Date:From;
	b=to2gbAtNQf+1WdrYjN1+DZvPSGRnpNvBhISRZA9J6jjp95lZrKFCYGi5eSWgo1zrB
	 NMLYaOyjYSKuGKibfmBT4qoQCiLjnKhsoIDJw20R1z4NtqgWykDdxhCFmTSIILcjEd
	 EhzKybNOOKy1kxAVcQ58hR45b0BKAC1k8sCl12/k=
Subject: FAILED: patch "[PATCH] LoongArch: vDSO: Emit GNU_EH_FRAME correctly" failed to apply to 6.6-stable tree
To: xry111@xry111.site,chenhuacai@loongson.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Mar 2026 11:48:53 +0200
Message-ID: <2026033053-salad-mulch-9066@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231110-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,xry111.site:email,gnu.org:url,gregkh:email]
X-Rspamd-Queue-Id: 5F751358A30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e4878c37f6679fdea91b27a0f4e60a871f0b7bad
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026033053-salad-mulch-9066@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e4878c37f6679fdea91b27a0f4e60a871f0b7bad Mon Sep 17 00:00:00 2001
From: Xi Ruoyao <xry111@xry111.site>
Date: Thu, 26 Mar 2026 14:29:09 +0800
Subject: [PATCH] LoongArch: vDSO: Emit GNU_EH_FRAME correctly

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

diff --git a/arch/loongarch/include/asm/linkage.h b/arch/loongarch/include/asm/linkage.h
index e2eca1a25b4e..a1bd6a3ee03a 100644
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
index 000000000000..109298b8d7e0
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
index 3017c7157600..2cc953f113ac 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -16,6 +16,7 @@
 #include <asm/ptrace.h>
 #include <asm/processor.h>
 #include <asm/ftrace.h>
+#include <asm/sigframe.h>
 #include <vdso/datapage.h>
 
 static void __used output_ptreg_defines(void)
@@ -220,6 +221,7 @@ static void __used output_sc_defines(void)
 	COMMENT("Linux sigcontext offsets.");
 	OFFSET(SC_REGS, sigcontext, sc_regs);
 	OFFSET(SC_PC, sigcontext, sc_pc);
+	OFFSET(RT_SIGFRAME_SC, rt_sigframe, rs_uctx.uc_mcontext);
 	BLANK();
 }
 
diff --git a/arch/loongarch/kernel/signal.c b/arch/loongarch/kernel/signal.c
index c9f7ca778364..d4151d2fb82e 100644
--- a/arch/loongarch/kernel/signal.c
+++ b/arch/loongarch/kernel/signal.c
@@ -35,6 +35,7 @@
 #include <asm/cpu-features.h>
 #include <asm/fpu.h>
 #include <asm/lbt.h>
+#include <asm/sigframe.h>
 #include <asm/ucontext.h>
 #include <asm/vdso.h>
 
@@ -51,11 +52,6 @@
 #define lock_lbt_owner()	({ preempt_disable(); pagefault_disable(); })
 #define unlock_lbt_owner()	({ pagefault_enable(); preempt_enable(); })
 
-struct rt_sigframe {
-	struct siginfo rs_info;
-	struct ucontext rs_uctx;
-};
-
 struct _ctx_layout {
 	struct sctx_info *addr;
 	unsigned int size;
diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index 520f1513f07d..294c16b9517f 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -26,7 +26,7 @@ cflags-vdso := $(ccflags-vdso) \
 	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
 	-std=gnu11 -fms-extensions -O2 -g -fno-strict-aliasing -fno-common -fno-builtin \
 	-fno-stack-protector -fno-jump-tables -DDISABLE_BRANCH_PROFILING \
-	$(call cc-option, -fno-asynchronous-unwind-tables) \
+	$(call cc-option, -fasynchronous-unwind-tables) \
 	$(call cc-option, -fno-stack-protector)
 aflags-vdso := $(ccflags-vdso) \
 	-D__ASSEMBLY__ -Wa,-gdwarf-2
@@ -41,7 +41,7 @@ endif
 
 # VDSO linker flags.
 ldflags-y := -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
-	$(filter -E%,$(KBUILD_CFLAGS)) -shared --build-id -T
+	$(filter -E%,$(KBUILD_CFLAGS)) -shared --build-id --eh-frame-hdr -T
 
 #
 # Shared build commands.
diff --git a/arch/loongarch/vdso/sigreturn.S b/arch/loongarch/vdso/sigreturn.S
index 9cb3c58fad03..59f940d928de 100644
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


