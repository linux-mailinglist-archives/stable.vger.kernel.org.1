Return-Path: <stable+bounces-50344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0906A905FF4
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 03:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97FA3B220C7
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 01:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE7CEECF;
	Thu, 13 Jun 2024 01:02:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB428BEC;
	Thu, 13 Jun 2024 01:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718240543; cv=none; b=epr7J4p0ePkb0ApcQPw6TgJ/Cx3uNiXHbHuGZ/I8FqdNqy4R3cd6+tbXk98HKaxszn8dFvQS1sk6ig0QdORuZsdKsvCKzcgSuZLN76C4VELWYfzfaqu2q3Knv3xTBHqdlnNm2I7wMyDYTf52Z7ZMW6YP2sAxf1s5WOqMgNkKgLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718240543; c=relaxed/simple;
	bh=8JEbd9P03HAF3cpe6UMOX7YqO/d0cvBr7fTjfu6bYKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qhBe8Vo1zdy1u8hSXxy4JclALeTO+6NbTSPAGDowSfXsnIqlVMipQTbQ/uwwBDscvbx7oeLoxWs5/9igWlQvLam97+CZN1Ih+7/XxEZyyhAAmr53AMm50pSdRgT5B/IYMyENtWlJVvGiuTroaICf5g+M0EHu9+GFhuWkrqmCU0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH -stable,4.19.x 03/40] netfilter: nf_tables: drop map element references from preparation phase
Date: Thu, 13 Jun 2024 03:01:32 +0200
Message-Id: <20240613010209.104423-4-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240613010209.104423-1-pablo@netfilter.org>
References: <20240613010209.104423-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 628bd3e49cba1c066228e23d71a852c23e26da73 ]

set .destroy callback releases the references to other objects in maps.
This is very late and it results in spurious EBUSY errors. Drop refcount
from the preparation phase instead, update set backend not to drop
reference counter from set .destroy path.

Exceptions: NFT_TRANS_PREPARE_ERROR does not require to drop the
reference counter because the transaction abort path releases the map
references for each element since the set is unbound. The abort path
also deals with releasing reference counter for new elements added to
unbound sets.

