Return-Path: <stable+bounces-3314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF38F7FF505
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1CB21C20E4E
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3341B54F98;
	Thu, 30 Nov 2023 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HgK15FOj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AAD54F90;
	Thu, 30 Nov 2023 16:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F467C433C7;
	Thu, 30 Nov 2023 16:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361515;
	bh=tU3AsZ0N1JUTYF3CcCA6SXhHLE8D6Xh3aKSTTAvufjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HgK15FOj5VMik9xTm9zTQ57y7FaBzZ1vfXXqEYe99zaRQcjgmLSfdx95OxFYKpjTr
	 wt2UKzsVAalQhqPFYm4ctSM+mcn+mCBufd5LskF5EuHNXnhJyIyMjt36xRwlRzqOO3
	 fvHonG+P+5BoPPQdCeV4uyVmCW/U0U69s0AbFxrE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 029/112] net: Move {l,t,d}stats allocation to core and convert veth & vrf
Date: Thu, 30 Nov 2023 16:21:16 +0000
Message-ID: <20231130162141.243199290@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>
References: <20231130162140.298098091@linuxfoundation.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/veth.c        | 16 ++-----------
 drivers/net/vrf.c         | 14 +++--------
 include/linux/netdevice.h | 20 ++++++++++++----
 net/core/dev.c            | 49 ++++++++++++++++++++++++++++++++++++++-
 4 files changed, 69 insertions(+), 30 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 0deefd1573cf2..0ee5d1e0759fb 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1499,25 +1499,12 @@ static void veth_free_queues(struct net_device *dev)
 
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
@@ -1789,6 +1776,7 @@ static void veth_setup(struct net_device *dev)
 			       NETIF_F_HW_VLAN_STAG_RX);
 	dev->needs_free_netdev = true;
 	dev->priv_destructor = veth_dev_free;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_LSTATS;
 	dev->max_mtu = ETH_MAX_MTU;
 
 	dev->hw_features = VETH_FEATURES;
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 3654c8b344024..b90dccdc2d33c 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1164,22 +1164,15 @@ static void vrf_dev_uninit(struct net_device *dev)
 
 	vrf_rtable_release(dev, vrf);
 	vrf_rt6_release(dev, vrf);
-
-	free_percpu(dev->dstats);
-	dev->dstats = NULL;
 }
 
 static int vrf_dev_init(struct net_device *dev)
 {
 	struct net_vrf *vrf = netdev_priv(dev);
 
-	dev->dstats = netdev_alloc_pcpu_stats(struct pcpu_dstats);
-	if (!dev->dstats)
-		goto out_nomem;
-
 	/* create the default dst which points back to us */
 	if (vrf_rtable_create(dev) != 0)
-		goto out_stats;
+		goto out_nomem;
 
 	if (vrf_rt6_create(dev) != 0)
 		goto out_rth;
@@ -1193,9 +1186,6 @@ static int vrf_dev_init(struct net_device *dev)
 
 out_rth:
 	vrf_rtable_release(dev, vrf);
-out_stats:
-	free_percpu(dev->dstats);
-	dev->dstats = NULL;
 out_nomem:
 	return -ENOMEM;
 }
@@ -1694,6 +1684,8 @@ static void vrf_setup(struct net_device *dev)
 	dev->min_mtu = IPV6_MIN_MTU;
 	dev->max_mtu = IP6_MAX_MTU;
 	dev->mtu = dev->max_mtu;
+
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
 }
 
 static int vrf_validate(struct nlattr *tb[], struct nlattr *data[],
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b76dc6fa4e772..b8e60a20416ba 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1774,6 +1774,13 @@ enum netdev_ml_priv_type {
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
@@ -1968,10 +1975,14 @@ enum netdev_ml_priv_type {
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
@@ -2328,6 +2339,7 @@ struct net_device {
 	void				*ml_priv;
 	enum netdev_ml_priv_type	ml_priv_type;
 
+	enum netdev_stat_type		pcpu_stat_type:8;
 	union {
 		struct pcpu_lstats __percpu		*lstats;
 		struct pcpu_sw_netstats __percpu	*tstats;
diff --git a/net/core/dev.c b/net/core/dev.c
index 9f3f8930c6914..37444c8e22054 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10050,6 +10050,46 @@ void netif_tx_stop_all_queues(struct net_device *dev)
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
@@ -10110,9 +10150,13 @@ int register_netdevice(struct net_device *dev)
 		goto err_uninit;
 	}
 
+	ret = netdev_do_alloc_pcpu_stats(dev);
+	if (ret)
+		goto err_uninit;
+
 	ret = dev_index_reserve(net, dev->ifindex);
 	if (ret < 0)
-		goto err_uninit;
+		goto err_free_pcpu;
 	dev->ifindex = ret;
 
 	/* Transfer changeable features to wanted_features and enable
@@ -10218,6 +10262,8 @@ int register_netdevice(struct net_device *dev)
 	call_netdevice_notifiers(NETDEV_PRE_UNINIT, dev);
 err_ifindex_release:
 	dev_index_release(net, dev->ifindex);
+err_free_pcpu:
+	netdev_do_free_pcpu_stats(dev);
 err_uninit:
 	if (dev->netdev_ops->ndo_uninit)
 		dev->netdev_ops->ndo_uninit(dev);
@@ -10470,6 +10516,7 @@ void netdev_run_todo(void)
 		WARN_ON(rcu_access_pointer(dev->ip_ptr));
 		WARN_ON(rcu_access_pointer(dev->ip6_ptr));
 
+		netdev_do_free_pcpu_stats(dev);
 		if (dev->priv_destructor)
 			dev->priv_destructor(dev);
 		if (dev->needs_free_netdev)
-- 
2.42.0




