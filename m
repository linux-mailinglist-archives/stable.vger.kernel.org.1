Return-Path: <stable+bounces-153573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D448ADD561
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D5C400257
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277812EF28A;
	Tue, 17 Jun 2025 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aA4T10zs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7422221550;
	Tue, 17 Jun 2025 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176398; cv=none; b=O3bB8EzXMBT+ZFznL5ck0UZMeaVaa/9NwDOQ4zr12aEh0ZdTpVRvD4Rh9lU5H4uufj8lNQrHfe0AJF2VuHERif16Z+EMoUZGMjZQMhaNxQmJ66qzynEilJAp3DVgg6ARaQMVIFvd/CfitXtFwa6mVEgXy/u5mOq5iviEHixDDyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176398; c=relaxed/simple;
	bh=Hyvo2QOqa78QS34wRq6MMfONVhsN4GWgFuoO7t9czsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AiJtBaSA/fdKKExdc/YvIBkf2msLt2th+17Lj6DRFhwfcy88gOrfd7M8PplrdyvTKCpNaWK4icNV/WNwKWjmVIgXUIDE67MoN6xCjgBpzD7+EpHwxHeyMD1yrFpeArRF9dD8XafkSjAyVM+Cb5UGvxozuWKN7+VU0fECboHuRF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aA4T10zs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F5FC4CEE3;
	Tue, 17 Jun 2025 16:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750176398;
	bh=Hyvo2QOqa78QS34wRq6MMfONVhsN4GWgFuoO7t9czsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aA4T10zsGt+isQ/RCJCSdpEefCQES2JPxs1gWmtsIgC7bQ9lo/t5xuofcxWxv1ZJT
	 teQDuIxfGkbNNSm2hAEEDLYmZQR8IWYvAJfciwllmvZlCSmq+kbF7Ehz4Z5inCeBQ3
	 XabZPDvmK4lgqi5WbYhA0fADtDYbWdjV5H3/pkF8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 185/780] udp_tunnel: create a fastpath GRO lookup.
Date: Tue, 17 Jun 2025 17:18:13 +0200
Message-ID: <20250617152459.014081415@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit a36283e2b683f172aa1760c77325e50b16c0f792 ]

Most UDP tunnels bind a socket to a local port, with ANY address, no
peer and no interface index specified.
Additionally it's quite common to have a single tunnel device per
namespace.

Track in each namespace the UDP tunnel socket respecting the above.
When only a single one is present, store a reference in the netns.

When such reference is not NULL, UDP tunnel GRO lookup just need to
match the incoming packet destination port vs the socket local port.

The tunnel socket never sets the reuse[port] flag[s]. When bound to no
address and interface, no other socket can exist in the same netns
matching the specified local port.

Matching packets with non-local destination addresses will be
aggregated, and eventually segmented as needed - no behavior changes
intended.

Restrict the optimization to kernel sockets only: it covers all the
relevant use-cases, and user-space owned sockets could be disconnected
and rebound after setup_udp_tunnel_sock(), breaking the uniqueness
assumption

Note that the UDP tunnel socket reference is stored into struct
netns_ipv4 for both IPv4 and IPv6 tunnels. That is intentional to keep
all the fastpath-related netns fields in the same struct and allow
cacheline-based optimization. Currently both the IPv4 and IPv6 socket
pointer share the same cacheline as the `udp_table` field.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/41d16bc8d1257d567f9344c445b4ae0b4a91ede4.1744040675.git.pabeni@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: c26c192c3d48 ("udp: properly deal with xfrm encap and ADDRFORM")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/udp.h        | 16 ++++++++++++++++
 include/net/netns/ipv4.h   | 11 +++++++++++
 include/net/udp.h          |  1 +
 include/net/udp_tunnel.h   | 12 ++++++++++++
 net/ipv4/udp.c             | 13 ++++++++++++-
 net/ipv4/udp_offload.c     | 37 +++++++++++++++++++++++++++++++++++++
 net/ipv4/udp_tunnel_core.c | 13 +++++++++++++
 net/ipv6/udp.c             |  2 ++
 net/ipv6/udp_offload.c     |  5 +++++
 9 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 0807e21cfec95..895240177f4f4 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -101,6 +101,13 @@ struct udp_sock {
 
 	/* Cache friendly copy of sk->sk_peek_off >= 0 */
 	bool		peeking_with_offset;
+
+	/*
+	 * Accounting for the tunnel GRO fastpath.
+	 * Unprotected by compilers guard, as it uses space available in
+	 * the last UDP socket cacheline.
+	 */
+	struct hlist_node	tunnel_list;
 };
 
 #define udp_test_bit(nr, sk)			\
