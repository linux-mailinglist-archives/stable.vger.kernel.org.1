Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA90703B67
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244705AbjEOSCl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244714AbjEOSCT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:02:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14771B0BD
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:59:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F46463030
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6B8C433EF;
        Mon, 15 May 2023 17:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173579;
        bh=xRFaHS4/wjGE5zx1LGGL8Td5VLHMsORKnRWuBboN0hk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ofgQGxx67U3NVvqqr66LnHNrpDhqTwYREqadmV/WSkB58tqm5bFGl16aUEEhuXKlN
         i+zTAGHdVkgoRo1x2ia18EDPQr90aOHxNRycyce6MaTp3y1yUgNJiUsycLxWERFlnQ
         0YoHmbUW8rT4Biz7gqGM3RzwH0GK3NQbsUHkPqxY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Dae R. Jeong" <threeearcat@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 133/282] vmci_host: fix a race condition in vmci_host_poll() causing GPF
Date:   Mon, 15 May 2023 18:28:31 +0200
Message-Id: <20230515161726.210625146@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dae R. Jeong <threeearcat@gmail.com>

[ Upstream commit ae13381da5ff0e8e084c0323c3cc0a945e43e9c7 ]

During fuzzing, a general protection fault is observed in
vmci_host_poll().

general protection fault, probably for non-canonical address 0xdffffc0000000019: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000000c8-0x00000000000000cf]
RIP: 0010:__lock_acquire+0xf3/0x5e00 kernel/locking/lockdep.c:4926
<- omitting registers ->
Call Trace:
 <TASK>
 lock_acquire+0x1a4/0x4a0 kernel/locking/lockdep.c:5672
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xb3/0x100 kernel/locking/spinlock.c:162
 add_wait_queue+0x3d/0x260 kernel/sched/wait.c:22
 poll_wait include/linux/poll.h:49 [inline]
 vmci_host_poll+0xf8/0x2b0 drivers/misc/vmw_vmci/vmci_host.c:174
 vfs_poll include/linux/poll.h:88 [inline]
 do_pollfd fs/select.c:873 [inline]
 do_poll fs/select.c:921 [inline]
 do_sys_poll+0xc7c/0x1aa0 fs/select.c:1015
 __do_sys_ppoll fs/select.c:1121 [inline]
 __se_sys_ppoll+0x2cc/0x330 fs/select.c:1101
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x4e/0xa0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Example thread interleaving that causes the general protection fault
is as follows:

CPU1 (vmci_host_poll)               CPU2 (vmci_host_do_init_context)
-----                               -----
// Read uninitialized context
context = vmci_host_dev->context;
                                    // Initialize context
                                    vmci_host_dev->context = vmci_ctx_create();
                                    vmci_host_dev->ct_type = VMCIOBJ_CONTEXT;

if (vmci_host_dev->ct_type == VMCIOBJ_CONTEXT) {
    // Dereferencing the wrong pointer
    poll_wait(..., &context->host_context);
}

In this scenario, vmci_host_poll() reads vmci_host_dev->context first,
and then reads vmci_host_dev->ct_type to check that
vmci_host_dev->context is initialized. However, since these two reads
are not atomically executed, there is a chance of a race condition as
described above.

To fix this race condition, read vmci_host_dev->context after checking
the value of vmci_host_dev->ct_type so that vmci_host_poll() always
reads an initialized context.

Reported-by: Dae R. Jeong <threeearcat@gmail.com>
Fixes: 8bf503991f87 ("VMCI: host side driver implementation.")
Signed-off-by: Dae R. Jeong <threeearcat@gmail.com>
Link: https://lore.kernel.org/r/ZCGFsdBAU4cYww5l@dragonet
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/vmw_vmci/vmci_host.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
index 833e2bd248a57..8ff8d649d9b3a 100644
--- a/drivers/misc/vmw_vmci/vmci_host.c
+++ b/drivers/misc/vmw_vmci/vmci_host.c
@@ -160,10 +160,16 @@ static int vmci_host_close(struct inode *inode, struct file *filp)
 static __poll_t vmci_host_poll(struct file *filp, poll_table *wait)
 {
 	struct vmci_host_dev *vmci_host_dev = filp->private_data;
-	struct vmci_ctx *context = vmci_host_dev->context;
+	struct vmci_ctx *context;
 	__poll_t mask = 0;
 
 	if (vmci_host_dev->ct_type == VMCIOBJ_CONTEXT) {
+		/*
+		 * Read context only if ct_type == VMCIOBJ_CONTEXT to make
+		 * sure that context is initialized
+		 */
+		context = vmci_host_dev->context;
+
 		/* Check for VMCI calls to this VM context. */
 		if (wait)
 			poll_wait(filp, &context->host_context.wait_queue,
-- 
2.39.2



