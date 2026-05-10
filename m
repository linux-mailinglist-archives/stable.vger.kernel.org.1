Return-Path: <stable+bounces-245026-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cH4+GcGUAGpvKgEAu9opvQ
	(envelope-from <stable+bounces-245026-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 16:22:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0614B50494C
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 16:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4FB0300BDA2
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 14:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FF138F251;
	Sun, 10 May 2026 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nA4PooOc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A1719CD03
	for <stable@vger.kernel.org>; Sun, 10 May 2026 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778422970; cv=none; b=YmDbVxe7055ixQPCaeTBmYJPECIPxV1zdSMU6P+mS7vFTDVTP/CeDlqkWj6fZxkigOCpOJWaxC/i4J6Oc9UISJ4Bq3N+fWqFfYegpw/u4cFBnu4KwVku8+gA6f3sEGNm05s64gr96cznxGRRWwJ+Xob/qT98fkKKf7f7cT/VtR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778422970; c=relaxed/simple;
	bh=CRdNGMwuDTfqEzXXMgeX4ZO5pMqSvdW/uQSrkPgRi5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HeSThABJNoSIDDyDqTXqKIYHn/64uRX9K3AysaRy08woEkttXD4Hq2tMt0DHLkzcJnaiF4tHHAvViwpMEz0m9F0Tl4TIDf/EfvTGL0ZlEkETlXkwcYwAu3D/54oN+HXlCxlivitW3JInnwQRYyTf0QJV4TM9nhO/hAojDUpP7g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nA4PooOc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170FCC2BCC9;
	Sun, 10 May 2026 14:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778422970;
	bh=CRdNGMwuDTfqEzXXMgeX4ZO5pMqSvdW/uQSrkPgRi5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nA4PooOcL0addrnn+g3V8RSqgWtTuzKof8+kyiFqQManLnr872EBvxat4FUwC0D2M
	 MuPZVYnr+ez/xUMozcYdWlxOyavn9hEI/jh5fsWnBFY2D9sc2u/9WKChTG9mV0NcV2
	 e2NytwSz5CffUfTBqaHK3GRvVkmwZgs+6eg+nzG8R/ZUrrFsoVt1ZNt/yfT/NSZKPf
	 DIpMshdkt+xKXiFQCaq0sG044ic6EsqCHqiOYfpg6l3lE+nVfNC6HdAMD5RuT3RYFI
	 koNIU+EQIR+62lOykMo01lkjIond9n7naAZKqCccaTKF+FakUrf3BeSNr+SG1GTGOP
	 jKCvDiPwtvVXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] net: stmmac: rename STMMAC_GET_ENTRY() -> STMMAC_NEXT_ENTRY()
Date: Sun, 10 May 2026 10:22:46 -0400
Message-ID: <20260510142247.4179438-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260510142247.4179438-1-sashal@kernel.org>
References: <2026050448-gawk-hybrid-73b9@gregkh>
 <20260510142247.4179438-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0614B50494C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245026-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,armlinux.org.uk:email]
X-Rspamd-Action: no action

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

[ Upstream commit 6b4286e0550814cdc4b897f881ec1fa8b0313227 ]

STMMAC_GET_ENTRY() doesn't describe what this macro is doing - it is
incrementing the provided index for the circular array of descriptors.
Replace "GET" with "NEXT" as this better describes the action here.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://patch.msgid.link/E1w2vba-0000000DbWo-1oL5@rmk-PC.armlinux.org.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 0bb05e6adfa9 ("net: stmmac: Prevent NULL deref when RX memory exhausted")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/stmicro/stmmac/chain_mode.c  |  2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h  |  2 +-
 .../net/ethernet/stmicro/stmmac/ring_mode.c   |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 26 +++++++++----------
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
index 1c01e3c640cee..2515608878235 100644
--- a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
@@ -47,7 +47,7 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 
 	while (len != 0) {
 		tx_q->tx_skbuff[entry] = NULL;
-		entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
+		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
 		desc = tx_q->dma_tx + entry;
 
 		if (len > bmax) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 7d47c002eaf0a..03786c7f2b1fc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -55,7 +55,7 @@
 #define DMA_MIN_RX_SIZE		64
 #define DMA_MAX_RX_SIZE		1024
 #define DMA_DEFAULT_RX_SIZE	512
-#define STMMAC_GET_ENTRY(x, size)	((x + 1) & (size - 1))
+#define STMMAC_NEXT_ENTRY(x, size)	((x + 1) & (size - 1))
 
 #undef FRAME_FILTER_DEBUG
 /* #define FRAME_FILTER_DEBUG */
diff --git a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
index d218412ca832f..45c14c1bb0eaa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
@@ -51,7 +51,7 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 		stmmac_prepare_tx_desc(priv, desc, 1, bmax, csum,
 				STMMAC_RING_MODE, 0, false, skb->len);
 		tx_q->tx_skbuff[entry] = NULL;
-		entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
+		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
 
 		if (priv->extend_desc)
 			desc = (struct dma_desc *)(tx_q->dma_etx + entry);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 8d32d4fc67735..1fd3977ec01ab 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2583,7 +2583,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		xsk_tx_metadata_to_compl(meta,
 					 &tx_q->tx_skbuff_dma[entry].xsk_meta);
 
-		tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
+		tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
 		entry = tx_q->cur_tx;
 	}
 	u64_stats_update_begin(&txq_stats->napi_syncp);
