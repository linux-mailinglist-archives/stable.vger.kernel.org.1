Return-Path: <stable+bounces-112584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FC7A28D73
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7B81677B6
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082B62E634;
	Wed,  5 Feb 2025 14:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pbPdgRMO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B969C1519AA;
	Wed,  5 Feb 2025 14:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738764060; cv=none; b=EuvoK4do4gM6tAN/wmNSN6t7UeUQZekwrXU4zXrFUewdOF+3q5JUCPr4Xwb7OczEJYXZBxLVkqj4+lKLA+eU5w3SXxjvC/CE9GwVWjtrl5o1UPCEIOEWL6KsvKpisCb4URXNd/mc5JyH2D3hs5kmq9hVjlJgo/m75JeeEq4fDrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738764060; c=relaxed/simple;
	bh=9JhKKlIQNKviHyobQDFmpBpz+ixJJipUTloDHbrYWGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3svNOVj1sKZPiBvZ6DUdIh8brxoLlYEFoa7vFawMV8phs67f9gZ4V7mzP7aTSwddXxJ6EV0Fr1bEgNGNanSy+qqLLOHXhbRgOf3zgoxmtIFsUmkhfGXIXXYj1949pPn6tnR6udBY7PBE2E5zmXUmhdg1hgEmrf8gZ7SlBWG9Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pbPdgRMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE96C4CED1;
	Wed,  5 Feb 2025 14:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738764060;
	bh=9JhKKlIQNKviHyobQDFmpBpz+ixJJipUTloDHbrYWGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pbPdgRMO9pZ7Qmi1dM0h6v0YkAzOBBufUQdaHzWSK/rA5iQqo73f8g0CL/6XEmcwq
	 jV1+K9Zavg+/iEdMTFILTWdlEtBTBoX85ryjK4OjWvOLg32d2B8c4uqtjM/9ghrTh/
	 +t0WBOdkEU8osmuxsE8lRVBc+4XloMo9ZljSxY2A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 136/393] inet: ipmr: fix data-races
Date: Wed,  5 Feb 2025 14:40:55 +0100
Message-ID: <20250205134425.504206509@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
References: <20250205134420.279368572@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 3440fa34ad99d471f1085bc2f4dedeaebc310261 ]

Following fields of 'struct mr_mfc' can be updated
concurrently (no lock protection) from ip_mr_forward()
and ip6_mr_forward()

- bytes
- pkt
- wrong_if
- lastuse

They also can be read from other functions.

Convert bytes, pkt and wrong_if to atomic_long_t,
and use READ_ONCE()/WRITE_ONCE() for lastuse.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20250114221049.1190631-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_mr.c |  8 +++---
 include/linux/mroute_base.h                   |  6 ++--
 net/ipv4/ipmr.c                               | 28 +++++++++----------
 net/ipv4/ipmr_base.c                          |  6 ++--
 net/ipv6/ip6mr.c                              | 28 +++++++++----------
 5 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c
index 69cd689dbc83e..5afe6b155ef0d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c
@@ -1003,10 +1003,10 @@ static void mlxsw_sp_mr_route_stats_update(struct mlxsw_sp *mlxsw_sp,
 	mr->mr_ops->route_stats(mlxsw_sp, mr_route->route_priv, &packets,
 				&bytes);
 
-	if (mr_route->mfc->mfc_un.res.pkt != packets)
-		mr_route->mfc->mfc_un.res.lastuse = jiffies;
-	mr_route->mfc->mfc_un.res.pkt = packets;
-	mr_route->mfc->mfc_un.res.bytes = bytes;
+	if (atomic_long_read(&mr_route->mfc->mfc_un.res.pkt) != packets)
+		WRITE_ONCE(mr_route->mfc->mfc_un.res.lastuse, jiffies);
+	atomic_long_set(&mr_route->mfc->mfc_un.res.pkt, packets);
+	atomic_long_set(&mr_route->mfc->mfc_un.res.bytes, bytes);
 }
 
 static void mlxsw_sp_mr_stats_update(struct work_struct *work)
diff --git a/include/linux/mroute_base.h b/include/linux/mroute_base.h
index 9dd4bf1572553..58a2401e4b551 100644
--- a/include/linux/mroute_base.h
+++ b/include/linux/mroute_base.h
@@ -146,9 +146,9 @@ struct mr_mfc {
 			unsigned long last_assert;
 			int minvif;
 			int maxvif;
-			unsigned long bytes;
-			unsigned long pkt;
-			unsigned long wrong_if;
+			atomic_long_t bytes;
+			atomic_long_t pkt;
+			atomic_long_t wrong_if;
 			unsigned long lastuse;
 			unsigned char ttls[MAXVIFS];
 			refcount_t refcount;
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index dc0ad979a894a..af9412a507cf3 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -816,7 +816,7 @@ static void ipmr_update_thresholds(struct mr_table *mrt, struct mr_mfc *cache,
 				cache->mfc_un.res.maxvif = vifi + 1;
 		}
 	}
