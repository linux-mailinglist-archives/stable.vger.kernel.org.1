Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD907489C5
	for <lists+stable@lfdr.de>; Wed,  5 Jul 2023 18:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjGEQ4b (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 5 Jul 2023 12:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjGEQ4a (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 5 Jul 2023 12:56:30 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BF7F171C;
        Wed,  5 Jul 2023 09:56:29 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     sashal@kernel.org, gregkh@linuxfoundation.org,
        stable@vger.kernel.org
Subject: [PATCH -stable,4.14 3/3] netfilter: nf_tables: unbind non-anonymous set if rule construction fails
Date:   Wed,  5 Jul 2023 18:56:23 +0200
Message-Id: <20230705165623.50304-4-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230705165623.50304-1-pablo@netfilter.org>
References: <20230705165623.50304-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[ 3e70489721b6c870252c9082c496703677240f53 ]

Otherwise a dangling reference to a rule object that is gone remains
in the set binding list.

Fixes: 26b5a5712eb8 ("netfilter: nf_tables: add NFT_TRANS_PREPARE_ERROR to deal with bound set/chain")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 624de5f25557..b016ae68d9db 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3461,6 +3461,8 @@ void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 		nft_set_trans_unbind(ctx, set);
 		if (set->flags & NFT_SET_ANONYMOUS)
 			nft_deactivate_next(ctx->net, set);
+		else
+			list_del_rcu(&binding->list);
 
 		set->use--;
 		break;
-- 
2.30.2

