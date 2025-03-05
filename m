Return-Path: <stable+bounces-120498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58022A50701
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10A78173C09
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 17:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CB925332F;
	Wed,  5 Mar 2025 17:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AsBniF6w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2489250C02;
	Wed,  5 Mar 2025 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197135; cv=none; b=FHhE/62EPZJmUyicYNscSnhkCIhHDIip6pTbpvx74JfSAktkNH8kKQIfBFEqPOcOBa5pPd93YkmidgoA293ICZfEWPF7xcpGCJmkl/sMADmdmWnzPcWv4pOtX5TIK/PpaC9V3Q4sq2ZzPLZxXg8fFzZAGFLmlNG5qU2W8O+Qez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197135; c=relaxed/simple;
	bh=1UIyGCzablz3FHVWcH6JvvnzWHzV86oCHyHZZIx5whs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HvvYe5Q/SFs33lEdos1AIIqxaiK5aBxiGYnhTXpJF2yIytduCR+KnPWR5PuuaW5IbC9Eqs/c7NDPiozqTnzgqtq6DE1TYx+p00lkGm/gjMujnpQH96n0w6xKRjqTqtHoEXC8M8LMG1rzv0lOCspxEtJhY+ahaZgddLDrwrMkHXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AsBniF6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F25FC4CED1;
	Wed,  5 Mar 2025 17:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741197134;
	bh=1UIyGCzablz3FHVWcH6JvvnzWHzV86oCHyHZZIx5whs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AsBniF6wephbIaqFxIMvE9vQ9N+b1hDDGeqAuKVOjNdy2e4GLu+aSVyfqWM9EDvl/
	 OufHKHJjZq7hQ79rQzlq/0juii+kTqdbNBkeO9KVtn9SqAdX8sTH9lST295BCix6zC
	 CgYktD2oj3RvekKgZYH0gFVBk5tTJ6TocFMVVV0E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nick Child <nnac123@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 051/176] ibmvnic: Add stat for tx direct vs tx batched
Date: Wed,  5 Mar 2025 18:47:00 +0100
Message-ID: <20250305174507.510976459@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174505.437358097@linuxfoundation.org>
References: <20250305174505.437358097@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nick Child <nnac123@linux.ibm.com>

[ Upstream commit 2ee73c54a615b74d2e7ee6f20844fd3ba63fc485 ]

Allow tracking of packets sent with send_subcrq direct vs
indirect. `ethtool -S <dev>` will now provide a counter
of the number of uses of each xmit method. This metric will
be useful in performance debugging.

Signed-off-by: Nick Child <nnac123@linux.ibm.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20241001163531.1803152-1-nnac123@linux.ibm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: bdf5d13aa05e ("ibmvnic: Don't reference skb after sending to VIOS")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 23 ++++++++++++++++-------
 drivers/net/ethernet/ibm/ibmvnic.h |  3 ++-
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 0b06fcd2d0f40..b83877cafaf7f 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2136,7 +2136,7 @@ static void ibmvnic_tx_scrq_clean_buffer(struct ibmvnic_adapter *adapter,
 		tx_buff = &tx_pool->tx_buff[index];
 		adapter->netdev->stats.tx_packets--;
 		adapter->netdev->stats.tx_bytes -= tx_buff->skb->len;
-		adapter->tx_stats_buffers[queue_num].packets--;
+		adapter->tx_stats_buffers[queue_num].batched_packets--;
 		adapter->tx_stats_buffers[queue_num].bytes -=
 						tx_buff->skb->len;
 		dev_kfree_skb_any(tx_buff->skb);
@@ -2228,7 +2228,8 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	unsigned int tx_map_failed = 0;
 	union sub_crq indir_arr[16];
 	unsigned int tx_dropped = 0;
-	unsigned int tx_packets = 0;
+	unsigned int tx_dpackets = 0;
+	unsigned int tx_bpackets = 0;
 	unsigned int tx_bytes = 0;
 	dma_addr_t data_dma_addr;
 	struct netdev_queue *txq;
@@ -2387,6 +2388,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 		if (lpar_rc != H_SUCCESS)
 			goto tx_err;
 
+		tx_dpackets++;
 		goto early_exit;
 	}
 
@@ -2415,6 +2417,8 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 			goto tx_err;
 	}
 
+	tx_bpackets++;
+
 early_exit:
 	if (atomic_add_return(num_entries, &tx_scrq->used)
 					>= adapter->req_tx_entries_per_subcrq) {
@@ -2422,7 +2426,6 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 		netif_stop_subqueue(netdev, queue_num);
 	}
 
-	tx_packets++;
 	tx_bytes += skb->len;
 	txq_trans_cond_update(txq);
 	ret = NETDEV_TX_OK;
@@ -2452,10 +2455,11 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	rcu_read_unlock();
 	netdev->stats.tx_dropped += tx_dropped;
 	netdev->stats.tx_bytes += tx_bytes;
-	netdev->stats.tx_packets += tx_packets;
+	netdev->stats.tx_packets += tx_bpackets + tx_dpackets;
 	adapter->tx_send_failed += tx_send_failed;
 	adapter->tx_map_failed += tx_map_failed;
-	adapter->tx_stats_buffers[queue_num].packets += tx_packets;
+	adapter->tx_stats_buffers[queue_num].batched_packets += tx_bpackets;
+	adapter->tx_stats_buffers[queue_num].direct_packets += tx_dpackets;
 	adapter->tx_stats_buffers[queue_num].bytes += tx_bytes;
 	adapter->tx_stats_buffers[queue_num].dropped_packets += tx_dropped;
 
@@ -3621,7 +3625,10 @@ static void ibmvnic_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 		memcpy(data, ibmvnic_stats[i].name, ETH_GSTRING_LEN);
 
 	for (i = 0; i < adapter->req_tx_queues; i++) {
-		snprintf(data, ETH_GSTRING_LEN, "tx%d_packets", i);
+		snprintf(data, ETH_GSTRING_LEN, "tx%d_batched_packets", i);
+		data += ETH_GSTRING_LEN;
+
+		snprintf(data, ETH_GSTRING_LEN, "tx%d_direct_packets", i);
 		data += ETH_GSTRING_LEN;
 
 		snprintf(data, ETH_GSTRING_LEN, "tx%d_bytes", i);
@@ -3686,7 +3693,9 @@ static void ibmvnic_get_ethtool_stats(struct net_device *dev,
 				      (adapter, ibmvnic_stats[i].offset));
 
 	for (j = 0; j < adapter->req_tx_queues; j++) {
-		data[i] = adapter->tx_stats_buffers[j].packets;
+		data[i] = adapter->tx_stats_buffers[j].batched_packets;
+		i++;
+		data[i] = adapter->tx_stats_buffers[j].direct_packets;
 		i++;
 		data[i] = adapter->tx_stats_buffers[j].bytes;
 		i++;
diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
index e5c6ff3d0c472..f923cdab03f57 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -213,7 +213,8 @@ struct ibmvnic_statistics {
 
 #define NUM_TX_STATS 3
 struct ibmvnic_tx_queue_stats {
-	u64 packets;
+	u64 batched_packets;
+	u64 direct_packets;
 	u64 bytes;
 	u64 dropped_packets;
 };
-- 
2.39.5




