Return-Path: <stable+bounces-24575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19292869538
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D26B1C24498
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8865F13DB9B;
	Tue, 27 Feb 2024 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LBdo7D0l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461A254BD4;
	Tue, 27 Feb 2024 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042399; cv=none; b=QnrTAbKtnR/wiLkxMhnNtegQ8mrQK6hIyR3xaSL/SwWQixU1O8o4R8o+K0Zw+Tnm2NTl0akvp7Skq8iNSUC4KIDAb3Qyh6ZY9JatXzqn3MPcFp9XkIPgQkfGVGKJfGzClJsHu7Sz1g0xV++tEk7T2hfJaMs6/35cyoeKep5d1TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042399; c=relaxed/simple;
	bh=BIbJrtHJ/WiWX2QeSDJwAPRR4HVSSXdfV4tvARp9kjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ik9aR2qu5PRiAa6CAbRAG5R/LDAAfkyTzfqjbjX8Wo5xdS3YK+moif2ZlzoXADxtcTKl+5bhQYVbuTIakPnBdbal38kBcJIFcg27r0kG8PzBBtMQeHILtsjiR7xY7+5IA22ZagRK4mMN6AVnEqvRiMjtOyO2zRO8ndI4xcBDfN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LBdo7D0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6167C433C7;
	Tue, 27 Feb 2024 13:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709042399;
	bh=BIbJrtHJ/WiWX2QeSDJwAPRR4HVSSXdfV4tvARp9kjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LBdo7D0lVoIc5PwAuudyUw7s8VLGD13war+yY1UPhZ/f8Z4FfiK2SYlTY9qKLXy1i
	 X4ggTWv+QOATC3c2mmnlKpZGrjCM1IVeGnVrR7/aK6t/etaynyxUNYibxJ/hhxbzFA
	 8vrbpMl0VR6hTNoTeOhxeW4/QoCMcUlcUFtF9g3Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 274/299] netfilter: nf_tables: register hooks last when adding new chain/flowtable
Date: Tue, 27 Feb 2024 14:26:25 +0100
Message-ID: <20240227131634.497237741@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
References: <20240227131625.847743063@linuxfoundation.org>
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

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit d472e9853d7b46a6b094224d131d09ccd3a03daf ]

Register hooks last when adding chain/flowtable to ensure that packets do
not walk over datastructure that is being released in the error path
without waiting for the rcu grace period.

Fixes: 91c7b38dc9f0 ("netfilter: nf_tables: use new transaction infrastructure to handle chain")
Fixes: 3b49e2e94e6e ("netfilter: nf_tables: add flow table netlink frontend")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 78 ++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 38 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 40e8aa8343cc7..36fdce00bdab4 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -686,15 +686,16 @@ static int nft_delobj(struct nft_ctx *ctx, struct nft_object *obj)
 	return err;
 }
 
