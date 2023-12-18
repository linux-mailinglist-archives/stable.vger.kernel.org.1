Return-Path: <stable+bounces-7198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A497481715F
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB5711C23FE6
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41C61D126;
	Mon, 18 Dec 2023 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y3klO7Nd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA53129EF7;
	Mon, 18 Dec 2023 13:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F30C433C8;
	Mon, 18 Dec 2023 13:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702907826;
	bh=pQzU8pyGHu0Qv4CIe4v/kgIFsNn0uyHGF1IXApoz+Vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y3klO7NdUMX31HwgFmyeNiaRhpiOUg7uqFA9E5BruHM8f0FAV2WfK3VHrzZv18hay
	 tSrShVM4X8IAivbfZ3D7KVyYaSo7WWII2/iYLGk3ziYz5HuwFCygrklVMThB+yTGWf
	 obrD3MbttgwSKSq/7tdrRJsES54+BS9dM5r/ojn4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 033/106] net: ena: Fix xdp drops handling due to multibuf packets
Date: Mon, 18 Dec 2023 14:50:47 +0100
Message-ID: <20231218135056.450506129@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135055.005497074@linuxfoundation.org>
References: <20231218135055.005497074@linuxfoundation.org>
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

From: David Arinzon <darinzon@amazon.com>

[ Upstream commit 505b1a88d311ff6f8c44a34f94e3be21745cce6f ]

Current xdp code drops packets larger than ENA_XDP_MAX_MTU.
This is an incorrect condition since the problem is not the
size of the packet, rather the number of buffers it contains.

This commit:

1. Identifies and drops XDP multi-buffer packets at the
   beginning of the function.
2. Increases the xdp drop statistic when this drop occurs.
3. Adds a one-time print that such drops are happening to
   give better indication to the user.

Fixes: 838c93dc5449 ("net: ena: implement XDP drop support")
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
Link: https://lore.kernel.org/r/20231211062801.27891-3-darinzon@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index d7392dabde1e3..044b8afde69a0 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1618,20 +1618,23 @@ static void ena_set_rx_hash(struct ena_ring *rx_ring,
 	}
 }
 
-static int ena_xdp_handle_buff(struct ena_ring *rx_ring, struct xdp_buff *xdp)
+static int ena_xdp_handle_buff(struct ena_ring *rx_ring, struct xdp_buff *xdp, u16 num_descs)
 {
 	struct ena_rx_buffer *rx_info;
 	int ret;
 
+	/* XDP multi-buffer packets not supported */
+	if (unlikely(num_descs > 1)) {
+		netdev_err_once(rx_ring->adapter->netdev,
+				"xdp: dropped unsupported multi-buffer packets\n");
+		ena_increase_stat(&rx_ring->rx_stats.xdp_drop, 1, &rx_ring->syncp);
+		return ENA_XDP_DROP;
+	}
+
 	rx_info = &rx_ring->rx_buffer_info[rx_ring->ena_bufs[0].req_id];
 	xdp_prepare_buff(xdp, page_address(rx_info->page),
 			 rx_info->page_offset,
 			 rx_ring->ena_bufs[0].len, false);
-	/* If for some reason we received a bigger packet than
-	 * we expect, then we simply drop it
-	 */
-	if (unlikely(rx_ring->ena_bufs[0].len > ENA_XDP_MAX_MTU))
-		return ENA_XDP_DROP;
 
 	ret = ena_xdp_execute(rx_ring, xdp);
 
@@ -1700,7 +1703,7 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 			  ena_rx_ctx.l4_proto, ena_rx_ctx.hash);
 
 		if (ena_xdp_present_ring(rx_ring))
-			xdp_verdict = ena_xdp_handle_buff(rx_ring, &xdp);
+			xdp_verdict = ena_xdp_handle_buff(rx_ring, &xdp, ena_rx_ctx.descs);
 
 		/* allocate skb and fill it */
 		if (xdp_verdict == ENA_XDP_PASS)
-- 
2.43.0




