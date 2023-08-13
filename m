Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30AE77A399
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 00:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjHLWJq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 18:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjHLWJp (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 18:09:45 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 212071704;
        Sat, 12 Aug 2023 15:09:48 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        sashal@kernel.org
Subject: [PATCH -stable,4.14 1/1] netfilter: nf_tables: report use refcount overflow
Date:   Sun, 13 Aug 2023 00:09:41 +0200
Message-Id: <20230812220941.56747-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230812220941.56747-1-pablo@netfilter.org>
References: <20230812220941.56747-1-pablo@netfilter.org>
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

commit 1689f25924ada8fe14a4a82c38925d04994c7142 upstream.

Overflow use refcount checks are not complete.

Add helper function to deal with object reference counter tracking.
Report -EMFILE in case UINT_MAX is reached.

nft_use_dec() splats in case that reference counter underflows,
which should not ever happen.

Add nft_use_inc_restore() and nft_use_dec_restore() which are used
to restore reference counter from error and abort paths.

Use u32 in nft_flowtable and nft_object since helper functions cannot
work on bitfields.

Remove the few early incomplete checks now that the helper functions
are in place and used to check for refcount overflow.

Fixes: 96518518cc41 ("netfilter: add nftables")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_tables.h |  27 +++++-
 net/netfilter/nf_tables_api.c     | 143 +++++++++++++++++++-----------
 net/netfilter/nft_objref.c        |   8 +-
 3 files changed, 119 insertions(+), 59 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index d5e933e6a611..e71e155f3b88 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -968,6 +968,29 @@ int __nft_release_basechain(struct nft_ctx *ctx);
 
 unsigned int nft_do_chain(struct nft_pktinfo *pkt, void *priv);
 
+static inline bool nft_use_inc(u32 *use)
+{
+	if (*use == UINT_MAX)
+		return false;
+
+	(*use)++;
+
+	return true;
+}
+
+static inline void nft_use_dec(u32 *use)
+{
+	WARN_ON_ONCE((*use)-- == 0);
+}
+
+/* For error and abort path: restore use counter to previous state. */
+static inline void nft_use_inc_restore(u32 *use)
+{
+	WARN_ON_ONCE(!nft_use_inc(use));
+}
+
+#define nft_use_dec_restore	nft_use_dec
+
 /**
  *	struct nft_table - nf_tables table
  *
@@ -1051,8 +1074,8 @@ struct nft_object {
 	struct list_head		list;
 	char				*name;
 	struct nft_table		*table;
-	u32				genmask:2,
-					use:30;
+	u32				genmask:2;
+	u32				use;
 	/* runtime data below here */
 	const struct nft_object_ops	*ops ____cacheline_aligned;
 	unsigned char			data[]
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index b016ae68d9db..e3c4fb6d5408 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -248,7 +248,7 @@ static int nft_delchain(struct nft_ctx *ctx)
 	if (err < 0)
 		return err;
 
-	ctx->table->use--;
+	nft_use_dec(&ctx->table->use);
 	nft_deactivate_next(ctx->net, ctx->chain);
 
 	return err;
@@ -289,7 +289,7 @@ nf_tables_delrule_deactivate(struct nft_ctx *ctx, struct nft_rule *rule)
 	/* You cannot delete the same rule twice */
 	if (nft_is_active_next(ctx->net, rule)) {
 		nft_deactivate_next(ctx->net, rule);
-		ctx->chain->use--;
+		nft_use_dec(&ctx->chain->use);
 		return 0;
 	}
 	return -ENOENT;
@@ -378,7 +378,7 @@ static int nft_delset(const struct nft_ctx *ctx, struct nft_set *set)
 		return err;
 
 	nft_deactivate_next(ctx->net, set);
-	ctx->table->use--;
+	nft_use_dec(&ctx->table->use);
 
 	return err;
 }
@@ -410,7 +410,7 @@ static int nft_delobj(struct nft_ctx *ctx, struct nft_object *obj)
 		return err;
 
 	nft_deactivate_next(ctx->net, obj);
-	ctx->table->use--;
+	nft_use_dec(&ctx->table->use);
 
 	return err;
 }
@@ -1421,9 +1421,6 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 	unsigned int i;
 	int err;
 
