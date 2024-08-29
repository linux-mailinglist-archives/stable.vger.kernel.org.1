Return-Path: <stable+bounces-71507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2AD9648F0
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 16:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6A51F21187
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 14:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0C91B1419;
	Thu, 29 Aug 2024 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UdtVok33"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856A51B012B
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942810; cv=none; b=BDHSEEmT20hrkPsA6sf6muYeMxYsw5jmNsUx+l2ZrCIissVnBb8YqZBRVkTJ1IcnTvHN4y4jyi4QMWw0rlqycfy7xoioVcGJ3JLg4JwPaAX94s44PREm+8WM8yDY36ZWJHJNTG8smz3XifztfGFEnvDmlCqV8Splok3l55wfx/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942810; c=relaxed/simple;
	bh=om/hBxVwyEwqd9Wet0BnvxGv0o7q27USn31SauPK2VE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bzjm1eMq+8tUDtJmD/G6jB0emLg8LqSSv/mCU1JGKOKD2D2JN9ZbQmfK7aElgI3Pc5Lzg1nHDr7sfOZZh0j6/DZuWbeuognIWNAzhVU8t14XCkYeNdg2I7DY714p9gee3nx3sjsjos5CiUUjbQ6CSKMfAtQeOmlqQcGqU7mbPTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UdtVok33; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1169005d9aso1469044276.0
        for <stable@vger.kernel.org>; Thu, 29 Aug 2024 07:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724942807; x=1725547607; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GsvFIbWLnIoB9I9D/ZAdpOE/EjanSMs0G2/A0cor4VM=;
        b=UdtVok330JwnuiohUYF/8l7MekvI68Ncctg1W8cAeQXdgqli5eYq7ZLuc0IcKoJw5C
         dbfqP9lCbR/hszEhIjZNvOuSdA4hiOo5rOhrJ4y8LhJcn7imLoAax81pSaal8rh2hLnd
         PzHzRDLcQQmBUQzpprPGlowj3EmBKX/LUJ/+B4/5V/lGPE4Pn+LqDyIq52/nqtdagwn/
         VfOQLEX2jQEvr2k7uYotgrSxjQhDYklBnwFwCk4MqTCxv+Z8KrWWd7ZegXHhsQlbXM1a
         /yID+IA+y6M0GZUAxP6eGHIa2WvimpFUBWkS20E4ACGRcoLN9ClpKCuRKt3Fqd+ol7RD
         QJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724942807; x=1725547607;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GsvFIbWLnIoB9I9D/ZAdpOE/EjanSMs0G2/A0cor4VM=;
        b=qE2HenBECkSuRJFo7ZPD49PdVzOxrNeqhHporml809IAtxBbY30VeNSLJ8qw4oyqCW
         STcHAhzLzW9W+zCEFbQDNH/Sb37hdsma8F20XEIr6CNV+e9JH78+6267Le4gjaC7xeZw
         5JSjOnGhAo3vOQLPWa+nGDFj0xdBz3RBHE+jDgMCAgKr0DVHQQ8VbMe/KqazsRQFxtV0
         YrbVbZG+58WnuqgUuwaEwo8+/0PHD40YYqQKFDkAWtfYbYGwhIuqnwaLa8EODWKgb/1x
         Q8+STUodBjTHDXPDqmVGdn5lulbY3krOjm7N49CnlE29Rjy4uZNi+9JjCan0JENqZT0s
         1QWg==
X-Forwarded-Encrypted: i=1; AJvYcCWkP10J5/D4cxzcxQasY7JnFE1L6qxt6JfgzRHrI7S2tEA3+9ufFa06X+sdeW4uF3EeNiJScY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLOTFwGauXrSU7YjrkKH7FVkr912/bpAMuV7UaZLix7cYuQ/43
	eGxS6p+9xmxl+EGJlofRJZVeEDhuVCW3vkxlBiBHhHkiUqAWVLuvcBuZmxIHKTV4PDAGchfYt2g
	hrm6F9muBwQ==
