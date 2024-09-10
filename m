Return-Path: <stable+bounces-74257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C75AC972E52
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47E971F25C42
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EA518CC16;
	Tue, 10 Sep 2024 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J8anwwbV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6567D18C005;
	Tue, 10 Sep 2024 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961276; cv=none; b=DjpotWQrgsOv7sUXDJ1qQxko4aOKfgdsyNJz322kwuqkzQlcEhw4FWRlYmT3AFYsUJ4KlxwJfrUqqKW3IwD/zM55IkB4WtgkB8QhbRBLBY76n/xE9F5k1sQp1+XzIEsqS5IsMXvgpTBe1YajQX8GEKupGBLuNgDQl1Po6M3gYgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961276; c=relaxed/simple;
	bh=/jdKoRsvF/HP2mATDTjXJlnFsWOvakkiOiBx5zqwtaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qmbn56X/aZOVL9u0sFOaakX30dKAt3z2LhQMgy+3SzQXfOz/yupwoS9wq23L7qPySOssFf28yTh4Bk0//HLPENDKiiBps5kSvi/hjYj+u+6KyXiWyD7NrWmWSU8de1t8p3GhMw+zY1fp9QdoW5Bweohi8I+C3hngdLPz0GUsolU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J8anwwbV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5CCC4CEC3;
	Tue, 10 Sep 2024 09:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961276;
	bh=/jdKoRsvF/HP2mATDTjXJlnFsWOvakkiOiBx5zqwtaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J8anwwbVOT5/cqGeFtmPRKYNXRPDIyduuSJdYoWqs+LisW3vHl8630Iz9v2nfflNo
	 fCyYGuvCVurbf/f32yoOSCj0g59d6twawX0KyM91NZj6F6vRzGdjVituygtR89l88r
	 ACgB/OF2m52dbVyJpjKMJdOLlzELc7OO+U44BHmo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Roger Quadros <rogerq@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Julien Panis <jpanis@baylibre.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.10 006/375] net: ethernet: ti: am65-cpsw: fix XDP_DROP, XDP_TX and XDP_REDIRECT
Date: Tue, 10 Sep 2024 11:26:43 +0200
Message-ID: <20240910092622.478344978@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roger Quadros <rogerq@kernel.org>

commit 5e24db550bd6f484d2c7687ee488708260e1f84a upstream.

The following XDP_DROP test from [1] stalls the interface after
250 packets.
~# xdb-bench drop -m native eth0
This is because new RX requests are never queued. Fix that.

The below XDP_TX test from [1] fails with a warning
[  499.947381] XDP_WARN: xdp_update_frame_from_buff(line:277): Driver BUG: missing reserved tailroom
~# xdb-bench tx -m native eth0
Fix that by using PAGE_SIZE during xdp_init_buf().

In XDP_REDIRECT case only 1 packet was processed in rx_poll.
Fix it to process up to budget packets.

Fix all XDP error cases to call trace_xdp_exception() and drop the packet
in am65_cpsw_run_xdp().

[1] xdp-tools suite https://github.com/xdp-project/xdp-tools

Fixes: 8acacc40f733 ("net: ethernet: ti: am65-cpsw: Add minimal XDP support")
Signed-off-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Acked-by: Julien Panis <jpanis@baylibre.com>
Reviewed-by: MD Danish Anwar <danishanwar@ti.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c |   62 +++++++++++++++++--------------
 1 file changed, 34 insertions(+), 28 deletions(-)

--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -156,12 +156,13 @@
 #define AM65_CPSW_CPPI_TX_PKT_TYPE 0x7
 
 /* XDP */
-#define AM65_CPSW_XDP_CONSUMED 2
-#define AM65_CPSW_XDP_REDIRECT 1
+#define AM65_CPSW_XDP_CONSUMED BIT(1)
+#define AM65_CPSW_XDP_REDIRECT BIT(0)
 #define AM65_CPSW_XDP_PASS     0
 
 /* Include headroom compatible with both skb and xdpf */
