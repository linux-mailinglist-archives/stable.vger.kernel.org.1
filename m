Return-Path: <stable+bounces-140098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D612CAAA4F3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29CC162FBD
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1615930916D;
	Mon,  5 May 2025 22:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0cEiWJr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F22309160;
	Mon,  5 May 2025 22:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484101; cv=none; b=keujwKvIZKxozZREp56VeWskZ15zydipqDoctbspURL7Y38nCbFLK3Dl8HHkeChYXvskMlhtCmLNJZwB9fJO10ZkAxiWQal967wk64mbUbbNUebUIU27WEZtmUKuIMn3wSz+DDBNmgnBPqxoLfLfO5gH+SqWWKnfNkDrd6asgpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484101; c=relaxed/simple;
	bh=CiudXCoaLhUhsdWhEEEvz/wFxDRaHTPScXpbuel7v40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ED8DOlMfFpsE5aQlIMbKkTCc//03SXCr7+tnoXW4oAHk9mBh31PZ7m7dqrGKJ8GKtB/5FOLsTOL6vWgTFC7E0gpuV4ELBdPNqWzjoaP+DX1kJ/WZ7OardesQZOxJyht1onrDvF/IEeX7s7Dqllu9P259N4DwX5tJP3r1LqSs5gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0cEiWJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4AFC4CEE4;
	Mon,  5 May 2025 22:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484101;
	bh=CiudXCoaLhUhsdWhEEEvz/wFxDRaHTPScXpbuel7v40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s0cEiWJrjSMZPMqLuFt3wsHVCgL2z+cTJufpxuWIuuy3LP0VJlPFmaB5y7Re+XPTW
	 nBeRpJkawMfCQ1FT93a+hjnp/mN6xZ1g4gtIQqRVxRvvcrditUw65sNXbE5rzTmR2H
	 w9uC5ATyhZiMCMOpQ92I5wTeLJNlFhLSatGHgYMDGuCUDw/tExxCkS7cUtK9UKany7
	 dtHndDmjx+qOim98Ly9nzwJxIophgt66OiVMebv7UjUbsAqZ7vhSaAqc8ce21DRT/n
	 rdrwPjPujkzmP1LTUfJ7YPubG6+OvVHQFtiRWuI/B7FGaEeGNRNzPooaDGUSKVU1we
	 KBXkZcYZndAgw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	steffen.klassert@secunet.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 351/642] net: ipv6: Init tunnel link-netns before registering dev
Date: Mon,  5 May 2025 18:09:27 -0400
Message-Id: <20250505221419.2672473-351-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Xiao Liang <shaw.leon@gmail.com>

[ Upstream commit db014522f35606031d8ac58b4aed6b1ed84f03d1 ]

Currently some IPv6 tunnel drivers set tnl->net to dev_net(dev) in
ndo_init(), which is called in register_netdevice(). However, it lacks
the context of link-netns when we enable cross-net tunnels at device
registration time.

Let's move the init of tunnel link-netns before register_netdevice().

ip6_gre has already initialized netns, so just remove the redundant
assignment.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://patch.msgid.link/20250219125039.18024-8-shaw.leon@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6_gre.c    | 2 --
 net/ipv6/ip6_tunnel.c | 3 ++-
 net/ipv6/ip6_vti.c    | 3 ++-
 net/ipv6/sit.c        | 8 +++++---
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 235808cfec705..68e9a41eed491 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1498,7 +1498,6 @@ static int ip6gre_tunnel_init_common(struct net_device *dev)
 	tunnel = netdev_priv(dev);
 
 	tunnel->dev = dev;
-	tunnel->net = dev_net(dev);
 	strcpy(tunnel->parms.name, dev->name);
 
 	ret = dst_cache_init(&tunnel->dst_cache, GFP_KERNEL);
@@ -1882,7 +1881,6 @@ static int ip6erspan_tap_init(struct net_device *dev)
 	tunnel = netdev_priv(dev);
 
 	tunnel->dev = dev;
