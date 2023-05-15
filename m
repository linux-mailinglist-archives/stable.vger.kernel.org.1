Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9197C7037F8
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244247AbjEOR0S (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244056AbjEORZx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:25:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7B78685
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:24:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECB7562C41
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7B2C433D2;
        Mon, 15 May 2023 17:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171178;
        bh=V+emYwIgfgLAfSZ8nB7XhKP1OCsnF64Gg+d0pCjIe/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KPjJKxtWGmspSA+rxcutJ1cps1FdtVu89R/zEmF/uwfMp+WaWKlUCbPKrj+6AMTah
         fYAofe9zaZxjQUs4MwD+iz4aody8EUPj7SnMGU36Rajz3SREf38vDXmd2R8jfPvP7a
         XceGgdDSOFnwBWvvBdtre94XYtZvsOWghIT+39E4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 125/242] netfilter: nf_tables: rename function to destroy hook list
Date:   Mon, 15 May 2023 18:27:31 +0200
Message-Id: <20230515161725.654592177@linuxfoundation.org>
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

[ Upstream commit cdc32546632354305afdcf399a5431138a31c9e0 ]

Rename nft_flowtable_hooks_destroy() by nft_hooks_destroy() to prepare
for netdev chain device updates.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: 8509f62b0b07 ("netfilter: nf_tables: hit ENOENT on unexisting chain/flowtable update with missing attributes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 4b0a84a39b19e..4ffafef46d2e2 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -7739,7 +7739,7 @@ static int nft_register_flowtable_net_hooks(struct net *net,
 	return err;
 }
 
-static void nft_flowtable_hooks_destroy(struct list_head *hook_list)
+static void nft_hooks_destroy(struct list_head *hook_list)
 {
 	struct nft_hook *hook, *next;
 
@@ -7920,7 +7920,7 @@ static int nf_tables_newflowtable(struct sk_buff *skb,
 					       &flowtable->hook_list,
 					       flowtable);
 	if (err < 0) {
-		nft_flowtable_hooks_destroy(&flowtable->hook_list);
+		nft_hooks_destroy(&flowtable->hook_list);
 		goto err4;
 	}
 
@@ -8695,7 +8695,7 @@ static void nft_commit_release(struct nft_trans *trans)
 		break;
 	case NFT_MSG_DELFLOWTABLE:
 		if (nft_trans_flowtable_update(trans))
-			nft_flowtable_hooks_destroy(&nft_trans_flowtable_hooks(trans));
+			nft_hooks_destroy(&nft_trans_flowtable_hooks(trans));
 		else
 			nf_tables_flowtable_destroy(nft_trans_flowtable(trans));
 		break;
@@ -9341,7 +9341,7 @@ static void nf_tables_abort_release(struct nft_trans *trans)
 		break;
 	case NFT_MSG_NEWFLOWTABLE:
 		if (nft_trans_flowtable_update(trans))
-			nft_flowtable_hooks_destroy(&nft_trans_flowtable_hooks(trans));
+			nft_hooks_destroy(&nft_trans_flowtable_hooks(trans));
 		else
 			nf_tables_flowtable_destroy(nft_trans_flowtable(trans));
 		break;
-- 
2.39.2



