Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE08E78AA29
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjH1KTQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjH1KSw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:18:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D0812D
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:18:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B96D637B5
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB20C433C7;
        Mon, 28 Aug 2023 10:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693217924;
        bh=4/UHMmuxJT2zXUL86Hg08YB147mOv5PPQqhHTzsEKmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wnd1xKc9yt9axePvMMNXWmWyvBfN/uutlLBEzIHeL0zeWvO6JeSmN4S1bnLfWcjJT
         ieHmqPa21LSyR7dni6tctTulmtp/c5P93r36t8Cq9IphPbE8+3DeTdI7jRnCcpGxAz
         BmTGkZoL77y7DNZ/ZZSENp8xaj1K6cD4HKyfP39w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 031/129] ipv4: fix data-races around inet->inet_id
Date:   Mon, 28 Aug 2023 12:11:50 +0200
Message-ID: <20230828101158.421007131@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit f866fbc842de5976e41ba874b76ce31710b634b5 ]

UDP sendmsg() is lockless, so ip_select_ident_segs()
can very well be run from multiple cpus [1]

Convert inet->inet_id to an atomic_t, but implement
a dedicated path for TCP, avoiding cost of a locked
instruction (atomic_add_return())

Note that this patch will cause a trivial merge conflict
because we added inet->flags in net-next tree.

v2: added missing change in
drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
(David Ahern)

[1]

BUG: KCSAN: data-race in __ip_make_skb / __ip_make_skb

read-write to 0xffff888145af952a of 2 bytes by task 7803 on cpu 1:
ip_select_ident_segs include/net/ip.h:542 [inline]
ip_select_ident include/net/ip.h:556 [inline]
__ip_make_skb+0x844/0xc70 net/ipv4/ip_output.c:1446
ip_make_skb+0x233/0x2c0 net/ipv4/ip_output.c:1560
udp_sendmsg+0x1199/0x1250 net/ipv4/udp.c:1260
inet_sendmsg+0x63/0x80 net/ipv4/af_inet.c:830
sock_sendmsg_nosec net/socket.c:725 [inline]
sock_sendmsg net/socket.c:748 [inline]
____sys_sendmsg+0x37c/0x4d0 net/socket.c:2494
___sys_sendmsg net/socket.c:2548 [inline]
__sys_sendmmsg+0x269/0x500 net/socket.c:2634
__do_sys_sendmmsg net/socket.c:2663 [inline]
__se_sys_sendmmsg net/socket.c:2660 [inline]
__x64_sys_sendmmsg+0x57/0x60 net/socket.c:2660
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff888145af952a of 2 bytes by task 7804 on cpu 0:
ip_select_ident_segs include/net/ip.h:541 [inline]
ip_select_ident include/net/ip.h:556 [inline]
__ip_make_skb+0x817/0xc70 net/ipv4/ip_output.c:1446
ip_make_skb+0x233/0x2c0 net/ipv4/ip_output.c:1560
udp_sendmsg+0x1199/0x1250 net/ipv4/udp.c:1260
inet_sendmsg+0x63/0x80 net/ipv4/af_inet.c:830
sock_sendmsg_nosec net/socket.c:725 [inline]
sock_sendmsg net/socket.c:748 [inline]
____sys_sendmsg+0x37c/0x4d0 net/socket.c:2494
___sys_sendmsg net/socket.c:2548 [inline]
__sys_sendmmsg+0x269/0x500 net/socket.c:2634
__do_sys_sendmmsg net/socket.c:2663 [inline]
__se_sys_sendmmsg net/socket.c:2660 [inline]
__x64_sys_sendmmsg+0x57/0x60 net/socket.c:2660
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x184d -> 0x184e

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 7804 Comm: syz-executor.1 Not tainted 6.5.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
==================================================================

Fixes: 23f57406b82d ("ipv4: avoid using shared IP generator for connected sockets")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../chelsio/inline_crypto/chtls/chtls_cm.c        |  2 +-
 include/net/inet_sock.h                           |  2 +-
 include/net/ip.h                                  | 15 +++++++++++++--
 net/dccp/ipv4.c                                   |  4 ++--
 net/ipv4/af_inet.c                                |  2 +-
 net/ipv4/datagram.c                               |  2 +-
 net/ipv4/tcp_ipv4.c                               |  4 ++--
 net/sctp/socket.c                                 |  2 +-
 8 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
index c2e7037c7ba1c..7750702900fa6 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
@@ -1466,7 +1466,7 @@ static void make_established(struct sock *sk, u32 snd_isn, unsigned int opt)
 	tp->write_seq = snd_isn;
 	tp->snd_nxt = snd_isn;
 	tp->snd_una = snd_isn;
-	inet_sk(sk)->inet_id = get_random_u16();
+	atomic_set(&inet_sk(sk)->inet_id, get_random_u16());
 	assign_rxopt(sk, opt);
 
 	if (tp->rcv_wnd > (RCV_BUFSIZ_M << 10))
diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 0bb32bfc61832..491ceb7ebe5d1 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -222,8 +222,8 @@ struct inet_sock {
 	__s16			uc_ttl;
 	__u16			cmsg_flags;
 	struct ip_options_rcu __rcu	*inet_opt;
+	atomic_t		inet_id;
 	__be16			inet_sport;
-	__u16			inet_id;
 
 	__u8			tos;
 	__u8			min_ttl;
diff --git a/include/net/ip.h b/include/net/ip.h
index 530e7257e4389..1872f570abeda 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -532,8 +532,19 @@ static inline void ip_select_ident_segs(struct net *net, struct sk_buff *skb,
 	 * generator as much as we can.
 	 */
 	if (sk && inet_sk(sk)->inet_daddr) {
-		iph->id = htons(inet_sk(sk)->inet_id);
-		inet_sk(sk)->inet_id += segs;
+		int val;
+
+		/* avoid atomic operations for TCP,
+		 * as we hold socket lock at this point.
+		 */
+		if (sk_is_tcp(sk)) {
+			sock_owned_by_me(sk);
+			val = atomic_read(&inet_sk(sk)->inet_id);
+			atomic_set(&inet_sk(sk)->inet_id, val + segs);
+		} else {
+			val = atomic_add_return(segs, &inet_sk(sk)->inet_id);
+		}
+		iph->id = htons(val);
 		return;
 	}
 	if ((iph->frag_off & htons(IP_DF)) && !skb->ignore_df) {
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index 3ab68415d121c..e7b9703bd1a1a 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -130,7 +130,7 @@ int dccp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 						    inet->inet_daddr,
 						    inet->inet_sport,
 						    inet->inet_dport);
-	inet->inet_id = get_random_u16();
+	atomic_set(&inet->inet_id, get_random_u16());
 
 	err = dccp_connect(sk);
 	rt = NULL;
@@ -432,7 +432,7 @@ struct sock *dccp_v4_request_recv_sock(const struct sock *sk,
 	RCU_INIT_POINTER(newinet->inet_opt, rcu_dereference(ireq->ireq_opt));
 	newinet->mc_index  = inet_iif(skb);
 	newinet->mc_ttl	   = ip_hdr(skb)->ttl;
-	newinet->inet_id   = get_random_u16();
+	atomic_set(&newinet->inet_id, get_random_u16());
 
 	if (dst == NULL && (dst = inet_csk_route_child_sock(sk, newsk, req)) == NULL)
 		goto put_and_exit;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 10ebe39dcc873..9dde8e842befe 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -340,7 +340,7 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 	else
 		inet->pmtudisc = IP_PMTUDISC_WANT;
 
-	inet->inet_id = 0;
+	atomic_set(&inet->inet_id, 0);
 
 	sock_init_data(sock, sk);
 
diff --git a/net/ipv4/datagram.c b/net/ipv4/datagram.c
index 4d1af0cd7d99e..cb5dbee9e018f 100644
--- a/net/ipv4/datagram.c
+++ b/net/ipv4/datagram.c
@@ -73,7 +73,7 @@ int __ip4_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len
 	reuseport_has_conns_set(sk);
 	sk->sk_state = TCP_ESTABLISHED;
 	sk_set_txhash(sk);
-	inet->inet_id = get_random_u16();
+	atomic_set(&inet->inet_id, get_random_u16());
 
 	sk_dst_set(sk, &rt->dst);
 	err = 0;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 498dd4acdeec8..caecb4d1e424a 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -312,7 +312,7 @@ int tcp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 					     inet->inet_daddr));
 	}
 
-	inet->inet_id = get_random_u16();
+	atomic_set(&inet->inet_id, get_random_u16());
 
 	if (tcp_fastopen_defer_connect(sk, &err))
 		return err;
@@ -1596,7 +1596,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 	inet_csk(newsk)->icsk_ext_hdr_len = 0;
 	if (inet_opt)
 		inet_csk(newsk)->icsk_ext_hdr_len = inet_opt->opt.optlen;
-	newinet->inet_id = get_random_u16();
+	atomic_set(&newinet->inet_id, get_random_u16());
 
 	/* Set ToS of the new socket based upon the value of incoming SYN.
 	 * ECT bits are set later in tcp_init_transfer().
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index de52045774303..d77561d97a1ed 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9479,7 +9479,7 @@ void sctp_copy_sock(struct sock *newsk, struct sock *sk,
 	newinet->inet_rcv_saddr = inet->inet_rcv_saddr;
 	newinet->inet_dport = htons(asoc->peer.port);
 	newinet->pmtudisc = inet->pmtudisc;
-	newinet->inet_id = get_random_u16();
+	atomic_set(&newinet->inet_id, get_random_u16());
 
 	newinet->uc_ttl = inet->uc_ttl;
 	newinet->mc_loop = 1;
-- 
2.40.1



