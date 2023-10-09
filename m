Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EDC7BE0AB
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377395AbjJINmp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377394AbjJINmo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:42:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3643AB6
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:42:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA35C433C8;
        Mon,  9 Oct 2023 13:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858962;
        bh=B1RA73EE/86MdwV0Y8r1TjCADgs0zVR1ZQiN4y7ObQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xawF2CcBYCvVJNvvpcTwui5Spt84tzuFre6tZBxqnlqfXtWJkXRfCI+e6XYMKf+CG
         5cV1wq1LL83YgukgLiadfWwaYhJOp1qqZ8csqWafrpkMTzlpJQFvQBrc+xXG3CLh8O
         J6M0JHcVEhMYxjNsafxSAZtXA9lwwgP3lJV+P57M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kevin Rich <kevinrich1337@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 148/226] netfilter: nf_tables: disallow rule removal from chain binding
Date:   Mon,  9 Oct 2023 15:01:49 +0200
Message-ID: <20231009130130.585387853@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 16e2500e8590b..78b268bd7f012 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1268,7 +1268,7 @@ static int nft_flush_table(struct nft_ctx *ctx)
 		if (!nft_is_active_next(ctx->net, chain))
 			continue;
 
-		if (nft_chain_is_bound(chain))
+		if (nft_chain_binding(chain))
 			continue;
 
 		ctx->chain = chain;
@@ -1312,7 +1312,7 @@ static int nft_flush_table(struct nft_ctx *ctx)
 		if (!nft_is_active_next(ctx->net, chain))
 			continue;
 
-		if (nft_chain_is_bound(chain))
+		if (nft_chain_binding(chain))
 			continue;
 
 		ctx->chain = chain;
@@ -2599,6 +2599,9 @@ static int nf_tables_delchain(struct net *net, struct sock *nlsk,
 		return PTR_ERR(chain);
 	}
 
+	if (nft_chain_binding(chain))
+		return -EOPNOTSUPP;
+
 	if (nlh->nlmsg_flags & NLM_F_NONREC &&
 	    chain->use > 0)
 		return -EBUSY;
@@ -3498,6 +3501,11 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 	}
 
 	if (nlh->nlmsg_flags & NLM_F_REPLACE) {
+		if (nft_chain_binding(chain)) {
+			err = -EOPNOTSUPP;
+			goto err_destroy_flow_rule;
+		}
+
 		trans = nft_trans_rule_add(&ctx, NFT_MSG_NEWRULE, rule);
 		if (trans == NULL) {
 			err = -ENOMEM;
@@ -3606,7 +3614,7 @@ static int nf_tables_delrule(struct net *net, struct sock *nlsk,
 			NL_SET_BAD_ATTR(extack, nla[NFTA_RULE_CHAIN]);
 			return PTR_ERR(chain);
 		}
-		if (nft_chain_is_bound(chain))
+		if (nft_chain_binding(chain))
 			return -EOPNOTSUPP;
 	}
 
@@ -3636,7 +3644,7 @@ static int nf_tables_delrule(struct net *net, struct sock *nlsk,
 		list_for_each_entry(chain, &table->chains, list) {
 			if (!nft_is_active_next(net, chain))
 				continue;
-			if (nft_chain_is_bound(chain))
+			if (nft_chain_binding(chain))
 				continue;
 
 			ctx.chain = chain;
@@ -9529,7 +9537,7 @@ static void __nft_release_table(struct net *net, struct nft_table *table)
 	ctx.family = table->family;
 	ctx.table = table;
 	list_for_each_entry(chain, &table->chains, list) {
-		if (nft_chain_is_bound(chain))
+		if (nft_chain_binding(chain))
 			continue;
 
 		ctx.chain = chain;
-- 
2.40.1



