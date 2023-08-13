Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4057677A395
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 00:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjHLWJI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 18:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjHLWJH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 18:09:07 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEFEE1704;
        Sat, 12 Aug 2023 15:09:09 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        sashal@kernel.org
Subject: [PATCH -stable,4.19 2/2] netfilter: nf_tables: report use refcount overflow
Date:   Sun, 13 Aug 2023 00:09:03 +0200
Message-Id: <20230812220903.56667-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230812220903.56667-1-pablo@netfilter.org>
References: <20230812220903.56667-1-pablo@netfilter.org>
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
 include/net/netfilter/nf_tables.h |  31 +++++-
 net/netfilter/nf_tables_api.c     | 166 +++++++++++++++++++-----------
 net/netfilter/nft_flow_offload.c  |   6 +-
 net/netfilter/nft_objref.c        |   8 +-
 4 files changed, 140 insertions(+), 71 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 3e314808e0ac..c435eb8171cc 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -992,6 +992,29 @@ int __nft_release_basechain(struct nft_ctx *ctx);
 
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
@@ -1050,8 +1073,8 @@ struct nft_object {
 	struct list_head		list;
 	char				*name;
 	struct nft_table		*table;
-	u32				genmask:2,
-					use:30;
+	u32				genmask:2;
+	u32				use;
 	u64				handle;
 	/* runtime data below here */
 	const struct nft_object_ops	*ops ____cacheline_aligned;
@@ -1149,8 +1172,8 @@ struct nft_flowtable {
 	int				hooknum;
 	int				priority;
 	int				ops_len;
-	u32				genmask:2,
-					use:30;
+	u32				genmask:2;
+	u32				use;
 	u64				handle;
 	/* runtime data below here */
 	struct nf_hook_ops		*ops ____cacheline_aligned;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 8e34bc3001ff..99bead66af4f 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -266,7 +266,7 @@ static int nft_delchain(struct nft_ctx *ctx)
 	if (err < 0)
 		return err;
 
-	ctx->table->use--;
+	nft_use_dec(&ctx->table->use);
 	nft_deactivate_next(ctx->net, ctx->chain);
 
 	return err;
@@ -307,7 +307,7 @@ nf_tables_delrule_deactivate(struct nft_ctx *ctx, struct nft_rule *rule)
 	/* You cannot delete the same rule twice */
 	if (nft_is_active_next(ctx->net, rule)) {
 		nft_deactivate_next(ctx->net, rule);
-		ctx->chain->use--;
+		nft_use_dec(&ctx->chain->use);
 		return 0;
 	}
 	return -ENOENT;
@@ -396,7 +396,7 @@ static int nft_delset(const struct nft_ctx *ctx, struct nft_set *set)
 		return err;
 
 	nft_deactivate_next(ctx->net, set);
-	ctx->table->use--;
+	nft_use_dec(&ctx->table->use);
 
 	return err;
 }
@@ -428,7 +428,7 @@ static int nft_delobj(struct nft_ctx *ctx, struct nft_object *obj)
 		return err;
 
 	nft_deactivate_next(ctx->net, obj);
-	ctx->table->use--;
+	nft_use_dec(&ctx->table->use);
 
 	return err;
 }
@@ -462,7 +462,7 @@ static int nft_delflowtable(struct nft_ctx *ctx,
 		return err;
 
 	nft_deactivate_next(ctx->net, flowtable);
-	ctx->table->use--;
+	nft_use_dec(&ctx->table->use);
 
 	return err;
 }
@@ -1660,9 +1660,6 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 	struct nft_rule **rules;
 	int err;
 
-	if (table->use == UINT_MAX)
-		return -EOVERFLOW;
-
 	if (nla[NFTA_CHAIN_HOOK]) {
 		struct nft_chain_hook hook;
 		struct nf_hook_ops *ops;
@@ -1734,6 +1731,11 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 	if (err < 0)
 		goto err1;
 
+	if (!nft_use_inc(&table->use)) {
+		err = -EMFILE;
+		goto err_use;
+	}
+
 	err = rhltable_insert_key(&table->chains_ht, chain->name,
 				  &chain->rhlhead, nft_chain_ht_params);
 	if (err)
@@ -1746,11 +1748,12 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 		goto err2;
 	}
 
-	table->use++;
 	list_add_tail_rcu(&chain->list, &table->chains);
 
 	return 0;
 err2:
