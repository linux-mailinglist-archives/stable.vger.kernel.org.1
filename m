Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7889A7ED6A2
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 23:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343766AbjKOWCi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 17:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343783AbjKOWCh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 17:02:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0AD1A4
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 14:02:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E212DC433C8;
        Wed, 15 Nov 2023 22:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700085754;
        bh=MGz73rDYUOHgr65Hv2OSrD3lAYC4NBCqnfym/ZWeYZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HfYYbgTABNUs31xOGjQ7zqRh+KETYUf1Ii9eYlxt3QANaWNKlSj0YRhxelQeEr9a8
         P6Ybf+ZJvBv2NBQA4PTGgT6TUQn29zeuxVv8qg3RV6Olq8q/hsGyrgkzzk/ixiiogS
         X88BMLnte3d1q6LMrBAhQSc/VUY6r0x5oqt5zOHg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 030/119] clk: mediatek: clk-mt6779: Add check for mtk_alloc_clk_data
Date:   Wed, 15 Nov 2023 17:00:20 -0500
Message-ID: <20231115220133.562433114@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115220132.607437515@linuxfoundation.org>
References: <20231115220132.607437515@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

[ Upstream commit 1f57f78fbacf630430bf954e5a84caafdfea30c0 ]

Add the check for the return value of mtk_alloc_clk_data() in order to
avoid NULL pointer dereference.

Fixes: 710774e04861 ("clk: mediatek: Add MT6779 clock support")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Link: https://lore.kernel.org/r/20230912093407.21505-2-jiasheng@iscas.ac.cn
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/mediatek/clk-mt6779.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt6779.c b/drivers/clk/mediatek/clk-mt6779.c
index 00920182bbe63..f7b5ec749ab96 100644
--- a/drivers/clk/mediatek/clk-mt6779.c
+++ b/drivers/clk/mediatek/clk-mt6779.c
@@ -1216,6 +1216,8 @@ static int clk_mt6779_apmixed_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 
@@ -1237,6 +1239,8 @@ static int clk_mt6779_top_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
 				    clk_data);
-- 
2.42.0



