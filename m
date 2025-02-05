Return-Path: <stable+bounces-112430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BE7A28CAC
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A71B43A88FD
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 13:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE33146D40;
	Wed,  5 Feb 2025 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y0wvX8Rr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8696413C9C4;
	Wed,  5 Feb 2025 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763548; cv=none; b=APv2CL2ziKBCurNldBSfzswm0zxHE8yY38u8bk3ik0kPyRerm5rzKpqOr6IUTFzL+aeZhprpoFqWiHyaBPCCPQl5EyIlez8gyuJhBne3SpDCnAavxbfkaBVabE1E3ad/kzP8ZEo4V3XbdTSI+CZQeJBY48geLqKcqtRvqSCoZVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763548; c=relaxed/simple;
	bh=gW2wsvIDqO/hkCvfsU/UDr9VGJ5m6mnGM4Eleyg4VDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wv2MXquVT4X6s7mR35A8qLeA7/t8XNdkPL4F+HnAcjIXWzdDFfVC6gsLbKlMRJS+sLPvrZooyekbMI7n54caN4LUpWnkpsIToP3M0Lm9AfLoqW0y+LbrDR8IhvIwM4OVBn+pUivMYkuNPKcHtg7VLprJSRUXFqrkmYi9LTEDsTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y0wvX8Rr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28DAC4CED1;
	Wed,  5 Feb 2025 13:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738763548;
	bh=gW2wsvIDqO/hkCvfsU/UDr9VGJ5m6mnGM4Eleyg4VDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y0wvX8Rrn4E/j1r4meP/YFXyjyYX/z1F2CPcepgA8R5O1otQi5adWELC/XP4eFMG3
	 FaIuITfpWFx9HsU6l5Xzt8e+B8v7wnlmUwN2d2hPP2NT17jSzcptv+UxQLXOCHPXWT
	 W4jTpHSh4Sd0KCITAsy2eIFaBt079U51lOd4xiKg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 080/393] inetpeer: do not get a refcount in inet_getpeer()
Date: Wed,  5 Feb 2025 14:39:59 +0100
Message-ID: <20250205134423.356362344@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
References: <20250205134420.279368572@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit a853c609504e2d1d83e71285e3622fda1f1451d8 ]

All inet_getpeer() callers except ip4_frag_init() don't need
to acquire a permanent refcount on the inetpeer.

They can switch to full RCU protection.

Move the refcount_inc_not_zero() into ip4_frag_init(),
so that all the other callers no longer have to
perform a pair of expensive atomic operations on
a possibly contended cache line.

inet_putpeer() no longer needs to be exported.

After this patch, my DUT can receive 8,400,000 UDP packets
per second targeting closed ports, using 50% less cpu cycles
than before.

Also change two calls to l3mdev_master_ifindex() by
l3mdev_master_ifindex_rcu() (Ido ideas)

Fixes: 8c2bd38b95f7 ("icmp: change the order of rate limits")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20241215175629.1248773-5-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/icmp.c        |  9 ++++-----
 net/ipv4/inetpeer.c    |  8 ++------
 net/ipv4/ip_fragment.c | 15 ++++++++++-----
 net/ipv4/route.c       | 15 ++++++++-------
 net/ipv6/icmp.c        |  4 ++--
 net/ipv6/ip6_output.c  |  4 ++--
 net/ipv6/ndisc.c       |  6 ++++--
 7 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 203734e29d462..a6adf6a2ec4b5 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -316,7 +316,6 @@ static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
 	struct dst_entry *dst = &rt->dst;
 	struct inet_peer *peer;
 	bool rc = true;
-	int vif;
 
 	if (!apply_ratelimit)
 		return true;
@@ -325,12 +324,12 @@ static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
 	if (dst->dev && (dst->dev->flags&IFF_LOOPBACK))
 		goto out;
 
-	vif = l3mdev_master_ifindex(dst->dev);
-	peer = inet_getpeer_v4(net->ipv4.peers, fl4->daddr, vif);
+	rcu_read_lock();
+	peer = inet_getpeer_v4(net->ipv4.peers, fl4->daddr,
+			       l3mdev_master_ifindex_rcu(dst->dev));
 	rc = inet_peer_xrlim_allow(peer,
 				   READ_ONCE(net->ipv4.sysctl_icmp_ratelimit));
