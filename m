Return-Path: <stable+bounces-57800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B64CD925E12
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA88F1C212B9
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7C517A5AE;
	Wed,  3 Jul 2024 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o/eezbdp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00991DFC7;
	Wed,  3 Jul 2024 11:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005971; cv=none; b=BeZ8zjGvTB9S4MeM7PwBYPyvxsPRAdMH3BfiVABvlN7pMdDJity66/1KVr2dxwvUGskG2J/J+0zPRnPGobD0IGrMMxsvvlFU8bxLzAGuboxRybPki3bgkJzHSkpHwPQ78BlWOgDCzwhREZa65IuXtdPazGwxuENZ+6FkAbtPVQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005971; c=relaxed/simple;
	bh=0YvttD5FnRMJtw8nd+ktlL3m0nOBqA7B4EfTSyeHPtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WheoyyDZetP5Z0Y1WY8Fq4JePzBEA4oHC/Bpn0SNJEF6fDZzwEGYTQEjeKt1r923nJsN2c+s71+PosJO2JSXjXw9jZcV/RgJnq1VwIVLFl7lqoK1IAmaLUstPL+0M1cVmH+Czi2J2JC5xb9eQk2dgSIvyBgBAXAwkBPgmw5WqY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o/eezbdp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318D9C2BD10;
	Wed,  3 Jul 2024 11:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720005971;
	bh=0YvttD5FnRMJtw8nd+ktlL3m0nOBqA7B4EfTSyeHPtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o/eezbdpcBbnCsFX05M5Za6AWvvjtFqe7S8+Uyc2Szr68T3/n4XNLr4PejMZ16F0S
	 G+AtqYyUCdoHvHmIPBNwO06M/tytL+U0ItcWXp7c6Q5n6O5loRLjxa9DIqjKBJWu99
	 3sqSq2+qgAJhCf2Y2JAmJP7SUV+7zzkoindsJ2Wo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Awogbemila <awogbemila@google.com>,
	Jeroen de Borst <jeroendb@google.com>,
	Catherine Sullivan <csully@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 258/356] gve: Add RX context.
Date: Wed,  3 Jul 2024 12:39:54 +0200
Message-ID: <20240703102922.877688235@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102913.093882413@linuxfoundation.org>
References: <20240703102913.093882413@linuxfoundation.org>
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

From: David Awogbemila <awogbemila@google.com>

[ Upstream commit 1344e751e91092ac0cb63b194621e59d2f364197 ]

This refactor moves the skb_head and skb_tail fields into a new
gve_rx_ctx struct. This new struct will contain information about the
current packet being processed. This is in preparation for
multi-descriptor RX packets.

