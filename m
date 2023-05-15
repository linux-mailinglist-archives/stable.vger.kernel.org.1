Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666597034C7
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243090AbjEOQwM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243110AbjEOQvz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:51:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DA25BAA
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:51:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EC776298D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DEAC433EF;
        Mon, 15 May 2023 16:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169513;
        bh=kRa/bjtKIZol98kBkfkNCuv5f4XFIPOMp9eF/zVnAq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lKyLUECQ+U0+RB3QymbMaoOsS5qYTrXb242uW+018zPNzTeOmcRwDsWzn3Ro+zOWC
         kGhCqw1ITwm3ooSjRtZJb9KtZsf0+G5oJqS5OPjqM5640sIDbl7+ivnO0AymevXn88
         S+DEJkt4phkRd7o/dgchY1f5XmOk+afRdJRbqwZc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rvfg <i@rvf6.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 081/246] netfilter: nf_tables: fix ct untracked match breakage
Date:   Mon, 15 May 2023 18:24:53 +0200
Message-Id: <20230515161725.009039005@linuxfoundation.org>
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

From: Florian Westphal <fw@strlen.de>

[ Upstream commit f057b63bc11d86a98176de31b437e46789f44d8f ]

"ct untracked" no longer works properly due to erroneous NFT_BREAK.
We have to check ctinfo enum first.

Fixes: d9e789147605 ("netfilter: nf_tables: avoid retpoline overhead for some ct expression calls")
Reported-by: Rvfg <i@rvf6.com>
Link: https://marc.info/?l=netfilter&m=168294996212038&w=2
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_ct_fast.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nft_ct_fast.c b/net/netfilter/nft_ct_fast.c
index 89983b0613fa3..e684c8a918487 100644
--- a/net/netfilter/nft_ct_fast.c
+++ b/net/netfilter/nft_ct_fast.c
@@ -15,10 +15,6 @@ void nft_ct_get_fast_eval(const struct nft_expr *expr,
 	unsigned int state;
 
 	ct = nf_ct_get(pkt->skb, &ctinfo);
-	if (!ct) {
-		regs->verdict.code = NFT_BREAK;
-		return;
-	}
 
 	switch (priv->key) {
 	case NFT_CT_STATE:
@@ -30,6 +26,16 @@ void nft_ct_get_fast_eval(const struct nft_expr *expr,
 			state = NF_CT_STATE_INVALID_BIT;
 		*dest = state;
 		return;
+	default:
+		break;
+	}
+
+	if (!ct) {
+		regs->verdict.code = NFT_BREAK;
+		return;
+	}
+
+	switch (priv->key) {
 	case NFT_CT_DIRECTION:
 		nft_reg_store8(dest, CTINFO2DIR(ctinfo));
 		return;
-- 
2.39.2



