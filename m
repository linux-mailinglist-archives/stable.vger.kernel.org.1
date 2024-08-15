Return-Path: <stable+bounces-68346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0B49531C6
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D1E6B24A86
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1C919F482;
	Thu, 15 Aug 2024 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PpjUbyX9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF7718D630;
	Thu, 15 Aug 2024 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730277; cv=none; b=eiKf2sTAsq9/2hEPnpol2Qb5+tmGig6n18ubwUc4zI8+4fwJlHSgguh2XIqzmkfFDap4qTF1h64cDiGY8g9ykHHdgBZ49jw3HXIB5B1kzECXLlKVG/1yGJjub/hJGd6E4Es1nuFA0HNWM33ItJXRD6QHE4If6HxnbiEUh9DdElw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730277; c=relaxed/simple;
	bh=dsxwaYbDpwYV9Q8QD9aZoWg8Kpf/5YPxD2kU64hmCKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1IdwBpVFYzxR1qpkMK7m8cXPCMSMPJJamq/LfwPGuogkh92rpbLDJvIWR+MmXeP9tXFdR2xjpcVgMgdX+fprhXYXOVDWIJcA/AGdxBthCU1At4gxHD4OyDA7wB+isVxiU9xA09l1v4WSy8wVxw/SwWut9Z/r8kll5Jv2C7RxA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PpjUbyX9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8231CC32786;
	Thu, 15 Aug 2024 13:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723730277;
	bh=dsxwaYbDpwYV9Q8QD9aZoWg8Kpf/5YPxD2kU64hmCKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PpjUbyX9VghzWk5RsBaz+yXoqZ6S34Q1UF5akAEc9iAZgv4fL6OJDSDHj/M3dEVVZ
	 BjWYyyS1SUgKyzIkBsq+TF1v0nNbVwNDpnEkX9AfPjFOyu+fGzQvV+CxJlKsasVh/o
	 BgvJRBq8cFxJWcMG6a2rIfB5sJuUjMBPOPzyGLTg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 358/484] sctp: move hlist_node and hashent out of sctp_ep_common
Date: Thu, 15 Aug 2024 15:23:36 +0200
Message-ID: <20240815131955.256107355@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
References: <20240815131941.255804951@linuxfoundation.org>
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

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 3d3b2f57d4447e6e9f4096ad01d0e4129f7bc7e9 ]

Struct sctp_ep_common is included in both asoc and ep, but hlist_node
and hashent are only needed by ep after asoc_hashtable was dropped by
Commit b5eff7128366 ("sctp: drop the old assoc hashtable of sctp").

So it is better to move hlist_node and hashent from sctp_ep_common to
sctp_endpoint, and it saves some space for each asoc.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 9ab0faa7f9ff ("sctp: Fix null-ptr-deref in reuseport_add_sock().")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/sctp/sctp.h    |  4 ++--
 include/net/sctp/structs.h |  8 ++++----
 net/sctp/input.c           | 27 ++++++++++-----------------
 net/sctp/proc.c            | 10 ++++------
 net/sctp/socket.c          |  6 +++---
 5 files changed, 23 insertions(+), 32 deletions(-)

diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
index 3ae61ce2eabd0..bf3716fe83e07 100644
--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -509,8 +509,8 @@ static inline int sctp_ep_hashfn(struct net *net, __u16 lport)
 	return (net_hash_mix(net) + lport) & (sctp_ep_hashsize - 1);
 }
 
-#define sctp_for_each_hentry(epb, head) \
-	hlist_for_each_entry(epb, head, node)
+#define sctp_for_each_hentry(ep, head) \
+	hlist_for_each_entry(ep, head, node)
 
 /* Is a socket of this style? */
 #define sctp_style(sk, style) __sctp_style((sk), (SCTP_SOCKET_##style))
diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index 790252c1478b0..821b20a0f8829 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -1244,10 +1244,6 @@ enum sctp_endpoint_type {
  */
 
 struct sctp_ep_common {
-	/* Fields to help us manage our entries in the hash tables. */
-	struct hlist_node node;
-	int hashent;
-
 	/* Runtime type information.  What kind of endpoint is this? */
 	enum sctp_endpoint_type type;
 
@@ -1299,6 +1295,10 @@ struct sctp_endpoint {
 	/* Common substructure for endpoint and association. */
 	struct sctp_ep_common base;
 
+	/* Fields to help us manage our entries in the hash tables. */
+	struct hlist_node node;
+	int hashent;
+
 	/* Associations: A list of current associations and mappings
 	 *	      to the data consumers for each association. This
 	 *	      may be in the form of a hash table or other
diff --git a/net/sctp/input.c b/net/sctp/input.c
index d16b3885dcccb..4f43afa8678f9 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -748,23 +748,21 @@ static int __sctp_hash_endpoint(struct sctp_endpoint *ep)
 	struct sock *sk = ep->base.sk;
 	struct net *net = sock_net(sk);
 	struct sctp_hashbucket *head;
-	struct sctp_ep_common *epb;
 
-	epb = &ep->base;
-	epb->hashent = sctp_ep_hashfn(net, epb->bind_addr.port);
-	head = &sctp_ep_hashtable[epb->hashent];
+	ep->hashent = sctp_ep_hashfn(net, ep->base.bind_addr.port);
+	head = &sctp_ep_hashtable[ep->hashent];
 
 	if (sk->sk_reuseport) {
 		bool any = sctp_is_ep_boundall(sk);
-		struct sctp_ep_common *epb2;
+		struct sctp_endpoint *ep2;
 		struct list_head *list;
 		int cnt = 0, err = 1;
 
 		list_for_each(list, &ep->base.bind_addr.address_list)
 			cnt++;
 
-		sctp_for_each_hentry(epb2, &head->chain) {
-			struct sock *sk2 = epb2->sk;
+		sctp_for_each_hentry(ep2, &head->chain) {
+			struct sock *sk2 = ep2->base.sk;
 
 			if (!net_eq(sock_net(sk2), net) || sk2 == sk ||
 			    !uid_eq(sock_i_uid(sk2), sock_i_uid(sk)) ||
@@ -791,7 +789,7 @@ static int __sctp_hash_endpoint(struct sctp_endpoint *ep)
 	}
 
 	write_lock(&head->lock);
-	hlist_add_head(&epb->node, &head->chain);
+	hlist_add_head(&ep->node, &head->chain);
 	write_unlock(&head->lock);
 	return 0;
 }
@@ -813,19 +811,16 @@ static void __sctp_unhash_endpoint(struct sctp_endpoint *ep)
 {
 	struct sock *sk = ep->base.sk;
 	struct sctp_hashbucket *head;
-	struct sctp_ep_common *epb;
 
-	epb = &ep->base;
+	ep->hashent = sctp_ep_hashfn(sock_net(sk), ep->base.bind_addr.port);
 
-	epb->hashent = sctp_ep_hashfn(sock_net(sk), epb->bind_addr.port);
-
-	head = &sctp_ep_hashtable[epb->hashent];
+	head = &sctp_ep_hashtable[ep->hashent];
 
 	if (rcu_access_pointer(sk->sk_reuseport_cb))
 		reuseport_detach_sock(sk);
 
 	write_lock(&head->lock);
-	hlist_del_init(&epb->node);
+	hlist_del_init(&ep->node);
 	write_unlock(&head->lock);
 }
 
@@ -858,7 +853,6 @@ static struct sctp_endpoint *__sctp_rcv_lookup_endpoint(
 					const union sctp_addr *paddr)
 {
 	struct sctp_hashbucket *head;
-	struct sctp_ep_common *epb;
 	struct sctp_endpoint *ep;
 	struct sock *sk;
 	__be16 lport;
@@ -868,8 +862,7 @@ static struct sctp_endpoint *__sctp_rcv_lookup_endpoint(
 	hash = sctp_ep_hashfn(net, ntohs(lport));
 	head = &sctp_ep_hashtable[hash];
 	read_lock(&head->lock);
-	sctp_for_each_hentry(epb, &head->chain) {
-		ep = sctp_ep(epb);
+	sctp_for_each_hentry(ep, &head->chain) {
 		if (sctp_endpoint_is_match(ep, net, laddr))
 			goto hit;
 	}
diff --git a/net/sctp/proc.c b/net/sctp/proc.c
index 963b94517ec20..ec00ee75d59a6 100644
--- a/net/sctp/proc.c
+++ b/net/sctp/proc.c
@@ -161,7 +161,6 @@ static void *sctp_eps_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 static int sctp_eps_seq_show(struct seq_file *seq, void *v)
 {
 	struct sctp_hashbucket *head;
-	struct sctp_ep_common *epb;
 	struct sctp_endpoint *ep;
 	struct sock *sk;
 	int    hash = *(loff_t *)v;
@@ -171,18 +170,17 @@ static int sctp_eps_seq_show(struct seq_file *seq, void *v)
 
 	head = &sctp_ep_hashtable[hash];
 	read_lock_bh(&head->lock);
-	sctp_for_each_hentry(epb, &head->chain) {
-		ep = sctp_ep(epb);
-		sk = epb->sk;
+	sctp_for_each_hentry(ep, &head->chain) {
+		sk = ep->base.sk;
 		if (!net_eq(sock_net(sk), seq_file_net(seq)))
 			continue;
 		seq_printf(seq, "%8pK %8pK %-3d %-3d %-4d %-5d %5u %5lu ", ep, sk,
 			   sctp_sk(sk)->type, sk->sk_state, hash,
-			   epb->bind_addr.port,
+			   ep->base.bind_addr.port,
 			   from_kuid_munged(seq_user_ns(seq), sock_i_uid(sk)),
 			   sock_i_ino(sk));
 
-		sctp_seq_dump_local_addrs(seq, epb);
+		sctp_seq_dump_local_addrs(seq, &ep->base);
 		seq_printf(seq, "\n");
 	}
 	read_unlock_bh(&head->lock);
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 967b330ffd4e3..9fe13de66b272 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -5303,14 +5303,14 @@ int sctp_for_each_endpoint(int (*cb)(struct sctp_endpoint *, void *),
 			   void *p) {
 	int err = 0;
 	int hash = 0;
-	struct sctp_ep_common *epb;
+	struct sctp_endpoint *ep;
 	struct sctp_hashbucket *head;
 
 	for (head = sctp_ep_hashtable; hash < sctp_ep_hashsize;
 	     hash++, head++) {
 		read_lock_bh(&head->lock);
-		sctp_for_each_hentry(epb, &head->chain) {
-			err = cb(sctp_ep(epb), p);
+		sctp_for_each_hentry(ep, &head->chain) {
+			err = cb(ep, p);
 			if (err)
 				break;
 		}
-- 
2.43.0