-	if (peer)
-		inet_putpeer(peer);
+	rcu_read_unlock();
 out:
 	if (!rc)
 		__ICMP_INC_STATS(net, ICMP_MIB_RATELIMITHOST);
diff --git a/net/ipv4/inetpeer.c b/net/ipv4/inetpeer.c
index 596e2c3a8551f..23896b6b8417d 100644
--- a/net/ipv4/inetpeer.c
+++ b/net/ipv4/inetpeer.c
@@ -112,8 +112,6 @@ static struct inet_peer *lookup(const struct inetpeer_addr *daddr,
 		p = rb_entry(parent, struct inet_peer, rb_node);
 		cmp = inetpeer_addr_cmp(daddr, &p->daddr);
 		if (cmp == 0) {
-			if (!refcount_inc_not_zero(&p->refcnt))
-				break;
 			now = jiffies;
 			if (READ_ONCE(p->dtime) != now)
 				WRITE_ONCE(p->dtime, now);
@@ -177,6 +175,7 @@ static void inet_peer_gc(struct inet_peer_base *base,
 	}
 }
 
+/* Must be called under RCU : No refcount change is done here. */
 struct inet_peer *inet_getpeer(struct inet_peer_base *base,
 			       const struct inetpeer_addr *daddr)
 {
@@ -187,10 +186,8 @@ struct inet_peer *inet_getpeer(struct inet_peer_base *base,
 	/* Attempt a lockless lookup first.
 	 * Because of a concurrent writer, we might not find an existing entry.
 	 */
-	rcu_read_lock();
 	seq = read_seqbegin(&base->lock);
 	p = lookup(daddr, base, seq, NULL, &gc_cnt, &parent, &pp);
-	rcu_read_unlock();
 
 	if (p)
 		return p;
@@ -208,7 +205,7 @@ struct inet_peer *inet_getpeer(struct inet_peer_base *base,
 		if (p) {
 			p->daddr = *daddr;
 			p->dtime = (__u32)jiffies;
-			refcount_set(&p->refcnt, 2);
+			refcount_set(&p->refcnt, 1);
 			atomic_set(&p->rid, 0);
 			p->metrics[RTAX_LOCK-1] = INETPEER_METRICS_NEW;
 			p->rate_tokens = 0;
@@ -236,7 +233,6 @@ void inet_putpeer(struct inet_peer *p)
 	if (refcount_dec_and_test(&p->refcnt))
 		call_rcu(&p->rcu, inetpeer_free_rcu);
 }
-EXPORT_SYMBOL_GPL(inet_putpeer);
 
 /*
  *	Check transmit rate limitation for given message.
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index e8cc225fcf250..877d1e03150c7 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -82,15 +82,20 @@ static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
 static void ip4_frag_init(struct inet_frag_queue *q, const void *a)
 {
 	struct ipq *qp = container_of(q, struct ipq, q);
-	struct net *net = q->fqdir->net;
-
 	const struct frag_v4_compare_key *key = a;
+	struct net *net = q->fqdir->net;
+	struct inet_peer *p = NULL;
 
 	q->key.v4 = *key;
 	qp->ecn = 0;
-	qp->peer = q->fqdir->max_dist ?
-		inet_getpeer_v4(net->ipv4.peers, key->saddr, key->vif) :
-		NULL;
+	if (q->fqdir->max_dist) {
+		rcu_read_lock();
+		p = inet_getpeer_v4(net->ipv4.peers, key->saddr, key->vif);
+		if (p && !refcount_inc_not_zero(&p->refcnt))
+			p = NULL;
+		rcu_read_unlock();
+	}
+	qp->peer = p;
 }
 
 static void ip4_frag_free(struct inet_frag_queue *q)
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index fb1ac5976d4c1..61fc2166a870e 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -882,11 +882,11 @@ void ip_rt_send_redirect(struct sk_buff *skb)
 	}
 	log_martians = IN_DEV_LOG_MARTIANS(in_dev);
 	vif = l3mdev_master_ifindex_rcu(rt->dst.dev);
-	rcu_read_unlock();
 
 	net = dev_net(rt->dst.dev);
 	peer = inet_getpeer_v4(net->ipv4.peers, ip_hdr(skb)->saddr, vif);
 	if (!peer) {
+		rcu_read_unlock();
 		icmp_send(skb, ICMP_REDIRECT, ICMP_REDIR_HOST,
 			  rt_nexthop(rt, ip_hdr(skb)->daddr));
 		return;
@@ -905,7 +905,7 @@ void ip_rt_send_redirect(struct sk_buff *skb)
 	 */
 	if (peer->n_redirects >= ip_rt_redirect_number) {
 		peer->rate_last = jiffies;
-		goto out_put_peer;
+		goto out_unlock;
 	}
 
 	/* Check for load limit; set rate_last to the latest sent
@@ -926,8 +926,8 @@ void ip_rt_send_redirect(struct sk_buff *skb)
 					     &ip_hdr(skb)->saddr, inet_iif(skb),
 					     &ip_hdr(skb)->daddr, &gw);
 	}
-out_put_peer:
-	inet_putpeer(peer);
+out_unlock:
+	rcu_read_unlock();
 }
 
 static int ip_error(struct sk_buff *skb)
@@ -987,9 +987,9 @@ static int ip_error(struct sk_buff *skb)
 		break;
 	}
 
+	rcu_read_lock();
 	peer = inet_getpeer_v4(net->ipv4.peers, ip_hdr(skb)->saddr,
-			       l3mdev_master_ifindex(skb->dev));
-
+			       l3mdev_master_ifindex_rcu(skb->dev));
 	send = true;
 	if (peer) {
 		now = jiffies;
@@ -1001,8 +1001,9 @@ static int ip_error(struct sk_buff *skb)
 			peer->rate_tokens -= ip_rt_error_cost;
 		else
 			send = false;
-		inet_putpeer(peer);
 	}
+	rcu_read_unlock();
+
 	if (send)
 		icmp_send(skb, ICMP_DEST_UNREACH, code, 0);
 
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 74b4050c746af..35df405ce1f75 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -222,10 +222,10 @@ static bool icmpv6_xrlim_allow(struct sock *sk, u8 type,
 		if (rt->rt6i_dst.plen < 128)
 			tmo >>= ((128 - rt->rt6i_dst.plen)>>5);
 
+		rcu_read_lock();
 		peer = inet_getpeer_v6(net->ipv6.peers, &fl6->daddr);
 		res = inet_peer_xrlim_allow(peer, tmo);
-		if (peer)
-			inet_putpeer(peer);
+		rcu_read_unlock();
 	}
 	if (!res)
 		__ICMP6_INC_STATS(net, ip6_dst_idev(dst),
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index ea1839fe47012..cd89a2b35dfb5 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -612,6 +612,7 @@ int ip6_forward(struct sk_buff *skb)
 		else
 			target = &hdr->daddr;
 
+		rcu_read_lock();
 		peer = inet_getpeer_v6(net->ipv6.peers, &hdr->daddr);
 
 		/* Limit redirects both by destination (here)
@@ -619,8 +620,7 @@ int ip6_forward(struct sk_buff *skb)
 		 */
 		if (inet_peer_xrlim_allow(peer, 1*HZ))
 			ndisc_send_redirect(skb, target);
-		if (peer)
-			inet_putpeer(peer);
+		rcu_read_unlock();
 	} else {
 		int addrtype = ipv6_addr_type(&hdr->saddr);
 
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index a5989a18ccd73..2ad0ef47b07c2 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1717,10 +1717,12 @@ void ndisc_send_redirect(struct sk_buff *skb, const struct in6_addr *target)
 			  "Redirect: destination is not a neighbour\n");
 		goto release;
 	}
+
+	rcu_read_lock();
 	peer = inet_getpeer_v6(net->ipv6.peers, &ipv6_hdr(skb)->saddr);
 	ret = inet_peer_xrlim_allow(peer, 1*HZ);
-	if (peer)
-		inet_putpeer(peer);
+	rcu_read_unlock();
+
 	if (!ret)
 		goto release;
 
-- 
2.39.5




