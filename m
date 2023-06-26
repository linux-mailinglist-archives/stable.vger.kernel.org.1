Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A113373E914
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjFZScg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjFZScU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:32:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5771D270B
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:32:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37FF460F45
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C2FC433C8;
        Mon, 26 Jun 2023 18:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804321;
        bh=ZQsHNlfvGWXK8XmJ9koA0qK7hcn9k08Lw3IBr3lEckg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bu4601RfMprZPlTqtBLPiLxLojBoHPsz3xSLxjX0xqw1sIqT5L1hs5PpiUzgLNCWK
         UNpbUpDNCqZof7/MSrpLK/H2i2uTxDk/tRqT85Ux4xFr2P7A8dVaFiUAz9uYo1nKKg
         aqMlyX//1iJDxaj7pLvNyiLJ/mLHw1Bun8DaOKRU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 117/170] netfilter: nf_tables: disallow updates of anonymous sets
Date:   Mon, 26 Jun 2023 20:11:26 +0200
Message-ID: <20230626180805.809508065@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
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

[ Upstream commit b770283c98e0eee9133c47bc03b6cc625dc94723 ]

Disallow updates of set timeout and garbage collection parameters for
anonymous sets.

Fixes: 123b99619cca ("netfilter: nf_tables: honor set timeout and garbage collection updates")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 984720964a498..7f71bdbc82672 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4774,6 +4774,9 @@ static int nf_tables_newset(struct sk_buff *skb, const struct nfnl_info *info,
 		if (info->nlh->nlmsg_flags & NLM_F_REPLACE)
 			return -EOPNOTSUPP;
 
+		if (nft_set_is_anonymous(set))
+			return -EOPNOTSUPP;
+
 		err = nft_set_expr_alloc(&ctx, set, nla, exprs, &num_exprs, flags);
 		if (err < 0)
 			return err;
-- 
2.39.2



