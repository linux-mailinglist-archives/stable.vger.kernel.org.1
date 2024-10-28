Return-Path: <stable+bounces-89030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98F99B2DEA
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 12:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCE701C21853
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D882B1F4264;
	Mon, 28 Oct 2024 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XILLDi+k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AA01DA113;
	Mon, 28 Oct 2024 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112775; cv=none; b=fvSDKWFfLGlY40y2RXQTRk31JPWUdykWfYAj0TDfQFA0mozymqSdy3HX4baONIXpcDgQHzwm3u5vMaaDxW1VE5uWEmBuLo7Z0VjCVDmIgA1e8pI5E0rc4Bc3BFCL9zGNGVbQv67KE/cUCElGXnBKoF9Z1NvJ7TeUJ6SNPA9heAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112775; c=relaxed/simple;
	bh=/B0j9pDYqTGK8Hk5AVckLIHAlE2EFcx+K8KdaBOzM8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fWrhyw3DcQF8OK6gJyTT1efgvre0hGps84x3ScBOeDhWAN+TKoUxvXDd4s/3VhX+lziPCV5rLxeeJ7b77b9OyWKj39B2KT+2jKKUP0U/l9ZdrD0eYeA0/lJVhesexa2G8tv9576bM6wTvwV2ewen6bikQZscl3yhIHpQK1dlV+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XILLDi+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25818C4CEC3;
	Mon, 28 Oct 2024 10:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112775;
	bh=/B0j9pDYqTGK8Hk5AVckLIHAlE2EFcx+K8KdaBOzM8o=;
	h=From:To:Cc:Subject:Date:From;
	b=XILLDi+k1J6tcy3GLUuaM3zLG+JCI7FoNT9aQyvevW3djimVAb2X52iRxOJ8M+DgH
	 IR58R4YOrF8eq0wBBCb/Xf4kHWsKp6iH+YoqHGNxIGdYUyhhy9r2Z6r+HWVddRpg7t
	 ct/n7yDdDsQurCmmaOdEh+HpmA0FqGZwIbAwxmzEShyJaCxrxwzSQ3oBGI6ElSML7K
	 t3T9DOpOoH9PmheNKV22gIwilVSU3qhBm5B2gy+xJ4Pfma7i9oFWUi/W/eWDex/KHn
	 ZevlOZ8sBDMUQngm1iikKd1GOgWA4Twer/t3oXKNTRZ7vvE4SyNRK08NJZl9RnffzN
	 iD7Nxm/qu4CMA==
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
Subject: [PATCH AUTOSEL 6.1 1/8] xfrm: extract dst lookup parameters into a struct
Date: Mon, 28 Oct 2024 06:52:42 -0400
Message-ID: <20241028105252.3560220-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.114
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
index 5b9c2c535702c..55ea15ccd5327 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -326,20 +326,23 @@ struct xfrm_if_cb {
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
@@ -1659,10 +1662,7 @@ static inline int xfrm_user_policy(struct sock *sk, int optname,
 }
 #endif
 
-struct dst_entry *__xfrm_dst_lookup(struct net *net, int tos, int oif,
-				    const xfrm_address_t *saddr,
-				    const xfrm_address_t *daddr,
-				    int family, u32 mark);
+struct dst_entry *__xfrm_dst_lookup(int family, const struct xfrm_dst_lookup_params *params);
 
 struct xfrm_policy *xfrm_policy_alloc(struct net *net, gfp_t gfp);
 
diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
index 3d0dfa6cf9f96..9ac9ed9738068 100644
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
index b7b5dbf5d037b..6e3e0f1bd81c9 100644
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
index 21269e8f2db4b..2535ee034a5c8 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -248,6 +248,8 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 
 	dev = dev_get_by_index(net, xuo->ifindex);
 	if (!dev) {
+		struct xfrm_dst_lookup_params params;
+
 		if (!(xuo->flags & XFRM_OFFLOAD_INBOUND)) {
 			saddr = &x->props.saddr;
 			daddr = &x->id.daddr;
@@ -256,9 +258,12 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
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
index 5fddde2d5bc48..adb12f428be30 100644
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
@@ -2346,15 +2352,15 @@ int __xfrm_sk_clone_policy(struct sock *sk, const struct sock *osk)
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
@@ -2383,9 +2389,14 @@ xfrm_tmpl_resolve_one(struct xfrm_policy *policy, const struct flowi *fl,
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


