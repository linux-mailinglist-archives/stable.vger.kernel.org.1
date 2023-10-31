Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B387DD3EC
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbjJaRGR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbjJaRGF (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:06:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A45D1BFD
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:03:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9E4C433C8;
        Tue, 31 Oct 2023 17:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698771815;
        bh=7onUowU+/tH5/hFFIRrbcwXJ56Hz1/N6xgnXkBsodaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zQgefSjFwuPfB7KpDtRYNoYg+QwNrkV/viRT2dTB2Po7fBB/QTu0S7HWEoczbduEh
         kkeUf4MAi2Nip1N7EZ5NOaT38VRLkhBNgc5J0tvue9U/ohUWfEKLn0QkhXaW9Xa7Tk
         ovv3C0sBgw1p3yiOhqHxP/zAFm0MHrRCxEPM/7zI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 09/86] pinctrl: qcom: lpass-lpi: fix concurrent register updates
Date:   Tue, 31 Oct 2023 18:00:34 +0100
Message-ID: <20231031165918.907158629@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165918.608547597@linuxfoundation.org>
References: <20231031165918.608547597@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit c8befdc411e5fd1bf95a13e8744c8ca79b412bee ]

The Qualcomm LPASS LPI pin controller driver uses one lock for guarding
Read-Modify-Write code for slew rate registers.  However the pin
configuration and muxing registers have exactly the same RMW code but
are not protected.

Pin controller framework does not provide locking here, thus it is
possible to trigger simultaneous change of pin configuration registers
resulting in non-atomic changes.

Protect from concurrent access by re-using the same lock used to cover
the slew rate register.  Using the same lock instead of adding second
one will make more sense, once we add support for newer Qualcomm SoC,
where slew rate is configured in the same register as pin
configuration/muxing.

Fixes: 6e261d1090d6 ("pinctrl: qcom: Add sm8250 lpass lpi pinctrl driver")
Cc: stable@vger.kernel.org
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20231013145705.219954-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
index a55998ae29fa4..bfcc5c45b8fa5 100644
--- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
@@ -24,7 +24,8 @@ struct lpi_pinctrl {
 	char __iomem *tlmm_base;
 	char __iomem *slew_base;
 	struct clk_bulk_data clks[MAX_LPI_NUM_CLKS];
-	struct mutex slew_access_lock;
+	/* Protects from concurrent register updates */
+	struct mutex lock;
 	const struct lpi_pinctrl_variant_data *data;
 };
 
@@ -94,9 +95,11 @@ static int lpi_gpio_set_mux(struct pinctrl_dev *pctldev, unsigned int function,
 	if (WARN_ON(i == g->nfuncs))
 		return -EINVAL;
 
+	mutex_lock(&pctrl->lock);
 	val = lpi_gpio_read(pctrl, pin, LPI_GPIO_CFG_REG);
 	u32p_replace_bits(&val, i, LPI_GPIO_FUNCTION_MASK);
 	lpi_gpio_write(pctrl, pin, LPI_GPIO_CFG_REG, val);
+	mutex_unlock(&pctrl->lock);
 
 	return 0;
 }
@@ -202,14 +205,14 @@ static int lpi_config_set(struct pinctrl_dev *pctldev, unsigned int group,
 			if (slew_offset == LPI_NO_SLEW)
 				break;
 
-			mutex_lock(&pctrl->slew_access_lock);
+			mutex_lock(&pctrl->lock);
 
 			sval = ioread32(pctrl->slew_base + LPI_SLEW_RATE_CTL_REG);
 			sval &= ~(LPI_SLEW_RATE_MASK << slew_offset);
 			sval |= arg << slew_offset;
 			iowrite32(sval, pctrl->slew_base + LPI_SLEW_RATE_CTL_REG);
 
-			mutex_unlock(&pctrl->slew_access_lock);
+			mutex_unlock(&pctrl->lock);
 			break;
 		default:
 			return -EINVAL;
@@ -225,6 +228,7 @@ static int lpi_config_set(struct pinctrl_dev *pctldev, unsigned int group,
 		lpi_gpio_write(pctrl, group, LPI_GPIO_VALUE_REG, val);
 	}
 
+	mutex_lock(&pctrl->lock);
 	val = lpi_gpio_read(pctrl, group, LPI_GPIO_CFG_REG);
 
 	u32p_replace_bits(&val, pullup, LPI_GPIO_PULL_MASK);
@@ -233,6 +237,7 @@ static int lpi_config_set(struct pinctrl_dev *pctldev, unsigned int group,
 	u32p_replace_bits(&val, output_enabled, LPI_GPIO_OE_MASK);
 
 	lpi_gpio_write(pctrl, group, LPI_GPIO_CFG_REG, val);
+	mutex_unlock(&pctrl->lock);
 
 	return 0;
 }
@@ -432,7 +437,7 @@ int lpi_pinctrl_probe(struct platform_device *pdev)
 	pctrl->chip.of_gpio_n_cells = 2;
 	pctrl->chip.can_sleep = false;
 
-	mutex_init(&pctrl->slew_access_lock);
+	mutex_init(&pctrl->lock);
 
 	pctrl->ctrl = devm_pinctrl_register(dev, &pctrl->desc, pctrl);
 	if (IS_ERR(pctrl->ctrl)) {
@@ -454,7 +459,7 @@ int lpi_pinctrl_probe(struct platform_device *pdev)
 	return 0;
 
 err_pinctrl:
-	mutex_destroy(&pctrl->slew_access_lock);
+	mutex_destroy(&pctrl->lock);
 	clk_bulk_disable_unprepare(MAX_LPI_NUM_CLKS, pctrl->clks);
 
 	return ret;
@@ -466,7 +471,7 @@ int lpi_pinctrl_remove(struct platform_device *pdev)
 	struct lpi_pinctrl *pctrl = platform_get_drvdata(pdev);
 	int i;
 
-	mutex_destroy(&pctrl->slew_access_lock);
+	mutex_destroy(&pctrl->lock);
 	clk_bulk_disable_unprepare(MAX_LPI_NUM_CLKS, pctrl->clks);
 
 	for (i = 0; i < pctrl->data->npins; i++)
-- 
2.42.0



