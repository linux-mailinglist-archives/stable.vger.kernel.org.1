Return-Path: <stable+bounces-48648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374058FE9E9
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1071C25ED9
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE0119D068;
	Thu,  6 Jun 2024 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T84IWWvY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF66F19D066;
	Thu,  6 Jun 2024 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683079; cv=none; b=MJZZBfEw7LLmPrEJrXPMWG7LupNhOlQeGsMIDilS4qCJ7YQ/bCejSNn7v+xXQAYa/pajEjBH7p8BfKvRpyCv/9jjqhFO/MNECTjBtgjLaVl3qAeaW+8FnaXI3lpAVq3HzXvYcmLLSw/DU5U9PXy0gWEeV2QlOdj2Uh4ZIrRCV/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683079; c=relaxed/simple;
	bh=B/TJGwfG+bB6EzMdbTkm251/De7qBMHGfY2UYdDTuXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V37CM5JLLv6DILL22ItySa9pE86ru+SduSLXVkkkNRytx4MFnsyO7m1MmJOWr+kMOuSq0hEH40BKwXBCMAMp//cNaakigUJHxxd5pbMx44aMXOXAs3ASpNdB8+uEFEWnJd3VdD+Z/oq8K8CDibqATwRL1YgBhxykO2PoSUGyDu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T84IWWvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFCDC2BD10;
	Thu,  6 Jun 2024 14:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683078;
	bh=B/TJGwfG+bB6EzMdbTkm251/De7qBMHGfY2UYdDTuXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T84IWWvYbXQ0+8c2UnDS9VhmPu4kVewpBOJ0+lUIlNEIOdUvrC6gyqpPmUM0D/25h
	 9hWHPMaTBN67SVVD6QaI/BdTJt8TTNAC1Ge8w5k2E7JGpXS1TRpr2ta4fVv8I++Ykz
	 /HoKYLYHDn014Pfl+do9bs7UQt9w2z0D4OiHlimc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 347/374] inet: introduce dst_rtable() helper
Date: Thu,  6 Jun 2024 16:05:26 +0200
Message-ID: <20240606131703.491449842@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 05d6d492097c55f2d153fc3fd33cbe78e1e28e0a ]

I added dst_rt6_info() in commit
e8dfd42c17fa ("ipv6: introduce dst_rt6_info() helper")

This patch does a similar change for IPv4.

Instead of (struct rtable *)dst casts, we can use :

 #define dst_rtable(_ptr) \
             container_of_const(_ptr, struct rtable, dst)

