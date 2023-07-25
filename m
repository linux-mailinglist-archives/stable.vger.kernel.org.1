Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5561B7615D4
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbjGYLdj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbjGYLdi (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:33:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCC3118
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:33:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2371761683
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3400FC433C8;
        Tue, 25 Jul 2023 11:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284816;
        bh=ZwQFuQ8LsVDglOkQLF9O0K9Sdro5+MVlBN9FZhj9+OQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c6gMEli9Z/LNdOOYOcYtzB7E4TpT3pD3S8FqfPhnOFdsuXWqAllYObhTQ4a4cjakk
         XyPaLSRol/oAvJ5wkhTPwwuzdYrjNkblwe7t3f0wnGMILg8ay7VAKh5cfBmwj3pK/F
         HCQ+MoZkB3vbAxFTXWJIc0ufCSwYDbXIA6XOk/nM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 491/509] netfilter: nf_tables: skip bound chain in netns release path
Date:   Tue, 25 Jul 2023 12:47:10 +0200
Message-ID: <20230725104616.227969874@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 751d460ccff3137212f47d876221534bf0490996 ]

Skip bound chain from netns release path, the rule that owns this chain
releases these objects.

Fixes: d0e2c7de92c7 ("netfilter: nf_tables: add NFT_CHAIN_BINDING")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index a8d316a58e44c..40ed4dd530c5a 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -9185,6 +9185,9 @@ static void __nft_release_table(struct net *net, struct nft_table *table)
 	ctx.family = table->family;
 	ctx.table = table;
 	list_for_each_entry(chain, &table->chains, list) {
+		if (nft_chain_is_bound(chain))
+			continue;
+
 		ctx.chain = chain;
 		list_for_each_entry_safe(rule, nr, &chain->rules, list) {
 			list_del(&rule->list);
-- 
2.39.2



