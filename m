Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CC274C33E
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbjGIL36 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbjGIL35 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:29:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0679013D
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:29:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F25160B7F
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21C1C433C8;
        Sun,  9 Jul 2023 11:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902196;
        bh=YwnMdKqtWycYR/lI50/IvyyNlFZ9k7Zr4yBPfXcCII0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uov1Fp/LziJkEG/jLYCryIszhkDsv8kmdpWfLByr1MSFsDJr3Hlb25mQvmPrWxp7n
         dwpqS0un3biJzEZyyHkjpuQlBKZgrf8VhLHAuQBwwFlmhgk3x9IN+UPTauqT4K1nCy
         dsBdxca3zGE76KmFTVuKP2+kxQzH+iJJl52mdBnM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhanhao Hu <zero12113@hust.edu.cn>,
        Abel Vesa <abel.vesa@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 290/431] clk: imx93: fix memory leak and missing unwind goto in imx93_clocks_probe
Date:   Sun,  9 Jul 2023 13:13:58 +0200
Message-ID: <20230709111457.945523460@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zhanhao Hu <zero12113@hust.edu.cn>

[ Upstream commit e02ba11b457647050cb16e7cad16cec3c252fade ]

In function probe(), it returns directly without unregistered hws
when error occurs.

Fix this by adding 'goto unregister_hws;' on line 295 and
line 310.

Use devm_kzalloc() instead of kzalloc() to automatically
free the memory using devm_kfree() when error occurs.

Replace of_iomap() with devm_of_iomap() to automatically
handle the unused ioremap region and delete 'iounmap(anatop_base);'
in unregister_hws.

Fixes: 24defbe194b6 ("clk: imx: add i.MX93 clk")
Signed-off-by: Zhanhao Hu <zero12113@hust.edu.cn>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Link: https://lore.kernel.org/r/20230601033825.336558-1-zero12113@hust.edu.cn
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-imx93.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index 8d0974db6bfd8..face30012b7dd 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -262,7 +262,7 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 	void __iomem *base, *anatop_base;
 	int i, ret;
 
-	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
+	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws,
 					  IMX93_CLK_END), GFP_KERNEL);
 	if (!clk_hw_data)
 		return -ENOMEM;
@@ -286,10 +286,12 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 								    "sys_pll_pfd2", 1, 2);
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx93-anatop");
-	anatop_base = of_iomap(np, 0);
+	anatop_base = devm_of_iomap(dev, np, 0, NULL);
 	of_node_put(np);
-	if (WARN_ON(!anatop_base))
-		return -ENOMEM;
+	if (WARN_ON(IS_ERR(anatop_base))) {
+		ret = PTR_ERR(base);
+		goto unregister_hws;
+	}
 
 	clks[IMX93_CLK_AUDIO_PLL] = imx_clk_fracn_gppll("audio_pll", "osc_24m", anatop_base + 0x1200,
 							&imx_fracn_gppll);
@@ -299,8 +301,8 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 	np = dev->of_node;
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (WARN_ON(IS_ERR(base))) {
-		iounmap(anatop_base);
-		return PTR_ERR(base);
+		ret = PTR_ERR(base);
+		goto unregister_hws;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(root_array); i++) {
@@ -332,7 +334,6 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 
 unregister_hws:
 	imx_unregister_hw_clocks(clks, IMX93_CLK_END);
-	iounmap(anatop_base);
 
 	return ret;
 }
-- 
2.39.2



