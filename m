Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0095A7758C5
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbjHIKzV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbjHIKzJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:55:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB8E211D
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:53:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AD1D63142
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893F7C433C7;
        Wed,  9 Aug 2023 10:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578418;
        bh=eZrklH5sZ77N4MIS5E+KpLGufMYlpx9j5J25AaEjfYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=omibVwYugPHgfnk7uUzxuAEmUS3Bm4fhoLmSxRs2fQdfuRH+DEtmYhRDYFiHEsZ06
         bL+8LLUS20as/rtPZXNbP2tt8F+o+YDDDq0Ic2oRmg2sHBDzaDlZWfFYXqRqYWZBe8
         JMEDCUTGNh3S8Fa7wEEsA0QmQ4vqSQQWd8QUNUPo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 053/127] net: korina: handle clk prepare error in korina_probe()
Date:   Wed,  9 Aug 2023 12:40:40 +0200
Message-ID: <20230809103638.433778100@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
References: <20230809103636.615294317@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yuanjun Gong <ruc_gongyuanjun@163.com>

[ Upstream commit 0b6291ad1940c403734312d0e453e8dac9148f69 ]

in korina_probe(), the return value of clk_prepare_enable()
should be checked since it might fail. we can use
devm_clk_get_optional_enabled() instead of devm_clk_get_optional()
and clk_prepare_enable() to automatically handle the error.

Fixes: e4cd854ec487 ("net: korina: Get mdio input clock via common clock framework")
Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
Link: https://lore.kernel.org/r/20230731090535.21416-1-ruc_gongyuanjun@163.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/korina.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/korina.c b/drivers/net/ethernet/korina.c
index 2b9335cb4bb3a..8537578e1cf1d 100644
--- a/drivers/net/ethernet/korina.c
+++ b/drivers/net/ethernet/korina.c
@@ -1302,11 +1302,10 @@ static int korina_probe(struct platform_device *pdev)
 	else if (of_get_ethdev_address(pdev->dev.of_node, dev) < 0)
 		eth_hw_addr_random(dev);
 
-	clk = devm_clk_get_optional(&pdev->dev, "mdioclk");
+	clk = devm_clk_get_optional_enabled(&pdev->dev, "mdioclk");
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 	if (clk) {
-		clk_prepare_enable(clk);
 		lp->mii_clock_freq = clk_get_rate(clk);
 	} else {
 		lp->mii_clock_freq = 200000000; /* max possible input clk */
-- 
2.40.1



