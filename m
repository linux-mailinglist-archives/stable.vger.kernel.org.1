Return-Path: <stable+bounces-143693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78169AB40ED
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE82719E7EC9
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 17:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BB8255E52;
	Mon, 12 May 2025 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u38wJu+Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17493248F49;
	Mon, 12 May 2025 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072774; cv=none; b=mwzL+2ld6oeVh/CrrNUuBI5OwNqXKCPBdrKYioHGZ4aIiKMW4Ui6/Cq7ZAqOfkQ3Z2QYhIIiKiDtDuT5winMBd2s6PnRCSYRrmVMOPrAOiPhkG/QUPdyxxaPfyqNaesUeuHvaXuhU65jBZNJoY4TYlXdhu8Z4zE88Ca+cAc9DUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072774; c=relaxed/simple;
	bh=dzn3vrdGF8SaMSx+Dqad5Knu8IdiyYLJbXlCaJCVsBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFYCBEMMQp5P8QWI77zFPOFSmOqeWUQjeinSiP136XkOB93SeuAbWqAcwk2V5wg+p59rsi+CFubXlooW4JftE8KyXphyjz8sx78iTeiJ4L0cuUaECDoItfC+aNmhOLyJU70v1RJM0kInH9OVOtv/0rktPrdisEb1p4QrjV0/45Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u38wJu+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA7CC4CEE7;
	Mon, 12 May 2025 17:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747072774;
	bh=dzn3vrdGF8SaMSx+Dqad5Knu8IdiyYLJbXlCaJCVsBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u38wJu+Zc7eF5P1LNUoat3GXRuJSUe3PzIxMzF7tUaoDMqvdLD80XuB7/yxfZYSlJ
	 OLtsDaee9niAd4VtFIqKp0xQbrRUs7pDhcgh2bygrJEcx/lPGXQ3F+rjR0W1ERDTC0
	 0zlujaTRB4mWlZp1sYsHXOeY8RTZvbK2z2ltD01M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 052/184] net: export a helper for adding up queue stats
Date: Mon, 12 May 2025 19:44:13 +0200
Message-ID: <20250512172043.857156378@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172041.624042835@linuxfoundation.org>
References: <20250512172041.624042835@linuxfoundation.org>
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

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 23fa6a23d97182d36ca3c71e43c804fa91e46a03 ]

Older drivers and drivers with lower queue counts often have a static
array of queues, rather than allocating structs for each queue on demand.
Add a helper for adding up qstats from a queue range. Expectation is
that driver will pass a queue range [netdev->real_num_*x_queues, MAX).
It was tempting to always use num_*x_queues as the end, but virtio
seems to clamp its queue count after allocating the netdev. And this
way we can trivaly reuse the helper for [0, real_..).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Link: https://patch.msgid.link/20250507003221.823267-2-kuba@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 001160ec8c59 ("virtio-net: fix total qstat values")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netdev_queues.h |  6 ++++
 net/core/netdev-genl.c      | 69 +++++++++++++++++++++++++++----------
 2 files changed, 56 insertions(+), 19 deletions(-)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 5ca019d294ca3..173bcfcd868a8 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -92,6 +92,12 @@ struct netdev_stat_ops {
 			       struct netdev_queue_stats_tx *tx);
 };
 
