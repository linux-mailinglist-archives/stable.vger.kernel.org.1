Return-Path: <stable+bounces-66457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D211A94EB06
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 12:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57BDB1F22836
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 10:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2E717AE0E;
	Mon, 12 Aug 2024 10:28:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B8F17ADF5;
	Mon, 12 Aug 2024 10:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723458538; cv=none; b=e2tZ7sypOLAvMRZ6APPmRZxVYpb22m205mlbdi2ChqPMSoBwPBmhUIaMQHW7B75Lw3soenEJxs6ZE/t4oDIMI9K+2rYtWzCJQFmyghJZ2Pn/pJenOZdYBXSIKmBq/yKpqiB/imAGDcOTHgiVh4cwvimTCcdtpCtrJffKowBRVag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723458538; c=relaxed/simple;
	bh=5XaUskoRRpbk3TmmYiQwBZfSb1EuEijcPbIoY1yjhBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uicPWG2sQJeVHkkzw5TLSrijDrcwTQ2xPIyWrNikaGg+8hPMD/Q8FIlY27lyJuSi7GEwJOJy4y0ghw00xdPY1h+2FEBxL/z2QEeGHlwoGNtLuPeiXku54y6bJkwVpAiPC8PaE6qqx2pUQSgL1QqEx1/7qOJ+bAYhWHkz0bPSwMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH -stable,5.4.x 2/3] netfilter: nf_tables: use timestamp to check for set element timeout
Date: Mon, 12 Aug 2024 12:28:47 +0200
Message-Id: <20240812102848.392437-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240812102848.392437-1-pablo@netfilter.org>
References: <20240812102848.392437-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 7395dfacfff65e9938ac0889dafa1ab01e987d15 upstream

Add a timestamp field at the beginning of the transaction, store it
in the nftables per-netns area.

Update set backend .insert, .deactivate and sync gc path to use the
timestamp, this avoids that an element expires while control plane
transaction is still unfinished.

.lookup and .update, which are used from packet path, still use the
current time to check if the element has expired. And .get path and dump
also since this runs lockless under rcu read size lock. Then, there is
async gc which also needs to check the current time since it runs
asynchronously from a workqueue.

[ NB: rbtree GC updates has been excluded because GC is asynchronous. ]

Fixes: c3e1b005ed1c ("netfilter: nf_tables: add set element timeout support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_tables.h | 21 +++++++++++++++++++--
 net/netfilter/nf_tables_api.c     |  1 +
 net/netfilter/nft_set_hash.c      |  8 +++++++-
 net/netfilter/nft_set_rbtree.c    |  6 ++++--
 4 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 4f77e2f8e1ca..648aac42dfec 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -13,6 +13,7 @@
 #include <net/netfilter/nf_flow_table.h>
 #include <net/netlink.h>
 #include <net/flow_offload.h>
+#include <net/netns/generic.h>
 
 struct module;
 
@@ -656,10 +657,16 @@ static inline struct nft_expr *nft_set_ext_expr(const struct nft_set_ext *ext)
 	return nft_set_ext(ext, NFT_SET_EXT_EXPR);
 }
 
