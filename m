Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608C572C1C6
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237384AbjFLLA3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237620AbjFLK7y (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:59:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDC6127E8
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:46:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E3DF6247B
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D04EC4339B;
        Mon, 12 Jun 2023 10:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566816;
        bh=U0Fjhdii9OMNHLJzzBnfo9/TjS1tMaJ5trJZgLwSLoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BpOTkCQlV2YRtgpeZ7y1DVYBe30Ku8lzh/IuTgVGBfp969Ub+UWr52BQx47LePYyu
         LZxDcsj8+HcmEX7pixJzqNxzogh/NGvtL5PNK1Nic+7qr9SwzolDgApovlVhQdDA69
         4Vw4KfOOF27xlWrSQPgmH4Pa7x9JZFGSq5Eho6RU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jeremy Sowden <jeremy@azazel.net>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 042/160] netfilter: nft_bitwise: fix register tracking
Date:   Mon, 12 Jun 2023 12:26:14 +0200
Message-ID: <20230612101716.965947218@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
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

From: Jeremy Sowden <jeremy@azazel.net>

[ Upstream commit 14e8b293903785590a0ef168745ac84250cb1f4c ]

At the end of `nft_bitwise_reduce`, there is a loop which is intended to
update the bitwise expression associated with each tracked destination
register.  However, currently, it just updates the first register
repeatedly.  Fix it.

Fixes: 34cc9e52884a ("netfilter: nf_tables: cancel tracking for clobbered destination registers")
Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_bitwise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_bitwise.c b/net/netfilter/nft_bitwise.c
index 84eae7cabc67a..2527a01486efc 100644
--- a/net/netfilter/nft_bitwise.c
+++ b/net/netfilter/nft_bitwise.c
@@ -323,7 +323,7 @@ static bool nft_bitwise_reduce(struct nft_regs_track *track,
 	dreg = priv->dreg;
 	regcount = DIV_ROUND_UP(priv->len, NFT_REG32_SIZE);
 	for (i = 0; i < regcount; i++, dreg++)
-		track->regs[priv->dreg].bitwise = expr;
+		track->regs[dreg].bitwise = expr;
 
 	return false;
 }
-- 
2.39.2



