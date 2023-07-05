Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A487D7489C3
	for <lists+stable@lfdr.de>; Wed,  5 Jul 2023 18:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjGEQ4b (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 5 Jul 2023 12:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjGEQ4a (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 5 Jul 2023 12:56:30 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04B37171B;
        Wed,  5 Jul 2023 09:56:29 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     sashal@kernel.org, gregkh@linuxfoundation.org,
        stable@vger.kernel.org
Subject: [PATCH -stable,4.14 2/3] netfilter: nf_tables: add NFT_TRANS_PREPARE_ERROR to deal with bound set/chain
Date:   Wed,  5 Jul 2023 18:56:22 +0200
Message-Id: <20230705165623.50304-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230705165623.50304-1-pablo@netfilter.org>
References: <20230705165623.50304-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[ 26b5a5712eb85e253724e56a54c17f8519bd8e4e ]

Add a new state to deal with rule expressions deactivation from the
newrule error path, otherwise the anonymous set remains in the list in
inactive state for the next generation. Mark the set/chain transaction
as unbound so the abort path releases this object, set it as inactive in
the next generation so it is not reachable anymore from this transaction
and reference counter is dropped.

Fixes: 1240eb93f061 ("netfilter: nf_tables: incorrect error path handling with NFT_MSG_NEWRULE")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_tables.h |  1 +
 net/netfilter/nf_tables_api.c     | 26 ++++++++++++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 0d625ff7841a..d5e933e6a611 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -725,6 +725,7 @@ struct nft_expr_type {
 
 enum nft_trans_phase {
 	NFT_TRANS_PREPARE,
+	NFT_TRANS_PREPARE_ERROR,
 	NFT_TRANS_ABORT,
 	NFT_TRANS_COMMIT,
 	NFT_TRANS_RELEASE
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index a4a04c404944..624de5f25557 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -140,7 +140,8 @@ static void nft_trans_destroy(struct nft_trans *trans)
 	kfree(trans);
 }
 
-static void nft_set_trans_bind(const struct nft_ctx *ctx, struct nft_set *set)
+static void __nft_set_trans_bind(const struct nft_ctx *ctx, struct nft_set *set,
+				 bool bind)
 {
 	struct net *net = ctx->net;
 	struct nft_trans *trans;
@@ -152,16 +153,26 @@ static void nft_set_trans_bind(const struct nft_ctx *ctx, struct nft_set *set)
 		switch (trans->msg_type) {
 		case NFT_MSG_NEWSET:
 			if (nft_trans_set(trans) == set)
-				nft_trans_set_bound(trans) = true;
+				nft_trans_set_bound(trans) = bind;
 			break;
 		case NFT_MSG_NEWSETELEM:
 			if (nft_trans_elem_set(trans) == set)
-				nft_trans_elem_set_bound(trans) = true;
+				nft_trans_elem_set_bound(trans) = bind;
 			break;
 		}
 	}
 }
 
+static void nft_set_trans_bind(const struct nft_ctx *ctx, struct nft_set *set)
+{
+	return __nft_set_trans_bind(ctx, set, true);
+}
+
+static void nft_set_trans_unbind(const struct nft_ctx *ctx, struct nft_set *set)
+{
+	return __nft_set_trans_bind(ctx, set, false);
+}
+
 static int nf_tables_register_hooks(struct net *net,
 				    const struct nft_table *table,
 				    struct nft_chain *chain,
@@ -2465,7 +2476,7 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 	return 0;
 
 err2:
-	nft_rule_expr_deactivate(&ctx, rule, NFT_TRANS_PREPARE);
+	nft_rule_expr_deactivate(&ctx, rule, NFT_TRANS_PREPARE_ERROR);
 	nf_tables_rule_destroy(&ctx, rule);
 err1:
 	for (i = 0; i < n; i++) {
@@ -3446,6 +3457,13 @@ void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 			      enum nft_trans_phase phase)
 {
 	switch (phase) {
+	case NFT_TRANS_PREPARE_ERROR:
+		nft_set_trans_unbind(ctx, set);
+		if (set->flags & NFT_SET_ANONYMOUS)
+			nft_deactivate_next(ctx->net, set);
+
+		set->use--;
+		break;
 	case NFT_TRANS_PREPARE:
 		if (set->flags & NFT_SET_ANONYMOUS)
 			nft_deactivate_next(ctx->net, set);
-- 
2.30.2

