Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAF67ECE1A
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbjKOTk0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbjKOTkY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:40:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EFF1A8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:40:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373C3C433C9;
        Wed, 15 Nov 2023 19:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077220;
        bh=0xAxlfNM1DrQIyO/PB63GKHoK+hacvsK3I29BudszeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dd4CJca+Siu2kM6csSuRKGuQm/t3CUbyufApcvGVbgZaYIZd7Msi+4YFjH2zGGHzi
         rAm90D/KPPVdgLDuNJm26o21iH1CMa7m2jT+IlX9xi7Wxy36PpaDkQkhPmxRwoUJ1Y
         kOrN/pf28PfBZV8YcLVJYPZrNBcswFE/bI9dFEcc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peng Fan <peng.fan@nxp.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Abel Vesa <abel.vesa@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 171/603] clk: imx: imx8: Fix an error handling path in imx8_acm_clk_probe()
Date:   Wed, 15 Nov 2023 14:11:56 -0500
Message-ID: <20231115191625.041636428@linuxfoundation.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit e9a164e367f039629fd5466a79b9f495646e1261 ]

If an error occurs after a successful clk_imx_acm_attach_pm_domains() call,
it must be undone.

Add an explicit error handling path, re-order the code and add the missing
clk_imx_acm_detach_pm_domains() call.

Fixes: d3a0946d7ac9 ("clk: imx: imx8: add audio clock mux driver")
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-imx8-acm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8-acm.c b/drivers/clk/imx/clk-imx8-acm.c
index 73b3b53549517..1c95ae905eec8 100644
--- a/drivers/clk/imx/clk-imx8-acm.c
+++ b/drivers/clk/imx/clk-imx8-acm.c
@@ -374,7 +374,6 @@ static int imx8_acm_clk_probe(struct platform_device *pdev)
 										0, NULL, NULL);
 		if (IS_ERR(hws[sels[i].clkid])) {
 			ret = PTR_ERR(hws[sels[i].clkid]);
-			pm_runtime_disable(&pdev->dev);
 			goto err_clk_register;
 		}
 	}
@@ -384,12 +383,16 @@ static int imx8_acm_clk_probe(struct platform_device *pdev)
 	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_hw_data);
 	if (ret < 0) {
 		dev_err(dev, "failed to register hws for ACM\n");
-		pm_runtime_disable(&pdev->dev);
+		goto err_clk_register;
 	}
 
-err_clk_register:
+	pm_runtime_put_sync(&pdev->dev);
+	return 0;
 
+err_clk_register:
 	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	clk_imx_acm_detach_pm_domains(&pdev->dev, &priv->dev_pm);
 
 	return ret;
 }
-- 
2.42.0