-#define AM65_CPSW_HEADROOM (max(NET_SKB_PAD, XDP_PACKET_HEADROOM) + NET_IP_ALIGN)
+#define AM65_CPSW_HEADROOM_NA (max(NET_SKB_PAD, XDP_PACKET_HEADROOM) + NET_IP_ALIGN)
+#define AM65_CPSW_HEADROOM ALIGN(AM65_CPSW_HEADROOM_NA, sizeof(long))
 
 static void am65_cpsw_port_set_sl_mac(struct am65_cpsw_port *slave,
 				      const u8 *dev_addr)
@@ -933,7 +934,7 @@ static int am65_cpsw_xdp_tx_frame(struct
 	host_desc = k3_cppi_desc_pool_alloc(tx_chn->desc_pool);
 	if (unlikely(!host_desc)) {
 		ndev->stats.tx_dropped++;
-		return -ENOMEM;
+		return AM65_CPSW_XDP_CONSUMED;	/* drop */
 	}
 
 	am65_cpsw_nuss_set_buf_type(tx_chn, host_desc, buf_type);
@@ -942,7 +943,7 @@ static int am65_cpsw_xdp_tx_frame(struct
 				 pkt_len, DMA_TO_DEVICE);
 	if (unlikely(dma_mapping_error(tx_chn->dma_dev, dma_buf))) {
 		ndev->stats.tx_dropped++;
-		ret = -ENOMEM;
+		ret = AM65_CPSW_XDP_CONSUMED;	/* drop */
 		goto pool_free;
 	}
 
@@ -977,6 +978,7 @@ static int am65_cpsw_xdp_tx_frame(struct
 		/* Inform BQL */
 		netdev_tx_completed_queue(netif_txq, 1, pkt_len);
 		ndev->stats.tx_errors++;
+		ret = AM65_CPSW_XDP_CONSUMED; /* drop */
 		goto dma_unmap;
 	}
 
@@ -1004,6 +1006,7 @@ static int am65_cpsw_run_xdp(struct am65
 	struct bpf_prog *prog;
 	struct page *page;
 	u32 act;
+	int err;
 
 	prog = READ_ONCE(port->xdp_prog);
 	if (!prog)
@@ -1023,14 +1026,14 @@ static int am65_cpsw_run_xdp(struct am65
 
 		xdpf = xdp_convert_buff_to_frame(xdp);
 		if (unlikely(!xdpf))
-			break;
+			goto drop;
 
 		__netif_tx_lock(netif_txq, cpu);
-		ret = am65_cpsw_xdp_tx_frame(ndev, tx_chn, xdpf,
+		err = am65_cpsw_xdp_tx_frame(ndev, tx_chn, xdpf,
 					     AM65_CPSW_TX_BUF_TYPE_XDP_TX);
 		__netif_tx_unlock(netif_txq);
-		if (ret)
-			break;
+		if (err)
+			goto drop;
 
 		ndev->stats.rx_bytes += *len;
 		ndev->stats.rx_packets++;
@@ -1038,7 +1041,7 @@ static int am65_cpsw_run_xdp(struct am65
 		goto out;
 	case XDP_REDIRECT:
 		if (unlikely(xdp_do_redirect(ndev, xdp, prog)))
-			break;
+			goto drop;
 
 		ndev->stats.rx_bytes += *len;
 		ndev->stats.rx_packets++;
@@ -1048,6 +1051,7 @@ static int am65_cpsw_run_xdp(struct am65
 		bpf_warn_invalid_xdp_action(ndev, prog, act);
 		fallthrough;
 	case XDP_ABORTED:
+drop:
 		trace_xdp_exception(ndev, prog, act);
 		fallthrough;
 	case XDP_DROP:
@@ -1056,7 +1060,6 @@ static int am65_cpsw_run_xdp(struct am65
 
 	page = virt_to_head_page(xdp->data);
 	am65_cpsw_put_page(rx_chn, page, true, desc_idx);
-
 out:
 	return ret;
 }
@@ -1095,7 +1098,7 @@ static void am65_cpsw_nuss_rx_csum(struc
 }
 
 static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_common *common,
-				     u32 flow_idx, int cpu)
+				     u32 flow_idx, int cpu, int *xdp_state)
 {
 	struct am65_cpsw_rx_chn *rx_chn = &common->rx_chns;
 	u32 buf_dma_len, pkt_len, port_id = 0, csum_info;
@@ -1114,6 +1117,7 @@ static int am65_cpsw_nuss_rx_packets(str
 	void **swdata;
 	u32 *psdata;
 
+	*xdp_state = AM65_CPSW_XDP_PASS;
 	ret = k3_udma_glue_pop_rx_chn(rx_chn->rx_chn, flow_idx, &desc_dma);
 	if (ret) {
 		if (ret != -ENODATA)
@@ -1161,15 +1165,13 @@ static int am65_cpsw_nuss_rx_packets(str
 	}
 
 	if (port->xdp_prog) {
-		xdp_init_buff(&xdp, AM65_CPSW_MAX_PACKET_SIZE, &port->xdp_rxq);
-
-		xdp_prepare_buff(&xdp, page_addr, skb_headroom(skb),
+		xdp_init_buff(&xdp, PAGE_SIZE, &port->xdp_rxq);
+		xdp_prepare_buff(&xdp, page_addr, AM65_CPSW_HEADROOM,
 				 pkt_len, false);
-
-		ret = am65_cpsw_run_xdp(common, port, &xdp, desc_idx,
-					cpu, &pkt_len);
-		if (ret != AM65_CPSW_XDP_PASS)
-			return ret;
+		*xdp_state = am65_cpsw_run_xdp(common, port, &xdp, desc_idx,
+					       cpu, &pkt_len);
+		if (*xdp_state != AM65_CPSW_XDP_PASS)
+			goto allocate;
 
 		/* Compute additional headroom to be reserved */
 		headroom = (xdp.data - xdp.data_hard_start) - skb_headroom(skb);
@@ -1193,9 +1195,13 @@ static int am65_cpsw_nuss_rx_packets(str
 	stats->rx_bytes += pkt_len;
 	u64_stats_update_end(&stats->syncp);
 
+allocate:
 	new_page = page_pool_dev_alloc_pages(rx_chn->page_pool);
-	if (unlikely(!new_page))
+	if (unlikely(!new_page)) {
+		dev_err(dev, "page alloc failed\n");
 		return -ENOMEM;
+	}
+
 	rx_chn->pages[desc_idx] = new_page;
 
 	if (netif_dormant(ndev)) {
@@ -1229,8 +1235,9 @@ static int am65_cpsw_nuss_rx_poll(struct
 	struct am65_cpsw_common *common = am65_cpsw_napi_to_common(napi_rx);
 	int flow = AM65_CPSW_MAX_RX_FLOWS;
 	int cpu = smp_processor_id();
-	bool xdp_redirect = false;
+	int xdp_state_or = 0;
 	int cur_budget, ret;
+	int xdp_state;
 	int num_rx = 0;
 
 	/* process every flow */
@@ -1238,12 +1245,11 @@ static int am65_cpsw_nuss_rx_poll(struct
 		cur_budget = budget - num_rx;
 
 		while (cur_budget--) {
-			ret = am65_cpsw_nuss_rx_packets(common, flow, cpu);
-			if (ret) {
-				if (ret == AM65_CPSW_XDP_REDIRECT)
-					xdp_redirect = true;
+			ret = am65_cpsw_nuss_rx_packets(common, flow, cpu,
+							&xdp_state);
+			xdp_state_or |= xdp_state;
+			if (ret)
 				break;
-			}
 			num_rx++;
 		}
 
@@ -1251,7 +1257,7 @@ static int am65_cpsw_nuss_rx_poll(struct
 			break;
 	}
 
-	if (xdp_redirect)
+	if (xdp_state_or & AM65_CPSW_XDP_REDIRECT)
 		xdp_do_flush();
 
 	dev_dbg(common->dev, "%s num_rx:%d %d\n", __func__, num_rx, budget);



