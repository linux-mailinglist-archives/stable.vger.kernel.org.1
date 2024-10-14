Return-Path: <stable+bounces-84634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53CA99D124
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E602852B3
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E312A1AB505;
	Mon, 14 Oct 2024 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F5LAaBmR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A112F1A76A5;
	Mon, 14 Oct 2024 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918687; cv=none; b=koH++1UHP6EfxNpI1xeEVVeQiSCXrmAvK2129cElEW0nHZG1dsB0lo5c8xRuMBS0rv5KoqWzmqjELETjaE+eUFDDIrIBMC9yJz+RkaG+rP+QWM9WfkT0iMlLRdOLXMCAaABITNrabo61ZCps6wuXJsqq/SHV3u06YrTBHALGCGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918687; c=relaxed/simple;
	bh=4oYOwfmcv95elabBy7dUr8Jr+hQ8ZcXUh/hY/kQMSrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGyjpp43ztOU0fY98/s9KonMqWTZ3h0K2Kp2lWKyoKyVTMqdmwJSxagjrP63YBDts49qftxAe9+ewcMCMwICXAQDpckVqutZHVwIOS0sDtxffgjNY/xXghN7J8GU4QHa/7Dz3ajwYS0mASHnT2UK1iet7KXCr3QPAsyLTyZIA/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F5LAaBmR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE88C4CEC3;
	Mon, 14 Oct 2024 15:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728918687;
	bh=4oYOwfmcv95elabBy7dUr8Jr+hQ8ZcXUh/hY/kQMSrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F5LAaBmRT1RDfU/Kymur5nW5tXr4seetQw8bICA7S5e6gmvAUHnQbXcx2mBQDoUcG
	 BHo105LtSui/5nqRrmZqUEVM44SepnD9dyquU94Qhh0dgewP+0Jp53gMzAE07/Dkob
	 ATskDNvE1xxH7GIqMWi4QLxRdvPQB5U08osTNBV8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Keyu Man <keyu.man@email.ucr.edu>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 362/798] icmp: change the order of rate limits
Date: Mon, 14 Oct 2024 16:15:16 +0200
Message-ID: <20241014141232.171538170@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/ip.h |    2 +
 net/ipv4/icmp.c  |  103 +++++++++++++++++++++++++++++--------------------------
 net/ipv6/icmp.c  |   28 +++++++++-----
 3 files changed, 76 insertions(+), 57 deletions(-)

--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -781,6 +781,8 @@ static inline void ip_cmsg_recv(struct m
 }
 
 bool icmp_global_allow(void);
