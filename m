Return-Path: <stable+bounces-145143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A28FABDA38
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0AE1BA361A
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B134F244196;
	Tue, 20 May 2025 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="efb1wHvf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699B9242922;
	Tue, 20 May 2025 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749291; cv=none; b=bLS9rF2YozULT86Qslr+hsMh6LfvkKVGKD/8wHXNqfIb+OBf4l9moInKf/R6g+MkCQt0FjJsxPsEdHnYny9MBXdpT+uj55z7VZn+0+Rq5dqjgsn2pW+QpYm31Y5bl8jsntWZGXmAlCTl2BOTYgoXqHghrVHHQrRA2VnUELBNjro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749291; c=relaxed/simple;
	bh=Blga8I4UNvldV1XM+CJdXzvVwKArdp+B7B/gswf+wr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2FrK6QMzprSy8cTlVyVUjVqP47uk2fzHFdQbQxw8KNsS59BZD47dt9t0eptANHnGSYZYWr0LjzLuFifAj3FO9W7EsyxtwjXRbsadGPJpJBUxDo4Q/QPmAJV2RjRLfwOAWrMo522IoyxC5kQ78IuWA0+uD4zRfIKtOa8knLGzdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=efb1wHvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BAAC4CEE9;
	Tue, 20 May 2025 13:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747749291;
	bh=Blga8I4UNvldV1XM+CJdXzvVwKArdp+B7B/gswf+wr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=efb1wHvf37F7V8+HOpmWe+sSaAQQdq11TA7m/Xl3xmF9yBRJhwMJqcW8y9GQntrfX
	 LUacBbBx7UcXeiurzFK/YjFkrFuraoF0ILA/mmBVtf1PQk81OTEm/6Tx7YdElRkR8i
	 tOHIipBcJDzqogd6R/+XcrkKOTpKRg7RRol4lB9I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org,
	netfilter-devel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.15 56/59] netfilter: nf_tables: pass nft_chain to destroy function, not nft_ctx
Date: Tue, 20 May 2025 15:50:47 +0200
Message-ID: <20250520125756.068868875@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125753.836407405@linuxfoundation.org>
References: <20250520125753.836407405@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 8965d42bcf54d42cbc72fe34a9d0ec3f8527debd upstream.

It would be better to not store nft_ctx inside nft_trans object,
the netlink ctx strucutre is huge and most of its information is
never needed in places that use trans->ctx.

Avoid/reduce its usage if possible, no runtime behaviour change
intended.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/netfilter/nf_tables.h |    2 +-
 net/netfilter/nf_tables_api.c     |   17 ++++++++---------
 net/netfilter/nft_immediate.c     |    2 +-
 3 files changed, 10 insertions(+), 11 deletions(-)

--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1088,7 +1088,7 @@ static inline bool nft_chain_is_bound(st
 
 int nft_chain_add(struct nft_table *table, struct nft_chain *chain);
 void nft_chain_del(struct nft_chain *chain);
-void nf_tables_chain_destroy(struct nft_ctx *ctx);
+void nf_tables_chain_destroy(struct nft_chain *chain);
 
 struct nft_stats {
 	u64			bytes;
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1981,9 +1981,9 @@ static void nf_tables_chain_free_chain_r
 	kvfree(chain->rules_next);
 }
 
-void nf_tables_chain_destroy(struct nft_ctx *ctx)
+void nf_tables_chain_destroy(struct nft_chain *chain)
 {
-	struct nft_chain *chain = ctx->chain;
+	const struct nft_table *table = chain->table;
 	struct nft_hook *hook, *next;
 
 	if (WARN_ON(chain->use > 0))
@@ -1995,7 +1995,7 @@ void nf_tables_chain_destroy(struct nft_
 	if (nft_is_base_chain(chain)) {
 		struct nft_base_chain *basechain = nft_base_chain(chain);
 
-		if (nft_base_chain_netdev(ctx->family, basechain->ops.hooknum)) {
+		if (nft_base_chain_netdev(table->family, basechain->ops.hooknum)) {
 			list_for_each_entry_safe(hook, next,
 						 &basechain->hook_list, list) {
 				list_del_rcu(&hook->list);
@@ -2445,7 +2445,7 @@ err_unregister_hook:
 err_use:
 	nf_tables_unregister_hook(net, table, chain);
 err_destroy_chain:
-	nf_tables_chain_destroy(ctx);
+	nf_tables_chain_destroy(chain);
 
 	return err;
 }
@@ -8809,7 +8809,7 @@ static void nft_commit_release(struct nf
 		kfree(nft_trans_chain_name(trans));
 		break;
 	case NFT_MSG_DELCHAIN:
-		nf_tables_chain_destroy(&trans->ctx);
+		nf_tables_chain_destroy(nft_trans_chain(trans));
 		break;
 	case NFT_MSG_DELRULE:
 		nf_tables_rule_destroy(&trans->ctx, nft_trans_rule(trans));
@@ -9721,7 +9721,7 @@ static void nf_tables_abort_release(stru
 		nf_tables_table_destroy(&trans->ctx);
 		break;
 	case NFT_MSG_NEWCHAIN:
-		nf_tables_chain_destroy(&trans->ctx);
+		nf_tables_chain_destroy(nft_trans_chain(trans));
 		break;
 	case NFT_MSG_NEWRULE:
 		nf_tables_rule_destroy(&trans->ctx, nft_trans_rule(trans));
@@ -10443,7 +10443,7 @@ int __nft_release_basechain(struct nft_c
 	}
 	nft_chain_del(ctx->chain);
 	nft_use_dec(&ctx->table->use);
-	nf_tables_chain_destroy(ctx);
+	nf_tables_chain_destroy(ctx->chain);
 
 	return 0;
 }
@@ -10519,10 +10519,9 @@ static void __nft_release_table(struct n
 		nft_obj_destroy(&ctx, obj);
 	}
 	list_for_each_entry_safe(chain, nc, &table->chains, list) {
-		ctx.chain = chain;
 		nft_chain_del(chain);
 		nft_use_dec(&table->use);
-		nf_tables_chain_destroy(&ctx);
+		nf_tables_chain_destroy(chain);
 	}
 	nf_tables_table_destroy(&ctx);
 }
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -221,7 +221,7 @@ static void nft_immediate_destroy(const
 			list_del(&rule->list);
 			nf_tables_rule_destroy(&chain_ctx, rule);
 		}
-		nf_tables_chain_destroy(&chain_ctx);
+		nf_tables_chain_destroy(chain);
 		break;
 	default:
 		break;



