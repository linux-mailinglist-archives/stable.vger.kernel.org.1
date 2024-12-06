Return-Path: <stable+bounces-100005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E990A9E7C4A
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 00:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E30283ECD
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 23:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ECC212FA4;
	Fri,  6 Dec 2024 23:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gguNYgBO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E881EF090
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 23:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733526718; cv=none; b=ZJ3g7paopGSEieP0zxHiS4x9NDNrwgMTvsx1a7cp2EmC5nPpBYGH/ekoFVlzTEBpL6gXu9tX2gQXcAy5/utP6MdZ4WdO94px7qkReUNbg0rN4VwBEHkm7bBqDjcsZb9aoQSSmaPOj4aUUbOEWZ0jQNRlVFbwpRdxm4583HEdupw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733526718; c=relaxed/simple;
	bh=hg0gjQfTdXjvWRKQ7Aue9lp4bG4O02B2/ZGvajJoK1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWryH7ua9ErV7Qk8hvIpU4XhXiBVwgK9Tgkt6rRveBX2n85tCddXQgetK7ElHEuPXiaCMvcizEGFa+tLj/fH9NGaTnxPgzUbb/2XZvYRzrHbFKVdlG67ctmp+4PXm0XVKx1gMnJKqMr/zYO0M+y4LnhcGEMfYwnAaMtifgBY79s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gguNYgBO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23E3C4CED1;
	Fri,  6 Dec 2024 23:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733526718;
	bh=hg0gjQfTdXjvWRKQ7Aue9lp4bG4O02B2/ZGvajJoK1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gguNYgBOdP1K4zhvlA43cxVgIe4Ch9K4iBw1/R/JGjP5p40+0kiqetn1kKXPTtQL0
	 dBmkf5JjANHnUBAgBGnzAl5IYvzlKeTK/Jn3kjqfR8Usi2PQORyha+QmjzQ0rjYulB
	 FyHInEDLcSu0e/bymPkN+fsO8WQzmAuy6pFa6m4Yma17zwFy38NRpWjS3RUMD6U1mK
	 n46KukBuXFZ0vtFzKwkVzZYoPn0Z6Cq5waDHPW1pRIk+tMIMJdiJCPZUz9Leo06n6T
	 8RAsZDlZKPebRxqsIvKzmxt+47nKLTeaFg7j49WvWfm9rlbT4VIVI+LRPYoHxkRG8B
	 wF9LOYsDzeCgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.1 1/3] net: Move {l,t,d}stats allocation to core and convert veth & vrf