-	cache->mfc_un.res.lastuse = jiffies;
+	WRITE_ONCE(cache->mfc_un.res.lastuse, jiffies);
 }
 
 static int vif_add(struct net *net, struct mr_table *mrt,
@@ -1666,9 +1666,9 @@ int ipmr_ioctl(struct sock *sk, int cmd, void *arg)
 		rcu_read_lock();
 		c = ipmr_cache_find(mrt, sr->src.s_addr, sr->grp.s_addr);
 		if (c) {
-			sr->pktcnt = c->_c.mfc_un.res.pkt;
-			sr->bytecnt = c->_c.mfc_un.res.bytes;
-			sr->wrong_if = c->_c.mfc_un.res.wrong_if;
+			sr->pktcnt = atomic_long_read(&c->_c.mfc_un.res.pkt);
+			sr->bytecnt = atomic_long_read(&c->_c.mfc_un.res.bytes);
+			sr->wrong_if = atomic_long_read(&c->_c.mfc_un.res.wrong_if);
 			rcu_read_unlock();
 			return 0;
 		}
@@ -1738,9 +1738,9 @@ int ipmr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 		rcu_read_lock();
 		c = ipmr_cache_find(mrt, sr.src.s_addr, sr.grp.s_addr);
 		if (c) {
-			sr.pktcnt = c->_c.mfc_un.res.pkt;
-			sr.bytecnt = c->_c.mfc_un.res.bytes;
-			sr.wrong_if = c->_c.mfc_un.res.wrong_if;
+			sr.pktcnt = atomic_long_read(&c->_c.mfc_un.res.pkt);
+			sr.bytecnt = atomic_long_read(&c->_c.mfc_un.res.bytes);
+			sr.wrong_if = atomic_long_read(&c->_c.mfc_un.res.wrong_if);
 			rcu_read_unlock();
 
 			if (copy_to_user(arg, &sr, sizeof(sr)))
@@ -1973,9 +1973,9 @@ static void ip_mr_forward(struct net *net, struct mr_table *mrt,
 	int vif, ct;
 
 	vif = c->_c.mfc_parent;
-	c->_c.mfc_un.res.pkt++;
-	c->_c.mfc_un.res.bytes += skb->len;
-	c->_c.mfc_un.res.lastuse = jiffies;
+	atomic_long_inc(&c->_c.mfc_un.res.pkt);
+	atomic_long_add(skb->len, &c->_c.mfc_un.res.bytes);
+	WRITE_ONCE(c->_c.mfc_un.res.lastuse, jiffies);
 
 	if (c->mfc_origin == htonl(INADDR_ANY) && true_vifi >= 0) {
 		struct mfc_cache *cache_proxy;
@@ -2006,7 +2006,7 @@ static void ip_mr_forward(struct net *net, struct mr_table *mrt,
 			goto dont_forward;
 		}
 
-		c->_c.mfc_un.res.wrong_if++;
+		atomic_long_inc(&c->_c.mfc_un.res.wrong_if);
 
 		if (true_vifi >= 0 && mrt->mroute_do_assert &&
 		    /* pimsm uses asserts, when switching from RPT to SPT,
@@ -3013,9 +3013,9 @@ static int ipmr_mfc_seq_show(struct seq_file *seq, void *v)
 
 		if (it->cache != &mrt->mfc_unres_queue) {
 			seq_printf(seq, " %8lu %8lu %8lu",
-				   mfc->_c.mfc_un.res.pkt,
-				   mfc->_c.mfc_un.res.bytes,
-				   mfc->_c.mfc_un.res.wrong_if);
+				   atomic_long_read(&mfc->_c.mfc_un.res.pkt),
+				   atomic_long_read(&mfc->_c.mfc_un.res.bytes),
+				   atomic_long_read(&mfc->_c.mfc_un.res.wrong_if));
 			for (n = mfc->_c.mfc_un.res.minvif;
 			     n < mfc->_c.mfc_un.res.maxvif; n++) {
 				if (VIF_EXISTS(mrt, n) &&
diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
index f0af12a2f70bc..03b6eee407a24 100644
--- a/net/ipv4/ipmr_base.c
+++ b/net/ipv4/ipmr_base.c
@@ -263,9 +263,9 @@ int mr_fill_mroute(struct mr_table *mrt, struct sk_buff *skb,
 	lastuse = READ_ONCE(c->mfc_un.res.lastuse);
 	lastuse = time_after_eq(jiffies, lastuse) ? jiffies - lastuse : 0;
 
-	mfcs.mfcs_packets = c->mfc_un.res.pkt;
-	mfcs.mfcs_bytes = c->mfc_un.res.bytes;
-	mfcs.mfcs_wrong_if = c->mfc_un.res.wrong_if;
+	mfcs.mfcs_packets = atomic_long_read(&c->mfc_un.res.pkt);
+	mfcs.mfcs_bytes = atomic_long_read(&c->mfc_un.res.bytes);
+	mfcs.mfcs_wrong_if = atomic_long_read(&c->mfc_un.res.wrong_if);
 	if (nla_put_64bit(skb, RTA_MFC_STATS, sizeof(mfcs), &mfcs, RTA_PAD) ||
 	    nla_put_u64_64bit(skb, RTA_EXPIRES, jiffies_to_clock_t(lastuse),
 			      RTA_PAD))
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 1571e85a3531e..7f19868d7d6c6 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -506,9 +506,9 @@ static int ipmr_mfc_seq_show(struct seq_file *seq, void *v)
 
 		if (it->cache != &mrt->mfc_unres_queue) {
 			seq_printf(seq, " %8lu %8lu %8lu",
-				   mfc->_c.mfc_un.res.pkt,
-				   mfc->_c.mfc_un.res.bytes,
-				   mfc->_c.mfc_un.res.wrong_if);
+				   atomic_long_read(&mfc->_c.mfc_un.res.pkt),
+				   atomic_long_read(&mfc->_c.mfc_un.res.bytes),
+				   atomic_long_read(&mfc->_c.mfc_un.res.wrong_if));
 			for (n = mfc->_c.mfc_un.res.minvif;
 			     n < mfc->_c.mfc_un.res.maxvif; n++) {
 				if (VIF_EXISTS(mrt, n) &&
@@ -870,7 +870,7 @@ static void ip6mr_update_thresholds(struct mr_table *mrt,
 				cache->mfc_un.res.maxvif = vifi + 1;
 		}
 	}
-	cache->mfc_un.res.lastuse = jiffies;
+	WRITE_ONCE(cache->mfc_un.res.lastuse, jiffies);
 }
 
 static int mif6_add(struct net *net, struct mr_table *mrt,
@@ -1931,9 +1931,9 @@ int ip6mr_ioctl(struct sock *sk, int cmd, void *arg)
 		c = ip6mr_cache_find(mrt, &sr->src.sin6_addr,
 				     &sr->grp.sin6_addr);
 		if (c) {
-			sr->pktcnt = c->_c.mfc_un.res.pkt;
-			sr->bytecnt = c->_c.mfc_un.res.bytes;
-			sr->wrong_if = c->_c.mfc_un.res.wrong_if;
+			sr->pktcnt = atomic_long_read(&c->_c.mfc_un.res.pkt);
+			sr->bytecnt = atomic_long_read(&c->_c.mfc_un.res.bytes);
+			sr->wrong_if = atomic_long_read(&c->_c.mfc_un.res.wrong_if);
 			rcu_read_unlock();
 			return 0;
 		}
@@ -2003,9 +2003,9 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 		rcu_read_lock();
 		c = ip6mr_cache_find(mrt, &sr.src.sin6_addr, &sr.grp.sin6_addr);
 		if (c) {
-			sr.pktcnt = c->_c.mfc_un.res.pkt;
-			sr.bytecnt = c->_c.mfc_un.res.bytes;
-			sr.wrong_if = c->_c.mfc_un.res.wrong_if;
+			sr.pktcnt = atomic_long_read(&c->_c.mfc_un.res.pkt);
+			sr.bytecnt = atomic_long_read(&c->_c.mfc_un.res.bytes);
+			sr.wrong_if = atomic_long_read(&c->_c.mfc_un.res.wrong_if);
 			rcu_read_unlock();
 
 			if (copy_to_user(arg, &sr, sizeof(sr)))
@@ -2128,9 +2128,9 @@ static void ip6_mr_forward(struct net *net, struct mr_table *mrt,
 	int true_vifi = ip6mr_find_vif(mrt, dev);
 
 	vif = c->_c.mfc_parent;
-	c->_c.mfc_un.res.pkt++;
-	c->_c.mfc_un.res.bytes += skb->len;
-	c->_c.mfc_un.res.lastuse = jiffies;
+	atomic_long_inc(&c->_c.mfc_un.res.pkt);
+	atomic_long_add(skb->len, &c->_c.mfc_un.res.bytes);
+	WRITE_ONCE(c->_c.mfc_un.res.lastuse, jiffies);
 
 	if (ipv6_addr_any(&c->mf6c_origin) && true_vifi >= 0) {
 		struct mfc6_cache *cache_proxy;
@@ -2148,7 +2148,7 @@ static void ip6_mr_forward(struct net *net, struct mr_table *mrt,
 	 * Wrong interface: drop packet and (maybe) send PIM assert.
 	 */
 	if (rcu_access_pointer(mrt->vif_table[vif].dev) != dev) {
-		c->_c.mfc_un.res.wrong_if++;
+		atomic_long_inc(&c->_c.mfc_un.res.wrong_if);
 
 		if (true_vifi >= 0 && mrt->mroute_do_assert &&
 		    /* pimsm uses asserts, when switching from RPT to SPT,
-- 
2.39.5




