Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4059761471
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbjGYLT2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbjGYLTZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:19:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEE19D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:19:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12B4E61683
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2516CC433C8;
        Tue, 25 Jul 2023 11:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283963;
        bh=yQM872vKs3Ha/OmGU/czMqCvw1flo2iH4BoWZtWZl+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hhWQQyWwM6jk4up/tDhonKLHNbFQvUv0PDSFmGHsK9J7LK3zflRN1t37Bek9C7HGR
         W4xFmFuKNr1YRBbFkAHIvXAadB9K+GoHMHRrwcChnSCu6CYIEADRZoGAppgIiFAR2w
         /RhmuwYE28i7az0sBXtEHwbdPbIlSQrDKxT15ngA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 156/509] RDMA/bnxt_re: Avoid calling wake_up threads from spin_lock context
Date:   Tue, 25 Jul 2023 12:41:35 +0200
Message-ID: <20230725104600.854645898@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kashyap Desai <kashyap.desai@broadcom.com>

[ Upstream commit 3099bcdc19b701f732f638ee45679858c08559bb ]

bnxt_qplib_service_creq can be called from interrupt or tasklet or
process context. So the function take irq variant  of spin_lock.
But when wake_up is invoked with the lock held, it is putting the
calling context to sleep.

[exception RIP: __wake_up_common+190]
RIP: ffffffffb7539d7e  RSP: ffffa73300207ad8  RFLAGS: 00000083
RAX: 0000000000000001  RBX: ffff91fa295f69b8  RCX: dead000000000200
RDX: ffffa733344af940  RSI: ffffa73336527940  RDI: ffffa73336527940
RBP: 000000000000001c   R8: 0000000000000002   R9: 00000000000299c0
R10: 0000017230de82c5  R11: 0000000000000002  R12: ffffa73300207b28
R13: 0000000000000000  R14: ffffa733341bf928  R15: 0000000000000000
ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018

Call the wakeup after releasing the lock.

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Link: https://lore.kernel.org/r/1686308514-11996-3-git-send-email-selvin.xavier@broadcom.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 212e5cd82d0db..2b0c3a86293cf 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -295,7 +295,8 @@ static int bnxt_qplib_process_func_event(struct bnxt_qplib_rcfw *rcfw,
 }
 
 static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
-				       struct creq_qp_event *qp_event)
+				       struct creq_qp_event *qp_event,
+				       u32 *num_wait)
 {
 	struct creq_qp_error_notification *err_event;
 	struct bnxt_qplib_hwq *hwq = &rcfw->cmdq.hwq;
@@ -304,6 +305,7 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 	u16 cbit, blocked = 0;
 	struct pci_dev *pdev;
 	unsigned long flags;
+	u32 wait_cmds = 0;
 	__le16  mcookie;
 	u16 cookie;
 	int rc = 0;
@@ -363,9 +365,10 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 		crsqe->req_size = 0;
 
 		if (!blocked)
-			wake_up(&rcfw->cmdq.waitq);
+			wait_cmds++;
 		spin_unlock_irqrestore(&hwq->lock, flags);
 	}
+	*num_wait += wait_cmds;
 	return rc;
 }
 
@@ -379,6 +382,7 @@ static void bnxt_qplib_service_creq(struct tasklet_struct *t)
 	struct creq_base *creqe;
 	u32 sw_cons, raw_cons;
 	unsigned long flags;
+	u32 num_wakeup = 0;
 
 	/* Service the CREQ until budget is over */
 	spin_lock_irqsave(&hwq->lock, flags);
@@ -397,7 +401,8 @@ static void bnxt_qplib_service_creq(struct tasklet_struct *t)
 		switch (type) {
 		case CREQ_BASE_TYPE_QP_EVENT:
 			bnxt_qplib_process_qp_event
-				(rcfw, (struct creq_qp_event *)creqe);
+				(rcfw, (struct creq_qp_event *)creqe,
+				 &num_wakeup);
 			creq->stats.creq_qp_event_processed++;
 			break;
 		case CREQ_BASE_TYPE_FUNC_EVENT:
@@ -425,6 +430,8 @@ static void bnxt_qplib_service_creq(struct tasklet_struct *t)
 				      rcfw->res->cctx, true);
 	}
 	spin_unlock_irqrestore(&hwq->lock, flags);
+	if (num_wakeup)
+		wake_up_nr(&rcfw->cmdq.waitq, num_wakeup);
 }
 
 static irqreturn_t bnxt_qplib_creq_irq(int irq, void *dev_instance)
-- 
2.39.2



