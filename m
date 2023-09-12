Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE55779B5A3
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243064AbjIKWKq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240732AbjIKOwL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:52:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0107118
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:52:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C41C433C8;
        Mon, 11 Sep 2023 14:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443926;
        bh=HqjQDE5XhFvZTynCO+3oMsDcSVVo0ZCjVfbHLHGOpIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lhyMkNjvI7MVfcxbO5hirUIz2Mwl7nHO50qDLRX6STaVpB+XeBnEs0hPx+FZwLNYe
         XYOjei9OY/aIGcPqj5d5GJMlfFpTN2g9kZjQ6gc12VzkRPWZiXSrTy7ZjzMoE3c+L9
         35JjHJl5KlVGMAYL+8fi41q0pLASZAVvAnuo9aaw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 520/737] RDMA/rxe: Move work queue code to subroutines
Date:   Mon, 11 Sep 2023 15:46:19 +0200
Message-ID: <20230911134705.102345057@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bob Pearson <rpearsonhpe@gmail.com>

[ Upstream commit e0ba8ff46704fc924e2ef0451ba196cbdc0d68f2 ]

This patch:
	- Moves code to initialize a qp send work queue to a
	  subroutine named rxe_init_sq.
	- Moves code to initialize a qp recv work queue to a
	  subroutine named rxe_init_rq.
	- Moves initialization of qp request and response packet
	  queues ahead of work queue initialization so that cleanup
	  of a qp if it is not fully completed can successfully
	  attempt to drain the packet queues without a seg fault.
	- Makes minor whitespace cleanups.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Link: https://lore.kernel.org/r/20230620135519.9365-2-rpearsonhpe@gmail.com
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 159 ++++++++++++++++++++---------
 1 file changed, 108 insertions(+), 51 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index a0f206431cf8e..b66afadbd7c40 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -183,13 +183,63 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
 	atomic_set(&qp->skb_out, 0);
 }
 
+static int rxe_init_sq(struct rxe_qp *qp, struct ib_qp_init_attr *init,
+		       struct ib_udata *udata,
+		       struct rxe_create_qp_resp __user *uresp)
+{
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	int wqe_size;
+	int err;
+
+	qp->sq.max_wr = init->cap.max_send_wr;
+	wqe_size = max_t(int, init->cap.max_send_sge * sizeof(struct ib_sge),
+			 init->cap.max_inline_data);
+	qp->sq.max_sge = wqe_size / sizeof(struct ib_sge);
+	qp->sq.max_inline = wqe_size;
+	wqe_size += sizeof(struct rxe_send_wqe);
+
+	qp->sq.queue = rxe_queue_init(rxe, &qp->sq.max_wr, wqe_size,
+				      QUEUE_TYPE_FROM_CLIENT);
+	if (!qp->sq.queue) {
+		rxe_err_qp(qp, "Unable to allocate send queue");
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	/* prepare info for caller to mmap send queue if user space qp */
+	err = do_mmap_info(rxe, uresp ? &uresp->sq_mi : NULL, udata,
+			   qp->sq.queue->buf, qp->sq.queue->buf_size,
+			   &qp->sq.queue->ip);
+	if (err) {
+		rxe_err_qp(qp, "do_mmap_info failed, err = %d", err);
+		goto err_free;
+	}
+
+	/* return actual capabilities to caller which may be larger
+	 * than requested
+	 */
+	init->cap.max_send_wr = qp->sq.max_wr;
+	init->cap.max_send_sge = qp->sq.max_sge;
+	init->cap.max_inline_data = qp->sq.max_inline;
+
+	return 0;
+
+err_free:
+	vfree(qp->sq.queue->buf);
+	kfree(qp->sq.queue);
+	qp->sq.queue = NULL;
+err_out:
+	return err;
+}
+
 static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 			   struct ib_qp_init_attr *init, struct ib_udata *udata,
 			   struct rxe_create_qp_resp __user *uresp)
 {
 	int err;
-	int wqe_size;
-	enum queue_type type;
+
+	/* if we don't finish qp create make sure queue is valid */
+	skb_queue_head_init(&qp->req_pkts);
 
 	err = sock_create_kern(&init_net, AF_INET, SOCK_DGRAM, 0, &qp->sk);
 	if (err < 0)
@@ -204,32 +254,10 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 	 * (0xc000 - 0xffff).
 	 */
 	qp->src_port = RXE_ROCE_V2_SPORT + (hash_32(qp_num(qp), 14) & 0x3fff);
-	qp->sq.max_wr		= init->cap.max_send_wr;
-
-	/* These caps are limited by rxe_qp_chk_cap() done by the caller */
-	wqe_size = max_t(int, init->cap.max_send_sge * sizeof(struct ib_sge),
-			 init->cap.max_inline_data);
-	qp->sq.max_sge = init->cap.max_send_sge =
-		wqe_size / sizeof(struct ib_sge);
-	qp->sq.max_inline = init->cap.max_inline_data = wqe_size;
-	wqe_size += sizeof(struct rxe_send_wqe);
 
-	type = QUEUE_TYPE_FROM_CLIENT;
-	qp->sq.queue = rxe_queue_init(rxe, &qp->sq.max_wr,
-				wqe_size, type);
-	if (!qp->sq.queue)
-		return -ENOMEM;
-
-	err = do_mmap_info(rxe, uresp ? &uresp->sq_mi : NULL, udata,
-			   qp->sq.queue->buf, qp->sq.queue->buf_size,
-			   &qp->sq.queue->ip);
-
-	if (err) {
-		vfree(qp->sq.queue->buf);
-		kfree(qp->sq.queue);
-		qp->sq.queue = NULL;
+	err = rxe_init_sq(qp, init, udata, uresp);
+	if (err)
 		return err;
-	}
 
 	qp->req.wqe_index = queue_get_producer(qp->sq.queue,
 					       QUEUE_TYPE_FROM_CLIENT);
@@ -248,36 +276,65 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 	return 0;
 }
 
