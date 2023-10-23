Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6367D3540
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbjJWLql (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbjJWLq2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:46:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B59310E4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:46:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACAC2C433C8;
        Mon, 23 Oct 2023 11:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061579;
        bh=aJbINt584ypx/SXcQWT5R1EAvPT3hsLqRm39BeL92Ko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ga7ZXLGf5vpXBV+wfSLqFYHgsDdfGYnhYRTq5B/dI5jo422WZnJshzs9HCQoe/CaQ
         WA/EmtgTvzZgp2GAdLDMFRPCPiQxBzU6ynQ/7EMZYKR1zpneHITfSeg4VTtKLWC48N
         eDmZwoKInfXfrvR1z92k9FO9L+mmnblBM4cDUzQI=
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
Subject: [PATCH 5.10 068/202] arm64: allow kprobes on EL0 handlers
Date:   Mon, 23 Oct 2023 12:56:15 +0200
Message-ID: <20231023104828.537185144@linuxfoundation.org>
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

commit b3a0c010e900a9f89dcd99f10bd8f7538d21b0a9 upstream.

Currently do_sysinstr() and do_cp15instr() are marked with
NOKPROBE_SYMBOL(). However, these are only called for exceptions taken
from EL0, and there is no risk of recursion in kprobes, so this is not
necessary.

Remove the NOKPROBE_SYMBOL() annotation, and rename the two functions to
more clearly indicate that these are solely for exceptions taken from
EL0, better matching the names used by the lower level entry points in
entry-common.c.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20221019144123.612388-2-mark.rutland@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/exception.h |    4 ++--
 arch/arm64/kernel/entry-common.c   |    4 ++--
 arch/arm64/kernel/traps.c          |    6 ++----
 3 files changed, 6 insertions(+), 8 deletions(-)

--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -42,10 +42,10 @@ void do_debug_exception(unsigned long ad
 void do_fpsimd_acc(unsigned int esr, struct pt_regs *regs);
 void do_sve_acc(unsigned int esr, struct pt_regs *regs);
 void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs);
-void do_sysinstr(unsigned int esr, struct pt_regs *regs);
+void do_el0_sys(unsigned long esr, struct pt_regs *regs);
 void do_sp_pc_abort(unsigned long addr, unsigned int esr, struct pt_regs *regs);
 void bad_el0_sync(struct pt_regs *regs, int reason, unsigned int esr);
-void do_cp15instr(unsigned int esr, struct pt_regs *regs);
+void do_el0_cp15(unsigned long esr, struct pt_regs *regs);
 void do_el0_svc(struct pt_regs *regs);
 void do_el0_svc_compat(struct pt_regs *regs);
 void do_el0_fpac(struct pt_regs *regs, unsigned long esr);
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -306,7 +306,7 @@ static void noinstr el0_sys(struct pt_re
 {
 	enter_from_user_mode();
 	local_daif_restore(DAIF_PROCCTX);
-	do_sysinstr(esr, regs);
+	do_el0_sys(esr, regs);
 }
 
 static void noinstr el0_pc(struct pt_regs *regs, unsigned long esr)
@@ -430,7 +430,7 @@ static void noinstr el0_cp15(struct pt_r
 {
 	enter_from_user_mode();
 	local_daif_restore(DAIF_PROCCTX);
-	do_cp15instr(esr, regs);
+	do_el0_cp15(esr, regs);
 }
 
 static void noinstr el0_svc_compat(struct pt_regs *regs)
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -650,7 +650,7 @@ static const struct sys64_hook cp15_64_h
 	{},
 };
 
-void do_cp15instr(unsigned int esr, struct pt_regs *regs)
+void do_el0_cp15(unsigned long esr, struct pt_regs *regs)
 {
 	const struct sys64_hook *hook, *hook_base;
 
@@ -688,10 +688,9 @@ void do_cp15instr(unsigned int esr, stru
 	 */
 	do_undefinstr(regs, esr);
 }
-NOKPROBE_SYMBOL(do_cp15instr);
 #endif
 
-void do_sysinstr(unsigned int esr, struct pt_regs *regs)
+void do_el0_sys(unsigned long esr, struct pt_regs *regs)
 {
 	const struct sys64_hook *hook;
 
@@ -708,7 +707,6 @@ void do_sysinstr(unsigned int esr, struc
 	 */
 	do_undefinstr(regs, esr);
 }
-NOKPROBE_SYMBOL(do_sysinstr);
 
 static const char *esr_class_str[] = {
 	[0 ... ESR_ELx_EC_MAX]		= "UNRECOGNIZED EC",


