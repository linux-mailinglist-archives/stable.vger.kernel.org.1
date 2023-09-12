Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00ED479ACDE
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbjIKUwu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239255AbjIKOPr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:15:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D87CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:15:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB1FC433C8;
        Mon, 11 Sep 2023 14:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441742;
        bh=LYqbt7l3OX/gnYYY0a2UKv/CA9q0dxMieOnUhr1Mxyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MuxI++1rfwfi1UNv9e8oPHcmWz3YsAj47L1CH04MYaiqDUFmSYXGyCwCJ7xtvaVs2
         4iZqqsvkxs8jFMhGgtyHzxR8GHKYrOMIccdtGNnhqGiL021jBiKqApc/SqRnQFHa5v
         gZQFkDzJafkMsoAL8rG+yOEpDMlh4FH28nISvZ/4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 494/739] RDMA/rxe: Fix incomplete state save in rxe_requester
Date:   Mon, 11 Sep 2023 15:44:53 +0200
Message-ID: <20230911134704.925243620@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bob Pearson <rpearsonhpe@gmail.com>

[ Upstream commit 5d122db2ff80cd2aed4dcd630befb56b51ddf947 ]

If a send packet is dropped by the IP layer in rxe_requester()
the call to rxe_xmit_packet() can fail with err == -EAGAIN.
To recover, the state of the wqe is restored to the state before
the packet was sent so it can be resent. However, the routines
that save and restore the state miss a significnt part of the
variable state in the wqe, the dma struct which is used to process
through the sge table. And, the state is not saved before the packet
is built which modifies the dma struct.

Under heavy stress testing with many QPs on a fast node sending
large messages to a slow node dropped packets are observed and
the resent packets are corrupted because the dma struct was not
restored. This patch fixes this behavior and allows the test cases
to succeed.

Fixes: 3050b9985024 ("IB/rxe: Fix race condition between requester and completer")
Link: https://lore.kernel.org/r/20230721200748.4604-1-rpearsonhpe@gmail.com
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 45 ++++++++++++++++-------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 2171f19494bca..d8c41fd626a94 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -578,10 +578,11 @@ static void save_state(struct rxe_send_wqe *wqe,
 		       struct rxe_send_wqe *rollback_wqe,
 		       u32 *rollback_psn)
 {
-	rollback_wqe->state     = wqe->state;
+	rollback_wqe->state = wqe->state;
 	rollback_wqe->first_psn = wqe->first_psn;
-	rollback_wqe->last_psn  = wqe->last_psn;
-	*rollback_psn		= qp->req.psn;
+	rollback_wqe->last_psn = wqe->last_psn;
+	rollback_wqe->dma = wqe->dma;
+	*rollback_psn = qp->req.psn;
 }
 
 static void rollback_state(struct rxe_send_wqe *wqe,
@@ -589,10 +590,11 @@ static void rollback_state(struct rxe_send_wqe *wqe,
 			   struct rxe_send_wqe *rollback_wqe,
 			   u32 rollback_psn)
 {
-	wqe->state     = rollback_wqe->state;
+	wqe->state = rollback_wqe->state;
 	wqe->first_psn = rollback_wqe->first_psn;
-	wqe->last_psn  = rollback_wqe->last_psn;
-	qp->req.psn    = rollback_psn;
+	wqe->last_psn = rollback_wqe->last_psn;
+	wqe->dma = rollback_wqe->dma;
+	qp->req.psn = rollback_psn;
 }
 
 static void update_state(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
@@ -797,6 +799,9 @@ int rxe_requester(struct rxe_qp *qp)
 	pkt.mask = rxe_opcode[opcode].mask;
 	pkt.wqe = wqe;
 
+	/* save wqe state before we build and send packet */
+	save_state(wqe, qp, &rollback_wqe, &rollback_psn);
+
 	av = rxe_get_av(&pkt, &ah);
 	if (unlikely(!av)) {
 		rxe_dbg_qp(qp, "Failed no address vector\n");
@@ -829,29 +834,29 @@ int rxe_requester(struct rxe_qp *qp)
 	if (ah)
 		rxe_put(ah);
 
-	/*
-	 * To prevent a race on wqe access between requester and completer,
-	 * wqe members state and psn need to be set before calling
-	 * rxe_xmit_packet().
-	 * Otherwise, completer might initiate an unjustified retry flow.
-	 */
-	save_state(wqe, qp, &rollback_wqe, &rollback_psn);
+	/* update wqe state as though we had sent it */
 	update_wqe_state(qp, wqe, &pkt);
 	update_wqe_psn(qp, wqe, &pkt, payload);
 
 	err = rxe_xmit_packet(qp, &pkt, skb);
 	if (err) {
-		qp->need_req_skb = 1;
+		if (err != -EAGAIN) {
+			wqe->status = IB_WC_LOC_QP_OP_ERR;
+			goto err;
+		}
 
+		/* the packet was dropped so reset wqe to the state
+		 * before we sent it so we can try to resend
+		 */
 		rollback_state(wqe, qp, &rollback_wqe, rollback_psn);
 
-		if (err == -EAGAIN) {
-			rxe_sched_task(&qp->req.task);
-			goto exit;
-		}
+		/* force a delay until the dropped packet is freed and
+		 * the send queue is drained below the low water mark
+		 */
+		qp->need_req_skb = 1;
 
-		wqe->status = IB_WC_LOC_QP_OP_ERR;
-		goto err;
+		rxe_sched_task(&qp->req.task);
+		goto exit;
 	}
 
 	update_state(qp, &pkt);
-- 
2.40.1



