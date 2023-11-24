Return-Path: <stable+bounces-2174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598587F8316
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13FF0286FD2
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D8037170;
	Fri, 24 Nov 2023 19:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CN6ne35/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CB735EE6;
	Fri, 24 Nov 2023 19:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86831C433C8;
	Fri, 24 Nov 2023 19:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853231;
	bh=5Ujtm6Xon2sNUkzsgMWjCl8RWsdzq8MXS1I25iVbytc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CN6ne35/7ue7ZzjcrGbg5/vERN0jWnXYgv9FtH67ewfsDjsMpQixqVRJyR2kBgrr4
	 drVvJ0jcynZMU6njZUvXOfc2+8pTAbab6sKJ8XkiVuLMtvi4F6tLqzylX1Kzlhp0me
	 BPpmbTlrIvhaRcPs2GxYqgOR1B5uj5hH5AYboOfY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Martin KaFai Lau <kafai@fb.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 099/297] net: inet: Open code inet_hash2 and inet_unhash2
Date: Fri, 24 Nov 2023 17:52:21 +0000
Message-ID: <20231124172003.724929298@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
References: <20231124172000.087816911@linuxfoundation.org>
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

From: Martin KaFai Lau <kafai@fb.com>

[ Upstream commit e8d0059000b20c4745c5b6a713f6adb269cff8ff ]

This patch folds lhash2 related functions into __inet_hash and
inet_unhash.  This will make the removal of the listening_hash
in a latter patch easier to review.

First, this patch folds inet_hash2 into __inet_hash.

For unhash, the current call sequence is like
inet_unhash() => __inet_unhash() => inet_unhash2().
The specific testing cases in __inet_unhash() are mostly related
to TCP_LISTEN sk and its caller inet_unhash() already has
the TCP_LISTEN test, so this patch folds both __inet_unhash() and
inet_unhash2() into inet_unhash().

Note that all listening_hash users also have lhash2 initialized,
so the !h->lhash2 check is no longer needed.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 871019b22d1b ("net: set SOCK_RCU_FREE before inserting socket into hashtable")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/inet_hashtables.c | 88 ++++++++++++++------------------------
 1 file changed, 33 insertions(+), 55 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 8e0451248fc05..637d806090b00 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -193,40 +193,6 @@ inet_lhash2_bucket_sk(struct inet_hashinfo *h, struct sock *sk)
 	return inet_lhash2_bucket(h, hash);
 }
 
-static void inet_hash2(struct inet_hashinfo *h, struct sock *sk)
-{
-	struct inet_listen_hashbucket *ilb2;
-
-	if (!h->lhash2)
-		return;
-
-	ilb2 = inet_lhash2_bucket_sk(h, sk);
-
-	spin_lock(&ilb2->lock);
-	if (sk->sk_reuseport && sk->sk_family == AF_INET6)
-		hlist_add_tail_rcu(&inet_csk(sk)->icsk_listen_portaddr_node,
-				   &ilb2->head);
-	else
-		hlist_add_head_rcu(&inet_csk(sk)->icsk_listen_portaddr_node,
-				   &ilb2->head);
-	spin_unlock(&ilb2->lock);
-}
-
-static void inet_unhash2(struct inet_hashinfo *h, struct sock *sk)
-{
-	struct inet_listen_hashbucket *ilb2;
-
-	if (!h->lhash2 ||
-	    WARN_ON_ONCE(hlist_unhashed(&inet_csk(sk)->icsk_listen_portaddr_node)))
-		return;
-
-	ilb2 = inet_lhash2_bucket_sk(h, sk);
-
-	spin_lock(&ilb2->lock);
-	hlist_del_init_rcu(&inet_csk(sk)->icsk_listen_portaddr_node);
-	spin_unlock(&ilb2->lock);
-}
-
 static inline int compute_score(struct sock *sk, struct net *net,
 				const unsigned short hnum, const __be32 daddr,
 				const int dif, const int sdif)
