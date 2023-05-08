Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7953B6FAC60
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbjEHLXt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbjEHLXm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:23:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5528939B8B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:23:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8CB462D10
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1079C433EF;
        Mon,  8 May 2023 11:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545017;
        bh=KpO+IDd/OPHpmqeOmoDl93qwT8X3jb/4UFN1KSvzEhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vzyN95QMRK8MRlkKtITALX2qvAE24V7pxAAczuDJxzH8tB/pDcdb69wezg++5iGVf
         WnI0i2Q//yZybhWaFHMTk/TQfGybMwPsyna/1evaRMNnEjaW4dmYdTh3htmQNd1tBo
         TK8hVb7reatASSBWnUM+WvbRJebmDhTf/MeY0CAY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 597/694] RDMA/rxe: Remove tasklet call from rxe_cq.c
Date:   Mon,  8 May 2023 11:47:12 +0200
Message-Id: <20230508094454.549582847@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Bob Pearson <rpearsonhpe@gmail.com>

[ Upstream commit 78b26a335310a097d6b22581b706050db42f196c ]

Remove the tasklet call in rxe_cq.c and also the is_dying in the
cq struct. There is no reason for the rxe driver to defer the call
to the cq completion handler by scheduling a tasklet. rxe_cq_post()
is not called in a hard irq context.

The rxe driver currently is incorrect because the tasklet call is
made without protecting the cq pointer with a reference from having
the underlying memory freed before the deferred routine is called.
Executing the comp_handler inline fixes this problem.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
Link: https://lore.kernel.org/r/20230327215643.10410-1-rpearsonhpe@gmail.com
Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rxe/rxe_cq.c    |   32 +++-----------------------------
 drivers/infiniband/sw/rxe/rxe_verbs.c |    2 --
 drivers/infiniband/sw/rxe/rxe_verbs.h |    2 --
 3 files changed, 3 insertions(+), 33 deletions(-)

--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -39,21 +39,6 @@ err1:
 	return -EINVAL;
 }
 
-static void rxe_send_complete(struct tasklet_struct *t)
-{
-	struct rxe_cq *cq = from_tasklet(cq, t, comp_task);
-	unsigned long flags;
-
-	spin_lock_irqsave(&cq->cq_lock, flags);
-	if (cq->is_dying) {
-		spin_unlock_irqrestore(&cq->cq_lock, flags);
-		return;
-	}
-	spin_unlock_irqrestore(&cq->cq_lock, flags);
-
-	cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
-}
-
 int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
 		     int comp_vector, struct ib_udata *udata,
 		     struct rxe_create_cq_resp __user *uresp)
@@ -79,10 +64,6 @@ int rxe_cq_from_init(struct rxe_dev *rxe
 
 	cq->is_user = uresp;
 
-	cq->is_dying = false;
-
-	tasklet_setup(&cq->comp_task, rxe_send_complete);
-
 	spin_lock_init(&cq->cq_lock);
 	cq->ibcq.cqe = cqe;
 	return 0;
@@ -103,6 +84,7 @@ int rxe_cq_resize_queue(struct rxe_cq *c
 	return err;
 }
 
+/* caller holds reference to cq */
 int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 {
 	struct ib_event ev;
@@ -135,21 +117,13 @@ int rxe_cq_post(struct rxe_cq *cq, struc
 	if ((cq->notify == IB_CQ_NEXT_COMP) ||
 	    (cq->notify == IB_CQ_SOLICITED && solicited)) {
 		cq->notify = 0;
-		tasklet_schedule(&cq->comp_task);
+
+		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
 	}
 
 	return 0;
 }
 
-void rxe_cq_disable(struct rxe_cq *cq)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&cq->cq_lock, flags);
-	cq->is_dying = true;
-	spin_unlock_irqrestore(&cq->cq_lock, flags);
-}
-
 void rxe_cq_cleanup(struct rxe_pool_elem *elem)
 {
 	struct rxe_cq *cq = container_of(elem, typeof(*cq), elem);
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -786,8 +786,6 @@ static int rxe_destroy_cq(struct ib_cq *
 	if (atomic_read(&cq->num_wq))
 		return -EINVAL;
 
-	rxe_cq_disable(cq);
-
 	rxe_cleanup(cq);
 	return 0;
 }
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -63,9 +63,7 @@ struct rxe_cq {
 	struct rxe_queue	*queue;
 	spinlock_t		cq_lock;
 	u8			notify;
-	bool			is_dying;
 	bool			is_user;
-	struct tasklet_struct	comp_task;
 	atomic_t		num_wq;
 };
 


