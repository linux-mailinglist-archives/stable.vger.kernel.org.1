Return-Path: <stable+bounces-85066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C202F99D65D
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 20:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9D31F230E5
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 18:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BCB1C729B;
	Mon, 14 Oct 2024 18:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="S3S/bvh0"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A011FAA
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728930106; cv=none; b=qJnak1E3W7SHz4QODqtkgQXlUpFpmw9aC/Sh/PYY6VztvptUu/g4WZxoCVGJBrnaSxpnfdk39L2/cH6BlRVOp9wmiqeYiOzSc+B5vn+I4Tig6JoMriQAMvzJn6+qGxUpSlyiSgZbThAAIKCV1g1lrigc+UCJrUSIIIahkEcubek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728930106; c=relaxed/simple;
	bh=B1/9jvtK1AyQMJgVk6wHw/uDAJJG0KG/bCunGclLZtI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ok51TM8hFf/csmJafyP7wQGzBC78wyMzzy9ytYso5yBS4Kchj0GdRBdaoVPiW5XBkOZS3E18a0kQ3KIBbk/cIwh7Rl4VZfHAtc/wmvo0/Z/yqOmLgpQi/1wHBftOeGyyUC7d7mElWB9C/szsnBnHn8sNVHhqYabtpEDtAqAzuSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=S3S/bvh0; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728930105; x=1760466105;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mkfn5qoo44KMNI6HH5H0sBj4agsYPKWcPK1VhNiCTd4=;
  b=S3S/bvh0DtpqnBgytGXpAYFSksXTQTivOSMaN4JICBmF27Fqn6KzQ0Dw
   Mfh0668+Mw0VydCHi3d4dUQetzGTBTVWJV7wQ2/XGCtFp/crDQboknHWS
   lqHxFETrdsK0n/2Wi39lwf0qErd5hxkPfGfAYPcWQSrhVXVXeM4k2SlSR
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="687487023"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 18:21:42 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:50482]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.107:2525] with esmtp (Farcaster)
 id 48c7aeec-22df-488f-86d8-2fba5ffea4dc; Mon, 14 Oct 2024 18:21:42 +0000 (UTC)
X-Farcaster-Flow-ID: 48c7aeec-22df-488f-86d8-2fba5ffea4dc
Received: from EX19D018UWB001.ant.amazon.com (10.13.138.56) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 18:21:41 +0000
Received: from c889f3bcf8d1.amazon.com (10.187.171.41) by
 EX19D018UWB001.ant.amazon.com (10.13.138.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 18:21:41 +0000
From: Matthew Yeazel <yeazelm@amazon.com>
To: <stable@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<sashal@kernel.org>, Peilin Ye <peilin.ye@bytedance.com>, Matt Yeazel
	<yeazelm@amazon.com>, Youlun Zhang <zhangyoulun@bytedance.com>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH 6.1.y] bpf: Fix dev's rx stats for bpf_redirect_peer traffic
Date: Mon, 14 Oct 2024 11:21:30 -0700
Message-ID: <20241014182130.37592-1-yeazelm@amazon.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D018UWB001.ant.amazon.com (10.13.138.56)

From: Peilin Ye <peilin.ye@bytedance.com>

commit 024ee930cb3c9ae49e4266aee89cfde0ebb407e1 upstream

Traffic redirected by bpf_redirect_peer() (used by recent CNIs like Cilium)
is not accounted for in the RX stats of supported devices (that is, veth
and netkit), confusing user space metrics collectors such as cAdvisor [0],
as reported by Youlun.

Fix it by calling dev_sw_netstats_rx_add() in skb_do_redirect(), to update
RX traffic counters. Devices that support ndo_get_peer_dev _must_ use the
@tstats per-CPU counters (instead of @lstats, or @dstats).

To make this more fool-proof, error out when ndo_get_peer_dev is set but
@tstats are not selected.

  [0] Specifically, the "container_network_receive_{byte,packet}s_total"
      counters are affected.

Fixes: 9aa1206e8f48 ("bpf: Add redirect_peer helper")
Reported-by: Youlun Zhang <zhangyoulun@bytedance.com>
Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://lore.kernel.org/r/20231114004220.6495-6-daniel@iogearbox.net
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
(cherry picked from commit 024ee930cb3c9ae49e4266aee89cfde0ebb407e1)
Signed-off-by: Matt Yeazel <yeazelm@amazon.com>
---
 net/core/dev.c    | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 net/core/filter.c |  1 +
 2 files changed, 49 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 20d8b9195ef6..9f5109a15e4c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9983,6 +9983,54 @@ void netif_tx_stop_all_queues(struct net_device *dev)
 }
 EXPORT_SYMBOL(netif_tx_stop_all_queues);
 
+static int netdev_do_alloc_pcpu_stats(struct net_device *dev)
+{
+	void __percpu *v;
+
+	/* Drivers implementing ndo_get_peer_dev must support tstat
+	 * accounting, so that skb_do_redirect() can bump the dev's
+	 * RX stats upon network namespace switch.
+	 */
+	if (dev->netdev_ops->ndo_get_peer_dev &&
+	    dev->pcpu_stat_type != NETDEV_PCPU_STAT_TSTATS)
+		return -EOPNOTSUPP;
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
diff --git a/net/core/filter.c b/net/core/filter.c
index 1cd5f146cafe..e318ec485cc8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2489,6 +2489,7 @@ int skb_do_redirect(struct sk_buff *skb)
 			     net_eq(net, dev_net(dev))))
 			goto out_drop;
 		skb->dev = dev;
+		dev_sw_netstats_rx_add(dev, skb->len);
 		return -EAGAIN;
 	}
 	return flags & BPF_F_NEIGH ?
-- 
2.45.2


