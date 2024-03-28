Return-Path: <stable+bounces-26666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 400D9870F93
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648B41C21ADF
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B860E79DCA;
	Mon,  4 Mar 2024 21:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d5vCnhON"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CE61C6AB;
	Mon,  4 Mar 2024 21:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709589363; cv=none; b=k+fqcMadjtOZESvxJUtOxJbpNKkuNZbFnLwaPVV/vJ2AHmNHTH8Zwy8K5jEmxOjZTXDX71BrHoiqiL/pTt9SCenMNAAJQYWELGhMul1wXZ1Akv9R/lGBbEQo/iZCgRxbgAy9tYjR2nLg7u3w19wdGqd47NM72PaQC+PO84uqpc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709589363; c=relaxed/simple;
	bh=9Q9HUpP8F5YfEeSDvAOF8flxdxD4H24CmA4nHM8Mmws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqjyNVyq3bxPBVBXIZCiG6X1VucAekkegP1MaO94l8uJmC2kjquVWq2w656Ys02TSdAw7Vhirf3y/kG843JW5LgTCSX/LyCi97PJi5hIxzf8XUR+f19ANWCEH3KkZMtIlGSEL1Smm1LeXX+GCoPsKu34ToSq4YgiZvj809+XQ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d5vCnhON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D6DC433F1;
	Mon,  4 Mar 2024 21:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709589363;
	bh=9Q9HUpP8F5YfEeSDvAOF8flxdxD4H24CmA4nHM8Mmws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d5vCnhONtEWSJXNPuv4RTVpqF2iDA8urOf3vl9awzG/IhJT3gd5VnFci1tFv1P4s0
	 l2zoYEcrYZSU9nJiREniXxgCv1mT7+B6lH9XllloGxn+9UWEWHnOT75K8uFBIK/ukx
	 pjwV5uSo7c6X/odr42OLt38WlmvTzdjQzpX/Hq9Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Martynas Pumputis <m@lambda.lt>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 5.15 81/84] bpf: Derive source IP addr via bpf_*_fib_lookup()
Date: Mon,  4 Mar 2024 21:24:54 +0000
Message-ID: <20240304211545.117712168@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211542.332206551@linuxfoundation.org>
References: <20240304211542.332206551@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martynas Pumputis <m@lambda.lt>

commit dab4e1f06cabb6834de14264394ccab197007302 upstream.

Extend the bpf_fib_lookup() helper by making it to return the source
IPv4/IPv6 address if the BPF_FIB_LOOKUP_SRC flag is set.

For example, the following snippet can be used to derive the desired
source IP address:

    struct bpf_fib_lookup p = { .ipv4_dst = ip4->daddr };

    ret = bpf_skb_fib_lookup(skb, p, sizeof(p),
            BPF_FIB_LOOKUP_SRC | BPF_FIB_LOOKUP_SKIP_NEIGH);
    if (ret != BPF_FIB_LKUP_RET_SUCCESS)
        return TC_ACT_SHOT;

    /* the p.ipv4_src now contains the source address */

The inability to derive the proper source address may cause malfunctions
in BPF-based dataplanes for hosts containing netdevs with more than one
routable IP address or for multi-homed hosts.

For example, Cilium implements packet masquerading in BPF. If an
egressing netdev to which the Cilium's BPF prog is attached has
multiple IP addresses, then only one [hardcoded] IP address can be used for
masquerading. This breaks connectivity if any other IP address should have
been selected instead, for example, when a public and private addresses
are attached to the same egress interface.

The change was tested with Cilium [1].

Nikolay Aleksandrov helped to figure out the IPv6 addr selection.

[1]: https://github.com/cilium/cilium/pull/28283

Signed-off-by: Martynas Pumputis <m@lambda.lt>
Link: https://lore.kernel.org/r/20231007081415.33502-2-m@lambda.lt
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/ipv6_stubs.h       |    5 +++++
 include/uapi/linux/bpf.h       |   10 ++++++++++
 net/core/filter.c              |   18 +++++++++++++++++-
 net/ipv6/af_inet6.c            |    1 +
 tools/include/uapi/linux/bpf.h |   10 ++++++++++
 5 files changed, 43 insertions(+), 1 deletion(-)

--- a/include/net/ipv6_stubs.h
+++ b/include/net/ipv6_stubs.h
@@ -81,6 +81,11 @@ struct ipv6_bpf_stub {
 				     const struct in6_addr *daddr, __be16 dport,
 				     int dif, int sdif, struct udp_table *tbl,
 				     struct sk_buff *skb);