@@ -219,4 +226,13 @@ static inline void udp_allow_gso(struct sock *sk)
 
 #define IS_UDPLITE(__sk) (__sk->sk_protocol == IPPROTO_UDPLITE)
 
+static inline struct sock *udp_tunnel_sk(const struct net *net, bool is_ipv6)
+{
+#if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
+	return rcu_dereference(net->ipv4.udp_tunnel_gro[is_ipv6].sk);
+#else
+	return NULL;
+#endif
+}
+
 #endif	/* _LINUX_UDP_H */
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 650b2dc9199f4..6373e3f17da84 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -47,6 +47,11 @@ struct sysctl_fib_multipath_hash_seed {
 };
 #endif
 
+struct udp_tunnel_gro {
+	struct sock __rcu *sk;
+	struct hlist_head list;
+};
+
 struct netns_ipv4 {
 	/* Cacheline organization can be found documented in
 	 * Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst.
@@ -85,6 +90,11 @@ struct netns_ipv4 {
 	struct inet_timewait_death_row tcp_death_row;
 	struct udp_table *udp_table;
 
+#if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
+	/* Not in a pernet subsys because need to be available at GRO stage */
+	struct udp_tunnel_gro udp_tunnel_gro[2];
+#endif
+
 #ifdef CONFIG_SYSCTL
 	struct ctl_table_header	*forw_hdr;
 	struct ctl_table_header	*frags_hdr;
@@ -277,4 +287,5 @@ struct netns_ipv4 {
 	struct hlist_head	*inet_addr_lst;
 	struct delayed_work	addr_chk_work;
 };
+
 #endif
diff --git a/include/net/udp.h b/include/net/udp.h
index 6e89520e100dc..a772510b2aa58 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -290,6 +290,7 @@ static inline void udp_lib_init_sock(struct sock *sk)
 	struct udp_sock *up = udp_sk(sk);
 
 	skb_queue_head_init(&up->reader_queue);
+	INIT_HLIST_NODE(&up->tunnel_list);
 	up->forward_threshold = sk->sk_rcvbuf >> 2;
 	set_bit(SOCK_CUSTOM_SOCKOPT, &sk->sk_socket->flags);
 }
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index a93dc51f6323e..1bb2b852e90eb 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -191,6 +191,18 @@ static inline int udp_tunnel_handle_offloads(struct sk_buff *skb, bool udp_csum)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
+void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, bool add);
+#else
+static inline void udp_tunnel_update_gro_lookup(struct net *net,
+						struct sock *sk, bool add) {}
+#endif
+
+static inline void udp_tunnel_cleanup_gro(struct sock *sk)
+{
+	udp_tunnel_update_gro_lookup(sock_net(sk), sk, false);
+}
+
 static inline void udp_tunnel_encap_enable(struct sock *sk)
 {
 	if (udp_test_and_set_bit(ENCAP_ENABLED, sk))
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 2742cc7602bb5..04cd3353f1d46 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2897,8 +2897,10 @@ void udp_destroy_sock(struct sock *sk)
 			if (encap_destroy)
 				encap_destroy(sk);
 		}
-		if (udp_test_bit(ENCAP_ENABLED, sk))
+		if (udp_test_bit(ENCAP_ENABLED, sk)) {
 			static_branch_dec(&udp_encap_needed_key);
+			udp_tunnel_cleanup_gro(sk);
+		}
 	}
 }
 