-	if (table->use == UINT_MAX)
-		return -EOVERFLOW;
-
 	if (nla[NFTA_CHAIN_HOOK]) {
 		struct nft_chain_hook hook;
 		struct nf_hook_ops *ops;
@@ -1491,16 +1488,22 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 	if (err < 0)
 		goto err1;
 
+	if (!nft_use_inc(&table->use)) {
+		err = -EMFILE;
+		goto err_use;
+	}
+
 	ctx->chain = chain;
 	err = nft_trans_chain_add(ctx, NFT_MSG_NEWCHAIN);
 	if (err < 0)
 		goto err2;
 
-	table->use++;
 	list_add_tail_rcu(&chain->list, &table->chains);
 
 	return 0;
 err2:
+	nft_use_dec_restore(&table->use);
+err_use:
 	nf_tables_unregister_hooks(net, table, chain, afi->nops);
 err1:
 	nf_tables_chain_destroy(chain);
@@ -2371,9 +2374,6 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 		if (!create || nlh->nlmsg_flags & NLM_F_REPLACE)
 			return -EINVAL;
 		handle = nf_tables_alloc_handle(table);
-
-		if (chain->use == UINT_MAX)
-			return -EOVERFLOW;
 	}
 
 	if (nla[NFTA_RULE_POSITION]) {
@@ -2441,23 +2441,28 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 		expr = nft_expr_next(expr);
 	}
 
+	if (!nft_use_inc(&chain->use)) {
+		err = -EMFILE;
+		goto err2;
+	}
+
 	if (nlh->nlmsg_flags & NLM_F_REPLACE) {
 		trans = nft_trans_rule_add(&ctx, NFT_MSG_NEWRULE, rule);
 		if (trans == NULL) {
 			err = -ENOMEM;
-			goto err2;
+			goto err_destroy_flow_rule;
 		}
 		err = nft_delrule(&ctx, old_rule);
 		if (err < 0) {
 			nft_trans_destroy(trans);
-			goto err2;
+			goto err_destroy_flow_rule;
 		}
 
 		list_add_tail_rcu(&rule->list, &old_rule->list);
 	} else {
 		if (nft_trans_rule_add(&ctx, NFT_MSG_NEWRULE, rule) == NULL) {
 			err = -ENOMEM;
-			goto err2;
+			goto err_destroy_flow_rule;
 		}
 
 		if (nlh->nlmsg_flags & NLM_F_APPEND) {
@@ -2472,9 +2477,11 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 				list_add_rcu(&rule->list, &chain->rules);
 		}
 	}
-	chain->use++;
+
 	return 0;
 
+err_destroy_flow_rule:
+	nft_use_dec_restore(&chain->use);
 err2:
 	nft_rule_expr_deactivate(&ctx, rule, NFT_TRANS_PREPARE_ERROR);
 	nf_tables_rule_destroy(&ctx, rule);
@@ -3262,10 +3269,15 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 	if (ops->privsize != NULL)
 		size = ops->privsize(nla, &desc);
 
+	if (!nft_use_inc(&table->use)) {
+		err = -EMFILE;
+		goto err1;
+	}
+
 	set = kvzalloc(sizeof(*set) + size + udlen, GFP_KERNEL);
 	if (!set) {
 		err = -ENOMEM;
-		goto err1;
+		goto err_alloc;
 	}
 
 	name = nla_strdup(nla[NFTA_SET_NAME], GFP_KERNEL);
@@ -3310,7 +3322,7 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 		goto err4;
 
 	list_add_tail_rcu(&set->list, &table->sets);
-	table->use++;
+
 	return 0;
 
 err4:
@@ -3319,6 +3331,8 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 	kfree(set->name);
 err2:
 	kvfree(set);
+err_alloc:
+	nft_use_dec_restore(&table->use);
 err1:
 	module_put(ops->type->owner);
 	return err;
@@ -3393,9 +3407,6 @@ int nf_tables_bind_set(const struct nft_ctx *ctx, struct nft_set *set,
 	struct nft_set_binding *i;
 	struct nft_set_iter iter;
 
-	if (set->use == UINT_MAX)
-		return -EOVERFLOW;
-
 	if (!list_empty(&set->bindings) && set->flags & NFT_SET_ANONYMOUS)
 		return -EBUSY;
 
@@ -3420,10 +3431,12 @@ int nf_tables_bind_set(const struct nft_ctx *ctx, struct nft_set *set,
 			return iter.err;
 	}
 bind:
+	if (!nft_use_inc(&set->use))
+		return -EMFILE;
+
 	binding->chain = ctx->chain;
 	list_add_tail_rcu(&binding->list, &set->bindings);
 	nft_set_trans_bind(ctx, set);
-	set->use++;
 
 	return 0;
 }
