Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3FC7B87F2
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243719AbjJDSLM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243914AbjJDSLL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:11:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581A3AD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:11:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0814C433C7;
        Wed,  4 Oct 2023 18:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443068;
        bh=W3d12rxD6c8kMEmCFLavjSHSa04vxB5av5mjQIW23jE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vX5HsQjojYweuqXteH+OLIsZl3MmEmOsHMjKiOwKpqc8lvTblnqzVw0seCdBxLcUB
         I9uM4v/01kCm7XFymFcrB5WtOdxj0mn0lXx45JNC/2q5iZZ3Y1Xa1YAjvEaAj+eTzs
         ui+sFmZTNgE8N5+uT9SGbHU+T/E7VeEyWHcqHuv8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 024/259] netfilter: nf_tables: remove busy mark and gc batch API
Date:   Wed,  4 Oct 2023 19:53:17 +0200
Message-ID: <20231004175218.543227232@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit a2dd0233cbc4d8a0abb5f64487487ffc9265beb5 upstream.

Ditch it, it has been replace it by the GC transaction API and it has no
clients anymore.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_tables.h | 98 +------------------------------
 net/netfilter/nf_tables_api.c     | 48 +--------------
 2 files changed, 4 insertions(+), 142 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 3b76370683c82..2d501dd901521 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -594,7 +594,6 @@ struct nft_set *nft_set_lookup_global(const struct net *net,
 
 struct nft_set_ext *nft_set_catchall_lookup(const struct net *net,
 					    const struct nft_set *set);
-void *nft_set_catchall_gc(const struct nft_set *set);
 
 static inline unsigned long nft_set_gc_interval(const struct nft_set *set)
 {
@@ -811,62 +810,6 @@ void nft_set_elem_destroy(const struct nft_set *set, void *elem,
 void nf_tables_set_elem_destroy(const struct nft_ctx *ctx,
 				const struct nft_set *set, void *elem);
 
-/**
- *	struct nft_set_gc_batch_head - nf_tables set garbage collection batch
- *
- *	@rcu: rcu head
- *	@set: set the elements belong to
- *	@cnt: count of elements
- */
-struct nft_set_gc_batch_head {
-	struct rcu_head			rcu;
-	const struct nft_set		*set;
-	unsigned int			cnt;
-};
-
-#define NFT_SET_GC_BATCH_SIZE	((PAGE_SIZE -				  \
-				  sizeof(struct nft_set_gc_batch_head)) / \
-				 sizeof(void *))
-
-/**
- *	struct nft_set_gc_batch - nf_tables set garbage collection batch
- *
- * 	@head: GC batch head
- * 	@elems: garbage collection elements
- */
-struct nft_set_gc_batch {
-	struct nft_set_gc_batch_head	head;
-	void				*elems[NFT_SET_GC_BATCH_SIZE];
-};
-
-struct nft_set_gc_batch *nft_set_gc_batch_alloc(const struct nft_set *set,
-						gfp_t gfp);
-void nft_set_gc_batch_release(struct rcu_head *rcu);
-
-static inline void nft_set_gc_batch_complete(struct nft_set_gc_batch *gcb)
-{
-	if (gcb != NULL)
-		call_rcu(&gcb->head.rcu, nft_set_gc_batch_release);
-}
-
-static inline struct nft_set_gc_batch *
-nft_set_gc_batch_check(const struct nft_set *set, struct nft_set_gc_batch *gcb,
-		       gfp_t gfp)
-{
-	if (gcb != NULL) {
-		if (gcb->head.cnt + 1 < ARRAY_SIZE(gcb->elems))
-			return gcb;
-		nft_set_gc_batch_complete(gcb);
-	}
-	return nft_set_gc_batch_alloc(set, gfp);
-}
-
-static inline void nft_set_gc_batch_add(struct nft_set_gc_batch *gcb,
-					void *elem)
-{
-	gcb->elems[gcb->head.cnt++] = elem;
-}
-
 struct nft_expr_ops;
 /**
  *	struct nft_expr_type - nf_tables expression type
@@ -1545,47 +1488,12 @@ static inline void nft_set_elem_change_active(const struct net *net,
 
 #endif /* IS_ENABLED(CONFIG_NF_TABLES) */
 
-/*
- * We use a free bit in the genmask field to indicate the element
- * is busy, meaning it is currently being processed either by
- * the netlink API or GC.
- *
- * Even though the genmask is only a single byte wide, this works
- * because the extension structure if fully constant once initialized,
- * so there are no non-atomic write accesses unless it is already
- * marked busy.
- */
-#define NFT_SET_ELEM_BUSY_MASK	(1 << 2)
-
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-#define NFT_SET_ELEM_BUSY_BIT	2
-#elif defined(__BIG_ENDIAN_BITFIELD)
-#define NFT_SET_ELEM_BUSY_BIT	(BITS_PER_LONG - BITS_PER_BYTE + 2)
-#else
-#error
-#endif
-
-static inline int nft_set_elem_mark_busy(struct nft_set_ext *ext)
-{
-	unsigned long *word = (unsigned long *)ext;
-
-	BUILD_BUG_ON(offsetof(struct nft_set_ext, genmask) != 0);
-	return test_and_set_bit(NFT_SET_ELEM_BUSY_BIT, word);
-}
-
-static inline void nft_set_elem_clear_busy(struct nft_set_ext *ext)
-{
-	unsigned long *word = (unsigned long *)ext;
-
-	clear_bit(NFT_SET_ELEM_BUSY_BIT, word);
-}
-
-#define NFT_SET_ELEM_DEAD_MASK	(1 << 3)
+#define NFT_SET_ELEM_DEAD_MASK	(1 << 2)
 
 #if defined(__LITTLE_ENDIAN_BITFIELD)
-#define NFT_SET_ELEM_DEAD_BIT	3
+#define NFT_SET_ELEM_DEAD_BIT	2
 #elif defined(__BIG_ENDIAN_BITFIELD)
-#define NFT_SET_ELEM_DEAD_BIT	(BITS_PER_LONG - BITS_PER_BYTE + 3)
+#define NFT_SET_ELEM_DEAD_BIT	(BITS_PER_LONG - BITS_PER_BYTE + 2)
 #else
 #error
 #endif
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index e179d1132f2fb..a38d87256b8fb 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6069,29 +6069,6 @@ struct nft_set_ext *nft_set_catchall_lookup(const struct net *net,
 }
 EXPORT_SYMBOL_GPL(nft_set_catchall_lookup);
 
-void *nft_set_catchall_gc(const struct nft_set *set)
-{
-	struct nft_set_elem_catchall *catchall, *next;
-	struct nft_set_ext *ext;
-	void *elem = NULL;
-
-	list_for_each_entry_safe(catchall, next, &set->catchall_list, list) {
-		ext = nft_set_elem_ext(set, catchall->elem);
-
-		if (!nft_set_elem_expired(ext) ||
-		    nft_set_elem_mark_busy(ext))
-			continue;
-
-		elem = catchall->elem;
-		list_del_rcu(&catchall->list);
-		kfree_rcu(catchall, rcu);
-		break;
-	}
-
-	return elem;
-}
-EXPORT_SYMBOL_GPL(nft_set_catchall_gc);
-
 static int nft_setelem_catchall_insert(const struct net *net,
 				       struct nft_set *set,
 				       const struct nft_set_elem *elem,
@@ -6562,7 +6539,7 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 		goto err_elem_free;
 	}
 
-	ext->genmask = nft_genmask_cur(ctx->net) | NFT_SET_ELEM_BUSY_MASK;
+	ext->genmask = nft_genmask_cur(ctx->net);
 
 	err = nft_setelem_insert(ctx->net, set, &elem, &ext2, flags);
 	if (err) {
@@ -6949,29 +6926,6 @@ static int nf_tables_delsetelem(struct sk_buff *skb,
 	return err;
 }
 
-void nft_set_gc_batch_release(struct rcu_head *rcu)
-{
-	struct nft_set_gc_batch *gcb;
-	unsigned int i;
-
-	gcb = container_of(rcu, struct nft_set_gc_batch, head.rcu);
-	for (i = 0; i < gcb->head.cnt; i++)
-		nft_set_elem_destroy(gcb->head.set, gcb->elems[i], true);
-	kfree(gcb);
-}
-
-struct nft_set_gc_batch *nft_set_gc_batch_alloc(const struct nft_set *set,
-						gfp_t gfp)
-{
-	struct nft_set_gc_batch *gcb;
-
-	gcb = kzalloc(sizeof(*gcb), gfp);
-	if (gcb == NULL)
-		return gcb;
-	gcb->head.set = set;
-	return gcb;
-}
-
 /*
  * Stateful objects
  */
-- 
2.40.1



