Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D673070377E
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244028AbjEORV5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244029AbjEORVj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:21:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EF510A1A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:19:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C274462C37
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29D4C433EF;
        Mon, 15 May 2023 17:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171175;
        bh=6xlHvXlBl9JEB8ti6cUpKgnSMC9ERIGl3eyIEz4zWPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rpgmbjKXH6GFdtQvDnVszhS/ejhEwXdi9FAqxkYQ/CiNzytPk1NlfgvLsMaNguvd7
         heAphFElVPPbGJcIh0xSC01W1WGDfe5vwgBXiiCz8pGeLL1wXx2x+UEcPUFhx0lyKv
         7344O8tB5pVlVS3sg8fnTjQDyIMe209ndkMxufxI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 124/242] netfilter: nf_tables: extended netlink error reporting for netdevice
Date:   Mon, 15 May 2023 18:27:30 +0200
Message-Id: <20230515161725.625877519@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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

[ Upstream commit c3c060adc0249355411a93e61888051e6902b8a1 ]

Flowtable and netdev chains are bound to one or several netdevice,
extend netlink error reporting to specify the the netdevice that
triggers the error.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: 8509f62b0b07 ("netfilter: nf_tables: hit ENOENT on unexisting chain/flowtable update with missing attributes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 38 ++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 96bc4b8ded423..4b0a84a39b19e 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1951,7 +1951,8 @@ static struct nft_hook *nft_hook_list_find(struct list_head *hook_list,
 
 static int nf_tables_parse_netdev_hooks(struct net *net,
 					const struct nlattr *attr,
-					struct list_head *hook_list)
+					struct list_head *hook_list,
+					struct netlink_ext_ack *extack)
 {
 	struct nft_hook *hook, *next;
 	const struct nlattr *tmp;
@@ -1965,10 +1966,12 @@ static int nf_tables_parse_netdev_hooks(struct net *net,
 
 		hook = nft_netdev_hook_alloc(net, tmp);
 		if (IS_ERR(hook)) {
+			NL_SET_BAD_ATTR(extack, tmp);
 			err = PTR_ERR(hook);
 			goto err_hook;
 		}
 		if (nft_hook_list_find(hook_list, hook)) {
+			NL_SET_BAD_ATTR(extack, tmp);
 			kfree(hook);
 			err = -EEXIST;
 			goto err_hook;
@@ -2001,20 +2004,23 @@ struct nft_chain_hook {
 
 static int nft_chain_parse_netdev(struct net *net,
 				  struct nlattr *tb[],
-				  struct list_head *hook_list)
+				  struct list_head *hook_list,
+				  struct netlink_ext_ack *extack)
 {
 	struct nft_hook *hook;
 	int err;
 
 	if (tb[NFTA_HOOK_DEV]) {
 		hook = nft_netdev_hook_alloc(net, tb[NFTA_HOOK_DEV]);
-		if (IS_ERR(hook))
+		if (IS_ERR(hook)) {
+			NL_SET_BAD_ATTR(extack, tb[NFTA_HOOK_DEV]);
 			return PTR_ERR(hook);
+		}
 
 		list_add_tail(&hook->list, hook_list);
 	} else if (tb[NFTA_HOOK_DEVS]) {
 		err = nf_tables_parse_netdev_hooks(net, tb[NFTA_HOOK_DEVS],
-						   hook_list);
+						   hook_list, extack);
 		if (err < 0)
 			return err;
 
@@ -2082,7 +2088,7 @@ static int nft_chain_parse_hook(struct net *net,
 
 	INIT_LIST_HEAD(&hook->list);
 	if (nft_base_chain_netdev(family, hook->num)) {
-		err = nft_chain_parse_netdev(net, ha, &hook->list);
+		err = nft_chain_parse_netdev(net, ha, &hook->list, extack);
 		if (err < 0) {
 			module_put(type->owner);
 			return err;
@@ -7552,7 +7558,8 @@ static const struct nla_policy nft_flowtable_hook_policy[NFTA_FLOWTABLE_HOOK_MAX
 static int nft_flowtable_parse_hook(const struct nft_ctx *ctx,
 				    const struct nlattr *attr,
 				    struct nft_flowtable_hook *flowtable_hook,
-				    struct nft_flowtable *flowtable, bool add)
+				    struct nft_flowtable *flowtable,
+				    struct netlink_ext_ack *extack, bool add)
 {
 	struct nlattr *tb[NFTA_FLOWTABLE_HOOK_MAX + 1];
 	struct nft_hook *hook;
@@ -7599,7 +7606,8 @@ static int nft_flowtable_parse_hook(const struct nft_ctx *ctx,
 	if (tb[NFTA_FLOWTABLE_HOOK_DEVS]) {
 		err = nf_tables_parse_netdev_hooks(ctx->net,
 						   tb[NFTA_FLOWTABLE_HOOK_DEVS],
-						   &flowtable_hook->list);
+						   &flowtable_hook->list,
+						   extack);
 		if (err < 0)
 			return err;
 	}
@@ -7742,7 +7750,8 @@ static void nft_flowtable_hooks_destroy(struct list_head *hook_list)
 }
 
 static int nft_flowtable_update(struct nft_ctx *ctx, const struct nlmsghdr *nlh,
-				struct nft_flowtable *flowtable)
+				struct nft_flowtable *flowtable,
+				struct netlink_ext_ack *extack)
 {
 	const struct nlattr * const *nla = ctx->nla;
 	struct nft_flowtable_hook flowtable_hook;
@@ -7753,7 +7762,7 @@ static int nft_flowtable_update(struct nft_ctx *ctx, const struct nlmsghdr *nlh,
 	int err;
 
 	err = nft_flowtable_parse_hook(ctx, nla[NFTA_FLOWTABLE_HOOK],
-				       &flowtable_hook, flowtable, false);
+				       &flowtable_hook, flowtable, extack, false);
 	if (err < 0)
 		return err;
 
@@ -7858,7 +7867,7 @@ static int nf_tables_newflowtable(struct sk_buff *skb,
 
 		nft_ctx_init(&ctx, net, skb, info->nlh, family, table, NULL, nla);
 
-		return nft_flowtable_update(&ctx, info->nlh, flowtable);
+		return nft_flowtable_update(&ctx, info->nlh, flowtable, extack);
 	}
 
 	nft_ctx_init(&ctx, net, skb, info->nlh, family, table, NULL, nla);
@@ -7899,7 +7908,7 @@ static int nf_tables_newflowtable(struct sk_buff *skb,
 		goto err3;
 
 	err = nft_flowtable_parse_hook(&ctx, nla[NFTA_FLOWTABLE_HOOK],
-				       &flowtable_hook, flowtable, true);
+				       &flowtable_hook, flowtable, extack, true);
 	if (err < 0)
 		goto err4;
 
@@ -7951,7 +7960,8 @@ static void nft_flowtable_hook_release(struct nft_flowtable_hook *flowtable_hook
 }
 
 static int nft_delflowtable_hook(struct nft_ctx *ctx,
-				 struct nft_flowtable *flowtable)
+				 struct nft_flowtable *flowtable,
+				 struct netlink_ext_ack *extack)
 {
 	const struct nlattr * const *nla = ctx->nla;
 	struct nft_flowtable_hook flowtable_hook;
@@ -7961,7 +7971,7 @@ static int nft_delflowtable_hook(struct nft_ctx *ctx,
 	int err;
 
 	err = nft_flowtable_parse_hook(ctx, nla[NFTA_FLOWTABLE_HOOK],
-				       &flowtable_hook, flowtable, false);
+				       &flowtable_hook, flowtable, extack, false);
 	if (err < 0)
 		return err;
 
@@ -8039,7 +8049,7 @@ static int nf_tables_delflowtable(struct sk_buff *skb,
 	nft_ctx_init(&ctx, net, skb, info->nlh, family, table, NULL, nla);
 
 	if (nla[NFTA_FLOWTABLE_HOOK])
-		return nft_delflowtable_hook(&ctx, flowtable);
+		return nft_delflowtable_hook(&ctx, flowtable, extack);
 
 	if (flowtable->use > 0) {
 		NL_SET_BAD_ATTR(extack, attr);
-- 
2.39.2



