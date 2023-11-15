Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9758B7ECF89
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbjKOTtH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbjKOTtG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:49:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DF2B8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:49:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179D8C433C7;
        Wed, 15 Nov 2023 19:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077743;
        bh=w0+mfBIvdpO3g1mJYBlWXmz4q8GzTrMoepmHqDPri5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xotVr6BN8aw+ky5KPrwSq5YQyyXcDB36cgzdsEQJulFiViwEJV4dNknTdkSTgS5MY
         2bTQPHwKKaziXwLCtj90gMS2G1o++Xo5swkt+LxIcZy982yGm9e2jUPLjYGuz37hVt
         zhAgSK0PQlhJpx26o39hx8QyPvc/yPrdMgGdXGzk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Joel Stanley <joel@jms.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 470/603] powerpc: Hide empty pt_regs at base of the stack
Date:   Wed, 15 Nov 2023 14:16:55 -0500
Message-ID: <20231115191645.047061666@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit d45c4b48dafb5820e5cc267ff9a6d7784d13a43c ]

A thread started via eg. user_mode_thread() runs in the kernel to begin
with and then may later return to userspace. While it's running in the
kernel it has a pt_regs at the base of its kernel stack, but that
pt_regs is all zeroes.

If the thread oopses in that state, it leads to an ugly stack trace with
a big block of zero GPRs, as reported by Joel:

  Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc7-00004-gf7757129e3de-dirty #3
  Hardware name: IBM PowerNV (emulated by qemu) POWER9 0x4e1200 opal:v7.0 PowerNV
  Call Trace:
  [c0000000036afb00] [c0000000010dd058] dump_stack_lvl+0x6c/0x9c (unreliable)
  [c0000000036afb30] [c00000000013c524] panic+0x178/0x424
  [c0000000036afbd0] [c000000002005100] mount_root_generic+0x250/0x324
  [c0000000036afca0] [c0000000020057d0] prepare_namespace+0x2d4/0x344
  [c0000000036afd20] [c0000000020049c0] kernel_init_freeable+0x358/0x3ac
  [c0000000036afdf0] [c0000000000111b0] kernel_init+0x30/0x1a0
  [c0000000036afe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0x1c
  --- interrupt: 0 at 0x0
  NIP:  0000000000000000 LR: 0000000000000000 CTR: 0000000000000000
  REGS: c0000000036afe80 TRAP: 0000   Not tainted  (6.5.0-rc7-00004-gf7757129e3de-dirty)
  MSR:  0000000000000000 <>  CR: 00000000  XER: 00000000
  CFAR: 0000000000000000 IRQMASK: 0
  GPR00: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  GPR04: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  GPR12: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  GPR28: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  NIP [0000000000000000] 0x0
  LR [0000000000000000] 0x0
  --- interrupt: 0

The all-zero pt_regs looks ugly and conveys no useful information, other
than its presence. So detect that case and just show the presence of the
frame by printing the interrupt marker, eg:

  Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc3-00126-g18e9506562a0-dirty #301
  Hardware name: IBM pSeries (emulated by qemu) POWER9 (raw) 0x4e1202 0xf000005 of:SLOF,HEAD hv:linux,kvm pSeries
  Call Trace:
  [c000000003aabb00] [c000000001143db8] dump_stack_lvl+0x6c/0x9c (unreliable)
  [c000000003aabb30] [c00000000014c624] panic+0x178/0x424
  [c000000003aabbd0] [c0000000020050fc] mount_root_generic+0x250/0x324
  [c000000003aabca0] [c0000000020057cc] prepare_namespace+0x2d4/0x344
  [c000000003aabd20] [c0000000020049bc] kernel_init_freeable+0x358/0x3ac
  [c000000003aabdf0] [c0000000000111b0] kernel_init+0x30/0x1a0
  [c000000003aabe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0x1c
  --- interrupt: 0 at 0x0

To avoid ever suppressing a valid pt_regs make sure the pt_regs has a
zero MSR and TRAP value, and is located at the very base of the stack.

Fixes: 6895dfc04741 ("powerpc: copy_thread fill in interrupt frame marker and back chain")
Reported-by: Joel Stanley <joel@jms.id.au>
Reported-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230824064210.907266-1-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/process.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index b68898ac07e19..392404688cec3 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -2258,6 +2258,22 @@ unsigned long __get_wchan(struct task_struct *p)
 	return ret;
 }
 
+static bool empty_user_regs(struct pt_regs *regs, struct task_struct *tsk)
+{
+	unsigned long stack_page;
+
+	// A non-empty pt_regs should never have a zero MSR or TRAP value.
+	if (regs->msr || regs->trap)
+		return false;
+
+	// Check it sits at the very base of the stack
+	stack_page = (unsigned long)task_stack_page(tsk);
+	if ((unsigned long)(regs + 1) != stack_page + THREAD_SIZE)
+		return false;
+
+	return true;
+}
+
 static int kstack_depth_to_print = CONFIG_PRINT_STACK_DEPTH;
 
 void __no_sanitize_address show_stack(struct task_struct *tsk,
@@ -2322,9 +2338,13 @@ void __no_sanitize_address show_stack(struct task_struct *tsk,
 			lr = regs->link;
 			printk("%s--- interrupt: %lx at %pS\n",
 			       loglvl, regs->trap, (void *)regs->nip);
-			__show_regs(regs);
-			printk("%s--- interrupt: %lx\n",
-			       loglvl, regs->trap);
+
+			// Detect the case of an empty pt_regs at the very base
+			// of the stack and suppress showing it in full.
+			if (!empty_user_regs(regs, tsk)) {
+				__show_regs(regs);
+				printk("%s--- interrupt: %lx\n", loglvl, regs->trap);
+			}
 
 			firstframe = 1;
 		}
-- 
2.42.0



