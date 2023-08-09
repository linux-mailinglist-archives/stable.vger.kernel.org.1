Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8190C7758DA
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjHIKzr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbjHIKz0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:55:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093463C3D
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:54:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2098630D2
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:54:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AA9C433C8;
        Wed,  9 Aug 2023 10:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578469;
        bh=zJ43y5lDWrwZiohu4gG9RBES7DaeTmzVLAsXm5Ud0pU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mMzbLayc0Zho0Nmp8jJjlPxZd0vH1NK4ZB1UI4d+8bTQIPDOpGkJ44BLleSasSbPo
         ryMAUA76a06stDI1UalxSRbP1D9/keSe/zNjX9s7lVbgYv/GZ88Hdh/6LDQvVMBreb
         64JU3v9KczdQP++vttaYqABXUTmIto05jbgu8/Sk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 041/127] net: annotate data-races around sk->sk_mark
Date:   Wed,  9 Aug 2023 12:40:28 +0200
Message-ID: <20230809103638.030772981@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
References: <20230809103636.615294317@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 3c5b4d69c358a9275a8de98f87caf6eda644b086 ]

sk->sk_mark is often read while another thread could change the value.

Fixes: 4a19ec5800fc ("[NET]: Introducing socket mark socket option.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/inet_sock.h    | 7 ++++---
 include/net/ip.h           | 2 +-
 include/net/route.h        | 4 ++--
 net/core/sock.c            | 4 ++--
 net/dccp/ipv6.c            | 4 ++--
 net/ipv4/inet_diag.c       | 4 ++--
 net/ipv4/ip_output.c       | 4 ++--
 net/ipv4/route.c           | 4 ++--
 net/ipv4/tcp_ipv4.c        | 2 +-
 net/ipv6/ping.c            | 2 +-
 net/ipv6/raw.c             | 4 ++--
 net/ipv6/route.c           | 7 ++++---
 net/ipv6/tcp_ipv6.c        | 6 +++---
 net/ipv6/udp.c             | 4 ++--
 net/l2tp/l2tp_ip6.c        | 2 +-
 net/mptcp/sockopt.c        | 2 +-
 net/netfilter/nft_socket.c | 2 +-
 net/netfilter/xt_socket.c  | 4 ++--
 net/packet/af_packet.c     | 6 +++---
 net/smc/af_smc.c           | 2 +-
 net/xdp/xsk.c              | 2 +-
 net/xfrm/xfrm_policy.c     | 2 +-
 22 files changed, 41 insertions(+), 39 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 51857117ac099..c8ef3b881f03d 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -107,11 +107,12 @@ static inline struct inet_request_sock *inet_rsk(const struct request_sock *sk)
 
 static inline u32 inet_request_mark(const struct sock *sk, struct sk_buff *skb)
 {
-	if (!sk->sk_mark &&
-	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_fwmark_accept))
+	u32 mark = READ_ONCE(sk->sk_mark);
+
+	if (!mark && READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_fwmark_accept))
 		return skb->mark;
 
