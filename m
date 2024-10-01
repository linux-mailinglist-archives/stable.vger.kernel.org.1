Return-Path: <stable+bounces-78551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6000F98C125
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 17:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA821F230E2
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 15:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716021CB31D;
	Tue,  1 Oct 2024 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F3RNiiXR"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C021C8FD7
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727795056; cv=none; b=sAFiw/Ox8aQZje5LxaVLtLEhKSE5zw7h3QiX17eBwA4ofE82e7+5hZ+7b9gZhr98GLSC3B7XiD2A/l7jyHZyBlzrGV10lyg9gjofPZI19jGbDHpp+7Alsc0D+70zJr3o7IxsKHiJlF9V8g3HN0C4RM4OMchb4QasLJofHIaJqew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727795056; c=relaxed/simple;
	bh=Q69wQ9zOAo7pHuVF1BQdO8sjlJUItH9j7Rj2jeu8TsY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f/48aLVGj+kfr7ZzvnQ02+qaqklEktrPmbH3vYSRl0oUHGw6RI6ScGF8BNfKiOwRSKysMcTrSFB37gWLGMv6xVJw/vN3KUEOypyn7GwQqp+QzRNpC2o2qCvE5RaXw58iAdAwSixKZMWeBpUNykeEr/17FMk0VARCnnbq6dspNPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F3RNiiXR; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e25ea440729so7229369276.0
        for <stable@vger.kernel.org>; Tue, 01 Oct 2024 08:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727795053; x=1728399853; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xIHmkOl8uPNwY9JvIev0+9u38xB6WPmUnsHofSzVpAU=;
        b=F3RNiiXRWOG4RXI8DsW1quYFn+rWgs0usW7a6eA5IvyZUcCjb/fntkOq0oji2z6drF
         XlvprdNUuFlWqpeRBvxH7tLCt+/nEMepAy2Dmjx73ujMA95GZNH/AFUWCMqKbcQ0ytHO
         37Iv9+dRpN6CBJqHJQxRavpn2IVh8zPVXcXUNZQoijd3WmW1K/Iz8p2GCvieqHceazoe
         HsdGtjiQ/6/FfdWWZ5s3pccY4Giyrp+693sjs1c+ILBMGu0t9x+OukMZ1nOL6fuf/nnm
         qXNUCA0LvxFdiTiayHyWki0181Rl6g5bNajCUxPZ2p/Omus7sRR3kk2VSuud+Ooh6IvO
         n23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727795053; x=1728399853;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xIHmkOl8uPNwY9JvIev0+9u38xB6WPmUnsHofSzVpAU=;
        b=dQBi+J5rN7d8BNUB4p2reAt3rEzi5B+XsJqFIUPhLkdXLgTn6v9fIcDFAKll+PCoY6
         sGo1IuaC5i5PktBuMaLmbI6ljYICuHHLo9SUiEeIz2x/VYHvSCxeeVplQsuGPpQ5sYvq
         u/xfq9XR9u2qL09ZNn4osxVvKwrtygq7meSlc0veKCTXl1zYpLEDffiX8/7VMk/+R7u0
         aTc8gOCtC+wlLERsBLCvKifxQFpKof5030OjyIluhtYAG9DYXdMp2H38gIxrTBWfUF2i
         TL0NQXNzJzENgMPj9XGEfl1MQcaprvF5BHdqzfPZ5O+pMPzAH+fcwLq+A1YWmNGaykih
         hQ2A==
X-Gm-Message-State: AOJu0Yze4qO483/PMtPtHNVndBdVPoEAhQsynaSfotcwb2ReUm1nLYh1
	Ap0LdX3uSwjz8opdShhJiACWM+IBaFVxVlWbZxfHBzhziE9vTJENu3ji9rt9yTMODHFarcO/7JH
	Z3jN8dwVNP/MGOisBbu2VsIaskqMzCMrRcWC4BjZhgt8yw1Vixz6yMX3VUzdtxQFRXyY2oxSrsB
	12wMR6QNoDV/J1UwAdUyvvnUv1P3Auc30+zoU8W2AxCxo=
X-Google-Smtp-Source: AGHT+IEpCciklleC/BvUOXy0P0sFqUFWXiwGU5TE09iydKr+0H/Oy/EKe+RurRwilKSPz44CHmjpoyfoST0Qzg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:9f09:0:b0:e24:a06b:1aed with SMTP id
 3f1490d57ef6-e2604b3096cmr14011276.3.1727795052916; Tue, 01 Oct 2024 08:04:12
 -0700 (PDT)
Date: Tue,  1 Oct 2024 15:04:04 +0000
In-Reply-To: <20241001150404.2176005-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024100127-uninsured-onyx-f79a@gregkh> <20241001150404.2176005-1-edumazet@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20241001150404.2176005-2-edumazet@google.com>
Subject: [PATCH 6.1.y 2/2] icmp: change the order of rate limits
From: Eric Dumazet <edumazet@google.com>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Keyu Man <keyu.man@email.ucr.edu>, 
	David Ahern <dsahern@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"

