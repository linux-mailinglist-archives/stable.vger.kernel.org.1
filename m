Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F57877ADA1
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjHMVtn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjHMVtJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:49:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB821FF1;
        Sun, 13 Aug 2023 14:42:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A26C561A2D;
        Sun, 13 Aug 2023 21:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7CCC433C8;
        Sun, 13 Aug 2023 21:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962969;
        bh=fhWqVJYw0ZETJK0vcwlTriSuf0u6+ABK1/pkDYO4Roo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cbft2jEce2ZBCNl/fVOhK7dbCvuiOjIJXQiRi+yMk/btGAlxvfTzQYbMh2W+KyHyU
         tNSNJwYyfW9z26Sufib0DEpa/md2K0xVRTZKgmssEj78wSrUUd69RDvf7a9oysCdKx
         G9Ewiccc1YWQpeTjerpz/IX5eUiEVuL8gIJ87qzY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org, netfilter-devel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.10 59/68] netfilter: nf_tables: report use refcount overflow
Date:   Sun, 13 Aug 2023 23:20:00 +0200
Message-ID: <20230813211709.946279551@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211708.149630011@linuxfoundation.org>
References: <20230813211708.149630011@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/netfilter/nf_tables.h |   31 ++++++
 net/netfilter/nf_tables_api.c     |  171 +++++++++++++++++++++++---------------
 net/netfilter/nft_flow_offload.c  |    6 -
 net/netfilter/nft_immediate.c     |    8 -
 net/netfilter/nft_objref.c        |    8 +
 5 files changed, 145 insertions(+), 79 deletions(-)

