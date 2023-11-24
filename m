Return-Path: <stable+bounces-2429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F527F8423
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D911FB27C5A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD7D37170;
	Fri, 24 Nov 2023 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D6xday69"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB90321AD;
	Fri, 24 Nov 2023 19:24:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9A3C433C8;
	Fri, 24 Nov 2023 19:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853860;
	bh=/zAlKrh3Uyq82SsRQRwR6xxAGwjdCXSTCTwrpLLKrSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D6xday69u90wOeinSYhQ2ywqXN8YeXjnDo8CwnmOPYyyaNWOUWRafWyS5ePpyCbOD
	 JgnBVCYqlex9Z/m0EGCsKSW5iLcBy7MwmEQQH3yPa7f+8ro9/2m55OyIKJ4G9vBYjp
	 QaejgANWyNLFJgK36FsY8dYwU6Hml2jtJhZYovQo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 059/159] net: stmmac: Rework stmmac_rx()
Date: Fri, 24 Nov 2023 17:54:36 +0000
Message-ID: <20231124171944.386983903@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171941.909624388@linuxfoundation.org>
References: <20231124171941.909624388@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jose Abreu <Jose.Abreu@synopsys.com>

[ Upstream commit 88ebe2cf7f3fc9da95e0f06483fd58da3e67e675 ]

This looks over-engineered. Let's use some helpers to get the buffer
length and hereby simplify the stmmac_rx() function. No performance drop
was seen with the new implementation.

Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: fa02de9e7588 ("net: stmmac: fix rx budget limit check")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 146 +++++++++++-------
 1 file changed, 94 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 6a3b0f76d9729..e521ab508f030 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3440,6 +3440,55 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
 	stmmac_set_rx_tail_ptr(priv, priv->ioaddr, rx_q->rx_tail_addr, queue);
 }
 
+static unsigned int stmmac_rx_buf1_len(struct stmmac_priv *priv,
+				       struct dma_desc *p,
+				       int status, unsigned int len)
+{
+	int ret, coe = priv->hw->rx_csum;
+	unsigned int plen = 0, hlen = 0;
+
+	/* Not first descriptor, buffer is always zero */
+	if (priv->sph && len)
+		return 0;
+
+	/* First descriptor, get split header length */
+	ret = stmmac_get_rx_header_len(priv, p, &hlen);
+	if (priv->sph && hlen) {
+		priv->xstats.rx_split_hdr_pkt_n++;
+		return hlen;
+	}
+
+	/* First descriptor, not last descriptor and not split header */
+	if (status & rx_not_ls)
+		return priv->dma_buf_sz;
+
+	plen = stmmac_get_rx_frame_len(priv, p, coe);
+
+	/* First descriptor and last descriptor and not split header */
+	return min_t(unsigned int, priv->dma_buf_sz, plen);
+}
+
+static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
+				       struct dma_desc *p,
+				       int status, unsigned int len)
+{
+	int coe = priv->hw->rx_csum;
+	unsigned int plen = 0;
+
+	/* Not split header, buffer is not available */
+	if (!priv->sph)
+		return 0;
+
+	/* Not last descriptor */
+	if (status & rx_not_ls)
+		return priv->dma_buf_sz;
+
+	plen = stmmac_get_rx_frame_len(priv, p, coe);
+
+	/* Last descriptor */
+	return plen - len;
+}
+
 /**
  * stmmac_rx - manage the receive process
  * @priv: driver private structure
@@ -3469,11 +3518,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		stmmac_display_ring(priv, rx_head, DMA_RX_SIZE, true);
 	}
 	while (count < limit) {
-		unsigned int hlen = 0, prev_len = 0;
+		unsigned int buf1_len = 0, buf2_len = 0;
 		enum pkt_hash_types hash_type;
 		struct stmmac_rx_buffer *buf;
 		struct dma_desc *np, *p;
-		unsigned int sec_len;
 		int entry;
 		u32 hash;
 
@@ -3492,7 +3540,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			break;
 
 read_again:
-		sec_len = 0;
+		buf1_len = 0;
+		buf2_len = 0;
 		entry = next_entry;
 		buf = &rx_q->buf_pool[entry];
 
@@ -3517,7 +3566,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			np = rx_q->dma_rx + next_entry;
 
 		prefetch(np);
-		prefetch(page_address(buf->page));
 
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->dev->stats,
@@ -3534,69 +3582,61 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			goto read_again;
 		if (unlikely(error)) {
 			dev_kfree_skb(skb);
+			skb = NULL;
 			count++;
 			continue;
 		}
 
 		/* Buffer is good. Go on. */
 
