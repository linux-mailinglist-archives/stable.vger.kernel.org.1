Return-Path: <stable+bounces-254709-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LCqMdmxF2p+NggAu9opvQ
	(envelope-from <stable+bounces-254709-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 05:09:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6A25EC12F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 05:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 543663058B89
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 03:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC402EBBB9;
	Thu, 28 May 2026 03:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="X4rpzlym"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB840305660;
	Thu, 28 May 2026 03:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779937619; cv=none; b=j9U952iQNZDJAFYa55I/PLBrzkLo6CgTQK30hdJyqk7TLeQ3Ov5ObxRGmHEeNnwMAdAlwhQryY7D8Ak16WuSL1/s2huO6T2T5ws2YMxHnDBRZtcJ9ddRqB3eRS/HsuOYIcf7d4DoiMBfzpqtpG/aqOuBzyiiet49r8x+2gBpato=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779937619; c=relaxed/simple;
	bh=TcIV9BaWJZBJf+siaIArVIvsEA4HBZ3tRlG/JYdRbMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QjzLjVV3SlWEzdvYrQnMd+FOW2+LARBwYKzEYC1ORauIgxl/BX7/+deJqlWrn4qG/9LoVgAbnWo32PvVW08gXfTZntaTnSYbElH34RshUbZtbcFPoE++ua7YAT6ltd9rYWgl8Mlqu77LkKI184sEPp0Di6ZxoEgivg0D+fBYR7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=X4rpzlym; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=pS
	T2nE1ZdntpdiRrgvI6nKA2ljNSTqu3KfCGCuxvpw4=; b=X4rpzlymQDSDUFmCrE
	8NCJyYYtx3nPtMy6I+4Mb2nPo2vl2lxZKa0r/x17+aeuE1IKQc1a0NEjDKnDfQqg
	DSsz4Kckob3Ohs7mwfgksa3CIS5Knq4JpwbGbCN6W2YmJVzpf4ew7yrogEgagtIP
	TCuBodTKjsvOqhUALYNZVPGek=
Received: from pek-lpg-core5.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wAHZewSsRdqsskMAA--.1791S2;
	Thu, 28 May 2026 11:05:55 +0800 (CST)
From: Robert Garcia <rob_garcia@163.com>
To: stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Martin KaFai Lau <kafai@fb.com>,
	Wei Wang <weiwan@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Robert Garcia <rob_garcia@163.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y] ipv4: start using dst_dev_rcu()
Date: Thu, 28 May 2026 11:05:54 +0800
Message-Id: <20260528030554.3147155-1-rob_garcia@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHZewSsRdqsskMAA--.1791S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF4kGrW3Kw47Cw47Xr47Arb_yoWrGr1Upr
	n8tFZ3trWUXr1UW3ykAF4kZryagw4kGasxuw18A3yag3WDX3ZYyFy8trWaqF4F9FWYyFWY
	qF1jvF47Aw1UJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRAnY8UUUUU=
X-CM-SenderInfo: 5uresw5dufxti6rwjhhfrp/xtbDARTRPWoXsRTN7AAA3A
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254709-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,fb.com,google.com,davemloft.net,163.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rob_garcia@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 6D6A25EC12F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 6ad8de3cefdb6ffa6708b21c567df0dbf82c43a8 ]

Change icmpv4_xrlim_allow(), ip_defrag() to prevent possible UAF.

Change ipmr_prepare_xmit(), ipmr_queue_fwd_xmit(), ip_mr_output(),
ipv4_neigh_lookup() to use lockdep enabled dst_dev_rcu().

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20250828195823.3958522-9-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Minor modifications made to adapt current code. ]
Signed-off-by: Robert Garcia <rob_garcia@163.com>
---
 net/ipv4/icmp.c        | 4 ++--
 net/ipv4/ip_fragment.c | 6 ++++--
 net/ipv4/ipmr.c        | 4 ++--
 net/ipv4/route.c       | 4 ++--
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 3fcf11f83d87..29a2162398e7 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -319,16 +319,16 @@ static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
 		return true;
 
 	/* No rate limit on loopback */
+	rcu_read_lock();
 	if (dst->dev && (dst->dev->flags&IFF_LOOPBACK))
 		goto out;
 
-	rcu_read_lock();
 	peer = inet_getpeer_v4(net->ipv4.peers, fl4->daddr,
 			       l3mdev_master_ifindex_rcu(dst->dev));
 	rc = inet_peer_xrlim_allow(peer,
 				   READ_ONCE(net->ipv4.sysctl_icmp_ratelimit));
-	rcu_read_unlock();
 out:
+	rcu_read_unlock();
 	if (!rc)
 		__ICMP_INC_STATS(net, ICMP_MIB_RATELIMITHOST);
 	else
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 484edc8513e4..efc50d21d954 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -488,13 +488,15 @@ static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
 /* Process an incoming IP datagram fragment. */
 int ip_defrag(struct net *net, struct sk_buff *skb, u32 user)
 {
-	struct net_device *dev = skb->dev ? : skb_dst(skb)->dev;
-	int vif = l3mdev_master_ifindex_rcu(dev);
+	struct net_device *dev;
 	struct ipq *qp;
+	int vif;
 
 	__IP_INC_STATS(net, IPSTATS_MIB_REASMREQDS);
 
 	/* Lookup (or create) queue header */
+	dev = skb->dev ? : skb_dst_dev_rcu(skb);
+	vif = l3mdev_master_ifindex_rcu(dev);
 	qp = ip_find(net, ip_hdr(skb), user, vif);
 	if (qp) {
 		int ret;
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index af9412a507cf..948e826900fa 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1905,7 +1905,7 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 		goto out_free;
 	}
 
-	encap += LL_RESERVED_SPACE(dev) + rt->dst.header_len;
+	encap += LL_RESERVED_SPACE(dst_dev_rcu(&rt->dst)) + rt->dst.header_len;
 
 	if (skb_cow(skb, encap)) {
 		ip_rt_put(rt);
@@ -1942,7 +1942,7 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 	 * result in receiving multiple packets.
 	 */
 	NF_HOOK(NFPROTO_IPV4, NF_INET_FORWARD,
-		net, NULL, skb, skb->dev, dev,
+		net, NULL, skb, skb->dev, dst_dev_rcu(&rt->dst),
 		ipmr_forward_finish);
 	return;
 
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index f134c59f839e..0ea017bcea47 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -416,11 +416,11 @@ static struct neighbour *ipv4_neigh_lookup(const struct dst_entry *dst,
 					   const void *daddr)
 {
 	const struct rtable *rt = container_of(dst, struct rtable, dst);
-	struct net_device *dev = dst->dev;
+	struct net_device *dev;
 	struct neighbour *n;
 
 	rcu_read_lock();
-
+	dev = dst_dev_rcu(dst);
 	if (likely(rt->rt_gw_family == AF_INET)) {
 		n = ip_neigh_gw4(dev, rt->rt_gw4);
 	} else if (rt->rt_gw_family == AF_INET6) {
-- 
2.34.1