--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1073,6 +1073,29 @@ int __nft_release_basechain(struct nft_c
 
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
@@ -1150,8 +1173,8 @@ struct nft_object {
 	struct list_head		list;
 	struct rhlist_head		rhlhead;
 	struct nft_object_hash_key	key;
-	u32				genmask:2,
-					use:30;
+	u32				genmask:2;
+	u32				use;
 	u64				handle;
 	u16				udlen;
 	u8				*udata;
@@ -1253,8 +1276,8 @@ struct nft_flowtable {
 	char				*name;
 	int				hooknum;
 	int				ops_len;
-	u32				genmask:2,
-					use:30;
+	u32				genmask:2;
+	u32				use;
 	u64				handle;
 	/* runtime data below here */
 	struct list_head		hook_list ____cacheline_aligned;
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -257,8 +257,10 @@ int nf_tables_bind_chain(const struct nf
 	if (chain->bound)
 		return -EBUSY;
 
+	if (!nft_use_inc(&chain->use))
+		return -EMFILE;
+
 	chain->bound = true;
-	chain->use++;
 	nft_chain_trans_bind(ctx, chain);
 
 	return 0;
@@ -427,7 +429,7 @@ static int nft_delchain(struct nft_ctx *
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	ctx->table->use--;
+	nft_use_dec(&ctx->table->use);
 	nft_deactivate_next(ctx->net, ctx->chain);
 
 	return 0;
@@ -466,7 +468,7 @@ nf_tables_delrule_deactivate(struct nft_
 	/* You cannot delete the same rule twice */
 	if (nft_is_active_next(ctx->net, rule)) {
 		nft_deactivate_next(ctx->net, rule);
-		ctx->chain->use--;
+		nft_use_dec(&ctx->chain->use);
 		return 0;
 	}
 	return -ENOENT;
@@ -594,7 +596,7 @@ static int nft_delset(const struct nft_c
 		nft_map_deactivate(ctx, set);
 
 	nft_deactivate_next(ctx->net, set);
-	ctx->table->use--;
+	nft_use_dec(&ctx->table->use);
 
 	return err;
 }
@@ -626,7 +628,7 @@ static int nft_delobj(struct nft_ctx *ct
 		return err;
 
 	nft_deactivate_next(ctx->net, obj);
-	ctx->table->use--;
+	nft_use_dec(&ctx->table->use);
 
 	return err;
 }
@@ -661,7 +663,7 @@ static int nft_delflowtable(struct nft_c
 		return err;
 
 	nft_deactivate_next(ctx->net, flowtable);
-	ctx->table->use--;
+	nft_use_dec(&ctx->table->use);
 
 	return err;
 }
@@ -2158,9 +2160,6 @@ static int nf_tables_addchain(struct nft
 	struct nft_rule **rules;
 	int err;
 
-	if (table->use == UINT_MAX)
-		return -EOVERFLOW;
-
 	if (nla[NFTA_CHAIN_HOOK]) {
 		struct nft_stats __percpu *stats = NULL;
 		struct nft_chain_hook hook;
@@ -2256,6 +2255,11 @@ static int nf_tables_addchain(struct nft
 	if (err < 0)
 		goto err_destroy_chain;
 
+	if (!nft_use_inc(&table->use)) {
+		err = -EMFILE;
+		goto err_use;
+	}
+
 	trans = nft_trans_chain_add(ctx, NFT_MSG_NEWCHAIN);
 	if (IS_ERR(trans)) {
 		err = PTR_ERR(trans);
@@ -2272,10 +2276,11 @@ static int nf_tables_addchain(struct nft
 		goto err_unregister_hook;
 	}
 
-	table->use++;
-
 	return 0;
+
 err_unregister_hook:
+	nft_use_dec_restore(&table->use);
+err_use:
 	nf_tables_unregister_hook(net, table, chain);
 err_destroy_chain:
 	nf_tables_chain_destroy(ctx);
@@ -3387,9 +3392,6 @@ static int nf_tables_newrule(struct net
 			return -EINVAL;
 		handle = nf_tables_alloc_handle(table);
 
-		if (chain->use == UINT_MAX)
-			return -EOVERFLOW;
-
 		if (nla[NFTA_RULE_POSITION]) {
 			pos_handle = be64_to_cpu(nla_get_be64(nla[NFTA_RULE_POSITION]));
 			old_rule = __nft_rule_lookup(chain, pos_handle);
@@ -3475,16 +3477,21 @@ static int nf_tables_newrule(struct net
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
@@ -3492,7 +3499,7 @@ static int nf_tables_newrule(struct net
 		trans = nft_trans_rule_add(&ctx, NFT_MSG_NEWRULE, rule);
 		if (!trans) {
 			err = -ENOMEM;
-			goto err2;
+			goto err_destroy_flow_rule;
 		}
 
 		if (nlh->nlmsg_flags & NLM_F_APPEND) {
@@ -3508,7 +3515,6 @@ static int nf_tables_newrule(struct net
 		}
 	}
 	kvfree(info);
-	chain->use++;
 
 	if (nft_net->validate_state == NFT_VALIDATE_DO)
 		return nft_table_validate(net, table);
@@ -3522,6 +3528,9 @@ static int nf_tables_newrule(struct net
 	}
 
 	return 0;
+
+err_destroy_flow_rule:
+	nft_use_dec_restore(&chain->use);
 err2:
 	nft_rule_expr_deactivate(&ctx, rule, NFT_TRANS_PREPARE_ERROR);
 	nf_tables_rule_destroy(&ctx, rule);
@@ -4437,9 +4446,15 @@ static int nf_tables_newset(struct net *
 	alloc_size = sizeof(*set) + size + udlen;
 	if (alloc_size < size || alloc_size > INT_MAX)
 		return -ENOMEM;
+
+	if (!nft_use_inc(&table->use))
+		return -EMFILE;
+
 	set = kvzalloc(alloc_size, GFP_KERNEL);
-	if (!set)
-		return -ENOMEM;
+	if (!set) {
+		err = -ENOMEM;
+		goto err_alloc;
+	}
 
 	name = nla_strdup(nla[NFTA_SET_NAME], GFP_KERNEL);
 	if (!name) {
@@ -4500,7 +4515,7 @@ static int nf_tables_newset(struct net *
 		goto err_set_expr_alloc;
 
 	list_add_tail_rcu(&set->list, &table->sets);
-	table->use++;
+
 	return 0;
 
 err_set_expr_alloc:
@@ -4512,6 +4527,9 @@ err_set_init:
 	kfree(set->name);
 err_set_name:
 	kvfree(set);
+err_alloc:
+	nft_use_dec_restore(&table->use);
+
 	return err;
 }
 
@@ -4605,9 +4623,6 @@ int nf_tables_bind_set(const struct nft_
 	struct nft_set_binding *i;
 	struct nft_set_iter iter;
 
-	if (set->use == UINT_MAX)
-		return -EOVERFLOW;
-
 	if (!list_empty(&set->bindings) && nft_set_is_anonymous(set))
 		return -EBUSY;
 
@@ -4632,10 +4647,12 @@ int nf_tables_bind_set(const struct nft_
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
@@ -4688,7 +4705,7 @@ void nf_tables_activate_set(const struct
 		nft_clear(ctx->net, set);
 	}
 
-	set->use++;
+	nft_use_inc_restore(&set->use);
 }
 EXPORT_SYMBOL_GPL(nf_tables_activate_set);
 
@@ -4704,7 +4721,7 @@ void nf_tables_deactivate_set(const stru
 		else
 			list_del_rcu(&binding->list);
 
-		set->use--;
+		nft_use_dec(&set->use);
 		break;
 	case NFT_TRANS_PREPARE:
 		if (nft_set_is_anonymous(set)) {
@@ -4713,7 +4730,7 @@ void nf_tables_deactivate_set(const stru
 
 			nft_deactivate_next(ctx->net, set);
 		}
-		set->use--;
+		nft_use_dec(&set->use);
 		return;
 	case NFT_TRANS_ABORT:
 	case NFT_TRANS_RELEASE:
@@ -4721,7 +4738,7 @@ void nf_tables_deactivate_set(const stru
 		    set->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
 			nft_map_deactivate(ctx, set);
 
-		set->use--;
+		nft_use_dec(&set->use);
 		fallthrough;
 	default:
 		nf_tables_unbind_set(ctx, set, binding,
@@ -5348,7 +5365,7 @@ void nft_set_elem_destroy(const struct n
 		nft_set_elem_expr_destroy(&ctx, nft_set_ext_expr(ext));
 
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_OBJREF))
-		(*nft_set_ext_obj(ext))->use--;
+		nft_use_dec(&(*nft_set_ext_obj(ext))->use);
 	kfree(elem);
 }
 EXPORT_SYMBOL_GPL(nft_set_elem_destroy);
@@ -5522,8 +5539,16 @@ static int nft_add_set_elem(struct nft_c
 				     set->objtype, genmask);
 		if (IS_ERR(obj)) {
 			err = PTR_ERR(obj);
+			obj = NULL;
+			goto err_parse_key_end;
+		}
+
+		if (!nft_use_inc(&obj->use)) {
+			err = -EMFILE;
+			obj = NULL;
 			goto err_parse_key_end;
 		}
+
 		nft_set_ext_add(&tmpl, NFT_SET_EXT_OBJREF);
 	}
 
@@ -5588,10 +5613,8 @@ static int nft_add_set_elem(struct nft_c
 		udata->len = ulen - 1;
 		nla_memcpy(&udata->data, nla[NFTA_SET_ELEM_USERDATA], ulen);
 	}
-	if (obj) {
+	if (obj)
 		*nft_set_ext_obj(ext) = obj;
-		obj->use++;
-	}
 
 	err = nft_set_elem_expr_setup(ctx, ext, expr);
 	if (err < 0)
@@ -5647,14 +5670,14 @@ err_set_full:
 err_element_clash:
 	kfree(trans);
 err_elem_expr:
-	if (obj)
-		obj->use--;
-
 	nf_tables_set_elem_destroy(ctx, set, elem.priv);
 err_parse_data:
 	if (nla[NFTA_SET_ELEM_DATA] != NULL)
 		nft_data_release(&elem.data.val, desc.type);
 err_parse_key_end:
+	if (obj)
+		nft_use_dec_restore(&obj->use);
+
 	nft_data_release(&elem.key_end.val, NFT_DATA_VALUE);
 err_parse_key:
 	nft_data_release(&elem.key.val, NFT_DATA_VALUE);
@@ -5726,7 +5749,7 @@ void nft_data_hold(const struct nft_data
 		case NFT_JUMP:
 		case NFT_GOTO:
 			chain = data->verdict.chain;
-			chain->use++;
+			nft_use_inc_restore(&chain->use);
 			break;
 		}
 	}
@@ -5741,7 +5764,7 @@ static void nft_setelem_data_activate(co
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_DATA))
 		nft_data_hold(nft_set_ext_data(ext), set->dtype);
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_OBJREF))
-		(*nft_set_ext_obj(ext))->use++;
+		nft_use_inc_restore(&(*nft_set_ext_obj(ext))->use);
 }
 
 static void nft_setelem_data_deactivate(const struct net *net,
@@ -5753,7 +5776,7 @@ static void nft_setelem_data_deactivate(
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_DATA))
 		nft_data_release(nft_set_ext_data(ext), set->dtype);
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_OBJREF))
-		(*nft_set_ext_obj(ext))->use--;
+		nft_use_dec(&(*nft_set_ext_obj(ext))->use);
 }
 
 static int nft_del_setelem(struct nft_ctx *ctx, struct nft_set *set,
@@ -6220,9 +6243,14 @@ static int nf_tables_newobj(struct net *
 
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
@@ -6256,7 +6284,7 @@ static int nf_tables_newobj(struct net *
 		goto err_obj_ht;
 
 	list_add_tail_rcu(&obj->list, &table->objects);
-	table->use++;
+
 	return 0;
 err_obj_ht:
 	/* queued in transaction log */
@@ -6272,6 +6300,9 @@ err_strdup:
 	kfree(obj);
 err_init:
 	module_put(type->owner);
+err_type:
+	nft_use_dec_restore(&table->use);
+
 	return err;
 }
 
@@ -6662,7 +6693,7 @@ void nf_tables_deactivate_flowtable(cons
 	case NFT_TRANS_PREPARE:
 	case NFT_TRANS_ABORT:
 	case NFT_TRANS_RELEASE:
-		flowtable->use--;
+		nft_use_dec(&flowtable->use);
 		fallthrough;
 	default:
 		return;
@@ -6999,9 +7030,14 @@ static int nf_tables_newflowtable(struct
 
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
@@ -7056,7 +7092,6 @@ static int nf_tables_newflowtable(struct
 		goto err5;
 
 	list_add_tail_rcu(&flowtable->list, &table->flowtables);
-	table->use++;
 
 	return 0;
 err5:
@@ -7073,6 +7108,9 @@ err2:
 	kfree(flowtable->name);
 err1:
 	kfree(flowtable);
+flowtable_alloc:
+	nft_use_dec_restore(&table->use);
+
 	return err;
 }
 
@@ -8258,7 +8296,7 @@ static int nf_tables_commit(struct net *
 			 */
 			if (nft_set_is_anonymous(nft_trans_set(trans)) &&
 			    !list_empty(&nft_trans_set(trans)->bindings))
-				trans->ctx.table->use--;
+				nft_use_dec(&trans->ctx.table->use);
 
 			nf_tables_set_notify(&trans->ctx, nft_trans_set(trans),
 					     NFT_MSG_NEWSET, GFP_KERNEL);
@@ -8442,7 +8480,7 @@ static int __nf_tables_abort(struct net
 					nft_trans_destroy(trans);
 					break;
 				}
-				trans->ctx.table->use--;
+				nft_use_dec_restore(&trans->ctx.table->use);
 				nft_chain_del(trans->ctx.chain);
 				nf_tables_unregister_hook(trans->ctx.net,
 							  trans->ctx.table,
@@ -8450,7 +8488,7 @@ static int __nf_tables_abort(struct net
 			}
 			break;
 		case NFT_MSG_DELCHAIN:
-			trans->ctx.table->use++;
+			nft_use_inc_restore(&trans->ctx.table->use);
 			nft_clear(trans->ctx.net, trans->ctx.chain);
 			nft_trans_destroy(trans);
 			break;
@@ -8459,20 +8497,20 @@ static int __nf_tables_abort(struct net
 				nft_trans_destroy(trans);
 				break;
 			}
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
@@ -8480,7 +8518,7 @@ static int __nf_tables_abort(struct net
 			list_del_rcu(&nft_trans_set(trans)->list);
 			break;
 		case NFT_MSG_DELSET:
-			trans->ctx.table->use++;
+			nft_use_inc_restore(&trans->ctx.table->use);
 			nft_clear(trans->ctx.net, nft_trans_set(trans));
 			if (nft_trans_set(trans)->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
 				nft_map_activate(&trans->ctx, nft_trans_set(trans));
@@ -8510,12 +8548,12 @@ static int __nf_tables_abort(struct net
 				nft_obj_destroy(&trans->ctx, nft_trans_obj_newobj(trans));
 				nft_trans_destroy(trans);
 			} else {
-				trans->ctx.table->use--;
+				nft_use_dec_restore(&trans->ctx.table->use);
 				nft_obj_del(nft_trans_obj(trans));
 			}
 			break;
 		case NFT_MSG_DELOBJ:
-			trans->ctx.table->use++;
+			nft_use_inc_restore(&trans->ctx.table->use);
 			nft_clear(trans->ctx.net, nft_trans_obj(trans));
 			nft_trans_destroy(trans);
 			break;
@@ -8524,7 +8562,7 @@ static int __nf_tables_abort(struct net
 				nft_unregister_flowtable_net_hooks(net,
 						&nft_trans_flowtable_hooks(trans));
 			} else {
-				trans->ctx.table->use--;
+				nft_use_dec_restore(&trans->ctx.table->use);
 				list_del_rcu(&nft_trans_flowtable(trans)->list);
 				nft_unregister_flowtable_net_hooks(net,
 						&nft_trans_flowtable(trans)->hook_list);
@@ -8535,7 +8573,7 @@ static int __nf_tables_abort(struct net
 				list_splice(&nft_trans_flowtable_hooks(trans),
 					    &nft_trans_flowtable(trans)->hook_list);
 			} else {
-				trans->ctx.table->use++;
+				nft_use_inc_restore(&trans->ctx.table->use);
 				nft_clear(trans->ctx.net, nft_trans_flowtable(trans));
 			}
 			nft_trans_destroy(trans);
@@ -8973,8 +9011,9 @@ static int nft_verdict_init(const struct
 		if (desc->flags & NFT_DATA_DESC_SETELEM &&
 		    chain->flags & NFT_CHAIN_BINDING)
 			return -EINVAL;
+		if (!nft_use_inc(&chain->use))
+			return -EMFILE;
 
-		chain->use++;
 		data->verdict.chain = chain;
 		break;
 	}
@@ -8992,7 +9031,7 @@ static void nft_verdict_uninit(const str
 	case NFT_JUMP:
 	case NFT_GOTO:
 		chain = data->verdict.chain;
-		chain->use--;
+		nft_use_dec(&chain->use);
 		break;
 	}
 }
@@ -9161,11 +9200,11 @@ int __nft_release_basechain(struct nft_c
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
@@ -9205,18 +9244,18 @@ static void __nft_release_table(struct n
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
 		if (set->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
 			nft_map_deactivate(&ctx, set);
 
@@ -9224,13 +9263,13 @@ static void __nft_release_table(struct n
 	}
 	list_for_each_entry_safe(obj, ne, &table->objects, list) {
 		nft_obj_del(obj);
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
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -174,8 +174,10 @@ static int nft_flow_offload_init(const s
 	if (IS_ERR(flowtable))
 		return PTR_ERR(flowtable);
 
+	if (!nft_use_inc(&flowtable->use))
+		return -EMFILE;
+
 	priv->flowtable = flowtable;
-	flowtable->use++;
 
 	return nf_ct_netns_get(ctx->net, ctx->family);
 }
@@ -194,7 +196,7 @@ static void nft_flow_offload_activate(co
 {
 	struct nft_flow_offload *priv = nft_expr_priv(expr);
 
-	priv->flowtable->use++;
+	nft_use_inc_restore(&priv->flowtable->use);
 }
 
 static void nft_flow_offload_destroy(const struct nft_ctx *ctx,
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -168,7 +168,7 @@ static void nft_immediate_deactivate(con
 				nft_immediate_chain_deactivate(ctx, chain, phase);
 				nft_chain_del(chain);
 				chain->bound = false;
-				chain->table->use--;
+				nft_use_dec(&chain->table->use);
 				break;
 			}
 			break;
@@ -207,7 +207,7 @@ static void nft_immediate_destroy(const
 		 * let the transaction records release this chain and its rules.
 		 */
 		if (chain->bound) {
-			chain->use--;
+			nft_use_dec(&chain->use);
 			break;
 		}
 
@@ -215,9 +215,9 @@ static void nft_immediate_destroy(const
 		chain_ctx = *ctx;
 		chain_ctx.chain = chain;
 
-		chain->use--;
+		nft_use_dec(&chain->use);
 		list_for_each_entry_safe(rule, n, &chain->rules, list) {
-			chain->use--;
+			nft_use_dec(&chain->use);
 			list_del(&rule->list);
 			nf_tables_rule_destroy(&chain_ctx, rule);
 		}
--- a/net/netfilter/nft_objref.c
+++ b/net/netfilter/nft_objref.c
@@ -41,8 +41,10 @@ static int nft_objref_init(const struct
 	if (IS_ERR(obj))
 		return -ENOENT;
 
+	if (!nft_use_inc(&obj->use))
+		return -EMFILE;
+
 	nft_objref_priv(expr) = obj;
-	obj->use++;
 
 	return 0;
 }
@@ -71,7 +73,7 @@ static void nft_objref_deactivate(const
 	if (phase == NFT_TRANS_COMMIT)
 		return;
 
-	obj->use--;
+	nft_use_dec(&obj->use);
 }
 
 static void nft_objref_activate(const struct nft_ctx *ctx,
@@ -79,7 +81,7 @@ static void nft_objref_activate(const st
 {
 	struct nft_object *obj = nft_objref_priv(expr);
 
-	obj->use++;
+	nft_use_inc_restore(&obj->use);
 }
 
 static struct nft_expr_type nft_objref_type;