-static int nft_trans_flowtable_add(struct nft_ctx *ctx, int msg_type,
-				   struct nft_flowtable *flowtable)
+static struct nft_trans *
+nft_trans_flowtable_add(struct nft_ctx *ctx, int msg_type,
+		        struct nft_flowtable *flowtable)
 {
 	struct nft_trans *trans;
 
 	trans = nft_trans_alloc(ctx, msg_type,
 				sizeof(struct nft_trans_flowtable));
 	if (trans == NULL)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	if (msg_type == NFT_MSG_NEWFLOWTABLE)
 		nft_activate_next(ctx->net, flowtable);
@@ -703,22 +704,22 @@ static int nft_trans_flowtable_add(struct nft_ctx *ctx, int msg_type,
 	nft_trans_flowtable(trans) = flowtable;
 	nft_trans_commit_list_add_tail(ctx->net, trans);
 
-	return 0;
+	return trans;
 }
 
 static int nft_delflowtable(struct nft_ctx *ctx,
 			    struct nft_flowtable *flowtable)
 {
-	int err;
+	struct nft_trans *trans;
 
-	err = nft_trans_flowtable_add(ctx, NFT_MSG_DELFLOWTABLE, flowtable);
-	if (err < 0)
-		return err;
+	trans = nft_trans_flowtable_add(ctx, NFT_MSG_DELFLOWTABLE, flowtable);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
 
 	nft_deactivate_next(ctx->net, flowtable);
 	nft_use_dec(&ctx->table->use);
 
-	return err;
+	return 0;
 }
 
 static void __nft_reg_track_clobber(struct nft_regs_track *track, u8 dreg)
@@ -2506,19 +2507,15 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 	RCU_INIT_POINTER(chain->blob_gen_0, blob);
 	RCU_INIT_POINTER(chain->blob_gen_1, blob);
 
-	err = nf_tables_register_hook(net, table, chain);
-	if (err < 0)
-		goto err_destroy_chain;
-
 	if (!nft_use_inc(&table->use)) {
 		err = -EMFILE;
-		goto err_use;
+		goto err_destroy_chain;
 	}
 
 	trans = nft_trans_chain_add(ctx, NFT_MSG_NEWCHAIN);
 	if (IS_ERR(trans)) {
 		err = PTR_ERR(trans);
-		goto err_unregister_hook;
+		goto err_trans;
 	}
 
 	nft_trans_chain_policy(trans) = NFT_CHAIN_POLICY_UNSET;
@@ -2526,17 +2523,22 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 		nft_trans_chain_policy(trans) = policy;
 
 	err = nft_chain_add(table, chain);
-	if (err < 0) {
-		nft_trans_destroy(trans);
-		goto err_unregister_hook;
-	}
+	if (err < 0)
+		goto err_chain_add;
+
+	/* This must be LAST to ensure no packets are walking over this chain. */
+	err = nf_tables_register_hook(net, table, chain);
+	if (err < 0)
+		goto err_register_hook;
 
 	return 0;
 
-err_unregister_hook:
+err_register_hook:
+	nft_chain_del(chain);
+err_chain_add:
+	nft_trans_destroy(trans);
+err_trans:
 	nft_use_dec_restore(&table->use);
-err_use:
-	nf_tables_unregister_hook(net, table, chain);
 err_destroy_chain:
 	nf_tables_chain_destroy(ctx);
 
@@ -8334,9 +8336,9 @@ static int nf_tables_newflowtable(struct sk_buff *skb,
 	u8 family = info->nfmsg->nfgen_family;
 	const struct nf_flowtable_type *type;
 	struct nft_flowtable *flowtable;
-	struct nft_hook *hook, *next;
 	struct net *net = info->net;
 	struct nft_table *table;
+	struct nft_trans *trans;
 	struct nft_ctx ctx;
 	int err;
 
@@ -8416,34 +8418,34 @@ static int nf_tables_newflowtable(struct sk_buff *skb,
 	err = nft_flowtable_parse_hook(&ctx, nla, &flowtable_hook, flowtable,
 				       extack, true);
 	if (err < 0)
-		goto err4;
+		goto err_flowtable_parse_hooks;
 
 	list_splice(&flowtable_hook.list, &flowtable->hook_list);
 	flowtable->data.priority = flowtable_hook.priority;
 	flowtable->hooknum = flowtable_hook.num;
 
+	trans = nft_trans_flowtable_add(&ctx, NFT_MSG_NEWFLOWTABLE, flowtable);
+	if (IS_ERR(trans)) {
+		err = PTR_ERR(trans);
+		goto err_flowtable_trans;
+	}
+
+	/* This must be LAST to ensure no packets are walking over this flowtable. */
 	err = nft_register_flowtable_net_hooks(ctx.net, table,
 					       &flowtable->hook_list,
 					       flowtable);
-	if (err < 0) {
-		nft_hooks_destroy(&flowtable->hook_list);
-		goto err4;
-	}
-
-	err = nft_trans_flowtable_add(&ctx, NFT_MSG_NEWFLOWTABLE, flowtable);
 	if (err < 0)
-		goto err5;
+		goto err_flowtable_hooks;
 
 	list_add_tail_rcu(&flowtable->list, &table->flowtables);
 
 	return 0;
-err5:
-	list_for_each_entry_safe(hook, next, &flowtable->hook_list, list) {
-		nft_unregister_flowtable_hook(net, flowtable, hook);
-		list_del_rcu(&hook->list);
-		kfree_rcu(hook, rcu);
-	}
-err4:
+
+err_flowtable_hooks:
+	nft_trans_destroy(trans);
+err_flowtable_trans:
+	nft_hooks_destroy(&flowtable->hook_list);
+err_flowtable_parse_hooks:
 	flowtable->data.type->free(&flowtable->data);
 err3:
 	module_put(type->owner);
-- 
2.43.0




