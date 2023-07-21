Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A6375CD93
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjGUQNI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjGUQMm (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:12:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFDC3A90
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:12:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DA5A61D30
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2C2C433CD;
        Fri, 21 Jul 2023 16:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955937;
        bh=CYtgyVZqPNKNh0yj03VZsd5tZ/Deo7DRhcXRfHqa/i0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XKb8rnrK7J0aO/BrgWtPEKFVtPgFS2Fu14baGGnV3R9UDyoJoaUfZi5s4StQJMVQQ
         edkIj53Pxs/fuSFpvTuZNUdcnltNmgdVRhyL+XjtwFf6vC39VBbpNRZaHQ8MIZ+Xta
         qGBpNAo5GaghG5ESwkEnh9phDZf5DyPl1hYh/VHE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wei Fang <wei.fang@nxp.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 083/292] net: fec: recycle pages for transmitted XDP frames
Date:   Fri, 21 Jul 2023 18:03:12 +0200
Message-ID: <20230721160532.371353127@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Wei Fang <wei.fang@nxp.com>

[ Upstream commit 20f797399035a8052dbd7297fdbe094079a9482e ]

Once the XDP frames have been successfully transmitted through the
ndo_xdp_xmit() interface, it's the driver responsibility to free
the frames so that the page_pool can recycle the pages and reuse
them. However, this action is not implemented in the fec driver.
This leads to a user-visible problem that the console will print
the following warning log.

[  157.568851] page_pool_release_retry() stalled pool shutdown 1389 inflight 60 sec
[  217.983446] page_pool_release_retry() stalled pool shutdown 1389 inflight 120 sec
[  278.399006] page_pool_release_retry() stalled pool shutdown 1389 inflight 181 sec
[  338.812885] page_pool_release_retry() stalled pool shutdown 1389 inflight 241 sec
[  399.226946] page_pool_release_retry() stalled pool shutdown 1389 inflight 302 sec

Therefore, to solve this issue, we free XDP frames via xdp_return_frame()
while cleaning the tx BD ring.

Fixes: 6d6b39f180b8 ("net: fec: add initial XDP support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fec.h      |  15 ++-
 drivers/net/ethernet/freescale/fec_main.c | 148 +++++++++++++++-------
 2 files changed, 115 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 9939ccafb5566..8c0226d061fec 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -544,10 +544,23 @@ enum {
 	XDP_STATS_TOTAL,
 };
 
+enum fec_txbuf_type {
+	FEC_TXBUF_T_SKB,
+	FEC_TXBUF_T_XDP_NDO,
+};
+
+struct fec_tx_buffer {
+	union {
+		struct sk_buff *skb;
+		struct xdp_frame *xdp;
+	};
+	enum fec_txbuf_type type;
+};
+
 struct fec_enet_priv_tx_q {
 	struct bufdesc_prop bd;
 	unsigned char *tx_bounce[TX_RING_SIZE];
-	struct  sk_buff *tx_skbuff[TX_RING_SIZE];
+	struct fec_tx_buffer tx_buf[TX_RING_SIZE];
 
 	unsigned short tx_stop_threshold;
 	unsigned short tx_wake_threshold;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 40d71be45f604..e6ed36e5daefa 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -397,7 +397,7 @@ static void fec_dump(struct net_device *ndev)
 			fec16_to_cpu(bdp->cbd_sc),
 			fec32_to_cpu(bdp->cbd_bufaddr),
 			fec16_to_cpu(bdp->cbd_datlen),
-			txq->tx_skbuff[index]);
+			txq->tx_buf[index].skb);
 		bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
 		index++;
 	} while (bdp != txq->bd.base);
@@ -654,7 +654,7 @@ static int fec_enet_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
 
 	index = fec_enet_get_bd_index(last_bdp, &txq->bd);
 	/* Save skb pointer */
-	txq->tx_skbuff[index] = skb;
+	txq->tx_buf[index].skb = skb;
 
 	/* Make sure the updates to rest of the descriptor are performed before
 	 * transferring ownership.
@@ -672,9 +672,7 @@ static int fec_enet_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
 
 	skb_tx_timestamp(skb);
 
-	/* Make sure the update to bdp and tx_skbuff are performed before
-	 * txq->bd.cur.
-	 */
+	/* Make sure the update to bdp is performed before txq->bd.cur. */
 	wmb();
 	txq->bd.cur = bdp;
 
