Return-Path: <stable+bounces-99649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF779E72B6
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10A716CD16
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1299720A5E5;
	Fri,  6 Dec 2024 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TgrkA0ES"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3801FCD11;
	Fri,  6 Dec 2024 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497890; cv=none; b=r2qdoNoQPXrmDLiQXvvuDaOUoIqHO61a4hJtDn/iGjzSBIn389pNU0icp4aclw3GMQhDWtcyyU1NeZ5H0S72CgRnZlO+3GpHbY5Uy+kSYu2h/xrNX/ZE0eQnWnorrFupgxQymPkBnSLx8LNOl0XhcrstA0EvgaYBXUg6HtvPHMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497890; c=relaxed/simple;
	bh=3M51tVg1eofobdrYcnzy9PXqzaVzEUYmudaG/8H4h60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+xBFRJG6ej2ZfYVlUPBWGe3BddSxU+iZO8dZByyo+1wZ1U+RJdXY7J8HXn9mg2ydvnuzhByehYXOmVQsE3SGGNY13GepPiPIM75mM5pTWmIeiNCDdE1FWrZOdU8rg5nAcost8geJYeD3BkvZOL2thyEc6kgPqm85AFaCmIQCMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TgrkA0ES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B54AC4CEDC;
	Fri,  6 Dec 2024 15:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733497890;
	bh=3M51tVg1eofobdrYcnzy9PXqzaVzEUYmudaG/8H4h60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TgrkA0ES37sseBYzgaIVy0xCpu3nfA/dvJI6coJlBqzwRb555Kri7LazIN6sGL/8I
	 AKoOXp6h32bLN4FE32SSH8PSoGyGvY2rE6xojnBmxkiMttuPH+on5wa7BlCFltlWya
	 GPyhVPgq1RXbanNE+Db/36ZJrx2VELuzHxWJWQ9U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Ahern <dsahern@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 424/676] ip6mr: fix tables suspicious RCU usage
Date: Fri,  6 Dec 2024 15:34:03 +0100
Message-ID: <20241206143709.905884398@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit f1553c9894b4dbeb10a2ab15ab1aa113b3b4047c ]

Several places call ip6mr_get_table() with no RCU nor RTNL lock.
Add RCU protection inside such helper and provide a lockless variant
for the few callers that already acquired the relevant lock.

Note that some users additionally reference the table outside the RCU
lock. That is actually safe as the table deletion can happen only
after all table accesses are completed.

Fixes: e2d57766e674 ("net: Provide compat support for SIOCGETMIFCNT_IN6 and SIOCGETSGCNT_IN6.")
Fixes: d7c31cbde4bc ("net: ip6mr: add RTM_GETROUTE netlink op")
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6mr.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 30ca064b76ef1..e24fa0843c7d1 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -125,7 +125,7 @@ static struct mr_table *ip6mr_mr_table_iter(struct net *net,
 	return ret;
 }
 
-static struct mr_table *ip6mr_get_table(struct net *net, u32 id)
+static struct mr_table *__ip6mr_get_table(struct net *net, u32 id)
 {
 	struct mr_table *mrt;
 
@@ -136,6 +136,16 @@ static struct mr_table *ip6mr_get_table(struct net *net, u32 id)
 	return NULL;
 }
 
+static struct mr_table *ip6mr_get_table(struct net *net, u32 id)
+{
+	struct mr_table *mrt;
+
+	rcu_read_lock();
+	mrt = __ip6mr_get_table(net, id);
+	rcu_read_unlock();
+	return mrt;
+}
+
 static int ip6mr_fib_lookup(struct net *net, struct flowi6 *flp6,
 			    struct mr_table **mrt)
 {
@@ -177,7 +187,7 @@ static int ip6mr_rule_action(struct fib_rule *rule, struct flowi *flp,
 
 	arg->table = fib_rule_get_table(rule, arg);
 
-	mrt = ip6mr_get_table(rule->fr_net, arg->table);
+	mrt = __ip6mr_get_table(rule->fr_net, arg->table);
 	if (!mrt)
 		return -EAGAIN;
 	res->mrt = mrt;
@@ -304,6 +314,8 @@ static struct mr_table *ip6mr_get_table(struct net *net, u32 id)
 	return net->ipv6.mrt6;
 }
 
+#define __ip6mr_get_table ip6mr_get_table
+
 static int ip6mr_fib_lookup(struct net *net, struct flowi6 *flp6,
 			    struct mr_table **mrt)
 {
@@ -382,7 +394,7 @@ static struct mr_table *ip6mr_new_table(struct net *net, u32 id)
 {
 	struct mr_table *mrt;
 
-	mrt = ip6mr_get_table(net, id);
+	mrt = __ip6mr_get_table(net, id);
 	if (mrt)
 		return mrt;
 
@@ -411,13 +423,15 @@ static void *ip6mr_vif_seq_start(struct seq_file *seq, loff_t *pos)
 	struct net *net = seq_file_net(seq);
 	struct mr_table *mrt;
 
-	mrt = ip6mr_get_table(net, RT6_TABLE_DFLT);
-	if (!mrt)
+	rcu_read_lock();
+	mrt = __ip6mr_get_table(net, RT6_TABLE_DFLT);
+	if (!mrt) {
+		rcu_read_unlock();
 		return ERR_PTR(-ENOENT);
+	}
 
 	iter->mrt = mrt;
 
-	rcu_read_lock();
 	return mr_vif_seq_start(seq, pos);
 }
 
@@ -2278,11 +2292,13 @@ int ip6mr_get_route(struct net *net, struct sk_buff *skb, struct rtmsg *rtm,
 	struct mfc6_cache *cache;
 	struct rt6_info *rt = (struct rt6_info *)skb_dst(skb);
 
-	mrt = ip6mr_get_table(net, RT6_TABLE_DFLT);
-	if (!mrt)
+	rcu_read_lock();
+	mrt = __ip6mr_get_table(net, RT6_TABLE_DFLT);
+	if (!mrt) {
+		rcu_read_unlock();
 		return -ENOENT;
+	}
 
-	rcu_read_lock();
 	cache = ip6mr_cache_find(mrt, &rt->rt6i_src.addr, &rt->rt6i_dst.addr);
 	if (!cache && skb->dev) {
 		int vif = ip6mr_find_vif(mrt, skb->dev);
@@ -2563,7 +2579,7 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		grp = nla_get_in6_addr(tb[RTA_DST]);
 	tableid = tb[RTA_TABLE] ? nla_get_u32(tb[RTA_TABLE]) : 0;
 
-	mrt = ip6mr_get_table(net, tableid ?: RT_TABLE_DEFAULT);
+	mrt = __ip6mr_get_table(net, tableid ?: RT_TABLE_DEFAULT);
 	if (!mrt) {
 		NL_SET_ERR_MSG_MOD(extack, "MR table does not exist");
 		return -ENOENT;
@@ -2608,7 +2624,7 @@ static int ip6mr_rtm_dumproute(struct sk_buff *skb, struct netlink_callback *cb)
 	if (filter.table_id) {
 		struct mr_table *mrt;
 
-		mrt = ip6mr_get_table(sock_net(skb->sk), filter.table_id);
+		mrt = __ip6mr_get_table(sock_net(skb->sk), filter.table_id);
 		if (!mrt) {
 			if (rtnl_msg_family(cb->nlh) != RTNL_FAMILY_IP6MR)
 				return skb->len;
-- 
2.43.0




