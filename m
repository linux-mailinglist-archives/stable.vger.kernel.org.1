Return-Path: <stable+bounces-62381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 837EA93EEFF
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20AB1C21C01
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 07:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A4012C554;
	Mon, 29 Jul 2024 07:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a53wQQbt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854CF84A2F
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239418; cv=none; b=QbuMgwxcVP35P00KYsixSeE+QBuCaLL3wvThqPWZFWjHGQgrSTP6e1CziNTNvGWh5KV9NO5HiFmzfSm2657ONTVFHaf42bHVwRUt5/8UXP3OPv+7a3ubg25qiEzF25Z11QmXHuKd1Pvk55ja+XEIjAe+Z1c1uxxR4OLu5nA6gig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239418; c=relaxed/simple;
	bh=9SV7Ki0FH0aqw2UtHk30Y1Iz5a8XT0g3IfdZrXEi4NA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Bi4EETNU8+nWN4T+GXsHJ+HxIIr2I2K5tjeYstCJBkuTzkGRmrhPEHzyiRir11kKtcf8yQBVBKjdPlkHncWGxrcXH5iWdCiguGTzep8mqFHiFTz2klSWqjiZ26EvO0gGM+Kk6Df1C9EpXLoAU7p+E9sLEbtKmecWXyK2WHkINQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a53wQQbt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA85C32786;
	Mon, 29 Jul 2024 07:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722239418;
	bh=9SV7Ki0FH0aqw2UtHk30Y1Iz5a8XT0g3IfdZrXEi4NA=;
	h=Subject:To:Cc:From:Date:From;
	b=a53wQQbt4kjmp9uvNB+FB77QERjYHXuCHRdy6fcgRq+c8csKasA6tJfHQ1z1RQ1m0
	 BKzlg8DNzR888ydsOBUjFvPsS2AvNWJCmEHkezWdmKan+6SuCrKW1W4Rd0U91ZUz/g
	 x9Ox/7S2Lmvz4YAMIO1edyFuIYOCOvptZgsJttps=
Subject: FAILED: patch "[PATCH] ipv6: fix source address selection with route leak" failed to apply to 5.15-stable tree
To: nicolas.dichtel@6wind.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 09:50:08 +0200
Message-ID: <2024072908-clicker-cornball-8a64@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 252442f2ae317d109ef0b4b39ce0608c09563042
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072908-clicker-cornball-8a64@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

252442f2ae31 ("ipv6: fix source address selection with route leak")
fa17a6d8a5bd ("ipv6: lockless IPV6_ADDR_PREFERENCES implementation")
859f8b265fc2 ("ipv6: lockless IPV6_FLOWINFO_SEND implementation")
6b724bc4300b ("ipv6: lockless IPV6_MTU_DISCOVER implementation")
83cd5eb654b3 ("ipv6: lockless IPV6_ROUTER_ALERT_ISOLATE implementation")
3cccda8db2cf ("ipv6: move np->repflow to atomic flags")
3fa29971c695 ("ipv6: lockless IPV6_RECVERR implemetation")
1086ca7cce29 ("ipv6: lockless IPV6_DONTFRAG implementation")
5121516b0c47 ("ipv6: lockless IPV6_AUTOFLOWLABEL implementation")
6559c0ff3bc2 ("ipv6: lockless IPV6_MULTICAST_ALL implementation")
dcae74622c05 ("ipv6: lockless IPV6_RECVERR_RFC4884 implementation")
273784d3c574 ("ipv6: lockless IPV6_MINHOPCOUNT implementation")
15f926c4457a ("ipv6: lockless IPV6_MTU implementation")
2da23eb07c91 ("ipv6: lockless IPV6_MULTICAST_HOPS implementation")
d986f52124e0 ("ipv6: lockless IPV6_MULTICAST_LOOP implementation")
b0adfba7ee77 ("ipv6: lockless IPV6_UNICAST_HOPS implementation")
8cdd9f1aaedf ("ipv6: fix ip6_sock_set_addr_preferences() typo")
e3390b30a5df ("net: annotate data-races around sk->sk_tsflags")
0f158b32a9b1 ("net: selectively purge error queue in IP_RECVERR / IPV6_RECVERR")
08e39c0dfa29 ("inet: move inet->defer_connect to inet->inet_flags")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 252442f2ae317d109ef0b4b39ce0608c09563042 Mon Sep 17 00:00:00 2001
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Wed, 10 Jul 2024 10:14:28 +0200
Subject: [PATCH] ipv6: fix source address selection with route leak