@@ -862,7 +860,7 @@ static int fec_enet_txq_submit_tso(struct fec_enet_priv_tx_q *txq,
 	}
 
 	/* Save skb pointer */
-	txq->tx_skbuff[index] = skb;
+	txq->tx_buf[index].skb = skb;
 
 	skb_tx_timestamp(skb);
 	txq->bd.cur = bdp;
@@ -952,16 +950,33 @@ static void fec_enet_bd_init(struct net_device *dev)
 		for (i = 0; i < txq->bd.ring_size; i++) {
 			/* Initialize the BD for every fragment in the page. */
 			bdp->cbd_sc = cpu_to_fec16(0);
-			if (bdp->cbd_bufaddr &&
-			    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
-				dma_unmap_single(&fep->pdev->dev,
-						 fec32_to_cpu(bdp->cbd_bufaddr),
-						 fec16_to_cpu(bdp->cbd_datlen),
-						 DMA_TO_DEVICE);
-			if (txq->tx_skbuff[i]) {
-				dev_kfree_skb_any(txq->tx_skbuff[i]);
-				txq->tx_skbuff[i] = NULL;
+			if (txq->tx_buf[i].type == FEC_TXBUF_T_SKB) {
+				if (bdp->cbd_bufaddr &&
+				    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
+					dma_unmap_single(&fep->pdev->dev,
+							 fec32_to_cpu(bdp->cbd_bufaddr),
+							 fec16_to_cpu(bdp->cbd_datlen),
+							 DMA_TO_DEVICE);
+				if (txq->tx_buf[i].skb) {
+					dev_kfree_skb_any(txq->tx_buf[i].skb);
+					txq->tx_buf[i].skb = NULL;
+				}
+			} else {
+				if (bdp->cbd_bufaddr)
+					dma_unmap_single(&fep->pdev->dev,
+							 fec32_to_cpu(bdp->cbd_bufaddr),
+							 fec16_to_cpu(bdp->cbd_datlen),
+							 DMA_TO_DEVICE);
+
+				if (txq->tx_buf[i].xdp) {
+					xdp_return_frame(txq->tx_buf[i].xdp);
+					txq->tx_buf[i].xdp = NULL;
+				}
+
+				/* restore default tx buffer type: FEC_TXBUF_T_SKB */
+				txq->tx_buf[i].type = FEC_TXBUF_T_SKB;
 			}
+
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
 			bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
 		}
@@ -1360,6 +1375,7 @@ static void
 fec_enet_tx_queue(struct net_device *ndev, u16 queue_id)
 {
 	struct	fec_enet_private *fep;
+	struct xdp_frame *xdpf;
 	struct bufdesc *bdp;
 	unsigned short status;
 	struct	sk_buff	*skb;
@@ -1387,16 +1403,31 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id)
 
 		index = fec_enet_get_bd_index(bdp, &txq->bd);
 
-		skb = txq->tx_skbuff[index];
-		txq->tx_skbuff[index] = NULL;
-		if (!IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
-			dma_unmap_single(&fep->pdev->dev,
-					 fec32_to_cpu(bdp->cbd_bufaddr),
-					 fec16_to_cpu(bdp->cbd_datlen),
-					 DMA_TO_DEVICE);
-		bdp->cbd_bufaddr = cpu_to_fec32(0);
-		if (!skb)
-			goto skb_done;
+		if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB) {
+			skb = txq->tx_buf[index].skb;
+			txq->tx_buf[index].skb = NULL;
+			if (bdp->cbd_bufaddr &&
+			    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
+				dma_unmap_single(&fep->pdev->dev,
+						 fec32_to_cpu(bdp->cbd_bufaddr),
+						 fec16_to_cpu(bdp->cbd_datlen),
+						 DMA_TO_DEVICE);
+			bdp->cbd_bufaddr = cpu_to_fec32(0);
+			if (!skb)
+				goto tx_buf_done;
+		} else {
+			xdpf = txq->tx_buf[index].xdp;
+			if (bdp->cbd_bufaddr)
+				dma_unmap_single(&fep->pdev->dev,
+						 fec32_to_cpu(bdp->cbd_bufaddr),
+						 fec16_to_cpu(bdp->cbd_datlen),
+						 DMA_TO_DEVICE);
+			bdp->cbd_bufaddr = cpu_to_fec32(0);
+			if (!xdpf) {
+				txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
+				goto tx_buf_done;
+			}
+		}
 
 		/* Check for errors. */
 		if (status & (BD_ENET_TX_HB | BD_ENET_TX_LC |
@@ -1415,21 +1446,11 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id)
 				ndev->stats.tx_carrier_errors++;
 		} else {
 			ndev->stats.tx_packets++;
-			ndev->stats.tx_bytes += skb->len;
-		}
 
-		/* NOTE: SKBTX_IN_PROGRESS being set does not imply it's we who
-		 * are to time stamp the packet, so we still need to check time
-		 * stamping enabled flag.
-		 */
-		if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS &&
-			     fep->hwts_tx_en) &&
-		    fep->bufdesc_ex) {
-			struct skb_shared_hwtstamps shhwtstamps;
-			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
-
-			fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts), &shhwtstamps);
-			skb_tstamp_tx(skb, &shhwtstamps);
+			if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB)
+				ndev->stats.tx_bytes += skb->len;
+			else
+				ndev->stats.tx_bytes += xdpf->len;
 		}
 
 		/* Deferred means some collisions occurred during transmit,
@@ -1438,10 +1459,32 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id)
 		if (status & BD_ENET_TX_DEF)
 			ndev->stats.collisions++;
 
-		/* Free the sk buffer associated with this last transmit */
-		dev_kfree_skb_any(skb);
-skb_done:
-		/* Make sure the update to bdp and tx_skbuff are performed
+		if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB) {
+			/* NOTE: SKBTX_IN_PROGRESS being set does not imply it's we who
+			 * are to time stamp the packet, so we still need to check time
+			 * stamping enabled flag.
+			 */
+			if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS &&
+				     fep->hwts_tx_en) && fep->bufdesc_ex) {
+				struct skb_shared_hwtstamps shhwtstamps;
+				struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+				fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts), &shhwtstamps);
+				skb_tstamp_tx(skb, &shhwtstamps);
+			}
+
+			/* Free the sk buffer associated with this last transmit */
+			dev_kfree_skb_any(skb);
+		} else {
+			xdp_return_frame(xdpf);
+
+			txq->tx_buf[index].xdp = NULL;
+			/* restore default tx buffer type: FEC_TXBUF_T_SKB */
+			txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
+		}
+
+tx_buf_done:
+		/* Make sure the update to bdp and tx_buf are performed
 		 * before dirty_tx
 		 */
 		wmb();
