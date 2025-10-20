Return-Path: <stable+bounces-188147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F7EBF2321
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEEC83A441A
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D531926CE07;
	Mon, 20 Oct 2025 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cL28QgIM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925AD26D4C4
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975054; cv=none; b=ZegAP7YF5itBOpjsZanD1HKQfJVEses5dKc2qi1R2vXkLbp8ldexwv50dCYD4E0DuNO91QuotWNmdZMUd/9LNhTf5QeLSm30lrzBLDk3FSrDk5EQUrgoMLv+jCelMM1rV0TO9cjkjR4fwY0+lD87+ZeEG6+VbTLVcmqddAx1QFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975054; c=relaxed/simple;
	bh=L6VRyTp589qViVIfv5drkq6moE47i+07BN9Y9RtDzrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJGcGSBZQNs5Gv6nvChE7BKQkB7m/wAHsnDVUmsu0yGfGsnxVlLCXo15TAJ6WVUVZISs4ddy92HXqP7bsW/XS2xhvTWMzo+x/l4GNgPuwAXpEsK/0xQIcLeij8NcBSjArzWQwTKVKo+18F9jveO4nUpihzu1fr20mB/kkJTx7fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cL28QgIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A443C4CEF9;
	Mon, 20 Oct 2025 15:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760975054;
	bh=L6VRyTp589qViVIfv5drkq6moE47i+07BN9Y9RtDzrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cL28QgIMuBCIuFtavkr9WzAjBOq51Y9g6U3V6sda4uoTx6J44Sigm2ANi1NEcDgRx
	 qPzklGRrqsG9oa3GrnTMSxGLi13AJPBwx72URPfSbvVmACALo9/1DDTmkh1ZjKvI6t
	 l+ff0uOlnIplyfZJXze2D+YNZG/wkN8rYxRpKqQ0lXhGcXJ07ePutdFK7OyK9QYEtS
	 IDuJqlhYH2zHe7y/nIR/xw++CLnWVKgr4sJpzFQH2i9YJAP9597DvZj4AlvLt5rk+m
	 VjSILgoTcvWC1gnRvMpFXEhUAUyGQSTauTcc9rXQvY33kmQsn84OXfz5gbhnaHk6hn
	 dELjU36YB5Y7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/8] tcp: convert to dev_net_rcu()
Date: Mon, 20 Oct 2025 11:44:02 -0400
Message-ID: <20251020154409.1823664-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101604-chamber-playhouse-5278@gregkh>
References: <2025101604-chamber-playhouse-5278@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit e7b9ecce562ca6a1de32c56c597fa45e08c44ec0 ]

