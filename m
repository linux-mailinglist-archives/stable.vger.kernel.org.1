Return-Path: <stable+bounces-222532-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yF0SItY+pWm36gUAu9opvQ
	(envelope-from <stable+bounces-222532-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 08:40:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CE01D40ED
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 08:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C7843026C05
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 07:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F2A383C9D;
	Mon,  2 Mar 2026 07:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="wHq/LCpy"
X-Original-To: stable@vger.kernel.org
Received: from out30-77.freemail.mail.aliyun.com (out30-77.freemail.mail.aliyun.com [115.124.30.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C7638551C;
	Mon,  2 Mar 2026 07:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772437040; cv=none; b=epVzciiOW8H7TCCf196KSNLBLVuZMpSbqF3AnpAQLhDDwSuzNTubW7rABDN8+JfoalMUluIpWV317S2emB5W1/bGMidXzEz4fEyT6hFnq6f0VekGYsNfhq0L2lLhKElXY1xFi2f7Fo+eCmlN7rDNm2huSw5V+3EuPM0hVKfImU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772437040; c=relaxed/simple;
	bh=m64c5pbpYYAqZr42t4xFQpkUGBygwAll/WxWA5SGk+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZiZ7v0yK+AZlEAvY0hFHRm7Rlgri6cIYzng1ayFHtdxJpleu/gKArh962a6Ea/vmkdE7GcuB556kFhNw3CJyVD2wDRO5e9SU3ObkNcmBDkgA6LxwPYZ3FJHSWrjxXbMiUmhtoS5EB7G9EUlMtHQf0b8fiC9UEV/fxBBVI5oDdyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=wHq/LCpy; arc=none smtp.client-ip=115.124.30.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1772437035; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=hwvQARZ5w4DROWN0heapfA7FJwFw4QsFAs1gMQciMEE=;
	b=wHq/LCpyOMSwsgVBubuMaktRF6v2B5WqWx+9LuLHP2lbQydB1qyaVyu5K1Z4AkC3+ecBrqa0fCwPOYomH/N3kwNsLsCIHWYDgU5IrFyZyF1BxqUvuO19V/HD3ykRks1ueCpp1gM4Aj+KzONhxVxsKlMB9RA3KWkQZehnS2GBs2U=
Received: from China-team(mailfrom:ruohanlan@aliyun.com fp:SMTPD_---0X-284.c_1772437032 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Mar 2026 15:37:14 +0800
From: Ruohan Lan <ruohanlan@aliyun.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: edumazet@google.com,
	kuniyu@google.com,
	kuba@kernel.org,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	Ruohan Lan <ruohanlan@aliyun.com>
Subject: [PATCH 6.6.y 1/3] net: dst: add four helpers to annotate data-races around dst->dev
Date: Mon,  2 Mar 2026 15:36:28 +0800
Message-Id: <20260302073630.988982-2-ruohanlan@aliyun.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302073630.988982-1-ruohanlan@aliyun.com>
References: <20260302073630.988982-1-ruohanlan@aliyun.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[aliyun.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[aliyun.com:s=s1024];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222532-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,kernel.org,vger.kernel.org,aliyun.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[aliyun.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruohanlan@aliyun.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[aliyun.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aliyun.com:mid,aliyun.com:dkim,aliyun.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28CE01D40ED
X-Rspamd-Action: no action

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 88fe14253e181878c2ddb51a298ae8c468a63010 ]

dst->dev is read locklessly in many contexts,
and written in dst_dev_put().

Fixing all the races is going to need many changes.

We probably will have to add full RCU protection.

Add three helpers to ease this painful process.

static inline struct net_device *dst_dev(const struct dst_entry *dst)
{
       return READ_ONCE(dst->dev);
}

static inline struct net_device *skb_dst_dev(const struct sk_buff *skb)
{
       return dst_dev(skb_dst(skb));
}

static inline struct net *skb_dst_dev_net(const struct sk_buff *skb)
{
       return dev_net(skb_dst_dev(skb));
}

static inline struct net *skb_dst_dev_net_rcu(const struct sk_buff *skb)
{
       return dev_net_rcu(skb_dst_dev(skb));
}

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20250630121934.3399505-7-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Minor context conflict resolved. ]
Signed-off-by: Ruohan Lan <ruohanlan@aliyun.com>
---
 include/net/dst.h | 20 ++++++++++++++++++++
 net/core/dst.c    |  4 ++--
 net/core/sock.c   |  8 ++++----
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 55d1be268d24..ea3b050f8b38 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -581,6 +581,26 @@ static inline struct net_device *skb_dst_dev_rcu(const struct sk_buff *skb)
 	return dst_dev_rcu(skb_dst(skb));
 }
 
+static inline struct net_device *dst_dev(const struct dst_entry *dst)
+{
+	return READ_ONCE(dst->dev);
+}
+
+static inline struct net_device *skb_dst_dev(const struct sk_buff *skb)
+{
+	return dst_dev(skb_dst(skb));
+}
+
+static inline struct net *skb_dst_dev_net(const struct sk_buff *skb)
+{
+	return dev_net(skb_dst_dev(skb));
+}
+
+static inline struct net *skb_dst_dev_net_rcu(const struct sk_buff *skb)
+{
+	return dev_net_rcu(skb_dst_dev(skb));
+}
+
 struct dst_entry *dst_blackhole_check(struct dst_entry *dst, u32 cookie);
 void dst_blackhole_update_pmtu(struct dst_entry *dst, struct sock *sk,
 			       struct sk_buff *skb, u32 mtu, bool confirm_neigh);
diff --git a/net/core/dst.c b/net/core/dst.c
index 2513665696f6..ac67706e5f87 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -152,7 +152,7 @@ void dst_dev_put(struct dst_entry *dst)
 		dst->ops->ifdown(dst, dev);
 	WRITE_ONCE(dst->input, dst_discard);
 	WRITE_ONCE(dst->output, dst_discard_out);
-	dst->dev = blackhole_netdev;
+	WRITE_ONCE(dst->dev, blackhole_netdev);
 	netdev_ref_replace(dev, blackhole_netdev, &dst->dev_tracker,
 			   GFP_ATOMIC);
 }
@@ -265,7 +265,7 @@ unsigned int dst_blackhole_mtu(const struct dst_entry *dst)
 {
 	unsigned int mtu = dst_metric_raw(dst, RTAX_MTU);
 
-	return mtu ? : dst->dev->mtu;
+	return mtu ? : dst_dev(dst)->mtu;
 }
 EXPORT_SYMBOL_GPL(dst_blackhole_mtu);
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 8e4c87a39dc8..0e52847c57f8 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2450,8 +2450,8 @@ static u32 sk_dst_gso_max_size(struct sock *sk, struct dst_entry *dst)
 		   !ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr));
 #endif
 	/* pairs with the WRITE_ONCE() in netif_set_gso(_ipv4)_max_size() */
-	max_size = is_ipv6 ? READ_ONCE(dst->dev->gso_max_size) :
-			READ_ONCE(dst->dev->gso_ipv4_max_size);
+	max_size = is_ipv6 ? READ_ONCE(dst_dev(dst)->gso_max_size) :
+			READ_ONCE(dst_dev(dst)->gso_ipv4_max_size);
 	if (max_size > GSO_LEGACY_MAX_SIZE && !sk_is_tcp(sk))
 		max_size = GSO_LEGACY_MAX_SIZE;
 
@@ -2462,7 +2462,7 @@ void sk_setup_caps(struct sock *sk, struct dst_entry *dst)
 {
 	u32 max_segs = 1;
 
-	sk->sk_route_caps = dst->dev->features;
+	sk->sk_route_caps = dst_dev(dst)->features;
 	if (sk_is_tcp(sk))
 		sk->sk_route_caps |= NETIF_F_GSO;
 	if (sk->sk_route_caps & NETIF_F_GSO)
@@ -2476,7 +2476,7 @@ void sk_setup_caps(struct sock *sk, struct dst_entry *dst)
 			sk->sk_route_caps |= NETIF_F_SG | NETIF_F_HW_CSUM;
 			sk->sk_gso_max_size = sk_dst_gso_max_size(sk, dst);
 			/* pairs with the WRITE_ONCE() in netif_set_gso_max_segs() */
-			max_segs = max_t(u32, READ_ONCE(dst->dev->gso_max_segs), 1);
+			max_segs = max_t(u32, READ_ONCE(dst_dev(dst)->gso_max_segs), 1);
 		}
 	}
 	sk->sk_gso_max_segs = max_segs;
-- 
2.43.0


