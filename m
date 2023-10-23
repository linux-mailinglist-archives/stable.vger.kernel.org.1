Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14477D3546
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbjJWLqw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbjJWLqi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:46:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9561810CB
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:46:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FCEC433C9;
        Mon, 23 Oct 2023 11:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061595;
        bh=aqr32Kiwc64X3mzpX/vRMoCWc1kpaO5yfcgNKHrqcP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LVIKYH3jvyNrWsfNAuLFvusG+bKToDIMdjK/vI5EkXh284ZdQVTQMwsxGtXX5gIWr
         NmO0ce+VllPegt4eVeRSOm8LkFt3hJrH1Gowm96OyT4/nuzTQLiUjPgfaMahRR8kpP
         sEa63eOUg2Sp9u0qh9xfaeFgC3vyvXrRJJaMfBBE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, ruanjinjie@huawei.com,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 5.10 063/202] arm64: report EL1 UNDEFs better
Date:   Mon, 23 Oct 2023 12:56:10 +0200
Message-ID: <20231023104828.397259007@linuxfoundation.org>
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

commit b502c87d2a26c349acbc231ff2acd6f17147926b upstream.

If an UNDEFINED exception is taken from EL1, and do_undefinstr() doesn't
find any suitable undef_hook, it will call:

	BUG_ON(!user_mode(regs))

... and the kernel will report a failure witin do_undefinstr() rather
than reporting the original context that the UNDEFINED exception was
taken from. The pt_regs and ESR value reported within the BUG() handler
will be from within do_undefinstr() and the code dump will be for the
BRK in BUG_ON(), which isn't sufficient to debug the cause of the
original exception.

This patch makes the reporting better by having do_undefinstr() call
die() directly in this case to report the original context from which
the UNDEFINED exception was taken.

Prior to this patch, an undefined instruction is reported as:

| kernel BUG at arch/arm64/kernel/traps.c:497!
| Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
| Modules linked in:
| CPU: 0 PID: 0 Comm: swapper Not tainted 5.19.0-rc3-00127-geff044f1b04e-dirty #3
| Hardware name: linux,dummy-virt (DT)
| pstate: 000000c5 (nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
| pc : do_undefinstr+0x28c/0x2ac
| lr : do_undefinstr+0x298/0x2ac
| sp : ffff800009f63bc0
| x29: ffff800009f63bc0 x28: ffff800009f73c00 x27: ffff800009644a70
| x26: ffff8000096778a8 x25: 0000000000000040 x24: 0000000000000000
| x23: 00000000800000c5 x22: ffff800009894060 x21: ffff800009f63d90
| x20: 0000000000000000 x19: ffff800009f63c40 x18: 0000000000000006
| x17: 0000000000403000 x16: 00000000bfbfd000 x15: ffff800009f63830
| x14: ffffffffffffffff x13: 0000000000000000 x12: 0000000000000019
| x11: 0101010101010101 x10: 0000000000161b98 x9 : 0000000000000000
| x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
| x5 : ffff800009f761d0 x4 : 0000000000000000 x3 : ffff80000a2b80f8
| x2 : 0000000000000000 x1 : ffff800009f73c00 x0 : 00000000800000c5
| Call trace:
|  do_undefinstr+0x28c/0x2ac
|  el1_undef+0x2c/0x4c
|  el1h_64_sync_handler+0x84/0xd0
|  el1h_64_sync+0x64/0x68
|  setup_arch+0x550/0x598
|  start_kernel+0x88/0x6ac
|  __primary_switched+0xb8/0xc0
| Code: 17ffff95 a9425bf5 17ffffb8 a9025bf5 (d4210000)

With this patch applied, an undefined instruction is reported as:

| Internal error: Oops - Undefined instruction: 0 [#1] PREEMPT SMP
| Modules linked in:
| CPU: 0 PID: 0 Comm: swapper Not tainted 5.19.0-rc3-00128-gf27cfcc80e52-dirty #5
| Hardware name: linux,dummy-virt (DT)
| pstate: 800000c5 (Nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
| pc : setup_arch+0x550/0x598
| lr : setup_arch+0x50c/0x598
| sp : ffff800009f63d90
| x29: ffff800009f63d90 x28: 0000000081000200 x27: ffff800009644a70
| x26: ffff8000096778c8 x25: 0000000000000040 x24: 0000000000000000
| x23: 0000000000000100 x22: ffff800009f69a58 x21: ffff80000a2b80b8
| x20: 0000000000000000 x19: 0000000000000000 x18: 0000000000000006
| x17: 0000000000403000 x16: 00000000bfbfd000 x15: ffff800009f63830
| x14: ffffffffffffffff x13: 0000000000000000 x12: 0000000000000019
| x11: 0101010101010101 x10: 0000000000161b98 x9 : 0000000000000000
| x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
| x5 : 0000000000000008 x4 : 0000000000000010 x3 : 0000000000000000
| x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
| Call trace:
|  setup_arch+0x550/0x598
|  start_kernel+0x88/0x6ac
|  __primary_switched+0xb8/0xc0
| Code: b4000080 90ffed80 912ac000 97db745f (00000000)

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Link: https://lore.kernel.org/r/20220913101732.3925290-2-mark.rutland@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/traps.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -404,7 +404,9 @@ void do_undefinstr(struct pt_regs *regs)
 	if (call_undef_hook(regs) == 0)
 		return;
 
-	BUG_ON(!user_mode(regs));
+	if (!user_mode(regs))
+		die("Oops - Undefined instruction", regs, 0);
+
 	force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
 }
 NOKPROBE_SYMBOL(do_undefinstr);


