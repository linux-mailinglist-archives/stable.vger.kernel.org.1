Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19262775780
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjHIKqq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjHIKqq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:46:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE871BF2
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:46:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FB4E63121
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:46:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07C0C433C7;
        Wed,  9 Aug 2023 10:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578004;
        bh=bzr1tL5/dyzxGavJVWCpPWMPKnHkTmI7PgernWJR80A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xu7wXNTiIbL0aEc9uZJFMIotxK57kUQjl9LWUk7odp7JRWlbKpqMv3EPKPnVOMmgS
         vHe6kcsmp+F3p+d1pBy9llR70VKz8tukNaHkWsAW1Ia7rmoF1L5bdHD9yf4ZzQx7Lv
         WR5VGfh2YeDMeokpdjDhhBPvc1W9zrsNU4AnTzaY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andy Gospodarek <gospo@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 064/165] bnxt: dont handle XDP in netpoll
Date:   Wed,  9 Aug 2023 12:39:55 +0200
Message-ID: <20230809103644.919522320@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 37b61cda9c1606cd8b6445d900ca9dc03185e8b6 ]

Similarly to other recently fixed drivers make sure we don't
try to access XDP or page pool APIs when NAPI budget is 0.
NAPI budget of 0 may mean that we are in netpoll.

This may result in running software IRQs in hard IRQ context,
leading to deadlocks or crashes.

To make sure bnapi->tx_pkts don't get wiped without handling
the events, move clearing the field into the handler itself.
Remember to clear tx_pkts after reset (bnxt_enable_napi())
as it's technically possible that netpoll will accumulate
some tx_pkts and then a reset will happen, leaving tx_pkts
out of sync with reality.

Fixes: 322b87ca55f2 ("bnxt_en: add page_pool support")
Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Link: https://lore.kernel.org/r/20230728205020.2784844-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 26 +++++++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  8 +++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  2 +-
 4 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b499bc9c4e067..0b314bf4fbe65 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -633,12 +633,13 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts)
+static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 {
 	struct bnxt_tx_ring_info *txr = bnapi->tx_ring;
 	struct netdev_queue *txq = netdev_get_tx_queue(bp->dev, txr->txq_index);
 	u16 cons = txr->tx_cons;
 	struct pci_dev *pdev = bp->pdev;
+	int nr_pkts = bnapi->tx_pkts;
 	int i;
 	unsigned int tx_bytes = 0;
 
@@ -688,6 +689,7 @@ static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts)
 		dev_kfree_skb_any(skb);
 	}
 
+	bnapi->tx_pkts = 0;
 	WRITE_ONCE(txr->tx_cons, cons);
 
 	__netif_txq_completed_wake(txq, nr_pkts, tx_bytes,
@@ -2573,12 +2575,11 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	return rx_pkts;
 }
 
-static void __bnxt_poll_work_done(struct bnxt *bp, struct bnxt_napi *bnapi)
+static void __bnxt_poll_work_done(struct bnxt *bp, struct bnxt_napi *bnapi,
+				  int budget)
 {
-	if (bnapi->tx_pkts) {
-		bnapi->tx_int(bp, bnapi, bnapi->tx_pkts);
-		bnapi->tx_pkts = 0;
-	}
+	if (bnapi->tx_pkts)
+		bnapi->tx_int(bp, bnapi, budget);
 
 	if ((bnapi->events & BNXT_RX_EVENT) && !(bnapi->in_reset)) {
 		struct bnxt_rx_ring_info *rxr = bnapi->rx_ring;
@@ -2607,7 +2608,7 @@ static int bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	 */
 	bnxt_db_cq(bp, &cpr->cp_db, cpr->cp_raw_cons);
 
-	__bnxt_poll_work_done(bp, bnapi);
+	__bnxt_poll_work_done(bp, bnapi, budget);
 	return rx_pkts;
 }
 
@@ -2738,7 +2739,7 @@ static int __bnxt_poll_cqs(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 }
 
 static void __bnxt_poll_cqs_done(struct bnxt *bp, struct bnxt_napi *bnapi,
-				 u64 dbr_type)
+				 u64 dbr_type, int budget)
 {
 	struct bnxt_cp_ring_info *cpr = &bnapi->cp_ring;
 	int i;
@@ -2754,7 +2755,7 @@ static void __bnxt_poll_cqs_done(struct bnxt *bp, struct bnxt_napi *bnapi,
 			cpr2->had_work_done = 0;
 		}
 	}
