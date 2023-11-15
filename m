Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AE67ECDB8
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbjKOTiA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbjKOTiA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:38:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB87C1A5
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:37:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155AAC433C7;
        Wed, 15 Nov 2023 19:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077076;
        bh=cH6la2wJLlR3mfwqPDFK/6QX1YoButnzpZCwkMZx7RA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2RcdGNH+GKFxFO3FodFv5FfkL77N6lwYFVO03m+URSvMABHncH4P7Gx7fuN390e99
         Nyq8hnOUcA9gnW5sZGFuqYV/s5A7lVRvXzkTTHGW3AZ7hnz3g2e4mSe/Ng945XwGmI
         spSKYvH+HCTlJR0UmbuA5EJg72A4pf8lcHwqrHtg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Geetha sowjanya <gakula@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 513/550] octeontx2-pf: Free pending and dropped SQEs
Date:   Wed, 15 Nov 2023 14:18:17 -0500
Message-ID: <20231115191636.492384016@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geetha sowjanya <gakula@marvell.com>

[ Upstream commit 3423ca23e08bf285a324237abe88e7e7d9becfe6 ]

On interface down, the pending SQEs in the NIX get dropped
or drained out during SMQ flush. But skb's pointed by these
SQEs never get free or updated to the stack as respective CQE
never get added.
This patch fixes the issue by freeing all valid skb's in SQ SG list.

Fixes: b1bc8457e9d0 ("octeontx2-pf: Cleanup all receive buffers in SG descriptor")
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../marvell/octeontx2/nic/otx2_common.c       | 15 +++----
 .../marvell/octeontx2/nic/otx2_common.h       |  1 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  1 +
 .../marvell/octeontx2/nic/otx2_txrx.c         | 42 +++++++++++++++++++
 4 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 379e1510b70c0..48bcd6f24fcde 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -816,7 +816,6 @@ void otx2_sqb_flush(struct otx2_nic *pfvf)
 	int qidx, sqe_tail, sqe_head;
 	struct otx2_snd_queue *sq;
 	u64 incr, *ptr, val;
-	int timeout = 1000;
 
 	ptr = (u64 *)otx2_get_regaddr(pfvf, NIX_LF_SQ_OP_STATUS);
 	for (qidx = 0; qidx < otx2_get_total_tx_queues(pfvf); qidx++) {
@@ -825,15 +824,11 @@ void otx2_sqb_flush(struct otx2_nic *pfvf)
 			continue;
 
 		incr = (u64)qidx << 32;
-		while (timeout) {
-			val = otx2_atomic64_add(incr, ptr);
-			sqe_head = (val >> 20) & 0x3F;
-			sqe_tail = (val >> 28) & 0x3F;
-			if (sqe_head == sqe_tail)
-				break;
-			usleep_range(1, 3);
-			timeout--;
-		}
+		val = otx2_atomic64_add(incr, ptr);
+		sqe_head = (val >> 20) & 0x3F;
+		sqe_tail = (val >> 28) & 0x3F;
+		if (sqe_head != sqe_tail)
+			usleep_range(50, 60);
 	}
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 0e81849db3538..5590e30f8e2d0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -972,6 +972,7 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool pfc_en);
 int otx2_txsch_alloc(struct otx2_nic *pfvf);
 void otx2_txschq_stop(struct otx2_nic *pfvf);
 void otx2_txschq_free_one(struct otx2_nic *pfvf, u16 lvl, u16 schq);
+void otx2_free_pending_sqe(struct otx2_nic *pfvf);
 void otx2_sqb_flush(struct otx2_nic *pfvf);
 int otx2_alloc_rbuf(struct otx2_nic *pfvf, struct otx2_pool *pool,
 		    dma_addr_t *dma);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index ca6602fe27050..472d6982eabd2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1600,6 +1600,7 @@ static void otx2_free_hw_resources(struct otx2_nic *pf)
 		else
 			otx2_cleanup_tx_cqes(pf, cq);
 	}
+	otx2_free_pending_sqe(pf);
 
 	otx2_free_sq_res(pf);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 53b2a4ef52985..6ee15f3c25ede 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -1247,9 +1247,11 @@ void otx2_cleanup_rx_cqes(struct otx2_nic *pfvf, struct otx2_cq_queue *cq, int q
 
 void otx2_cleanup_tx_cqes(struct otx2_nic *pfvf, struct otx2_cq_queue *cq)
 {
+	int tx_pkts = 0, tx_bytes = 0;
 	struct sk_buff *skb = NULL;
 	struct otx2_snd_queue *sq;
 	struct nix_cqe_tx_s *cqe;
+	struct netdev_queue *txq;
 	int processed_cqe = 0;
 	struct sg_list *sg;
 	int qidx;
@@ -1270,12 +1272,20 @@ void otx2_cleanup_tx_cqes(struct otx2_nic *pfvf, struct otx2_cq_queue *cq)
 		sg = &sq->sg[cqe->comp.sqe_id];
 		skb = (struct sk_buff *)sg->skb;
 		if (skb) {
+			tx_bytes += skb->len;
+			tx_pkts++;
 			otx2_dma_unmap_skb_frags(pfvf, sg);
 			dev_kfree_skb_any(skb);
 			sg->skb = (u64)NULL;
 		}
 	}
 
+	if (likely(tx_pkts)) {
+		if (qidx >= pfvf->hw.tx_queues)
+			qidx -= pfvf->hw.xdp_queues;
+		txq = netdev_get_tx_queue(pfvf->netdev, qidx);
+		netdev_tx_completed_queue(txq, tx_pkts, tx_bytes);
+	}
 	/* Free CQEs to HW */
 	otx2_write64(pfvf, NIX_LF_CQ_OP_DOOR,
 		     ((u64)cq->cq_idx << 32) | processed_cqe);
@@ -1302,6 +1312,38 @@ int otx2_rxtx_enable(struct otx2_nic *pfvf, bool enable)
 	return err;
 }
 
+void otx2_free_pending_sqe(struct otx2_nic *pfvf)
+{
+	int tx_pkts = 0, tx_bytes = 0;
+	struct sk_buff *skb = NULL;
+	struct otx2_snd_queue *sq;
+	struct netdev_queue *txq;
+	struct sg_list *sg;
+	int sq_idx, sqe;
+
+	for (sq_idx = 0; sq_idx < pfvf->hw.tx_queues; sq_idx++) {
+		sq = &pfvf->qset.sq[sq_idx];
+		for (sqe = 0; sqe < sq->sqe_cnt; sqe++) {
+			sg = &sq->sg[sqe];
+			skb = (struct sk_buff *)sg->skb;
+			if (skb) {
+				tx_bytes += skb->len;
+				tx_pkts++;
+				otx2_dma_unmap_skb_frags(pfvf, sg);
+				dev_kfree_skb_any(skb);
+				sg->skb = (u64)NULL;
+			}
+		}
+
+		if (!tx_pkts)
+			continue;
+		txq = netdev_get_tx_queue(pfvf->netdev, sq_idx);
+		netdev_tx_completed_queue(txq, tx_pkts, tx_bytes);
+		tx_pkts = 0;
+		tx_bytes = 0;
+	}
+}
+
 static void otx2_xdp_sqe_add_sg(struct otx2_snd_queue *sq, u64 dma_addr,
 				int len, int *offset)
 {
-- 
2.42.0



