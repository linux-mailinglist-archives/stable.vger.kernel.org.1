Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F667F4E39
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 18:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjKVRXP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 12:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbjKVRXP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 12:23:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E2419D
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 09:23:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82ABCC433C8;
        Wed, 22 Nov 2023 17:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700673783;
        bh=LMoNpTYHOHwmUdlqXEzwWTO/g37QYA1iRelcj5Dk2mU=;
        h=Subject:To:Cc:From:Date:From;
        b=uRjpkeZIh69bs5p6QYw90gCo+Hq/RODBZgHAPEiUH2BEMk3wId1UcwIWDOC1n+f/G
         EY6C0eziJeLr5X2u1ft0LaSuBsVLUH9uhzsO5xCPzCOVu7DEj6qsVlPArYMnMcdcK1
         XF5lk3guITDUt6yrnChTsm6k1LLgAs7IoPVLN6Fk=
Subject: FAILED: patch "[PATCH] tty/sysrq: replace smp_processor_id() with get_cpu()" failed to apply to 5.4-stable tree
To:     usama.anjum@collabora.com, gregkh@linuxfoundation.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 22 Nov 2023 17:23:01 +0000
Message-ID: <2023112201-yiddish-limes-21d5@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x dd976a97d15b47656991e185a94ef42a0fa5cfd4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112201-yiddish-limes-21d5@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

dd976a97d15b ("tty/sysrq: replace smp_processor_id() with get_cpu()")
5390e7f46b9d ("sysrq: do not omit current cpu when showing backtrace of all active CPUs")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dd976a97d15b47656991e185a94ef42a0fa5cfd4 Mon Sep 17 00:00:00 2001
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
Date: Mon, 9 Oct 2023 21:20:20 +0500
Subject: [PATCH] tty/sysrq: replace smp_processor_id() with get_cpu()

The smp_processor_id() shouldn't be called from preemptible code.
Instead use get_cpu() and put_cpu() which disables preemption in
addition to getting the processor id. Enable preemption back after
calling schedule_work() to make sure that the work gets scheduled on all
cores other than the current core. We want to avoid a scenario where
current core's stack trace is printed multiple times and one core's
stack trace isn't printed because of scheduling of current task.

This fixes the following bug:

[  119.143590] sysrq: Show backtrace of all active CPUs
[  119.143902] BUG: using smp_processor_id() in preemptible [00000000] code: bash/873
[  119.144586] caller is debug_smp_processor_id+0x20/0x30
[  119.144827] CPU: 6 PID: 873 Comm: bash Not tainted 5.10.124-dirty #3
[  119.144861] Hardware name: QEMU QEMU Virtual Machine, BIOS 2023.05-1 07/22/2023
[  119.145053] Call trace:
[  119.145093]  dump_backtrace+0x0/0x1a0
[  119.145122]  show_stack+0x18/0x70
[  119.145141]  dump_stack+0xc4/0x11c
[  119.145159]  check_preemption_disabled+0x100/0x110
[  119.145175]  debug_smp_processor_id+0x20/0x30
[  119.145195]  sysrq_handle_showallcpus+0x20/0xc0
[  119.145211]  __handle_sysrq+0x8c/0x1a0
[  119.145227]  write_sysrq_trigger+0x94/0x12c
[  119.145247]  proc_reg_write+0xa8/0xe4
[  119.145266]  vfs_write+0xec/0x280
[  119.145282]  ksys_write+0x6c/0x100
[  119.145298]  __arm64_sys_write+0x20/0x30
[  119.145315]  el0_svc_common.constprop.0+0x78/0x1e4
[  119.145332]  do_el0_svc+0x24/0x8c
[  119.145348]  el0_svc+0x10/0x20
[  119.145364]  el0_sync_handler+0x134/0x140
[  119.145381]  el0_sync+0x180/0x1c0

Cc: jirislaby@kernel.org
Cc: stable@vger.kernel.org
Fixes: 47cab6a722d4 ("debug lockups: Improve lockup detection, fix generic arch fallback")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Link: https://lore.kernel.org/r/20231009162021.3607632-1-usama.anjum@collabora.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 23198e3f1461..6b4a28bcf2f5 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -262,13 +262,14 @@ static void sysrq_handle_showallcpus(u8 key)
 		if (in_hardirq())
 			regs = get_irq_regs();
 
-		pr_info("CPU%d:\n", smp_processor_id());
+		pr_info("CPU%d:\n", get_cpu());
 		if (regs)
 			show_regs(regs);
 		else
 			show_stack(NULL, NULL, KERN_INFO);
 
 		schedule_work(&sysrq_showallcpus);
+		put_cpu();
 	}
 }
 

