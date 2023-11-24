Return-Path: <stable+bounces-2185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9F47F8321
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3B91C24D90
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE734381CC;
	Fri, 24 Nov 2023 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LwVgqmO9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C38C1A5A4;
	Fri, 24 Nov 2023 19:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FF7C433C8;
	Fri, 24 Nov 2023 19:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853259;
	bh=uy/3bdgm9oYWWTBprIWWyjs3+dYgkxb2jdnguOSbQOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LwVgqmO9eoycYCXeESoknZQzdoObu0T0Xbw6KfaKof6pUBuIVnAJRNt/RlVbq9g9W
	 cL2rYRGNsJivECl6b3Dj7rpawjgHgDUel8NZBRm/kz7fvKvqn1iTXp4CvOlYSqPT5k
	 Vl7glRfTBskCG8H5WysfqVnz2MrlpH588JTIVc/w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Martin KaFai Lau <kafai@fb.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 100/297] net: inet: Retire port only listening_hash
Date: Fri, 24 Nov 2023 17:52:22 +0000
Message-ID: <20231124172003.756426017@linuxfoundation.org>
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

[ Upstream commit cae3873c5b3a4fcd9706fb461ff4e91bdf1f0120 ]

The listen sk is currently stored in two hash tables,
listening_hash (hashed by port) and lhash2 (hashed by port and address).

After commit 0ee58dad5b06 ("net: tcp6: prefer listeners bound to an address")
and commit d9fbc7f6431f ("net: tcp: prefer listeners bound to an address"),
the TCP-SYN lookup fast path does not use listening_hash.

The commit 05c0b35709c5 ("tcp: seq_file: Replace listening_hash with lhash2")
also moved the seq_file (/proc/net/tcp) iteration usage from
listening_hash to lhash2.

There are still a few listening_hash usages left.
One of them is inet_reuseport_add_sock() which uses the listening_hash
to search a listen sk during the listen() system call.  This turns
out to be very slow on use cases that listen on many different
VIPs at a popular port (e.g. 443).  [ On top of the slowness in
adding to the tail in the IPv6 case ].  The latter patch has a
selftest to demonstrate this case.

This patch takes this chance to move all remaining listening_hash
usages to lhash2 and then retire listening_hash.

Since most changes need to be done together, it is hard to cut
the listening_hash to lhash2 switch into small patches.  The
changes in this patch is highlighted here for the review
purpose.

1. Because of the listening_hash removal, lhash2 can use the
   sk->sk_nulls_node instead of the icsk->icsk_listen_portaddr_node.
   This will also keep the sk_unhashed() check to work as is
   after stop adding sk to listening_hash.

   The union is removed from inet_listen_hashbucket because
   only nulls_head is needed.

2. icsk->icsk_listen_portaddr_node and its helpers are removed.

3. The current lhash2 users needs to iterate with sk_nulls_node
   instead of icsk_listen_portaddr_node.

   One case is in the inet[6]_lhash2_lookup().

   Another case is the seq_file iterator in tcp_ipv4.c.
   One thing to note is sk_nulls_next() is needed
   because the old inet_lhash2_for_each_icsk_continue()
   does a "next" first before iterating.

