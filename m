Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8631761239
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjGYLAU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbjGYK74 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:59:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253A13C1B
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:57:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 909AC61602
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC94C433C7;
        Tue, 25 Jul 2023 10:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282631;
        bh=f4tUOHA0cuJYXQGH5bcJqFwTv2vXZhnsxa2KCzaFT70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j5fohligMPXR9ZZ38qsm/yOyoVPbaxg33myYxaRIeYgiAkxgu/frNGEL0wuCbQR9f
         OQxMZHg7wTnHH14u5iIElCo4i3astUrHaHwe/RRfR3KW0uojmebiuy1Ym01pFWGgxa
         kkTbXXQvZI+9J/7Pe7DSH4XYgi6sh+0cPjsX8Ij4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kevin Rich <kevinrich1337@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 199/227] netfilter: nf_tables: skip bound chain on rule flush
Date:   Tue, 25 Jul 2023 12:46:06 +0200
Message-ID: <20230725104523.043385755@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 6eaf41e87a223ae6f8e7a28d6e78384ad7e407f8 ]

Skip bound chain when flushing table rules, the rule that owns this
chain releases these objects.

Otherwise, the following warning is triggered:

  WARNING: CPU: 2 PID: 1217 at net/netfilter/nf_tables_api.c:2013 nf_tables_chain_destroy+0x1f7/0x210 [nf_tables]
  CPU: 2 PID: 1217 Comm: chain-flush Not tainted 6.1.39 #1
  RIP: 0010:nf_tables_chain_destroy+0x1f7/0x210 [nf_tables]

Fixes: d0e2c7de92c7 ("netfilter: nf_tables: add NFT_CHAIN_BINDING")
Reported-by: Kevin Rich <kevinrich1337@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index e3049c7db9041..ccf0b3d80fd97 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4086,6 +4086,8 @@ static int nf_tables_delrule(struct sk_buff *skb, const struct nfnl_info *info,
 		list_for_each_entry(chain, &table->chains, list) {
 			if (!nft_is_active_next(net, chain))
 				continue;
+			if (nft_chain_is_bound(chain))
+				continue;
 
 			ctx.chain = chain;
 			err = nft_delrule_by_chain(&ctx);
-- 
2.39.2



