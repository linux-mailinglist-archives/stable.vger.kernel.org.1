Return-Path: <stable+bounces-201116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4D6CC00D4
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 22:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DD5F3056565
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 21:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B4D329C57;
	Mon, 15 Dec 2025 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="QcDgLoI8"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFB631ED9A;
	Mon, 15 Dec 2025 21:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765835573; cv=none; b=EVt+bm+w8PkAINgtTrQr2c3quiIAVGo8IRBBoAe7Hj7QhAvPCq8HF3XQywhT+yH5nccmkBZxy0KZOgOc4DKQ+cfTm2V5deRWYBQestcy9p5azsW3j93xAdCPDqNO8htIS66UNBL/Qu5kunS3ksKqQAJKhorQsyiz/KKCwd8tduw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765835573; c=relaxed/simple;
	bh=mk7D4pfZMdxS1O+z9LiyeGwaarT/Ir5kcEp0BYnfAv8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0LibptPho7n51alp7rhOVA+tzBrCbN/e7J2ucIzetcuPcR46N3dqy8Q6BDbMbh/493sXojaNJCfC3ixVuFILl0PXnpcfIx7NCYuCTkwlufNCRGN896vG/xPW7eWW+uqlN13VSe8U+zwNs3VDkpOM+KbHLIVBN7zBk+WM3p3qs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=QcDgLoI8; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1765835571; x=1797371571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AFy//bIv2WOBsGEnBs+F/J2UzVTYkg8qOmO8sk49Kjs=;
  b=QcDgLoI86+RZorVOPgADIfgtOmIOh8x6ASNPvSqDHPRT55j6G6+L8Ydk
   /uEWSProA9qbldt6PdXS1Ip3ABSJ3HnbFC1OuTZCpLpkS+YDXYDltwVNY
   7H0VdTI3SGWBtTDU6Ff4DCP33ZhFUIC5YAEo2CSGpjnPyL4JnlDijyTiW
   NhFJqAqWnn9Z4wfAyHvMKC5NUsTLxvDxvDfMvTydIoR/ddN3B3R2esbto
   okrWp1T1/PhOA1wGpY+XTJftJPBUOUjmEfq6D6oO4GOGM4dql8uIjlHcM
   Ay+pdIpCBYMkXNXBvsN34aw3EuFA+xaGGWYm96pEx0b8gHTDI6NEeyWgG
   w==;
X-CSE-ConnectionGUID: 5q7GFcmGSSCI0LjR+PgmCw==
X-CSE-MsgGUID: YCAmXR1uSg2umreCIfevFQ==
X-IronPort-AV: E=Sophos;i="6.21,151,1763424000"; 
   d="scan'208";a="9136392"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 21:51:44 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:32112]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.5:2525] with esmtp (Farcaster)
 id a546f009-43fe-4371-bfb8-68ff58ca61ce; Mon, 15 Dec 2025 21:51:43 +0000 (UTC)
X-Farcaster-Flow-ID: a546f009-43fe-4371-bfb8-68ff58ca61ce
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 15 Dec 2025 21:51:43 +0000
Received: from dev-dsk-gyokhan-1b-83b48b3c.eu-west-1.amazon.com (10.13.234.1)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 15 Dec 2025 21:51:41 +0000
From: Gyokhan Kochmarla <gyokhan@amazon.de>
To: <stable@vger.kernel.org>
CC: <edumazet@google.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux@gyokhan.com>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] net: dst: introduce dst->dev_rcu
Date: Mon, 15 Dec 2025 21:51:18 +0000
Message-ID: <20251215215119.63681-2-gyokhan@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251215215119.63681-1-gyokhan@amazon.de>
References: <20251215215119.63681-1-gyokhan@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D037UWB001.ant.amazon.com (10.13.138.123) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit caedcc5b6df1b2e2b5f39079e3369c1d4d5c5f50 ]

