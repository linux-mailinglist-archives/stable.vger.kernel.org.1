Return-Path: <stable+bounces-39766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664938A54A3
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1B84B233A4
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF017E57F;
	Mon, 15 Apr 2024 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1dcO+PU3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF097580D;
	Mon, 15 Apr 2024 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191749; cv=none; b=mnzRgrfFii/TgsTj3BwsFyOuBfUENHlRGFhNudmPyM17enWcRcPwN/3g6qYc632uoZz/r1lpcHd+4q6DpYIAjw5v6yBJXY18TyLWazhEZUDMFnVyJ7f00MiFDOOvSq5tSGVf3gjq/bMxgecljD1P5IpgiwICIKjBW6yBsIhwOP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191749; c=relaxed/simple;
	bh=dXj/h+IxvrAB0MayVw/YAFD4d/f/o68hQz4bH2ROPs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNGImhdqrT6kNPHKl1b8Xl43GuzFFEdBPtQYOJiFqlGxj2to+0qsFPntLGQi3cICcgB0CqY4KdcHMIQjwfOOZgkDIJTEKb7LQRIn39AojbaZ0T/RFsqkro2jxBb3oqX1tmsQ7UnyqdDivBGPdpiclyVJlId1lUDGr7uBKJIL/vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1dcO+PU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C60AC113CC;
	Mon, 15 Apr 2024 14:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713191748;
	bh=dXj/h+IxvrAB0MayVw/YAFD4d/f/o68hQz4bH2ROPs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1dcO+PU3tFhTbGVjCj7MqfYch9+AtuHezTIJcy4bgcAPIWhowdjUfKCJ1L9fnWD8b
	 PjRGD7h14Oj3+aZGYdTa6s1pzOv6XYNMY1s7zWGlOZLtaEUrTKMN49GJqVUsXT0ZbE
	 6r7ilnMJ/5bJ3KVc+iqmhHAjTaIw7CfyZoCcWGvw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shay Agroskin <shayagr@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 072/122] net: ena: Pass ena_adapter instead of net_device to ena_xmit_common()
Date: Mon, 15 Apr 2024 16:20:37 +0200
Message-ID: <20240415141955.539236688@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415141953.365222063@linuxfoundation.org>
References: <20240415141953.365222063@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Arinzon <darinzon@amazon.com>

[ Upstream commit 39a044f4dcfee1c776603a6589b6fb98a9e222f2 ]

This change will enable the ability to use ena_xmit_common()
in functions that don't have a net_device pointer.
While it can be retrieved by dereferencing
ena_adapter (adapter->netdev), there's no reason to do it in
fast path code where this pointer is only needed for
debug prints.

Signed-off-by: Shay Agroskin <shayagr@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
Link: https://lore.kernel.org/r/20240101190855.18739-3-darinzon@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 36a1ca01f045 ("net: ena: Set tx_info->xdpf value to NULL")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 9 ++++-----
 drivers/net/ethernet/amazon/ena/ena_netdev.h | 2 +-
 drivers/net/ethernet/amazon/ena/ena_xdp.c    | 6 +++---
 drivers/net/ethernet/amazon/ena/ena_xdp.h    | 4 ++--
 4 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 1e74386829c42..8868494929c78 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -88,19 +88,18 @@ static int ena_change_mtu(struct net_device *dev, int new_mtu)
 	return ret;
 }
 