TCP uses of dev_net() are under RCU protection, change them
to dev_net_rcu() to get LOCKDEP support.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://patch.msgid.link/20250301201424.2046477-4-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 833d4313bc1e ("mptcp: reset blackhole on success with non-loopback ifaces")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/inet6_hashtables.h |  2 +-
 include/net/inet_hashtables.h  |  2 +-
 net/ipv4/tcp_ipv4.c            | 12 ++++++------
 net/ipv4/tcp_metrics.c         |  6 +++---
 net/ipv6/tcp_ipv6.c            | 22 +++++++++++-----------
 5 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index 74dd90ff5f129..c32878c69179d 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -150,7 +150,7 @@ static inline struct sock *__inet6_lookup_skb(struct inet_hashinfo *hashinfo,
 					      int iif, int sdif,
 					      bool *refcounted)
 {
-	struct net *net = dev_net(skb_dst(skb)->dev);
+	struct net *net = dev_net_rcu(skb_dst(skb)->dev);
 	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
 	struct sock *sk;
 
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 5eea47f135a42..da818fb0205fe 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -492,7 +492,7 @@ static inline struct sock *__inet_lookup_skb(struct inet_hashinfo *hashinfo,
 					     const int sdif,
 					     bool *refcounted)
 {
-	struct net *net = dev_net(skb_dst(skb)->dev);
+	struct net *net = dev_net_rcu(skb_dst(skb)->dev);
 	const struct iphdr *iph = ip_hdr(skb);
 	struct sock *sk;
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 824048679e1b8..d8976753d4e47 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -494,14 +494,14 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 {
 	const struct iphdr *iph = (const struct iphdr *)skb->data;
 	struct tcphdr *th = (struct tcphdr *)(skb->data + (iph->ihl << 2));
-	struct tcp_sock *tp;
+	struct net *net = dev_net_rcu(skb->dev);
 	const int type = icmp_hdr(skb)->type;
 	const int code = icmp_hdr(skb)->code;
-	struct sock *sk;
 	struct request_sock *fastopen;
+	struct tcp_sock *tp;
 	u32 seq, snd_una;
+	struct sock *sk;
 	int err;
-	struct net *net = dev_net(skb->dev);
 
 	sk = __inet_lookup_established(net, net->ipv4.tcp_death_row.hashinfo,
 				       iph->daddr, th->dest, iph->saddr,
@@ -786,7 +786,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb,
 	arg.iov[0].iov_base = (unsigned char *)&rep;
 	arg.iov[0].iov_len  = sizeof(rep.th);
 
-	net = sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
+	net = sk ? sock_net(sk) : dev_net_rcu(skb_dst(skb)->dev);
 
 	/* Invalid TCP option size or twice included auth */
 	if (tcp_parse_auth_options(tcp_hdr(skb), &md5_hash_location, &aoh))
@@ -1965,7 +1965,7 @@ EXPORT_SYMBOL(tcp_v4_do_rcv);
 
 int tcp_v4_early_demux(struct sk_buff *skb)
 {
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	const struct iphdr *iph;
 	const struct tcphdr *th;
 	struct sock *sk;
@@ -2176,7 +2176,7 @@ static void tcp_v4_fill_cb(struct sk_buff *skb, const struct iphdr *iph,
 
 int tcp_v4_rcv(struct sk_buff *skb)
 {
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	enum skb_drop_reason drop_reason;
 	int sdif = inet_sdif(skb);
 	int dif = inet_iif(skb);
diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index 95669935494ef..4251670e328c8 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -170,7 +170,7 @@ static struct tcp_metrics_block *tcpm_new(struct dst_entry *dst,
 	bool reclaim = false;
 
 	spin_lock_bh(&tcp_metrics_lock);
-	net = dev_net(dst->dev);
+	net = dev_net_rcu(dst->dev);
 
 	/* While waiting for the spin-lock the cache might have been populated
 	 * with this entry and so we have to check again.
@@ -273,7 +273,7 @@ static struct tcp_metrics_block *__tcp_get_metrics_req(struct request_sock *req,
 		return NULL;
 	}
 
-	net = dev_net(dst->dev);
+	net = dev_net_rcu(dst->dev);
 	hash ^= net_hash_mix(net);
 	hash = hash_32(hash, tcp_metrics_hash_log);
 
@@ -318,7 +318,7 @@ static struct tcp_metrics_block *tcp_get_metrics(struct sock *sk,
 	else
 		return NULL;
 
-	net = dev_net(dst->dev);
+	net = dev_net_rcu(dst->dev);
 	hash ^= net_hash_mix(net);
 	hash = hash_32(hash, tcp_metrics_hash_log);
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 882ce5444572e..06edfe0b2db90 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -376,7 +376,7 @@ static int tcp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 {
 	const struct ipv6hdr *hdr = (const struct ipv6hdr *)skb->data;
 	const struct tcphdr *th = (struct tcphdr *)(skb->data+offset);
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	struct request_sock *fastopen;
 	struct ipv6_pinfo *np;
 	struct tcp_sock *tp;
@@ -864,16 +864,16 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 				 int oif, int rst, u8 tclass, __be32 label,
 				 u32 priority, u32 txhash, struct tcp_key *key)
 {
-	const struct tcphdr *th = tcp_hdr(skb);
-	struct tcphdr *t1;
-	struct sk_buff *buff;
-	struct flowi6 fl6;
-	struct net *net = sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
-	struct sock *ctl_sk = net->ipv6.tcp_sk;
+	struct net *net = sk ? sock_net(sk) : dev_net_rcu(skb_dst(skb)->dev);
 	unsigned int tot_len = sizeof(struct tcphdr);
+	struct sock *ctl_sk = net->ipv6.tcp_sk;
+	const struct tcphdr *th = tcp_hdr(skb);
 	__be32 mrst = 0, *topt;
 	struct dst_entry *dst;
-	__u32 mark = 0;
+	struct sk_buff *buff;
+	struct tcphdr *t1;
+	struct flowi6 fl6;
+	u32 mark = 0;
 
 	if (tsecr)
 		tot_len += TCPOLEN_TSTAMP_ALIGNED;
@@ -1036,7 +1036,7 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb,
 	if (!sk && !ipv6_unicast_destination(skb))
 		return;
 
-	net = sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
+	net = sk ? sock_net(sk) : dev_net_rcu(skb_dst(skb)->dev);
 	/* Invalid TCP option size or twice included auth */
 	if (tcp_parse_auth_options(th, &md5_hash_location, &aoh))
 		return;
@@ -1739,6 +1739,7 @@ static void tcp_v6_fill_cb(struct sk_buff *skb, const struct ipv6hdr *hdr,
 
 INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 {
+	struct net *net = dev_net_rcu(skb->dev);
 	enum skb_drop_reason drop_reason;
 	int sdif = inet6_sdif(skb);
 	int dif = inet6_iif(skb);
@@ -1748,7 +1749,6 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 	bool refcounted;
 	int ret;
 	u32 isn;
-	struct net *net = dev_net(skb->dev);
 
 	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	if (skb->pkt_type != PACKET_HOST)
@@ -1999,7 +1999,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 
 void tcp_v6_early_demux(struct sk_buff *skb)
 {
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	const struct ipv6hdr *hdr;
 	const struct tcphdr *th;
 	struct sock *sk;
-- 
2.51.0


