Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4A77034AF
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243106AbjEOQvG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243122AbjEOQu6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:50:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B376185
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:50:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14A5462982
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A33C433EF;
        Mon, 15 May 2023 16:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169454;
        bh=0D4IA4SHNWemuEwpiLXvyPFsdWPRbvt3EWAV5AX/6Uc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xgvamqen9gIAhaCHHmgUdYMMZ5cpL+YaEvo1PugUV9YnintMcMF827FKIToZ6ZoOP
         3qHqzQRZW+8gmyNOiCXTpm0RkghpMqi7UdfOfuf1Me6mJDolN9vw6mzAr7OPLUGYz8
         6pt8NJVKUar9vNt6DwcV0YwkGr/shHWAweQU3sbQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 063/246] netfilter: nf_tables: hit ENOENT on unexisting chain/flowtable update with missing attributes
Date:   Mon, 15 May 2023 18:24:35 +0200
Message-Id: <20230515161724.471425994@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 8509f62b0b07ae8d6dec5aa9613ab1b250ff632f ]

If user does not specify hook number and priority, then assume this is
a chain/flowtable update. Therefore, report ENOENT which provides a
better hint than EINVAL. Set on extended netlink error report to refer
to the chain name.

Fixes: 5b6743fb2c2a ("netfilter: nf_tables: skip flowtable hooknum and priority on device updates")
Fixes: 5efe72698a97 ("netfilter: nf_tables: support for adding new devices to an existing netdev chain")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index f64e83323473a..45f701fd86f06 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2066,8 +2066,10 @@ static int nft_chain_parse_hook(struct net *net,
 
 	if (!basechain) {
 		if (!ha[NFTA_HOOK_HOOKNUM] ||
-		    !ha[NFTA_HOOK_PRIORITY])
-			return -EINVAL;
+		    !ha[NFTA_HOOK_PRIORITY]) {
+			NL_SET_BAD_ATTR(extack, nla[NFTA_CHAIN_NAME]);
+			return -ENOENT;
+		}
 
 		hook->num = ntohl(nla_get_be32(ha[NFTA_HOOK_HOOKNUM]));
 		hook->priority = ntohl(nla_get_be32(ha[NFTA_HOOK_PRIORITY]));
@@ -7630,7 +7632,7 @@ static const struct nla_policy nft_flowtable_hook_policy[NFTA_FLOWTABLE_HOOK_MAX
 };
 
 static int nft_flowtable_parse_hook(const struct nft_ctx *ctx,
-				    const struct nlattr *attr,
+				    const struct nlattr * const nla[],
 				    struct nft_flowtable_hook *flowtable_hook,
 				    struct nft_flowtable *flowtable,
 				    struct netlink_ext_ack *extack, bool add)
@@ -7642,15 +7644,18 @@ static int nft_flowtable_parse_hook(const struct nft_ctx *ctx,
 
 	INIT_LIST_HEAD(&flowtable_hook->list);
 
-	err = nla_parse_nested_deprecated(tb, NFTA_FLOWTABLE_HOOK_MAX, attr,
+	err = nla_parse_nested_deprecated(tb, NFTA_FLOWTABLE_HOOK_MAX,
+					  nla[NFTA_FLOWTABLE_HOOK],
 					  nft_flowtable_hook_policy, NULL);
 	if (err < 0)
 		return err;
 
 	if (add) {
 		if (!tb[NFTA_FLOWTABLE_HOOK_NUM] ||
-		    !tb[NFTA_FLOWTABLE_HOOK_PRIORITY])
-			return -EINVAL;
+		    !tb[NFTA_FLOWTABLE_HOOK_PRIORITY]) {
+			NL_SET_BAD_ATTR(extack, nla[NFTA_FLOWTABLE_NAME]);
+			return -ENOENT;
+		}
 
 		hooknum = ntohl(nla_get_be32(tb[NFTA_FLOWTABLE_HOOK_NUM]));
 		if (hooknum != NF_NETDEV_INGRESS)
@@ -7835,8 +7840,8 @@ static int nft_flowtable_update(struct nft_ctx *ctx, const struct nlmsghdr *nlh,
 	u32 flags;
 	int err;
 
-	err = nft_flowtable_parse_hook(ctx, nla[NFTA_FLOWTABLE_HOOK],
-				       &flowtable_hook, flowtable, extack, false);
+	err = nft_flowtable_parse_hook(ctx, nla, &flowtable_hook, flowtable,
+				       extack, false);
 	if (err < 0)
 		return err;
 
@@ -7981,8 +7986,8 @@ static int nf_tables_newflowtable(struct sk_buff *skb,
 	if (err < 0)
 		goto err3;
 
-	err = nft_flowtable_parse_hook(&ctx, nla[NFTA_FLOWTABLE_HOOK],
-				       &flowtable_hook, flowtable, extack, true);
+	err = nft_flowtable_parse_hook(&ctx, nla, &flowtable_hook, flowtable,
+				       extack, true);
 	if (err < 0)
 		goto err4;
 
@@ -8044,8 +8049,8 @@ static int nft_delflowtable_hook(struct nft_ctx *ctx,
 	struct nft_trans *trans;
 	int err;
 
-	err = nft_flowtable_parse_hook(ctx, nla[NFTA_FLOWTABLE_HOOK],
-				       &flowtable_hook, flowtable, extack, false);
+	err = nft_flowtable_parse_hook(ctx, nla, &flowtable_hook, flowtable,
+				       extack, false);
 	if (err < 0)
 		return err;
 
-- 
2.39.2



