Return-Path: <stable+bounces-245020-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id y+6aGjuKAGodKAEAu9opvQ
	(envelope-from <stable+bounces-245020-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 15:38:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1995044CD
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 15:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D606300B622
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 13:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B410F37E2EC;
	Sun, 10 May 2026 13:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntIxRvnd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A5035AC1E
	for <stable@vger.kernel.org>; Sun, 10 May 2026 13:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778420280; cv=none; b=WgpJWSZJTZmfwDVaUCMmjzxM/O2fmeysNPfghd8mwA79H8z5rphkNgNxcgTWN3kJXaNO2p5DT/ovspQDIikT1bVDqt1BXxW4jdYpo34hNNn140wTravwcxeTBSMdniu4IBg7R0FoZQzBxZPnhJAprUxYtuhk43th4/pYbXeA9zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778420280; c=relaxed/simple;
	bh=AtPJ+85qEoJtDmKEf43J0VsMPVp4si72+PMu/7VdlEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2xEGdAE/GUWCtwAKmO6Ub3WUw9mJytsxY/+xF1vnl3IPMoN8+GC1Akin5ANv1EUzLEI5vOSal8pBL/Ypdlgd/64yVPY+q3JcPy9udnH2C6TtasC+HiZpKNnz8w3loPpt8T1toLjzcpdqwe6qAyzWJ3OYu9R3KSjDt+Q5tUllDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntIxRvnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91789C2BCB8;
	Sun, 10 May 2026 13:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778420280;
	bh=AtPJ+85qEoJtDmKEf43J0VsMPVp4si72+PMu/7VdlEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ntIxRvndFJnxgtHkSKilppQ1RTqKxvuGQZxRYiFrSslmgxHYfEtk7sYWhlcTmYe0a
	 ILTzAOGe4/2BzjY5Wz4GwCqWMhT8avrjFT+ykAl41tBudM5IEWSlTA65mtgnKyizMQ
	 gBmGCwIyM70QB5LmSA3NAfRdO4duU5vwb8HyhuNLiEue3+zj8XMsnW8fEq6Znyv3gG
	 2icq+aY4fwlcZL25rjYaw5gHPhHVF9MavPEWMlKG+TUh5wS7cRw4yKOGWtvXCL0UXz
	 Justf2FU3havFBm3doXSYJPg3TTaJKxyvtO9V5QndbDwNZLvN9XFk2BZomT6zUEqJb
	 Q+XY+xaoEcRYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 1/2] net: stmmac: rename STMMAC_GET_ENTRY() -> STMMAC_NEXT_ENTRY()
Date: Sun, 10 May 2026 09:37:56 -0400
Message-ID: <20260510133757.4137215-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050445-outscore-much-bbe7@gregkh>
References: <2026050445-outscore-much-bbe7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AA1995044CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245020-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
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
index 37f9417c7c0e0..fc04a23342cfc 100644
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
index d26e8a0630224..bd0fb5142d663 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -63,7 +63,7 @@ static inline bool dwmac_is_xmac(enum dwmac_core_type core_type)
 #define DMA_MIN_RX_SIZE		64
 #define DMA_MAX_RX_SIZE		1024
 #define DMA_DEFAULT_RX_SIZE	512
-#define STMMAC_GET_ENTRY(x, size)	((x + 1) & (size - 1))
+#define STMMAC_NEXT_ENTRY(x, size)	((x + 1) & (size - 1))
 
 #undef FRAME_FILTER_DEBUG
 /* #define FRAME_FILTER_DEBUG */
diff --git a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
index 382d94a3b9720..78fc6aa5bbe95 100644
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
index 13d3cac056bea..aa0bf1335ed34 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2744,7 +2744,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		xsk_tx_metadata_to_compl(meta,
 					 &tx_q->tx_skbuff_dma[entry].xsk_meta);
 
-		tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
+		tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
 		entry = tx_q->cur_tx;
 	}
 	u64_stats_update_begin(&txq_stats->napi_syncp);
