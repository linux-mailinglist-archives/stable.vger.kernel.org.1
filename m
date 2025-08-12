Return-Path: <stable+bounces-168248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B6CB23425
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87AE93BA79D
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6392FA0F9;
	Tue, 12 Aug 2025 18:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1qe2pmE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBC52F4A0A
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023542; cv=none; b=WUN92U+m1+7HRAu5Rz546klKYgohvsiGhZ+mfPFOKAG9q97xsJw/LBYuiRrTuCqGpLCvq1r0kios3zEhpgba98VSIcfkhNx/atf4jrXc03RtOFoRq1Z3Q0Zx9haMESd/TjPhR8w2WADsAeh0qnsx6Kle6rXweeLIr34yQtEjSIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023542; c=relaxed/simple;
	bh=/cKcZ67G75Z5hk90NQtKNEy2MOgB0O5s+GEK2ZtW8ng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DMPq6vXjvp/xGJH7O9t36DlGtR35GCcwy4z+bh/h+B/ZG5F7m4xThZB/q3U5lg4y39qB8TlOb4sNyyOz2LBABb43Y94qk3nvDMb1vpGBzA/kwDXkg6iJkDHjS4Yt3I4jQlmd21c+itrmod16vtLgRCrU4AEJn3J0YBvrbkI0YMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1qe2pmE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A08C4CEF8;
	Tue, 12 Aug 2025 18:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755023541;
	bh=/cKcZ67G75Z5hk90NQtKNEy2MOgB0O5s+GEK2ZtW8ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r1qe2pmEE5wzvDXuiQUarL9332DApXF4oFp/IW46xg+b5UokS2rA3VJi4Y3/xz7Kb
	 nFfuUmJPnnKRZR4mgNgqpEUe8Wbknqm2pYqj/kcqAX+R1dTsys4GoLEGdHiEkZZuvz
	 /VeQv6Bp7RdSTqfwRCogkbL6nvG+YDkYNMK4S9MFR80ODpD380hc0/PN4Oro5P/h+M
	 jf46s89sHgf5beFtANZL0m/rlUseQ4vs8J50sV40/uRl2z8UX6bf0e24c0Udq6ZnH7
	 i1fDxHM5FVi91A1OkBt/1nbp/vF3/FMgty+OP4VBDRyAjq3/IfTGedbYp9eK0HPRv2
	 ojdR0yPlOTPIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	syzbot+30a19e01a97420719891@syzkaller.appspotmail.com,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] net: better track kernel sockets lifetime
Date: Tue, 12 Aug 2025 14:32:06 -0400
Message-Id: <20250812183207.2024870-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250812183207.2024870-1-sashal@kernel.org>
References: <2025081230-dentist-cautious-7bb4@gregkh>
 <20250812183207.2024870-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 5c70eb5c593d64d93b178905da215a9fd288a4b5 ]

While kernel sockets are dismantled during pernet_operations->exit(),
their freeing can be delayed by any tx packets still held in qdisc
or device queues, due to skb_set_owner_w() prior calls.

This then trigger the following warning from ref_tracker_dir_exit() [1]

To fix this, make sure that kernel sockets own a reference on net->passive.

Add sk_net_refcnt_upgrade() helper, used whenever a kernel socket
is converted to a refcounted one.

[1]

