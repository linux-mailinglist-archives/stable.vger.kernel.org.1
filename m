Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9077ECBB7
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjKOTYC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbjKOTYB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:24:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8820B12C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:23:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D36C433C7;
        Wed, 15 Nov 2023 19:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076237;
        bh=SEK6iqwz2q8d3ocMC0DQxqes7KgFHU/l5nqyIhNC2mw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A4bq/aADIx5t8em/YbwYeFPIBdQqofTaVjzOzj35blaIIIn+RdlQWXDhfFiHcaZoa
         Xyahx+7aVguUmquL5qFyXVdKoFmYYIG+RRamVEregltTbHpGKM0lPlNN7LJJ5Ev15+
         UOjvnNPu+5fQk1xBZ1aOd8cSAi6Oi6+y4CbtG6JA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Abel Vesa <abel.vesa@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 162/550] clk: imx: imx8qxp: Fix elcdif_pll clock
Date:   Wed, 15 Nov 2023 14:12:26 -0500
Message-ID: <20231115191611.926297231@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robert Chiras <robert.chiras@nxp.com>

[ Upstream commit 15cee75dacb82ade710d61bfd536011933ef9bf2 ]

Move the elcdif_pll clock initialization before the lcd_clk, since the
elcdif_clk needs to be initialized ahead of lcd_clk, being its parent.
This change fixes issues with the LCD clocks during suspend/resume.

Fixes: babfaa9556d7 ("clk: imx: scu: add more scu clocks")
Suggested-by: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
Acked-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Link: https://lore.kernel.org/r/20230912-imx8-clk-v1-v1-2-69a34bcfcae1@nxp.com
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-imx8qxp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index 546a3703bfeb2..273de1f293076 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -148,10 +148,10 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 	imx_clk_scu("adc0_clk",  IMX_SC_R_ADC_0, IMX_SC_PM_CLK_PER);
 	imx_clk_scu("adc1_clk",  IMX_SC_R_ADC_1, IMX_SC_PM_CLK_PER);
 	imx_clk_scu("pwm_clk",   IMX_SC_R_LCD_0_PWM_0, IMX_SC_PM_CLK_PER);
+	imx_clk_scu("elcdif_pll", IMX_SC_R_ELCDIF_PLL, IMX_SC_PM_CLK_PLL);
 	imx_clk_scu2("lcd_clk", lcd_sels, ARRAY_SIZE(lcd_sels), IMX_SC_R_LCD_0, IMX_SC_PM_CLK_PER);
 	imx_clk_scu2("lcd_pxl_clk", lcd_pxl_sels, ARRAY_SIZE(lcd_pxl_sels), IMX_SC_R_LCD_0, IMX_SC_PM_CLK_MISC0);
 	imx_clk_scu("lcd_pxl_bypass_div_clk", IMX_SC_R_LCD_0, IMX_SC_PM_CLK_BYPASS);
-	imx_clk_scu("elcdif_pll", IMX_SC_R_ELCDIF_PLL, IMX_SC_PM_CLK_PLL);
 
 	/* Audio SS */
 	imx_clk_scu("audio_pll0_clk", IMX_SC_R_AUDIO_PLL_0, IMX_SC_PM_CLK_PLL);
-- 
2.42.0



