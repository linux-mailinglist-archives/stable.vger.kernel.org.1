Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B50B703354
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242769AbjEOQfw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242770AbjEOQfu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:35:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA903C14
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:35:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09F2B6280D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1348DC433EF;
        Mon, 15 May 2023 16:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168545;
        bh=Fi4+X0D7WgiD/0i4TheNMs6yab0l6eq3rNifMT902FA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iDkjS3DrSJyb/PE6NEvF6cTtpYhc+nfDqw8kpku9UXgXC+w99HzCt6juBc3sB1uJo
         s5uyKI/iwlA741LNMNmVL4uBAtae4NDuQw/OcqX7KdTQkGZzp5k0G2kMfeRdc+03Rp
         0jYkEIytDf1TNZ0TDw/23BiITyLQb/7g2WKMQxuc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mikhail Morfikov <mmorfikov@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 084/116] netfilter: nf_tables: unbind set in rule from commit path
Date:   Mon, 15 May 2023 18:26:21 +0200
Message-Id: <20230515161701.066941450@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161658.228491273@linuxfoundation.org>
References: <20230515161658.228491273@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ backport for 4.14 of f6ac8585897684374a19863fff21186a05805286 ]

Anonymous sets that are bound to rules from the same transaction trigger
a kernel splat from the abort path due to double set list removal and
double free.

This patch updates the logic to search for the transaction that is
responsible for creating the set and disable the set list removal and
release, given the rule is now responsible for this. Lookup is reverse
since the transaction that adds the set is likely to be at the tail of
the list.

Moreover, this patch adds the unbind step to deliver the event from the
commit path.  This should not be done from the worker thread, since we
have no guarantees of in-order delivery to the listener.

This patch removes the assumption that both activate and deactivate
callbacks need to be provided.

Fixes: cd5125d8f518 ("netfilter: nf_tables: split set destruction in deactivate and destroy phase")
Reported-by: Mikhail Morfikov <mmorfikov@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_tables.h | 17 +++++--
 net/netfilter/nf_tables_api.c     | 85 +++++++++++++++----------------
 net/netfilter/nft_dynset.c        | 18 +++----
 net/netfilter/nft_immediate.c     |  6 ++-
 net/netfilter/nft_lookup.c        | 18 +++----
 net/netfilter/nft_objref.c        | 18 +++----
 6 files changed, 80 insertions(+), 82 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 59da90bb840d9..cc6ba7e593e74 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -462,9 +462,7 @@ struct nft_set_binding {
 int nf_tables_bind_set(const struct nft_ctx *ctx, struct nft_set *set,
 		       struct nft_set_binding *binding);
 void nf_tables_unbind_set(const struct nft_ctx *ctx, struct nft_set *set,
-			  struct nft_set_binding *binding);
-void nf_tables_rebind_set(const struct nft_ctx *ctx, struct nft_set *set,
-			  struct nft_set_binding *binding);
+			  struct nft_set_binding *binding, bool commit);
 void nf_tables_destroy_set(const struct nft_ctx *ctx, struct nft_set *set);
 
 /**
@@ -713,6 +711,13 @@ struct nft_expr_type {
 
 #define NFT_EXPR_STATEFUL		0x1
 
+enum nft_trans_phase {
+	NFT_TRANS_PREPARE,
+	NFT_TRANS_ABORT,
+	NFT_TRANS_COMMIT,
+	NFT_TRANS_RELEASE
+};
+
 /**
  *	struct nft_expr_ops - nf_tables expression operations
  *
@@ -742,7 +747,8 @@ struct nft_expr_ops {
 	void				(*activate)(const struct nft_ctx *ctx,
 						    const struct nft_expr *expr);
 	void				(*deactivate)(const struct nft_ctx *ctx,
-						      const struct nft_expr *expr);
+						      const struct nft_expr *expr,
+						      enum nft_trans_phase phase);
 	void				(*destroy)(const struct nft_ctx *ctx,
 						   const struct nft_expr *expr);
 	int				(*dump)(struct sk_buff *skb,
@@ -1290,12 +1296,15 @@ struct nft_trans_rule {
 struct nft_trans_set {
 	struct nft_set			*set;
 	u32				set_id;
+	bool				bound;
 };
 
 #define nft_trans_set(trans)	\
 	(((struct nft_trans_set *)trans->data)->set)
 #define nft_trans_set_id(trans)	\
 	(((struct nft_trans_set *)trans->data)->set_id)
+#define nft_trans_set_bound(trans)	\
+	(((struct nft_trans_set *)trans->data)->bound)
 
 struct nft_trans_chain {
 	bool				update;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 39416c568d181..5541ba7cc4a01 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -140,6 +140,23 @@ static void nft_trans_destroy(struct nft_trans *trans)
 	kfree(trans);
 }
 
+static void nft_set_trans_bind(const struct nft_ctx *ctx, struct nft_set *set)
+{
+	struct net *net = ctx->net;
+	struct nft_trans *trans;
+
+	if (!(set->flags & NFT_SET_ANONYMOUS))
+		return;
+
+	list_for_each_entry_reverse(trans, &net->nft.commit_list, list) {
+		if (trans->msg_type == NFT_MSG_NEWSET &&
+		    nft_trans_set(trans) == set) {
+			nft_trans_set_bound(trans) = true;
+			break;
+		}
+	}
+}
+
 static int nf_tables_register_hooks(struct net *net,
 				    const struct nft_table *table,
 				    struct nft_chain *chain,
@@ -221,18 +238,6 @@ static int nft_delchain(struct nft_ctx *ctx)
 	return err;
 }
 
-/* either expr ops provide both activate/deactivate, or neither */
-static bool nft_expr_check_ops(const struct nft_expr_ops *ops)
-{
-	if (!ops)
-		return true;
-
-	if (WARN_ON_ONCE((!ops->activate ^ !ops->deactivate)))
-		return false;
-
-	return true;
-}
-
 static void nft_rule_expr_activate(const struct nft_ctx *ctx,
 				   struct nft_rule *rule)
 {
@@ -248,14 +253,15 @@ static void nft_rule_expr_activate(const struct nft_ctx *ctx,
 }
 
 static void nft_rule_expr_deactivate(const struct nft_ctx *ctx,
-				     struct nft_rule *rule)
+				     struct nft_rule *rule,
+				     enum nft_trans_phase phase)
 {
 	struct nft_expr *expr;
 
 	expr = nft_expr_first(rule);
 	while (expr != nft_expr_last(rule) && expr->ops) {
 		if (expr->ops->deactivate)
-			expr->ops->deactivate(ctx, expr);
+			expr->ops->deactivate(ctx, expr, phase);
 
 		expr = nft_expr_next(expr);
 	}
@@ -306,7 +312,7 @@ static int nft_delrule(struct nft_ctx *ctx, struct nft_rule *rule)
 		nft_trans_destroy(trans);
 		return err;
 	}
