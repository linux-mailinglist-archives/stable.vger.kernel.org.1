Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62EF79BF8B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354128AbjIKVwe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241426AbjIKPI0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:08:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E65CCC
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:08:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91C4C433C8;
        Mon, 11 Sep 2023 15:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444901;
        bh=tz5mV7Ij1LRuoOhK2AYFtKVhp63LdM8r994kOP1Jj48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kil/kpui9dKxMddqmpGcJA5FW3JhGAmcev8KlDH8Y2M60NpPpEEE07nr4b5tc0Hcg
         NnwzlPk+/d3GPP+4t4BOcYaHdNdy5X3J/JerAYR9Sj1oMuw9DLAEtz0drYSE0xnpI4
         DNPrMMS2/p+4uDgwAbm/GOglET0ugfA7UlAIMQlw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniel Borkmann <daniel@iogearbox.net>,
        Joe Stringer <joe@cilium.io>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Lorenz Bauer <lmb@isovalent.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 155/600] bpf, net: Support SO_REUSEPORT sockets with bpf_sk_assign
Date:   Mon, 11 Sep 2023 15:43:08 +0200
Message-ID: <20230911134638.186101693@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenz Bauer <lmb@isovalent.com>

[ Upstream commit 9c02bec95954252c3c01bfbb3f7560e0b95ca955 ]

Currently the bpf_sk_assign helper in tc BPF context refuses SO_REUSEPORT
sockets. This means we can't use the helper to steer traffic to Envoy,
which configures SO_REUSEPORT on its sockets. In turn, we're blocked
from removing TPROXY from our setup.

The reason that bpf_sk_assign refuses such sockets is that the
bpf_sk_lookup helpers don't execute SK_REUSEPORT programs. Instead,
one of the reuseport sockets is selected by hash. This could cause
dispatch to the "wrong" socket:

    sk = bpf_sk_lookup_tcp(...) // select SO_REUSEPORT by hash
    bpf_sk_assign(skb, sk) // SK_REUSEPORT wasn't executed

Fixing this isn't as simple as invoking SK_REUSEPORT from the lookup
helpers unfortunately. In the tc context, L2 headers are at the start
of the skb, while SK_REUSEPORT expects L3 headers instead.

Instead, we execute the SK_REUSEPORT program when the assigned socket
is pulled out of the skb, further up the stack. This creates some
trickiness with regards to refcounting as bpf_sk_assign will put both
refcounted and RCU freed sockets in skb->sk. reuseport sockets are RCU
freed. We can infer that the sk_assigned socket is RCU freed if the
reuseport lookup succeeds, but convincing yourself of this fact isn't
straight forward. Therefore we defensively check refcounting on the
sk_assign sock even though it's probably not required in practice.

Fixes: 8e368dc72e86 ("bpf: Fix use of sk->sk_reuseport from sk_assign")
Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Joe Stringer <joe@cilium.io>
Link: https://lore.kernel.org/bpf/CACAyw98+qycmpQzKupquhkxbvWK4OFyDuuLMBNROnfWMZxUWeA@mail.gmail.com/
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
Link: https://lore.kernel.org/r/20230720-so-reuseport-v6-7-7021b683cdae@isovalent.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/inet6_hashtables.h | 56 +++++++++++++++++++++++++++++++---
 include/net/inet_hashtables.h  | 49 +++++++++++++++++++++++++++--
 include/net/sock.h             |  7 +++--
 include/uapi/linux/bpf.h       |  3 --
 net/core/filter.c              |  2 --
 net/ipv4/udp.c                 |  8 +++--
 net/ipv6/udp.c                 |  8 +++--
 tools/include/uapi/linux/bpf.h |  3 --
 8 files changed, 115 insertions(+), 21 deletions(-)

diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index f89320b6fee31..475e672b4facc 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -94,6 +94,46 @@ static inline struct sock *__inet6_lookup(struct net *net,
 				     daddr, hnum, dif, sdif);
 }
 