X-Google-Smtp-Source: AGHT+IFl6gXILQamF6WR2WBuxYjcrPKRtwnrxbZKfhi0osrgCPWUQApe9y4UJaRReTW8+JouX/spEAhp5V4S2Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:846:0:b0:e11:5e94:17dc with SMTP id
 3f1490d57ef6-e1a5ab75e35mr4392276.5.1724942807371; Thu, 29 Aug 2024 07:46:47
 -0700 (PDT)
Date: Thu, 29 Aug 2024 14:46:39 +0000
In-Reply-To: <20240829144641.3880376-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240829144641.3880376-1-edumazet@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240829144641.3880376-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/3] icmp: change the order of rate limits
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Willy Tarreau <w@1wt.eu>, Keyu Man <keyu.man@email.ucr.edu>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ICMP messages are ratelimited :

After the blamed commits, the two rate limiters are applied in this order:

1) host wide ratelimit (icmp_global_allow())

2) Per destination ratelimit (inetpeer based)

In order to avoid side-channels attacks, we need to apply
the per destination check first.

This patch makes the following change :

1) icmp_global_allow() checks if the host wide limit is reached.
   But credits are not yet consumed. This is deferred to 3)

2) The per destination limit is checked/updated.
   This might add a new node in inetpeer tree.

3) icmp_global_consume() consumes tokens if prior operations succeeded.

This means that host wide ratelimit is still effective
in keeping inetpeer tree small even under DDOS.

As a bonus, I removed icmp_global.lock as the fast path
can use a lock-free operation.

Fixes: c0303efeab73 ("net: reduce cycles spend on ICMP replies that gets rate limited")
Fixes: 4cdf507d5452 ("icmp: add a global rate limitation")
Reported-by: Keyu Man <keyu.man@email.ucr.edu>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: stable@vger.kernel.org
---
 include/net/ip.h |   2 +
 net/ipv4/icmp.c  | 103 ++++++++++++++++++++++++++---------------------
 net/ipv6/icmp.c  |  28 ++++++++-----
 3 files changed, 76 insertions(+), 57 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index c5606cadb1a552f3e282a5e1e721fd47b07432b2..82248813619e3f21e09d52976accbdc76c7668c2 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -795,6 +795,8 @@ static inline void ip_cmsg_recv(struct msghdr *msg, struct sk_buff *skb)
 }
 
 bool icmp_global_allow(void);
