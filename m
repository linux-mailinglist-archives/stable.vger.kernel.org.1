Return-Path: <stable+bounces-165145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 834CFB15495
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 23:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B677B3AC2FA
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 21:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBB02797BE;
	Tue, 29 Jul 2025 21:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiZMHSGM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F21824DD17
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 21:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753823520; cv=none; b=NgfcqKDLbYeiOneMfs+TF8Jc7n/gGte0Lg4mOpzIx6PeqopuVVu8aLleLHAKpH4Y4wkLGYvaZp+7/d00eiDs0zXZb/eXTy0tBvDMUkFfrP38uP+yNZYLLTiZOgiB3lB0OmXeHmvfoj8U5WnQkE2iPXqMtEg6aR8UZrC6MqmL7y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753823520; c=relaxed/simple;
	bh=ewQXMtOKSHmAc/pZNTjvKunz7kT/74vq0f5kXxA2s1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RTSeDzyT3O7khWof1UsFcSXrreIdig7eFVKP2I8KQfq/lkudE66PcfmSEwQF8P+IMmODPjfIlAGw1cKIsUxzS1WD24tqhD3+bVYDC2Ja5iOHHfKbYzXkvY1yD4WDb37qyox+r08yInFGRpPUBEk41Kw5Xqsx2TriE04nJelSMHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiZMHSGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0D6C4CEEF;
	Tue, 29 Jul 2025 21:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753823519;
	bh=ewQXMtOKSHmAc/pZNTjvKunz7kT/74vq0f5kXxA2s1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KiZMHSGMKCWP/kCHOiK1cT6sAoqrW7X//UwTCRRsMh8x9t911mk/ghFvDdBP0mw3o
	 Uoj/eQYsBq2cB2Y7KdprH/nhvo3zBZfCh+gJ0JqQdHklvNt6xzt39RA3KyLgxtxTjd
	 B0phlgZ2wvSU+0VUUb9XQjhADBX5PE+6bcqRIcnAMKKx5T2xKfuIl0s4s2dbTEsa6g
	 U3duvE/EMKSR9ARdKLO4+0Qo36MAXfX/48R21sAHx6xmsXWI+Fr2h/oTqtEiNOxgiT
	 dRhWszEip0FXgDYanmyW0EWysMJS6aDICc8NKalEzvTknd2ogfnS/tzkmV6fTKK2B7
	 ZAnShnFgPsSsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] xfrm: delete x->tunnel as we delete x
Date: Tue, 29 Jul 2025 17:11:52 -0400
Message-Id: <20250729211153.2893984-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072924-postbox-exorcism-f636@gregkh>
References: <2025072924-postbox-exorcism-f636@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit b441cf3f8c4b8576639d20c8eb4aa32917602ecd ]