commit 8c2bd38b95f75f3d2a08c93e35303e26d480d24e upstream.

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
Link: https://patch.msgid.link/20240829144641.3880376-2-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ip.h |   2 +
 net/ipv4/icmp.c  | 103 ++++++++++++++++++++++++++---------------------
 net/ipv6/icmp.c  |  28 ++++++++-----
 3 files changed, 76 insertions(+), 57 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 4f11f7df7dd6788e9715b80a38540e862d1ff9e7..9d754c4a53002de506425a1be80619c105510634 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -781,6 +781,8 @@ static inline void ip_cmsg_recv(struct msghdr *msg, struct sk_buff *skb)
 }
 
 bool icmp_global_allow(void);
+void icmp_global_consume(void);
+
 extern int sysctl_icmp_msgs_per_sec;
 extern int sysctl_icmp_msgs_burst;
 
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 190988bfa3e293adaf1d5c2849592b64dcaf38da..9dffdd876fef501d5fa31698bb85c9f73dedc1e5 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -222,57 +222,59 @@ int sysctl_icmp_msgs_per_sec __read_mostly = 1000;
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
-		credit = max_t(int, credit - prandom_u32_max(3), 0);
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
@@ -289,14 +291,16 @@ static bool icmpv4_mask_allow(struct net *net, int type, int code)
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
@@ -306,15 +310,16 @@ static bool icmpv4_global_allow(struct net *net, int type, int code)
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
@@ -329,6 +334,8 @@ static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
 out:
 	if (!rc)
 		__ICMP_INC_STATS(net, ICMP_MIB_RATELIMITHOST);
+	else
+		icmp_global_consume();
 	return rc;
 }
 
@@ -400,6 +407,7 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 	struct ipcm_cookie ipc;
 	struct rtable *rt = skb_rtable(skb);
 	struct net *net = dev_net(rt->dst.dev);
+	bool apply_ratelimit = false;
 	struct flowi4 fl4;
 	struct sock *sk;
 	struct inet_sock *inet;
@@ -411,11 +419,11 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
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
@@ -448,7 +456,7 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 	rt = ip_route_output_key(net, &fl4);
 	if (IS_ERR(rt))
 		goto out_unlock;
-	if (icmpv4_xrlim_allow(net, rt, &fl4, type, code))
+	if (icmpv4_xrlim_allow(net, rt, &fl4, type, code, apply_ratelimit))
 		icmp_push_reply(sk, icmp_param, &fl4, &ipc, &rt);
 	ip_rt_put(rt);
 out_unlock:
@@ -592,6 +600,7 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	int room;
 	struct icmp_bxm icmp_param;
 	struct rtable *rt = skb_rtable(skb_in);
+	bool apply_ratelimit = false;
 	struct ipcm_cookie ipc;
 	struct flowi4 fl4;
 	__be32 saddr;
@@ -673,7 +682,7 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 		}
 	}
 
-	/* Needed by both icmp_global_allow and icmp_xmit_lock */
+	/* Needed by both icmpv4_global_allow and icmp_xmit_lock */
 	local_bh_disable();
 
 	/* Check global sysctl_icmp_msgs_per_sec ratelimit, unless
@@ -681,7 +690,7 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	 * loopback, then peer ratelimit still work (in icmpv4_xrlim_allow)
 	 */
 	if (!(skb_in->dev && (skb_in->dev->flags&IFF_LOOPBACK)) &&
-	      !icmpv4_global_allow(net, type, code))
+	      !icmpv4_global_allow(net, type, code, &apply_ratelimit))
 		goto out_bh_enable;
 
 	sk = icmp_xmit_lock(net);
@@ -740,7 +749,7 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 		goto out_unlock;
 
 	/* peer icmp_ratelimit */
-	if (!icmpv4_xrlim_allow(net, rt, &fl4, type, code))
+	if (!icmpv4_xrlim_allow(net, rt, &fl4, type, code, apply_ratelimit))
 		goto ende;
 
 	/* RFC says return as much as we can without exceeding 576 bytes. */
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 7bea1d82e1783c1956ea388ddc6ed842e2a6268e..ed8cdf7b8b11ecb1afd606efa6cff7348bb58ea0 100644
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
@@ -454,6 +458,7 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 	struct net *net;
 	struct ipv6_pinfo *np;
 	const struct in6_addr *saddr = NULL;
+	bool apply_ratelimit = false;
 	struct dst_entry *dst;
 	struct icmp6hdr tmp_hdr;
 	struct flowi6 fl6;
@@ -535,11 +540,12 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
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
@@ -577,7 +583,7 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 
 	np = inet6_sk(sk);
 
-	if (!icmpv6_xrlim_allow(sk, type, &fl6))
+	if (!icmpv6_xrlim_allow(sk, type, &fl6, apply_ratelimit))
 		goto out;
 
 	tmp_hdr.icmp6_type = type;
@@ -719,6 +725,7 @@ static void icmpv6_echo_reply(struct sk_buff *skb)
 	struct ipv6_pinfo *np;
 	const struct in6_addr *saddr = NULL;
 	struct icmp6hdr *icmph = icmp6_hdr(skb);
+	bool apply_ratelimit = false;
 	struct icmp6hdr tmp_hdr;
 	struct flowi6 fl6;
 	struct icmpv6_msg msg;
@@ -782,8 +789,9 @@ static void icmpv6_echo_reply(struct sk_buff *skb)
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
2.46.1.824.gd892dcdcdd-goog