+void icmp_global_consume(void);
+
 extern int sysctl_icmp_msgs_per_sec;
 extern int sysctl_icmp_msgs_burst;
 
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index b8f56d03fcbb62970a828e20dd9f05fcede2d552..0078e8fb2e86d0552ef85eb5bf5bef947b0f1c3d 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -224,57 +224,59 @@ int sysctl_icmp_msgs_per_sec __read_mostly = 1000;
 int sysctl_icmp_msgs_burst __read_mostly = 50;
 
 static struct {
-	spinlock_t	lock;
-	u32		credit;
+	atomic_t	credit;
 	u32		stamp;
-} icmp_global = {
-	.lock		= __SPIN_LOCK_UNLOCKED(icmp_global.lock),
-};
+} icmp_global;
 
 /**
  * icmp_global_allow - Are we allowed to send one more ICMP message ?
  *
  * Uses a token bucket to limit our ICMP messages to ~sysctl_icmp_msgs_per_sec.
  * Returns false if we reached the limit and can not send another packet.
- * Note: called with BH disabled
+ * Works in tandem with icmp_global_consume().
  */
 bool icmp_global_allow(void)
 {
-	u32 credit, delta, incr = 0, now = (u32)jiffies;
-	bool rc = false;
+	u32 delta, now, oldstamp;
+	int incr, new, old;
 
-	/* Check if token bucket is empty and cannot be refilled
-	 * without taking the spinlock. The READ_ONCE() are paired
-	 * with the following WRITE_ONCE() in this same function.
+	/* Note: many cpus could find this condition true.
+	 * Then later icmp_global_consume() could consume more credits,
+	 * this is an acceptable race.
 	 */
-	if (!READ_ONCE(icmp_global.credit)) {
-		delta = min_t(u32, now - READ_ONCE(icmp_global.stamp), HZ);
-		if (delta < HZ / 50)
-			return false;
-	}
+	if (atomic_read(&icmp_global.credit) > 0)
+		return true;
 
-	spin_lock(&icmp_global.lock);
-	delta = min_t(u32, now - icmp_global.stamp, HZ);
-	if (delta >= HZ / 50) {
-		incr = READ_ONCE(sysctl_icmp_msgs_per_sec) * delta / HZ;
-		if (incr)
-			WRITE_ONCE(icmp_global.stamp, now);
-	}
-	credit = min_t(u32, icmp_global.credit + incr,
-		       READ_ONCE(sysctl_icmp_msgs_burst));
-	if (credit) {
-		/* We want to use a credit of one in average, but need to randomize
-		 * it for security reasons.
-		 */
-		credit = max_t(int, credit - get_random_u32_below(3), 0);
-		rc = true;
+	now = jiffies;
+	oldstamp = READ_ONCE(icmp_global.stamp);
+	delta = min_t(u32, now - oldstamp, HZ);
+	if (delta < HZ / 50)
+		return false;
+
+	incr = READ_ONCE(sysctl_icmp_msgs_per_sec) * delta / HZ;
+	if (!incr)
+		return false;
+
+	if (cmpxchg(&icmp_global.stamp, oldstamp, now) == oldstamp) {
+		old = atomic_read(&icmp_global.credit);
+		do {
+			new = min(old + incr, READ_ONCE(sysctl_icmp_msgs_burst));
+		} while (!atomic_try_cmpxchg(&icmp_global.credit, &old, new));
 	}
-	WRITE_ONCE(icmp_global.credit, credit);
-	spin_unlock(&icmp_global.lock);
-	return rc;
+	return true;
 }
 EXPORT_SYMBOL(icmp_global_allow);
 
+void icmp_global_consume(void)
+{
+	int credits = get_random_u32_below(3);
+
+	/* Note: this might make icmp_global.credit negative. */
+	if (credits)
+		atomic_sub(credits, &icmp_global.credit);
+}
+EXPORT_SYMBOL(icmp_global_consume);
+
 static bool icmpv4_mask_allow(struct net *net, int type, int code)
 {
 	if (type > NR_ICMP_TYPES)
@@ -291,14 +293,16 @@ static bool icmpv4_mask_allow(struct net *net, int type, int code)
 	return false;
 }
 
-static bool icmpv4_global_allow(struct net *net, int type, int code)
+static bool icmpv4_global_allow(struct net *net, int type, int code,
+				bool *apply_ratelimit)
 {
 	if (icmpv4_mask_allow(net, type, code))
 		return true;
 
-	if (icmp_global_allow())
+	if (icmp_global_allow()) {
+		*apply_ratelimit = true;
 		return true;
-
+	}
 	__ICMP_INC_STATS(net, ICMP_MIB_RATELIMITGLOBAL);
 	return false;
 }
@@ -308,15 +312,16 @@ static bool icmpv4_global_allow(struct net *net, int type, int code)
  */
 
 static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
-			       struct flowi4 *fl4, int type, int code)
+			       struct flowi4 *fl4, int type, int code,
+			       bool apply_ratelimit)
 {
 	struct dst_entry *dst = &rt->dst;
 	struct inet_peer *peer;
 	bool rc = true;
 	int vif;
 
-	if (icmpv4_mask_allow(net, type, code))
-		goto out;
+	if (!apply_ratelimit)
+		return true;
 
 	/* No rate limit on loopback */
 	if (dst->dev && (dst->dev->flags&IFF_LOOPBACK))
@@ -331,6 +336,8 @@ static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
 out:
 	if (!rc)
 		__ICMP_INC_STATS(net, ICMP_MIB_RATELIMITHOST);
+	else
+		icmp_global_consume();
 	return rc;
 }
 
