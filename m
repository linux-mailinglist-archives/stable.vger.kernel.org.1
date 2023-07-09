Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C4574C37A
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjGILdH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjGILck (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:32:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A7495
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:32:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AB5560B7F
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB02C433C8;
        Sun,  9 Jul 2023 11:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902358;
        bh=nJB6YtktESUQfGuLoaTC2UwrfGeGo1r0x0uFdXuRyR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S0io+F24Ew1LHwOTG7a2NK9hAVUt4LLPJK/s4OfZGLwb6a7wyLMr0eDB/7TE3fXLb
         H8G4vFrMuELy/atK7/ACrqmp0KRKMEOEF51h6DlSYJyGiWex71VapOfj2ZAIYsktm6
         9t9eee12OJ38f/o4/JhgvwLipcg0n7X/BnZJh1Gs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 348/431] pinctrl: at91: Dont mix non-devm calls with devm ones
Date:   Sun,  9 Jul 2023 13:14:56 +0200
Message-ID: <20230709111459.324594517@linuxfoundation.org>
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

[ Upstream commit 415a099ea55ae716b69beefdcaa654b96087c016 ]

Replace devm_clk_get() by devm_clk_get_enabled() and drop
unneeded code pieces. This will make sure we keep the ordering
of the resource allocation correct.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Tested-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/20230215134242.37618-3-andriy.shevchenko@linux.intel.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Stable-dep-of: 35216718c9ac ("pinctrl: at91: fix a couple NULL vs IS_ERR() checks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-at91.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 9fa68ca4a412d..f0b139a1cc3ed 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1849,19 +1849,13 @@ static int at91_gpio_probe(struct platform_device *pdev)
 	at91_chip->pioc_virq = irq;
 	at91_chip->pioc_idx = alias_idx;
 
-	at91_chip->clock = devm_clk_get(&pdev->dev, NULL);
+	at91_chip->clock = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(at91_chip->clock)) {
 		dev_err(&pdev->dev, "failed to get clock, ignoring.\n");
 		ret = PTR_ERR(at91_chip->clock);
 		goto err;
 	}
 
-	ret = clk_prepare_enable(at91_chip->clock);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to prepare and enable clock, ignoring.\n");
-		goto clk_enable_err;
-	}
-
 	at91_chip->chip = at91_gpio_template;
 	at91_chip->id = alias_idx;
 
@@ -1882,7 +1876,7 @@ static int at91_gpio_probe(struct platform_device *pdev)
 	names = devm_kasprintf_strarray(dev, "pio", chip->ngpio);
 	if (!names) {
 		ret = -ENOMEM;
-		goto clk_enable_err;
+		goto err;
 	}
 
 	for (i = 0; i < chip->ngpio; i++)
@@ -1915,8 +1909,6 @@ static int at91_gpio_probe(struct platform_device *pdev)
 	return 0;
 
 gpiochip_add_err:
-clk_enable_err:
-	clk_disable_unprepare(at91_chip->clock);
 err:
 	dev_err(&pdev->dev, "Failure %i for GPIO %i\n", ret, alias_idx);
 
-- 
2.39.2



