Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BE37CA273
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbjJPIt5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjJPIt4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:49:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60AFEA
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:49:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98A4C433CB;
        Mon, 16 Oct 2023 08:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446194;
        bh=8OOVXTBxwOsFZZP5qh+PBwila+o0LqAlPiiwAF1Mwk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HOayMtda8Uke38I7V5nQ01ZSdGlqXJiquRGbePMTjqKnRdm/hKs22Iok9l0j3tUbI
         Zx9MFuYTUMWL8s5ScBJHA/WYbCluT2iKhEAgTDbyNbHzRa6kKx2qsDSn8aw+Fx9rMf
         HPKiWcnzCT2+Dc6dHZsmA2lta09gPihjihz/lcyg=
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
Subject: [PATCH 5.15 091/102] arm64: split EL0/EL1 UNDEF handlers
Date:   Mon, 16 Oct 2023 10:41:30 +0200
Message-ID: <20231016083956.119992807@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

commit 61d64a376ea80f9097e7ea599bcd68671b836dc6 upstream.

In general, exceptions taken from EL1 need to be handled separately from
exceptions taken from EL0, as the logic to handle the two cases can be
significantly divergent, and exceptions taken from EL1 typically have
more stringent requirements on locking and instrumentation.

Subsequent patches will rework the way EL1 UNDEFs are handled in order
to address longstanding soundness issues with instrumentation and RCU.
In preparation for that rework, this patch splits the existing
do_undefinstr() handler into separate do_el0_undef() and do_el1_undef()
handlers.

Prior to this patch, do_undefinstr() was marked with NOKPROBE_SYMBOL(),
preventing instrumentation via kprobes. However, do_undefinstr() invokes
other code which can be instrumented, and:

* For UNDEFINED exceptions taken from EL0, there is no risk of recursion
  within kprobes. Therefore it is safe for do_el0_undef to be
  instrumented with kprobes, and it does not need to be marked with
  NOKPROBE_SYMBOL().

* For UNDEFINED exceptions taken from EL1, either:

  (a) The exception is has been taken when manipulating SSBS; these cases
      are limited and do not occur within code that can be invoked
      recursively via kprobes. Hence, in these cases instrumentation
      with kprobes is benign.

  (b) The exception has been taken for an unknown reason, as other than
      manipulating SSBS we do not expect to take UNDEFINED exceptions
      from EL1. Any handling of these exception is best-effort.

  ... and in either case, marking do_el1_undef() with NOKPROBE_SYMBOL()
  isn't sufficient to prevent recursion via kprobes as functions it
  calls (including die()) are instrumentable via kprobes.

  Hence, it's not worthwhile to mark do_el1_undef() with
  NOKPROBE_SYMBOL(). The same applies to do_el1_bti() and do_el1_fpac(),
  so their NOKPROBE_SYMBOL() annotations are also removed.

Aside from the new instrumentability, there should be no functional
change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20221019144123.612388-3-mark.rutland@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/exception.h |    3 ++-
 arch/arm64/kernel/entry-common.c   |    4 ++--
 arch/arm64/kernel/traps.c          |   22 ++++++++++++----------
 3 files changed, 16 insertions(+), 13 deletions(-)

--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -58,7 +58,8 @@ asmlinkage void call_on_irq_stack(struct
 asmlinkage void asm_exit_to_user_mode(struct pt_regs *regs);
 
 void do_mem_abort(unsigned long far, unsigned long esr, struct pt_regs *regs);
-void do_undefinstr(struct pt_regs *regs, unsigned long esr);
+void do_el0_undef(struct pt_regs *regs, unsigned long esr);
+void do_el1_undef(struct pt_regs *regs, unsigned long esr);
 void do_el0_bti(struct pt_regs *regs);
 void do_el1_bti(struct pt_regs *regs, unsigned long esr);
 void do_debug_exception(unsigned long addr_if_watchpoint, unsigned long esr,
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -375,7 +375,7 @@ static void noinstr el1_undef(struct pt_
 {
 	enter_from_kernel_mode(regs);
 	local_daif_inherit(regs);
-	do_undefinstr(regs, esr);
+	do_el1_undef(regs, esr);
 	local_daif_mask();
 	exit_to_kernel_mode(regs);
 }
@@ -570,7 +570,7 @@ static void noinstr el0_undef(struct pt_
 {
 	enter_from_user_mode(regs);
 	local_daif_restore(DAIF_PROCCTX);
-	do_undefinstr(regs, esr);
+	do_el0_undef(regs, esr);
 	exit_to_user_mode(regs);
 }
 
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -486,7 +486,7 @@ void arm64_notify_segfault(unsigned long
 	force_signal_inject(SIGSEGV, code, addr, 0);
 }
 
-void do_undefinstr(struct pt_regs *regs, unsigned long esr)
+void do_el0_undef(struct pt_regs *regs, unsigned long esr)
 {
 	/* check for AArch32 breakpoint instructions */
 	if (!aarch32_break_handler(regs))
@@ -495,12 +495,16 @@ void do_undefinstr(struct pt_regs *regs,
 	if (call_undef_hook(regs) == 0)
 		return;
 
-	if (!user_mode(regs))
-		die("Oops - Undefined instruction", regs, esr);
-
 	force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
 }
-NOKPROBE_SYMBOL(do_undefinstr);
+
+void do_el1_undef(struct pt_regs *regs, unsigned long esr)
+{
+	if (call_undef_hook(regs) == 0)
+		return;
+
+	die("Oops - Undefined instruction", regs, esr);
+}
 
 void do_el0_bti(struct pt_regs *regs)
 {
@@ -511,7 +515,6 @@ void do_el1_bti(struct pt_regs *regs, un
 {
 	die("Oops - BTI", regs, esr);
 }
-NOKPROBE_SYMBOL(do_el1_bti);
 
 void do_el0_fpac(struct pt_regs *regs, unsigned long esr)
 {
@@ -526,7 +529,6 @@ void do_el1_fpac(struct pt_regs *regs, u
 	 */
 	die("Oops - FPAC", regs, esr);
 }
-NOKPROBE_SYMBOL(do_el1_fpac);
 
 #define __user_cache_maint(insn, address, res)			\
 	if (address >= user_addr_max()) {			\
@@ -763,7 +765,7 @@ void do_el0_cp15(unsigned long esr, stru
 		hook_base = cp15_64_hooks;
 		break;
 	default:
-		do_undefinstr(regs, esr);
+		do_el0_undef(regs, esr);
 		return;
 	}
 
@@ -778,7 +780,7 @@ void do_el0_cp15(unsigned long esr, stru
 	 * EL0. Fall back to our usual undefined instruction handler
 	 * so that we handle these consistently.
 	 */
-	do_undefinstr(regs, esr);
+	do_el0_undef(regs, esr);
 }
 #endif
 
@@ -797,7 +799,7 @@ void do_el0_sys(unsigned long esr, struc
 	 * back to our usual undefined instruction handler so that we handle
 	 * these consistently.
 	 */
-	do_undefinstr(regs, esr);
+	do_el0_undef(regs, esr);
 }
 
 static const char *esr_class_str[] = {