@@ -402,6 +409,7 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 	struct ipcm_cookie ipc;
 	struct rtable *rt = skb_rtable(skb);
 	struct net *net = dev_net(rt->dst.dev);
+	bool apply_ratelimit = false;
 	struct flowi4 fl4;
 	struct sock *sk;
 	struct inet_sock *inet;
@@ -413,11 +421,11 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 	if (ip_options_echo(net, &icmp_param->replyopts.opt.opt, skb))
 		return;
 
-	/* Needed by both icmp_global_allow and icmp_xmit_lock */
+	/* Needed by both icmpv4_global_allow and icmp_xmit_lock */
 	local_bh_disable();
 
-	/* global icmp_msgs_per_sec */
-	if (!icmpv4_global_allow(net, type, code))
+	/* is global icmp_msgs_per_sec exhausted ? */
+	if (!icmpv4_global_allow(net, type, code, &apply_ratelimit))
 		goto out_bh_enable;
 
 	sk = icmp_xmit_lock(net);
@@ -450,7 +458,7 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 	rt = ip_route_output_key(net, &fl4);
 	if (IS_ERR(rt))
 		goto out_unlock;
-	if (icmpv4_xrlim_allow(net, rt, &fl4, type, code))
+	if (icmpv4_xrlim_allow(net, rt, &fl4, type, code, apply_ratelimit))
 		icmp_push_reply(sk, icmp_param, &fl4, &ipc, &rt);
 	ip_rt_put(rt);
 out_unlock:
@@ -596,6 +604,7 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	int room;
 	struct icmp_bxm icmp_param;
 	struct rtable *rt = skb_rtable(skb_in);
+	bool apply_ratelimit = false;
 	struct ipcm_cookie ipc;
 	struct flowi4 fl4;
 	__be32 saddr;
@@ -677,7 +686,7 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 		}
 	}
 
-	/* Needed by both icmp_global_allow and icmp_xmit_lock */
+	/* Needed by both icmpv4_global_allow and icmp_xmit_lock */
 	local_bh_disable();
 
 	/* Check global sysctl_icmp_msgs_per_sec ratelimit, unless
@@ -685,7 +694,7 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	 * loopback, then peer ratelimit still work (in icmpv4_xrlim_allow)
 	 */
 	if (!(skb_in->dev && (skb_in->dev->flags&IFF_LOOPBACK)) &&
-	      !icmpv4_global_allow(net, type, code))
+	      !icmpv4_global_allow(net, type, code, &apply_ratelimit))
 		goto out_bh_enable;
 
 	sk = icmp_xmit_lock(net);
@@ -744,7 +753,7 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 		goto out_unlock;
 
 	/* peer icmp_ratelimit */
-	if (!icmpv4_xrlim_allow(net, rt, &fl4, type, code))
+	if (!icmpv4_xrlim_allow(net, rt, &fl4, type, code, apply_ratelimit))
 		goto ende;
 
 	/* RFC says return as much as we can without exceeding 576 bytes. */
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 7b31674644efc338ec458d92dfe495480825b0fd..46f70e4a835139ef7d8925c49440865355048193 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -175,14 +175,16 @@ static bool icmpv6_mask_allow(struct net *net, int type)
 	return false;
 }
 
-static bool icmpv6_global_allow(struct net *net, int type)
+static bool icmpv6_global_allow(struct net *net, int type,
+				bool *apply_ratelimit)
 {
 	if (icmpv6_mask_allow(net, type))
 		return true;
 
-	if (icmp_global_allow())
+	if (icmp_global_allow()) {
+		*apply_ratelimit = true;
 		return true;
-
+	}
 	__ICMP_INC_STATS(net, ICMP_MIB_RATELIMITGLOBAL);
 	return false;
 }
