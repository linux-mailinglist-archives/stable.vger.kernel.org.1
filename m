Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C4274C37B
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjGILdI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbjGILcn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:32:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7016E95
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:32:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DE8260B7F
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211D5C433C8;
        Sun,  9 Jul 2023 11:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902361;
        bh=8kCy9KQudzzjGwmru/cwlp2BmA4T/EgVCl1ng4BQcWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mg8lpBt88ikD2rnEAYPg/R8BvKfRlT2fbycqpS4v69gYF5TyS9/iE1DkNfQ0R5pnz
         b1ZFtbw7YQkBQTOX6WdoQDzEhrQro5y4QiehJgoXtCL2yZUWWJyQkKmLw52AiJ9ctp
         Wo6vI1Z3z/uV7zeO2lyO7cWq9cfJosAdZidB4u5c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 349/431] pinctrl: at91: Use dev_err_probe() instead of custom messaging
Date:   Sun,  9 Jul 2023 13:14:57 +0200
Message-ID: <20230709111459.349493446@linuxfoundation.org>
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

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 472bbb2cfd6384fe4c4b956af2170c1225fe2a92 ]

The custom message has no value except printing the error code,
the same does dev_err_probe(). Let's use the latter for the sake
of unification.

Note that some APIs already have messaging in them and some simply
do not require the current noise.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Tested-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/20230215134242.37618-5-andriy.shevchenko@linux.intel.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Stable-dep-of: 35216718c9ac ("pinctrl: at91: fix a couple NULL vs IS_ERR() checks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-at91.c | 64 +++++++++++-----------------------
 1 file changed, 21 insertions(+), 43 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index f0b139a1cc3ed..e3664aafccef9 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1294,10 +1294,11 @@ static const struct of_device_id at91_pinctrl_of_match[] = {
 static int at91_pinctrl_probe_dt(struct platform_device *pdev,
 				 struct at91_pinctrl *info)
 {
+	struct device *dev = &pdev->dev;
 	int ret = 0;
 	int i, j, ngpio_chips_enabled = 0;
 	uint32_t *tmp;
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np = dev->of_node;
 	struct device_node *child;
 
 	if (!np)
@@ -1361,9 +1362,8 @@ static int at91_pinctrl_probe_dt(struct platform_device *pdev,
 			continue;
 		ret = at91_pinctrl_parse_functions(child, info, i++);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to parse function\n");
 			of_node_put(child);
-			return ret;
+			return dev_err_probe(dev, ret, "failed to parse function\n");
 		}
 	}
 
@@ -1416,11 +1416,8 @@ static int at91_pinctrl_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, info);
 	info->pctl = devm_pinctrl_register(&pdev->dev, &at91_pinctrl_desc,
 					   info);
-
-	if (IS_ERR(info->pctl)) {
-		dev_err(&pdev->dev, "could not register AT91 pinctrl driver\n");
-		return PTR_ERR(info->pctl);
-	}
+	if (IS_ERR(info->pctl))
+		return dev_err_probe(dev, PTR_ERR(info->pctl), "could not register AT91 pinctrl driver\n");
 
 	/* We will handle a range of GPIO pins */
 	for (i = 0; i < gpio_banks; i++)
@@ -1821,28 +1818,20 @@ static int at91_gpio_probe(struct platform_device *pdev)
 	char **names;
 
 	BUG_ON(alias_idx >= ARRAY_SIZE(gpio_chips));
-	if (gpio_chips[alias_idx]) {
-		ret = -EBUSY;
-		goto err;
-	}
+	if (gpio_chips[alias_idx])
+		return dev_err_probe(dev, -EBUSY, "%d slot is occupied.\n", alias_idx);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto err;
-	}
+	if (irq < 0)
+		return irq;
 
 	at91_chip = devm_kzalloc(&pdev->dev, sizeof(*at91_chip), GFP_KERNEL);
-	if (!at91_chip) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	if (!at91_chip)
+		return -ENOMEM;
 
 	at91_chip->regbase = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(at91_chip->regbase)) {
-		ret = PTR_ERR(at91_chip->regbase);
-		goto err;
-	}
+	if (IS_ERR(at91_chip->regbase))
+		return PTR_ERR(at91_chip->regbase);
 
 	at91_chip->ops = (const struct at91_pinctrl_mux_ops *)
 		of_match_device(at91_gpio_of_match, &pdev->dev)->data;
@@ -1850,11 +1839,8 @@ static int at91_gpio_probe(struct platform_device *pdev)
 	at91_chip->pioc_idx = alias_idx;
 
 	at91_chip->clock = devm_clk_get_enabled(&pdev->dev, NULL);
-	if (IS_ERR(at91_chip->clock)) {
-		dev_err(&pdev->dev, "failed to get clock, ignoring.\n");
-		ret = PTR_ERR(at91_chip->clock);
-		goto err;
-	}
+	if (IS_ERR(at91_chip->clock))
+		return dev_err_probe(dev, PTR_ERR(at91_chip->clock), "failed to get clock, ignoring.\n");
 
 	at91_chip->chip = at91_gpio_template;
 	at91_chip->id = alias_idx;
@@ -1867,17 +1853,15 @@ static int at91_gpio_probe(struct platform_device *pdev)
 
 	if (!of_property_read_u32(np, "#gpio-lines", &ngpio)) {
 		if (ngpio >= MAX_NB_GPIO_PER_BANK)
-			pr_err("at91_gpio.%d, gpio-nb >= %d failback to %d\n",
-			       alias_idx, MAX_NB_GPIO_PER_BANK, MAX_NB_GPIO_PER_BANK);
+			dev_err(dev, "at91_gpio.%d, gpio-nb >= %d failback to %d\n",
+				alias_idx, MAX_NB_GPIO_PER_BANK, MAX_NB_GPIO_PER_BANK);
 		else
 			chip->ngpio = ngpio;
 	}
 
 	names = devm_kasprintf_strarray(dev, "pio", chip->ngpio);
-	if (!names) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	if (!names)
+		return -ENOMEM;
 
 	for (i = 0; i < chip->ngpio; i++)
 		strreplace(names[i], '-', alias_idx + 'A');
@@ -1894,11 +1878,11 @@ static int at91_gpio_probe(struct platform_device *pdev)
 
 	ret = at91_gpio_of_irq_setup(pdev, at91_chip);
 	if (ret)
-		goto gpiochip_add_err;
+		return ret;
 
 	ret = gpiochip_add_data(chip, at91_chip);
 	if (ret)
-		goto gpiochip_add_err;
+		return ret;
 
 	gpio_chips[alias_idx] = at91_chip;
 	platform_set_drvdata(pdev, at91_chip);
@@ -1907,12 +1891,6 @@ static int at91_gpio_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "at address %p\n", at91_chip->regbase);
 
 	return 0;
-
-gpiochip_add_err:
-err:
-	dev_err(&pdev->dev, "Failure %i for GPIO %i\n", ret, alias_idx);
-
-	return ret;
 }
 
 static const struct dev_pm_ops at91_gpio_pm_ops = {
-- 
2.39.2