+static int rxe_init_rq(struct rxe_qp *qp, struct ib_qp_init_attr *init,
+		       struct ib_udata *udata,
+		       struct rxe_create_qp_resp __user *uresp)
+{
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	int wqe_size;
+	int err;
+
+	qp->rq.max_wr = init->cap.max_recv_wr;
+	qp->rq.max_sge = init->cap.max_recv_sge;
+	wqe_size = sizeof(struct rxe_recv_wqe) +
+				qp->rq.max_sge*sizeof(struct ib_sge);
+
+	qp->rq.queue = rxe_queue_init(rxe, &qp->rq.max_wr, wqe_size,
+				      QUEUE_TYPE_FROM_CLIENT);
+	if (!qp->rq.queue) {
+		rxe_err_qp(qp, "Unable to allocate recv queue");
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	/* prepare info for caller to mmap recv queue if user space qp */
+	err = do_mmap_info(rxe, uresp ? &uresp->rq_mi : NULL, udata,
+			   qp->rq.queue->buf, qp->rq.queue->buf_size,
+			   &qp->rq.queue->ip);
+	if (err) {
+		rxe_err_qp(qp, "do_mmap_info failed, err = %d", err);
+		goto err_free;
+	}
+
+	/* return actual capabilities to caller which may be larger
+	 * than requested
+	 */
+	init->cap.max_recv_wr = qp->rq.max_wr;
+
+	return 0;
+
+err_free:
+	vfree(qp->rq.queue->buf);
+	kfree(qp->rq.queue);
+	qp->rq.queue = NULL;
+err_out:
+	return err;
+}
+
 static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 			    struct ib_qp_init_attr *init,
 			    struct ib_udata *udata,
 			    struct rxe_create_qp_resp __user *uresp)
 {
 	int err;
-	int wqe_size;
-	enum queue_type type;
+
+	/* if we don't finish qp create make sure queue is valid */
+	skb_queue_head_init(&qp->resp_pkts);
 
 	if (!qp->srq) {
-		qp->rq.max_wr		= init->cap.max_recv_wr;
-		qp->rq.max_sge		= init->cap.max_recv_sge;
-
-		wqe_size = rcv_wqe_size(qp->rq.max_sge);
-
-		type = QUEUE_TYPE_FROM_CLIENT;
-		qp->rq.queue = rxe_queue_init(rxe, &qp->rq.max_wr,
-					wqe_size, type);
-		if (!qp->rq.queue)
-			return -ENOMEM;
-
-		err = do_mmap_info(rxe, uresp ? &uresp->rq_mi : NULL, udata,
-				   qp->rq.queue->buf, qp->rq.queue->buf_size,
-				   &qp->rq.queue->ip);
-		if (err) {
-			vfree(qp->rq.queue->buf);
-			kfree(qp->rq.queue);
-			qp->rq.queue = NULL;
+		err = rxe_init_rq(qp, init, udata, uresp);
+		if (err)
 			return err;
-		}
 	}
 
 	rxe_init_task(&qp->resp.task, qp, rxe_responder);
@@ -307,10 +364,10 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
 	if (srq)
 		rxe_get(srq);
 
-	qp->pd			= pd;
-	qp->rcq			= rcq;
-	qp->scq			= scq;
-	qp->srq			= srq;
+	qp->pd = pd;
+	qp->rcq = rcq;
+	qp->scq = scq;
+	qp->srq = srq;
 
 	atomic_inc(&rcq->num_wq);
 	atomic_inc(&scq->num_wq);
-- 
2.40.1