@@ -191,13 +193,13 @@ static bool icmpv6_global_allow(struct net *net, int type)
  * Check the ICMP output rate limit
  */
 static bool icmpv6_xrlim_allow(struct sock *sk, u8 type,
-			       struct flowi6 *fl6)
+			       struct flowi6 *fl6, bool apply_ratelimit)
 {
 	struct net *net = sock_net(sk);
 	struct dst_entry *dst;
 	bool res = false;
 
-	if (icmpv6_mask_allow(net, type))
+	if (!apply_ratelimit)
 		return true;
 
 	/*
@@ -228,6 +230,8 @@ static bool icmpv6_xrlim_allow(struct sock *sk, u8 type,
 	if (!res)
 		__ICMP6_INC_STATS(net, ip6_dst_idev(dst),
 				  ICMP6_MIB_RATELIMITHOST);
+	else
+		icmp_global_consume();
 	dst_release(dst);
 	return res;
 }
@@ -452,6 +456,7 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 	struct net *net;
 	struct ipv6_pinfo *np;
 	const struct in6_addr *saddr = NULL;
+	bool apply_ratelimit = false;
 	struct dst_entry *dst;
 	struct icmp6hdr tmp_hdr;
 	struct flowi6 fl6;
@@ -533,11 +538,12 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 		return;
 	}
 
-	/* Needed by both icmp_global_allow and icmpv6_xmit_lock */
+	/* Needed by both icmpv6_global_allow and icmpv6_xmit_lock */
 	local_bh_disable();
 
 	/* Check global sysctl_icmp_msgs_per_sec ratelimit */
-	if (!(skb->dev->flags & IFF_LOOPBACK) && !icmpv6_global_allow(net, type))
+	if (!(skb->dev->flags & IFF_LOOPBACK) &&
+	    !icmpv6_global_allow(net, type, &apply_ratelimit))
 		goto out_bh_enable;
 
 	mip6_addr_swap(skb, parm);
@@ -575,7 +581,7 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 
 	np = inet6_sk(sk);
 
-	if (!icmpv6_xrlim_allow(sk, type, &fl6))
+	if (!icmpv6_xrlim_allow(sk, type, &fl6, apply_ratelimit))
 		goto out;
 
 	tmp_hdr.icmp6_type = type;
@@ -717,6 +723,7 @@ static enum skb_drop_reason icmpv6_echo_reply(struct sk_buff *skb)
 	struct ipv6_pinfo *np;
 	const struct in6_addr *saddr = NULL;
 	struct icmp6hdr *icmph = icmp6_hdr(skb);
+	bool apply_ratelimit = false;
 	struct icmp6hdr tmp_hdr;
 	struct flowi6 fl6;
 	struct icmpv6_msg msg;
@@ -781,8 +788,9 @@ static enum skb_drop_reason icmpv6_echo_reply(struct sk_buff *skb)
 		goto out;
 
 	/* Check the ratelimit */
-	if ((!(skb->dev->flags & IFF_LOOPBACK) && !icmpv6_global_allow(net, ICMPV6_ECHO_REPLY)) ||
-	    !icmpv6_xrlim_allow(sk, ICMPV6_ECHO_REPLY, &fl6))
+	if ((!(skb->dev->flags & IFF_LOOPBACK) &&
+	    !icmpv6_global_allow(net, ICMPV6_ECHO_REPLY, &apply_ratelimit)) ||
+	    !icmpv6_xrlim_allow(sk, ICMPV6_ECHO_REPLY, &fl6, apply_ratelimit))
 		goto out_dst_release;
 
 	idev = __in6_dev_get(skb->dev);
-- 
2.46.0.295.g3b9ea8a38a-goog


