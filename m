Return-Path: <stable+bounces-168303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC4CB2345B
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5127D16F1A4
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CC22EF652;
	Tue, 12 Aug 2025 18:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GSmHWkTK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E20726A0EB;
	Tue, 12 Aug 2025 18:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023724; cv=none; b=nsIuuqUD1j/ruURe5gsG+MW/lfzLFIY5RJ3VPfJ1t+G7L2W5KaSaxBJLq4PoU0yMaGtGbu6/6L2o9vLZ6ISAkBSEqEd8RwJk7GjBR+OSGI1l0AzYE0f0gPPBrUZ5l4WiGz/Q2sL7GXeK8FOq7UixadrPHAtVIOXUsiynCVcuQG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023724; c=relaxed/simple;
	bh=D/5UFyPk4ohXLmK5RKZEPLROgVVQo6nuNY35iRrfKtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EyvkOIG7A//jzuR1g6jxGc2R4YlLLtz9jQ8qO9lZifvbLTxiLPGsKnLp0zBkSAIhV3OZPV0kPu39zpXqNdIfWNCWTYX6ZOV/XG732028haJ5VOTcdiXxePreS5u/00+vIA1QkC3YVGyhV/Gzq/1HUIRpe3MPHqDHqpZICwUakHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GSmHWkTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE72BC4CEF0;
	Tue, 12 Aug 2025 18:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755023724;
	bh=D/5UFyPk4ohXLmK5RKZEPLROgVVQo6nuNY35iRrfKtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GSmHWkTKwicvqrrEARGzZqZAitYwtdjEmfg2YvUwhdCMQ0g2cQwiqk0v/TTG7XQeY
	 GJLSDJtPt9nyF6Yh2xTYEihNFafqBrBF86QxcuUy4Te/g1LJKKFNMZ98mxiYs2XPXm
	 6xlr3AgnA/ZxGmew/QMNz1vNWIBZ0PUv7l4P6Cew=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Lorenzo Colitti <lorenzo@google.com>,
	=?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 162/627] net: annotate races around sk->sk_uid
Date: Tue, 12 Aug 2025 19:27:37 +0200
Message-ID: <20250812173425.455858656@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit e84a4927a404f369c842c19de93b216627fcc690 ]

sk->sk_uid can be read while another thread changes its
value in sockfs_setattr().

Add sk_uid(const struct sock *sk) helper to factorize the needed
READ_ONCE() annotations, and add corresponding WRITE_ONCE()
where needed.

Fixes: 86741ec25462 ("net: core: Add a UID field to struct sock.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Reviewed-by: Maciej Żenczykowski <maze@google.com>
Link: https://patch.msgid.link/20250620133001.4090592-2-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/route.h              |  4 ++--
 include/net/sock.h               | 12 ++++++++++--
 net/ipv4/inet_connection_sock.c  |  4 ++--
 net/ipv4/ping.c                  |  2 +-
 net/ipv4/raw.c                   |  2 +-
 net/ipv4/route.c                 |  3 ++-
 net/ipv4/syncookies.c            |  3 ++-
 net/ipv4/udp.c                   |  3 ++-
 net/ipv6/af_inet6.c              |  2 +-
 net/ipv6/datagram.c              |  2 +-
 net/ipv6/inet6_connection_sock.c |  4 ++--
 net/ipv6/ping.c                  |  2 +-
 net/ipv6/raw.c                   |  2 +-
 net/ipv6/route.c                 |  4 ++--
 net/ipv6/syncookies.c            |  2 +-
 net/ipv6/tcp_ipv6.c              |  2 +-
 net/ipv6/udp.c                   |  5 +++--
 net/l2tp/l2tp_ip6.c              |  2 +-
 net/mptcp/protocol.c             |  2 +-
 net/socket.c                     |  8 +++++---
 20 files changed, 42 insertions(+), 28 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index 8e39aa822cf9..3d3d6048ffca 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -153,7 +153,7 @@ static inline void inet_sk_init_flowi4(const struct inet_sock *inet,
 			   ip_sock_rt_tos(sk), ip_sock_rt_scope(sk),
 			   sk->sk_protocol, inet_sk_flowi_flags(sk), daddr,
 			   inet->inet_saddr, inet->inet_dport,
-			   inet->inet_sport, sk->sk_uid);
+			   inet->inet_sport, sk_uid(sk));
 	security_sk_classify_flow(sk, flowi4_to_flowi_common(fl4));
 }
 
