Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FC97D3435
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbjJWLhj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbjJWLhi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:37:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BB5DB
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:37:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8FBC433C9;
        Mon, 23 Oct 2023 11:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061055;
        bh=J6KcQj6y1ZZ7CDZHuubiH6ohTdrBIO0O0drmkLiRsjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1NQUMePbfrS81tl93jAQlTsxgcWG/sPHrFKGYujU4qyUwmXpvBMCHeaIBAvGuMGZF
         OKLgx+QmRS4bjjpl1CbsFAwVp50nqe8cOqQQ2ZG7kHaqkhYwdTKjuJek4C6AnV8gks
         edH5XyksQTZpT+cP7HAkqUb7MdJGanEy7FTp4Cb0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 058/137] perf/x86: Move branch classifier
Date:   Mon, 23 Oct 2023 12:56:55 +0200
Message-ID: <20231023104822.942181322@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104820.849461819@linuxfoundation.org>
References: <20231023104820.849461819@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sandipan Das <sandipan.das@amd.com>

[ Upstream commit 4462fbfe6ec1bfe2196b977010f6ce7b43a32f2c ]

Commit 3e702ff6d1ea ("perf/x86: Add LBR software filter support for Intel
CPUs") introduces a software branch filter which complements the hardware
branch filter and adds an x86 branch classifier.

Move the branch classifier to arch/x86/events/ so that it can be utilized
by other vendors for branch record filtering.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/bae5b95470d6bd49f40954bd379f414f5afcb965.1660211399.git.sandipan.das@amd.com
Stable-dep-of: e53899771a02 ("perf/x86/lbr: Filter vsyscall addresses")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/Makefile     |   2 +-
 arch/x86/events/intel/lbr.c  | 273 -----------------------------------
 arch/x86/events/perf_event.h |  62 ++++++++
 arch/x86/events/utils.c      | 216 +++++++++++++++++++++++++++
 4 files changed, 279 insertions(+), 274 deletions(-)
 create mode 100644 arch/x86/events/utils.c

diff --git a/arch/x86/events/Makefile b/arch/x86/events/Makefile
index 9933c0e8e97a9..86a76efa8bb6d 100644
--- a/arch/x86/events/Makefile
+++ b/arch/x86/events/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y					+= core.o probe.o
+obj-y					+= core.o probe.o utils.o
 obj-$(CONFIG_PERF_EVENTS_INTEL_RAPL)	+= rapl.o
 obj-y					+= amd/
 obj-$(CONFIG_X86_LOCAL_APIC)            += msr.o
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index bc3e40184719f..e8c6575cf65ea 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -4,7 +4,6 @@
 
 #include <asm/perf_event.h>
 #include <asm/msr.h>
-#include <asm/insn.h>
 
 #include "../perf_event.h"
 
@@ -73,65 +72,6 @@ static const enum {
 
 #define LBR_FROM_SIGNEXT_2MSB	(BIT_ULL(60) | BIT_ULL(59))
 
-/*
- * x86control flow change classification
- * x86control flow changes include branches, interrupts, traps, faults
- */
-enum {
-	X86_BR_NONE		= 0,      /* unknown */
-
-	X86_BR_USER		= 1 << 0, /* branch target is user */
-	X86_BR_KERNEL		= 1 << 1, /* branch target is kernel */
-
-	X86_BR_CALL		= 1 << 2, /* call */
-	X86_BR_RET		= 1 << 3, /* return */
-	X86_BR_SYSCALL		= 1 << 4, /* syscall */
-	X86_BR_SYSRET		= 1 << 5, /* syscall return */
-	X86_BR_INT		= 1 << 6, /* sw interrupt */
-	X86_BR_IRET		= 1 << 7, /* return from interrupt */
-	X86_BR_JCC		= 1 << 8, /* conditional */
-	X86_BR_JMP		= 1 << 9, /* jump */
-	X86_BR_IRQ		= 1 << 10,/* hw interrupt or trap or fault */
-	X86_BR_IND_CALL		= 1 << 11,/* indirect calls */
-	X86_BR_ABORT		= 1 << 12,/* transaction abort */
-	X86_BR_IN_TX		= 1 << 13,/* in transaction */
-	X86_BR_NO_TX		= 1 << 14,/* not in transaction */
-	X86_BR_ZERO_CALL	= 1 << 15,/* zero length call */
-	X86_BR_CALL_STACK	= 1 << 16,/* call stack */
-	X86_BR_IND_JMP		= 1 << 17,/* indirect jump */
-
-	X86_BR_TYPE_SAVE	= 1 << 18,/* indicate to save branch type */
-
-};
-
-#define X86_BR_PLM (X86_BR_USER | X86_BR_KERNEL)
-#define X86_BR_ANYTX (X86_BR_NO_TX | X86_BR_IN_TX)
-
-#define X86_BR_ANY       \
-	(X86_BR_CALL    |\
-	 X86_BR_RET     |\
-	 X86_BR_SYSCALL |\
-	 X86_BR_SYSRET  |\
-	 X86_BR_INT     |\
-	 X86_BR_IRET    |\
-	 X86_BR_JCC     |\
-	 X86_BR_JMP	 |\
-	 X86_BR_IRQ	 |\
-	 X86_BR_ABORT	 |\
-	 X86_BR_IND_CALL |\
-	 X86_BR_IND_JMP  |\
-	 X86_BR_ZERO_CALL)
-
-#define X86_BR_ALL (X86_BR_PLM | X86_BR_ANY)
-
-#define X86_BR_ANY_CALL		 \
-	(X86_BR_CALL		|\
-	 X86_BR_IND_CALL	|\
-	 X86_BR_ZERO_CALL	|\
-	 X86_BR_SYSCALL		|\
-	 X86_BR_IRQ		|\
-	 X86_BR_INT)
-
 /*
  * Intel LBR_CTL bits
  *
@@ -1168,219 +1108,6 @@ int intel_pmu_setup_lbr_filter(struct perf_event *event)
 	return ret;
 }
 
-/*
- * return the type of control flow change at address "from"
- * instruction is not necessarily a branch (in case of interrupt).
- *
- * The branch type returned also includes the priv level of the
- * target of the control flow change (X86_BR_USER, X86_BR_KERNEL).
- *
- * If a branch type is unknown OR the instruction cannot be
- * decoded (e.g., text page not present), then X86_BR_NONE is
- * returned.
- */
-static int branch_type(unsigned long from, unsigned long to, int abort)
-{
-	struct insn insn;
-	void *addr;
-	int bytes_read, bytes_left;
-	int ret = X86_BR_NONE;
-	int ext, to_plm, from_plm;
-	u8 buf[MAX_INSN_SIZE];
-	int is64 = 0;
-
-	to_plm = kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
-	from_plm = kernel_ip(from) ? X86_BR_KERNEL : X86_BR_USER;
-
-	/*
-	 * maybe zero if lbr did not fill up after a reset by the time
-	 * we get a PMU interrupt
-	 */
-	if (from == 0 || to == 0)
-		return X86_BR_NONE;
-
-	if (abort)
-		return X86_BR_ABORT | to_plm;
-
-	if (from_plm == X86_BR_USER) {
-		/*
-		 * can happen if measuring at the user level only
-		 * and we interrupt in a kernel thread, e.g., idle.
-		 */
-		if (!current->mm)
-			return X86_BR_NONE;
-
-		/* may fail if text not present */
-		bytes_left = copy_from_user_nmi(buf, (void __user *)from,
-						MAX_INSN_SIZE);
-		bytes_read = MAX_INSN_SIZE - bytes_left;
-		if (!bytes_read)
-			return X86_BR_NONE;
-
-		addr = buf;
-	} else {
-		/*
-		 * The LBR logs any address in the IP, even if the IP just
-		 * faulted. This means userspace can control the from address.
-		 * Ensure we don't blindly read any address by validating it is
-		 * a known text address.
-		 */
-		if (kernel_text_address(from)) {
-			addr = (void *)from;
-			/*
-			 * Assume we can get the maximum possible size
-			 * when grabbing kernel data.  This is not
-			 * _strictly_ true since we could possibly be
-			 * executing up next to a memory hole, but
-			 * it is very unlikely to be a problem.
-			 */
-			bytes_read = MAX_INSN_SIZE;
-		} else {
-			return X86_BR_NONE;
-		}
-	}
-
-	/*
-	 * decoder needs to know the ABI especially
-	 * on 64-bit systems running 32-bit apps
-	 */
-#ifdef CONFIG_X86_64
-	is64 = kernel_ip((unsigned long)addr) || any_64bit_mode(current_pt_regs());
-#endif
-	insn_init(&insn, addr, bytes_read, is64);
-	if (insn_get_opcode(&insn))
-		return X86_BR_ABORT;
-
-	switch (insn.opcode.bytes[0]) {
-	case 0xf:
-		switch (insn.opcode.bytes[1]) {
-		case 0x05: /* syscall */
-		case 0x34: /* sysenter */
-			ret = X86_BR_SYSCALL;
-			break;
-		case 0x07: /* sysret */
-		case 0x35: /* sysexit */
-			ret = X86_BR_SYSRET;
-			break;
-		case 0x80 ... 0x8f: /* conditional */
-			ret = X86_BR_JCC;
-			break;
-		default:
-			ret = X86_BR_NONE;
-		}
-		break;
-	case 0x70 ... 0x7f: /* conditional */
-		ret = X86_BR_JCC;
-		break;
-	case 0xc2: /* near ret */
-	case 0xc3: /* near ret */
-	case 0xca: /* far ret */
-	case 0xcb: /* far ret */
-		ret = X86_BR_RET;
-		break;
-	case 0xcf: /* iret */
-		ret = X86_BR_IRET;
-		break;
-	case 0xcc ... 0xce: /* int */
-		ret = X86_BR_INT;
-		break;
-	case 0xe8: /* call near rel */
-		if (insn_get_immediate(&insn) || insn.immediate1.value == 0) {
-			/* zero length call */
-			ret = X86_BR_ZERO_CALL;
-			break;
-		}
-		fallthrough;
-	case 0x9a: /* call far absolute */
-		ret = X86_BR_CALL;
-		break;
-	case 0xe0 ... 0xe3: /* loop jmp */
-		ret = X86_BR_JCC;
-		break;
-	case 0xe9 ... 0xeb: /* jmp */
-		ret = X86_BR_JMP;
-		break;
-	case 0xff: /* call near absolute, call far absolute ind */
-		if (insn_get_modrm(&insn))
-			return X86_BR_ABORT;
-
-		ext = (insn.modrm.bytes[0] >> 3) & 0x7;
-		switch (ext) {
-		case 2: /* near ind call */
-		case 3: /* far ind call */
-			ret = X86_BR_IND_CALL;
-			break;
-		case 4:
-		case 5:
-			ret = X86_BR_IND_JMP;
-			break;
-		}
-		break;
-	default:
-		ret = X86_BR_NONE;
-	}
-	/*
-	 * interrupts, traps, faults (and thus ring transition) may
-	 * occur on any instructions. Thus, to classify them correctly,
-	 * we need to first look at the from and to priv levels. If they
-	 * are different and to is in the kernel, then it indicates
-	 * a ring transition. If the from instruction is not a ring
-	 * transition instr (syscall, systenter, int), then it means
-	 * it was a irq, trap or fault.
-	 *
-	 * we have no way of detecting kernel to kernel faults.
-	 */
-	if (from_plm == X86_BR_USER && to_plm == X86_BR_KERNEL
-	    && ret != X86_BR_SYSCALL && ret != X86_BR_INT)
-		ret = X86_BR_IRQ;
-
-	/*
-	 * branch priv level determined by target as
-	 * is done by HW when LBR_SELECT is implemented
-	 */
-	if (ret != X86_BR_NONE)
-		ret |= to_plm;
-
-	return ret;
-}
-
-#define X86_BR_TYPE_MAP_MAX	16
-
-static int branch_map[X86_BR_TYPE_MAP_MAX] = {
-	PERF_BR_CALL,		/* X86_BR_CALL */
-	PERF_BR_RET,		/* X86_BR_RET */
-	PERF_BR_SYSCALL,	/* X86_BR_SYSCALL */
-	PERF_BR_SYSRET,		/* X86_BR_SYSRET */
-	PERF_BR_UNKNOWN,	/* X86_BR_INT */
-	PERF_BR_ERET,		/* X86_BR_IRET */
-	PERF_BR_COND,		/* X86_BR_JCC */
-	PERF_BR_UNCOND,		/* X86_BR_JMP */
-	PERF_BR_IRQ,		/* X86_BR_IRQ */
-	PERF_BR_IND_CALL,	/* X86_BR_IND_CALL */
-	PERF_BR_UNKNOWN,	/* X86_BR_ABORT */
-	PERF_BR_UNKNOWN,	/* X86_BR_IN_TX */
-	PERF_BR_UNKNOWN,	/* X86_BR_NO_TX */
-	PERF_BR_CALL,		/* X86_BR_ZERO_CALL */
-	PERF_BR_UNKNOWN,	/* X86_BR_CALL_STACK */
-	PERF_BR_IND,		/* X86_BR_IND_JMP */
-};
-
-static int
-common_branch_type(int type)
-{
-	int i;
-
-	type >>= 2; /* skip X86_BR_USER and X86_BR_KERNEL */
-
-	if (type) {
-		i = __ffs(type);
-		if (i < X86_BR_TYPE_MAP_MAX)
-			return branch_map[i];
-	}
-
-	return PERF_BR_UNKNOWN;
-}
-
 enum {
 	ARCH_LBR_BR_TYPE_JCC			= 0,
 	ARCH_LBR_BR_TYPE_NEAR_IND_JMP		= 1,
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index e3ac05c97b5e5..9b4d51c0e0ad4 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1181,6 +1181,68 @@ static inline void set_linear_ip(struct pt_regs *regs, unsigned long ip)
 	regs->ip = ip;
 }
 
+/*
+ * x86control flow change classification
+ * x86control flow changes include branches, interrupts, traps, faults
+ */
+enum {
+	X86_BR_NONE		= 0,      /* unknown */
+
+	X86_BR_USER		= 1 << 0, /* branch target is user */
+	X86_BR_KERNEL		= 1 << 1, /* branch target is kernel */
+
+	X86_BR_CALL		= 1 << 2, /* call */
+	X86_BR_RET		= 1 << 3, /* return */
+	X86_BR_SYSCALL		= 1 << 4, /* syscall */
+	X86_BR_SYSRET		= 1 << 5, /* syscall return */
+	X86_BR_INT		= 1 << 6, /* sw interrupt */
+	X86_BR_IRET		= 1 << 7, /* return from interrupt */
+	X86_BR_JCC		= 1 << 8, /* conditional */
+	X86_BR_JMP		= 1 << 9, /* jump */
+	X86_BR_IRQ		= 1 << 10,/* hw interrupt or trap or fault */
+	X86_BR_IND_CALL		= 1 << 11,/* indirect calls */
+	X86_BR_ABORT		= 1 << 12,/* transaction abort */
+	X86_BR_IN_TX		= 1 << 13,/* in transaction */
+	X86_BR_NO_TX		= 1 << 14,/* not in transaction */
+	X86_BR_ZERO_CALL	= 1 << 15,/* zero length call */
+	X86_BR_CALL_STACK	= 1 << 16,/* call stack */
+	X86_BR_IND_JMP		= 1 << 17,/* indirect jump */
+
+	X86_BR_TYPE_SAVE	= 1 << 18,/* indicate to save branch type */
+
+};
+
+#define X86_BR_PLM (X86_BR_USER | X86_BR_KERNEL)
+#define X86_BR_ANYTX (X86_BR_NO_TX | X86_BR_IN_TX)
+
+#define X86_BR_ANY       \
+	(X86_BR_CALL    |\
+	 X86_BR_RET     |\
+	 X86_BR_SYSCALL |\
+	 X86_BR_SYSRET  |\
+	 X86_BR_INT     |\
+	 X86_BR_IRET    |\
+	 X86_BR_JCC     |\
+	 X86_BR_JMP	 |\
+	 X86_BR_IRQ	 |\
+	 X86_BR_ABORT	 |\
+	 X86_BR_IND_CALL |\
+	 X86_BR_IND_JMP  |\
+	 X86_BR_ZERO_CALL)
+
+#define X86_BR_ALL (X86_BR_PLM | X86_BR_ANY)
+
+#define X86_BR_ANY_CALL		 \
+	(X86_BR_CALL		|\
+	 X86_BR_IND_CALL	|\
+	 X86_BR_ZERO_CALL	|\
+	 X86_BR_SYSCALL		|\
+	 X86_BR_IRQ		|\
+	 X86_BR_INT)
+
+int common_branch_type(int type);
+int branch_type(unsigned long from, unsigned long to, int abort);
+
 ssize_t x86_event_sysfs_show(char *page, u64 config, u64 event);
 ssize_t intel_event_sysfs_show(char *page, u64 config);
 
diff --git a/arch/x86/events/utils.c b/arch/x86/events/utils.c
new file mode 100644
index 0000000000000..a32368945462f
--- /dev/null
+++ b/arch/x86/events/utils.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <asm/insn.h>
+
+#include "perf_event.h"
+
+/*
+ * return the type of control flow change at address "from"
+ * instruction is not necessarily a branch (in case of interrupt).
+ *
+ * The branch type returned also includes the priv level of the
+ * target of the control flow change (X86_BR_USER, X86_BR_KERNEL).
+ *
+ * If a branch type is unknown OR the instruction cannot be
+ * decoded (e.g., text page not present), then X86_BR_NONE is
+ * returned.
+ */
+int branch_type(unsigned long from, unsigned long to, int abort)
+{
+	struct insn insn;
+	void *addr;
+	int bytes_read, bytes_left;
+	int ret = X86_BR_NONE;
+	int ext, to_plm, from_plm;
+	u8 buf[MAX_INSN_SIZE];
+	int is64 = 0;
+
+	to_plm = kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
+	from_plm = kernel_ip(from) ? X86_BR_KERNEL : X86_BR_USER;
+
+	/*
+	 * maybe zero if lbr did not fill up after a reset by the time
+	 * we get a PMU interrupt
+	 */
+	if (from == 0 || to == 0)
+		return X86_BR_NONE;
+
+	if (abort)
+		return X86_BR_ABORT | to_plm;
+
+	if (from_plm == X86_BR_USER) {
+		/*
+		 * can happen if measuring at the user level only
+		 * and we interrupt in a kernel thread, e.g., idle.
+		 */
+		if (!current->mm)
+			return X86_BR_NONE;
+
+		/* may fail if text not present */
+		bytes_left = copy_from_user_nmi(buf, (void __user *)from,
+						MAX_INSN_SIZE);
+		bytes_read = MAX_INSN_SIZE - bytes_left;
+		if (!bytes_read)
+			return X86_BR_NONE;
+
+		addr = buf;
+	} else {
+		/*
+		 * The LBR logs any address in the IP, even if the IP just
+		 * faulted. This means userspace can control the from address.
+		 * Ensure we don't blindly read any address by validating it is
+		 * a known text address.
+		 */
+		if (kernel_text_address(from)) {
+			addr = (void *)from;
+			/*
+			 * Assume we can get the maximum possible size
+			 * when grabbing kernel data.  This is not
+			 * _strictly_ true since we could possibly be
+			 * executing up next to a memory hole, but
+			 * it is very unlikely to be a problem.
+			 */
+			bytes_read = MAX_INSN_SIZE;
+		} else {
+			return X86_BR_NONE;
+		}
+	}
+
+	/*
+	 * decoder needs to know the ABI especially
+	 * on 64-bit systems running 32-bit apps
+	 */
+#ifdef CONFIG_X86_64
+	is64 = kernel_ip((unsigned long)addr) || any_64bit_mode(current_pt_regs());
+#endif
+	insn_init(&insn, addr, bytes_read, is64);
+	if (insn_get_opcode(&insn))
+		return X86_BR_ABORT;
+
+	switch (insn.opcode.bytes[0]) {
+	case 0xf:
+		switch (insn.opcode.bytes[1]) {
+		case 0x05: /* syscall */
+		case 0x34: /* sysenter */
+			ret = X86_BR_SYSCALL;
+			break;
+		case 0x07: /* sysret */
+		case 0x35: /* sysexit */
+			ret = X86_BR_SYSRET;
+			break;
+		case 0x80 ... 0x8f: /* conditional */
+			ret = X86_BR_JCC;
+			break;
+		default:
+			ret = X86_BR_NONE;
+		}
+		break;
+	case 0x70 ... 0x7f: /* conditional */
+		ret = X86_BR_JCC;
+		break;
+	case 0xc2: /* near ret */
+	case 0xc3: /* near ret */
+	case 0xca: /* far ret */
+	case 0xcb: /* far ret */
+		ret = X86_BR_RET;
+		break;
+	case 0xcf: /* iret */
+		ret = X86_BR_IRET;
+		break;
+	case 0xcc ... 0xce: /* int */
+		ret = X86_BR_INT;
+		break;
+	case 0xe8: /* call near rel */
+		if (insn_get_immediate(&insn) || insn.immediate1.value == 0) {
+			/* zero length call */
+			ret = X86_BR_ZERO_CALL;
+			break;
+		}
+		fallthrough;
+	case 0x9a: /* call far absolute */
+		ret = X86_BR_CALL;
+		break;
+	case 0xe0 ... 0xe3: /* loop jmp */
+		ret = X86_BR_JCC;
+		break;
+	case 0xe9 ... 0xeb: /* jmp */
+		ret = X86_BR_JMP;
+		break;
+	case 0xff: /* call near absolute, call far absolute ind */
+		if (insn_get_modrm(&insn))
+			return X86_BR_ABORT;
+
+		ext = (insn.modrm.bytes[0] >> 3) & 0x7;
+		switch (ext) {
+		case 2: /* near ind call */
+		case 3: /* far ind call */
+			ret = X86_BR_IND_CALL;
+			break;
+		case 4:
+		case 5:
+			ret = X86_BR_IND_JMP;
+			break;
+		}
+		break;
+	default:
+		ret = X86_BR_NONE;
+	}
+	/*
+	 * interrupts, traps, faults (and thus ring transition) may
+	 * occur on any instructions. Thus, to classify them correctly,
+	 * we need to first look at the from and to priv levels. If they
+	 * are different and to is in the kernel, then it indicates
+	 * a ring transition. If the from instruction is not a ring
+	 * transition instr (syscall, systenter, int), then it means
+	 * it was a irq, trap or fault.
+	 *
+	 * we have no way of detecting kernel to kernel faults.
+	 */
+	if (from_plm == X86_BR_USER && to_plm == X86_BR_KERNEL
+	    && ret != X86_BR_SYSCALL && ret != X86_BR_INT)
+		ret = X86_BR_IRQ;
+
+	/*
+	 * branch priv level determined by target as
+	 * is done by HW when LBR_SELECT is implemented
+	 */
+	if (ret != X86_BR_NONE)
+		ret |= to_plm;
+
+	return ret;
+}
+
+#define X86_BR_TYPE_MAP_MAX	16
+
+static int branch_map[X86_BR_TYPE_MAP_MAX] = {
+	PERF_BR_CALL,		/* X86_BR_CALL */
+	PERF_BR_RET,		/* X86_BR_RET */
+	PERF_BR_SYSCALL,	/* X86_BR_SYSCALL */
+	PERF_BR_SYSRET,		/* X86_BR_SYSRET */
+	PERF_BR_UNKNOWN,	/* X86_BR_INT */
+	PERF_BR_ERET,		/* X86_BR_IRET */
+	PERF_BR_COND,		/* X86_BR_JCC */
+	PERF_BR_UNCOND,		/* X86_BR_JMP */
+	PERF_BR_IRQ,		/* X86_BR_IRQ */
+	PERF_BR_IND_CALL,	/* X86_BR_IND_CALL */
+	PERF_BR_UNKNOWN,	/* X86_BR_ABORT */
+	PERF_BR_UNKNOWN,	/* X86_BR_IN_TX */
+	PERF_BR_UNKNOWN,	/* X86_BR_NO_TX */
+	PERF_BR_CALL,		/* X86_BR_ZERO_CALL */
+	PERF_BR_UNKNOWN,	/* X86_BR_CALL_STACK */
+	PERF_BR_IND,		/* X86_BR_IND_JMP */
+};
+
+int common_branch_type(int type)
+{
+	int i;
+
+	type >>= 2; /* skip X86_BR_USER and X86_BR_KERNEL */
+
+	if (type) {
+		i = __ffs(type);
+		if (i < X86_BR_TYPE_MAP_MAX)
+			return branch_map[i];
+	}
+
+	return PERF_BR_UNKNOWN;
+}
-- 
2.40.1