The ipcomp fallback tunnels currently get deleted (from the various
lists and hashtables) as the last user state that needed that fallback
is destroyed (not deleted). If a reference to that user state still
exists, the fallback state will remain on the hashtables/lists,
triggering the WARN in xfrm_state_fini. Because of those remaining
references, the fix in commit f75a2804da39 ("xfrm: destroy xfrm_state
synchronously on net exit path") is not complete.

We recently fixed one such situation in TCP due to defered freeing of
skbs (commit 9b6412e6979f ("tcp: drop secpath at the same time as we
currently drop dst")). This can also happen due to IP reassembly: skbs
with a secpath remain on the reassembly queue until netns
destruction. If we can't guarantee that the queues are flushed by the
time xfrm_state_fini runs, there may still be references to a (user)
xfrm_state, preventing the timely deletion of the corresponding
fallback state.

Instead of chasing each instance of skbs holding a secpath one by one,
this patch fixes the issue directly within xfrm, by deleting the
fallback state as soon as the last user state depending on it has been
deleted. Destruction will still happen when the final reference is
dropped.

A separate lockdep class for the fallback state is required since
we're going to lock x->tunnel while x is locked.

Fixes: 9d4139c76905 ("netns xfrm: per-netns xfrm_state_all list")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/xfrm.h      |  1 -
 net/ipv4/ipcomp.c       |  2 ++
 net/ipv6/ipcomp6.c      |  2 ++
 net/ipv6/xfrm6_tunnel.c |  2 +-
 net/xfrm/xfrm_ipcomp.c  |  1 -
 net/xfrm/xfrm_state.c   | 19 ++++++++-----------
 6 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 1484dd15a369..d3bdefdc4a50 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -424,7 +424,6 @@ int xfrm_input_register_afinfo(const struct xfrm_input_afinfo *afinfo);
 int xfrm_input_unregister_afinfo(const struct xfrm_input_afinfo *afinfo);
 
 void xfrm_flush_gc(void);
-void xfrm_state_delete_tunnel(struct xfrm_state *x);
 
 struct xfrm_type {
 	struct module		*owner;
diff --git a/net/ipv4/ipcomp.c b/net/ipv4/ipcomp.c
index 5a4fb2539b08..9a45aed508d1 100644
--- a/net/ipv4/ipcomp.c
+++ b/net/ipv4/ipcomp.c
@@ -54,6 +54,7 @@ static int ipcomp4_err(struct sk_buff *skb, u32 info)
 }
 
 /* We always hold one tunnel user reference to indicate a tunnel */
+static struct lock_class_key xfrm_state_lock_key;
 static struct xfrm_state *ipcomp_tunnel_create(struct xfrm_state *x)
 {
 	struct net *net = xs_net(x);
@@ -62,6 +63,7 @@ static struct xfrm_state *ipcomp_tunnel_create(struct xfrm_state *x)
 	t = xfrm_state_alloc(net);
 	if (!t)
 		goto out;
+	lockdep_set_class(&t->lock, &xfrm_state_lock_key);
 
 	t->id.proto = IPPROTO_IPIP;
 	t->id.spi = x->props.saddr.a4;
diff --git a/net/ipv6/ipcomp6.c b/net/ipv6/ipcomp6.c
index 72d4858dec18..8607569de34f 100644
--- a/net/ipv6/ipcomp6.c
+++ b/net/ipv6/ipcomp6.c
@@ -71,6 +71,7 @@ static int ipcomp6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	return 0;
 }
 
+static struct lock_class_key xfrm_state_lock_key;
 static struct xfrm_state *ipcomp6_tunnel_create(struct xfrm_state *x)
 {
 	struct net *net = xs_net(x);
@@ -79,6 +80,7 @@ static struct xfrm_state *ipcomp6_tunnel_create(struct xfrm_state *x)
 	t = xfrm_state_alloc(net);
 	if (!t)
 		goto out;
+	lockdep_set_class(&t->lock, &xfrm_state_lock_key);
 
 	t->id.proto = IPPROTO_IPV6;
 	t->id.spi = xfrm6_tunnel_alloc_spi(net, (xfrm_address_t *)&x->props.saddr);
diff --git a/net/ipv6/xfrm6_tunnel.c b/net/ipv6/xfrm6_tunnel.c
index bf140ef781c1..7fd8bc08e6eb 100644
--- a/net/ipv6/xfrm6_tunnel.c
+++ b/net/ipv6/xfrm6_tunnel.c
@@ -334,8 +334,8 @@ static void __net_exit xfrm6_tunnel_net_exit(struct net *net)
 	struct xfrm6_tunnel_net *xfrm6_tn = xfrm6_tunnel_pernet(net);
 	unsigned int i;
 
-	xfrm_flush_gc();
 	xfrm_state_flush(net, 0, false, true);
+	xfrm_flush_gc();
 
 	for (i = 0; i < XFRM6_TUNNEL_SPI_BYADDR_HSIZE; i++)
 		WARN_ON_ONCE(!hlist_empty(&xfrm6_tn->spi_byaddr[i]));
diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
index 9c0fa0e1786a..f2e70e918f11 100644
--- a/net/xfrm/xfrm_ipcomp.c
+++ b/net/xfrm/xfrm_ipcomp.c
@@ -315,7 +315,6 @@ void ipcomp_destroy(struct xfrm_state *x)
 	struct ipcomp_data *ipcd = x->data;
 	if (!ipcd)
 		return;
-	xfrm_state_delete_tunnel(x);
 	mutex_lock(&ipcomp_resource_mutex);
 	ipcomp_free_data(ipcd);
 	mutex_unlock(&ipcomp_resource_mutex);
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 7a298058fc16..f791a4f15cee 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -748,6 +748,7 @@ void __xfrm_state_destroy(struct xfrm_state *x, bool sync)
 }
 EXPORT_SYMBOL(__xfrm_state_destroy);
 
+static void xfrm_state_delete_tunnel(struct xfrm_state *x);
 int __xfrm_state_delete(struct xfrm_state *x)
 {
 	struct net *net = xs_net(x);
@@ -775,6 +776,8 @@ int __xfrm_state_delete(struct xfrm_state *x)
 
 		xfrm_dev_state_delete(x);
 
+		xfrm_state_delete_tunnel(x);
+
 		/* All xfrm_state objects are created by xfrm_state_alloc.
 		 * The xfrm_state_alloc call gives a reference, and that
 		 * is what we are dropping here.
@@ -878,10 +881,7 @@ int xfrm_state_flush(struct net *net, u8 proto, bool task_valid, bool sync)
 				err = xfrm_state_delete(x);
 				xfrm_audit_state_delete(x, err ? 0 : 1,
 							task_valid);
-				if (sync)
-					xfrm_state_put_sync(x);
-				else
-					xfrm_state_put(x);
+				xfrm_state_put(x);
 				if (!err)
 					cnt++;
 
@@ -2994,20 +2994,17 @@ void xfrm_flush_gc(void)
 }
 EXPORT_SYMBOL(xfrm_flush_gc);
 
-/* Temporarily located here until net/xfrm/xfrm_tunnel.c is created */
-void xfrm_state_delete_tunnel(struct xfrm_state *x)
+static void xfrm_state_delete_tunnel(struct xfrm_state *x)
 {
 	if (x->tunnel) {
 		struct xfrm_state *t = x->tunnel;
 
-		if (atomic_read(&t->tunnel_users) == 2)
+		if (atomic_dec_return(&t->tunnel_users) == 1)
 			xfrm_state_delete(t);
-		atomic_dec(&t->tunnel_users);
-		xfrm_state_put_sync(t);
+		xfrm_state_put(t);
 		x->tunnel = NULL;
 	}
 }
-EXPORT_SYMBOL(xfrm_state_delete_tunnel);
 
 u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
 {
@@ -3207,8 +3204,8 @@ void xfrm_state_fini(struct net *net)
 	unsigned int sz;
 
 	flush_work(&net->xfrm.state_hash_work);
-	flush_work(&xfrm_state_gc_work);
 	xfrm_state_flush(net, 0, false, true);
+	flush_work(&xfrm_state_gc_work);
 
 	WARN_ON(!list_empty(&net->xfrm.state_all));
 
-- 
2.39.5