+	nft_use_dec_restore(&table->use);
+err_use:
 	nf_tables_unregister_hook(net, table, chain);
 err1:
 	nf_tables_chain_destroy(ctx);
@@ -2692,9 +2695,6 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 			return -EINVAL;
 		handle = nf_tables_alloc_handle(table);
 
-		if (chain->use == UINT_MAX)
-			return -EOVERFLOW;
-
 		if (nla[NFTA_RULE_POSITION]) {
 			pos_handle = be64_to_cpu(nla_get_be64(nla[NFTA_RULE_POSITION]));
 			old_rule = __nft_rule_lookup(chain, pos_handle);
@@ -2770,23 +2770,28 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
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
@@ -2802,12 +2807,14 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 		}
 	}
 	kvfree(info);
-	chain->use++;
 
 	if (nft_net->validate_state == NFT_VALIDATE_DO)
 		return nft_table_validate(net, table);
 
 	return 0;
+
+err_destroy_flow_rule:
+	nft_use_dec_restore(&chain->use);
 err2:
 	nft_rule_expr_deactivate(&ctx, rule, NFT_TRANS_PREPARE_ERROR);
 	nf_tables_rule_destroy(&ctx, rule);
@@ -3625,10 +3632,15 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
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
@@ -3675,7 +3687,7 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 		goto err4;
 
 	list_add_tail_rcu(&set->list, &table->sets);
-	table->use++;
+
 	return 0;
 
 err4:
@@ -3684,6 +3696,8 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 	kfree(set->name);
 err2:
 	kvfree(set);
+err_alloc:
+	nft_use_dec_restore(&table->use);
 err1:
 	module_put(to_set_type(ops)->owner);
 	return err;
@@ -3770,9 +3784,6 @@ int nf_tables_bind_set(const struct nft_ctx *ctx, struct nft_set *set,
 	struct nft_set_binding *i;
 	struct nft_set_iter iter;
 
-	if (set->use == UINT_MAX)
-		return -EOVERFLOW;
-
 	if (!list_empty(&set->bindings) && nft_set_is_anonymous(set))
 		return -EBUSY;
 
@@ -3797,10 +3808,12 @@ int nf_tables_bind_set(const struct nft_ctx *ctx, struct nft_set *set,
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
@@ -3825,7 +3838,7 @@ void nf_tables_activate_set(const struct nft_ctx *ctx, struct nft_set *set)
 	if (nft_set_is_anonymous(set))
 		nft_clear(ctx->net, set);
 
-	set->use++;
+	nft_use_inc_restore(&set->use);
 }
 EXPORT_SYMBOL_GPL(nf_tables_activate_set);
 
@@ -3841,17 +3854,17 @@ void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 		else
 			list_del_rcu(&binding->list);
 
-		set->use--;
+		nft_use_dec(&set->use);
 		break;
 	case NFT_TRANS_PREPARE:
 		if (nft_set_is_anonymous(set))
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
@@ -4433,7 +4446,7 @@ void nft_set_elem_destroy(const struct nft_set *set, void *elem,
 		}
 	}
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_OBJREF))
-		(*nft_set_ext_obj(ext))->use--;
+		nft_use_dec(&(*nft_set_ext_obj(ext))->use);
 	kfree(elem);
 }
 EXPORT_SYMBOL_GPL(nft_set_elem_destroy);
@@ -4542,8 +4555,16 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 				     set->objtype, genmask);
 		if (IS_ERR(obj)) {
 			err = PTR_ERR(obj);
+			obj = NULL;
+			goto err2;
+		}
+
+		if (!nft_use_inc(&obj->use)) {
+			err = -EMFILE;
+			obj = NULL;
 			goto err2;
 		}
+
 		nft_set_ext_add(&tmpl, NFT_SET_EXT_OBJREF);
 	}
 
