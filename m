Return-Path: <stable+bounces-225240-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EYhCtWDs2msXQAAu9opvQ
	(envelope-from <stable+bounces-225240-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 04:26:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD30427D12A
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 04:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C5A630AA171
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 03:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCB030AAA9;
	Fri, 13 Mar 2026 03:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="YnzBEnMy"
X-Original-To: stable@vger.kernel.org
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED82304BDC
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 03:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773372347; cv=none; b=m+Lg2dMS6SL2U9DTkhEKbKfiZc4hE5ASXqob1q7bDFT20RZgxdW/s917TvH69v2gUgFit5STn1uuNpT2wpe8CUFMJTKB7HjMm7YAkkg5+eao6lcwq9uc/RAtjopGQ4oxIO+Kse335hA19Gneyj7xjVn3Z3o6fQ716h0cZSx+RuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773372347; c=relaxed/simple;
	bh=y0Ah/CzvBkpqX7I7vu2xVBl2TW0EAIWYO7FzvuDd4mw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A10tyYEZWy3daaskHVqc1oaXvvggncEHUuWpus7xG4oxURYbCgfY/XCR/dtnpdhpnQe1RQzF0fWbjsAkcBSvuUsIG5XSF+vny2x4J0fxZYoHGGTXup+xvGe60Jcw/kgkPJd2OJ0f4XMdNL3ut4DaWULyDLU5sPukx0Z0nV8Ouz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=YnzBEnMy; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1773372342;
	bh=sSJYW5io/4MyT3pXpRddCt5uwN76i4vLd85t6YieSm4=;
	h=From:Subject:Date:Message-Id;
	b=YnzBEnMyocmDhlTEnap1GE7ZWynk8GCEHwc1ul+V8rLD+Xra1fz+ySB7zU90mahcG
	 CZK3BNId8tn0dOE7fVSUBQCpNVvkOYUmVVtiNO0Qi8D/JTGtjwC0xwpAhZXsJGbjAo
	 75q+JjqFyLJMTfjdor8MsWi85PmzcOavDp8v966c=
X-SMAIL-HELO: pek-lpg-core6.wrs.com
Received: from unknown (HELO pek-lpg-core6.wrs.com)([60.247.85.88])
	by sina.com (10.185.250.23) with ESMTP
	id 69B3826B0000382D; Fri, 13 Mar 2026 11:20:13 +0800 (CST)
X-Sender: johnny_haocn@sina.com
X-Auth-ID: johnny_haocn@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=johnny_haocn@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=johnny_haocn@sina.com
X-SMAIL-MID: 3918558912958
X-SMAIL-UIID: 70AA6FCCB42040DE9AC27B7A05CF2B26-20260313-112013-1
From: Johnny Hao <johnny_haocn@sina.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Groeneveld <kgroeneveld@lenbrook.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wei Fang <wei.fang@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Johnny Hao <johnny_haocn@sina.com>
Subject: [PATCH 6.1.y] net: fec: handle page_pool_dev_alloc_pages error
Date: Fri, 13 Mar 2026 11:20:09 +0800
Message-Id: <20260313032009.2181924-1-johnny_haocn@sina.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225240-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lenbrook.com,intel.com,nxp.com,kernel.org,sina.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[sina.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnny_haocn@sina.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sina.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sina.com:dkim,sina.com:email,sina.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: CD30427D12A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kevin Groeneveld <kgroeneveld@lenbrook.com>

[ Upstream commit 001ba0902046cb6c352494df610718c0763e77a5 ]

The fec_enet_update_cbd function calls page_pool_dev_alloc_pages but did
not handle the case when it returned NULL. There was a WARN_ON(!new_page)
but it would still proceed to use the NULL pointer and then crash.

This case does seem somewhat rare but when the system is under memory
pressure it can happen. One case where I can duplicate this with some
frequency is when writing over a smbd share to a SATA HDD attached to an
imx6q.

Setting /proc/sys/vm/min_free_kbytes to higher values also seems to solve
the problem for my test case. But it still seems wrong that the fec driver
ignores the memory allocation error and can crash.

This commit handles the allocation error by dropping the current packet.

Fixes: 95698ff6177b5 ("net: fec: using page pool to manage RX buffers")
Signed-off-by: Kevin Groeneveld <kgroeneveld@lenbrook.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
Link: https://patch.msgid.link/20250113154846.1765414-1-kgroeneveld@lenbrook.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ The context change is due to the commit 6c8fae0caf5d
(net: fec: simplify the code logic of quirks")
in v6.2 which is irrelevant to the logic of this patch. ]
Signed-off-by: Johnny Hao <johnny_haocn@sina.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c8f897afb30a..e9c4945d0c27 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1595,19 +1595,22 @@ fec_enet_copybreak(struct net_device *ndev, struct sk_buff **skb,
 	return true;
 }
 
-static void fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
+static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
 				struct bufdesc *bdp, int index)
 {
 	struct page *new_page;
 	dma_addr_t phys_addr;
 
 	new_page = page_pool_dev_alloc_pages(rxq->page_pool);
-	WARN_ON(!new_page);
-	rxq->rx_skb_info[index].page = new_page;
+	if (unlikely(!new_page))
+		return -ENOMEM;
 
+	rxq->rx_skb_info[index].page = new_page;
 	rxq->rx_skb_info[index].offset = FEC_ENET_XDP_HEADROOM;
 	phys_addr = page_pool_get_dma_addr(new_page) + FEC_ENET_XDP_HEADROOM;
 	bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
+
+	return 0;
 }
 
 /* During a receive, the bd_rx.cur points to the current incoming buffer.
@@ -1632,6 +1635,7 @@ fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
 	int	index = 0;
 	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
 	struct page *page;
+	__fec32 cbd_bufaddr;
 
 #ifdef CONFIG_M532x
 	flush_cache_all();
@@ -1686,12 +1690,17 @@ fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
 
 		index = fec_enet_get_bd_index(bdp, &rxq->bd);
 		page = rxq->rx_skb_info[index].page;
+		cbd_bufaddr = bdp->cbd_bufaddr;
+		if (fec_enet_update_cbd(rxq, bdp, index)) {
+			ndev->stats.rx_dropped++;
+			goto rx_processing_done;
+		}
+
 		dma_sync_single_for_cpu(&fep->pdev->dev,
-					fec32_to_cpu(bdp->cbd_bufaddr),
+					fec32_to_cpu(cbd_bufaddr),
 					pkt_len,
 					DMA_FROM_DEVICE);
 		prefetch(page_address(page));
-		fec_enet_update_cbd(rxq, bdp, index);
 
 		/* The packet length includes FCS, but we don't want to
 		 * include that when passing upstream as it messes up
-- 
2.34.1


