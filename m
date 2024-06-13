Return-Path: <stable+bounces-50425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6469065C0
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 09:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE382281AD2
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 07:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A59C13C9D5;
	Thu, 13 Jun 2024 07:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOsHOnyT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB2813C9CF
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 07:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265317; cv=none; b=sOfGxCkQDjF7hDTZzMQSoCS/eko1YDzzGqQiNeke9xbsAv3fuqLSiMumPDjrRT4trYVD4hTSHJd77JB2cYnSOUzb9xjpt9cHLw62uheeoVPj4ff87PPh+ZGI+Wbf+Ez2PjlVZH2JqH4y2aIFy7EKnynzzADNWX6tNK6uaRLa9qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265317; c=relaxed/simple;
	bh=bLUVu9gcYhniB1VsuuATrMZzxN1bm8nAlvwkmnZQ7qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGmYCCAZitFg6aak3Hy0ZB+Ga3k4BCw1ow06tL/mwHssdloy4Hzzj75s64B/nAKeTfzmietJIEzAS5uTNqTSd2x2dopVqn5pfZ2kmvP3zfHa0w5i+mwnv56AtfevN32mIt/YeXCOXLmyBV/sTHpKMAe1DME0w5YqCEMn8+Fhg9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOsHOnyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CABC4AF1A;
	Thu, 13 Jun 2024 07:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718265317;
	bh=bLUVu9gcYhniB1VsuuATrMZzxN1bm8nAlvwkmnZQ7qQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bOsHOnyTbnC1ACYN5BNnF0HULvF6XSi7DopmpxFit3twRYsodGxvGr/zGS6cjPJ5P
	 TuV8Dq7AUJxZQcrRwGufnwTVgbvmEAS+QjWK2qfi5RbK6ixkDv+u8e3EyW4+/SdYiS
	 IAlz92tzfDbBACJP61YB11uVpWcgvA3OmqJcSgJSHi+41rE5gcCzuxWyhJt8gkNvvp
	 Zvqx82jw/cD3ZeBLR8K7IgRJ/R9pjkWYPgvvB9NjWMSfkI85o/rybRxggavSAQlZCS
	 3Uq742FkT5FrlJ5/s79ujd/S38JtRIC5dGR1+0EkbE09DUXdp82QaLPZt9AUcTGwTF
	 hl9SMpbRJKXhA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Clement Lecigne <clecigne@google.com>,
	Tom Herbert <tom@herbertland.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 1/1] net: fix __dst_negative_advice() race
Date: Thu, 13 Jun 2024 08:54:40 +0100
Message-ID: <20240613075444.2477127-6-lee@kernel.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240613075444.2477127-1-lee@kernel.org>
References: <20240613075444.2477127-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

__dst_negative_advice() does not enforce proper RCU rules when
sk->dst_cache must be cleared, leading to possible UAF.

RCU rules are that we must first clear sk->sk_dst_cache,
then call dst_release(old_dst).

Note that sk_dst_reset(sk) is implementing this protocol correctly,
while __dst_negative_advice() uses the wrong order.

Given that ip6_negative_advice() has special logic
against RTF_CACHE, this means each of the three ->negative_advice()
existing methods must perform the sk_dst_reset() themselves.

Note the check against NULL dst is centralized in
__dst_negative_advice(), there is no need to duplicate
it in various callbacks.

Many thanks to Clement Lecigne for tracking this issue.

This old bug became visible after the blamed commit, using UDP sockets.

Fixes: a87cb3e48ee8 ("net: Facility to report route quality of connected sockets")
Reported-by: Clement Lecigne <clecigne@google.com>
Diagnosed-by: Clement Lecigne <clecigne@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Tom Herbert <tom@herbertland.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://lore.kernel.org/r/20240528114353.1794151-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 92f1655aa2b2294d0b49925f3b875a634bd3b59e)
[Lee: Stable backport]
Signed-off-by: Lee Jones <lee@kernel.org>
---
 include/net/dst_ops.h  |  2 +-
 include/net/sock.h     | 13 +++----------
 net/ipv4/route.c       | 22 ++++++++--------------
 net/ipv6/route.c       | 29 +++++++++++++++--------------
 net/xfrm/xfrm_policy.c | 11 +++--------
 5 files changed, 30 insertions(+), 47 deletions(-)