4. Move the remaining listening_hash usage to lhash2

   inet_reuseport_add_sock() which this series is
   trying to improve.

   inet_diag.c and mptcp_diag.c are the final two
   remaining use cases and is moved to lhash2 now also.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 871019b22d1b ("net: set SOCK_RCU_FREE before inserting socket into hashtable")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/inet_connection_sock.h |  2 --
 include/net/inet_hashtables.h      | 41 +-------------------------
 net/dccp/proto.c                   |  1 -
 net/ipv4/inet_diag.c               |  5 ++--
 net/ipv4/inet_hashtables.c         | 47 ++++++------------------------
 net/ipv4/tcp.c                     |  1 -
 net/ipv4/tcp_ipv4.c                | 21 ++++++-------
 net/ipv6/inet6_hashtables.c        |  5 ++--
 net/mptcp/mptcp_diag.c             |  4 +--
 9 files changed, 26 insertions(+), 101 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 695ed45841f06..d31a18824cd5c 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -66,7 +66,6 @@ struct inet_connection_sock_af_ops {
  * @icsk_ulp_ops	   Pluggable ULP control hook
  * @icsk_ulp_data	   ULP private data
  * @icsk_clean_acked	   Clean acked data hook
- * @icsk_listen_portaddr_node	hash to the portaddr listener hashtable
  * @icsk_ca_state:	   Congestion control state
  * @icsk_retransmits:	   Number of unrecovered [RTO] timeouts
  * @icsk_pending:	   Scheduled timer event
@@ -96,7 +95,6 @@ struct inet_connection_sock {
 	const struct tcp_ulp_ops  *icsk_ulp_ops;
 	void __rcu		  *icsk_ulp_data;
 	void (*icsk_clean_acked)(struct sock *sk, u32 acked_seq);
-	struct hlist_node         icsk_listen_portaddr_node;
 	unsigned int		  (*icsk_sync_mss)(struct sock *sk, u32 pmtu);
 	__u8			  icsk_ca_state:5,
 				  icsk_ca_initialized:1,
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 405670d7661da..a7a8e66a1bad0 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -111,10 +111,7 @@ struct inet_bind_hashbucket {
 #define LISTENING_NULLS_BASE (1U << 29)
 struct inet_listen_hashbucket {
 	spinlock_t		lock;
-	union {
-		struct hlist_head	head;
-		struct hlist_nulls_head	nulls_head;
-	};
+	struct hlist_nulls_head	nulls_head;
 };
 
 /* This is for listening sockets, thus all sockets which possess wildcards. */
@@ -142,32 +139,8 @@ struct inet_hashinfo {
 	/* The 2nd listener table hashed by local port and address */
 	unsigned int			lhash2_mask;
 	struct inet_listen_hashbucket	*lhash2;
-
-	/* All the above members are written once at bootup and
-	 * never written again _or_ are predominantly read-access.
-	 *
-	 * Now align to a new cache line as all the following members
-	 * might be often dirty.
-	 */
-	/* All sockets in TCP_LISTEN state will be in listening_hash.
-	 * This is the only table where wildcard'd TCP sockets can
-	 * exist.  listening_hash is only hashed by local port number.
-	 * If lhash2 is initialized, the same socket will also be hashed
-	 * to lhash2 by port and address.
-	 */
-	struct inet_listen_hashbucket	listening_hash[INET_LHTABLE_SIZE]
-					____cacheline_aligned_in_smp;
 };
 
-#define inet_lhash2_for_each_icsk_continue(__icsk) \
-	hlist_for_each_entry_continue(__icsk, icsk_listen_portaddr_node)
-
-#define inet_lhash2_for_each_icsk(__icsk, list) \
-	hlist_for_each_entry(__icsk, list, icsk_listen_portaddr_node)
-
-#define inet_lhash2_for_each_icsk_rcu(__icsk, list) \
-	hlist_for_each_entry_rcu(__icsk, list, icsk_listen_portaddr_node)
-
 static inline struct inet_listen_hashbucket *
 inet_lhash2_bucket(struct inet_hashinfo *h, u32 hash)
 {
@@ -218,23 +191,11 @@ static inline u32 inet_bhashfn(const struct net *net, const __u16 lport,
 void inet_bind_hash(struct sock *sk, struct inet_bind_bucket *tb,
 		    const unsigned short snum);
 
-/* These can have wildcards, don't try too hard. */
-static inline u32 inet_lhashfn(const struct net *net, const unsigned short num)
-{
-	return (num + net_hash_mix(net)) & (INET_LHTABLE_SIZE - 1);
-}
-
-static inline int inet_sk_listen_hashfn(const struct sock *sk)
-{
-	return inet_lhashfn(sock_net(sk), inet_sk(sk)->inet_num);
-}
-
 /* Caller must disable local BH processing. */
 int __inet_inherit_port(const struct sock *sk, struct sock *child);
 
 void inet_put_port(struct sock *sk);
 
-void inet_hashinfo_init(struct inet_hashinfo *h);
 void inet_hashinfo2_init(struct inet_hashinfo *h, const char *name,
 			 unsigned long numentries, int scale,
 			 unsigned long low_limit,
diff --git a/net/dccp/proto.c b/net/dccp/proto.c
index 0b0567a692a8f..1b285a57c7aab 100644
--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -1131,7 +1131,6 @@ static int __init dccp_init(void)
 
 	BUILD_BUG_ON(sizeof(struct dccp_skb_cb) >
 		     sizeof_field(struct sk_buff, cb));
-	inet_hashinfo_init(&dccp_hashinfo);
 	rc = inet_hashinfo2_init_mod(&dccp_hashinfo);
 	if (rc)
 		goto out_fail;
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index ae70e07c52445..09cabed358fd0 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -1028,12 +1028,13 @@ void inet_diag_dump_icsk(struct inet_hashinfo *hashinfo, struct sk_buff *skb,
 		if (!(idiag_states & TCPF_LISTEN) || r->id.idiag_dport)
 			goto skip_listen_ht;
 
-		for (i = s_i; i < INET_LHTABLE_SIZE; i++) {
+		for (i = s_i; i <= hashinfo->lhash2_mask; i++) {
 			struct inet_listen_hashbucket *ilb;
 			struct hlist_nulls_node *node;
 
 			num = 0;
-			ilb = &hashinfo->listening_hash[i];
+			ilb = &hashinfo->lhash2[i];
+
 			spin_lock(&ilb->lock);
 			sk_nulls_for_each(sk, node, &ilb->nulls_head) {
 				struct inet_sock *inet = inet_sk(sk);
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 637d806090b00..a673f4ec1b429 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -246,12 +246,11 @@ static struct sock *inet_lhash2_lookup(struct net *net,
 				const __be32 daddr, const unsigned short hnum,
 				const int dif, const int sdif)
 {
-	struct inet_connection_sock *icsk;
 	struct sock *sk, *result = NULL;
+	struct hlist_nulls_node *node;
 	int score, hiscore = 0;
 
-	inet_lhash2_for_each_icsk_rcu(icsk, &ilb2->head) {
-		sk = (struct sock *)icsk;
+	sk_nulls_for_each_rcu(sk, node, &ilb2->nulls_head) {
 		score = compute_score(sk, net, hnum, daddr, dif, sdif);
 		if (score > hiscore) {
 			result = lookup_reuseport(net, sk, skb, doff,
@@ -593,7 +592,6 @@ int __inet_hash(struct sock *sk, struct sock *osk)
 {
 	struct inet_hashinfo *hashinfo = sk->sk_prot->h.hashinfo;
 	struct inet_listen_hashbucket *ilb2;
-	struct inet_listen_hashbucket *ilb;
 	int err = 0;
 
 	if (sk->sk_state != TCP_LISTEN) {
@@ -603,31 +601,23 @@ int __inet_hash(struct sock *sk, struct sock *osk)
 		return 0;
 	}
 	WARN_ON(!sk_unhashed(sk));
-	ilb = &hashinfo->listening_hash[inet_sk_listen_hashfn(sk)];
 	ilb2 = inet_lhash2_bucket_sk(hashinfo, sk);
 
-	spin_lock(&ilb->lock);
 	spin_lock(&ilb2->lock);
 	if (sk->sk_reuseport) {
-		err = inet_reuseport_add_sock(sk, ilb);
+		err = inet_reuseport_add_sock(sk, ilb2);
 		if (err)
 			goto unlock;
 	}
 	if (IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
-		sk->sk_family == AF_INET6) {
-		hlist_add_tail_rcu(&inet_csk(sk)->icsk_listen_portaddr_node,
-				   &ilb2->head);
-		__sk_nulls_add_node_tail_rcu(sk, &ilb->nulls_head);
-	} else {
-		hlist_add_head_rcu(&inet_csk(sk)->icsk_listen_portaddr_node,
-				   &ilb2->head);
-		__sk_nulls_add_node_rcu(sk, &ilb->nulls_head);
-	}
+		sk->sk_family == AF_INET6)
+		__sk_nulls_add_node_tail_rcu(sk, &ilb2->nulls_head);
+	else
+		__sk_nulls_add_node_rcu(sk, &ilb2->nulls_head);
 	sock_set_flag(sk, SOCK_RCU_FREE);
 	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 unlock:
 	spin_unlock(&ilb2->lock);
-	spin_unlock(&ilb->lock);
 
 	return err;
 }
@@ -653,29 +643,23 @@ void inet_unhash(struct sock *sk)
 
 	if (sk->sk_state == TCP_LISTEN) {
 		struct inet_listen_hashbucket *ilb2;
-		struct inet_listen_hashbucket *ilb;
 
-		ilb = &hashinfo->listening_hash[inet_sk_listen_hashfn(sk)];
 		ilb2 = inet_lhash2_bucket_sk(hashinfo, sk);
 		/* Don't disable bottom halves while acquiring the lock to
 		 * avoid circular locking dependency on PREEMPT_RT.
 		 */
-		spin_lock(&ilb->lock);
 		spin_lock(&ilb2->lock);
 		if (sk_unhashed(sk)) {
 			spin_unlock(&ilb2->lock);
-			spin_unlock(&ilb->lock);
 			return;
 		}
 
 		if (rcu_access_pointer(sk->sk_reuseport_cb))
 			reuseport_stop_listen_sock(sk);
 
-		hlist_del_init_rcu(&inet_csk(sk)->icsk_listen_portaddr_node);
 		__sk_nulls_del_node_init_rcu(sk);
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
 		spin_unlock(&ilb2->lock);
-		spin_unlock(&ilb->lock);
 	} else {
 		spinlock_t *lock = inet_ehash_lockp(hashinfo, sk->sk_hash);
 
@@ -833,27 +817,14 @@ int inet_hash_connect(struct inet_timewait_death_row *death_row,
 }
 EXPORT_SYMBOL_GPL(inet_hash_connect);
 
-void inet_hashinfo_init(struct inet_hashinfo *h)
-{
-	int i;
-
-	for (i = 0; i < INET_LHTABLE_SIZE; i++) {
-		spin_lock_init(&h->listening_hash[i].lock);
-		INIT_HLIST_NULLS_HEAD(&h->listening_hash[i].nulls_head,
-				      i + LISTENING_NULLS_BASE);
-	}
-
-	h->lhash2 = NULL;
-}
-EXPORT_SYMBOL_GPL(inet_hashinfo_init);
-
 static void init_hashinfo_lhash2(struct inet_hashinfo *h)
 {
 	int i;
 
 	for (i = 0; i <= h->lhash2_mask; i++) {
 		spin_lock_init(&h->lhash2[i].lock);
-		INIT_HLIST_HEAD(&h->lhash2[i].head);
+		INIT_HLIST_NULLS_HEAD(&h->lhash2[i].nulls_head,
+				      i + LISTENING_NULLS_BASE);
 	}
 }
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 6dcb77a2bde60..86dff7abdfd69 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4554,7 +4554,6 @@ void __init tcp_init(void)
 	timer_setup(&tcp_orphan_timer, tcp_orphan_update, TIMER_DEFERRABLE);
 	mod_timer(&tcp_orphan_timer, jiffies + TCP_ORPHAN_TIMER_PERIOD);
 
-	inet_hashinfo_init(&tcp_hashinfo);
 	inet_hashinfo2_init(&tcp_hashinfo, "tcp_listen_portaddr_hash",
 			    thash_entries, 21,  /* one slot per 2 MB*/
 			    0, 64 * 1024);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index f89cb184649ec..0666be6b9ec93 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2343,16 +2343,15 @@ static void *listening_get_first(struct seq_file *seq)
 	st->offset = 0;
 	for (; st->bucket <= tcp_hashinfo.lhash2_mask; st->bucket++) {
 		struct inet_listen_hashbucket *ilb2;
-		struct inet_connection_sock *icsk;
+		struct hlist_nulls_node *node;
 		struct sock *sk;
 
 		ilb2 = &tcp_hashinfo.lhash2[st->bucket];
-		if (hlist_empty(&ilb2->head))
+		if (hlist_nulls_empty(&ilb2->nulls_head))
 			continue;
 
 		spin_lock(&ilb2->lock);
-		inet_lhash2_for_each_icsk(icsk, &ilb2->head) {
-			sk = (struct sock *)icsk;
+		sk_nulls_for_each(sk, node, &ilb2->nulls_head) {
 			if (seq_sk_match(seq, sk))
 				return sk;
 		}
@@ -2371,15 +2370,14 @@ static void *listening_get_next(struct seq_file *seq, void *cur)
 {
 	struct tcp_iter_state *st = seq->private;
 	struct inet_listen_hashbucket *ilb2;
-	struct inet_connection_sock *icsk;
+	struct hlist_nulls_node *node;
 	struct sock *sk = cur;
 
 	++st->num;
 	++st->offset;
 
-	icsk = inet_csk(sk);
-	inet_lhash2_for_each_icsk_continue(icsk) {
-		sk = (struct sock *)icsk;
+	sk = sk_nulls_next(sk);
+	sk_nulls_for_each_from(sk, node) {
 		if (seq_sk_match(seq, sk))
 			return sk;
 	}
@@ -2788,16 +2786,15 @@ static unsigned int bpf_iter_tcp_listening_batch(struct seq_file *seq,
 {
 	struct bpf_tcp_iter_state *iter = seq->private;
 	struct tcp_iter_state *st = &iter->state;
-	struct inet_connection_sock *icsk;
+	struct hlist_nulls_node *node;
 	unsigned int expected = 1;
 	struct sock *sk;
 
 	sock_hold(start_sk);
 	iter->batch[iter->end_sk++] = start_sk;
 
-	icsk = inet_csk(start_sk);
-	inet_lhash2_for_each_icsk_continue(icsk) {
-		sk = (struct sock *)icsk;
+	sk = sk_nulls_next(start_sk);
+	sk_nulls_for_each_from(sk, node) {
 		if (seq_sk_match(seq, sk)) {
 			if (iter->end_sk < iter->max_sk) {
 				sock_hold(sk);
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index b4a5e01e12016..c40cbdfc6247f 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -138,12 +138,11 @@ static struct sock *inet6_lhash2_lookup(struct net *net,
 		const __be16 sport, const struct in6_addr *daddr,
 		const unsigned short hnum, const int dif, const int sdif)
 {
-	struct inet_connection_sock *icsk;
 	struct sock *sk, *result = NULL;
+	struct hlist_nulls_node *node;
 	int score, hiscore = 0;
 
-	inet_lhash2_for_each_icsk_rcu(icsk, &ilb2->head) {
-		sk = (struct sock *)icsk;
+	sk_nulls_for_each_rcu(sk, node, &ilb2->nulls_head) {
 		score = compute_score(sk, net, hnum, daddr, dif, sdif);
 		if (score > hiscore) {
 			result = lookup_reuseport(net, sk, skb, doff,
diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index 4d8625d0b179a..520ee65850553 100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -83,13 +83,13 @@ static void mptcp_diag_dump_listeners(struct sk_buff *skb, struct netlink_callba
 	struct net *net = sock_net(skb->sk);
 	int i;
 
-	for (i = diag_ctx->l_slot; i < INET_LHTABLE_SIZE; i++) {
+	for (i = diag_ctx->l_slot; i <= tcp_hashinfo.lhash2_mask; i++) {
 		struct inet_listen_hashbucket *ilb;
 		struct hlist_nulls_node *node;
 		struct sock *sk;
 		int num = 0;
 
-		ilb = &tcp_hashinfo.listening_hash[i];
+		ilb = &tcp_hashinfo.lhash2[i];
 
 		rcu_read_lock();
 		spin_lock(&ilb->lock);
-- 
2.42.0




