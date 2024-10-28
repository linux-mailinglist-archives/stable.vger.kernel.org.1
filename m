Return-Path: <stable+bounces-89038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9AC9B2E01
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 12:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64941F21009
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2832010E0;
	Mon, 28 Oct 2024 10:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhj/Xrfw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD01200CA4;
	Mon, 28 Oct 2024 10:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112794; cv=none; b=PEnzdMiicUj9bGjwdRrzVaJf7ZujX2bLxNPzHY5KOYl4cHr46zMLxqUneOc1sP6UaxFBra8AZtYh6SDUyGP6d3sC6CxYqlECLS5W5Q0TbCznZj6EkB1FMPKpEulhPokVxiW3XTI4r01JdI9I3ddnRMZqZuDzg2A5SVwOnytXFoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112794; c=relaxed/simple;
	bh=fKiwhT04Pr77s113q9VUgdfNwDQWaaM/67NlVd+MEYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j5vVfQ8RmyDCdKCXxMy7vwsxxN15H6NOjpLBqLrfrewyVVdkLPUSHHshhzkxXV9bWRveUGu+qsTRvJAWdi+bBUKfYQmGMkXa5U1mbdF9w1HK9OksxK7UAJ5AjyR1kvBAi9RvG4j6XApQtMMnT9go4DrQw6SIpdAIDzx6q2ZDi04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhj/Xrfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91741C4CEE3;
	Mon, 28 Oct 2024 10:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112793;
	bh=fKiwhT04Pr77s113q9VUgdfNwDQWaaM/67NlVd+MEYA=;
	h=From:To:Cc:Subject:Date:From;
	b=nhj/Xrfw8LXxg4//JnF8cuglAjMUIgV3au+rbC1dWOKHM/UI1JjNUkm+NSzukdz5l
	 NvgcMZ2NvPiY+TRT6uOG7oaJrrlD01ecA4MELUxKE+i6WtBTMHXE3ZMRPw1yaPxYTJ
	 1Oz2iclxXcGf3bjQQ9tPvXzd8vY5uOTpwPGOlpA6GZ1soVBHpTFSScpmpCknJ9PquA
	 OQEm0hRm5JexfuJxzxh+6MOtfRAjVgzV5x1ERRnPQ1hOQ8vb+9H5uXNa+J9soGN5Zw
	 R3PsJrvK6+M/KVtA37K4Oo9CorsrgWE78fQmwzz/HMC3s2UYpMAODAS0J4k9ZD8yXO
	 qAXfX3K/sbNww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eyal Birger <eyal.birger@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 1/7] xfrm: extract dst lookup parameters into a struct
Date: Mon, 28 Oct 2024 06:53:03 -0400
Message-ID: <20241028105311.3560419-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.169
Content-Transfer-Encoding: 8bit

From: Eyal Birger <eyal.birger@gmail.com>

[ Upstream commit e509996b16728e37d5a909a5c63c1bd64f23b306 ]