Signed-off-by: David Awogbemila <awogbemila@google.com>
Signed-off-by: Jeroen de Borst <jeroendb@google.com>
Reviewed-by: Catherine Sullivan <csully@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 6f4d93b78ade ("gve: Clear napi->skb before dev_kfree_skb_any()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/google/gve/gve.h        | 13 +++-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 68 ++++++++++----------
 2 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 08f4c0595efae..822bdaff66f69 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -144,6 +144,15 @@ struct gve_index_list {
 	s16 tail;
 };
 
+/* A single received packet split across multiple buffers may be
+ * reconstructed using the information in this structure.
+ */
+struct gve_rx_ctx {
+	/* head and tail of skb chain for the current packet or NULL if none */
+	struct sk_buff *skb_head;
+	struct sk_buff *skb_tail;
+};
+
 /* Contains datapath state used to represent an RX queue. */
 struct gve_rx_ring {
 	struct gve_priv *gve;
@@ -208,9 +217,7 @@ struct gve_rx_ring {
 	dma_addr_t q_resources_bus; /* dma address for the queue resources */
 	struct u64_stats_sync statss; /* sync stats for 32bit archs */
 
-	/* head and tail of skb chain for the current packet or NULL if none */
-	struct sk_buff *skb_head;
-	struct sk_buff *skb_tail;
+	struct gve_rx_ctx ctx; /* Info for packet currently being processed in this ring. */
 };
 
 /* A TX desc ring entry */
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index d947c2c334128..630f42a3037b0 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -240,8 +240,8 @@ static int gve_rx_alloc_ring_dqo(struct gve_priv *priv, int idx)
 	rx->dqo.bufq.mask = buffer_queue_slots - 1;
 	rx->dqo.complq.num_free_slots = completion_queue_slots;
 	rx->dqo.complq.mask = completion_queue_slots - 1;
-	rx->skb_head = NULL;
-	rx->skb_tail = NULL;
+	rx->ctx.skb_head = NULL;
+	rx->ctx.skb_tail = NULL;
 
 	rx->dqo.num_buf_states = min_t(s16, S16_MAX, buffer_queue_slots * 4);
 	rx->dqo.buf_states = kvcalloc(rx->dqo.num_buf_states,
@@ -467,12 +467,12 @@ static void gve_rx_skb_hash(struct sk_buff *skb,
 
 static void gve_rx_free_skb(struct gve_rx_ring *rx)
 {
-	if (!rx->skb_head)
+	if (!rx->ctx.skb_head)
 		return;
 
-	dev_kfree_skb_any(rx->skb_head);
-	rx->skb_head = NULL;
-	rx->skb_tail = NULL;
+	dev_kfree_skb_any(rx->ctx.skb_head);
+	rx->ctx.skb_head = NULL;
+	rx->ctx.skb_tail = NULL;
 }
 
 /* Chains multi skbs for single rx packet.
@@ -483,7 +483,7 @@ static int gve_rx_append_frags(struct napi_struct *napi,
 			       u16 buf_len, struct gve_rx_ring *rx,
 			       struct gve_priv *priv)
 {
-	int num_frags = skb_shinfo(rx->skb_tail)->nr_frags;
+	int num_frags = skb_shinfo(rx->ctx.skb_tail)->nr_frags;
 
 	if (unlikely(num_frags == MAX_SKB_FRAGS)) {
 		struct sk_buff *skb;
@@ -492,17 +492,17 @@ static int gve_rx_append_frags(struct napi_struct *napi,
 		if (!skb)
 			return -1;
 
-		skb_shinfo(rx->skb_tail)->frag_list = skb;
-		rx->skb_tail = skb;
+		skb_shinfo(rx->ctx.skb_tail)->frag_list = skb;
+		rx->ctx.skb_tail = skb;
 		num_frags = 0;
 	}
-	if (rx->skb_tail != rx->skb_head) {
-		rx->skb_head->len += buf_len;
-		rx->skb_head->data_len += buf_len;
-		rx->skb_head->truesize += priv->data_buffer_size_dqo;
+	if (rx->ctx.skb_tail != rx->ctx.skb_head) {
+		rx->ctx.skb_head->len += buf_len;
+		rx->ctx.skb_head->data_len += buf_len;
+		rx->ctx.skb_head->truesize += priv->data_buffer_size_dqo;
 	}
 
-	skb_add_rx_frag(rx->skb_tail, num_frags,
+	skb_add_rx_frag(rx->ctx.skb_tail, num_frags,
 			buf_state->page_info.page,
 			buf_state->page_info.page_offset,
 			buf_len, priv->data_buffer_size_dqo);
@@ -556,7 +556,7 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 				      buf_len, DMA_FROM_DEVICE);
 
 	/* Append to current skb if one exists. */
-	if (rx->skb_head) {
+	if (rx->ctx.skb_head) {
 		if (unlikely(gve_rx_append_frags(napi, buf_state, buf_len, rx,
 						 priv)) != 0) {
 			goto error;
@@ -567,11 +567,11 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 	}
 
 	if (eop && buf_len <= priv->rx_copybreak) {
-		rx->skb_head = gve_rx_copy(priv->dev, napi,
-					   &buf_state->page_info, buf_len, 0);
-		if (unlikely(!rx->skb_head))
+		rx->ctx.skb_head = gve_rx_copy(priv->dev, napi,
+					       &buf_state->page_info, buf_len, 0);
+		if (unlikely(!rx->ctx.skb_head))
 			goto error;
-		rx->skb_tail = rx->skb_head;
+		rx->ctx.skb_tail = rx->ctx.skb_head;
 
 		u64_stats_update_begin(&rx->statss);
 		rx->rx_copied_pkt++;
@@ -583,12 +583,12 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 		return 0;
 	}
 
-	rx->skb_head = napi_get_frags(napi);
-	if (unlikely(!rx->skb_head))
+	rx->ctx.skb_head = napi_get_frags(napi);
+	if (unlikely(!rx->ctx.skb_head))
 		goto error;
-	rx->skb_tail = rx->skb_head;
+	rx->ctx.skb_tail = rx->ctx.skb_head;
 
-	skb_add_rx_frag(rx->skb_head, 0, buf_state->page_info.page,
+	skb_add_rx_frag(rx->ctx.skb_head, 0, buf_state->page_info.page,
 			buf_state->page_info.page_offset, buf_len,
 			priv->data_buffer_size_dqo);
 	gve_dec_pagecnt_bias(&buf_state->page_info);
@@ -635,27 +635,27 @@ static int gve_rx_complete_skb(struct gve_rx_ring *rx, struct napi_struct *napi,
 		rx->gve->ptype_lut_dqo->ptypes[desc->packet_type];
 	int err;
 
-	skb_record_rx_queue(rx->skb_head, rx->q_num);
+	skb_record_rx_queue(rx->ctx.skb_head, rx->q_num);
 
 	if (feat & NETIF_F_RXHASH)
-		gve_rx_skb_hash(rx->skb_head, desc, ptype);
+		gve_rx_skb_hash(rx->ctx.skb_head, desc, ptype);
 
 	if (feat & NETIF_F_RXCSUM)
-		gve_rx_skb_csum(rx->skb_head, desc, ptype);
+		gve_rx_skb_csum(rx->ctx.skb_head, desc, ptype);
 
 	/* RSC packets must set gso_size otherwise the TCP stack will complain
 	 * that packets are larger than MTU.
 	 */
 	if (desc->rsc) {
-		err = gve_rx_complete_rsc(rx->skb_head, desc, ptype);
+		err = gve_rx_complete_rsc(rx->ctx.skb_head, desc, ptype);
 		if (err < 0)
 			return err;
 	}
 
-	if (skb_headlen(rx->skb_head) == 0)
+	if (skb_headlen(rx->ctx.skb_head) == 0)
 		napi_gro_frags(napi);
 	else
-		napi_gro_receive(napi, rx->skb_head);
+		napi_gro_receive(napi, rx->ctx.skb_head);
 
 	return 0;
 }
@@ -717,18 +717,18 @@ int gve_rx_poll_dqo(struct gve_notify_block *block, int budget)
 		/* Free running counter of completed descriptors */
 		rx->cnt++;
 
-		if (!rx->skb_head)
+		if (!rx->ctx.skb_head)
 			continue;
 
 		if (!compl_desc->end_of_packet)
 			continue;
 
 		work_done++;
-		pkt_bytes = rx->skb_head->len;
+		pkt_bytes = rx->ctx.skb_head->len;
 		/* The ethernet header (first ETH_HLEN bytes) is snipped off
 		 * by eth_type_trans.
 		 */
-		if (skb_headlen(rx->skb_head))
+		if (skb_headlen(rx->ctx.skb_head))
 			pkt_bytes += ETH_HLEN;
 
 		/* gve_rx_complete_skb() will consume skb if successful */
@@ -741,8 +741,8 @@ int gve_rx_poll_dqo(struct gve_notify_block *block, int budget)
 		}
 
 		bytes += pkt_bytes;
-		rx->skb_head = NULL;
-		rx->skb_tail = NULL;
+		rx->ctx.skb_head = NULL;
+		rx->ctx.skb_tail = NULL;
 	}
 
 	gve_rx_post_buffers_dqo(rx);
-- 
2.43.0