@@ -3247,9 +3290,19 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 		for (i = 0; i < txq->bd.ring_size; i++) {
 			kfree(txq->tx_bounce[i]);
 			txq->tx_bounce[i] = NULL;
-			skb = txq->tx_skbuff[i];
-			txq->tx_skbuff[i] = NULL;
-			dev_kfree_skb(skb);
+
+			if (txq->tx_buf[i].type == FEC_TXBUF_T_SKB) {
+				skb = txq->tx_buf[i].skb;
+				txq->tx_buf[i].skb = NULL;
+				dev_kfree_skb(skb);
+			} else {
+				if (txq->tx_buf[i].xdp) {
+					xdp_return_frame(txq->tx_buf[i].xdp);
+					txq->tx_buf[i].xdp = NULL;
+				}
+
+				txq->tx_buf[i].type = FEC_TXBUF_T_SKB;
+			}
 		}
 	}
 }
@@ -3809,7 +3862,8 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 		ebdp->cbd_esc = cpu_to_fec32(estatus);
 	}
 
-	txq->tx_skbuff[index] = NULL;
+	txq->tx_buf[index].type = FEC_TXBUF_T_XDP_NDO;
+	txq->tx_buf[index].xdp = frame;
 
 	/* Make sure the updates to rest of the descriptor are performed before
 	 * transferring ownership.
-- 
2.39.2



