Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D30A7AB5FB
	for <lists+stable@lfdr.de>; Fri, 22 Sep 2023 18:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjIVQbG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 22 Sep 2023 12:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjIVQbE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 22 Sep 2023 12:31:04 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB545194;
        Fri, 22 Sep 2023 09:30:58 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     stable@vger.kernel.org, gregkh@linuxfoundation.org,
        sashal@kernel.org
Subject: [-stable,6.1 11/17] netfilter: nf_tables: defer gc run if previous batch is still pending
Date:   Fri, 22 Sep 2023 18:30:23 +0200
Message-Id: <20230922163029.150988-12-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230922163029.150988-1-pablo@netfilter.org>
References: <20230922163029.150988-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

commit 8e51830e29e12670b4c10df070a4ea4c9593e961 upstream.

Don't queue more gc work, else we may queue the same elements multiple
times.

If an element is flagged as dead, this can mean that either the previous
gc request was invalidated/discarded by a transaction or that the previous
request is still pending in the system work queue.

The latter will happen if the gc interval is set to a very low value,
e.g. 1ms, and system work queue is backlogged.

The sets refcount is 1 if no previous gc requeusts are queued, so add
a helper for this and skip gc run if old requests are pending.

Add a helper for this and skip the gc run in this case.

Fixes: f6c383b8c31a ("netfilter: nf_tables: adapt set backend to use GC transaction API")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/netfilter/nf_tables.h | 5 +++++
 net/netfilter/nft_set_hash.c      | 3 +++
 net/netfilter/nft_set_rbtree.c    | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 2d501dd90152..12777a5b60cd 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -581,6 +581,11 @@ static inline void *nft_set_priv(const struct nft_set *set)
 	return (void *)set->data;
 }
 
+static inline bool nft_set_gc_is_pending(const struct nft_set *s)
+{
+	return refcount_read(&s->refs) != 1;
+}
+
 static inline struct nft_set *nft_set_container_of(const void *priv)
 {
 	return (void *)priv - offsetof(struct nft_set, data);
diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index cef5df846000..524763659f25 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -326,6 +326,9 @@ static void nft_rhash_gc(struct work_struct *work)
 	nft_net = nft_pernet(net);
 	gc_seq = READ_ONCE(nft_net->gc_seq);
 
+	if (nft_set_gc_is_pending(set))
+		goto done;
+
 	gc = nft_trans_gc_alloc(set, gc_seq, GFP_KERNEL);
 	if (!gc)
 		goto done;
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index f9d4c8fcbbf8..c6435e709231 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -611,6 +611,9 @@ static void nft_rbtree_gc(struct work_struct *work)
 	nft_net = nft_pernet(net);
 	gc_seq  = READ_ONCE(nft_net->gc_seq);
 
+	if (nft_set_gc_is_pending(set))
+		goto done;
+
 	gc = nft_trans_gc_alloc(set, gc_seq, GFP_KERNEL);
 	if (!gc)
 		goto done;
-- 
2.30.2

