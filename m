Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B747ECE1B
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbjKOTk3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbjKOTk2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:40:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538EA19F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:40:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440D0C433C7;
        Wed, 15 Nov 2023 19:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077222;
        bh=IW1V4PK8zJXnTL455FH3ghyeV1a2UTzO4t2wPWtQ3Fs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GzltkdGTsaTr4wTubNE+g0AyKlxZ+e/B5dZlBeEB0w6C6QYZFtW8bG3OXW9eHGsOo
         0iOYFfstL+K3ZBD/ms7JqT6t0fb8MblgebVJJaIspxZUy2MRlwRj6+3jsEfMSVvy/z
         XviQ+ExjmSSnIICyAKBdO0w/pAE3ECJgDiJ0wUaI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>, Peng Fan <peng.fan@nxp.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 172/603] clk: imx: imx8mq: correct error handling path
Date:   Wed, 15 Nov 2023 14:11:57 -0500
Message-ID: <20231115191625.115805760@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit 577ad169966e6e75b10e004389a3f79813e84b5d ]

Avoid memory leak in error handling path. It does not make
much sense for the SoC without clk driver, to make program behavior
correct, let's fix it.

Fixes: b80522040cd3 ("clk: imx: Add clock driver for i.MX8MQ CCM")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202309240551.e46NllPa-lkp@intel.com/
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Link: https://lore.kernel.org/r/20231001122618.194498-1-peng.fan@oss.nxp.com
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-imx8mq.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 4bd65879fcd34..f70ed231b92d6 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -288,8 +288,7 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 	void __iomem *base;
 	int err;
 
-	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
-					  IMX8MQ_CLK_END), GFP_KERNEL);
+	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, IMX8MQ_CLK_END), GFP_KERNEL);
 	if (WARN_ON(!clk_hw_data))
 		return -ENOMEM;
 
@@ -306,10 +305,12 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MQ_CLK_EXT4] = imx_get_clk_hw_by_name(np, "clk_ext4");
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mq-anatop");
-	base = of_iomap(np, 0);
+	base = devm_of_iomap(dev, np, 0, NULL);
 	of_node_put(np);
-	if (WARN_ON(!base))
-		return -ENOMEM;
+	if (WARN_ON(IS_ERR(base))) {
+		err = PTR_ERR(base);
+		goto unregister_hws;
+	}
 
 	hws[IMX8MQ_ARM_PLL_REF_SEL] = imx_clk_hw_mux("arm_pll_ref_sel", base + 0x28, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	hws[IMX8MQ_GPU_PLL_REF_SEL] = imx_clk_hw_mux("gpu_pll_ref_sel", base + 0x18, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
@@ -395,8 +396,10 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 
 	np = dev->of_node;
 	base = devm_platform_ioremap_resource(pdev, 0);
-	if (WARN_ON(IS_ERR(base)))
-		return PTR_ERR(base);
+	if (WARN_ON(IS_ERR(base))) {
+		err = PTR_ERR(base);
+		goto unregister_hws;
+	}
 
 	/* CORE */
 	hws[IMX8MQ_CLK_A53_DIV] = imx8m_clk_hw_composite_core("arm_a53_div", imx8mq_a53_sels, base + 0x8000);
-- 
2.42.0



