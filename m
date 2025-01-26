Return-Path: <stable+bounces-110632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF125A1CAA9
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E84A1885AF9
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5112063FC;
	Sun, 26 Jan 2025 15:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UspHUnrH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267712063F4;
	Sun, 26 Jan 2025 15:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903721; cv=none; b=UGaJBqEfiX9WPRZDUXYLDMwMwuZxBBRWO4WUJBoSQEUPJZ5IYzdxNbWyMzVTzVRgYaEjTP1coMQFWTyDb9HRyWTrDW9o0kZa7/mHOQ6OzjRLex1xcZEF9t6KYicFKDGctNXDIh9sB8UH7W3TBQONbZLd7F7qCvXIoP5ILBA7HD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903721; c=relaxed/simple;
	bh=SR1hu6nXyJqZdJm7Z8j2I2ChoV54Uy53VBcYCPSYwAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mJUowGwA2U9WUrbDlXvgN/Q/C5p2e9R0Hj7c6EmoimWZ4wU694LGVCxrZBT4VuibhqNHfIXFlT+yN9fRwiZV2Wh/gvIzxOTS1DoD4A8K25DueReP0hhFtTK64bGYK8JU1tXCQmW3jyQ/wDwMveG9w1R6NkB2SBVBkV2DDD6d5BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UspHUnrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F2AC4CEE2;
	Sun, 26 Jan 2025 15:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903721;
	bh=SR1hu6nXyJqZdJm7Z8j2I2ChoV54Uy53VBcYCPSYwAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UspHUnrHNkbawFD9h/j9PmLKSTHRWoWf4lW8J3G9WIqeQe9cy5PPbgG44pDDFa4qc
	 FsHh8DFbEw0Ns9cUG82nMavk01+nMhEvgSQNomyHdMpOAStPR1q8VrWSMd01jEAGWI
	 ILWI6iV2IiGqx2KF2ImOaqnkf6wLF2wD4Ik1Z6jTGGuSPHRr9ar5a5x+Y+Edey8cik
	 Xpu2Be6PxIt0tqRHuv2sNR63BKiydIeTsDAYOJFQkela4J3Ct7PfgEQjpQKTxn/7JN
	 EbcFHvLYHgZNbQKPc1nivAe48ALjMnO0R/wIcOvNHhFE2t0tglsX1kkDErimi5FXiA
	 Ln89cWoBpH6zw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shinas Rasheed <srasheed@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	vburru@marvell.com,
	sedara@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 31/35] octeon_ep: update tx/rx stats locally for persistence
Date: Sun, 26 Jan 2025 10:00:25 -0500
Message-Id: <20250126150029.953021-31-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150029.953021-1-sashal@kernel.org>
References: <20250126150029.953021-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Shinas Rasheed <srasheed@marvell.com>

[ Upstream commit 10fad79846e49f67ad1a0a05910837125c6ca9ad ]

Update tx/rx stats locally, so that ndo_get_stats64()
can use that and not rely on per queue resources to obtain statistics.
The latter used to cause race conditions when the device stopped.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
Link: https://patch.msgid.link/20250117094653.2588578-3-srasheed@marvell.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../marvell/octeon_ep/octep_ethtool.c         | 41 ++++++++-----------
 .../ethernet/marvell/octeon_ep/octep_main.c   | 19 ++++-----
 .../ethernet/marvell/octeon_ep/octep_main.h   |  6 +++
 .../net/ethernet/marvell/octeon_ep/octep_rx.c | 11 ++---
 .../net/ethernet/marvell/octeon_ep/octep_rx.h |  4 +-
 .../net/ethernet/marvell/octeon_ep/octep_tx.c |  7 ++--
 .../net/ethernet/marvell/octeon_ep/octep_tx.h |  4 +-
 7 files changed, 45 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ethtool.c b/drivers/net/ethernet/marvell/octeon_ep/octep_ethtool.c
index 4f4d581891188..a88c006ea65b7 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ethtool.c
@@ -150,17 +150,14 @@ octep_get_ethtool_stats(struct net_device *netdev,
 				    iface_rx_stats,
 				    iface_tx_stats);
 
