Return-Path: <stable+bounces-86315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB1B99ED3A
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 15:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8CA1F24E39
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC221EBA0A;
	Tue, 15 Oct 2024 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IW71Kv8K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998791C07DF;
	Tue, 15 Oct 2024 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998495; cv=none; b=OiEnTbk+w/9zW2UYB6H33vtm/ouegemAt0JbV0HBV8qOLNUNA52itdCAlpYOKlvigQY2pIzJlv5JHkxUCeBefdG3eRb9b2J+Ey+ZPZc0p/BJ1K1PCaihPSoJPZjzcQ7pchEXz9rlyLGI9T6jsvj1bDzYvGHFP1eqrtxtFVSe4YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998495; c=relaxed/simple;
	bh=/YeL3IZn/Sq7RfMEIzacD5Gj2ozTRNF/Y11fRFGWlvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNiX86QH/Gnb/5S5bdOdRa3eG6x8+SG0ZDuDSAVcpea2y6qy/dp7QdY08EFB0f/NHAkUG/0nwOFt9NO3FEpwdc/phHV0sD7rLINYnFbi32v2QQjDeB7LuNgjul/GQFRFFfBZFhm1ZoS+LGsaDGVAKSNHliauIkGpotjWSVwA0RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IW71Kv8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7426C4CEC6;
	Tue, 15 Oct 2024 13:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728998495;
	bh=/YeL3IZn/Sq7RfMEIzacD5Gj2ozTRNF/Y11fRFGWlvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IW71Kv8K2W5ZuL7Zh16WTcVAhMem5mvtGOmBa30UPHwH+bIUOk3dBuj7w/VwZaAtg
	 gRyakxnqPAIHwRQ6tdFnTb1iSY0KHgo78ac+JvamVbFkZJHNIAS4CE7Pg6OXLT9BSc
	 lLh+T/kM4pFWObthzDUCRsWWtu7+sA01kGskuLIE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Ahern <dsahern@kernel.org>,
	Ben Greear <greearb@candelatech.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 493/518] net: Add l3mdev index to flow struct and avoid oif reset for port devices
Date: Tue, 15 Oct 2024 14:46:37 +0200
Message-ID: <20241015123936.026137649@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
References: <20241015123916.821186887@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Ahern <dsahern@kernel.org>

[ Upstream commit 40867d74c374b235e14d839f3a77f26684feefe5 ]

The fundamental premise of VRF and l3mdev core code is binding a socket
to a device (l3mdev or netdev with an L3 domain) to indicate L3 scope.
Legacy code resets flowi_oif to the l3mdev losing any original port
device binding. Ben (among others) has demonstrated use cases where the
original port device binding is important and needs to be retained.
This patch handles that by adding a new entry to the common flow struct
that can indicate the l3mdev index for later rule and table matching
avoiding the need to reset flowi_oif.

In addition to allowing more use cases that require port device binds,
this patch brings a few datapath simplications:

1. l3mdev_fib_rule_match is only called when walking fib rules and
   always after l3mdev_update_flow. That allows an optimization to bail
   early for non-VRF type uses cases when flowi_l3mdev is not set. Also,
   only that index needs to be checked for the FIB table id.

2. l3mdev_update_flow can be called with flowi_oif set to a l3mdev
   (e.g., VRF) device. By resetting flowi_oif only for this case the
   FLOWI_FLAG_SKIP_NH_OIF flag is not longer needed and can be removed,
   removing several checks in the datapath. The flowi_iif path can be
   simplified to only be called if the it is not loopback (loopback can
   not be assigned to an L3 domain) and the l3mdev index is not already
   set.

3. Avoid another device lookup in the output path when the fib lookup
   returns a reject failure.

Note: 2 functional tests for local traffic with reject fib rules are
updated to reflect the new direct failure at FIB lookup time for ping
rather than the failure on packet path. The current code fails like this:

    HINT: Fails since address on vrf device is out of device scope
    COMMAND: ip netns exec ns-A ping -c1 -w1 -I eth1 172.16.3.1
    ping: Warning: source address might be selected on device other than: eth1
    PING 172.16.3.1 (172.16.3.1) from 172.16.3.1 eth1: 56(84) bytes of data.

    --- 172.16.3.1 ping statistics ---
    1 packets transmitted, 0 received, 100% packet loss, time 0ms