Followup of commit 88fe14253e1818 ("net: dst: add four helpers
to annotate data-races around dst->dev").

We want to gradually add explicit RCU protection to dst->dev,
including lockdep support.

Add an union to alias dst->dev_rcu and dst->dev.

Add dst_dev_net_rcu() helper.

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20250828195823.3958522-2-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 50c127a69cd62 ("Replace three dst_dev() with a lockdep enabled helper.")
Signed-off-by: Gyokhan Kochmarla <gyokhan@amazon.com>
---
 include/net/dst.h | 16 +++++++++++-----
 net/core/dst.c    |  2 +-
 net/ipv4/route.c  |  4 ++--
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index e5c9ea188383..e7c1eb69570e 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -24,7 +24,10 @@
 struct sk_buff;
 
 struct dst_entry {
-	struct net_device       *dev;
+	union {
+		struct net_device       *dev;
+		struct net_device __rcu *dev_rcu;
+	};
 	struct  dst_ops	        *ops;
 	unsigned long		_metrics;
 	unsigned long           expires;
@@ -568,9 +571,12 @@ static inline struct net_device *dst_dev(const struct dst_entry *dst)
 
 static inline struct net_device *dst_dev_rcu(const struct dst_entry *dst)
 {
-	/* In the future, use rcu_dereference(dst->dev) */
-	WARN_ON_ONCE(!rcu_read_lock_held());
-	return READ_ONCE(dst->dev);
+	return rcu_dereference(dst->dev_rcu);
+}
+
+static inline struct net *dst_dev_net_rcu(const struct dst_entry *dst)
+{
+	return dev_net_rcu(dst_dev_rcu(dst));
 }
 
 static inline struct net_device *skb_dst_dev(const struct sk_buff *skb)
@@ -590,7 +596,7 @@ static inline struct net *skb_dst_dev_net(const struct sk_buff *skb)
 
 static inline struct net *skb_dst_dev_net_rcu(const struct sk_buff *skb)
 {
-	return dev_net_rcu(skb_dst_dev(skb));
+	return dev_net_rcu(skb_dst_dev_rcu(skb));
 }
 
 struct dst_entry *dst_blackhole_check(struct dst_entry *dst, u32 cookie);
diff --git a/net/core/dst.c b/net/core/dst.c
index 9a0ddef8bee4..8dbb54148c03 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -150,7 +150,7 @@ void dst_dev_put(struct dst_entry *dst)
 		dst->ops->ifdown(dst, dev);
 	WRITE_ONCE(dst->input, dst_discard);
 	WRITE_ONCE(dst->output, dst_discard_out);
-	WRITE_ONCE(dst->dev, blackhole_netdev);
+	rcu_assign_pointer(dst->dev_rcu, blackhole_netdev);
 	netdev_ref_replace(dev, blackhole_netdev, &dst->dev_tracker,
 			   GFP_ATOMIC);
 }
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index e219bb423c3a..7579001d5b29 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1030,7 +1030,7 @@ static void __ip_rt_update_pmtu(struct rtable *rt, struct flowi4 *fl4, u32 mtu)
 		return;
 
 	rcu_read_lock();
-	net = dev_net_rcu(dst_dev(dst));
+	net = dst_dev_net_rcu(dst);
 	if (mtu < net->ipv4.ip_rt_min_pmtu) {
 		lock = true;
 		mtu = min(old_mtu, net->ipv4.ip_rt_min_pmtu);
@@ -1328,7 +1328,7 @@ static unsigned int ipv4_default_advmss(const struct dst_entry *dst)
 	struct net *net;
 
 	rcu_read_lock();
-	net = dev_net_rcu(dst_dev(dst));
+	net = dst_dev_net_rcu(dst);
 	advmss = max_t(unsigned int, ipv4_mtu(dst) - header_size,
 				   net->ipv4.ip_rt_min_advmss);
 	rcu_read_unlock();
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