@@ -2754,7 +2754,7 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
 
 		stmmac_release_tx_desc(priv, p, priv->mode);
 
-		entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
+		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
 	}
 	tx_q->dirty_tx = entry;
 
@@ -4076,7 +4076,7 @@ static bool stmmac_vlan_insert(struct stmmac_priv *priv, struct sk_buff *skb,
 		return false;
 
 	stmmac_set_tx_owner(priv, p);
-	tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
+	tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
 	return true;
 }
 
@@ -4104,7 +4104,7 @@ static void stmmac_tso_allocator(struct stmmac_priv *priv, dma_addr_t des,
 	while (tmp_len > 0) {
 		dma_addr_t curr_addr;
 
-		tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx,
+		tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx,
 						priv->dma_conf.dma_tx_size);
 		WARN_ON(tx_q->tx_skbuff[tx_q->cur_tx]);
 
@@ -4250,7 +4250,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 
 		stmmac_set_mss(priv, mss_desc, mss);
 		tx_q->mss = mss;
-		tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx,
+		tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx,
 						priv->dma_conf.dma_tx_size);
 		WARN_ON(tx_q->tx_skbuff[tx_q->cur_tx]);
 	}
@@ -4369,7 +4369,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	 * ndo_start_xmit will fill this descriptor the next time it's
 	 * called and stmmac_tx_clean may clean up to this descriptor.
 	 */
-	tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
+	tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
 
 	if (unlikely(stmmac_tx_avail(priv, queue) <= (MAX_SKB_FRAGS + 1))) {
 		netif_dbg(priv, hw, priv->dev, "%s: stop transmitted packets\n",
@@ -4568,7 +4568,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		int len = skb_frag_size(frag);
 		bool last_segment = (i == (nfrags - 1));
 
-		entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
+		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
 		WARN_ON(tx_q->tx_skbuff[entry]);
 
 		if (likely(priv->extend_desc))
@@ -4638,7 +4638,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	 * ndo_start_xmit will fill this descriptor the next time it's
 	 * called and stmmac_tx_clean may clean up to this descriptor.
 	 */
-	entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
+	entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
 	tx_q->cur_tx = entry;
 
 	if (netif_msg_pktdata(priv)) {
@@ -4807,7 +4807,7 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
 		dma_wmb();
 		stmmac_set_rx_owner(priv, p, use_rx_wd);
 
-		entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_rx_size);
+		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_rx_size);
 	}
 	rx_q->dirty_rx = entry;
 	rx_q->rx_tail_addr = rx_q->dma_rx_phy +
@@ -4941,7 +4941,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 
 	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
 
-	entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
+	entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
 	tx_q->cur_tx = entry;
 
 	return STMMAC_XDP_TX;
@@ -5175,7 +5175,7 @@ static bool stmmac_rx_refill_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		dma_wmb();
 		stmmac_set_rx_owner(priv, rx_desc, use_rx_wd);
 
-		entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_rx_size);
+		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_rx_size);
 	}
 
 	if (rx_desc) {
@@ -5270,7 +5270,7 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 			break;
 
 		/* Prefetch the next RX descriptor */
-		rx_q->cur_rx = STMMAC_GET_ENTRY(rx_q->cur_rx,
+		rx_q->cur_rx = STMMAC_NEXT_ENTRY(rx_q->cur_rx,
 						priv->dma_conf.dma_rx_size);
 		next_entry = rx_q->cur_rx;
 
@@ -5466,7 +5466,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		if (unlikely(status & dma_own))
 			break;
 
-		rx_q->cur_rx = STMMAC_GET_ENTRY(rx_q->cur_rx,
+		rx_q->cur_rx = STMMAC_NEXT_ENTRY(rx_q->cur_rx,
 						priv->dma_conf.dma_rx_size);
 		next_entry = rx_q->cur_rx;
 
-- 
2.53.0


