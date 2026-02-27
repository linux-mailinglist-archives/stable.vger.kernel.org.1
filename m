Return-Path: <stable+bounces-219925-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Ix9CQ5GoWkirwQAu9opvQ
	(envelope-from <stable+bounces-219925-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 08:21:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A41991B3C6C
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 08:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9BDDD304EEC5
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 07:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AD2364926;
	Fri, 27 Feb 2026 07:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="aW0xNnUs"
X-Original-To: stable@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B533603E5;
	Fri, 27 Feb 2026 07:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772176881; cv=none; b=hjYIOftWGvz0pbxb4Om6HGCeGu1vJ2IHdHcn7hh8twhtZ1fA5uWH4sYJJyeJqg/Tax8tSrYubsF6/HXBrmkprGZ4cmvjYfATPbmHQKtGqwwwoyI6JRhYZ71YY8YPknquToWK8wxElDb1YuBi5VbqhZtzAvQk5Z55MHFvEPKT81Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772176881; c=relaxed/simple;
	bh=7Y6mul3sgcwCz0jONSvbybw6Ymw6qsECJdZje9TzWSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fpSrTO9pPy9dIoVznU3/DPJ4FdWHyCt2suNk54WRMcTNGawl24diESSjZ2ahAOyjSxsFG422nyEqix7ufoaAoqtH8wCDVOsfa4XWKLYYjQ/Bmr+C7NW5TILapijG/ynuwJrDXR7krHSPbMxLuAxwsMvNz3CODsjB5Ods1wuANrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=aW0xNnUs; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1772176866;
	bh=Qlk+jI3aGgXtl94OODFP7Dk+Y3lPnznfePWMMOfZh4M=;
	h=From:To:Cc:Subject:Date:From;
	b=aW0xNnUsC9Io9wuaTpVrnGjVsO25dBlq7x2Ma04inPzTeIHduCcnXjYR5qukKrYZe
	 DmMEFSCcc+h965PaENKgWeJNHiH+enzorucaSM6TG9BNR7Ncmnj8COZa9i4KPN4xs3
	 d39qupXSxDwpWCVNpXLeq76cBnVwuIPd7ukQeJSw=
Received: from stargazer (unknown [IPv6:2409:8a4c:e11:4510:818c:b334:624:49f8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id E348D1A41A7;
	Fri, 27 Feb 2026 02:20:58 -0500 (EST)
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Jinyang He <hejinyang@loongson.cn>
Cc: WANG Rui <wangrui@loongson.cn>,
	Mingcong Bai <jeffbai@aosc.io>,
	Zixing Liu <liushuyu@aosc.io>,
	"H . Peter Anvin" <hpa@zytor.com>,
	stable@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Bibo Mao <maobibo@loongson.cn>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hanlu Li <lihanlu@loongson.cn>,
	Nathan Chancellor <nathan@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Wentao Guan <guanwentao@uniontech.com>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v2] LoongArch: vDSO: Emit GNU_EH_FRAME correctly
Date: Fri, 27 Feb 2026 15:18:39 +0800
Message-ID: <20260227072031.581229-1-xry111@xry111.site>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[xry111.site,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[xry111.site:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[loongson.cn,aosc.io,zytor.com,vger.kernel.org,infradead.org,gmail.com,kernel.org,flygoat.com,uniontech.com,lists.linux.dev,xry111.site];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-219925-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xry111@xry111.site,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[xry111.site:+];
	NEURAL_HAM(-0.00)[-0.948];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A41991B3C6C
X-Rspamd-Action: no action

With -fno-asynchronous-unwind-tables and --no-eh-frame-hdr (the default
of the linker), the GNU_EH_FRAME segment (specified by vdso.lds.S) is
empty.  This is not valid, as the current DWARF specification mandates
the first byte of the EH frame to be the version number 1.  It causes
some unwinders to complain, for example the ClickHouse query profiler
spams the log with messages:

    clickhouse-server[365854]: libunwind: unsupported .eh_frame_hdr
    version: 127 at 7ffffffb0000

Here "127" is just the byte located at the p_vaddr (0, i.e. the
beginning of the vDSO) of the empty GNU_EH_FRAME segment.
Cross-checking with /proc/365854/maps has also proven 7ffffffb0000 is
the start of vDSO in the process VM image.

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
rt_sigreturn and extract the registers saved in the sigframe if the code
pattern is matched.  As unwinding from signal handlers is vital for
libgcc to support pthread cancellation etc., the fall-back routine had
been silently keeping the LoongArch Linux systems functioning since
Linux 5.19.  But when we start to emit GNU_EH_FRAME with the correct
format, fall-back routine will no longer be used and libgcc will fail
to unwind the sigframe, and unwinding from signal handlers will no
longer work, causing dozens of glibc test failures.  To make it possible
to unwind from signal handlers again, it's necessary to code the unwind
info in __vdso_rt_sigreturn via .cfi_* directives.

The offsets in the .cfi_* directives depend on the layout of struct
sigframe, notably the offset of sigcontect in the sigframe.  To use the
offset in the assembly file, factor out struct sigframe into a header to
allow asm-offsets.c to output the offset for assembly.

To work around a long-term issue in the libgcc unwinder (the pc is
unconditionally substracted by 1: doing so is technically incorrect for
a signal frame), a nop instruction is included with the two real
instructions in __vdso_rt_sigreturn in the same FDE PC range.  The same
hack has been used on x86 for a long time.

Fixes: c6b99bed6b8f ("LoongArch: Add VDSO and VSYSCALL support")
Cc: stable@vger.kernel.org
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---

Changes from [v1]:
- Use DWARF column 0 instead of the libgcc-specific column 72.
- Style change to sigframe.h.

[v1]: https://lore.kernel.org/20260225104607.3803060-1-xry111@xry111.site

 arch/loongarch/include/asm/sigframe.h | 12 +++++++
 arch/loongarch/kernel/asm-offsets.c   |  2 ++
 arch/loongarch/kernel/signal.c        |  6 +---
 arch/loongarch/vdso/Makefile          |  4 +--
 arch/loongarch/vdso/sigreturn.S       | 46 ++++++++++++++++++++++++---
 5 files changed, 59 insertions(+), 11 deletions(-)
 create mode 100644 arch/loongarch/include/asm/sigframe.h

diff --git a/arch/loongarch/include/asm/sigframe.h b/arch/loongarch/include/asm/sigframe.h
new file mode 100644
index 000000000000..59db3de6db85
--- /dev/null
+++ b/arch/loongarch/include/asm/sigframe.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Separated from arch/loongarch/kernel/signal.c.
+ */
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
index c9f7ca778364..e297d54ea638 100644
--- a/arch/loongarch/kernel/signal.c
+++ b/arch/loongarch/kernel/signal.c
@@ -37,6 +37,7 @@
 #include <asm/lbt.h>
 #include <asm/ucontext.h>
 #include <asm/vdso.h>
+#include <asm/sigframe.h>
 
 #ifdef DEBUG_SIG
 #  define DEBUGP(fmt, args...) printk("%s: " fmt, __func__, ##args)
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
index 9cb3c58fad03..a72c5d592ff5 100644
--- a/arch/loongarch/vdso/sigreturn.S
+++ b/arch/loongarch/vdso/sigreturn.S
@@ -12,13 +12,51 @@
 
 #include <asm/regdef.h>
 #include <asm/asm.h>
+#include <asm/asm-offsets.h>
 
 	.section	.text
-	.cfi_sections	.debug_frame
 
-SYM_FUNC_START(__vdso_rt_sigreturn)
+	.cfi_startproc
+	.cfi_signal_frame
 
+	/*
+	 * There is a struct rt_sigframe at $sp, set CFA to the address of
+	 * the struct sigcontext in the rt_sigframe to simplify the
+	 * offsets below.
+	 */
+	.cfi_def_cfa 3, RT_SIGFRAME_SC
+
+	/*
+	 * The "DWARF for the LoongArch(TM) Architecture" manual states
+	 * column 0 is for $zero, but it does not make too much sense
+	 * to save/restore the hardware zero register.  Repurpose the
+	 * column here (both libgcc and LLVM libunwind allow to do so)
+	 * and we'd update the manual later.
+	 */
+	.cfi_return_column 0
+	.cfi_offset 0, SC_PC
+
+	/* The GPRs of the "caller" are also stored in the sigcontext.  */
+.irp	num, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, \
+	     17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
+	.cfi_offset \num, SC_REGS + \num * SZREG
+.endr
+
+	/*
+	 * HACK: The dwarf2 unwind routine will subtract 1 from the return
+	 * address to get an address in the middle of the persumed call
+	 * instruction.  While in libgcc there exists a logic to avoid
+	 * subtracting 1 for the signal frame (a frame with the 'S'
+	 * augmentation that we've already added via .cfi_signal_frame),
+	 * unfortunately it doesn't really work: the check of signal frame
+	 * is at libgcc/unwind-dw2:1008 in GCC 15.2.0, but the flag it
+	 * checks will only get updated by the extract_cie_info call at line
+	 * 1025.  So include a nop before the real start to make up for it.
+	 * This is also the reason we don't use SYM_FUNC_START.
+	 */
+	nop
+SYM_START(__vdso_rt_sigreturn, SYM_L_GLOBAL, SYM_A_ALIGN)
 	li.w	a7, __NR_rt_sigreturn
 	syscall	0
-
-SYM_FUNC_END(__vdso_rt_sigreturn)
+	.cfi_endproc
+SYM_END(__vdso_rt_sigreturn, SYM_T_FUNC)
-- 
2.53.0