By default, an address assigned to the output interface is selected when
the source address is not specified. This is problematic when a route,
configured in a vrf, uses an interface from another vrf (aka route leak).
The original vrf does not own the selected source address.

Let's add a check against the output interface and call the appropriate
function to select the source address.

CC: stable@vger.kernel.org
Fixes: 0d240e7811c4 ("net: vrf: Implement get_saddr for IPv6")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Link: https://patch.msgid.link/20240710081521.3809742-3-nicolas.dichtel@6wind.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index a18ed24fed94..6dbdf60b342f 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -127,18 +127,26 @@ void rt6_age_exceptions(struct fib6_info *f6i, struct fib6_gc_args *gc_args,
 
 static inline int ip6_route_get_saddr(struct net *net, struct fib6_info *f6i,
 				      const struct in6_addr *daddr,
-				      unsigned int prefs,
+				      unsigned int prefs, int l3mdev_index,
 				      struct in6_addr *saddr)
 {
+	struct net_device *l3mdev;
+	struct net_device *dev;
+	bool same_vrf;
 	int err = 0;
 
-	if (f6i && f6i->fib6_prefsrc.plen) {
-		*saddr = f6i->fib6_prefsrc.addr;
-	} else {
-		struct net_device *dev = f6i ? fib6_info_nh_dev(f6i) : NULL;
+	rcu_read_lock();
 
-		err = ipv6_dev_get_saddr(net, dev, daddr, prefs, saddr);
-	}
+	l3mdev = dev_get_by_index_rcu(net, l3mdev_index);
+	if (!f6i || !f6i->fib6_prefsrc.plen || l3mdev)
+		dev = f6i ? fib6_info_nh_dev(f6i) : NULL;
+	same_vrf = !l3mdev || l3mdev_master_dev_rcu(dev) == l3mdev;
+	if (f6i && f6i->fib6_prefsrc.plen && same_vrf)
+		*saddr = f6i->fib6_prefsrc.addr;
+	else
+		err = ipv6_dev_get_saddr(net, same_vrf ? dev : l3mdev, daddr, prefs, saddr);
+
+	rcu_read_unlock();
 
 	return err;
 }
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 27d8725445e3..784424ac4147 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1124,6 +1124,7 @@ static int ip6_dst_lookup_tail(struct net *net, const struct sock *sk,
 		from = rt ? rcu_dereference(rt->from) : NULL;
 		err = ip6_route_get_saddr(net, from, &fl6->daddr,
 					  sk ? READ_ONCE(inet6_sk(sk)->srcprefs) : 0,
+					  fl6->flowi6_l3mdev,
 					  &fl6->saddr);
 		rcu_read_unlock();
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 8d72ca0b086d..c9a9506b714d 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5689,7 +5689,7 @@ static int rt6_fill_node(struct net *net, struct sk_buff *skb,
 				goto nla_put_failure;
 	} else if (dest) {
 		struct in6_addr saddr_buf;
-		if (ip6_route_get_saddr(net, rt, dest, 0, &saddr_buf) == 0 &&
+		if (ip6_route_get_saddr(net, rt, dest, 0, 0, &saddr_buf) == 0 &&
 		    nla_put_in6_addr(skb, RTA_PREFSRC, &saddr_buf))
 			goto nla_put_failure;
 	}