@@ -3810,6 +3812,15 @@ static void __net_init udp_set_table(struct net *net)
 
 static int __net_init udp_pernet_init(struct net *net)
 {
+#if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
+	int i;
+
+	/* No tunnel is configured */
+	for (i = 0; i < ARRAY_SIZE(net->ipv4.udp_tunnel_gro); ++i) {
+		INIT_HLIST_HEAD(&net->ipv4.udp_tunnel_gro[i].list);
+		RCU_INIT_POINTER(net->ipv4.udp_tunnel_gro[i].sk, NULL);
+	}
+#endif
 	udp_sysctl_init(net);
 	udp_set_table(net);
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 9a8142ccbabe4..67641945ba3a3 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -12,6 +12,38 @@
 #include <net/udp.h>
 #include <net/protocol.h>
 #include <net/inet_common.h>
+#include <net/udp_tunnel.h>
+
+#if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
+static DEFINE_SPINLOCK(udp_tunnel_gro_lock);
+
+void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, bool add)
+{
+	bool is_ipv6 = sk->sk_family == AF_INET6;
+	struct udp_sock *tup, *up = udp_sk(sk);
+	struct udp_tunnel_gro *udp_tunnel_gro;
+
+	spin_lock(&udp_tunnel_gro_lock);
+	udp_tunnel_gro = &net->ipv4.udp_tunnel_gro[is_ipv6];
+	if (add)
+		hlist_add_head(&up->tunnel_list, &udp_tunnel_gro->list);
+	else if (up->tunnel_list.pprev)
+		hlist_del_init(&up->tunnel_list);
+
+	if (udp_tunnel_gro->list.first &&
+	    !udp_tunnel_gro->list.first->next) {
+		tup = hlist_entry(udp_tunnel_gro->list.first, struct udp_sock,
+				  tunnel_list);
+
+		rcu_assign_pointer(udp_tunnel_gro->sk, (struct sock *)tup);
+	} else {
+		RCU_INIT_POINTER(udp_tunnel_gro->sk, NULL);
+	}
+
+	spin_unlock(&udp_tunnel_gro_lock);
+}
+EXPORT_SYMBOL_GPL(udp_tunnel_update_gro_lookup);
+#endif
 
 static struct sk_buff *__skb_udp_tunnel_segment(struct sk_buff *skb,
 	netdev_features_t features,
@@ -694,8 +726,13 @@ static struct sock *udp4_gro_lookup_skb(struct sk_buff *skb, __be16 sport,
 {
 	const struct iphdr *iph = skb_gro_network_header(skb);
 	struct net *net = dev_net_rcu(skb->dev);
+	struct sock *sk;
 	int iif, sdif;
 
+	sk = udp_tunnel_sk(net, false);
+	if (sk && dport == htons(sk->sk_num))
+		return sk;
+
 	inet_get_iif_sdif(skb, &iif, &sdif);
 
 	return __udp4_lib_lookup(net, iph->saddr, sport,
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 619a53eb672da..3d1214e6df0ea 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -58,6 +58,15 @@ int udp_sock_create4(struct net *net, struct udp_port_cfg *cfg,
 }
 EXPORT_SYMBOL(udp_sock_create4);
 
+static bool sk_saddr_any(struct sock *sk)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	return ipv6_addr_any(&sk->sk_v6_rcv_saddr);
+#else
+	return !sk->sk_rcv_saddr;
+#endif
+}
+
 void setup_udp_tunnel_sock(struct net *net, struct socket *sock,
 			   struct udp_tunnel_sock_cfg *cfg)
 {
@@ -80,6 +89,10 @@ void setup_udp_tunnel_sock(struct net *net, struct socket *sock,
 	udp_sk(sk)->gro_complete = cfg->gro_complete;
 
 	udp_tunnel_encap_enable(sk);
+
+	if (!sk->sk_dport && !sk->sk_bound_dev_if && sk_saddr_any(sk) &&
+	    sk->sk_kern_sock)
+		udp_tunnel_update_gro_lookup(net, sk, true);
 }
 EXPORT_SYMBOL_GPL(setup_udp_tunnel_sock);
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 024458ef163c9..7317f8e053f1c 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -46,6 +46,7 @@
 #include <net/tcp_states.h>
 #include <net/ip6_checksum.h>
 #include <net/ip6_tunnel.h>
+#include <net/udp_tunnel.h>
 #include <net/xfrm.h>
 #include <net/inet_hashtables.h>
 #include <net/inet6_hashtables.h>
@@ -1825,6 +1826,7 @@ void udpv6_destroy_sock(struct sock *sk)
 		if (udp_test_bit(ENCAP_ENABLED, sk)) {
 			static_branch_dec(&udpv6_encap_needed_key);
 			udp_encap_disable();
+			udp_tunnel_cleanup_gro(sk);
 		}
 	}
 }
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index 404212dfc99ab..d8445ac1b2e43 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -118,8 +118,13 @@ static struct sock *udp6_gro_lookup_skb(struct sk_buff *skb, __be16 sport,
 {
 	const struct ipv6hdr *iph = skb_gro_network_header(skb);
 	struct net *net = dev_net_rcu(skb->dev);
+	struct sock *sk;
 	int iif, sdif;
 
+	sk = udp_tunnel_sk(net, true);
+	if (sk && dport == htons(sk->sk_num))
+		return sk;
+
 	inet6_get_iif_sdif(skb, &iif, &sdif);
 
 	return __udp6_lib_lookup(net, &iph->saddr, sport,
-- 
2.39.5




