Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1F074875A
	for <lists+stable@lfdr.de>; Wed,  5 Jul 2023 17:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbjGEPCg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 5 Jul 2023 11:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbjGEPCa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 5 Jul 2023 11:02:30 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADDB11BFA;
        Wed,  5 Jul 2023 08:02:01 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     sashal@kernel.org, gregkh@linuxfoundation.org,
        stable@vger.kernel.org
Subject: [PATCH -stable,5.10,v2 10/11] netfilter: nf_tables: unbind non-anonymous set if rule construction fails
Date:   Wed,  5 Jul 2023 17:00:10 +0200
Message-Id: <20230705150011.59408-11-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230705150011.59408-1-pablo@netfilter.org>
References: <20230705150011.59408-1-pablo@netfilter.org>
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
index 2a9deeb76835..5b6a57fd858f 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4719,6 +4719,8 @@ void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 		nft_set_trans_unbind(ctx, set);
 		if (nft_set_is_anonymous(set))
 			nft_deactivate_next(ctx->net, set);
+		else
+			list_del_rcu(&binding->list);
 
 		set->use--;
 		break;
-- 
2.30.2

