Return-Path: <stable+bounces-82833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A37A3994EA8
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76701C25339
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C051DED48;
	Tue,  8 Oct 2024 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FACIq1Q4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39111DE89A;
	Tue,  8 Oct 2024 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393579; cv=none; b=Tw0N/YU2i6OUnSjn0zojsnnsjHD2+KA9+LwRWtwU1RV2F+MdwAFara1JtVH7pKK00/PPWzCsRRu7oDFyepPeq9d4QIaHoxAaMsuHXDpvfSoPc3I8HB6dv0CpTAJ5wH0aHcAs9Dqn0mlLNFqnaMRDUzyClSGGWdJqcbAZvA/lcvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393579; c=relaxed/simple;
	bh=JSGWA4/0Ol02wqsFLJXxJvD2wCkeY9Ae+FuVLpRaHfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AIzM0D5WD+wx8Lqt0T7403fHGMgp7B93RWEg480o5fMAbnTgu4iw/Oc/0rgm83IrEnqvN8h2O49f+HJrXigxOKEoFy13DLLQBB08qyzIpcUxHMvCgVaQ/LOgnbGc5ZHtG+BqzNXDAsFXBzdRXtl5lzi+wE26Ef9xTvnJiubImQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FACIq1Q4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55104C4CECC;
	Tue,  8 Oct 2024 13:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728393578;
	bh=JSGWA4/0Ol02wqsFLJXxJvD2wCkeY9Ae+FuVLpRaHfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FACIq1Q4bjuwoRS+v5VN4929zh99KBqTnrZokvJL82ZEEJiXlv/ezNFRbCgRezEXx
	 pPCuzZFACvi5zrKdEoRfbA3BAAFlaLND+Fai0w7efjD/Xq3dd+fFPtj9mw4wZRuEhn
	 dGqgPROXx1lrcj6NjQVzck+g2W8bBqGYoBZ8/7hc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrii Nakryiko <andrii@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 162/386] perf,x86: avoid missing caller address in stack traces captured in uprobe
Date: Tue,  8 Oct 2024 14:06:47 +0200
Message-ID: <20241008115635.799939345@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
References: <20241008115629.309157387@linuxfoundation.org>
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

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit cfa7f3d2c526c224a6271cc78a4a27a0de06f4f0 ]

When tracing user functions with uprobe functionality, it's common to
install the probe (e.g., a BPF program) at the first instruction of the
function. This is often going to be `push %rbp` instruction in function
preamble, which means that within that function frame pointer hasn't
been established yet. This leads to consistently missing an actual
caller of the traced function, because perf_callchain_user() only
records current IP (capturing traced function) and then following frame
pointer chain (which would be caller's frame, containing the address of
caller's caller).

So when we have target_1 -> target_2 -> target_3 call chain and we are
tracing an entry to target_3, captured stack trace will report
target_1 -> target_3 call chain, which is wrong and confusing.

This patch proposes a x86-64-specific heuristic to detect `push %rbp`
(`push %ebp` on 32-bit architecture) instruction being traced. Given
entire kernel implementation of user space stack trace capturing works
under assumption that user space code was compiled with frame pointer
register (%rbp/%ebp) preservation, it seems pretty reasonable to use
this instruction as a strong indicator that this is the entry to the
function. In that case, return address is still pointed to by %rsp/%esp,
so we fetch it and add to stack trace before proceeding to unwind the
rest using frame pointer-based logic.

We also check for `endbr64` (for 64-bit modes) as another common pattern
for function entry, as suggested by Josh Poimboeuf. Even if we get this
wrong sometimes for uprobes attached not at the function entry, it's OK
because stack trace will still be overall meaningful, just with one
extra bogus entry. If we don't detect this, we end up with guaranteed to
be missing caller function entry in the stack trace, which is worse
overall.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20240729175223.23914-1-andrii@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/core.c  | 63 +++++++++++++++++++++++++++++++++++++++++
 include/linux/uprobes.h |  2 ++
 kernel/events/uprobes.c |  2 ++
 3 files changed, 67 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8811fedc9776a..150a365b4fbc8 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -41,6 +41,8 @@
 #include <asm/desc.h>
 #include <asm/ldt.h>
 #include <asm/unwind.h>
+#include <asm/uprobes.h>
+#include <asm/ibt.h>
 
 #include "perf_event.h"
 
@@ -2816,6 +2818,46 @@ static unsigned long get_segment_base(unsigned int segment)
 	return get_desc_base(desc);
 }
 