Fixes: 591054469b3e ("netfilter: nf_tables: revisit chain/object refcounting from elements")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_tables.h |  5 +-
 net/netfilter/nf_tables_api.c     | 89 +++++++++++++++++++++++++++----
 net/netfilter/nft_set_bitmap.c    |  5 +-
 net/netfilter/nft_set_hash.c      | 23 ++++++--
 net/netfilter/nft_set_rbtree.c    |  5 +-
 5 files changed, 108 insertions(+), 19 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index fd85286482c1..cff8c7141276 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -349,7 +349,8 @@ struct nft_set_ops {
 	int				(*init)(const struct nft_set *set,
 						const struct nft_set_desc *desc,
 						const struct nlattr * const nla[]);
-	void				(*destroy)(const struct nft_set *set);
+	void				(*destroy)(const struct nft_ctx *ctx,
+						   const struct nft_set *set);
 	void				(*gc_init)(const struct nft_set *set);
 
 	unsigned int			elemsize;
@@ -645,6 +646,8 @@ void *nft_set_elem_init(const struct nft_set *set,
 			u64 timeout, gfp_t gfp);
 void nft_set_elem_destroy(const struct nft_set *set, void *elem,
 			  bool destroy_expr);
+void nf_tables_set_elem_destroy(const struct nft_ctx *ctx,
+				const struct nft_set *set, void *elem);
 
 /**
  *	struct nft_set_gc_batch_head - nf_tables set garbage collection batch
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index acd2763bb784..a9dfe3183565 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -388,6 +388,31 @@ static int nft_trans_set_add(const struct nft_ctx *ctx, int msg_type,
 	return 0;
 }
 
+static void nft_setelem_data_deactivate(const struct net *net,
+					const struct nft_set *set,
+					struct nft_set_elem *elem);
+
+static int nft_mapelem_deactivate(const struct nft_ctx *ctx,
+				  struct nft_set *set,
+				  const struct nft_set_iter *iter,
+				  struct nft_set_elem *elem)
+{
+	nft_setelem_data_deactivate(ctx->net, set, elem);
+
+	return 0;
+}
+
+static void nft_map_deactivate(const struct nft_ctx *ctx, struct nft_set *set)
+{
+	struct nft_set_iter iter = {
+		.genmask	= nft_genmask_next(ctx->net),
+		.fn		= nft_mapelem_deactivate,
+	};
+
+	set->ops->walk(ctx, set, &iter);
+	WARN_ON_ONCE(iter.err);
+}
+
 static int nft_delset(const struct nft_ctx *ctx, struct nft_set *set)
 {
 	int err;
@@ -396,6 +421,9 @@ static int nft_delset(const struct nft_ctx *ctx, struct nft_set *set)
 	if (err < 0)
 		return err;
 
+	if (set->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
+		nft_map_deactivate(ctx, set);
+
 	nft_deactivate_next(ctx->net, set);
 	nft_use_dec(&ctx->table->use);
 
@@ -3741,7 +3769,7 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 	return 0;
 
 err4:
-	ops->destroy(set);
+	ops->destroy(&ctx, set);
 err3:
 	kfree(set->name);
 err2:
@@ -3758,7 +3786,7 @@ static void nft_set_destroy(const struct nft_ctx *ctx, struct nft_set *set)
 	if (WARN_ON(set->use > 0))
 		return;
 
-	set->ops->destroy(set);
+	set->ops->destroy(ctx, set);
 	module_put(to_set_type(set->ops)->owner);
 	kfree(set->name);
 	kvfree(set);
@@ -3883,10 +3911,39 @@ void nf_tables_unbind_set(const struct nft_ctx *ctx, struct nft_set *set,
 }
 EXPORT_SYMBOL_GPL(nf_tables_unbind_set);
 
+static void nft_setelem_data_activate(const struct net *net,
+				      const struct nft_set *set,
+				      struct nft_set_elem *elem);
+
+static int nft_mapelem_activate(const struct nft_ctx *ctx,
+				struct nft_set *set,
+				const struct nft_set_iter *iter,
+				struct nft_set_elem *elem)
+{
+	nft_setelem_data_activate(ctx->net, set, elem);
+
+	return 0;
+}
+
+static void nft_map_activate(const struct nft_ctx *ctx, struct nft_set *set)
+{
+	struct nft_set_iter iter = {
+		.genmask	= nft_genmask_next(ctx->net),
+		.fn		= nft_mapelem_activate,
+	};
+
+	set->ops->walk(ctx, set, &iter);
+	WARN_ON_ONCE(iter.err);
+}
+
 void nf_tables_activate_set(const struct nft_ctx *ctx, struct nft_set *set)
 {
-	if (nft_set_is_anonymous(set))
+	if (nft_set_is_anonymous(set)) {
+		if (set->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
+			nft_map_activate(ctx, set);
+
 		nft_clear(ctx->net, set);
+	}
 
 	nft_use_inc_restore(&set->use);
 }
@@ -3907,13 +3964,20 @@ void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 		nft_use_dec(&set->use);
 		break;
 	case NFT_TRANS_PREPARE:
-		if (nft_set_is_anonymous(set))
-			nft_deactivate_next(ctx->net, set);
+		if (nft_set_is_anonymous(set)) {
+			if (set->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
+				nft_map_deactivate(ctx, set);
 
+			nft_deactivate_next(ctx->net, set);
+		}
 		nft_use_dec(&set->use);
 		return;
 	case NFT_TRANS_ABORT:
 	case NFT_TRANS_RELEASE:
+		if (nft_set_is_anonymous(set) &&
+		    set->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
+			nft_map_deactivate(ctx, set);
+
 		nft_use_dec(&set->use);
 		/* fall through */
 	default:
@@ -4473,6 +4537,7 @@ void *nft_set_elem_init(const struct nft_set *set,
 	return elem;
 }
 
+/* Drop references and destroy. Called from gc, dynset and abort path. */
 void nft_set_elem_destroy(const struct nft_set *set, void *elem,
 			  bool destroy_expr)
 {
@@ -4501,11 +4566,11 @@ void nft_set_elem_destroy(const struct nft_set *set, void *elem,
 }
 EXPORT_SYMBOL_GPL(nft_set_elem_destroy);
 
-/* Only called from commit path, nft_setelem_data_deactivate() already deals
- * with the refcounting from the preparation phase.
+/* Destroy element. References have been already dropped in the preparation
+ * path via nft_setelem_data_deactivate().
  */
-static void nf_tables_set_elem_destroy(const struct nft_ctx *ctx,
-				       const struct nft_set *set, void *elem)
+void nf_tables_set_elem_destroy(const struct nft_ctx *ctx,
+				const struct nft_set *set, void *elem)
 {
 	struct nft_set_ext *ext = nft_set_elem_ext(set, elem);
 
@@ -4513,6 +4578,7 @@ static void nf_tables_set_elem_destroy(const struct nft_ctx *ctx,
 		nf_tables_expr_destroy(ctx, nft_set_ext_expr(ext));
 	kfree(elem);
 }
+EXPORT_SYMBOL_GPL(nf_tables_set_elem_destroy);
 
 static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 			    const struct nlattr *attr, u32 nlmsg_flags)
@@ -6940,6 +7006,8 @@ static int __nf_tables_abort(struct net *net)
 		case NFT_MSG_DELSET:
 			nft_use_inc_restore(&trans->ctx.table->use);
 			nft_clear(trans->ctx.net, nft_trans_set(trans));
+			if (nft_trans_set(trans)->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
+				nft_map_activate(&trans->ctx, nft_trans_set(trans));
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_NEWSETELEM:
@@ -7604,6 +7672,9 @@ static void __nft_release_table(struct net *net, struct nft_table *table)
 	list_for_each_entry_safe(set, ns, &table->sets, list) {
 		list_del(&set->list);
 		nft_use_dec(&table->use);
+		if (set->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
+			nft_map_deactivate(&ctx, set);
+
 		nft_set_destroy(&ctx, set);
 	}
 	list_for_each_entry_safe(obj, ne, &table->objects, list) {
diff --git a/net/netfilter/nft_set_bitmap.c b/net/netfilter/nft_set_bitmap.c
index f866bd41e5d2..80dce1182215 100644
--- a/net/netfilter/nft_set_bitmap.c
+++ b/net/netfilter/nft_set_bitmap.c
@@ -273,13 +273,14 @@ static int nft_bitmap_init(const struct nft_set *set,
 	return 0;
 }
 
-static void nft_bitmap_destroy(const struct nft_set *set)
+static void nft_bitmap_destroy(const struct nft_ctx *ctx,
+			       const struct nft_set *set)
 {
 	struct nft_bitmap *priv = nft_set_priv(set);
 	struct nft_bitmap_elem *be, *n;
 
 	list_for_each_entry_safe(be, n, &priv->list, head)
-		nft_set_elem_destroy(set, be, true);
+		nf_tables_set_elem_destroy(ctx, set, be);
 }
 
 static bool nft_bitmap_estimate(const struct nft_set_desc *desc, u32 features,
diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index 0b8510a4185d..f2be05731740 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -379,19 +379,31 @@ static int nft_rhash_init(const struct nft_set *set,
 	return 0;
 }
 
+struct nft_rhash_ctx {
+	const struct nft_ctx	ctx;
+	const struct nft_set	*set;
+};
+
 static void nft_rhash_elem_destroy(void *ptr, void *arg)
 {
-	nft_set_elem_destroy(arg, ptr, true);
+	struct nft_rhash_ctx *rhash_ctx = arg;
+
+	nf_tables_set_elem_destroy(&rhash_ctx->ctx, rhash_ctx->set, ptr);
 }
 
-static void nft_rhash_destroy(const struct nft_set *set)
+static void nft_rhash_destroy(const struct nft_ctx *ctx,
+			      const struct nft_set *set)
 {
 	struct nft_rhash *priv = nft_set_priv(set);
+	struct nft_rhash_ctx rhash_ctx = {
+		.ctx	= *ctx,
+		.set	= set,
+	};
 
 	cancel_delayed_work_sync(&priv->gc_work);
 	rcu_barrier();
 	rhashtable_free_and_destroy(&priv->ht, nft_rhash_elem_destroy,
-				    (void *)set);
+				    (void *)&rhash_ctx);
 }
 
 /* Number of buckets is stored in u32, so cap our result to 1U<<31 */
@@ -629,7 +641,8 @@ static int nft_hash_init(const struct nft_set *set,
 	return 0;
 }
 
-static void nft_hash_destroy(const struct nft_set *set)
+static void nft_hash_destroy(const struct nft_ctx *ctx,
+			     const struct nft_set *set)
 {
 	struct nft_hash *priv = nft_set_priv(set);
 	struct nft_hash_elem *he;
@@ -639,7 +652,7 @@ static void nft_hash_destroy(const struct nft_set *set)
 	for (i = 0; i < priv->buckets; i++) {
 		hlist_for_each_entry_safe(he, next, &priv->table[i], node) {
 			hlist_del_rcu(&he->node);
-			nft_set_elem_destroy(set, he, true);
+			nf_tables_set_elem_destroy(ctx, set, he);
 		}
 	}
 }
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 9c7ec2ec1fcf..60ef5dea89fa 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -466,7 +466,8 @@ static int nft_rbtree_init(const struct nft_set *set,
 	return 0;
 }
 
-static void nft_rbtree_destroy(const struct nft_set *set)
+static void nft_rbtree_destroy(const struct nft_ctx *ctx,
+			       const struct nft_set *set)
 {
 	struct nft_rbtree *priv = nft_set_priv(set);
 	struct nft_rbtree_elem *rbe;
@@ -477,7 +478,7 @@ static void nft_rbtree_destroy(const struct nft_set *set)
 	while ((node = priv->root.rb_node) != NULL) {
 		rb_erase(node, &priv->root);
 		rbe = rb_entry(node, struct nft_rbtree_elem, node);
-		nft_set_elem_destroy(set, rbe, true);
+		nf_tables_set_elem_destroy(ctx, set, rbe);
 	}
 }
 
-- 
2.30.2


