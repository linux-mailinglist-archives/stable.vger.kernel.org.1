Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33DE79BD91
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240368AbjIKV5B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241189AbjIKPDu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:03:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CA01B9
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:03:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208FDC433C8;
        Mon, 11 Sep 2023 15:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444625;
        bh=wdtEE65LNr821hfuRctCLLoVeoyD3I6F/a+0nq8NkwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ufguN/2fgTa2IGvyV336uOsCniZqYp5FvinoSk4yQkiR+ERnxgwQ7RUaK+tp+rU+Y
         mjgD1ZZu61JNoiCZwOVgHXf0O0awsDIKTG4xayJCQXajXO3gRqw4+Ws8yXU/CrJJUj
         QGU32b9Y0FD+XhGhHaCXUp/EU9FutIfIRx1ZRTlU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chengfeng Ye <dg573847474@gmail.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 059/600] scsi: qedi: Fix potential deadlock on &qedi_percpu->p_work_lock
Date:   Mon, 11 Sep 2023 15:41:32 +0200
Message-ID: <20230911134635.368736915@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengfeng Ye <dg573847474@gmail.com>

[ Upstream commit dd64f80587190265ca8a0f4be6c64c2fda6d3ac2 ]

As &qedi_percpu->p_work_lock is acquired by hard IRQ qedi_msix_handler(),
other acquisitions of the same lock under process context should disable
IRQ, otherwise deadlock could happen if the IRQ preempts the execution
while the lock is held in process context on the same CPU.

qedi_cpu_offline() is one such function which acquires the lock in process
context.

[Deadlock Scenario]
qedi_cpu_offline()
    ->spin_lock(&p->p_work_lock)
        <irq>
        ->qedi_msix_handler()
        ->edi_process_completions()
        ->spin_lock_irqsave(&p->p_work_lock, flags); (deadlock here)

This flaw was found by an experimental static analysis tool I am developing
for IRQ-related deadlocks.

The tentative patch fix the potential deadlock by spin_lock_irqsave()
under process context.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
Link: https://lore.kernel.org/r/20230726125655.4197-1-dg573847474@gmail.com
Acked-by: Manish Rangankar <mrangankar@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qedi/qedi_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index 9fd68d362698f..2ee109fb65616 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -1977,8 +1977,9 @@ static int qedi_cpu_offline(unsigned int cpu)
 	struct qedi_percpu_s *p = this_cpu_ptr(&qedi_percpu);
 	struct qedi_work *work, *tmp;
 	struct task_struct *thread;
+	unsigned long flags;
 
-	spin_lock_bh(&p->p_work_lock);
+	spin_lock_irqsave(&p->p_work_lock, flags);
 	thread = p->iothread;
 	p->iothread = NULL;
 
@@ -1989,7 +1990,7 @@ static int qedi_cpu_offline(unsigned int cpu)
 			kfree(work);
 	}
 
-	spin_unlock_bh(&p->p_work_lock);
+	spin_unlock_irqrestore(&p->p_work_lock, flags);
 	if (thread)
 		kthread_stop(thread);
 	return 0;
-- 
2.40.1



