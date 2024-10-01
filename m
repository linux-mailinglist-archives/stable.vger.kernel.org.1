Return-Path: <stable+bounces-78513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9F198BECE
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 16:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7B51F214B6
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 14:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A908D1991A3;
	Tue,  1 Oct 2024 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S8lGRymA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694DE224CF
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791351; cv=none; b=RjGZ91Od2t84+GOlGy3INOWeHJvfUqSqtN8YxM8PBbZUlfw54D8C5jij81+n0JihK0RnRcwx5EiUPMtIMBkwBbSLylh02S5c+Frh/pUkzzIwroYmFPQOXJ034peedpmtTwEmwWMmQ6lKiTth91Ao5j1nQVXQGqtAg9FcMcOHkG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791351; c=relaxed/simple;
	bh=U8YSbmiXUSc7/vAkqfd7r1WOo8uYv4mtHiHtZuHz4ps=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oLY5uXC6d3yoh7YqCXWP+c70o+uw/qvgQ/rjUAjjdoC1Wo/cJQABerShfSsGMWeig5DFex1GtJ90TWas34rQKizBeXignN7DWuYeSkJiLqSY/jmUgqV6DlxIVr8IGnPsLZAI+k0MOIb42HZ5CvVDAbbUYkkho4d3riHzRAws4Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S8lGRymA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644B7C4CEC7;
	Tue,  1 Oct 2024 14:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727791350;
	bh=U8YSbmiXUSc7/vAkqfd7r1WOo8uYv4mtHiHtZuHz4ps=;
	h=Subject:To:Cc:From:Date:From;
	b=S8lGRymAriLCky6Vm8T970GmtG8/xFqY8JSZjX2SSm5mh2Gf0D7dMVH6NMIXESwHd
	 VRNSYKh1ICqbjfgZo3p4v/alSKw2g/iT8LcdEeaD2S0zS4HVjMauEwwVCuqu0TtrqA
	 HhoXglbWsaqwqU3JDmyyitsUVQcYylOa97tTZTn0=
Subject: FAILED: patch "[PATCH] icmp: change the order of rate limits" failed to apply to 6.1-stable tree
To: edumazet@google.com,dsahern@kernel.org,hawk@kernel.org,keyu.man@email.ucr.edu,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 16:02:27 +0200
Message-ID: <2024100127-uninsured-onyx-f79a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8c2bd38b95f75f3d2a08c93e35303e26d480d24e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100127-uninsured-onyx-f79a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

8c2bd38b95f7 ("icmp: change the order of rate limits")
d0941130c935 ("icmp: Add counters for rate limits")
8032bf1233a7 ("treewide: use get_random_u32_below() instead of deprecated function")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8c2bd38b95f75f3d2a08c93e35303e26d480d24e Mon Sep 17 00:00:00 2001
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 29 Aug 2024 14:46:39 +0000
Subject: [PATCH] icmp: change the order of rate limits

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

diff --git a/include/net/ip.h b/include/net/ip.h
index c5606cadb1a5..82248813619e 100644
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
index b8f56d03fcbb..0078e8fb2e86 100644
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
-	credit = min_t(u32, icmp_global.credit + incr,
-		       READ_ONCE(sysctl_icmp_msgs_burst));
-	if (credit) {
-		/* We want to use a credit of one in average, but need to randomize
-		 * it for security reasons.
-		 */
-		credit = max_t(int, credit - get_random_u32_below(3), 0);
-		rc = true;
-	}
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
index 7b31674644ef..46f70e4a8351 100644
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


