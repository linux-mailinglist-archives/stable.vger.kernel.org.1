Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A5473E980
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjFZSgp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjFZSgo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:36:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FF39B
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:36:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B65A60F40
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0634C433C9;
        Mon, 26 Jun 2023 18:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804602;
        bh=dNjhZ7YYC2cpui8ttTE4j7w2r0dksdk/CDNJgyj8gOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S9KZ10OIqU8qRi6jtro/bjhepp9SucV/RC9AWkN5RNg4VRdRoNBNH6esDzkrSa5/E
         QkCpeMF+pbAKKOlnkDyiuBKHFlZl1WxQXSYRTP+xWsIWNx7xbnFu1vZAglEGfHuuHs
         Zj2mQ4px0Hfvg+uCCwVjt1/rh4L4/YD0y6KNSDyE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 40/60] netfilter: nf_tables: disallow element updates of bound anonymous sets
Date:   Mon, 26 Jun 2023 20:12:19 +0200
Message-ID: <20230626180741.193887738@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180739.558575012@linuxfoundation.org>
References: <20230626180739.558575012@linuxfoundation.org>
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

[ Upstream commit c88c535b592d3baeee74009f3eceeeaf0fdd5e1b ]

Anonymous sets come with NFT_SET_CONSTANT from userspace. Although API
allows to create anonymous sets without NFT_SET_CONSTANT, it makes no
sense to allow to add and to delete elements for bound anonymous sets.

Fixes: 96518518cc41 ("netfilter: add nftables")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 909076ef157e8..914fbd9ecef96 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4804,7 +4804,8 @@ static int nf_tables_newsetelem(struct net *net, struct sock *nlsk,
 	if (IS_ERR(set))
 		return PTR_ERR(set);
 
-	if (!list_empty(&set->bindings) && set->flags & NFT_SET_CONSTANT)
+	if (!list_empty(&set->bindings) &&
+	    (set->flags & (NFT_SET_CONSTANT | NFT_SET_ANONYMOUS)))
 		return -EBUSY;
 
 	nla_for_each_nested(attr, nla[NFTA_SET_ELEM_LIST_ELEMENTS], rem) {
@@ -4987,7 +4988,9 @@ static int nf_tables_delsetelem(struct net *net, struct sock *nlsk,
 	set = nft_set_lookup(ctx.table, nla[NFTA_SET_ELEM_LIST_SET], genmask);
 	if (IS_ERR(set))
 		return PTR_ERR(set);
-	if (!list_empty(&set->bindings) && set->flags & NFT_SET_CONSTANT)
+
+	if (!list_empty(&set->bindings) &&
+	    (set->flags & (NFT_SET_CONSTANT | NFT_SET_ANONYMOUS)))
 		return -EBUSY;
 
 	if (nla[NFTA_SET_ELEM_LIST_ELEMENTS] == NULL) {
-- 
2.39.2



