Return-Path: <stable+bounces-55892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE13919B6E
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 01:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE731F231AD
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 23:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8985F19415A;
	Wed, 26 Jun 2024 23:53:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C41D1940AB;
	Wed, 26 Jun 2024 23:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719446000; cv=none; b=uJk9do89Tfjb3UdEOgSSE3UvCUNObNC91z8wJSe0Yvb1yxmqKXlq2hl6grccs0RzwN9jlohf/uhYRuJ0dinlLewjRErixaOaupLVXdT4zJgRAcZ20r7lBmRgG/TfYcB6Z2SdxJrGNhSVqoCLyTjKSw2TDzAN9kV7U7s5qc7AMXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719446000; c=relaxed/simple;
	bh=95+L+6Zxxd3SzwrmOMAmIehM16beC3wBHI898fB8mVs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t+QBGW2zU9YtqgjoH34z6fGaJn1bFl9e3hgzVr2W3ljeQDaWPlpJDB2yTRyZScOxmPzXpP20qF6UBfgWnGQ/AfWCc8SzIwEijDL+nHDMGzllJl17t+QMRnpKsu3pVSfqj7XE3GINAKjbq4K+tqKplU4kF73X0SIZtUcQ5l0BCH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: kuntal.nayak@broadcom.com,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Subject: [PATCH -stable,6.1.x] netfilter: nf_tables: use timestamp to check for set element timeout
Date: Thu, 27 Jun 2024 01:53:13 +0200
Message-Id: <20240626235314.281432-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
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