-	nft_rule_expr_deactivate(ctx, rule);
+	nft_rule_expr_deactivate(ctx, rule, NFT_TRANS_PREPARE);
 
 	return 0;
 }
@@ -1737,9 +1743,6 @@ static int nf_tables_delchain(struct net *net, struct sock *nlsk,
  */
 int nft_register_expr(struct nft_expr_type *type)
 {
-	if (!nft_expr_check_ops(type->ops))
-		return -EINVAL;
-
 	nfnl_lock(NFNL_SUBSYS_NFTABLES);
 	if (type->family == NFPROTO_UNSPEC)
 		list_add_tail_rcu(&type->list, &nf_tables_expressions);
@@ -1889,10 +1892,6 @@ static int nf_tables_expr_parse(const struct nft_ctx *ctx,
 			err = PTR_ERR(ops);
 			goto err1;
 		}
-		if (!nft_expr_check_ops(ops)) {
-			err = -EINVAL;
-			goto err1;
-		}
 	} else
 		ops = type->ops;
 
@@ -2297,7 +2296,7 @@ static void nf_tables_rule_destroy(const struct nft_ctx *ctx,
 static void nf_tables_rule_release(const struct nft_ctx *ctx,
 				   struct nft_rule *rule)
 {
-	nft_rule_expr_deactivate(ctx, rule);
+	nft_rule_expr_deactivate(ctx, rule, NFT_TRANS_RELEASE);
 	nf_tables_rule_destroy(ctx, rule);
 }
 
@@ -3389,39 +3388,30 @@ int nf_tables_bind_set(const struct nft_ctx *ctx, struct nft_set *set,
 bind:
 	binding->chain = ctx->chain;
 	list_add_tail_rcu(&binding->list, &set->bindings);
+	nft_set_trans_bind(ctx, set);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nf_tables_bind_set);
 
-void nf_tables_rebind_set(const struct nft_ctx *ctx, struct nft_set *set,
-			  struct nft_set_binding *binding)
-{
-	if (list_empty(&set->bindings) && set->flags & NFT_SET_ANONYMOUS &&
-	    nft_is_active(ctx->net, set))
-		list_add_tail_rcu(&set->list, &ctx->table->sets);
-
-	list_add_tail_rcu(&binding->list, &set->bindings);
-}
-EXPORT_SYMBOL_GPL(nf_tables_rebind_set);
-
 void nf_tables_unbind_set(const struct nft_ctx *ctx, struct nft_set *set,
-		          struct nft_set_binding *binding)
+			  struct nft_set_binding *binding, bool event)
 {
 	list_del_rcu(&binding->list);
 
-	if (list_empty(&set->bindings) && set->flags & NFT_SET_ANONYMOUS &&
-	    nft_is_active(ctx->net, set))
+	if (list_empty(&set->bindings) && set->flags & NFT_SET_ANONYMOUS) {
 		list_del_rcu(&set->list);
+		if (event)
+			nf_tables_set_notify(ctx, set, NFT_MSG_DELSET,
+					     GFP_KERNEL);
+	}
 }
 EXPORT_SYMBOL_GPL(nf_tables_unbind_set);
 
 void nf_tables_destroy_set(const struct nft_ctx *ctx, struct nft_set *set)
 {
-	if (list_empty(&set->bindings) && set->flags & NFT_SET_ANONYMOUS &&
-	    nft_is_active(ctx->net, set)) {
-		nf_tables_set_notify(ctx, set, NFT_MSG_DELSET, GFP_ATOMIC);
+	if (list_empty(&set->bindings) && set->flags & NFT_SET_ANONYMOUS)
 		nft_set_destroy(set);
-	}
 }
 EXPORT_SYMBOL_GPL(nf_tables_destroy_set);
 
@@ -5197,6 +5187,9 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 			nf_tables_rule_notify(&trans->ctx,
 					      nft_trans_rule(trans),
 					      NFT_MSG_DELRULE);
+			nft_rule_expr_deactivate(&trans->ctx,
+						 nft_trans_rule(trans),
+						 NFT_TRANS_COMMIT);
 			break;
 		case NFT_MSG_NEWSET:
 			nft_clear(net, nft_trans_set(trans));
@@ -5274,7 +5267,8 @@ static void nf_tables_abort_release(struct nft_trans *trans)
 		nf_tables_rule_destroy(&trans->ctx, nft_trans_rule(trans));
 		break;
 	case NFT_MSG_NEWSET:
-		nft_set_destroy(nft_trans_set(trans));
+		if (!nft_trans_set_bound(trans))
+			nft_set_destroy(nft_trans_set(trans));
 		break;
 	case NFT_MSG_NEWSETELEM:
 		nft_set_elem_destroy(nft_trans_elem_set(trans),
@@ -5334,7 +5328,9 @@ static int nf_tables_abort(struct net *net, struct sk_buff *skb)
 		case NFT_MSG_NEWRULE:
 			trans->ctx.chain->use--;
 			list_del_rcu(&nft_trans_rule(trans)->list);
-			nft_rule_expr_deactivate(&trans->ctx, nft_trans_rule(trans));
+			nft_rule_expr_deactivate(&trans->ctx,
+						 nft_trans_rule(trans),
+						 NFT_TRANS_ABORT);
 			break;
 		case NFT_MSG_DELRULE:
 			trans->ctx.chain->use++;
@@ -5344,7 +5340,8 @@ static int nf_tables_abort(struct net *net, struct sk_buff *skb)
 			break;
 		case NFT_MSG_NEWSET:
 			trans->ctx.table->use--;
-			list_del_rcu(&nft_trans_set(trans)->list);
+			if (!nft_trans_set_bound(trans))
+				list_del_rcu(&nft_trans_set(trans)->list);
 			break;
 		case NFT_MSG_DELSET:
 			trans->ctx.table->use++;
diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index 800ca627a4577..7e0a203437408 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -223,20 +223,17 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 	return err;
 }
 
-static void nft_dynset_activate(const struct nft_ctx *ctx,
-				const struct nft_expr *expr)
-{
-	struct nft_dynset *priv = nft_expr_priv(expr);
-
-	nf_tables_rebind_set(ctx, priv->set, &priv->binding);
-}
-
 static void nft_dynset_deactivate(const struct nft_ctx *ctx,
-				  const struct nft_expr *expr)
+				  const struct nft_expr *expr,
+				  enum nft_trans_phase phase)
 {
 	struct nft_dynset *priv = nft_expr_priv(expr);
 
-	nf_tables_unbind_set(ctx, priv->set, &priv->binding);
+	if (phase == NFT_TRANS_PREPARE)
+		return;
+
+	nf_tables_unbind_set(ctx, priv->set, &priv->binding,
+			     phase == NFT_TRANS_COMMIT);
 }
 
 static void nft_dynset_destroy(const struct nft_ctx *ctx,
@@ -284,7 +281,6 @@ static const struct nft_expr_ops nft_dynset_ops = {
 	.eval		= nft_dynset_eval,
 	.init		= nft_dynset_init,
 	.destroy	= nft_dynset_destroy,
-	.activate	= nft_dynset_activate,
 	.deactivate	= nft_dynset_deactivate,
 	.dump		= nft_dynset_dump,
 };
diff --git a/net/netfilter/nft_immediate.c b/net/netfilter/nft_immediate.c
index aa87ff8beae82..86fd35018b4a6 100644
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -78,10 +78,14 @@ static void nft_immediate_activate(const struct nft_ctx *ctx,
 }
 
 static void nft_immediate_deactivate(const struct nft_ctx *ctx,
-				     const struct nft_expr *expr)
+				     const struct nft_expr *expr,
+				     enum nft_trans_phase phase)
 {
 	const struct nft_immediate_expr *priv = nft_expr_priv(expr);
 
+	if (phase == NFT_TRANS_COMMIT)
+		return;
+
 	return nft_data_release(&priv->data, nft_dreg_to_type(priv->dreg));
 }
 
