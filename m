Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16247C9AC4
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 20:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjJOS2J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 14:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJOS2I (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 14:28:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9B7AB
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 11:28:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B13C433C7;
        Sun, 15 Oct 2023 18:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697394486;
        bh=aJ7incBGezyAdGMwfferGvcInTwXuZXTg2Ta+wlGytg=;
        h=Subject:To:Cc:From:Date:From;
        b=V9K7kYAPhbnbkskDNmV5GPK3obfKg+AKmTIuYweuxt4FTISuVXR9J46OJ7PpG4sEQ
         AjagsCyH2rTYvufOi58hcIuUnSRLSJAI4iwq8kvm+IrayvNxjaPvF/vrsgzxXTPd32
         mWS3RfVJsoKw4ehYbF5eWuIDZ3S+/Ctxs+2fJ4/U=
Subject: FAILED: patch "[PATCH] riscv: Only consider swbp/ss handlers for correct privileged" failed to apply to 6.1-stable tree
To:     bjorn@rivosinc.com, guoren@kernel.org, namcaov@gmail.com,
        palmer@rivosinc.com, puranjay12@gmail.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 15 Oct 2023 20:28:00 +0200
Message-ID: <2023101500-bubbly-batboy-9184@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9f564b92cf6d0ecb398f9348600a7d8a7f8ea804
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023101500-bubbly-batboy-9184@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

9f564b92cf6d ("riscv: Only consider swbp/ss handlers for correct privileged mode")
f0bddf50586d ("riscv: entry: Convert to generic entry")
c3ec1e8964fb ("Merge patch series "RISC-V: Align the shadow stack"")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9f564b92cf6d0ecb398f9348600a7d8a7f8ea804 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Date: Tue, 12 Sep 2023 08:56:19 +0200
Subject: [PATCH] riscv: Only consider swbp/ss handlers for correct privileged
 mode
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

RISC-V software breakpoint trap handlers are used for {k,u}probes.

When trapping from kernelmode, only the kernelmode handlers should be
considered. Vice versa, only usermode handlers for usermode
traps. This is not the case on RISC-V, which can trigger a bug if a
userspace process uses uprobes, and a WARN() is triggered from
kernelmode (which is implemented via {c.,}ebreak).

The kernel will trap on the kernelmode {c.,}ebreak, look for uprobes
handlers, realize incorrectly that uprobes need to be handled, and
exit the trap handler early. The trap returns to re-executing the
{c.,}ebreak, and enter an infinite trap-loop.

The issue was found running the BPF selftest [1].

Fix this issue by only considering the swbp/ss handlers for
kernel/usermode respectively. Also, move CONFIG ifdeffery from traps.c
to the asm/{k,u}probes.h headers.

Note that linux/uprobes.h only include asm/uprobes.h if CONFIG_UPROBES
is defined, which is why asm/uprobes.h needs to be unconditionally
included in traps.c

Link: https://lore.kernel.org/linux-riscv/87v8d19aun.fsf@all.your.base.are.belong.to.us/ # [1]
Fixes: 74784081aac8 ("riscv: Add uprobes supported")
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Nam Cao <namcaov@gmail.com>
Tested-by: Puranjay Mohan <puranjay12@gmail.com>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
Link: https://lore.kernel.org/r/20230912065619.62020-1-bjorn@kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kprobes.h
index e7882ccb0fd4..78ea44f76718 100644
--- a/arch/riscv/include/asm/kprobes.h
+++ b/arch/riscv/include/asm/kprobes.h
@@ -40,6 +40,15 @@ void arch_remove_kprobe(struct kprobe *p);
 int kprobe_fault_handler(struct pt_regs *regs, unsigned int trapnr);
 bool kprobe_breakpoint_handler(struct pt_regs *regs);
 bool kprobe_single_step_handler(struct pt_regs *regs);
-
+#else
+static inline bool kprobe_breakpoint_handler(struct pt_regs *regs)
+{
+	return false;
+}
+
+static inline bool kprobe_single_step_handler(struct pt_regs *regs)
+{
+	return false;
+}
 #endif /* CONFIG_KPROBES */
 #endif /* _ASM_RISCV_KPROBES_H */
diff --git a/arch/riscv/include/asm/uprobes.h b/arch/riscv/include/asm/uprobes.h
index f2183e00fdd2..3fc7deda9190 100644
--- a/arch/riscv/include/asm/uprobes.h
+++ b/arch/riscv/include/asm/uprobes.h
@@ -34,7 +34,18 @@ struct arch_uprobe {
 	bool simulate;
 };
 
+#ifdef CONFIG_UPROBES
 bool uprobe_breakpoint_handler(struct pt_regs *regs);
 bool uprobe_single_step_handler(struct pt_regs *regs);
-
+#else
+static inline bool uprobe_breakpoint_handler(struct pt_regs *regs)
+{
+	return false;
+}
+
+static inline bool uprobe_single_step_handler(struct pt_regs *regs)
+{
+	return false;
+}
+#endif /* CONFIG_UPROBES */
 #endif /* _ASM_RISCV_UPROBES_H */
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 19807c4d3805..fae8f610d867 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -13,6 +13,8 @@
 #include <linux/kdebug.h>
 #include <linux/uaccess.h>
 #include <linux/kprobes.h>
+#include <linux/uprobes.h>
+#include <asm/uprobes.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/irq.h>
@@ -247,22 +249,28 @@ static inline unsigned long get_break_insn_length(unsigned long pc)
 	return GET_INSN_LENGTH(insn);
 }
 
+static bool probe_single_step_handler(struct pt_regs *regs)
+{
+	bool user = user_mode(regs);
+
+	return user ? uprobe_single_step_handler(regs) : kprobe_single_step_handler(regs);
+}
+
+static bool probe_breakpoint_handler(struct pt_regs *regs)
+{
+	bool user = user_mode(regs);
+
+	return user ? uprobe_breakpoint_handler(regs) : kprobe_breakpoint_handler(regs);
+}
+
 void handle_break(struct pt_regs *regs)
 {
-#ifdef CONFIG_KPROBES
-	if (kprobe_single_step_handler(regs))
+	if (probe_single_step_handler(regs))
 		return;
 
-	if (kprobe_breakpoint_handler(regs))
-		return;
-#endif
-#ifdef CONFIG_UPROBES
-	if (uprobe_single_step_handler(regs))
+	if (probe_breakpoint_handler(regs))
 		return;
 
-	if (uprobe_breakpoint_handler(regs))
-		return;
-#endif
 	current->thread.bad_cause = regs->cause;
 
 	if (user_mode(regs))

