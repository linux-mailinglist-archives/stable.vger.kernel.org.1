Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61CE7CAC8E
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbjJPOz7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbjJPOzx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:55:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B21E3
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:55:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84253C433C8;
        Mon, 16 Oct 2023 14:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697468150;
        bh=yE/D6o0f9bQDmspG10nLw/xcdjwKwvAyQ40Sl1tdD18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2FzBOwZIFBgOtaHSe/sct/i0/4Adg+Svoj7HGF6S+g1dRE7cXSOpeUYAq5lgKqkCe
         y0iGrJKNNPi1GUCmjLQRjaVYnv+Bt1mqh69Tl7tERYFC2U92VPm6aCEFu9smk8YSyX
         4nqcg3pjSbhGmaqkXGUSE4Inquj/E4bBqTHevtKg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Guo Ren <guoren@kernel.org>,
        Nam Cao <namcaov@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 6.5 167/191] riscv: Only consider swbp/ss handlers for correct privileged mode
Date:   Mon, 16 Oct 2023 10:42:32 +0200
Message-ID: <20231016084019.274700229@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Björn Töpel <bjorn@rivosinc.com>

commit 9f564b92cf6d0ecb398f9348600a7d8a7f8ea804 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/include/asm/kprobes.h |    9 +++++++++
 arch/riscv/include/asm/uprobes.h |   11 +++++++++++
 arch/riscv/kernel/traps.c        |   28 ++++++++++++++++++----------
 3 files changed, 38 insertions(+), 10 deletions(-)

--- a/arch/riscv/include/asm/kprobes.h
+++ b/arch/riscv/include/asm/kprobes.h
@@ -40,6 +40,15 @@ void arch_remove_kprobe(struct kprobe *p
 int kprobe_fault_handler(struct pt_regs *regs, unsigned int trapnr);
 bool kprobe_breakpoint_handler(struct pt_regs *regs);
 bool kprobe_single_step_handler(struct pt_regs *regs);
+#else
+static inline bool kprobe_breakpoint_handler(struct pt_regs *regs)
+{
+	return false;
+}
 
+static inline bool kprobe_single_step_handler(struct pt_regs *regs)
+{
+	return false;
+}
 #endif /* CONFIG_KPROBES */
 #endif /* _ASM_RISCV_KPROBES_H */
--- a/arch/riscv/include/asm/uprobes.h
+++ b/arch/riscv/include/asm/uprobes.h
@@ -34,7 +34,18 @@ struct arch_uprobe {
 	bool simulate;
 };
 
+#ifdef CONFIG_UPROBES
 bool uprobe_breakpoint_handler(struct pt_regs *regs);
 bool uprobe_single_step_handler(struct pt_regs *regs);
+#else
+static inline bool uprobe_breakpoint_handler(struct pt_regs *regs)
+{
+	return false;
+}
 
+static inline bool uprobe_single_step_handler(struct pt_regs *regs)
+{
+	return false;
+}
+#endif /* CONFIG_UPROBES */
 #endif /* _ASM_RISCV_UPROBES_H */
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
@@ -246,22 +248,28 @@ static inline unsigned long get_break_in
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