@@ -3448,7 +3461,7 @@ void nf_tables_activate_set(const struct nft_ctx *ctx, struct nft_set *set)
 	if (set->flags & NFT_SET_ANONYMOUS)
 		nft_clear(ctx->net, set);
 
-	set->use++;
+	nft_use_inc_restore(&set->use);
 }
 EXPORT_SYMBOL_GPL(nf_tables_activate_set);
 
@@ -3464,17 +3477,17 @@ void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 		else
 			list_del_rcu(&binding->list);
 
-		set->use--;
+		nft_use_dec(&set->use);
 		break;
 	case NFT_TRANS_PREPARE:
 		if (set->flags & NFT_SET_ANONYMOUS)
 			nft_deactivate_next(ctx->net, set);
 
-		set->use--;
+		nft_use_dec(&set->use);
 		return;
 	case NFT_TRANS_ABORT:
 	case NFT_TRANS_RELEASE:
-		set->use--;
+		nft_use_dec(&set->use);
 		/* fall through */
 	default:
 		nf_tables_unbind_set(ctx, set, binding,
@@ -3947,7 +3960,7 @@ void nft_set_elem_destroy(const struct nft_set *set, void *elem,
 	if (destroy_expr && nft_set_ext_exists(ext, NFT_SET_EXT_EXPR))
 		nf_tables_expr_destroy(NULL, nft_set_ext_expr(ext));
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_OBJREF))
-		(*nft_set_ext_obj(ext))->use--;
+		nft_use_dec(&(*nft_set_ext_obj(ext))->use);
 	kfree(elem);
 }
 EXPORT_SYMBOL_GPL(nft_set_elem_destroy);
@@ -4090,8 +4103,16 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 					   set->objtype, genmask);
 		if (IS_ERR(obj)) {
 			err = PTR_ERR(obj);
+			obj = NULL;
 			goto err2;
 		}
+
+		if (!nft_use_inc(&obj->use)) {
+			err = -EMFILE;
+			obj = NULL;
+			goto err2;
+		}
+
 		nft_set_ext_add(&tmpl, NFT_SET_EXT_OBJREF);
 	}
 
@@ -4150,10 +4171,8 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 		udata->len = ulen - 1;
 		nla_memcpy(&udata->data, nla[NFTA_SET_ELEM_USERDATA], ulen);
 	}
-	if (obj) {
+	if (obj)
 		*nft_set_ext_obj(ext) = obj;
-		obj->use++;
-	}
 
 	trans = nft_trans_elem_alloc(ctx, NFT_MSG_NEWSETELEM, set);
 	if (trans == NULL)
@@ -4199,13 +4218,14 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 err5:
 	kfree(trans);
 err4:
-	if (obj)
-		obj->use--;
 	kfree(elem.priv);
 err3:
 	if (nla[NFTA_SET_ELEM_DATA] != NULL)
 		nft_data_release(&elem.data.val, desc.type);
 err2:
+	if (obj)
+		nft_use_dec_restore(&obj->use);
+
 	nft_data_release(&elem.key.val, NFT_DATA_VALUE);
 err1:
 	return err;