-	return sk->sk_mark;
+	return mark;
 }
 
 static inline int inet_request_bound_dev_if(const struct sock *sk,
diff --git a/include/net/ip.h b/include/net/ip.h
index 83a1a9bc3ceb1..530e7257e4389 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -93,7 +93,7 @@ static inline void ipcm_init_sk(struct ipcm_cookie *ipcm,
 {
 	ipcm_init(ipcm);
 
-	ipcm->sockc.mark = inet->sk.sk_mark;
+	ipcm->sockc.mark = READ_ONCE(inet->sk.sk_mark);
 	ipcm->sockc.tsflags = inet->sk.sk_tsflags;
 	ipcm->oif = READ_ONCE(inet->sk.sk_bound_dev_if);
 	ipcm->addr = inet->inet_saddr;
diff --git a/include/net/route.h b/include/net/route.h
index fe00b0a2e4759..af8431b25f800 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -171,7 +171,7 @@ static inline struct rtable *ip_route_output_ports(struct net *net, struct flowi
 						   __be16 dport, __be16 sport,
 						   __u8 proto, __u8 tos, int oif)
 {
-	flowi4_init_output(fl4, oif, sk ? sk->sk_mark : 0, tos,
+	flowi4_init_output(fl4, oif, sk ? READ_ONCE(sk->sk_mark) : 0, tos,
 			   RT_SCOPE_UNIVERSE, proto,
 			   sk ? inet_sk_flowi_flags(sk) : 0,
 			   daddr, saddr, dport, sport, sock_net_uid(net, sk));
@@ -304,7 +304,7 @@ static inline void ip_route_connect_init(struct flowi4 *fl4, __be32 dst,
 	if (inet_sk(sk)->transparent)
 		flow_flags |= FLOWI_FLAG_ANYSRC;
 
-	flowi4_init_output(fl4, oif, sk->sk_mark, ip_sock_rt_tos(sk),
+	flowi4_init_output(fl4, oif, READ_ONCE(sk->sk_mark), ip_sock_rt_tos(sk),
 			   ip_sock_rt_scope(sk), protocol, flow_flags, dst,
 			   src, dport, sport, sk->sk_uid);
 }
diff --git a/net/core/sock.c b/net/core/sock.c
index 1a2ec2c4cfe26..4dd13d34e4740 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -977,7 +977,7 @@ EXPORT_SYMBOL(sock_set_rcvbuf);
 static void __sock_set_mark(struct sock *sk, u32 val)
 {
 	if (val != sk->sk_mark) {
-		sk->sk_mark = val;
+		WRITE_ONCE(sk->sk_mark, val);
 		sk_dst_reset(sk);
 	}
 }
@@ -1796,7 +1796,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		return security_socket_getpeersec_stream(sock, optval.user, optlen.user, len);
 
 	case SO_MARK:
-		v.val = sk->sk_mark;
+		v.val = READ_ONCE(sk->sk_mark);
 		break;
 
 	case SO_RCVMARK:
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index c0fd8f5f3b94e..b51ce6f8ceba0 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -237,8 +237,8 @@ static int dccp_v6_send_response(const struct sock *sk, struct request_sock *req
 		opt = ireq->ipv6_opt;
 		if (!opt)
 			opt = rcu_dereference(np->opt);
-		err = ip6_xmit(sk, skb, &fl6, sk->sk_mark, opt, np->tclass,
-			       sk->sk_priority);
+		err = ip6_xmit(sk, skb, &fl6, READ_ONCE(sk->sk_mark), opt,
+			       np->tclass, sk->sk_priority);
 		rcu_read_unlock();
 		err = net_xmit_eval(err);
 	}
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index b812eb36f0e36..f7426926a1041 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -150,7 +150,7 @@ int inet_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
 	}
 #endif
 
-	if (net_admin && nla_put_u32(skb, INET_DIAG_MARK, sk->sk_mark))
+	if (net_admin && nla_put_u32(skb, INET_DIAG_MARK, READ_ONCE(sk->sk_mark)))
 		goto errout;
 
 	if (ext & (1 << (INET_DIAG_CLASS_ID - 1)) ||
@@ -799,7 +799,7 @@ int inet_diag_bc_sk(const struct nlattr *bc, struct sock *sk)
 	entry.ifindex = sk->sk_bound_dev_if;
 	entry.userlocks = sk_fullsock(sk) ? sk->sk_userlocks : 0;
 	if (sk_fullsock(sk))
-		entry.mark = sk->sk_mark;
+		entry.mark = READ_ONCE(sk->sk_mark);
 	else if (sk->sk_state == TCP_NEW_SYN_RECV)
 		entry.mark = inet_rsk(inet_reqsk(sk))->ir_mark;
 	else if (sk->sk_state == TCP_TIME_WAIT)
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 7b4ab545c06e0..99d8cdbfd9ab5 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -184,7 +184,7 @@ int ip_build_and_send_pkt(struct sk_buff *skb, const struct sock *sk,
 
 	skb->priority = sk->sk_priority;
 	if (!skb->mark)
-		skb->mark = sk->sk_mark;
+		skb->mark = READ_ONCE(sk->sk_mark);
 
 	/* Send it out. */
 	return ip_local_out(net, skb->sk, skb);
@@ -527,7 +527,7 @@ int __ip_queue_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl,
 
 	/* TODO : should we use skb->sk here instead of sk ? */
 	skb->priority = sk->sk_priority;
-	skb->mark = sk->sk_mark;
+	skb->mark = READ_ONCE(sk->sk_mark);
 
 	res = ip_local_out(net, sk, skb);
 	rcu_read_unlock();
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index cd1fa9f70f1a1..51bd9a50a1d1d 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -518,7 +518,7 @@ static void __build_flow_key(const struct net *net, struct flowi4 *fl4,
 		const struct inet_sock *inet = inet_sk(sk);
 
 		oif = sk->sk_bound_dev_if;
-		mark = sk->sk_mark;
+		mark = READ_ONCE(sk->sk_mark);
 		tos = ip_sock_rt_tos(sk);
 		scope = ip_sock_rt_scope(sk);
 		prot = inet->hdrincl ? IPPROTO_RAW : sk->sk_protocol;
@@ -552,7 +552,7 @@ static void build_sk_flow_key(struct flowi4 *fl4, const struct sock *sk)
 	inet_opt = rcu_dereference(inet->inet_opt);
 	if (inet_opt && inet_opt->opt.srr)
 		daddr = inet_opt->opt.faddr;
-	flowi4_init_output(fl4, sk->sk_bound_dev_if, sk->sk_mark,
+	flowi4_init_output(fl4, sk->sk_bound_dev_if, READ_ONCE(sk->sk_mark),
 			   ip_sock_rt_tos(sk) & IPTOS_RT_MASK,
 			   ip_sock_rt_scope(sk),
 			   inet->hdrincl ? IPPROTO_RAW : sk->sk_protocol,
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 9a8d59e9303a0..23b4f93afb28d 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -931,7 +931,7 @@ static void tcp_v4_send_ack(const struct sock *sk,
 	ctl_sk = this_cpu_read(ipv4_tcp_sk);
 	sock_net_set(ctl_sk, net);
 	ctl_sk->sk_mark = (sk->sk_state == TCP_TIME_WAIT) ?
-			   inet_twsk(sk)->tw_mark : sk->sk_mark;
+			   inet_twsk(sk)->tw_mark : READ_ONCE(sk->sk_mark);
 	ctl_sk->sk_priority = (sk->sk_state == TCP_TIME_WAIT) ?
 			   inet_twsk(sk)->tw_priority : sk->sk_priority;
 	transmit_time = tcp_transmit_time(sk);
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index 4651aaf70db4f..4d5a27dd9a4b2 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -120,7 +120,7 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	ipcm6_init_sk(&ipc6, np);
 	ipc6.sockc.tsflags = sk->sk_tsflags;
-	ipc6.sockc.mark = sk->sk_mark;
+	ipc6.sockc.mark = READ_ONCE(sk->sk_mark);
 
 	fl6.flowi6_oif = oif;
 
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 33852fc38ad91..e8675e5b5d00b 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -772,12 +772,12 @@ static int rawv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	 */
 	memset(&fl6, 0, sizeof(fl6));
 
-	fl6.flowi6_mark = sk->sk_mark;
+	fl6.flowi6_mark = READ_ONCE(sk->sk_mark);
 	fl6.flowi6_uid = sk->sk_uid;
 
 	ipcm6_init(&ipc6);
 	ipc6.sockc.tsflags = sk->sk_tsflags;
-	ipc6.sockc.mark = sk->sk_mark;
+	ipc6.sockc.mark = fl6.flowi6_mark;
 
 	if (sin6) {
 		if (addr_len < SIN6_LEN_RFC2133)
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 0b060cb8681f0..960ab43a49c46 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2952,7 +2952,8 @@ void ip6_sk_update_pmtu(struct sk_buff *skb, struct sock *sk, __be32 mtu)
 	if (!oif && skb->dev)
 		oif = l3mdev_master_ifindex(skb->dev);
 
-	ip6_update_pmtu(skb, sock_net(sk), mtu, oif, sk->sk_mark, sk->sk_uid);
+	ip6_update_pmtu(skb, sock_net(sk), mtu, oif, READ_ONCE(sk->sk_mark),
+			sk->sk_uid);
 
 	dst = __sk_dst_get(sk);
 	if (!dst || !dst->obsolete ||
@@ -3173,8 +3174,8 @@ void ip6_redirect_no_header(struct sk_buff *skb, struct net *net, int oif)
 
 void ip6_sk_redirect(struct sk_buff *skb, struct sock *sk)
 {
-	ip6_redirect(skb, sock_net(sk), sk->sk_bound_dev_if, sk->sk_mark,
-		     sk->sk_uid);
+	ip6_redirect(skb, sock_net(sk), sk->sk_bound_dev_if,
+		     READ_ONCE(sk->sk_mark), sk->sk_uid);
 }
 EXPORT_SYMBOL_GPL(ip6_sk_redirect);
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index d9253aa764fae..039aa51390aed 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -567,8 +567,8 @@ static int tcp_v6_send_synack(const struct sock *sk, struct dst_entry *dst,
 		opt = ireq->ipv6_opt;
 		if (!opt)
 			opt = rcu_dereference(np->opt);
-		err = ip6_xmit(sk, skb, fl6, skb->mark ? : sk->sk_mark, opt,
-			       tclass, sk->sk_priority);
+		err = ip6_xmit(sk, skb, fl6, skb->mark ? : READ_ONCE(sk->sk_mark),
+			       opt, tclass, sk->sk_priority);
 		rcu_read_unlock();
 		err = net_xmit_eval(err);
 	}
@@ -943,7 +943,7 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 		if (sk->sk_state == TCP_TIME_WAIT)
 			mark = inet_twsk(sk)->tw_mark;
 		else
-			mark = sk->sk_mark;
+			mark = READ_ONCE(sk->sk_mark);
 		skb_set_delivery_time(buff, tcp_transmit_time(sk), true);
 	}
 	if (txhash) {
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 04f1d696503cd..27348172b25b9 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -622,7 +622,7 @@ int __udp6_lib_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	if (type == NDISC_REDIRECT) {
 		if (tunnel) {
 			ip6_redirect(skb, sock_net(sk), inet6_iif(skb),
-				     sk->sk_mark, sk->sk_uid);
+				     READ_ONCE(sk->sk_mark), sk->sk_uid);
 		} else {
 			ip6_sk_redirect(skb, sk);
 		}
@@ -1350,7 +1350,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	ipcm6_init(&ipc6);
 	ipc6.gso_size = READ_ONCE(up->gso_size);
 	ipc6.sockc.tsflags = sk->sk_tsflags;
-	ipc6.sockc.mark = sk->sk_mark;
+	ipc6.sockc.mark = READ_ONCE(sk->sk_mark);
 
 	/* destination address check */
 	if (sin6) {
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index 5137ea1861ce2..bce4132b0a5c8 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -519,7 +519,7 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	/* Get and verify the address */
 	memset(&fl6, 0, sizeof(fl6));
 
-	fl6.flowi6_mark = sk->sk_mark;
+	fl6.flowi6_mark = READ_ONCE(sk->sk_mark);
 	fl6.flowi6_uid = sk->sk_uid;
 
 	ipcm6_init(&ipc6);
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 696ba398d699a..937bd4c556151 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -102,7 +102,7 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
 			break;
 		case SO_MARK:
 			if (READ_ONCE(ssk->sk_mark) != sk->sk_mark) {
-				ssk->sk_mark = sk->sk_mark;
+				WRITE_ONCE(ssk->sk_mark, sk->sk_mark);
 				sk_dst_reset(ssk);
 			}
 			break;
diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
index 49a5348a6a14f..777561b71fcbd 100644
--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -107,7 +107,7 @@ static void nft_socket_eval(const struct nft_expr *expr,
 		break;
 	case NFT_SOCKET_MARK:
 		if (sk_fullsock(sk)) {
-			*dest = sk->sk_mark;
+			*dest = READ_ONCE(sk->sk_mark);
 		} else {
 			regs->verdict.code = NFT_BREAK;
 			return;
diff --git a/net/netfilter/xt_socket.c b/net/netfilter/xt_socket.c
index 7013f55f05d1e..76e01f292aaff 100644
--- a/net/netfilter/xt_socket.c
+++ b/net/netfilter/xt_socket.c
@@ -77,7 +77,7 @@ socket_match(const struct sk_buff *skb, struct xt_action_param *par,
 
 		if (info->flags & XT_SOCKET_RESTORESKMARK && !wildcard &&
 		    transparent && sk_fullsock(sk))
-			pskb->mark = sk->sk_mark;
+			pskb->mark = READ_ONCE(sk->sk_mark);
 
 		if (sk != skb->sk)
 			sock_gen_put(sk);
@@ -138,7 +138,7 @@ socket_mt6_v1_v2_v3(const struct sk_buff *skb, struct xt_action_param *par)
 
 		if (info->flags & XT_SOCKET_RESTORESKMARK && !wildcard &&
 		    transparent && sk_fullsock(sk))
-			pskb->mark = sk->sk_mark;
+			pskb->mark = READ_ONCE(sk->sk_mark);
 
 		if (sk != skb->sk)
 			sock_gen_put(sk);
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 6ab9d5b543387..30a28c1ff928a 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2053,7 +2053,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 	skb->protocol = proto;
 	skb->dev = dev;
 	skb->priority = sk->sk_priority;
-	skb->mark = sk->sk_mark;
+	skb->mark = READ_ONCE(sk->sk_mark);
 	skb->tstamp = sockc.transmit_time;
 
 	skb_setup_tx_timestamp(skb, sockc.tsflags);
@@ -2576,7 +2576,7 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	skb->protocol = proto;
 	skb->dev = dev;
 	skb->priority = po->sk.sk_priority;
-	skb->mark = po->sk.sk_mark;
+	skb->mark = READ_ONCE(po->sk.sk_mark);
 	skb->tstamp = sockc->transmit_time;
 	skb_setup_tx_timestamp(skb, sockc->tsflags);
 	skb_zcopy_set_nouarg(skb, ph.raw);
@@ -2978,7 +2978,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 		goto out_unlock;
 
 	sockcm_init(&sockc, sk);
-	sockc.mark = sk->sk_mark;
+	sockc.mark = READ_ONCE(sk->sk_mark);
 	if (msg->msg_controllen) {
 		err = sock_cmsg_send(sk, msg, &sockc);
 		if (unlikely(err))
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 02d1daae77397..5ae0a54a823b5 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -447,7 +447,7 @@ static void smc_copy_sock_settings(struct sock *nsk, struct sock *osk,
 	nsk->sk_rcvbuf = osk->sk_rcvbuf;
 	nsk->sk_sndtimeo = osk->sk_sndtimeo;
 	nsk->sk_rcvtimeo = osk->sk_rcvtimeo;
-	nsk->sk_mark = osk->sk_mark;
+	nsk->sk_mark = READ_ONCE(osk->sk_mark);
 	nsk->sk_priority = osk->sk_priority;
 	nsk->sk_rcvlowat = osk->sk_rcvlowat;
 	nsk->sk_bound_dev_if = osk->sk_bound_dev_if;
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 371d269d22fa0..22bf10ffbf2d1 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -504,7 +504,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 	skb->dev = dev;
 	skb->priority = xs->sk.sk_priority;
-	skb->mark = xs->sk.sk_mark;
+	skb->mark = READ_ONCE(xs->sk.sk_mark);
 	skb_shinfo(skb)->destructor_arg = (void *)(long)desc->addr;
 	skb->destructor = xsk_destruct_skb;
 
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 7b1b93584bdbe..e65de78cb61bf 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2174,7 +2174,7 @@ static struct xfrm_policy *xfrm_sk_policy_lookup(const struct sock *sk, int dir,
 
 		match = xfrm_selector_match(&pol->selector, fl, family);
 		if (match) {
-			if ((sk->sk_mark & pol->mark.m) != pol->mark.v ||
+			if ((READ_ONCE(sk->sk_mark) & pol->mark.m) != pol->mark.v ||
 			    pol->if_id != if_id) {
 				pol = NULL;
 				goto out;
-- 
2.40.1