-	__bnxt_poll_work_done(bp, bnapi);
+	__bnxt_poll_work_done(bp, bnapi, budget);
 }
 
 static int bnxt_poll_p5(struct napi_struct *napi, int budget)
@@ -2784,7 +2785,8 @@ static int bnxt_poll_p5(struct napi_struct *napi, int budget)
 			if (cpr->has_more_work)
 				break;
 
-			__bnxt_poll_cqs_done(bp, bnapi, DBR_TYPE_CQ_ARMALL);
+			__bnxt_poll_cqs_done(bp, bnapi, DBR_TYPE_CQ_ARMALL,
+					     budget);
 			cpr->cp_raw_cons = raw_cons;
 			if (napi_complete_done(napi, work_done))
 				BNXT_DB_NQ_ARM_P5(&cpr->cp_db,
@@ -2814,7 +2816,7 @@ static int bnxt_poll_p5(struct napi_struct *napi, int budget)
 		}
 		raw_cons = NEXT_RAW_CMP(raw_cons);
 	}
-	__bnxt_poll_cqs_done(bp, bnapi, DBR_TYPE_CQ);
+	__bnxt_poll_cqs_done(bp, bnapi, DBR_TYPE_CQ, budget);
 	if (raw_cons != cpr->cp_raw_cons) {
 		cpr->cp_raw_cons = raw_cons;
 		BNXT_DB_NQ_P5(&cpr->cp_db, raw_cons);
@@ -9433,6 +9435,8 @@ static void bnxt_enable_napi(struct bnxt *bp)
 			cpr->sw_stats.rx.rx_resets++;
 		bnapi->in_reset = false;
 
+		bnapi->tx_pkts = 0;
+
 		if (bnapi->rx_ring) {
 			INIT_WORK(&cpr->dim.work, bnxt_dim_work);
 			cpr->dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 080e73496066b..bb95c3dc5270f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1005,7 +1005,7 @@ struct bnxt_napi {
 	struct bnxt_tx_ring_info	*tx_ring;
 
 	void			(*tx_int)(struct bnxt *, struct bnxt_napi *,
-					  int);
+					  int budget);
 	int			tx_pkts;
 	u8			events;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 4efa5fe6972b2..7f2f9a317d473 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -125,16 +125,20 @@ static void __bnxt_xmit_xdp_redirect(struct bnxt *bp,
 	dma_unmap_len_set(tx_buf, len, 0);
 }
 
-void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts)
+void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 {
 	struct bnxt_tx_ring_info *txr = bnapi->tx_ring;
 	struct bnxt_rx_ring_info *rxr = bnapi->rx_ring;
 	bool rx_doorbell_needed = false;
+	int nr_pkts = bnapi->tx_pkts;
 	struct bnxt_sw_tx_bd *tx_buf;
 	u16 tx_cons = txr->tx_cons;
 	u16 last_tx_cons = tx_cons;
 	int i, j, frags;
 
+	if (!budget)
+		return;
+
 	for (i = 0; i < nr_pkts; i++) {
 		tx_buf = &txr->tx_buf_ring[tx_cons];
 
@@ -161,6 +165,8 @@ void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts)
 		}
 		tx_cons = NEXT_TX(tx_cons);
 	}
+
+	bnapi->tx_pkts = 0;
 	WRITE_ONCE(txr->tx_cons, tx_cons);
 	if (rx_doorbell_needed) {
 		tx_buf = &txr->tx_buf_ring[last_tx_cons];
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
index ea430d6961df3..5e412c5655ba5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
@@ -16,7 +16,7 @@ struct bnxt_sw_tx_bd *bnxt_xmit_bd(struct bnxt *bp,
 				   struct bnxt_tx_ring_info *txr,
 				   dma_addr_t mapping, u32 len,
 				   struct xdp_buff *xdp);
-void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts);
+void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int budget);
 bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
 		 struct xdp_buff xdp, struct page *page, u8 **data_ptr,
 		 unsigned int *len, u8 *event);
-- 
2.40.1



