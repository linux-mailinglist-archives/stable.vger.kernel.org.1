Return-Path: <stable+bounces-91071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D553E9BEC4C
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CD6DB221B8
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4431FB887;
	Wed,  6 Nov 2024 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a5ObnN9N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BDE1E0090;
	Wed,  6 Nov 2024 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897655; cv=none; b=iFrApzTv6KiGt7LBVl8HX4RSsZKu+mm3NcBIe9jTefNbEEthV9fgC7hIrunK74/Cz5/ZOxdmEuIS4Oc8d0wIkTNmTZhSZ8OllIJdITOwcz1D7ro7+GX+agFdzc67O222XE5PzEkDUpaBobUe2lIC/+XQPtV3JwNboVW/aaS/nbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897655; c=relaxed/simple;
	bh=lV8KfkMb0K966rCyNCPDKDfnywgyBwEdghSGwuHJtnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyAZ77ZgrBTTd5KlzkwjJ3tWco8CBqF5JRbMvqMwph9ZmtKy/wPaLRTRTRbRKAH2OOMR0O1fqvClt6G4dKT4Ffm8dvny+U+RQtklQt29tzvauxoO6mbxBAN5ibzPqRN5ZLZZx0sJe1RZGQAbF+w/Hw/r6YkW1SIIV3zVj2zVyhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a5ObnN9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9E4C4CECD;
	Wed,  6 Nov 2024 12:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730897655;
	bh=lV8KfkMb0K966rCyNCPDKDfnywgyBwEdghSGwuHJtnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a5ObnN9NI1N5677iKrBGRNQqD6juzZZcqUiTdJ/xsxZQFsMLA3+CUlf4rVyss6O0H
	 CPtGaO4qlE8FRHQrWAsw5oW9ZzxUCPBI0baspKDyh0h0999WvHMvU2efpc+v3fSn+x
	 smEWfm/rmFSW5kvfQySsDx5xAshvwhBpLgvT7L4E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gatlin Newhouse <gatlin.newhouse@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 127/151] x86/traps: Enable UBSAN traps on x86
Date: Wed,  6 Nov 2024 13:05:15 +0100
Message-ID: <20241106120312.358605504@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120308.841299741@linuxfoundation.org>
References: <20241106120308.841299741@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gatlin Newhouse <gatlin.newhouse@gmail.com>

[ Upstream commit 7424fc6b86c8980a87169e005f5cd4438d18efe6 ]

Currently ARM64 extracts which specific sanitizer has caused a trap via
encoded data in the trap instruction. Clang on x86 currently encodes the
same data in the UD1 instruction but x86 handle_bug() and
is_valid_bugaddr() currently only look at UD2.

Bring x86 to parity with ARM64, similar to commit 25b84002afb9 ("arm64:
Support Clang UBSAN trap codes for better reporting"). See the llvm
links for information about the code generation.

Enable the reporting of UBSAN sanitizer details on x86 compiled with clang
when CONFIG_UBSAN_TRAP=y by analysing UD1 and retrieving the type immediate
which is encoded by the compiler after the UD1.

[ tglx: Simplified it by moving the printk() into handle_bug() ]

Signed-off-by: Gatlin Newhouse <gatlin.newhouse@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20240724000206.451425-1-gatlin.newhouse@gmail.com
Link: https://github.com/llvm/llvm-project/commit/c5978f42ec8e9#diff-bb68d7cd885f41cfc35843998b0f9f534adb60b415f647109e597ce448e92d9f
Link: https://github.com/llvm/llvm-project/blob/main/llvm/lib/Target/X86/X86InstrSystem.td#L27
Stable-dep-of: 1db272864ff2 ("x86/traps: move kmsan check after instrumentation_begin")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/bug.h | 12 ++++++++
 arch/x86/kernel/traps.c    | 59 ++++++++++++++++++++++++++++++++++----
 include/linux/ubsan.h      |  5 ++++
 lib/Kconfig.ubsan          |  4 +--
 4 files changed, 73 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index a3ec87d198ac8..806649c7f23dc 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -13,6 +13,18 @@
 #define INSN_UD2	0x0b0f
 #define LEN_UD2		2
 
+/*
+ * In clang we have UD1s reporting UBSAN failures on X86, 64 and 32bit.
+ */
+#define INSN_ASOP		0x67
+#define OPCODE_ESCAPE		0x0f
+#define SECOND_BYTE_OPCODE_UD1	0xb9
+#define SECOND_BYTE_OPCODE_UD2	0x0b
+
+#define BUG_NONE		0xffff
+#define BUG_UD1			0xfffe
+#define BUG_UD2			0xfffd
+
 #ifdef CONFIG_GENERIC_BUG
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c876f1d36a81a..840a3b2d24779 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -41,6 +41,7 @@
 #include <linux/hardirq.h>
 #include <linux/atomic.h>
 #include <linux/iommu.h>
+#include <linux/ubsan.h>
 
 #include <asm/stacktrace.h>
 #include <asm/processor.h>
@@ -89,6 +90,47 @@ __always_inline int is_valid_bugaddr(unsigned long addr)
 	return *(unsigned short *)addr == INSN_UD2;
 }
 