-static inline bool nft_set_elem_expired(const struct nft_set_ext *ext)
+static inline bool __nft_set_elem_expired(const struct nft_set_ext *ext,
+					  u64 tstamp)
 {
 	return nft_set_ext_exists(ext, NFT_SET_EXT_EXPIRATION) &&
-	       time_is_before_eq_jiffies64(*nft_set_ext_expiration(ext));
+	       time_after_eq64(tstamp, *nft_set_ext_expiration(ext));
+}
+
+static inline bool nft_set_elem_expired(const struct nft_set_ext *ext)
+{
+	return __nft_set_elem_expired(ext, get_jiffies_64());
 }
 
 static inline struct nft_set_ext *nft_set_elem_ext(const struct nft_set *set,
@@ -1482,9 +1489,19 @@ struct nftables_pernet {
 	struct list_head	module_list;
 	struct list_head	notify_list;
 	struct mutex		commit_mutex;
+	u64			tstamp;
 	unsigned int		base_seq;
 	u8			validate_state;
 	unsigned int		gc_seq;
 };
 
+extern unsigned int nf_tables_net_id;
+
+static inline u64 nft_net_tstamp(const struct net *net)
+{
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
+
+	return nft_net->tstamp;
+}
+
 #endif /* _NET_NF_TABLES_H */
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 2915575739e2..eff496a6891b 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -7758,6 +7758,7 @@ static bool nf_tables_valid_genid(struct net *net, u32 genid)
 	bool genid_ok;
 
 	mutex_lock(&nft_net->commit_mutex);
+	nft_net->tstamp = get_jiffies_64();
 
 	genid_ok = genid == 0 || nft_net->base_seq == genid;
 	if (!genid_ok)
diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index 0581d5499c5a..ec03d4c77b3d 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -38,6 +38,7 @@ struct nft_rhash_cmp_arg {
 	const struct nft_set		*set;
 	const u32			*key;
 	u8				genmask;
+	u64				tstamp;
 };
 
 static inline u32 nft_rhash_key(const void *data, u32 len, u32 seed)
@@ -64,7 +65,7 @@ static inline int nft_rhash_cmp(struct rhashtable_compare_arg *arg,
 		return 1;
 	if (nft_set_elem_is_dead(&he->ext))
 		return 1;
-	if (nft_set_elem_expired(&he->ext))
+	if (__nft_set_elem_expired(&he->ext, x->tstamp))
 		return 1;
 	if (!nft_set_elem_active(&he->ext, x->genmask))
 		return 1;
@@ -88,6 +89,7 @@ static bool nft_rhash_lookup(const struct net *net, const struct nft_set *set,
 		.genmask = nft_genmask_cur(net),
 		.set	 = set,
 		.key	 = key,
+		.tstamp  = get_jiffies_64(),
 	};
 
 	he = rhashtable_lookup(&priv->ht, &arg, nft_rhash_params);
@@ -106,6 +108,7 @@ static void *nft_rhash_get(const struct net *net, const struct nft_set *set,
 		.genmask = nft_genmask_cur(net),
 		.set	 = set,
 		.key	 = elem->key.val.data,
+		.tstamp  = get_jiffies_64(),
 	};
 
 	he = rhashtable_lookup(&priv->ht, &arg, nft_rhash_params);
@@ -129,6 +132,7 @@ static bool nft_rhash_update(struct nft_set *set, const u32 *key,
 		.genmask = NFT_GENMASK_ANY,
 		.set	 = set,
 		.key	 = key,
+		.tstamp  = get_jiffies_64(),
 	};
 
 	he = rhashtable_lookup(&priv->ht, &arg, nft_rhash_params);
@@ -172,6 +176,7 @@ static int nft_rhash_insert(const struct net *net, const struct nft_set *set,
 		.genmask = nft_genmask_next(net),
 		.set	 = set,
 		.key	 = elem->key.val.data,
+		.tstamp	 = nft_net_tstamp(net),
 	};
 	struct nft_rhash_elem *prev;
 
@@ -214,6 +219,7 @@ static void *nft_rhash_deactivate(const struct net *net,
 		.genmask = nft_genmask_next(net),
 		.set	 = set,
 		.key	 = elem->key.val.data,
+		.tstamp	 = nft_net_tstamp(net),
 	};
 
 	rcu_read_lock();
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 2b5f65a424b7..ed54cc057899 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -315,6 +315,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 	struct nft_rbtree *priv = nft_set_priv(set);
 	u8 cur_genmask = nft_genmask_cur(net);
 	u8 genmask = nft_genmask_next(net);
+	u64 tstamp = nft_net_tstamp(net);
 	int d, err;
 
 	/* Descend the tree to search for an existing element greater than the
@@ -362,7 +363,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 		/* perform garbage collection to avoid bogus overlap reports
 		 * but skip new elements in this transaction.
 		 */
-		if (nft_set_elem_expired(&rbe->ext) &&
+		if (__nft_set_elem_expired(&rbe->ext, tstamp) &&
 		    nft_set_elem_active(&rbe->ext, cur_genmask)) {
 			err = nft_rbtree_gc_elem(set, priv, rbe);
 			if (err < 0)
@@ -537,6 +538,7 @@ static void *nft_rbtree_deactivate(const struct net *net,
 	const struct rb_node *parent = priv->root.rb_node;
 	struct nft_rbtree_elem *rbe, *this = elem->priv;
 	u8 genmask = nft_genmask_next(net);
+	u64 tstamp = nft_net_tstamp(net);
 	int d;
 
 	while (parent != NULL) {
@@ -557,7 +559,7 @@ static void *nft_rbtree_deactivate(const struct net *net,
 				   nft_rbtree_interval_end(this)) {
 				parent = parent->rb_right;
 				continue;
-			} else if (nft_set_elem_expired(&rbe->ext)) {
+			} else if (__nft_set_elem_expired(&rbe->ext, tstamp)) {
 				break;
 			} else if (!nft_set_elem_active(&rbe->ext, genmask)) {
 				parent = parent->rb_left;
-- 
2.30.2