@@ -331,7 +331,7 @@ static inline void ip_route_connect_init(struct flowi4 *fl4, __be32 dst,
 
 	flowi4_init_output(fl4, oif, READ_ONCE(sk->sk_mark), ip_sock_rt_tos(sk),
 			   ip_sock_rt_scope(sk), protocol, flow_flags, dst,
-			   src, dport, sport, sk->sk_uid);
+			   src, dport, sport, sk_uid(sk));
 }
 
 static inline struct rtable *ip_route_connect(struct flowi4 *fl4, __be32 dst,
diff --git a/include/net/sock.h b/include/net/sock.h
index 4c37015b7cf7..e3ab20345685 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2076,6 +2076,7 @@ static inline void sock_orphan(struct sock *sk)
 	sock_set_flag(sk, SOCK_DEAD);
 	sk_set_socket(sk, NULL);
 	sk->sk_wq  = NULL;
+	/* Note: sk_uid is unchanged. */
 	write_unlock_bh(&sk->sk_callback_lock);
 }
 
@@ -2086,18 +2087,25 @@ static inline void sock_graft(struct sock *sk, struct socket *parent)
 	rcu_assign_pointer(sk->sk_wq, &parent->wq);
 	parent->sk = sk;
 	sk_set_socket(sk, parent);
-	sk->sk_uid = SOCK_INODE(parent)->i_uid;
+	WRITE_ONCE(sk->sk_uid, SOCK_INODE(parent)->i_uid);
 	security_sock_graft(sk, parent);
 	write_unlock_bh(&sk->sk_callback_lock);
 }
 
 kuid_t sock_i_uid(struct sock *sk);
+
+static inline kuid_t sk_uid(const struct sock *sk)
+{
+	/* Paired with WRITE_ONCE() in sockfs_setattr() */
+	return READ_ONCE(sk->sk_uid);
+}
+
 unsigned long __sock_i_ino(struct sock *sk);
 unsigned long sock_i_ino(struct sock *sk);
 
 static inline kuid_t sock_net_uid(const struct net *net, const struct sock *sk)
 {
-	return sk ? sk->sk_uid : make_kuid(net->user_ns, 0);
+	return sk ? sk_uid(sk) : make_kuid(net->user_ns, 0);
 }
 
 static inline u32 net_tx_rndhash(void)
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 6906bedad19a..46750c96d08e 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -812,7 +812,7 @@ struct dst_entry *inet_csk_route_req(const struct sock *sk,
 			   sk->sk_protocol, inet_sk_flowi_flags(sk),
 			   (opt && opt->opt.srr) ? opt->opt.faddr : ireq->ir_rmt_addr,
 			   ireq->ir_loc_addr, ireq->ir_rmt_port,
-			   htons(ireq->ir_num), sk->sk_uid);
+			   htons(ireq->ir_num), sk_uid(sk));
 	security_req_classify_flow(req, flowi4_to_flowi_common(fl4));
 	rt = ip_route_output_flow(net, fl4, sk);
 	if (IS_ERR(rt))
