Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4E97CA26E
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjJPItu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbjJPItt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:49:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453D8DC
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:49:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B52C433C8;
        Mon, 16 Oct 2023 08:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446185;
        bh=xkRy7H1IbvYHFLgXrVVNNCUpsw18I/L+toipTAiyM4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UZE1oygxyAfRMnTmaOnGIcYBHf2HWH/tcOz+1wKTNE35qCis07ZRkLEKvzbceDhvA
         m38iK3fVNLNVkkc2Zhh4IMa2fI4GGHhl1h5Q9weKCxHufRVJafReLk45kBZs4deRtv
         lbRKBQhcU7TiT5XoXaAFOij7W5iOMz9TmsLWzpZ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, ruanjinjie@huawei.com,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 5.15 089/102] arm64: rework BTI exception handling
Date:   Mon, 16 Oct 2023 10:41:28 +0200
Message-ID: <20231016083956.066747378@linuxfoundation.org>
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

commit 830a2a4d853f2c4a1e4606aa03341b7f273b0e9b upstream.

If a BTI exception is taken from EL1, the entry code will treat this as
an unhandled exception and will panic() the kernel. This is inconsistent
with the way we handle FPAC exceptions, which have a dedicated handler
and only necessarily kill the thread from which the exception was taken
from, and we don't log all the information that could be relevant to
debug the issue.

The code in do_bti() has:

	BUG_ON(!user_mode(regs));

... and it seems like the intent was to call this for EL1 BTI
exceptions, as with FPAC, but this was omitted due to an oversight.

This patch adds separate EL0 and EL1 BTI exception handlers, with the
latter calling die() directly to report the original context the BTI
exception was taken from. This matches our handling of FPAC exceptions.

Prior to this patch, a BTI failure is reported as:

| Unhandled 64-bit el1h sync exception on CPU0, ESR 0x0000000034000002 -- BTI
| CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc3-00131-g7d937ff0221d-dirty #9
| Hardware name: linux,dummy-virt (DT)
| pstate: 20400809 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=-c)
| pc : test_bti_callee+0x4/0x10
| lr : test_bti_caller+0x1c/0x28
| sp : ffff80000800bdf0
| x29: ffff80000800bdf0 x28: 0000000000000000 x27: 0000000000000000
| x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
| x23: ffff80000a2b8000 x22: 0000000000000000 x21: 0000000000000000
| x20: ffff8000099fa5b0 x19: ffff800009ff7000 x18: fffffbfffda37000
| x17: 3120676e696d7573 x16: 7361202c6e6f6974 x15: 0000000041a90000
| x14: 0040000000000041 x13: 0040000000000001 x12: ffff000001a90000
| x11: fffffbfffda37480 x10: 0068000000000703 x9 : 0001000040000000
| x8 : 0000000000090000 x7 : 0068000000000f03 x6 : 0060000000000f83
| x5 : ffff80000a2b6000 x4 : ffff0000028d0000 x3 : ffff800009f78378
| x2 : 0000000000000000 x1 : 0000000040210000 x0 : ffff8000080257e4
| Kernel panic - not syncing: Unhandled exception
| CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc3-00131-g7d937ff0221d-dirty #9
| Hardware name: linux,dummy-virt (DT)
| Call trace:
|  dump_backtrace.part.0+0xcc/0xe0
|  show_stack+0x18/0x5c
|  dump_stack_lvl+0x64/0x80
|  dump_stack+0x18/0x34
|  panic+0x170/0x360
|  arm64_exit_nmi.isra.0+0x0/0x80
|  el1h_64_sync_handler+0x64/0xd0
|  el1h_64_sync+0x64/0x68
|  test_bti_callee+0x4/0x10
|  smp_cpus_done+0xb0/0xbc
|  smp_init+0x7c/0x8c
|  kernel_init_freeable+0x128/0x28c
|  kernel_init+0x28/0x13c
|  ret_from_fork+0x10/0x20

With this patch applied, a BTI failure is reported as:

| Internal error: Oops - BTI: 0000000034000002 [#1] PREEMPT SMP
| Modules linked in:
| CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc3-00132-g0ad98265d582-dirty #8
| Hardware name: linux,dummy-virt (DT)
| pstate: 20400809 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=-c)
| pc : test_bti_callee+0x4/0x10
| lr : test_bti_caller+0x1c/0x28
| sp : ffff80000800bdf0
| x29: ffff80000800bdf0 x28: 0000000000000000 x27: 0000000000000000
| x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
| x23: ffff80000a2b8000 x22: 0000000000000000 x21: 0000000000000000
| x20: ffff8000099fa5b0 x19: ffff800009ff7000 x18: fffffbfffda37000
| x17: 3120676e696d7573 x16: 7361202c6e6f6974 x15: 0000000041a90000
| x14: 0040000000000041 x13: 0040000000000001 x12: ffff000001a90000
| x11: fffffbfffda37480 x10: 0068000000000703 x9 : 0001000040000000
| x8 : 0000000000090000 x7 : 0068000000000f03 x6 : 0060000000000f83
| x5 : ffff80000a2b6000 x4 : ffff0000028d0000 x3 : ffff800009f78378
| x2 : 0000000000000000 x1 : 0000000040210000 x0 : ffff800008025804
| Call trace:
|  test_bti_callee+0x4/0x10
|  smp_cpus_done+0xb0/0xbc
|  smp_init+0x7c/0x8c
|  kernel_init_freeable+0x128/0x28c
|  kernel_init+0x28/0x13c
|  ret_from_fork+0x10/0x20
| Code: d50323bf d53cd040 d65f03c0 d503233f (d50323bf)

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20220913101732.3925290-6-mark.rutland@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/exception.h |    3 ++-
 arch/arm64/kernel/entry-common.c   |   14 +++++++++++++-
 arch/arm64/kernel/traps.c          |   10 +++++++---
 3 files changed, 22 insertions(+), 5 deletions(-)

--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -59,7 +59,8 @@ asmlinkage void asm_exit_to_user_mode(st
 
 void do_mem_abort(unsigned long far, unsigned long esr, struct pt_regs *regs);
 void do_undefinstr(struct pt_regs *regs, unsigned long esr);
-void do_bti(struct pt_regs *regs);
+void do_el0_bti(struct pt_regs *regs);
+void do_el1_bti(struct pt_regs *regs, unsigned long esr);
 void do_debug_exception(unsigned long addr_if_watchpoint, unsigned long esr,
 			struct pt_regs *regs);
 void do_fpsimd_acc(unsigned long esr, struct pt_regs *regs);
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -380,6 +380,15 @@ static void noinstr el1_undef(struct pt_
 	exit_to_kernel_mode(regs);
 }
 
+static void noinstr el1_bti(struct pt_regs *regs, unsigned long esr)
+{
+	enter_from_kernel_mode(regs);
+	local_daif_inherit(regs);
+	do_el1_bti(regs, esr);
+	local_daif_mask();
+	exit_to_kernel_mode(regs);
+}
+
 static void noinstr el1_dbg(struct pt_regs *regs, unsigned long esr)
 {
 	unsigned long far = read_sysreg(far_el1);
@@ -419,6 +428,9 @@ asmlinkage void noinstr el1h_64_sync_han
 	case ESR_ELx_EC_UNKNOWN:
 		el1_undef(regs, esr);
 		break;
+	case ESR_ELx_EC_BTI:
+		el1_bti(regs, esr);
+		break;
 	case ESR_ELx_EC_BREAKPT_CUR:
 	case ESR_ELx_EC_SOFTSTP_CUR:
 	case ESR_ELx_EC_WATCHPT_CUR:
@@ -566,7 +578,7 @@ static void noinstr el0_bti(struct pt_re
 {
 	enter_from_user_mode(regs);
 	local_daif_restore(DAIF_PROCCTX);
-	do_bti(regs);
+	do_el0_bti(regs);
 	exit_to_user_mode(regs);
 }
 
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -502,12 +502,16 @@ void do_undefinstr(struct pt_regs *regs,
 }
 NOKPROBE_SYMBOL(do_undefinstr);
 
-void do_bti(struct pt_regs *regs)
+void do_el0_bti(struct pt_regs *regs)
 {
-	BUG_ON(!user_mode(regs));
 	force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
 }
-NOKPROBE_SYMBOL(do_bti);
+
+void do_el1_bti(struct pt_regs *regs, unsigned long esr)
+{
+	die("Oops - BTI", regs, esr);
+}
+NOKPROBE_SYMBOL(do_el1_bti);
 
 void do_el0_fpac(struct pt_regs *regs, unsigned long esr)
 {


