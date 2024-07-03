Return-Path: <stable+bounces-57565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE600925D05
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643FC294ABE
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6F9171671;
	Wed,  3 Jul 2024 11:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VHrsXOOP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9FA4DA14;
	Wed,  3 Jul 2024 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005269; cv=none; b=Pzu/szs0WDUiYsQMTxnbS8jNcCXmKXGV/HYWxa4fuPRaqWoK3cnAsmPhu8yzv9pv+rC0kjJbTuKOTgdy4TkLEScR1Vrn0VT9mFZ4dWLOguAK8psCBx48PUvvsBNVGMPzA14xYnYHVENJUCNAUtIdYRXAtzOKpfrFi4VimWwclj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005269; c=relaxed/simple;
	bh=m1t8K5NZEDI4RvkqCPY45aUd2WXh+8v8qytZzCcBPwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aeMZzMNAUXjkiw6cHniVVrjQNGgvq6qAkjLiWtDJcf14m++7+NSeOS5V1pK04yM0mU4vJw2q8Z2Mb6b6ADjLNHeo3xAT2j/PS3jJJZ+2nIFclyUqhET+pwtN3u7wpRr4e+NbM5aPD9gE/NpIP573G+LCDzMndyqCl8sOq063Xnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VHrsXOOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4617CC2BD10;
	Wed,  3 Jul 2024 11:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720005268;
	bh=m1t8K5NZEDI4RvkqCPY45aUd2WXh+8v8qytZzCcBPwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VHrsXOOPBQ4DrCsqlR9TELPB/FCfwLBZcK1jcqrhnK0F0vhq5YK3LXHVqQvTs3C0c
	 GM+2ax4KKwtWjOZiqMi3nsVMEK/A9Dx4dM0NvVB2nxBUdqa45GhKjY/FK+YNcDrch8
	 saMmGSDbiALola1CNNMj6vTI1NN/Sx0xKdm+Mw7U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 025/356] net: drop nopreempt requirement on sock_prot_inuse_add()
Date: Wed,  3 Jul 2024 12:36:01 +0200
Message-ID: <20240703102914.052608293@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102913.093882413@linuxfoundation.org>
References: <20240703102913.093882413@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit b3cb764aa1d753cf6a58858f9e2097ba71e8100b ]

This is distracting really, let's make this simpler,
because many callers had to take care of this
by themselves, even if on x86 this adds more
code than really needed.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: a9bf9c7dc6a5 ("af_unix: Annotate data-race of sk->sk_state in unix_stream_connect().")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/sock.h       | 4 ++--
 net/ieee802154/socket.c  | 4 ++--
 net/ipv4/raw.c           | 2 +-
 net/ipv6/ipv6_sockglue.c | 8 ++++----
 net/netlink/af_netlink.c | 4 ----
 net/packet/af_packet.c   | 4 ----
 net/sctp/socket.c        | 5 -----
 net/smc/af_smc.c         | 2 +-
 net/unix/af_unix.c       | 4 ----
 net/xdp/xsk.c            | 4 ----
 10 files changed, 10 insertions(+), 31 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index c13c284222424..146f1b9c30636 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1464,11 +1464,11 @@ proto_memory_pressure(struct proto *prot)
 struct prot_inuse {
 	int val[PROTO_INUSE_NR];
 };
-/* Called with local bh disabled */
+
 static inline void sock_prot_inuse_add(const struct net *net,
 				       const struct proto *prot, int val)
 {
-	__this_cpu_add(net->core.prot_inuse->val[prot->inuse_idx], val);
+	this_cpu_add(net->core.prot_inuse->val[prot->inuse_idx], val);
 }
 int sock_prot_inuse_get(struct net *net, struct proto *proto);
 int sock_inuse_get(struct net *net);
diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index c33f46c9b6b34..586a6c4adf246 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -174,8 +174,8 @@ static int raw_hash(struct sock *sk)
 {
 	write_lock_bh(&raw_lock);
 	sk_add_node(sk, &raw_head);
-	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 	write_unlock_bh(&raw_lock);
+	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 
 	return 0;
 }
@@ -458,8 +458,8 @@ static int dgram_hash(struct sock *sk)
 {
 	write_lock_bh(&dgram_lock);
 	sk_add_node(sk, &dgram_head);
-	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 	write_unlock_bh(&dgram_lock);
+	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 
 	return 0;
 }
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index f532589d26926..cc8e946768e43 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -99,8 +99,8 @@ int raw_hash_sk(struct sock *sk)
 
 	write_lock_bh(&h->lock);
 	sk_add_node(sk, head);