Preparation for adding more fields to dst lookup functions without
changing their signatures.

Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/xfrm.h      | 26 +++++++++++++-------------
 net/ipv4/xfrm4_policy.c | 38 ++++++++++++++++----------------------
 net/ipv6/xfrm6_policy.c | 28 +++++++++++++---------------
 net/xfrm/xfrm_device.c  | 11 ++++++++---
 net/xfrm/xfrm_policy.c  | 35 +++++++++++++++++++++++------------
 5 files changed, 73 insertions(+), 65 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 2e2e30d31a763..642e0b60130d8 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -315,20 +315,23 @@ struct xfrm_if_cb {
 void xfrm_if_register_cb(const struct xfrm_if_cb *ifcb);
 void xfrm_if_unregister_cb(void);
 
+struct xfrm_dst_lookup_params {
+	struct net *net;
+	int tos;
+	int oif;
+	xfrm_address_t *saddr;
+	xfrm_address_t *daddr;
+	u32 mark;
+};
+
 struct net_device;
 struct xfrm_type;
 struct xfrm_dst;
 struct xfrm_policy_afinfo {
 	struct dst_ops		*dst_ops;
-	struct dst_entry	*(*dst_lookup)(struct net *net,
-					       int tos, int oif,
-					       const xfrm_address_t *saddr,
-					       const xfrm_address_t *daddr,
-					       u32 mark);
-	int			(*get_saddr)(struct net *net, int oif,
-					     xfrm_address_t *saddr,
-					     xfrm_address_t *daddr,
-					     u32 mark);
+	struct dst_entry	*(*dst_lookup)(const struct xfrm_dst_lookup_params *params);
+	int			(*get_saddr)(xfrm_address_t *saddr,
+					     const struct xfrm_dst_lookup_params *params);
 	int			(*fill_dst)(struct xfrm_dst *xdst,
 					    struct net_device *dev,
 					    const struct flowi *fl);
@@ -1645,10 +1648,7 @@ static inline int xfrm_user_policy(struct sock *sk, int optname,
 }
 #endif
 
-struct dst_entry *__xfrm_dst_lookup(struct net *net, int tos, int oif,
-				    const xfrm_address_t *saddr,
-				    const xfrm_address_t *daddr,
-				    int family, u32 mark);
+struct dst_entry *__xfrm_dst_lookup(int family, const struct xfrm_dst_lookup_params *params);
 
 struct xfrm_policy *xfrm_policy_alloc(struct net *net, gfp_t gfp);
 
diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
index 4548a91acdc89..d1c2619e03740 100644
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -17,47 +17,41 @@
 #include <net/ip.h>
 #include <net/l3mdev.h>
 
-static struct dst_entry *__xfrm4_dst_lookup(struct net *net, struct flowi4 *fl4,
-					    int tos, int oif,
-					    const xfrm_address_t *saddr,
-					    const xfrm_address_t *daddr,
-					    u32 mark)
+static struct dst_entry *__xfrm4_dst_lookup(struct flowi4 *fl4,
+					    const struct xfrm_dst_lookup_params *params)
 {
 	struct rtable *rt;
 
 	memset(fl4, 0, sizeof(*fl4));
-	fl4->daddr = daddr->a4;
-	fl4->flowi4_tos = tos;
-	fl4->flowi4_l3mdev = l3mdev_master_ifindex_by_index(net, oif);
-	fl4->flowi4_mark = mark;
-	if (saddr)
-		fl4->saddr = saddr->a4;
-
-	rt = __ip_route_output_key(net, fl4);
+	fl4->daddr = params->daddr->a4;
+	fl4->flowi4_tos = params->tos;
+	fl4->flowi4_l3mdev = l3mdev_master_ifindex_by_index(params->net,
+							    params->oif);
+	fl4->flowi4_mark = params->mark;
+	if (params->saddr)
+		fl4->saddr = params->saddr->a4;
+
+	rt = __ip_route_output_key(params->net, fl4);
 	if (!IS_ERR(rt))
 		return &rt->dst;
 
 	return ERR_CAST(rt);
 }
 
-static struct dst_entry *xfrm4_dst_lookup(struct net *net, int tos, int oif,
-					  const xfrm_address_t *saddr,
-					  const xfrm_address_t *daddr,
-					  u32 mark)
+static struct dst_entry *xfrm4_dst_lookup(const struct xfrm_dst_lookup_params *params)
 {
 	struct flowi4 fl4;
 
-	return __xfrm4_dst_lookup(net, &fl4, tos, oif, saddr, daddr, mark);
+	return __xfrm4_dst_lookup(&fl4, params);
 }
 
-static int xfrm4_get_saddr(struct net *net, int oif,
-			   xfrm_address_t *saddr, xfrm_address_t *daddr,
-			   u32 mark)
+static int xfrm4_get_saddr(xfrm_address_t *saddr,
+			   const struct xfrm_dst_lookup_params *params)
 {
 	struct dst_entry *dst;
 	struct flowi4 fl4;
 
-	dst = __xfrm4_dst_lookup(net, &fl4, 0, oif, NULL, daddr, mark);
+	dst = __xfrm4_dst_lookup(&fl4, params);
 	if (IS_ERR(dst))
 		return -EHOSTUNREACH;
 
diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index 492b9692c0dc0..40183fdf7da0e 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -23,23 +23,21 @@
 #include <net/ip6_route.h>
 #include <net/l3mdev.h>
 
-static struct dst_entry *xfrm6_dst_lookup(struct net *net, int tos, int oif,
-					  const xfrm_address_t *saddr,
-					  const xfrm_address_t *daddr,
-					  u32 mark)
+static struct dst_entry *xfrm6_dst_lookup(const struct xfrm_dst_lookup_params *params)
 {
 	struct flowi6 fl6;
 	struct dst_entry *dst;
 	int err;
 
 	memset(&fl6, 0, sizeof(fl6));
-	fl6.flowi6_l3mdev = l3mdev_master_ifindex_by_index(net, oif);
-	fl6.flowi6_mark = mark;
-	memcpy(&fl6.daddr, daddr, sizeof(fl6.daddr));
-	if (saddr)
-		memcpy(&fl6.saddr, saddr, sizeof(fl6.saddr));
+	fl6.flowi6_l3mdev = l3mdev_master_ifindex_by_index(params->net,
+							   params->oif);
+	fl6.flowi6_mark = params->mark;
+	memcpy(&fl6.daddr, params->daddr, sizeof(fl6.daddr));
+	if (params->saddr)
+		memcpy(&fl6.saddr, params->saddr, sizeof(fl6.saddr));
 
-	dst = ip6_route_output(net, NULL, &fl6);
+	dst = ip6_route_output(params->net, NULL, &fl6);
 
 	err = dst->error;
 	if (dst->error) {
@@ -50,15 +48,14 @@ static struct dst_entry *xfrm6_dst_lookup(struct net *net, int tos, int oif,
 	return dst;
 }
 
-static int xfrm6_get_saddr(struct net *net, int oif,
-			   xfrm_address_t *saddr, xfrm_address_t *daddr,
-			   u32 mark)
+static int xfrm6_get_saddr(xfrm_address_t *saddr,
+			   const struct xfrm_dst_lookup_params *params)
 {
 	struct dst_entry *dst;
 	struct net_device *dev;
 	struct inet6_dev *idev;
 
-	dst = xfrm6_dst_lookup(net, 0, oif, NULL, daddr, mark);
+	dst = xfrm6_dst_lookup(params);
 	if (IS_ERR(dst))
 		return -EHOSTUNREACH;
 
@@ -68,7 +65,8 @@ static int xfrm6_get_saddr(struct net *net, int oif,
 		return -EHOSTUNREACH;
 	}
 	dev = idev->dev;
-	ipv6_dev_get_saddr(dev_net(dev), dev, &daddr->in6, 0, &saddr->in6);
+	ipv6_dev_get_saddr(dev_net(dev), dev, &params->daddr->in6, 0,
+			   &saddr->in6);
 	dst_release(dst);
 	return 0;
 }
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 8b8e957a69c36..4d13f7a372ab6 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -241,6 +241,8 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 
 	dev = dev_get_by_index(net, xuo->ifindex);
 	if (!dev) {
+		struct xfrm_dst_lookup_params params;
+
 		if (!(xuo->flags & XFRM_OFFLOAD_INBOUND)) {
 			saddr = &x->props.saddr;
 			daddr = &x->id.daddr;
@@ -249,9 +251,12 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 			daddr = &x->props.saddr;
 		}
 
-		dst = __xfrm_dst_lookup(net, 0, 0, saddr, daddr,
-					x->props.family,
-					xfrm_smark_get(0, x));
+		memset(&params, 0, sizeof(params));
+		params.net = net;
+		params.saddr = saddr;
+		params.daddr = daddr;
+		params.mark = xfrm_smark_get(0, x);
+		dst = __xfrm_dst_lookup(x->props.family, &params);
 		if (IS_ERR(dst))
 			return 0;
 
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index bc867d1905f52..ab6f5955aa9cf 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -251,10 +251,8 @@ static const struct xfrm_if_cb *xfrm_if_get_cb(void)
 	return rcu_dereference(xfrm_if_cb);
 }
 
-struct dst_entry *__xfrm_dst_lookup(struct net *net, int tos, int oif,
-				    const xfrm_address_t *saddr,
-				    const xfrm_address_t *daddr,
-				    int family, u32 mark)
+struct dst_entry *__xfrm_dst_lookup(int family,
+				    const struct xfrm_dst_lookup_params *params)
 {
 	const struct xfrm_policy_afinfo *afinfo;
 	struct dst_entry *dst;
@@ -263,7 +261,7 @@ struct dst_entry *__xfrm_dst_lookup(struct net *net, int tos, int oif,
 	if (unlikely(afinfo == NULL))
 		return ERR_PTR(-EAFNOSUPPORT);
 
-	dst = afinfo->dst_lookup(net, tos, oif, saddr, daddr, mark);
+	dst = afinfo->dst_lookup(params);
 
 	rcu_read_unlock();
 
@@ -277,6 +275,7 @@ static inline struct dst_entry *xfrm_dst_lookup(struct xfrm_state *x,
 						xfrm_address_t *prev_daddr,
 						int family, u32 mark)
 {
+	struct xfrm_dst_lookup_params params;
 	struct net *net = xs_net(x);
 	xfrm_address_t *saddr = &x->props.saddr;
 	xfrm_address_t *daddr = &x->id.daddr;
@@ -291,7 +290,14 @@ static inline struct dst_entry *xfrm_dst_lookup(struct xfrm_state *x,
 		daddr = x->coaddr;
 	}
 
-	dst = __xfrm_dst_lookup(net, tos, oif, saddr, daddr, family, mark);
+	params.net = net;
+	params.saddr = saddr;
+	params.daddr = daddr;
+	params.tos = tos;
+	params.oif = oif;
+	params.mark = mark;
+
+	dst = __xfrm_dst_lookup(family, &params);
 
 	if (!IS_ERR(dst)) {
 		if (prev_saddr != saddr)
@@ -2342,15 +2348,15 @@ int __xfrm_sk_clone_policy(struct sock *sk, const struct sock *osk)
 }
 
 static int
-xfrm_get_saddr(struct net *net, int oif, xfrm_address_t *local,
-	       xfrm_address_t *remote, unsigned short family, u32 mark)
+xfrm_get_saddr(unsigned short family, xfrm_address_t *saddr,
+	       const struct xfrm_dst_lookup_params *params)
 {
 	int err;
 	const struct xfrm_policy_afinfo *afinfo = xfrm_policy_get_afinfo(family);
 
 	if (unlikely(afinfo == NULL))
 		return -EINVAL;
-	err = afinfo->get_saddr(net, oif, local, remote, mark);
+	err = afinfo->get_saddr(saddr, params);
 	rcu_read_unlock();
 	return err;
 }
@@ -2379,9 +2385,14 @@ xfrm_tmpl_resolve_one(struct xfrm_policy *policy, const struct flowi *fl,
 			remote = &tmpl->id.daddr;
 			local = &tmpl->saddr;
 			if (xfrm_addr_any(local, tmpl->encap_family)) {
-				error = xfrm_get_saddr(net, fl->flowi_oif,
-						       &tmp, remote,
-						       tmpl->encap_family, 0);
+				struct xfrm_dst_lookup_params params;
+
+				memset(&params, 0, sizeof(params));
+				params.net = net;
+				params.oif = fl->flowi_oif;
+				params.daddr = remote;
+				error = xfrm_get_saddr(tmpl->encap_family, &tmp,
+						       &params);
 				if (error)
 					goto fail;
 				local = &tmp;
-- 
2.43.0


