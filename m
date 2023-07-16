Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B17755207
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjGPUC7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjGPUC5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:02:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C589D
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:02:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D989B60EA6
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:02:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7FBC433C8;
        Sun, 16 Jul 2023 20:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537776;
        bh=5UsgjKgaHO6N8lAVj4nRUuwIwign7Sg7l0/uxAAUumM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Th4smnFd6dixlCgA2mXHqhpFcuqTuq6+aLuDFbkGF0/kjjMhR8HkfEaQCsyat+igB
         /XH18xRn+2bTTvb8kk/RVjrQLNo1hwl3s2P/sKIOEBFDHo9U96Cl96DLIR/ZXmCM/E
         DVpuQojWghoVdY64NpWDh3/TItIMzZ00cbGmr6s8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 217/800] netfilter: nf_tables: unbind non-anonymous set if rule construction fails
Date:   Sun, 16 Jul 2023 21:41:10 +0200
Message-ID: <20230716194954.134929961@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 3e70489721b6c870252c9082c496703677240f53 ]

Otherwise a dangling reference to a rule object that is gone remains
in the set binding list.

Fixes: 26b5a5712eb8 ("netfilter: nf_tables: add NFT_TRANS_PREPARE_ERROR to deal with bound set/chain")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 4c7937fd803f9..1d64c163076a1 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5343,6 +5343,8 @@ void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 		nft_set_trans_unbind(ctx, set);
 		if (nft_set_is_anonymous(set))
 			nft_deactivate_next(ctx->net, set);
+		else
+			list_del_rcu(&binding->list);
 
 		set->use--;
 		break;
-- 
2.39.2



