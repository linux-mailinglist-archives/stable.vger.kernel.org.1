Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2697AB6B5
	for <lists+stable@lfdr.de>; Fri, 22 Sep 2023 19:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjIVRBf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 22 Sep 2023 13:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbjIVRBe (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 22 Sep 2023 13:01:34 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9383198;
        Fri, 22 Sep 2023 10:01:27 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        sashal@kernel.org
Subject: [PATCH -stable,5.10 06/17] netfilter: nf_tables: remove busy mark and gc batch API
Date:   Fri, 22 Sep 2023 19:01:07 +0200
Message-Id: <20230922170118.152420-7-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230922170118.152420-1-pablo@netfilter.org>
References: <20230922170118.152420-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit a2dd0233cbc4d8a0abb5f64487487ffc9265beb5 upstream.

Ditch it, it has been replace it by the GC transaction API and it has no
clients anymore.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_tables.h | 97 +------------------------------
 net/netfilter/nf_tables_api.c     | 26 +--------
 2 files changed, 5 insertions(+), 118 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 39a0b37e8a1a..9182b583d429 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -695,62 +695,6 @@ void nft_set_elem_destroy(const struct nft_set *set, void *elem,
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
@@ -1418,47 +1362,12 @@ static inline void nft_set_elem_change_active(const struct net *net,
 
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
index 1f06dd065d75..206755eb35f3 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5637,7 +5637,8 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 		goto err_elem_expr;
 	}
 
-	ext->genmask = nft_genmask_cur(ctx->net) | NFT_SET_ELEM_BUSY_MASK;
+	ext->genmask = nft_genmask_cur(ctx->net);
+
 	err = set->ops->insert(ctx->net, set, &elem, &ext2);
 	if (err) {
 		if (err == -EEXIST) {
@@ -5945,29 +5946,6 @@ static int nf_tables_delsetelem(struct net *net, struct sock *nlsk,
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
2.30.2