+static inline
+struct sock *inet6_steal_sock(struct net *net, struct sk_buff *skb, int doff,
+			      const struct in6_addr *saddr, const __be16 sport,
+			      const struct in6_addr *daddr, const __be16 dport,
+			      bool *refcounted, inet6_ehashfn_t *ehashfn)
+{
+	struct sock *sk, *reuse_sk;
+	bool prefetched;
+
+	sk = skb_steal_sock(skb, refcounted, &prefetched);
+	if (!sk)
+		return NULL;
+
+	if (!prefetched)
+		return sk;
+
+	if (sk->sk_protocol == IPPROTO_TCP) {
+		if (sk->sk_state != TCP_LISTEN)
+			return sk;
+	} else if (sk->sk_protocol == IPPROTO_UDP) {
+		if (sk->sk_state != TCP_CLOSE)
+			return sk;
+	} else {
+		return sk;
+	}
+
+	reuse_sk = inet6_lookup_reuseport(net, sk, skb, doff,
+					  saddr, sport, daddr, ntohs(dport),
+					  ehashfn);
+	if (!reuse_sk)
+		return sk;
+
+	/* We've chosen a new reuseport sock which is never refcounted. This
+	 * implies that sk also isn't refcounted.
+	 */
+	WARN_ON_ONCE(*refcounted);
+
+	return reuse_sk;
+}
+
 static inline struct sock *__inet6_lookup_skb(struct inet_hashinfo *hashinfo,
 					      struct sk_buff *skb, int doff,
 					      const __be16 sport,
@@ -101,14 +141,20 @@ static inline struct sock *__inet6_lookup_skb(struct inet_hashinfo *hashinfo,
 					      int iif, int sdif,
 					      bool *refcounted)
 {
-	struct sock *sk = skb_steal_sock(skb, refcounted);
-
+	struct net *net = dev_net(skb_dst(skb)->dev);
+	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
+	struct sock *sk;
+
+	sk = inet6_steal_sock(net, skb, doff, &ip6h->saddr, sport, &ip6h->daddr, dport,
+			      refcounted, inet6_ehashfn);
+	if (IS_ERR(sk))
+		return NULL;
 	if (sk)
 		return sk;
 
-	return __inet6_lookup(dev_net(skb_dst(skb)->dev), hashinfo, skb,
-			      doff, &ipv6_hdr(skb)->saddr, sport,
-			      &ipv6_hdr(skb)->daddr, ntohs(dport),
+	return __inet6_lookup(net, hashinfo, skb,
+			      doff, &ip6h->saddr, sport,
+			      &ip6h->daddr, ntohs(dport),
 			      iif, sdif, refcounted);
 }
 
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index ddfa2e67fdb51..a1b8eb147ce73 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -442,6 +442,46 @@ static inline struct sock *inet_lookup(struct net *net,
 	return sk;
 }
 
+static inline
+struct sock *inet_steal_sock(struct net *net, struct sk_buff *skb, int doff,
+			     const __be32 saddr, const __be16 sport,
+			     const __be32 daddr, const __be16 dport,
+			     bool *refcounted, inet_ehashfn_t *ehashfn)
+{
+	struct sock *sk, *reuse_sk;
+	bool prefetched;
+
+	sk = skb_steal_sock(skb, refcounted, &prefetched);
+	if (!sk)
+		return NULL;
+
+	if (!prefetched)
+		return sk;
+
+	if (sk->sk_protocol == IPPROTO_TCP) {
+		if (sk->sk_state != TCP_LISTEN)
+			return sk;
+	} else if (sk->sk_protocol == IPPROTO_UDP) {
+		if (sk->sk_state != TCP_CLOSE)
+			return sk;
+	} else {
+		return sk;
+	}
+
+	reuse_sk = inet_lookup_reuseport(net, sk, skb, doff,
+					 saddr, sport, daddr, ntohs(dport),
+					 ehashfn);
+	if (!reuse_sk)
+		return sk;
+
+	/* We've chosen a new reuseport sock which is never refcounted. This
+	 * implies that sk also isn't refcounted.
+	 */
+	WARN_ON_ONCE(*refcounted);
+
+	return reuse_sk;
+}
+
 static inline struct sock *__inet_lookup_skb(struct inet_hashinfo *hashinfo,
 					     struct sk_buff *skb,
 					     int doff,
@@ -450,13 +490,18 @@ static inline struct sock *__inet_lookup_skb(struct inet_hashinfo *hashinfo,
 					     const int sdif,
 					     bool *refcounted)
 {
-	struct sock *sk = skb_steal_sock(skb, refcounted);
+	struct net *net = dev_net(skb_dst(skb)->dev);
 	const struct iphdr *iph = ip_hdr(skb);
+	struct sock *sk;
 
+	sk = inet_steal_sock(net, skb, doff, iph->saddr, sport, iph->daddr, dport,
+			     refcounted, inet_ehashfn);
+	if (IS_ERR(sk))
+		return NULL;
 	if (sk)
 		return sk;
 
-	return __inet_lookup(dev_net(skb_dst(skb)->dev), hashinfo, skb,
+	return __inet_lookup(net, hashinfo, skb,
 			     doff, iph->saddr, sport,
 			     iph->daddr, dport, inet_iif(skb), sdif,
 			     refcounted);
diff --git a/include/net/sock.h b/include/net/sock.h
index d1f936ed97556..3a8b2cc23b914 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2852,20 +2852,23 @@ sk_is_refcounted(struct sock *sk)
  * skb_steal_sock - steal a socket from an sk_buff
  * @skb: sk_buff to steal the socket from
  * @refcounted: is set to true if the socket is reference-counted
+ * @prefetched: is set to true if the socket was assigned from bpf
  */
 static inline struct sock *
-skb_steal_sock(struct sk_buff *skb, bool *refcounted)
+skb_steal_sock(struct sk_buff *skb, bool *refcounted, bool *prefetched)
 {
 	if (skb->sk) {
 		struct sock *sk = skb->sk;
 
 		*refcounted = true;
-		if (skb_sk_is_prefetched(skb))
+		*prefetched = skb_sk_is_prefetched(skb);
+		if (*prefetched)
 			*refcounted = sk_is_refcounted(sk);
 		skb->destructor = NULL;
 		skb->sk = NULL;
 		return sk;
 	}
+	*prefetched = false;
 	*refcounted = false;
 	return NULL;
 }
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 51b9aa640ad2a..1304bec5c97a0 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4079,9 +4079,6 @@ union bpf_attr {
  *		**-EOPNOTSUPP** if the operation is not supported, for example
  *		a call from outside of TC ingress.
  *
- *		**-ESOCKTNOSUPPORT** if the socket type is not supported
- *		(reuseport).
- *
  * long bpf_sk_assign(struct bpf_sk_lookup *ctx, struct bpf_sock *sk, u64 flags)
  *	Description
  *		Helper is overloaded depending on BPF program type. This
diff --git a/net/core/filter.c b/net/core/filter.c
index 9fd7c88b5db4e..ccc97d54d9a8b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7257,8 +7257,6 @@ BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u64, flags)
 		return -EOPNOTSUPP;
 	if (unlikely(dev_net(skb->dev) != sock_net(sk)))
 		return -ENETUNREACH;
-	if (unlikely(sk_fullsock(sk) && sk->sk_reuseport))
-		return -ESOCKTNOSUPPORT;
 	if (sk_unhashed(sk))
 		return -EOPNOTSUPP;
 	if (sk_is_refcounted(sk) &&
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 87686c9e4efca..58c2f8df5fd70 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2442,7 +2442,11 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	if (udp4_csum_init(skb, uh, proto))
 		goto csum_error;
 
-	sk = skb_steal_sock(skb, &refcounted);
+	sk = inet_steal_sock(net, skb, sizeof(struct udphdr), saddr, uh->source, daddr, uh->dest,
+			     &refcounted, udp_ehashfn);
+	if (IS_ERR(sk))
+		goto no_sk;
+
 	if (sk) {
 		struct dst_entry *dst = skb_dst(skb);
 		int ret;
@@ -2463,7 +2467,7 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	sk = __udp4_lib_lookup_skb(skb, uh->source, uh->dest, udptable);
 	if (sk)
 		return udp_unicast_rcv_skb(sk, skb, uh);
-
+no_sk:
 	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb))
 		goto drop;
 	nf_reset_ct(skb);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 3408376b1863b..91b757066c935 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -983,7 +983,11 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 		goto csum_error;
 
 	/* Check if the socket is already available, e.g. due to early demux */
-	sk = skb_steal_sock(skb, &refcounted);
+	sk = inet6_steal_sock(net, skb, sizeof(struct udphdr), saddr, uh->source, daddr, uh->dest,
+			      &refcounted, udp6_ehashfn);
+	if (IS_ERR(sk))
+		goto no_sk;
+
 	if (sk) {
 		struct dst_entry *dst = skb_dst(skb);
 		int ret;
@@ -1017,7 +1021,7 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 			goto report_csum_error;
 		return udp6_unicast_rcv_skb(sk, skb, uh);
 	}
-
+no_sk:
 	reason = SKB_DROP_REASON_NO_SOCKET;
 
 	if (!uh->check)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 51b9aa640ad2a..1304bec5c97a0 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4079,9 +4079,6 @@ union bpf_attr {
  *		**-EOPNOTSUPP** if the operation is not supported, for example
  *		a call from outside of TC ingress.
  *
- *		**-ESOCKTNOSUPPORT** if the socket type is not supported
- *		(reuseport).
- *
  * long bpf_sk_assign(struct bpf_sk_lookup *ctx, struct bpf_sock *sk, u64 flags)
  *	Description
  *		Helper is overloaded depending on BPF program type. This
-- 
2.40.1