@@ -626,6 +592,7 @@ static int inet_reuseport_add_sock(struct sock *sk,
 int __inet_hash(struct sock *sk, struct sock *osk)
 {
 	struct inet_hashinfo *hashinfo = sk->sk_prot->h.hashinfo;
+	struct inet_listen_hashbucket *ilb2;
 	struct inet_listen_hashbucket *ilb;
 	int err = 0;
 
@@ -637,22 +604,29 @@ int __inet_hash(struct sock *sk, struct sock *osk)
 	}
 	WARN_ON(!sk_unhashed(sk));
 	ilb = &hashinfo->listening_hash[inet_sk_listen_hashfn(sk)];
+	ilb2 = inet_lhash2_bucket_sk(hashinfo, sk);
 
 	spin_lock(&ilb->lock);
+	spin_lock(&ilb2->lock);
 	if (sk->sk_reuseport) {
 		err = inet_reuseport_add_sock(sk, ilb);
 		if (err)
 			goto unlock;
 	}
 	if (IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
-		sk->sk_family == AF_INET6)
+		sk->sk_family == AF_INET6) {
+		hlist_add_tail_rcu(&inet_csk(sk)->icsk_listen_portaddr_node,
+				   &ilb2->head);
 		__sk_nulls_add_node_tail_rcu(sk, &ilb->nulls_head);
-	else
+	} else {
+		hlist_add_head_rcu(&inet_csk(sk)->icsk_listen_portaddr_node,
+				   &ilb2->head);
 		__sk_nulls_add_node_rcu(sk, &ilb->nulls_head);
-	inet_hash2(hashinfo, sk);
+	}
 	sock_set_flag(sk, SOCK_RCU_FREE);
 	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 unlock:
+	spin_unlock(&ilb2->lock);
 	spin_unlock(&ilb->lock);
 
 	return err;
@@ -670,22 +644,6 @@ int inet_hash(struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(inet_hash);
 
-static void __inet_unhash(struct sock *sk, struct inet_listen_hashbucket *ilb)
-{
-	if (sk_unhashed(sk))
-		return;
-
-	if (rcu_access_pointer(sk->sk_reuseport_cb))
-		reuseport_stop_listen_sock(sk);
-	if (ilb) {
-		struct inet_hashinfo *hashinfo = sk->sk_prot->h.hashinfo;
-
-		inet_unhash2(hashinfo, sk);
-	}
-	__sk_nulls_del_node_init_rcu(sk);
-	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
-}
-
 void inet_unhash(struct sock *sk)
 {
 	struct inet_hashinfo *hashinfo = sk->sk_prot->h.hashinfo;
@@ -694,20 +652,40 @@ void inet_unhash(struct sock *sk)
 		return;
 
 	if (sk->sk_state == TCP_LISTEN) {
+		struct inet_listen_hashbucket *ilb2;
 		struct inet_listen_hashbucket *ilb;
 
 		ilb = &hashinfo->listening_hash[inet_sk_listen_hashfn(sk)];
+		ilb2 = inet_lhash2_bucket_sk(hashinfo, sk);
 		/* Don't disable bottom halves while acquiring the lock to
 		 * avoid circular locking dependency on PREEMPT_RT.
 		 */
 		spin_lock(&ilb->lock);
-		__inet_unhash(sk, ilb);
+		spin_lock(&ilb2->lock);
+		if (sk_unhashed(sk)) {
+			spin_unlock(&ilb2->lock);
+			spin_unlock(&ilb->lock);
+			return;
+		}
+
+		if (rcu_access_pointer(sk->sk_reuseport_cb))
+			reuseport_stop_listen_sock(sk);
+
+		hlist_del_init_rcu(&inet_csk(sk)->icsk_listen_portaddr_node);
+		__sk_nulls_del_node_init_rcu(sk);
+		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+		spin_unlock(&ilb2->lock);
 		spin_unlock(&ilb->lock);
 	} else {
 		spinlock_t *lock = inet_ehash_lockp(hashinfo, sk->sk_hash);
 
 		spin_lock_bh(lock);
-		__inet_unhash(sk, NULL);
+		if (sk_unhashed(sk)) {
+			spin_unlock_bh(lock);
+			return;
+		}
+		__sk_nulls_del_node_init_rcu(sk);
+		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
 		spin_unlock_bh(lock);
 	}
 }
-- 
2.42.0