-	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 	write_unlock_bh(&h->lock);
+	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 
 	return 0;
 }
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 197e12d5607f1..2071a212a2679 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -471,10 +471,10 @@ static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 
 			if (sk->sk_protocol == IPPROTO_TCP) {
 				struct inet_connection_sock *icsk = inet_csk(sk);
-				local_bh_disable();
+
 				sock_prot_inuse_add(net, sk->sk_prot, -1);
 				sock_prot_inuse_add(net, &tcp_prot, 1);
-				local_bh_enable();
+
 				sk->sk_prot = &tcp_prot;
 				icsk->icsk_af_ops = &ipv4_specific;
 				sk->sk_socket->ops = &inet_stream_ops;
@@ -485,10 +485,10 @@ static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 
 				if (sk->sk_protocol == IPPROTO_UDPLITE)
 					prot = &udplite_prot;
-				local_bh_disable();
+
 				sock_prot_inuse_add(net, sk->sk_prot, -1);
 				sock_prot_inuse_add(net, prot, 1);
-				local_bh_enable();
+
 				sk->sk_prot = prot;
 				sk->sk_socket->ops = &inet_dgram_ops;
 				sk->sk_family = PF_INET;
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 216445dd44db9..18a38db2b27eb 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -711,9 +711,7 @@ static int netlink_create(struct net *net, struct socket *sock, int protocol,
 	if (err < 0)
 		goto out_module;
 
-	local_bh_disable();
 	sock_prot_inuse_add(net, &netlink_proto, 1);
-	local_bh_enable();
 
 	nlk = nlk_sk(sock->sk);
 	nlk->module = module;
@@ -813,9 +811,7 @@ static int netlink_release(struct socket *sock)
 		netlink_table_ungrab();
 	}
 
-	local_bh_disable();
 	sock_prot_inuse_add(sock_net(sk), &netlink_proto, -1);
-	local_bh_enable();
 	call_rcu(&nlk->rcu, deferred_put_nlk_sk);
 	return 0;
 }
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 0ab3b09f863ba..4f920502f92fe 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3092,9 +3092,7 @@ static int packet_release(struct socket *sock)
 	sk_del_node_init_rcu(sk);
 	mutex_unlock(&net->packet.sklist_lock);
 
-	preempt_disable();
 	sock_prot_inuse_add(net, sk->sk_prot, -1);
-	preempt_enable();
 
 	spin_lock(&po->bind_lock);
 	unregister_prot_hook(sk, false);
@@ -3361,9 +3359,7 @@ static int packet_create(struct net *net, struct socket *sock, int protocol,
 	sk_add_node_tail_rcu(sk, &net->packet.sklist);
 	mutex_unlock(&net->packet.sklist_lock);
 
-	preempt_disable();
 	sock_prot_inuse_add(net, &packet_proto, 1);
-	preempt_enable();
 
 	return 0;
 out2:
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 57acf7ed80de3..d9271ffb29781 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -5073,12 +5073,9 @@ static int sctp_init_sock(struct sock *sk)
 
 	SCTP_DBG_OBJCNT_INC(sock);
 
-	local_bh_disable();
 	sk_sockets_allocated_inc(sk);
 	sock_prot_inuse_add(net, sk->sk_prot, 1);
 
-	local_bh_enable();
-
 	return 0;
 }
 
@@ -5104,10 +5101,8 @@ static void sctp_destroy_sock(struct sock *sk)
 		list_del(&sp->auto_asconf_list);
 	}
 	sctp_endpoint_free(sp->ep);
-	local_bh_disable();
 	sk_sockets_allocated_dec(sk);
 	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
-	local_bh_enable();
 }
 
 /* Triggered when there are no references on the socket anymore */
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 8c11eb70c0f69..bd0b3a8b95d50 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -88,8 +88,8 @@ int smc_hash_sk(struct sock *sk)
 
 	write_lock_bh(&h->lock);
 	sk_add_node(sk, head);
-	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 	write_unlock_bh(&h->lock);
+	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 
 	return 0;
 }
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 73b287b7a1154..262aeaea9861c 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -515,9 +515,7 @@ static void unix_sock_destructor(struct sock *sk)
 		unix_release_addr(u->addr);
 
 	atomic_long_dec(&unix_nr_socks);
-	local_bh_disable();
 	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
-	local_bh_enable();
 #ifdef UNIX_REFCNT_DEBUG
 	pr_debug("UNIX %p is destroyed, %ld are still alive.\n", sk,
 		atomic_long_read(&unix_nr_socks));
@@ -890,9 +888,7 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
 	memset(&u->scm_stat, 0, sizeof(struct scm_stat));
 	unix_insert_socket(unix_sockets_unbound(sk), sk);
 
-	local_bh_disable();
 	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
-	local_bh_enable();
 
 	return sk;
 
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 1f61d15b3d1d4..da31a99ce6521 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -842,9 +842,7 @@ static int xsk_release(struct socket *sock)
 	sk_del_node_init_rcu(sk);
 	mutex_unlock(&net->xdp.lock);
 
-	local_bh_disable();
 	sock_prot_inuse_add(net, sk->sk_prot, -1);
-	local_bh_enable();
 
 	xsk_delete_from_maps(xs);
 	mutex_lock(&xs->mutex);
@@ -1465,9 +1463,7 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
 	sk_add_node_rcu(sk, &net->xdp.list);
 	mutex_unlock(&net->xdp.lock);
 
-	local_bh_disable();
 	sock_prot_inuse_add(net, &xsk_proto, 1);
-	local_bh_enable();
 
 	return 0;
 }
-- 
2.43.0