diff --git a/net/netfilter/nft_lookup.c b/net/netfilter/nft_lookup.c
index c34667f4f48a5..7dd35245222c5 100644
--- a/net/netfilter/nft_lookup.c
+++ b/net/netfilter/nft_lookup.c
@@ -118,20 +118,17 @@ static int nft_lookup_init(const struct nft_ctx *ctx,
 	return 0;
 }
 
-static void nft_lookup_activate(const struct nft_ctx *ctx,
-				const struct nft_expr *expr)
-{
-	struct nft_lookup *priv = nft_expr_priv(expr);
-
-	nf_tables_rebind_set(ctx, priv->set, &priv->binding);
-}
-
 static void nft_lookup_deactivate(const struct nft_ctx *ctx,
-				  const struct nft_expr *expr)
+				  const struct nft_expr *expr,
+				  enum nft_trans_phase phase)
 {
 	struct nft_lookup *priv = nft_expr_priv(expr);
 
-	nf_tables_unbind_set(ctx, priv->set, &priv->binding);
+	if (phase == NFT_TRANS_PREPARE)
+		return;
+
+	nf_tables_unbind_set(ctx, priv->set, &priv->binding,
+			     phase == NFT_TRANS_COMMIT);
 }
 
 static void nft_lookup_destroy(const struct nft_ctx *ctx,
@@ -167,7 +164,6 @@ static const struct nft_expr_ops nft_lookup_ops = {
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_lookup)),
 	.eval		= nft_lookup_eval,
 	.init		= nft_lookup_init,