@@ -849,7 +849,7 @@ struct dst_entry *inet_csk_route_child_sock(const struct sock *sk,
 			   sk->sk_protocol, inet_sk_flowi_flags(sk),
 			   (opt && opt->opt.srr) ? opt->opt.faddr : ireq->ir_rmt_addr,
 			   ireq->ir_loc_addr, ireq->ir_rmt_port,
-			   htons(ireq->ir_num), sk->sk_uid);
+			   htons(ireq->ir_num), sk_uid(sk));
 	security_req_classify_flow(req, flowi4_to_flowi_common(fl4));
 	rt = ip_route_output_flow(net, fl4, sk);
 	if (IS_ERR(rt))
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index c14baa6589c7..4eacaf00e2e9 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -781,7 +781,7 @@ static int ping_v4_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	flowi4_init_output(&fl4, ipc.oif, ipc.sockc.mark,
 			   ipc.tos & INET_DSCP_MASK, scope,
 			   sk->sk_protocol, inet_sk_flowi_flags(sk), faddr,
-			   saddr, 0, 0, sk->sk_uid);
+			   saddr, 0, 0, sk_uid(sk));
 
 	fl4.fl4_icmp_type = user_icmph.type;
 	fl4.fl4_icmp_code = user_icmph.code;
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 6aace4d55733..32f942d0f944 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -610,7 +610,7 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			   hdrincl ? ipc.protocol : sk->sk_protocol,
 			   inet_sk_flowi_flags(sk) |
 			    (hdrincl ? FLOWI_FLAG_KNOWN_NH : 0),
-			   daddr, saddr, 0, 0, sk->sk_uid);
+			   daddr, saddr, 0, 0, sk_uid(sk));
 
 	fl4.fl4_icmp_type = 0;
 	fl4.fl4_icmp_code = 0;
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index fccb05fb3a79..64ac20c27f1b 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -556,7 +556,8 @@ static void build_sk_flow_key(struct flowi4 *fl4, const struct sock *sk)
 			   inet_test_bit(HDRINCL, sk) ?
 				IPPROTO_RAW : sk->sk_protocol,
 			   inet_sk_flowi_flags(sk),
-			   daddr, inet->inet_saddr, 0, 0, sk->sk_uid);
+			   daddr, inet->inet_saddr, 0, 0,
+			   sk_uid(sk));
 	rcu_read_unlock();
 }
 
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 5459a78b9809..eb0819463fae 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -454,7 +454,8 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 			   ip_sock_rt_tos(sk), ip_sock_rt_scope(sk),
 			   IPPROTO_TCP, inet_sk_flowi_flags(sk),
 			   opt->srr ? opt->faddr : ireq->ir_rmt_addr,
-			   ireq->ir_loc_addr, th->source, th->dest, sk->sk_uid);
+			   ireq->ir_loc_addr, th->source, th->dest,
+			   sk_uid(sk));
 	security_req_classify_flow(req, flowi4_to_flowi_common(&fl4));
 	rt = ip_route_output_key(net, &fl4);
 	if (IS_ERR(rt)) {
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index dde52b8050b8..f94bb222aa2d 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1445,7 +1445,8 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		flowi4_init_output(fl4, ipc.oif, ipc.sockc.mark,
 				   ipc.tos & INET_DSCP_MASK, scope,
 				   sk->sk_protocol, flow_flags, faddr, saddr,
-				   dport, inet->inet_sport, sk->sk_uid);
+				   dport, inet->inet_sport,
+				   sk_uid(sk));
 
 		security_sk_classify_flow(sk, flowi4_to_flowi_common(fl4));
 		rt = ip_route_output_flow(net, fl4, sk);
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index acaff1296783..1992621e3f3f 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -842,7 +842,7 @@ int inet6_sk_rebuild_header(struct sock *sk)
 		fl6.flowi6_mark = sk->sk_mark;
 		fl6.fl6_dport = inet->inet_dport;
 		fl6.fl6_sport = inet->inet_sport;