+	int (*ipv6_dev_get_saddr)(struct net *net,
+				  const struct net_device *dst_dev,
+				  const struct in6_addr *daddr,
+				  unsigned int prefs,
+				  struct in6_addr *saddr);
 };
 extern const struct ipv6_bpf_stub *ipv6_bpf_stub __read_mostly;
 
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3023,6 +3023,11 @@ union bpf_attr {
  *			and *params*->smac will not be set as output. A common
  *			use case is to call **bpf_redirect_neigh**\ () after
  *			doing **bpf_fib_lookup**\ ().
+ *		**BPF_FIB_LOOKUP_SRC**
+ *			Derive and set source IP addr in *params*->ipv{4,6}_src
+ *			for the nexthop. If the src addr cannot be derived,
+ *			**BPF_FIB_LKUP_RET_NO_SRC_ADDR** is returned. In this
+ *			case, *params*->dmac and *params*->smac are not set either.
  *
  *		*ctx* is either **struct xdp_md** for XDP programs or
  *		**struct sk_buff** tc cls_act programs.
@@ -6051,6 +6056,7 @@ enum {
 	BPF_FIB_LOOKUP_OUTPUT  = (1U << 1),
 	BPF_FIB_LOOKUP_SKIP_NEIGH = (1U << 2),
 	BPF_FIB_LOOKUP_TBID    = (1U << 3),
+	BPF_FIB_LOOKUP_SRC     = (1U << 4),
 };
 
 enum {
@@ -6063,6 +6069,7 @@ enum {
 	BPF_FIB_LKUP_RET_UNSUPP_LWT,   /* fwd requires encapsulation */
 	BPF_FIB_LKUP_RET_NO_NEIGH,     /* no neighbor entry for nh */
 	BPF_FIB_LKUP_RET_FRAG_NEEDED,  /* fragmentation required to fwd */
+	BPF_FIB_LKUP_RET_NO_SRC_ADDR,  /* failed to derive IP src addr */
 };
 
 struct bpf_fib_lookup {
@@ -6097,6 +6104,9 @@ struct bpf_fib_lookup {
 		__u32	rt_metric;
 	};
 
+	/* input: source address to consider for lookup
+	 * output: source address result from lookup
+	 */
 	union {
 		__be32		ipv4_src;
 		__u32		ipv6_src[4];  /* in6_addr; network order */
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5504,6 +5504,9 @@ static int bpf_ipv4_fib_lookup(struct ne
 	params->rt_metric = res.fi->fib_priority;
 	params->ifindex = dev->ifindex;
 
+	if (flags & BPF_FIB_LOOKUP_SRC)
+		params->ipv4_src = fib_result_prefsrc(net, &res);
+
 	/* xdp and cls_bpf programs are run in RCU-bh so
 	 * rcu_read_lock_bh is not needed here
 	 */
@@ -5646,6 +5649,18 @@ static int bpf_ipv6_fib_lookup(struct ne
 	params->rt_metric = res.f6i->fib6_metric;
 	params->ifindex = dev->ifindex;
 
+	if (flags & BPF_FIB_LOOKUP_SRC) {
+		if (res.f6i->fib6_prefsrc.plen) {
+			*src = res.f6i->fib6_prefsrc.addr;
+		} else {
+			err = ipv6_bpf_stub->ipv6_dev_get_saddr(net, dev,
+								&fl6.daddr, 0,
+								src);
+			if (err)
+				return BPF_FIB_LKUP_RET_NO_SRC_ADDR;
+		}
+	}
+
 	if (flags & BPF_FIB_LOOKUP_SKIP_NEIGH)
 		goto set_fwd_params;
 
@@ -5664,7 +5679,8 @@ set_fwd_params:
 #endif
 
 #define BPF_FIB_LOOKUP_MASK (BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_OUTPUT | \
-			     BPF_FIB_LOOKUP_SKIP_NEIGH | BPF_FIB_LOOKUP_TBID)
+			     BPF_FIB_LOOKUP_SKIP_NEIGH | BPF_FIB_LOOKUP_TBID | \
+			     BPF_FIB_LOOKUP_SRC)
 
 BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
 	   struct bpf_fib_lookup *, params, int, plen, u32, flags)
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -1061,6 +1061,7 @@ static const struct ipv6_stub ipv6_stub_
 static const struct ipv6_bpf_stub ipv6_bpf_stub_impl = {
 	.inet6_bind = __inet6_bind,
 	.udp6_lib_lookup = __udp6_lib_lookup,
+	.ipv6_dev_get_saddr = ipv6_dev_get_saddr,
 };
 
 static int __init inet6_init(void)
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3023,6 +3023,11 @@ union bpf_attr {
  *			and *params*->smac will not be set as output. A common
  *			use case is to call **bpf_redirect_neigh**\ () after
  *			doing **bpf_fib_lookup**\ ().
+ *		**BPF_FIB_LOOKUP_SRC**
+ *			Derive and set source IP addr in *params*->ipv{4,6}_src
+ *			for the nexthop. If the src addr cannot be derived,
+ *			**BPF_FIB_LKUP_RET_NO_SRC_ADDR** is returned. In this
+ *			case, *params*->dmac and *params*->smac are not set either.
  *
  *		*ctx* is either **struct xdp_md** for XDP programs or
  *		**struct sk_buff** tc cls_act programs.
@@ -6051,6 +6056,7 @@ enum {
 	BPF_FIB_LOOKUP_OUTPUT  = (1U << 1),
 	BPF_FIB_LOOKUP_SKIP_NEIGH = (1U << 2),
 	BPF_FIB_LOOKUP_TBID    = (1U << 3),
+	BPF_FIB_LOOKUP_SRC     = (1U << 4),
 };
 
 enum {
@@ -6063,6 +6069,7 @@ enum {
 	BPF_FIB_LKUP_RET_UNSUPP_LWT,   /* fwd requires encapsulation */
 	BPF_FIB_LKUP_RET_NO_NEIGH,     /* no neighbor entry for nh */
 	BPF_FIB_LKUP_RET_FRAG_NEEDED,  /* fragmentation required to fwd */
+	BPF_FIB_LKUP_RET_NO_SRC_ADDR,  /* failed to derive IP src addr */
 };
 
 struct bpf_fib_lookup {
@@ -6097,6 +6104,9 @@ struct bpf_fib_lookup {
 		__u32	rt_metric;
 	};
 
+	/* input: source address to consider for lookup
+	 * output: source address result from lookup
+	 */
 	union {
 		__be32		ipv4_src;
 		__u32		ipv6_src[4];  /* in6_addr; network order */



