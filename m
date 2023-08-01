Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B1E76AE1F
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjHAJgH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjHAJfy (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:35:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657FA26AA
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:34:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D725D614CF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6795C433C8;
        Tue,  1 Aug 2023 09:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882441;
        bh=zhKYFYy57Qs0uc7J8Lh99D9RbtSjZxvrhNWwkxjxBjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RcVkyoZOmwxukU5yXQU9oUpv6sQnRbMFbWrmXnao4BS4Bfsv4DKgUJn/O+bdNRo0P
         nfA8w3iCpy+mDaL+/qnLBnKvw3TE8A7Jk5L9X6iqHDdYodRD9p2RTw/SZGD1t6Ufx9
         1aKqKIb3YH03D+XjbOg7tFqjsBcf/Ygl2BSst3ok=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kevin Rich <kevinrich1337@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 106/228] netfilter: nf_tables: skip immediate deactivate in _PREPARE_ERROR
Date:   Tue,  1 Aug 2023 11:19:24 +0200
Message-ID: <20230801091926.626867733@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 0a771f7b266b02d262900c75f1e175c7fe76fec2 ]

On error when building the rule, the immediate expression unbinds the
chain, hence objects can be deactivated by the transaction records.

Otherwise, it is possible to trigger the following warning:

 WARNING: CPU: 3 PID: 915 at net/netfilter/nf_tables_api.c:2013 nf_tables_chain_destroy+0x1f7/0x210 [nf_tables]
 CPU: 3 PID: 915 Comm: chain-bind-err- Not tainted 6.1.39 #1
 RIP: 0010:nf_tables_chain_destroy+0x1f7/0x210 [nf_tables]

Fixes: 4bedf9eee016 ("netfilter: nf_tables: fix chain binding transaction logic")
Reported-by: Kevin Rich <kevinrich1337@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_immediate.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/net/netfilter/nft_immediate.c b/net/netfilter/nft_immediate.c
index 900e75e8c3465..391c18e4b3ebd 100644
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -125,15 +125,27 @@ static void nft_immediate_activate(const struct nft_ctx *ctx,
 	return nft_data_hold(&priv->data, nft_dreg_to_type(priv->dreg));
 }
 
+static void nft_immediate_chain_deactivate(const struct nft_ctx *ctx,
+					   struct nft_chain *chain,
+					   enum nft_trans_phase phase)
+{
+	struct nft_ctx chain_ctx;
+	struct nft_rule *rule;
+
+	chain_ctx = *ctx;
+	chain_ctx.chain = chain;
+
+	list_for_each_entry(rule, &chain->rules, list)
+		nft_rule_expr_deactivate(&chain_ctx, rule, phase);
+}
+
 static void nft_immediate_deactivate(const struct nft_ctx *ctx,
 				     const struct nft_expr *expr,
 				     enum nft_trans_phase phase)
 {
 	const struct nft_immediate_expr *priv = nft_expr_priv(expr);
 	const struct nft_data *data = &priv->data;
-	struct nft_ctx chain_ctx;
 	struct nft_chain *chain;
-	struct nft_rule *rule;
 
 	if (priv->dreg == NFT_REG_VERDICT) {
 		switch (data->verdict.code) {
@@ -143,20 +155,17 @@ static void nft_immediate_deactivate(const struct nft_ctx *ctx,
 			if (!nft_chain_binding(chain))
 				break;
 
-			chain_ctx = *ctx;
-			chain_ctx.chain = chain;
-
-			list_for_each_entry(rule, &chain->rules, list)
-				nft_rule_expr_deactivate(&chain_ctx, rule, phase);
-
 			switch (phase) {
 			case NFT_TRANS_PREPARE_ERROR:
 				nf_tables_unbind_chain(ctx, chain);
-				fallthrough;
+				nft_deactivate_next(ctx->net, chain);
+				break;
 			case NFT_TRANS_PREPARE:
+				nft_immediate_chain_deactivate(ctx, chain, phase);
 				nft_deactivate_next(ctx->net, chain);
 				break;
 			default:
+				nft_immediate_chain_deactivate(ctx, chain, phase);
 				nft_chain_del(chain);
 				chain->bound = false;
 				chain->table->use--;
-- 
2.39.2