[  136.263918][   T35] ref_tracker: net notrefcnt@ffff8880638f01e0 has 1/2 users at
[  136.263918][   T35]      sk_alloc+0x2b3/0x370
[  136.263918][   T35]      inet6_create+0x6ce/0x10f0
[  136.263918][   T35]      __sock_create+0x4c0/0xa30
[  136.263918][   T35]      inet_ctl_sock_create+0xc2/0x250
[  136.263918][   T35]      igmp6_net_init+0x39/0x390
[  136.263918][   T35]      ops_init+0x31e/0x590
[  136.263918][   T35]      setup_net+0x287/0x9e0
[  136.263918][   T35]      copy_net_ns+0x33f/0x570
[  136.263918][   T35]      create_new_namespaces+0x425/0x7b0
[  136.263918][   T35]      unshare_nsproxy_namespaces+0x124/0x180
[  136.263918][   T35]      ksys_unshare+0x57d/0xa70
[  136.263918][   T35]      __x64_sys_unshare+0x38/0x40
[  136.263918][   T35]      do_syscall_64+0xf3/0x230
[  136.263918][   T35]      entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  136.263918][   T35]
[  136.343488][   T35] ref_tracker: net notrefcnt@ffff8880638f01e0 has 1/2 users at
[  136.343488][   T35]      sk_alloc+0x2b3/0x370
[  136.343488][   T35]      inet6_create+0x6ce/0x10f0
[  136.343488][   T35]      __sock_create+0x4c0/0xa30
[  136.343488][   T35]      inet_ctl_sock_create+0xc2/0x250
[  136.343488][   T35]      ndisc_net_init+0xa7/0x2b0
[  136.343488][   T35]      ops_init+0x31e/0x590
[  136.343488][   T35]      setup_net+0x287/0x9e0
[  136.343488][   T35]      copy_net_ns+0x33f/0x570
[  136.343488][   T35]      create_new_namespaces+0x425/0x7b0
[  136.343488][   T35]      unshare_nsproxy_namespaces+0x124/0x180
[  136.343488][   T35]      ksys_unshare+0x57d/0xa70
[  136.343488][   T35]      __x64_sys_unshare+0x38/0x40
[  136.343488][   T35]      do_syscall_64+0xf3/0x230
[  136.343488][   T35]      entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 0cafd77dcd03 ("net: add a refcount tracker for kernel sockets")
Reported-by: syzbot+30a19e01a97420719891@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/67b72aeb.050a0220.14d86d.0283.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://patch.msgid.link/20250220131854.4048077-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/sock.h       |  1 +
 net/core/sock.c          | 27 ++++++++++++++++++++++-----
 net/mptcp/subflow.c      |  5 +----
 net/netlink/af_netlink.c | 10 ----------
 net/rds/tcp.c            |  8 ++------
 net/smc/af_smc.c         |  5 +----
 net/sunrpc/svcsock.c     |  5 +----
 net/sunrpc/xprtsock.c    |  8 ++------
 8 files changed, 30 insertions(+), 39 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index b7270b6b9e9c..722f409cccd3 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1780,6 +1780,7 @@ static inline bool sock_allow_reclassification(const struct sock *csk)
 struct sock *sk_alloc(struct net *net, int family, gfp_t priority,
 		      struct proto *prot, int kern);
 void sk_free(struct sock *sk);
+void sk_net_refcnt_upgrade(struct sock *sk);
 void sk_destruct(struct sock *sk);
 struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority);
 void sk_free_unlock_clone(struct sock *sk);
diff --git a/net/core/sock.c b/net/core/sock.c
index 9c63da2829f6..d392cb37a864 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2243,6 +2243,7 @@ struct sock *sk_alloc(struct net *net, int family, gfp_t priority,
 			get_net_track(net, &sk->ns_tracker, priority);
 			sock_inuse_add(net, 1);
 		} else {
+			net_passive_inc(net);
 			__netns_tracker_alloc(net, &sk->ns_tracker,
 					      false, priority);
 		}
@@ -2267,6 +2268,7 @@ EXPORT_SYMBOL(sk_alloc);
 static void __sk_destruct(struct rcu_head *head)
 {
 	struct sock *sk = container_of(head, struct sock, sk_rcu);
+	struct net *net = sock_net(sk);
 	struct sk_filter *filter;
 
 	if (sk->sk_destruct)
@@ -2298,14 +2300,28 @@ static void __sk_destruct(struct rcu_head *head)
 	put_cred(sk->sk_peer_cred);
 	put_pid(sk->sk_peer_pid);
 
-	if (likely(sk->sk_net_refcnt))
-		put_net_track(sock_net(sk), &sk->ns_tracker);
-	else
-		__netns_tracker_free(sock_net(sk), &sk->ns_tracker, false);
-
+	if (likely(sk->sk_net_refcnt)) {
+		put_net_track(net, &sk->ns_tracker);
+	} else {
+		__netns_tracker_free(net, &sk->ns_tracker, false);
+		net_passive_dec(net);
+	}
 	sk_prot_free(sk->sk_prot_creator, sk);
 }
 