+void netdev_stat_queue_sum(struct net_device *netdev,
+			   int rx_start, int rx_end,
+			   struct netdev_queue_stats_rx *rx_sum,
+			   int tx_start, int tx_end,
+			   struct netdev_queue_stats_tx *tx_sum);
+
 /**
  * struct netdev_queue_mgmt_ops - netdev ops for queue management
  *
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index ad426b3a03b52..0fe537781bc4d 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -616,25 +616,66 @@ netdev_nl_stats_by_queue(struct net_device *netdev, struct sk_buff *rsp,
 	return 0;
 }
 
+/**
+ * netdev_stat_queue_sum() - add up queue stats from range of queues
+ * @netdev:	net_device
+ * @rx_start:	index of the first Rx queue to query
+ * @rx_end:	index after the last Rx queue (first *not* to query)
+ * @rx_sum:	output Rx stats, should be already initialized
+ * @tx_start:	index of the first Tx queue to query
+ * @tx_end:	index after the last Tx queue (first *not* to query)
+ * @tx_sum:	output Tx stats, should be already initialized
+ *
+ * Add stats from [start, end) range of queue IDs to *x_sum structs.
+ * The sum structs must be already initialized. Usually this
+ * helper is invoked from the .get_base_stats callbacks of drivers
+ * to account for stats of disabled queues. In that case the ranges
+ * are usually [netdev->real_num_*x_queues, netdev->num_*x_queues).
+ */
+void netdev_stat_queue_sum(struct net_device *netdev,
+			   int rx_start, int rx_end,
+			   struct netdev_queue_stats_rx *rx_sum,
+			   int tx_start, int tx_end,
+			   struct netdev_queue_stats_tx *tx_sum)
+{
+	const struct netdev_stat_ops *ops;
+	struct netdev_queue_stats_rx rx;
+	struct netdev_queue_stats_tx tx;
+	int i;
+
+	ops = netdev->stat_ops;
+
+	for (i = rx_start; i < rx_end; i++) {
+		memset(&rx, 0xff, sizeof(rx));
+		if (ops->get_queue_stats_rx)
+			ops->get_queue_stats_rx(netdev, i, &rx);
+		netdev_nl_stats_add(rx_sum, &rx, sizeof(rx));
+	}
+	for (i = tx_start; i < tx_end; i++) {
+		memset(&tx, 0xff, sizeof(tx));
+		if (ops->get_queue_stats_tx)
+			ops->get_queue_stats_tx(netdev, i, &tx);
+		netdev_nl_stats_add(tx_sum, &tx, sizeof(tx));
+	}
+}
+EXPORT_SYMBOL(netdev_stat_queue_sum);
+
 static int
 netdev_nl_stats_by_netdev(struct net_device *netdev, struct sk_buff *rsp,
 			  const struct genl_info *info)
 {
-	struct netdev_queue_stats_rx rx_sum, rx;
-	struct netdev_queue_stats_tx tx_sum, tx;
-	const struct netdev_stat_ops *ops;
+	struct netdev_queue_stats_rx rx_sum;
+	struct netdev_queue_stats_tx tx_sum;
 	void *hdr;
-	int i;
 
-	ops = netdev->stat_ops;
 	/* Netdev can't guarantee any complete counters */
-	if (!ops->get_base_stats)
+	if (!netdev->stat_ops->get_base_stats)
 		return 0;
 
 	memset(&rx_sum, 0xff, sizeof(rx_sum));
 	memset(&tx_sum, 0xff, sizeof(tx_sum));
 
-	ops->get_base_stats(netdev, &rx_sum, &tx_sum);
+	netdev->stat_ops->get_base_stats(netdev, &rx_sum, &tx_sum);
 
 	/* The op was there, but nothing reported, don't bother */
 	if (!memchr_inv(&rx_sum, 0xff, sizeof(rx_sum)) &&
@@ -647,18 +688,8 @@ netdev_nl_stats_by_netdev(struct net_device *netdev, struct sk_buff *rsp,
 	if (nla_put_u32(rsp, NETDEV_A_QSTATS_IFINDEX, netdev->ifindex))
 		goto nla_put_failure;
 
-	for (i = 0; i < netdev->real_num_rx_queues; i++) {
-		memset(&rx, 0xff, sizeof(rx));
-		if (ops->get_queue_stats_rx)
-			ops->get_queue_stats_rx(netdev, i, &rx);
-		netdev_nl_stats_add(&rx_sum, &rx, sizeof(rx));
-	}
-	for (i = 0; i < netdev->real_num_tx_queues; i++) {
-		memset(&tx, 0xff, sizeof(tx));
-		if (ops->get_queue_stats_tx)
-			ops->get_queue_stats_tx(netdev, i, &tx);
-		netdev_nl_stats_add(&tx_sum, &tx, sizeof(tx));
-	}
+	netdev_stat_queue_sum(netdev, 0, netdev->real_num_rx_queues, &rx_sum,
+			      0, netdev->real_num_tx_queues, &tx_sum);
 
 	if (netdev_nl_stats_write_rx(rsp, &rx_sum) ||
 	    netdev_nl_stats_write_tx(rsp, &tx_sum))
-- 
2.39.5