-		fl6.flowi6_uid = sk->sk_uid;
+		fl6.flowi6_uid = sk_uid(sk);
 		security_sk_classify_flow(sk, flowi6_to_flowi_common(&fl6));
 
 		rcu_read_lock();
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index fff78496803d..83f5aa5e133a 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -53,7 +53,7 @@ static void ip6_datagram_flow_key_init(struct flowi6 *fl6,
 	fl6->fl6_dport = inet->inet_dport;
 	fl6->fl6_sport = inet->inet_sport;
 	fl6->flowlabel = ip6_make_flowinfo(np->tclass, np->flow_label);
-	fl6->flowi6_uid = sk->sk_uid;
+	fl6->flowi6_uid = sk_uid(sk);
 
 	if (!oif)
 		oif = np->sticky_pktinfo.ipi6_ifindex;
diff --git a/net/ipv6/inet6_connection_sock.c b/net/ipv6/inet6_connection_sock.c
index 8f500eaf33cf..333e43434dd7 100644
--- a/net/ipv6/inet6_connection_sock.c
+++ b/net/ipv6/inet6_connection_sock.c
@@ -45,7 +45,7 @@ struct dst_entry *inet6_csk_route_req(const struct sock *sk,
 	fl6->flowi6_mark = ireq->ir_mark;
 	fl6->fl6_dport = ireq->ir_rmt_port;
 	fl6->fl6_sport = htons(ireq->ir_num);
-	fl6->flowi6_uid = sk->sk_uid;
+	fl6->flowi6_uid = sk_uid(sk);
 	security_req_classify_flow(req, flowi6_to_flowi_common(fl6));
 
 	dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p);
@@ -79,7 +79,7 @@ static struct dst_entry *inet6_csk_route_socket(struct sock *sk,
 	fl6->flowi6_mark = sk->sk_mark;
 	fl6->fl6_sport = inet->inet_sport;
 	fl6->fl6_dport = inet->inet_dport;
-	fl6->flowi6_uid = sk->sk_uid;
+	fl6->flowi6_uid = sk_uid(sk);
 	security_sk_classify_flow(sk, flowi6_to_flowi_common(fl6));
 
 	rcu_read_lock();
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index 84d90dd8b3f0..82b0492923d4 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -142,7 +142,7 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	fl6.saddr = np->saddr;
 	fl6.daddr = *daddr;
 	fl6.flowi6_mark = ipc6.sockc.mark;
-	fl6.flowi6_uid = sk->sk_uid;
+	fl6.flowi6_uid = sk_uid(sk);
 	fl6.fl6_icmp_type = user_icmph.icmp6_type;
 	fl6.fl6_icmp_code = user_icmph.icmp6_code;
 	security_sk_classify_flow(sk, flowi6_to_flowi_common(&fl6));
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index fda640ebd53f..4c3f8245c40f 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -777,7 +777,7 @@ static int rawv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	memset(&fl6, 0, sizeof(fl6));
 
 	fl6.flowi6_mark = ipc6.sockc.mark;
-	fl6.flowi6_uid = sk->sk_uid;
+	fl6.flowi6_uid = sk_uid(sk);
 
 	if (sin6) {
 		if (addr_len < SIN6_LEN_RFC2133)
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 79c8f1acf8a3..7b9e49be7164 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3010,7 +3010,7 @@ void ip6_sk_update_pmtu(struct sk_buff *skb, struct sock *sk, __be32 mtu)
 		oif = l3mdev_master_ifindex(skb->dev);
 
 	ip6_update_pmtu(skb, sock_net(sk), mtu, oif, READ_ONCE(sk->sk_mark),
-			sk->sk_uid);
+			sk_uid(sk));
 
 	dst = __sk_dst_get(sk);
 	if (!dst || !dst->obsolete ||
@@ -3232,7 +3232,7 @@ void ip6_redirect_no_header(struct sk_buff *skb, struct net *net, int oif)
 void ip6_sk_redirect(struct sk_buff *skb, struct sock *sk)
 {
 	ip6_redirect(skb, sock_net(sk), sk->sk_bound_dev_if,
-		     READ_ONCE(sk->sk_mark), sk->sk_uid);
+		     READ_ONCE(sk->sk_mark), sk_uid(sk));
 }
 EXPORT_SYMBOL_GPL(ip6_sk_redirect);
 
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 9d83eadd308b..f0ee1a909771 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -236,7 +236,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 		fl6.flowi6_mark = ireq->ir_mark;
 		fl6.fl6_dport = ireq->ir_rmt_port;
 		fl6.fl6_sport = inet_sk(sk)->inet_sport;
-		fl6.flowi6_uid = sk->sk_uid;
+		fl6.flowi6_uid = sk_uid(sk);
 		security_req_classify_flow(req, flowi6_to_flowi_common(&fl6));
 
 		dst = ip6_dst_lookup_flow(net, sk, &fl6, final_p);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e8e68a142649..f61b0396ef6b 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -269,7 +269,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
 	fl6.fl6_sport = inet->inet_sport;
 	if (IS_ENABLED(CONFIG_IP_ROUTE_MULTIPATH) && !fl6.fl6_sport)
 		fl6.flowi6_flags = FLOWI_FLAG_ANY_SPORT;
-	fl6.flowi6_uid = sk->sk_uid;
+	fl6.flowi6_uid = sk_uid(sk);
 
 	opt = rcu_dereference_protected(np->opt, lockdep_sock_is_held(sk));
 	final_p = fl6_update_dst(&fl6, opt, &final);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 7317f8e053f1..ebb95d8bc681 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -750,7 +750,8 @@ int __udp6_lib_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	if (type == NDISC_REDIRECT) {
 		if (tunnel) {
 			ip6_redirect(skb, sock_net(sk), inet6_iif(skb),
-				     READ_ONCE(sk->sk_mark), sk->sk_uid);
+				     READ_ONCE(sk->sk_mark),
+				     sk_uid(sk));
 		} else {
 			ip6_sk_redirect(skb, sk);
 		}
@@ -1620,7 +1621,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	if (!fl6->flowi6_oif)
 		fl6->flowi6_oif = np->sticky_pktinfo.ipi6_ifindex;
 
-	fl6->flowi6_uid = sk->sk_uid;
+	fl6->flowi6_uid = sk_uid(sk);
 
 	if (msg->msg_controllen) {
 		opt = &opt_space;
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index b98d13584c81..ea232f338dcb 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -545,7 +545,7 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	memset(&fl6, 0, sizeof(fl6));
 
 	fl6.flowi6_mark = READ_ONCE(sk->sk_mark);
-	fl6.flowi6_uid = sk->sk_uid;
+	fl6.flowi6_uid = sk_uid(sk);
 
 	ipcm6_init_sk(&ipc6, sk);
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6a817a13b154..76cb699885b3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3537,7 +3537,7 @@ void mptcp_sock_graft(struct sock *sk, struct socket *parent)
 	write_lock_bh(&sk->sk_callback_lock);
 	rcu_assign_pointer(sk->sk_wq, &parent->wq);
 	sk_set_socket(sk, parent);
-	sk->sk_uid = SOCK_INODE(parent)->i_uid;
+	WRITE_ONCE(sk->sk_uid, SOCK_INODE(parent)->i_uid);
 	write_unlock_bh(&sk->sk_callback_lock);
 }
 
diff --git a/net/socket.c b/net/socket.c
index 9a0e720f0859..c706601a4c16 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -592,10 +592,12 @@ static int sockfs_setattr(struct mnt_idmap *idmap,
 	if (!err && (iattr->ia_valid & ATTR_UID)) {
 		struct socket *sock = SOCKET_I(d_inode(dentry));
 
-		if (sock->sk)
-			sock->sk->sk_uid = iattr->ia_uid;
-		else
+		if (sock->sk) {
+			/* Paired with READ_ONCE() in sk_uid() */
+			WRITE_ONCE(sock->sk->sk_uid, iattr->ia_uid);
+		} else {
 			err = -ENOENT;
+		}
 	}
 
 	return err;
-- 
2.39.5




