Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833D16FAC1F
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbjEHLVB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbjEHLVB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:21:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3AE38F1C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:20:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 705C762C60
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F45C4339B;
        Mon,  8 May 2023 11:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544858;
        bh=9LJbx+ELuwApZUsSfMPBiPMGyel/4ljM8YpTP5ivLhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bfNqnqMWDlcYx4tgHWNo9fOLhQM1H3JhBrryK7seSPFBmlU5kcizRe1gs4crUZjOg
         +HGZa1DL9yDzbm9xKVQRSeu8EPMwdJhghzopao0V0QjDeVNe0kop3bSbWHnD82WzVy
         1xCscgsGhJQOven1QHATy4nFWitD5A8HP6GltUow=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Dae R. Jeong" <threeearcat@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 516/694] vmci_host: fix a race condition in vmci_host_poll() causing GPF
Date:   Mon,  8 May 2023 11:45:51 +0200
Message-Id: <20230508094450.941577617@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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
index 857b9851402a6..abe79f6fd2a79 100644
--- a/drivers/misc/vmw_vmci/vmci_host.c
+++ b/drivers/misc/vmw_vmci/vmci_host.c
@@ -165,10 +165,16 @@ static int vmci_host_close(struct inode *inode, struct file *filp)
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