Patch is smaller than IPv6 one, because IPv4 has skb_rtable() helper.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://lore.kernel.org/r/20240429133009.1227754-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 92f1655aa2b2 ("net: fix __dst_negative_advice() race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/addr.c   | 12 +++---------
 drivers/net/vrf.c                |  2 +-
 drivers/s390/net/qeth_core.h     |  5 ++---
 include/linux/skbuff.h           |  9 ---------
 include/net/ip.h                 |  4 ++--
 include/net/route.h              | 11 +++++++++++
 net/atm/clip.c                   |  2 +-
 net/core/dst_cache.c             |  2 +-
 net/core/filter.c                |  3 +--
 net/ipv4/af_inet.c               |  2 +-
 net/ipv4/icmp.c                  | 26 ++++++++++++++------------
 net/ipv4/ip_input.c              |  2 +-
 net/ipv4/ip_output.c             |  8 ++++----
 net/ipv4/route.c                 | 24 +++++++++++-------------
 net/ipv4/udp.c                   |  2 +-
 net/ipv4/xfrm4_policy.c          |  2 +-
 net/l2tp/l2tp_ip.c               |  2 +-
 net/mpls/mpls_iptunnel.c         |  2 +-
 net/netfilter/ipvs/ip_vs_xmit.c  |  2 +-
 net/netfilter/nf_flow_table_ip.c |  4 ++--
 net/netfilter/nft_rt.c           |  2 +-
 net/sctp/protocol.c              |  4 ++--
 net/tipc/udp_media.c             |  2 +-
 23 files changed, 64 insertions(+), 70 deletions(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index f20dfe70fa0e4..be0743dac3fff 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -348,16 +348,10 @@ static int dst_fetch_ha(const struct dst_entry *dst,
 
 static bool has_gateway(const struct dst_entry *dst, sa_family_t family)
 {
-	const struct rtable *rt;
-	const struct rt6_info *rt6;
+	if (family == AF_INET)
+		return dst_rtable(dst)->rt_uses_gateway;
 
-	if (family == AF_INET) {
-		rt = container_of(dst, struct rtable, dst);
-		return rt->rt_uses_gateway;
-	}
-
-	rt6 = dst_rt6_info(dst);
-	return rt6->rt6i_flags & RTF_GATEWAY;
+	return dst_rt6_info(dst)->rt6i_flags & RTF_GATEWAY;
 }
 
 static int fetch_ha(const struct dst_entry *dst, struct rdma_dev_addr *dev_addr,
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 71cfa03a77449..c3af9ad5e1547 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -860,7 +860,7 @@ static int vrf_rt6_create(struct net_device *dev)
 static int vrf_finish_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	struct dst_entry *dst = skb_dst(skb);
-	struct rtable *rt = (struct rtable *)dst;
+	struct rtable *rt = dst_rtable(dst);
 	struct net_device *dev = dst->dev;
 	unsigned int hh_len = LL_RESERVED_SPACE(dev);
 	struct neighbour *neigh;
diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 5f17a2a5d0e33..41fe8a043d61f 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -970,9 +970,8 @@ static inline struct dst_entry *qeth_dst_check_rcu(struct sk_buff *skb,
 static inline __be32 qeth_next_hop_v4_rcu(struct sk_buff *skb,
 					  struct dst_entry *dst)
 {
-	struct rtable *rt = (struct rtable *) dst;
-
-	return (rt) ? rt_nexthop(rt, ip_hdr(skb)->daddr) : ip_hdr(skb)->daddr;
+	return (dst) ? rt_nexthop(dst_rtable(dst), ip_hdr(skb)->daddr) :
+		       ip_hdr(skb)->daddr;
 }
 
 static inline struct in6_addr *qeth_next_hop_v6_rcu(struct sk_buff *skb,
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 4ff48eda3f642..5b1078c160f27 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1174,15 +1174,6 @@ static inline bool skb_dst_is_noref(const struct sk_buff *skb)
 	return (skb->_skb_refdst & SKB_DST_NOREF) && skb_dst(skb);
 }
 
-/**
- * skb_rtable - Returns the skb &rtable
- * @skb: buffer
- */
-static inline struct rtable *skb_rtable(const struct sk_buff *skb)
-{
-	return (struct rtable *)skb_dst(skb);
-}
-
 /* For mangling skb->pkt_type from user space side from applications
  * such as nft, tc, etc, we only allow a conservative subset of
  * possible pkt_types to be set.
diff --git a/include/net/ip.h b/include/net/ip.h
index 25cb688bdc623..6d735e00d3f3e 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -423,7 +423,7 @@ int ip_decrease_ttl(struct iphdr *iph)
 
 static inline int ip_mtu_locked(const struct dst_entry *dst)
 {
-	const struct rtable *rt = (const struct rtable *)dst;
+	const struct rtable *rt = dst_rtable(dst);
 
 	return rt->rt_mtu_locked || dst_metric_locked(dst, RTAX_MTU);
 }
@@ -461,7 +461,7 @@ static inline bool ip_sk_ignore_df(const struct sock *sk)
 static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 						    bool forwarding)
 {
-	const struct rtable *rt = container_of(dst, struct rtable, dst);
+	const struct rtable *rt = dst_rtable(dst);
 	struct net *net = dev_net(dst->dev);
 	unsigned int mtu;
 
diff --git a/include/net/route.h b/include/net/route.h
index d4a0147942f1a..af55401aa8f40 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -77,6 +77,17 @@ struct rtable {
 				rt_pmtu:31;
 };
 
+#define dst_rtable(_ptr) container_of_const(_ptr, struct rtable, dst)
+
+/**
+ * skb_rtable - Returns the skb &rtable
+ * @skb: buffer
+ */
+static inline struct rtable *skb_rtable(const struct sk_buff *skb)
+{
+	return dst_rtable(skb_dst(skb));
+}
+
 static inline bool rt_is_input_route(const struct rtable *rt)
 {
 	return rt->rt_is_input != 0;
diff --git a/net/atm/clip.c b/net/atm/clip.c
index 294cb9efe3d38..015fb679be425 100644
--- a/net/atm/clip.c
+++ b/net/atm/clip.c
@@ -345,7 +345,7 @@ static netdev_tx_t clip_start_xmit(struct sk_buff *skb,
 		dev->stats.tx_dropped++;
 		return NETDEV_TX_OK;
 	}
-	rt = (struct rtable *) dst;
+	rt = dst_rtable(dst);
 	if (rt->rt_gw_family == AF_INET)
 		daddr = &rt->rt_gw4;
 	else
diff --git a/net/core/dst_cache.c b/net/core/dst_cache.c
index b17171345d649..0c0bdb058c5b1 100644
--- a/net/core/dst_cache.c
+++ b/net/core/dst_cache.c
@@ -83,7 +83,7 @@ struct rtable *dst_cache_get_ip4(struct dst_cache *dst_cache, __be32 *saddr)
 		return NULL;
 
 	*saddr = idst->in_saddr.s_addr;
-	return container_of(dst, struct rtable, dst);
+	return dst_rtable(dst);
 }
 EXPORT_SYMBOL_GPL(dst_cache_get_ip4);
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 03c1fdd111f25..a5856a8b4498b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2314,8 +2314,7 @@ static int bpf_out_neigh_v4(struct net *net, struct sk_buff *skb,
 
 	rcu_read_lock();
 	if (!nh) {
-		struct dst_entry *dst = skb_dst(skb);
-		struct rtable *rt = container_of(dst, struct rtable, dst);
+		struct rtable *rt = skb_rtable(skb);
 
 		neigh = ip_neigh_for_gw(rt, skb, &is_v6gw);
 	} else if (nh->nh_family == AF_INET6) {
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index c6bebca49591f..5622ddd3bf55b 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1308,8 +1308,8 @@ static int inet_sk_reselect_saddr(struct sock *sk)
 
 int inet_sk_rebuild_header(struct sock *sk)
 {
+	struct rtable *rt = dst_rtable(__sk_dst_check(sk, 0));
 	struct inet_sock *inet = inet_sk(sk);
-	struct rtable *rt = (struct rtable *)__sk_dst_check(sk, 0);
 	__be32 daddr;
 	struct ip_options_rcu *inet_opt;
 	struct flowi4 *fl4;
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 437e782b9663b..207482d30dc7e 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -483,6 +483,7 @@ static struct rtable *icmp_route_lookup(struct net *net,
 					struct icmp_bxm *param)
 {
 	struct net_device *route_lookup_dev;
+	struct dst_entry *dst, *dst2;
 	struct rtable *rt, *rt2;
 	struct flowi4 fl4_dec;
 	int err;
@@ -508,16 +509,17 @@ static struct rtable *icmp_route_lookup(struct net *net,
 	/* No need to clone since we're just using its address. */
 	rt2 = rt;
 
-	rt = (struct rtable *) xfrm_lookup(net, &rt->dst,
-					   flowi4_to_flowi(fl4), NULL, 0);
-	if (!IS_ERR(rt)) {
+	dst = xfrm_lookup(net, &rt->dst,
+			  flowi4_to_flowi(fl4), NULL, 0);
+	rt = dst_rtable(dst);
+	if (!IS_ERR(dst)) {
 		if (rt != rt2)
 			return rt;
-	} else if (PTR_ERR(rt) == -EPERM) {
+	} else if (PTR_ERR(dst) == -EPERM) {
 		rt = NULL;
-	} else
+	} else {
 		return rt;
-
+	}
 	err = xfrm_decode_session_reverse(net, skb_in, flowi4_to_flowi(&fl4_dec), AF_INET);
 	if (err)
 		goto relookup_failed;
@@ -551,19 +553,19 @@ static struct rtable *icmp_route_lookup(struct net *net,
 	if (err)
 		goto relookup_failed;
 
-	rt2 = (struct rtable *) xfrm_lookup(net, &rt2->dst,
-					    flowi4_to_flowi(&fl4_dec), NULL,
-					    XFRM_LOOKUP_ICMP);
-	if (!IS_ERR(rt2)) {
+	dst2 = xfrm_lookup(net, &rt2->dst, flowi4_to_flowi(&fl4_dec), NULL,
+			   XFRM_LOOKUP_ICMP);
+	rt2 = dst_rtable(dst2);
+	if (!IS_ERR(dst2)) {
 		dst_release(&rt->dst);
 		memcpy(fl4, &fl4_dec, sizeof(*fl4));
 		rt = rt2;
-	} else if (PTR_ERR(rt2) == -EPERM) {
+	} else if (PTR_ERR(dst2) == -EPERM) {
 		if (rt)
 			dst_release(&rt->dst);
 		return rt2;
 	} else {
-		err = PTR_ERR(rt2);
+		err = PTR_ERR(dst2);
 		goto relookup_failed;
 	}
 	return rt;
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 5e9c8156656a7..d6fbcbd2358a5 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -616,7 +616,7 @@ static void ip_list_rcv_finish(struct net *net, struct sock *sk,
 		dst = skb_dst(skb);
 		if (curr_dst != dst) {
 			hint = ip_extract_route_hint(net, skb,
-					       ((struct rtable *)dst)->rt_type);
+						     dst_rtable(dst)->rt_type);
 
 			/* dispatch old sublist */
 			if (!list_empty(&sublist))
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 39229fd0601a1..9500031a1f55b 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -198,7 +198,7 @@ EXPORT_SYMBOL_GPL(ip_build_and_send_pkt);
 static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	struct dst_entry *dst = skb_dst(skb);
-	struct rtable *rt = (struct rtable *)dst;
+	struct rtable *rt = dst_rtable(dst);
 	struct net_device *dev = dst->dev;
 	unsigned int hh_len = LL_RESERVED_SPACE(dev);
 	struct neighbour *neigh;
@@ -475,7 +475,7 @@ int __ip_queue_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl,
 		goto packet_routed;
 
 	/* Make sure we can route this packet. */
-	rt = (struct rtable *)__sk_dst_check(sk, 0);
+	rt = dst_rtable(__sk_dst_check(sk, 0));
 	if (!rt) {
 		__be32 daddr;
 
@@ -971,7 +971,7 @@ static int __ip_append_data(struct sock *sk,
 	bool zc = false;
 	unsigned int maxfraglen, fragheaderlen, maxnonfragsize;
 	int csummode = CHECKSUM_NONE;
-	struct rtable *rt = (struct rtable *)cork->dst;
+	struct rtable *rt = dst_rtable(cork->dst);
 	bool paged, hold_tskey, extra_uref = false;
 	unsigned int wmem_alloc_delta = 0;
 	u32 tskey = 0;
@@ -1390,7 +1390,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 	struct inet_sock *inet = inet_sk(sk);
 	struct net *net = sock_net(sk);
 	struct ip_options *opt = NULL;
-	struct rtable *rt = (struct rtable *)cork->dst;
+	struct rtable *rt = dst_rtable(cork->dst);
 	struct iphdr *iph;
 	u8 pmtudisc, ttl;
 	__be16 df = 0;
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index b814fdab19f71..12738051ebea7 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -831,7 +831,7 @@ static void ip_do_redirect(struct dst_entry *dst, struct sock *sk, struct sk_buf
 	u32 mark = skb->mark;
 	__u8 tos = iph->tos;
 
-	rt = (struct rtable *) dst;
+	rt = dst_rtable(dst);
 
 	__build_flow_key(net, &fl4, sk, iph, oif, tos, prot, mark, 0);
 	__ip_do_redirect(rt, skb, &fl4, true);
@@ -839,7 +839,7 @@ static void ip_do_redirect(struct dst_entry *dst, struct sock *sk, struct sk_buf
 
 static struct dst_entry *ipv4_negative_advice(struct dst_entry *dst)
 {
-	struct rtable *rt = (struct rtable *)dst;
+	struct rtable *rt = dst_rtable(dst);
 	struct dst_entry *ret = dst;
 
 	if (rt) {
@@ -1056,7 +1056,7 @@ static void ip_rt_update_pmtu(struct dst_entry *dst, struct sock *sk,
 			      struct sk_buff *skb, u32 mtu,
 			      bool confirm_neigh)
 {
-	struct rtable *rt = (struct rtable *) dst;
+	struct rtable *rt = dst_rtable(dst);
 	struct flowi4 fl4;
 
 	ip_rt_build_flow_key(&fl4, sk, skb);
@@ -1127,7 +1127,7 @@ void ipv4_sk_update_pmtu(struct sk_buff *skb, struct sock *sk, u32 mtu)
 
 	__build_flow_key(net, &fl4, sk, iph, 0, 0, 0, 0, 0);
 
-	rt = (struct rtable *)odst;
+	rt = dst_rtable(odst);
 	if (odst->obsolete && !odst->ops->check(odst, 0)) {
 		rt = ip_route_output_flow(sock_net(sk), &fl4, sk);
 		if (IS_ERR(rt))
@@ -1136,7 +1136,7 @@ void ipv4_sk_update_pmtu(struct sk_buff *skb, struct sock *sk, u32 mtu)
 		new = true;
 	}
 
-	__ip_rt_update_pmtu((struct rtable *)xfrm_dst_path(&rt->dst), &fl4, mtu);
+	__ip_rt_update_pmtu(dst_rtable(xfrm_dst_path(&rt->dst)), &fl4, mtu);
 
 	if (!dst_check(&rt->dst, 0)) {
 		if (new)
@@ -1193,7 +1193,7 @@ EXPORT_SYMBOL_GPL(ipv4_sk_redirect);
 INDIRECT_CALLABLE_SCOPE struct dst_entry *ipv4_dst_check(struct dst_entry *dst,
 							 u32 cookie)
 {
-	struct rtable *rt = (struct rtable *) dst;
+	struct rtable *rt = dst_rtable(dst);
 
 	/* All IPV4 dsts are created with ->obsolete set to the value
 	 * DST_OBSOLETE_FORCE_CHK which forces validation calls down
@@ -1528,10 +1528,8 @@ void rt_del_uncached_list(struct rtable *rt)
 
 static void ipv4_dst_destroy(struct dst_entry *dst)
 {
-	struct rtable *rt = (struct rtable *)dst;
-
 	ip_dst_metrics_put(dst);
-	rt_del_uncached_list(rt);
+	rt_del_uncached_list(dst_rtable(dst));
 }
 
 void rt_flush_dev(struct net_device *dev)
@@ -2832,7 +2830,7 @@ static struct dst_ops ipv4_dst_blackhole_ops = {
 
 struct dst_entry *ipv4_blackhole_route(struct net *net, struct dst_entry *dst_orig)
 {
-	struct rtable *ort = (struct rtable *) dst_orig;
+	struct rtable *ort = dst_rtable(dst_orig);
 	struct rtable *rt;
 
 	rt = dst_alloc(&ipv4_dst_blackhole_ops, NULL, DST_OBSOLETE_DEAD, 0);
@@ -2877,9 +2875,9 @@ struct rtable *ip_route_output_flow(struct net *net, struct flowi4 *flp4,
 
 	if (flp4->flowi4_proto) {
 		flp4->flowi4_oif = rt->dst.dev->ifindex;
-		rt = (struct rtable *)xfrm_lookup_route(net, &rt->dst,
-							flowi4_to_flowi(flp4),
-							sk, 0);
+		rt = dst_rtable(xfrm_lookup_route(net, &rt->dst,
+						  flowi4_to_flowi(flp4),
+						  sk, 0));
 	}
 
 	return rt;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index b5ad0c527c521..72d3bf136810d 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1218,7 +1218,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 	if (connected)
-		rt = (struct rtable *)sk_dst_check(sk, 0);
+		rt = dst_rtable(sk_dst_check(sk, 0));
 
 	if (!rt) {
 		struct net *net = sock_net(sk);
diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
index c33bca2c38415..1853a8415d9f1 100644
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -69,7 +69,7 @@ static int xfrm4_get_saddr(struct net *net, int oif,
 static int xfrm4_fill_dst(struct xfrm_dst *xdst, struct net_device *dev,
 			  const struct flowi *fl)
 {
-	struct rtable *rt = (struct rtable *)xdst->route;
+	struct rtable *rt = dst_rtable(xdst->route);
 	const struct flowi4 *fl4 = &fl->u.ip4;
 
 	xdst->u.rt.rt_iif = fl4->flowi4_iif;
diff --git a/net/l2tp/l2tp_ip.c b/net/l2tp/l2tp_ip.c
index 970af3983d116..19c8cc5289d59 100644
--- a/net/l2tp/l2tp_ip.c
+++ b/net/l2tp/l2tp_ip.c
@@ -459,7 +459,7 @@ static int l2tp_ip_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	fl4 = &inet->cork.fl.u.ip4;
 	if (connected)
-		rt = (struct rtable *)__sk_dst_check(sk, 0);
+		rt = dst_rtable(__sk_dst_check(sk, 0));
 
 	rcu_read_lock();
 	if (!rt) {
diff --git a/net/mpls/mpls_iptunnel.c b/net/mpls/mpls_iptunnel.c
index 606349c8df0e6..4385fd3b13be3 100644
--- a/net/mpls/mpls_iptunnel.c
+++ b/net/mpls/mpls_iptunnel.c
@@ -81,7 +81,7 @@ static int mpls_xmit(struct sk_buff *skb)
 			ttl = net->mpls.default_ttl;
 		else
 			ttl = ip_hdr(skb)->ttl;
-		rt = (struct rtable *)dst;
+		rt = dst_rtable(dst);
 	} else if (dst->ops->family == AF_INET6) {
 		if (tun_encap_info->ttl_propagate == MPLS_TTL_PROP_DISABLED)
 			ttl = tun_encap_info->default_ttl;
diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index 5cd511162bc03..e1f17392f58c1 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -318,7 +318,7 @@ __ip_vs_get_out_rt(struct netns_ipvs *ipvs, int skb_af, struct sk_buff *skb,
 	if (dest) {
 		dest_dst = __ip_vs_dst_check(dest);
 		if (likely(dest_dst))
-			rt = (struct rtable *) dest_dst->dst_cache;
+			rt = dst_rtable(dest_dst->dst_cache);
 		else {
 			dest_dst = ip_vs_dest_dst_alloc();
 			spin_lock_bh(&dest->dst_lock);
diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 100887beed314..c2c005234dcd3 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -434,7 +434,7 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 		return NF_ACCEPT;
 
 	if (unlikely(tuplehash->tuple.xmit_type == FLOW_OFFLOAD_XMIT_XFRM)) {
-		rt = (struct rtable *)tuplehash->tuple.dst_cache;
+		rt = dst_rtable(tuplehash->tuple.dst_cache);
 		memset(skb->cb, 0, sizeof(struct inet_skb_parm));
 		IPCB(skb)->iif = skb->dev->ifindex;
 		IPCB(skb)->flags = IPSKB_FORWARDED;
@@ -446,7 +446,7 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 
 	switch (tuplehash->tuple.xmit_type) {
 	case FLOW_OFFLOAD_XMIT_NEIGH:
-		rt = (struct rtable *)tuplehash->tuple.dst_cache;
+		rt = dst_rtable(tuplehash->tuple.dst_cache);
 		outdev = rt->dst.dev;
 		skb->dev = outdev;
 		nexthop = rt_nexthop(rt, flow->tuplehash[!dir].tuple.src_v4.s_addr);
diff --git a/net/netfilter/nft_rt.c b/net/netfilter/nft_rt.c
index 2434c624aafde..14d88394bcb7f 100644
--- a/net/netfilter/nft_rt.c
+++ b/net/netfilter/nft_rt.c
@@ -73,7 +73,7 @@ void nft_rt_get_eval(const struct nft_expr *expr,
 		if (nft_pf(pkt) != NFPROTO_IPV4)
 			goto err;
 
-		*dest = (__force u32)rt_nexthop((const struct rtable *)dst,
+		*dest = (__force u32)rt_nexthop(dst_rtable(dst),
 						ip_hdr(skb)->daddr);
 		break;
 	case NFT_RT_NEXTHOP6:
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index e849f368ed913..5a7436a13b741 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -552,7 +552,7 @@ static void sctp_v4_get_saddr(struct sctp_sock *sk,
 			      struct flowi *fl)
 {
 	union sctp_addr *saddr = &t->saddr;
-	struct rtable *rt = (struct rtable *)t->dst;
+	struct rtable *rt = dst_rtable(t->dst);
 
 	if (rt) {
 		saddr->v4.sin_family = AF_INET;
@@ -1085,7 +1085,7 @@ static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_reset_inner_mac_header(skb);
 	skb_reset_inner_transport_header(skb);
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
-	udp_tunnel_xmit_skb((struct rtable *)dst, sk, skb, fl4->saddr,
+	udp_tunnel_xmit_skb(dst_rtable(dst), sk, skb, fl4->saddr,
 			    fl4->daddr, dscp, ip4_dst_hoplimit(dst), df,
 			    sctp_sk(sk)->udp_port, t->encap_port, false, false);
 	return 0;
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index f892b0903dbaf..b849a3d133a01 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -174,7 +174,7 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 	local_bh_disable();
 	ndst = dst_cache_get(cache);
 	if (dst->proto == htons(ETH_P_IP)) {
-		struct rtable *rt = (struct rtable *)ndst;
+		struct rtable *rt = dst_rtable(ndst);
 
 		if (!rt) {
 			struct flowi4 fl = {
-- 
2.43.0