-	tunnel->net = dev_net(dev);
 	strcpy(tunnel->parms.name, dev->name);
 
 	ret = dst_cache_init(&tunnel->dst_cache, GFP_KERNEL);
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 48fd53b989726..5350c9bb2319b 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1878,7 +1878,6 @@ ip6_tnl_dev_init_gen(struct net_device *dev)
 	int t_hlen;
 
 	t->dev = dev;
-	t->net = dev_net(dev);
 
 	ret = dst_cache_init(&t->dst_cache, GFP_KERNEL);
 	if (ret)
@@ -1940,6 +1939,7 @@ static int __net_init ip6_fb_tnl_dev_init(struct net_device *dev)
 	struct net *net = dev_net(dev);
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 
+	t->net = net;
 	t->parms.proto = IPPROTO_IPV6;
 
 	rcu_assign_pointer(ip6n->tnls_wc[0], t);
@@ -2013,6 +2013,7 @@ static int ip6_tnl_newlink(struct net *src_net, struct net_device *dev,
 	int err;
 
 	nt = netdev_priv(dev);
+	nt->net = net;
 
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		err = ip6_tnl_encap_setup(nt, &ipencap);
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 590737c275379..0123504691443 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -925,7 +925,6 @@ static inline int vti6_dev_init_gen(struct net_device *dev)
 	struct ip6_tnl *t = netdev_priv(dev);
 
 	t->dev = dev;
-	t->net = dev_net(dev);
 	netdev_hold(dev, &t->dev_tracker, GFP_KERNEL);
 	netdev_lockdep_set_classes(dev);
 	return 0;
@@ -958,6 +957,7 @@ static int __net_init vti6_fb_tnl_dev_init(struct net_device *dev)
 	struct net *net = dev_net(dev);
 	struct vti6_net *ip6n = net_generic(net, vti6_net_id);
 
+	t->net = net;
 	t->parms.proto = IPPROTO_IPV6;
 
 	rcu_assign_pointer(ip6n->tnls_wc[0], t);
@@ -1008,6 +1008,7 @@ static int vti6_newlink(struct net *src_net, struct net_device *dev,
 	vti6_netlink_parms(data, &nt->parms);
 
 	nt->parms.proto = IPPROTO_IPV6;
+	nt->net = net;
 
 	if (vti6_locate(net, &nt->parms, 0))
 		return -EEXIST;
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 39bd8951bfca1..3c15a0ae228e2 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -269,6 +269,7 @@ static struct ip_tunnel *ipip6_tunnel_locate(struct net *net,
 
 	nt = netdev_priv(dev);
 
+	nt->net = net;
 	nt->parms = *parms;
 	if (ipip6_tunnel_create(dev) < 0)
 		goto failed_free;
@@ -1449,7 +1450,6 @@ static int ipip6_tunnel_init(struct net_device *dev)
 	int err;
 
 	tunnel->dev = dev;
-	tunnel->net = dev_net(dev);
 	strcpy(tunnel->parms.name, dev->name);
 
 	ipip6_tunnel_bind_dev(dev);
@@ -1563,6 +1563,7 @@ static int ipip6_newlink(struct net *src_net, struct net_device *dev,
 	int err;
 
 	nt = netdev_priv(dev);
+	nt->net = net;
 
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		err = ip_tunnel_encap_setup(nt, &ipencap);
@@ -1858,6 +1859,9 @@ static int __net_init sit_init_net(struct net *net)
 	 */
 	sitn->fb_tunnel_dev->netns_local = true;
 
+	t = netdev_priv(sitn->fb_tunnel_dev);
+	t->net = net;
+
 	err = register_netdev(sitn->fb_tunnel_dev);
 	if (err)
 		goto err_reg_dev;
@@ -1865,8 +1869,6 @@ static int __net_init sit_init_net(struct net *net)
 	ipip6_tunnel_clone_6rd(sitn->fb_tunnel_dev, sitn);
 	ipip6_fb_tunnel_init(sitn->fb_tunnel_dev);
 
-	t = netdev_priv(sitn->fb_tunnel_dev);
-
 	strcpy(t->parms.name, sitn->fb_tunnel_dev->name);
 	return 0;
 
-- 
2.39.5


