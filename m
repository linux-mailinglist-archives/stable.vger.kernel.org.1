Return-Path: <stable+bounces-102515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B1F9EF268
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 993D129149F
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D85B223C42;
	Thu, 12 Dec 2024 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ojc1ZyZI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4A721CFEA;
	Thu, 12 Dec 2024 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021510; cv=none; b=brreJzSQPWJ/dBQIgUD3JE7BT78WqOG1Exf5ZfW6bZFTHduQ9RGe0boQFU7wnh9CDQ+e8n3Mqf5HyBsl2DP4C4qSUFkJRR8RqmljeR9gceZME1Q913Y6ZG1ULjQGuGiCKe6eQoU4VfHyC3FF2x4SwEk+ngswox04Zdg/PZk7HjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021510; c=relaxed/simple;
	bh=3rQK6+0r2tzlRKvOT73UWLUpOaLZU+A2G9DwXqFyy44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVnDwpkkMJ4s5jRP2+mYsjoh+yckY4P5LFBSKgHNl12VN7cyZ4v83AiQN5wC2h9fCb2VQXyQ0cU4oADoa7gjvkdLMHZc1k/qM34/ur8xEzC2xy2uTZ+83M32EOoRtDbo8K0crELFZXv1+L7Pk9VTeodMsI3cAjdEKvpzkUkeaJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ojc1ZyZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FBEC4CECE;
	Thu, 12 Dec 2024 16:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734021509;
	bh=3rQK6+0r2tzlRKvOT73UWLUpOaLZU+A2G9DwXqFyy44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ojc1ZyZI+mZp5GzP3Koh7K1uWLNyD6ge64V9OBB2pFfev2z7FulhaDPd6/Cbs9pbc
	 NDtm7wiZO9fMRsk2Sgpm3Yxzs3PPUHw08E1puB42+uKCXEhZhPJJaTZBETg1fTlVZe
	 PhTj3aX4aeWXzc9qje6s/uUql6wtW0N/8wJF2aYU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH 6.1 758/772] net: Move {l,t,d}stats allocation to core and convert veth & vrf
Date: Thu, 12 Dec 2024 16:01:43 +0100
Message-ID: <20241212144421.259686893@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 34d21de99cea9cb17967874313e5b0262527833c ]

Move {l,t,d}stats allocation to the core and let netdevs pick the stats
type they need. That way the driver doesn't have to bother with error
handling (allocation failure checking, making sure free happens in the
right spot, etc) - all happening in the core.

Co-developed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Cc: David Ahern <dsahern@kernel.org>
Link: https://lore.kernel.org/r/20231114004220.6495-3-daniel@iogearbox.net
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Stable-dep-of: 024ee930cb3c ("bpf: Fix dev's rx stats for bpf_redirect_peer traffic")
[ Note: Simplified vrf bits to reduce patch given unrelated to the fix ]
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/veth.c        |   16 +------------
 drivers/net/vrf.c         |   24 ++++++--------------
 include/linux/netdevice.h |   30 ++++++++++++++++++++++----
 net/core/dev.c            |   53 +++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 85 insertions(+), 38 deletions(-)