@@ -2915,7 +2915,7 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
 
 		stmmac_release_tx_desc(priv, p, priv->mode);
 
-		entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
+		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
 	}
 	tx_q->dirty_tx = entry;
 
@@ -4258,7 +4258,7 @@ static bool stmmac_vlan_insert(struct stmmac_priv *priv, struct sk_buff *skb,
 		return false;
 
 	stmmac_set_tx_owner(priv, p);
-	tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
+	tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
 	return true;
 }
 
@@ -4286,7 +4286,7 @@ static void stmmac_tso_allocator(struct stmmac_priv *priv, dma_addr_t des,
 	while (tmp_len > 0) {
 		dma_addr_t curr_addr;
 
-		tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx,
+		tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx,
 						priv->dma_conf.dma_tx_size);
 		WARN_ON(tx_q->tx_skbuff[tx_q->cur_tx]);
 
@@ -4437,7 +4437,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 
 		stmmac_set_mss(priv, mss_desc, mss);
 		tx_q->mss = mss;
-		tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx,
+		tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx,
 						priv->dma_conf.dma_tx_size);
 		WARN_ON(tx_q->tx_skbuff[tx_q->cur_tx]);
 	}
@@ -4541,7 +4541,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	 * ndo_start_xmit will fill this descriptor the next time it's
 	 * called and stmmac_tx_clean may clean up to this descriptor.
 	 */
-	tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
+	tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
 
 	if (unlikely(stmmac_tx_avail(priv, queue) <= (MAX_SKB_FRAGS + 1))) {
 		netif_dbg(priv, hw, priv->dev, "%s: stop transmitted packets\n",
@@ -4751,7 +4751,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		int len = skb_frag_size(frag);
 		bool last_segment = (i == (nfrags - 1));
 
-		entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
+		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
 		WARN_ON(tx_q->tx_skbuff[entry]);
 
 		if (likely(priv->extend_desc))
@@ -4821,7 +4821,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	 * ndo_start_xmit will fill this descriptor the next time it's
 	 * called and stmmac_tx_clean may clean up to this descriptor.
 	 */
-	entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
+	entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
 	tx_q->cur_tx = entry;
 
 	if (netif_msg_pktdata(priv)) {
@@ -4990,7 +4990,7 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
 		dma_wmb();
 		stmmac_set_rx_owner(priv, p, use_rx_wd);
 
-		entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_rx_size);
+		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_rx_size);
 	}
 	rx_q->dirty_rx = entry;
 	rx_q->rx_tail_addr = rx_q->dma_rx_phy +
@@ -5140,7 +5140,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 
 	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
 
-	entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
+	entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
 	tx_q->cur_tx = entry;
 
 	return STMMAC_XDP_TX;
@@ -5374,7 +5374,7 @@ static bool stmmac_rx_refill_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		dma_wmb();
 		stmmac_set_rx_owner(priv, rx_desc, use_rx_wd);
 
-		entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_rx_size);
+		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_rx_size);
 	}
 
 	if (rx_desc) {
@@ -5469,7 +5469,7 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 			break;
 
 		/* Prefetch the next RX descriptor */
-		rx_q->cur_rx = STMMAC_GET_ENTRY(rx_q->cur_rx,
+		rx_q->cur_rx = STMMAC_NEXT_ENTRY(rx_q->cur_rx,
 						priv->dma_conf.dma_rx_size);
 		next_entry = rx_q->cur_rx;
 
@@ -5665,7 +5665,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		if (unlikely(status & dma_own))
 			break;
 
-		rx_q->cur_rx = STMMAC_GET_ENTRY(rx_q->cur_rx,
+		rx_q->cur_rx = STMMAC_NEXT_ENTRY(rx_q->cur_rx,
 						priv->dma_conf.dma_rx_size);
 		next_entry = rx_q->cur_rx;
 
-- 
2.53.0