@@ -4608,10 +4629,8 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
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
@@ -4657,13 +4676,14 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
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
@@ -4723,11 +4743,14 @@ static int nf_tables_newsetelem(struct net *net, struct sock *nlsk,
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
@@ -4742,7 +4765,7 @@ static void nft_set_elem_activate(const struct net *net,
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_DATA))
 		nft_data_hold(nft_set_ext_data(ext), set->dtype);
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_OBJREF))
-		(*nft_set_ext_obj(ext))->use++;
+		nft_use_inc_restore(&(*nft_set_ext_obj(ext))->use);
 }
 
 static void nft_set_elem_deactivate(const struct net *net,
@@ -4754,7 +4777,7 @@ static void nft_set_elem_deactivate(const struct net *net,
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_DATA))
 		nft_data_release(nft_set_ext_data(ext), set->dtype);
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_OBJREF))
-		(*nft_set_ext_obj(ext))->use--;
+		nft_use_dec(&(*nft_set_ext_obj(ext))->use);
 }
 
 static int nft_del_setelem(struct nft_ctx *ctx, struct nft_set *set,
@@ -5151,9 +5174,14 @@ static int nf_tables_newobj(struct net *net, struct sock *nlsk,
 
 	nft_ctx_init(&ctx, net, skb, nlh, family, table, NULL, nla);
 
+	if (!nft_use_inc(&table->use))
+		return -EMFILE;
+
 	type = nft_obj_type_get(net, objtype);
-	if (IS_ERR(type))
-		return PTR_ERR(type);
+	if (IS_ERR(type)) {
+		err = PTR_ERR(type);
+		goto err_type;
+	}
 
 	obj = nft_obj_init(&ctx, type, nla[NFTA_OBJ_DATA]);
 	if (IS_ERR(obj)) {
@@ -5174,7 +5202,7 @@ static int nf_tables_newobj(struct net *net, struct sock *nlsk,
 		goto err3;
 
 	list_add_tail_rcu(&obj->list, &table->objects);
-	table->use++;
+
 	return 0;
 err3:
 	kfree(obj->name);
@@ -5184,6 +5212,9 @@ static int nf_tables_newobj(struct net *net, struct sock *nlsk,
 	kfree(obj);
 err1:
 	module_put(type->owner);
+err_type:
+	nft_use_dec_restore(&table->use);
+
 	return err;
 }
 
@@ -5527,7 +5558,7 @@ void nf_tables_deactivate_flowtable(const struct nft_ctx *ctx,
 	case NFT_TRANS_PREPARE:
 	case NFT_TRANS_ABORT:
 	case NFT_TRANS_RELEASE:
-		flowtable->use--;
+		nft_use_dec(&flowtable->use);
 		/* fall through */
 	default:
 		return;
@@ -5734,9 +5765,14 @@ static int nf_tables_newflowtable(struct net *net, struct sock *nlsk,
 
 	nft_ctx_init(&ctx, net, skb, nlh, family, table, NULL, nla);
 
+	if (!nft_use_inc(&table->use))
+		return -EMFILE;
+
 	flowtable = kzalloc(sizeof(*flowtable), GFP_KERNEL);
-	if (!flowtable)
-		return -ENOMEM;
+	if (!flowtable) {
+		err = -ENOMEM;
+		goto flowtable_alloc;
+	}
 
 	flowtable->table = table;
 	flowtable->handle = nf_tables_alloc_handle(table);
@@ -5790,7 +5826,6 @@ static int nf_tables_newflowtable(struct net *net, struct sock *nlsk,
 		goto err6;
 
 	list_add_tail_rcu(&flowtable->list, &table->flowtables);
-	table->use++;
 
 	return 0;
 err6:
@@ -5808,6 +5843,9 @@ static int nf_tables_newflowtable(struct net *net, struct sock *nlsk,
 	kfree(flowtable->name);
 err1:
 	kfree(flowtable);
+flowtable_alloc:
+	nft_use_dec_restore(&table->use);
+
 	return err;
 }
 
@@ -6682,7 +6720,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 			 */
 			if (nft_set_is_anonymous(nft_trans_set(trans)) &&
 			    !list_empty(&nft_trans_set(trans)->bindings))
-				trans->ctx.table->use--;
+				nft_use_dec(&trans->ctx.table->use);
 
 			nf_tables_set_notify(&trans->ctx, nft_trans_set(trans),
 					     NFT_MSG_NEWSET, GFP_KERNEL);
@@ -6808,7 +6846,7 @@ static int __nf_tables_abort(struct net *net)
 				kfree(nft_trans_chain_name(trans));
 				nft_trans_destroy(trans);
 			} else {
-				trans->ctx.table->use--;
+				nft_use_dec_restore(&trans->ctx.table->use);
 				nft_chain_del(trans->ctx.chain);
 				nf_tables_unregister_hook(trans->ctx.net,
 							  trans->ctx.table,
@@ -6816,25 +6854,25 @@ static int __nf_tables_abort(struct net *net)
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
@@ -6842,7 +6880,7 @@ static int __nf_tables_abort(struct net *net)
 			list_del_rcu(&nft_trans_set(trans)->list);
 			break;
 		case NFT_MSG_DELSET:
-			trans->ctx.table->use++;
+			nft_use_inc_restore(&trans->ctx.table->use);
 			nft_clear(trans->ctx.net, nft_trans_set(trans));
 			nft_trans_destroy(trans);
 			break;
@@ -6865,22 +6903,22 @@ static int __nf_tables_abort(struct net *net)
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
 		case NFT_MSG_NEWFLOWTABLE:
-			trans->ctx.table->use--;
+			nft_use_dec_restore(&trans->ctx.table->use);
 			list_del_rcu(&nft_trans_flowtable(trans)->list);
 			nft_unregister_flowtable_net_hooks(net,
 					nft_trans_flowtable(trans));
 			break;
 		case NFT_MSG_DELFLOWTABLE:
-			trans->ctx.table->use++;
+			nft_use_inc_restore(&trans->ctx.table->use);
 			nft_clear(trans->ctx.net, nft_trans_flowtable(trans));
 			nft_trans_destroy(trans);
 			break;
@@ -7291,8 +7329,9 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 			return PTR_ERR(chain);
 		if (nft_is_base_chain(chain))
 			return -EOPNOTSUPP;
+		if (!nft_use_inc(&chain->use))
+			return -EMFILE;
 
-		chain->use++;
 		data->verdict.chain = chain;
 		break;
 	}
@@ -7304,10 +7343,13 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 
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
@@ -7460,11 +7502,11 @@ int __nft_release_basechain(struct nft_ctx *ctx)
 	nf_tables_unregister_hook(ctx->net, ctx->chain->table, ctx->chain);
 	list_for_each_entry_safe(rule, nr, &ctx->chain->rules, list) {
 		list_del(&rule->list);
-		ctx->chain->use--;
+		nft_use_dec(&ctx->chain->use);
 		nf_tables_rule_release(ctx, rule);
 	}
 	nft_chain_del(ctx->chain);
-	ctx->table->use--;
+	nft_use_dec(&ctx->table->use);
 	nf_tables_chain_destroy(ctx);
 
 	return 0;
@@ -7493,29 +7535,29 @@ static void __nft_release_table(struct net *net, struct nft_table *table)
 		ctx.chain = chain;
 		list_for_each_entry_safe(rule, nr, &chain->rules, list) {
 			list_del(&rule->list);
-			chain->use--;
+			nft_use_dec(&chain->use);
 			nf_tables_rule_release(&ctx, rule);
 		}
 	}
 	list_for_each_entry_safe(flowtable, nf, &table->flowtables, list) {
 		list_del(&flowtable->list);
-		table->use--;
+		nft_use_dec(&table->use);
 		nf_tables_flowtable_destroy(flowtable);
 	}
 	list_for_each_entry_safe(set, ns, &table->sets, list) {
 		list_del(&set->list);
-		table->use--;
+		nft_use_dec(&table->use);
 		nft_set_destroy(set);
 	}
 	list_for_each_entry_safe(obj, ne, &table->objects, list) {
 		list_del(&obj->list);
-		table->use--;
+		nft_use_dec(&table->use);
 		nft_obj_destroy(&ctx, obj);
 	}
 	list_for_each_entry_safe(chain, nc, &table->chains, list) {
 		ctx.chain = chain;
 		nft_chain_del(chain);
-		table->use--;
+		nft_use_dec(&table->use);
 		nf_tables_chain_destroy(&ctx);
 	}
 	list_del(&table->list);
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index c78f7bd4c1db..7055088e91c2 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -169,8 +169,10 @@ static int nft_flow_offload_init(const struct nft_ctx *ctx,
 	if (IS_ERR(flowtable))
 		return PTR_ERR(flowtable);
 
+	if (!nft_use_inc(&flowtable->use))
+		return -EMFILE;
+
 	priv->flowtable = flowtable;
-	flowtable->use++;
 
 	return nf_ct_netns_get(ctx->net, ctx->family);
 }
@@ -189,7 +191,7 @@ static void nft_flow_offload_activate(const struct nft_ctx *ctx,
 {
 	struct nft_flow_offload *priv = nft_expr_priv(expr);
 
-	priv->flowtable->use++;
+	nft_use_inc_restore(&priv->flowtable->use);
 }
 
 static void nft_flow_offload_destroy(const struct nft_ctx *ctx,
diff --git a/net/netfilter/nft_objref.c b/net/netfilter/nft_objref.c
index 615f0fcf711c..2401e9fa17c4 100644
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