+#ifdef CONFIG_UPROBES
+/*
+ * Heuristic-based check if uprobe is installed at the function entry.
+ *
+ * Under assumption of user code being compiled with frame pointers,
+ * `push %rbp/%ebp` is a good indicator that we indeed are.
+ *
+ * Similarly, `endbr64` (assuming 64-bit mode) is also a common pattern.
+ * If we get this wrong, captured stack trace might have one extra bogus
+ * entry, but the rest of stack trace will still be meaningful.
+ */
+static bool is_uprobe_at_func_entry(struct pt_regs *regs)
+{
+	struct arch_uprobe *auprobe;
+
+	if (!current->utask)
+		return false;
+
+	auprobe = current->utask->auprobe;
+	if (!auprobe)
+		return false;
+
+	/* push %rbp/%ebp */
+	if (auprobe->insn[0] == 0x55)
+		return true;
+
+	/* endbr64 (64-bit only) */
+	if (user_64bit_mode(regs) && is_endbr(*(u32 *)auprobe->insn))
+		return true;
+
+	return false;
+}
+
+#else
+static bool is_uprobe_at_func_entry(struct pt_regs *regs)
+{
+	return false;
+}
+#endif /* CONFIG_UPROBES */
+
 #ifdef CONFIG_IA32_EMULATION
 
 #include <linux/compat.h>
@@ -2827,6 +2869,7 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *ent
 	unsigned long ss_base, cs_base;
 	struct stack_frame_ia32 frame;
 	const struct stack_frame_ia32 __user *fp;
+	u32 ret_addr;
 
 	if (user_64bit_mode(regs))
 		return 0;
@@ -2836,6 +2879,12 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *ent
 
 	fp = compat_ptr(ss_base + regs->bp);
 	pagefault_disable();
+
+	/* see perf_callchain_user() below for why we do this */
+	if (is_uprobe_at_func_entry(regs) &&
+	    !get_user(ret_addr, (const u32 __user *)regs->sp))
+		perf_callchain_store(entry, ret_addr);
+
 	while (entry->nr < entry->max_stack) {
 		if (!valid_user_frame(fp, sizeof(frame)))
 			break;
@@ -2864,6 +2913,7 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs
 {
 	struct stack_frame frame;
 	const struct stack_frame __user *fp;
+	unsigned long ret_addr;
 
 	if (perf_guest_state()) {
 		/* TODO: We don't support guest os callchain now */
@@ -2887,6 +2937,19 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs
 		return;
 
 	pagefault_disable();
+
+	/*
+	 * If we are called from uprobe handler, and we are indeed at the very
+	 * entry to user function (which is normally a `push %rbp` instruction,
+	 * under assumption of application being compiled with frame pointers),
+	 * we should read return address from *regs->sp before proceeding
+	 * to follow frame pointers, otherwise we'll skip immediate caller
+	 * as %rbp is not yet setup.
+	 */
+	if (is_uprobe_at_func_entry(regs) &&
+	    !get_user(ret_addr, (const unsigned long __user *)regs->sp))
+		perf_callchain_store(entry, ret_addr);
+
 	while (entry->nr < entry->max_stack) {
 		if (!valid_user_frame(fp, sizeof(frame)))
 			break;
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index f46e0ca0169c7..d91e32aff5a13 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -76,6 +76,8 @@ struct uprobe_task {
 	struct uprobe			*active_uprobe;
 	unsigned long			xol_vaddr;
 
+	struct arch_uprobe              *auprobe;
+
 	struct return_instance		*return_instances;
 	unsigned int			depth;
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4705571f80345..6876b7f152b10 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2071,6 +2071,7 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 	bool need_prep = false; /* prepare return uprobe, when needed */
 
 	down_read(&uprobe->register_rwsem);
+	current->utask->auprobe = &uprobe->arch;
 	for (uc = uprobe->consumers; uc; uc = uc->next) {
 		int rc = 0;
 
@@ -2085,6 +2086,7 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 
 		remove &= rc;
 	}
+	current->utask->auprobe = NULL;
 
 	if (need_prep && !remove)
 		prepare_uretprobe(uprobe, regs); /* put bp at return */
-- 
2.43.0