where the test now directly fails:

    HINT: Fails since address on vrf device is out of device scope
    COMMAND: ip netns exec ns-A ping -c1 -w1 -I eth1 172.16.3.1
    ping: connect: No route to host

Signed-off-by: David Ahern <dsahern@kernel.org>
Tested-by: Ben Greear <greearb@candelatech.com>
Link: https://lore.kernel.org/r/20220314204551.16369-1-dsahern@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 05ef7055debc ("netfilter: fib: check correct rtable in vrf setups")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vrf.c                         |  7 ++--
 include/net/flow.h                        |  6 +++-
 net/ipv4/fib_frontend.c                   |  7 ++--
 net/ipv4/fib_semantics.c                  |  2 +-
 net/ipv4/fib_trie.c                       |  7 ++--
 net/ipv4/route.c                          |  4 +--
 net/ipv4/xfrm4_policy.c                   |  4 +--
 net/ipv6/ip6_output.c                     |  3 +-
 net/ipv6/route.c                          | 12 -------
 net/ipv6/xfrm6_policy.c                   |  3 +-
 net/l3mdev/l3mdev.c                       | 43 +++++++++--------------
 tools/testing/selftests/net/fcnal-test.sh |  2 +-
 12 files changed, 37 insertions(+), 63 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 8ab0b5a8dfeff..13ad434643b80 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -470,14 +470,13 @@ static netdev_tx_t vrf_process_v6_outbound(struct sk_buff *skb,
 
 	memset(&fl6, 0, sizeof(fl6));
 	/* needed to match OIF rule */
-	fl6.flowi6_oif = dev->ifindex;
+	fl6.flowi6_l3mdev = dev->ifindex;
 	fl6.flowi6_iif = LOOPBACK_IFINDEX;
 	fl6.daddr = iph->daddr;
 	fl6.saddr = iph->saddr;
 	fl6.flowlabel = ip6_flowinfo(iph);
 	fl6.flowi6_mark = skb->mark;
 	fl6.flowi6_proto = iph->nexthdr;
-	fl6.flowi6_flags = FLOWI_FLAG_SKIP_NH_OIF;
 
 	dst = ip6_dst_lookup_flow(net, NULL, &fl6, NULL);
 	if (IS_ERR(dst) || dst == dst_null)
@@ -550,10 +549,10 @@ static netdev_tx_t vrf_process_v4_outbound(struct sk_buff *skb,
 
 	memset(&fl4, 0, sizeof(fl4));
 	/* needed to match OIF rule */
-	fl4.flowi4_oif = vrf_dev->ifindex;
+	fl4.flowi4_l3mdev = vrf_dev->ifindex;
 	fl4.flowi4_iif = LOOPBACK_IFINDEX;
 	fl4.flowi4_tos = RT_TOS(ip4h->tos);
-	fl4.flowi4_flags = FLOWI_FLAG_ANYSRC | FLOWI_FLAG_SKIP_NH_OIF;
+	fl4.flowi4_flags = FLOWI_FLAG_ANYSRC;
 	fl4.flowi4_proto = ip4h->protocol;
 	fl4.daddr = ip4h->daddr;
 	fl4.saddr = ip4h->saddr;
diff --git a/include/net/flow.h b/include/net/flow.h
index 7ffa1fe1107cc..1c19af4f3b97e 100644
--- a/include/net/flow.h
+++ b/include/net/flow.h
@@ -29,6 +29,7 @@ struct flowi_tunnel {
 struct flowi_common {
 	int	flowic_oif;
 	int	flowic_iif;
+	int     flowic_l3mdev;
 	__u32	flowic_mark;
 	__u8	flowic_tos;
 	__u8	flowic_scope;
@@ -36,7 +37,6 @@ struct flowi_common {
 	__u8	flowic_flags;
 #define FLOWI_FLAG_ANYSRC		0x01
 #define FLOWI_FLAG_KNOWN_NH		0x02
-#define FLOWI_FLAG_SKIP_NH_OIF		0x04
 	__u32	flowic_secid;
 	kuid_t  flowic_uid;
 	__u32		flowic_multipath_hash;
@@ -66,6 +66,7 @@ struct flowi4 {
 	struct flowi_common	__fl_common;
 #define flowi4_oif		__fl_common.flowic_oif
 #define flowi4_iif		__fl_common.flowic_iif
+#define flowi4_l3mdev		__fl_common.flowic_l3mdev
 #define flowi4_mark		__fl_common.flowic_mark
 #define flowi4_tos		__fl_common.flowic_tos
 #define flowi4_scope		__fl_common.flowic_scope
@@ -99,6 +100,7 @@ static inline void flowi4_init_output(struct flowi4 *fl4, int oif,
 {
 	fl4->flowi4_oif = oif;
 	fl4->flowi4_iif = LOOPBACK_IFINDEX;
+	fl4->flowi4_l3mdev = 0;
 	fl4->flowi4_mark = mark;
 	fl4->flowi4_tos = tos;
 	fl4->flowi4_scope = scope;
@@ -129,6 +131,7 @@ struct flowi6 {
 	struct flowi_common	__fl_common;
 #define flowi6_oif		__fl_common.flowic_oif
 #define flowi6_iif		__fl_common.flowic_iif
+#define flowi6_l3mdev		__fl_common.flowic_l3mdev
 #define flowi6_mark		__fl_common.flowic_mark
 #define flowi6_scope		__fl_common.flowic_scope
 #define flowi6_proto		__fl_common.flowic_proto
@@ -159,6 +162,7 @@ struct flowi {
 	} u;
 #define flowi_oif	u.__fl_common.flowic_oif
 #define flowi_iif	u.__fl_common.flowic_iif
+#define flowi_l3mdev	u.__fl_common.flowic_l3mdev
 #define flowi_mark	u.__fl_common.flowic_mark
 #define flowi_tos	u.__fl_common.flowic_tos
 #define flowi_scope	u.__fl_common.flowic_scope
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 0394146f813c5..5e2a003cd83c7 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -290,7 +290,7 @@ __be32 fib_compute_spec_dst(struct sk_buff *skb)
 		bool vmark = in_dev && IN_DEV_SRC_VMARK(in_dev);
 		struct flowi4 fl4 = {
 			.flowi4_iif = LOOPBACK_IFINDEX,
-			.flowi4_oif = l3mdev_master_ifindex_rcu(dev),
+			.flowi4_l3mdev = l3mdev_master_ifindex_rcu(dev),
 			.daddr = ip_hdr(skb)->saddr,
 			.flowi4_tos = ip_hdr(skb)->tos & IPTOS_RT_MASK,
 			.flowi4_scope = scope,
@@ -352,9 +352,8 @@ static int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 	bool dev_match;
 
 	fl4.flowi4_oif = 0;
-	fl4.flowi4_iif = l3mdev_master_ifindex_rcu(dev);
-	if (!fl4.flowi4_iif)
-		fl4.flowi4_iif = oif ? : LOOPBACK_IFINDEX;
+	fl4.flowi4_l3mdev = l3mdev_master_ifindex_rcu(dev);
+	fl4.flowi4_iif = oif ? : LOOPBACK_IFINDEX;
 	fl4.daddr = src;
 	fl4.saddr = dst;
 	fl4.flowi4_tos = tos;
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index bb5255178d75c..a308d3f0f845c 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -2268,7 +2268,7 @@ void fib_select_multipath(struct fib_result *res, int hash)
 void fib_select_path(struct net *net, struct fib_result *res,
 		     struct flowi4 *fl4, const struct sk_buff *skb)
 {
-	if (fl4->flowi4_oif && !(fl4->flowi4_flags & FLOWI_FLAG_SKIP_NH_OIF))
+	if (fl4->flowi4_oif)
 		goto check_saddr;
 
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 3f4f6458d40e9..1bdcdc79d43f9 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -1384,11 +1384,8 @@ bool fib_lookup_good_nhc(const struct fib_nh_common *nhc, int fib_flags,
 	    !(fib_flags & FIB_LOOKUP_IGNORE_LINKSTATE))
 		return false;
 
-	if (!(flp->flowi4_flags & FLOWI_FLAG_SKIP_NH_OIF)) {
-		if (flp->flowi4_oif &&
-		    flp->flowi4_oif != nhc->nhc_oif)
-			return false;
-	}
+	if (flp->flowi4_oif && flp->flowi4_oif != nhc->nhc_oif)
+		return false;
 
 	return true;
 }
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 1eb1e4316ed6d..c34386a9d99b4 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2200,6 +2200,7 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	/*
 	 *	Now we are ready to route packet.
 	 */
+	fl4.flowi4_l3mdev = 0;
 	fl4.flowi4_oif = 0;
 	fl4.flowi4_iif = dev->ifindex;
 	fl4.flowi4_mark = skb->mark;
@@ -2676,8 +2677,7 @@ struct rtable *ip_route_output_key_hash_rcu(struct net *net, struct flowi4 *fl4,
 		res->fi = NULL;
 		res->table = NULL;
 		if (fl4->flowi4_oif &&
-		    (ipv4_is_multicast(fl4->daddr) ||
-		    !netif_index_is_l3_master(net, fl4->flowi4_oif))) {
+		    (ipv4_is_multicast(fl4->daddr) || !fl4->flowi4_l3mdev)) {
 			/* Apparently, routing tables are wrong. Assume,
 			   that the destination is on link.
 
diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
index 9ebd54752e03b..4548a91acdc89 100644
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -28,13 +28,11 @@ static struct dst_entry *__xfrm4_dst_lookup(struct net *net, struct flowi4 *fl4,
 	memset(fl4, 0, sizeof(*fl4));
 	fl4->daddr = daddr->a4;
 	fl4->flowi4_tos = tos;
-	fl4->flowi4_oif = l3mdev_master_ifindex_by_index(net, oif);
+	fl4->flowi4_l3mdev = l3mdev_master_ifindex_by_index(net, oif);
 	fl4->flowi4_mark = mark;
 	if (saddr)
 		fl4->saddr = saddr->a4;
 
-	fl4->flowi4_flags = FLOWI_FLAG_SKIP_NH_OIF;
-
 	rt = __ip_route_output_key(net, fl4);
 	if (!IS_ERR(rt))
 		return &rt->dst;
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 436733021b1e9..26d8105981e96 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1067,8 +1067,7 @@ static struct dst_entry *ip6_sk_dst_check(struct sock *sk,
 #ifdef CONFIG_IPV6_SUBTREES
 	    ip6_rt_check(&rt->rt6i_src, &fl6->saddr, np->saddr_cache) ||
 #endif
-	   (!(fl6->flowi6_flags & FLOWI_FLAG_SKIP_NH_OIF) &&
-	      (fl6->flowi6_oif && fl6->flowi6_oif != dst->dev->ifindex))) {
+	   (fl6->flowi6_oif && fl6->flowi6_oif != dst->dev->ifindex)) {
 		dst_release(dst);
 		dst = NULL;
 	}
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 799779475c7de..37e05a77fe49e 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1207,9 +1207,6 @@ INDIRECT_CALLABLE_SCOPE struct rt6_info *ip6_pol_route_lookup(struct net *net,
 	struct fib6_node *fn;
 	struct rt6_info *rt;
 
-	if (fl6->flowi6_flags & FLOWI_FLAG_SKIP_NH_OIF)
-		flags &= ~RT6_LOOKUP_F_IFACE;
-
 	rcu_read_lock();
 	fn = fib6_node_lookup(&table->tb6_root, &fl6->daddr, &fl6->saddr);
 restart:
@@ -2183,9 +2180,6 @@ int fib6_table_lookup(struct net *net, struct fib6_table *table, int oif,
 	fn = fib6_node_lookup(&table->tb6_root, &fl6->daddr, &fl6->saddr);
 	saved_fn = fn;
 
-	if (fl6->flowi6_flags & FLOWI_FLAG_SKIP_NH_OIF)
-		oif = 0;
-
 redo_rt6_select:
 	rt6_select(net, fn, oif, res, strict);
 	if (res->f6i == net->ipv6.fib6_null_entry) {
@@ -2932,12 +2926,6 @@ INDIRECT_CALLABLE_SCOPE struct rt6_info *__ip6_route_redirect(struct net *net,
 	struct fib6_info *rt;
 	struct fib6_node *fn;
 
-	/* l3mdev_update_flow overrides oif if the device is enslaved; in
-	 * this case we must match on the real ingress device, so reset it
-	 */
-	if (fl6->flowi6_flags & FLOWI_FLAG_SKIP_NH_OIF)
-		fl6->flowi6_oif = skb->dev->ifindex;
-
 	/* Get the "current" route for this destination and
 	 * check if the redirect has come from appropriate router.
 	 *
diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index 7c903e0e446cb..492b9692c0dc0 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -33,8 +33,7 @@ static struct dst_entry *xfrm6_dst_lookup(struct net *net, int tos, int oif,
 	int err;
 
 	memset(&fl6, 0, sizeof(fl6));
-	fl6.flowi6_oif = l3mdev_master_ifindex_by_index(net, oif);
-	fl6.flowi6_flags = FLOWI_FLAG_SKIP_NH_OIF;
+	fl6.flowi6_l3mdev = l3mdev_master_ifindex_by_index(net, oif);
 	fl6.flowi6_mark = mark;
 	memcpy(&fl6.daddr, daddr, sizeof(fl6.daddr));
 	if (saddr)
diff --git a/net/l3mdev/l3mdev.c b/net/l3mdev/l3mdev.c
index f2c3a61ad134b..42794581762cb 100644
--- a/net/l3mdev/l3mdev.c
+++ b/net/l3mdev/l3mdev.c
@@ -249,25 +249,19 @@ int l3mdev_fib_rule_match(struct net *net, struct flowi *fl,
 	struct net_device *dev;
 	int rc = 0;
 
-	rcu_read_lock();
+	/* update flow ensures flowi_l3mdev is set when relevant */
+	if (!fl->flowi_l3mdev)
+		return 0;
 
-	dev = dev_get_by_index_rcu(net, fl->flowi_oif);
-	if (dev && netif_is_l3_master(dev) &&
-	    dev->l3mdev_ops->l3mdev_fib_table) {
-		arg->table = dev->l3mdev_ops->l3mdev_fib_table(dev);
-		rc = 1;
-		goto out;
-	}
+	rcu_read_lock();
 
-	dev = dev_get_by_index_rcu(net, fl->flowi_iif);
+	dev = dev_get_by_index_rcu(net, fl->flowi_l3mdev);
 	if (dev && netif_is_l3_master(dev) &&
 	    dev->l3mdev_ops->l3mdev_fib_table) {
 		arg->table = dev->l3mdev_ops->l3mdev_fib_table(dev);
 		rc = 1;
-		goto out;
 	}
 
-out:
 	rcu_read_unlock();
 
 	return rc;
@@ -276,31 +270,28 @@ int l3mdev_fib_rule_match(struct net *net, struct flowi *fl,
 void l3mdev_update_flow(struct net *net, struct flowi *fl)
 {
 	struct net_device *dev;
-	int ifindex;
 
 	rcu_read_lock();
 
 	if (fl->flowi_oif) {
 		dev = dev_get_by_index_rcu(net, fl->flowi_oif);
 		if (dev) {
-			ifindex = l3mdev_master_ifindex_rcu(dev);
-			if (ifindex) {
-				fl->flowi_oif = ifindex;
-				fl->flowi_flags |= FLOWI_FLAG_SKIP_NH_OIF;
-				goto out;
-			}
+			if (!fl->flowi_l3mdev)
+				fl->flowi_l3mdev = l3mdev_master_ifindex_rcu(dev);
+
+			/* oif set to L3mdev directs lookup to its table;
+			 * reset to avoid oif match in fib_lookup
+			 */
+			if (netif_is_l3_master(dev))
+				fl->flowi_oif = 0;
+			goto out;
 		}
 	}
 
-	if (fl->flowi_iif) {
+	if (fl->flowi_iif > LOOPBACK_IFINDEX && !fl->flowi_l3mdev) {
 		dev = dev_get_by_index_rcu(net, fl->flowi_iif);
-		if (dev) {
-			ifindex = l3mdev_master_ifindex_rcu(dev);
-			if (ifindex) {
-				fl->flowi_iif = ifindex;
-				fl->flowi_flags |= FLOWI_FLAG_SKIP_NH_OIF;
-			}
-		}
+		if (dev)
+			fl->flowi_l3mdev = l3mdev_master_ifindex_rcu(dev);
 	}
 
 out:
diff --git a/tools/testing/selftests/net/fcnal-test.sh b/tools/testing/selftests/net/fcnal-test.sh
index e13b0fb63333f..acffe0029fdd1 100755
--- a/tools/testing/selftests/net/fcnal-test.sh
+++ b/tools/testing/selftests/net/fcnal-test.sh
@@ -741,7 +741,7 @@ ipv4_ping_vrf()
 		log_start
 		show_hint "Fails since address on vrf device is out of device scope"
 		run_cmd ping -c1 -w1 -I ${NSA_DEV} ${a}
-		log_test_addr ${a} $? 1 "ping local, device bind"
+		log_test_addr ${a} $? 2 "ping local, device bind"
 	done
 
 	#
-- 
2.43.0