@@ -4266,11 +4286,14 @@ static int nf_tables_newsetelem(struct net *net, struct sock *nlsk,
  */
 void nft_data_hold(const struct nft_data *data, enum nft_data_types type)
 {
+	struct nft_chain *chain;
+
 	if (type == NFT_DATA_VERDICT) {
 		switch (data->verdict.code) {
 		case NFT_JUMP:
 		case NFT_GOTO:
-			data->verdict.chain->use++;
+			chain = data->verdict.chain;
+			nft_use_inc_restore(&chain->use);
 			break;
 		}
 	}
@@ -4285,7 +4308,7 @@ static void nft_set_elem_activate(const struct net *net,
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_DATA))
 		nft_data_hold(nft_set_ext_data(ext), set->dtype);
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_OBJREF))
-		(*nft_set_ext_obj(ext))->use++;
+		nft_use_inc_restore(&(*nft_set_ext_obj(ext))->use);
 }
 
 static void nft_set_elem_deactivate(const struct net *net,
@@ -4297,7 +4320,7 @@ static void nft_set_elem_deactivate(const struct net *net,
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_DATA))
 		nft_data_release(nft_set_ext_data(ext), set->dtype);
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_OBJREF))
-		(*nft_set_ext_obj(ext))->use--;
+		nft_use_dec(&(*nft_set_ext_obj(ext))->use);
 }
 
 static int nft_del_setelem(struct nft_ctx *ctx, struct nft_set *set,
@@ -4672,9 +4695,14 @@ static int nf_tables_newobj(struct net *net, struct sock *nlsk,
 
 	nft_ctx_init(&ctx, net, skb, nlh, afi, table, NULL, nla);
 
+	if (!nft_use_inc(&table->use))
+		return -EMFILE;
+
 	type = nft_obj_type_get(objtype);
-	if (IS_ERR(type))
-		return PTR_ERR(type);
+	if (IS_ERR(type)) {
+		err = PTR_ERR(type);
+		goto err_type;
+	}
 
 	obj = nft_obj_init(&ctx, type, nla[NFTA_OBJ_DATA]);
 	if (IS_ERR(obj)) {
@@ -4693,7 +4721,7 @@ static int nf_tables_newobj(struct net *net, struct sock *nlsk,
 		goto err3;
 
 	list_add_tail_rcu(&obj->list, &table->objects);
-	table->use++;
+
 	return 0;
 err3:
 	kfree(obj->name);
@@ -4703,6 +4731,9 @@ static int nf_tables_newobj(struct net *net, struct sock *nlsk,
 	kfree(obj);
 err1:
 	module_put(type->owner);
+err_type:
+	nft_use_dec_restore(&table->use);
+
 	return err;
 }
 
@@ -5304,7 +5335,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 			 */
 			if (nft_trans_set(trans)->flags & NFT_SET_ANONYMOUS &&
 			    !list_empty(&nft_trans_set(trans)->bindings))
-				trans->ctx.table->use--;
+				nft_use_dec(&trans->ctx.table->use);
 
 			nf_tables_set_notify(&trans->ctx, nft_trans_set(trans),
 					     NFT_MSG_NEWSET, GFP_KERNEL);
@@ -5418,7 +5449,7 @@ static int nf_tables_abort(struct net *net, struct sk_buff *skb)
 				kfree(nft_trans_chain_name(trans));
 				nft_trans_destroy(trans);
 			} else {
-				trans->ctx.table->use--;
+				nft_use_dec_restore(&trans->ctx.table->use);
 				list_del_rcu(&trans->ctx.chain->list);
 				nf_tables_unregister_hooks(trans->ctx.net,
 							   trans->ctx.table,
@@ -5427,25 +5458,25 @@ static int nf_tables_abort(struct net *net, struct sk_buff *skb)
 			}
 			break;
 		case NFT_MSG_DELCHAIN:
-			trans->ctx.table->use++;
+			nft_use_inc_restore(&trans->ctx.table->use);
 			nft_clear(trans->ctx.net, trans->ctx.chain);
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_NEWRULE:
-			trans->ctx.chain->use--;
+			nft_use_dec_restore(&trans->ctx.chain->use);
 			list_del_rcu(&nft_trans_rule(trans)->list);
 			nft_rule_expr_deactivate(&trans->ctx,
 						 nft_trans_rule(trans),
 						 NFT_TRANS_ABORT);
 			break;
 		case NFT_MSG_DELRULE:
-			trans->ctx.chain->use++;
+			nft_use_inc_restore(&trans->ctx.chain->use);
 			nft_clear(trans->ctx.net, nft_trans_rule(trans));
 			nft_rule_expr_activate(&trans->ctx, nft_trans_rule(trans));
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_NEWSET:
-			trans->ctx.table->use--;
+			nft_use_dec_restore(&trans->ctx.table->use);
 			if (nft_trans_set_bound(trans)) {
 				nft_trans_destroy(trans);
 				break;
@@ -5453,7 +5484,7 @@ static int nf_tables_abort(struct net *net, struct sk_buff *skb)
 			list_del_rcu(&nft_trans_set(trans)->list);
 			break;
 		case NFT_MSG_DELSET:
-			trans->ctx.table->use++;
+			nft_use_inc_restore(&trans->ctx.table->use);
 			nft_clear(trans->ctx.net, nft_trans_set(trans));
 			nft_trans_destroy(trans);
 			break;
@@ -5477,11 +5508,11 @@ static int nf_tables_abort(struct net *net, struct sk_buff *skb)
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_NEWOBJ:
-			trans->ctx.table->use--;
+			nft_use_dec_restore(&trans->ctx.table->use);
 			list_del_rcu(&nft_trans_obj(trans)->list);
 			break;
 		case NFT_MSG_DELOBJ:
-			trans->ctx.table->use++;
+			nft_use_inc_restore(&trans->ctx.table->use);
 			nft_clear(trans->ctx.net, nft_trans_obj(trans));
 			nft_trans_destroy(trans);
 			break;
@@ -5879,8 +5910,9 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 			return PTR_ERR(chain);
 		if (nft_is_base_chain(chain))
 			return -EOPNOTSUPP;
+		if (!nft_use_inc(&chain->use))
+			return -EMFILE;
 
-		chain->use++;
 		data->verdict.chain = chain;
 		break;
 	}
@@ -5892,10 +5924,13 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 
 static void nft_verdict_uninit(const struct nft_data *data)
 {
+	struct nft_chain *chain;
+
 	switch (data->verdict.code) {
 	case NFT_JUMP:
 	case NFT_GOTO:
-		data->verdict.chain->use--;
+		chain = data->verdict.chain;
+		nft_use_dec(&chain->use);
 		break;
 	}
 }
@@ -6056,11 +6091,11 @@ int __nft_release_basechain(struct nft_ctx *ctx)
 				   ctx->afi->nops);
 	list_for_each_entry_safe(rule, nr, &ctx->chain->rules, list) {
 		list_del(&rule->list);
-		ctx->chain->use--;
+		nft_use_dec(&ctx->chain->use);
 		nf_tables_rule_release(ctx, rule);
 	}
 	list_del(&ctx->chain->list);
-	ctx->table->use--;
+	nft_use_dec(&ctx->table->use);
 	nf_tables_chain_destroy(ctx->chain);
 
 	return 0;
@@ -6090,23 +6125,23 @@ static void __nft_release_afinfo(struct net *net, struct nft_af_info *afi)
 			ctx.chain = chain;
 			list_for_each_entry_safe(rule, nr, &chain->rules, list) {
 				list_del(&rule->list);
-				chain->use--;
+				nft_use_dec(&chain->use);
 				nf_tables_rule_release(&ctx, rule);
 			}
 		}
 		list_for_each_entry_safe(set, ns, &table->sets, list) {
 			list_del(&set->list);
-			table->use--;
+			nft_use_dec(&table->use);
 			nft_set_destroy(set);
 		}
 		list_for_each_entry_safe(obj, ne, &table->objects, list) {
 			list_del(&obj->list);
-			table->use--;
+			nft_use_dec(&table->use);
 			nft_obj_destroy(obj);
 		}
 		list_for_each_entry_safe(chain, nc, &table->chains, list) {
 			list_del(&chain->list);
-			table->use--;
+			nft_use_dec(&table->use);
 			nf_tables_chain_destroy(chain);
 		}
 		list_del(&table->list);
diff --git a/net/netfilter/nft_objref.c b/net/netfilter/nft_objref.c
index 8ad0be6c53fd..f3c5d4b14657 100644
--- a/net/netfilter/nft_objref.c
+++ b/net/netfilter/nft_objref.c
@@ -43,8 +43,10 @@ static int nft_objref_init(const struct nft_ctx *ctx,
 	if (IS_ERR(obj))
 		return -ENOENT;
 
+	if (!nft_use_inc(&obj->use))
+		return -EMFILE;
+
 	nft_objref_priv(expr) = obj;
-	obj->use++;
 
 	return 0;
 }
@@ -73,7 +75,7 @@ static void nft_objref_deactivate(const struct nft_ctx *ctx,
 	if (phase == NFT_TRANS_COMMIT)
 		return;
 
-	obj->use--;
+	nft_use_dec(&obj->use);
 }
 
 static void nft_objref_activate(const struct nft_ctx *ctx,
@@ -81,7 +83,7 @@ static void nft_objref_activate(const struct nft_ctx *ctx,
 {
 	struct nft_object *obj = nft_objref_priv(expr);
 
-	obj->use++;
+	nft_use_inc_restore(&obj->use);
 }
 
 static struct nft_expr_type nft_objref_type;
-- 
2.30.2

