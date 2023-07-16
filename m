Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EDB7552AF
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjGPUKn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjGPUKl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:10:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3F59B
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:10:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88BEF60EA6
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997BFC433C8;
        Sun, 16 Jul 2023 20:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538240;
        bh=x+npZbv8mH+79cB6bj0I7u9mYEceT9vRQ5CndDDH0Us=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TuNGoVb6VJdVO62KlTHU4PVKkBToYquKJLGJ3YL7TtcJ/PD9Z02zPDuOvGSDtcm7p
         6y82Y04qGUr5ifggtjldbwsu5QCnXPZ9grYrW5YpeimKbJ2+jC8VzBvx+HMkNZ+1t/
         etdzMW5NmV9BlEMVxX3WNDHP76dGwsVqYBmvaQ6M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kai Ma <kaima@hust.edu.cn>,
        Peng Fan <peng.fan@nxp.com>,
        Jesse Taube <Mr.Bossman075@gmail.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 379/800] clk: imx: clk-imxrt1050: fix memory leak in imxrt1050_clocks_probe
Date:   Sun, 16 Jul 2023 21:43:52 +0200
Message-ID: <20230716194957.877760837@linuxfoundation.org>
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

From: Kai Ma <kaima@hust.edu.cn>

[ Upstream commit 1b280598ab3bd8a2dc8b96a12530d5b1ee7a8f4a ]

Use devm_of_iomap() instead of of_iomap() to automatically
handle the unused ioremap region. If any error occurs, regions allocated by
kzalloc() will leak, but using devm_kzalloc() instead will automatically
free the memory using devm_kfree().

Also, fix error handling of hws by adding unregister_hws label, which
unregisters remaining hws when iomap failed.

Fixes: 7154b046d8f3 ("clk: imx: Add initial support for i.MXRT1050 clock driver")
Signed-off-by: Kai Ma <kaima@hust.edu.cn>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Acked-by: Jesse Taube <Mr.Bossman075@gmail.com>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Link: https://lore.kernel.org/r/20230418113451.151312-1-kaima@hust.edu.cn
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-imxrt1050.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-imxrt1050.c b/drivers/clk/imx/clk-imxrt1050.c
index fd5c51fc92c0e..08d155feb035a 100644
--- a/drivers/clk/imx/clk-imxrt1050.c
+++ b/drivers/clk/imx/clk-imxrt1050.c
@@ -42,7 +42,7 @@ static int imxrt1050_clocks_probe(struct platform_device *pdev)
 	struct device_node *anp;
 	int ret;
 
-	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
+	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws,
 					  IMXRT1050_CLK_END), GFP_KERNEL);
 	if (WARN_ON(!clk_hw_data))
 		return -ENOMEM;
@@ -53,10 +53,12 @@ static int imxrt1050_clocks_probe(struct platform_device *pdev)
 	hws[IMXRT1050_CLK_OSC] = imx_get_clk_hw_by_name(np, "osc");
 
 	anp = of_find_compatible_node(NULL, NULL, "fsl,imxrt-anatop");
-	pll_base = of_iomap(anp, 0);
+	pll_base = devm_of_iomap(dev, anp, 0, NULL);
 	of_node_put(anp);
-	if (WARN_ON(!pll_base))
-		return -ENOMEM;
+	if (WARN_ON(IS_ERR(pll_base))) {
+		ret = PTR_ERR(pll_base);
+		goto unregister_hws;
+	}
 
 	/* Anatop clocks */
 	hws[IMXRT1050_CLK_DUMMY] = imx_clk_hw_fixed("dummy", 0UL);
@@ -104,8 +106,10 @@ static int imxrt1050_clocks_probe(struct platform_device *pdev)
 
 	/* CCM clocks */
 	ccm_base = devm_platform_ioremap_resource(pdev, 0);
-	if (WARN_ON(IS_ERR(ccm_base)))
-		return PTR_ERR(ccm_base);
+	if (WARN_ON(IS_ERR(ccm_base))) {
+		ret = PTR_ERR(ccm_base);
+		goto unregister_hws;
+	}
 
 	hws[IMXRT1050_CLK_ARM_PODF] = imx_clk_hw_divider("arm_podf", "pll1_arm", ccm_base + 0x10, 0, 3);
 	hws[IMXRT1050_CLK_PRE_PERIPH_SEL] = imx_clk_hw_mux("pre_periph_sel", ccm_base + 0x18, 18, 2,
@@ -149,8 +153,12 @@ static int imxrt1050_clocks_probe(struct platform_device *pdev)
 	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register clks for i.MXRT1050.\n");
-		imx_unregister_hw_clocks(hws, IMXRT1050_CLK_END);
+		goto unregister_hws;
 	}
+	return 0;
+
+unregister_hws:
+	imx_unregister_hw_clocks(hws, IMXRT1050_CLK_END);
 	return ret;
 }
 static const struct of_device_id imxrt1050_clk_of_match[] = {
-- 
2.39.2



