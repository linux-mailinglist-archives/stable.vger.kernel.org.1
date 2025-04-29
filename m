Return-Path: <stable+bounces-138381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8622BAA17C7
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73E54C5F91
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77334253949;
	Tue, 29 Apr 2025 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ybAeFssN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B4825393F;
	Tue, 29 Apr 2025 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949065; cv=none; b=IPqbIYVUlKIa4o3VP4cgkjAyph4pV8PBhfa1tSnfIpWGbJGUdrY1sR247VMZWd4rCg31rGQWHBssMdf4f6LpR7Kp9yTu5762ng8izlyzqK8wm+DAdcX3bKCXz6KjJE/PpYWPohgFiSpYkYUOiCKpXF/GDhFE1aaWe+6Ht1Vhuyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949065; c=relaxed/simple;
	bh=wTD+AZaHWYLgycpG0MmeHb4DKma3YNjtiJr44/QqZzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uU+sscHEcX3q7PNXVchkIWBjF1l32fQyPggUcU54T6HnThdUnRQRaBNlWQauaAyiX4DepPk/PpN/yE7hncxEQZ1rFQlIsM0VyqW6u8SnQ1UvF4e+6dgI1e+Y93Vi9/Wb7GnmnzRJtNDMm63P51FFm9yqzUDyt7OU4bmn5frgot8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ybAeFssN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FA3C4CEE9;
	Tue, 29 Apr 2025 17:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745949065;
	bh=wTD+AZaHWYLgycpG0MmeHb4DKma3YNjtiJr44/QqZzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ybAeFssNLnS82sccIpzkLtyTUSgAtvSKxRfJAtMxv1Btm1GYlt0I9WjOxPstAP4Kf
	 snE933NFznaCtXRyJqItasyxcjwH3PFJnfDLm8GZvK3dq/BiCZD5ScKZbwWyNn9jY9
	 ewcdqBnwD4YyMzzZ2yH0tFgBPJmJ/imXw3gCWzjk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15 203/373] ipv6: release nexthop on device removal
Date: Tue, 29 Apr 2025 18:41:20 +0200
Message-ID: <20250429161131.514501753@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit eb02688c5c45c3e7af7e71f036a7144f5639cbfe ]

The CI is hitting some aperiodic hangup at device removal time in the
pmtu.sh self-test:

unregister_netdevice: waiting for veth_A-R1 to become free. Usage count = 6
ref_tracker: veth_A-R1@ffff888013df15d8 has 1/5 users at
	dst_init+0x84/0x4a0
	dst_alloc+0x97/0x150
	ip6_dst_alloc+0x23/0x90
	ip6_rt_pcpu_alloc+0x1e6/0x520
	ip6_pol_route+0x56f/0x840
	fib6_rule_lookup+0x334/0x630
	ip6_route_output_flags+0x259/0x480
	ip6_dst_lookup_tail.constprop.0+0x5c2/0x940
	ip6_dst_lookup_flow+0x88/0x190
	udp_tunnel6_dst_lookup+0x2a7/0x4c0
	vxlan_xmit_one+0xbde/0x4a50 [vxlan]
	vxlan_xmit+0x9ad/0xf20 [vxlan]
	dev_hard_start_xmit+0x10e/0x360
	__dev_queue_xmit+0xf95/0x18c0
	arp_solicit+0x4a2/0xe00
	neigh_probe+0xaa/0xf0

While the first suspect is the dst_cache, explicitly tracking the dst
owing the last device reference via probes proved such dst is held by
the nexthop in the originating fib6_info.

Similar to commit f5b51fe804ec ("ipv6: route: purge exception on
removal"), we need to explicitly release the originating fib info when
disconnecting a to-be-removed device from a live ipv6 dst: move the
fib6_info cleanup into ip6_dst_ifdown().

Tested running:

./pmtu.sh cleanup_ipv6_exception

in a tight loop for more than 400 iterations with no spat, running an
unpatched kernel  I observed a splat every ~10 iterations.

Fixes: f88d8ea67fbd ("ipv6: Plumb support for nexthop object in a fib6_info")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/604c45c188c609b732286b47ac2a451a40f6cf6d.1730828007.git.pabeni@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit eb02688c5c45c3e7af7e71f036a7144f5639cbfe)
[Harshit: Resolved conflict due to missing commit: e5f80fcf869a ("ipv6:
give an IPv6 dev to blackhole_netdev") and commit: b4cb4a1391dc ("net:
use unrcu_pointer() helper") in linux-5.15.y]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -377,6 +377,7 @@ static void ip6_dst_ifdown(struct dst_en
 	struct inet6_dev *idev = rt->rt6i_idev;
 	struct net_device *loopback_dev =
 		dev_net(dev)->loopback_dev;
+	struct fib6_info *from;
 
 	if (idev && idev->dev != loopback_dev) {
 		struct inet6_dev *loopback_idev = in6_dev_get(loopback_dev);
@@ -385,6 +386,8 @@ static void ip6_dst_ifdown(struct dst_en
 			in6_dev_put(idev);
 		}
 	}
+	from = xchg((__force struct fib6_info **)&rt->from, NULL);
+	fib6_info_release(from);
 }
 
 static bool __rt6_check_expired(const struct rt6_info *rt)
@@ -1443,7 +1446,6 @@ static DEFINE_SPINLOCK(rt6_exception_loc
 static void rt6_remove_exception(struct rt6_exception_bucket *bucket,
 				 struct rt6_exception *rt6_ex)
 {
-	struct fib6_info *from;
 	struct net *net;
 
 	if (!bucket || !rt6_ex)
@@ -1455,8 +1457,6 @@ static void rt6_remove_exception(struct
 	/* purge completely the exception to allow releasing the held resources:
 	 * some [sk] cache may keep the dst around for unlimited time
 	 */
-	from = xchg((__force struct fib6_info **)&rt6_ex->rt6i->from, NULL);
-	fib6_info_release(from);
 	dst_dev_put(&rt6_ex->rt6i->dst);
 
 	hlist_del_rcu(&rt6_ex->hlist);



