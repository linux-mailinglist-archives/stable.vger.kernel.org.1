Return-Path: <stable+bounces-67078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 698C894F3CC
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95ACCB21831
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7BA186E34;
	Mon, 12 Aug 2024 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cKvHoqSU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14BF183CA6;
	Mon, 12 Aug 2024 16:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723479732; cv=none; b=HlUXsji1oDNxq7XPmv9f1Mh7aKu6gDRBr70x1I3ddaJYiPEyXggtEb54TpPEnwLo2YdHv6Rq2syYq/4lFrOghw/5iCh5znFpcQZAB7ZlDh7bEaoYzRvC0IP+xGdmDXI8gjC0JRn0zErhZhAZs1laOA+492xnsbfBxI8ySkYpJBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723479732; c=relaxed/simple;
	bh=VGZtKUlxRsmkiKe5VKz29JT0EXXE4hzrBMXgdJbCGLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkIb9lv7YILUtpna5QKBOXS7dpOAU+gy0sKAblCUqLQ0jwOXfsy9cJ+wYjyYc7VlielV5WAw0hukkcYk+5M9cS6BPOMQ60isMgk8jEeo5//mmIJ4F6CTrKFD1UyCtKvw0Kxm5+yoZdZVq6gzaot/GgWFHunAxil14DhLdCLbHKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cKvHoqSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4691DC32782;
	Mon, 12 Aug 2024 16:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723479732;
	bh=VGZtKUlxRsmkiKe5VKz29JT0EXXE4hzrBMXgdJbCGLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cKvHoqSUhySbLugQVZ4QD+OxmVQafZ+T0OUWYkrwFWNQAnoxfj2rhyywySgrM92TI
	 FKIYmPi9dNfX5wO7j8p+K41xqIr/kDHIGM379oqs8lNUq7jkDc6tPt9L9tEmt+kNUr
	 U/JD7PY5bq+wVyngw4NQV80Fj5SKZNarP3Jp70MI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 6.6 176/189] netfilter: nf_tables: prefer nft_chain_validate
Date: Mon, 12 Aug 2024 18:03:52 +0200
Message-ID: <20240812160138.923486159@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160132.135168257@linuxfoundation.org>
References: <20240812160132.135168257@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit cff3bd012a9512ac5ed858d38e6ed65f6391008c upstream.

nft_chain_validate already performs loop detection because a cycle will
result in a call stack overflow (ctx->level >= NFT_JUMP_STACK_SIZE).

It also follows maps via ->validate callback in nft_lookup, so there
appears no reason to iterate the maps again.

nf_tables_check_loops() and all its helper functions can be removed.
This improves ruleset load time significantly, from 23s down to 12s.

This also fixes a crash bug. Old loop detection code can result in
unbounded recursion:

BUG: TASK stack guard page was hit at ....
Oops: stack guard page: 0000 [#1] PREEMPT SMP KASAN
CPU: 4 PID: 1539 Comm: nft Not tainted 6.10.0-rc5+ #1
[..]

with a suitable ruleset during validation of register stores.

I can't see any actual reason to attempt to check for this from
nft_validate_register_store(), at this point the transaction is still in
progress, so we don't have a full picture of the rule graph.

For nf-next it might make sense to either remove it or make this depend
on table->validate_state in case we could catch an error earlier
(for improved error reporting to userspace).

Fixes: 20a69341f2d0 ("netfilter: nf_tables: add netlink set API")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_tables_api.c |  154 +++---------------------------------------
 1 file changed, 13 insertions(+), 141 deletions(-)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3743,6 +3743,15 @@ static void nf_tables_rule_release(const
 	nf_tables_rule_destroy(ctx, rule);
 }
 
+/** nft_chain_validate - loop detection and hook validation
+ *
+ * @ctx: context containing call depth and base chain
+ * @chain: chain to validate
+ *
+ * Walk through the rules of the given chain and chase all jumps/gotos
+ * and set lookups until either the jump limit is hit or all reachable
+ * chains have been validated.
+ */
 int nft_chain_validate(const struct nft_ctx *ctx, const struct nft_chain *chain)
 {
 	struct nft_expr *expr, *last;
@@ -3764,6 +3773,9 @@ int nft_chain_validate(const struct nft_
 			if (!expr->ops->validate)
 				continue;
 
+			/* This may call nft_chain_validate() recursively,
+			 * callers that do so must increment ctx->level.
+			 */
 			err = expr->ops->validate(ctx, expr, &data);
 			if (err < 0)
 				return err;
@@ -10621,146 +10633,6 @@ int nft_chain_validate_hooks(const struc
 }
 EXPORT_SYMBOL_GPL(nft_chain_validate_hooks);
 
-/*
- * Loop detection - walk through the ruleset beginning at the destination chain
- * of a new jump until either the source chain is reached (loop) or all
- * reachable chains have been traversed.
- *
- * The loop check is performed whenever a new jump verdict is added to an
- * expression or verdict map or a verdict map is bound to a new chain.
- */
-
-static int nf_tables_check_loops(const struct nft_ctx *ctx,
-				 const struct nft_chain *chain);
-
-static int nft_check_loops(const struct nft_ctx *ctx,
-			   const struct nft_set_ext *ext)
-{
-	const struct nft_data *data;
-	int ret;
-
-	data = nft_set_ext_data(ext);
-	switch (data->verdict.code) {
-	case NFT_JUMP:
-	case NFT_GOTO:
-		ret = nf_tables_check_loops(ctx, data->verdict.chain);
-		break;
-	default:
-		ret = 0;
-		break;
-	}
-
-	return ret;
-}
-
-static int nf_tables_loop_check_setelem(const struct nft_ctx *ctx,
-					struct nft_set *set,
-					const struct nft_set_iter *iter,
-					struct nft_set_elem *elem)
-{
-	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
-
-	if (nft_set_ext_exists(ext, NFT_SET_EXT_FLAGS) &&
-	    *nft_set_ext_flags(ext) & NFT_SET_ELEM_INTERVAL_END)
-		return 0;
-
-	return nft_check_loops(ctx, ext);
-}
-
-static int nft_set_catchall_loops(const struct nft_ctx *ctx,
-				  struct nft_set *set)
-{
-	u8 genmask = nft_genmask_next(ctx->net);
-	struct nft_set_elem_catchall *catchall;
-	struct nft_set_ext *ext;
-	int ret = 0;
-
-	list_for_each_entry_rcu(catchall, &set->catchall_list, list) {
-		ext = nft_set_elem_ext(set, catchall->elem);
-		if (!nft_set_elem_active(ext, genmask))
-			continue;
-
-		ret = nft_check_loops(ctx, ext);
-		if (ret < 0)
-			return ret;
-	}
-
-	return ret;
-}
-
-static int nf_tables_check_loops(const struct nft_ctx *ctx,
-				 const struct nft_chain *chain)
-{
-	const struct nft_rule *rule;
-	const struct nft_expr *expr, *last;
-	struct nft_set *set;
-	struct nft_set_binding *binding;
-	struct nft_set_iter iter;
-
-	if (ctx->chain == chain)
-		return -ELOOP;
-
-	if (fatal_signal_pending(current))
-		return -EINTR;
-
-	list_for_each_entry(rule, &chain->rules, list) {
-		nft_rule_for_each_expr(expr, last, rule) {
-			struct nft_immediate_expr *priv;
-			const struct nft_data *data;
-			int err;
-
-			if (strcmp(expr->ops->type->name, "immediate"))
-				continue;
-
-			priv = nft_expr_priv(expr);
-			if (priv->dreg != NFT_REG_VERDICT)
-				continue;
-
-			data = &priv->data;
-			switch (data->verdict.code) {
-			case NFT_JUMP:
-			case NFT_GOTO:
-				err = nf_tables_check_loops(ctx,
-							data->verdict.chain);
-				if (err < 0)
-					return err;
-				break;
-			default:
-				break;
-			}
-		}
-	}
-
-	list_for_each_entry(set, &ctx->table->sets, list) {
-		if (!nft_is_active_next(ctx->net, set))
-			continue;
-		if (!(set->flags & NFT_SET_MAP) ||
-		    set->dtype != NFT_DATA_VERDICT)
-			continue;
-
-		list_for_each_entry(binding, &set->bindings, list) {
-			if (!(binding->flags & NFT_SET_MAP) ||
-			    binding->chain != chain)
-				continue;
-
-			iter.genmask	= nft_genmask_next(ctx->net);
-			iter.skip 	= 0;
-			iter.count	= 0;
-			iter.err	= 0;
-			iter.fn		= nf_tables_loop_check_setelem;
-
-			set->ops->walk(ctx, set, &iter);
-			if (!iter.err)
-				iter.err = nft_set_catchall_loops(ctx, set);
-
-			if (iter.err < 0)
-				return iter.err;
-		}
-	}
-
-	return 0;
-}
-
 /**
  *	nft_parse_u32_check - fetch u32 attribute and check for maximum value
  *
@@ -10873,7 +10745,7 @@ static int nft_validate_register_store(c
 		if (data != NULL &&
 		    (data->verdict.code == NFT_GOTO ||
 		     data->verdict.code == NFT_JUMP)) {
-			err = nf_tables_check_loops(ctx, data->verdict.chain);
+			err = nft_chain_validate(ctx, data->verdict.chain);
 			if (err < 0)
 				return err;
 		}