Date: Fri,  6 Dec 2024 18:11:56 -0500
Message-ID: <20241206130554-1a2b2e7554bb99e9@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206153403.273068-1-daniel@iogearbox.net>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 34d21de99cea9cb17967874313e5b0262527833c


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 6ae7b3fc7ae8)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  34d21de99cea9 ! 1:  927b0635b3b95 net: Move {l,t,d}stats allocation to core and convert veth & vrf
    @@ Metadata
      ## Commit message ##
         net: Move {l,t,d}stats allocation to core and convert veth & vrf
     
    +    [ Upstream commit 34d21de99cea9cb17967874313e5b0262527833c ]
    +    [ Note: Simplified vrf bits to reduce patch given unrelated to the fix ]
    +
         Move {l,t,d}stats allocation to the core and let netdevs pick the stats
         type they need. That way the driver doesn't have to bother with error
         handling (allocation failure checking, making sure free happens in the
    @@ Commit message
         Cc: David Ahern <dsahern@kernel.org>
         Link: https://lore.kernel.org/r/20231114004220.6495-3-daniel@iogearbox.net
         Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
    +    Stable-dep-of: 024ee930cb3c ("bpf: Fix dev's rx stats for bpf_redirect_peer traffic")
    +    Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
     
      ## drivers/net/veth.c ##
     @@ drivers/net/veth.c: static void veth_free_queues(struct net_device *dev)
    @@ drivers/net/veth.c: static void veth_setup(struct net_device *dev)
      	dev->hw_features = VETH_FEATURES;
     
      ## drivers/net/vrf.c ##
    -@@ drivers/net/vrf.c: static void vrf_dev_uninit(struct net_device *dev)
    +@@ drivers/net/vrf.c: struct net_vrf {
    + 	int			ifindex;
    + };
      
    - 	vrf_rtable_release(dev, vrf);
    - 	vrf_rt6_release(dev, vrf);
    +-struct pcpu_dstats {
    +-	u64			tx_pkts;
    +-	u64			tx_bytes;
    +-	u64			tx_drps;
    +-	u64			rx_pkts;
    +-	u64			rx_bytes;
    +-	u64			rx_drps;
    +-	struct u64_stats_sync	syncp;
    +-};
     -
    --	free_percpu(dev->dstats);
    --	dev->dstats = NULL;
    - }
    - 
    - static int vrf_dev_init(struct net_device *dev)
    + static void vrf_rx_stats(struct net_device *dev, int len)
      {
    - 	struct net_vrf *vrf = netdev_priv(dev);
    + 	struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
      
    --	dev->dstats = netdev_alloc_pcpu_stats(struct pcpu_dstats);
    --	if (!dev->dstats)
    --		goto out_nomem;
    --
    - 	/* create the default dst which points back to us */
    - 	if (vrf_rtable_create(dev) != 0)
    --		goto out_stats;
    -+		goto out_nomem;
    - 
    - 	if (vrf_rt6_create(dev) != 0)
    - 		goto out_rth;
    -@@ drivers/net/vrf.c: static int vrf_dev_init(struct net_device *dev)
    - 
    - out_rth:
    - 	vrf_rtable_release(dev, vrf);
    --out_stats:
    --	free_percpu(dev->dstats);
    --	dev->dstats = NULL;
    - out_nomem:
    - 	return -ENOMEM;
    + 	u64_stats_update_begin(&dstats->syncp);
    +-	dstats->rx_pkts++;
    ++	dstats->rx_packets++;
    + 	dstats->rx_bytes += len;
    + 	u64_stats_update_end(&dstats->syncp);
      }
    -@@ drivers/net/vrf.c: static void vrf_setup(struct net_device *dev)
    - 	dev->min_mtu = IPV6_MIN_MTU;
    - 	dev->max_mtu = IP6_MAX_MTU;
    - 	dev->mtu = dev->max_mtu;
    -+
    -+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
    +@@ drivers/net/vrf.c: static void vrf_get_stats64(struct net_device *dev,
    + 		do {
    + 			start = u64_stats_fetch_begin_irq(&dstats->syncp);
    + 			tbytes = dstats->tx_bytes;
    +-			tpkts = dstats->tx_pkts;
    +-			tdrops = dstats->tx_drps;
    ++			tpkts = dstats->tx_packets;
    ++			tdrops = dstats->tx_drops;
    + 			rbytes = dstats->rx_bytes;
    +-			rpkts = dstats->rx_pkts;
    ++			rpkts = dstats->rx_packets;
    + 		} while (u64_stats_fetch_retry_irq(&dstats->syncp, start));
    + 		stats->tx_bytes += tbytes;
    + 		stats->tx_packets += tpkts;
    +@@ drivers/net/vrf.c: static int vrf_local_xmit(struct sk_buff *skb, struct net_device *dev,
    + 	if (likely(__netif_rx(skb) == NET_RX_SUCCESS))
    + 		vrf_rx_stats(dev, len);
    + 	else
    +-		this_cpu_inc(dev->dstats->rx_drps);
    ++		this_cpu_inc(dev->dstats->rx_drops);
    + 
    + 	return NETDEV_TX_OK;
      }
    +@@ drivers/net/vrf.c: static netdev_tx_t vrf_xmit(struct sk_buff *skb, struct net_device *dev)
    + 		struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
      
    - static int vrf_validate(struct nlattr *tb[], struct nlattr *data[],
    + 		u64_stats_update_begin(&dstats->syncp);
    +-		dstats->tx_pkts++;
    ++		dstats->tx_packets++;
    + 		dstats->tx_bytes += len;
    + 		u64_stats_update_end(&dstats->syncp);
    + 	} else {
    +-		this_cpu_inc(dev->dstats->tx_drps);
    ++		this_cpu_inc(dev->dstats->tx_drops);
    + 	}
    + 
    + 	return ret;
     
      ## include/linux/netdevice.h ##
     @@ include/linux/netdevice.h: enum netdev_ml_priv_type {
    @@ include/linux/netdevice.h: struct net_device {
      	union {
      		struct pcpu_lstats __percpu		*lstats;
      		struct pcpu_sw_netstats __percpu	*tstats;
    +@@ include/linux/netdevice.h: struct pcpu_sw_netstats {
    + 	struct u64_stats_sync   syncp;
    + } __aligned(4 * sizeof(u64));
    + 
    ++struct pcpu_dstats {
    ++	u64			rx_packets;
    ++	u64			rx_bytes;
    ++	u64			rx_drops;
    ++	u64			tx_packets;
    ++	u64			tx_bytes;
    ++	u64			tx_drops;
    ++	struct u64_stats_sync	syncp;
    ++} __aligned(8 * sizeof(u64));
    ++
    + struct pcpu_lstats {
    + 	u64_stats_t packets;
    + 	u64_stats_t bytes;
     
      ## net/core/dev.c ##
     @@ net/core/dev.c: void netif_tx_stop_all_queues(struct net_device *dev)
    @@ net/core/dev.c: int register_netdevice(struct net_device *dev)
     +	if (ret)
     +		goto err_uninit;
     +
    - 	ret = dev_index_reserve(net, dev->ifindex);
    - 	if (ret < 0)
    + 	ret = -EBUSY;
    + 	if (!dev->ifindex)
    + 		dev->ifindex = dev_new_index(net);
    + 	else if (__dev_get_by_index(net, dev->ifindex))
     -		goto err_uninit;
     +		goto err_free_pcpu;
    - 	dev->ifindex = ret;
      
      	/* Transfer changeable features to wanted_features and enable
    + 	 * software offloads (GSO and GRO).
    +@@ net/core/dev.c: int register_netdevice(struct net_device *dev)
    + 	ret = call_netdevice_notifiers(NETDEV_POST_INIT, dev);
    + 	ret = notifier_to_errno(ret);
    + 	if (ret)
    +-		goto err_uninit;
    ++		goto err_free_pcpu;
    + 
    + 	ret = netdev_register_kobject(dev);
    + 	write_lock(&dev_base_lock);
    + 	dev->reg_state = ret ? NETREG_UNREGISTERED : NETREG_REGISTERED;
    + 	write_unlock(&dev_base_lock);
    + 	if (ret)
    +-		goto err_uninit;
    ++		goto err_free_pcpu;
    + 
    + 	__netdev_update_features(dev);
    + 
     @@ net/core/dev.c: int register_netdevice(struct net_device *dev)
    - 	call_netdevice_notifiers(NETDEV_PRE_UNINIT, dev);
    - err_ifindex_release:
    - 	dev_index_release(net, dev->ifindex);
    + out:
    + 	return ret;
    + 
     +err_free_pcpu:
     +	netdev_do_free_pcpu_stats(dev);
      err_uninit:
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