+/*
+ * Check for UD1 or UD2, accounting for Address Size Override Prefixes.
+ * If it's a UD1, get the ModRM byte to pass along to UBSan.
+ */
+__always_inline int decode_bug(unsigned long addr, u32 *imm)
+{
+	u8 v;
+
+	if (addr < TASK_SIZE_MAX)
+		return BUG_NONE;
+
+	v = *(u8 *)(addr++);
+	if (v == INSN_ASOP)
+		v = *(u8 *)(addr++);
+	if (v != OPCODE_ESCAPE)
+		return BUG_NONE;
+
+	v = *(u8 *)(addr++);
+	if (v == SECOND_BYTE_OPCODE_UD2)
+		return BUG_UD2;
+
+	if (!IS_ENABLED(CONFIG_UBSAN_TRAP) || v != SECOND_BYTE_OPCODE_UD1)
+		return BUG_NONE;
+
+	/* Retrieve the immediate (type value) for the UBSAN UD1 */
+	v = *(u8 *)(addr++);
+	if (X86_MODRM_RM(v) == 4)
+		addr++;
+
+	*imm = 0;
+	if (X86_MODRM_MOD(v) == 1)
+		*imm = *(u8 *)addr;
+	else if (X86_MODRM_MOD(v) == 2)
+		*imm = *(u32 *)addr;
+	else
+		WARN_ONCE(1, "Unexpected MODRM_MOD: %u\n", X86_MODRM_MOD(v));
+
+	return BUG_UD1;
+}
+
+
 static nokprobe_inline int
 do_trap_no_signal(struct task_struct *tsk, int trapnr, const char *str,
 		  struct pt_regs *regs,	long error_code)
@@ -214,6 +256,8 @@ static inline void handle_invalid_op(struct pt_regs *regs)
 static noinstr bool handle_bug(struct pt_regs *regs)
 {
 	bool handled = false;
+	int ud_type;
+	u32 imm;
 
 	/*
 	 * Normally @regs are unpoisoned by irqentry_enter(), but handle_bug()
@@ -221,7 +265,8 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 	 * irqentry_enter().
 	 */
 	kmsan_unpoison_entry_regs(regs);
-	if (!is_valid_bugaddr(regs->ip))
+	ud_type = decode_bug(regs->ip, &imm);
+	if (ud_type == BUG_NONE)
 		return handled;
 
 	/*
@@ -234,10 +279,14 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 	 */
 	if (regs->flags & X86_EFLAGS_IF)
 		raw_local_irq_enable();
-	if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
-	    handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
-		regs->ip += LEN_UD2;
-		handled = true;
+	if (ud_type == BUG_UD2) {
+		if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
+		    handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
+			regs->ip += LEN_UD2;
+			handled = true;
+		}
+	} else if (IS_ENABLED(CONFIG_UBSAN_TRAP)) {
+		pr_crit("%s at %pS\n", report_ubsan_failure(regs, imm), (void *)regs->ip);
 	}
 	if (regs->flags & X86_EFLAGS_IF)
 		raw_local_irq_disable();
diff --git a/include/linux/ubsan.h b/include/linux/ubsan.h
index bff7445498ded..d8219cbe09ff8 100644
--- a/include/linux/ubsan.h
+++ b/include/linux/ubsan.h
@@ -4,6 +4,11 @@
 
 #ifdef CONFIG_UBSAN_TRAP
 const char *report_ubsan_failure(struct pt_regs *regs, u32 check_type);
+#else
+static inline const char *report_ubsan_failure(struct pt_regs *regs, u32 check_type)
+{
+	return NULL;
+}
 #endif
 
 #endif
diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 59e21bfec188c..f43bcac47c0ab 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -28,8 +28,8 @@ config UBSAN_TRAP
 
 	  Also note that selecting Y will cause your kernel to Oops
 	  with an "illegal instruction" error with no further details
-	  when a UBSAN violation occurs. (Except on arm64, which will
-	  report which Sanitizer failed.) This may make it hard to
+	  when a UBSAN violation occurs. (Except on arm64 and x86, which
+	  will report which Sanitizer failed.) This may make it hard to
 	  determine whether an Oops was caused by UBSAN or to figure
 	  out the details of a UBSAN violation. It makes the kernel log
 	  output less useful for bug reports.
-- 
2.43.0




