Return-Path: <stable+bounces-107298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6404CA02B2B
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9428F7A1F83
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312B71DDA2D;
	Mon,  6 Jan 2025 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zfL8BK0O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03061DD874;
	Mon,  6 Jan 2025 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178046; cv=none; b=h+VwA0ea83a169HGD6CHSk6mYY1LVg2jaVOACmFlvq55PcOfnYzys6wZjlurDD0MsSjsnkXxpG+12iBnQ9JrMPGWzAnaFr41lO7w6/C165q1EJZDVJBotOEFQ6PlxoM9fzBfNKSKbpAKQAIwru417EdPJdW5CGmkBIOGzzHadTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178046; c=relaxed/simple;
	bh=z9voKzu9woem0Bh6EGCEoS0vsiDnKzboS4CDdIxu9Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7y3MqxeANKWcVl7MUgsfchNnI3UA1hjQYI7FDiAB+P6lE2hDxNOesSxUCp43XtMneq+FtNGjLDl6MrapjbuyhhsXHNephQZb0ZTYV6R7FpqZrMPWlL6yfxKiVjMh3XRBGex7926G6ANhoZh3rI1f9FCgnPCTs6xySLPFWYmayE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zfL8BK0O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDD5C4CEDF;
	Mon,  6 Jan 2025 15:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736178045;
	bh=z9voKzu9woem0Bh6EGCEoS0vsiDnKzboS4CDdIxu9Ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zfL8BK0OUPffVSmz1tHrI4e9vp6MQiovOkCRfWzFwrqTozpq2HphHmpvyHIsgcyf0
	 gA+rabtcXaefIlKLO7GhhWaeh0xUWnu810tEwSVy70iWL2Q5mUOegVrkgp04hspHbI
	 r6woFLDkDRJpKzoeD1x1L5NfPVOLWPGvnmG9xLBs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Joshua Washington <joshwash@google.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.12 143/156] gve: process XSK TX descriptors as part of RX NAPI
Date: Mon,  6 Jan 2025 16:17:09 +0100
Message-ID: <20250106151147.114670497@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151141.738050441@linuxfoundation.org>
References: <20250106151141.738050441@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joshua Washington <joshwash@google.com>

commit ba0925c34e0fa6fe02d3d642bc02ab099ab312c7 upstream.

When busy polling is enabled, xsk_sendmsg for AF_XDP zero copy marks
the NAPI ID corresponding to the memory pool allocated for the socket.
In GVE, this NAPI ID will never correspond to a NAPI ID of one of the
dedicated XDP TX queues registered with the umem because XDP TX is not
set up to share a NAPI with a corresponding RX queue.

This patch moves XSK TX descriptor processing from the TX NAPI to the RX
NAPI, and the gve_xsk_wakeup callback is updated to use the RX NAPI
instead of the TX NAPI, accordingly. The branch on if the wakeup is for
TX is removed, as the NAPI poll should be invoked whether the wakeup is
for TX or for RX.

Fixes: fd8e40321a12 ("gve: Add AF_XDP zero-copy support for GQI-QPL format")
Cc: stable@vger.kernel.org
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/google/gve/gve.h      |    1 
 drivers/net/ethernet/google/gve/gve_main.c |    8 ++++++
 drivers/net/ethernet/google/gve/gve_tx.c   |   36 +++++++++++++++++------------
 3 files changed, 31 insertions(+), 14 deletions(-)

--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -1134,6 +1134,7 @@ int gve_xdp_xmit_one(struct gve_priv *pr
 void gve_xdp_tx_flush(struct gve_priv *priv, u32 xdp_qid);
 bool gve_tx_poll(struct gve_notify_block *block, int budget);
 bool gve_xdp_poll(struct gve_notify_block *block, int budget);
+int gve_xsk_tx_poll(struct gve_notify_block *block, int budget);
 int gve_tx_alloc_rings_gqi(struct gve_priv *priv,
 			   struct gve_tx_alloc_rings_cfg *cfg);
 void gve_tx_free_rings_gqi(struct gve_priv *priv,
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -333,6 +333,14 @@ int gve_napi_poll(struct napi_struct *na
 
 	if (block->rx) {
 		work_done = gve_rx_poll(block, budget);
+
+		/* Poll XSK TX as part of RX NAPI. Setup re-poll based on max of
+		 * TX and RX work done.
+		 */
+		if (priv->xdp_prog)
+			work_done = max_t(int, work_done,
+					  gve_xsk_tx_poll(block, budget));
+
 		reschedule |= work_done == budget;
 	}
 
--- a/drivers/net/ethernet/google/gve/gve_tx.c
+++ b/drivers/net/ethernet/google/gve/gve_tx.c
@@ -975,33 +975,41 @@ out:
 	return sent;
 }
 
+int gve_xsk_tx_poll(struct gve_notify_block *rx_block, int budget)
+{
+	struct gve_rx_ring *rx = rx_block->rx;
+	struct gve_priv *priv = rx->gve;
+	struct gve_tx_ring *tx;
+	int sent = 0;
+
+	tx = &priv->tx[gve_xdp_tx_queue_id(priv, rx->q_num)];
+	if (tx->xsk_pool) {
+		sent = gve_xsk_tx(priv, tx, budget);
+
+		u64_stats_update_begin(&tx->statss);
+		tx->xdp_xsk_sent += sent;
+		u64_stats_update_end(&tx->statss);
+		if (xsk_uses_need_wakeup(tx->xsk_pool))
+			xsk_set_tx_need_wakeup(tx->xsk_pool);
+	}
+
+	return sent;
+}
+
 bool gve_xdp_poll(struct gve_notify_block *block, int budget)
 {
 	struct gve_priv *priv = block->priv;
 	struct gve_tx_ring *tx = block->tx;
 	u32 nic_done;
-	bool repoll;
 	u32 to_do;
 
 	/* Find out how much work there is to be done */
 	nic_done = gve_tx_load_event_counter(priv, tx);
 	to_do = min_t(u32, (nic_done - tx->done), budget);
 	gve_clean_xdp_done(priv, tx, to_do);
-	repoll = nic_done != tx->done;
-
-	if (tx->xsk_pool) {
-		int sent = gve_xsk_tx(priv, tx, budget);
-
-		u64_stats_update_begin(&tx->statss);
-		tx->xdp_xsk_sent += sent;
-		u64_stats_update_end(&tx->statss);
-		repoll |= (sent == budget);
-		if (xsk_uses_need_wakeup(tx->xsk_pool))
-			xsk_set_tx_need_wakeup(tx->xsk_pool);
-	}
 
 	/* If we still have work we want to repoll */
-	return repoll;
+	return nic_done != tx->done;
 }
 
 bool gve_tx_poll(struct gve_notify_block *block, int budget)



