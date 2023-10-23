Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE3B7D3543
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbjJWLqs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbjJWLqe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:46:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1F6FD
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:46:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F48C433C8;
        Mon, 23 Oct 2023 11:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061588;
        bh=g2CL/b7/1PpQIxYbqGrjv9+kAe4QE79U5cLP4YAjFpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jXZ2/ZAaqDPPvgo2RxS1wtiCE2pXXZOuQHNDnvI6mJYng8LaxsEBdggJbbl3+W9bv
         hTz8MTRITR/cq2GhWStuDd7Q9IFGcNrZxwpFtOv6/GYV3YRWKiwNM3So/YiF6ebaPc
         /phKO7iDfNbDnoY1yiNbqS8h/YOzxqlzkXQyUwN0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, ruanjinjie@huawei.com,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 5.10 071/202] arm64: factor insn read out of call_undef_hook()
Date:   Mon, 23 Oct 2023 12:56:18 +0200
Message-ID: <20231023104828.621723559@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

commit dbfbd87efa79575491af0ba1a87bf567eaea6cae upstream.

Subsequent patches will rework EL0 UNDEF handling, removing the need for
struct undef_hook and call_undef_hook. In preparation for those changes,
this patch factors the logic for reading user instructions out of
call_undef_hook() and into a new user_insn_read() helper, matching the
style of the existing aarch64_insn_read() helper used for reading kernel
instructions.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20221019144123.612388-5-mark.rutland@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/traps.c |   31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -303,25 +303,22 @@ void unregister_undef_hook(struct undef_
 	raw_spin_unlock_irqrestore(&undef_lock, flags);
 }
 
-static int call_undef_hook(struct pt_regs *regs)
+static int user_insn_read(struct pt_regs *regs, u32 *insnp)
 {
-	struct undef_hook *hook;
-	unsigned long flags;
 	u32 instr;
-	int (*fn)(struct pt_regs *regs, u32 instr) = NULL;
 	void __user *pc = (void __user *)instruction_pointer(regs);
 
 	if (compat_thumb_mode(regs)) {
 		/* 16-bit Thumb instruction */
 		__le16 instr_le;
 		if (get_user(instr_le, (__le16 __user *)pc))
-			goto exit;
+			return -EFAULT;
 		instr = le16_to_cpu(instr_le);
 		if (aarch32_insn_is_wide(instr)) {
 			u32 instr2;
 
 			if (get_user(instr_le, (__le16 __user *)(pc + 2)))
-				goto exit;
+				return -EFAULT;
 			instr2 = le16_to_cpu(instr_le);
 			instr = (instr << 16) | instr2;
 		}
@@ -329,10 +326,20 @@ static int call_undef_hook(struct pt_reg
 		/* 32-bit ARM instruction */
 		__le32 instr_le;
 		if (get_user(instr_le, (__le32 __user *)pc))
-			goto exit;
+			return -EFAULT;
 		instr = le32_to_cpu(instr_le);
 	}
 
+	*insnp = instr;
+	return 0;
+}
+
+static int call_undef_hook(struct pt_regs *regs, u32 instr)
+{
+	struct undef_hook *hook;
+	unsigned long flags;
+	int (*fn)(struct pt_regs *regs, u32 instr) = NULL;
+
 	raw_spin_lock_irqsave(&undef_lock, flags);
 	list_for_each_entry(hook, &undef_hook, node)
 		if ((instr & hook->instr_mask) == hook->instr_val &&
@@ -340,7 +347,7 @@ static int call_undef_hook(struct pt_reg
 			fn = hook->fn;
 
 	raw_spin_unlock_irqrestore(&undef_lock, flags);
-exit:
+
 	return fn ? fn(regs, instr) : 1;
 }
 
@@ -392,13 +399,19 @@ void arm64_notify_segfault(unsigned long
 
 void do_el0_undef(struct pt_regs *regs, unsigned long esr)
 {
+	u32 insn;
+
 	/* check for AArch32 breakpoint instructions */
 	if (!aarch32_break_handler(regs))
 		return;
 
-	if (call_undef_hook(regs) == 0)
+	if (user_insn_read(regs, &insn))
+		goto out_err;
+
+	if (call_undef_hook(regs, insn) == 0)
 		return;
 
+out_err:
 	force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
 }
 


