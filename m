Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CA77AB65D
	for <lists+stable@lfdr.de>; Fri, 22 Sep 2023 18:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjIVQnx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 22 Sep 2023 12:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjIVQni (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 22 Sep 2023 12:43:38 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89E74CF2;
        Fri, 22 Sep 2023 09:43:24 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        sashal@kernel.org
Subject: [PATCH -stable,5.15 17/17] netfilter: nf_tables: fix memleak when more than 255 elements expired
Date:   Fri, 22 Sep 2023 18:43:13 +0200
Message-Id: <20230922164313.151564-18-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230922164313.151564-1-pablo@netfilter.org>
References: <20230922164313.151564-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

commit cf5000a7787cbc10341091d37245a42c119d26c5 upstream.

When more than 255 elements expired we're supposed to switch to a new gc
container structure.

This never happens: u8 type will wrap before reaching the boundary
and nft_trans_gc_space() always returns true.

This means we recycle the initial gc container structure and
lose track of the elements that came before.

While at it, don't deref 'gc' after we've passed it to call_rcu.

Fixes: 5f68718b34a5 ("netfilter: nf_tables: GC transaction API to avoid race with control plane")
Reported-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_tables.h |  2 +-
 net/netfilter/nf_tables_api.c     | 10 ++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index d543078c43f9..098e829fd762 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1605,7 +1605,7 @@ struct nft_trans_gc {
 	struct net		*net;
 	struct nft_set		*set;
 	u32			seq;
-	u8			count;
+	u16			count;
 	void			*priv[NFT_TRANS_GC_BATCHCOUNT];
 	struct rcu_head		rcu;
 };
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 58fec8806ec5..4dadb0eebf61 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8984,12 +8984,15 @@ static int nft_trans_gc_space(struct nft_trans_gc *trans)
 struct nft_trans_gc *nft_trans_gc_queue_async(struct nft_trans_gc *gc,
 					      unsigned int gc_seq, gfp_t gfp)
 {
+	struct nft_set *set;
+
 	if (nft_trans_gc_space(gc))
 		return gc;
 
+	set = gc->set;
 	nft_trans_gc_queue_work(gc);
 
-	return nft_trans_gc_alloc(gc->set, gc_seq, gfp);
+	return nft_trans_gc_alloc(set, gc_seq, gfp);
 }
 
 void nft_trans_gc_queue_async_done(struct nft_trans_gc *trans)
@@ -9004,15 +9007,18 @@ void nft_trans_gc_queue_async_done(struct nft_trans_gc *trans)
 
 struct nft_trans_gc *nft_trans_gc_queue_sync(struct nft_trans_gc *gc, gfp_t gfp)
 {
+	struct nft_set *set;
+
 	if (WARN_ON_ONCE(!lockdep_commit_lock_is_held(gc->net)))
 		return NULL;
 
 	if (nft_trans_gc_space(gc))
 		return gc;
 
+	set = gc->set;
 	call_rcu(&gc->rcu, nft_trans_gc_trans_free);
 
-	return nft_trans_gc_alloc(gc->set, 0, gfp);
+	return nft_trans_gc_alloc(set, 0, gfp);
 }
 
 void nft_trans_gc_queue_sync_done(struct nft_trans_gc *trans)
-- 
2.30.2

