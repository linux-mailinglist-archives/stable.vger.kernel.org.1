Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10EA7B87C5
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243857AbjJDSJD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243874AbjJDSJC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:09:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26192DD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:08:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6913EC433C7;
        Wed,  4 Oct 2023 18:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442938;
        bh=ouhJzqVgoUYCg+s9vRJRJ5XIUIUot7aDeWdqkmmoJWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pszcAMJWFhXNeovqGY6g8k4OwAqfbfDJ4REtQ9GH+p2gG2iY/MEtAv9MPdBSJkYF/
         kMufBVv3jA5FEW0dT7CuCWX5erSD02J1LfkZtW9ZVYjky8VFioEBQ3ZWq7HbeE22HW
         ldgtsuz7JtFB2Z8AU3Pe/0rFmX5Teq5PGJYW1zzU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kevin Rich <kevinrich1337@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 163/183] netfilter: nf_tables: disallow rule removal from chain binding
Date:   Wed,  4 Oct 2023 19:56:34 +0200
Message-ID: <20231004175210.848209282@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit f15f29fd4779be8a418b66e9d52979bb6d6c2325 ]

Chain binding only requires the rule addition/insertion command within
the same transaction. Removal of rules from chain bindings within the
same transaction makes no sense, userspace does not utilize this
feature. Replace nft_chain_is_bound() check to nft_chain_binding() in
rule deletion commands. Replace command implies a rule deletion, reject
this command too.

Rule flush command can also safely rely on this nft_chain_binding()
check because unbound chains are not allowed since 62e1e94b246e
("netfilter: nf_tables: reject unbound chain set before commit phase").

Fixes: d0e2c7de92c7 ("netfilter: nf_tables: add NFT_CHAIN_BINDING")
Reported-by: Kevin Rich <kevinrich1337@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 2f7d8e0e47de8..8a4cd1c16e0e4 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1348,7 +1348,7 @@ static int nft_flush_table(struct nft_ctx *ctx)
 		if (!nft_is_active_next(ctx->net, chain))
 			continue;
 
-		if (nft_chain_is_bound(chain))
+		if (nft_chain_binding(chain))
 			continue;
 
 		ctx->chain = chain;
@@ -1392,7 +1392,7 @@ static int nft_flush_table(struct nft_ctx *ctx)
 		if (!nft_is_active_next(ctx->net, chain))
 			continue;
 
-		if (nft_chain_is_bound(chain))
+		if (nft_chain_binding(chain))
 			continue;
 
 		ctx->chain = chain;
@@ -2697,6 +2697,9 @@ static int nf_tables_delchain(struct sk_buff *skb, const struct nfnl_info *info,
 		return PTR_ERR(chain);
 	}
 
+	if (nft_chain_binding(chain))
+		return -EOPNOTSUPP;
+
 	if (info->nlh->nlmsg_flags & NLM_F_NONREC &&
 	    chain->use > 0)
 		return -EBUSY;
@@ -3674,6 +3677,11 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 	}
 
 	if (info->nlh->nlmsg_flags & NLM_F_REPLACE) {
+		if (nft_chain_binding(chain)) {
+			err = -EOPNOTSUPP;
+			goto err_destroy_flow_rule;
+		}
+
 		err = nft_delrule(&ctx, old_rule);
 		if (err < 0)
 			goto err_destroy_flow_rule;
@@ -3777,7 +3785,7 @@ static int nf_tables_delrule(struct sk_buff *skb, const struct nfnl_info *info,
 			NL_SET_BAD_ATTR(extack, nla[NFTA_RULE_CHAIN]);
 			return PTR_ERR(chain);
 		}
-		if (nft_chain_is_bound(chain))
+		if (nft_chain_binding(chain))
 			return -EOPNOTSUPP;
 	}
 
@@ -3807,7 +3815,7 @@ static int nf_tables_delrule(struct sk_buff *skb, const struct nfnl_info *info,
 		list_for_each_entry(chain, &table->chains, list) {
 			if (!nft_is_active_next(net, chain))
 				continue;
-			if (nft_chain_is_bound(chain))
+			if (nft_chain_binding(chain))
 				continue;
 
 			ctx.chain = chain;
@@ -10458,7 +10466,7 @@ static void __nft_release_table(struct net *net, struct nft_table *table)
 	ctx.family = table->family;
 	ctx.table = table;
 	list_for_each_entry(chain, &table->chains, list) {
-		if (nft_chain_is_bound(chain))
+		if (nft_chain_binding(chain))
 			continue;
 
 		ctx.chain = chain;
-- 
2.40.1



