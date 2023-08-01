Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274ED76AD21
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjHAJ0p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjHAJ0Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:26:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F146F2D67
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:25:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3EB3614FE
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4107C433C7;
        Tue,  1 Aug 2023 09:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690881917;
        bh=KMK7dFgTT2c4G9OFv2qbTGw8rnSgXdj158CuXgf+BgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B3RySZt+aTii4TvgF7pbgZkfaZh1wqg4GrcOcU9w2e+u4JwpfhhvSzRM+6QLM3/Sf
         wyxvOk3pbXdecSIebWeFPo8uI0cMjYBXHdBBRTmU93NJcKR+ROC7OfGtWKiQW3QD2N
         djhHwaFMOLcS9J1Csdg9nKj+y8fL7L8JAsjmQjsk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kevin Rich <kevinrich1337@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 075/155] netfilter: nf_tables: disallow rule addition to bound chain via NFTA_RULE_CHAIN_ID
Date:   Tue,  1 Aug 2023 11:19:47 +0200
Message-ID: <20230801091912.823773901@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 0ebc1064e4874d5987722a2ddbc18f94aa53b211 ]

Bail out with EOPNOTSUPP when adding rule to bound chain via
NFTA_RULE_CHAIN_ID. The following warning splat is shown when
adding a rule to a deleted bound chain:

 WARNING: CPU: 2 PID: 13692 at net/netfilter/nf_tables_api.c:2013 nf_tables_chain_destroy+0x1f7/0x210 [nf_tables]
 CPU: 2 PID: 13692 Comm: chain-bound-rul Not tainted 6.1.39 #1
 RIP: 0010:nf_tables_chain_destroy+0x1f7/0x210 [nf_tables]

Fixes: d0e2c7de92c7 ("netfilter: nf_tables: add NFT_CHAIN_BINDING")
Reported-by: Kevin Rich <kevinrich1337@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index e0e675313d8e1..ce9f962380b7b 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3529,8 +3529,6 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 			NL_SET_BAD_ATTR(extack, nla[NFTA_RULE_CHAIN]);
 			return PTR_ERR(chain);
 		}
-		if (nft_chain_is_bound(chain))
-			return -EOPNOTSUPP;
 
 	} else if (nla[NFTA_RULE_CHAIN_ID]) {
 		chain = nft_chain_lookup_byid(net, table, nla[NFTA_RULE_CHAIN_ID],
@@ -3543,6 +3541,9 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 		return -EINVAL;
 	}
 
+	if (nft_chain_is_bound(chain))
+		return -EOPNOTSUPP;
+
 	if (nla[NFTA_RULE_HANDLE]) {
 		handle = be64_to_cpu(nla_get_be64(nla[NFTA_RULE_HANDLE]));
 		rule = __nft_rule_lookup(chain, handle);
-- 
2.39.2