-	.activate	= nft_lookup_activate,
 	.deactivate	= nft_lookup_deactivate,
 	.destroy	= nft_lookup_destroy,
 	.dump		= nft_lookup_dump,
diff --git a/net/netfilter/nft_objref.c b/net/netfilter/nft_objref.c
index d289fa5e4eb96..f72aeff93efad 100644
--- a/net/netfilter/nft_objref.c
+++ b/net/netfilter/nft_objref.c
@@ -154,20 +154,17 @@ static int nft_objref_map_dump(struct sk_buff *skb, const struct nft_expr *expr)
 	return -1;
 }
 
-static void nft_objref_map_activate(const struct nft_ctx *ctx,
-				    const struct nft_expr *expr)
-{
-	struct nft_objref_map *priv = nft_expr_priv(expr);
-
-	nf_tables_rebind_set(ctx, priv->set, &priv->binding);
-}
-
 static void nft_objref_map_deactivate(const struct nft_ctx *ctx,
-				      const struct nft_expr *expr)
+				      const struct nft_expr *expr,
+				      enum nft_trans_phase phase)
 {
 	struct nft_objref_map *priv = nft_expr_priv(expr);
 
-	nf_tables_unbind_set(ctx, priv->set, &priv->binding);
+	if (phase == NFT_TRANS_PREPARE)
+		return;
+
+	nf_tables_unbind_set(ctx, priv->set, &priv->binding,
+			     phase == NFT_TRANS_COMMIT);
 }
 
 static void nft_objref_map_destroy(const struct nft_ctx *ctx,
@@ -184,7 +181,6 @@ static const struct nft_expr_ops nft_objref_map_ops = {
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_objref_map)),
 	.eval		= nft_objref_map_eval,
 	.init		= nft_objref_map_init,
-	.activate	= nft_objref_map_activate,
 	.deactivate	= nft_objref_map_deactivate,
 	.destroy	= nft_objref_map_destroy,
 	.dump		= nft_objref_map_dump,
-- 
2.39.2



