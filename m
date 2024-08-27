Return-Path: <stable+bounces-71264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2BC961299
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88D92832F1
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A35C1CF2BA;
	Tue, 27 Aug 2024 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K7Kb9jYJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078A61CF298;
	Tue, 27 Aug 2024 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772638; cv=none; b=FItcEPbSkKowVRsbeUWpPed6Ncl+BlbPLTEUTtmoUZ8UV0kuU11flXwhhddVyM5WALkY31gvI1PR5+s02UjqxFG/GCXTwmA4OQWfYsQthW0mbOWaI67xJzENBfkMHe5EC339WEAn9jbNXyvGqp5KIy414i+uTxzLWlVTbCUNfAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772638; c=relaxed/simple;
	bh=9xYuzmqMbenzy0wQJmGbDia3mFcCP0oPwcSWz/XbhSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMW5XzpcBVoKKbGBcvOOlVct86hH++G2gOgQiRe43L4uxkd/3Ye7boN8fsn3N2lCjDNtnhHHGPKdJbm9nUpCzrKcDFMMYIExQ9mB2TtFku8P6FjK6HhJ9PzixDwFInv60oNRN/qMqm8UlpzdI9lK62W1TW1dZvYv+1ZPMZNNqmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K7Kb9jYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837A3C4AF68;
	Tue, 27 Aug 2024 15:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724772637;
	bh=9xYuzmqMbenzy0wQJmGbDia3mFcCP0oPwcSWz/XbhSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K7Kb9jYJ6p6yRTK0Sd1psuC+VQkudkyEKE45XmzuLLXhuoD2uGSAEdgDwdxPayCPJ
	 89rQYPdtungBCDo2KWl4TvyczgX6lzjrnb1KsfgFRJjTg9SROfR6WiSgwfnRIcXhwe
	 NzJ1SVsxtLMMS+tewifMKtZxpE8FYig+HD9sMEF4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 243/321] ice: Add xdp_buff to ice_rx_ring struct
Date: Tue, 27 Aug 2024 16:39:11 +0200
Message-ID: <20240827143847.491519402@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

[ Upstream commit cb0473e0e9dccaa0ddafb252f2c3ef943b86bb56 ]

In preparation for XDP multi-buffer support, let's store xdp_buff on
Rx ring struct. This will allow us to combine fragmented frames across
separate NAPI cycles in the same way as currently skb fragments are
handled. This means that skb pointer on Rx ring will become redundant
and will be removed. For now it is kept and layout of Rx ring struct was
not inspected, some member movement will be needed later on so that will
be the time to take care of it.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Alexander Lobakin <alexandr.lobakin@intel.com>
Link: https://lore.kernel.org/bpf/20230131204506.219292-3-maciej.fijalkowski@intel.com
Stable-dep-of: 50b2143356e8 ("ice: fix page reuse when PAGE_SIZE is over 8k")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_base.c |  1 +
 drivers/net/ethernet/intel/ice/ice_txrx.c | 39 +++++++++++++----------
 drivers/net/ethernet/intel/ice/ice_txrx.h |  1 +
 3 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index c7c6f01538e0d..4db4ec4b8857a 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -534,6 +534,7 @@ int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 		}
 	}
 
