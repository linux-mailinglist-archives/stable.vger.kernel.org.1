Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B276B75D45E
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjGUTUZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjGUTUY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:20:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01862733
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:20:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1289F61B24
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D7EC433C9;
        Fri, 21 Jul 2023 19:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967221;
        bh=Mvnek+0FLfL3cFQ/FgFjQoGSPyXpzhR70K/Umjwcl4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LFrRBMLYvqtzWJTao23mezz1eka3pGSHk6WnlOR44giAURkNaE/v+I5drW6CaWIo4
         WipZDzGw2GfxNNXG0KMmPm9opiY54NcmVJJFa7ejxpIJhs+Mj5SdQO7RU5lZ59ev2e
         h0bI1P3wrAZIFkrwBo5ugC+o+7f8tZFlxJcnmG8o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jan Visser <starquake@linuxeverywhere.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 6.1 087/223] pinctrl: amd: Unify debounce handling into amd_pinconf_set()
Date:   Fri, 21 Jul 2023 18:05:40 +0200
Message-ID: <20230721160524.571428379@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

commit 283c5ce7da0a676f46539094d40067ad17c4f294 upstream.

Debounce handling is done in two different entry points in the driver.
Unify this to make sure that it's always handled the same.

Tested-by: Jan Visser <starquake@linuxeverywhere.org>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20230705133005.577-5-mario.limonciello@amd.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/pinctrl-amd.c |   21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -115,16 +115,12 @@ static void amd_gpio_set_value(struct gp
 	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
 }
 
-static int amd_gpio_set_debounce(struct gpio_chip *gc, unsigned offset,
-		unsigned debounce)
+static int amd_gpio_set_debounce(struct amd_gpio *gpio_dev, unsigned int offset,
+				 unsigned int debounce)
 {
 	u32 time;
 	u32 pin_reg;
 	int ret = 0;
-	unsigned long flags;
-	struct amd_gpio *gpio_dev = gpiochip_get_data(gc);
-
-	raw_spin_lock_irqsave(&gpio_dev->lock, flags);
 
 	/* Use special handling for Pin0 debounce */
 	if (offset == 0) {
@@ -183,7 +179,6 @@ static int amd_gpio_set_debounce(struct
 		pin_reg &= ~(DB_CNTRl_MASK << DB_CNTRL_OFF);
 	}
 	writel(pin_reg, gpio_dev->base + offset * 4);
-	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
 
 	return ret;
 }
@@ -782,9 +777,8 @@ static int amd_pinconf_set(struct pinctr
 
 		switch (param) {
 		case PIN_CONFIG_INPUT_DEBOUNCE:
-			pin_reg &= ~DB_TMR_OUT_MASK;
-			pin_reg |= arg & DB_TMR_OUT_MASK;
-			break;
+			ret = amd_gpio_set_debounce(gpio_dev, pin, arg);
+			goto out_unlock;
 
 		case PIN_CONFIG_BIAS_PULL_DOWN:
 			pin_reg &= ~BIT(PULL_DOWN_ENABLE_OFF);
@@ -811,6 +805,7 @@ static int amd_pinconf_set(struct pinctr
 
 		writel(pin_reg, gpio_dev->base + pin*4);
 	}
+out_unlock:
 	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
 
 	return ret;
@@ -857,12 +852,6 @@ static int amd_gpio_set_config(struct gp
 {
 	struct amd_gpio *gpio_dev = gpiochip_get_data(gc);
 
-	if (pinconf_to_config_param(config) == PIN_CONFIG_INPUT_DEBOUNCE) {
-		u32 debounce = pinconf_to_config_argument(config);
-
-		return amd_gpio_set_debounce(gc, pin, debounce);
-	}
-
 	return amd_pinconf_set(gpio_dev->pctrl, pin, &config, 1);
 }
 


