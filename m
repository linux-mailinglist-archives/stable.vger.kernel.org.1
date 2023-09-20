Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA057A7D84
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbjITMKW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbjITMJl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:09:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F8BF0
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:09:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44655C433C7;
        Wed, 20 Sep 2023 12:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211774;
        bh=YeNsfoYtRjkoqRCnKfpWDkKSF4mDQZsB+mtWQZ65TBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=06/ZZao0cPdy+EY17+2PA9mKNfPliLXAdJ841VZhlr0wP8GP+6YH84TVif8tSRHQo
         QEm7aJSmMwsfKPZp+WpsIZVAr3Avpli3lRFh5lz+3M9K9MM+hym2EVbBmqlMP5THMh
         /tNxhP/nITtC7zXfjgM5tRy70PtvPqQKJuU5pevg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chengfeng Ye <dg573847474@gmail.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 030/273] scsi: qedi: Fix potential deadlock on &qedi_percpu->p_work_lock
Date:   Wed, 20 Sep 2023 13:27:50 +0200
Message-ID: <20230920112847.356118362@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index ab66e1f0fdfa3..7a179cfc01ed2 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -1864,8 +1864,9 @@ static int qedi_cpu_offline(unsigned int cpu)
 	struct qedi_percpu_s *p = this_cpu_ptr(&qedi_percpu);
 	struct qedi_work *work, *tmp;
 	struct task_struct *thread;
+	unsigned long flags;
 
-	spin_lock_bh(&p->p_work_lock);
+	spin_lock_irqsave(&p->p_work_lock, flags);
 	thread = p->iothread;
 	p->iothread = NULL;
 
@@ -1876,7 +1877,7 @@ static int qedi_cpu_offline(unsigned int cpu)
 			kfree(work);
 	}
 
-	spin_unlock_bh(&p->p_work_lock);
+	spin_unlock_irqrestore(&p->p_work_lock, flags);
 	if (thread)
 		kthread_stop(thread);
 	return 0;
-- 
2.40.1