--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1381,25 +1381,12 @@ static void veth_free_queues(struct net_
 
 static int veth_dev_init(struct net_device *dev)
 {
-	int err;
-
-	dev->lstats = netdev_alloc_pcpu_stats(struct pcpu_lstats);
-	if (!dev->lstats)
-		return -ENOMEM;
-
-	err = veth_alloc_queues(dev);
-	if (err) {
-		free_percpu(dev->lstats);
-		return err;
-	}
-
-	return 0;
+	return veth_alloc_queues(dev);
 }
 
 static void veth_dev_free(struct net_device *dev)
 {
 	veth_free_queues(dev);
-	free_percpu(dev->lstats);
 }
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
@@ -1625,6 +1612,7 @@ static void veth_setup(struct net_device
 			       NETIF_F_HW_VLAN_STAG_RX);
 	dev->needs_free_netdev = true;
 	dev->priv_destructor = veth_dev_free;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_LSTATS;
 	dev->max_mtu = ETH_MAX_MTU;
 
 	dev->hw_features = VETH_FEATURES;
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -121,22 +121,12 @@ struct net_vrf {
 	int			ifindex;
 };
 
-struct pcpu_dstats {
-	u64			tx_pkts;
-	u64			tx_bytes;
-	u64			tx_drps;
-	u64			rx_pkts;
-	u64			rx_bytes;
-	u64			rx_drps;
-	struct u64_stats_sync	syncp;
-};
-
 static void vrf_rx_stats(struct net_device *dev, int len)
 {
 	struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
 
 	u64_stats_update_begin(&dstats->syncp);
-	dstats->rx_pkts++;
+	dstats->rx_packets++;
 	dstats->rx_bytes += len;
 	u64_stats_update_end(&dstats->syncp);
 }
@@ -161,10 +151,10 @@ static void vrf_get_stats64(struct net_d
 		do {
 			start = u64_stats_fetch_begin_irq(&dstats->syncp);
 			tbytes = dstats->tx_bytes;
-			tpkts = dstats->tx_pkts;
-			tdrops = dstats->tx_drps;
+			tpkts = dstats->tx_packets;
+			tdrops = dstats->tx_drops;
 			rbytes = dstats->rx_bytes;
-			rpkts = dstats->rx_pkts;
+			rpkts = dstats->rx_packets;
 		} while (u64_stats_fetch_retry_irq(&dstats->syncp, start));
 		stats->tx_bytes += tbytes;
 		stats->tx_packets += tpkts;
@@ -421,7 +411,7 @@ static int vrf_local_xmit(struct sk_buff
 	if (likely(__netif_rx(skb) == NET_RX_SUCCESS))
 		vrf_rx_stats(dev, len);
 	else
-		this_cpu_inc(dev->dstats->rx_drps);
+		this_cpu_inc(dev->dstats->rx_drops);
 
 	return NETDEV_TX_OK;
 }
@@ -616,11 +606,11 @@ static netdev_tx_t vrf_xmit(struct sk_bu
 		struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
 
 		u64_stats_update_begin(&dstats->syncp);
-		dstats->tx_pkts++;
+		dstats->tx_packets++;
 		dstats->tx_bytes += len;
 		u64_stats_update_end(&dstats->syncp);
 	} else {
-		this_cpu_inc(dev->dstats->tx_drps);
+		this_cpu_inc(dev->dstats->tx_drops);
 	}
 
 	return ret;
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1747,6 +1747,13 @@ enum netdev_ml_priv_type {
 	ML_PRIV_CAN,
 };
 
+enum netdev_stat_type {
+	NETDEV_PCPU_STAT_NONE,
+	NETDEV_PCPU_STAT_LSTATS, /* struct pcpu_lstats */
+	NETDEV_PCPU_STAT_TSTATS, /* struct pcpu_sw_netstats */
+	NETDEV_PCPU_STAT_DSTATS, /* struct pcpu_dstats */
+};
+
 /**
  *	struct net_device - The DEVICE structure.
  *
@@ -1941,10 +1948,14 @@ enum netdev_ml_priv_type {
  *
  * 	@ml_priv:	Mid-layer private
  *	@ml_priv_type:  Mid-layer private type
- * 	@lstats:	Loopback statistics
- * 	@tstats:	Tunnel statistics
- * 	@dstats:	Dummy statistics
- * 	@vstats:	Virtual ethernet statistics
+ *
+ *	@pcpu_stat_type:	Type of device statistics which the core should
+ *				allocate/free: none, lstats, tstats, dstats. none
+ *				means the driver is handling statistics allocation/
+ *				freeing internally.
+ *	@lstats:		Loopback statistics: packets, bytes
+ *	@tstats:		Tunnel statistics: RX/TX packets, RX/TX bytes
+ *	@dstats:		Dummy statistics: RX/TX/drop packets, RX/TX bytes
  *
  *	@garp_port:	GARP
  *	@mrp_port:	MRP
@@ -2287,6 +2298,7 @@ struct net_device {
 	void				*ml_priv;
 	enum netdev_ml_priv_type	ml_priv_type;
 
+	enum netdev_stat_type		pcpu_stat_type:8;
 	union {
 		struct pcpu_lstats __percpu		*lstats;
 		struct pcpu_sw_netstats __percpu	*tstats;
@@ -2670,6 +2682,16 @@ struct pcpu_sw_netstats {
 	struct u64_stats_sync   syncp;
 } __aligned(4 * sizeof(u64));
 
+struct pcpu_dstats {
+	u64			rx_packets;
+	u64			rx_bytes;
+	u64			rx_drops;
+	u64			tx_packets;
+	u64			tx_bytes;
+	u64			tx_drops;
+	struct u64_stats_sync	syncp;
+} __aligned(8 * sizeof(u64));
+
 struct pcpu_lstats {
 	u64_stats_t packets;
 	u64_stats_t bytes;
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9991,6 +9991,46 @@ void netif_tx_stop_all_queues(struct net
 }
 EXPORT_SYMBOL(netif_tx_stop_all_queues);
 
+static int netdev_do_alloc_pcpu_stats(struct net_device *dev)
+{
+	void __percpu *v;
+
+	switch (dev->pcpu_stat_type) {
+	case NETDEV_PCPU_STAT_NONE:
+		return 0;
+	case NETDEV_PCPU_STAT_LSTATS:
+		v = dev->lstats = netdev_alloc_pcpu_stats(struct pcpu_lstats);
+		break;
+	case NETDEV_PCPU_STAT_TSTATS:
+		v = dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
+		break;
+	case NETDEV_PCPU_STAT_DSTATS:
+		v = dev->dstats = netdev_alloc_pcpu_stats(struct pcpu_dstats);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return v ? 0 : -ENOMEM;
+}
+
+static void netdev_do_free_pcpu_stats(struct net_device *dev)
+{
+	switch (dev->pcpu_stat_type) {
+	case NETDEV_PCPU_STAT_NONE:
+		return;
+	case NETDEV_PCPU_STAT_LSTATS:
+		free_percpu(dev->lstats);
+		break;
+	case NETDEV_PCPU_STAT_TSTATS:
+		free_percpu(dev->tstats);
+		break;
+	case NETDEV_PCPU_STAT_DSTATS:
+		free_percpu(dev->dstats);
+		break;
+	}
+}
+
 /**
  * register_netdevice() - register a network device
  * @dev: device to register
@@ -10051,11 +10091,15 @@ int register_netdevice(struct net_device
 		goto err_uninit;
 	}
 
+	ret = netdev_do_alloc_pcpu_stats(dev);
+	if (ret)
+		goto err_uninit;
+
 	ret = -EBUSY;
 	if (!dev->ifindex)
 		dev->ifindex = dev_new_index(net);
 	else if (__dev_get_by_index(net, dev->ifindex))
-		goto err_uninit;
+		goto err_free_pcpu;
 
 	/* Transfer changeable features to wanted_features and enable
 	 * software offloads (GSO and GRO).
@@ -10102,14 +10146,14 @@ int register_netdevice(struct net_device
 	ret = call_netdevice_notifiers(NETDEV_POST_INIT, dev);
 	ret = notifier_to_errno(ret);
 	if (ret)
-		goto err_uninit;
+		goto err_free_pcpu;
 
 	ret = netdev_register_kobject(dev);
 	write_lock(&dev_base_lock);
 	dev->reg_state = ret ? NETREG_UNREGISTERED : NETREG_REGISTERED;
 	write_unlock(&dev_base_lock);
 	if (ret)
-		goto err_uninit;
+		goto err_free_pcpu;
 
 	__netdev_update_features(dev);
 
@@ -10156,6 +10200,8 @@ int register_netdevice(struct net_device
 out:
 	return ret;
 
+err_free_pcpu:
+	netdev_do_free_pcpu_stats(dev);
 err_uninit:
 	if (dev->netdev_ops->ndo_uninit)
 		dev->netdev_ops->ndo_uninit(dev);
@@ -10409,6 +10455,7 @@ void netdev_run_todo(void)
 		WARN_ON(rcu_access_pointer(dev->ip_ptr));
 		WARN_ON(rcu_access_pointer(dev->ip6_ptr));
 
+		netdev_do_free_pcpu_stats(dev);
 		if (dev->priv_destructor)
 			dev->priv_destructor(dev);
 		if (dev->needs_free_netdev)