Fixes: c3e1b005ed1c ("netfilter: nf_tables: add set element timeout support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
This is a backport for 6.1.x, please apply.

 include/net/netfilter/nf_tables.h | 16 ++++++++++++++--
 net/netfilter/nf_tables_api.c     |  4 +++-
 net/netfilter/nft_set_hash.c      |  8 +++++++-
 net/netfilter/nft_set_pipapo.c    | 18 +++++++++++-------
 net/netfilter/nft_set_rbtree.c    |  6 ++++--
 5 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 2fa344cb66f6..964cf7578bd5 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -784,10 +784,16 @@ static inline struct nft_set_elem_expr *nft_set_ext_expr(const struct nft_set_ex
 	return nft_set_ext(ext, NFT_SET_EXT_EXPRESSIONS);
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
@@ -1711,6 +1717,7 @@ struct nftables_pernet {
 	struct list_head	notify_list;
 	struct mutex		commit_mutex;
 	u64			table_handle;
+	u64			tstamp;
 	unsigned int		base_seq;
 	u8			validate_state;
 	unsigned int		gc_seq;
@@ -1723,6 +1730,11 @@ static inline struct nftables_pernet *nft_pernet(const struct net *net)
 	return net_generic(net, nf_tables_net_id);
 }
 
+static inline u64 nft_net_tstamp(const struct net *net)
+{
+	return nft_pernet(net)->tstamp;
+}
+
 #define __NFT_REDUCE_READONLY	1UL
 #define NFT_REDUCE_READONLY	(void *)__NFT_REDUCE_READONLY
 
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 1c4b7a8ec2cc..e838a6617b0a 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -9377,6 +9377,7 @@ struct nft_trans_gc *nft_trans_gc_catchall_async(struct nft_trans_gc *gc,
 struct nft_trans_gc *nft_trans_gc_catchall_sync(struct nft_trans_gc *gc)
 {
 	struct nft_set_elem_catchall *catchall, *next;
+	u64 tstamp = nft_net_tstamp(gc->net);
 	const struct nft_set *set = gc->set;
 	struct nft_set_elem elem;
 	struct nft_set_ext *ext;
@@ -9386,7 +9387,7 @@ struct nft_trans_gc *nft_trans_gc_catchall_sync(struct nft_trans_gc *gc)
 	list_for_each_entry_safe(catchall, next, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
 
-		if (!nft_set_elem_expired(ext))
+		if (!__nft_set_elem_expired(ext, tstamp))
 			continue;
 
 		gc = nft_trans_gc_queue_sync(gc, GFP_KERNEL);
@@ -10138,6 +10139,7 @@ static bool nf_tables_valid_genid(struct net *net, u32 genid)
 	bool genid_ok;
 
 	mutex_lock(&nft_net->commit_mutex);
+	nft_net->tstamp = get_jiffies_64();
 
 	genid_ok = genid == 0 || nft_net->base_seq == genid;
 	if (!genid_ok)
diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index 2013de934cef..1fd3b413350d 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -35,6 +35,7 @@ struct nft_rhash_cmp_arg {
 	const struct nft_set		*set;
 	const u32			*key;
 	u8				genmask;
+	u64				tstamp;
 };
 
 static inline u32 nft_rhash_key(const void *data, u32 len, u32 seed)
@@ -61,7 +62,7 @@ static inline int nft_rhash_cmp(struct rhashtable_compare_arg *arg,
 		return 1;
 	if (nft_set_elem_is_dead(&he->ext))
 		return 1;
-	if (nft_set_elem_expired(&he->ext))
+	if (__nft_set_elem_expired(&he->ext, x->tstamp))
 		return 1;
 	if (!nft_set_elem_active(&he->ext, x->genmask))
 		return 1;
@@ -86,6 +87,7 @@ bool nft_rhash_lookup(const struct net *net, const struct nft_set *set,
 		.genmask = nft_genmask_cur(net),
 		.set	 = set,
 		.key	 = key,
+		.tstamp  = get_jiffies_64(),
 	};
 
 	he = rhashtable_lookup(&priv->ht, &arg, nft_rhash_params);
@@ -104,6 +106,7 @@ static void *nft_rhash_get(const struct net *net, const struct nft_set *set,
 		.genmask = nft_genmask_cur(net),
 		.set	 = set,
 		.key	 = elem->key.val.data,
+		.tstamp  = get_jiffies_64(),
 	};
 
 	he = rhashtable_lookup(&priv->ht, &arg, nft_rhash_params);
@@ -127,6 +130,7 @@ static bool nft_rhash_update(struct nft_set *set, const u32 *key,
 		.genmask = NFT_GENMASK_ANY,
 		.set	 = set,
 		.key	 = key,
+		.tstamp  = get_jiffies_64(),
 	};
 
 	he = rhashtable_lookup(&priv->ht, &arg, nft_rhash_params);
@@ -170,6 +174,7 @@ static int nft_rhash_insert(const struct net *net, const struct nft_set *set,
 		.genmask = nft_genmask_next(net),
 		.set	 = set,
 		.key	 = elem->key.val.data,
+		.tstamp	 = nft_net_tstamp(net),
 	};
 	struct nft_rhash_elem *prev;
 
@@ -212,6 +217,7 @@ static void *nft_rhash_deactivate(const struct net *net,
 		.genmask = nft_genmask_next(net),
 		.set	 = set,
 		.key	 = elem->key.val.data,
+		.tstamp	 = nft_net_tstamp(net),
 	};
 
 	rcu_read_lock();
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 2299ced939c4..a56ed216c223 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -504,6 +504,7 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
  * @set:	nftables API set representation
  * @data:	Key data to be matched against existing elements
  * @genmask:	If set, check that element is active in given genmask
+ * @tstamp:	timestamp to check for expired elements
  *
  * This is essentially the same as the lookup function, except that it matches
  * key data against the uncommitted copy and doesn't use preallocated maps for
@@ -513,7 +514,8 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
  */
 static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 					  const struct nft_set *set,
-					  const u8 *data, u8 genmask)
+					  const u8 *data, u8 genmask,
+					  u64 tstamp)
 {
 	struct nft_pipapo_elem *ret = ERR_PTR(-ENOENT);
 	struct nft_pipapo *priv = nft_set_priv(set);
@@ -566,7 +568,7 @@ static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 			goto out;
 
 		if (last) {
-			if (nft_set_elem_expired(&f->mt[b].e->ext))
+			if (__nft_set_elem_expired(&f->mt[b].e->ext, tstamp))
 				goto next_match;
 			if ((genmask &&
 			     !nft_set_elem_active(&f->mt[b].e->ext, genmask)))
@@ -603,7 +605,7 @@ static void *nft_pipapo_get(const struct net *net, const struct nft_set *set,
 			    const struct nft_set_elem *elem, unsigned int flags)
 {
 	return pipapo_get(net, set, (const u8 *)elem->key.val.data,
-			 nft_genmask_cur(net));
+			 nft_genmask_cur(net), get_jiffies_64());
 }
 
 /**
@@ -1197,6 +1199,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 	struct nft_pipapo *priv = nft_set_priv(set);
 	struct nft_pipapo_match *m = priv->clone;
 	u8 genmask = nft_genmask_next(net);
+	u64 tstamp = nft_net_tstamp(net);
 	struct nft_pipapo_field *f;
 	const u8 *start_p, *end_p;
 	int i, bsize_max, err = 0;
@@ -1206,7 +1209,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 	else
 		end = start;
 
-	dup = pipapo_get(net, set, start, genmask);
+	dup = pipapo_get(net, set, start, genmask, tstamp);
 	if (!IS_ERR(dup)) {
 		/* Check if we already have the same exact entry */
 		const struct nft_data *dup_key, *dup_end;
@@ -1228,7 +1231,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 
 	if (PTR_ERR(dup) == -ENOENT) {
 		/* Look for partially overlapping entries */
-		dup = pipapo_get(net, set, end, nft_genmask_next(net));
+		dup = pipapo_get(net, set, end, nft_genmask_next(net), tstamp);
 	}
 
 	if (PTR_ERR(dup) != -ENOENT) {
@@ -1581,6 +1584,7 @@ static void pipapo_gc(const struct nft_set *_set, struct nft_pipapo_match *m)
 	struct nft_set *set = (struct nft_set *) _set;
 	struct nft_pipapo *priv = nft_set_priv(set);
 	struct net *net = read_pnet(&set->net);
+	u64 tstamp = nft_net_tstamp(net);
 	int rules_f0, first_rule = 0;
 	struct nft_pipapo_elem *e;
 	struct nft_trans_gc *gc;
@@ -1615,7 +1619,7 @@ static void pipapo_gc(const struct nft_set *_set, struct nft_pipapo_match *m)
 		/* synchronous gc never fails, there is no need to set on
 		 * NFT_SET_ELEM_DEAD_BIT.
 		 */
-		if (nft_set_elem_expired(&e->ext)) {
+		if (__nft_set_elem_expired(&e->ext, tstamp)) {
 			priv->dirty = true;
 
 			gc = nft_trans_gc_queue_sync(gc, GFP_ATOMIC);
@@ -1786,7 +1790,7 @@ static void *pipapo_deactivate(const struct net *net, const struct nft_set *set,
 {
 	struct nft_pipapo_elem *e;
 
-	e = pipapo_get(net, set, data, nft_genmask_next(net));
+	e = pipapo_get(net, set, data, nft_genmask_next(net), nft_net_tstamp(net));
 	if (IS_ERR(e))
 		return NULL;
 
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 5bf5572e945c..021d9e76129a 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -314,6 +314,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 	struct nft_rbtree *priv = nft_set_priv(set);
 	u8 cur_genmask = nft_genmask_cur(net);
 	u8 genmask = nft_genmask_next(net);
+	u64 tstamp = nft_net_tstamp(net);
 	int d;
 
 	/* Descend the tree to search for an existing element greater than the
@@ -361,7 +362,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 		/* perform garbage collection to avoid bogus overlap reports
 		 * but skip new elements in this transaction.
 		 */
-		if (nft_set_elem_expired(&rbe->ext) &&
+		if (__nft_set_elem_expired(&rbe->ext, tstamp) &&
 		    nft_set_elem_active(&rbe->ext, cur_genmask)) {
 			const struct nft_rbtree_elem *removed_end;
 
@@ -548,6 +549,7 @@ static void *nft_rbtree_deactivate(const struct net *net,
 	const struct rb_node *parent = priv->root.rb_node;
 	struct nft_rbtree_elem *rbe, *this = elem->priv;
 	u8 genmask = nft_genmask_next(net);
+	u64 tstamp = nft_net_tstamp(net);
 	int d;
 
 	while (parent != NULL) {
@@ -568,7 +570,7 @@ static void *nft_rbtree_deactivate(const struct net *net,
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