-	for (q = 0; q < oct->num_oqs; q++) {
-		struct octep_iq *iq = oct->iq[q];
-		struct octep_oq *oq = oct->oq[q];
-
-		tx_packets += iq->stats.instr_completed;
-		tx_bytes += iq->stats.bytes_sent;
-		tx_busy_errors += iq->stats.tx_busy;
-
-		rx_packets += oq->stats.packets;
-		rx_bytes += oq->stats.bytes;
-		rx_alloc_errors += oq->stats.alloc_failures;
+	for (q = 0; q < OCTEP_MAX_QUEUES; q++) {
+		tx_packets += oct->stats_iq[q].instr_completed;
+		tx_bytes += oct->stats_iq[q].bytes_sent;
+		tx_busy_errors += oct->stats_iq[q].tx_busy;
+
+		rx_packets += oct->stats_oq[q].packets;
+		rx_bytes += oct->stats_oq[q].bytes;
+		rx_alloc_errors += oct->stats_oq[q].alloc_failures;
 	}
 	i = 0;
 	data[i++] = rx_packets;
@@ -198,22 +195,18 @@ octep_get_ethtool_stats(struct net_device *netdev,
 	data[i++] = iface_rx_stats->err_pkts;
 
 	/* Per Tx Queue stats */
-	for (q = 0; q < oct->num_iqs; q++) {
-		struct octep_iq *iq = oct->iq[q];
-
-		data[i++] = iq->stats.instr_posted;
-		data[i++] = iq->stats.instr_completed;
-		data[i++] = iq->stats.bytes_sent;
-		data[i++] = iq->stats.tx_busy;
+	for (q = 0; q < OCTEP_MAX_QUEUES; q++) {
+		data[i++] = oct->stats_iq[q].instr_posted;
+		data[i++] = oct->stats_iq[q].instr_completed;
+		data[i++] = oct->stats_iq[q].bytes_sent;
+		data[i++] = oct->stats_iq[q].tx_busy;
 	}
 
 	/* Per Rx Queue stats */
-	for (q = 0; q < oct->num_oqs; q++) {
-		struct octep_oq *oq = oct->oq[q];
-
-		data[i++] = oq->stats.packets;
-		data[i++] = oq->stats.bytes;
-		data[i++] = oq->stats.alloc_failures;
+	for (q = 0; q < OCTEP_MAX_QUEUES; q++) {
+		data[i++] = oct->stats_oq[q].packets;
+		data[i++] = oct->stats_oq[q].bytes;
+		data[i++] = oct->stats_oq[q].alloc_failures;
 	}
 }
 
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 549436efc2048..317c8cdc21b20 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -822,7 +822,7 @@ static inline int octep_iq_full_check(struct octep_iq *iq)
 	if (unlikely(IQ_INSTR_SPACE(iq) >
 		     OCTEP_WAKE_QUEUE_THRESHOLD)) {
 		netif_start_subqueue(iq->netdev, iq->q_no);
-		iq->stats.restart_cnt++;
+		iq->stats->restart_cnt++;
 		return 0;
 	}
 
@@ -960,7 +960,7 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
 	wmb();
 	/* Ring Doorbell to notify the NIC of new packets */
 	writel(iq->fill_cnt, iq->doorbell_reg);
-	iq->stats.instr_posted += iq->fill_cnt;
+	iq->stats->instr_posted += iq->fill_cnt;
 	iq->fill_cnt = 0;
 	return NETDEV_TX_OK;
 
@@ -991,8 +991,8 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
 static void octep_get_stats64(struct net_device *netdev,
 			      struct rtnl_link_stats64 *stats)
 {
-	u64 tx_packets, tx_bytes, rx_packets, rx_bytes;
 	struct octep_device *oct = netdev_priv(netdev);
+	u64 tx_packets, tx_bytes, rx_packets, rx_bytes;
 	int q;
 
 	if (netif_running(netdev))
@@ -1005,14 +1005,11 @@ static void octep_get_stats64(struct net_device *netdev,
 	tx_bytes = 0;
 	rx_packets = 0;
 	rx_bytes = 0;
-	for (q = 0; q < oct->num_oqs; q++) {
-		struct octep_iq *iq = oct->iq[q];
-		struct octep_oq *oq = oct->oq[q];
-
-		tx_packets += iq->stats.instr_completed;
-		tx_bytes += iq->stats.bytes_sent;
-		rx_packets += oq->stats.packets;
-		rx_bytes += oq->stats.bytes;
+	for (q = 0; q < OCTEP_MAX_QUEUES; q++) {
+		tx_packets += oct->stats_iq[q].instr_completed;
+		tx_bytes += oct->stats_iq[q].bytes_sent;
+		rx_packets += oct->stats_oq[q].packets;
+		rx_bytes += oct->stats_oq[q].bytes;
 	}
 	stats->tx_packets = tx_packets;
 	stats->tx_bytes = tx_bytes;
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
index fee59e0e0138f..936b786f42816 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
@@ -257,11 +257,17 @@ struct octep_device {
 	/* Pointers to Octeon Tx queues */
 	struct octep_iq *iq[OCTEP_MAX_IQ];
 
+	/* Per iq stats */
+	struct octep_iq_stats stats_iq[OCTEP_MAX_IQ];
+
 	/* Rx queues (OQ: Output Queue) */
 	u16 num_oqs;
 	/* Pointers to Octeon Rx queues */
 	struct octep_oq *oq[OCTEP_MAX_OQ];
 
+	/* Per oq stats */
+	struct octep_oq_stats stats_oq[OCTEP_MAX_OQ];
+
 	/* Hardware port number of the PCIe interface */
 	u16 pcie_port;
 
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
index 8af75cb37c3ee..82b6b19e76b47 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
@@ -87,7 +87,7 @@ static int octep_oq_refill(struct octep_device *oct, struct octep_oq *oq)
 		page = dev_alloc_page();
 		if (unlikely(!page)) {
 			dev_err(oq->dev, "refill: rx buffer alloc failed\n");
-			oq->stats.alloc_failures++;
+			oq->stats->alloc_failures++;
 			break;
 		}
 
@@ -98,7 +98,7 @@ static int octep_oq_refill(struct octep_device *oct, struct octep_oq *oq)
 				"OQ-%d buffer refill: DMA mapping error!\n",
 				oq->q_no);
 			put_page(page);
-			oq->stats.alloc_failures++;
+			oq->stats->alloc_failures++;
 			break;
 		}
 		oq->buff_info[refill_idx].page = page;
@@ -134,6 +134,7 @@ static int octep_setup_oq(struct octep_device *oct, int q_no)
 	oq->netdev = oct->netdev;
 	oq->dev = &oct->pdev->dev;
 	oq->q_no = q_no;
+	oq->stats = &oct->stats_oq[q_no];
 	oq->max_count = CFG_GET_OQ_NUM_DESC(oct->conf);
 	oq->ring_size_mask = oq->max_count - 1;
 	oq->buffer_size = CFG_GET_OQ_BUF_SIZE(oct->conf);
@@ -443,7 +444,7 @@ static int __octep_oq_process_rx(struct octep_device *oct,
 		if (!skb) {
 			octep_oq_drop_rx(oq, buff_info,
 					 &read_idx, &desc_used);
-			oq->stats.alloc_failures++;
+			oq->stats->alloc_failures++;
 			continue;
 		}
 		skb_reserve(skb, data_offset);
@@ -494,8 +495,8 @@ static int __octep_oq_process_rx(struct octep_device *oct,
 
 	oq->host_read_idx = read_idx;
 	oq->refill_count += desc_used;
-	oq->stats.packets += pkt;
-	oq->stats.bytes += rx_bytes;
+	oq->stats->packets += pkt;
+	oq->stats->bytes += rx_bytes;
 
 	return pkt;
 }
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.h b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.h
index 3b08e2d560dc3..b4696c93d0e6a 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.h
@@ -186,8 +186,8 @@ struct octep_oq {
 	 */
 	u8 __iomem *pkts_sent_reg;
 
-	/* Statistics for this OQ. */
-	struct octep_oq_stats stats;
+	/* Pointer to statistics for this OQ. */
+	struct octep_oq_stats *stats;
 
 	/* Packets pending to be processed */
 	u32 pkts_pending;
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c
index 06851b78aa28c..08ee90013fef3 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c
@@ -81,9 +81,9 @@ int octep_iq_process_completions(struct octep_iq *iq, u16 budget)
 	}
 
 	iq->pkts_processed += compl_pkts;
-	iq->stats.instr_completed += compl_pkts;
-	iq->stats.bytes_sent += compl_bytes;
-	iq->stats.sgentry_sent += compl_sg;
+	iq->stats->instr_completed += compl_pkts;
+	iq->stats->bytes_sent += compl_bytes;
+	iq->stats->sgentry_sent += compl_sg;
 	iq->flush_index = fi;
 
 	netdev_tx_completed_queue(iq->netdev_q, compl_pkts, compl_bytes);
@@ -187,6 +187,7 @@ static int octep_setup_iq(struct octep_device *oct, int q_no)
 	iq->netdev = oct->netdev;
 	iq->dev = &oct->pdev->dev;
 	iq->q_no = q_no;
+	iq->stats = &oct->stats_iq[q_no];
 	iq->max_count = CFG_GET_IQ_NUM_DESC(oct->conf);
 	iq->ring_size_mask = iq->max_count - 1;
 	iq->fill_threshold = CFG_GET_IQ_DB_MIN(oct->conf);
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
index 875a2c34091ff..58fb39dda977c 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
@@ -170,8 +170,8 @@ struct octep_iq {
 	 */
 	u16 flush_index;
 
-	/* Statistics for this input queue. */
-	struct octep_iq_stats stats;
+	/* Pointer to statistics for this input queue. */
+	struct octep_iq_stats *stats;
 
 	/* Pointer to the Virtual Base addr of the input ring. */
 	struct octep_tx_desc_hw *desc_ring;
-- 
2.39.5


