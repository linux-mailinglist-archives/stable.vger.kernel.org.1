Return-Path: <stable+bounces-6240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8166380D98C
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CB1F282053
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C728851C59;
	Mon, 11 Dec 2023 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Va1IG3Qf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A2951C38;
	Mon, 11 Dec 2023 18:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3E5C433C7;
	Mon, 11 Dec 2023 18:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320891;
	bh=M26aKDLjI4naHN9yuOg4o1X0vlT4cMDH7OhL5nJ7BEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Va1IG3QflZdv7wp24z9FXv01E1mLePy42nDYErjJ4Oeskc64rGpki5PkdEl93S2L3
	 RdnEH+I36EsOcJl0e80Nq+H2o5VAEATra5Tw8sXd48rzLMzhzpsyVAUY+1O6hMfCLj
	 dEMQPH/YZu4hbx4Y5vSjdCn2uCQa2ZntteRNshwI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Pakhunov <alexey.pakhunov@spacex.com>,
	Vincent Wong <vincent.wong2@spacex.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 005/141] tg3: Move the [rt]x_dropped counters to tg3_napi
Date: Mon, 11 Dec 2023 19:21:04 +0100
Message-ID: <20231211182026.724020443@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182026.503492284@linuxfoundation.org>
References: <20231211182026.503492284@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Pakhunov <alexey.pakhunov@spacex.com>

[ Upstream commit 907d1bdb8b2cc0357d03a1c34d2a08d9943760b1 ]

This change moves [rt]x_dropped counters to tg3_napi so that they can be
updated by a single writer, race-free.

Signed-off-by: Alex Pakhunov <alexey.pakhunov@spacex.com>
Signed-off-by: Vincent Wong <vincent.wong2@spacex.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Link: https://lore.kernel.org/r/20231113182350.37472-1-alexey.pakhunov@spacex.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/tg3.c | 38 +++++++++++++++++++++++++----
 drivers/net/ethernet/broadcom/tg3.h |  4 +--
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 2c41852a082bb..946b4decac0ce 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -6854,7 +6854,7 @@ static int tg3_rx(struct tg3_napi *tnapi, int budget)
 				       desc_idx, *post_ptr);
 		drop_it_no_recycle:
 			/* Other statistics kept track of by card. */
-			tp->rx_dropped++;
+			tnapi->rx_dropped++;
 			goto next_pkt;
 		}
 
@@ -8152,7 +8152,7 @@ static netdev_tx_t tg3_start_xmit(struct sk_buff *skb, struct net_device *dev)
 drop:
 	dev_kfree_skb_any(skb);
 drop_nofree:
-	tp->tx_dropped++;
+	tnapi->tx_dropped++;
 	return NETDEV_TX_OK;
 }
 
@@ -9331,7 +9331,7 @@ static void __tg3_set_rx_mode(struct net_device *);
 /* tp->lock is held. */
 static int tg3_halt(struct tg3 *tp, int kind, bool silent)
 {
-	int err;
+	int err, i;
 
 	tg3_stop_fw(tp);
 
@@ -9352,6 +9352,13 @@ static int tg3_halt(struct tg3 *tp, int kind, bool silent)
 
 		/* And make sure the next sample is new data */
 		memset(tp->hw_stats, 0, sizeof(struct tg3_hw_stats));
+
+		for (i = 0; i < TG3_IRQ_MAX_VECS; ++i) {
+			struct tg3_napi *tnapi = &tp->napi[i];
+
+			tnapi->rx_dropped = 0;
+			tnapi->tx_dropped = 0;
+		}
 	}
 
 	return err;
@@ -11906,6 +11913,9 @@ static void tg3_get_nstats(struct tg3 *tp, struct rtnl_link_stats64 *stats)
 {
 	struct rtnl_link_stats64 *old_stats = &tp->net_stats_prev;
 	struct tg3_hw_stats *hw_stats = tp->hw_stats;
+	unsigned long rx_dropped;
+	unsigned long tx_dropped;
+	int i;
 
 	stats->rx_packets = old_stats->rx_packets +
 		get_stat64(&hw_stats->rx_ucast_packets) +
@@ -11952,8 +11962,26 @@ static void tg3_get_nstats(struct tg3 *tp, struct rtnl_link_stats64 *stats)
 	stats->rx_missed_errors = old_stats->rx_missed_errors +
 		get_stat64(&hw_stats->rx_discards);
 
-	stats->rx_dropped = tp->rx_dropped;
-	stats->tx_dropped = tp->tx_dropped;
+	/* Aggregate per-queue counters. The per-queue counters are updated
+	 * by a single writer, race-free. The result computed by this loop
+	 * might not be 100% accurate (counters can be updated in the middle of
+	 * the loop) but the next tg3_get_nstats() will recompute the current
+	 * value so it is acceptable.
+	 *
+	 * Note that these counters wrap around at 4G on 32bit machines.
+	 */
+	rx_dropped = (unsigned long)(old_stats->rx_dropped);
+	tx_dropped = (unsigned long)(old_stats->tx_dropped);
+
+	for (i = 0; i < tp->irq_cnt; i++) {
+		struct tg3_napi *tnapi = &tp->napi[i];
+
+		rx_dropped += tnapi->rx_dropped;
+		tx_dropped += tnapi->tx_dropped;
+	}
+
+	stats->rx_dropped = rx_dropped;
+	stats->tx_dropped = tx_dropped;
 }
 
 static int tg3_get_regs_len(struct net_device *dev)
diff --git a/drivers/net/ethernet/broadcom/tg3.h b/drivers/net/ethernet/broadcom/tg3.h
index 1000c894064f0..8d753f8c5b065 100644
--- a/drivers/net/ethernet/broadcom/tg3.h
+++ b/drivers/net/ethernet/broadcom/tg3.h
@@ -3018,6 +3018,7 @@ struct tg3_napi {
 	u16				*rx_rcb_prod_idx;
 	struct tg3_rx_prodring_set	prodring;
 	struct tg3_rx_buffer_desc	*rx_rcb;
+	unsigned long			rx_dropped;
 
 	u32				tx_prod	____cacheline_aligned;
 	u32				tx_cons;
@@ -3026,6 +3027,7 @@ struct tg3_napi {
 	u32				prodmbox;
 	struct tg3_tx_buffer_desc	*tx_ring;
 	struct tg3_tx_ring_info		*tx_buffers;
+	unsigned long			tx_dropped;
 
 	dma_addr_t			status_mapping;
 	dma_addr_t			rx_rcb_mapping;
@@ -3219,8 +3221,6 @@ struct tg3 {
 
 
 	/* begin "everything else" cacheline(s) section */
-	unsigned long			rx_dropped;
-	unsigned long			tx_dropped;
 	struct rtnl_link_stats64	net_stats_prev;
 	struct tg3_ethtool_stats	estats_prev;
 
-- 
2.42.0