diff --git a/include/net/dst_ops.h b/include/net/dst_ops.h
index 6d1c8541183d..3a9001a042a5 100644
--- a/include/net/dst_ops.h
+++ b/include/net/dst_ops.h
@@ -24,7 +24,7 @@ struct dst_ops {
 	void			(*destroy)(struct dst_entry *);
 	void			(*ifdown)(struct dst_entry *,
 					  struct net_device *dev);
-	struct dst_entry *	(*negative_advice)(struct dst_entry *);
+	void			(*negative_advice)(struct sock *sk, struct dst_entry *);
 	void			(*link_failure)(struct sk_buff *);
 	void			(*update_pmtu)(struct dst_entry *dst, struct sock *sk,
 					       struct sk_buff *skb, u32 mtu,
diff --git a/include/net/sock.h b/include/net/sock.h
index 53b81e0a8981..5942b5ff4c78 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2183,17 +2183,10 @@ sk_dst_get(const struct sock *sk)
 
 static inline void __dst_negative_advice(struct sock *sk)
 {
-	struct dst_entry *ndst, *dst = __sk_dst_get(sk);
+	struct dst_entry *dst = __sk_dst_get(sk);
 
-	if (dst && dst->ops->negative_advice) {
-		ndst = dst->ops->negative_advice(dst);
-
-		if (ndst != dst) {
-			rcu_assign_pointer(sk->sk_dst_cache, ndst);
-			sk_tx_queue_clear(sk);
-			WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
-		}
-	}
+	if (dst && dst->ops->negative_advice)
+		dst->ops->negative_advice(sk, dst);
 }
 
 static inline void dst_negative_advice(struct sock *sk)
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 7c05cbcd39d3..40b9c579c917 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -132,7 +132,8 @@ struct dst_entry	*ipv4_dst_check(struct dst_entry *dst, u32 cookie);
 static unsigned int	 ipv4_default_advmss(const struct dst_entry *dst);
 INDIRECT_CALLABLE_SCOPE
 unsigned int		ipv4_mtu(const struct dst_entry *dst);
-static struct dst_entry *ipv4_negative_advice(struct dst_entry *dst);
+static void		ipv4_negative_advice(struct sock *sk,
+					     struct dst_entry *dst);
 static void		 ipv4_link_failure(struct sk_buff *skb);
 static void		 ip_rt_update_pmtu(struct dst_entry *dst, struct sock *sk,
 					   struct sk_buff *skb, u32 mtu,
@@ -837,22 +838,15 @@ static void ip_do_redirect(struct dst_entry *dst, struct sock *sk, struct sk_buf
 	__ip_do_redirect(rt, skb, &fl4, true);
 }
 
-static struct dst_entry *ipv4_negative_advice(struct dst_entry *dst)
+static void ipv4_negative_advice(struct sock *sk,
+				 struct dst_entry *dst)
 {
 	struct rtable *rt = (struct rtable *)dst;
-	struct dst_entry *ret = dst;
 
-	if (rt) {
-		if (dst->obsolete > 0) {
-			ip_rt_put(rt);
-			ret = NULL;
-		} else if ((rt->rt_flags & RTCF_REDIRECTED) ||
-			   rt->dst.expires) {
-			ip_rt_put(rt);
-			ret = NULL;
-		}
-	}
-	return ret;
+	if ((dst->obsolete > 0) ||
+	    (rt->rt_flags & RTCF_REDIRECTED) ||
+	    rt->dst.expires)
+		sk_dst_reset(sk);
 }
 
 /*
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 236a45557ba1..0c0a1a5e4022 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -87,7 +87,8 @@ struct dst_entry	*ip6_dst_check(struct dst_entry *dst, u32 cookie);
 static unsigned int	 ip6_default_advmss(const struct dst_entry *dst);
 INDIRECT_CALLABLE_SCOPE
 unsigned int		ip6_mtu(const struct dst_entry *dst);
-static struct dst_entry *ip6_negative_advice(struct dst_entry *);
+static void		ip6_negative_advice(struct sock *sk,
+					    struct dst_entry *dst);
 static void		ip6_dst_destroy(struct dst_entry *);
 static void		ip6_dst_ifdown(struct dst_entry *,
 				       struct net_device *dev);
@@ -2760,24 +2761,24 @@ INDIRECT_CALLABLE_SCOPE struct dst_entry *ip6_dst_check(struct dst_entry *dst,
 }
 EXPORT_INDIRECT_CALLABLE(ip6_dst_check);
 
-static struct dst_entry *ip6_negative_advice(struct dst_entry *dst)
+static void ip6_negative_advice(struct sock *sk,
+				struct dst_entry *dst)
 {
 	struct rt6_info *rt = (struct rt6_info *) dst;
 
-	if (rt) {
-		if (rt->rt6i_flags & RTF_CACHE) {
-			rcu_read_lock();
-			if (rt6_check_expired(rt)) {
-				rt6_remove_exception_rt(rt);
-				dst = NULL;
-			}
-			rcu_read_unlock();
-		} else {
-			dst_release(dst);
-			dst = NULL;
+	if (rt->rt6i_flags & RTF_CACHE) {
+		rcu_read_lock();
+		if (rt6_check_expired(rt)) {
+			/* counteract the dst_release() in sk_dst_reset() */
+			dst_hold(dst);
+			sk_dst_reset(sk);
+
+			rt6_remove_exception_rt(rt);
 		}
+		rcu_read_unlock();
+		return;
 	}
-	return dst;
+	sk_dst_reset(sk);
 }
 
 static void ip6_link_failure(struct sk_buff *skb)
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 97d69ec54ff9..0dde08e02887 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3853,15 +3853,10 @@ static void xfrm_link_failure(struct sk_buff *skb)
 	/* Impossible. Such dst must be popped before reaches point of failure. */
 }
 
-static struct dst_entry *xfrm_negative_advice(struct dst_entry *dst)
+static void xfrm_negative_advice(struct sock *sk, struct dst_entry *dst)
 {
-	if (dst) {
-		if (dst->obsolete) {
-			dst_release(dst);
-			dst = NULL;
-		}
-	}
-	return dst;
+	if (dst->obsolete)
+		sk_dst_reset(sk);
 }
 
 static void xfrm_init_pmtu(struct xfrm_dst **bundle, int nr)
-- 
2.45.2.505.gda0bf45e8d-goog