-		if (likely(status & rx_not_ls)) {
-			len += priv->dma_buf_sz;
-		} else {
-			prev_len = len;
-			len = stmmac_get_rx_frame_len(priv, p, coe);
-
-			/* ACS is set; GMAC core strips PAD/FCS for IEEE 802.3
-			 * Type frames (LLC/LLC-SNAP)
-			 *
-			 * llc_snap is never checked in GMAC >= 4, so this ACS
-			 * feature is always disabled and packets need to be
-			 * stripped manually.
-			 */
-			if (unlikely(priv->synopsys_id >= DWMAC_CORE_4_00) ||
-			    unlikely(status != llc_snap))
-				len -= ETH_FCS_LEN;
+		prefetch(page_address(buf->page));
+		if (buf->sec_page)
+			prefetch(page_address(buf->sec_page));
+
+		buf1_len = stmmac_rx_buf1_len(priv, p, status, len);
+		len += buf1_len;
+		buf2_len = stmmac_rx_buf2_len(priv, p, status, len);
+		len += buf2_len;
+
+		/* ACS is set; GMAC core strips PAD/FCS for IEEE 802.3
+		 * Type frames (LLC/LLC-SNAP)
+		 *
+		 * llc_snap is never checked in GMAC >= 4, so this ACS
+		 * feature is always disabled and packets need to be
+		 * stripped manually.
+		 */
+		if (unlikely(priv->synopsys_id >= DWMAC_CORE_4_00) ||
+		    unlikely(status != llc_snap)) {
+			if (buf2_len)
+				buf2_len -= ETH_FCS_LEN;
+			else
+				buf1_len -= ETH_FCS_LEN;
+
+			len -= ETH_FCS_LEN;
 		}
 
 		if (!skb) {
-			int ret = stmmac_get_rx_header_len(priv, p, &hlen);
-
-			if (priv->sph && !ret && (hlen > 0)) {
-				sec_len = len;
-				if (!(status & rx_not_ls))
-					sec_len = sec_len - hlen;
-				len = hlen;
-
-				prefetch(page_address(buf->sec_page));
-				priv->xstats.rx_split_hdr_pkt_n++;
-			}
-
-			skb = napi_alloc_skb(&ch->rx_napi, len);
+			skb = napi_alloc_skb(&ch->rx_napi, buf1_len);
 			if (!skb) {
 				priv->dev->stats.rx_dropped++;
 				count++;
-				continue;
+				goto drain_data;
 			}
 
-			dma_sync_single_for_cpu(priv->device, buf->addr, len,
-						DMA_FROM_DEVICE);
+			dma_sync_single_for_cpu(priv->device, buf->addr,
+						buf1_len, DMA_FROM_DEVICE);
 			skb_copy_to_linear_data(skb, page_address(buf->page),
-						len);
-			skb_put(skb, len);
+						buf1_len);
+			skb_put(skb, buf1_len);
 
 			/* Data payload copied into SKB, page ready for recycle */
 			page_pool_recycle_direct(rx_q->page_pool, buf->page);
 			buf->page = NULL;
-		} else {
-			unsigned int buf_len = len - prev_len;
-
-			if (likely(status & rx_not_ls))
-				buf_len = priv->dma_buf_sz;
-
+		} else if (buf1_len) {
 			dma_sync_single_for_cpu(priv->device, buf->addr,
-						buf_len, DMA_FROM_DEVICE);
+						buf1_len, DMA_FROM_DEVICE);
 			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
-					buf->page, 0, buf_len,
+					buf->page, 0, buf1_len,
 					priv->dma_buf_sz);
 
 			/* Data payload appended into SKB */
@@ -3604,22 +3644,23 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			buf->page = NULL;
 		}
 
-		if (sec_len > 0) {
+		if (buf2_len) {
 			dma_sync_single_for_cpu(priv->device, buf->sec_addr,
-						sec_len, DMA_FROM_DEVICE);
+						buf2_len, DMA_FROM_DEVICE);
 			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
-					buf->sec_page, 0, sec_len,
+					buf->sec_page, 0, buf2_len,
 					priv->dma_buf_sz);
 
-			len += sec_len;
-
 			/* Data payload appended into SKB */
 			page_pool_release_page(rx_q->page_pool, buf->sec_page);
 			buf->sec_page = NULL;
 		}
 
+drain_data:
 		if (likely(status & rx_not_ls))
 			goto read_again;
+		if (!skb)
+			continue;
 
 		/* Got entire packet into SKB. Finish it. */
 
@@ -3637,13 +3678,14 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		skb_record_rx_queue(skb, queue);
 		napi_gro_receive(&ch->rx_napi, skb);
+		skb = NULL;
 
 		priv->dev->stats.rx_packets++;
 		priv->dev->stats.rx_bytes += len;
 		count++;
 	}
 
-	if (status & rx_not_ls) {
+	if (status & rx_not_ls || skb) {
 		rx_q->state_saved = true;
 		rx_q->state.skb = skb;
 		rx_q->state.error = error;
-- 
2.42.0