+void sk_net_refcnt_upgrade(struct sock *sk)
+{
+	struct net *net = sock_net(sk);
+
+	WARN_ON_ONCE(sk->sk_net_refcnt);
+	__netns_tracker_free(net, &sk->ns_tracker, false);
+	net_passive_dec(net);
+	sk->sk_net_refcnt = 1;
+	get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
+	sock_inuse_add(net, 1);
+}
+EXPORT_SYMBOL_GPL(sk_net_refcnt_upgrade);
+
 void sk_destruct(struct sock *sk)
 {
 	bool use_call_rcu = sock_flag(sk, SOCK_RCU_FREE);
@@ -2402,6 +2418,7 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 		 * is not properly dismantling its kernel sockets at netns
 		 * destroy time.
 		 */
+		net_passive_inc(sock_net(newsk));
 		__netns_tracker_alloc(sock_net(newsk), &newsk->ns_tracker,
 				      false, priority);
 	}
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0253a863a621..a05f201d194c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1768,10 +1768,7 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	 * needs it.
 	 * Update ns_tracker to current stack trace and refcounted tracker.
 	 */
-	__netns_tracker_free(net, &sf->sk->ns_tracker, false);
-	sf->sk->sk_net_refcnt = 1;
-	get_net_track(net, &sf->sk->ns_tracker, GFP_KERNEL);
-	sock_inuse_add(net, 1);
+	sk_net_refcnt_upgrade(sf->sk);
 	err = tcp_set_ulp(sf->sk, "mptcp");
 	if (err)
 		goto err_free;
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index b02fb75f8d4f..2290d14b0932 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -794,16 +794,6 @@ static int netlink_release(struct socket *sock)
 
 	sock_prot_inuse_add(sock_net(sk), &netlink_proto, -1);
 
-	/* Because struct net might disappear soon, do not keep a pointer. */
-	if (!sk->sk_net_refcnt && sock_net(sk) != &init_net) {
-		__netns_tracker_free(sock_net(sk), &sk->ns_tracker, false);
-		/* Because of deferred_put_nlk_sk and use of work queue,
-		 * it is possible  netns will be freed before this socket.
-		 */
-		sock_net_set(sk, &init_net);
-		__netns_tracker_alloc(&init_net, &sk->ns_tracker,
-				      false, GFP_KERNEL);
-	}
 	call_rcu(&nlk->rcu, deferred_put_nlk_sk);
 	return 0;
 }
diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 0581c53e6517..3cc2f303bf78 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -504,12 +504,8 @@ bool rds_tcp_tune(struct socket *sock)
 			release_sock(sk);
 			return false;
 		}
-		/* Update ns_tracker to current stack trace and refcounted tracker */
-		__netns_tracker_free(net, &sk->ns_tracker, false);
-
-		sk->sk_net_refcnt = 1;
-		netns_tracker_alloc(net, &sk->ns_tracker, GFP_KERNEL);
-		sock_inuse_add(net, 1);
+		sk_net_refcnt_upgrade(sk);
+		put_net(net);
 	}
 	rtn = net_generic(net, rds_tcp_netid);
 	if (rtn->sndbuf_size > 0) {
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 3c43239f09d3..cdd445d40b94 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3353,10 +3353,7 @@ int smc_create_clcsk(struct net *net, struct sock *sk, int family)
 	 * which need net ref.
 	 */
 	sk = smc->clcsock->sk;
-	__netns_tracker_free(net, &sk->ns_tracker, false);
-	sk->sk_net_refcnt = 1;
-	get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
-	sock_inuse_add(net, 1);
+	sk_net_refcnt_upgrade(sk);
 	return 0;
 }
 
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 3bfbb789c4be..780a54548372 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1541,10 +1541,7 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
 	newlen = error;
 
 	if (protocol == IPPROTO_TCP) {
-		__netns_tracker_free(net, &sock->sk->ns_tracker, false);
-		sock->sk->sk_net_refcnt = 1;
-		get_net_track(net, &sock->sk->ns_tracker, GFP_KERNEL);
-		sock_inuse_add(net, 1);
+		sk_net_refcnt_upgrade(sock->sk);
 		if ((error = kernel_listen(sock, 64)) < 0)
 			goto bummer;
 	}
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 67d099c7c662..acae53d74230 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1940,12 +1940,8 @@ static struct socket *xs_create_sock(struct rpc_xprt *xprt,
 		goto out;
 	}
 
-	if (protocol == IPPROTO_TCP) {
-		__netns_tracker_free(xprt->xprt_net, &sock->sk->ns_tracker, false);
-		sock->sk->sk_net_refcnt = 1;
-		get_net_track(xprt->xprt_net, &sock->sk->ns_tracker, GFP_KERNEL);
-		sock_inuse_add(xprt->xprt_net, 1);
-	}
+	if (protocol == IPPROTO_TCP)
+		sk_net_refcnt_upgrade(sock->sk);
 
 	filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
 	if (IS_ERR(filp))
-- 
2.39.5


