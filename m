Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62427D1BE0
	for <lists+stable@lfdr.de>; Sat, 21 Oct 2023 11:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjJUJD4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 21 Oct 2023 05:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUJDz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 21 Oct 2023 05:03:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3FCD66
        for <stable@vger.kernel.org>; Sat, 21 Oct 2023 02:03:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A69C433C8;
        Sat, 21 Oct 2023 09:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697879033;
        bh=0jNusZ6dzZxnxJUg3+eyQWYRzpIwJuKnHCmpCWGZCEc=;
        h=Subject:To:Cc:From:Date:From;
        b=fz8ClIAV13gyZEJllBR1ZhUqWhERfiz24CudeJ1y35vrVkiTnL/b2YZReTmkEq9X4
         jSWhxBynrr912KUK15QOsjf6KFuy6VT1V5e+e3BnHKGZirNzZlkcGUPhlyriWE1+Is
         YA0lZ/IRmHx20NBiGM7XNCQZ1gfWDWSE13YPnbBE=
Subject: FAILED: patch "[PATCH] pinctrl: qcom: lpass-lpi: fix concurrent register updates" failed to apply to 5.15-stable tree
To:     krzysztof.kozlowski@linaro.org, linus.walleij@linaro.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 21 Oct 2023 11:03:42 +0200
Message-ID: <2023102142-tiny-thing-872a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c8befdc411e5fd1bf95a13e8744c8ca79b412bee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102142-tiny-thing-872a@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c8befdc411e5fd1bf95a13e8744c8ca79b412bee Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 13 Oct 2023 16:57:05 +0200
Subject: [PATCH] pinctrl: qcom: lpass-lpi: fix concurrent register updates

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

diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
index e5a418026ba3..0b2839d27fd6 100644
--- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
@@ -32,7 +32,8 @@ struct lpi_pinctrl {
 	char __iomem *tlmm_base;
 	char __iomem *slew_base;
 	struct clk_bulk_data clks[MAX_LPI_NUM_CLKS];
-	struct mutex slew_access_lock;
+	/* Protects from concurrent register updates */
+	struct mutex lock;
 	DECLARE_BITMAP(ever_gpio, MAX_NR_GPIO);
 	const struct lpi_pinctrl_variant_data *data;
 };
@@ -103,6 +104,7 @@ static int lpi_gpio_set_mux(struct pinctrl_dev *pctldev, unsigned int function,
 	if (WARN_ON(i == g->nfuncs))
 		return -EINVAL;
 
+	mutex_lock(&pctrl->lock);
 	val = lpi_gpio_read(pctrl, pin, LPI_GPIO_CFG_REG);
 
 	/*
@@ -128,6 +130,7 @@ static int lpi_gpio_set_mux(struct pinctrl_dev *pctldev, unsigned int function,
 
 	u32p_replace_bits(&val, i, LPI_GPIO_FUNCTION_MASK);
 	lpi_gpio_write(pctrl, pin, LPI_GPIO_CFG_REG, val);
+	mutex_unlock(&pctrl->lock);
 
 	return 0;
 }
@@ -233,14 +236,14 @@ static int lpi_config_set(struct pinctrl_dev *pctldev, unsigned int group,
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
@@ -256,6 +259,7 @@ static int lpi_config_set(struct pinctrl_dev *pctldev, unsigned int group,
 		lpi_gpio_write(pctrl, group, LPI_GPIO_VALUE_REG, val);
 	}
 
+	mutex_lock(&pctrl->lock);
 	val = lpi_gpio_read(pctrl, group, LPI_GPIO_CFG_REG);
 
 	u32p_replace_bits(&val, pullup, LPI_GPIO_PULL_MASK);
@@ -264,6 +268,7 @@ static int lpi_config_set(struct pinctrl_dev *pctldev, unsigned int group,
 	u32p_replace_bits(&val, output_enabled, LPI_GPIO_OE_MASK);
 
 	lpi_gpio_write(pctrl, group, LPI_GPIO_CFG_REG, val);
+	mutex_unlock(&pctrl->lock);
 
 	return 0;
 }
@@ -461,7 +466,7 @@ int lpi_pinctrl_probe(struct platform_device *pdev)
 	pctrl->chip.label = dev_name(dev);
 	pctrl->chip.can_sleep = false;
 
-	mutex_init(&pctrl->slew_access_lock);
+	mutex_init(&pctrl->lock);
 
 	pctrl->ctrl = devm_pinctrl_register(dev, &pctrl->desc, pctrl);
 	if (IS_ERR(pctrl->ctrl)) {
@@ -483,7 +488,7 @@ int lpi_pinctrl_probe(struct platform_device *pdev)
 	return 0;
 
 err_pinctrl:
-	mutex_destroy(&pctrl->slew_access_lock);
+	mutex_destroy(&pctrl->lock);
 	clk_bulk_disable_unprepare(MAX_LPI_NUM_CLKS, pctrl->clks);
 
 	return ret;
@@ -495,7 +500,7 @@ int lpi_pinctrl_remove(struct platform_device *pdev)
 	struct lpi_pinctrl *pctrl = platform_get_drvdata(pdev);
 	int i;
 
-	mutex_destroy(&pctrl->slew_access_lock);
+	mutex_destroy(&pctrl->lock);
 	clk_bulk_disable_unprepare(MAX_LPI_NUM_CLKS, pctrl->clks);
 
 	for (i = 0; i < pctrl->data->npins; i++)