-int ena_xmit_common(struct net_device *dev,
+int ena_xmit_common(struct ena_adapter *adapter,
 		    struct ena_ring *ring,
 		    struct ena_tx_buffer *tx_info,
 		    struct ena_com_tx_ctx *ena_tx_ctx,
 		    u16 next_to_use,
 		    u32 bytes)
 {
-	struct ena_adapter *adapter = netdev_priv(dev);
 	int rc, nb_hw_desc;
 
 	if (unlikely(ena_com_is_doorbell_needed(ring->ena_com_io_sq,
 						ena_tx_ctx))) {
-		netif_dbg(adapter, tx_queued, dev,
+		netif_dbg(adapter, tx_queued, adapter->netdev,
 			  "llq tx max burst size of queue %d achieved, writing doorbell to send burst\n",
 			  ring->qid);
 		ena_ring_tx_doorbell(ring);
@@ -115,7 +114,7 @@ int ena_xmit_common(struct net_device *dev,
 	 * ena_com_prepare_tx() are fatal and therefore require a device reset.
 	 */
 	if (unlikely(rc)) {
-		netif_err(adapter, tx_queued, dev,
+		netif_err(adapter, tx_queued, adapter->netdev,
 			  "Failed to prepare tx bufs\n");
 		ena_increase_stat(&ring->tx_stats.prepare_ctx_err, 1,
 				  &ring->syncp);
@@ -2607,7 +2606,7 @@ static netdev_tx_t ena_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	/* set flags and meta data */
 	ena_tx_csum(&ena_tx_ctx, skb, tx_ring->disable_meta_caching);
 
-	rc = ena_xmit_common(dev,
+	rc = ena_xmit_common(adapter,
 			     tx_ring,
 			     tx_info,
 			     &ena_tx_ctx,
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.h b/drivers/net/ethernet/amazon/ena/ena_netdev.h
index 041f08d20b450..236d1f859a783 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
@@ -426,7 +426,7 @@ static inline void ena_ring_tx_doorbell(struct ena_ring *tx_ring)
 	ena_increase_stat(&tx_ring->tx_stats.doorbells, 1, &tx_ring->syncp);
 }
 
-int ena_xmit_common(struct net_device *dev,
+int ena_xmit_common(struct ena_adapter *adapter,
 		    struct ena_ring *ring,
 		    struct ena_tx_buffer *tx_info,
 		    struct ena_com_tx_ctx *ena_tx_ctx,
diff --git a/drivers/net/ethernet/amazon/ena/ena_xdp.c b/drivers/net/ethernet/amazon/ena/ena_xdp.c
index d0c8a2dc9a676..42370fa027733 100644
--- a/drivers/net/ethernet/amazon/ena/ena_xdp.c
+++ b/drivers/net/ethernet/amazon/ena/ena_xdp.c
@@ -73,7 +73,7 @@ static int ena_xdp_tx_map_frame(struct ena_ring *xdp_ring,
 }
 
 int ena_xdp_xmit_frame(struct ena_ring *xdp_ring,
-		       struct net_device *dev,
+		       struct ena_adapter *adapter,
 		       struct xdp_frame *xdpf,
 		       int flags)
 {
@@ -93,7 +93,7 @@ int ena_xdp_xmit_frame(struct ena_ring *xdp_ring,
 
 	ena_tx_ctx.req_id = req_id;
 
-	rc = ena_xmit_common(dev,
+	rc = ena_xmit_common(adapter,
 			     xdp_ring,
 			     tx_info,
 			     &ena_tx_ctx,
@@ -141,7 +141,7 @@ int ena_xdp_xmit(struct net_device *dev, int n,
 	spin_lock(&xdp_ring->xdp_tx_lock);
 
 	for (i = 0; i < n; i++) {
-		if (ena_xdp_xmit_frame(xdp_ring, dev, frames[i], 0))
+		if (ena_xdp_xmit_frame(xdp_ring, adapter, frames[i], 0))
 			break;
 		nxmit++;
 	}
diff --git a/drivers/net/ethernet/amazon/ena/ena_xdp.h b/drivers/net/ethernet/amazon/ena/ena_xdp.h
index 80c7496081088..6e472ba6ce1ba 100644
--- a/drivers/net/ethernet/amazon/ena/ena_xdp.h
+++ b/drivers/net/ethernet/amazon/ena/ena_xdp.h
@@ -36,7 +36,7 @@ void ena_xdp_exchange_program_rx_in_range(struct ena_adapter *adapter,
 					  int first, int count);
 int ena_xdp_io_poll(struct napi_struct *napi, int budget);
 int ena_xdp_xmit_frame(struct ena_ring *xdp_ring,
-		       struct net_device *dev,
+		       struct ena_adapter *adapter,
 		       struct xdp_frame *xdpf,
 		       int flags);
 int ena_xdp_xmit(struct net_device *dev, int n,
@@ -108,7 +108,7 @@ static inline int ena_xdp_execute(struct ena_ring *rx_ring, struct xdp_buff *xdp
 		/* The XDP queues are shared between XDP_TX and XDP_REDIRECT */
 		spin_lock(&xdp_ring->xdp_tx_lock);
 
-		if (ena_xdp_xmit_frame(xdp_ring, rx_ring->netdev, xdpf,
+		if (ena_xdp_xmit_frame(xdp_ring, rx_ring->adapter, xdpf,
 				       XDP_XMIT_FLUSH))
 			xdp_return_frame(xdpf);
 
-- 
2.43.0