+	xdp_init_buff(&ring->xdp, ice_rx_pg_size(ring) / 2, &ring->xdp_rxq);
 	err = ice_setup_rx_ctx(ring);
 	if (err) {
 		dev_err(dev, "ice_setup_rx_ctx failed for RxQ %d, err %d\n",
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 2db20263420d8..d3411170f3eaf 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -523,8 +523,16 @@ int ice_setup_rx_ring(struct ice_rx_ring *rx_ring)
 	return -ENOMEM;
 }
 
+/**
+ * ice_rx_frame_truesize
+ * @rx_ring: ptr to Rx ring
+ * @size: size
+ *
+ * calculate the truesize with taking into the account PAGE_SIZE of
+ * underlying arch
+ */
 static unsigned int
-ice_rx_frame_truesize(struct ice_rx_ring *rx_ring, unsigned int __maybe_unused size)
+ice_rx_frame_truesize(struct ice_rx_ring *rx_ring, const unsigned int size)
 {
 	unsigned int truesize;
 
@@ -1103,21 +1111,20 @@ ice_is_non_eop(struct ice_rx_ring *rx_ring, union ice_32b_rx_flex_desc *rx_desc)
  */
 int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 {
-	unsigned int total_rx_bytes = 0, total_rx_pkts = 0, frame_sz = 0;
+	unsigned int total_rx_bytes = 0, total_rx_pkts = 0;
 	u16 cleaned_count = ICE_DESC_UNUSED(rx_ring);
 	unsigned int offset = rx_ring->rx_offset;
+	struct xdp_buff *xdp = &rx_ring->xdp;
 	struct ice_tx_ring *xdp_ring = NULL;
 	unsigned int xdp_res, xdp_xmit = 0;
 	struct sk_buff *skb = rx_ring->skb;
 	struct bpf_prog *xdp_prog = NULL;
-	struct xdp_buff xdp;
 	bool failure;
 
 	/* Frame size depend on rx_ring setup when PAGE_SIZE=4K */
 #if (PAGE_SIZE < 8192)
-	frame_sz = ice_rx_frame_truesize(rx_ring, 0);
+	xdp->frame_sz = ice_rx_frame_truesize(rx_ring, 0);
 #endif
-	xdp_init_buff(&xdp, frame_sz, &rx_ring->xdp_rxq);
 
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 	if (xdp_prog)
@@ -1171,30 +1178,30 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		rx_buf = ice_get_rx_buf(rx_ring, size, &rx_buf_pgcnt);
 
 		if (!size) {
-			xdp.data = NULL;
-			xdp.data_end = NULL;
-			xdp.data_hard_start = NULL;
-			xdp.data_meta = NULL;
+			xdp->data = NULL;
+			xdp->data_end = NULL;
+			xdp->data_hard_start = NULL;
+			xdp->data_meta = NULL;
 			goto construct_skb;
 		}
 
 		hard_start = page_address(rx_buf->page) + rx_buf->page_offset -
 			     offset;
-		xdp_prepare_buff(&xdp, hard_start, offset, size, !!offset);
+		xdp_prepare_buff(xdp, hard_start, offset, size, !!offset);
 #if (PAGE_SIZE > 4096)
 		/* At larger PAGE_SIZE, frame_sz depend on len size */
-		xdp.frame_sz = ice_rx_frame_truesize(rx_ring, size);
+		xdp->frame_sz = ice_rx_frame_truesize(rx_ring, size);
 #endif
 
 		if (!xdp_prog)
 			goto construct_skb;
 
-		xdp_res = ice_run_xdp(rx_ring, &xdp, xdp_prog, xdp_ring);
+		xdp_res = ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring);
 		if (!xdp_res)
 			goto construct_skb;
 		if (xdp_res & (ICE_XDP_TX | ICE_XDP_REDIR)) {
 			xdp_xmit |= xdp_res;
-			ice_rx_buf_adjust_pg_offset(rx_buf, xdp.frame_sz);
+			ice_rx_buf_adjust_pg_offset(rx_buf, xdp->frame_sz);
 		} else {
 			rx_buf->pagecnt_bias++;
 		}
@@ -1207,11 +1214,11 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 construct_skb:
 		if (skb) {
 			ice_add_rx_frag(rx_ring, rx_buf, skb, size);
-		} else if (likely(xdp.data)) {
+		} else if (likely(xdp->data)) {
 			if (ice_ring_uses_build_skb(rx_ring))
-				skb = ice_build_skb(rx_ring, rx_buf, &xdp);
+				skb = ice_build_skb(rx_ring, rx_buf, xdp);
 			else
-				skb = ice_construct_skb(rx_ring, rx_buf, &xdp);
+				skb = ice_construct_skb(rx_ring, rx_buf, xdp);
 		}
 		/* exit if we failed to retrieve a buffer */
 		if (!skb) {
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index bfbe4b16df96a..ef8245f795c5b 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -295,6 +295,7 @@ struct ice_rx_ring {
 	struct bpf_prog *xdp_prog;
 	struct ice_tx_ring *xdp_ring;
 	struct xsk_buff_pool *xsk_pool;
+	struct xdp_buff xdp;
 	struct sk_buff *skb;
 	dma_addr_t dma;			/* physical address of ring */
 	u64 cached_phctime;
-- 
2.43.0