+void icmp_global_consume(void);
+
 extern int sysctl_icmp_msgs_per_sec;
 extern int sysctl_icmp_msgs_burst;
 
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -222,57 +222,59 @@ int sysctl_icmp_msgs_per_sec __read_most
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
@@ -289,14 +291,16 @@ static bool icmpv4_mask_allow(struct net
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
@@ -306,15 +310,16 @@ static bool icmpv4_global_allow(struct n
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
@@ -329,6 +334,8 @@ static bool icmpv4_xrlim_allow(struct ne
 out:
 	if (!rc)
 		__ICMP_INC_STATS(net, ICMP_MIB_RATELIMITHOST);
+	else
+		icmp_global_consume();
 	return rc;
 }
 
@@ -400,6 +407,7 @@ static void icmp_reply(struct icmp_bxm *
 	struct ipcm_cookie ipc;
 	struct rtable *rt = skb_rtable(skb);
 	struct net *net = dev_net(rt->dst.dev);
+	bool apply_ratelimit = false;
 	struct flowi4 fl4;
 	struct sock *sk;
 	struct inet_sock *inet;
@@ -411,11 +419,11 @@ static void icmp_reply(struct icmp_bxm *
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
@@ -448,7 +456,7 @@ static void icmp_reply(struct icmp_bxm *
 	rt = ip_route_output_key(net, &fl4);
 	if (IS_ERR(rt))
 		goto out_unlock;
-	if (icmpv4_xrlim_allow(net, rt, &fl4, type, code))
+	if (icmpv4_xrlim_allow(net, rt, &fl4, type, code, apply_ratelimit))
 		icmp_push_reply(sk, icmp_param, &fl4, &ipc, &rt);
 	ip_rt_put(rt);
 out_unlock:
@@ -592,6 +600,7 @@ void __icmp_send(struct sk_buff *skb_in,
 	int room;
 	struct icmp_bxm icmp_param;
 	struct rtable *rt = skb_rtable(skb_in);
+	bool apply_ratelimit = false;
 	struct ipcm_cookie ipc;
 	struct flowi4 fl4;
 	__be32 saddr;
@@ -673,7 +682,7 @@ void __icmp_send(struct sk_buff *skb_in,
 		}
 	}
 
-	/* Needed by both icmp_global_allow and icmp_xmit_lock */
+	/* Needed by both icmpv4_global_allow and icmp_xmit_lock */
 	local_bh_disable();
 
 	/* Check global sysctl_icmp_msgs_per_sec ratelimit, unless
@@ -681,7 +690,7 @@ void __icmp_send(struct sk_buff *skb_in,
 	 * loopback, then peer ratelimit still work (in icmpv4_xrlim_allow)
 	 */
 	if (!(skb_in->dev && (skb_in->dev->flags&IFF_LOOPBACK)) &&
-	      !icmpv4_global_allow(net, type, code))
+	      !icmpv4_global_allow(net, type, code, &apply_ratelimit))
 		goto out_bh_enable;
 
 	sk = icmp_xmit_lock(net);
@@ -740,7 +749,7 @@ void __icmp_send(struct sk_buff *skb_in,
 		goto out_unlock;
 
 	/* peer icmp_ratelimit */
-	if (!icmpv4_xrlim_allow(net, rt, &fl4, type, code))
+	if (!icmpv4_xrlim_allow(net, rt, &fl4, type, code, apply_ratelimit))
 		goto ende;
 
 	/* RFC says return as much as we can without exceeding 576 bytes. */
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -175,14 +175,16 @@ static bool icmpv6_mask_allow(struct net
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
@@ -191,13 +193,13 @@ static bool icmpv6_global_allow(struct n
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
@@ -228,6 +230,8 @@ static bool icmpv6_xrlim_allow(struct so
 	if (!res)
 		__ICMP6_INC_STATS(net, ip6_dst_idev(dst),
 				  ICMP6_MIB_RATELIMITHOST);
+	else
+		icmp_global_consume();
 	dst_release(dst);
 	return res;
 }
@@ -454,6 +458,7 @@ void icmp6_send(struct sk_buff *skb, u8
 	struct net *net;
 	struct ipv6_pinfo *np;
 	const struct in6_addr *saddr = NULL;
+	bool apply_ratelimit = false;
 	struct dst_entry *dst;
 	struct icmp6hdr tmp_hdr;
 	struct flowi6 fl6;
@@ -535,11 +540,12 @@ void icmp6_send(struct sk_buff *skb, u8
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
@@ -577,7 +583,7 @@ void icmp6_send(struct sk_buff *skb, u8
 
 	np = inet6_sk(sk);
 
-	if (!icmpv6_xrlim_allow(sk, type, &fl6))
+	if (!icmpv6_xrlim_allow(sk, type, &fl6, apply_ratelimit))
 		goto out;
 
 	tmp_hdr.icmp6_type = type;
@@ -719,6 +725,7 @@ static void icmpv6_echo_reply(struct sk_
 	struct ipv6_pinfo *np;
 	const struct in6_addr *saddr = NULL;
 	struct icmp6hdr *icmph = icmp6_hdr(skb);
+	bool apply_ratelimit = false;
 	struct icmp6hdr tmp_hdr;
 	struct flowi6 fl6;
 	struct icmpv6_msg msg;
@@ -782,8 +789,9 @@ static void icmpv6_echo_reply(struct sk_
 		goto out;
 
 	/* Check the ratelimit */
-	if ((!(skb->dev->flags & IFF_LOOPBACK) && !icmpv6_global_allow(net, ICMPV6_ECHO_REPLY)) ||
-	    !icmpv6_xrlim_allow(sk, ICMPV6_ECHO_REPLY, &fl6))
+	if ((!(skb->dev->flags & IFF_LOOPBACK) &&
+	    !icmpv6_global_allow(net, ICMPV6_ECHO_REPLY, &apply_ratelimit)) ||
+	    !icmpv6_xrlim_allow(sk, ICMPV6_ECHO_REPLY, &fl6, apply_ratelimit))
 		goto out_dst_release;
 
 	idev = __in6_dev_get(skb->dev);



